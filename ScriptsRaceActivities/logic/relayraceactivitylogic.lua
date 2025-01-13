module("cardSystem.logic")
missionSetupData["Relay race activity"] = {}
local spawnOrder = {
  ["Team 1 Racer 1"] = "Team 1 Racer 2",
  ["Team 1 Racer 2"] = "Team 1 Racer 3",
  ["Team 2 Racer 1"] = "Team 2 Racer 2",
  ["Team 2 Racer 2"] = "Team 2 Racer 3",
  ["Team 3 Racer 1"] = "Team 3 Racer 2",
  ["Team 3 Racer 2"] = "Team 3 Racer 3"
}
local opponentsFinished = 0
local racerTask = function(goalParams, HUD, audio, agent, actorID)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Linear Checkpoints",
        dynamicTargets = true,
        specialName = "racerTask",
        coreData = {totalLaps = 0},
        goalConditions = {
          {
            {
              goal = "Reached next checkpoint"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {coreValue = "totalLaps"}
            }
          },
          {
            {
              goal = "All opposing vehicles damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Checkpoint Gate"] = {showAsLaps = true}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Relay race activity hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Is player controlled",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Is not player controlled",
        taskConditions = {
          {
            {
              goal = "Is player controlled",
              params = {inverse = true}
            }
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Relay race activity"].taskCreatorFunctionLookups = {
  ["Race team 1"] = racerTask,
  ["Race team 2"] = racerTask,
  ["Race team 3"] = racerTask,
  ["Race team 4"] = racerTask
}
missionSetupData["Relay race activity"].initiate = function(instance)
  RaceManager.AddRacer(instance.raceId, instance.taskObjectsByActorID["Team 1 Racer 1"].coreData.agent.gameVehicle)
  createCheckpoints(instance)
  local playerTaskObject = localPlayer:getTaskObject()
  setUpRouteManager(playerTaskObject)
  localPlayer:blockAbility("zap", true)
  opponentsFinished = 0
end
missionSetupData["Relay race activity"].update = nil
local RaceTeamDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if dynamicListID then
    if task.networkVars.checkpoints < #allCheckpoints then
      return {
        allCheckpoints[task.networkVars.checkpoints + 1]
      }, false
    else
      return false, true
    end
  else
    return {
      allCheckpoints[task.networkVars.checkpoints]
    }, false
  end
end
missionSetupData["Relay race activity"].targetList = {
  ["Race team 1"] = RaceTeamDynamicTargets,
  ["Race team 2"] = RaceTeamDynamicTargets,
  ["Race team 3"] = RaceTeamDynamicTargets,
  ["Race team 4"] = RaceTeamDynamicTargets
}
taskCompleteData["Relay race activity"] = {}
taskCompleteData["Relay race activity"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.agent,
    cameraShots = cameraShots[2],
    failReason = "ID:182607",
    successReason = "ID:183987",
    hint = "ID:235494"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.success then
    if task.specialName == "racerTask" then
      if task.condition == 1 then
        if spawnOrder[task.actor.ID] then
          challengeSystem.spawnActors(task.instance, "Never", {
            [spawnOrder[task.actor.ID]] = true
          })
          RaceManager.SwapRacer(task.instance.raceId, task.agent.gameVehicle, task.instance.taskObjectsByActorID[spawnOrder[task.actor.ID]].coreData.agent.gameVehicle)
          if task.actor.team == "Race team 1" then
            local agent = task.instance.taskObjectsByActorID[spawnOrder[task.actor.ID]].coreData.agent
            localPlayer.missionSupport:setMainTaskObject(task.instance.taskObjectsByActorID[spawnOrder[task.actor.ID]])
            localPlayer:zapToAgent(agent)
            RouteArrowsManager.AddArrows(localPlayer.localID, task.instance.raceId, routes[task.actor.routeName].roads, routes[task.actor.routeName].arrows)
            RouteArrowsManager.SetTarget(localPlayer.localID, task.instance.raceId, agent.gameVehicle)
          else
            OneShotSound.Play("Jericho_Shift_OneShot")
            ZapAIPresence.StartTransition(task.agent.gameVehicle, task.instance.taskObjectsByActorID[spawnOrder[task.actor.ID]].coreData.agent.gameVehicle)
          end
        elseif task.actor.team == "Race team 1" then
          params.rating = "PASS"
          params.driverIsTanner = true
          params.callback = completeTask
          if opponentsFinished == 1 then
            params.successReason = "ID:184691"
          end
          localPlayer.challenge.endScreen(taskObject, params)
        else
          opponentsFinished = opponentsFinished + 1
          if opponentsFinished == 2 then
            params.rating = "FAIL"
            params.callback = failTask
            localPlayer.challenge.endScreen(taskObject, params)
          end
        end
      elseif task.condition == 2 and task.actor.team == "Race team 1" then
        params.rating = "PASS"
        params.driverIsTanner = true
        params.callback = completeTask
        params.successReason = "ID:232271"
        localPlayer.challenge.endScreen(taskObject, params)
      end
    elseif task.specialName == "Is player controlled" then
      RouteArrowsManager.HideArrows(localPlayer.localID, false)
      feedbackSystem.menusMaster.primaryTextPromptParam({
        prompt = "ID:184685",
        delay = true,
        priority = 1
      })
      if task.actor.ID == "Team 1 Racer 1" then
        feedbackSystem.menusMaster.secondaryTextPromptParam({
          prompt = "ID:184013",
          delay = true,
          priority = 1
        })
      end
    end
  elseif task.actor.team == "Race team 1" then
    params.failReason = "ID:184950"
    params.rating = "FAIL"
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
  else
    feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:183974", priority = 1})
  end
end
missionEndCallback["Relay race activity"] = function(instance)
  localPlayer:blockAbility("zap", false)
end
