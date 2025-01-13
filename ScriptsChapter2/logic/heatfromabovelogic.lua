module("cardSystem.logic")
missionSetupData["Heat from above"] = {}
zapLevelForHelicam = 6
local checkpointTimers = {
  [1] = 25,
  [2] = 30,
  [3] = 55,
  [4] = 45,
  [5] = 40
}
local initalZapSlowMo
local KeyFrameData = {
  [1] = {
    time = 0,
    matrix = vec.matrix(-0.04782, -0.507356, 0.860409, 442.5742, 0.027853, 0.860382, 0.508888, 191.2829, -0.998468, 0.048301, -0.027012, 123.9889, 0, 0, 0, 1),
    fov = 1.18
  },
  [2] = {
    time = 9.514758,
    matrix = vec.matrix(0.012276, -0.516584, 0.856149, 427.6446, 0.006768, 0.856236, 0.51654, 189.2755, -0.999902, -0.000547, 0.014008, 115.4185, 0, 0, 0, 1),
    fov = 1.18
  },
  [3] = {
    time = 19.70908,
    matrix = vec.matrix(-0.548871, -0.506198, 0.66521, 31.61254, 0.025423, 0.785317, 0.618571, 136.0263, -0.83552, 0.356428, -0.418169, -111.9253, 0, 0, 0, 1),
    fov = 1.18
  },
  [4] = {
    time = 28.34522,
    matrix = vec.matrix(-0.407701, -0.617726, 0.672454, -192.3013, 0.023602, 0.729064, 0.684039, 162.2084, -0.912811, 0.294755, -0.28266, -23.35216, 0, 0, 0, 1),
    fov = 1.18
  },
  [5] = {
    time = 32.66071,
    matrix = vec.matrix(-0.955207, 0.253781, -0.152234, -335.6876, 0.018248, 0.56394, 0.825614, 192.5087, 0.295376, 0.785854, -0.543311, 33.24184, 0, 0, 0, 1),
    fov = 1.18
  },
  [6] = {
    time = 43.69527,
    matrix = vec.matrix(-0.9456, 0.255166, -0.20182, -85.62729, 0.022211, 0.669536, 0.742447, 137.4319, 0.324573, 0.697575, -0.638781, 694.2234, 0, 0, 0, 1),
    fov = 1.18
  },
  [7] = {
    time = 48.68712,
    matrix = vec.matrix(-0.764401, -0.468745, 0.442685, -48.09825, 0.019868, 0.669157, 0.742856, 115.1215, -0.644435, 0.576635, -0.502191, 865.9176, 0, 0, 0, 1),
    fov = 1.18
  },
  [8] = {
    time = 53.69367,
    matrix = vec.matrix(-0.915121, -0.352279, 0.196095, -155.7629, 0.014993, 0.4563, 0.889699, 106.5155, -0.402901, 0.817122, -0.412288, 993.3628, 0, 0, 0, 1),
    fov = 1.18
  },
  [9] = {
    time = 62.22758,
    matrix = vec.matrix(-0.995412, -0.091908, 0.026594, -163.3652, 0.007281, 0.204384, 0.978864, 193.6104, -0.095401, 0.974567, -0.202777, 981.6353, 0, 0, 0, 1),
    fov = 1.18
  },
  [10] = {
    time = 68.54118,
    matrix = vec.matrix(-0.991324, 0.115892, -0.062018, -86.07667, 0.019177, 0.594294, 0.804019, 154.5649, 0.130037, 0.795854, -0.591361, 1400.313, 0, 0, 0, 1),
    fov = 1.18
  },
  [11] = {
    time = 72.99598,
    matrix = vec.matrix(-0.909343, -0.322423, 0.262943, -95.71835, 0.019388, 0.598477, 0.800905, 176.0623, -0.415596, 0.733395, -0.53797, 1519.328, 0, 0, 0, 1),
    fov = 1.18
  },
  [12] = {
    time = 75.55214,
    matrix = vec.matrix(-0.603105, -0.588676, 0.538261, -123.6464, 0.021678, 0.662453, 0.74879, 150.8349, -0.797368, 0.463267, -0.386767, 1597.231, 0, 0, 0, 1),
    fov = 1.18
  },
  [13] = {
    time = 77.07456,
    matrix = vec.matrix(-0.411311, -0.59226, 0.692857, -247.4337, 0.034173, 0.749579, 0.661032, 134.7169, -0.910854, 0.295566, -0.288071, 1674.694, 0, 0, 0, 1),
    fov = 1.18
  },
  [14] = {
    time = 79.67664,
    matrix = vec.matrix(-0.279027, -0.563506, 0.777564, -471.5242, 0.02606, 0.804981, 0.592727, 111.3472, -0.95993, 0.18565, -0.209927, 1734.729, 0, 0, 0, 1),
    fov = 1.18
  },
  [15] = {
    time = 87.57098,
    matrix = vec.matrix(-0.120274, -0.495719, 0.860115, -931.5203, 0.027949, 0.86437, 0.50208, 106.947, -0.992347, 0.084426, -0.090106, 1852.913, 0, 0, 0, 1),
    fov = 1.18
  },
  [16] = {
    time = 91.41743,
    matrix = vec.matrix(-0.090275, -0.477649, 0.8739, -1102.266, -0.007188, 0.877773, 0.479023, 135.244, -0.995891, 0.036962, -0.082674, 1783.376, 0, 0, 0, 1),
    fov = 1.18
  },
  [17] = {
    time = 96.12225,
    matrix = vec.matrix(-0.087545, -0.486642, 0.869204, -1430.1, 0.027843, 0.871018, 0.490462, 170, -0.995772, 0.067139, -0.062703, 1726.314, 0, 0, 0, 1),
    fov = 1.18
  },
  [18] = {
    time = 100.7051,
    matrix = vec.matrix(-0.424733, -0.515583, 0.744162, -1796.546, 0.083793, 0.796072, 0.599373, 240, -0.901433, 0.316928, -0.294916, 1764.962, 0, 0, 0, 1),
    fov = 1.18
  },
  [19] = {
    time = 104.824,
    matrix = vec.matrix(-0.84691, -0.293206, 0.443591, -2157.213, 0.072362, 0.76292, 0.642431, 213.6854, -0.526789, 0.57618, -0.624908, 1942.138, 0, 0, 0, 1),
    fov = 1.18
  },
  [20] = {
    time = 115.454,
    matrix = vec.matrix(-0.717783, -0.294702, 0.630824, -2754.523, 0.028889, 0.892623, 0.449878, 158.7251, -0.695667, 0.341139, -0.632196, 2566.294, 0, 0, 0, 1),
    fov = 1.18
  },
  [21] = {
    time = 123.9263,
    matrix = vec.matrix(-0.765951, -0.535537, 0.355694, -2948.462, 0.017364, 0.535832, 0.844146, 143.2835, -0.642664, 0.652751, -0.401122, 2728.52, 0, 0, 0, 1),
    fov = 1.18
  },
  [22] = {
    time = 130.6145,
    matrix = vec.matrix(-0.81135, -0.499004, 0.304477, -2950.418, 0.016233, 0.501431, 0.865045, 143.6456, -0.584336, 0.706797, -0.398735, 2726.578, 0, 0, 0, 1),
    fov = 1.18
  }
}
local tannerTask = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        coreData = {
          totalLaps = goalParams["Total laps"] or 0
        },
        specialName = "Start",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 5}
            },
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
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Enable helicam",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        }
      }
    }
  }
  return task
end
local enemyTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Toggle targetting reticule",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 69}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 74}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 91}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 94}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Spawn streetrace vehicles",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 10}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Play Scan Prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 9}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Trigger streetrace commentary",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 22}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Spawn emergency services",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 33}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 40}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Trigger crashsite commentary",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 45}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Trigger crashsite explosion",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 53.5}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 57}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Trigger fire engine to crashsite",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 61}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Trigger cop chase",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 74}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Trigger low building commentary",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 97}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Enemy scanned",
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 121}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Scanned in helicam",
              params = {actorID = "Real enemy"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Player In Agent",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Real enemy"}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Enemy controlled by player",
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
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Reached Destination",
        taskConditions = {
          {
            {
              goal = "In back of truck"
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
              goal = "Time trigger",
              params = {value = 60},
              feedback = "Timer"
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
            style = "Heat from above HUD",
            settings = {showTimer = true, startTime = 60}
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Near to truck",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 75}
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
local function truckTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Truck controlled by player",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Real enemy"},
                inverse = true
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
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Trigger truck prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Follow Route",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "Linear Checkpoints No AI",
        specialName = "Truck Reached Destination",
        coreData = {totalLaps = 0},
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 45}
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
              goal = "Completed lap",
              params = {value = 0, inverse = true}
            },
            {
              goal = "Driving to checkpoint",
              params = {value = 1}
            },
            {
              goal = "Time trigger",
              params = {
                value = checkpointTimers[1]
              },
              feedback = "Timer"
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Completed lap",
              params = {value = 0, inverse = true}
            },
            {
              goal = "Driving to checkpoint",
              params = {value = 2}
            },
            {
              goal = "Time trigger",
              params = {
                value = checkpointTimers[2]
              },
              feedback = "Timer"
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Completed lap",
              params = {value = 0, inverse = true}
            },
            {
              goal = "Driving to checkpoint",
              params = {value = 3}
            },
            {
              goal = "Time trigger",
              params = {
                value = checkpointTimers[3]
              },
              feedback = "Timer"
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Completed lap",
              params = {value = 0, inverse = true}
            },
            {
              goal = "Driving to checkpoint",
              params = {value = 4}
            },
            {
              goal = "Time trigger",
              params = {
                value = checkpointTimers[4]
              },
              feedback = "Timer"
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Completed lap",
              params = {value = 0, inverse = true}
            },
            {
              goal = "Driving to checkpoint",
              params = {value = 5}
            },
            {
              goal = "Time trigger",
              params = {
                value = checkpointTimers[5]
              },
              feedback = "Timer"
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
            style = "Heat from above HUD",
            settings = {showTimer = true, checkpointTimers = checkpointTimers}
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Trigger truck speech",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Spawn 1st goons",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 2000}
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
        specialName = "Audio - 1st Damage",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player within radius of opposing team member",
              params = {value = 25}
            },
            {
              goal = "Damage has changed by",
              params = {value = 0.01}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Spawn Front Smasher 1",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 1350}
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
        specialName = "Spawn Front Smasher 2",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 1200}
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
        specialName = "Spawn Front Smasher 3",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 900}
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
        specialName = "Spawn hoard 1",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 55}
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
        specialName = "Spawn hoard 2",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 95}
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
        task = "No AI",
        specialName = "Wait for End",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        }
      }
    }
  }
  return task
end
local stationaryTask = function(goalParams, HUD, audio)
  local task = {
    {
      {task = "No AI"}
    }
  }
  return task
end
local stoppingDistance = {
  ["Ambulance 1"] = 5,
  ["Ambulance 2"] = 10,
  ["Ambulance 3"] = 15
}
local function racerTask(goalParams, HUD, audio, agent, actorID)
  local task = {
    {
      {
        task = "Linear Checkpoints",
        dynamicTargets = true,
        specialName = "Enemy arrives at location",
        coreData = {
          totalLaps = goalParams["Total laps"] or 0
        },
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {
                value = stoppingDistance[actorID] or 20
              }
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {coreValue = "totalLaps"}
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
      {
        task = "Non-linear Chase",
        dynamicTargets = true
      }
    }
  }
  return task
end
local goonTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Linear Chase",
        dynamicTargets = true,
        specialName = "Chase truck",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Stop chase",
        groupProgression = {importantMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Any team member within radius of target",
              params = {value = 200}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 40}
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
        task = "Linear Checkpoints",
        specialName = "Drive away",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        specialName = "Far from truck",
        dynamicTargets = true,
        goalConditions = {
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
              params = {value = 1}
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
          },
          {
            {
              goal = "Time trigger",
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
local exploderTask = function(goalParams, HUD, audio, agent, actorID)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Linear Chase",
        specialName = "ExplodeMe",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Simple collision check",
              params = {force = 1000, mustHitTarget = true}
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Stop chase",
        groupProgression = {importantMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Any team member within radius of target",
              params = {value = 200}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 50}
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
        task = "Linear Checkpoints",
        specialName = "Drive away",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        specialName = "Far from truck",
        dynamicTargets = true,
        goalConditions = {
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
              params = {value = 1}
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
          },
          {
            {
              goal = "Time trigger",
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
missionSetupData["Heat from above"].taskCreatorFunctionLookups = {
  ["Tanner team"] = tannerTask,
  ["Stationary team"] = stationaryTask,
  ["Race team"] = racerTask,
  ["Chase team"] = chaseTask,
  ["Enemy team"] = enemyTask,
  ["Goon team"] = goonTask,
  ["Truck team"] = truckTask,
  ["Exploder team"] = exploderTask
}
local policeStation = vec.vector(-3045.44, 66.28259, 936.8161, 1)
local leave = vec.vector(0, 0, 0, 1)
local attackersWrecked
local truckAtPoliceStation = false
local ravens, marker
missionSetupData["Heat from above"].initiate = function(instance)
  createCheckpoints(instance)
  createFixedPosition(instance, {policeStation}, 200)
  createFixedPosition(instance, {leave}, 201)
  attackersWrecked = 0
  truckAtPoliceStation = false
  feedbackSystem.menusMaster.blockHintButton(true)
  initalZapSlowMo = zapcontroller.getZapSlowMotionMultiplier()
  local softSaveData = progressionSystem.getSoftSaveData()
  if not softSaveData or softSaveData and softSaveData.progression <= 1 then
    scoreSystem.blockWillpowerPrompt(true)
    localPlayer:blockAbility("zap", true)
    localPlayer:blockAbility("zapReturn", true)
    localPlayer:setBlockAutoZap(true)
    OneShotSound.Play("Mis_Helicopter_Exterior_Play")
    feedbackSystem.menusMaster.masterSetTextVariable("helicopter_scan_button", localPlayer.buttonLayout.helicopterScan)
    feedbackSystem.menusMaster.masterSetTextVariable("helicopter_shift_button", localPlayer.buttonLayout.zapSelect)
    Mood.addMoodZapLevel(moodSystem.chapterMoods.Chapter2.main, "TopZap5", 6, 1, -1, localID)
  end
  GameVehicleResource.registerAttachedVehicleCallback(vehicleManager.attachedVehicleCallback)
  GameVehicleResource.registerAttachedVehicleDeleteRequestFn(vehicleManager.attachedVehicleDeleteRequest)
  if softSaveData then
    if softSaveData.progression == 1 then
      GameVehicleResource.setCanCaptureCars(instance.taskObjectsByActorID.Truck.coreData.agent.gameVehicle, true)
      ravens = characterManager.addCirclingRavens(spawnPositions["Real enemy"].position + vec.vector(0, 3, 0, 0), 100)
      feedbackSystem.playRavensSound("Ravens_Circling", spawnPositions["Real enemy"].position)
      OneShotSound.Play("Mis_Helicopter_Exterior_Leaving_Play")
    elseif softSaveData.progression == 2 then
      instance.taskObjectsByActorID.Truck.coreData.actor.markerType = "Objective"
    end
    if softSaveData.progression >= 1 then
      feedbackSystem.menusMaster.blockHintButton(false)
      feedbackSystem.startMusic("Uid15056_CH02_Story_EyesOnTheCity_Play")
    end
  end
end
missionSetupData["Heat from above"].update = nil
local getRacerDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if dynamicListID then
    if task.networkVars.checkpoints < #allCheckpoints then
      return {
        allCheckpoints[task.networkVars.checkpoints + 1]
      }, false
    else
      return false, true
    end
  else
    return {
      allCheckpoints[task.networkVars.checkpoints]
    }, false
  end
end
local getChaserDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Chase truck" or task.specialName == "Far from truck" or task.specialName == "ExplodeMe" or task.specialName == "Near to truck" then
    if dynamicListID then
      return false, true
    else
      return {
        task.instance.taskObjectsByActorID.Truck.coreData.agent
      }, false
    end
  elseif task.specialName == "Stop chase" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 200), false
    end
  elseif task.specialName == "Drive away" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 201), false
    end
  else
    return {
      task.instance.taskObjectsByActorID.Racer.coreData.agent
    }, false
  end
end
local getTruckDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName ~= "Truck Reached Destination" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 200), false
    end
  else
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, task.actor.checkpointGroup)
    if dynamicListID then
      if task.networkVars.checkpoints < #allCheckpoints then
        OneShotSound.Play("HUD_Play_Waypoint")
        local promptParams = {}
        if task.networkVars.checkpoints < #allCheckpoints then
          promptParams.prompt = "ID:243824"
          promptParams.value = #allCheckpoints - task.networkVars.checkpoints
          feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
        end
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
end
missionSetupData["Heat from above"].targetList = {
  ["Tanner team"] = getRacerDynamicTargets,
  ["Race team"] = getRacerDynamicTargets,
  ["Chase team"] = getChaserDynamicTargets,
  ["Truck team"] = getTruckDynamicTargets,
  ["Goon team"] = getChaserDynamicTargets,
  ["Exploder team"] = getChaserDynamicTargets,
  ["Enemy team"] = getChaserDynamicTargets
}
local function startCam()
  HeliCam.Start(KeyFrameData)
  HeliCam.SetCursorAccelerationMultiplier(500)
  HeliCam.SetCursorMaxVelocity(2)
  HeliCam.SetCursorFrictionCoEfficient(0.0015)
  HeliCam.SetMaxTimeBeforeLosingVehicle(1)
  OneShotSound.Play("Mis_Helicopter_Interior_Play")
  OneShotSound.Play("Mis_Helicopter_Exterior_Stop", false, true)
  localPlayer:showHUDElements(false)
  HeliCam.SetScanSpeedMultipler(15)
  localPlayer.simulationSupport.doWait(1, function()
    transitions.fadeto(vec.vector(0, 0, 0, 0), 1, 1)
  end, "fadeIn")
end
local loopThroughAndKill = function(task, exclusionList)
  for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
    if actorID ~= "Real enemy" and actorID ~= "Truck" and actorID ~= exclusionList.actorID then
      print(actorID)
      if taskObject.coreData.agent.gameVehicle.towingVehicle then
        GameVehicleResource.detachVehicle(taskObject.coreData.agent.gameVehicle)
      end
      taskObject:delete(true)
    end
  end
end
missionSetupData["Heat from above"].goalComplete = function(taskObject, task, conditionKey)
  if task.specialName == "Toggle targetting reticule" then
    if conditionKey == 1 or conditionKey == 3 then
      OneShotSound.Play("Mis_Scan_Interrupt_Stop")
      OneShotSound.Play("Mis_Scan_OutOfRange_Stop")
      HeliCam.BlockScan(true)
    else
      HeliCam.BlockScan(false)
    end
  end
end
taskCompleteData["Heat from above"] = {}
taskCompleteData["Heat from above"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = taskObject.coreData.agent,
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = "ID:183989"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.success then
    if task.specialName == "Start" then
      localPlayer:SetZapLevel(zapLevelForHelicam)
      zapcontroller.setZapSlowMotionMultiplier(1)
      transitions.fadeto(vec.vector(1, 1, 1, 1), 1, 2, startCam)
      zapcontroller.FPPShowZapFlare(false)
      OneShotSound.Play("ZAP_ZapOut_OneShot")
    elseif task.specialName == "Enable helicam" then
      challengeSystem.spawnActors(task.instance, "Any", {
        ["Truck"] = true,
        ["Real enemy"] = true
      })
      localPlayer.missionSupport:setMainTaskObject(task.instance.taskObjectsByActorID["Real enemy"])
      localPlayer:setBlockAutoZap(true)
      feedbackSystem.menusMaster.setNextFocusString()
      GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID.Truck.coreData.agent.gameVehicle, true)
      GameVehicleResource.registerAttachedVehicleCallback(vehicleManager.attachedVehicleCallback)
      GameVehicleResource.registerAttachedVehicleDeleteRequestFn(vehicleManager.attachedVehicleDeleteRequest)
      task.instance.taskObjectsByActorID["Real enemy"].coreData.agent.heliCamAllowZapInto = true
      if not marker and task.instance.taskObjectsByActorID["Real enemy"] then
        marker = feedbackSystem.newTarget(task.instance.taskObjectsByActorID["Real enemy"].coreData.agent, "Exclamation marker")
      end
    elseif task.specialName == "Play Scan Prompt" then
      local params = {
        prompt = "ID:246420",
        endCallback = function()
          HeliCam.ShowCursor(true)
          HeliCam.BlockScan(false)
        end
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(params)
    elseif task.specialName == "Spawn streetrace vehicles" then
      local toSpawn = {
        ["Streetracer 1"] = true,
        ["Streetracer 2"] = true,
        ["Streetracer 3"] = true,
        ["Streetracer 4"] = true,
        ["Streetracer 5"] = true,
        ["Streetracer 6"] = true,
        ["Streetracer 7"] = true,
        ["Streetracer 8"] = true
      }
      local toExclude = {
        ["Streetracer 1"] = true,
        ["Streetracer 2"] = true,
        ["Streetracer 3"] = true,
        ["Streetracer 4"] = true,
        ["Streetracer 5"] = true,
        ["Streetracer 6"] = true,
        ["Streetracer 7"] = true,
        ["Streetracer 8"] = true,
        ["Tanner Actor"] = true
      }
      loopThroughAndKill(task, toExclude)
      challengeSystem.spawnActors(task.instance, "Any", toSpawn)
    elseif task.specialName == "Spawn emergency services" then
      local toSpawn = {
        ["Accident 1 RK Spyder"] = true,
        ["Accident 2 Cadillac"] = true,
        ["Accident 3 Tanker"] = true,
        ["Ambulance 1"] = true,
        ["Ambulance 2"] = true,
        ["Ambulance 3"] = true,
        ["Accident emergency 1 Ambulance"] = true,
        ["Accident emergency 2 cop"] = true,
        ["Accident emergency 3 cop"] = true
      }
      loopThroughAndKill(task, toSpawn)
      challengeSystem.spawnActors(task.instance, "Any", toSpawn)
      local smokeParams2 = {
        id = 103,
        eventName = "EParticleEvent_Fiire_stage_02",
        offset = vec.vector(0, 3.5, 4.232, 1),
        gameVehicle = task.instance.taskObjectsByActorID["Accident 3 Tanker"].coreData.agent.gameVehicle.towedVehicle
      }
      local smokeParams3 = {
        id = 104,
        eventName = "EParticleEvent_Fiire_stage_02",
        offset = vec.vector(0, 3.5, -0.273, 1),
        gameVehicle = task.instance.taskObjectsByActorID["Accident 3 Tanker"].coreData.agent.gameVehicle.towedVehicle
      }
      local smokeParams4 = {
        id = 105,
        eventName = "EParticleEvent_Fiire_stage_02",
        offset = vec.vector(0, 3.5, -4.766, 1),
        gameVehicle = task.instance.taskObjectsByActorID["Accident 3 Tanker"].coreData.agent.gameVehicle.towedVehicle
      }
      ParticleEditor.TriggerEvent(smokeParams2)
      ParticleEditor.TriggerEvent(smokeParams3)
      ParticleEditor.TriggerEvent(smokeParams4)
    elseif task.specialName == "Enemy arrives at location" then
      if taskObject.coreData.actor.ID == "Ambulance 1" then
        taskObject.coreData.agent:lockEmergencyBrakes(5)
      elseif taskObject.coreData.actor.ID == "Ambulance 2" or taskObject.coreData.actor.ID == "Ambulance 3" then
        taskObject.coreData.agent:lockEmergencyBrakes(2)
      end
    elseif task.specialName == "Trigger crashsite explosion" then
      ParticleEditor.StopEvent(103)
      ParticleEditor.StopEvent(104)
      ParticleEditor.StopEvent(105)
      GameVehicleResource.explode({
        gameVehicle = task.instance.taskObjectsByActorID["Accident 3 Tanker"].coreData.agent.gameVehicle.towedVehicle,
        offset = vec.vector(1, 0, 0, 1),
        range = 0,
        strength = 0
      })
      OneShotSound.Play("Mis_Explosion_HeliView_OneShot")
    elseif task.specialName == "Trigger fire engine to crashsite" then
      local toSpawn = {
        ["Firetruck"] = true,
        ["Firetruck 2"] = true
      }
      challengeSystem.spawnActors(task.instance, "Any", toSpawn)
    elseif task.specialName == "Trigger cop chase" then
      local toSpawn = {
        ["Racer"] = true,
        ["Chaser 1"] = true,
        ["Chaser 2"] = true,
        ["Chaser 3"] = true,
        ["Chaser 4"] = true,
        ["Chaser 5"] = true
      }
      loopThroughAndKill(task, toSpawn)
      challengeSystem.spawnActors(task.instance, "Any", toSpawn)
      toSpawn = {
        ["Chaser 6"] = true,
        ["Chaser 7"] = true
      }
      challengeSystem.spawnActors(task.instance, "Any", toSpawn)
      ravens = characterManager.addCirclingRavens(spawnPositions["Real enemy"].position + vec.vector(0, 10, 0, 0), 100)
      feedbackSystem.playRavensSound("Ravens_Circling", spawnPositions["Real enemy"].position)
    elseif task.specialName == "Enemy scanned" then
      local velocity, direction = vec.vector(0, 0, 0, 0), vec.vector(1, 0, 0, 0)
      OneShotSound.PlayAtPosition("Mis_Alone_RavenEye_Positive_Play", spawnPositions["Real enemy"].position + vec.vector(0, 1, 0, 0), velocity, direction)
      if marker then
        feedbackSystem.clearTarget(marker)
        marker = nil
      end
    elseif task.specialName == "Player In Agent" then
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if actorID ~= "Real enemy" and actorID ~= "Truck" then
          if taskObject.coreData.agent.gameVehicle.towingVehicle then
            GameVehicleResource.detachVehicle(taskObject.coreData.agent.gameVehicle)
          end
          taskObject:delete()
        end
      end
      HeliCam.HideHUD()
      OneShotSound.Play("Mis_Helicopter_Interior_Stop")
      OneShotSound.Play("Mis_Helicopter_Exterior_Leaving_Play")
      OneShotSound.Play("Mis_Scan_OutOfRange_Stop")
      zapcontroller.setZapSlowMotionMultiplier(initalZapSlowMo)
      feedbackSystem.startMusic("Uid15056_CH02_Story_EyesOnTheCity_Play")
      scoreSystem.blockWillpowerPrompt(false)
      feedbackSystem.menusMaster.masterSetVariable("iHelicopter_Text", 0)
      feedbackSystem.menusMaster.masterSetVariable("iHelicopter_Scan_Prompt", 0)
      localPlayer:showHUDElements(true)
    elseif task.specialName == "Enemy controlled by player" then
      progressionSystem.triggerSoftSave({progression = 1})
      feedbackSystem.menusMaster.blockHintButton(false)
      feedbackSystem.menusMaster.setCurrentFocusString(1)
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245534")
    elseif task.specialName == "Near to truck" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184823")
      characterManager.removeRavenGroup(ravens)
      feedbackSystem.stopRavensSound()
      feedbackSystem.menusMaster.setCurrentFocusString(2)
      OneShotSound.Play("Mis_Helicopter_Exterior_Stop")
    elseif task.specialName == "Reached Destination" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      localPlayer.missionSupport:setMainTaskObject(task.instance.taskObjectsByActorID.Truck)
      GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID.Truck.coreData.agent.gameVehicle, false)
      task.instance.taskObjectsByActorID.Truck.coreData.actor.markerType = "Objective"
      localPlayer:zapToAgent(task.instance.taskObjectsByActorID.Truck.coreData.agent)
    elseif task.specialName == "Truck controlled by player" then
      progressionSystem.triggerSoftSave({progression = 2})
      feedbackSystem.menusMaster.setCurrentFocusString(3)
      localPlayer:blockAbility("zap", false)
      localPlayer:blockAbility("zapReturn", false)
      localPlayer:setBlockAutoZap(false)
      localPlayer:overrideZapReturn(localPlayer.currentVehicle)
    elseif task.specialName == "Trigger truck prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245535")
    elseif task.specialName == "Spawn 1st goons" and not truckAtPoliceStation then
      challengeSystem.spawnActors(task.instance, "Any", {
        ["Chasing Goon Start 1"] = true,
        ["Chasing Goon Start 2"] = true
      })
      challengeSystem.spawnActors(task.instance, "Any", {
        ["Endcop1"] = true,
        ["Endcop2"] = true,
        ["Tanner Actor 2"] = true
      })
      OneShotSound.Play("HUD_Gen_NewEnemy_Alert_OneShot", false)
    elseif task.specialName == "Spawn Front Smasher 1" and not truckAtPoliceStation then
      challengeSystem.spawnActors(task.instance, "Any", {
        ["Chasing Goon Front Smash 1"] = true
      })
      OneShotSound.Play("HUD_Gen_NewEnemy_Alert_OneShot", false)
    elseif task.specialName == "Spawn Front Smasher 2" and not truckAtPoliceStation then
      challengeSystem.spawnActors(task.instance, "Any", {
        ["Chasing Goon Front Smash 2"] = true
      })
      OneShotSound.Play("HUD_Gen_NewEnemy_Alert_OneShot", false)
    elseif task.specialName == "Spawn Front Smasher 3" and not truckAtPoliceStation then
      challengeSystem.spawnActors(task.instance, "Any", {
        ["Chasing Goon Front Smash 3"] = true
      })
      OneShotSound.Play("HUD_Gen_NewEnemy_Alert_OneShot", false)
    elseif task.specialName == "Spawn hoard 1" and not truckAtPoliceStation then
      challengeSystem.spawnActors(task.instance, "Any", {
        ["Chasing Goon Horde 1a"] = true,
        ["Chasing Goon Horde 1b"] = true,
        ["Chasing Goon SUV 1"] = true
      })
      OneShotSound.Play("HUD_Gen_NewEnemy_Alert_OneShot", false)
    elseif task.specialName == "Spawn hoard 2" and not truckAtPoliceStation then
      challengeSystem.spawnActors(task.instance, "Any", {
        ["Chasing Goon Horde 2a"] = true,
        ["Chasing Goon 3d"] = true,
        ["Chasing Goon SUV 2"] = true
      })
      OneShotSound.Play("HUD_Gen_NewEnemy_Alert_OneShot", false)
    elseif task.specialName == "Stop chase" then
      taskObject.coreData.agent.iconsVisible = false
      if task.condition == 2 then
        attackersWrecked = attackersWrecked + 1
        if attackersWrecked == 3 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_3", nil, "missioncritical")
        end
      end
    elseif task.specialName == "ExplodeMe" then
      GameVehicleResource.explode({
        gameVehicle = taskObject.coreData.agent.gameVehicle,
        range = 20,
        strength = 5
      })
      taskObject.coreData.agent.iconsVisible = false
      OneShotSound.Play("ParkedCar_Explosion_Play")
    elseif task.specialName == "Truck Reached Destination" then
      OneShotSound.Play("HUD_Play_Waypoint")
      truckAtPoliceStation = true
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if string.find(actorID, "Chasing") then
          if taskObject.coreData.agent.gameVehicle.towingVehicle then
            GameVehicleResource.detachVehicle(taskObject.coreData.agent.gameVehicle)
          end
          taskObject:delete()
        end
      end
      taskObject.coreData.agent:lockEmergencyBrakes(2)
      feedbackSystem.stopMusic("Uid15056_CH02_Story_EyesOnTheCity_Stop")
      params.vehicle = task.instance.taskObjectsByActorID.Truck.coreData.agent
      params.rating = "PASS"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
  else
    if task.specialName == "Reached Destination" or task.specialName == "Truck controlled by player" or task.specialName == "Truck Reached Destination" then
      params.hint = "ID:235485"
      if 3 <= task.condition then
        params.failReason = "ID:184293"
      else
        params.reason = "Wrecked"
      end
    end
    params.vehicle = taskObject.coreData.agent
    params.rating = "FAIL"
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Heat from above"] = function(instance)
  localPlayer:showHUDElements(true)
  localPlayer:blockAbility("zap", false)
  HeliCam.Stop()
  localPlayer:blockAbility("zapReturn", false)
  localPlayer:setBlockAutoZap(false)
  OneShotSound.Play("Mis_Helicopter_Exterior_Stop", false, true)
  OneShotSound.Play("Mis_Helicopter_Interior_Stop", false, true)
  feedbackSystem.menusMaster.masterSetVariable("iHelicopter_Text", 0)
  feedbackSystem.stopMusic("Uid15056_CH02_Story_EyesOnTheCity_Stop")
  feedbackSystem.menusMaster.masterSetVariable("iHelicopter_Scan_Prompt", 0)
  zapcontroller.FPPShowZapFlare(true)
  zapcontroller.HideFlare(false, localPlayer.playerID)
  removeUserUpdateFunction("fadeIn")
  if ravens then
    characterManager.removeRavenGroup(ravens)
  end
  if marker then
    feedbackSystem.clearTarget(marker)
    marker = nil
  end
  feedbackSystem.stopRavensSound()
  GameVehicleResource.unregisterAttachedVehicleCallback(vehicleManager.attachedVehicleCallback)
  GameVehicleResource.unregisterAttachedVehicleDeleteRequestFn(vehicleManager.attachedVehicleDeleteRequest)
  zapcontroller.setZapSlowMotionMultiplier(initalZapSlowMo)
  scoreSystem.blockWillpowerPrompt(false)
  Mood.removeMood("TopZap5")
end
