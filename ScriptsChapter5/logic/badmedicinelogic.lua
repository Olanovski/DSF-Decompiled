module("cardSystem.logic")
missionSetupData["Bad medicine"] = {}
local chaserTask = function(goalParams, HUD, audio)
  local taskList = {
    {
      {
        task = "Wander",
        specialName = "Initial pause",
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
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Bad medicine hud"
          }
        }
      }
    },
    {
      {
        task = "Non-linear Checkpoints",
        specialName = "Get to boxes",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 22}
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
              params = {value = 1}
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
        specialName = "first prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "First PiP",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 4.5}
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
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 15}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Small pause",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
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
        }
      }
    },
    {
      {
        task = "Follow Route",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        specialName = "Destroy boxes",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Agent stopped inside radius",
              params = {
                value = 12,
                unlockBrakes = true,
                stopDuration = 1.2
              }
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
            {
              goal = "Instance dynamic time above"
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
        }
      },
      {
        task = "No AI",
        specialName = "Display timer",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Mission part 2 - First text prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Mission part 2 - Update focus text",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 4}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Mission part 2 - Second text prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Allow time update",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 12.5}
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Soft save",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine hud"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Non-linear Chase",
        specialName = "Chase convoy",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Target damage above",
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
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Bad medicine hud"
          }
        }
      },
      {
        task = "Payload Tracking",
        specialName = "Use oncoming reminder",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 20}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Changed vehicle"
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "In mission vehicle",
              params = {inverse = true}
            },
            {
              goal = "Against traffic flow"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Payload over",
              params = {value = 3}
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Trucks text prompt 1",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 6}
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Trucks text prompt 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 10}
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Audio - Player In Zap Chase Convoy",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = true}
            }
          },
          {
            {
              goal = "Player in zap",
              params = {value = false}
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return taskList
end
local racerTask = function(goalParams, HUD)
  local taskList = {
    enableNonPlayerFeedback = true,
    {
      {
        task = "Linear Checkpoints",
        specialName = "Convoy race",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 22}
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
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Within radius",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
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
        }
      },
      {
        task = "No AI",
        specialName = "Within 1/3 radius",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 1000}
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
        specialName = "Bugger we have tipped over",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Agent tipped over"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Display trucks counter",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
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
        HUD = {
          {
            style = "Bad medicine hud"
          }
        }
      }
    }
  }
  return taskList
end
local guardTask = function(goalParams, HUD)
  local task = {
    deleteVehicleOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "Stopped trucks",
        taskConditions = {
          {
            {
              goal = "Actor is in major order",
              params = {
                actorID = "Attacker1 (Actor)",
                value = {5}
              }
            }
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Bad medicine"].taskCreatorFunctionLookups = {
  ["Race team"] = racerTask,
  ["Chase team"] = chaserTask,
  ["Guard team"] = guardTask
}
local boxesPosition = vec.vector(2154.722, 27.587, -4059.148, 1)
local triggerTruckPosition = vec.vector(1294.954, 30.014, -4199.823, 1)
local docksLocation = vec.vector(715.721, 5.484, -2289.579, 1)
local rtpropIDs, docksLocationMarker
local vehiclesWrecked = 0
local firstRadiusTriggered = false
local secondRadiusTriggered = false
missionSetupData["Bad medicine"].initiate = function(instance)
  instance.allowBonusDisplay = false
  instance.timeLimit = 30
  createCheckpoints(instance)
  createFixedPosition(instance, {docksLocation}, 4)
  local softSaveData = progressionSystem.getSoftSaveData()
  if not softSaveData then
    createFixedPosition(instance, {boxesPosition}, 2)
    createFixedPosition(instance, {triggerTruckPosition}, 99)
    challengeSystem.spawnActors(instance, "Never", {
      ["StoppedConvoy1 (Actor)"] = true,
      ["StoppedConvoy2 (Actor)"] = true,
      ["StoppedConvoy3 (Actor)"] = true,
      ["StoppedConvoy4 (Actor)"] = true,
      ["StoppedConvoy5 (Actor)"] = true
    })
    challengeSystem.spawnActors(instance, "Never", {
      ["StoppedConvoy6 (Actor)"] = true,
      ["StoppedConvoy7 (Actor)"] = true,
      ["StoppedConvoy8 (Actor)"] = true,
      ["StoppedConvoy9 (Actor)"] = true
    })
  else
    instance.rubberbandRoute = "Bad medicine route"
    feedbackSystem.menusMaster.setCurrentFocusString(3)
  end
  vehiclesWrecked = 0
  firstRadiusTriggered = false
  secondRadiusTriggered = false
  instance.taskObjectsByActorID["Attacker1 (Actor)"].coreData.actor.routeName = nil
end
missionSetupData["Bad medicine"].update = nil
local getRaceTeamDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName ~= "Within radius" and task.specialName ~= "Within 1/3 radius" then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
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
  elseif dynamicListID then
    return false, true
  else
    return checkpointSystem.getCheckpoints(task.instance, 4), false
  end
end
local function getChaseTeamDynamicTargets(taskObject, task, dynamicListID)
  if task.specialName == "Chase convoy" then
    if dynamicListID then
      if #task.dynamicTargets > 1 then
        return false, false
      else
        return false, true
      end
    else
      rtpropIDs = rtpropIDs or {}
      for actorID, vehicletaskObject in next, task.instance.taskObjectsByActorID, nil do
        if vehicletaskObject.coreData.actor.team == "Race team" then
          rtpropIDs = rtpropIDs or {}
          rtpropIDs[actorID] = PropSystem.CreateRuntimeProps({
            {
              modelUID = "0x2A26F71898721240",
              position = vec.vector(0.7, 1.2, -0.4, 1),
              zaxis = vec.vector(-1, 0, 0, 0),
              movementLimits = vec.vector(0.1, 0.1, 0.1, 0),
              attachVehicle = vehicletaskObject.coreData.agent.gameVehicle
            },
            {
              modelUID = "0x2A26F71898721240",
              position = vec.vector(0.7, 1.2, -2.9, 1),
              zaxis = vec.vector(-1, 0, 0, 0),
              movementLimits = vec.vector(0.1, 0.1, 0.1, 0),
              attachVehicle = vehicletaskObject.coreData.agent.gameVehicle
            }
          })
        end
      end
      local teams = {}
      for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
        teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
        table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
      end
      return teams["Race team"], false
    end
  elseif task.specialName == "Get to boxes" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 2), false
    end
  elseif task.specialName == "Destroy boxes" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 99), false
    end
  end
end
missionSetupData["Bad medicine"].targetList = {
  ["Race team"] = getRaceTeamDynamicTargets,
  ["Chase team"] = getChaseTeamDynamicTargets
}
taskCompleteData["Bad medicine"] = {}
taskCompleteData["Bad medicine"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID["Attacker1 (Actor)"].coreData.agent,
    driverIsTanner = true,
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235496"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix, perfect)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  local function playAudio()
    if vehiclesWrecked == 1 then
      local promptParams = {
        prompt = "ID:235443",
        delay = false,
        priority = 2
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
      if task.instance.taskObjectsByActorID["Attacker1 (Actor)"].coreData.agent.controlled then
        feedbackSystem.eventFeedback(task.instance.taskObjectsByActorID["Attacker1 (Actor)"].coreData.agent, "GPMV01_SEQUENCE_L_7")
      end
    elseif vehiclesWrecked == 2 then
      local promptParams = {
        prompt = "ID:235442",
        delay = false,
        priority = 2
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
      if task.instance.taskObjectsByActorID["Attacker1 (Actor)"].coreData.agent.controlled then
        feedbackSystem.eventFeedback(task.instance.taskObjectsByActorID["Attacker1 (Actor)"].coreData.agent, "GPMV01_SEQUENCE_L_8")
      end
    end
  end
  if task.success then
    if task.specialName == "Soft save" then
      local function turnOnSiren()
        if not task.agent.siren then
          task.agent:activateSiren()
        end
      end
      feedbackSystem.menusMaster.setCurrentFocusString(3)
      progressionSystem.triggerSoftSave({progression = 1})
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Convoy1 (Actor)"] = true,
        ["Convoy2 (Actor)"] = true,
        ["Convoy3 (Actor)"] = true
      })
      GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID["Convoy1 (Actor)"].coreData.agent.gameVehicle.position, 10)
      GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID["Convoy2 (Actor)"].coreData.agent.gameVehicle.position, 10)
      GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID["Convoy3 (Actor)"].coreData.agent.gameVehicle.position, 10)
      feedbackSystem.eventFeedback(task.agent, "PIP02", turnOnSiren)
      iCamFlyToCamPosition(task.instance.taskObjectsByActorID["Convoy1 (Actor)"].coreData.agent.gameVehicle.position + vec.vector(-4, 0, 4, 0))
      propSystem.cleanupRuntimeProps()
      task.actor.obeyRaceTowingRules = true
    elseif task.specialName == "Get to boxes" then
      propSystem.setupRuntimeProps("bad medicine", true, true)
      if not task.agent.controlled then
        localPlayer:zapToAgent(task.agent)
      end
    elseif task.specialName == "Small pause" then
      task.instance.softsaveStartTime = g_NetworkTime - 3 + 0.5
      task.actor.routeName = "Bad medicine cop route"
    elseif task.specialName == "Mission part 2 - Update focus text" then
      feedbackSystem.menusMaster.setNextFocusString()
    elseif task.specialName == "Destroy boxes" then
      feedbackSystem.taskSuccessAudio()
      removeUserUpdateFunction("propWatch")
      if not task.agent.controlled then
        localPlayer:zapToAgent(task.agent)
      end
    elseif task.specialName == "Convoy race" then
      if 1 <= task.instance.taskObjectsByActorID["Attacker1 (Actor)"].coreData.agent.gameVehicle.damage then
        params.vehicle = task.agent
        params.driverIsTanner = false
      else
        params.vehicle = task.instance.taskObjectsByActorID["Attacker1 (Actor)"].coreData.agent
      end
      params.completeReason = params.failReason
      params.callback = failTask
      params.rating = "FAIL"
      params.dialogue = "GPMV00_FAILURE_L_1"
      params.hint = "ID:235487"
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "Chase convoy" then
      if docksLocationMarker then
        feedbackSystem.clearTarget(docksLocationMarker)
        docksLocationMarker = nil
      end
      params.callback = completeTask
      params.rating = "PASS"
      if 1 > task.agent.gameVehicle.damage and task.agent == localPlayer.currentVehicle then
        params.dialogue = "GPMV00_SUCCESS_L_1"
        params.vehicle = task.agent
      else
        params.vehicle = localPlayer.currentVehicle
        params.dialogue = "GPMV00_SUCCESS_L_2"
      end
      local function endSlowdown()
        if not taskObject then
          removeUserUpdateFunction("Pause complete while slowdown active")
        elseif not localPlayer.inCutscene then
          localPlayer.challenge.endScreen(taskObject, params)
          removeUserUpdateFunction("Pause complete while slowdown active")
        end
      end
      addUserUpdateFunction("Pause complete while slowdown active", endSlowdown, 4)
    elseif task.specialName == "Within 1/3 radius" and not firstRadiusTriggered then
      firstRadiusTriggered = true
      local promptParams = {
        prompt = "ID:184879",
        delay = false,
        priority = 2
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
      feedbackSystem.eventFeedback(task.instance.taskObjectsByActorID["Attacker1 (Actor)"].coreData.agent, "GPMV01_SEQUENCE_L_5")
    elseif task.specialName == "Within radius" and not secondRadiusTriggered then
      secondRadiusTriggered = true
      local promptParams = {
        prompt = "ID:235450",
        delay = false,
        priority = 2
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
      feedbackSystem.eventFeedback(task.instance.taskObjectsByActorID["Attacker1 (Actor)"].coreData.agent, "GPMV01_SEQUENCE_L_6")
    elseif task.specialName == "Bugger we have tipped over" then
      GameVehicleResource.applyDamage({
        gameVehicle = task.agent.gameVehicle,
        damage = 1
      })
    elseif task.specialName == "Trucks text prompt 1" and not docksLocationMarker then
      docksLocationMarker = feedbackSystem.newTarget({position = docksLocation}, "Hotspot")
    end
  elseif task.specialName == "Initial pause" or task.specialName == "Get to boxes" or task.specialName == "Small pause" then
    params.hint = "ID:235485"
    params.callback = failTask
    params.rating = "FAIL"
    params.failReason = "ID:184950"
    params.reason = "Wrecked"
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "Destroy boxes" then
    params.vehicle = localPlayer.currentVehicle
    params.callback = failTask
    params.rating = "FAIL"
    if task.condition == 2 then
      params.failReason = "ID:184950"
      params.reason = "Wrecked"
    elseif task.condition == 3 then
      params.failReason = "ID:184719"
    end
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "Convoy race" then
    vehiclesWrecked = vehiclesWrecked + 1
    iCamCrashCam(task.agent.gameVehicle, playAudio)
    local localDesiredSpeed = 55
    local localDamageMultiplier = 1.5
    local localAvoidAttacks = false
    local localCollisionResilience = "Average"
    local localPerformance = 1
    local localMaintainLane = true
    local localAiIgnorePlayerInCivsUntilHit = true
    if vehiclesWrecked == 1 then
      localDesiredSpeed = 80
      localDamageMultiplier = 1.4
      localCollisionResilience = "Tough"
      localMaintainLane = false
    elseif vehiclesWrecked == 2 then
      localDesiredSpeed = 100
      localDamageMultiplier = 1.3
      localAvoidAttacks = true
      localCollisionResilience = "Very tough"
      localPerformance = 1.25
      localMaintainLane = false
      localAiIgnorePlayerInCivsUntilHit = false
    end
    if vehiclesWrecked < 3 then
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == "Race team" then
          taskObject.coreData.agent:stopHighSpeedDriving()
          taskObject.coreData.agent:set_damageMultiplier(damageMultiplier)
          taskObject.coreData.agent.gameVehicle.performance = localPerformance
          taskObject.coreData.actor.desiredSpeed = localDesiredSpeed
          taskObject.coreData.actor.avoidAttacks = localAvoidAttacks
          taskObject.coreData.actor.collisionResilience = localCollisionResilience
          taskObject.coreData.actor.maintainLane = localMaintainLane
          taskObject.coreData.actor.aiIgnorePlayerInCivsUntilHit = localAiIgnorePlayerInCivsUntilHit
          local behaviour = {
            traits = taskSystem.buildDriveTraits(task),
            roadRoute = routes[taskObject.coreData.actor.routeName].roads,
            routeName = taskObject.coreData.actor.routeName
          }
          taskObject.coreData.agent:highSpeedDrive(behaviour)
        end
      end
    end
  end
end
missionEndCallback["Bad medicine"] = function(instance)
  instance.allowBonusDisplay = false
  removeUserUpdateFunction("propWatch")
  removeUserUpdateFunction("Pause complete while slowdown active")
  propSystem.cleanupRuntimeProps()
  if docksLocationMarker then
    feedbackSystem.clearTarget(docksLocationMarker)
    docksLocationMarker = nil
  end
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.team == "Race team" then
      taskObject.coreData.agent:set_damageMultiplier(1.5)
      taskObject.coreData.agent.gameVehicle.performance = 1
      taskObject.coreData.actor.desiredSpeed = 55
      taskObject.coreData.actor.avoidAttacks = false
      taskObject.coreData.actor.collisionResilience = "Average"
      taskObject.coreData.actor.maintainLane = true
      taskObject.coreData.actor.aiIgnorePlayerInCivsUntilHit = true
    end
  end
end
