module("cardSystem.logic")
missionSetupData["Tanner and Jones 7"] = {}
local timerLengths = {
  [1] = 40,
  [2] = 70,
  [3] = 50
}
local function tannerTask(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Wander",
        specialName = "Inital delay",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
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
        specialName = "get to decoy",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 40}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"]
              }
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          },
          {
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {hideTerrainMarker = true}
              }
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 7 HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Second speech",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Is player controlled"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "zap before bomb",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Player outside radius of specified actors",
              params = {
                actorIDs = {"Decoy"},
                value = 300
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "destination prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 7 HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Trigger cutscene",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Tanner"}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Trigger Cutscene",
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
        specialName = "Icam started",
        taskConditions = {
          {
            {
              goal = "In cutscene or icam"
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "icam ended",
        taskConditions = {
          {
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
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
        task = "No AI",
        taskConditions = {
          {
            {
              goal = "Actor is in major order",
              params = {
                actorID = "Tanner",
                value = {0, 7}
              }
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "pre-location delay",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
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
        specialName = "get to midpoint build up",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 4}
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
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Damage watch",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.5}
            }
          },
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.8}
            }
          },
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.95}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "destination prompt 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 7 HUD"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "get to midpoint",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Getaway within radius",
              params = {value = 65}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          },
          {
            failCondition = true,
            {
              goal = "Getaway damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Time trigger",
              params = {
                value = timerLengths[1]
              },
              feedback = "Time"
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
        HUD = {
          {
            style = "Tanner and Jones 7 HUD",
            settings = {
              timerLength = timerLengths[1],
              updateTimer = true
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Damage watch 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.5}
            }
          },
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.8}
            }
          },
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.95}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "get to midpoint 2",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Getaway within radius",
              params = {value = 65}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          },
          {
            failCondition = true,
            {
              goal = "Getaway damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Time trigger",
              params = {
                value = timerLengths[2]
              },
              feedback = "Time"
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
        HUD = {
          {
            style = "Tanner and Jones 7 HUD",
            settings = {
              timerLength = timerLengths[2],
              updateTimer = true
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Damage watch 3",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.5}
            }
          },
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.8}
            }
          },
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.95}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "get to leila audio 1",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            {
              goal = "Player in getaway vehicle"
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "get to leila",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Getaway within radius",
              params = {value = 50}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          },
          {
            failCondition = true,
            {
              goal = "Getaway damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Time trigger",
              params = {
                value = timerLengths[3]
              },
              feedback = "Time"
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
        HUD = {
          {
            style = "Tanner and Jones 7 HUD",
            settings = {
              timerLength = timerLengths[3],
              updateTimer = true
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Damage watch 4",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.5}
            }
          },
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.8}
            }
          },
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.95}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "get to leila audio 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            {
              goal = "Player in getaway vehicle"
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "trigger soft save",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "set up felony",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
local player2Task = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "chase Leila",
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "All chaser teammates wrecked"
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Getaway escaped"
            }
          },
          {
            {
              goal = "Busted getaway"
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 7 HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "losing Leila",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
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
        specialName = "Zoom to Leila",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            },
            {
              goal = "Within radius of getaway",
              params = {value = 100}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "in zap on highway",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1, inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = true}
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
local decoyTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {task = "No AI"}
    }
  }
  return task
end
local leilaTask = function(goalParams, HUD, audio)
  local task = {
    {
      {task = "No AI"}
    }
  }
  return task
end
local truckTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "chase tanner",
        groupProgression = {priorityMinorOrder = true},
        taskConditions = {
          {
            {
              goal = "Actor within radius of getaway",
              params = {value = 100}
            }
          }
        }
      }
    }
  }
  return task
end
local tanner2Task = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "trigger soft save",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        }
      },
      {task = "No AI"}
    }
  }
  return task
end
missionSetupData["Tanner and Jones 7"].taskCreatorFunctionLookups = {
  ["Player"] = playerTask,
  ["Player2"] = player2Task,
  ["Tanner softsave"] = tanner2Task,
  ["Tanner team"] = tannerTask,
  ["Leila team"] = leilaTask,
  ["Decoy team"] = decoyTask,
  ["Truck team 1"] = truckTask
}
local firstCheckpointAlley = vec.vector(107.3045, 19.47744, -2893.122, 1)
local highwayCheckpoint1 = vec.vector(-1050.273, 70.52197, -3642.046, 1)
local highwayCheckpoint3 = vec.vector(-3034.135, 91.27338, -2931.563, 1)
local highwayCheckpoint4 = vec.vector(-2945.208, 49.11746, -1505.466, 1)
local playerTeleport = vec.matrix(-0.5897511, 0.1491098, -0.793626, -143.7346, 0.001413372, 0.982996, 0.1836167, 45.2612, 0.8075083, 0.1071795, -0.5799337, -2992.387, 0, 0, 0, 1)
local evader, evaderTanner
missionSetupData["Tanner and Jones 7"].initiate = function(instance)
  local softSaveData = progressionSystem.getSoftSaveData()
  if not softSaveData then
    feedbackSystem.menusMaster.setCurrentFocusString(1)
  elseif softSaveData and softSaveData.progression == 1 then
    feedbackSystem.menusMaster.setCurrentFocusString(2)
  elseif softSaveData and softSaveData.progression >= 2 then
    instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.speed = 17.88
    feedbackSystem.startMusic("Uid07426_CH07_TJ_Entrapment_Play")
    feedbackSystem.menusMaster.setCurrentFocusString(3)
    evaderTanner = instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle
  end
  createFixedPosition(instance, {firstCheckpointAlley}, 101)
  createFixedPosition(instance, {highwayCheckpoint3}, 201)
  createFixedPosition(instance, {highwayCheckpoint4}, 202)
  createFixedPosition(instance, {highwayCheckpoint1}, 200)
  PatrollingVehicleManager.EnableHud(false)
  felony_patrollingVehicleManager.enablePatrollingVehicles(false)
  createCheckpoints(instance)
end
missionSetupData["Tanner and Jones 7"].update = nil
local getTannerTeamDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    return false, true
  elseif task.specialName == "get to midpoint" or task.specialName == "get to midpoint build up" then
    return checkpointSystem.getCheckpoints(task.instance, 200), true
  elseif task.specialName == "get to midpoint 2" then
    return checkpointSystem.getCheckpoints(task.instance, 201), true
  elseif task.specialName == "get to leila" then
    return checkpointSystem.getCheckpoints(task.instance, 202), true
  else
    return checkpointSystem.getCheckpoints(task.instance, 101), true
  end
end
missionSetupData["Tanner and Jones 7"].targetList = {
  ["Tanner team"] = getTannerTeamDynamicTargets,
  ["Decoy team"] = getTannerTeamDynamicTargets
}
taskCompleteData["Tanner and Jones 7"] = {}
taskCompleteData["Tanner and Jones 7"].taskComplete = function(taskObject, task)
  if task.success then
    if task.specialName == "get to decoy" then
      if not task.agent.controlled then
        localPlayer:zapToAgent(task.agent)
      end
      vehicleManager.unhookPlayerVehicle()
      localPlayer:enterCutsceneMode({addAI = false})
      OneShotSound.Play("HUD_Play_Waypoint")
    elseif task.specialName == "icam ended" then
      progressionSystem.triggerSoftSave({progression = 1})
      feedbackSystem.startMusic("Uid07426_CH07_TJ_Entrapment_Play")
      task.instance.taskObjectsByActorID.Decoy:delete(true)
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Truck Start 1"] = true,
        ["Truck Start 2"] = true,
        ["Truck Start 3"] = true,
        ["Truck Start 4"] = true,
        ["Truck Start 5"] = true
      })
      task.instance.taskObjectsByActorID["Truck Start 1"].coreData.agent.gameVehicle.performance = 1.25
      task.instance.taskObjectsByActorID["Truck Start 2"].coreData.agent.gameVehicle.performance = 1.25
      taskObject.coreData.agent.gameVehicle.speed = 17.88
      evaderTanner = task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle
      localPlayer:overrideZapReturn(task.instance.taskObjectsByActorID.Tanner.coreData.agent)
      localPlayer:buildZapReturn()
      felony_getaway.addEvader(evaderTanner)
      felony_getaway.addChaser(evaderTanner, task.instance.taskObjectsByActorID["Truck Start 1"].coreData.agent.gameVehicle)
      felony_getaway.addChaser(evaderTanner, task.instance.taskObjectsByActorID["Truck Start 2"].coreData.agent.gameVehicle)
    elseif task.specialName == "Trigger Cutscene" then
      Commentary.StopCommentary()
      task.agent:addTemporaryInvulnerability(3)
      engineCutscene.playCutscene("mis_ch7_Entrapment_01", nil, function()
        feedbackSystem.menusMaster.setCurrentFocusString(2)
        task.agent:teleportToMatrix(playerTeleport)
      end, nil, nil, 0.5)
    elseif task.specialName == "get to midpoint" or task.specialName == "get to midpoint 2" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245300", nil)
      OneShotSound.Play("HUD_Play_Waypoint")
    elseif task.specialName == "set up felony" then
      evaderTanner = task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle
      localPlayer:clearZapReturnOverride()
      challengeSystem.spawnActors(task.instance, "Any", {Player2 = true})
      challengeSystem.spawnActors(task.instance, "Any", {Leila = true})
      localPlayer.missionSupport:setMainTaskObject(task.instance.taskObjectsByActorID.Player2)
      evader = task.instance.taskObjectsByActorID.Leila.coreData.agent
      felony_chase.startChase(evader.gameVehicle, evaderTanner)
      feedbackSystem.menusMaster.primaryTextPrompt("ID:247341", nil)
      OneShotSound.Play("HUD_Play_Waypoint")
      feedbackSystem.menusMaster.setCurrentFocusString(3)
      GameVehicleResource.spoolOccupants(localPlayer.primaryFelony.getawayGameVehicle)
      GameVehicleResource.upgradeOccupants(localPlayer.primaryFelony.getawayGameVehicle)
      removeUserUpdateFunction("doRapidShiftPrompt")
    elseif task.specialName == "trigger soft save" then
      Getaway.StopAll()
      progressionSystem.triggerSoftSave({progression = 2})
      if not task.instance.taskObjectsByActorID.Tanner.coreData.agent.controlled then
        localPlayer:zapToAgent(task.instance.taskObjectsByActorID.Tanner.coreData.agent)
      end
    elseif task.specialName == "Zoom to Leila" then
      if task.condition == 1 then
        localPlayer.cameraSupport.zoomLookToAgent({agent = evader})
      end
    elseif task.specialName == "chase tanner" then
      task.instance.taskObjectsByActorID[task.actor.ID].coreData.agent.gameVehicle.performance = 1.25
      if not Chase.IsAChaseActive() or Getaway.IsAGetawayActive() then
        felony_getaway.addEvader(evaderTanner)
      end
      felony_getaway.addChaser(evaderTanner, task.instance.taskObjectsByActorID[task.actor.ID].coreData.agent.gameVehicle)
    elseif task.specialName == "Stop chase" then
      taskObject.coreData.agent.iconsVisible = false
      if task.condition == 2 then
        iCamCrashCam(task.agent.gameVehicle)
      end
    elseif task.specialName == "chase Leila" then
      local params = {
        vehicle = felony_chase.endScreenVehicle,
        driverIsTanner = true,
        cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
        successReason = task.instance.challenge.taskCompleteData["Success reason"],
        failReason = task.instance.challenge.taskCompleteData["Failure reason"],
        hint = "ID:248273",
        hintIcon1 = localPlayer.buttonLayout.minimapZoom
      }
      local function completeTask()
        progressionSystem.challengeComplete(task.instance, task.agent.matrix)
      end
      params.driverIsTanner = false
      params.rating = "PASS"
      params.dialogue = "GPMV00_SUCCESS_L_1"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
  else
    local params = {
      vehicle = vehicleManager.vehiclesByGameVehicle[localPlayer.primaryFelony.getawayGameVehicle],
      driverIsTanner = true,
      cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
      successReason = task.instance.challenge.taskCompleteData["Success reason"],
      failReason = task.instance.challenge.taskCompleteData["Failure reason"],
      hint = "ID:248273",
      hintIcon1 = localPlayer.buttonLayout.minimapZoom
    }
    local function failTask()
      progressionSystem.challengeFailed(task.instance, task.agent.matrix)
    end
    if task.specialName == "chase Leila" then
      params.failReason = "ID:184091"
      params.vehicle = felony_chase.endScreenVehicle
      params.driverIsTanner = false
      if task.condition == 2 then
        params.reason = "Lost getaway"
      else
        params.reason = "Wrecked"
      end
    end
    if task.specialName == "get to decoy" then
      params.dialogue = "GPMV01_FAILURE_L_1"
      params.vehicle = task.agent
      params.reason = "Wrecked"
    else
      if string.find(task.specialName, "get to") then
        params.vehicle = vehicleManager.vehiclesByGameVehicle[localPlayer.primaryFelony.getawayGameVehicle]
        params.dialogue = "GPMV01_FAILURE_L_3"
        if task.condition == 2 then
          params.reason = "Wrecked"
        else
          params.failReason = "ID:245303"
        end
      else
        params.dialogue = "GPMV01_FAILURE_L_2"
      end
      params.hint = "ID:248273"
    end
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Tanner and Jones 7"] = function(instance)
  CameraSystem.ClearScene()
  OneShotSound.Play("HUD_Mis_CameraZoom_Stop")
  instance.firstDamagePlayed = false
  instance.secondDamagePlayed = false
  instance.thirdDamagePlayed = false
  PatrollingVehicleManager.EnableHud(true)
  felony_patrollingVehicleManager.enablePatrollingVehicles(true)
end
