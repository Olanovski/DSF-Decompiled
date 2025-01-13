module("cardSystem.logic")
missionSetupData.DriveToSurvive2 = {}
local previousTime
local timeTrigger = 20
local heartRateLocked, playerTaskObject
local tutorialStarted = false
local playerTask = function(goalParams, HUD, audio)
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
            style = "DriveToSurvive2 hud"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        coreData = {totalLaps = 0},
        specialName = "Survive",
        groupProgression = {priorityMinorOrder = true},
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {goal = "Got busted"}
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "DriveToSurvive2 hud"
          }
        }
      },
      {
        task = "Payload Tracking With Multiplyer",
        coreData = {upper = 167, lower = 30},
        specialName = "payload task",
        startingValues = {payload = 120},
        groupProgression = {importantMinorOrder = true},
        goalConditions = {
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "Is jumping",
              params = {inverse = true}
            },
            {
              goal = "Is drifting",
              params = {inverse = true}
            },
            {
              goal = "Below speed",
              params = {value = 80}
            },
            {
              goal = "Time trigger",
              params = {value = 0.15}
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "Is jumping",
              params = {inverse = true}
            },
            {
              goal = "Is drifting",
              params = {inverse = true}
            },
            {
              goal = "Below speed",
              params = {value = 50}
            },
            {
              goal = "Time trigger",
              params = {value = 0.3}
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "Is jumping",
              params = {inverse = true}
            },
            {
              goal = "Is drifting",
              params = {inverse = true}
            },
            {
              goal = "Below speed",
              params = {value = 30}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          },
          {
            autoRefresh = true,
            failCondition = true,
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        taskConditions = {
          {
            autoRefresh = true,
            failCondition = true,
            {
              goal = "Payload under",
              params = {value = 30}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "DriveToSurvive2 hud",
            settings = {}
          }
        }
      }
    }
  }
  cardSystem.createHeartometerParameters(task[2][2])
  return task
end
missionSetupData.DriveToSurvive2.taskCreatorFunctionLookups = {
  ["Player team"] = playerTask
}
function missionSetupData.DriveToSurvive2.initiate(instance)
  localPlayer:blockAbility("zap", true)
  previousTime = false
  playerTaskObject = false
  heartRateLocked = false
  instance.previousTrailers = {}
  Sound.EnableScoring("jump", true)
  Sound.EnableScoring("drift", true)
  localPlayer:enterCutsceneMode()
end
function missionSetupData.DriveToSurvive2.update(instance)
  if instance.taskObjectsByActorID.player.namedTasks["payload task"] then
    if not playerTaskObject then
      playerTaskObject = instance.taskObjectsByActorID.player.namedTasks["payload task"]
      playerTaskObject.networkVars.upMultiplyer = 1.5
      playerTaskObject.networkVars.downMultiplyer = 0.5
    end
    if previousTime and playerTaskObject and not heartRateLocked and g_NetworkTime - previousTime >= timeTrigger then
      if playerTaskObject.coreData.upper > 47 then
        playerTaskObject.coreData.upper = playerTaskObject.coreData.upper - 10
      else
        heartRateLocked = true
      end
      if playerTaskObject.networkVars.upMultiplyer >= 0.1 then
        playerTaskObject.networkVars.upMultiplyer = playerTaskObject.networkVars.upMultiplyer * 0.9
        playerTaskObject.networkVars.downMultiplyer = playerTaskObject.networkVars.downMultiplyer * 1.1
      end
      previousTime = g_NetworkTime
    end
  end
end
local playerDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  else
    local teams = {}
    for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
      teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
      table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
    end
    if task.majorOrder == 1 then
      return checkpointSystem.getCheckpoints(task.instance, 200), false
    end
  end
end
missionSetupData.DriveToSurvive2.targetList = {
  ["Player team"] = playerDynamicTargets
}
taskCompleteData.DriveToSurvive2 = {}
function taskCompleteData.DriveToSurvive2.taskComplete(taskObject, task)
  local params = {
    vehicle = task.agent,
    cameraShots = cameraShots[2],
    successReason = "ID:245583",
    failReason = "ID:231222",
    hint = "ID:235493",
    driverIsTanner = true
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix, perfect)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
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
  elseif task.specialName == "Wait for countdown" then
    previousTime = g_NetworkTime
    localPlayer:exitCutsceneMode()
    feedbackSystem.menusMaster.primaryTextPromptParam({
      prompt = "ID:233881",
      delay = true,
      priority = 1
    })
  elseif task.specialName == "payload task" or task.specialName == "Survive" then
    if feedbackSystem.getTimer() > math.floor(singlePlayerStatistics.getScoreStatistic()) / 100 then
      params.rating = "PASS"
      params.callback = completeTask
      singlePlayerStatistics.updateScoreStatistic(feedbackSystem.getTimer(), "Time")
    else
      params.rating = "FAIL"
      params.callback = failTask
    end
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
function missionEndCallback.DriveToSurvive2(instance)
  localPlayer:blockAbility("zap", false)
  Sound.EnableScoring("jump", false)
  Sound.EnableScoring("drift", false)
  if instance.previousTrailers then
    for index, gameVehicle in next, instance.previousTrailers, nil do
      GameVehicleResource.UnRegisterDeletionCallback(gameVehicle, recycleTrailerGameVehicle)
    end
  end
end
