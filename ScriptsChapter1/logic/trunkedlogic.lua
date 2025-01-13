module("cardSystem.logic")
missionSetupData.Trunked = {}
local waitTimeAfterKill = 3
local firstTimer = 25
local secondTimer = 25
local thirdTimer = 25
local trunkViewTime = 3.5
local initalZapSlowMo
local function playerTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = true},
        specialName = "Initial Stall",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5}
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
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Reached 1st Destination",
        dynamicTargets = true,
        goalConditions = {
          {
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
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = true},
        specialName = "Wait for 1st Destination Prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5}
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
        HUD = {
          {
            style = "Trunked HUD"
          }
        }
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "Audio - Wait for 1st Destination Prompt",
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
        task = "No AI",
        specialName = "Audio - 1st Destination Zap Prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Button Press",
              params = {watchFor = "Pressed", button = "Zap_In"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Audio - Wait for 2nd Destination Prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 6}
            }
          },
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
        },
        HUD = {
          {
            style = "Trunked HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Reached 2nd Destination",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 150}
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
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - 2nd Destination Zap Prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Button Press",
              params = {watchFor = "Pressed", button = "Zap_In"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = true},
        specialName = "Audio - Wait for 3rd Destination Prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 9}
            }
          },
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
        },
        HUD = {
          {
            style = "Trunked HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Reached 3rd Destination",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 150}
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
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - 3rd Destination Zap Prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Button Press",
              params = {watchFor = "Pressed", button = "Zap_In"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = true},
        specialName = "Audio - Wait for 4th Destination Prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 5}
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
        HUD = {
          {
            style = "Trunked HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Reached 4th Destination",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 30}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            },
            {
              goal = "Agent brought to a halt"
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
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Zap to TrunkedBootViewActor1",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 20}
            }
          },
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
        },
        HUD = {
          {
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Player is in TrunkedBootViewActor1",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "TrunkedBootViewActor1"
              }
            },
            {
              goal = "Game has stopped spooling"
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
        HUD = {
          {
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Open trunk",
        taskConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 1.5}
            },
            {
              goal = "Button Press",
              params = {
                watchFor = "JustPressed",
                button = "Open_Trunk",
                number = 5
              }
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
        HUD = {
          {
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Sit in TrunkedBootViewActor1",
        goalConditions = {},
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "TrunkedBootViewActor1"
              }
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = trunkViewTime}
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
        HUD = {
          {
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Player back from TrunkedBootViewActor1",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Tanner"}
            },
            {
              goal = "Game has stopped spooling"
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
        HUD = {
          {
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Reached 5th Destination",
        dynamicTargets = true,
        goalConditions = {
          {
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
            {
              goal = "Time trigger",
              params = {value = 3}
            },
            {
              goal = "Time trigger",
              params = {value = firstTimer},
              feedback = "Timer"
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
            style = "Trunked HUD",
            settings = {timerStart = firstTimer}
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Wait for 5th Destination Prompt",
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
            style = "Trunked HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Audio - 5th Destination Zap Prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Button Press",
              params = {watchFor = "Pressed", button = "Zap_In"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Zap to TrunkedBootViewActor2",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 20}
            }
          },
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
        },
        HUD = {
          {
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Arrive at TrunkedBootViewActor2",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "TrunkedBootViewActor2"
              }
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
        HUD = {
          {
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Sit in TrunkedBootViewActor2",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "TrunkedBootViewActor2"
              }
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = trunkViewTime}
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
        HUD = {
          {
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Back from TrunkedBootViewActor2",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Tanner"}
            },
            {
              goal = "Game has stopped spooling"
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
        HUD = {
          {
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Reached 6th Destination",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 90}
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
              goal = "Time trigger",
              params = {value = secondTimer},
              feedback = "Timer"
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
            style = "Trunked HUD",
            settings = {timerStart = secondTimer}
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Wait for 6th Destination Prompt",
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
            style = "Trunked HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Audio - 6th Destination Zap Prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Button Press",
              params = {watchFor = "Pressed", button = "Zap_In"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Zap to TrunkedActor",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 20}
            }
          },
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
        },
        HUD = {
          {
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Arrive at TrunkedActor",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "TrunkedActor"
              }
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
        HUD = {
          {
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Chase",
        specialName = "Sit in TrunkedActor",
        dynamicTargets = true,
        goalConditions = {},
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "TrunkedActor"
              }
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = trunkViewTime}
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
        HUD = {
          {
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Back from TrunkedActor",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Tanner"}
            },
            {
              goal = "Game has stopped spooling"
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
        HUD = {
          {
            style = "Trunked HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Find car",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Player within radius of opposing team member",
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
            failCondition = true,
            {
              goal = "Time trigger",
              params = {value = thirdTimer},
              feedback = "Timer"
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
        HUD = {
          {
            style = "Trunked HUD",
            settings = {timerStart = thirdTimer}
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - find car zap prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Button Press",
              params = {watchFor = "Pressed", button = "Zap_In"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Trigger softsave",
        goalConditions = {},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
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
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Cutscene mis_ch1_kidnapped_01 finished Player",
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
        HUD = {
          {
            style = "Trunked HUD"
          }
        }
      }
    },
    {
      {
        task = "Linear Chase",
        specialName = "Chase car",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
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
        HUD = {
          {
            style = "Trunked HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Third softsave",
        taskConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Head on Actor"
                }
              }
            },
            {
              goal = "Player in zap",
              params = {value = true}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Audio - chase car zap prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = true}
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
local opponentTask = function(goalParams, HUD, audio, agent, actorID)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Player in TrunkedActor",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = actorID}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Boot cam actor active",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = actorID}
            },
            {
              goal = "Game has stopped spooling"
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
        specialName = "Player in Tanner vehicle",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Tanner"}
            },
            {
              goal = "Game has stopped spooling"
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
        specialName = "Player Nearby",
        taskConditions = {
          {
            {
              goal = "Player within radius of opposing team member",
              params = {value = 50}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Cutscene mis_ch1_kidnapped_01 started TrunkedActor",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = false}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Cutscene mis_ch1_kidnapped_01 finished TrunkedActor",
        taskConditions = {
          {
            {
              goal = "In cutscene",
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
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Tutorial start",
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
        specialName = "Is Tutorial Prompt Finished",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.2}
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
        task = "Follow Route",
        specialName = "Vehicle making escape",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        specialName = "Check victim collision",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            failCondition = true,
            {
              goal = "Simple collision check",
              params = {
                whereIWasHit = "Behind",
                force = 3000,
                playerMustHitTarget = true
              }
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Hit kidnapper",
        groupProgression = {priorityMinorOrder = true},
        taskConditions = {
          {
            {
              goal = "Simple collision check",
              params = {
                whereIWasHit = "Front",
                force = 1000,
                playerMustHitTarget = true
              }
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Missed kidnapper",
        groupProgression = {priorityMinorOrder = true},
        taskConditions = {
          {
            failCondition = true,
            {
              goal = "Player within then outside radius of agent",
              params = {value = 70}
            }
          },
          {
            failCondition = true,
            {
              goal = "Player in any other vehicle"
            },
            {
              goal = "Within radius of player",
              params = {value = 500, inverse = true}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "controlling head on actor",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Within radius of player",
              params = {value = 500}
            },
            {
              goal = "Player in any other vehicle"
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Timed Wait",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        }
      }
    },
    {
      {
        task = "Follow Route",
        specialName = "Vehicle making escape 2",
        groupProgression = {importantMinorOrder = true},
        taskConditions = {
          {
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
        specialName = "Hit kidnapper 2",
        groupProgression = {priorityMinorOrder = true},
        taskConditions = {
          {
            {
              goal = "Simple collision check",
              params = {
                whereIWasHit = "Front",
                force = 3000,
                playerMustHitTarget = true
              }
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Remove vehicle",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            },
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
local bootCamTask = function(goalParams, HUD, audio, agent, actorID)
  local task = {
    deleteVehicleOnCompletion = true,
    {
      {
        task = "Follow Route",
        specialName = "Boot cam actor active",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = actorID}
            },
            {
              goal = "Game has stopped spooling"
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
        task = "Follow Route",
        specialName = "Player in Tanner vehicle",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Tanner"}
            },
            {
              goal = "Game has stopped spooling"
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            }
          }
        }
      }
    }
  }
  return task
end
local ambulanceTask = function(goalParams, HUD, audio, agent, actorID)
  local task = {
    deleteVehicleOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "delete ambulance",
        taskConditions = {
          {
            {
              goal = "Actor is in major order",
              params = {
                actorID = "Tanner",
                value = {9}
              }
            }
          }
        }
      }
    }
  }
  return task
end
local headOnTask = function(goalParams, HUD, audio, agent, actorID)
  local task = {
    enableNonPlayerFeedback = true,
    {
      {task = "Wander", specialName = "set wander"}
    }
  }
  return task
end
missionSetupData.Trunked.taskCreatorFunctionLookups = {
  ["Tanner team"] = playerTask,
  ["Opponent team"] = opponentTask,
  ["BootCam Team"] = bootCamTask,
  ["Ambulance team"] = ambulanceTask,
  ["Head on team"] = headOnTask
}
local vehicleName
local openTrunk = function(instance, actorName)
  local trunkCamAgent = instance.taskObjectsByActorID[actorName].coreData.agent
  GameVehicleResource.forceOpenPanels({
    gameVehicle = trunkCamAgent.gameVehicle,
    panelIndex = 5,
    angle = 0.3
  })
end
local showTrunkCam = function(instance, actorName)
  local attachCamera = {
    {
      {
        action = "attach",
        infiniteLength = true,
        lockRoll = true,
        lookAt = nil,
        lookAtOffset = vec.vector(-1.1, 0.75, -4.8, 0),
        lookAtAttached = true,
        lookFrom = nil,
        lookFromOffset = vec.vector(0.47, 0.9, -2.4, 0),
        lookFromAttached = true,
        fov = math.rad(85)
      }
    }
  }
  local trunkCamAgent = instance.taskObjectsByActorID[actorName].coreData.agent
  attachCamera[1][1].lookAt = trunkCamAgent.gameVehicle
  attachCamera[1][1].lookFrom = trunkCamAgent.gameVehicle
  if localPlayer.cameraMode == "Bumper" then
    VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
  end
  trunkCamAgent.gameVehicle.visualLodHint = "AlwaysInterior"
  CameraSystem.SetClippingPlanesForKidnappedBootShot(true)
  CameraSystem.AddScene(attachCamera)
  localPlayer:showHUDElements(false)
  if actorName == "TrunkedBootViewActor1" then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:184662", nil, false, true, false, localPlayer.buttonLayout.trunked)
  end
end
local function afterRapidShift(instance)
  if not instance.taskObjectsByActorID[vehicleName] then
    vehicleName = "Tanner"
  end
  GameVehicleResource.ClearAreaOfVehicles(instance.taskObjectsByActorID[vehicleName].coreData.agent.gameVehicle.matrix[3], 10)
  localPlayer:exitCutsceneMode()
  localPlayer.controllerInterface:registerPlayerControl()
  localPlayer:resetCameraMode()
  replays.unPause()
  OneShotSound.Play("ZAP_CantDo_Unmute")
end
local function zapBetweenVehicles(instance, actorName)
  localPlayer:showHUDElements(false)
  localPlayer:enterCutsceneMode()
  OneShotSound.Play("ZAP_CantDo_Mute")
  if actorName ~= "TrunkedBootViewActor1" and actorName ~= "Tanner" then
    openTrunk(instance, actorName)
  end
  instance.taskObjectsByActorID[actorName].coreData.agent.blockTow = true
  Mood.addMoodUserDefined(moodSystem.RapidZap, "FastZap", 1, 0.1)
  CameraSystem.ClearScene()
  if not localPlayer.inZap then
    localPlayer:SetZapLevel(1)
  end
  localPlayer:ZapIntoVehicle(instance.taskObjectsByActorID[actorName].coreData.agent.gameVehicle, true, true, false, nil, {disableZapFlash = true})
  if actorName == "Tanner" then
    CameraSystem.SetClippingPlanesForKidnappedBootShot(false)
    currentTrunkActor = instance.taskObjectsByActorID.TrunkedBootViewActor2 or instance.taskObjectsByActorID.TrunkedBootViewActor1 or instance.taskObjectsByActorID.TrunkedActor
    currentTrunkActor.coreData.agent.gameVehicle.visualLodHint = "Whatever"
  else
    replays.pause()
  end
end
local objective1 = vec.vector(170.0034, 35.54718, 2049.96, 1)
local objective2 = vec.vector(714.5867, 6.250916, 1677.716, 1)
local objective3 = vec.vector(1165.351, 6.195598, 1284.987, 1)
local objective4 = vec.vector(1276.413, 5.869367, 1096.009, 1)
local objective5, objective6, objective7, marker
function missionSetupData.Trunked.initiate(instance)
  simulation.setSpeed(1)
  objective5 = spawnPositions["Trunked BootCamActor1"].position
  objective6 = spawnPositions["Trunked BootCamActor2"].position
  objective7 = spawnPositions["Trunked spawn"].position
  createFixedPosition(instance, {objective1}, 200)
  createFixedPosition(instance, {objective2}, 201)
  createFixedPosition(instance, {objective3}, 202)
  createFixedPosition(instance, {objective4}, 204)
  createFixedPosition(instance, {objective5}, 101)
  createFixedPosition(instance, {objective6}, 102)
  createFixedPosition(instance, {objective7}, 103)
  localPlayer:blockAbility("zapReturn", true)
  feedbackSystem.startMusic("Uid00770_CH01_Story_Kidnapped_Play")
  initalZapSlowMo = zapcontroller.getZapSlowMotionMultiplier()
  local softSaveData = progressionSystem.getSoftSaveData()
  if not softSaveData or softSaveData and softSaveData.progression == 1 then
    instance.taskObjectsByActorID.Tanner.coreData.actor.desiredSpeed = 30
    localPlayer:blockAbility("zap", true)
  elseif softSaveData and softSaveData.progression == 2 then
    localPlayer:blockAbility("zap", true)
    instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.speed = 13.41
    instance.taskObjectsByActorID.Tanner.coreData.agent.iconsVisible = false
    instance.taskObjectsByActorID.TrunkedActor.coreData.agent.iconsVisible = false
    instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle.speed = 13.41
    instance.taskObjectsByActorID.TrunkedActor.coreData.actor.markerType = "Red Marker, Getaway Radius"
    instance.taskObjectsByActorID.TrunkedActor.coreData.agent:set_damageMultiplier(0.1)
    GameVehicleResource.setVehicleOccupantDraw(instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle, 2, true)
    GameVehicleResource.setNoVisDamageOnRear(instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle, true)
    openTrunk(instance, "TrunkedActor")
    zapcontroller.AddLockedVehicle({
      gameVehicle = instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle
    })
  elseif softSaveData and softSaveData.progression == 3 then
    feedbackSystem.menusMaster.setCurrentFocusString(2)
    instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.speed = 17.88
    instance.taskObjectsByActorID.Tanner.coreData.agent.iconsVisible = false
    instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle.speed = 17.88
    instance.taskObjectsByActorID.TrunkedActor.coreData.actor.markerType = "Red Marker, Getaway Radius"
    instance.taskObjectsByActorID.TrunkedActor.coreData.agent.iconsVisible = false
    instance.taskObjectsByActorID.TrunkedActor.coreData.agent:set_damageMultiplier(0.1)
    GameVehicleResource.setNoVisDamageOnRear(instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle, true)
    GameVehicleResource.setVehicleOccupantDraw(instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle, 2, true)
    openTrunk(instance, "TrunkedActor")
    feedbackSystem.updateTutorialPanel({
      panelState = 2,
      string1 = "ID:243168",
      string2 = "ID:243294"
    })
    feedbackSystem.updateTutorialPanel({highlight1 = true})
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243168", false, false, true)
    zap.singlePlayerZapSlowDownMultiplier = 0.05
    localPlayer:SetZapLevel(1)
    zapcontroller.AddLockedVehicle({
      gameVehicle = instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle
    })
    zapcontroller.AddLockedVehicle({
      gameVehicle = instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle
    })
  elseif softSaveData and softSaveData.progression == 4 then
    feedbackSystem.menusMaster.setCurrentFocusString(3)
    instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.speed = 17.88
    instance.taskObjectsByActorID.Tanner.coreData.agent.iconsVisible = false
    instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle.speed = 17.88
    instance.taskObjectsByActorID.TrunkedActor.coreData.actor.markerType = "Red Marker, Getaway Radius"
    instance.taskObjectsByActorID.TrunkedActor.coreData.agent.iconsVisible = true
    instance.taskObjectsByActorID.TrunkedActor.coreData.agent:set_damageMultiplier(0.1)
    GameVehicleResource.setVehicleOccupantDraw(instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle, 2, true)
    openTrunk(instance, "TrunkedActor")
    zap.singlePlayerZapSlowDownMultiplier = 0.05
    localPlayer:SetZapLevel(1)
    localPlayer:SetZapLevel(0, instance.taskObjectsByActorID["Head on Actor"].coreData.agent, true)
    feedbackSystem.updateTutorialPanel({
      panelState = 2,
      string1 = "ID:243168",
      string2 = "ID:243294"
    })
    feedbackSystem.updateTutorialPanel({tick1 = true})
    feedbackSystem.updateTutorialPanel({highlight2 = true})
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243294", false, false, true)
    instance.taskObjectsByActorID["Head on Actor"].coreData.agent.iconsVisible = false
    instance.taskObjectsByActorID["Head on Actor"].coreData.actor.markerType = "None"
    instance.taskObjectsByActorID["Head on Actor"].coreData.agent.gameVehicle.speed = 13.41
    GameVehicleResource.setNoVisDamageOnRear(instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle, true)
    zapcontroller.AddLockedVehicle({
      gameVehicle = instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle
    })
    zapcontroller.AddLockedVehicle({
      gameVehicle = instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle
    })
  end
end
missionSetupData.Trunked.update = nil
local tannerDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  elseif task.specialName == "Reached 1st Destination" then
    return checkpointSystem.getCheckpoints(task.instance, 200), false
  elseif task.specialName == "Reached 2nd Destination" then
    return checkpointSystem.getCheckpoints(task.instance, 201), false
  elseif task.specialName == "Reached 3rd Destination" or task.specialName == "Trying something PIP" then
    return checkpointSystem.getCheckpoints(task.instance, 202), false
  elseif task.specialName == "Reached 4th Destination" then
    return checkpointSystem.getCheckpoints(task.instance, 204), false
  elseif task.specialName == "Zap to TrunkedBootViewActor2" or task.specialName == "Reached 5th Destination" or task.specialName == "Player is in TrunkedBootViewActor1" or task.specialName == "Open trunk" or task.specialName == "Sit in TrunkedBootViewActor1" or task.specialName == "Player back from TrunkedBootViewActor1" then
    return checkpointSystem.getCheckpoints(task.instance, 101), false
  elseif task.specialName == "Zap to TrunkedBootViewActor3" or task.specialName == "Reached 6th Destination" or task.specialName == "Sit in TrunkedBootViewActor2" or task.specialName == "Back from TrunkedBootViewActor2" then
    return checkpointSystem.getCheckpoints(task.instance, 102), false
  elseif task.specialName == "Find car" then
    return checkpointSystem.getCheckpoints(task.instance, 103), false
  elseif task.specialName == "Sit in TrunkedActor" or task.specialName == "Chase car" or task.specialName == "Stop car" then
    local teams = {}
    for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
      teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
      table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
    end
    return teams["Opponent team"], false
  end
end
missionSetupData.Trunked.targetList = {
  ["Tanner team"] = tannerDynamicTargets,
  ["Head on team"] = tannerDynamicTargets
}
local teleportOnCutsceneFade = function(task)
  return function()
    local positionTable = softSaveStartPositions.Trunked[2]
    task.instance.taskObjectsByActorID.Tanner.coreData.agent:teleportToPositionAndHeading(positionTable.Tanner.position, positionTable.Tanner.heading, nil, nil, nil, false)
    task.instance.taskObjectsByActorID.TrunkedActor.coreData.agent:teleportToPositionAndHeading(positionTable.TrunkedActor.position, positionTable.TrunkedActor.heading, nil, nil, nil, false)
    task.instance.taskObjectsByActorID.TrunkedActor.coreData.actor.markerType = "Red Marker, Getaway Radius"
  end
end
taskCompleteData.Trunked = {}
function taskCompleteData.Trunked.taskComplete(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.Tanner.coreData.agent,
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    driverIsTanner = true,
    cameraShots = cameraShots[2],
    hint = "ID:235485",
    hintIcon1 = localPlayer.buttonLayout.minimapZoom
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.success then
    if task.specialName == "Reached 4th Destination" then
      localPlayer.controllerInterface:removePlayerControl()
      localPlayer:enterCutsceneMode()
      localPlayer.cameraSupport.miniSceneCamera()
    elseif task.specialName == "Zap to TrunkedBootViewActor1" then
      vehicleName = "TrunkedBootViewActor1"
      challengeSystem.spawnActors(task.instance, "Never", {
        [vehicleName] = true
      })
      zapBetweenVehicles(task.instance, vehicleName)
    elseif task.specialName == "Player is in TrunkedBootViewActor1" then
      local positionTable = softSaveStartPositions.Trunked[1].Tanner
      task.instance.taskObjectsByActorID.Tanner.coreData.agent:teleportToPositionAndHeading(positionTable.position, positionTable.heading)
    elseif task.specialName == "Open trunk" then
      openTrunk(task.instance, "TrunkedBootViewActor1")
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    elseif task.specialName == "Player back from TrunkedBootViewActor1" then
      progressionSystem.triggerSoftSave({progression = 1})
    elseif task.specialName == "Zap to TrunkedBootViewActor2" then
      vehicleName = "TrunkedBootViewActor2"
      challengeSystem.spawnActors(task.instance, "Never", {
        [vehicleName] = true
      })
      GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID[vehicleName].coreData.agent.gameVehicle.matrix[3], 10)
      if localPlayer.cameraMode == "Bumper" then
        CameraSystemRegisterUpdate(localPlayer.camName, localPlayer.camera, "simulation", Camera_Function_Vehicle_Dynamic_Chase_Cam, {
          agent = localPlayer.currentVehicle,
          pad = localPlayer.gamepad
        })
      end
      zapBetweenVehicles(task.instance, vehicleName)
    elseif task.specialName == "Zap to TrunkedActor" then
      vehicleName = "TrunkedActor"
      challengeSystem.spawnActors(task.instance, "Never", {
        [vehicleName] = true
      })
      GameVehicleResource.setNoVisDamageOnRear(task.instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle, true)
      zapcontroller.AddLockedVehicle({
        gameVehicle = task.instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle
      })
      GameVehicleResource.setVehicleOccupantDraw(task.instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle, 2, false)
      if localPlayer.cameraMode == "Bumper" then
        CameraSystemRegisterUpdate(localPlayer.camName, localPlayer.camera, "simulation", Camera_Function_Vehicle_Dynamic_Chase_Cam, {
          agent = localPlayer.currentVehicle,
          pad = localPlayer.gamepad
        })
      end
      zapBetweenVehicles(task.instance, vehicleName)
    elseif task.specialName == "Player in TrunkedActor" then
      localPlayer.controllerInterface:removePlayerControl(false)
    elseif task.specialName == "Boot cam actor active" then
      if taskObject.coreData.actor.ID ~= "TrunkedActor" then
        localPlayer.controllerInterface:removePlayerControl(true)
      end
      showTrunkCam(task.instance, taskObject.coreData.actor.ID)
    elseif string.find(task.specialName, "Sit in") then
      zapBetweenVehicles(task.instance, "Tanner")
    elseif task.specialName == "Player in Tanner vehicle" then
      afterRapidShift(task.instance)
    elseif task.specialName == "Find car" then
      task.instance.taskObjectsByActorID.Tanner.coreData.agent:lockEmergencyBrakes(2)
    elseif task.specialName == "Trigger softsave" then
      if localPlayer.cameraMode == "Bumper" then
        CameraSystemRegisterUpdate(localPlayer.camName, localPlayer.camera, "simulation", Camera_Function_Vehicle_Dynamic_Chase_Cam, {
          agent = localPlayer.currentVehicle,
          pad = localPlayer.gamepad
        })
      end
      task.instance.taskObjectsByActorID.Tanner.coreData.agent:unlockEmergencyBrakes()
      engineCutscene.playCutscene("mis_ch1_kidnapped_01", teleportOnCutsceneFade(task), function()
        localPlayer:enterCutsceneMode()
        localPlayer:blockAbility("zap", true)
        localPlayer:resetCameraMode()
        GameVehicleResource.setVehicleOccupantDraw(task.instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle, 2, true)
        task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.speed = 13.41
        task.instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle.speed = 13.41
        task.instance.taskObjectsByActorID.Tanner.coreData.agent.iconsVisible = false
        task.instance.taskObjectsByActorID.TrunkedActor.coreData.agent.iconsVisible = false
        CutsceneFiles.tutorials.playTutorial("ID:243165", false, false, true)
      end)
    elseif task.specialName == "Cutscene mis_ch1_kidnapped_01 finished Player" then
      progressionSystem.triggerSoftSave({progression = 2})
      task.instance.taskObjectsByActorID.TrunkedActor.coreData.agent:set_damageMultiplier(0.1)
      feedbackSystem.menusMaster.setCurrentFocusString(2)
    elseif task.specialName == "Third softsave" then
      local softSaveData = progressionSystem.getSoftSaveData()
      if not softSaveData or softSaveData and softSaveData.progression < 3 then
        progressionSystem.triggerSoftSave({progression = 3})
      end
    elseif task.specialName == "Tutorial start" then
      task.instance.taskObjectsByActorID.Tanner.coreData.agent.iconsVisible = false
      task.instance.taskObjectsByActorID.TrunkedActor.coreData.agent.iconsVisible = false
      zapcontroller.AddLockedVehicle({
        gameVehicle = task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle
      })
    elseif task.specialName == "Is Tutorial Prompt Finished" then
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Head on Actor"] = true
      })
      if not marker and task.instance.taskObjectsByActorID["Head on Actor"] then
        marker = feedbackSystem.newTarget(task.instance.taskObjectsByActorID["Head on Actor"].coreData.agent, "Exclamation marker")
      end
      task.instance.taskObjectsByActorID["Head on Actor"].coreData.agent.iconsVisible = true
      localPlayer:exitCutsceneMode()
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243168", false, false, false)
      localPlayer:blockAbility("zap", false)
      zap.singlePlayerZapSlowDownMultiplier = 0.05
      localPlayer:SetZapLevel(1)
      feedbackSystem.updateTutorialPanel({highlight1 = true})
    elseif task.specialName == "controlling head on actor" then
      local softSaveData = progressionSystem.getSoftSaveData()
      if not softSaveData or softSaveData and softSaveData.progression < 4 then
        progressionSystem.triggerSoftSave({progression = 4})
      end
      if marker then
        feedbackSystem.clearTarget(marker)
        marker = nil
      end
      local function doThis()
        feedbackSystem.updateTutorialPanel({highlight1 = false})
        feedbackSystem.updateTutorialPanel({tick1 = true})
        feedbackSystem.updateTutorialPanel({highlight2 = true})
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        feedbackSystem.menusMaster.primaryTextPrompt("ID:243294", false, false, false)
        feedbackSystem.menusMaster.setCurrentFocusString(3)
        task.instance.taskObjectsByActorID["Head on Actor"].coreData.agent.iconsVisible = false
        task.instance.taskObjectsByActorID.TrunkedActor.coreData.agent.iconsVisible = true
        task.instance.taskObjectsByActorID["Head on Actor"].coreData.actor.markerType = "None"
      end
      localPlayer.simulationSupport.doSlowDown(doThis, 0.5, 0.1, true)
      localPlayer.simulationSupport.doWait(0.5, function()
        localPlayer.simulationSupport.doSlowDown(nil, 0.5, 1, true)
      end)
    elseif task.specialName == "Chase car" then
      localPlayer:showHUDElements(false)
      taskObject.coreData.agent:lockEmergencyBrakes(2)
    elseif task.specialName == "Hit kidnapper" then
      GameVehicleResource.applyDamage({
        gameVehicle = task.instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle,
        damage = 0.4
      })
      feedbackSystem.updateTutorialPanel({tick2 = true})
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245239", false, false, false)
      localPlayer:SetZapLevel(1)
    elseif task.specialName == "Hit kidnapper 2" then
      GameVehicleResource.applyDamage({
        gameVehicle = task.instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle,
        damage = 1
      })
      zapcontroller.RemoveLockedVehicle({
        gameVehicle = task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle
      })
      local function endMissionCallback(taskObject, params)
        return function()
          feedbackSystem.updateTutorialPanel({panelState = 3})
          params.vehicle = task.instance.taskObjectsByActorID.TrunkedActor.coreData.agent
          params.dialogue = "GPMV00_SUCCESS_L_1"
          params.driverIsTanner = false
          params.callback = completeTask
          params.rating = "PASS"
          localPlayer.challenge.endScreen(taskObject, params)
        end
      end
      iCamCrashCam(task.instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle, endMissionCallback(taskObject, params))
    end
  elseif 1 <= task.instance.taskObjectsByActorID.Tanner.coreData.agent.damage then
    params.reason = "Wrecked"
    params.failReason = "ID:184015"
    params.dialogue = "GPMV01_FAILURE_L_3"
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "Missed kidnapper" or task.specialName == "Check victim collision" then
    params.callback = failTask
    params.rating = "FAIL"
    params.forceRetry = true
    localPlayer.challenge.endScreen(taskObject, params)
  else
    params.failReason = params.failReason or "ID:184664"
    params.dialogue = "GPMV01_FAILURE_L_1"
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
function missionEndCallback.Trunked(instance)
  CameraSystem.SetClippingPlanesForKidnappedBootShot(false)
  feedbackSystem.stopMusic("Uid00770_CH01_Story_Kidnapped_Stop")
  OneShotSound.Play("ZAP_CantDo_Unmute")
  Sound.ExitAudioState("AuxAmbience")
  removeUserUpdateFunction("pause at end")
  removeUserUpdateFunction("slowDownUpdate")
  Sound.ExitAudioState("AuxAmbience")
  zap.singlePlayerZapSlowDownMultiplier = initalZapSlowMo
  localPlayer:blockAbility("zap", false)
  localPlayer:blockAbility("zapReturn", false)
  CameraSystem.ClearScene()
  localPlayer:exitCutsceneMode()
  localPlayer.controllerInterface:registerPlayerControl()
  localPlayer:resetCameraMode()
  if instance.taskObjectsByActorID.TrunkedActor then
    GameVehicleResource.setNoVisDamageOnRear(instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle, true)
    zapcontroller.RemoveLockedVehicle({
      gameVehicle = instance.taskObjectsByActorID.TrunkedActor.coreData.agent.gameVehicle
    })
  end
  if marker then
    feedbackSystem.clearTarget(marker)
    marker = nil
  end
end
