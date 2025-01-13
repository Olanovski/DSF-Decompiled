module("cardSystem.logic")
missionSetupData["Tanner & Jones Mission 1"] = {}
local tannerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Linear Chase",
        dynamicTargets = true,
        specialName = "first audio",
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5}
            },
            {
              goal = "Is player controlled"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            {
              goal = "Player in zap"
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
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
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Chase",
        dynamicTargets = true,
        specialName = "Racer task 1",
        goalConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1"}
            },
            {
              goal = "Player has jumped off a vehicle",
              params = {
                modelID = {298}
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
            forceTaskComplete = true,
            failCondition = true,
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
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "In Racer 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1"}
            }
          },
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1"}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        HUD = {
          {
            style = "Tanner & Jones Mission 1 HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Zap to racer dialogue 1",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            },
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
        specialName = "Player in agent 1",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1"}
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
        specialName = "A ramp truck needs to be respawned",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Transporter1"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Transporter2"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Transporter3"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Transporter4"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Transporter5"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Transporter6"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          }
        }
      }
    },
    {
      {
        task = "Linear Chase",
        dynamicTargets = true,
        specialName = "Zap to tanner 1",
        taskConditions = {
          {
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Is jumping",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.25}
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
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
        }
      }
    },
    {
      {
        task = "Linear Chase",
        dynamicTargets = true,
        specialName = "Back in tanner 1",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
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
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Chase",
        dynamicTargets = true,
        specialName = "Speech finished 1",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
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
        }
      }
    },
    {
      {
        task = "Linear Chase",
        dynamicTargets = true,
        specialName = "Racer task 2",
        goalConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1"}
            },
            {
              goal = "Is a felony active"
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
            failCondition = true,
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
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "In Racer 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1"}
            }
          },
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1"}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Tanner & Jones Mission 1 HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Zap to racer dialogue 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            },
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
        specialName = "Player in agent 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1"}
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
        task = "Linear Chase",
        dynamicTargets = true,
        specialName = "Wait for Icam",
        taskConditions = {
          {
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
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
        }
      }
    },
    {
      {
        task = "Linear Chase",
        dynamicTargets = true,
        specialName = "Racer task lose cop",
        goalConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1"}
            },
            {
              goal = "Is a felony active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
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
            failCondition = true,
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
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "In Racer lose cop",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1"}
            }
          },
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1"}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Tanner & Jones Mission 1 HUD"
          }
        }
      }
    },
    {
      {
        task = "Linear Chase",
        dynamicTargets = true,
        specialName = "Wait for Icam after felony loss",
        taskConditions = {
          {
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
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
        }
      }
    },
    {
      {
        task = "Linear Chase",
        dynamicTargets = true,
        specialName = "Back in tanner 2",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
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
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Zap to tanner 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.25}
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
        task = "Linear Chase",
        dynamicTargets = true,
        specialName = "Speech finished 2",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
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
        }
      }
    },
    {
      {
        task = "Linear Chase",
        dynamicTargets = true,
        specialName = "Racer task 3",
        goalConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1"}
            },
            {
              goal = "Target being towed"
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
            failCondition = true,
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
        }
      },
      {
        task = "No AI",
        specialName = "In Racer 3",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1"}
            }
          },
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1"}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Tanner & Jones Mission 1 HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Zap to racer dialogue 3",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            },
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
        specialName = "Player in agent 3",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Racer1"}
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
        specialName = "A tow truck needs to be respawned",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"TowTruck1"},
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"TowTruck2"},
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"TowTruck3"},
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"TowTruck4"},
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"TowTruck5"},
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"TowTruck6"},
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"TowTruck7"},
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"TowTruck8"},
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "End mission",
        taskConditions = {
          {
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
              params = {value = 1}
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
local racerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Wander",
        specialName = "Opponent task",
        taskConditions = {
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
        HUD = {
          {
            style = "Tanner & Jones Mission 1 HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Set damage multiplier",
        dynamicTargets = true,
        goalConditions = {
          {
            skipTargetUpdate = true,
            {
              goal = "Is player controlled",
              params = {target = "Target"}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Is player controlled"
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Is player controlled",
              params = {target = "Target", inverse = true}
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
            }
          }
        }
      }
    }
  }
  return task
end
local copTask = function(goalParams, HUD, audio)
  local task = {
    {
      {task = "No AI"}
    }
  }
  return task
end
local spawnerTeamTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Kill respawn 1",
        taskConditions = {
          {
            forceTaskComplete = true,
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
                value = 350,
                target = "Player",
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          },
          {
            forceTaskComplete = true,
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Player within radius in zap",
              params = {
                value = 350,
                useOperandA = true,
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
        specialName = "Player shifted into agent",
        groupProgression = {priorityMinorOrder = true},
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            }
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Kill respawn 2",
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
              goal = "Within radius",
              params = {
                value = 350,
                target = "Player",
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 1.5}
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
                value = 350,
                useOperandA = true,
                inverse = true
              }
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
missionSetupData["Tanner & Jones Mission 1"].taskCreatorFunctionLookups = {
  ["Tanner team"] = tannerTask,
  ["Racer team"] = racerTask,
  ["Cop team"] = racerTask,
  ["Ramptruck team"] = spawnerTeamTask,
  ["Towtruck team"] = spawnerTeamTask
}
missionSetupData["Tanner & Jones Mission 1"].initiate = function(instance)
  localPlayer:blockAbility("zap", true)
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    feedbackSystem.startMusic("Uid04354_CH01_TJ_ProveIt_Play")
    instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.speed = 17.88
  end
end
missionSetupData["Tanner & Jones Mission 1"].update = nil
local removeVehicleFromTraffic = function(gameVehicle, reason)
  local vehicleAgent = vehicleManager.vehiclesByGameVehicle[gameVehicle]
  local vehicleWander = {
    traits = taskSystem.buildDriveTraits(vehicleAgent:getTaskObject().coreData)
  }
  vehicleAgent:getTaskObject().coreData.agent:highSpeedDrive(vehicleWander)
end
missionSetupData["Tanner & Jones Mission 1"].goalComplete = function(taskObject, task, conditionKey)
  if task.specialName == "A ramp truck needs to be respawned" then
    local truckToSpawn = false
    if conditionKey == 1 then
      truckToSpawn = "Transporter1"
    elseif conditionKey == 2 then
      truckToSpawn = "Transporter2"
    elseif conditionKey == 3 then
      truckToSpawn = "Transporter3"
    elseif conditionKey == 4 then
      truckToSpawn = "Transporter4"
    elseif conditionKey == 5 then
      truckToSpawn = "Transporter5"
    elseif conditionKey == 6 then
      truckToSpawn = "Transporter6"
    end
    if truckToSpawn then
      challengeSystem.spawnActors(task.instance, "Any", {
        [truckToSpawn] = true
      })
      local hasBeenAddedToTraffic
      hasBeenAddedToTraffic = civilianTraffic.AddScriptLaneTrackInterloper(task.instance.taskObjectsByActorID[truckToSpawn].coreData.agent.gameVehicle, removeVehicleFromTraffic)
      if not hasBeenAddedToTraffic then
        removeVehicleFromTraffic(task.instance.taskObjectsByActorID[truckToSpawn].coreData.agent.gameVehicle)
      end
    end
  elseif task.specialName == "A tow truck needs to be respawned" then
    local truckToSpawn = false
    if conditionKey == 1 then
      truckToSpawn = "TowTruck1"
    elseif conditionKey == 2 then
      truckToSpawn = "TowTruck2"
    elseif conditionKey == 3 then
      truckToSpawn = "TowTruck3"
    elseif conditionKey == 4 then
      truckToSpawn = "TowTruck4"
    elseif conditionKey == 5 then
      truckToSpawn = "TowTruck5"
    elseif conditionKey == 6 then
      truckToSpawn = "TowTruck6"
    elseif conditionKey == 7 then
      truckToSpawn = "TowTruck7"
    elseif conditionKey == 8 then
      truckToSpawn = "TowTruck8"
    end
    if truckToSpawn then
      challengeSystem.spawnActors(task.instance, "Any", {
        [truckToSpawn] = true
      })
      local hasBeenAddedToTraffic
      hasBeenAddedToTraffic = civilianTraffic.AddScriptLaneTrackInterloper(task.instance.taskObjectsByActorID[truckToSpawn].coreData.agent.gameVehicle, removeVehicleFromTraffic)
      if not hasBeenAddedToTraffic then
        removeVehicleFromTraffic(task.instance.taskObjectsByActorID[truckToSpawn].coreData.agent.gameVehicle)
      end
    end
  elseif task.specialName == "Set damage multiplier" then
    if conditionKey == 1 then
      task.agent:set_damageMultiplier(0.2)
      task.instance.taskObjectsByActorID.Tanner.coreData.agent:set_damageMultiplier(0.5)
    elseif conditionKey == 2 then
      task.agent:set_damageMultiplier(0.5)
      task.instance.taskObjectsByActorID.Tanner.coreData.agent:set_damageMultiplier(0.2)
    else
      task.agent:set_damageMultiplier(0.2)
      task.instance.taskObjectsByActorID.Tanner.coreData.agent:set_damageMultiplier(0.2)
    end
  end
end
local tannerDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID.Racer1.coreData.agent
    }, false
  end
end
local jackassDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID.Tanner.coreData.agent
    }, false
  end
end
missionSetupData["Tanner & Jones Mission 1"].targetList = {
  ["Tanner team"] = tannerDynamicTargets,
  ["Racer team"] = jackassDynamicTargets
}
taskCompleteData["Tanner & Jones Mission 1"] = {}
taskCompleteData["Tanner & Jones Mission 1"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.Racer1.coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    successReasonPerfect = task.instance.challenge.taskCompleteData["Success reason (perfect)"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    driverIsTanner = true,
    hint = "ID:235500",
    hintIcon1 = localPlayer.buttonLayout.minimapZoom
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  local iCamStartTime = g_NetworkTime
  local function finishiCam()
    if g_NetworkTime > iCamStartTime + 0.45 then
      if not localPlayer.scoring.isJumping or localPlayer.scoring.isJumping and not localPlayer.scoring.rewardJump or g_NetworkTime >= iCamStartTime + 0.8 then
        return true
      else
        return false
      end
    else
      return false
    end
  end
  local function activateIcam(duration, callback)
    removeUserUpdateFunction("waitForHighlight")
    local iCamTable = {
      cameraTargets = {
        task.instance.taskObjectsByActorID.Racer1.coreData.agent.gameVehicle
      },
      duration = duration,
      speed = 0.2,
      framing = "",
      angleYaw = "",
      stopFunction = nil,
      radiusCam = nil,
      anglePitch = nil
    }
    if task.specialName == "Racer task 1" then
      iCamStartTime = g_NetworkTime
      iCamTable.framing = "wide"
      iCamTable.angleYaw = "rear quarter"
      iCamTable.stopFunction = finishiCam
      iCamTable.radiusCam = 10
      iCamActivationTableInput(iCamTable)
    elseif task.specialName == "Racer task 2" then
      iCamTable.framing = "wide"
      iCamTable.angleYaw = "profile"
      iCamActivationTableInput(iCamTable)
    elseif task.specialName == "Racer task lose cop" then
      iCamTable.framing = "mid"
      iCamTable.angleYaw = "front"
      iCamTable.anglePitch = "low"
      iCamTable.radiusCam = 25
      iCamTable.hudParams = {prompts = true}
      iCamActivationTableInput(iCamTable)
    elseif task.specialName == "Racer task 3" then
      iCamTable.framing = "wide"
      iCamTable.angleYaw = "profile"
      iCamTable.radiusCam = 6
      iCamActivationTableInput(iCamTable)
    else
      iCamTable.framing = "wide"
      iCamTable.angleYaw = "front quarter"
      iCamActivationTableInput(iCamTable)
    end
  end
  if task.success then
    if task.specialName == "first audio" then
      challengeSystem.spawnActors(task.instance, "Never", {
        Transporter1 = true,
        Transporter2 = true,
        Transporter3 = true,
        Transporter4 = true,
        Transporter5 = true,
        Transporter6 = true
      })
      localPlayer:blockAbility("zap", false)
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == "Ramptruck team" then
          local hasBeenAddedToTraffic
          hasBeenAddedToTraffic = civilianTraffic.AddScriptLaneTrackInterloper(taskObject.coreData.agent.gameVehicle, removeVehicleFromTraffic)
          if not hasBeenAddedToTraffic then
            removeVehicleFromTraffic(taskObject.coreData.agent.gameVehicle)
          end
        end
      end
    elseif string.find(task.specialName, "Speech finished") then
      localPlayer:blockAbility("zap", false)
    elseif string.find(task.specialName, "Racer task") then
      if task.specialName == "Racer task 1" then
        activateIcam(-1, finishiCam)
      elseif task.specialName == "Racer task 2" then
        feedbackSystem.menusMaster.setCurrentFocusString(6)
        PatrollingVehicleManager.EnableHud(true)
        activateIcam(4, nil)
      else
        activateIcam(4, nil)
      end
      minimap.RemoveAllHighlightedVehicleModelUIDs()
    elseif string.find(task.specialName, "Zap to tanner") then
      if not task.agent.controlled then
        if localPlayer.inZap then
          localPlayer:SetZapLevel(0, task.agent, false)
        else
          localPlayer:zapToAgent(task.agent)
        end
      end
    elseif task.specialName == "Player in agent 2" then
      felony_patrollingVehicleManager.enablePatrollingVehicles(true)
      PatrollingVehicleManager.EnableHud(false)
    elseif task.specialName == "Back in tanner 1" then
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == "Ramptruck team" then
          civilianTraffic.RemoveScriptLaneTrackInterloper(taskObject.coreData.agent.gameVehicle)
          taskObject:delete()
        end
      end
      progressionSystem.triggerSoftSave({progression = 1})
      localPlayer:blockAbility("zap", true)
      feedbackSystem.menusMaster.setCurrentFocusString(1)
    elseif task.specialName == "Back in tanner 2" then
      progressionSystem.triggerSoftSave({progression = 2})
      localPlayer:blockAbility("zap", true)
      feedbackSystem.menusMaster.setCurrentFocusString(1)
      challengeSystem.spawnActors(task.instance, "Never", {
        TowTruck1 = true,
        TowTruck2 = true,
        TowTruck3 = true,
        TowTruck4 = true
      })
      challengeSystem.spawnActors(task.instance, "Never", {
        TowTruck5 = true,
        TowTruck6 = true,
        TowTruck7 = true,
        TowTruck8 = true
      })
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == "Towtruck team" then
          local hasBeenAddedToTraffic
          hasBeenAddedToTraffic = civilianTraffic.AddScriptLaneTrackInterloper(taskObject.coreData.agent.gameVehicle, removeVehicleFromTraffic)
          if not hasBeenAddedToTraffic then
            removeVehicleFromTraffic(taskObject.coreData.agent.gameVehicle)
          end
        end
      end
    elseif task.specialName == "Kill respawn 1" then
      civilianTraffic.RemoveScriptLaneTrackInterloper(taskObject.coreData.agent.gameVehicle)
      taskObject:delete(true)
    elseif task.specialName == "Kill respawn 2" then
      taskObject:delete(true)
    elseif task.specialName == "Player shifted into agent" then
      civilianTraffic.RemoveScriptLaneTrackInterloper(taskObject.coreData.agent.gameVehicle)
      player.setAttachment(localPlayer.localID, localPlayer.currentVehicle.gameVehicle)
      player.registerController(localPlayer.localID)
    elseif task.specialName == "End mission" then
      params.callback = completeTask
      params.dialogue = "GPMV00_SUCCESS_L_1"
      params.rating = "PASS"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  else
    if taskObject.playerTask then
      params.dialogue = "GPMV01_FAILURE_L_1"
      params.failReason = "ID:184015"
      params.vehicle = task.instance.taskObjectsByActorID.Tanner.coreData.agent
      params.reason = "Wrecked"
    else
      if task.condition == 1 then
        params.dialogue = "GPMV02_FAILURE_L_1"
        params.failReason = "ID:184015"
        params.reason = "Wrecked"
      elseif task.condition == 2 then
        params.dialogue = "GPMV02_FAILURE_L_2"
        params.failReason = "ID:186264"
        params.reason = "Busted"
      end
      params.vehicle = task.instance.taskObjectsByActorID.Racer1.coreData.agent
    end
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Tanner & Jones Mission 1"] = function(instance)
  Sound.EnableScoring("jump", false)
  localPlayer:blockAbility("zap", false)
  PatrollingVehicleManager.EnableHud(true)
  feedbackSystem.stopMusic("Uid04354_CH01_TJ_ProveIt_Stop")
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.team == "Ramptruck team" then
      civilianTraffic.RemoveScriptLaneTrackInterloper(taskObject.coreData.agent.gameVehicle)
      taskObject:delete()
    end
  end
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.team == "Towtruck team" then
      civilianTraffic.RemoveScriptLaneTrackInterloper(taskObject.coreData.agent.gameVehicle)
      taskObject:delete()
    end
  end
end
