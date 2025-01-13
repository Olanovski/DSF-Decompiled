module("cardSystem.logic")
local vehicleSearchParameters = {
  ignoreSciptOwnedVehicles = true,
  ignoreCops = true,
  ignoreThrown = true,
  idealDistance = 70,
  scoring = {
    ahead = {condition = true, discard = true},
    sameDirection = {condition = true, discard = true}
  }
}
missionSetupData["Anything you can do"] = {}
local TannerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Linear Checkpoints",
        specialName = "Chase",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
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
            forceTaskComplete = true,
            failCondition = true,
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
          },
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
              goal = "All team members damage above",
              params = {
                team = "Jericho team",
                value = 1
              }
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
            style = "Anything you can do HUD"
          }
        },
        audioPIP = audio
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
              params = {value = 2}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Trigger the car throwing",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 5}
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
        task = "No AI",
        specialName = "Tanner health",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
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
            triggerCount = 1,
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
            triggerCount = 1,
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
              params = {value = 2}
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
              params = {value = 2}
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
              params = {value = 2}
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
              params = {value = 2}
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
            triggerCount = 3,
            {
              goal = "Time trigger",
              params = {value = 5}
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
                force = 5000
              }
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
        specialName = "Respawn jericho",
        goalConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Jericho Actor"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Initial zap",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = true}
            }
          }
        },
        HUD = {
          {
            style = "Anything you can do HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "In zap",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 20}
            },
            {
              goal = "Player in zap",
              params = {value = true}
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
        specialName = "Initial civ speech",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
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
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "idle",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 2,
            {
              goal = "Below speed",
              params = {value = 2}
            },
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Not End Mission",
        taskConditions = {
          {
            {
              goal = "Player using zap return",
              params = {inverse = true}
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Shift back to tanner and trigger end speech",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "End Mission",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
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
        }
      }
    }
  }
  return task
end
local JerichoTask = function(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    {
      {
        task = "Follow Route",
        specialName = "Checkpoints"
      },
      {
        task = "No AI",
        specialName = "Jericho health",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Damage has changed by",
              params = {value = 0.01}
            },
            {
              goal = "Damage above",
              params = {value = 0.25}
            },
            {
              goal = "Damage below",
              params = {value = 0.5}
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
              params = {value = 0.5}
            },
            {
              goal = "Damage below",
              params = {value = 0.75}
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
              params = {value = 0.75}
            },
            {
              goal = "Damage below",
              params = {value = 1}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            {
              goal = "Damage above",
              params = {value = 0.5}
            }
          }
        },
        HUD = {
          {
            style = "Anything you can do HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Jericho delete to respawn",
        taskConditions = {
          {
            {
              goal = "Damage below",
              params = {value = 1}
            },
            {
              goal = "Actor in front of vehicle along route",
              params = {
                actor = "Tanner Actor",
                position = 1
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            {
              goal = "Damage below",
              params = {value = 1}
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
              goal = "Agent in oncoming traffic"
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Damage below",
              params = {value = 1}
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Simple collision check",
              params = {
                hitActor = "Tanner Actor",
                force = 5000
              }
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Fake rubberband",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius of specified actor",
              params = {
                value = 150,
                actorID = "Tanner Actor",
                inverse = true
              }
            }
          },
          {
            {
              goal = "Within radius of specified actor",
              params = {
                value = 90,
                actorID = "Tanner Actor"
              }
            }
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Anything you can do"].taskCreatorFunctionLookups = {
  ["Tanner team"] = TannerTask,
  ["Jericho team"] = JerichoTask
}
local timer = 0
local damage = 0
local chuckTime = 2
local jerichoThrow = false
local canThrow = false
local vehiclesLaunched = 0
local throwNumber = 3
local numberThrown = 0
local showIcam = false
local thrownCars = 0
local playedPIP1 = false
local thrownVehicles = {}
local recievedVehicles = {}
local zapTransitionFinished = true
local function jerichoZapTransitionEnd()
  if not zapTransitionFinished then
    zapTransitionFinished = "Reset"
  end
end
local function jerichoCallbackFunction(gameVehicle)
  recievedVehicles[gameVehicle] = nil
end
local jerichoDamage
local jerichoLaunchAngle = 80
local jerichoLaunchVelocity = 24
local jerichoImpulseTime = 0.5
local jerichoLauncherTravelTime = 1
local initalZapSlowMo
local earlyStage = true
local midStage = false
local endStage = false
missionSetupData["Anything you can do"].initiate = function(instance)
  damage = 0
  initalZapSlowMo = zapcontroller.getZapSlowMotionMultiplier()
  chuckTime = 2
  jerichoThrow = false
  canThrow = false
  vehiclesLaunched = 0
  throwNumber = 3
  numberThrown = 0
  thrownCars = 0
  thrownVehicles = {}
  recievedVehicles = {}
  zapTransitionFinished = true
  createCheckpoints(instance)
  localPlayer:blockAbility("zap", true)
  timer = g_NetworkTime
  local function throwCars()
    if canThrow and g_NetworkTime - timer > chuckTime and instance.taskObjectsByActorID["Jericho Actor"] and instance.taskObjectsByActorID["Tanner Actor"].coreData.agent.speed > 15 and not localPlayer.inCutscene then
      local vehicleList = vehicleManager.findVehiclesInTraffic(instance.taskObjectsByActorID["Tanner Actor"].coreData.agent.gameVehicle.position, instance.taskObjectsByActorID["Tanner Actor"].coreData.agent.matrix[2], 100, vehicleSearchParameters, 1)
      if not jerichoThrow then
        jerichoThrow = feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_2")
      end
      if vehicleList and vehicleList[1] then
        recievedVehicles[vehicleList[1]] = {}
        if math.random(100) > 50 then
          if earlyStage then
            chuckTime = 2
          elseif midStage then
            chuckTime = 1.5
          elseif endStage then
            chuckTime = 1
          end
        elseif instance.taskObjectsByActorID["Tanner Actor"].coreData.agent.damage > 0.8 then
          if earlyStage then
            chuckTime = 2
          elseif midStage then
            chuckTime = 1.25
          elseif endStage then
            chuckTime = 1
          end
        elseif earlyStage then
          chuckTime = 2
        elseif midStage then
          chuckTime = 1.25
        elseif endStage then
          chuckTime = 1
        end
        local offset = vec.vector(1, 0, 0, 1)
        if (vehicleList[1].model_id == 201 or vehicleList[1].model_id == 197 or vehicleList[1].model_id == 291 or vehicleList[1].model_id == 185 or vehicleList[1].model_id == 152 or vehicleList[1].model_id == 170 or vehicleList[1].model_id == 138) and localPlayer.currentVehicle == instance.taskObjectsByActorID["Tanner Actor"].coreData.agent then
          if vehicleList[1].model_id == 291 then
            recievedVehicles[vehicleList[1]].exploded = false
          end
          local rand = math.random(5)
          local offsetHolder = vec.vector(5, 0, 0, 1)
          if rand > 5 then
            offset = offsetHolder
          else
            offset = -offsetHolder
            offset[3] = 1
          end
        elseif localPlayer.currentVehicle ~= instance.taskObjectsByActorID["Tanner Actor"].coreData.agent then
          recievedVehicles = {}
        else
          local rand = math.random(5)
          offset = vec.vector(1, 0, 0, 1) * ((rand - 5) / 2)
        end
        local randY = (math.random(100) - 50) / 50
        GameVehicleResource.setFlashColour(vehicleList[1], vec.vector(1, 0, 0, 1))
        ZapAIPresence.Settings({
          Radius = 1,
          TransitionInTime = 1,
          Color = vec.vector(40, 40, 40, 1),
          AttachedToVehicle = false
        })
        ZapAIPresence.StartTransition(nil, vehicleList[1])
        VehicleLauncher.Settings({
          LaunchAngle = jerichoLaunchAngle,
          LaunchVelocity = jerichoLaunchVelocity,
          SecondImpulseTime = jerichoImpulseTime,
          TravelTime = jerichoLauncherTravelTime
        })
        VehicleLauncher.VehicleToVehicle(vehicleList[1], instance.taskObjectsByActorID["Tanner Actor"].coreData.agent.gameVehicle, vec.vector(1, 0, randY, 1), offset)
        GameVehicleResource.RegisterDeletionCallback(vehicleList[1], jerichoCallbackFunction)
        numberThrown = numberThrown + 1
        thrownCars = thrownCars + 1
        timer = g_NetworkTime
        if thrownCars % 10 == 0 and not isEventActive() then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_3A")
        end
      end
    end
  end
  addUserUpdateFunction("throw", throwCars, 120)
  instance.taskObjectsByActorID["Tanner Actor"].coreData.agent.gameVehicle.speed = 13.41
  instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle.performance = 1.25
  ZapAIPresence.SetCallback({TransitionCallback = jerichoZapTransitionEnd})
  local loadAudioCallBack = function()
    feedbackSystem.startMusic("Uid16592_CH08_Standard_MindControl_Play")
  end
  Sound.LoadMission(cards.Missions[instance.challenge.name].MissionID, loadAudioCallBack)
  ZapAIPresence.Settings({
    Height = 50,
    Radius = 1,
    TransitionInTime = 1,
    Color = vec.vector(40, 40, 40, 1)
  })
  ZapAIPresence.StartTransition(nil, instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle)
  GameVehicleResource.setInfiniteMass(instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle, true)
  RaceManager.SetStartCheckpointIndex(instance.raceId, RaceManager.GetStartCheckpointIndex(instance.raceId))
  spoolsystem.AddSpoolCentre(instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle.position)
  spoolsystem.SetSpoolCentreAttachment(1, instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle)
  GameVehicleResource.removeVehicleSimulationArea(instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle)
  GameVehicleResource.addVehicleSimulationArea(instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle, 40, 150, 10, 1, true)
end
local function callbackFunction(gameVehicle)
  thrownVehicles[gameVehicle] = nil
end
local removeTable = {}
missionSetupData["Anything you can do"].update = function(instance)
  if localPlayer.inZap and minimap.GetOn(localPlayer.localID) then
    localPlayer.minimapSupport:hide()
  end
  for vehicleThrown, currentThrownVehicle in next, thrownVehicles, nil do
    if instance.taskObjectsByActorID["Jericho Actor"] then
      local distance = vehicleThrown.position - instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.position:length()
      if distance > 150 then
        removeTable[vehicleThrown] = true
      elseif distance < 10 then
        GameVehicleResource.setInfiniteMass(instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle, false)
        GameVehicleResource.playerOnlyTakedown({
          gameVehicle = instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle,
          enabled = false
        })
        localPlayer.simulationSupport.doWait(2, function()
          if instance.taskObjectsByActorID["Jericho Actor"] then
            GameVehicleResource.setInfiniteMass(instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle, true)
            GameVehicleResource.playerOnlyTakedown({
              gameVehicle = instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle,
              enabled = true
            })
          end
        end)
        if vehicleThrown.model_id ~= 201 and vehicleThrown.model_id ~= 197 and vehicleThrown.model_id ~= 291 and vehicleThrown.model_id ~= 185 and vehicleThrown.model_id ~= 152 and vehicleThrown.model_id ~= 170 and vehicleThrown.model_id ~= 138 then
          showIcam = false
        else
          showIcam = true
        end
        if not isEventActive() then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_3B")
        end
        if not localPlayer.inZap and not localPlayer.zapTransition and not currentThrownVehicle.isGhosted then
          abilities.ghost.abilityFunction()
          localPlayer.currentVehicle:removeFlashColourOverRide()
          GhostCar.OverriddeAffectedVehicleLogic(true)
          GhostCar.ClearCandidateVehicleToOverriddenLogicList()
          GhostCar.AddCandidateVehicleToOverriddenLogicList(vehicleThrown)
          currentThrownVehicle.isGhosted = true
        end
        if showIcam == true or vehiclesLaunched < 2 then
          local function finishFunction()
            if not instance.taskObjectsByActorID["Jericho Actor"] then
              return true
            end
          end
          local icamParams = {
            cameraTargets = {
              instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle
            },
            duration = 2,
            speed = 1,
            framing = "verywide",
            angleYaw = "front",
            callbackFunction = function()
              localPlayer.controllerInterface:registerPlayerControl()
              Menu.ShowHUD = 1
              if vehiclesLaunched > 1 then
                canThrow = true
              end
            end,
            stopFunction = finishFunction
          }
          if not localPlayer.inZap then
            if damage < 1 and not localPlayer.inCutscene then
              Menu.ShowHUD = 0
              localPlayer.controllerInterface:removePlayerControl(true)
              iCamActivationTableInput(icamParams)
            end
          else
            local timer = g_NetworkTime
            local function resetCamera()
              if not localPlayer.inCutscene then
                if not localPlayer.zapTransition then
                  localPlayer:SetZapLevel(0, localPlayer.currentVehicle, true)
                end
                Menu.ShowHUD = 0
                if localPlayer.currentVehicle and instance.taskObjectsByActorID["Jericho Actor"] then
                  localPlayer.controllerInterface:removePlayerControl(true)
                  iCamActivationTableInput(icamParams)
                  removeUserUpdateFunction("reset")
                end
              end
            end
            addUserUpdateFunction("reset", resetCamera, 10)
          end
          if vehicleThrown.model_id == 291 then
            GameVehicleResource.explode({
              gameVehicle = vehicleThrown,
              offset = vec.vector(1, 0, 0, 1),
              range = 0,
              strength = 5
            })
          end
        end
        removeTable[vehicleThrown] = true
      end
    end
  end
  for vehicleThrown, v in next, removeTable, nil do
    thrownVehicles[vehicleThrown] = nil
    GameVehicleResource.UnRegisterDeletionCallback(vehicleThrown, callbackFunction)
  end
  removeTable = {}
end
local function getTannerDynamicTargets(taskObject, task, dynamicListID)
  if task.specialName == "Chase" then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
      if task.networkVars.checkpoints == 3 then
        jerichoLaunchVelocity = 18
        jerichoImpulseTime = 0.5
        jerichoLauncherTravelTime = 1.25
        VehicleLauncher.DeleteAll()
      elseif task.networkVars.checkpoints == 6 then
        canThrow = true
        jerichoLaunchVelocity = 20
        jerichoImpulseTime = 0.5
        jerichoLauncherTravelTime = 1
      elseif task.networkVars.checkpoints == 7 then
        canThrow = false
      elseif task.networkVars.checkpoints == 8 then
        canThrow = true
        jerichoLaunchAngle = 85
        jerichoLaunchVelocity = 20
        jerichoImpulseTime = 0.5
        jerichoLauncherTravelTime = 1
        vehicleSearchParameters.idealDistance = 90
      elseif task.networkVars.checkpoints == 11 then
        canThrow = false
      elseif task.networkVars.checkpoints == 12 then
        canThrow = true
      elseif task.networkVars.checkpoints == 17 then
        canThrow = false
      elseif task.networkVars.checkpoints == 18 then
        canThrow = true
      end
      if task.networkVars.checkpoints < #allCheckpoints then
        return {
          allCheckpoints[task.networkVars.checkpoints + 1]
        }, false
      else
        return {
          allCheckpoints[1]
        }, false
      end
    else
      return {
        allCheckpoints[task.networkVars.checkpoints]
      }, false
    end
  end
end
missionSetupData["Anything you can do"].targetList = {
  ["Tanner team"] = getTannerDynamicTargets
}
local jerichoSlowedDown = false
missionSetupData["Anything you can do"].goalComplete = function(taskObject, task, conditionKey)
  if task.specialName == "Respawn jericho" then
    challengeSystem.spawnActors(task.instance, "Any", {
      ["Jericho Actor"] = true
    })
    local taskObject = task.instance.taskObjectsByActorID["Jericho Actor"]
    GameVehicleResource.applyDamage({
      gameVehicle = taskObject.coreData.agent.gameVehicle,
      damage = damage
    })
    OneShotSound.Play("Jericho_Shift_OneShot")
    RaceManager.SetStartCheckpointIndex(task.instance.raceId, RaceManager.GetStartCheckpointIndex(task.instance.raceId))
    ZapAIPresence.StartTransition(nil, task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle)
    GameVehicleResource.setInfiniteMass(task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle, true)
    spoolsystem.AddSpoolCentre(task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle.position)
    spoolsystem.SetSpoolCentreAttachment(1, task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle)
    GameVehicleResource.removeVehicleSimulationArea(task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle)
    GameVehicleResource.addVehicleSimulationArea(task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle, 40, 150, 10, 1, true)
  elseif task.specialName == "Jericho health" then
    if conditionKey == 1 then
      earlyStage = true
    elseif conditionKey == 2 then
      midStage = false
    elseif conditionKey == 3 then
      endStage = false
    end
  elseif task.specialName == "Fake rubberband" then
    local traits = {}
    if conditionKey == 1 and not jerichoSlowedDown then
      traits.desiredSpeed = 8.944544
      ActiveLifeAI.setPersonalityTraits(task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle, traits)
      jerichoSlowedDown = true
    elseif conditionKey == 2 and jerichoSlowedDown then
      traits.desiredSpeed = 44.72272
      ActiveLifeAI.setPersonalityTraits(task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle, traits)
      RaceManager.SetStartCheckpointIndex(task.instance.raceId, RaceManager.GetStartCheckpointIndex(task.instance.raceId))
      jerichoSlowedDown = false
    end
  end
end
taskCompleteData["Anything you can do"] = {}
taskCompleteData["Anything you can do"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = localPlayer.currentVehicle,
    cameraShots = cameraShots[2],
    failReason = "ID:184961"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if taskObject.coreData.actor.team == "Tanner team" then
    if task.success then
      if task.specialName == "In tanner" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01", nil, "missionCritical")
      elseif task.specialName == "Trigger the car throwing" then
        zap.singlePlayerZapSlowDownMultiplier = 0.5
        feedbackSystem.menusMaster.primaryTextPrompt("ID:214868", nil, false, false, false)
        feedbackSystem.menusMaster.secondaryTextPrompt("ID:214869", nil, false, false, true, localPlayer.buttonLayout.enterZap)
        localPlayer:blockAbility("zap", false)
        local function overrideFunction(param)
          local gameVehicleSelected = zapcontroller.GetTargetedGameVehicle()
          local tannerToJerichoDistance = 0
          if task.instance.taskObjectsByActorID["Tanner Actor"] and task.instance.taskObjectsByActorID["Jericho Actor"] then
            tannerToJerichoDistance = task.instance.taskObjectsByActorID["Tanner Actor"].coreData.agent.position - task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.position:length()
          end
          if gameVehicleSelected and tannerToJerichoDistance <= 150 then
            if gameVehicleSelected == task.instance.taskObjectsByActorID["Tanner Actor"].coreData.agent.gameVehicle then
              localPlayer:SetZapLevel(0, task.instance.taskObjectsByActorID["Tanner Actor"].coreData.agent, false)
            elseif task.instance.taskObjectsByActorID["Jericho Actor"] and gameVehicleSelected == task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle then
              return
            else
              local randY = (math.random(100) - 50) / 50
              VehicleLauncher.Settings({
                LaunchAngle = 75,
                LaunchVelocity = 18,
                SecondImpulseTime = 0.25,
                TravelTime = 0.75
              })
              if task.instance.taskObjectsByActorID["Jericho Actor"] and gameVehicleSelected then
                if GameVehicleResource.withinRadius(gameVehicleSelected.position, task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.position, 150) then
                  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
                  VehicleLauncher.VehicleToVehicle(gameVehicleSelected, task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle, vec.vector(1, 0, randY, 1))
                  vehiclesLaunched = vehiclesLaunched + 1
                  localPlayer.currentVehicle:removeFlashColourOverRide()
                  if not task.instance.taskObjectsByActorID["Tanner Actor"].controlled then
                    localPlayer:SetZapLevel(0, task.instance.taskObjectsByActorID["Tanner Actor"].coreData.agent, false)
                  end
                  thrownVehicles[gameVehicleSelected] = {isGhosted = false}
                  GameVehicleResource.RegisterDeletionCallback(gameVehicleSelected, callbackFunction)
                  OneShotSound.Play("Mis_MindControl_ThrowVehicle_OneShot", false)
                elseif not feedbackSystem.menusMaster.primaryPromptActive then
                  feedbackSystem.menusMaster.primaryTextPrompt("ID:248272", false, false, false, false)
                end
              end
            end
          elseif gameVehicleSelected and tannerToJerichoDistance > 150 then
            if gameVehicleSelected == task.instance.taskObjectsByActorID["Tanner Actor"].coreData.agent.gameVehicle then
              localPlayer:SetZapLevel(0, task.instance.taskObjectsByActorID["Tanner Actor"].coreData.agent, false)
            elseif not feedbackSystem.menusMaster.primaryPromptActive then
              feedbackSystem.menusMaster.primaryTextPrompt("ID:248272", false, false, false, false)
            end
          end
        end
        local overrideZap = function()
        end
        zap.setZapButtonJustPressedOverride(overrideFunction)
        zap.SetZapInOverride(overrideZap)
        local function allowingThrows()
          if vehiclesLaunched > 1 then
            canThrow = true
          end
          removeUserUpdateFunction("allowThrows")
        end
        addUserUpdateFunction("allowThrows", allowingThrows, 1800, true)
        canThrow = false
      end
      if task.specialName == "Chase" then
        removeUserUpdateFunction("throw")
        if GhostCar.IsActive() then
          abilities.ghost.stopAbilityFunction()
        end
        localPlayer:blockAbility("zap", true)
        task.instance.taskObjectsByActorID["Tanner Actor"].coreData.agent.gameVehicle.maxAllowedDamage = 0.9
        if task.condition == 3 then
          if not task.instance.taskObjectsByActorID["Tanner Actor"].controlled then
            if not localPlayer.inZap then
              localPlayer:SetZapLevel(1)
            end
            localPlayer:SetZapLevel(0, task.instance.taskObjectsByActorID["Tanner Actor"].coreData.agent, true)
          end
          local icamParams = {
            cameraTargets = {
              task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle
            },
            duration = 2,
            speed = 1,
            framing = "verywide",
            angleYaw = "front"
          }
          iCamActivationTableInput(icamParams)
        end
      elseif task.specialName == "End Mission" then
        params.rating = "PASS"
        params.callback = completeTask
        localPlayer.challenge.endScreen(taskObject, params)
      end
    else
      params.rating = "FAIL"
      params.dialogue = "GPMV01_FAILURE_L_1"
      params.callback = failTask
      params.driverIsTanner = true
      if 1 <= task.agent.damage then
        params.failReason = "ID:184961"
        params.hint = "ID:236266"
      else
        params.failReason = "ID:231140"
        params.hint = "ID:236266"
      end
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "Jericho delete to respawn" then
    ZapAIPresence.Settings({
      Radius = 0.085,
      TransitionInTime = 1,
      Color = vec.vector(40, 40, 40, 1)
    })
    ZapAIPresence.StartTransition(nil, task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.gameVehicle)
    damage = task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.damage
    spoolsystem.RemoveSpoolCentre(1)
    spoolsystem.SetSpoolCentreAttachment(1, nil)
    task.instance.rubberbandRoute = nil
    zapTransitionFinished = true
    OneShotSound.Play("Jericho_Disappear_OneShot")
    numberThrown = 0
    localPlayer.simulationSupport.doWait(1, function()
      if task.instance.taskObjectsByActorID["Jericho Actor"] then
        damage = task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.damage
        task.instance.taskObjectsByActorID["Jericho Actor"]:delete(true)
      end
    end)
  end
end
missionEndCallback["Anything you can do"] = function(instance)
  if GhostCar.IsActive() then
    abilities.ghost.stopAbilityFunction()
  end
  zap.singlePlayerZapSlowDownMultiplier = initalZapSlowMo
  removeUserUpdateFunction("throw")
  moodSystem.removeMood("Jericho lite", 0)
  moodSystem.removeMood("Coma", 0)
  VehicleLauncher.DeleteAll()
  jerichoThrow = false
  damage = 0
  zap.setZapButtonJustPressedOverride(nil)
  zap.SetZapInOverride(nil)
  chuckTime = 2
  throwNumber = 3
  thrownCars = 0
  playedPIP1 = false
  localPlayer:blockAbility("zap", false)
  thrownVehicles = {}
  recievedVehicles = {}
  feedbackSystem.stopMusic("Uid16592_CH08_Standard_MindControl_Stop")
  feedbackSystem.removeSlot(1)
  spoolsystem.RemoveSpoolCentre(1)
  spoolsystem.SetSpoolCentreAttachment(1, nil)
end
