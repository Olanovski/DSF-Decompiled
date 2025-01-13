module("cardSystem", package.seeall)
missionSetupData = missionSetupData or {}
missionSetupData["Gone in 59 seconds"] = {}
local startOfTimer = 0
local evaderGameVehicle
local goonsWrecked = 0
local LaneTrackFollowerRejectionCallback = function(gameVehicle, reason)
  if reason == "OutSideSimulation" then
  elseif reason == "OffCarrier" then
    local truckAgent = vehicleManager.vehiclesByGameVehicle[gameVehicle]
    local behaviour = {
      personality = "civ",
      traits = {
        desiredSpeed = 50,
        wanderType = "preferStraight",
        avoidedByCivilianTraffic = true
      }
    }
    truckAgent:highSpeedDrive(behaviour)
  end
end
local truckTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "No AI",
        specialName = "truck task",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "In back of truck",
              params = {target = "Target"}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
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
local towTask = function(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    {
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Do nothing",
        goalConditions = {
          {
            {
              goal = "Target damage above",
              params = {value = 1}
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
local playerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Follow Route",
        specialName = "first second",
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
          },
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        },
        HUD = {
          {
            style = "Gone in 59 seconds HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Follow Route",
        specialName = "cars revealed",
        groupProgression = {importantMinorOrder = true},
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {levelOfZap = 5}
            }
          },
          {
            {
              goal = "Player in zap",
              params = {levelOfZap = 4}
            }
          },
          {
            {
              goal = "Player in a specified agent",
              params = {
                actorIDs = {
                  "Hot Car 1",
                  "Hot Car 2",
                  "Hot Car 3",
                  "Hot Car 4"
                }
              }
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
        specialName = "lock cop",
        groupProgression = {importantMinorOrder = true},
        taskConditions = {
          {
            {
              goal = "Is player controlled",
              params = {inverse = true}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "force out of vehicle",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player in a specified agent",
              params = {
                actorIDs = {
                  "Hot Car 1",
                  "Hot Car 2",
                  "Hot Car 3",
                  "Hot Car 4"
                },
                inverse = true
              }
            },
            {
              goal = "Recent audio played",
              params = {value = 3}
            }
          }
        }
      }
    },
    {
      {
        task = "Follow Route",
        specialName = "Get all cars",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "In back of truck"
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Player in target vehicle"
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
            {
              goal = "Time trigger",
              params = {value = 300}
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
            style = "Gone in 59 seconds HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Far away from the targets",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Changed vehicle"
            },
            {
              goal = "Player outside radius of specified actors",
              params = {
                actorIDs = {
                  "Hot Car 1",
                  "Hot Car 2",
                  "Hot Car 3",
                  "Hot Car 4"
                },
                value = 700
              }
            },
            {
              goal = "Time trigger",
              params = {value = 10}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        HUD = {
          {
            style = "Gone in 59 seconds HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "one third through",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 70}
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
        specialName = "two third through",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 140}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
local hotCarTask = function(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    {
      {
        task = "Follow Route",
        groupProgression = {importantMinorOrder = true},
        specialName = "hot car task",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player in zap",
              params = {levelOfZap = 5}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Player in zap",
              params = {levelOfZap = 4}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Specified actors struck by player",
              params = {
                actorIDs = {
                  "Truck 1",
                  "Truck 2",
                  "Truck 4"
                },
                useTrailer = true
              }
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            {
              goal = "In back of truck"
            },
            {
              goal = "Player using zap return",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.15}
            }
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            }
          },
          {
            failCondition = true,
            {goal = "Got busted"}
          }
        },
        HUD = {
          {
            style = "Gone in 59 seconds HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "Boot out and clear",
        taskConditions = {
          {
            {
              goal = "In back of truck"
            },
            {
              goal = "Player using zap return",
              params = {inverse = true}
            }
          }
        }
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "hot car visible",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player zap status has changed",
              params = {transition = "out"}
            },
            {
              goal = "Is player controlled"
            }
          }
        },
        HUD = {
          {
            style = "Gone in 59 seconds HUD"
          }
        }
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "first prompt",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            }
          }
        }
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "damage",
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Damage above",
              params = {value = 0.2}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Damage above",
              params = {value = 0.6}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "GoalConditions empty"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "damage for damaged car",
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Damage above",
              params = {value = 0.85}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Damage above",
              params = {value = 0.95}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "GoalConditions empty"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "zapped in to vehicle",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
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
        groupProgression = {importantMinorOrder = false},
        specialName = "tow check",
        goalConditions = {
          {
            {
              goal = "Being towed"
            }
          },
          {
            {
              goal = "Being towed",
              params = {inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Gone in 59 seconds HUD"
          }
        }
      }
    }
  }
  return task
end
local hotCarTask2 = function(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    {
      {
        task = "No AI",
        specialName = "Wait for player",
        goalConditions = {
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            }
          },
          {
            {
              goal = "Struck by player"
            }
          },
          {
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
            style = "Gone in 59 seconds HUD"
          }
        }
      }
    },
    {
      {
        task = "Follow Route",
        specialName = "hot car task",
        groupProgression = {importantMinorOrder = true},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player in zap",
              params = {levelOfZap = 5}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Player in zap",
              params = {levelOfZap = 4}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Specified actors struck by player",
              params = {
                actorIDs = {"Truck 3"},
                useTrailer = true
              }
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            {
              goal = "In back of truck"
            },
            {
              goal = "Player using zap return",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.15}
            }
          },
          {
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
            style = "Gone in 59 seconds HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "Boot out and clear",
        taskConditions = {
          {
            {
              goal = "In back of truck"
            },
            {
              goal = "Player using zap return",
              params = {inverse = true}
            }
          }
        }
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "Driving away",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 8}
            },
            {
              goal = "Above speed",
              params = {value = 50}
            }
          }
        },
        HUD = {
          {
            style = "Gone in 59 seconds HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Hit by goon",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Struck specified actors",
              params = {
                actorIDs = {
                  [1] = "Goon 1",
                  [2] = "Goon 2",
                  [3] = "Goon 3"
                }
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "hot car visible",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player zap status has changed",
              params = {transition = "out"}
            },
            {
              goal = "Is player controlled"
            }
          }
        },
        HUD = {
          {
            style = "Gone in 59 seconds HUD"
          }
        }
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "first prompt2",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            }
          }
        }
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "damage",
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Damage above",
              params = {value = 0.2}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Damage above",
              params = {value = 0.6}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "GoalConditions empty"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "damage for damaged car",
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Damage above",
              params = {value = 0.85}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Damage above",
              params = {value = 0.95}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "GoalConditions empty"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "zapped in to vehicle",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
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
        groupProgression = {importantMinorOrder = false},
        specialName = "Lost chasers",
        taskConditions = {
          {
            {
              goal = "Above speed",
              params = {value = 10}
            },
            {
              goal = "Being chased",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1.5}
            },
            {
              goal = "Prompt active",
              params = {inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Gone in 59 seconds HUD"
          }
        }
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "tow check",
        goalConditions = {
          {
            {
              goal = "Being towed"
            }
          },
          {
            {
              goal = "Being towed",
              params = {inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Gone in 59 seconds HUD"
          }
        }
      }
    }
  }
  return task
end
local goonTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    enableNonPlayerFeedback = true,
    {
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Wait for drive",
        goalConditions = {
          {
            {
              goal = "Target damage above",
              params = {value = 1, inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 50}
            },
            {
              goal = "Target below speed",
              params = {inverse = true, value = 5}
            },
            {
              goal = "Time trigger",
              params = {
                value = math.random(1.5)
              }
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
            style = "Gone in 59 seconds HUD"
          }
        }
      }
    },
    {
      {
        {task = "No AI"}
      }
    }
  }
  return task
end
missionSetupData["Gone in 59 seconds"].taskCreatorFunctionLookups = {
  ["Police team"] = playerTask,
  ["Hot Car team"] = hotCarTask,
  ["Hot Car team2"] = hotCarTask2,
  ["Truck team"] = truckTask,
  ["Tow team"] = towTask,
  ["Goon team"] = goonTask
}
missionSetupData["Gone in 59 seconds"].initiate = function(instance)
  instance.allFourReturned = false
  instance.recoveredCars = 0
  startOfTimer = 0
  goonsWrecked = 0
  evaderGameVehicle = instance.taskObjectsByActorID["Hot Car 3"].coreData.agent.gameVehicle
  minimap.AddHighlightedVehicleModelUIDs({
    {VehicleModelUID = 289}
  })
  minimap.SetHighlightedVehicles(true)
  GameVehicleResource.registerAttachedVehicleCallback(vehicleManager.attachedVehicleCallback)
  GameVehicleResource.registerAttachedVehicleDeleteRequestFn(vehicleManager.attachedVehicleDeleteRequest)
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.team == "Truck team" then
      taskObject.coreData.agent.iconsVisible = false
      GameVehicleResource.setCanCaptureCars(taskObject.coreData.agent.gameVehicle, true)
      zapcontroller.AddLockedVehicle(localPlayer.localID, {
        gameVehicle = taskObject.coreData.agent.gameVehicle
      })
      if taskObject.coreData.actor.ID == "Truck 3" then
        civilianTraffic.AddScriptLaneTrackInterloper(taskObject.coreData.agent.gameVehicle, LaneTrackFollowerRejectionCallback)
      end
    end
  end
end
missionSetupData["Gone in 59 seconds"].update = nil
local getPlayerTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "Get all cars" then
    if dynamicListID then
      if #task.dynamicTargets == 1 then
        return false, true
      else
        return false, false
      end
    else
      local teams = {}
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if string.find(taskObject.coreData.actor.team, "Hot Car team") then
          table.insert(teams, taskObject.coreData.agent)
        end
      end
      return teams, false
    end
  end
end
local getGoonTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID["Hot Car 3"].coreData.agent
    }, false
  end
end
local getTowTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID.Police.coreData.agent
    }, false
  end
end
local getTruckTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if task.actor.ID == "Truck 1" then
    if dynamicListID then
      return false, true
    else
      return {
        task.instance.taskObjectsByActorID["Hot Car 1"].coreData.agent
      }, false
    end
  elseif task.actor.ID == "Truck 2" then
    if dynamicListID then
      return false, true
    else
      return {
        task.instance.taskObjectsByActorID["Hot Car 2"].coreData.agent
      }, false
    end
  elseif task.actor.ID == "Truck 3" then
    if dynamicListID then
      return false, true
    else
      return {
        task.instance.taskObjectsByActorID["Hot Car 3"].coreData.agent
      }, false
    end
  elseif task.actor.ID == "Truck 4" then
    if dynamicListID then
      return false, true
    else
      return {
        task.instance.taskObjectsByActorID["Hot Car 4"].coreData.agent
      }, false
    end
  end
end
missionSetupData["Gone in 59 seconds"].targetList = {
  ["Police team"] = getPlayerTargets,
  ["Goon team"] = getGoonTargets,
  ["Tow team"] = getTowTargets,
  ["Truck team"] = getTruckTargets
}
taskCompleteData = taskCompleteData or {}
taskCompleteData["Gone in 59 seconds"] = {}
taskCompleteData["Gone in 59 seconds"].taskComplete = function(taskObject, task)
  print(tostring(task.actor.ID) .. " TASK COMPLETE task.specialName = " .. tostring(task.specialName))
  local params = {
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235485",
    hintIcon1 = localPlayer.buttonLayout.minimapZoom
  }
  local function completeTask()
    feedbackSystem.removeSlot(1)
    feedbackSystem.removeSlot(2)
    progressionSystem.challengeComplete(task.instance, task.agent.matrix, perfect)
  end
  local function failTask()
    feedbackSystem.removeSlot(1)
    feedbackSystem.removeSlot(2)
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  local function endScreenVehicle()
    if task.success then
      if task.actor.ID == "Hot Car 1" and task.instance.taskObjectsByActorID["Truck 1"] then
        params.vehicle = task.instance.taskObjectsByActorID["Truck 1"].coreData.agent
      elseif task.actor.ID == "Hot Car 2" and task.instance.taskObjectsByActorID["Truck 2"] then
        params.vehicle = task.instance.taskObjectsByActorID["Truck 2"].coreData.agent
      elseif task.actor.ID == "Hot Car 3" and task.instance.taskObjectsByActorID["Truck 3"] then
        params.vehicle = task.instance.taskObjectsByActorID["Truck 3"].coreData.agent
      elseif task.actor.ID == "Hot Car 4" and task.instance.taskObjectsByActorID["Truck 4"] then
        params.vehicle = task.instance.taskObjectsByActorID["Truck 4"].coreData.agent
      end
    else
      for actorID, remainingTaskObject in next, task.instance.taskObjectsByActorID, nil do
        if string.find(actorID, "Hot Car") then
          if remainingTaskObject.coreData.agent.damage >= 1 then
            params.vehicle = remainingTaskObject.coreData.agent
            params.driverIsTanner = true
            break
          elseif remainingTaskObject.coreData.agent.controlled then
            params.vehicle = remainingTaskObject.coreData.agent
            params.driverIsTanner = true
            break
          else
            params.vehicle = remainingTaskObject.coreData.agent
            params.driverIsTanner = false
          end
        end
      end
    end
    if not params.vehicle then
      params.vehicle = task.agent
    end
  end
  if task.success then
    if task.specialName == "first second" then
      startOfTimer = g_NetworkTime
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      local prompt = {
        prompt = "ID:184826",
        delay = false,
        priority = 1
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    elseif task.specialName == "cars revealed" then
      task.instance.taskObjectsByActorID["Truck 1"].coreData.agent.iconsVisible = false
      task.instance.taskObjectsByActorID["Truck 2"].coreData.agent.iconsVisible = false
      task.instance.taskObjectsByActorID["Truck 3"].coreData.agent.iconsVisible = false
      task.instance.taskObjectsByActorID["Truck 4"].coreData.agent.iconsVisible = false
      task.instance.taskObjectsByActorID["Goon 1"].coreData.agent.iconsVisible = false
      task.instance.taskObjectsByActorID["Goon 2"].coreData.agent.iconsVisible = false
      task.instance.taskObjectsByActorID["Goon 3"].coreData.agent.iconsVisible = false
      local prompt = {
        prompt = "ID:184822",
        delay = false,
        priority = 1
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    elseif task.specialName == "lock cop" then
      zapcontroller.AddLockedVehicle(localID, {
        gameVehicle = task.agent.gameVehicle
      })
    elseif task.specialName == "force out of vehicle" then
      localPlayer:SetZapLevel(5, nil, true)
    elseif task.specialName == "first prompt" then
      feedbackSystem.menusMaster.setNextFocusString()
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      local prompt = {
        prompt = "ID:245550",
        delay = false,
        priority = 1
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    elseif task.specialName == "first prompt2" then
      feedbackSystem.menusMaster.setNextFocusString()
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      local prompt = {
        prompt = "ID:242124",
        delay = false,
        priority = 1
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    elseif task.specialName == "Driving away" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      local prompt = {
        prompt = "ID:245550",
        delay = true,
        priority = 1
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    elseif task.specialName == "chase hot car" then
      task.actor.tailingDistance = 35
      task.actor.groupAggression = "Low"
    elseif task.specialName == "hot car task" then
      localPlayer:clearZapReturnOverride()
      if Getaway.IsBeingChased(task.agent.gameVehicle) then
        Getaway.Stop(task.agent.gameVehicle)
      end
      if task.actor.ID == "Hot Car 1" then
        task.instance.taskObjectsByActorID["Truck 1"].coreData.agent.iconsVisible = false
        GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID["Truck 1"].coreData.agent.gameVehicle, false)
      elseif task.actor.ID == "Hot Car 2" then
        task.instance.taskObjectsByActorID["Truck 2"].coreData.agent.iconsVisible = false
        GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID["Truck 2"].coreData.agent.gameVehicle, false)
      elseif task.actor.ID == "Hot Car 3" then
        if task.instance.taskObjectsByActorID["Goon 1"] then
          task.instance.taskObjectsByActorID["Goon 1"]:delete()
        end
        if task.instance.taskObjectsByActorID["Goon 2"] then
          task.instance.taskObjectsByActorID["Goon 2"]:delete()
        end
        if task.instance.taskObjectsByActorID["Goon 3"] then
          task.instance.taskObjectsByActorID["Goon 3"]:delete()
        end
        task.instance.taskObjectsByActorID["Truck 3"].coreData.agent.iconsVisible = false
        GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID["Truck 3"].coreData.agent.gameVehicle, false)
      elseif task.actor.ID == "Hot Car 4" then
        task.instance.taskObjectsByActorID["Truck 4"].coreData.agent.iconsVisible = false
        GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID["Truck 4"].coreData.agent.gameVehicle, false)
      end
      for ID, vehicle in next, task.instance.taskObjectsByActorID, nil do
        if vehicle.coreData.actor.team == "Hot Car team" or vehicle.coreData.actor.team == "Hot Car team2" then
          if vehicle.coreData.actor.ID ~= task.actor.ID then
            vehicle.coreData.agent.iconsVisible = true
          end
        else
          task.actor.markerType = "None"
          feedbackSystem.taskSupport.instanceUpdateEvent()
        end
      end
      if task.instance.recoveredCars ~= 4 then
        if localPlayer.inZap and 4 > zapcontroller.getZapLevel() then
          localPlayer:SetZapLevel(5, nil, true)
        end
        local prompt = {
          prompt = "ID:184827",
          delay = false,
          priority = 1
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
      end
      if task.agent == localPlayer.currentVehicle then
        localPlayer:clearCurrentVehicle()
      end
    elseif task.specialName == "Boot out and clear" then
      if not localPlayer.inZap then
        localPlayer:SetZapLevel(1)
      end
    elseif task.specialName == "truck task" then
      task.instance.recoveredCars = task.instance.recoveredCars + 1
      feedbackSystem.taskSuccessAudio()
      if task.instance.recoveredCars == 4 then
        if taskObject.coreData.actor.ID == "Truck 3" then
          civilianTraffic.RemoveScriptLaneTrackInterloper(task.agent.gameVehicle)
        end
        task.instance.allFourReturned = true
        params.dialogue = "GPMV00_SUCCESS_L_1"
        params.vehicle = task.agent
        params.rating = "PASS"
        params.callback = completeTask
        localPlayer.challenge.endScreen(taskObject, params)
      end
    elseif task.specialName == "Wait for drive" then
      if not Chase.IsAChaseActive() and not Getaway.IsAGetawayActive() then
        felony_getaway.addEvader(evaderGameVehicle)
      end
      felony_getaway.addChaser(evaderGameVehicle, taskObject.coreData.agent.gameVehicle)
    end
  elseif task.specialName == "Get all cars" and not task.instance.allFourReturned then
    endScreenVehicle()
    params.dialogue = "GPMV00_FAILURE_L_1"
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "hot car task" or task.specialName == "Wait for player" then
    params.vehicle = task.agent
    if task.condition == 2 then
      params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
      params.reason = "Wrecked"
    elseif task.condition == 3 then
      params.failReason = "ID:186264"
      params.reason = "Busted"
    end
    params.dialogue = "GPMV00_FAILURE_L_1"
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  elseif string.find(task.specialName, "chase hot car") then
    goonsWrecked = goonsWrecked + 1
    if task.condition == 4 and goonsWrecked == 3 and not isEventActive() then
      iCamCrashCam(task.agent.gameVehicle)
    end
  end
end
missionEndCallback = missionEndCallback or {}
missionEndCallback["Gone in 59 seconds"] = function(instance)
  minimap.SetHighlightedVehicles(false)
  removeUserUpdateFunction("Reset capture timer")
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.ID == "Truck 3" then
      civilianTraffic.RemoveScriptLaneTrackInterloper(taskObject.coreData.agent.gameVehicle)
    end
  end
  GameVehicleResource.unregisterAttachedVehicleCallback(vehicleManager.attachedVehicleCallback)
  GameVehicleResource.unregisterAttachedVehicleDeleteRequestFn(vehicleManager.attachedVehicleDeleteRequest)
end
