module("cardSystem.logic")
local playerTeam
missionSetupData["Test drive"] = {}
local tannerTask = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Linear Checkpoints",
        dynamicTargets = true,
        coreData = {totalLaps = 0},
        specialName = "Initial drive",
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Agent stopped inside radius",
              params = {
                value = 22,
                stopDuration = 1,
                unlockBrakes = false
              }
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
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {}
              }
            }
          },
          {
            manager = "Instance vehicles",
            settings = {selfOnly = true}
          }
        },
        audioPIP = audio,
        HUD = {
          {style = "Test drive"}
        }
      },
      {
        task = "No AI",
        specialName = "Tanner zap out",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = true}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "zap to tanner",
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
        task = "Linear Checkpoints",
        dynamicTargets = true,
        specialName = "ICam zapin",
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 5}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          },
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
          },
          {
            {
              goal = "Time trigger",
              params = {value = 1.25}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles",
            settings = {selfOnly = true}
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait for transition",
        taskConditions = {
          {
            {
              goal = "Is player controlled",
              params = {inverse = true}
            }
          },
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
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {}
              }
            }
          },
          {
            manager = "Instance vehicles",
            settings = {selfOnly = true}
          }
        }
      }
    }
  }
  return task
end
local ordellTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Non-linear Checkpoints",
        dynamicTargets = true,
        specialName = "Drive to start",
        goalConditions = {
          {
            {
              goal = "Agent stopped inside radius",
              params = {value = 10}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Wait to be controlled",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        HUD = {
          {style = "Test drive"}
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Camera change",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Pause before race",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Race preview",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "SoftSave",
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
        specialName = "Race countdown",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 4}
            }
          }
        },
        audioPIP = audio,
        HUD = {
          {style = "Test drive"}
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        dynamicTargets = true,
        specialName = "Race",
        coreData = {totalLaps = 0},
        groupProgression = {importantMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Within strip of road"
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
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Time trigger",
              params = {
                value = goalParams["Time limit"]
              }
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
            manager = "Target list",
            settings = {
              styles = {
                ["Checkpoint Gate"] = {}
              }
            }
          },
          {
            manager = "Instance vehicles",
            settings = {selfOnly = true}
          }
        },
        audioPIP = audio,
        HUD = {
          {style = "Test drive"}
        }
      },
      {
        task = "No AI",
        specialName = "Trigger commentary 1",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Trigger chase commentary",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Being chased"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Trigger time commentary 1",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 25}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Trigger time commentary 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 50}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Trigger time commentary 3",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 65}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Pause after race 1",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Is jumping",
              params = {inverse = true}
            },
            {
              goal = "Agent stopped inside radius",
              params = {
                value = 100,
                stopDuration = 1,
                unlockBrakes = false
              }
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles",
            settings = {selfOnly = true}
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Transition",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles",
            settings = {selfOnly = true}
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Test drive"].taskCreatorFunctionLookups = {
  ["Tanner team"] = tannerTask,
  ["Ordell team"] = ordellTask
}
local testDriveStart = vec.vector(-3645.881, 57.50656, 2821.361, 1)
local AlleywayBlock = vec.vector(-3753.646, 47.26075, 2791.736, 1)
local IcamZapInLocation = vec.vector(-3634.078, 63.77618, 2869.965, 1)
local RaceEndLocation = vec.vector(-4118.288, 42.49934, 2947.984, 1)
missionSetupData["Test drive"].initiate = function(instance)
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    instance.challenge.showRouteArrows = "All"
  end
  createCheckpoints(instance)
  feedbackSystem.startMusic("Mus_Uid12496_Play")
  createFixedPosition(instance, {testDriveStart}, 99)
  createFixedPosition(instance, {IcamZapInLocation}, 100)
  createFixedPosition(instance, {AlleywayBlock}, 101)
  createFixedPosition(instance, {RaceEndLocation}, 102)
  FixedCameras = {
    vec.vector(-3606.698, 63.35804, 2819.373, 1),
    vec.vector(-3677.279, 138.9371, 2807.975, 1),
    vec.vector(-3609.337, 61.97192, 2833.051, 1),
    [7] = vec.vector(-3616.431, 67.47614, 2849.623, 1)
  }
end
missionSetupData["Test drive"].update = nil
local tannerDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if dynamicListID then
    return false, true
  elseif task.specialName == "Initial drive" or task.specialName == "ICam zapin" then
    return checkpointSystem.getCheckpoints(task.instance, 100), false
  end
end
local ordellDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if task.specialName == "Drive to start" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 99), false
    end
  elseif task.specialName == "Pause after race 1" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 102), false
    end
  elseif dynamicListID then
    if task.networkVars.checkpoints < #allCheckpoints then
      return {
        allCheckpoints[task.networkVars.checkpoints + 1]
      }, false
    else
      return {
        allCheckpoints[1]
      }, true
    end
  else
    return {
      allCheckpoints[task.networkVars.checkpoints]
    }, false
  end
end
missionSetupData["Test drive"].targetList = {
  ["Tanner team"] = tannerDynamicTargets,
  ["Ordell team"] = ordellDynamicTargets
}
local zapTransitionEnd = function()
  zapTransitionFinished = true
end
local tannerAtZapPosition = false
taskCompleteData["Test drive"] = {}
taskCompleteData["Test drive"].taskComplete = function(taskObject, task)
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  local function zapInOrdell()
    task.instance.challenge.showRouteArrows = "All"
    localPlayer.missionSupport:setMainTaskObject(task.instance.taskObjectsByActorID.Ordell)
    localPlayer:zapToAgent(task.instance.taskObjectsByActorID.Ordell.coreData.agent)
    minimap.RemoveAllHighlightedVehicleModelUIDs()
    localPlayer:buildZapReturn()
    feedbackSystem.menusMaster.setCurrentFocusString(2)
    localPlayer:blockAbility("zap", true)
    localPlayer:enterCutsceneMode()
  end
  local function atZapPosition()
    return tannerAtZapPosition
  end
  if task.success then
    if task.specialName == "Initial drive" then
      if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle ~= task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle or localPlayer.inZap then
        localPlayer:zapToAgent(task.instance.taskObjectsByActorID.Tanner.coreData.agent)
      end
    elseif task.specialName == "zap to tanner" then
      OneShotSound.Play("HUD_Play_Waypoint")
      challengeSystem.spawnActors(task.instance, "Never", {Ordell = true})
      GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID.Ordell.coreData.agent.gameVehicle.position, 15)
      minimap.SetHighlightedVehicleModelUID(163)
      minimap.SetHighlightedVehicles(true)
      local iCamTable = {
        cameraTargets = {
          task.instance.taskObjectsByActorID.Ordell.coreData.agent.gameVehicle
        },
        duration = 10,
        speed = 0.75,
        framing = "verywide",
        angleYaw = "rear",
        callbackFunction = zapInOrdell,
        stopFunction = function()
          if task.instance.taskObjectsByActorID.Ordell and task.instance.taskObjectsByActorID.Ordell.coreData.agent.gameVehicle.speed <= 1 then
            return true
          end
        end,
        fixedCameras = FixedCameras
      }
      iCamActivationTableInput(iCamTable)
    elseif task.specialName == "ICam zapin" then
      tannerAtZapPosition = true
    elseif task.specialName == "Camera change" then
      localPlayer.cameraSupport.miniSceneCamera()
      localPlayer:enterCutsceneMode()
    elseif task.specialName == "SoftSave" then
      progressionSystem.triggerSoftSave({progression = 1})
      feedbackSystem.menusMaster.setCurrentFocusString(2)
      localPlayer.cameraSupport.miniSceneCamera()
      localPlayer:enterCutsceneMode()
      localPlayer:blockAbility("zap", true)
    elseif task.specialName == "Race countdown" then
      task.agent:unlockEmergencyBrakes()
      localPlayer:exitCutsceneMode()
      localPlayer:resetCameraMode()
      RaceManager.EnableWrongWay(task.instance.raceId, true)
      RaceManager.EnableOffRoute(task.instance.raceId, true)
    elseif task.specialName == "Race" then
      raceManager.wrongWayCallback(false)
      RaceManager.EnableWrongWay(task.instance.raceId, false)
      raceManager.offRouteCallback(false)
      RaceManager.EnableOffRoute(task.instance.raceId, false)
      feedbackSystem.removeSlot(2)
    elseif task.specialName == "Pause after race 1" then
      localPlayer.cameraSupport.miniSceneCamera()
      localPlayer:enterCutsceneMode()
      localPlayer:blockAbility("zap", true)
    elseif task.specialName == "Transition" then
      localPlayer:blockAbility("zap", false)
      localPlayer:exitCutsceneMode()
      localPlayer:resetCameraMode()
      local params = {
        vehicle = task.instance.taskObjectsByActorID.Ordell.coreData.agent,
        successReason = task.instance.challenge.taskCompleteData["Success reason"],
        callback = completeTask,
        rating = "PASS",
        dialogue = "GPMV01_SUCCESS_L_1"
      }
      localPlayer.challenge.endScreen(taskObject, params)
    end
  else
    local params = {
      vehicle = localPlayer.currentVehicle,
      failReason = task.instance.challenge.taskCompleteData["Failure reason"],
      hint = "ID:236259",
      callback = failTask,
      rating = "FAIL"
    }
    if task.specialName == "Initial drive" or task.specialName == "Wait for transition" or task.specialName == "ICam zapin" then
      params.vehicle = task.instance.taskObjectsByActorID.Tanner.coreData.agent
      params.hintIcon1 = localPlayer.buttonLayout.minimapZoom
      params.hint = "ID:235485"
      params.driverIsTanner = true
      params.dialogue = "GPMV01_FAILURE_L_1"
      if task.condition == 3 then
        params.failReason = "ID:186264"
        params.reason = "Busted"
      else
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        params.reason = "Wrecked"
      end
    elseif task.specialName == "Race" then
      localPlayer:blockAbility("zap", false)
      if task.condition == 2 then
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        params.dialogue = "GPMV02_FAILURE_L_1"
        params.reason = "Wrecked"
      elseif task.condition == 3 then
        params.dialogue = "GPMV02_FAILURE_L_2"
      elseif task.condition == 4 then
        params.failReason = "ID:186264"
        params.reason = "Busted"
      end
    end
    feedbackSystem.stopMusic("Uid12496_CH05_TJ_TestDrive_Stop")
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Test drive"] = function(instance)
  instance.challenge.showRouteArrows = "None"
  localPlayer:blockAbility("zap", false)
  tannerAtZapPosition = false
end
