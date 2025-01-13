module("cardSystem.logic")
missionSetupData["Exposition takedown the getaway"] = {}
local doomedTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait for your inevitable demise"
      }
    }
  }
  return task
end
local jumpLocation = vec.vector(-267.8243, 66.32082, 269.5462, 1)
local playerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Tutorial trigger",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5}
            },
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            }
          }
        },
        HUD = {
          {style = HUD}
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Meat",
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Getaway damage above",
              params = {value = 0.05}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 20}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Busted getaway"
            }
          },
          {
            failCondition = true,
            {
              goal = "Getaway escaped"
            }
          },
          {
            failCondition = true,
            {
              goal = "All chaser teammates wrecked"
            }
          }
        },
        HUD = {
          {
            style = "Takedown HUD"
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
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            }
          }
        },
        audioPIP = audio,
        HUD = {
          {
            style = "Takedown HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Cop 1 damage comments",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            },
            {
              goal = "Specified chaser damage above",
              params = {ID = 1, value = 0.4}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            autoRefresh = true,
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            },
            {
              goal = "Specified chaser damage above",
              params = {ID = 1, value = 0.6}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Player in zap",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 3,
            {
              goal = "Player in zap",
              params = {value = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Changed vehicle",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Changed vehicle",
              params = {value = false}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Player is in another vehicle when the cop car starts to lose the evader",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1, inverse = true}
            },
            {
              goal = "Losing getaway"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Back in range speech trigger",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Losing getaway"
            }
          },
          {
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            },
            {
              goal = "Within radius of getaway",
              params = {
                value = felony_chase.chaseSettingsPerMission["Exposition 06 Law Breaker (cop)"].radius
              }
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
missionSetupData["Exposition takedown the getaway"].taskCreatorFunctionLookups = {
  ["Evade team"] = doomedTask,
  ["Chase team"] = doomedTask,
  ["Player"] = playerTask
}
missionSetupData["Exposition takedown the getaway"].initiate = function(instance)
  localPlayer:blockAbility("zap", true)
  feedbackSystem.menusMaster.currentHUDSetVariable("iMinimap_flash", 2)
  createFixedPosition(instance, {jumpLocation}, 101)
  local evaderGameVehicle = instance.taskObjectsByActorID.Evader.coreData.agent.gameVehicle
  local chaserGameVehicle = instance.taskObjectsByActorID.Chaser.coreData.agent.gameVehicle
  felony_chase.startChase(evaderGameVehicle, chaserGameVehicle)
end
missionSetupData["Exposition takedown the getaway"].update = nil
missionSetupData["Exposition takedown the getaway"].goalComplete = nil
local getPlayerDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Jump Camera" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 101), false
    end
  end
end
missionSetupData["Exposition takedown the getaway"].targetList = {Player = getPlayerDynamicTargets}
taskCompleteData["Exposition takedown the getaway"] = {}
taskCompleteData["Exposition takedown the getaway"].taskComplete = function(taskObject, task)
  local params = {
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    failReasonWrecked = task.instance.challenge.taskCompleteData["Failure reason (Wrecked)"],
    hint = "ID:235487"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.specialName == "Is player controlled" then
    feedbackSystem.startMusic("Uid02807_Exp_Takedown1_Play")
  elseif task.specialName == "Changed vehicle" then
    localPlayer.primaryFelony.status.usedCivVehicles = true
  end
  local function endScreen()
    feedbackSystem.stopMusic("Uid02807_Exp_Takedown1_Stop")
    feedbackSystem.menusMaster.currentHUDSetVariable("iMinimap_flash", 0)
    localPlayer:exitCutsceneMode()
    params.vehicle = felony_chase.endScreenVehicle
    localPlayer.challenge.endScreen(taskObject, params)
  end
  if task.specialName == "Meat" then
    if task.success then
      if localPlayer.primaryFelony.status.usedCivVehicles then
        params.dialogue = "GPMV00_SUCCESS_L_2"
      else
        params.dialogue = "GPMV00_SUCCESS_L_1"
      end
      params.rating = "PASS"
      params.callback = completeTask
      endScreen()
    else
      if felony_chase.endScreenVehicle.damage >= 1 then
        params.failReason = "ID:178465"
        params.dialogue = "GPMV00_FAILURE_L_1"
        params.driverIsTanner = true
      else
        params.failReason = "ID:178464"
        params.dialogue = "GPMV00_FAILURE_L_2"
      end
      params.callback = failTask
      params.rating = "FAIL"
      endScreen()
    end
  end
end
missionEndCallback["Exposition takedown the getaway"] = function(instance)
  localPlayer:blockAbility("zap", false)
  feedbackSystem.stopMusic("Uid02807_Exp_Takedown1_Stop")
  feedbackSystem.menusMaster.currentHUDSetVariable("iMinimap_flash", 0)
  if CutsceneFiles.Exposition.felonyTutorialActive then
    localPlayer:blockAbility("zap", false)
    controlHandler:resetState("missionComplete")
    controlHandler:removeState("missionComplete", localPlayer.localID)
    CameraSystem.ClearScene()
    removeUserUpdateFunction("slowDownUpdate")
    removeUserUpdateFunction("speedUpUpdate")
    simulation.setSpeed(1)
    if localPlayer.cameraMode == "DriverEye" then
      CameraSystem.SetClippingPlanesForKidnappedBootShot(false)
    end
    localPlayer:exitCutsceneMode()
    feedbackSystem.updateTutorialPanel({panelState = 0, continueState = 0})
    CutsceneFiles.Exposition.felonyTutorialActive = false
  end
end
