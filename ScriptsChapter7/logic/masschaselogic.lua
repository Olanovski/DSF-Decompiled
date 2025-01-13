module("cardSystem.logic")
missionSetupData["Mass chase"] = {}
local timerBuffer = 3
local function playerTask(goalParams, HUD, audio)
  local task = {
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
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            {goal = "Got busted"}
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
        specialName = "Audio - First speech",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.75}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Lose the cops",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Being chased",
              params = {inverse = true}
            }
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            {goal = "Got busted"}
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
        specialName = "First prompt",
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
            style = "Mass chase hud"
          }
        }
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Lose cops warning",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            {
              goal = "Within radius",
              params = {value = 150}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Outside radius",
              params = {value = 150}
            }
          }
        },
        HUD = {
          {
            style = "Mass chase hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Audio - Guardian angel 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Simple collision check",
              params = {
                force = 7000,
                copsOnly = true,
                setOnPlayer = true
              }
            }
          },
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - To the first waypoint chat",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Agent escaping chasers",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 30}
            },
            {
              goal = "Recent audio played",
              params = {value = 2}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Agent escaping chasers",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 60}
            },
            {
              goal = "Recent audio played",
              params = {value = 2}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Agent escaping chasers",
              params = {inverse = true}
            },
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
        specialName = "Audio - Fighting the cops 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Agent escaping chasers"
            },
            {
              goal = "Recent audio played",
              params = {value = 2}
            }
          },
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Agent escaping chasers",
              params = {inverse = true}
            },
            {
              goal = "Recent audio played",
              params = {value = 2}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Felony chaser destroyed"
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
        specialName = "Audio - Player enters shift 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player using zap return",
              params = {inverse = true}
            },
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
        specialName = "Audio - Hit by cop 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Is player controlled"
            },
            {
              goal = "Simple collision check",
              params = {
                whereIWasHit = "Front",
                force = 7000,
                copsOnly = true
              }
            },
            {
              goal = "Player using ram",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Hit a cop 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Simple collision check",
              params = {
                whereIWasHit = "Front",
                force = 7000,
                copsOnly = true
              }
            },
            {
              goal = "Is player controlled"
            },
            {
              goal = "Player using ram"
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Non-linear Checkpoints",
        specialName = "Get to the safehouse",
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
        specialName = "Get to safety prompt",
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
            style = "Mass chase hud"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Cutscene end",
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
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            {goal = "Got busted"}
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "getToHighway",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 11}
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
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            {goal = "Got busted"}
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
        specialName = "Second PiP",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3.5}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - To the second waypoint chat",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Being chased"
            },
            {
              goal = "Agent escaping chasers",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 35}
            },
            {
              goal = "Recent audio played",
              params = {value = 2}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Being chased"
            },
            {
              goal = "Agent escaping chasers",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 65}
            },
            {
              goal = "Recent audio played",
              params = {value = 2}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Being chased"
            },
            {
              goal = "Agent escaping chasers",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 80}
            },
            {
              goal = "Recent audio played",
              params = {value = 2}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Being chased"
            },
            {
              goal = "Agent escaping chasers",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 100}
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
        specialName = "Audio - Fighting the cops 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Being chased"
            },
            {
              goal = "Agent escaping chasers"
            },
            {
              goal = "Recent audio played",
              params = {value = 2}
            }
          },
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Being chased"
            },
            {
              goal = "Agent escaping chasers",
              params = {inverse = true}
            },
            {
              goal = "Recent audio played",
              params = {value = 2}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Felony chaser destroyed"
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
        specialName = "Audio - Player enters shift 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Being chased"
            },
            {
              goal = "Player using zap return",
              params = {inverse = true}
            },
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
        specialName = "Audio - Hit by cop 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Is player controlled"
            },
            {
              goal = "Simple collision check",
              params = {
                whereIWasHit = "Front",
                force = 7000,
                copsOnly = true
              }
            },
            {
              goal = "Player using ram",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Hit a cop 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Simple collision check",
              params = {
                whereIWasHit = "Front",
                force = 7000,
                copsOnly = true
              }
            },
            {
              goal = "Is player controlled"
            },
            {
              goal = "Player using ram"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Guardian angel 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Simple collision check",
              params = {
                force = 7000,
                copsOnly = true,
                setOnPlayer = true
              }
            }
          },
          {
            {
              goal = "Being chased"
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
        specialName = "Reminder prompt about Aegis",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Specified actor is getaway",
              params = {actorID = "Player", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          }
        },
        HUD = {
          {
            style = "Mass chase hud"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Highway SoftSave",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            {goal = "Got busted"}
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
        task = "Linear Chase",
        specialName = "Chase",
        dynamicTargets = true,
        goalConditions = {
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Within radius",
              params = {value = 300}
            },
            {
              goal = "Is player controlled"
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Within radius",
              params = {value = 150}
            },
            {
              goal = "Is player controlled"
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Time trigger",
              params = {value = timerBuffer}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "In back of truck"
            }
          },
          {
            failCondition = true,
            {
              goal = "Time trigger",
              params = {
                value = 90 + timerBuffer
              }
            }
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            {goal = "Got busted"}
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
            style = "Mass chase hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Board the tuck prompt reminder",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Agent on highway"
            }
          },
          {
            {
              goal = "Specified actor is getaway",
              params = {actorID = "Player", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          }
        },
        HUD = {
          {
            style = "Mass chase hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Board the truck prompt",
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
            style = "Mass chase hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Start the music",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Agent on highway"
            },
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Hurry up",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
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
        specialName = "Audio - Hurry up reminder",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 60}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Fighting the cops 3",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Being chased"
            },
            {
              goal = "Agent escaping chasers"
            },
            {
              goal = "Recent audio played",
              params = {value = 2}
            }
          },
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Being chased"
            },
            {
              goal = "Agent escaping chasers",
              params = {inverse = true}
            },
            {
              goal = "Recent audio played",
              params = {value = 2}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Felony chaser destroyed"
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
        specialName = "Audio - Player enters shift 3",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player using zap return",
              params = {inverse = true}
            },
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
        specialName = "Audio - Hit by cop 3",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Is player controlled"
            },
            {
              goal = "Simple collision check",
              params = {
                whereIWasHit = "Front",
                force = 7000,
                copsOnly = true
              }
            },
            {
              goal = "Player using ram",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Hit a cop 3",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Simple collision check",
              params = {
                whereIWasHit = "Front",
                force = 7000,
                copsOnly = true
              }
            },
            {
              goal = "Is player controlled"
            },
            {
              goal = "Player using ram"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Guardian angel 3",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Simple collision check",
              params = {
                force = 7000,
                copsOnly = true,
                setOnPlayer = true
              }
            }
          },
          {
            {
              goal = "Being chased"
            },
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
        task = "No AI",
        specialName = "After chase",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5}
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
local buddyTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "Linear Checkpoints",
        specialName = "Truck task",
        dynamicTargets = true,
        coreData = {totalLaps = 0},
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
        }
      }
    }
  }
  return task
end
local copTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOncompletion = true,
    {
      {
        task = "No AI",
        specialName = "Cops wait",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 25}
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
local copAmbushTask = function(goalParams, HUD)
  local task = {
    {
      {task = "No AI"}
    }
  }
  return task
end
local copTruckTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "Linear Chase",
        specialName = "Chase truck",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Target damage above",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Is a felony active",
              params = {inverse = true}
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
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Remove fake cop",
        taskConditions = {
          {
            forceTaskComplete = true,
            {
              goal = "Within radius of player",
              params = {value = 200, inverse = true}
            }
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Mass chase"].taskCreatorFunctionLookups = {
  ["Player team"] = playerTask,
  ["Buddy team"] = buddyTask,
  ["Spawner team"] = copAmbushTask,
  ["Spawner 2 team"] = copTruckTask,
  ["Cop 7 Actor"] = copTask,
  ["Cop 11 Actor"] = copTask
}
local safeHousePosition = vec.vector(-1087.894, 66.663, 1898.085, 1)
local ambushPosition = vec.vector(-1940.078, 65.441, 1771.37, 1)
local teleportPosition = vec.vector(-1949.171, 65.484, 1773.081, 1)
local teleportHeading = -3.03
local marker
missionSetupData["Mass chase"].initiate = function(instance)
  createCheckpoints(instance)
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    feedbackSystem.menusMaster.setCurrentFocusString(3)
  end
  createFixedPosition(instance, {safeHousePosition}, 99)
  createFixedPosition(instance, {ambushPosition}, 98)
  GameVehicleResource.registerAttachedVehicleCallback(vehicleManager.attachedVehicleCallback)
  GameVehicleResource.registerAttachedVehicleDeleteRequestFn(vehicleManager.attachedVehicleDeleteRequest)
  instance.blockHurryAudio = false
end
missionSetupData["Mass chase"].update = nil
local playerTeamDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Chase" then
    if dynamicListID then
      return false, true
    else
      return {
        task.instance.taskObjectsByActorID.Truck.coreData.agent
      }, false
    end
  elseif task.specialName == "Get to the safehouse" or task.specialName == "Lose the cops" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 98), false
    end
  elseif task.specialName == "Lose cops warning" then
    return checkpointSystem.getCheckpoints(task.instance, 98), false
  elseif dynamicListID then
    return false, true
  else
    return checkpointSystem.getCheckpoints(task.instance, 99), false
  end
end
local buddyTeamDynamicTargets = function(taskObject, task, dynamicListID)
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
end
local copTeamDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID.Player.coreData.agent
    }, false
  end
end
local cop2TeamDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID.Truck.coreData.agent
    }, false
  end
end
missionSetupData["Mass chase"].targetList = {
  ["Player team"] = playerTeamDynamicTargets,
  ["Buddy team"] = buddyTeamDynamicTargets,
  ["Spawner team"] = copTeamDynamicTargets,
  ["Spawner 2 team"] = cop2TeamDynamicTargets
}
taskCompleteData["Mass chase"] = {}
taskCompleteData["Mass chase"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.Player.coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235490",
    driverIsTanner = false
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.specialName == "Audio - First speech" then
    felony_getaway.addEvader(task.agent.gameVehicle)
    for k, v in next, task.instance.taskObjectsByActorID, nil do
      if v.coreData.actor.team == "Spawner team" then
        felony_getaway.addChaser(task.agent.gameVehicle, v.coreData.agent.gameVehicle)
      end
    end
  elseif task.specialName == "Initial pause" then
    if not task.success then
      if taskObject.coreData.agent.damage >= 1 then
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        params.reason = "Wrecked"
        params.dialogue = "GPMV00_FAILURE_L_2"
      else
        params.failReason = "ID:184793"
        params.reason = "Busted"
      end
      params.driverIsTanner = true
      params.callback = failTask
      params.rating = "FAIL"
      feedbackSystem.stopMusic("Uid02821_CH05_Standard_IDidItForYou_Stop")
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "Lose the cops" then
    if not task.success then
      if taskObject.coreData.agent.damage >= 1 then
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        params.reason = "Wrecked"
        params.dialogue = "GPMV00_FAILURE_L_2"
      else
        params.failReason = "ID:184793"
        params.reason = "Busted"
      end
      params.driverIsTanner = true
      params.callback = failTask
      params.rating = "FAIL"
      feedbackSystem.stopMusic("Uid02821_CH05_Standard_IDidItForYou_Stop")
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "Get to the safehouse" then
    if not task.success then
      params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
      params.reason = "Wrecked"
      params.dialogue = "GPMV00_FAILURE_L_2"
      params.driverIsTanner = true
      params.callback = failTask
      params.rating = "FAIL"
      feedbackSystem.stopMusic("Uid02821_CH05_Standard_IDidItForYou_Stop")
      localPlayer.challenge.endScreen(taskObject, params)
    else
      if not task.agent.controlled then
        if localPlayer.inZap then
          localPlayer:SetZapLevel(0, task.agent, false)
        else
          localPlayer:SetZapLevel(1)
          localPlayer:SetZapLevel(0, task.agent, false)
        end
      end
      if task.agent.gameVehicle.isBeingTowed then
        vehicleManager.unhookPlayerVehicle()
      end
      engineCutscene.playCutscene("mis_ch5_foryou_01", function()
        task.agent:teleportToPositionAndHeading(teleportPosition, teleportHeading)
      end, function()
        challengeSystem.spawnActors(taskObject.coreData.instance, "Any", {
          ["Cop 3 Actor"] = true,
          ["Cop 4 Actor"] = true,
          ["Cop 5 Actor"] = true,
          ["Cop 8 Actor"] = true
        })
        task.agent:unlockEmergencyBrakes()
        feedbackSystem.menusMaster.setCurrentFocusString(3)
      end, nil)
    end
  elseif task.specialName == "Cutscene end" then
    progressionSystem.triggerSoftSave({progression = 1})
    felony_getaway.addEvader(task.agent.gameVehicle)
    felony_getaway.addChaser(task.agent.gameVehicle, task.instance.taskObjectsByActorID["Cop 3 Actor"].coreData.agent.gameVehicle)
    felony_getaway.addChaser(task.agent.gameVehicle, task.instance.taskObjectsByActorID["Cop 4 Actor"].coreData.agent.gameVehicle)
    felony_getaway.addChaser(task.agent.gameVehicle, task.instance.taskObjectsByActorID["Cop 5 Actor"].coreData.agent.gameVehicle)
    felony_getaway.addChaser(task.agent.gameVehicle, task.instance.taskObjectsByActorID["Cop 8 Actor"].coreData.agent.gameVehicle)
  elseif task.specialName == "getToHighway" then
    if not task.success then
      if taskObject.coreData.agent.damage >= 1 then
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        params.reason = "Wrecked"
        params.dialogue = "GPMV00_FAILURE_L_2"
      else
        params.failReason = "ID:184793"
        params.reason = "Busted"
      end
      params.driverIsTanner = true
      params.callback = failTask
      params.rating = "FAIL"
      feedbackSystem.stopMusic("Uid02821_CH05_Standard_IDidItForYou_Stop")
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "Highway SoftSave" then
    if not task.success then
      if taskObject.coreData.agent.damage >= 1 then
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        params.reason = "Wrecked"
        params.dialogue = "GPMV00_FAILURE_L_2"
      else
        params.failReason = "ID:184793"
        params.reason = "Busted"
      end
      params.driverIsTanner = true
      params.callback = failTask
      params.rating = "FAIL"
      feedbackSystem.stopMusic("Uid02821_CH05_Standard_IDidItForYou_Stop")
      localPlayer.challenge.endScreen(taskObject, params)
    else
      OneShotSound.Play("HUD_Play_Waypoint")
      progressionSystem.triggerSoftSave({progression = 2})
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      challengeSystem.spawnActors(taskObject.coreData.instance, "Any", {Truck = true})
      GameVehicleResource.createTrailerAndHookup({
        gameVehicle = task.instance.taskObjectsByActorID.Truck.coreData.agent.gameVehicle,
        panelSet = 0,
        trailerId = 289
      })
      GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID.Truck.coreData.agent.gameVehicle, true)
      if not marker and task.instance.taskObjectsByActorID.Truck then
        marker = feedbackSystem.newTarget(task.instance.taskObjectsByActorID.Truck.coreData.agent, "Exclamation marker")
      end
      challengeSystem.spawnActors(taskObject.coreData.instance, "Any", {
        ["Cop 7 Actor"] = true,
        ["Cop 11 Actor"] = true
      })
      feedbackSystem.menusMaster.setCurrentFocusString(5)
    end
  elseif task.specialName == "Cops wait" then
    felony_getaway.addEvader(task.instance.taskObjectsByActorID.Player.coreData.agent.gameVehicle)
    felony_getaway.addChaser(task.instance.taskObjectsByActorID.Player.coreData.agent.gameVehicle, task.instance.taskObjectsByActorID["Cop 7 Actor"].coreData.agent.gameVehicle)
    felony_getaway.addChaser(task.instance.taskObjectsByActorID.Player.coreData.agent.gameVehicle, task.instance.taskObjectsByActorID["Cop 11 Actor"].coreData.agent.gameVehicle)
    challengeSystem.spawnActors(task.instance, "Any", {
      ["Cop 9 Actor"] = true,
      ["Cop 10 Actor"] = true
    })
  elseif task.specialName == "Chase" then
    if task.success then
      GameVehicleResource.unregisterAttachedVehicleDeleteRequestFn(vehicleManager.attachedVehicleDeleteRequest)
      GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID.Truck.coreData.agent.gameVehicle, false)
      if marker then
        feedbackSystem.clearTarget(marker)
        marker = nil
      end
    else
      params.vehicle = task.instance.taskObjectsByActorID.Truck.coreData.agent
      if taskObject.coreData.agent.damage >= 1 then
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        params.reason = "Wrecked"
        params.dialogue = "GPMV00_FAILURE_L_2"
        params.vehicle = task.agent
      elseif task.condition == 2 then
        params.failReason = "ID:184792"
        params.dialogue = "GPMV00_FAILURE_L_1"
      else
        params.failReason = "ID:184793"
        params.reason = "Busted"
        params.vehicle = task.agent
      end
      params.callback = failTask
      params.rating = "FAIL"
      feedbackSystem.stopMusic("Uid02821_CH05_Standard_IDidItForYou_Stop")
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "After chase" then
    params.callback = completeTask
    params.vehicle = task.instance.taskObjectsByActorID.Truck.coreData.agent
    params.rating = "PASS"
    params.dialogue = "GPMV00_SUCCESS_L_1"
    feedbackSystem.stopMusic("Uid02821_CH05_Standard_IDidItForYou_Stop")
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "Truck task" and not task.success then
    params.vehicle = task.instance.taskObjectsByActorID.Truck.coreData.agent
    params.failReason = "ID:235444"
    params.callback = failTask
    params.rating = "FAIL"
    feedbackSystem.stopMusic("Uid02821_CH05_Standard_IDidItForYou_Stop")
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Mass chase"] = function(instance)
  if marker then
    feedbackSystem.clearTarget(marker)
    marker = nil
  end
  if instance.taskObjectsByActorID.Truck then
    zapcontroller.RemoveLockedVehicle({
      gameVehicle = instance.taskObjectsByActorID.Truck.coreData.agent.gameVehicle
    })
  end
  instance.blockHurryAudio = false
  GameVehicleResource.unregisterAttachedVehicleCallback(vehicleManager.attachedVehicleCallback)
  GameVehicleResource.unregisterAttachedVehicleDeleteRequestFn(vehicleManager.attachedVehicleDeleteRequest)
end
