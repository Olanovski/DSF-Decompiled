local offsetHolder = vec.vector(5, 0, 0, 1)
module("cardSystem.logic")
local groundAttackTime = 10
local largeVehicles = {
  201,
  197,
  291,
  185,
  152,
  170,
  138
}
local numberToReturn = 1
local splitHighWayPosition = vec.vector(3216.977, 19.88626, 683.033, 1)
local vehicleSearchParameters = {
  ignoreSciptOwnedVehicles = true,
  ignoreOrphans = true,
  ignoreThrown = true,
  ignoreCops = true,
  avoidModelID = largeVehicles,
  scoring = {
    ahead = {condition = true, discard = true},
    sameDirection = {condition = false, discard = false},
    proximity = true
  }
}
local workingVector = vec.vector()
missionSetupData["Avoid the cars"] = {}
local tannerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "The chase",
        goalConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Jericho Actor"
                }
              }
            },
            {
              goal = "Within radius of specified actor",
              params = {
                actorID = "Jericho Actor",
                value = 150,
                inverse = true
              }
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Jericho Actor"
                },
                inverse = true
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
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Jericho Actor"
                }
              }
            },
            {
              goal = "Within radius of specified actor",
              params = {
                actorID = "Jericho Actor",
                value = 150,
                inverse = true
              }
            },
            {
              goal = "Losing getaway time trigger",
              params = {value = 10, prompt = "ID:236625"}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Soft save 01",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 50}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Mission speech triggers",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 21}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 80}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 100}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 142}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 160}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "Linear Checkpoints",
        dynamicTargets = true,
        specialName = "Change variables",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within strip of road",
              params = {value = 20}
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
      },
      {
        task = "No AI",
        specialName = "Kill the ground attacks",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 60}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "In tanner",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Tanner health",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Damage has changed by",
              params = {value = 0.01}
            },
            {
              goal = "Damage above",
              params = {value = 0.4}
            },
            {
              goal = "Damage below",
              params = {value = 0.6}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            {
              goal = "Damage has changed by",
              params = {value = 0.01}
            },
            {
              goal = "Damage above",
              params = {value = 0.6}
            },
            {
              goal = "Damage below",
              params = {value = 0.8}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            {
              goal = "Damage has changed by",
              params = {value = 0.01}
            },
            {
              goal = "Damage above",
              params = {value = 0.8}
            },
            {
              goal = "Damage below",
              params = {value = 1}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Ram jericho",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 2}
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Jericho Actor"
                }
              }
            },
            {
              goal = "Simple collision check",
              params = {
                hitActor = "Jericho Actor",
                force = 4000,
                setOnPlayer = true
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Button press",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 2,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Button Press",
              params = {watchFor = "Pressed", button = "Zap_In"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Mission ending properly",
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
        }
      }
    }
  }
  return task
end
local jerichoTask = function(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    deleteVehicleOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "Jericho chase end",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 80}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Start the ZapAIPresence effect on jericho",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 120}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      },
      {
        task = "Follow Route",
        specialName = "Jericho task",
        groupProgression = {importantMinorOrder = false}
      }
    }
  }
  return task
end
local civTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Linear Chase",
        specialName = "civ attack tanner",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Agent within then outside radius of target",
              params = {value = 60}
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
            {
              goal = "Time trigger",
              params = {value = 10}
            }
          },
          {
            {
              goal = "Simple collision check",
              params = {
                hitActor = "Tanner Actor",
                force = 5000
              }
            }
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Avoid the cars"].taskCreatorFunctionLookups = {
  ["Tanner team"] = tannerTask,
  ["Jericho team"] = jerichoTask,
  ["Civ team"] = civTask
}
local timer = 0
local chuckTime = 2
local slowCounter = 0
local slowMode = 0
local function slowDownUpdate(duration, target)
  if target < 1 then
    slowCounter = slowCounter + 1
    localPlayer.currentVehicle.gameVehicle.performance = 1.25
  else
    localPlayer.currentVehicle.gameVehicle.performance = 1
  end
  local startSimulationSpeed = simulation.getSpeed()
  local simulationSpeed = startSimulationSpeed
  local stepsToTake = duration * updates.stepRate
  local stepsTaken = 0
  local speedUpStepsToTake = 0.5 * updates.stepRate
  local speedUpStepsTaken = 0
  return function()
    stepsTaken = stepsTaken + 1
    if stepsTaken < stepsToTake then
      simulationSpeed = lerp_value(startSimulationSpeed, target, stepsTaken / stepsToTake)
      simulation.setSpeed(simulationSpeed)
    else
      speedUpStepsTaken = speedUpStepsTaken + 1
      simulationSpeedUp = lerp_value(simulationSpeed, 1, speedUpStepsTaken / speedUpStepsToTake)
      simulation.setSpeed(simulationSpeedUp)
      if 1 <= simulationSpeedUp then
        removeUserUpdateFunction("slowDownUpdate")
        slowMode = 0
      end
    end
  end
end
local function slowDownHandOver(duration, target)
  addUserUpdateFunction("slowDownUpdate", slowDownUpdate(duration, target), 1)
end
local tunnelPosition = vec.vector(3051.602, 19.90278, 931.1401, 1)
local softSave = vec.vector(3247.648, 19.92532, 701.651, 1)
local jerichoRouteEndPoint = vec.vector(581.3953, 24.5, -2593.25, 1)
local audioPrompt = false
local highLODVehicle = {}
local counter = 0
local slowAmount = 0.4
local currentSpeed = 1
local attack = false
local cars = true
local timeDelay
local speedUp = true
local offset = vec.vector(10, 0, 0, 1)
local isFirstCarThrown = false
local earlyStage = true
local midStage = false
local endStage = false
local civAttack = function(gameVehicle, instance)
  local playSound = false
  local soundPos
  if gameVehicle and not instance.taskObjectsByActorID.Civ then
    if not SNV.getSNVFromGameVehicle(gameVehicle) then
      SNV.CreateSNVFromGV(gameVehicle)
    end
    local civAgent = vehicleManager.registerVehicle({gameVehicle = gameVehicle})
    local actor = instance.challenge.actorPool.Civ
    challengeSystem.createActor(instance, civAgent, actor)
    SNV.setFlashColour(instance.taskObjectsByActorID.Civ.coreData.agent.SNVID, vec.vector(1, 0, 0, 1))
    ZapAIPresence.Settings({
      Radius = 1,
      TransitionInTime = 1,
      Color = vec.vector(40, 40, 40, 1)
    })
    ZapAIPresence.StartTransition(nil, instance.taskObjectsByActorID.Civ.coreData.agent.gameVehicle)
    playSound = true
    soundPos = instance.taskObjectsByActorID.Civ.coreData.agent.position
  elseif not instance.taskObjectsByActorID.Civ then
    challengeSystem.spawnActors(instance, "Never", {Civ = true})
    SNV.setFlashColour(instance.taskObjectsByActorID.Civ.coreData.agent.SNVID, vec.vector(1, 0, 0, 1))
    ZapAIPresence.Settings({
      Radius = 1,
      TransitionInTime = 1,
      Color = vec.vector(40, 40, 40, 1)
    })
    ZapAIPresence.StartTransition(nil, instance.taskObjectsByActorID.Civ.coreData.agent.gameVehicle)
    playSound = true
    soundPos = instance.taskObjectsByActorID.Civ.coreData.agent.position
  end
  if playSound == true and soundPos ~= nil then
    vec.vector(1, 0, 0, 0)
    local velocity, direction = vec.vector(0, 0, 0, 0), vec.vector(0, 0, 0, 0)
    OneShotSound.PlayAtPosition("Jericho_Shift_OneShot", soundPos, velocity, direction, false)
  end
end
missionSetupData["Avoid the cars"].initiate = function(instance)
  slowCounter = 0
  timeDelay = g_NetworkTime
  ZapAIPresence.Settings({
    Height = 50,
    Radius = 1,
    TransitionInTime = 1,
    Color = vec.vector(40, 40, 40, 1)
  })
  feedbackSystem.menusMaster.setFocusButtonText()
  createCheckpoints(instance)
  createFixedPosition(instance, {softSave}, 101)
  createFixedPosition(instance, {jerichoRouteEndPoint}, 102)
  createFixedPosition(instance, {tunnelPosition}, 103)
  scoreSystem.maxAbility(localPlayer.localID)
  local tanner = instance.taskObjectsByActorID["Tanner Actor"]
  local jericho = instance.taskObjectsByActorID["Jericho Actor"]
  timer = g_NetworkTime
  GameVehicleResource.setInfiniteMass(jericho.coreData.agent.gameVehicle, true)
  local function delayedCarThrowAudio()
    if not isFirstCarThrown then
      Commentary.StopCommentary()
      if not isEventActive() then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_2")
      end
      isFirstCarThrown = true
    elseif not isEventActive() then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_3")
    end
    removeUserUpdateFunction("throwAudio")
  end
  local function _trafficSearch()
    local vehicleList = {}
    local gameVehicle, playerPosition, playerHeading, position, roadIndex, distanceAlong, positionOnRoad
    return function(offset)
      playerPosition = tanner.coreData.agent.position
      playerHeading = tanner.coreData.agent.heading
      position = playerPosition:clone()
      if offset then
        position.x = playerPosition.x + offset.x * math.cos(playerHeading) + offset.z * math.sin(playerHeading)
        position.z = playerPosition.z + offset.z * math.cos(playerHeading) - offset.x * math.sin(playerHeading)
      end
      roadIndex, distanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(position)
      positionOnRoad = Atlas.RoadPositionAtDistanceAlong(roadIndex, distanceAlong)
      return positionOnRoad
    end
  end
  local trafficSearch = _trafficSearch()
  local function _throwCars()
    local offsetInFront = vec.vector(0, 0, 200, 0)
    local workingVector = vec.vector()
    local vehicleList = {}
    return function()
      if cars and jericho and tanner and not instance.taskObjectsByActorID.Civ and g_NetworkTime - timeDelay > groundAttackTime then
        groundAttackTime = 2
        if localPlayer.currentVehicle:get_withTrafficFlow() then
          workingVector = trafficSearch(offsetInFront)
        else
          workingVector = trafficSearch()
        end
        vehicleList = {}
        vehicleList = vehicleManager.findVehiclesInTraffic(workingVector, tanner.coreData.agent.matrix[2], 100, vehicleSearchParameters, numberToReturn)
        if vehicleList[1] then
          civAttack(vehicleList[1], instance)
        else
          civAttack(nil, instance)
        end
      end
      if attack then
        local tannerToJerichoDistance = false
        if tanner and jericho then
          tannerToJerichoDistance = GameVehicleResource.withinRadius(tanner.coreData.agent.position, jericho.coreData.agent.position, 150)
        end
        if tannerToJerichoDistance and g_NetworkTime - timer > chuckTime and tanner.coreData.agent.gameVehicle.speedAlongHeading > 10 and tanner.coreData.agent:get_withTrafficFlow() then
          workingVector = trafficSearch()
          vehicleList = {}
          vehicleList = vehicleManager.findVehiclesInTraffic(workingVector, tanner.coreData.agent.matrix[2], 100, vehicleSearchParameters, numberToReturn)
          if vehicleList[1] then
            ZapAIPresence.Settings({
              Radius = 0.5,
              TransitionInTime = 0.2,
              Color = vec.vector(40, 40, 40, 1),
              AttachedToVehicle = false
            })
            ZapAIPresence.StartTransition(nil, vehicleList[1])
            if math.random(100) > 50 then
              if earlyStage then
                chuckTime = 1.5
              elseif midStage then
                chuckTime = 1
              elseif endStage then
                chuckTime = 0.5
              end
            elseif tanner.coreData.agent.damage > 0.8 then
              if earlyStage then
                chuckTime = 2
              elseif midStage then
                chuckTime = 1.25
              elseif endStage then
                chuckTime = 1
              end
            elseif earlyStage then
              chuckTime = 1
            elseif midStage then
              chuckTime = 0.75
            elseif endStage then
              chuckTime = 0.5
            end
            local isLargeVehicle = false
            for i = 1, #largeVehicles do
              if vehicleList[1].model_id == largeVehicles[i] then
                isLargeVehicle = true
              end
            end
            if localPlayer.currentVehicle == tanner.coreData.agent then
              if isLargeVehicle then
                highLODVehicle[vehicleList[1]] = {}
                highLODVehicle[vehicleList[1]].distance = workingVector:sub(vehicleList[1].position, tanner.coreData.agent.position):length()
                highLODVehicle[vehicleList[1]].timer = g_NetworkTime
                if vehicleList[1].model_id == 291 then
                  highLODVehicle[vehicleList[1]].exploded = false
                end
                local rand = math.random(20)
                if rand > 5 then
                  offset = offsetHolder
                else
                  offset = -offsetHolder
                  offset[3] = 1
                end
              else
                local rand = math.random(20)
                offset = vec.vector(1, 0, 0, 1) * ((rand - 5) / 2)
              end
            else
              highLODVehicle = {}
            end
            if audioPrompt and localPlayer.currentVehicle == tanner.coreData.agent then
              audioPrompt = false
              highLODVehicle[vehicleList[1]] = {}
              highLODVehicle[vehicleList[1]].distance = workingVector:sub(vehicleList[1].position, tanner.coreData.agent.position):length()
              highLODVehicle[vehicleList[1]].timer = g_NetworkTime
              addUserUpdateFunction("throwAudio", delayedCarThrowAudio, 100, true)
            end
            local randX = (math.random(150) - 100) / 100
            GameVehicleResource.setFlashColour(vehicleList[1], vec.vector(1, 0, 0, 1))
            if not isFirstCarThrown then
              randX = 0
            end
            VehicleLauncher.VehicleToVehicle(vehicleList[1], tanner.coreData.agent.gameVehicle, vec.vector(randX, 0, 1, 1), offset)
            counter = counter + 1
            if counter >= 5 then
              addUserUpdateFunction("throwAudio", delayedCarThrowAudio, 100, true)
              counter = 0
            end
            timer = g_NetworkTime
          end
        end
        local vehicles = 0
        for k, v in next, highLODVehicle, nil do
          local removed = false
          if g_NetworkTime - v.timer > 3 then
            highLODVehicle[k] = nil
            removed = true
            break
          end
          if not removed and tanner then
            local distance = workingVector:sub(k.position, tanner.coreData.agent.position):length()
            if v.exploded == false and distance < 30 and not v.exploded then
              v.exploded = true
              GameVehicleResource.explode({
                gameVehicle = k,
                offset = vec.vector(1, 0, 0, 1),
                range = 0,
                strength = 5
              })
            elseif distance - 0.01 > v.distance then
              highLODVehicle[k] = nil
            else
              vehicles = vehicles + 1
              highLODVehicle[k].distance = distance
            end
          end
        end
        if slowCounter <= 2 then
          if vehicles > 0 and slowMode == 0 and currentSpeed ~= slowAmount then
            slowMode = 1
          elseif vehicles == 0 and slowMode == 0 and currentSpeed ~= 1 and speedUp then
            slowMode = 2
          end
          if slowMode == 1 and currentSpeed ~= slowAmount then
            currentSpeed = slowAmount
            slowDownHandOver(3, slowAmount)
          elseif slowMode == 2 and currentSpeed ~= 1 then
            currentSpeed = 1
            slowDownHandOver(0.6, 1)
          end
        elseif currentSpeed ~= 1 then
          currentSpeed = 1
          slowDownHandOver(0.6, 1)
        end
      end
    end
  end
  throwCars = _throwCars()
  jericho.coreData.agent.gameVehicle.performance = 1.25
  addUserUpdateFunction("throw", throwCars, 60, true)
  ZapAIPresence.StartTransition(nil, jericho.coreData.agent.gameVehicle)
  tanner.coreData.agent.gameVehicle.speed = 30
  localPlayer:blockAbility("zap", true)
  Sfx.SetJerichoCityLightning(true)
  local softSaveData = progressionSystem.getSoftSaveData()
  if not softSaveData then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:170893", nil, true, false, false)
  else
    RaceManager.SetStartCheckpointIndex(instance.raceId, RaceManager.GetStartCheckpointIndex(instance.raceId))
    cars = false
    earlyStage = true
    midStage = false
    endStage = false
  end
  InterestingVehicleManager.Enable(false)
  local playMusic = function()
    feedbackSystem.startMusic("Uid04869_CH08_Standard_Showdown_Play")
  end
  Sound.LoadMission(cards.Missions[instance.challenge.name].MissionID, playMusic)
  GameVehicleResource.ClearAreaOfVehicles(tanner.coreData.agent.position, 50)
end
missionSetupData["Avoid the cars"].update = nil
local function getChaseTeamDynamicTargets(taskObject, task, dynamicListID)
  if task.specialName == "Soft save 01" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 101), false
    end
  elseif task.specialName == "Kill the ground attacks" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 103), false
    end
  elseif task.specialName == "Change variables" then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
      if task.networkVars.checkpoints == 2 then
        vehicleSearchParameters.avoidModelID = nil
        VehicleLauncher.Settings({
          LaunchAngle = 80,
          LaunchVelocity = 20,
          SecondImpulseTime = 0.3,
          TravelTime = 1.2
        })
        vehicleSearchParameters.idealDistance = 60
      elseif task.networkVars.checkpoints == 3 then
        attack = false
      elseif task.networkVars.checkpoints == 4 then
        attack = true
        VehicleLauncher.Settings({
          LaunchAngle = 80,
          LaunchVelocity = 20,
          SecondImpulseTime = 0.5,
          TravelTime = 1.4
        })
        vehicleSearchParameters.idealDistance = 65
      elseif task.networkVars.checkpoints == 5 then
        earlyStage = false
        midStage = true
        VehicleLauncher.Settings({
          LaunchAngle = 75,
          LaunchVelocity = 20,
          SecondImpulseTime = 0.5,
          TravelTime = 1.4
        })
        vehicleSearchParameters.idealDistance = 80
      elseif task.networkVars.checkpoints == 6 then
        attack = false
      elseif task.networkVars.checkpoints == 7 then
        attack = true
        midStage = false
        endStage = true
        vehicleSearchParameters.avoidModelID = largeVehicles
        VehicleLauncher.Settings({
          LaunchAngle = 75,
          LaunchVelocity = 22,
          SecondImpulseTime = 0.75,
          TravelTime = 1.4
        })
        vehicleSearchParameters.idealDistance = 70
      elseif task.networkVars.checkpoints == 8 then
        slowAmount = 0.8
        currentSpeed = 0.8
        slowMode = 3
        speedUp = false
      elseif task.networkVars.checkpoints == 9 then
        attack = true
        VehicleLauncher.Settings({
          LaunchAngle = 80,
          LaunchVelocity = 24,
          SecondImpulseTime = 0.5,
          TravelTime = 1.2
        })
        vehicleSearchParameters.idealDistance = 95
      elseif task.networkVars.checkpoints == 10 then
        vehicleSearchParameters.avoidModelID = nil
        VehicleLauncher.Settings({
          LaunchAngle = 85,
          LaunchVelocity = 26,
          SecondImpulseTime = 0.5,
          TravelTime = 1.2
        })
        vehicleSearchParameters.idealDistance = 80
      elseif task.networkVars.checkpoints == 11 then
        attack = false
      elseif task.networkVars.checkpoints == 12 then
        attack = true
      elseif task.networkVars.checkpoints == 13 then
        removeUserUpdateFunction("throw")
      end
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
end
local getJerichoTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Jericho chase end" or task.specialName == "Start the ZapAIPresence effect on jericho" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 102), false
    end
  end
end
local getCivDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID["Tanner Actor"].coreData.agent
    }, false
  end
end
missionSetupData["Avoid the cars"].targetList = {
  ["Tanner team"] = getChaseTeamDynamicTargets,
  ["Jericho team"] = getJerichoTargets,
  ["Civ team"] = getCivDynamicTargets
}
local jerichoSlowedDown = false
missionSetupData["Avoid the cars"].goalComplete = nil
taskCompleteData["Avoid the cars"] = {}
taskCompleteData["Avoid the cars"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID["Tanner Actor"].coreData.agent,
    successReason = "ID:184949",
    failReason = "ID:184950",
    passCondition = "ID:184917",
    perfectCondition = "ID:184918"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.specialName == "Soft save 01" then
    progressionSystem.triggerSoftSave({progression = 1})
    task.instance.taskObjectsByActorID["Tanner Actor"].coreData.agent.throwing = true
    attack = true
    audioPrompt = true
    VehicleLauncher.Settings({
      LaunchAngle = 80,
      LaunchVelocity = 18,
      SecondImpulseTime = 0.3,
      TravelTime = 1.2
    })
    vehicleSearchParameters.scoring.sameDirection.condition = true
    vehicleSearchParameters.scoring.sameDirection.discard = true
    VehicleLauncher.DeleteAll()
    offset = vec.vector(0, 0, 0, 1)
    vehicleSearchParameters.idealDistance = 50
  elseif task.specialName == "Kill the ground attacks" then
    cars = false
  elseif task.specialName == "Start the ZapAIPresence effect on jericho" then
    removeUserUpdateFunction("throw")
    ZapAIPresence.Settings({
      Radius = 1,
      TransitionInTime = 3,
      Color = vec.vector(40, 40, 40, 1)
    })
    ZapAIPresence.StartTransition(nil, task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle)
  elseif task.specialName == "Jericho chase end" then
    Sfx.SetJerichoCityLightning(false)
    OneShotSound.Play("Jericho_Disappear_OneShot")
  elseif task.specialName == "The chase" and not task.success then
    removeUserUpdateFunction("throw")
    params.rating = "FAIL"
    params.driverIsTanner = true
    params.callback = failTask
    params.dialogue = "GPMV01_FAILURE_L_1"
    if 1 <= task.agent.damage then
      params.failReason = "ID:184961"
      params.hint = "ID:235491"
    else
      params.hint = "ID:235491"
      params.failReason = "ID:231140"
    end
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "Mission ending properly" then
    params.rating = "PASS"
    params.callback = completeTask
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "civ attack tanner" then
    if task.condition == 3 then
      timeDelay = g_NetworkTime
    end
    SNV.resetFlashColour(task.instance.taskObjectsByActorID.Civ.coreData.agent.SNVID)
  elseif task.specialName == "tanker" then
    task.agent:lockEmergencyBrakes(1)
  end
end
missionEndCallback["Avoid the cars"] = function(instance)
  removeUserUpdateFunction("throw")
  VehicleLauncher.DeleteAll()
  removeUserUpdateFunction("slowDownUpdate")
  simulation.setSpeed(1)
  audioPrompt = true
  counter = 0
  slowAmount = 0.4
  slowDownHandOver(0.6, 1)
  speedUp = true
  offset = vec.vector(0, 0, 3, 1)
  attack = false
  cars = true
  isFirstCarThrown = false
  groundAttackTime = 10
  earlyStage = true
  midStage = false
  endStage = false
  vehicleSearchParameters.avoidModelID = largeVehicles
  vehicleSearchParameters.idealDistance = nil
  vehicleSearchParameters.scoring.sameDirection.condition = false
  vehicleSearchParameters.scoring.sameDirection.discard = false
  feedbackSystem.stopMusic("Uid04869_CH08_Standard_Showdown_Stop")
  localPlayer:blockAbility("zap", false)
  Sfx.SetJerichoCityLightning(false)
  InterestingVehicleManager.Enable(true)
end
