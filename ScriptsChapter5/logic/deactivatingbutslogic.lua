module("cardSystem.logic")
missionSetupData["Deactivating bombs under trucks"] = {}
local countdownTimer = 185
local trailerTimer = 3
local trucksToSpawn = {
  ["Bomb truck 3"] = true,
  ["Bomb truck 4"] = true,
  ["Bomb truck Stationary 1"] = true,
  ["Bomb truck 6"] = true,
  ["Bomb truck 7"] = true,
  ["Bomb truck 8"] = true,
  ["Bomb truck 9"] = true,
  ["Bomb truck 10"] = true,
  ["Bomb truck 11"] = true,
  ["Bomb truck Stationary 2"] = true
}
local trucksInMission = 0
for k, v in next, trucksToSpawn, nil do
  trucksInMission = trucksInMission + 1
end
local function policeTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Follow Route",
        specialName = "get first bomb",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Drive under trailer",
              params = {
                timer = trailerTimer,
                bufferTime = 0.5,
                useTarget = true
              },
              feedback = "Time"
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Drive under trailer",
              params = {useTarget = true}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
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
          {
            style = HUD,
            settings = {
              showDefuseBar = true,
              playDiffuseFailSpeech = true,
              trailerTimer = trailerTimer
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Play PIP01",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
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
        HUD = {
          {style = HUD}
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Play GPMV01_SEQUENCE_L_1",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {value = true}
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 200}
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
        specialName = "Show STAY UNDER prompt",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Current vehicle height is less than",
              params = {value = 1.5}
            },
            {
              goal = "Within radius",
              params = {value = 100, agent = "Player"}
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
        HUD = {
          {style = HUD}
        }
      },
      {
        task = "No AI",
        specialName = "Play PLAN audio",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {value = true}
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 600}
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
        specialName = "Play HERE GOES audio",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Current vehicle height is less than",
              params = {value = 1.5}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Within radius",
              params = {value = 15, agent = "Player"}
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
        specialName = "Vehicle size feedback 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Changed vehicle"
            },
            {
              goal = "Current vehicle height is less than",
              params = {value = 1.5}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Changed vehicle"
            },
            {
              goal = "Current vehicle height is less than",
              params = {value = 1.5, inverse = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "In zap 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Player using zap return",
              params = {inverse = true}
            },
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
        task = "No functionality",
        specialName = "softsave1",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Follow Route",
        specialName = "pip finished",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Event active",
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
        audioPIP = audio
      }
    },
    {
      {
        task = "Follow Route",
        specialName = "police task",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Drive under trailer",
              params = {
                timer = trailerTimer,
                bufferTime = 0.5,
                useTarget = true
              },
              feedback = "Time"
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Completed lap",
              params = {value = 2}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Completed lap",
              params = {value = 4}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Completed lap",
              params = {value = 6}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Completed lap",
              params = {value = 8}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {
                value = trucksInMission - 1
              }
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
              params = {value = countdownTimer}
            }
          }
        },
        targetManagers = {
          {
            manager = "Grouped vehicles",
            settings = {
              zapLevel = 2,
              group = {
                ["Bomb truck 1"] = 4,
                ["Bomb truck 2"] = 4,
                ["Bomb truck 3"] = 3,
                ["Bomb truck 4"] = 3,
                ["Bomb truck Stationary 2"] = 3,
                ["Bomb truck 6"] = 1,
                ["Bomb truck 7"] = 1,
                ["Bomb truck 8"] = 2,
                ["Bomb truck 11"] = 2,
                ["Bomb truck 9"] = 0,
                ["Bomb truck 10"] = 0,
                ["Bomb truck Stationary 1"] = 0
              }
            }
          }
        },
        HUD = {
          {
            style = HUD,
            settings = {
              showTimer = true,
              showCounter = true,
              showDefuseBar = true,
              timerStartTime = countdownTimer,
              trailerTimer = trailerTimer,
              truckQuantity = trucksInMission
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Vehicle time feedback",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {
                value = countdownTimer - 60
              }
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {
                value = countdownTimer - 30
              }
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {
                value = countdownTimer - 10
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Vehicle size feedback 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Changed vehicle"
            },
            {
              goal = "Current vehicle height is less than",
              params = {value = 1.5}
            }
          },
          {
            triggerCount = 2,
            {
              goal = "Changed vehicle"
            },
            {
              goal = "Current vehicle height is less than",
              params = {value = 1.5, inverse = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "In zap 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Player using zap return",
              params = {inverse = true}
            },
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
        specialName = "get going reminder",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = true}
            }
          },
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 10}
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
local function truckTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Give myself a lanetrack",
        taskConditions = {
          {
            {
              goal = "Instant goal complete"
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "truck task",
        taskConditions = {
          {
            {
              goal = "Drive under trailer",
              params = {
                timer = trailerTimer,
                bufferTime = 0.5,
                self = true
              }
            }
          },
          {
            failCondition = true,
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            },
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            {
              goal = "In cutscene or icam"
            },
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        }
      }
    }
  }
  return task
end
local busTask = function(goalParams, HUD, audio)
  local task = {
    {
      {task = "No AI"}
    }
  }
  return task
end
local createBehaviour = function(gameVehicle)
  local behaviour = {
    traits = taskSystem.buildDriveTraits(vehicleManager.vehiclesByGameVehicle[gameVehicle]:getTaskObject().coreData)
  }
  return behaviour
end
local function LaneTrackFollowerRejectionCallback(gameVehicle, reason)
  vehicleManager.vehiclesByGameVehicle[gameVehicle]:stopHighSpeedDriving()
  vehicleManager.vehiclesByGameVehicle[gameVehicle]:highSpeedDrive(createBehaviour(gameVehicle))
end
missionSetupData["Deactivating bombs under trucks"].taskCreatorFunctionLookups = {
  ["police team"] = policeTask,
  ["bomb trucks team"] = truckTask,
  ["bus team"] = busTask
}
missionSetupData["Deactivating bombs under trucks"].initiate = function(instance)
  TrafficSpooler.ExcludeTrailerModel(123)
  Start_Under_Trailer_Camera()
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
  minimap.UnderTrailerArrowsSetModelRadius(123, 150, arrowMarkers)
end
missionSetupData["Deactivating bombs under trucks"].update = nil
local playerDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  else
    local teams = {}
    for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
      teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
      table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
    end
    return teams["bomb trucks team"], false
  end
end
missionSetupData["Deactivating bombs under trucks"].targetList = {
  ["police team"] = playerDynamicTargets
}
local getEndDialogue = function(task)
  local dialogue = "GPMV01_FAILURE_L_1"
  if not task.instance.taskObjectsByActorID["Bomb truck 1"] or not task.instance.taskObjectsByActorID["Bomb truck 2"] then
    local trucksLeft = 0
    for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team == "bomb trucks team" then
        trucksLeft = trucksLeft + 1
      end
    end
    if trucksLeft <= 1 then
      dialogue = "GPMV00_FAILURE_L_1"
    else
      dialogue = "GPMV00_FAILURE_L_2"
    end
  end
  return dialogue
end
local target
local function getClosestTruck(taskObject, includeDefused)
  local workingVector = vec.vector()
  local distance = 0
  local smallestDistance = math.huge
  local playerPosition
  if localPlayer.inZap then
    playerPosition = game_camera.matrix[3]
  else
    playerPosition = localPlayer.currentVehicle.position
  end
  if includeDefused then
    for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team == "bomb trucks team" then
        distance = workingVector:sub(playerPosition, taskObject.coreData.agent.position):length()
        if smallestDistance > distance then
          target = actorID
          smallestDistance = distance
        end
      end
    end
  else
    for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team == "bomb trucks team" and not taskObject.coreData.defused then
        distance = workingVector:sub(playerPosition, taskObject.coreData.agent.position):length()
        if smallestDistance > distance then
          target = actorID
          smallestDistance = distance
        end
      end
    end
  end
  return taskObject.coreData.instance.taskObjectsByActorID[target].coreData.agent, target
end
taskCompleteData["Deactivating bombs under trucks"] = {}
taskCompleteData["Deactivating bombs under trucks"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = taskObject.coreData.agent,
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:236262",
    dialogue = "GPMV01_FAILURE_L_1",
    rating = "PASS"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.success then
    if task.specialName == "Give myself a lanetrack" then
      GameVehicleResource.setBombVisible(taskObject.coreData.agent.gameVehicle, "Child", true)
      GameVehicleResource.setAttachedBombState(taskObject.coreData.agent.gameVehicle, "Child", true, "Truck_Bomb_Timer_Tick")
      if not string.find(taskObject.coreData.actor.ID, "Stationary") then
        civilianTraffic.AddScriptLaneTrackInterloper(taskObject.coreData.agent.gameVehicle, LaneTrackFollowerRejectionCallback)
      end
    elseif task.specialName == "softsave1" then
      for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == "bomb trucks team" then
          GameVehicleResource.setAttachedBombState(taskObject.coreData.agent.gameVehicle, "Child", false, "Truck_Bomb_Timer_Tick_Stop")
          civilianTraffic.RemoveScriptLaneTrackInterloper(taskObject.coreData.agent.gameVehicle)
          taskObject.coreData.agent:setDebugRequiredVehicles(false)
          minimap.UnderTrailerArrowsExcludeGameVehicle(taskObject.coreData.agent.gameVehicle)
          taskObject:delete()
        end
      end
      progressionSystem.triggerSoftSave({progression = 1})
      challengeSystem.spawnActors(task.instance, "Never", trucksToSpawn)
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Stationary Bus 1"] = true,
        ["Stationary Bus 2"] = true
      })
      feedbackSystem.menusMaster.blockHintButton(true)
      localPlayer:blockAbility("zap", true)
    elseif task.specialName == "get first bomb" then
      localPlayer:blockAbility("zap", true)
      if not taskObject.coreData.agent.controlled then
        localPlayer:zapToAgent(task.instance.taskObjectsByActorID.Supercop.coreData.agent)
      end
    elseif task.specialName == "pip finished" then
      localPlayer:blockAbility("zap", false)
      localPlayer:blockAbility("zapReturn", true)
      localPlayer:buildZapReturn()
      feedbackSystem.menusMaster.setCurrentFocusString(3)
      feedbackSystem.menusMaster.blockHintButton(false)
    elseif task.specialName == "get going reminder" then
      if task.condition == 1 then
        feedbackSystem.menusMaster.setCurrentFocusString(4)
      end
    elseif task.specialName == "police task" then
      local function endMission()
        params.dialogue = "GPMV00_SUCCESS_L_1"
        params.rating = "PASS"
        params.callback = completeTask
        localPlayer.challenge.endScreen(taskObject, params)
      end
      local iCamParams = {
        duration = 3.5,
        speed = 0.25,
        framing = "wide",
        angleYaw = "profile",
        callbackFunction = endMission,
        hudParams = {prompts = true}
      }
      target = taskObject.coreData.actor.ID
      local closestTruckAgent, closestTruckActorID = getClosestTruck(taskObject, true)
      if localPlayer.currentVehicle then
        params.driverIsTanner = true
        params.vehicle = localPlayer.currentVehicle
      elseif closestTruckAgent then
        params.vehicle = closestTruckAgent
      end
      feedbackSystem.stopMusic("Uid07502_CH07_Standard_TickingClock_Stop")
      iCamParams.cameraTargets = {
        params.vehicle.gameVehicle
      }
      feedbackSystem.updateBarFeedback({barHide = true})
      Stop_Under_Trailer_Camera()
      if closestTruckActorID and not string.find(closestTruckActorID, "Stationary") then
        iCamActivationTableInput(iCamParams)
      else
        endMission()
      end
    elseif task.specialName == "truck task" and task.condition == 1 then
      GameVehicleResource.setAttachedBombState(taskObject.coreData.agent.gameVehicle, "Child", false, "Truck_Bomb_Timer_Tick_Stop")
      OneShotSound.Play("HUD_Gen_Positive")
      minimap.UnderTrailerArrowsExcludeGameVehicle(taskObject.coreData.agent.gameVehicle)
      taskObject.coreData.defused = true
      taskObject.coreData.agent.iconsVisible = false
      taskObject.coreData.agent:setDebugRequiredVehicles(true)
    end
  elseif not task.instance.missionHasBeenFailed then
    task.instance.missionHasBeenFailed = true
    local function endMission()
      params.rating = "FAIL"
      params.callback = failTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
    if task.specialName ~= "truck task" and task.condition == 2 then
      params.driverIsTanner = true
      params.failReason = "ID:214895"
      feedbackSystem.updateBarFeedback({barHide = true})
      Stop_Under_Trailer_Camera()
      endMission()
    else
      local iCamParams = {
        duration = 5,
        speed = 0.4,
        framing = "verywide",
        angleYaw = "profile",
        anglePitch = "mid",
        callbackFunction = endMission,
        disableCallbackOnFail = true
      }
      params.dialogue = getEndDialogue(task)
      if task.specialName ~= "truck task" and task.condition == 3 then
        target = taskObject.coreData.actor.ID
        params.vehicle = getClosestTruck(taskObject)
      end
      iCamParams.cameraTargets = {
        params.vehicle.gameVehicle.towedVehicle
      }
      minimap.UnderTrailerArrowsExcludeGameVehicle(params.vehicle.gameVehicle)
      params.vehicle:setDebugRequiredVehicles(true)
      feedbackSystem.updateBarFeedback({barHide = true})
      if not localPlayer.inZap and iCamActivationTableInput(iCamParams) then
        localPlayer.simulationSupport.doWait(0.2, function()
          GameVehicleResource.explode({
            gameVehicle = params.vehicle.gameVehicle,
            attachedVehicle = "Child",
            offset = vec.vector(1, 0, 0, 1),
            range = 1,
            strength = 10
          })
          GameVehicleResource.applyDamage({
            gameVehicle = params.vehicle.gameVehicle,
            damage = 1,
            overridePlayerOnlyDamage = true
          })
          GameVehicleResource.applyDamage({
            gameVehicle = params.vehicle.gameVehicle.towedVehicle,
            damage = 1,
            overridePlayerOnlyDamage = true
          })
        end, "explode")
      else
        GameVehicleResource.explode({
          gameVehicle = params.vehicle.gameVehicle,
          attachedVehicle = "Child",
          offset = vec.vector(1, 0, 0, 1),
          range = 1,
          strength = 10
        })
        GameVehicleResource.applyDamage({
          gameVehicle = params.vehicle.gameVehicle,
          damage = 1,
          overridePlayerOnlyDamage = true
        })
        GameVehicleResource.applyDamage({
          gameVehicle = params.vehicle.gameVehicle.towedVehicle,
          damage = 1,
          overridePlayerOnlyDamage = true
        })
        endMission()
      end
    end
  end
end
missionEndCallback["Deactivating bombs under trucks"] = function(instance)
  Stop_Under_Trailer_Camera()
  feedbackSystem.stopMusic("Uid07502_CH07_Standard_TickingClock_Stop")
  TrafficSpooler.ClearExcludedTrailerModelList()
  localPlayer:blockAbility("zapReturn", false)
  localPlayer:buildZapReturn()
  localPlayer:blockAbility("zap", false)
  if userUpdateFunctions.explode then
    removeUserUpdateFunction("explode")
  end
  feedbackSystem.menusMaster.blockHintButton(false)
  minimap.UnderTrailerArrowsSetModelRadius()
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.team == "bomb trucks team" then
      GameVehicleResource.setAttachedBombState(taskObject.coreData.agent.gameVehicle, "Child", false, "Truck_Bomb_Timer_Tick_Stop")
      GameVehicleResource.setBombVisible(taskObject.coreData.agent.gameVehicle, "Child", false)
      civilianTraffic.RemoveScriptLaneTrackInterloper(taskObject.coreData.agent.gameVehicle)
      taskObject.coreData.agent:setDebugRequiredVehicles(false)
      minimap.UnderTrailerArrowsExcludeGameVehicle(taskObject.coreData.agent.gameVehicle)
      taskObject:delete(true)
    end
  end
end
