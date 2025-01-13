module("cardSystem.logic")
missionSetupData["Generic checkpoint activity"] = {}
local racerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait for countdown",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3},
              feedback = "Time"
            }
          }
        },
        HUD = {
          {
            style = "Checkpoint activity hud"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        dynamicTargets = true,
        specialName = "Checkpoints",
        coreData = {
          totalLaps = goalParams["Total laps"] or 0
        },
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
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            {
              goal = "Instance dynamic time above"
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Checkpoint Gate"] = {}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Checkpoint activity hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Reduce willpower",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Checkpoint activity hud"
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Generic checkpoint activity"].taskCreatorFunctionLookups = {
  ["Player Team"] = racerTask
}
missionSetupData["Generic checkpoint activity"].initiate = function(instance)
  instance.timeLimit = instance.challenge.goalValues["Maximum willpower"] / instance.challenge.goalValues["Substracted willpower per second"]
  createCheckpoints(instance)
  if instance.challenge.props then
    propSystem.setupRuntimeProps(instance.challenge.props, false, false)
  end
  localPlayer:enterCutsceneMode()
end
missionSetupData["Generic checkpoint activity"].update = nil
local RaceTeamDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Checkpoints" then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if #allCheckpoints == 2 then
      RaceManager.EnableOffRoute(task.instance.raceId, false)
    end
    if dynamicListID then
      if task.networkVars.checkpoints < #allCheckpoints then
        return {
          allCheckpoints[task.networkVars.checkpoints + 1]
        }, false
      elseif task.instance.challenge.goalValues["Total laps"] then
        if task.networkVars.laps == task.instance.challenge.goalValues["Total laps"] then
          RouteArrowsManager.HideArrows(localPlayer.localID, true)
          return false, true
        else
          return {
            allCheckpoints[1]
          }, true
        end
      else
        RouteArrowsManager.HideArrows(localPlayer.localID, true)
        return false, true
      end
    else
      return {
        allCheckpoints[task.networkVars.checkpoints]
      }, false
    end
  end
end
missionSetupData["Generic checkpoint activity"].targetList = {
  ["Player Team"] = RaceTeamDynamicTargets
}
missionEndCallback["Generic checkpoint activity"] = function(instance)
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.agent.raceId then
      RouteArrowsManager.ClearArrows()
      RaceManager.RemoveRace(taskObject.coreData.agent.raceId)
      taskObject.coreData.agent.raceId = nil
      taskObject.coreData.instance.raceId = nil
      break
    end
  end
end
taskCompleteData["Generic checkpoint activity"] = {}
taskCompleteData["Generic checkpoint activity"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.agent,
    successReason = "ID:245559",
    failReason = "ID:243979",
    hint = "ID:245264"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.specialName == "Start activity tutorial" then
    ProfileSettings.SetToolTipShown(toolTipLookupTable.Activity)
    CutsceneFiles.tutorials.playTutorial("ID:245640")
  elseif task.specialName == "Wait for tutorial" then
  elseif task.specialName == "Wait for countdown" then
    localPlayer:exitCutsceneMode()
  elseif task.specialName == "Checkpoints" then
    if task.success then
      RaceManager.RacerCrossedFinishLine(task.agent.raceId, task.agent.gameVehicle)
      params.rating = "PASS"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    else
      if task.condition == 2 then
        params.failReason = "ID:182731"
      end
      params.callback = failTask
      params.rating = "FAIL"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  end
end
