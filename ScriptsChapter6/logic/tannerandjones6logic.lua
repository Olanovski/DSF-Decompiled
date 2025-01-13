module("cardSystem.logic")
missionSetupData["Tanner and Jones 6"] = {}
local prompts = {
  ["Drive to ordell"] = "ID:245547",
  ["Head to Alcatraz"] = "ID:248765",
  ["Destination"] = "ID:248764",
  ["Stop prompt"] = "ID:183967",
  ["Lose cops prompt"] = "ID:231403",
  ["Escaped"] = "ID:231165"
}
local showText = function(text)
  feedbackSystem.menusMaster.primaryTextPrompt(text, false, false, false, false)
end
local tannerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Linear Checkpoints",
        specialName = "recce",
        dynamicTargets = true,
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
            style = "Tanner and Jones 6 HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "PlayerInTaskVehicle",
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
        specialName = "Speech trigger 01",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 15}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 30}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "zapping to driver",
        taskConditions = {
          {
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
        task = "No AI",
        specialName = "Entered rendezvous with cops",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Specified actor is getaway",
              params = {actorID = "Driver"}
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
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
          }
        }
      }
    }
  }
  return task
end
local driverTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Waiting for player",
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
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "ambushed",
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
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "lose cops",
        taskConditions = {
          {
            {
              goal = "Being chased",
              params = {inverse = true}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {goal = "Got busted"}
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
        audioPIP = audio,
        HUD = {
          {
            style = "Tanner and Jones 6 HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Felony 01",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
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
        specialName = "PIP 01 trigger",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
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
        specialName = "Speech trigger 02",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 3,
            {
              goal = "Recent audio played",
              params = {value = 15}
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
        specialName = "Player in zap with felony 01",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            },
            {
              goal = "Being chased"
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Wait for display hotspot",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints AI Wander",
        specialName = "Soft save trigger",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 140}
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
            {goal = "Got busted"}
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
                Hotspot = {hideTerrainMarker = true}
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio before PIP",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            },
            {
              goal = "Recent audio played",
              params = {value = 2}
            },
            {
              goal = "Within radius",
              params = {value = 450}
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
        specialName = "Player in zap without felony 01",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            },
            {
              goal = "Being chased",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Speech trigger 03",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Recent audio played",
              params = {value = 5}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Zap to Tanner",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "get to destination 1",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints AI Wander",
        specialName = "get to destination 2",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Being chased",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 100}
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
            {goal = "Got busted"}
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
            style = "Tanner and Jones 6 HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "get to destination 2B",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 20}
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
        specialName = "Audio after PIP",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 8}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Player in zap with felony 02",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            },
            {
              goal = "Being chased"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Speech trigger 04",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 3,
            {
              goal = "Recent audio played",
              params = {value = 15}
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
        specialName = "On approach 2",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Being chased"
            },
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
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Lost the feds",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            {
              goal = "Being chased",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Lost the feds get to dest prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            {
              goal = "Being chased",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "spawn ambush 2",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Being chased"
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
        }
      },
      {
        task = "No AI",
        specialName = "stop prompt",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Being chased",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 100}
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
        specialName = "lose cops first prompt",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Being chased"
            },
            {
              goal = "Within radius",
              params = {value = 100}
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
        specialName = "Player in zap without felony 02",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            },
            {
              goal = "Being chased",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Stop Vehicle",
        specialName = "mission end",
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
          },
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Vehicle tracking"] = {}
              }
            }
          }
        },
        audioPIP = audio
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
local agentTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "No AI",
        specialName = "ambush driver",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Specified actor is getaway",
              params = {
                actorID = {"Driver"},
                inverse = true
              }
            },
            {
              goal = "Within radius",
              params = {value = 40}
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
      {task = "No AI"}
    }
  }
  return task
end
local roadblockTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "No AI",
        specialName = "passedRoadblock",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 25}
            }
          },
          {
            {
              goal = "Outside radius",
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
      }
    }
  }
  return task
end
missionSetupData["Tanner and Jones 6"].taskCreatorFunctionLookups = {
  ["Tanner team"] = tannerTask,
  ["Driver team"] = driverTask,
  ["Chase team"] = chaseTask,
  ["Agents team"] = roadblockTask
}
local wave1Spawned = false
local wave2Spawned = false
local wave3Spawned = false
local evaderGameVehicle = false
local ambushPosition1 = vec.vector(844.593, 8.244, 3192.608, 1)
local ambushPosition2 = vec.vector(951.97, 8.544, 3274.183, 1)
local ambushPosition3 = vec.vector(1093.679, 8.544, 3169.442, 1)
local secondHotspotPosition = vec.vector(977.7233, 8.538776, 3186.285, 1)
local function setUpSecondChase(instance)
  if instance.taskObjectsByActorID.Driver.coreData.agent.gameVehicle.isBeingTowed then
    vehicleManager.unhookPlayerVehicle()
  end
  challengeSystem.spawnActors(instance, "Never", {
    ["Fed 1"] = true,
    ["Fed 2"] = true
  })
  if not Getaway.IsBeingChased(instance.taskObjectsByActorID.Driver.coreData.agent.gameVehicle) then
    local getawaySettings = felony_getaway.getawaySettingsPerMission["Tanner and Jones 6 - part 2"]
    felony_patrollingVehicleManager.setSpawningModels(getawaySettings.modelIDs)
    PlayerAnalysis.AddWeight("Getaway", getawaySettings.playerAnalysis)
    PlayerAnalysis.SetDecay("Getaway", getawaySettings.playerAnalysisDecay)
    evaderGameVehicle = instance.taskObjectsByActorID.Driver.coreData.agent.gameVehicle
    localPlayer:createFelony(evaderGameVehicle, getawaySettings)
    Getaway.Start(evaderGameVehicle, nil, "Mission", getawaySettings)
  end
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if actorID ~= "Driver" and actorID ~= "Tanner" then
      felony_getaway.addChaser(evaderGameVehicle, taskObject.coreData.agent.gameVehicle)
    end
  end
  challengeSystem.spawnActors(instance, "Never", {
    ["Chaser 11"] = true
  })
  instance.taskObjectsByActorID.Driver.coreData.agent.gameVehicle.speed = 40
end
missionSetupData["Tanner and Jones 6"].initiate = function(instance)
  createFixedPosition(instance, {ambushPosition3}, 3)
  createFixedPosition(instance, {
    spawnPositions["Tanner and Jones 6 dropoff"].position
  }, 4)
  createFixedPosition(instance, {ambushPosition1}, 99)
  createFixedPosition(instance, {ambushPosition2}, 98)
  createFixedPosition(instance, {
    spawnPositions["TJ6 Cop spawn 1"].position
  }, 97)
  createFixedPosition(instance, {
    spawnPositions["TJ6 Cop spawn 2"].position
  }, 96)
  createFixedPosition(instance, {
    spawnPositions["TJ6 Cop spawn 3"].position
  }, 95)
  createFixedPosition(instance, {
    spawnPositions["TJ6 Cop spawn 4"].position
  }, 94)
  createFixedPosition(instance, {
    spawnPositions["TJ6 Cop spawn 5"].position
  }, 93)
  createFixedPosition(instance, {secondHotspotPosition}, 92)
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    if softSaveData.progression == 1 then
      instance.taskObjectsByActorID.Driver.coreData.agent.gameVehicle.speed = 30
      setUpSecondChase(instance)
      feedbackSystem.menusMaster.setCurrentFocusString(3)
    elseif softSaveData.progression == 2 then
      feedbackSystem.menusMaster.setCurrentFocusString(2)
    end
  else
    createFixedPosition(instance, {
      spawnPositions["Tanner and Jones 6 driver spawn"].position
    }, 1)
    createFixedPosition(instance, {
      spawnPositions["Tanner and Jones 6 recce"].position
    }, 2)
    feedbackSystem.menusMaster.primaryTextPrompt(prompts["Drive to ordell"], nil, true)
  end
  evaderGameVehicle = false
  wave1Spawned = false
  wave2Spawned = false
  wave3Spawned = false
  FelonyVehicleSpawnManager.SetExclusionZone(spawnPositions["Tanner and Jones 6 dropoff"].position, 300)
end
missionSetupData["Tanner and Jones 6"].update = nil
local getTannerTeamDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "recce" then
    if dynamicListID then
      feedbackSystem.menusMaster.setCurrentFocusString(2)
      return nil, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 2), false
    end
  elseif task.specialName == "Entered rendezvous with cops" then
    if dynamicListID then
      return false, true
    else
      return {
        task.instance.taskObjectsByActorID.Driver.coreData.agent
      }, false
    end
  end
end
local function getDriverTeamDynamicTargets(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "Soft save trigger" or task.specialName == "Audio before PIP" then
    if dynamicListID then
      return nil, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 92), false
    end
  elseif task.specialName == "Spawn cops 1" then
    if dynamicListID then
      return nil, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 97), false
    end
  elseif task.specialName == "Spawn cops 2" then
    if dynamicListID then
      return nil, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 96), false
    end
  elseif task.specialName == "Spawn cops 3" then
    if dynamicListID then
      return nil, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 95), false
    end
  elseif task.specialName == "Spawn cops 4" then
    if dynamicListID then
      return nil, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 94), false
    end
  elseif task.specialName == "Spawn cops 5" then
    if dynamicListID then
      return nil, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 93), false
    end
  elseif task.specialName == "get to destination 2" or task.specialName == "get to destination 2B" then
    if dynamicListID then
      return false, true
    else
      OneShotSound.Play("HUD_Fel_Gained")
      return checkpointSystem.getCheckpoints(task.instance, 4), false
    end
  elseif task.specialName == "On approach 2" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 4), false
    end
  elseif task.specialName == "spawn ambush 2" then
    if dynamicListID then
      if not Getaway.IsBeingChased(task.instance.taskObjectsByActorID.Driver.coreData.agent.gameVehicle) then
        evaderGameVehicle = task.instance.taskObjectsByActorID.Driver.coreData.agent.gameVehicle
        felony_getaway.addEvader(evaderGameVehicle)
      end
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.ID == "Fed 3" or taskObject.coreData.actor.ID == "Fed 4" then
          felony_getaway.addChaser(evaderGameVehicle, taskObject.coreData.agent.gameVehicle)
        end
      end
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 4), false
    end
  elseif task.specialName == "stop prompt" then
    if dynamicListID then
      showText(prompts["Stop prompt"])
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 4), false
    end
  elseif task.specialName == "lose cops first prompt" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 4), false
    end
  end
end
local getAgentsTeamDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID.Driver.coreData.agent
    }, false
  end
end
missionSetupData["Tanner and Jones 6"].targetList = {
  ["Tanner team"] = getTannerTeamDynamicTargets,
  ["Driver team"] = getDriverTeamDynamicTargets,
  ["Agents team"] = getAgentsTeamDynamicTargets
}
local towingVehicle
missionEndCallback["Tanner and Jones 6"] = function(instance)
  FelonyVehicleSpawnManager.ClearModelTypes()
  FelonyVehicleSpawnManager.AddModelType(271, 1)
  localPlayer:blockAbility("zap", false)
  towingVehicle = nil
end
taskCompleteData["Tanner and Jones 6"] = {}
local params
local function setupEndScreen(task)
  params = {
    vehicle = localPlayer.currentVehicle,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    failReasonWrecked = task.instance.challenge.taskCompleteData["Failure reason (Wrecked)"],
    inCarCompletion = task.instance.challenge.taskCompleteData["In-car completion"],
    inCarReward = task.instance.challenge.taskCompleteData["In-car reward"],
    passCondition = task.instance.challenge.taskCompleteData["Pass condition"],
    passReward = task.instance.challenge.taskCompleteData["Pass reward"],
    hint = "ID:235485",
    hintIcon1 = localPlayer.buttonLayout.minimapZoom
  }
end
local spawnCop = function(task, position, heading)
  local evaderGameVehicle
  for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.team == "Driver team" then
      evaderGameVehicle = taskObject.coreData.agent.gameVehicle
    end
  end
  local settings = {
    type = "Generic",
    position = position,
    heading = heading,
    vehicle = evaderGameVehicle,
    vehicles = {
      [1] = {modelID = 265}
    }
  }
  if localPlayer.currentVehicle then
    local vehicles = Spawn.Spawn(settings)
    felony_getaway.addEvader(evaderGameVehicle)
    local vehicle = vehicleManager.registerVehicle({
      gameVehicle = vehicles[1]
    })
    felony_getaway.addChaser(evaderGameVehicle, vehicles[1])
  end
end
taskCompleteData["Tanner and Jones 6"].taskComplete = function(taskObject, task)
  local perfect = false
  if not showingEndScreen then
    if task.success then
      print("=======TASK COMPLETE =    : " .. task.specialName)
      if task.specialName == "recce" then
        OneShotSound.Play("HUD_Play_Waypoint")
        challengeSystem.spawnActors(task.instance, "Never", {Driver = true})
        if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle ~= task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle and task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.isBeingTowed then
          task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.parentVehicle.speed = 0
          GameVehicleResource.lockEmergencyBrakes(task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.parentVehicle, 0.1)
        end
      elseif task.specialName == "zapping to driver" then
        GameVehicleResource.unlockEmergencyBrakes(task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.parentVehicle)
        feedbackSystem.menusMaster.blockHintButton(true)
        localPlayer:zapToAgent(task.instance.taskObjectsByActorID.Driver.coreData.agent)
        localPlayer.missionSupport:setMainTaskObject(task.instance.taskObjectsByActorID.Driver)
        localPlayer:buildZapReturn()
      elseif task.specialName == "Waiting for player" then
        progressionSystem.triggerSoftSave({progression = 2})
        task.instance.taskObjectsByActorID.Tanner.coreData.actor.markerType = "None"
        localPlayer.missionSupport:setMainTaskObject(taskObject)
        localPlayer:buildZapReturn()
      elseif task.specialName == "ambushed" then
        feedbackSystem.menusMaster.blockHintButton(false)
        if not wave1Spawned then
          challengeSystem.spawnActors(task.instance, "Never", {
            ["Chaser 1"] = true,
            ["Chaser 10"] = true
          })
          wave1Spawned = true
        end
        for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
          if taskObject.coreData.actor.team == "Driver team" then
            evaderGameVehicle = taskObject.coreData.agent.gameVehicle
            felony_getaway.addEvader(evaderGameVehicle)
          end
        end
        for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
          if taskObject.coreData.actor.team == "Chase team" then
            felony_getaway.addChaser(evaderGameVehicle, taskObject.coreData.agent.gameVehicle)
          end
        end
      elseif task.specialName == "Zap to Tanner" then
        engineCutscene.playCutscene("mis_ch6_escapist_01", function()
          if towingVehicle then
            towingVehicle:delete()
          end
          local spawn = softSaveStartPositions["Tanner and Jones 6"][1].Driver
          task.instance.taskObjectsByActorID.Driver.coreData.agent:teleportToPositionAndHeading(spawn.position, spawn.heading, nil, nil, nil, false)
        end, function()
          setUpSecondChase(task.instance)
        end)
      elseif task.specialName == "Soft save trigger" then
        OneShotSound.Play("HUD_Play_Waypoint")
        towingVehicle = task.instance.taskObjectsByActorID.Driver.coreData.agent.towingVehicle
        if localPlayer.currentVehicle ~= task.instance.taskObjectsByActorID.Driver.coreData.agent or localPlayer.inZap then
          localPlayer:zapToAgent(task.instance.taskObjectsByActorID.Driver.coreData.agent)
          vehicleManager.unhookPlayerVehicle()
        end
      elseif task.specialName == "get to destination 1" then
        feedbackSystem.menusMaster.setCurrentFocusString(4)
        progressionSystem.triggerSoftSave({progression = 1})
      elseif task.specialName == "lose cops" then
        showText(prompts.Escaped)
      elseif task.specialName == "Wait for display hotspot" then
        showText(prompts["Head to Alcatraz"])
        feedbackSystem.menusMaster.setCurrentFocusString(3)
      elseif task.specialName == "Lost the feds" then
        showText(prompts.Escaped)
      elseif task.specialName == "Lost the feds get to dest prompt" then
        showText(prompts.Destination)
        feedbackSystem.menusMaster.setCurrentFocusString(5)
      elseif task.specialName == "passedRoadblock" then
        felony_getaway.addChaser(evaderGameVehicle, task.agent.gameVehicle)
      elseif task.specialName == "lose cops first prompt" then
        showText(prompts["Lose cops prompt"])
      elseif task.specialName == "get to destination 2" then
        if not task.agent.controlled then
          if task.instance.taskObjectsByActorID.Driver.coreData.agent.gameVehicle.isBeingTowed then
            task.instance.taskObjectsByActorID.Driver.coreData.agent.gameVehicle.parentVehicle.speed = 0
            GameVehicleResource.lockEmergencyBrakes(task.instance.taskObjectsByActorID.Driver.coreData.agent.gameVehicle.parentVehicle, 0.1)
          end
          if localPlayer.inZap then
            localPlayer:SetZapLevel(0, task.agent)
          else
            localPlayer:SetZapLevel(1)
            localPlayer:SetZapLevel(0, task.agent)
          end
        end
        OneShotSound.Play("HUD_Play_Waypoint")
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        localPlayer.cameraSupport.miniSceneCamera()
        localPlayer.controllerInterface:removePlayerControl()
      elseif task.specialName == "mission end" then
        if task.instance.taskObjectsByActorID.Driver.coreData.agent.gameVehicle.isBeingTowed then
          GameVehicleResource.unlockEmergencyBrakes(task.instance.taskObjectsByActorID.Driver.coreData.agent.gameVehicle.parentVehicle)
        end
        setupEndScreen(task)
        local function completeTask()
          progressionSystem.challengeComplete(task.instance, task.agent.matrix, perfect)
        end
        params.dialogue = "GPMV02_SUCCESS_L_1"
        params.callback = completeTask
        params.rating = "PASS"
        localPlayer.challenge.endScreen(taskObject, params)
      elseif task.specialName == "mission end prompt" then
        showText(prompts["Tanner end dialog"])
      end
    else
      setupEndScreen(task)
      if task.specialName == "lose cops" or task.specialName == "Soft save trigger" or task.specialName == "get to destination 1" or task.specialName == "get to destination 2" then
        params.hint = "ID:235490"
        if task.condition == 2 then
          params.dialogue = "GPMV02_FAILURE_L_2"
          params.failReason = task.instance.challenge.taskCompleteData.Arrested
          params.reason = "Busted"
        elseif task.condition == 3 then
          if not localPlayer.inZap and localPlayer.currentVehicle == task.instance.taskObjectsByActorID.Driver.coreData.agent then
            params.dialogue = "GPMV02_FAILURE_L_1"
          else
            params.dialogue = "GPMV00_FAILURE_L_1"
          end
          params.reason = "Wrecked"
          params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        end
      elseif 1 <= task.agent.damage then
        params.dialogue = "GPMV00_FAILURE_L_1"
        params.reason = "Wrecked"
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
      end
      local function failTask()
        progressionSystem.challengeFailed(task.instance, task.agent.matrix)
      end
      params.callback = failTask
      params.rating = "FAIL"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  end
end
