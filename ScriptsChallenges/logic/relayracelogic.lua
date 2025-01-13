module("cardSystem.logic")
missionSetupData["Relay race"] = {}
local startTime = false
local splitTime = false
local tutorialStarted = false
local spawnOrder = {
  ["Team 1 Racer 1"] = "Team 1 Racer 2",
  ["Team 1 Racer 2"] = "Team 1 Racer 3",
  ["Team 2 Racer 1"] = "Team 2 Racer 2",
  ["Team 2 Racer 2"] = "Team 2 Racer 3",
  ["Team 3 Racer 1"] = "Team 3 Racer 2",
  ["Team 3 Racer 2"] = "Team 3 Racer 3",
  ["Team 4 Racer 1"] = "Team 4 Racer 2",
  ["Team 4 Racer 2"] = "Team 4 Racer 3"
}
local raceWatch = {
  ["Team 1 Racer 2"] = "Team 1 Racer 1",
  ["Team 1 Racer 3"] = "Team 1 Racer 2",
  ["Team 2 Racer 2"] = "Team 2 Racer 1",
  ["Team 2 Racer 3"] = "Team 2 Racer 2",
  ["Team 3 Racer 2"] = "Team 3 Racer 1",
  ["Team 3 Racer 3"] = "Team 3 Racer 2",
  ["Team 4 Racer 2"] = "Team 4 Racer 1",
  ["Team 4 Racer 3"] = "Team 4 Racer 2"
}
local racerStartTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
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
            style = "Relay race hud"
          }
        }
      }
    },
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
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            {
              goal = "All opposing vehicles damage above",
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
            style = "Relay race hud"
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
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            {
              goal = "All opposing vehicles damage above",
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
            style = "Relay race hud"
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
missionSetupData["Relay race"].taskCreatorFunctionLookups = {
  ["Team 1 Racer 1"] = racerStartTask,
  ["Team 2 Racer 1"] = racerStartTask,
  ["Team 3 Racer 1"] = racerStartTask,
  ["Team 4 Racer 1"] = racerStartTask,
  ["Race team 1"] = racerTask,
  ["Race team 2"] = racerTask,
  ["Race team 3"] = racerTask,
  ["Race team 4"] = racerTask
}
missionSetupData["Relay race"].initiate = function(instance)
  createCheckpoints(instance)
  local playerTaskObject = localPlayer:getTaskObject()
  setUpRouteManager(playerTaskObject)
  localPlayer:enterCutsceneMode()
  localPlayer:blockAbility("zap", true)
end
missionSetupData["Relay race"].update = nil
local function PlayerRaceTeamDynamicTargets(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if not task.instance.splitTimes and taskObject.coreData.agent.controlled then
    task.instance.splitTimes = {}
    startTime = g_NetworkTime
  end
  if dynamicListID then
    if taskObject.coreData.agent.controlled then
      splitTime = g_NetworkTime - startTime
      splitTime = feedbackSystem.RandomiseMilliseconds(splitTime)
      table.insert(task.instance.splitTimes, splitTime)
    end
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
missionSetupData["Relay race"].targetList = {
  ["Race team 1"] = PlayerRaceTeamDynamicTargets,
  ["Race team 2"] = RaceTeamDynamicTargets,
  ["Race team 3"] = RaceTeamDynamicTargets,
  ["Race team 4"] = RaceTeamDynamicTargets
}
taskCompleteData["Relay race"] = {}
taskCompleteData["Relay race"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.agent,
    cameraShots = cameraShots[2],
    failReason = "ID:182607",
    successReason = "ID:183987",
    hint = "ID:246664"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  local function endChallenge()
    if feedbackSystem.getTimer() < math.floor(singlePlayerStatistics.getScoreStatistic()) / 100 then
      params.rating = "PASS"
      params.driverIsTanner = true
      params.callback = completeTask
      singlePlayerStatistics.updateScoreStatistic(feedbackSystem.getTimer(), "Time")
      if task.instance.splitTimes then
        singlePlayerStatistics.updateSplitStatistics(task.instance.splitTimes)
      end
    else
      params.failReason = "ID:231222"
      params.rating = "FAIL"
      params.callback = failTask
    end
    localPlayer.challenge.endScreen(taskObject, params)
  end
  if taskObject.coreData.actor.team == "Race team 1" then
    if task.success then
      if task.specialName == "Start Challenge tutorial" then
        if not tutorialStarted then
          tutorialStarted = true
          ProfileSettings.SetToolTipShown(toolTipLookupTable.Challenge)
          CutsceneFiles.tutorials.playTutorial("ID:245644")
        end
      elseif task.specialName == "Start Movie Challenge tutorial" then
        if not tutorialStarted then
          tutorialStarted = true
          ProfileSettings.SetToolTipShown(toolTipLookupTable["Movie Challenge"])
          CutsceneFiles.tutorials.playTutorial("ID:245648")
        end
      elseif task.specialName == "racerTask" then
        if task.condition == 1 then
          if spawnOrder[taskObject.coreData.actor.ID] then
            challengeSystem.spawnActors(task.instance, "Never", {
              [spawnOrder[taskObject.coreData.actor.ID]] = true
            })
            RaceManager.SwapRacer(taskObject.coreData.instance.raceId, taskObject.coreData.agent.gameVehicle, task.instance.taskObjectsByActorID[spawnOrder[taskObject.coreData.actor.ID]].coreData.agent.gameVehicle)
            local agent = task.instance.taskObjectsByActorID[spawnOrder[taskObject.coreData.actor.ID]].coreData.agent
            localPlayer.missionSupport:setMainTaskObject(task.instance.taskObjectsByActorID[spawnOrder[taskObject.coreData.actor.ID]])
            localPlayer:zapToAgent(agent)
            RouteArrowsManager.AddArrows(localPlayer.localID, taskObject.coreData.instance.raceId, routes[taskObject.coreData.actor.routeName].roads, routes[taskObject.coreData.actor.routeName].arrows)
            RouteArrowsManager.SetTarget(localPlayer.localID, taskObject.coreData.instance.raceId, agent.gameVehicle)
          else
            endChallenge()
          end
        elseif task.condition == 3 then
          endChallenge()
        end
      elseif task.specialName == "Is player controlled" then
        feedbackSystem.menusMaster.primaryTextPromptParam({
          prompt = "ID:184685",
          delay = true,
          priority = 1
        })
        if task.actor.ID == "Team 1 Racer 1" then
          feedbackSystem.menusMaster.secondaryTextPromptParam({
            prompt = "ID:184679",
            delay = true,
            priority = 1
          })
        end
      elseif task.specialName == "Wait for countdown" then
        localPlayer:exitCutsceneMode()
      end
    elseif task.condition == 2 then
      params.failReason = "ID:184688"
      params.rating = "FAIL"
      params.callback = failTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.success then
    if task.specialName == "racerTask" and task.condition == 1 then
      if spawnOrder[taskObject.coreData.actor.ID] then
        challengeSystem.spawnActors(task.instance, "Never", {
          [spawnOrder[taskObject.coreData.actor.ID]] = true
        })
        RaceManager.SwapRacer(taskObject.coreData.instance.raceId, taskObject.coreData.agent.gameVehicle, task.instance.taskObjectsByActorID[spawnOrder[taskObject.coreData.actor.ID]].coreData.agent.gameVehicle)
        OneShotSound.Play("Jericho_Shift_OneShot")
        ZapAIPresence.StartTransition(taskObject.coreData.agent.gameVehicle, task.instance.taskObjectsByActorID[spawnOrder[taskObject.coreData.actor.ID]].coreData.agent.gameVehicle)
      else
        params.failReason = "ID:184692"
        params.rating = "FAIL"
        params.callback = failTask
        localPlayer.challenge.endScreen(taskObject, params)
      end
    end
  elseif task.condition == 2 then
    feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:183974", priority = 2})
  end
end
missionEndCallback["Relay race"] = function(instance)
  localPlayer:blockAbility("zap", false)
end
