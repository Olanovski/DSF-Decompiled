module("cardSystem.logic")
missionSetupData["Protect the base"] = {}
local siegeTime = 180
local function moneyTruckTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Trigger 1st Prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Trigger PIP01",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2.5}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "Linear Checkpoints",
        dynamicTargets = true,
        specialName = "Get Truck To Dropoff",
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
              goal = "Completed lap",
              params = {value = 0}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              targetLoop = false,
              targetDepth = math.huge,
              alwaysOn = true,
              styles = {
                Hotspot = {}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = HUD,
            settings = {updateHealth = true}
          }
        }
      },
      {
        task = "No AI",
        specialName = "Audio - Whipped Speech Speech",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 6}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Incidental Driveto Speech",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 25}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No functionality",
        specialName = "Play cutscene",
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
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait for Cutscene",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Softsave",
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
        specialName = "Trigger Messages",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1, takeZapIntoAccount = true}
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
        specialName = "Wait for Police",
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = siegeTime}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = siegeTime}
            },
            {
              goal = "Number of team members remaining",
              params = {
                value = 1,
                team = "Attack team"
              }
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = siegeTime}
            },
            {
              goal = "Number of team members remaining",
              params = {
                value = 0,
                team = "Attack team"
              }
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
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
              updateHealth = true,
              updateTimer = true,
              timerLength = siegeTime
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Play Audio - Shift higher",
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 2,
            {
              goal = "Player in zap",
              params = {levelOfZap = 1}
            },
            {
              goal = "Time trigger",
              params = {value = 7, takeZapIntoAccount = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Trigger Shift Reminder",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3, takeZapIntoAccount = true}
            }
          }
        },
        HUD = {
          {style = HUD}
        }
      },
      {
        task = "No AI",
        specialName = "Siege Controller",
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 45}
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 90}
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 110}
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 140}
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Spawn Fake Cops",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {
                value = siegeTime - 20
              }
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Trigger Mission End",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
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
          {style = HUD}
        }
      }
    }
  }
  return task
end
local attackTask = function(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Wander",
        specialName = "Set any updates",
        groupProgression = {importantMinorOrder = false},
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
        task = "Non-linear Chase",
        dynamicTargets = true,
        specialName = "Attacker Hits Prison Van",
        goalConditions = {
          {
            {
              goal = "Simple collision check",
              params = {mustHitTarget = true}
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
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
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
        specialName = "Proximity warning",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 300}
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
      }
    },
    {
      {
        task = "Wander",
        specialName = "Get Away From Van",
        taskConditions = {
          {
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          }
        }
      }
    }
  }
  return task
end
local bombCarTask = function(goalParams, HUD, audio)
  local task = {
    {
      {task = "No AI"}
    }
  }
  return task
end
missionSetupData["Protect the base"].taskCreatorFunctionLookups = {
  ["Attack team"] = attackTask,
  ["Protect team"] = moneyTruckTask,
  ["Bomb car team"] = bombCarTask
}
local audioToggle = true
local showIcam = true
local ramStationaryDistance = 50
local isBerserkerState = false
local lastCrashTime = 0
local bombCarMatrix = vec.matrix(0.884, 0.0154, 0.467, -929.471, 0.001, 0.999, -0.034, 62.737, -0.467, 0.03, 0.884, 2136.811, 0, 0, 0, 1)
local truckMatrix = vec.matrix(0.833, -0.012, 0.553, -936.099, 0.026, 1, -0.017, 62.652, -0.552, 0.028, 0.833, 2143.549, 0, 0, 0, 1)
local dropOffLocation = vec.vector(-926.1802, 62.71582, 2146.484, 1)
local spoolcenterset = false
local directions = {
  [1] = "North",
  [2] = "East",
  [3] = "South",
  [4] = "West"
}
local distances = {
  [1] = "700m",
  [2] = "1000m"
}
local sizes = {
  [1] = "",
  [2] = " bis",
  [3] = " Large"
}
local nextDistance = 1
local nextDirection = 1
local currentRequiredVehicles = 3
local spawnTimer = 2.5
local lastSpawnTime = 0
local allowLarge = false
local nextSize = 1
local allowDouble = false
local spawnDouble = true
missionSetupData["Protect the base"].initiate = function(instance)
  GameVehicleResource.setCharacterSpoolingEntityIndex(instance.taskObjectsByActorID.BombCar.coreData.agent.gameVehicle, 0, "-1")
  nextSize = 1
  nextDistance = 1
  nextDirection = 1
  currentRequiredVehicles = 3
  spawnTimer = 2.5
  lastSpawnTime = 0
  allowLarge = false
  allowDouble = false
  spawnDouble = true
  isBerserkerState = false
  lastCrashTime = 0
  showIcam = true
  audioToggle = true
  spoolcenterset = false
  createFixedPosition(instance, {dropOffLocation}, 1)
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    if softSaveData.progression == 1 then
      instance.timerStartTime = g_NetworkTime
      instance.taskObjectsByActorID.BombCar.coreData.agent:teleportToMatrix(bombCarMatrix)
      GameVehicleResource.applyDamage({
        gameVehicle = instance.taskObjectsByActorID.BombCar.coreData.agent.gameVehicle,
        damage = 1
      })
      GameVehicleResource.setInfiniteMass(instance.taskObjectsByActorID.MoneyTruck.coreData.agent.gameVehicle, true)
      GameVehicleResource.setBurntOut(instance.taskObjectsByActorID.MoneyTruck.coreData.agent.gameVehicle, true)
      zapcontroller.AddLockedVehicle({
        gameVehicle = instance.taskObjectsByActorID.MoneyTruck.coreData.agent.gameVehicle
      })
      localPlayer:blockAbility("zapReturn", true)
    end
  else
    GameVehicleResource.setInfiniteMass(instance.taskObjectsByActorID.BombCar.coreData.agent.gameVehicle, true)
    instance.taskObjectsByActorID.BombCar.coreData.agent:set_damageMultiplier(0)
  end
end
local function checkValidDirection(instance, nextDirection)
  local isValid = true
  for actorID, v in next, instance.taskObjectsByActorID, nil do
    if string.find(actorID, tostring(directions[nextDirection])) then
      isValid = false
    end
  end
  return isValid
end
local getSpawnedVehicles = function(instance)
  local currentSpawnedVehicles = 0
  for actorID, data in next, instance.taskObjectsByActorID, nil do
    if data.coreData.actor.team == "Attack team" and not data.coreData.agent.disabled == true then
      currentSpawnedVehicles = currentSpawnedVehicles + 1
    end
  end
  return currentSpawnedVehicles
end
local function spawnNextVehicle(instance)
  if lastSpawnTime + spawnTimer <= g_NetworkTime and getSpawnedVehicles(instance) < currentRequiredVehicles or getSpawnedVehicles(instance) == 0 and not localPlayer.inCutsceneOrIcam then
    local respawn = false
    if checkValidDirection(instance, nextDirection) then
      if nextDistance == 2 or isBerserkerState then
        nextDistance = 2
        if allowLarge and allowDouble then
          if spawnDouble then
            nextSize = 2
            spawnDouble = false
          else
            nextSize = 3
            spawnDouble = true
          end
        elseif allowLarge then
          nextSize = 3
        elseif allowDouble then
          nextSize = 2
        else
          nextSize = 1
        end
      else
        nextSize = 1
      end
      respawn = true
    elseif nextDirection < #directions then
      nextDirection = nextDirection + 1
    else
      nextDirection = 1
    end
    if respawn then
      lastSpawnTime = g_NetworkTime
      if nextSize == 1 then
        challengeSystem.spawnActors(instance, "Never", {
          ["Siege car " .. distances[nextDistance] .. " " .. directions[nextDirection]] = true
        })
      elseif nextSize == 2 then
        challengeSystem.spawnActors(instance, "Never", {
          ["Siege car " .. distances[nextDistance] .. " " .. directions[nextDirection]] = true,
          ["Siege car " .. distances[nextDistance] .. " " .. directions[nextDirection] .. sizes[nextSize]] = true
        })
      elseif nextSize == 3 then
        challengeSystem.spawnActors(instance, "Never", {
          ["Siege car " .. distances[nextDistance] .. " " .. directions[nextDirection] .. sizes[nextSize]] = true
        })
      end
      if nextDirection < #directions then
        nextDirection = nextDirection + 1
      else
        nextDirection = 1
      end
      if nextDistance < #distances then
        nextDistance = nextDistance + 1
      else
        nextDistance = 1
      end
    end
  elseif getSpawnedVehicles(instance) >= currentRequiredVehicles then
    removeUserUpdateFunction("Spawner")
  end
end
missionSetupData["Protect the base"].update = nil
local getProtectTeamTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  elseif task.specialName == "Get Truck To Dropoff" then
    return checkpointSystem.getCheckpoints(task.instance, 1), false
  end
end
local getAttackerTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    if #task.dynamicTargets == 1 then
      return false, true
    else
      return false, false
    end
  else
    local teams = {}
    for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
      teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
      table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
    end
    if teams["Protect team"] then
      return teams["Protect team"], false
    else
      return false, true
    end
  end
end
missionSetupData["Protect the base"].targetList = {
  ["Attack team"] = getAttackerTargets,
  ["Protect team"] = getProtectTeamTargets,
  ["Bomb car team"] = getProtectTeamTargets,
  ["Emergency team"] = getAttackerTargets
}
local cutSpeed = function(task, amountToSubtract)
  local traits = {}
  for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
    if string.find(actorID, "Siege") then
      traits.desiredSpeed = taskObject.coreData.actor.desiredSpeed - amountToSubtract
      ActiveLifeAI.setPersonalityTraits(task.instance.taskObjectsByActorID[actorID].coreData.agent.gameVehicle, traits)
    end
  end
end
missionSetupData["Protect the base"].goalComplete = function(taskObject, task, conditionKey)
  if task.specialName == "Wait for Police" then
    local prompt = {prompt = "", priority = 2}
    task.instance.timerHasFinished = true
    if conditionKey == 1 then
      prompt.prompt = "ID:248730"
      prompt.priority = 2
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    elseif conditionKey == 2 then
      prompt.prompt = "ID:248731"
      prompt.priority = 1
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    end
  elseif task.specialName == "Siege Controller" then
    if conditionKey == 1 then
      currentRequiredVehicles = 3
      spawnTimer = 5
    elseif conditionKey == 2 then
      currentRequiredVehicles = 4
      spawnTimer = 3
      allowLarge = true
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243752")
    elseif conditionKey == 3 then
      currentRequiredVehicles = 4
      allowLarge = true
      allowDouble = true
      spawnTimer = 2
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243751")
    elseif conditionKey == 4 then
      allowLarge = true
      allowDouble = true
      isBerserkerState = true
      currentRequiredVehicles = 4
    elseif conditionKey == 5 then
      currentRequiredVehicles = 3
      spawnTimer = 1
      allowLarge = true
      allowDouble = true
      isBerserkerState = true
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243755")
      local traits = {desiredSpeed = 80, spawnSpeed = 80}
      for ID, vehicle in next, task.instance.taskObjectsByActorID, nil do
        if vehicle.coreData.actor.team == "Attack team" then
          ActiveLifeAI.setPersonalityTraits(task.instance.taskObjectsByActorID[ID].coreData.agent.gameVehicle, traits)
        end
      end
    end
    addUserUpdateFunction("Spawner", function()
      spawnNextVehicle(task.instance)
    end, 60)
  end
end
local playFirstZapAudio = false
taskCompleteData["Protect the base"] = {}
taskCompleteData["Protect the base"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.MoneyTruck.coreData.agent,
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    successReasonPerfect = task.instance.challenge.taskCompleteData["Success reason (perfect)"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235485",
    hintIcon1 = localPlayer.buttonLayout.minimapZoom
  }
  local function audioCallback()
    if not audioToggle then
      if playFirstZapAudio then
        feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_L_2", nil, "missionCritical")
        playFirstZapAudio = false
      else
        feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_L_3", nil, "missionCritical")
        playFirstZapAudio = true
      end
    end
  end
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.success then
    if task.specialName == "Trigger 1st Prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245548")
    elseif task.specialName == "Get Truck To Dropoff" then
      task.agent:addTemporaryInvulnerability(3)
      localPlayer:enterCutsceneMode()
      localPlayer:blockAbility("zap", true)
      if not taskObject.coreData.agent.controlled then
        localPlayer:zapToAgent(task.instance.taskObjectsByActorID.MoneyTruck.coreData.agent)
      end
    elseif task.specialName == "Play cutscene" then
      localPlayer:enterCutsceneMode()
      engineCutscene.playCutscene("mis_ch4_bestdefence_01", nil, function()
        task.agent:teleportToMatrix(truckMatrix)
        task.instance.taskObjectsByActorID.BombCar.coreData.agent:teleportToMatrix(bombCarMatrix)
        GameVehicleResource.setInfiniteMass(task.instance.taskObjectsByActorID.BombCar.coreData.agent.gameVehicle, false)
        GameVehicleResource.applyDamage({
          gameVehicle = task.instance.taskObjectsByActorID.BombCar.coreData.agent.gameVehicle,
          damage = 1
        })
        GameVehicleResource.setInfiniteMass(task.instance.taskObjectsByActorID.MoneyTruck.coreData.agent.gameVehicle, true)
        GameVehicleResource.setBurntOut(task.instance.taskObjectsByActorID.MoneyTruck.coreData.agent.gameVehicle, true)
        localPlayer:blockAbility("zapReturn", true)
        localPlayer:blockAbility("zap", false)
        zapcontroller.AddLockedVehicle({
          gameVehicle = task.agent.gameVehicle
        })
      end, nil, nil, 1)
    elseif task.specialName == "Softsave" then
      feedbackSystem.menusMaster.setCurrentFocusString(2)
      localPlayer:exitCutsceneMode()
      task.instance.timerStartTime = g_NetworkTime
      progressionSystem.triggerSoftSave({progression = 1})
      if not localPlayer.inZap then
        localPlayer:SetZapLevel(2, nil, false, {forcedOut = true})
      end
      feedbackSystem.startMusic("Uid06864_CH04_Standard_BestDefence_Play")
    elseif task.specialName == "Trigger Messages" then
      if not spoolcenterset then
        spoolsystem.AddSpoolCentre(task.agent.gameVehicle.position)
        spoolsystem.SetSpoolCentreAttachment(1, task.agent.gameVehicle)
        GameVehicleResource.removeVehicleSimulationArea(task.agent.gameVehicle)
        GameVehicleResource.addVehicleSimulationArea(task.agent.gameVehicle, 40, 150, 10, 1, true)
        spoolcenterset = true
      end
      addUserUpdateFunction("Spawner", function()
        spawnNextVehicle(task.instance)
      end, 60)
    elseif task.specialName == "Spawn Fake Cops" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      Sound.OverrideAmbience("CopsOnTheWay")
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243753", false, false, false, false)
      cutSpeed(task, 20)
    elseif task.specialName == "Wait for Police" then
      for ID, vehicle in next, task.instance.taskObjectsByActorID, nil do
        if vehicle.coreData.actor.team == "Attack team" then
          vehicle:delete()
        end
      end
      params.vehicle = task.agent
      if task.instance.taskObjectsByActorID.MoneyTruck.coreData.agent.damage <= 0.5 then
        params.dialogue = "GPMV00_SUCCESS_L_2"
      else
        params.dialogue = "GPMV00_SUCCESS_L_1"
      end
      params.rating = "PASS"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "Set any updates" then
      taskObject.coreData.actor.ramStationaryDistance = ramStationaryDistance
      if isBerserkerState then
        task.actor.desiredSpeed = 80
        task.actor.spawnSpeed = 80
      end
    elseif task.specialName == "Attacker Hits Prison Van" then
      if task.condition == 1 then
        local baseParams = {
          id = 1234567,
          eventName = "EParticleEvent_dollars_large",
          oneShot = true,
          offset = vec.vector(0, 1.5, -3.25, 1),
          gameVehicle = task.instance.taskObjectsByActorID.MoneyTruck.coreData.agent.gameVehicle
        }
        ParticleEditor.TriggerEvent(baseParams)
        GameVehicleResource.applyDamage({
          gameVehicle = taskObject.coreData.instance.taskObjectsByActorID.MoneyTruck.coreData.agent.gameVehicle,
          damage = 0.2
        })
        if showIcam or taskObject.coreData.instance.taskObjectsByActorID.MoneyTruck.coreData.agent.damage >= 0.85 then
          local iCamParams = {
            cameraTargets = {
              taskObject.coreData.agent.gameVehicle
            },
            duration = 3,
            speed = 0.5,
            framing = "wide",
            angleyaw = "rear"
          }
          iCamActivationTableInput(iCamParams)
          showIcam = false
        end
      elseif task.condition == 2 then
        if 2 > g_NetworkTime - lastCrashTime and not feedbackSystem.menusMaster.primaryPromptActive then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:243770")
          lastCrashTime = g_NetworkTime
        else
          iCamCrashCam(task.agent.gameVehicle, audioCallback)
          lastCrashTime = g_NetworkTime
        end
        if audioToggle then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_1", nil, "timeSensitive")
        end
        audioToggle = not audioToggle
      end
      if not task.instance.timerHasFinished then
        taskObject.coreData.agent.disabled = true
        if not userUpdateFunctions.Spawner then
          addUserUpdateFunction("Spawner", function()
            spawnNextVehicle(task.instance)
          end, 60)
          lastSpawnTime = g_NetworkTime
        end
      end
    elseif task.specialName == "Stop near evidence" then
      task.agent:lockEmergencyBrakes(0.5)
    end
  else
    params.callback = failTask
    params.rating = "FAIL"
    if task.specialName == "Get Truck To Dropoff" then
      params.dialogue = "GPMV01_FAILURE_L_1"
    else
      params.hint = "ID:235499"
      params.dialogue = "GPMV00_FAILURE_L_1"
    end
    feedbackSystem.stopMusic("Uid06864_CH04_Standard_BestDefence_Stop")
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Protect the base"] = function(instance)
  if spoolcenterset then
    spoolsystem.RemoveSpoolCentre(1)
    spoolsystem.SetSpoolCentreAttachment(1, nil)
    GameVehicleResource.removeVehicleSimulationArea(instance.taskObjectsByActorID.MoneyTruck.coreData.agent.gameVehicle)
    spoolcenterset = false
  end
  removeUserUpdateFunction("Spawner")
  Sound.RestoreAmbience()
  feedbackSystem.stopMusic("Uid06864_CH04_Standard_BestDefence_Stop")
  localPlayer:blockAbility("zapReturn", false)
  localPlayer:blockAbility("zap", false)
  zapcontroller.RemoveLockedVehicle({
    gameVehicle = instance.taskObjectsByActorID.MoneyTruck.coreData.agent.gameVehicle
  })
end
