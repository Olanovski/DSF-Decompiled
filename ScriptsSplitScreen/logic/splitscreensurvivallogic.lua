module("cardSystem.logic")
missionSetupData["Split Screen Survival"] = {}
local levelReached = 0
local maxChaserDistance = 200
local maxLevel = 10
survivalSwapStatus = {
  [1] = false,
  [2] = false,
  [3] = false,
  [4] = false,
  [5] = false,
  [6] = false,
  [7] = false,
  [8] = false
}
survivalSwapQueue = {
  [1] = false,
  [2] = false,
  [3] = false,
  [4] = false,
  [5] = false,
  [6] = false,
  [7] = false,
  [8] = false
}
missionSetupData["Split Screen Survival"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    local levelData = {
      [1] = {
        startLocation = routes["Survival 1 Level 1 start"].checkpoints[1].position,
        startHeading = routes["Survival 1 Level 1 start"].checkpoints[1].heading,
        route = routes["Survival Level 1"].checkpoints,
        playerVehicles = {
          {
            vehicleID = 62,
            shader = {
              [0] = 0
            }
          },
          {
            vehicleID = 192,
            shader = {
              [0] = 1
            }
          }
        },
        chasers = {
          [1] = 271,
          [2] = 271,
          [3] = 271,
          [4] = 271
        },
        spoolableVehicles = {
          [1] = 271,
          [2] = 231,
          [3] = 62,
          [4] = 192,
          [5] = 128,
          [6] = 280,
          [7] = 205,
          [8] = 269,
          [9] = 275,
          [10] = 215,
          [11] = 265,
          [12] = 248,
          [13] = 189,
          [14] = 226,
          [15] = 232
        }
      },
      [2] = {
        startLocation = routes["Survival 1 Level 2 start"].checkpoints[1].position,
        startHeading = routes["Survival 1 Level 2 start"].checkpoints[1].heading,
        route = routes["Survival 1 Level 2"].checkpoints,
        playerVehicles = {
          vehicleID = 231,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 271,
          [2] = 271,
          [3] = 271,
          [4] = 271,
          [5] = 271,
          [6] = 271
        }
      },
      [3] = {
        startLocation = routes["Survival 1 Level 3 start"].checkpoints[1].position,
        startHeading = routes["Survival 1 Level 3 start"].checkpoints[1].heading,
        route = routes["Survival 1 Level 3 "].checkpoints,
        playerVehicles = {
          vehicleID = 128,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 271,
          [2] = 280,
          [3] = 280,
          [4] = 271,
          [5] = 280,
          [6] = 280
        }
      },
      [4] = {
        startLocation = routes["Survival 1 Level 4 start"].checkpoints[1].position,
        startHeading = routes["Survival 1 Level 4 start"].checkpoints[1].heading,
        route = routes["Survival 1 Level 4"].checkpoints,
        playerVehicles = {
          vehicleID = 205,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 280,
          [2] = 280,
          [3] = 269,
          [4] = 269,
          [5] = 269,
          [6] = 269
        }
      },
      [5] = {
        startLocation = routes["Survival 1 Level 5 start"].checkpoints[1].position,
        startHeading = routes["Survival 1 Level 5 start"].checkpoints[1].heading,
        route = routes["Survival 1 Level 5"].checkpoints,
        playerVehicles = {
          vehicleID = 275,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 280,
          [2] = 269,
          [3] = 269,
          [4] = 269,
          [5] = 269,
          [6] = 269
        }
      },
      [6] = {
        startLocation = routes["Survival 1 Level 6 start"].checkpoints[1].position,
        startHeading = routes["Survival 1 Level 6 start"].checkpoints[1].heading,
        route = routes["Survival 1 Level 6"].checkpoints,
        playerVehicles = {
          vehicleID = 215,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 269,
          [2] = 269,
          [3] = 269,
          [4] = 269,
          [5] = 269,
          [6] = 265
        }
      },
      [7] = {
        startLocation = routes["Survival 1 Level 7 start"].checkpoints[1].position,
        startHeading = routes["Survival 1 Level 7 start"].checkpoints[1].heading,
        route = routes["Survival 1 Level 7"].checkpoints,
        playerVehicles = {
          vehicleID = 248,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 269,
          [2] = 269,
          [3] = 269,
          [4] = 265,
          [5] = 265,
          [6] = 265
        }
      },
      [8] = {
        startLocation = routes["Survival 1 Level 8 start"].checkpoints[1].position,
        startHeading = routes["Survival 1 Level 8 start"].checkpoints[1].heading,
        route = routes["Survival 1 Level 8"].checkpoints,
        playerVehicles = {
          vehicleID = 189,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 269,
          [2] = 269,
          [3] = 265,
          [4] = 265,
          [5] = 265,
          [6] = 265,
          [7] = 265,
          [8] = 265
        }
      },
      [9] = {
        startLocation = routes["Survival 1 Level 9 start"].checkpoints[1].position,
        startHeading = routes["Survival 1 Level 9 start"].checkpoints[1].heading,
        route = routes["Survival 1 Level 9"].checkpoints,
        playerVehicles = {
          vehicleID = 226,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 269,
          [2] = 265,
          [3] = 265,
          [4] = 265,
          [5] = 265,
          [6] = 265,
          [7] = 265,
          [8] = 269
        }
      },
      [10] = {
        startLocation = routes["Survival 1 Level 10 start"].checkpoints[1].position,
        startHeading = routes["Survival 1 Level 10 start"].checkpoints[1].heading,
        route = routes["Survival 1 Level 10"].checkpoints,
        playerVehicles = {
          vehicleID = 232,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 265,
          [2] = 265,
          [3] = 265,
          [4] = 265,
          [5] = 265,
          [6] = 265,
          [7] = 265,
          [8] = 265
        }
      }
    }
    spawnPosition.target = levelData[1].startLocation
    spawnPosition.positionA = levelData[1].startLocation
    spawnPosition.headingA = levelData[1].startHeading
    spawnPosition.playerOneVehicle = levelData[1].playerVehicles[1]
    spawnPosition.playerTwoVehicle = levelData[1].playerVehicles[2]
    spawnPosition.spoolableVehicles = levelData[1].spoolableVehicles
    spawnPosition.levelData = levelData
  end,
  [2] = function(spawnPosition)
    local levelData = {
      [1] = {
        startLocation = routes["Survival 2 Level 1 start "].checkpoints[1].position,
        startHeading = routes["Survival 2 Level 1 start "].checkpoints[1].heading,
        route = routes["Survival 2 Level 1"].checkpoints,
        playerVehicles = {
          {
            vehicleID = 62,
            shader = {
              [0] = 0
            }
          },
          {
            vehicleID = 192,
            shader = {
              [0] = 1
            }
          }
        },
        chasers = {
          [1] = 271,
          [2] = 271,
          [3] = 271,
          [4] = 271
        },
        spoolableVehicles = {
          [1] = 271,
          [2] = 129,
          [3] = 62,
          [4] = 192,
          [5] = 159,
          [6] = 280,
          [7] = 193,
          [8] = 275,
          [9] = 269,
          [10] = 182,
          [11] = 189,
          [12] = 265,
          [13] = 211,
          [14] = 225,
          [15] = 232
        }
      },
      [2] = {
        startLocation = routes["Survival 2 Level 2 start "].checkpoints[1].position,
        startHeading = routes["Survival 2 Level 2 start "].checkpoints[1].heading,
        route = routes["Survival 2 Level 2"].checkpoints,
        playerVehicles = {
          vehicleID = 129,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 271,
          [2] = 271,
          [3] = 271,
          [4] = 271,
          [5] = 271,
          [6] = 271
        }
      },
      [3] = {
        startLocation = routes["Survival 2 Level 3 start "].checkpoints[1].position,
        startHeading = routes["Survival 2 Level 3 start "].checkpoints[1].heading,
        route = routes["Survival 2 Level 3 "].checkpoints,
        playerVehicles = {
          vehicleID = 159,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 271,
          [2] = 280,
          [3] = 280,
          [4] = 271,
          [5] = 280,
          [6] = 280
        }
      },
      [4] = {
        startLocation = routes["Survival 2 Level 4 start "].checkpoints[1].position,
        startHeading = routes["Survival 2 Level 4 start "].checkpoints[1].heading,
        route = routes["Survival 2 Level 4"].checkpoints,
        playerVehicles = {
          vehicleID = 193,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 280,
          [2] = 280,
          [3] = 280,
          [4] = 280,
          [5] = 280,
          [6] = 280
        }
      },
      [5] = {
        startLocation = routes["Survival 2 Level 5 start "].checkpoints[1].position,
        startHeading = routes["Survival 2 Level 5 start "].checkpoints[1].heading,
        route = routes["Survival 2 Level 5"].checkpoints,
        playerVehicles = {
          vehicleID = 275,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 280,
          [2] = 269,
          [3] = 269,
          [4] = 269,
          [5] = 269,
          [6] = 269
        }
      },
      [6] = {
        startLocation = routes["Survival 2 Level 6 start "].checkpoints[1].position,
        startHeading = routes["Survival 2 Level 6 start "].checkpoints[1].heading,
        route = routes["Survival 2 Level 6 "].checkpoints,
        playerVehicles = {
          vehicleID = 182,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 269,
          [2] = 269,
          [3] = 269,
          [4] = 269,
          [5] = 269,
          [6] = 269
        }
      },
      [7] = {
        startLocation = routes["Survival 2 Level 7 start "].checkpoints[1].position,
        startHeading = routes["Survival 2 Level 7 start "].checkpoints[1].heading,
        route = routes["Survival 2 Level 7"].checkpoints,
        playerVehicles = {
          vehicleID = 189,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 269,
          [2] = 269,
          [3] = 269,
          [4] = 269,
          [5] = 265,
          [6] = 265
        }
      },
      [8] = {
        startLocation = routes["Survival 2 Level 8 start "].checkpoints[1].position,
        startHeading = routes["Survival 2 Level 8 start "].checkpoints[1].heading,
        route = routes["Survival 2 Level 8 "].checkpoints,
        playerVehicles = {
          vehicleID = 211,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 269,
          [2] = 269,
          [3] = 269,
          [4] = 269,
          [5] = 265,
          [6] = 265,
          [7] = 265,
          [8] = 265
        }
      },
      [9] = {
        startLocation = routes["Survival 2 Level 9 start "].checkpoints[1].position,
        startHeading = routes["Survival 2 Level 9 start "].checkpoints[1].heading,
        route = routes["Survival 2 Level 9 "].checkpoints,
        playerVehicles = {
          vehicleID = 225,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 269,
          [2] = 269,
          [3] = 265,
          [4] = 265,
          [5] = 265,
          [6] = 265,
          [7] = 265,
          [8] = 265
        }
      },
      [10] = {
        startLocation = routes["Survival 2 Level 10 start "].checkpoints[1].position,
        startHeading = routes["Survival 2 Level 10 start "].checkpoints[1].heading,
        route = routes["Survival 2 Level 10"].checkpoints,
        playerVehicles = {
          vehicleID = 232,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 265,
          [2] = 265,
          [3] = 265,
          [4] = 265,
          [5] = 265,
          [6] = 265,
          [7] = 265,
          [8] = 265
        }
      }
    }
    spawnPosition.target = levelData[1].startLocation
    spawnPosition.positionA = levelData[1].startLocation
    spawnPosition.headingA = levelData[1].startHeading
    spawnPosition.playerOneVehicle = levelData[1].playerVehicles[1]
    spawnPosition.playerTwoVehicle = levelData[1].playerVehicles[2]
    spawnPosition.spoolableVehicles = levelData[1].spoolableVehicles
    spawnPosition.levelData = levelData
  end,
  [3] = function(spawnPosition)
    local levelData = {
      [1] = {
        startLocation = routes["Survival 3 Level 1 start"].checkpoints[1].position,
        startHeading = routes["Survival 3 Level 1 start"].checkpoints[1].heading,
        route = routes["Survival 3 Level 1"].checkpoints,
        playerVehicles = {
          {
            vehicleID = 62,
            shader = {
              [0] = 0
            }
          },
          {
            vehicleID = 192,
            shader = {
              [0] = 1
            }
          }
        },
        chasers = {
          [1] = 271,
          [2] = 271,
          [3] = 271,
          [4] = 271
        },
        spoolableVehicles = {
          [1] = 271,
          [2] = 184,
          [3] = 62,
          [4] = 192,
          [5] = 149,
          [6] = 280,
          [7] = 126,
          [8] = 269,
          [9] = 275,
          [10] = 215,
          [11] = 248,
          [12] = 265,
          [13] = 189,
          [14] = 216,
          [15] = 232
        }
      },
      [2] = {
        startLocation = routes["Survival 3 Level 2 start"].checkpoints[1].position,
        startHeading = routes["Survival 3 Level 2 start"].checkpoints[1].heading,
        route = routes["Survival 3 Level 2"].checkpoints,
        playerVehicles = {
          vehicleID = 184,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 271,
          [2] = 271,
          [3] = 271,
          [4] = 271,
          [5] = 271,
          [6] = 271
        }
      },
      [3] = {
        startLocation = routes["Survival 3 Level 3 start"].checkpoints[1].position,
        startHeading = routes["Survival 3 Level 3 start"].checkpoints[1].heading,
        route = routes["Survival 3 Level 3"].checkpoints,
        playerVehicles = {
          vehicleID = 149,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 271,
          [2] = 280,
          [3] = 280,
          [4] = 271,
          [5] = 280,
          [6] = 280
        }
      },
      [4] = {
        startLocation = routes["Survival 3 Level 4 start"].checkpoints[1].position,
        startHeading = routes["Survival 3 Level 4 start"].checkpoints[1].heading,
        route = routes["Survival 3 Level 4"].checkpoints,
        playerVehicles = {
          vehicleID = 126,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 280,
          [2] = 280,
          [3] = 280,
          [4] = 269,
          [5] = 269,
          [6] = 269
        }
      },
      [5] = {
        startLocation = routes["Survival 3 Level 5 start"].checkpoints[1].position,
        startHeading = routes["Survival 3 Level 5 start"].checkpoints[1].heading,
        route = routes["Survival 3 Level 5"].checkpoints,
        playerVehicles = {
          vehicleID = 275,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 269,
          [2] = 269,
          [3] = 269,
          [4] = 269,
          [5] = 269,
          [6] = 269
        }
      },
      [6] = {
        startLocation = routes["Survival 3 Level 6 start"].checkpoints[1].position,
        startHeading = routes["Survival 3 Level 6 start"].checkpoints[1].heading,
        route = routes["Survival 3 Level 6"].checkpoints,
        playerVehicles = {
          vehicleID = 215,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 269,
          [2] = 269,
          [3] = 269,
          [4] = 269,
          [5] = 269,
          [6] = 269
        }
      },
      [7] = {
        startLocation = routes["Survival 3 Level 7 start"].checkpoints[1].position,
        startHeading = routes["Survival 3 Level 7 start"].checkpoints[1].heading,
        route = routes["Survival 3 Level 7"].checkpoints,
        playerVehicles = {
          vehicleID = 248,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 269,
          [2] = 269,
          [3] = 269,
          [4] = 269,
          [5] = 265,
          [6] = 265
        }
      },
      [8] = {
        startLocation = routes["Survival 3 Level 8 start"].checkpoints[1].position,
        startHeading = routes["Survival 3 Level 8 start"].checkpoints[1].heading,
        route = routes["Survival 3 Level 8"].checkpoints,
        playerVehicles = {
          vehicleID = 189,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 269,
          [2] = 269,
          [3] = 269,
          [4] = 265,
          [5] = 265,
          [6] = 265,
          [7] = 265,
          [8] = 265
        }
      },
      [9] = {
        startLocation = routes["Survival 3 Level 9 start"].checkpoints[1].position,
        startHeading = routes["Survival 3 Level 9 start"].checkpoints[1].heading,
        route = routes["Survival 3 Level 9"].checkpoints,
        playerVehicles = {
          vehicleID = 216,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 269,
          [2] = 265,
          [3] = 265,
          [4] = 265,
          [5] = 265,
          [6] = 265,
          [7] = 265,
          [8] = 265
        }
      },
      [10] = {
        startLocation = routes["Survival 3 Level 10 start"].checkpoints[1].position,
        startHeading = routes["Survival 3 Level 10 start"].checkpoints[1].heading,
        route = routes["Survival 3 Level 10"].checkpoints,
        playerVehicles = {
          vehicleID = 232,
          shader = {
            [0] = 0
          }
        },
        chasers = {
          [1] = 265,
          [2] = 265,
          [3] = 265,
          [4] = 265,
          [5] = 265,
          [6] = 265,
          [7] = 265,
          [8] = 265
        }
      }
    }
    spawnPosition.target = levelData[1].startLocation
    spawnPosition.positionA = levelData[1].startLocation
    spawnPosition.headingA = levelData[1].startHeading
    spawnPosition.playerOneVehicle = levelData[1].playerVehicles[1]
    spawnPosition.playerTwoVehicle = levelData[1].playerVehicles[2]
    spawnPosition.spoolableVehicles = levelData[1].spoolableVehicles
    spawnPosition.levelData = levelData
  end
}
missionSetupData["Split Screen Survival"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
  spawnPosition.playerOneVehicle = nil
  spawnPosition.playerTwoVehicle = nil
  spawnPosition.spoolableVehicles = nil
  spawnPosition.levelData = nil
end
missionSetupData["Split Screen Survival"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\SplitScreen_Survival01.lua",
    trafficSet = 8,
    moods = {
      [1] = "OnlineComa",
      [2] = "OnlineDefault",
      [3] = "OnlineLAConnection",
      [4] = "OnlineVanishing",
      [5] = "OnlineDefault"
    }
  },
  [2] = {
    routeName = "RouteData\\SplitScreen_Survival02.lua",
    trafficSet = 8,
    moods = {
      [1] = "OnlineComa",
      [2] = "OnlineDefault",
      [3] = "OnlineWhiteStripe",
      [4] = "OnlineWhiteStripe",
      [5] = "OnlineVanishing"
    }
  },
  [3] = {
    routeName = "RouteData\\SplitScreen_Survival03.lua",
    trafficSet = 8,
    moods = {
      [1] = "OnlineComa",
      [2] = "OnlineDefault",
      [3] = "OnlineVanishing",
      [4] = "OnlineLAConnection",
      [5] = "OnlineDefault"
    }
  }
}
missionSetupData["Split Screen Survival"].usableRouteIndicies = {
  [1] = {1},
  [2] = {2},
  [3] = {3}
}
local function playerTasks(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "Linear Checkpoints No AI",
        specialName = "checkpoints",
        dynamicTargets = true,
        coreData = {totalLaps = 0},
        goalConditions = {
          {
            {
              goal = "SS Player in shift",
              params = {value = false}
            },
            {
              goal = "SS Player vehicle wrecked",
              params = {value = false}
            },
            {
              goal = "MP Checkpoint Tracker"
            }
          },
          {
            {
              goal = "SS partner crossed checkpoint",
              params = {value = true}
            }
          },
          {
            {
              goal = "SS new level reached",
              params = {value = true}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "SS survival level above",
              params = {
                value = maxLevel + 1
              }
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["SS Coop Survival Checkpoint Gate"] = {maxLevel = maxLevel}
              }
            }
          }
        },
        HUD = {
          {
            style = "SS Survival HUD"
          }
        }
      },
      [2] = {
        task = "SS Shift To New Vehicle Tracking",
        goalConditions = {
          {
            {
              goal = "SS player shifting to new vehicle",
              params = {value = true}
            },
            {
              goal = "SS Player in shift",
              params = {value = false}
            }
          }
        }
      },
      [3] = {
        task = "SS Track Partner",
        goalConditions = {
          {
            {
              goal = "SS player shifting to new vehicle",
              params = {value = false}
            },
            {
              goal = "SS player shift returning",
              params = {value = false}
            },
            {
              goal = "SS player shift level greater or equal",
              params = {value = 1}
            }
          }
        }
      }
    }
  }
end
local function packageTasks(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "Survival Spawner",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "SS Players wrecked",
              params = {value = false}
            },
            {
              goal = "SS player shifting to new vehicle",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Chaser spawn check",
              params = {
                distance = maxChaserDistance,
                start = 1,
                increment = 2
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "SS Players wrecked",
              params = {value = false}
            },
            {
              goal = "SS player shifting to new vehicle",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Chaser spawn check",
              params = {
                distance = maxChaserDistance,
                start = 2,
                increment = 2
              }
            }
          }
        }
      },
      [2] = {
        task = "Survival Level Tracker",
        specialName = "level",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "SS player completed route",
              params = {value = true}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "SS survival level above",
              params = {
                value = maxLevel + 1
              }
            }
          },
          {
            {
              goal = "SS Players wrecked",
              params = {value = true}
            }
          }
        }
      }
    }
  }
end
local function chaserTasks(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "SS Survival Chase",
        specialName = "chase",
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
              goal = "SS target in zap",
              params = {value = true}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "SS survival level above",
              params = {
                value = maxLevel + 1
              }
            }
          },
          {
            {
              goal = "SS Players wrecked",
              params = {value = true}
            }
          }
        }
      },
      [2] = {
        task = "SS Survival Target Player",
        goalConditions = {
          {
            {
              goal = "SS Check Swap Complete"
            },
            {
              goal = "SS Chaser Target Player"
            }
          }
        }
      }
    }
  }
end
missionSetupData["Split Screen Survival"].taskCreatorFunctionLookups = {
  ["Objective Team 1"] = chaserTasks,
  ["Objective Team 2"] = packageTasks,
  ["Player Pool"] = playerTasks
}
missionSetupData["Split Screen Survival"].stepHighlightColours = function(instance)
  if not instance.playersColours then
    instance.playersColours = {
      [1] = {SNVID = -1},
      [2] = {SNVID = -1}
    }
    Menu.SetPlayerColour(0, OnlineModeSettings.blue128)
    Menu.SetPlayerColour(1, OnlineModeSettings.orange128)
  end
  for playerID, data in next, instance.playersColours, nil do
    if data.SNVID ~= -1 and not vehicleManager.vehiclesBySNVID[data.SNVID] then
      data.SNVID = -1
    end
  end
  for localPlayerID, player in next, localPlayerManager.players, nil do
    if player.currentVehicle and (instance.playersColours[localPlayerID + 1].SNVID == -1 or instance.playersColours[localPlayerID + 1].SNVID ~= player.currentVehicle.SNVID) then
      instance.playersColours[localPlayerID + 1].SNVID = player.currentVehicle.SNVID
      if localPlayerID == 0 then
        player.currentVehicle:setDisplayColour(OnlineModeSettings.blue32, OnlineModeSettings.blue128)
      else
        player.currentVehicle:setDisplayColour(OnlineModeSettings.orange32, OnlineModeSettings.orange128)
      end
    end
  end
end
missionSetupData["Split Screen Survival"].missionCompleteData = function()
  onlineScreenManager.setSSModeCompDataTable(maxLevel, 50, 70, 90)
  onlineScreenManager.setSSCoopModeCompDataTable(levelReached - 1, maxLevel, levelReached - 1)
end
missionSetupData["Split Screen Survival"].getPlayerProgress = function(instance)
  local medal = 0
  local level = 0
  local progress = 0
  local objTO = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  level = objTO.namedTasks.level and objTO.namedTasks.level.networkVars.level - 1 or 0
  progress = level / maxLevel * 100
  if progress >= 90 then
    medal = 1
  elseif progress >= 70 then
    medal = 2
  elseif progress >= 50 then
    medal = 3
  end
  return level, medal
end
missionSetupData["Split Screen Survival"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 2,
      spoolStartArea = true,
      gridStyle = 5,
      missionVehicleStyle = 5,
      moodStyle = 2,
      teamGame = false,
      gridStagger = 0,
      disableZapOnCompletion = true,
      trackPlayerScores = true,
      maxChaserDistance = maxChaserDistance,
      respawnDistanceFromGate = 110,
      introHUD = "SS Survival Start HUD",
      maxLevel = maxLevel
    }
  }
end
missionSetupData["Split Screen Survival"].initiate = function(instance)
  local package = packageManager.createPackage(false, vec.vector(0, 0, 0, 1), true, 0, nil, nil, nil, nil, 0, true)
  instance:newActorFromAgent(OBJ_TEAM_TWO_STRING_TABLE[1], package)
end
local swapFinishedCallback = function(gameVehicle)
  local instance = false
  local playerTO = localPlayer.getTaskObject()
  local objTO = false
  local scriptVehicle = vehicleManager.vehiclesByGameVehicle[gameVehicle]
  local chasers = false
  instance = playerTO and playerTO.coreData.instance or false
  NetworkLog.Write(">[LUA] Survival: Swap Complete = " .. tostring(gameVehicle))
  if playerTO and scriptVehicle then
    local level = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]].namedTasks.level.networkVars.level
    chasers = instance.challenge.spawnPositions[instance.networkVars.routeIndex].levelData[level].chasers
    local behaviour = false
    for i = 1, 8 do
      objTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
      if objTO and objTO.coreData.agent == scriptVehicle then
        scriptVehicle:activateSiren()
        objTO.swapComplete = true
        NetworkLog.Write(">[LUA] Survival: Swap Complete = " .. tostring(gameVehicle) .. " Obj TO = " .. tostring(i))
        if survivalSwapStatus[i].callback then
          survivalSwapStatus[i].callback(scriptVehicle, level)
        end
        survivalSwapStatus[i] = false
        if survivalSwapQueue[i] then
          scriptVehicle = vehicleManager.vehiclesByGameVehicle[survivalSwapQueue[i].vehicle]
          if scriptVehicle then
            survivalSwapStatus[i] = {}
            survivalSwapStatus[i].vehicle = survivalSwapQueue[i].vehicle
            survivalSwapStatus[i].callback = survivalSwapQueue[i].callback
            NetworkLog.Write(">[LUA] Survival: Swap Model (Queued)(Cop) = " .. tostring(survivalSwapQueue[i].vehicle) .. "  objID = " .. tostring(i))
            GameVehicleResource.swapWithModel(survivalSwapQueue[i].vehicle, chasers[i])
          end
          survivalSwapQueue[i] = false
        end
        break
      end
    end
  end
end
missionSetupData["Split Screen Survival"].missionStart = function(instance)
  checkpointSystem.clearNoneSyncronisedCheckpoint()
  for i = 1, maxLevel do
    for j, checkpointData in ipairs(instance.challenge.spawnPositions[instance.networkVars.routeIndex].levelData[i].route) do
      checkpointSystem.createNoneSyncronisedCheckpoint(instance.instanceID, i, checkpointData)
    end
  end
  for localID, player in next, playerManager.players, nil do
    player:blockAbility("zap", true)
  end
  zap.SetZapInOverride(function()
  end)
  zap.zapSwap.setSwapFinishedCallback(swapFinishedCallback)
  zapcontroller.ZapSettings(1, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(2, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(3, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(4, {CanSelectVehicles = false})
  localPlayerManager.players[0].currentVehicle:set_damageMultiplier(survivalAI.playerDamageMultiplier[1])
  localPlayerManager.players[1].currentVehicle:set_damageMultiplier(survivalAI.playerDamageMultiplier[1])
  localPlayerManager.players[0].zapToNewVehicle = false
  localPlayerManager.players[1].zapToNewVehicle = false
  for localPlayerID, player in next, localPlayerManager.players, nil do
    checkpointTracker.addTracker(player:getTaskObject(), player.currentVehicle.gameVehicle)
  end
  levelReached = 0
  for i = 1, 8 do
    survivalSwapStatus[i] = false
    survivalSwapQueue[i] = false
  end
end
missionSetupData["Split Screen Survival"].missionEnd = function(instance)
  zapcontroller.ZapSettings(1, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(2, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(3, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(4, {CanSelectVehicles = true})
  zap.zapSwap.setSwapFinishedCallback(false)
  zap.SetZapInOverride(nil)
  zap.setZapTransitionCompleteCallback(false)
end
missionSetupData["Split Screen Survival"].modeReadyCheck = function(instance)
  return true
end
missionSetupData["Split Screen Survival"].update = function(instance)
end
taskCompleteData["Split Screen Survival"] = {}
taskCompleteData["Split Screen Survival"].taskComplete = function(taskObject, task)
  if task.taskName == "Survival Level Tracker" then
    if task.condition == 2 then
      phaseManager.failedSSRound = true
    end
    levelReached = task.networkVars.level
    task.instance:initiateOverTimePhase()
    for localID, player in next, playerManager.players, nil do
      player:blockAbility("zap", false)
    end
    zap.SetZapInOverride(nil)
  end
end
local function getPlayerDynamicTargets(taskObject, task, dynamicListID)
  local packageTO = task.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  local level = packageTO and packageTO.namedTasks.level and packageTO.namedTasks.level.networkVars.level or 1
  local lap = task.networkVars.laps + 1
  if level > maxLevel then
    level = maxLevel
  end
  local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(taskObject.coreData.instance.instanceID, level)
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
local getObjectiveTeamOneTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  local playerOneVehicle = localPlayerManager.players[0].currentVehicle
  local playerTwoVehicle = localPlayerManager.players[1].currentVehicle
  if (not playerOneVehicle or 1 <= playerOneVehicle.damage) and (not playerTwoVehicle or 1 <= playerTwoVehicle.damage) then
    return false, true
  elseif not playerOneVehicle or 1 <= playerOneVehicle.damage then
    return {playerTwoVehicle}, false
  elseif not playerTwoVehicle or 1 <= playerTwoVehicle.damage then
    return {playerOneVehicle}, false
  else
    for i, id in ipairs(OBJ_TEAM_ONE_STRING_TABLE) do
      if id == taskObject.coreData.actor.ID then
        if math.mod(i, 2) == 0 then
          return {playerOneVehicle}, false
        else
          return {playerTwoVehicle}, false
        end
      end
    end
  end
end
missionSetupData["Split Screen Survival"].targetList = {
  ["Player Pool"] = getPlayerDynamicTargets,
  ["Objective Team 1"] = getObjectiveTeamOneTargets
}
