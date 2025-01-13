module("cardSystem.logic")
missionSetupData["Split Screen Go the Distance"] = {}
local goTheDistanceFuelDepletionTickRate = 0.2
local goTheDistanceFuelReplenishTickRate = 0.2
local inTrailsSpeedUpdateRate = 0.5
local maxBonusSpeed = 12
local outTrailsSpeedDecrease = 4
local inTrailsSpeedIncrease = 1.7
local goTheDistanceFuelDepletionRates = {
  [1] = {
    [1] = 0.7,
    [2] = 1,
    [3] = 1.35,
    [4] = 1.65,
    [5] = 1.7,
    [6] = 1.75,
    [7] = 1.8,
    [8] = 1.85,
    [9] = 1.9,
    [10] = 2
  },
  [2] = {
    [1] = 0.95,
    [2] = 1,
    [3] = 1.35,
    [4] = 1.65,
    [5] = 1.7,
    [6] = 1.75,
    [7] = 1.8,
    [8] = 1.85,
    [9] = 1.9,
    [10] = 2
  },
  [3] = {
    [1] = 0.7,
    [2] = 1,
    [3] = 1.35,
    [4] = 1.65,
    [5] = 1.7,
    [6] = 1.75,
    [7] = 1.8,
    [8] = 1.85,
    [9] = 1.9,
    [10] = 2
  }
}
local goTheDistanceFuelReplenishRates = {
  [1] = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0,
    [8] = 0,
    [9] = 0,
    [10] = 0
  },
  [2] = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0,
    [8] = 0,
    [9] = 0,
    [10] = 0
  },
  [3] = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0,
    [8] = 0,
    [9] = 0,
    [10] = 0
  }
}
local goTheDistancePlayerVehicleFuel = {
  [1] = {
    [1] = 150,
    [2] = 100,
    [3] = 125,
    [4] = 125,
    [5] = 125,
    [6] = 125,
    [7] = 125,
    [8] = 100,
    [9] = 100,
    [10] = 100
  },
  [2] = {
    [1] = 150,
    [2] = 100,
    [3] = 125,
    [4] = 125,
    [5] = 125,
    [6] = 125,
    [7] = 125,
    [8] = 100,
    [9] = 100,
    [10] = 100
  },
  [3] = {
    [1] = 150,
    [2] = 100,
    [3] = 125,
    [4] = 125,
    [5] = 125,
    [6] = 125,
    [7] = 125,
    [8] = 100,
    [9] = 100,
    [10] = 100
  }
}
local goTheDistanceTrailLengths = {
  [1] = {
    [1] = 2,
    [2] = 2,
    [3] = 1.9,
    [4] = 1.9,
    [5] = 1.8,
    [6] = 1.8,
    [7] = 1.7,
    [8] = 1.7,
    [9] = 1.6,
    [10] = 1.5
  },
  [2] = {
    [1] = 2,
    [2] = 2,
    [3] = 1.9,
    [4] = 1.9,
    [5] = 1.8,
    [6] = 1.8,
    [7] = 1.7,
    [8] = 1.7,
    [9] = 1.6,
    [10] = 1.5
  },
  [3] = {
    [1] = 2,
    [2] = 2,
    [3] = 1.9,
    [4] = 1.9,
    [5] = 1.8,
    [6] = 1.8,
    [7] = 1.7,
    [8] = 1.7,
    [9] = 1.6,
    [10] = 1.5
  }
}
local goTheDistanceFuelBonus = {
  [1] = {
    [1] = 100,
    [2] = 90,
    [3] = 85,
    [4] = 80,
    [5] = 75,
    [6] = 70,
    [7] = 65,
    [8] = 55,
    [9] = 45,
    [10] = 40
  },
  [2] = {
    [1] = 100,
    [2] = 90,
    [3] = 85,
    [4] = 80,
    [5] = 75,
    [6] = 70,
    [7] = 65,
    [8] = 55,
    [9] = 45,
    [10] = 40
  },
  [3] = {
    [1] = 100,
    [2] = 90,
    [3] = 85,
    [4] = 80,
    [5] = 75,
    [6] = 70,
    [7] = 65,
    [8] = 55,
    [9] = 45,
    [10] = 40
  }
}
missionSetupData["Split Screen Go the Distance"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.target = routes["SS Go the Distance Start 01"].checkpoints[1].position
    spawnPosition.positionA = routes["SS Go the Distance Start 01"].checkpoints[1].position
    spawnPosition.headingA = routes["SS Go the Distance Start 01"].checkpoints[1].heading
    spawnPosition.startPos = routes["SS Go the Distance Start 01"].checkpoints[2]
    spawnPosition.startPosB = routes["SS Go the Distance Start 01"].arrows[1].position
    spawnPosition.vehicleSet = OnlineModeSettings.vehicleTypeRoad
    spawnPosition.trafficSet = 3
    spawnPosition.roads = {
      [1] = routes["SS Go the Distance 01"].roads,
      [2] = routes["SS Go the Distance 02"].roads,
      [3] = routes["SS Go the Distance 03"].roads,
      [4] = routes["SS Go the Distance 04"].roads,
      [5] = routes["SS Go the Distance 05"].roads,
      [6] = routes["SS Go the Distance 06"].roads,
      [7] = routes["SS Go the Distance 07"].roads,
      [8] = routes["SS Go the Distance 08"].roads,
      [9] = routes["SS Go the Distance 09"].roads,
      [10] = routes["SS Go the Distance 10"].roads
    }
    spawnPosition.routes = {
      [1] = routes["SS Go the Distance 01"].checkpoints,
      [2] = routes["SS Go the Distance 02"].checkpoints,
      [3] = routes["SS Go the Distance 03"].checkpoints,
      [4] = routes["SS Go the Distance 04"].checkpoints,
      [5] = routes["SS Go the Distance 05"].checkpoints,
      [6] = routes["SS Go the Distance 06"].checkpoints,
      [7] = routes["SS Go the Distance 07"].checkpoints,
      [8] = routes["SS Go the Distance 08"].checkpoints,
      [9] = routes["SS Go the Distance 09"].checkpoints,
      [10] = routes["SS Go the Distance 10"].checkpoints
    }
    spawnPosition.routeNames = {
      [1] = "SS Go the Distance 01",
      [2] = "SS Go the Distance 02",
      [3] = "SS Go the Distance 03",
      [4] = "SS Go the Distance 04",
      [5] = "SS Go the Distance 05",
      [6] = "SS Go the Distance 06",
      [7] = "SS Go the Distance 07",
      [8] = "SS Go the Distance 08",
      [9] = "SS Go the Distance 09",
      [10] = "SS Go the Distance 10"
    }
  end,
  [2] = function(spawnPosition)
    spawnPosition.target = routes["SS Go the Distance Start 11"].checkpoints[1].position
    spawnPosition.positionA = routes["SS Go the Distance Start 11"].checkpoints[1].position
    spawnPosition.headingA = routes["SS Go the Distance Start 11"].checkpoints[1].heading
    spawnPosition.startPos = routes["SS Go the Distance Start 11"].checkpoints[2]
    spawnPosition.startPosB = routes["SS Go the Distance Start 11"].arrows[1].position
    spawnPosition.vehicleSet = OnlineModeSettings.vehicleTypeRoad
    spawnPosition.trafficSet = 3
    spawnPosition.roads = {
      [1] = routes["SS Go the Distance 11"].roads,
      [2] = routes["SS Go the Distance 12"].roads,
      [3] = routes["SS Go the Distance 13"].roads,
      [4] = routes["SS Go the Distance 14"].roads,
      [5] = routes["SS Go the Distance 15"].roads,
      [6] = routes["SS Go the Distance 16"].roads,
      [7] = routes["SS Go the Distance 17"].roads,
      [8] = routes["SS Go the Distance 18"].roads,
      [9] = routes["SS Go the Distance 19"].roads,
      [10] = routes["SS Go the Distance 20"].roads
    }
    spawnPosition.routes = {
      [1] = routes["SS Go the Distance 11"].checkpoints,
      [2] = routes["SS Go the Distance 12"].checkpoints,
      [3] = routes["SS Go the Distance 13"].checkpoints,
      [4] = routes["SS Go the Distance 14"].checkpoints,
      [5] = routes["SS Go the Distance 15"].checkpoints,
      [6] = routes["SS Go the Distance 16"].checkpoints,
      [7] = routes["SS Go the Distance 17"].checkpoints,
      [8] = routes["SS Go the Distance 18"].checkpoints,
      [9] = routes["SS Go the Distance 19"].checkpoints,
      [10] = routes["SS Go the Distance 20"].checkpoints
    }
    spawnPosition.routeNames = {
      [1] = "SS Go the Distance 11",
      [2] = "SS Go the Distance 12",
      [3] = "SS Go the Distance 13",
      [4] = "SS Go the Distance 14",
      [5] = "SS Go the Distance 15",
      [6] = "SS Go the Distance 16",
      [7] = "SS Go the Distance 17",
      [8] = "SS Go the Distance 18",
      [9] = "SS Go the Distance 19",
      [10] = "SS Go the Distance 20"
    }
  end,
  [3] = function(spawnPosition)
    spawnPosition.target = routes["SS Go the Distance Start 21"].checkpoints[1].position
    spawnPosition.positionA = routes["SS Go the Distance Start 21"].checkpoints[1].position
    spawnPosition.headingA = routes["SS Go the Distance Start 21"].checkpoints[1].heading
    spawnPosition.startPos = routes["SS Go the Distance Start 21"].checkpoints[2]
    spawnPosition.startPosB = routes["SS Go the Distance Start 21"].arrows[1].position
    spawnPosition.vehicleSet = OnlineModeSettings.vehicleTypeRoad
    spawnPosition.trafficSet = 3
    spawnPosition.roads = {
      [1] = routes["SS Go the Distance 21"].roads,
      [2] = routes["SS Go the Distance 22"].roads,
      [3] = routes["SS Go the Distance 23"].roads,
      [4] = routes["SS Go the Distance 24"].roads,
      [5] = routes["SS Go the Distance 25"].roads,
      [6] = routes["SS Go the Distance 26"].roads,
      [7] = routes["SS Go the Distance 27"].roads,
      [8] = routes["SS Go the Distance 28"].roads,
      [9] = routes["SS Go the Distance 29"].roads,
      [10] = routes["SS Go the Distance 30"].roads
    }
    spawnPosition.routes = {
      [1] = routes["SS Go the Distance 21"].checkpoints,
      [2] = routes["SS Go the Distance 22"].checkpoints,
      [3] = routes["SS Go the Distance 23"].checkpoints,
      [4] = routes["SS Go the Distance 24"].checkpoints,
      [5] = routes["SS Go the Distance 25"].checkpoints,
      [6] = routes["SS Go the Distance 26"].checkpoints,
      [7] = routes["SS Go the Distance 27"].checkpoints,
      [8] = routes["SS Go the Distance 28"].checkpoints,
      [9] = routes["SS Go the Distance 29"].checkpoints,
      [10] = routes["SS Go the Distance 30"].checkpoints
    }
    spawnPosition.routeNames = {
      [1] = "SS Go the Distance 21",
      [2] = "SS Go the Distance 22",
      [3] = "SS Go the Distance 23",
      [4] = "SS Go the Distance 24",
      [5] = "SS Go the Distance 25",
      [6] = "SS Go the Distance 26",
      [7] = "SS Go the Distance 27",
      [8] = "SS Go the Distance 28",
      [9] = "SS Go the Distance 29",
      [10] = "SS Go the Distance 30"
    }
  end
}
missionSetupData["Split Screen Go the Distance"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
  spawnPosition.startPos = nil
  spawnPosition.startPosB = nil
  spawnPosition.vehicleSet = nil
  spawnPosition.trafficSet = nil
  spawnPosition.roads = nil
  spawnPosition.routes = nil
end
missionSetupData["Split Screen Go the Distance"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\SplitScreen_GoTheDistance01.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    trafficSet = 3,
    playerOneVehicle = {
      vehicleID = 62,
      shader = {
        [0] = 0
      }
    },
    playerTwoVehicle = {
      vehicleID = 192,
      shader = {
        [0] = 1
      }
    },
    spoolableVehicles = {
      [1] = 62,
      [2] = 192,
      [3] = 171
    },
    moods = {
      [1] = "OnlineDefault",
      [2] = "OnlineDefault",
      [3] = "OnlineJerichoLite"
    }
  },
  [2] = {
    routeName = "RouteData\\SplitScreen_GoTheDistance02.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    trafficSet = 3,
    playerOneVehicle = {
      vehicleID = 62,
      shader = {
        [0] = 0
      }
    },
    playerTwoVehicle = {
      vehicleID = 192,
      shader = {
        [0] = 1
      }
    },
    spoolableVehicles = {
      [1] = 62,
      [2] = 192,
      [3] = 171
    },
    moods = {
      [1] = "OnlineDefault",
      [2] = "OnlineDefault",
      [3] = "OnlineTheDriver"
    }
  },
  [3] = {
    routeName = "RouteData\\SplitScreen_GoTheDistance03.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    trafficSet = 3,
    playerOneVehicle = {
      vehicleID = 62,
      shader = {
        [0] = 0
      }
    },
    playerTwoVehicle = {
      vehicleID = 192,
      shader = {
        [0] = 1
      }
    },
    spoolableVehicles = {
      [1] = 62,
      [2] = 192,
      [3] = 171
    },
    moods = {
      [1] = "OnlineDefault",
      [2] = "OnlineVanishing",
      [3] = "OnlineVanishing",
      [4] = "OnlineComa"
    }
  }
}
missionSetupData["Split Screen Go the Distance"].usableRouteIndicies = {
  [1] = {1},
  [2] = {2},
  [3] = {3}
}
local function playerTasks(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "SS Charge Blazing Vehicle",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "SS Player in shift",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = goTheDistanceFuelReplenishTickRate}
            },
            {
              goal = "SS Player vehicle wrecked",
              params = {value = false}
            },
            {
              goal = "SS Within blaze"
            }
          },
          {
            autoRefresh = true,
            {
              goal = "SS Player in shift",
              params = {value = false}
            },
            {
              goal = "SS Player in vehicle with no fuel"
            },
            {
              goal = "SS Player vehicle wrecked",
              params = {value = false}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "SS Player in shift status changed",
              params = {value = false}
            },
            {
              goal = "SS Player in shift status changed",
              params = {value = true}
            }
          }
        },
        HUD = {
          {
            style = "SS Go the Distance HUD"
          }
        }
      }
    }
  }
end
local function trailBlazerTasks(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "Linear Follow Route",
        specialName = "fuel",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "MP Checkpoint Tracker"
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = goTheDistanceFuelDepletionTickRate}
            },
            {
              goal = "No Players in blaze"
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = inTrailsSpeedUpdateRate}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Route index above",
              params = {value = 10}
            }
          },
          {
            {
              goal = "Fuel level greater than or equal",
              params = {value = 0}
            }
          }
        }
      }
    }
  }
end
missionSetupData["Split Screen Go the Distance"].taskCreatorFunctionLookups = {
  ["Objective Team 1"] = trailBlazerTasks,
  ["Player Pool"] = playerTasks
}
missionSetupData["Split Screen Go the Distance"].stepHighlightColours = function(instance)
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
missionSetupData["Split Screen Go the Distance"].missionCompleteData = function(instance)
  onlineScreenManager.setSSModeCompDataTable(10, 50, 70, 90)
  onlineScreenManager.setSSCoopModeCompDataTable(instance.currentSSLevel - 1, 10, instance.currentSSLevel - 1)
end
missionSetupData["Split Screen Go the Distance"].getPlayerProgress = function(instance)
  local medal = 0
  local level = 0
  local progress = 0
  local objTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  if objTO ~= nil then
    level = objTO.namedTasks.fuel and objTO.namedTasks.fuel.networkVars.routeIndex - 1 or 0
    progress = level / 10 * 100
    if progress >= 90 then
      medal = 1
    elseif progress >= 70 then
      medal = 2
    elseif progress >= 50 then
      medal = 3
    end
  end
  return level, medal
end
missionSetupData["Split Screen Go the Distance"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 2,
      spoolStartArea = true,
      gridStyle = 5,
      missionVehicleStyle = 5,
      moodStyle = 2,
      introHUD = "SS Go the Distance Start HUD",
      teamGame = false,
      gridStagger = 0,
      disableZapOnCompletion = true,
      fuelDepletionRates = goTheDistanceFuelDepletionRates,
      fuelReplenishRates = goTheDistanceFuelReplenishRates,
      playerVehicleFuel = goTheDistancePlayerVehicleFuel,
      trailLengths = goTheDistanceTrailLengths,
      fuelBonus = goTheDistanceFuelBonus,
      gridStagger = 0,
      maxBonusSpeed = maxBonusSpeed,
      outTrailsSpeedDecrease = outTrailsSpeedDecrease,
      inTrailsSpeedIncrease = inTrailsSpeedIncrease
    }
  }
end
missionSetupData["Split Screen Go the Distance"].initiate = function(instance)
  instance.currentSSLevel = 1
  checkpointSystem.clearNoneSyncronisedCheckpoint()
  for i = 1, 10 do
    for j, checkpointData in ipairs(instance.challenge.spawnPositions[instance.networkVars.routeIndex].routes[i]) do
      checkpointSystem.createNoneSyncronisedCheckpoint(instance.instanceID, i, checkpointData)
    end
  end
  local trailBlazerVehicle = vehicleManager.spawnVehicle({
    position = instance.challenge.spawnPositions[instance.networkVars.routeIndex].startPosB,
    heading = instance.challenge.spawnPositions[instance.networkVars.routeIndex].startPos.heading,
    modelID = 171,
    shader = {
      [0] = 0
    }
  })
  GameVehicleResource.setInfiniteMass(trailBlazerVehicle.gameVehicle, true)
  instance:newActorFromAgent(OBJ_TEAM_ONE_STRING_TABLE[1], trailBlazerVehicle)
end
missionSetupData["Split Screen Go the Distance"].missionStart = function(instance)
  local trailTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local trailVehicle = trailTO.coreData.agent
  MPZapToAction.setZapToAction(1, trailVehicle)
  checkpointTracker.addTracker(trailTO, trailVehicle.gameVehicle)
end
missionSetupData["Split Screen Go the Distance"].modeReadyCheck = function(instance)
  return true
end
missionSetupData["Split Screen Go the Distance"].update = function(instance)
end
taskCompleteData["Split Screen Go the Distance"] = {}
taskCompleteData["Split Screen Go the Distance"].taskComplete = function(taskObject, task)
  if task.taskName == "Linear Follow Route" then
    MPZapToAction.reset()
    task.instance:initiateOverTimePhase()
  end
end
local getTrailBlazerDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    if task.networkVars.routeIndex ~= 10 then
      local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(taskObject.coreData.instance.instanceID, task.networkVars.routeIndex + 1)
      return {
        allCheckpoints[#allCheckpoints]
      }, true
    else
      return false, true
    end
  else
    local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(taskObject.coreData.instance.instanceID, task.networkVars.routeIndex)
    return {
      allCheckpoints[#allCheckpoints]
    }, false
  end
end
missionSetupData["Split Screen Go the Distance"].targetList = {
  ["Objective Team 1"] = getTrailBlazerDynamicTargets
}
