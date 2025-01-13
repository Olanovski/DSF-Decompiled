module("cardSystem.logic")
missionSetupData["Generic protect activity"] = {}
local lastCrashTime, spoolcenterset, showIcam
local nextSize = 1
local nextDistance = 1
local nextDirection = 1
local currentRequiredVehicles = 3
local spawnTimer = 3
local lastSpawnTime = 0
local allowLarge = false
local allowDouble = false
local displayingShiftReminder = false
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
local attackedVehicleTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Start",
        taskConditions = {
          {
            {
              goal = "Is player controlled",
              params = {inverse = true}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Sieged",
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {
                value = goalParams["Time limit"]
              }
            }
          },
          {
            {
              goal = "Time trigger",
              params = {
                value = goalParams["Time limit"]
              }
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
              params = {
                value = goalParams["Time limit"]
              }
            },
            {
              goal = "All opposing vehicles damage above",
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
            style = "Protect HUD",
            settings = {
              updateHealth = true,
              updateTimer = true,
              timerLength = goalParams["Time limit"]
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Siege Controller",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {
                value = goalParams["Time limit"] / 3
              }
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
              params = {
                value = goalParams["Time limit"] / 3 * 2
              }
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
        specialName = "Remind player to shift",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Within radius of player",
              params = {value = 50}
            },
            {
              goal = "Time trigger",
              params = {value = 20}
            }
          },
          {
            {
              goal = "Within radius of player",
              params = {value = 50, inverse = true}
            }
          },
          {
            {
              goal = "Player in zap",
              params = {value = true}
            }
          }
        }
      }
    }
  }
  return task
end
local attackTask = function(goalParams, HUD)
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
          },
          {
            forceTaskComplete = true,
            {
              goal = "Being towed"
            }
          }
        },
        HUD = {
          {
            style = "Protect HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Proximity warning",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
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
        HUD = {
          {
            style = "Protect HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Reduce difficulty",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Instance time above",
              params = {
                value = goalParams["Time limit"]
              }
            }
          }
        },
        HUD = {
          {
            style = "Protect HUD"
          }
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
missionSetupData["Generic protect activity"].taskCreatorFunctionLookups = {
  ["Attack team"] = attackTask,
  ["Protect team"] = attackedVehicleTask
}
missionSetupData["Generic protect activity"].initiate = function(instance)
  lastCrashTime = 0
  spoolcenterset = false
  showIcam = true
  nextDistance = 1
  nextDirection = 1
  nextSize = 1
  currentRequiredVehicles = instance.challenge.goalValues["S1 Max Attackers"] or 3
  spawnTimer = instance.challenge.goalValues["S1 Spawn Delay"] or 3
  allowLarge = instance.challenge.goalValues["S1 Pickups"] or false
  allowDouble = instance.challenge.goalValues["S1 Doubles"] or false
  lastSpawnTime = 0
  displayingShiftReminder = false
  garage.hide(true)
  instance.timerStartTime = g_NetworkTime
  localPlayer:blockAbility("zapReturn", true)
  zapcontroller.AddLockedVehicle({
    gameVehicle = instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent.gameVehicle
  })
  GameVehicleResource.setInfiniteMass(instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent.gameVehicle, true)
  instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent:lockEmergencyBrakes(0.5)
  instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent.blockTow = true
  localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
  if not spoolcenterset then
    spoolsystem.AddSpoolCentre(instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent.gameVehicle.position)
    spoolsystem.SetSpoolCentreAttachment(1, instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent.gameVehicle)
    GameVehicleResource.removeVehicleSimulationArea(instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent.gameVehicle)
    GameVehicleResource.addVehicleSimulationArea(instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent.gameVehicle, 40, 150, 10, 1, true)
    spoolcenterset = true
  end
end
missionSetupData["Generic protect activity"].update = nil
local getAttackerTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    if #task.dynamicTargets == 1 then
      return false, true
    else
      return false, false
    end
  elseif task.instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent then
    return {
      task.instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent
    }, false
  else
    return false, true
  end
end
missionSetupData["Generic protect activity"].targetList = {
  ["Attack team"] = getAttackerTargets
}
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
      if nextDistance == 2 then
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
          ["Attacker " .. distances[nextDistance] .. " " .. directions[nextDirection]] = true
        })
      elseif nextSize == 2 then
        challengeSystem.spawnActors(instance, "Never", {
          ["Attacker " .. distances[nextDistance] .. " " .. directions[nextDirection]] = true,
          ["Attacker " .. distances[nextDistance] .. " " .. directions[nextDirection] .. sizes[nextSize]] = true
        })
      elseif nextSize == 3 then
        challengeSystem.spawnActors(instance, "Never", {
          ["Attacker " .. distances[nextDistance] .. " " .. directions[nextDirection] .. sizes[nextSize]] = true
        })
      end
      OneShotSound.Play("HUD_Gen_NewEnemy_Alert_OneShot", false)
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
missionSetupData["Generic protect activity"].goalComplete = function(taskObject, task, conditionKey)
  if task.specialName == "Sieged" then
    task.instance.timerHasFinished = true
    removeUserUpdateFunction("Spawner")
    if conditionKey == 1 then
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:248730", priority = 2})
    elseif conditionKey == 2 then
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:248731", priority = 1})
    end
  elseif task.specialName == "Remind player to shift" then
    if conditionKey == 1 then
      if not displayingShiftReminder then
        displayingShiftReminder = true
        feedbackSystem.menusMaster.primaryTextPrompt("ID:248755", nil, nil, nil, nil, nil, function()
          displayingShiftReminder = false
        end)
      end
    elseif displayingShiftReminder then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      displayingShiftReminder = false
    end
  elseif task.specialName == "Siege Controller" then
    if conditionKey == 1 then
      currentRequiredVehicles = task.instance.challenge.goalValues["S2 Max Attackers"] or 3
      spawnTimer = task.instance.challenge.goalValues["S2 Spawn Delay"] or 2
      allowLarge = task.instance.challenge.goalValues["S2 Pickups"] or false
      allowDouble = task.instance.challenge.goalValues["S2 Doubles"] or false
    elseif conditionKey == 2 then
      currentRequiredVehicles = task.instance.challenge.goalValues["S3 Max Attackers"] or 4
      spawnTimer = task.instance.challenge.goalValues["S3 Spawn Delay"] or 1
      allowLarge = task.instance.challenge.goalValues["S3 Pickups"] or true
      allowDouble = task.instance.challenge.goalValues["S3 Doubles"] or false
    end
    addUserUpdateFunction("Spawner", function()
      spawnNextVehicle(task.instance)
    end, 60)
  end
end
taskCompleteData["Generic protect activity"] = {}
taskCompleteData["Generic protect activity"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent,
    successReason = "ID:184781",
    failReason = "ID:245569",
    hint = "ID:235499"
  }
  if task.success then
    if task.specialName == "Start" then
      if not userUpdateFunctions.Spawner then
        addUserUpdateFunction("Spawner", function()
          spawnNextVehicle(task.instance)
        end, 60)
        lastSpawnTime = g_NetworkTime
      end
    elseif task.specialName == "Sieged" then
      local function completeTask()
        progressionSystem.challengeComplete(task.instance, task.agent.matrix)
      end
      params.callback = completeTask
      params.vehicle = task.agent
      params.rating = "PASS"
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "Set any updates" then
      task.actor.ramStationaryDistance = 200
    elseif task.specialName == "Attacker Hits Prison Van" then
      if task.condition == 1 then
        GameVehicleResource.applyDamage({
          gameVehicle = task.instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent.gameVehicle,
          damage = task.instance.challenge.goalValues["Truck damage"]
        })
        if showIcam or task.instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent.damage >= 1 - task.instance.challenge.goalValues["Truck damage"] then
          iCamActivationTableInput({
            cameraTargets = {
              task.agent.gameVehicle
            },
            duration = 3,
            speed = 0.5,
            framing = "wide",
            angleyaw = "rear"
          })
          showIcam = false
        end
      else
        iCamCrashCam(task.agent.gameVehicle)
        if g_NetworkTime - lastCrashTime < 1 then
          feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:243770", priority = 2})
        else
          lastCrashTime = g_NetworkTime
        end
      end
      taskObject.coreData.agent.disabled = true
      if not userUpdateFunctions.Spawner and not task.instance.timerHasFinished then
        addUserUpdateFunction("Spawner", function()
          spawnNextVehicle(task.instance)
        end, 60)
        lastSpawnTime = g_NetworkTime
      end
    elseif task.specialName == "Reduce difficulty" then
      task.actor.desiredSpeed = 45
      local behaviour = {
        traits = taskSystem.buildChaseTraits(task)
      }
      behaviour.traits.avoidAttacks = false
      behaviour.opponentGameVehicle = task.instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent.gameVehicle
      task.agent:highSpeedDrive(behaviour)
    end
  else
    local function failTask()
      progressionSystem.challengeFailed(task.instance, task.agent.matrix)
    end
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Generic protect activity"] = function(instance)
  removeUserUpdateFunction("Spawner")
  garage.hide(false)
  if spoolcenterset then
    spoolsystem.RemoveSpoolCentre(1)
    spoolsystem.SetSpoolCentreAttachment(1, nil)
    GameVehicleResource.removeVehicleSimulationArea(instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent.gameVehicle)
    spoolcenterset = false
  end
  localPlayer:blockAbility("zapReturn", false)
  GameVehicleResource.setInfiniteMass(instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent.gameVehicle, false)
  zapcontroller.RemoveLockedVehicle({
    gameVehicle = instance.taskObjectsByActorID["Attacked Vehicle"].coreData.agent.gameVehicle
  })
end
