module("cardSystem.logic")
missionSetupData["Multiplayer pure race"] = {}
missionSetupData["Multiplayer pure race"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.roads = routes["Pure Race 01"].roads
    spawnPosition.arrows = routes["Pure Race 01"].arrows
    spawnPosition.route = routes["Pure Race 01"].checkpoints
    spawnPosition.target = routes["Pure Race Start 01"].checkpoints[1].position
    spawnPosition.positionA = routes["Pure Race Start 01"].checkpoints[1].position
    spawnPosition.headingA = routes["Pure Race Start 01"].checkpoints[1].heading
  end,
  [2] = function(spawnPosition)
    spawnPosition.roads = routes["Pure Race 02"].roads
    spawnPosition.arrows = routes["Pure Race 02"].arrows
    spawnPosition.route = routes["Pure Race 02"].checkpoints
    spawnPosition.target = routes["Pure Race Start 02"].checkpoints[1].position
    spawnPosition.positionA = routes["Pure Race Start 02"].checkpoints[1].position
    spawnPosition.headingA = routes["Pure Race Start 02"].checkpoints[1].heading
  end,
  [3] = function(spawnPosition)
    spawnPosition.roads = routes["Pure Race 03"].roads
    spawnPosition.arrows = routes["Pure Race 03"].arrows
    spawnPosition.route = routes["Pure Race 03"].checkpoints
    spawnPosition.target = routes["Pure Race Start 03"].checkpoints[1].position
    spawnPosition.positionA = routes["Pure Race Start 03"].checkpoints[1].position
    spawnPosition.headingA = routes["Pure Race Start 03"].checkpoints[1].heading
  end,
  [4] = function(spawnPosition)
    spawnPosition.roads = routes["Pure Race 04"].roads
    spawnPosition.arrows = routes["Pure Race 04"].arrows
    spawnPosition.route = routes["Pure Race 04"].checkpoints
    spawnPosition.target = routes["Pure Race Start 04"].checkpoints[1].position
    spawnPosition.positionA = routes["Pure Race Start 04"].checkpoints[1].position
    spawnPosition.headingA = routes["Pure Race Start 04"].checkpoints[1].heading
  end,
  [5] = function(spawnPosition)
    spawnPosition.roads = routes["Pure Race 05"].roads
    spawnPosition.arrows = routes["Pure Race 05"].arrows
    spawnPosition.route = routes["Pure Race 05"].checkpoints
    spawnPosition.target = routes["Pure Race Start 05"].checkpoints[1].position
    spawnPosition.positionA = routes["Pure Race Start 05"].checkpoints[1].position
    spawnPosition.headingA = routes["Pure Race Start 05"].checkpoints[1].heading
  end,
  [6] = function(spawnPosition)
    spawnPosition.roads = routes["Pure Race 06"].roads
    spawnPosition.arrows = routes["Pure Race 06"].arrows
    spawnPosition.route = routes["Pure Race 06"].checkpoints
    spawnPosition.target = routes["Pure Race Start 06"].checkpoints[1].position
    spawnPosition.positionA = routes["Pure Race Start 06"].checkpoints[1].position
    spawnPosition.headingA = routes["Pure Race Start 06"].checkpoints[1].heading
  end,
  [7] = function(spawnPosition)
    spawnPosition.roads = routes["Pure Race 07"].roads
    spawnPosition.arrows = routes["Pure Race 07"].arrows
    spawnPosition.route = routes["Pure Race 07"].checkpoints
    spawnPosition.target = routes["Pure Race Start 07"].checkpoints[1].position
    spawnPosition.positionA = routes["Pure Race Start 07"].checkpoints[1].position
    spawnPosition.headingA = routes["Pure Race Start 07"].checkpoints[1].heading
  end,
  [8] = function(spawnPosition)
    spawnPosition.roads = routes["Pure Race 08"].roads
    spawnPosition.arrows = routes["Pure Race 08"].arrows
    spawnPosition.route = routes["Pure Race 08"].checkpoints
    spawnPosition.target = routes["Pure Race Start 08"].checkpoints[1].position
    spawnPosition.positionA = routes["Pure Race Start 08"].checkpoints[1].position
    spawnPosition.headingA = routes["Pure Race Start 08"].checkpoints[1].heading
  end,
  [9] = function(spawnPosition)
    spawnPosition.roads = routes["Pure Race 09"].roads
    spawnPosition.arrows = routes["Pure Race 09"].arrows
    spawnPosition.route = routes["Pure Race 09"].checkpoints
    spawnPosition.target = routes["Pure Race Start 09"].checkpoints[1].position
    spawnPosition.positionA = routes["Pure Race Start 09"].checkpoints[1].position
    spawnPosition.headingA = routes["Pure Race Start 09"].checkpoints[1].heading
  end
}
missionSetupData["Multiplayer pure race"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.roads = nil
  spawnPosition.arrows = nil
  spawnPosition.route = nil
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
end
missionSetupData["Multiplayer pure race"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\MP_PureRace01.lua",
    lockingZoneData = {
      name = "Online_PureRace01",
      drawDistance = 30
    },
    propData = {name = "PureRace01"},
    vehicleSet = OnlineModeSettings.vehicleTypeMixed,
    moods = OnlineModeSettings.onlineMoodsSuburbs1,
    trafficSet = 1
  },
  [2] = {
    routeName = "RouteData\\MP_PureRace02.lua",
    lockingZoneData = {
      name = "Online_PureRace02",
      drawDistance = 30
    },
    propData = {name = "PureRace02"},
    vehicleSet = OnlineModeSettings.vehicleTypePureRally,
    moods = OnlineModeSettings.onlineMoodsNatural1,
    trafficSet = 1
  },
  [3] = {
    routeName = "RouteData\\MP_PureRace03.lua",
    lockingZoneData = {
      name = "Online_PureRace03",
      drawDistance = 30
    },
    propData = {name = "PureRace03"},
    vehicleSet = OnlineModeSettings.vehicleTypeMixed02,
    moods = OnlineModeSettings.onlineMoodsSuburbs2,
    trafficSet = 1
  },
  [4] = {
    routeName = "RouteData\\MP_PureRace04.lua",
    lockingZoneData = {
      name = "Online_PureRace04",
      drawDistance = 30
    },
    propData = {name = "PureRace04"},
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsDowntown1,
    trafficSet = 3
  },
  [5] = {
    routeName = "RouteData\\MP_PureRace05.lua",
    lockingZoneData = {
      name = "Online_PureRace05",
      drawDistance = 30
    },
    propData = {name = "PureRace05"},
    vehicleSet = OnlineModeSettings.vehicleTypeMixedRally,
    moods = OnlineModeSettings.onlineMoodsMarin,
    trafficSet = 1
  },
  [6] = {
    routeName = "RouteData\\MP_PureRace06.lua",
    lockingZoneData = {
      name = "Online_PureRace06",
      drawDistance = 30
    },
    propData = {name = "PureRace06"},
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsDowntown2,
    trafficSet = 1
  },
  [7] = {
    routeName = "RouteData\\MP_PureRace07.lua",
    lockingZoneData = {
      name = "Online_PureRace07",
      drawDistance = 30
    },
    propData = {name = "PureRace07"},
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsMarin,
    trafficSet = 3
  },
  [8] = {
    routeName = "RouteData\\MP_PureRace08.lua",
    lockingZoneData = {
      name = "Online_PureRace08",
      drawDistance = 30
    },
    propData = {name = "PureRace08"},
    vehicleSet = OnlineModeSettings.vehicleTypePureRally,
    moods = OnlineModeSettings.onlineMoodsNatural2,
    trafficSet = 1
  },
  [9] = {
    routeName = "RouteData\\MP_PureRace09.lua",
    lockingZoneData = {
      name = "Online_PureRace09",
      drawDistance = 30
    },
    propData = {name = "PureRace09"},
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsSuburbFog,
    trafficSet = 1
  }
}
missionSetupData["Multiplayer pure race"].usableRouteIndicies = {
  [1] = {8, 2},
  [2] = {
    1,
    6,
    9
  },
  [3] = {5, 3},
  [4] = {
    1,
    2,
    3,
    4,
    5,
    8,
    9
  }
}
ssPureRaceLapCount = 0
local playerTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "No target",
        HUD = {
          {
            style = "MP Pure Race HUD"
          }
        }
      }
    }
  }
end
local vehicleTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "Linear Checkpoints No AI",
        specialName = "checkpoints",
        dynamicTargets = true,
        coreData = {totalLaps = ssPureRaceLapCount},
        goalConditions = {
          {
            {
              goal = "MP Crossed Checkpoint"
            },
            {
              goal = "SS race score event",
              params = {numCheckpoints = 10}
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
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Checkpoint Gate"] = {
                  showAsLaps = true,
                  noneSyncronisedCheckpoint = true,
                  dontShowTrackingMarker = true,
                  multiplayerRace = true
                }
              }
            }
          }
        }
      }
    }
  }
end
missionSetupData["Multiplayer pure race"].taskCreatorFunctionLookups = {
  ["Objective Team 1"] = vehicleTasks,
  ["Player Pool"] = playerTasks
}
missionSetupData["Multiplayer pure race"].stepHighlightColours = function(instance)
  if not instance.playersColours then
    instance.playersColours = true
    Menu.SetPlayerColour(0, OnlineModeSettings.blue128)
    Menu.SetPlayerColour(1, OnlineModeSettings.orange128)
  end
end
missionSetupData["Multiplayer pure race"].missionCompleteData = function()
  if localPlayer.getTaskObject() and localPlayer.getTaskObject().coreData then
    local instance = localPlayer.getTaskObject().coreData.instance
    if instance then
      if onlineRaceManager.getPlayerRank(localPlayer.playerID) == 1 then
        onlineProgressionSystem.progressionMissionComplete(true)
        onlineStatistics.updateWinStatistic(1)
      else
        onlineProgressionSystem.progressionMissionComplete(false)
        onlineStatistics.updateLossStatistic(1)
      end
      onlineScreenManager.setRaceCompleteData(true)
      local numCheckPoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
      onlineScreenManager.setSSModeCompDataTable(numCheckPoints, 60, 75, 90, true)
      for i = 1, 8 do
        local taskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
        if taskObject and taskObject.namedTasks.checkpoints then
          onlineScreenManager.updatePlayerScore(i - 1, taskObject.namedTasks.checkpoints.networkVars.checkpoints - 1 + taskObject.namedTasks.checkpoints.networkVars.laps * numCheckPoints)
          onlineScreenManager.updatePlayerSecondaryScore(i - 1, onlineRaceManager.getPlayerRank(i - 1))
        end
      end
    end
  end
end
missionSetupData["Multiplayer pure race"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 2,
      spoolStartArea = true,
      gridStyle = 1,
      missionVehicleStyle = 1,
      moodStyle = 2,
      introHUD = "MP Pure Race Start HUD",
      raceMode = true,
      zapLock = true,
      disableZapOnCompletion = true,
      modeTimeLimit = mpPureRaceTimeLimit,
      totalLaps = ssPureRaceLapCount,
      gridStagger = 0
    }
  }
end
missionSetupData["Multiplayer pure race"].assignTaskObjects = function(instance, player, vehicle)
  if player then
    local actor = instance.challenge.actorPool[OBJ_TEAM_ONE_STRING_TABLE[player.playerID + 1]]
    instance:newActorFromAgent(actor.ID, vehicle)
  else
    for playerID, player in next, playerManager.players, nil do
      if not instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[playerID + 1]] then
        local vehicle = vehicleManager.vehiclesBySNVID[phaseManager.vehicleGrid[playerID + 1]]
        assert(vehicle.networkVars.onlineOwnerID == playerID, "PURE RACE, Creating taskObject for invalid vehicle")
        local actor = instance.challenge.actorPool[OBJ_TEAM_ONE_STRING_TABLE[playerID + 1]]
        instance:newActorFromAgent(actor.ID, vehicle)
      end
    end
  end
end
missionSetupData["Multiplayer pure race"].missionEnd = function(instance)
  removeUserUpdateFunction("setNewPlayerVehicleMaxDamage")
  feedbackSystem.menusMaster.blockDamageBar(localPlayerManager.players[0], false)
  feedbackSystem.menusMaster.blockDamageBar(localPlayerManager.players[1], false)
end
missionSetupData["Multiplayer pure race"].missionStart = function(instance)
  if not instance.missionStartCalled then
    local routeIndex = instance.networkVars.routeIndex
    local route = instance.challenge.spawnPositions[routeIndex].route
    checkpointSystem.clearNoneSyncronisedCheckpoint()
    for i, checkpointData in ipairs(route) do
      checkpointSystem.createNoneSyncronisedCheckpoint(instance.instanceID, 1, checkpointData)
    end
  end
  for localPlayerID, player in next, localPlayerManager.players, nil do
    player.currentVehicle.gameVehicle.maxAllowedDamage = 0.74
    if localPlayerID == 0 then
      player.currentVehicle:setDisplayColour(OnlineModeSettings.blue32, OnlineModeSettings.blue128)
    else
      player.currentVehicle:setDisplayColour(OnlineModeSettings.orange32, OnlineModeSettings.orange128)
    end
  end
  instance.missionStartCalled = true
end
missionSetupData["Multiplayer pure race"].modeReadyCheck = function(instance)
  for playerID, player in next, playerManager.players, nil do
    local racerTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[playerID + 1]]
    if not racerTO then
      return false
    end
    if racerTO and not racerTO.coreData.agent then
      return false
    end
  end
  return true
end
missionSetupData["Multiplayer pure race"].update = function(instance)
  for i = 1, 8 do
    local taskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
    if taskObject and not playerManager.players[i - 1] and taskObject.coreData.isLocal and taskObject:canBeDeleted() then
      taskObject:delete()
    end
  end
  onlineProgressionSystem.progressionUpdate()
end
taskCompleteData["Multiplayer pure race"] = {}
taskCompleteData["Multiplayer pure race"].taskComplete = function(taskObject, task)
  if task.taskName == "Linear Checkpoints No AI" then
    onlineRaceManager.sendLockPlayersPosition()
    local raceCompleted = false
    for i = 1, 8 do
      local objTO = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
      if objTO and objTO.namedTasks.checkpoints and objTO.namedTasks.checkpoints.networkVars.laps > objTO.namedTasks.checkpoints.coreData.totalLaps then
        raceCompleted = true
        break
      end
    end
    if task.taskName == "Linear Checkpoints No AI" and task.condition == 2 and not raceCompleted then
      phaseManager.modeTimedOut = true
    else
      phaseManager.modeTimedOut = false
    end
    scoreSystem.stopAbilityDrain(localPlayer.localID, false)
    if taskObject.coreData.instance.isLocal then
      taskObject.coreData.instance:initiateOverTimePhase()
    end
  end
end
local getRaceVehicleDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(taskObject.coreData.instance.instanceID, 1)
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
missionSetupData["Multiplayer pure race"].targetList = {
  ["Objective Team 1"] = getRaceVehicleDynamicTargets
}
