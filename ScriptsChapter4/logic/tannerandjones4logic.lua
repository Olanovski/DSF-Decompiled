module("cardSystem.logic")
missionSetupData["Tanner and Jones Mission 4"] = {}
local tailTooFar = 140
local losingRadius = 150
local suspicionRadius = 40
local failRadius = 160
local payload = 0
local attackerSpawnCheckpointRadius = 50
local function tannerAndJonesTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Linear Checkpoints",
        specialName = "Drive to Krug",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 20}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0, setRaceFinished = true}
            }
          },
          {
            failCondition = true,
            {
              goal = "Struck specified actors",
              params = {
                actorIDs = {
                  [1] = "Krug"
                }
              }
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
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Fail before reaching Krug",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
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
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "All opposing vehicles damage above",
              params = {value = 1}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Drive to prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Drive to speech",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 4}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Wait for icam",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
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
        task = "No AI",
        specialName = "Soft save 00",
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
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Instructions 1",
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
            style = "Tanner and Jones 4 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Instructions 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 7}
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        }
      },
      {
        task = "Linear Chase",
        specialName = "Tail section 01",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = failRadius, inverse = true}
            },
            {
              goal = "Losing getaway time trigger",
              params = {value = 10, prompt = "ID:184767"}
            }
          },
          {
            {
              goal = "Target damage above",
              params = {value = 1}
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
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
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        }
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Tracking Player Position 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            {
              goal = "Within radius",
              params = {value = losingRadius}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Within radius",
              params = {value = losingRadius, inverse = true}
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
            style = "Tanner and Jones 4 hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "Payload Tracking",
        specialName = "Tail suspicion 1",
        dynamicTargets = true,
        coreData = {upper = 100, lower = 0},
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Player on pavement"
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Agent in oncoming traffic"
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 3}
            },
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Struck specified actors",
              params = {
                actorIDs = {
                  [1] = "Krug"
                }
              }
            },
            {
              goal = "Change payload by amount",
              params = {value = 25}
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Payload over",
              params = {value = 100}
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Tail warning",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Outside radius",
              params = {value = tailTooFar}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Within range",
              params = {minimum = suspicionRadius, maximum = tailTooFar}
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "shift warning",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            {
              goal = "In mission vehicle",
              params = {inverse = true}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "In mission vehicle"
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "In zap",
        goalConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
            }
          },
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
        specialName = "Conversation manager",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Is player controlled"
            },
            {
              goal = "Within radius",
              params = {value = losingRadius}
            },
            {
              goal = "Time trigger",
              params = {value = 0.8}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Event active"
            },
            {
              goal = "Is player controlled"
            },
            {
              goal = "Within radius",
              params = {value = losingRadius, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.8}
            }
          },
          {
            {
              goal = "Specified actors have finished race",
              params = {
                actors = {"Krug"},
                value = 1
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 30}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = losingRadius, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 14}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Speed change",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 20}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 30}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 40}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 50}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Actor completed minor order",
              params = {
                actorID = "Krug",
                specialName = "Spawn Attacker Wave"
              }
            },
            {
              goal = "In losing countdown",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio,
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Soft save 01",
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
        }
      }
    },
    {
      {
        task = "Linear Chase",
        specialName = "CHASE during attack",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        taskConditions = {
          {
            {
              goal = "Actor completed minor order",
              params = {
                actorID = "Krug",
                specialName = "Spawn Attacker Wave"
              }
            },
            {
              goal = "All team members damage above",
              params = {
                team = "Attacking team",
                value = 1
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
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
            style = "Tanner and Jones 4 hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "CHASE killer",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
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
            style = "Tanner and Jones 4 hud"
          }
        }
      },
      {
        task = "Linear Chase",
        specialName = "Tail section CHASE",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = failRadius, inverse = true}
            },
            {
              goal = "Losing getaway time trigger",
              params = {value = 10, prompt = "ID:184767"}
            }
          },
          {
            {
              goal = "Target damage above",
              params = {value = 1}
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
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
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        }
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Tracking Player Position CHASE",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            {
              goal = "Within radius",
              params = {value = losingRadius}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "In mission vehicle",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = losingRadius, inverse = true}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "In mission vehicle"
            },
            {
              goal = "Is player controlled"
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
            style = "Tanner and Jones 4 hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "CHASE zap",
        goalConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
            }
          },
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
      }
    },
    {
      {
        task = "Linear Chase",
        specialName = "Player back in recording range",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = failRadius}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Is player controlled",
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
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Soft save 02",
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
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Pause before Jericho phone calls",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 4}
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
        task = "Linear Chase",
        specialName = "Fail before Jericho calls",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = failRadius, inverse = true}
            },
            {
              goal = "Losing getaway time trigger",
              params = {value = 10, prompt = "ID:184767"}
            }
          },
          {
            {
              goal = "Target damage above",
              params = {value = 1}
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
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
        }
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Tracking Player Position  before Jericho calls",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = losingRadius}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = losingRadius, inverse = true}
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
            style = "Tanner and Jones 4 hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "Payload Tracking",
        specialName = "Tail suspicion  before Jericho calls",
        dynamicTargets = true,
        coreData = {upper = 100, lower = 0},
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Player on pavement"
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Agent in oncoming traffic"
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 3}
            },
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Struck specified actors",
              params = {
                actorIDs = {
                  [1] = "Krug"
                }
              }
            },
            {
              goal = "Change payload by amount",
              params = {value = 25}
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Payload over",
              params = {value = 100}
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Tail warning before Jericho calls",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Outside radius",
              params = {value = tailTooFar}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Within range",
              params = {minimum = suspicionRadius, maximum = tailTooFar}
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        }
      }
    },
    {
      {
        task = "Linear Chase",
        specialName = "Fail PART DUEX",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = failRadius, inverse = true}
            },
            {
              goal = "Losing getaway time trigger",
              params = {value = 10, prompt = "ID:184767"}
            }
          },
          {
            {
              goal = "Target damage above",
              params = {value = 1}
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
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
        }
      },
      {
        task = "No AI",
        specialName = "Player at the end of the route",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
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
          }
        }
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Tracking Player Position 1 PART DUEX",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            {
              goal = "Within radius",
              params = {value = losingRadius}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Within radius",
              params = {value = losingRadius, inverse = true}
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
            style = "Tanner and Jones 4 hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "Payload Tracking",
        specialName = "Tail suspicion 1 PART DUEX",
        dynamicTargets = true,
        coreData = {upper = 100, lower = 0},
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Player on pavement"
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Agent in oncoming traffic"
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 3}
            },
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Struck specified actors",
              params = {
                actorIDs = {
                  [1] = "Krug"
                }
              }
            },
            {
              goal = "Change payload by amount",
              params = {value = 25}
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Payload over",
              params = {value = 100}
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Tail warning PART DUEX",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Outside radius",
              params = {value = tailTooFar}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Within range",
              params = {minimum = suspicionRadius, maximum = tailTooFar}
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "In zap PART DUEX",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "In mission vehicle",
              params = {inverse = true}
            }
          },
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "In mission vehicle"
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Conversation manager PART DUEX",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Is player controlled"
            },
            {
              goal = "Within radius",
              params = {value = losingRadius}
            },
            {
              goal = "Time trigger",
              params = {value = 0.8}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Event active"
            },
            {
              goal = "Is player controlled"
            },
            {
              goal = "Within radius",
              params = {value = losingRadius, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.8}
            }
          },
          {
            {
              goal = "Specified actors have finished race",
              params = {
                actors = {"Krug"},
                value = 1
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 30}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = losingRadius, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 14}
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
        specialName = "Tracking Player Position 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            {
              goal = "Within radius",
              params = {value = losingRadius}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Within radius",
              params = {value = losingRadius, inverse = true}
            }
          },
          {
            {
              goal = "Within radius",
              params = {value = failRadius, inverse = true}
            },
            {
              goal = "Losing getaway time trigger",
              params = {value = 10, prompt = "ID:184767"}
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
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
            style = "Tanner and Jones 4 hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "Payload Tracking",
        specialName = "Tail suspicion 2",
        dynamicTargets = true,
        coreData = {upper = 100, lower = 0},
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Player on pavement"
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Agent in oncoming traffic"
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 3}
            },
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Struck specified actors",
              params = {
                actorIDs = {
                  [1] = "Krug"
                }
              }
            },
            {
              goal = "Change payload by amount",
              params = {value = 25}
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Payload over",
              params = {value = 100}
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
            style = "Tanner and Jones 4 hud"
          }
        }
      }
    }
  }
  return task
end
local function krugTask(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    {
      {
        task = "No AI",
        specialName = "Wait for Tanner start",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Specified actors have finished race",
              params = {
                actors = {
                  "Tanner and Jones"
                },
                value = 1
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          }
        }
      }
    },
    {
      {
        task = "Follow Route",
        specialName = "Krug task",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "Linear Checkpoints No AI",
        specialName = "Spawn Attacker Wave",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = attackerSpawnCheckpointRadius}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          }
        }
      }
    },
    {
      {
        task = "Follow Route",
        specialName = "Krug escape task",
        groupProgression = {importantMinorOrder = true},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "All team members damage above",
              params = {
                team = "Attacking team",
                value = 1
              }
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Fake rubberband",
        goalConditions = {
          {
            {
              goal = "Above speed",
              params = {value = 60}
            },
            {
              goal = "Within radius of specified actor",
              params = {
                value = 120,
                inverse = true,
                actorID = "Tanner and Jones"
              }
            }
          },
          {
            {
              goal = "Within radius of specified actor",
              params = {
                value = 90,
                actorID = "Tanner and Jones"
              }
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Use shift to take them down prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 5}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Follow Route",
        specialName = "Krug final follow task",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        specialName = "Krug task 2",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Agent stopped inside radius",
              params = {value = 20, stopDuration = 1}
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
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait for Tanner",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = losingRadius}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Player in target vehicle"
            },
            {
              goal = "Within radius",
              params = {value = losingRadius, inverse = true}
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
          }
        },
        HUD = {
          {
            style = "Tanner and Jones 4 hud"
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
local attackerTask = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Wait for CHASE",
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 35}
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
        task = "Wander",
        dynamicTargets = true,
        specialName = "Start CHASE",
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Alongside vehicle",
              params = {value = 15}
            }
          },
          {
            {
              goal = "Target damage above",
              params = {value = 0.75}
            }
          },
          {
            {
              goal = "Outside radius",
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
        }
      }
    },
    {
      {
        task = "Linear Chase",
        dynamicTargets = true,
        specialName = "CHASE krug",
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
            failCondition = true,
            {
              goal = "Being towed"
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
missionSetupData["Tanner and Jones Mission 4"].taskCreatorFunctionLookups = {
  ["Tanner and Jones team"] = tannerAndJonesTask,
  ["Krug team"] = krugTask,
  ["Attacking team"] = attackerTask
}
local initialDriveToLocation = vec.vector(-4428.86, 14.84057, 2216.173, 1)
local KrugEndDPlocation = vec.vector(-1528.133, 43.36383, 1078.344, 1)
local chaseStartLocation = vec.vector(-1834.878, 5.215892, -203.4839, 1)
local chaseKillerLocation = vec.vector(-560.2338, 22.67719, 650.9263, 1)
local endDriveToLocation = vec.vector(-1432.984, 40.66459, 1065.028, 1)
local firstWaveTriggerPosition = vec.vector(-1932.361, 5.321091, -214.8598, 1)
local tannerActor, tannerAgent, krugActor, krugAgent
missionSetupData["Tanner and Jones Mission 4"].initiate = function(instance)
  instance.taskObjectsByActorID.Krug.coreData.actor.desiredSpeed = 70
  createFixedPosition(instance, {KrugEndDPlocation}, 101)
  createFixedPosition(instance, {chaseKillerLocation}, 102)
  createFixedPosition(instance, {chaseStartLocation}, 103)
  createFixedPosition(instance, {initialDriveToLocation}, 104)
  createFixedPosition(instance, {endDriveToLocation}, 105)
  createFixedPosition(instance, {firstWaveTriggerPosition}, 106)
  krugAgent = instance.taskObjectsByActorID.Krug.coreData.agent
  krugActor = instance.taskObjectsByActorID.Krug.coreData.actor
  tannerAgent = instance.taskObjectsByActorID["Tanner and Jones"].coreData.agent
  tannerActor = instance.taskObjectsByActorID["Tanner and Jones"].coreData.actor
  krugAgent.blockTow = true
  tannerAgent.blockTow = true
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    instance.payload = 0
    if softSaveData.progression == 1 then
      feedbackSystem.menusMaster.setCurrentFocusString(2)
      instance.rubberbandRoute = "TannerAndJones4Route"
      krugActor.routeName = "TannerAndJones4Route"
      tannerAgent.gameVehicle.speed = 0
      tannerAgent.gameVehicle.velocity = tannerAgent.gameVehicle.matrix[2] * 20
      krugAgent.gameVehicle.velocity = krugAgent.gameVehicle.matrix[2] * 50
      krugActor.desiredSpeed = 70
    elseif softSaveData.progression == 2 then
      krugActor.routeName = "TannerAndJones4MidRoute"
      feedbackSystem.menusMaster.setCurrentFocusString(3)
      krugAgent.gameVehicle.performance = 1.5
      krugActor.desiredSpeed = 70
      tannerActor.desiredSpeed = 90
      tannerAgent.gameVehicle.velocity = tannerAgent.gameVehicle.matrix[2] * 20
      createCheckpoints(instance, tannerActor.routeName)
    elseif softSaveData.progression == 3 then
      feedbackSystem.menusMaster.setCurrentFocusString(4)
      tannerAgent.gameVehicle.velocity = tannerAgent.gameVehicle.matrix[2] * 20
      krugActor.routeName = "TannerAndJones4EndRoute"
      krugActor.desiredSpeed = 95
      krugActor.avoidUTurns = true
      krugActor.distanceBehindPlayer = -80
      krugActor.rubberbandingToPlayerStrength = "Medium"
    end
  else
    krugActor.routeName = "TannerAndJones4Route"
    localPlayer:blockAbility("zap", true)
  end
  createCheckpoints(instance)
  RaceManager.SetStartCheckpointIndex(instance.raceId, RaceManager.GetStartCheckpointIndex(instance.raceId))
  OneShotSound.Play("Suspicion_Meter_Play")
  Sound.SetRTPC("Paranoia_Meter", 0)
  Sound.SetRTPC("DistanceToTarget", 200)
end
missionSetupData["Tanner and Jones Mission 4"].update = nil
local krugRunningSlow = false
missionSetupData["Tanner and Jones Mission 4"].goalComplete = function(taskObject, task, conditionKey)
  if task.specialName == "Fake rubberband" then
    local traits = {}
    if conditionKey == 1 and not krugRunningSlow then
      traits.desiredSpeed = 17.88909
      ActiveLifeAI.setPersonalityTraits(krugAgent.gameVehicle, traits)
      krugRunningSlow = true
    elseif conditionKey == 2 and krugRunningSlow then
      traits.desiredSpeed = 42.48658
      ActiveLifeAI.setPersonalityTraits(krugAgent.gameVehicle, traits)
      krugRunningSlow = false
    end
  end
end
local getTannerAndJonesDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName ~= "CHASE killer" and task.specialName ~= "CHASE Starter" and task.specialName ~= "Drive to Krug" and task.specialName ~= "Player at the end of the route" then
    if dynamicListID then
      return false, true
    else
      return {
        task.instance.taskObjectsByActorID.Krug.coreData.agent
      }, false
    end
  elseif task.specialName == "CHASE Starter" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 103), false
    end
  elseif task.specialName == "CHASE killer" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 102), false
    end
  elseif task.specialName == "Drive to Krug" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 104), false
    end
  elseif task.specialName == "Player at the end of the route" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 105), false
    end
  end
end
local waitForLosingPrompt = function()
  if not feedbackSystem.menusMaster.minimapPromptActive then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243773")
    removeUserUpdateFunction("waitForLosingPrompt")
  end
end
local function getKrugDynamicTargets(taskObject, task, dynamicListID, goalConditionKey)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if task.specialName == "Krug task" then
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
  elseif task.specialName == "Krug task 2" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 101), false
    end
  elseif task.specialName == "Wait for Tanner" or task.specialName == "Wait for Tanner start" then
    if dynamicListID then
      return false, true
    else
      return {
        task.instance.taskObjectsByActorID["Tanner and Jones"].coreData.agent
      }, false
    end
  elseif task.specialName == "Spawn Attacker Wave" then
    if dynamicListID then
      local function spawnAttackers()
        if not localPlayer.eventActive then
          challengeSystem.spawnActors(task.instance, "Never", {
            ["Attacker 01"] = true,
            ["Attacker 02"] = true,
            ["Attacker 03"] = true
          })
          removeUserUpdateFunction("spawnAttackers")
        end
      end
      addUserUpdateFunction("waitForLosingPrompt", waitForLosingPrompt, 1, false)
      addUserUpdateFunction("spawnAttackers", spawnAttackers, 10)
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 106), true
    end
  end
end
local getAttackerDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Attackers" or task.specialName == "Start CHASE" or task.specialName == "Wait for CHASE" or task.specialName == "CHASE krug" then
    if dynamicListID then
      return false, true
    else
      return {
        task.instance.taskObjectsByActorID.Krug.coreData.agent
      }, false
    end
  end
end
missionSetupData["Tanner and Jones Mission 4"].targetList = {
  ["Tanner and Jones team"] = getTannerAndJonesDynamicTargets,
  ["Krug team"] = getKrugDynamicTargets,
  ["Attacking team"] = getAttackerDynamicTargets
}
missionEndCallback["Tanner and Jones Mission 4"] = function(instance)
  krugActor.distanceBehindPlayer = nil
  krugActor.rubberbandingToPlayerStrength = nil
  krugActor.routeName = "TannerAndJones4Route"
  Sound.SetRTPC("Paranoia_Meter", 0)
  Sound.SetRTPC("DistanceToTarget", 0)
  OneShotSound.Play("Recording_Stop", false, true)
  OneShotSound.Play("Suspicion_Meter_Stop", false, true)
  localPlayer:blockAbility("zap", false)
  removeUserUpdateFunction("spawnAttackers")
  feedbackSystem.removeSlot(1)
  feedbackSystem.removeSlot(2)
  feedbackSystem.removeSlot(3)
  instance.KrugHealthBarOn = false
end
taskCompleteData["Tanner and Jones Mission 4"] = {}
taskCompleteData["Tanner and Jones Mission 4"].taskComplete = function(taskObject, task)
  local perfect = false
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix, perfect)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  local params = {
    vehicle = task.instance.taskObjectsByActorID.Krug.coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    successReasonPerfect = task.instance.challenge.taskCompleteData["Success reason (perfect)"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"],
    hint = "ID:235498"
  }
  local teleportAtEnd = function()
  end
  if task.success then
    if task.specialName == "Wait for Tanner" then
      if not task.instance.taskObjectsByActorID["Tanner and Jones"].coreData.agent.controlled then
        localPlayer:zapToAgent(task.instance.taskObjectsByActorID["Tanner and Jones"].coreData.agent)
      end
      OneShotSound.Play("Suspicion_Meter_Stop")
      Sound.SetRTPC("DistanceToTarget", 0)
      params.dialogue = "GPMV00_SUCCESS_L_1"
      params.rating = "PASS"
      perfect = true
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "Drive to Krug" then
      feedbackSystem.menusMaster.setCurrentFocusString(2)
      engineCutscene.playCutscene("ch4_tailingkrug", nil, function()
        local tannerPosition = vec.vector(-4437.973, 15.03935, 2154.182, 1)
        local tannerHeading = 3.09136
        local krugPosition = vec.vector(-4432.867, 14.96756, 2092.91, 1)
        local krugHeading = 3.020522
        tannerAgent:teleportToPositionAndHeading(tannerPosition, tannerHeading)
        tannerAgent.gameVehicle.velocity = tannerAgent.gameVehicle.matrix[2] * 20
        krugAgent:teleportToPositionAndHeading(krugPosition, krugHeading)
        krugAgent.gameVehicle.velocity = krugAgent.gameVehicle.matrix[2] * 20
      end)
    elseif task.specialName == "Soft save 00" then
      progressionSystem.triggerSoftSave({progression = 1})
    elseif task.specialName == "Soft save 01" then
      OneShotSound.Play("Suspicion_Meter_Stop")
      Sound.SetRTPC("DistanceToTarget", 0)
    elseif task.specialName == "Wait for CHASE" then
      task.actor.markerType = "Opponent"
    elseif task.specialName == "Start CHASE" then
      task.actor.desiredSpeed = 95
      local traits = {}
      traits.desiredSpeed = 95
      ActiveLifeAI.setPersonalityTraits(task.agent.gameVehicle, traits)
    elseif task.specialName == "Spawn Attacker Wave" then
      krugAgent.gameVehicle.performance = 1.5
      tannerActor.desiredSpeed = 120
      tannerActor.tailingDistance = 40
      feedbackSystem.menusMaster.setCurrentFocusString(3)
      progressionSystem.triggerSoftSave({progression = 2})
      task.actor.routeName = "TannerAndJones4MidRoute"
      createCheckpoints(task.instance, task.actor.routeName)
    elseif task.specialName == "Krug escape task" then
      krugAgent.gameVehicle.performance = 1
      for k, v in next, task.instance.taskObjectsByActorID, nil do
        v.coreData.agent.raceID = nil
      end
      task.actor.routeName = "TannerAndJones4EndRoute"
      task.actor.desiredSpeed = 70
      task.actor.avoidUTurns = true
      task.actor.distanceBehindPlayer = -80
      task.actor.rubberbandingToPlayerStrength = "Medium"
      createCheckpoints(task.instance, task.actor.routeName)
      RaceManager.SetStartCheckpointIndex(task.instance.raceId, RaceManager.GetStartCheckpointIndex(task.instance.raceId))
    elseif task.specialName == "Soft save 02" then
      feedbackSystem.menusMaster.setCurrentFocusString(4)
      progressionSystem.triggerSoftSave({progression = 3})
    elseif task.specialName == "CHASE during attack" or task.specialName == "CHASE killer" then
      feedbackSystem.menusMaster.setCurrentFocusString(5)
      task.actor.desiredSpeed = 60
      task.actor.tailingDistance = 95
      krugAgent:stopHighSpeedDriving()
      local behaviour = {
        traits = taskSystem.buildDriveTraits(task.instance.taskObjectsByActorID.Krug.coreData),
        roadRoute = routes[krugActor.routeName].roads,
        routeName = krugActor.routeName
      }
      behaviour.traits.desiredSpeed = 95
      behaviour.traits.distanceBehindPlayer = -70
      behaviour.traits.rubberbandingToPlayerStrength = "Medium"
      krugAgent:highSpeedDrive(behaviour)
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == "Attacking team" then
          taskObject:delete()
        end
      end
    end
  elseif task.specialName ~= "CHASE krug" then
    if task.specialName == "Tail section 01" or task.specialName == "Tracking Player Position 2" or task.specialName == "Fail before reaching Krug" or task.specialName == "Tail section CHASE" or task.specialName == "Fail PART DUEX" or task.specialName == "CHASE during attack" or task.specialName == "CHASE killer" then
      if task.condition == 1 then
        if 1 <= krugAgent.damage then
          params.dialogue = "GPMV00_FAILURE_L_3"
          params.failReason = "ID:243867"
        else
          params.dialogue = "GPMV00_FAILURE_L_5"
          params.reason = "Lost getaway"
          params.failReason = task.instance.challenge.taskCompleteData["Failure reason (Lost)"]
          params.vehicle = task.instance.taskObjectsByActorID["Tanner and Jones"].coreData.agent
        end
      elseif task.condition == 2 then
        params.dialogue = "GPMV00_FAILURE_L_1"
        params.reason = "Wrecked"
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        params.vehicle = task.instance.taskObjectsByActorID["Tanner and Jones"].coreData.agent
      elseif task.condition == 3 then
        params.dialogue = "GPMV00_FAILURE_L_3"
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
      end
    elseif task.specialName == "Krug task" or task.specialName == "Krug task at alley DP" or task.specialName == "Wait for Tanner" then
      if localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Tanner and Jones"].coreData.agent then
        params.dialogue = "GPMV00_FAILURE_L_2"
      else
        params.dialogue = "GPMV00_FAILURE_L_3"
      end
    elseif task.specialName == "Tail suspicion 1" or task.specialName == "Tail suspicion 2" or task.specialName == "Tail suspicion CHASE" or task.specialName == "Tail suspicion  before Jericho calls" or task.specialName == "Tail suspicion 1 PART DUEX" or task.specialName == "Drive to Krug" or task.specialName == "Wait for Tanner start" then
      params.dialogue = "GPMV00_FAILURE_L_4"
      params.failReason = task.instance.challenge.taskCompleteData["Failure reason"]
    elseif task.specialName == "Krug task 2" and task.condition == 2 then
      params.vehicle = task.instance.taskObjectsByActorID["Tanner and Jones"].coreData.agent
      params.dialogue = "GPMV00_FAILURE_L_3"
      params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
    end
    OneShotSound.Play("Suspicion_Meter_Stop")
    params.callback = failTask
    params.rating = "FAIL"
    task.instance.payload = 0
    Sound.SetRTPC("DistanceToTarget", 0)
    localPlayer.challenge.endScreen(taskObject, params)
  else
    iCamCrashCam(task.agent.gameVehicle)
  end
end
