module("cardSystem.logic")
missionSetupData["Split Screen Clean the Streets"] = {}
local cleanTheStreetsRacerLife = {
  [1] = {
    [1] = 5,
    [2] = 3,
    [3] = 7,
    [4] = 5,
    [5] = 6,
    [6] = 5,
    [7] = 5,
    [8] = 6,
    [9] = 5,
    [10] = 13
  },
  [2] = {
    [1] = 5,
    [2] = 3,
    [3] = 6,
    [4] = 5,
    [5] = 5,
    [6] = 4,
    [7] = 7,
    [8] = 7,
    [9] = 5,
    [10] = 13
  },
  [3] = {
    [1] = 5,
    [2] = 3,
    [3] = 6,
    [4] = 5,
    [5] = 5,
    [6] = 4,
    [7] = 5,
    [8] = 6,
    [9] = 5,
    [10] = 13
  }
}
local cleanTheStreetsHitRacerForce = {
  [1] = {
    [1] = 3000,
    [2] = 4000,
    [3] = 4000,
    [4] = 4000,
    [5] = 4000,
    [6] = 4000,
    [7] = 4000,
    [8] = 4000,
    [9] = 3500,
    [10] = 3500
  },
  [2] = {
    [1] = 3000,
    [2] = 4000,
    [3] = 4000,
    [4] = 4000,
    [5] = 4000,
    [6] = 4000,
    [7] = 4000,
    [8] = 4000,
    [9] = 3500,
    [10] = 3500
  },
  [3] = {
    [1] = 3000,
    [2] = 4000,
    [3] = 4000,
    [4] = 4000,
    [5] = 4000,
    [6] = 4000,
    [7] = 4000,
    [8] = 4000,
    [9] = 3500,
    [10] = 3500
  }
}
local racerVehicles = {
  [1] = 176,
  [2] = 184,
  [3] = 250,
  [4] = 127,
  [5] = 119,
  [6] = 248,
  [7] = 135,
  [8] = 279,
  [9] = 212,
  [10] = 224
}
local numberOfRacersPerLevel = {
  [1] = {
    [1] = 2,
    [2] = 3,
    [3] = 2,
    [4] = 3,
    [5] = 2,
    [6] = 3,
    [7] = 2,
    [8] = 2,
    [9] = 3,
    [10] = 1
  },
  [2] = {
    [1] = 2,
    [2] = 3,
    [3] = 2,
    [4] = 3,
    [5] = 2,
    [6] = 3,
    [7] = 2,
    [8] = 2,
    [9] = 3,
    [10] = 1
  },
  [3] = {
    [1] = 2,
    [2] = 3,
    [3] = 2,
    [4] = 3,
    [5] = 2,
    [6] = 3,
    [7] = 2,
    [8] = 2,
    [9] = 3,
    [10] = 1
  }
}
local playerVehicles = {
  [1] = 271,
  [2] = 271,
  [3] = 271,
  [4] = 269,
  [5] = 269,
  [6] = 269,
  [7] = 265,
  [8] = 265,
  [9] = 265,
  [10] = 265
}
missionSetupData["Split Screen Clean the Streets"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.target = routes["SS Clean the Streets Start 01"].checkpoints[1].position
    spawnPosition.positionA = routes["SS Clean the Streets Start 01"].checkpoints[1].position
    spawnPosition.headingA = routes["SS Clean the Streets Start 01"].checkpoints[1].heading
    spawnPosition.spawnPositions = {
      [1] = {
        pos = routes["SS Clean the Streets Level 01"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 01"].checkpoints[1].heading
      },
      [2] = {
        pos = routes["SS Clean the Streets Level 02"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 02"].checkpoints[1].heading
      },
      [3] = {
        pos = routes["SS Clean the Streets Level 03"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 03"].checkpoints[1].heading
      },
      [4] = {
        pos = routes["SS Clean the Streets Level 04"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 04"].checkpoints[1].heading
      },
      [5] = {
        pos = routes["SS Clean the Streets Level 05"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 05"].checkpoints[1].heading
      },
      [6] = {
        pos = routes["SS Clean the Streets Level 06"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 06"].checkpoints[1].heading
      },
      [7] = {
        pos = routes["SS Clean the Streets Level 07"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 07"].checkpoints[1].heading
      },
      [8] = {
        pos = routes["SS Clean the Streets Level 08"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 08"].checkpoints[1].heading
      },
      [9] = {
        pos = routes["SS Clean the Streets Level 09"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 09"].checkpoints[1].heading
      },
      [10] = {
        pos = routes["SS Clean the Streets Level 10"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 10"].checkpoints[1].heading
      }
    }
    spawnPosition.targetPositions = {
      [1] = routes["SS Clean the Streets Level 01"].checkpoints,
      [2] = routes["SS Clean the Streets Level 02"].checkpoints,
      [3] = routes["SS Clean the Streets Level 03"].checkpoints,
      [4] = routes["SS Clean the Streets Level 04"].checkpoints,
      [5] = routes["SS Clean the Streets Level 05"].checkpoints,
      [6] = routes["SS Clean the Streets Level 06"].checkpoints,
      [7] = routes["SS Clean the Streets Level 07"].checkpoints,
      [8] = routes["SS Clean the Streets Level 08"].checkpoints,
      [9] = routes["SS Clean the Streets Level 09"].checkpoints,
      [10] = routes["SS Clean the Streets Level 10"].checkpoints
    }
    spawnPosition.roads = {
      [1] = routes["SS Clean the Streets Level 01"].roads,
      [2] = routes["SS Clean the Streets Level 02"].roads,
      [3] = routes["SS Clean the Streets Level 03"].roads,
      [4] = routes["SS Clean the Streets Level 04"].roads,
      [5] = routes["SS Clean the Streets Level 05"].roads,
      [6] = routes["SS Clean the Streets Level 06"].roads,
      [7] = routes["SS Clean the Streets Level 07"].roads,
      [8] = routes["SS Clean the Streets Level 08"].roads,
      [9] = routes["SS Clean the Streets Level 09"].roads,
      [10] = routes["SS Clean the Streets Level 10"].roads
    }
    spawnPosition.routeNames = {
      [1] = "SS Clean the Streets Level 01",
      [2] = "SS Clean the Streets Level 02",
      [3] = "SS Clean the Streets Level 03",
      [4] = "SS Clean the Streets Level 04",
      [5] = "SS Clean the Streets Level 05",
      [6] = "SS Clean the Streets Level 06",
      [7] = "SS Clean the Streets Level 07",
      [8] = "SS Clean the Streets Level 08",
      [9] = "SS Clean the Streets Level 09",
      [10] = "SS Clean the Streets Level 10"
    }
  end,
  [2] = function(spawnPosition)
    spawnPosition.target = routes["SS Clean the Streets Start 11"].checkpoints[1].position
    spawnPosition.positionA = routes["SS Clean the Streets Start 11"].checkpoints[1].position
    spawnPosition.headingA = routes["SS Clean the Streets Start 11"].checkpoints[1].heading
    spawnPosition.spawnPositions = {
      [1] = {
        pos = routes["SS Clean the Streets Level 11"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 11"].checkpoints[1].heading
      },
      [2] = {
        pos = routes["SS Clean the Streets Level 12"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 12"].checkpoints[1].heading
      },
      [3] = {
        pos = routes["SS Clean the Streets Level 13"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 13"].checkpoints[1].heading
      },
      [4] = {
        pos = routes["SS Clean the Streets Level 14"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 14"].checkpoints[1].heading
      },
      [5] = {
        pos = routes["SS Clean the Streets Level 15"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 15"].checkpoints[1].heading
      },
      [6] = {
        pos = routes["SS Clean the Streets Level 16"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 16"].checkpoints[1].heading
      },
      [7] = {
        pos = routes["SS Clean the Streets Level 17"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 17"].checkpoints[1].heading
      },
      [8] = {
        pos = routes["SS Clean the Streets Level 18"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 18"].checkpoints[1].heading
      },
      [9] = {
        pos = routes["SS Clean the Streets Level 19"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 19"].checkpoints[1].heading
      },
      [10] = {
        pos = routes["SS Clean the Streets Level 20"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 20"].checkpoints[1].heading
      }
    }
    spawnPosition.targetPositions = {
      [1] = routes["SS Clean the Streets Level 11"].checkpoints,
      [2] = routes["SS Clean the Streets Level 12"].checkpoints,
      [3] = routes["SS Clean the Streets Level 13"].checkpoints,
      [4] = routes["SS Clean the Streets Level 14"].checkpoints,
      [5] = routes["SS Clean the Streets Level 15"].checkpoints,
      [6] = routes["SS Clean the Streets Level 16"].checkpoints,
      [7] = routes["SS Clean the Streets Level 17"].checkpoints,
      [8] = routes["SS Clean the Streets Level 18"].checkpoints,
      [9] = routes["SS Clean the Streets Level 19"].checkpoints,
      [10] = routes["SS Clean the Streets Level 20"].checkpoints
    }
    spawnPosition.roads = {
      [1] = routes["SS Clean the Streets Level 11"].roads,
      [2] = routes["SS Clean the Streets Level 12"].roads,
      [3] = routes["SS Clean the Streets Level 13"].roads,
      [4] = routes["SS Clean the Streets Level 14"].roads,
      [5] = routes["SS Clean the Streets Level 15"].roads,
      [6] = routes["SS Clean the Streets Level 16"].roads,
      [7] = routes["SS Clean the Streets Level 17"].roads,
      [8] = routes["SS Clean the Streets Level 18"].roads,
      [9] = routes["SS Clean the Streets Level 19"].roads,
      [10] = routes["SS Clean the Streets Level 20"].roads
    }
    spawnPosition.routeNames = {
      [1] = "SS Clean the Streets Level 11",
      [2] = "SS Clean the Streets Level 12",
      [3] = "SS Clean the Streets Level 13",
      [4] = "SS Clean the Streets Level 14",
      [5] = "SS Clean the Streets Level 15",
      [6] = "SS Clean the Streets Level 16",
      [7] = "SS Clean the Streets Level 17",
      [8] = "SS Clean the Streets Level 18",
      [9] = "SS Clean the Streets Level 19",
      [10] = "SS Clean the Streets Level 20"
    }
  end,
  [3] = function(spawnPosition)
    spawnPosition.target = routes["SS Clean the Streets Start 21"].checkpoints[1].position
    spawnPosition.positionA = routes["SS Clean the Streets Start 21"].checkpoints[1].position
    spawnPosition.headingA = routes["SS Clean the Streets Start 21"].checkpoints[1].heading
    spawnPosition.spawnPositions = {
      [1] = {
        pos = routes["SS Clean the Streets Level 21"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 21"].checkpoints[1].heading
      },
      [2] = {
        pos = routes["SS Clean the Streets Level 22"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 22"].checkpoints[1].heading
      },
      [3] = {
        pos = routes["SS Clean the Streets Level 23"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 23"].checkpoints[1].heading
      },
      [4] = {
        pos = routes["SS Clean the Streets Level 24"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 24"].checkpoints[1].heading
      },
      [5] = {
        pos = routes["SS Clean the Streets Level 25"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 25"].checkpoints[1].heading
      },
      [6] = {
        pos = routes["SS Clean the Streets Level 26"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 26"].checkpoints[1].heading
      },
      [7] = {
        pos = routes["SS Clean the Streets Level 27"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 27"].checkpoints[1].heading
      },
      [8] = {
        pos = routes["SS Clean the Streets Level 28"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 28"].checkpoints[1].heading
      },
      [9] = {
        pos = routes["SS Clean the Streets Level 29"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 29"].checkpoints[1].heading
      },
      [10] = {
        pos = routes["SS Clean the Streets Level 30"].checkpoints[1].position,
        heading = routes["SS Clean the Streets Level 30"].checkpoints[1].heading
      }
    }
    spawnPosition.targetPositions = {
      [1] = routes["SS Clean the Streets Level 21"].checkpoints,
      [2] = routes["SS Clean the Streets Level 22"].checkpoints,
      [3] = routes["SS Clean the Streets Level 23"].checkpoints,
      [4] = routes["SS Clean the Streets Level 24"].checkpoints,
      [5] = routes["SS Clean the Streets Level 25"].checkpoints,
      [6] = routes["SS Clean the Streets Level 26"].checkpoints,
      [7] = routes["SS Clean the Streets Level 27"].checkpoints,
      [8] = routes["SS Clean the Streets Level 28"].checkpoints,
      [9] = routes["SS Clean the Streets Level 29"].checkpoints,
      [10] = routes["SS Clean the Streets Level 30"].checkpoints
    }
    spawnPosition.roads = {
      [1] = routes["SS Clean the Streets Level 21"].roads,
      [2] = routes["SS Clean the Streets Level 22"].roads,
      [3] = routes["SS Clean the Streets Level 23"].roads,
      [4] = routes["SS Clean the Streets Level 24"].roads,
      [5] = routes["SS Clean the Streets Level 25"].roads,
      [6] = routes["SS Clean the Streets Level 26"].roads,
      [7] = routes["SS Clean the Streets Level 27"].roads,
      [8] = routes["SS Clean the Streets Level 28"].roads,
      [9] = routes["SS Clean the Streets Level 29"].roads,
      [10] = routes["SS Clean the Streets Level 30"].roads
    }
    spawnPosition.routeNames = {
      [1] = "SS Clean the Streets Level 21",
      [2] = "SS Clean the Streets Level 22",
      [3] = "SS Clean the Streets Level 23",
      [4] = "SS Clean the Streets Level 24",
      [5] = "SS Clean the Streets Level 25",
      [6] = "SS Clean the Streets Level 26",
      [7] = "SS Clean the Streets Level 27",
      [8] = "SS Clean the Streets Level 28",
      [9] = "SS Clean the Streets Level 29",
      [10] = "SS Clean the Streets Level 30"
    }
  end
}
missionSetupData["Split Screen Clean the Streets"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
  spawnPosition.targetPositions = nil
  spawnPosition.spawnPositions = nil
  spawnPosition.routeNames = nil
  spawnPosition.roads = nil
end
missionSetupData["Split Screen Clean the Streets"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\SplitScreen_CleanTheStreets01.lua",
    playerOneVehicle = {
      vehicleID = playerVehicles[1]
    },
    playerTwoVehicle = {
      vehicleID = playerVehicles[1]
    },
    trafficSet = 8,
    racerVehicles = racerVehicles,
    playerVehicles = playerVehicles,
    spoolableVehicles = {
      [1] = racerVehicles[1],
      [2] = racerVehicles[2],
      [3] = playerVehicles[1],
      [4] = playerVehicles[2]
    },
    moods = {
      [1] = "OnlineDefault",
      [2] = "OnlineDefault",
      [3] = "OnlineLAConnection",
      [4] = "OnlineLAConnection",
      [5] = "OnlineLAConnection"
    }
  },
  [2] = {
    routeName = "RouteData\\SplitScreen_CleanTheStreets02.lua",
    playerOneVehicle = {
      vehicleID = playerVehicles[1]
    },
    playerTwoVehicle = {
      vehicleID = playerVehicles[1]
    },
    trafficSet = 8,
    racerVehicles = racerVehicles,
    playerVehicles = playerVehicles,
    spoolableVehicles = {
      [1] = racerVehicles[1],
      [2] = racerVehicles[2],
      [3] = playerVehicles[1],
      [4] = playerVehicles[2]
    },
    moods = {
      [1] = "OnlineDefault",
      [2] = "OnlineDefault",
      [3] = "OnlineDukes",
      [4] = "OnlineDukes",
      [5] = "OnlineDukes",
      [6] = "OnlineCannonBall"
    }
  },
  [3] = {
    routeName = "RouteData\\SplitScreen_CleanTheStreets03.lua",
    playerOneVehicle = {
      vehicleID = playerVehicles[1]
    },
    playerTwoVehicle = {
      vehicleID = playerVehicles[1]
    },
    trafficSet = 8,
    racerVehicles = racerVehicles,
    playerVehicles = playerVehicles,
    spoolableVehicles = {
      [1] = racerVehicles[1],
      [2] = racerVehicles[2],
      [3] = playerVehicles[1],
      [4] = playerVehicles[2]
    },
    moods = {
      [1] = "OnlineComa",
      [2] = "OnlineDefault",
      [3] = "OnlineDefault",
      [4] = "OnlineVanishing"
    }
  }
}
missionSetupData["Split Screen Clean the Streets"].usableRouteIndicies = {
  [1] = {1},
  [2] = {2},
  [3] = {3}
}
local playerTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "SS Vehicle swap",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player left zap"
            }
          }
        },
        HUD = {
          {
            style = "MP Clean the Streets HUD"
          }
        }
      }
    }
  }
end
local packageTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "SS Mode level data",
        specialName = "score",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "SS Objective team 1 wrecked"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "SS Mode Level equal",
              params = {value = 11}
            }
          }
        }
      }
    }
  }
end
local racerTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "SS Linear Checkpoints",
        specialName = "Checkpoints",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "MP Checkpoint Tracker"
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
      },
      [2] = {
        task = "SS Take Damage",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "SS hit by player"
            }
          }
        }
      }
    }
  }
end
missionSetupData["Split Screen Clean the Streets"].taskCreatorFunctionLookups = {
  ["Objective Team 1"] = racerTasks,
  ["Objective Team 2"] = packageTasks,
  ["Player Pool"] = playerTasks
}
missionSetupData["Split Screen Clean the Streets"].stepHighlightColours = function(instance)
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
missionSetupData["Split Screen Clean the Streets"].missionCompleteData = function(instance)
  local location = phaseManager.playlistSupport.getSelectedLocation()
  assert(location >= 1 and location <= 3, "Mode location not between 1 and 3")
  for i = 1, instance.currentSSLevel - 1 do
    instance.numVehicleDestroyed = instance.numVehicleDestroyed + instance.challenge.settings.numRacersPerLevel[location][i]
  end
  local maxScore = 0
  local location = phaseManager.playlistSupport.getSelectedLocation()
  assert(location >= 1 and location <= 3, "Mode location not between 1 and 3")
  for i, count in ipairs(numberOfRacersPerLevel[location]) do
    maxScore = maxScore + count
  end
  local bronze = 10 / maxScore * 100
  local silver = 14 / maxScore * 100
  local gold = 18 / maxScore * 100
  onlineScreenManager.setSSModeCompDataTable(maxScore, bronze, silver, gold)
  onlineScreenManager.setSSCoopModeCompDataTable(instance.currentSSLevel - 1, 10, instance.numVehicleDestroyed)
end
missionSetupData["Split Screen Clean the Streets"].getPlayerProgress = function(instance)
  local medal = 0
  local level = 0
  local progress = 0
  local objTO = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  level = objTO.namedTasks.score and objTO.namedTasks.score.networkVars.payload - 1 or 0
  progress = level / 10 * 100
  if progress >= 90 then
    medal = 1
  elseif progress >= 70 then
    medal = 2
  elseif progress >= 50 then
    medal = 3
  end
  return level, medal
end
missionSetupData["Split Screen Clean the Streets"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 2,
      spoolStartArea = true,
      gridStyle = 5,
      moodStyle = 2,
      introHUD = "MP Clean the Streets Start HUD",
      teamGame = false,
      modeTimeLimit = 120,
      gridStagger = 0,
      disableZapOnCompletion = true,
      missionVehicleStyle = 5,
      hitRacerForces = cleanTheStreetsHitRacerForce,
      racerLife = cleanTheStreetsRacerLife,
      spawnDistance = 300,
      numRacersPerLevel = numberOfRacersPerLevel,
      maxNumRacers = 4
    }
  }
end
missionSetupData["Split Screen Clean the Streets"].initiate = function(instance)
  instance.currentSSLevel = 1
  for i, checkpoints in ipairs(instance.challenge.spawnPositions[instance.networkVars.routeIndex].targetPositions) do
    for j, checkpoint in ipairs(checkpoints) do
      if j ~= 1 then
        checkpointSystem.createNoneSyncronisedCheckpoint(instance.instanceID, i, checkpoint)
      end
    end
  end
  local package = packageManager.createPackage(false, vec.vector(0, 0, 0, 1), true, 0, nil, nil, nil, nil, 0, true)
  instance:newActorFromAgent(OBJ_TEAM_TWO_STRING_TABLE[1], package)
end
local swapFinishedCallback = function(gameVehicle)
  for playerID, player in next, localPlayerManager.players, nil do
    if player.currentVehicle and player.currentVehicle.gameVehicle == gameVehicle then
      player.currentVehicle:activateSiren()
    end
  end
end
missionSetupData["Split Screen Clean the Streets"].missionStart = function(instance)
  local location = phaseManager.playlistSupport.getSelectedLocation()
  assert(location >= 1 and location <= 3, "Mode location not between 1 and 3")
  local spawnVehicles = {}
  for i = 1, instance.challenge.settings.numRacersPerLevel[location][1] do
    table.insert(spawnVehicles, {
      modelID = instance.challenge.spawnPositions[instance.networkVars.routeIndex].racerVehicles[1],
      shaderParams = {
        [0] = framework.random(0, 5)
      }
    })
  end
  local spawnData = {
    type = "Grid",
    position = instance.challenge.spawnPositions[instance.networkVars.routeIndex].spawnPositions[1].pos,
    gridSpacing = 10,
    vehicles = spawnVehicles,
    heading = instance.challenge.spawnPositions[instance.networkVars.routeIndex].spawnPositions[1].heading,
    gridMaxVehicles = instance.challenge.settings.numRacersPerLevel[location][1],
    staggeredGridSpacing = 0
  }
  local grid = Spawn.Spawn(spawnData)
  local vehicle, racerTaskObject
  for i = 1, instance.challenge.settings.numRacersPerLevel[location][1] do
    vehicle = vehicleManager.takeOwnership({
      gameVehicle = grid[i]
    })
    racerTaskObject = instance:newActorFromAgent(OBJ_TEAM_ONE_STRING_TABLE[i], vehicle)
    checkpointTracker.addTracker(racerTaskObject, racerTaskObject.coreData.agent.gameVehicle)
    GameVehicleResource.setInfiniteMass(vehicle.gameVehicle, true)
    vehicle:set_damageMultiplier(0)
  end
  zap.zapSwap.setSwapFinishedCallback(swapFinishedCallback)
  for playerID, player in next, localPlayerManager.players, nil do
    if player.currentVehicle then
      player.currentVehicle:activateSiren()
    end
  end
  local objOneTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local objTwoTO = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  local objOneVehicle = objOneTO.coreData.agent
  MPZapToAction.setZapToAction(1, objOneVehicle)
  objTwoTO.zapToActionTarget = objOneTO.coreData.taskObjectID
end
missionSetupData["Split Screen Clean the Streets"].modeReadyCheck = function(instance)
  return true
end
missionSetupData["Split Screen Clean the Streets"].update = function(instance)
end
missionSetupData["Split Screen Clean the Streets"].missionEnd = function(instance)
  zap.zapSwap.setSwapFinishedCallback(false)
end
taskCompleteData["Split Screen Clean the Streets"] = {}
taskCompleteData["Split Screen Clean the Streets"].taskComplete = function(taskObject, task)
  if task.taskName == "SS Mode level data" or task.taskName == "SS Linear Checkpoints" then
    task.instance.numVehicleDestroyed = 0
    if task.instance.currentSSLevel < 11 then
      for i = 1, task.instance.challenge.settings.maxNumRacers do
        racer = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
        if taskSystem.validTaskObject(racer) and 1 <= racer.coreData.agent.damage then
          task.instance.numVehicleDestroyed = task.instance.numVehicleDestroyed + 1
        end
      end
    end
    MPZapToAction.reset()
    task.instance:initiateOverTimePhase()
  end
end
local getRacerDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(task.instance.instanceID, task.instance.currentSSLevel)
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
missionSetupData["Split Screen Clean the Streets"].targetList = {
  ["Objective Team 1"] = getRacerDynamicTargets
}
