module("cardSystem.logic")
missionSetupData["Deactivating bombs 2"] = {}
local arrowMarkers = {
  {
    facing = false,
    gadgetID = 78,
    scale = vec.vector(0.3, 0.3, 0.3, 0),
    matrixOffset = vec.matrix(-4.371139E-08, 0, 1, 0, 0, 1, 0, 0, -1, 0, -4.371139E-08, 0, -1.4, -0.69, -4.5, 1),
    visible = true,
    colour = vec.vector(246, 196, 14, 255)
  },
  {
    facing = false,
    gadgetID = 78,
    scale = vec.vector(0.3, 0.3, 0.3, 0),
    matrixOffset = vec.matrix(4.371139E-08, 0, -1, 0, 0, 1, 0, 0, 1, 0, 4.371139E-08, 0, -1.65, -0.69, 4.5, 1),
    visible = true,
    colour = vec.vector(246, 196, 14, 255)
  },
  {
    facing = false,
    gadgetID = 78,
    scale = vec.vector(0.3, 0.3, 0.3, 0),
    matrixOffset = vec.matrix(-4.371139E-08, 0, 1, 0, 0, 1, 0, 0, -1, 0, -4.371139E-08, 0, 1.65, -0.69, -4.5, 1),
    visible = true,
    colour = vec.vector(246, 196, 14, 255)
  },
  {
    facing = false,
    gadgetID = 78,
    scale = vec.vector(0.3, 0.3, 0.3, 0),
    matrixOffset = vec.matrix(4.371139E-08, 0, -1, 0, 0, 1, 0, 0, 1, 0, 4.371139E-08, 0, 1.5, -0.69, 4.5, 1),
    visible = true,
    colour = vec.vector(246, 196, 14, 255)
  }
}
local function resetCam()
  Stop_Under_Trailer_Camera()
  localPlayer:resetCameraMode()
  localPlayer.scoring.unregisterUnderTrailerExitCallback(resetCam)
end
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
            style = "Deactivating bombs 2 hud"
          }
        }
      }
    },
    {
      {
        task = "Payload Tracking",
        coreData = {upper = 30, lower = 0},
        specialName = "payload task",
        startingValues = {payload = 0},
        groupProgression = {importantMinorOrder = true},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Drive under trailer",
              params = {checkPreviousTrailers = true}
            },
            {
              goal = "Change payload by amount",
              params = {value = 1}
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            {
              goal = "Payload over",
              params = {
                value = goalParams["Amount of trucks to drive under"]
              }
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
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
            style = "Deactivating bombs 2 hud"
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Deactivating bombs 2"].taskCreatorFunctionLookups = {
  ["Player team"] = playerTask
}
missionSetupData["Deactivating bombs 2"].initiate = function(instance)
  localPlayer:blockAbility("zap", true)
  minimap.UnderTrailerArrowsSetModelRadius(123, 150, arrowMarkers)
  instance.previousTrailers = {}
  localPlayer:enterCutsceneMode()
end
missionSetupData["Deactivating bombs 2"].update = nil
taskCompleteData["Deactivating bombs 2"] = {}
taskCompleteData["Deactivating bombs 2"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.agent,
    cameraShots = cameraShots[2],
    successReason = "ID:245580",
    hint = "ID:246661",
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
    localPlayer:exitCutsceneMode()
    feedbackSystem.menusMaster.primaryTextPromptParam({
      prompt = "ID:234228",
      delay = true,
      priority = 1
    })
  elseif task.specialName == "payload task" then
    if task.success then
      if feedbackSystem.getTimer() < math.floor(singlePlayerStatistics.getScoreStatistic()) / 100 then
        params.rating = "PASS"
        params.callback = completeTask
        singlePlayerStatistics.updateScoreStatistic(feedbackSystem.getTimer(), "Time")
      else
        params.failReason = "ID:231222"
        params.rating = "FAIL"
        params.callback = failTask
      end
      localPlayer.challenge.endScreen(taskObject, params)
    else
      if 1 <= task.agent.damage then
        params.failReason = "ID:173965"
      else
        params.failReason = "ID:231166"
      end
      params.rating = "FAIL"
      params.callback = failTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
  end
end
missionEndCallback["Deactivating bombs 2"] = function(instance)
  localPlayer:blockAbility("zap", false)
  resetCam()
  minimap.UnderTrailerArrowsSetModelRadius()
  if instance.previousTrailers then
    for index, gameVehicle in next, instance.previousTrailers, nil do
      GameVehicleResource.UnRegisterDeletionCallback(gameVehicle, recycleTrailerGameVehicle)
    end
  end
end
