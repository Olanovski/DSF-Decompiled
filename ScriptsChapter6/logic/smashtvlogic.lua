module("cardSystem.logic")
missionSetupData["Smash tv"] = {}
local beforeICam = "beforeICam"
local copsPosition1 = vec.vector(-2962.868, 143.547, 4270.313, 1)
local copsPosition2 = vec.vector(-2833.757, 118.094, 3856.198, 1)
local copsPosition3 = vec.vector(-3174.469, 99.85, 4226.978, 1)
local copsPosition4 = vec.vector(-3803.167, 64.68, 3993.738, 1)
local copsPosition5 = vec.vector(-4156.275, 48.905, 3884.848, 1)
local function getawayTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Linear Checkpoints",
        specialName = "Checkpoints",
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
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            },
            {
              goal = "Being chased",
              params = {inverse = true}
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
              goal = "Being chased"
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {goal = "Got busted"}
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
        HUD = {
          {
            style = "Smash tv hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Out of truck prompt",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
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
        },
        HUD = {
          {
            style = "Smash tv hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Instructions",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        },
        HUD = {
          {
            style = "Smash tv hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "second audio",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
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
        specialName = "player vehicle's damaged part 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.4}
            },
            {
              goal = "Is player controlled"
            }
          },
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.8}
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
        specialName = "Prompt to use ram 1",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Damage above",
              params = {value = 0.5}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Near cops position 1",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player within radius of point",
              params = {value = 50, position = copsPosition1}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Near cops position 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player within radius of point",
              params = {value = 150, position = copsPosition2}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Near cops position 3",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player within radius of point",
              params = {value = 150, position = copsPosition3}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Near cops position 4",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player within radius of point",
              params = {value = 150, position = copsPosition4}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Near cops position 5",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player within radius of point",
              params = {value = 150, position = copsPosition5}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "shift audio 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player just zapped out of specified actors",
              params = {
                actors = {"Getaway"}
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Felony countdown is on 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Being busted"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Player has lost cops",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Being chased",
              params = {inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Smash tv hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Controlled",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
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
            style = "Smash tv hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "SoftSave",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
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
            style = "Smash tv hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Chase",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            },
            {
              goal = "Being chased",
              params = {inverse = true}
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
              goal = "Being chased"
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {goal = "Got busted"}
          }
        },
        HUD = {
          {
            style = "Smash tv hud"
          }
        }
      },
      {
        task = "Linear Chase",
        specialName = "Chase 2",
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
        }
      },
      {
        task = "No AI",
        specialName = "Instructions Chase",
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
            style = "Smash tv hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "player vehicle's damaged part 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.4}
            },
            {
              goal = "Is player controlled"
            }
          },
          triggerCount = 1,
          {
            {
              goal = "Damage above",
              params = {value = 0.8}
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
        specialName = "Prompt to use ram 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Damage above",
              params = {value = 0.5}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "shift audio 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
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
        specialName = "target's getting destroyed",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Specified actors struck by player",
              params = {
                actorIDs = {"Truck"}
              }
            },
            {
              goal = "Is player controlled"
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Target damage above",
              params = {value = 0.4}
            },
            {
              goal = "Is player controlled"
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Target damage above",
              params = {value = 0.6}
            },
            {
              goal = "Is player controlled"
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Target damage above",
              params = {value = 0.8}
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
        specialName = "Felony countdown is on 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Being busted"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Player has lost cops second part",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Being chased",
              params = {inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Smash tv hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait for icam",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        }
      }
    }
  }
  return task
end
local chaseTask = function(goalParams, HUD)
  local task = {
    {
      {task = "No AI"}
    }
  }
  return task
end
local truckTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 250}
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
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Pass first junction",
        dynamicTargets = true,
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
            {
              goal = "All targets eliminated (Non-linear)"
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {goal = "Got busted"}
          }
        }
      },
      {
        task = "No AI",
        specialName = "Accelerate traitor 1a",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Damage above",
              params = {value = 0.5}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Accelerate traitor 2a",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Damage above",
              params = {value = 0.75}
            }
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Flee",
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {goal = "Got busted"}
          }
        }
      },
      {
        task = "No AI",
        specialName = "Accelerate traitor 1b",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Damage above",
              params = {value = 0.5}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Accelerate traitor 2b",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Damage above",
              params = {value = 0.75}
            }
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Smash tv"].taskCreatorFunctionLookups = {
  ["Evade team"] = getawayTask,
  ["Chase team"] = chaseTask,
  ["Truck team"] = truckTask
}
local fixedCameras = {
  [4] = vec.vector(-4432.753, 23.14827, 3100.229, 1)
}
local firstCheckpoint = vec.vector(-4443.963, 21.53374, 3285.543, 1)
missionSetupData["Smash tv"].initiate = function(instance)
  createFixedPosition(instance, {firstCheckpoint}, 101)
  createFixedPosition(instance, {
    spawnPositions["Smash tv truck destination"].position
  }, 102)
  local evaderGameVehicle = false
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.team == "Evade team" then
      evaderGameVehicle = taskObject.coreData.agent.gameVehicle
      felony_getaway.addEvader(evaderGameVehicle)
    end
  end
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.team == "Chase team" then
      felony_getaway.addChaser(evaderGameVehicle, taskObject.coreData.agent.gameVehicle)
    end
  end
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData and softSaveData.progression == 1 then
    local PAdata = {
      Drift = 5,
      Jump = 5,
      Overtake = 5,
      OvertakeOncomming = 5,
      Trailer = 5,
      HighSpeedDriving = 5,
      SafeDriving = 5,
      PlayerCollision = 0,
      DrivingInAnAlley = 5
    }
    PlayerAnalysis.AddWeight("Getaway", PAdata)
    feedbackSystem.startMusic("Uid00787_CH04_Standard_TripleCross_Play")
    instance.challenge.actorPool.Truck.desiredSpeed = 65
  end
end
missionSetupData["Smash tv"].update = nil
local getEvadeTeamDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "Checkpoints" or task.specialName == "Out of truck prompt" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 101), false
    end
  elseif task.specialName == "Chase 2" or task.specialName == "target's getting destroyed" then
    if dynamicListID then
      return false, true
    else
      local teams = {}
      for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
        teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
        table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
      end
      return teams["Truck team"], false
    end
  end
end
local getTruckTeamDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Pass first junction" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 102), false
    end
  elseif dynamicListID then
    return false, true
  else
    local teams = {}
    for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
      teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
      table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
    end
    return teams["Evade team"], false
  end
end
missionSetupData["Smash tv"].targetList = {
  ["Evade team"] = getEvadeTeamDynamicTargets,
  ["Truck team"] = getTruckTeamDynamicTargets
}
local useRamPromptShown = false
taskCompleteData["Smash tv"] = {}
taskCompleteData["Smash tv"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.Getaway.coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235490"
  }
  if task.success then
    if task.specialName == "Checkpoints" then
      OneShotSound.Play("HUD_Play_Waypoint")
      if not task.agent.controlled then
        localPlayer:zapToAgent(task.agent)
      end
    elseif task.specialName == "Prompt to use ram 1" or task.specialName == "Prompt to use ram 2" and not useRamPromptShown then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243486")
      useRamPromptShown = true
    elseif task.specialName == "Controlled" then
    elseif task.specialName == "SoftSave" then
      progressionSystem.triggerSoftSave({progression = 1})
      challengeSystem.spawnActors(task.instance, "Never", {Truck = true})
      feedbackSystem.menusMaster.setNextFocusString()
      truckGameVehicle = task.instance.taskObjectsByActorID.Truck.coreData.agent.gameVehicle
      vehicletable = {}
      vehicletable[0] = {}
      vehicletable[0].gameVehicle = truckGameVehicle
      Sound.SetChallengers(vehicletable)
      local iCamParams = {
        cameraTargets = {
          task.instance.taskObjectsByActorID.Truck.coreData.agent.gameVehicle,
          task.instance.taskObjectsByActorID.Getaway.coreData.agent.gameVehicle
        },
        duration = 5,
        speed = 0.3,
        framing = "wide",
        angleyaw = "front quarter",
        fixedCameras = fixedCameras
      }
      iCamActivationTableInput(iCamParams)
      feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_4", function()
        feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_5")
      end)
    elseif task.specialName == "Near cops position 1" then
    elseif task.specialName == "Near cops position 2" then
    elseif task.specialName == "Near cops position 3" then
    elseif task.specialName == "Near cops position 4" then
    elseif task.specialName == "Near cops position 5" then
    elseif task.specialName == "Chase 2" then
      iCamCrashCam(task.instance.taskObjectsByActorID.Truck.coreData.agent.gameVehicle)
    elseif task.specialName == "Accelerate traitor 1a" or task.specialName == "Accelerate traitor 1b" then
      task.actor.desiredSpeed = 70
      task.agent:stopHighSpeedDriving()
      local behaviour = {
        traits = taskSystem.buildDriveTraits(task)
      }
      task.agent:highSpeedDrive(behaviour)
    elseif task.specialName == "Accelerate traitor 2a" or task.specialName == "Accelerate traitor 2b" then
      task.actor.desiredSpeed = 80
      task.agent:stopHighSpeedDriving()
      local behaviour = {
        traits = taskSystem.buildDriveTraits(task)
      }
      task.agent:highSpeedDrive(behaviour)
    elseif task.specialName == "Wait for icam" then
      local function completeTask()
        progressionSystem.challengeComplete(task.instance, task.agent.matrix)
      end
      params.rating = "PASS"
      params.vehicle = task.instance.taskObjectsByActorID.Truck.coreData.agent
      params.dialogue = "GPMV00_SUCCESS_L_1"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "Pass first junction" or task.specialName == "Flee" then
    local function completeTask()
      progressionSystem.challengeComplete(task.instance, task.agent.matrix)
    end
    params.rating = "PASS"
    params.successReason = "ID:243197"
    params.vehicle = task.instance.taskObjectsByActorID.Truck.coreData.agent
    params.dialogue = "GPMV00_SUCCESS_L_1"
    params.callback = completeTask
    local iCamParams = {
      cameraTargets = {
        task.instance.taskObjectsByActorID.Truck.coreData.agent.gameVehicle
      },
      duration = 3,
      speed = 0.5,
      framing = "wide",
      angleyaw = "front quarter",
      callbackFunction = function()
        localPlayer.challenge.endScreen(taskObject, params)
      end
    }
    iCamActivationTableInput(iCamParams)
  else
    if localPlayer.currentVehicle ~= taskObject.coreData.agent or localPlayer.currentVehicle == taskObject.coreData.agent and localPlayer.inZap then
      if task.condition == 1 then
        params.dialogue = "GPMV00_FAILURE_L_1A"
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        params.reason = "Wrecked"
      elseif task.condition == 2 or task.condition == 3 then
        params.dialogue = "GPMV00_FAILURE_L_2A"
        if task.condition == 2 then
          params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
          params.reason = "Wrecked"
        else
          params.failReason = "ID:184474"
          params.reason = "Busted"
        end
      end
    elseif task.condition == 1 then
      params.dialogue = "GPMV00_FAILURE_L_1"
      params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
      params.reason = "Wrecked"
    elseif task.condition == 2 or task.condition == 3 then
      params.dialogue = "GPMV00_FAILURE_L_2"
      if task.condition == 2 then
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        params.reason = "Wrecked"
      else
        params.failReason = "ID:184474"
        params.reason = "Busted"
      end
    end
    local function failTask()
      progressionSystem.challengeFailed(task.instance, task.agent.matrix)
    end
    if task.specialName == "Chase" then
      params.hint = "ID:235487"
    end
    params.rating = "FAIL"
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Smash tv"] = function(instance)
  removeUserUpdateFunction(beforeICam)
  useRamPromptShown = false
end
