module("cardSystem.logic")
missionSetupData["Kill Tanner"] = {}
local tannerTask = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Wander",
        specialName = "Init audio",
        taskConditions = {
          {
            {
              goal = "Time trigger",
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
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {style = HUD}
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Shift to ordell",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        HUD = {
          {style = HUD}
        }
      }
    }
  }
  return task
end
local tanner2Task = function(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    {
      {
        task = "No AI",
        specialName = "Audio pause at start",
        taskConditions = {
          {
            {
              goal = "Actor is in major order",
              params = {
                actorID = "Ordell",
                value = {3, 0}
              }
            },
            {
              goal = "Time trigger",
              params = {value = 2.5}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        },
        audioPIP = audio,
        HUD = {
          {style = HUD}
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Tutorial complete",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Drive route - button watch",
        taskConditions = {
          {
            {
              goal = "Button Press",
              params = {
                watchFor = "Pressed",
                button = "Vehicle_Accelerate"
              }
            }
          },
          {
            {
              goal = "Button Press",
              params = {
                watchFor = "Pressed",
                button = "Vehicle_Reverse"
              }
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Drive route - timer start",
        taskConditions = {
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
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
        specialName = "Drive route - timer start 2",
        taskConditions = {
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        audioPIP = audio,
        HUD = {
          {style = HUD}
        }
      }
    },
    {
      {
        task = "Linear Checkpoints No AI",
        specialName = "Drive route",
        dynamicTargets = true,
        coreData = {
          totalLaps = goalParams["Total laps"] or 0
        },
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 15}
            }
          }
        },
        taskConditions = {
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
              goal = "Reached checkpoints by times",
              params = {
                checkpointTimes = {
                  nil,
                  40,
                  25,
                  25,
                  30,
                  25,
                  30
                }
              }
            }
          },
          {
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {hideTerrainMarker = true}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        audioPIP = audio,
        HUD = {
          {style = HUD}
        }
      },
      {
        task = "No AI",
        specialName = "Control audio",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Button Press",
              params = {
                watchFor = "Pressed",
                button = "Vehicle_Accelerate"
              }
            }
          },
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Button Press",
              params = {
                watchFor = "Pressed",
                button = "Vehicle_Reverse"
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "End drive audio",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 175}
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
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Second back seat audio",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Above speed",
              params = {value = 75}
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
        specialName = "Tanner damaged",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Damage above",
              params = {value = 0.5}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Turn off back seat",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 8}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2}
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
        audioPIP = audio,
        HUD = {
          {style = HUD}
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Audio pause",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5}
            },
            {
              goal = "Event active",
              params = {inverse = true}
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
            manager = "Instance vehicles"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Jericho zap",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
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
        audioPIP = audio,
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Play shift audio",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
            },
            {
              goal = "Event active",
              params = {inverse = true}
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
        audioPIP = audio,
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Shift audio",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            },
            {
              goal = "Event active",
              params = {inverse = true}
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
            manager = "Instance vehicles"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Teleport tanner",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
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
            manager = "Instance vehicles"
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
local ordellTask = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Linear Checkpoints",
        specialName = "Get to tanner",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 35}
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {hideTerrainMarker = true}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        audioPIP = audio,
        HUD = {
          {style = HUD}
        }
      },
      {
        task = "No AI",
        specialName = "Close to tanner",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 160}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Empty dynamicTargets"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Ordell damaged2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Damage above",
              params = {value = 0.5}
            },
            {
              goal = "Damage below",
              params = {value = 1}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Zap attempt1",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            },
            {
              goal = "Button Press",
              params = {watchFor = "Pressed", button = "Zap_In"}
            },
            {
              goal = "Recent audio played",
              params = {value = 2}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Ordell audio played",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        },
        HUD = {
          {style = HUD}
        }
      },
      {
        task = "No AI",
        specialName = "Init audio ordell",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 2.5}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Cutscene",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          }
        },
        HUD = {
          {style = HUD}
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Tutorial complete ordell",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Chase drive tanner",
        taskConditions = {
          {
            {
              goal = "Actor is in major order",
              params = {
                actorID = "Tanner2",
                value = {7}
              }
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        audioPIP = audio,
        HUD = {
          {style = HUD}
        }
      },
      {
        task = "No AI",
        specialName = "Zap attempt2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 5}
            },
            {
              goal = "Button Press",
              params = {watchFor = "Pressed", button = "Zap_In"}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Ordell damaged",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Damage above",
              params = {value = 0.5}
            },
            {
              goal = "Damage below",
              params = {value = 1}
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
function copTask(goalParams, HUD, audio)
  local task = {
    {
      {task = "No AI"}
    }
  }
  return task
end
missionSetupData["Kill Tanner"].taskCreatorFunctionLookups = {
  ["Tanner team"] = tannerTask,
  ["Tanner team 2"] = tanner2Task,
  ["Ordell team"] = ordellTask,
  ["Cop team"] = copTask
}
local chaseGameVehicle, leadGameVehicle, leadVehicle, chaserVehicle
local function chaseSetup(instance)
  chaseGameVehicle = instance.taskObjectsByActorID.Ordell.coreData.agent.gameVehicle
  leadGameVehicle = instance.taskObjectsByActorID.Tanner2.coreData.agent.gameVehicle
  chaserVehicle = vehicleManager.vehiclesByGameVehicle[chaseGameVehicle]
  leadVehicle = vehicleManager.vehiclesByGameVehicle[leadGameVehicle]
  chaserVehicle.blockCamChange = true
  setActiveCamera("Normal", localPlayer.localID)
  leadVehicle:stopHighSpeedDriving()
  CameraSystemRegisterUpdate(localPlayer.camName, localPlayer.camera, "simulation", Camera_Function_Vehicle_Driver_Eye_Cam, {
    agent = localPlayer.currentVehicle,
    pad = localPlayer.gamepad
  })
  GameVehicleResource.lockEmergencyBrakes(chaseGameVehicle)
  feedbackSystem.menusMaster.setCurrentFocusString(4)
  feedbackSystem.menusMaster.blockHintButton(false)
  propSystem.setupRuntimeProps("KillTannerProps", false, false)
  Commentary.OverridePlayer(chaseGameVehicle)
  chaserVehicle.blockTow = true
  leadVehicle.blockTow = true
  chaserVehicle:set_damageMultiplier(0)
  localPlayer:blockAbility("ram", true)
  localPlayer:blockAbility("nitro", true)
  enableAbilities(localPlayer.localID, false)
end
local function BackSeatDriverStart(instance)
  print("START BACKSEAT DRIVER")
  GameVehicleResource.unlockEmergencyBrakes(chaseGameVehicle)
  instance.backSeatActive = true
  instance.taskObjectsByActorID.Tanner2.coreData.actor.showRouteArrows = "All"
  cardSystem.setUpRouteManager(instance.taskObjectsByActorID.Tanner2)
  RouteArrowsManager.HideArrows(localPlayer.localID, false)
  player.setAttachment(localPlayer.localID, leadGameVehicle)
  player.registerController()
  BackSeatDriver.SetDistanceFromLeader(10)
  BackSeatDriver.SetPathTimeOffset(0.35)
  BackSeatDriver.AddLeadVehicle(leadGameVehicle)
  BackSeatDriver.AddChaseVehicle(chaseGameVehicle)
  BackSeatDriver.Enable(true)
  replays.unPause()
end
local function BackSeatDriverStop(instance, endMission)
  Commentary.OverridePlayer()
  BackSeatDriver.Clear()
  instance.backSeatActive = false
  CameraSystemRegisterUpdate(localPlayer.camName, localPlayer.camera, "simulation", Camera_Function_Vehicle_Driver_Eye_Cam, {
    agent = localPlayer.currentVehicle,
    pad = localPlayer.gamepad
  })
  if not endMission then
    player.setAttachment(localPlayer.localID, chaseGameVehicle)
    player.registerController()
  end
end
local endDriveToPosition = vec.vector(-1954.24, 157.1231, -4050.504, 1)
missionSetupData["Kill Tanner"].initiate = function(instance)
  createCheckpoints(instance)
  createFixedPosition(instance, {endDriveToPosition}, 101)
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    chaseSetup(instance)
  end
  localPlayer:blockAbility("zap", true)
end
missionSetupData["Kill Tanner"].update = nil
local checkpointsDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, task.actor.checkpointGroup)
  if task.specialName == "Hotspot minor" then
    if dynamicListID then
      return false, true
    else
      return {
        allCheckpoints[1]
      }, true
    end
  elseif task.specialName == "Audio pause" or task.specialName == "Jericho zap" or task.specialName == "Play shift audio" or task.specialName == "Shift audio" then
    task.instance.taskObjectsByActorID.Tanner2.coreData.actor.routeName = nil
    return checkpointSystem.getCheckpoints(task.instance, 101), false
  elseif dynamicListID then
    if task.specialName == "Close to tanner" then
      return false, true
    elseif task.networkVars.checkpoints < #allCheckpoints then
      return {
        allCheckpoints[task.networkVars.checkpoints + 1]
      }, false
    else
      return {
        allCheckpoints[1]
      }, true
    end
  elseif task.specialName == "Close to tanner" then
    return {
      allCheckpoints[#allCheckpoints]
    }, false
  else
    return {
      allCheckpoints[task.networkVars.checkpoints]
    }, false
  end
end
missionSetupData["Kill Tanner"].targetList = {
  ["Ordell team"] = checkpointsDynamicTargets,
  ["Tanner team 2"] = checkpointsDynamicTargets
}
taskCompleteData["Kill Tanner"] = {}
taskCompleteData["Kill Tanner"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = taskObject.coreData.agent,
    successReason = "ID:245617",
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    passCondition = task.instance.challenge.taskCompleteData["Pass condition"],
    hint = "ID:235485"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.success then
    if task.specialName == "Shift to ordell" then
      challengeSystem.spawnActors(task.instance, "Never", {Ordell = true})
      replays.pause()
      localPlayer:zapToAgent(task.instance.taskObjectsByActorID.Ordell.coreData.agent)
      localPlayer.missionSupport:setMainTaskObject(task.instance.taskObjectsByActorID.Ordell)
    elseif task.specialName == "Init audio ordell" then
      replays.unPause()
    elseif task.specialName == "Get to tanner" then
      engineCutscene.playCutscene("ch6_sm6_01", function()
        taskObject.coreData.agent:teleportToPositionAndHeading(vec.vector(-1938.188, 8.209471, -2485.649, 1), 2.70962)
        challengeSystem.spawnActors(task.instance, "Never", {
          ["Tanner2"] = true,
          ["Dead vehicle"] = true,
          ["Dead vehicle 2"] = true
        })
        chaseSetup(task.instance)
      end)
    elseif task.specialName == "Cutscene" then
      progressionSystem.triggerSoftSave({progression = 1})
      replays.pause()
    elseif task.specialName == "Drive route" then
      GameVehicleResource.ClearAreaOfVehicles(routes["Kill Tanner Chase Route"].checkpoints[7].position, 1250)
    elseif task.specialName == "Turn off back seat" then
      OneShotSound.Play("Jericho_ShiftWithRumble_OneShot")
      ZapAIPresence.Settings({
        Radius = 0.11,
        TransitionInTime = 0.15,
        Color = vec.vector(40, 40, 40, 1)
      })
      ZapAIPresence.StartTransition(task.instance.taskObjectsByActorID.Ordell.coreData.agent.gameVehicle, task.instance.taskObjectsByActorID.Tanner2.coreData.agent.gameVehicle)
      moodSystem.applyMood("The Target - jericho", 2)
      SNV.setFlashColour(task.instance.taskObjectsByActorID.Tanner2.coreData.agent.SNVID, vec.vector(1, 0, 0, 1))
      GameVehicleResource.setInfiniteMass(task.instance.taskObjectsByActorID.Tanner2.coreData.agent.gameVehicle, true)
      task.instance.taskObjectsByActorID.Tanner2.coreData.actor.markerType = "Opponent"
      task.instance.taskObjectsByActorID.Tanner2.coreData.agent:set_damageMultiplier(0)
      BackSeatDriverStop(task.instance)
      GameVehicleResource.setCharacterSpoolingEntityIndex(task.instance.taskObjectsByActorID.Tanner2.coreData.agent.gameVehicle, 0, "-376150524")
      GameVehicleResource.spoolOccupants(task.instance.taskObjectsByActorID.Tanner2.coreData.agent.gameVehicle)
      GameVehicleResource.upgradeOccupants(task.instance.taskObjectsByActorID.Tanner2.coreData.agent.gameVehicle)
      taskSystem.buildDriveTraits(task)
      local tannerSpeed = task.instance.taskObjectsByActorID.Tanner2.coreData.agent.gameVehicle.speed * 2
      local ordellSpeed = task.instance.taskObjectsByActorID.Ordell.coreData.agent.gameVehicle.speed * 0.5
      task.instance.taskObjectsByActorID.Tanner2.coreData.agent.gameVehicle.speed = tannerSpeed
      task.instance.taskObjectsByActorID.Ordell.coreData.agent.gameVehicle.speed = ordellSpeed
      task.instance.taskObjectsByActorID.Tanner2.coreData.agent.gameVehicle.performance = 2
    elseif task.specialName == "Shift audio" then
      localPlayer.cameraMode = "Normal"
      localPlayer:resetCameraMode()
      localPlayer:enterCutsceneMode()
      localPlayer:zapToAgent(task.instance.taskObjectsByActorID.Tanner2.coreData.agent)
      GameVehicleResource.setInfiniteMass(task.instance.taskObjectsByActorID.Tanner2.coreData.agent.gameVehicle, false)
    elseif task.specialName == "Teleport tanner" then
      params.callback = completeTask
      params.rating = "PASS"
      params.dialogue = "GPMV00_SUCCESS_L_1"
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "Drive route - button watch" then
      BackSeatDriverStart(task.instance)
    end
  else
    if task.instance.backSeatActive then
      BackSeatDriver.Clear()
    end
    if task.specialName == "Drive route" and 1 > taskObject.coreData.agent.damage then
      params.failReason = "ID:184828"
      params.hint = "ID:236261"
      params.dialogue = "GPMV00_FAILURE_L_1"
    elseif string.find(taskObject.coreData.actor.ID, "Tanner") then
      params.failReason = "ID:182731"
      params.dialogue = "GPMV00_FAILURE_L_1"
    elseif taskObject.coreData.actor.ID == "Ordell" then
      params.failReason = "ID:182731"
      params.dialogue = "GPMV02_FAILURE_L_2"
    end
    if 1 <= taskObject.coreData.agent.damage then
      params.reason = "Wrecked"
    end
    params.rating = "FAIL"
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Kill Tanner"] = function(instance)
  BackSeatDriverStop(instance, true)
  propSystem.cleanupRuntimeProps("KillTannerProps")
  removeUserUpdateFunction("playAudio")
  localPlayer:blockAbility("zap", false)
  localPlayer:blockAbility("ram", false)
  localPlayer:blockAbility("nitro", false)
  moodSystem.removeMood("The Target - jericho", 0)
  if localPlayer.currentVehicle then
    localPlayer.currentVehicle.blockCamChange = false
  end
  enableAbilities(localPlayer.localID, true)
  localPlayer:resetCameraMode()
  instance.challenge.actorPool.Tanner2.routeName = "Kill Tanner Chase Route"
end
