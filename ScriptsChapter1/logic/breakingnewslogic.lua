module("cardSystem.logic")
missionSetupData["Breaking news"] = {}
local copCars = {
  267,
  271,
  280,
  269,
  265,
  185,
  186,
  276
}
local truckMovedFailDistance = 20
local distanceToTriggerReminder = 180
local showHotspotAboveZapLevel = 3
local amountToDrift = 20
local targetDisplaySpeed, speedToHit = feedbackSystem.mphToLocalisedSpeed(100)
local firstFilmingZone = vec.vector(-315.727, 18.41, 888.247, 1)
local hotspotInAlleyway = vec.vector(90.981, 44.138, 685.711, 1)
local radiusToJumpInto = vec.vector(114.295, 41.264, 812.954, 1)
local hotspotAt1stLocation = vec.vector(-265.221, 17.982, 907.021, 1)
local hotspotAt2ndLocation = vec.vector(100.254, 36.242, 842.162, 1)
local alleywayRoadIndex, targetDistanceAlong
alleywayRoadIndex, targetDistanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(hotspotInAlleyway)
local function scoringTask(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "Stall at start of mission",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
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
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
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
        dynamicTargets = true,
        specialName = "Stop In Hotspot",
        groupProgression = {importantMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Agent stopped inside radius",
              params = {value = 5, stopDuration = 0.2}
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
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
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
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Trigger Destination Prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Trigger Initial Speech",
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
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait for Start PIP",
        dynamicTargets = false,
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            },
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
        specialName = "Wait in Icam",
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
        specialName = "Finish Icam",
        dynamicTargets = true,
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
            manager = "Target list",
            settings = {
              styles = {
                ["Radius with hotspot"] = {
                  radius = goalParams["Hotspot radius"]
                }
              }
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait For Zap",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Vehicles zapped into",
              params = {value = 1}
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
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {goal = "Got busted"}
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Radius with hotspot"] = {
                  radius = goalParams["Hotspot radius"]
                }
              }
            }
          }
        },
        HUD = {
          {style = HUD}
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait 1",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
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
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {goal = "Got busted"}
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Radius with hotspot"] = {
                  distanceToHideHotspot = distanceToTriggerReminder,
                  useZapPositionForHotspotControl = true,
                  showHotspotAboveZapLevel = showHotspotAboveZapLevel,
                  radius = goalParams["Hotspot radius"]
                }
              }
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Speed Past",
        groupProgression = {importantMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Within radius",
              params = {
                value = goalParams["Hotspot radius"],
                agent = "Player"
              }
            },
            {
              goal = "Player above speed",
              params = {value = speedToHit, displayed = true}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Recent audio played",
              params = {value = 5}
            },
            {
              goal = "Within radius",
              params = {
                value = goalParams["Hotspot radius"],
                agent = "Player",
                inverse = true
              }
            },
            {
              goal = "Player above speed",
              params = {value = speedToHit, displayed = true}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            {
              goal = "Prompt active",
              params = {
                promptType = "StuntPrompt",
                inverse = true
              }
            },
            {
              goal = "Within radius",
              params = {
                value = 350,
                agent = "Player",
                inverse = true
              }
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Prompt active",
              params = {
                promptType = "StuntPrompt",
                inverse = true
              }
            },
            {
              goal = "Within radius",
              params = {value = 350, agent = "Player"}
            },
            {
              goal = "Within radius",
              params = {
                value = 50,
                agent = "Player",
                inverse = true
              }
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Time trigger",
              params = {value = 0.25}
            },
            {
              goal = "Within radius",
              params = {
                value = goalParams["Hotspot radius"],
                agent = "Player",
                inverse = true
              }
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Time trigger",
              params = {value = 0.25}
            },
            {
              goal = "Within radius",
              params = {
                value = goalParams["Hotspot radius"],
                agent = "Player"
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
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {goal = "Got busted"}
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Radius with hotspot"] = {
                  distanceToHideHotspot = distanceToTriggerReminder,
                  useZapPositionForHotspotControl = true,
                  showHotspotAboveZapLevel = showHotspotAboveZapLevel,
                  radius = goalParams["Hotspot radius"]
                }
              }
            }
          }
        },
        HUD = {
          {
            style = HUD,
            settings = {
              showStuntFeedback = true,
              speedToHit = speedToHit,
              targetDisplaySpeed = targetDisplaySpeed
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "zap speed",
        goalConditions = {
          {
            triggerCount = 3,
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
        dynamicTargets = true,
        specialName = "Truck moved 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = truckMovedFailDistance, inverse = true}
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
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "cam ended 1",
        goalConditions = {
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
        },
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.2}
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        },
        HUD = {
          {
            style = HUD,
            settings = {showStuntFeedback = true}
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "HandBrake Turn",
        groupProgression = {importantMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Within radius",
              params = {
                value = goalParams["Hotspot radius"],
                agent = "Player"
              }
            },
            {
              goal = "Is drifting",
              params = {value = amountToDrift}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Recent audio played",
              params = {value = 5}
            },
            {
              goal = "Within radius",
              params = {
                value = goalParams["Hotspot radius"],
                agent = "Player",
                inverse = true
              }
            },
            {
              goal = "Is drifting",
              params = {value = amountToDrift}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            {
              goal = "Prompt active",
              params = {
                promptType = "StuntPrompt",
                inverse = true
              }
            },
            {
              goal = "Within radius",
              params = {
                value = distanceToTriggerReminder,
                agent = "Player",
                inverse = true
              }
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Prompt active",
              params = {
                promptType = "StuntPrompt",
                inverse = true
              }
            },
            {
              goal = "Within radius",
              params = {value = distanceToTriggerReminder, agent = "Player"}
            },
            {
              goal = "Within radius",
              params = {
                value = 50,
                agent = "Player",
                inverse = true
              }
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Time trigger",
              params = {value = 0.25}
            },
            {
              goal = "Within radius",
              params = {
                value = goalParams["Hotspot radius"],
                agent = "Player",
                inverse = true
              }
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Time trigger",
              params = {value = 0.25}
            },
            {
              goal = "Within radius",
              params = {
                value = goalParams["Hotspot radius"],
                agent = "Player"
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
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {goal = "Got busted"}
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Radius with hotspot"] = {
                  distanceToHideHotspot = distanceToTriggerReminder,
                  useZapPositionForHotspotControl = true,
                  showHotspotAboveZapLevel = showHotspotAboveZapLevel,
                  radius = goalParams["Hotspot radius"]
                }
              }
            }
          }
        },
        HUD = {
          {
            style = HUD,
            settings = {showStuntFeedback = true, amountToDrift = amountToDrift}
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Show handbrake reminder",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Is drifting",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 30}
            },
            {
              goal = "Prompt active",
              params = {
                promptType = "StuntPrompt",
                inverse = true
              }
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            }
          }
        },
        HUD = {
          {style = HUD}
        }
      },
      {
        task = "No AI",
        specialName = "zap handbrake",
        goalConditions = {
          {
            triggerCount = 3,
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
        dynamicTargets = true,
        specialName = "Truck moved 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = truckMovedFailDistance, inverse = true}
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
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "cam ended 2",
        goalConditions = {
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
        },
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.2}
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        },
        HUD = {
          {
            style = HUD,
            settings = {showStuntFeedback = true}
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Head On Collision",
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Within radius",
              params = {
                value = goalParams["Hotspot radius"],
                agent = "Player"
              }
            },
            {
              goal = "Simple collision check",
              params = {
                force = 5000,
                type = "Vehicle",
                whereIHit = "Front",
                whereIWasHit = "Front",
                setOnPlayer = true,
                ignoreSpecifiedActor = "Van Actor"
              }
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Recent audio played",
              params = {value = 5}
            },
            {
              goal = "Within radius",
              params = {
                value = goalParams["Hotspot radius"],
                agent = "Player",
                inverse = true
              }
            },
            {
              goal = "Simple collision check",
              params = {
                force = 5000,
                type = "Vehicle",
                whereIHit = "Front",
                whereIWasHit = "Front",
                setOnPlayer = true,
                ignoreSpecifiedActor = "Van Actor"
              }
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            {
              goal = "Prompt active",
              params = {
                promptType = "StuntPrompt",
                inverse = true
              }
            },
            {
              goal = "Within radius",
              params = {
                value = distanceToTriggerReminder,
                agent = "Player",
                inverse = true
              }
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Prompt active",
              params = {
                promptType = "StuntPrompt",
                inverse = true
              }
            },
            {
              goal = "Within radius",
              params = {value = distanceToTriggerReminder, agent = "Player"}
            },
            {
              goal = "Within radius",
              params = {
                value = 50,
                agent = "Player",
                inverse = true
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
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {goal = "Got busted"}
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Radius with hotspot"] = {
                  distanceToHideHotspot = distanceToTriggerReminder,
                  useZapPositionForHotspotControl = true,
                  showHotspotAboveZapLevel = showHotspotAboveZapLevel,
                  radius = goalParams["Hotspot radius"]
                }
              }
            }
          }
        },
        HUD = {
          {style = HUD}
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Kill driftscore sound",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Is drifting",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "zap collision",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 4,
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
        dynamicTargets = true,
        specialName = "Truck moved 3",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = truckMovedFailDistance, inverse = true}
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
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "cam ended 3",
        goalConditions = {
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
        },
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.2}
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        HUD = {
          {
            style = HUD,
            settings = {showStuntFeedback = true}
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Get in van",
        groupProgression = {importantMinorOrder = true},
        taskConditions = {
          {
            {
              goal = "Is player controlled"
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
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {goal = "Got busted"}
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {style = HUD}
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Unlock van",
        groupProgression = {importantMinorOrder = true},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Prompt to return to van",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        HUD = {
          {style = HUD}
        }
      },
      {
        task = "No AI",
        specialName = "Force out of car",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 20}
            }
          }
        }
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Truck moved 4",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = truckMovedFailDistance, inverse = true}
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
              goal = "Instant goal complete"
            }
          }
        }
      }
    },
    {
      {
        task = "Wander",
        dynamicTargets = true,
        specialName = "Stop In Hotspot 2",
        groupProgression = {importantMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Agent stopped inside radius",
              params = {value = 5, stopDuration = 0.2}
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
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
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
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Prompt to get to next destination",
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
        HUD = {
          {style = HUD}
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Trigger Icam",
        taskConditions = {
          {
            {
              goal = "Instant goal complete"
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Start ICam2",
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
        specialName = "Finish Icam2",
        dynamicTargets = true,
        taskConditions = {
          {
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
        task = "No AI",
        specialName = "Have we jumped",
        groupProgression = {importantMinorOrder = true},
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Player in getaway vehicle"
            },
            {
              goal = "Is player on this road ID",
              params = {roadIndex = alleywayRoadIndex}
            },
            {
              goal = "Within radius",
              params = {value = 20, agent = "Player"}
            },
            {
              goal = "Player above speed",
              params = {value = 40}
            },
            {goal = "Is jumping"}
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {goal = "Got busted"}
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
          {style = HUD}
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Are we being chased",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
            skipTargetUpdate = true,
            {
              goal = "Time trigger",
              params = {value = 0.2}
            },
            {
              goal = "Is a felony active"
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player in getaway vehicle"
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Time trigger",
              params = {value = 0.2}
            },
            {
              goal = "Is a felony active",
              params = {inverse = true}
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Is player in vehicle model",
              params = {value = copCars, inverse = true}
            },
            {
              goal = "Player in getaway vehicle",
              params = {inverse = true}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Time trigger",
              params = {value = 0.2}
            },
            {
              goal = "Is a felony active"
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player in getaway vehicle"
            },
            {
              goal = "Is player on this road ID",
              params = {roadIndex = alleywayRoadIndex}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Time trigger",
              params = {value = 0.2}
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Is player in vehicle model",
              params = {value = copCars}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Is a felony active",
              params = {inverse = true}
            }
          },
          {
            triggerCount = 1,
            skipTargetUpdate = true,
            {
              goal = "Is a felony active",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = true}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Is a felony active"
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Time trigger",
              params = {value = 0.2}
            },
            {
              goal = "Is a felony active"
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player in getaway vehicle"
            },
            {
              goal = "Is player on this road ID",
              params = {roadIndex = alleywayRoadIndex, inverse = true}
            }
          }
        },
        HUD = {
          {
            style = HUD,
            settings = {hotspotPosition = hotspotInAlleyway, jumpAreaPosition = radiusToJumpInto}
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Van moved",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = truckMovedFailDistance, inverse = true}
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
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait for jump camera",
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
        },
        HUD = {
          {style = HUD}
        }
      },
      audioPIP = audio
    }
  }
  return task
end
missionSetupData["Breaking news"].taskCreatorFunctionLookups = {
  ["Scoring team"] = scoringTask
}
missionSetupData["Breaking news"].initiate = function(instance)
  createFixedPosition(instance, {firstFilmingZone}, 101)
  createFixedPosition(instance, {hotspotAt1stLocation}, 100)
  createFixedPosition(instance, {hotspotAt2ndLocation}, 102)
  createFixedPosition(instance, {hotspotInAlleyway}, 103)
  createFixedPosition(instance, {radiusToJumpInto}, 104)
  local focusText = {
    ["ID:243788"] = {
      [1] = targetDisplaySpeed
    }
  }
  feedbackSystem.menusMaster.setFocusButtonText(focusText)
end
missionSetupData["Breaking news"].update = nil
local getVehicleDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    return false, true
  elseif task.specialName == "Stop In Hotspot" or string.find(task.specialName, "Truck moved") then
    return checkpointSystem.getCheckpoints(task.instance, 100), false
  elseif task.specialName == "Stop In Hotspot 2" or task.specialName == "Van moved" then
    return checkpointSystem.getCheckpoints(task.instance, 102), false
  elseif task.specialName == "Are we being chased" then
    return checkpointSystem.getCheckpoints(task.instance, 103), false
  elseif task.specialName == "Finish Icam2" or task.specialName == "Have we jumped" then
    return checkpointSystem.getCheckpoints(task.instance, 104), false
  else
    return checkpointSystem.getCheckpoints(task.instance, 101), false
  end
end
missionSetupData["Breaking news"].targetList = {
  ["Scoring team"] = getVehicleDynamicTargets
}
missionEndCallback["Breaking news"] = function(instance)
  Sound.EnableScoring("drift", false)
  Sound.EnableScoring("jump", false)
  zapcontroller.RemoveLockedVehicle({
    gameVehicle = instance.taskObjectsByActorID["Van Actor"].coreData.agent.gameVehicle
  })
  feedbackSystem.menusMaster.masterSetVariable("iTV_Cam", 0)
  CameraSystem.ClearScene()
  minimap.SetHighlightedVehicles(false)
  minimap.RemoveAllHighlightedVehicleModelUIDs()
  PatrollingVehicleManager.EnableHud(true)
  localPlayer:blockAbility("zapReturn", false)
  Sound.ExitAudioState("FilmRolling")
end
local forceZapOut = function(task)
  localPlayer:exitCutsceneMode()
  localPlayer:resetCameraMode()
  localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
  zapcontroller.AddLockedVehicle({
    gameVehicle = task.instance.taskObjectsByActorID["Van Actor"].coreData.agent.gameVehicle
  })
  localPlayer:blockAbility("zapReturn", true)
end
taskCompleteData["Breaking news"] = {}
taskCompleteData["Breaking news"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID["Van Actor"].coreData.agent,
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:234321",
    dialogue = "",
    hintIcon1 = localPlayer.buttonLayout.minimapZoom
  }
  if task.success then
    if task.specialName == "Trigger Destination Prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245529")
    elseif string.find(task.specialName, "Stop In Hotspot") then
      if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle ~= task.agent.gameVehicle or localPlayer.inZap then
        localPlayer:SetZapLevel(1)
        localPlayer:SetZapLevel(0, task.agent, false)
      end
      localPlayer.cameraSupport.miniSceneCamera()
      localPlayer:enterCutsceneMode()
    elseif task.specialName == "Wait for Start PIP" then
      local cameraMatrix = vec.matrix(0.6270242, -0.3366578, 0.7024122, -253.499, 0.07319283, 0.9232526, 0.3771595, 34.45791, -0.775475, -0.1850696, 0.6035449, 922.9818, 0, 0, 0, 1)
      local sceneCamera = {
        {
          {
            lookFrom = cameraMatrix[3],
            lookAt = cameraMatrix[3] + -cameraMatrix[2] * 5,
            duration = 6
          }
        }
      }
      if localPlayer.cameraMode == "Bumper" then
        VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
      end
      local matrix = vec.matrix(-0.9951556, 0.005073533, 0.0981959, -265.1594, 0.004289422, 0.9999585, -0.008194681, 17.9177, -0.09823316, -0.007733758, -0.995136, 907.4722, 0, 0, 0, 1)
      CameraSystem.AddScene(sceneCamera)
      task.agent:teleport(matrix)
    elseif task.specialName == "Wait in Icam" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243699", nil, false, false, false)
    elseif task.specialName == "Finish Icam" then
      CameraSystem.ClearScene()
      forceZapOut(task)
    elseif task.specialName == "Wait For Zap" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.setCurrentFocusString(2)
    elseif task.specialName == "softsave" then
      progressionSystem.triggerSoftSave({progression = 1})
    elseif task.specialName == "Trigger Icam" then
      local cameraMatrix = vec.matrix(0.8433942, 0.1510627, -0.5156253, 86.77954, 0.01409378, 0.9531147, 0.3022864, 50.34954, 0.5371131, -0.2622139, 0.8017219, 861.0412, 0, 0, 0, 1)
      local sceneCamera = {
        {
          {
            lookFrom = cameraMatrix[3],
            lookAt = cameraMatrix[3] + -cameraMatrix[2] * 5,
            duration = 6
          }
        }
      }
      if localPlayer.cameraMode == "Bumper" then
        VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
      end
      CameraSystem.AddScene(sceneCamera)
    elseif task.specialName == "Start ICam2" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:246397")
    elseif task.specialName == "Finish Icam2" then
      CameraSystem.ClearScene()
      forceZapOut(task)
      felony_patrollingVehicleManager.enablePatrollingVehicles(true, true)
    elseif task.specialName == "Unlock van" then
      task.agent:unlockEmergencyBrakes()
      zapcontroller.RemoveLockedVehicle({
        gameVehicle = task.agent.gameVehicle
      })
      localPlayer:blockAbility("zapReturn", false)
      localPlayer:buildZapReturn()
    elseif task.specialName == "Force out of car" then
      localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
    elseif task.specialName == "Wait for jump camera" then
      local function completeTask()
        progressionSystem.challengeComplete(task.instance, task.agent.matrix)
      end
      params.rating = "PASS"
      params.dialogue = "GPMV01_SUCCESS_L_1"
      params.callback = completeTask
      params.driverIsTanner = true
      localPlayer.challenge.endScreen(taskObject, params)
    end
  else
    local function failTask()
      progressionSystem.challengeFailed(task.instance, task.agent.matrix)
    end
    if task.condition == 1 then
      params.failReason = "ID:243667"
    elseif task.condition == 2 then
      params.failReason = "ID:184950"
      params.reason = "Wrecked"
    elseif task.condition == 3 then
      params.failReason = "ID:186264"
      params.reason = "Busted"
    end
    params.callback = failTask
    params.dialogue = "GPMV00_FAILURE_L_1"
    params.rating = "FAIL"
    params.driverIsTanner = true
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
