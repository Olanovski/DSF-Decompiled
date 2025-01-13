module("cardSystem.logic")
missionSetupData["Final destination"] = {}
local targetDisplaySpeed, targetSpeed = feedbackSystem.mphToLocalisedSpeed(60)
local function createPayloadMinorOrder(goalParams, HUD, audio, specialName)
  local minorOrder = {
    task = "Payload Tracking With Multiplyer",
    coreData = {upper = 100, lower = 0},
    specialName = specialName,
    startingValues = {payload = 0},
    groupProgression = {priorityMinorOrder = true},
    goalConditions = {
      {
        failCondition = true,
        autoRefresh = true,
        {
          goal = "Above speed",
          params = {value = targetSpeed}
        },
        {
          goal = "Time trigger",
          params = {value = 0.2}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Below speed",
          params = {value = targetSpeed}
        },
        {
          goal = "Time trigger",
          params = {value = 0.1}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Damage has changed by",
          params = {value = 0.002}
        },
        {
          goal = "Change payload by amount",
          params = {value = 9}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Damage has changed by",
          params = {value = 0.0015}
        },
        {
          goal = "Damage has changed by",
          params = {value = 0.00199, inverse = true}
        },
        {
          goal = "Change payload by amount",
          params = {value = 7}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Damage has changed by",
          params = {value = 0.001}
        },
        {
          goal = "Damage has changed by",
          params = {value = 0.00149, inverse = true}
        },
        {
          goal = "Change payload by amount",
          params = {value = 5}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Damage has changed by",
          params = {value = 0.0005}
        },
        {
          goal = "Damage has changed by",
          params = {value = 0.000999, inverse = true}
        },
        {
          goal = "Change payload by amount",
          params = {value = 4}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Damage has changed by",
          params = {value = 0.0002}
        },
        {
          goal = "Damage has changed by",
          params = {value = 0.000499, inverse = true}
        },
        {
          goal = "Change payload by amount",
          params = {value = 2}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Time trigger",
          params = {value = 2}
        },
        {
          goal = "Simple collision check",
          params = {
            whereIHit = "Front",
            whereIWasHit = "Front",
            force = 30000
          }
        },
        {
          goal = "Change payload by amount",
          params = {value = 17}
        }
      },
      {
        triggerCount = 4,
        {
          goal = "Recent audio played",
          params = {value = 1}
        },
        {
          goal = "Payload over",
          params = {value = 50, increment = 0}
        },
        {
          goal = "Simple collision check",
          params = {whereIWasHit = "Front", force = 4000}
        }
      },
      {
        triggerCount = 1,
        {
          goal = "Recent audio played",
          params = {value = 3}
        },
        {
          goal = "Payload over",
          params = {value = 85, increment = 0}
        }
      },
      {
        triggerCount = 3,
        {
          goal = "Recent audio played",
          params = {value = 3}
        },
        {
          goal = "Is player controlled"
        },
        {
          goal = "Payload has decreased",
          params = {value = 0}
        },
        {
          goal = "Payload under",
          params = {value = 0, increment = 0}
        }
      },
      {
        {
          goal = "Payload between",
          params = {lowest = 0, highest = 20}
        },
        {
          goal = "Change payload multiplyers",
          params = {upMultiplyer = 2, downMultiplyer = 0.4}
        }
      },
      {
        {
          goal = "Payload between",
          params = {lowest = 20, highest = 40}
        },
        {
          goal = "Change payload multiplyers",
          params = {upMultiplyer = 1.5, downMultiplyer = 0.6}
        }
      },
      {
        {
          goal = "Payload between",
          params = {lowest = 40, highest = 60}
        },
        {
          goal = "Change payload multiplyers",
          params = {upMultiplyer = 1, downMultiplyer = 0.9}
        }
      },
      {
        {
          goal = "Payload between",
          params = {lowest = 60, highest = 80}
        },
        {
          goal = "Change payload multiplyers",
          params = {upMultiplyer = 0.5, downMultiplyer = 1.3}
        }
      },
      {
        {
          goal = "Payload between",
          params = {lowest = 80, highest = 101}
        },
        {
          goal = "Change payload multiplyers",
          params = {upMultiplyer = 0.3, downMultiplyer = 1.7}
        }
      }
    },
    taskConditions = {
      {
        forceTaskComplete = true,
        failCondition = true,
        {
          goal = "Payload over",
          params = {value = 100}
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
    HUD = {
      {
        style = "FinalDestination hud"
      }
    },
    audioPIP = audio
  }
  return minorOrder
end
local function createEndPayloadMinorOrder(goalParams, HUD, audio)
  local minorOrder = {
    task = "Payload Tracking",
    coreData = {upper = 100, lower = 0},
    specialName = "Final payload",
    startingValues = {payload = 0},
    goalConditions = {
      {
        autoRefresh = true,
        {
          goal = "Below speed",
          params = {value = targetSpeed}
        },
        {
          goal = "Time trigger",
          params = {value = 0.25}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Time trigger",
          params = {value = 2}
        },
        {
          goal = "Damage has changed by",
          params = {value = 0.02}
        },
        {
          goal = "Change payload by amount",
          params = {value = 40}
        }
      }
    },
    taskConditions = {
      {
        failCondition = true,
        {
          goal = "Payload over",
          params = {value = 100}
        }
      }
    },
    HUD = {
      {
        style = "FinalDestination hud"
      }
    },
    audioPIP = audio
  }
  return minorOrder
end
local function bigRigTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Mission start",
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
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
        HUD = {
          {
            style = "FinalDestination hud"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Slow start",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 6}
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
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "drive to quiet spot",
        groupProgression = {priorityMinorOrder = true},
        dynamicTargets = true,
        coreData = {totalLaps = 0},
        goalConditions = {
          {
            {
              goal = "Agent stopped inside radius",
              params = {value = 11}
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
        }
      },
      {
        task = "No AI",
        specialName = "Text prompt 1",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Text prompt 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 6.5}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Zapped out",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player just zapped out of specified actors",
              params = {
                actors = {"Big Rig"}
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Almost at alley",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        coreData = {totalLaps = 0},
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
        HUD = {
          {
            style = "FinalDestination hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio sequence",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 30}
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
        specialName = "Audio sequence2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 90}
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
        specialName = "PIP 2 play",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 60}
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
        specialName = "speed check",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Instance time above",
              params = {value = 25}
            },
            {
              goal = "Above speed",
              params = {value = targetSpeed}
            }
          },
          {
            {
              goal = "Instance time above",
              params = {value = 25}
            },
            {
              goal = "Below speed",
              params = {value = targetSpeed}
            }
          }
        },
        HUD = {
          {
            style = "FinalDestination hud"
          }
        }
      },
      [15] = createPayloadMinorOrder(goalParams, HUD, audio, "payload task 1")
    },
    {
      {
        task = "No AI",
        specialName = "Wait for zap transition",
        taskConditions = {
          {
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
        task = "No functionality",
        specialName = "softsave",
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
        task = "Payload Tracking",
        startingValues = {payload = 100},
        dynamicTargets = true,
        specialName = "bomb ticking",
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Drive under trailer",
              params = {
                timer = 2,
                bufferTime = 1,
                self = true
              },
              feedback = "Time"
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
          },
          {
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {}
              }
            }
          }
        },
        HUD = {
          {
            style = "FinalDestination hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Find a car text prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5, takeZapIntoAccount = true}
            }
          }
        },
        HUD = {
          {
            style = "FinalDestination hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Zap audio - find car",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "In small civilian",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Changed vehicle"
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Current vehicle height is less than",
              params = {value = 1.5}
            },
            {
              goal = "Player is none of actors specified",
              params = {
                actorIDs = {"Big Rig"},
                notSameVehicle = true
              }
            }
          }
        },
        HUD = {
          {
            style = "FinalDestination hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "In shift",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {levelOfZap = 1}
            }
          }
        },
        HUD = {
          {
            style = "FinalDestination hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "In large civilian",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Changed vehicle"
            },
            {
              goal = "Current vehicle height is less than",
              params = {value = 1.5, inverse = true}
            },
            {
              goal = "Player is none of actors specified",
              params = {
                actorIDs = {"Big Rig"},
                notSameVehicle = true
              }
            }
          }
        },
        audioPIP = audio
      },
      [12] = createEndPayloadMinorOrder(goalParams, HUD, audio)
    },
    {
      {
        task = "No AI",
        specialName = "last second",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.25}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Final destination"].taskCreatorFunctionLookups = {
  ["Big rig team"] = bigRigTask
}
local getToLocation = "ID:231516"
local getToLocation2 = "ID:231391"
local stopInArea = "ID:186119"
local endLocation = vec.vector(-2339.052, 176.706, 3822.055, 1)
local towedGameVehicle
missionSetupData["Final destination"].initiate = function(instance)
  InterestingVehicleManager.Enable(false)
  Start_Under_Trailer_Camera()
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    scoreSystem.maxAbility()
    localPlayer:blockAbility("zapReturn", true)
    zapcontroller.AddLockedVehicle({
      gameVehicle = instance.taskObjectsByActorID["Big Rig"].coreData.agent.gameVehicle
    })
    localPlayer:SetZapLevel(1)
    feedbackSystem.menusMaster.setNextFocusString()
    feedbackSystem.menusMaster.setNextFocusString()
    feedbackSystem.startMusic("Uid00408_CH06_Standard_HandleWithCare_Play")
  else
    localPlayer:blockAbility("zap", true)
    localPlayer:blockAbility("zapReturn", false)
  end
  createFixedPosition(instance, {endLocation}, 44)
  GameVehicleResource.ClearAreaOfVehicles(instance.taskObjectsByActorID["Big Rig"].coreData.agent.gameVehicle.position, 100)
  towedGameVehicle = instance.taskObjectsByActorID["Big Rig"].coreData.agent.gameVehicle
  GameVehicleResource.setBombVisible(towedGameVehicle, "Child", true)
  GameVehicleResource.setAttachedBombState(towedGameVehicle, "Child", true)
  propSystem.setupRuntimeProps("Final destination", false, false)
  local focusText = {
    ["ID:186124"] = {
      [1] = targetDisplaySpeed
    }
  }
  feedbackSystem.menusMaster.setFocusButtonText(focusText)
end
missionSetupData["Final destination"].update = nil
local getBigRigTeamDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Slow start" or task.specialName == "drive to quiet spot" or task.specialName == "Almost at alley" or task.specialName == "bomb ticking" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 44), false
    end
  end
end
missionSetupData["Final destination"].targetList = {
  ["Big rig team"] = getBigRigTeamDynamicTargets
}
missionEndCallback["Final destination"] = function(instance)
  localPlayer:blockAbility("zapReturn", false)
  localPlayer:blockAbility("zap", false)
  InterestingVehicleManager.Enable(true)
  Stop_Under_Trailer_Camera()
  GameVehicleResource.setBombVisible(towedGameVehicle, false)
  minimap.SetHighlightedVehicles(false)
  minimap.RemoveAllHighlightedVehicleModelUIDs()
  localPlayer.minimapSupport.highlightedVehicles = false
end
taskCompleteData["Final destination"] = {}
taskCompleteData["Final destination"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID["Big Rig"].coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    rating = "PASS",
    hint = "ID:248754",
    hintIcon1 = localPlayer.buttonLayout.minimapZoom,
    driverIsTanner = false
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.specialName == "Almost at alley" then
    feedbackSystem.menusMaster.primaryTextPrompt(stopInArea, nil, true, false, false)
    feedbackSystem.menusMaster.setNextFocusString()
  elseif task.specialName == "Text prompt 1" then
    feedbackSystem.menusMaster.primaryTextPrompt(getToLocation, targetDisplaySpeed, false, false, false)
  elseif task.specialName == "Text prompt 2" then
    feedbackSystem.menusMaster.primaryTextPrompt(getToLocation2, nil, false, false, false)
  elseif task.specialName == "drive to quiet spot" then
    if task.success then
      if localPlayer.inZap or localPlayer.currentVehicle ~= task.agent then
        task.agent.gameVehicle.speed = 0
      end
      localPlayer:blockAbility("zapReturn", true)
      zapcontroller.AddLockedVehicle({
        gameVehicle = taskObject.coreData.agent.gameVehicle
      })
      feedbackSystem.menusMaster.setNextFocusString()
      if Getaway.IsBeingChased(task.agent.gameVehicle) then
        Getaway.Stop(task.agent.gameVehicle)
      end
    else
      params.rating = "FAIL"
      params.dialogue = "GPMV01_FAILURE_L_1"
      params.failReason = "ID:184015"
      params.reason = "Wrecked"
      GameVehicleResource.ClearAreaOfVehicles(task.agent.gameVehicle.position, 50)
      GameVehicleResource.explode({
        gameVehicle = task.agent.gameVehicle,
        attachedVehicle = "Both",
        offset = vec.vector(1, 0, 0, 1),
        range = 1,
        strength = 500
      })
      params.callback = failTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "Wait for zap transition" then
    if task.agent.controlled then
      localPlayer:SetZapLevel(1)
    end
  elseif task.specialName == "Slow start" then
    if not task.success then
      params.rating = "FAIL"
      params.dialogue = "GPMV01_FAILURE_L_1"
      params.failReason = "ID:184015"
      params.reason = "Wrecked"
      params.callback = failTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "softsave" then
    progressionSystem.triggerSoftSave({progression = 1})
  elseif task.specialName == "payload task 1" then
    params.rating = "FAIL"
    params.dialogue = "GPMV01_FAILURE_L_1"
    if 1 <= taskObject.coreData.agent.gameVehicle.damage then
      params.failReason = "ID:184015"
      params.reason = "Wrecked"
    else
      GameVehicleResource.applyDamage({
        gameVehicle = taskObject.coreData.agent.gameVehicle,
        damage = 1
      })
    end
    GameVehicleResource.ClearAreaOfVehicles(task.agent.gameVehicle.position, 50)
    GameVehicleResource.explode({
      gameVehicle = task.agent.gameVehicle,
      attachedVehicle = "Both",
      offset = vec.vector(1, 0, 0, 1),
      range = 1,
      strength = 500
    })
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "bomb ticking" then
    if task.success then
      GameVehicleResource.setAttachedBombState(towedGameVehicle, "Child", false)
      params.vehicle = localPlayer.currentVehicle
      params.driverIsTanner = true
      params.rating = "PASS"
      params.callback = completeTask
      params.dialogue = "GPMV00_SUCCESS_L_1"
      Stop_Under_Trailer_Camera()
      localPlayer.challenge.endScreen(taskObject, params)
    else
      GameVehicleResource.setBombVisible(trailer, false)
      GameVehicleResource.ClearAreaOfVehicles(task.agent.gameVehicle.position, 50)
      GameVehicleResource.explode({
        gameVehicle = task.agent.gameVehicle,
        attachedVehicle = "Both",
        offset = vec.vector(1, 0, 0, 1),
        range = 1,
        strength = 500
      })
      params.hint = "ID:236262"
      params.rating = "FAIL"
      params.dialogue = "GPMV00_FAILURE_L_1"
      Stop_Under_Trailer_Camera()
      GameVehicleResource.applyDamage({
        gameVehicle = task.agent.gameVehicle,
        damage = 1
      })
      params.callback = failTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "Final payload" then
    localPlayer:SetZapLevel(1)
    GameVehicleResource.setBombVisible(trailer, false)
    GameVehicleResource.ClearAreaOfVehicles(task.agent.gameVehicle.position, 50)
    GameVehicleResource.explode({
      gameVehicle = task.agent.gameVehicle,
      attachedVehicle = "Both",
      offset = vec.vector(1, 0, 0, 1),
      range = 1,
      strength = 500
    })
    params.hint = "ID:236262"
    params.rating = "FAIL"
    params.dialogue = "GPMV00_FAILURE_L_1"
    GameVehicleResource.applyDamage({
      gameVehicle = task.agent.gameVehicle,
      damage = 1
    })
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
