module("cardSystem.logic")
missionSetupData["Wrecked evidence"] = {}
local siegeTime = 90
local zapLevelAfterTutorial = 3
local function evidenceTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Wander",
        specialName = "Towed or Close",
        dynamicTargets = true,
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            }
          },
          {
            {
              goal = "Actor is in major order",
              params = {
                actorID = "Tow Truck",
                value = {3}
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
            style = HUD,
            settings = {updateHealth = true}
          }
        }
      },
      {
        task = "No AI",
        specialName = "Initial being driven",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.25}
            },
            {
              goal = "Being towed",
              params = {inverse = true}
            },
            {
              goal = "Player in agent",
              params = {agentName = "Evidence"}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 0.25}
            },
            {
              goal = "Being towed",
              params = {inverse = true}
            },
            {
              goal = "Player in agent",
              params = {agentName = "Evidence", inverse = true}
            }
          }
        },
        HUD = {
          {style = HUD}
        }
      },
      {
        task = "No AI",
        specialName = "Player Zapped Out Of Truck",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 2,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Near to Mission TowTruck",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Being towed",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 80}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Play chatter",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Being towed",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 80, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 30}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Play waiting for",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Being towed",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 20}
            },
            {
              goal = "Time trigger",
              params = {value = 10}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Player At Lab",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Actor is in major order",
              params = {
                actorID = "Tow Truck",
                value = {4}
              }
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            }
          },
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
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
        specialName = "Is being driven",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.25}
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Tow Truck"}
              }
            },
            {
              goal = "Being towed",
              params = {inverse = true}
            },
            {
              goal = "Player in agent",
              params = {agentName = "Evidence"}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 0.25}
            },
            {
              goal = "Being towed",
              params = {inverse = true}
            },
            {
              goal = "Player in agent",
              params = {agentName = "Evidence", inverse = true}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 0.25}
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Tow Truck"}
              }
            },
            {
              goal = "Being towed"
            },
            {
              goal = "Player in agent",
              params = {agentName = "Tow Truck"}
            }
          }
        },
        HUD = {
          {style = HUD}
        }
      },
      {
        task = "No AI",
        specialName = "Near to Lab",
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
        specialName = "Spawn 1st Attackers Pt 2",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 750}
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
        specialName = "Spawn 2nd Attackers Pt 2",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
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
        specialName = "Spawn 3rd Attackers Pt 2",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 400}
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
        specialName = "Audio - Play locked in",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 500}
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
      }
    },
    {
      {
        task = "No AI",
        specialName = "Faded out",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "After fade audio started",
        taskConditions = {
          {
            {
              goal = "Event active"
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Is PIP Finished",
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
        specialName = "softsave",
        taskConditions = {
          {
            {
              goal = "Tutorial panel active",
              params = {inverse = "true"}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Finished Pushing Into Zap",
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {levelOfZap = zapLevelAfterTutorial}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 7, takeZapIntoAccount = true}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait for Police",
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = siegeTime}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = siegeTime}
            },
            {
              goal = "Number of team members remaining",
              params = {value = 1, team = "Siege team"}
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
              goal = "All opposing vehicles damage above",
              params = {value = 1}
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
        specialName = "Siege Controller",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 28}
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
              params = {value = 50}
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
      },
      {
        task = "No AI",
        specialName = "Spawn Fake Cops",
        groupProgression = {importantMinorOrder = false},
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
      },
      {
        task = "No AI",
        specialName = "Has Player Zapped 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 3,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
local truckTask = function(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    {
      {
        task = "No AI",
        specialName = "Towtruck setup",
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
        specialName = "Is Towing Truck",
        taskConditions = {
          {
            {
              goal = "Agent being towed",
              params = {agentName = "Evidence"}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Watch for towtruck damage",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Towtruck At Lab",
        dynamicTargets = true,
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
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            }
          },
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Audio - Play PIP02",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in agent",
              params = {agentName = "Tow Truck"}
            },
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Towtruck task ended",
        taskConditions = {
          {
            {
              goal = "Instant goal complete"
            }
          }
        }
      }
    }
  }
  return task
end
local badGuyTask = function(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    {
      {
        task = "Linear Chase",
        dynamicTargets = true,
        specialName = "Drive To Evidence",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "stop chasing",
        groupProgression = {importantMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Any team member within radius of target",
              params = {value = 50}
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
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Player has Zapped Out - Goon",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 3,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        dynamicTargets = true,
        specialName = "Drive Away From Truck",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 60}
            }
          },
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
              goal = "Within radius",
              params = {
                value = 300,
                target = "Player",
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Player within radius in zap",
              params = {
                value = 300,
                useOperandA = true,
                inverse = true
              }
            },
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
        }
      }
    }
  }
  return task
end
local siegeTask = function(goalParams, HUD, audio)
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
missionSetupData["Wrecked evidence"].taskCreatorFunctionLookups = {
  ["Evidence team"] = evidenceTask,
  ["Bad Guy team"] = badGuyTask,
  ["Truck team"] = truckTask,
  ["Siege team"] = siegeTask
}
local highlightVehicles = function(on)
  if on then
    local vehicles = {
      {VehicleModelUID = 287, AllowTowedVehicles = false}
    }
    localPlayer.minimapSupport.setHighlightedVehicleModelType("exclamationMark")
    minimap.AddHighlightedVehicleModelUIDs(vehicles)
    minimap.SetHighlightedVehicles(true)
  else
    minimap.SetHighlightedVehicles(false)
  end
end
local spoolcenterset = false
local firstTimePrompt = true
local displayingShiftReminder = false
local showIcam = true
local playGPMV00_SEQUENCE_L_1 = true
local lastCrashTime
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
  [2] = " Large"
}
local nextSize = 1
local nextDistance = 1
local nextDirection = 1
local currentRequiredVehicles = 3
local spawnTimer = 3
local lastSpawnTime = 0
local allowLarge = false
local allLarge = false
missionSetupData["Wrecked evidence"].initiate = function(instance)
  firstTimePrompt = true
  showIcam = true
  playGPMV00_SEQUENCE_L_1 = true
  lastCrashTime = 0
  nextDistance = 1
  nextDirection = 1
  nextSize = 1
  currentRequiredVehicles = 3
  spawnTimer = 3
  lastSpawnTime = 0
  allowLarge = false
  allLarge = false
  displayingShiftReminder = false
  createFixedPosition(instance, {
    spawnPositions["Wrecked evidence truck spawn"].position
  }, 1)
  createFixedPosition(instance, {
    softSaveStartPositions["Wrecked evidence"][1].Evidence.position
  }, 2)
  createCheckpoints(instance)
  local vehicleAgent = instance.taskObjectsByActorID.Evidence.coreData.agent
  vehicleAgent.blockTow = false
  garage.enable(false)
  vehicleAgent.zapToTowingVehicle = true
  GameVehicleResource.setBurntOut(vehicleAgent.gameVehicle, true)
  GameVehicleResource.setDirtValue({
    gameVehicle = vehicleAgent.gameVehicle,
    dirt = 1
  })
  vehicleAgent.gameVehicle.steeringTweak = 0.4
  vehicleAgent.gameVehicle.engineTweak = 0.39
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    if softSaveData.progression == 1 then
      feedbackSystem.menusMaster.setCurrentFocusString(3)
      localPlayer:blockAbility("zapReturn", true)
      GameVehicleResource.setInfiniteMass(vehicleAgent.gameVehicle, true)
      vehicleAgent.blockTow = true
      zapcontroller.AddLockedVehicle({
        gameVehicle = vehicleAgent.gameVehicle
      })
      localPlayer:enterCutsceneMode()
    end
  else
    feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01", nil, "missionCritical")
    highlightVehicles(true)
    localPlayer:setBlockWagglePrompt(true)
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
local function getNextDistance(instance)
  local current700 = 0
  local current1000 = 0
  local nextDistance
  for actorID, v in next, instance.taskObjectsByActorID, nil do
    if string.find(actorID, tostring(distances[1])) then
      current700 = current700 + 1
    else
      current1000 = current1000 + 1
    end
  end
  if current700 < current1000 then
    nextDistance = 1
  else
    nextDistance = 2
  end
  return nextDistance
end
local getSpawnedVehicles = function(instance)
  local currentSpawnedVehicles = 0
  for actorID, data in next, instance.taskObjectsByActorID, nil do
    if data.coreData.actor.team == "Siege team" and not data.coreData.agent.disabled == true then
      currentSpawnedVehicles = currentSpawnedVehicles + 1
    end
  end
  return currentSpawnedVehicles
end
local function spawnNextVehicle(instance)
  if lastSpawnTime + spawnTimer <= g_NetworkTime and getSpawnedVehicles(instance) < currentRequiredVehicles or getSpawnedVehicles(instance) == 0 and not localPlayer.inCutsceneOrIcam then
    local respawn = false
    if checkValidDirection(instance, nextDirection) then
      if allowLarge and allLarge then
        nextDistance = 2
      else
        nextDistance = getNextDistance(instance)
      end
      if nextDistance == 2 and allowLarge then
        nextSize = 2
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
      challengeSystem.spawnActors(instance, "Never", {
        ["Siege car " .. distances[nextDistance] .. " " .. directions[nextDirection]] = true
      })
      if nextSize == 2 then
        challengeSystem.spawnActors(instance, "Never", {
          ["Siege car " .. distances[nextDistance] .. " " .. directions[nextDirection] .. sizes[nextSize]] = true
        })
      end
      OneShotSound.Play("HUD_Gen_NewEnemy_Alert_OneShot", false)
      if nextSize == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP03_ZAP_R_2", nil, "timeSensitive")
      end
      if nextDirection < #directions then
        nextDirection = nextDirection + 1
      else
        nextDirection = 1
      end
    end
  elseif getSpawnedVehicles(instance) >= currentRequiredVehicles then
    removeUserUpdateFunction("Spawner")
  end
end
missionSetupData["Wrecked evidence"].update = nil
local getEvidenceTeamDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Towed or Close" or task.specialName == "Spawn 2nd Attackers Pt 2" or task.specialName == "Spawn 1st Attackers Pt 2" or task.specialName == "Spawn 3rd Attackers Pt 2" or task.specialName == "Audio - Play locked in" then
    if dynamicListID then
      return checkpointSystem.getCheckpoints(task.instance, 2), true
    else
      return checkpointSystem.getCheckpoints(task.instance, 2), false
    end
  elseif task.specialName == "Near to Mission TowTruck" or task.specialName == "Audio - Play waiting for" or task.specialName == "Audio - Play chatter" then
    if dynamicListID then
      return false, true
    else
      return {
        task.instance.taskObjectsByActorID["Tow Truck"].coreData.agent
      }, false
    end
  elseif task.specialName == "Player At Lab" or task.specialName == "reach police perimeter" or task.specialName == "Near to Lab" or task.specialName == "Towtruck At Lab" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 2), false
    end
  end
end
local getBadGuyDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "Drive To Evidence" then
    return {
      task.instance.taskObjectsByActorID["Tow Truck"].coreData.agent
    }, false
  elseif task.specialName == "stop chasing" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 2), false
    end
  elseif task.specialName == "Drive Away From Truck" then
    return checkpointSystem.getCheckpoints(task.instance, 1), false
  end
end
local getSiegeDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
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
    if teams["Evidence team"] then
      return teams["Evidence team"], false
    else
      return false, true
    end
  end
end
local cutSpeed = function(task, amountToSubtract)
  local traits = {}
  for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
    if string.find(actorID, "Siege") then
      traits.desiredSpeed = taskObject.coreData.actor.desiredSpeed - amountToSubtract
      ActiveLifeAI.setPersonalityTraits(task.instance.taskObjectsByActorID[actorID].coreData.agent.gameVehicle, traits)
    end
  end
end
missionSetupData["Wrecked evidence"].targetList = {
  ["Evidence team"] = getEvidenceTeamDynamicTargets,
  ["Bad Guy team"] = getBadGuyDynamicTargets,
  ["Siege team"] = getSiegeDynamicTargets,
  ["Truck team"] = getEvidenceTeamDynamicTargets
}
missionSetupData["Wrecked evidence"].goalComplete = function(taskObject, task, conditionKey)
  if task.specialName == "Wait for Police" then
    local prompt = {prompt = "", priority = 2}
    task.instance.timerHasFinished = true
    removeUserUpdateFunction("Spawner")
    if conditionKey == 1 then
      prompt.prompt = "ID:248730"
      prompt.priority = 2
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    elseif conditionKey == 2 then
      prompt.prompt = "ID:248731"
      prompt.priority = 1
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
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
      currentRequiredVehicles = 4
      spawnTimer = 3
      allowLarge = true
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243752", nil, false, false, false)
    elseif conditionKey == 2 then
      allowLarge = true
      allLarge = true
      currentRequiredVehicles = 4
      spawnTimer = 2.5
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243751", nil, false, false, false)
    end
    addUserUpdateFunction("Spawner", function()
      spawnNextVehicle(task.instance)
    end, 60)
  end
end
taskCompleteData["Wrecked evidence"] = {}
taskCompleteData["Wrecked evidence"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.Evidence.coreData.agent,
    driverIsTanner = false,
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235489"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.success then
    if task.specialName == "Towtruck setup" then
      GameVehicleResource.setInfiniteMass(task.agent.gameVehicle, true)
      zapcontroller.AddLockedVehicle({
        gameVehicle = taskObject.coreData.instance.taskObjectsByActorID["Tow Truck"].coreData.agent.gameVehicle
      })
    elseif task.specialName == "Towed or Close" then
      feedbackSystem.menusMaster.setCurrentFocusString(2)
      zapcontroller.RemoveLockedVehicle({
        gameVehicle = taskObject.coreData.instance.taskObjectsByActorID["Tow Truck"].coreData.agent.gameVehicle
      })
      GameVehicleResource.setInfiniteMass(taskObject.coreData.instance.taskObjectsByActorID["Tow Truck"].coreData.agent.gameVehicle, false)
      zapcontroller.AddLockedVehicle({
        gameVehicle = task.agent.gameVehicle
      })
      highlightVehicles(false)
      localPlayer:setBlockWagglePrompt(false)
    elseif task.specialName == "Is Towing Truck" then
      taskObject.coreData.agent:activateSiren()
    elseif task.specialName == "Spawn 1st Attackers Pt 2" then
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Bad Guy 1"] = true,
        ["Bad Guy 2"] = true
      })
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184607", nil, false, false, false)
    elseif task.specialName == "Spawn 2nd Attackers Pt 2" then
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Bad Guy 3"] = true
      })
    elseif task.specialName == "Spawn 3rd Attackers Pt 2" then
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Bad Guy 5"] = true,
        ["Bad Guy 6"] = true
      })
    elseif task.specialName == "Near to Lab" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184610", nil, false, false, false)
    elseif task.specialName == "Towtruck At Lab" then
      taskObject.coreData.agent:lockEmergencyBrakes(2)
    elseif task.specialName == "Player At Lab" then
      OneShotSound.Play("HUD_Play_Waypoint")
      local playPIP = function()
        localPlayer:enterCutsceneMode()
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_4", nil, "missionCritical")
      end
      local function setupScene()
        taskObject.coreData.agent.blockTow = true
        if taskObject.coreData.agent.gameVehicle.towingVehicle then
          GameVehicleResource.detachVehicle(taskObject.coreData.agent.gameVehicle)
        end
        for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
          if string.find(actorID, "Bad Guy") or string.find(actorID, "Tow") then
            if taskObject.coreData.agent.gameVehicle.towingVehicle then
              GameVehicleResource.detachVehicle(taskObject.coreData.agent.gameVehicle)
            end
            taskObject:delete(true)
          end
        end
        GameVehicleResource.ClearAreaOfVehicles(softSaveStartPositions["Wrecked evidence"][1].Evidence.position, 20)
        taskObject.coreData.agent:teleportToPositionAndHeading(softSaveStartPositions["Wrecked evidence"][1].Evidence.position, softSaveStartPositions["Wrecked evidence"][1].Evidence.heading, nil, nil, nil, false)
        GameVehicleResource.setInfiniteMass(task.agent.gameVehicle, true)
        feedbackSystem.menusMaster.setCurrentFocusString(3)
        localPlayer:SetZapLevel(1, nil, false)
        localPlayer:SetZapLevel(0, taskObject.coreData.agent, true)
        spooling.fadeIn(nil, nil, playPIP)
      end
      taskObject.coreData.agent.zapToTowingVehicle = false
      localPlayer:blockAbility("zapReturn", true)
      zapcontroller.AddLockedVehicle({
        gameVehicle = task.agent.gameVehicle
      })
      localPlayer:enterCutsceneMode()
      spooling.fadeOut(nil, nil, setupScene)
    elseif task.specialName == "Faded out" then
      Commentary.StopCommentary()
    elseif task.specialName == "Is PIP Finished" then
      CutsceneFiles.tutorials.playTutorial("ID:243694")
    elseif task.specialName == "softsave" then
      progressionSystem.triggerSoftSave({progression = 1})
      localPlayer:enterCutsceneMode()
      localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
      localPlayer.simulationSupport.doWait(0.09, function()
        localPlayer:SetZapLevel(zapLevelAfterTutorial, nil, false, {})
      end, "shiftWait")
    elseif task.specialName == "Finished Pushing Into Zap" then
      localPlayer:exitCutsceneMode()
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_6", nil, "missionCritical")
      if not spoolcenterset then
        spoolsystem.AddSpoolCentre(task.agent.gameVehicle.position)
        spoolsystem.SetSpoolCentreAttachment(1, task.agent.gameVehicle)
        GameVehicleResource.removeVehicleSimulationArea(task.agent.gameVehicle)
        GameVehicleResource.addVehicleSimulationArea(task.agent.gameVehicle, 40, 150, 10, 1, true)
        spoolcenterset = true
      end
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.primaryTextPrompt("ID: 243691")
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Siege car 1st Goon"] = true
      })
      feedbackSystem.startMusic("Uid01780_CH03_Standard_WreckedEvidence_Play")
    elseif task.specialName == "Set any updates" then
      taskObject.coreData.actor.ramStationaryDistance = 150
    elseif task.specialName == "Attacker Hits Prison Van" then
      if task.condition == 1 then
        GameVehicleResource.applyDamage({
          gameVehicle = taskObject.coreData.instance.taskObjectsByActorID.Evidence.coreData.agent.gameVehicle,
          damage = 0.25
        })
        if showIcam or taskObject.coreData.instance.taskObjectsByActorID.Evidence.coreData.agent.damage >= 0.85 then
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
          iCamCrashCam(taskObject.coreData.agent.gameVehicle)
          lastCrashTime = g_NetworkTime
        end
        if playGPMV00_SEQUENCE_L_1 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_1", nil, "missionCritical")
          playGPMV00_SEQUENCE_L_1 = false
        else
          playGPMV00_SEQUENCE_L_1 = true
        end
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
    elseif task.specialName == "Spawn Fake Cops" then
      cutSpeed(task, 15)
      Sound.OverrideAmbience("CopsOnTheWay")
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243693", false, false, false, false)
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_5", nil, "missionCritical")
    elseif task.specialName == "Stop near evidence" then
      task.agent:lockEmergencyBrakes(0.5)
    elseif task.specialName == "Wait for Police" then
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if string.find(actorID, "Siege") or string.find(actorID, "Cop") then
          if taskObject.coreData.agent.gameVehicle.towingVehicle then
            GameVehicleResource.detachVehicle(taskObject.coreData.agent.gameVehicle)
          end
          taskObject:delete()
        end
      end
      params.dialogue = "GPMV00_SUCCESS_L_1"
      params.rating = "PASS"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.actor.ID == "Evidence" or task.actor.ID == "Tow Truck" then
    if task.specialName == "Wait for Police" then
      params.dialogue = "GPMV00_FAILURE_L_1"
      params.hint = "ID:235499"
    elseif task.specialName == "Player At Lab" then
      params.dialogue = "GPMV00_FAILURE_L_2"
    elseif task.specialName == "Towtruck At Lab" or task.specialName == "Watch for towtruck damage" then
      params.dialogue = "GPMV01_FAILURE_L_1"
      params.reason = "Wrecked"
    end
    feedbackSystem.stopMusic("Uid01780_CH03_Standard_WreckedEvidence_Stop")
    params.rating = "FAIL"
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Wrecked evidence"] = function(instance)
  removeUserUpdateFunction("fadeIn")
  removeUserUpdateFunction("shiftWait")
  removeUserUpdateFunction("Spawner")
  Sound.RestoreAmbience()
  if instance.taskObjectsByActorID["Tow Truck"] then
    zapcontroller.RemoveLockedVehicle({
      gameVehicle = instance.taskObjectsByActorID["Tow Truck"].coreData.agent.gameVehicle
    })
    GameVehicleResource.setInfiniteMass(instance.taskObjectsByActorID["Tow Truck"].coreData.agent.gameVehicle, false)
  end
  if instance.taskObjectsByActorID.Evidence then
    instance.taskObjectsByActorID.Evidence.coreData.agent.zapToTowingVehicle = false
    zapcontroller.RemoveLockedVehicle({
      gameVehicle = instance.taskObjectsByActorID.Evidence.coreData.agent.gameVehicle
    })
    GameVehicleResource.setInfiniteMass(instance.taskObjectsByActorID.Evidence.coreData.agent.gameVehicle, false)
  end
  localPlayer:blockAbility("zapReturn", false)
  garage.enable(true)
  localPlayer.autoZapOnTow = false
  highlightVehicles(false)
  localPlayer:setBlockWagglePrompt(false)
  minimap.RemoveAllHighlightedVehicleModelUIDs()
  if spoolcenterset then
    spoolsystem.RemoveSpoolCentre(1)
    spoolsystem.SetSpoolCentreAttachment(1, nil)
    GameVehicleResource.removeVehicleSimulationArea(instance.taskObjectsByActorID.Evidence.coreData.agent.gameVehicle)
    spoolcenterset = false
  end
end
