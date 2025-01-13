module("cardSystem.logic")
missionSetupData["Exposition pre crash chase alleyway"] = {}
local tannerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Speech and mission complete",
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 7}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 14}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Look behind prompt",
        groupProgression = {importantMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Prompt active",
              params = {promptType = "Secondary", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 5.5}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 10}
            }
          },
          {
            {
              goal = "Button Press",
              params = {
                watchFor = "Pressed",
                button = "Camera_LookUp"
              }
            }
          },
          {
            {
              goal = "Button Press",
              params = {
                watchFor = "Pressed",
                button = "ActionButton"
              }
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Mission complete",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
local jerichoTask = function(goalParams, HUD)
  local task = {
    {
      {task = "No AI", specialName = "Jericho"}
    }
  }
  return task
end
missionSetupData["Exposition pre crash chase alleyway"].taskCreatorFunctionLookups = {
  ["Tanner team"] = tannerTask,
  ["Jericho team"] = jerichoTask
}
local loadAudioCallBack = function()
  feedbackSystem.startMusic("Uid06903_Exp_BullRun_Play")
end
missionSetupData["Exposition pre crash chase alleyway"].initiate = function(instance)
  propSystem.reenableAllPropTypes()
  propSystem.disablePropType("DO_NOT_USE_shutter_A", "DO_NOT_USE_shutter_B", "DO_NOT_USE_Wall_A")
  Atlas.JerichoAlleyWayActive(true)
  propSystem.setupRuntimeProps(instance.challenge.props, false, false)
  localPlayer:blockAbility("zap", true)
  feedbackSystem.menusMaster.setFocusButtonText()
  Commentary.LoadMission(cards.Missions[instance.challenge.name].MissionID, loadMissionCallBack)
  Sound.LoadMission(cards.Missions[instance.challenge.name].MissionID, loadAudioCallBack)
  instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.velocity = instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.matrix[2] * 15
  instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.maxAllowedDamage = 0.5
  AlleyChaser.setChaser(instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle)
  AlleyChaser.SetControl(true)
  if localPlayer.cameraMode ~= "DriverEye" then
    if localPlayer.cameraMode == "Bumper" then
      VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
    end
    CameraSystemRegisterUpdate("Game_Cam", game_camera, "simulation", Camera_Function_Vehicle_Driver_Eye_Cam, {
      agent = localPlayer.currentVehicle
    })
  end
  localPlayer.currentVehicle.blockCamChange = true
end
missionSetupData["Exposition pre crash chase alleyway"].update = nil
missionSetupData["Exposition pre crash chase alleyway"].targetList = {
  ["Tanner team"] = {},
  ["Jericho team"] = {}
}
taskCompleteData["Exposition pre crash chase alleyway"] = {}
taskCompleteData["Exposition pre crash chase alleyway"].taskComplete = function(taskObject, task)
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  if task.specialName == "Mission complete" then
    local params = {
      callback = completeTask,
      rating = "PASS",
      keepMusicTrackRunning = true
    }
    AlleyChaser.SetControl(false)
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Exposition pre crash chase alleyway"] = function(instance)
  AlleyChaser.SetControl(false)
  localPlayer.currentVehicle.blockCamChange = true
  if localPlayer.cameraMode == "Bumper" then
    VehicleSystem.setPlayerVehicleVisible(0, localPlayer.localID)
  end
  localPlayer:resetCameraMode()
  propSystem.cleanupRuntimeProps("Bull run props")
end
