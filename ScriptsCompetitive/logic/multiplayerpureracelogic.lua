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
  end,
  [10] = function(spawnPosition)
    spawnPosition.roads = routes["Online Test Route"].roads
    spawnPosition.route = routes["Online Test Route"].checkpoints
    spawnPosition.target = routes["Online Test Route Start"].checkpoints[1].position
    spawnPosition.positionA = routes["Online Test Route Start"].checkpoints[1].position
    spawnPosition.headingA = routes["Online Test Route Start"].checkpoints[1].heading
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
    trafficSet = 3,
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(549.0491, 5.998573, 1434.49, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(728.3087, 5.975, 1367.403, 1),
            length = 150,
            width = 150
          },
          [2] = {
            position = vec.vector(454.2584, 14.20166, 1596.173, 1),
            length = 150,
            width = 150
          }
        }
      }
    }
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
  },
  [10] = {
    routeName = "RouteData\\MP_TestRoute.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsSuburbFog,
    trafficSet = 1
  }
}
missionSetupData["Multiplayer pure race"].usableRouteIndicies = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 7,
  [8] = 8,
  [9] = 9
}
mpPureRaceEndTimeLimit = 5
mpPureRaceTimeLimit = 480
mpPureRaceLapCount = 1
local playerTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "MP race end",
        coreData = {stdRace = true, playerTO = false},
        goalConditions = {
          {
            {
              goal = "MP Player 2 Active",
              params = {value = false}
            },
            {
              goal = "Race finished",
              params = {value = true, playerTO = false}
            },
            {
              goal = "Race end screen set",
              params = {value = false}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "MP Player 2 Active",
              params = {value = false}
            },
            {
              goal = "Race end screen set",
              params = {value = true}
            }
          },
          {
            {
              goal = "MP Player 2 Active",
              params = {value = true}
            },
            {
              goal = "Race finished",
              params = {value = true, playerTO = false}
            }
          }
        },
        HUD = {
          {
            style = "MP Pure Race HUD"
          }
        }
      }
    },
    [2] = {
      [1] = {
        task = "MP race end timer",
        specialName = "overTime",
        goalConditions = {
          {
            {
              goal = "End race timer set",
              params = {value = false}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "End race timer set",
              params = {value = true}
            },
            {
              goal = "End race time above",
              params = {value = mpPureRaceEndTimeLimit}
            }
          },
          {
            {
              goal = "All players finished race",
              params = {playerTO = false}
            }
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
        coreData = {totalLaps = mpPureRaceLapCount},
        goalConditions = {
          {
            {
              goal = "MP Crossed Checkpoint"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {coreValue = "totalLaps"}
            }
          },
          {
            {
              goal = "Instance start time valid"
            },
            {
              goal = "Instance time above",
              params = {value = mpPureRaceTimeLimit}
            }
          },
          {
            {
              goal = "End race timer set",
              params = {value = true}
            },
            {
              goal = "End race time above",
              params = {value = mpPureRaceEndTimeLimit}
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
missionSetupData["Multiplayer pure race"].onlineProgressionData = {
  localPlayer = {
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.classicRaceCheckpointXP,
        completeText = "ID:243727",
        minShowXP = 0,
        groupXP = true,
        groupLimit = 2
      },
      {
        goal = "Checkpoint crossed",
        params = {value = true}
      }
    },
    getMatchBonus = function(timeInMode, threshold, baseXPValue, gainedXP)
      local playerRank = onlineRaceManager.getPlayerRank(localPlayer.playerID)
      local playerScore = 0
      if playerRank and playerRank <= 8 then
        playerScore = onlineProgressionSystem.onlineRaceRankMultiplier[playerRank]
      end
      local matchBonus = timeInMode * baseXPValue * playerScore
      if gainedXP < threshold then
        return math.max(gainedXP / threshold, onlineProgressionSystem.minimumPercentMatchBonus) * matchBonus
      end
      return matchBonus
    end
  }
}
missionSetupData["Multiplayer pure race"].stepHighlightColours = function(instance)
  if not instance.playersColours then
    instance.playersColours = {
      [1] = {playerColourSet = false, ID = -1},
      [2] = {playerColourSet = false, ID = -1},
      [3] = {playerColourSet = false, ID = -1},
      [4] = {playerColourSet = false, ID = -1},
      [5] = {playerColourSet = false, ID = -1},
      [6] = {playerColourSet = false, ID = -1},
      [7] = {playerColourSet = false, ID = -1},
      [8] = {playerColourSet = false, ID = -1}
    }
    for playerID, player in next, playerManager.players, nil do
      Menu.SetPlayerColour(player.playerID, OnlineModeSettings.pink128)
    end
  end
  for playerID, data in next, instance.playersColours, nil do
    if data.ID ~= -1 and (not vehicleManager.vehiclesBySNVID[data.ID] or not playerManager.players[playerID - 1]) then
      data.ID = -1
      data.playerColourSet = false
    end
  end
  for playerID, player in next, playerManager.players, nil do
    if not instance.playersColours[player.playerID + 1].playerColourSet then
      Menu.SetPlayerColour(player.playerID, OnlineModeSettings.red128)
      instance.playersColours[player.playerID + 1].playerColourSet = true
    end
    if player.currentVehicle and playerID ~= localPlayer.playerID then
      if instance.playersColours[player.playerID + 1].ID == -1 then
        instance.playersColours[player.playerID + 1].ID = player.currentVehicle.SNVID
        player.currentVehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
      elseif instance.playersColours[player.playerID + 1].ID ~= player.currentVehicle.SNVID then
        instance.playersColours[player.playerID + 1].ID = player.currentVehicle.SNVID
        player.currentVehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
      end
    end
  end
end
missionSetupData["Multiplayer pure race"].onlineStatisticsData = function()
  local racePosition = onlineRaceManager.getPlayerRank(localPlayer.playerID)
  assert(racePosition and racePosition > 0 and racePosition < 9, "Pure Race Statistic Gen Error: Race position must be between [0,8], value " .. tostring(racePosition))
  local winValue = onlineStatistics.getWinStatistic()
  local lossValue = onlineStatistics.getLossStatistic()
  local specific = onlineStatistics.getSpecificStatistic()
  onlineStatistics.updateSpecificStatistic(specific * -1)
  local numOfRaces = winValue + lossValue
  assert(numOfRaces > 0, "Pure Race Statistic Gen Error: Number of races should be at least 1 as you just completed a Race")
  local positionTotal = specific * (numOfRaces - 1)
  positionTotal = positionTotal + racePosition
  local average = positionTotal / numOfRaces
  assert(average > 0 and average < 9, "Pure Race Statistic Gen Error: average must be between [0,8], value " .. tostring(average))
  onlineStatistics.updateSpecificStatistic(average)
  onlineStatistics.updateScoreStatistic(onlineProgressionSystem.getLocalPlayerXPGained())
end
missionSetupData["Multiplayer pure race"].missionCompleteData = function(instance, syncedScoreTable)
  onlineScreenManager.setRaceCompleteData(true)
  onlineScreenManager.setForceSortType(false)
  for playerID, player in next, playerManager.players, nil do
    assert(syncedScoreTable[playerID], "players score not found in synced score table")
    onlineScreenManager.updatePlayerScore(playerID, syncedScoreTable[playerID])
    onlineScreenManager.updatePlayerSecondaryScore(playerID, onlineRaceManager.getPlayerRank(playerID))
  end
  local localPlayerRank = onlineRaceManager.getPlayerRank(localPlayer.playerID)
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public and localPlayerRank <= 3 then
    local value = ProfileSettings.GetNumPureRaceTopThree() + 1
    ProfileSettings.SetNumPureRaceTopThree(value)
    OnlineAchievements.onValueChange("Pure Race Top 3", value)
  end
  if localPlayerRank == 1 then
    onlineProgressionSystem.progressionMissionComplete(true)
    onlineStatistics.updateWinStatistic(1)
    onlineStatistics.updateModeProfileWinStatistic("MP pure race")
  else
    onlineProgressionSystem.progressionMissionComplete(false)
    onlineStatistics.updateLossStatistic(1)
  end
  onlineStatistics.updatePlayerLastPositionInMode("MP pure race", localPlayerRank)
end
missionSetupData["Multiplayer pure race"].getLocalPlayerFinalScore = function(instance)
  local playerObjTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[localPlayer.playerID + 1]]
  local numCheckPoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
  if playerObjTO and playerObjTO.namedTasks.checkpoints then
    return playerObjTO.namedTasks.checkpoints.networkVars.checkpoints - 1 + playerObjTO.namedTasks.checkpoints.networkVars.laps * numCheckPoints
  end
  return 0
end
missionSetupData["Multiplayer pure race"].getPlayerFinalScore = function(instance, playerID)
  local playerObjTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[playerID + 1]]
  local numCheckPoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
  if playerObjTO and playerObjTO.namedTasks.checkpoints then
    return playerObjTO.namedTasks.checkpoints.networkVars.checkpoints - 1 + playerObjTO.namedTasks.checkpoints.networkVars.laps * numCheckPoints
  end
  return 0
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
      totalLaps = mpPureRaceLapCount
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
missionSetupData["Multiplayer pure race"].onPlayerJoinInProgress = function(remotePlayer)
  if remotePlayer then
    local function setNewPlayerVehicleMaxDamage()
      if remotePlayer.currentVehicle then
        remotePlayer.currentVehicle.gameVehicle.maxAllowedDamage = 0.74
        removeUserUpdateFunction("setNewPlayerVehicleMaxDamage")
      end
    end
    addUserUpdateFunction("setNewPlayerVehicleMaxDamage", setNewPlayerVehicleMaxDamage, 1)
  else
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243748")
  end
end
missionSetupData["Multiplayer pure race"].missionEnd = function(instance)
  removeUserUpdateFunction("setNewPlayerVehicleMaxDamage")
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
  for playerID, player in next, playerManager.players, nil do
    if player and player.currentVehicle then
      player.currentVehicle.gameVehicle.maxAllowedDamage = 0.74
    end
  end
  feedbackSystem.menusMaster.disableDamageBar(localPlayer)
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
  if task.taskName == "Linear Checkpoints No AI" and task.condition == 1 and taskObject.coreData.isLocal then
    onlineRaceManager.onLocalPlayerFinishRace()
  elseif task.taskName == "Linear Checkpoints No AI" and task.condition ~= 1 or task.taskName == "MP race end timer" and task.condition > 0 or task.taskName == "MP race end" and task.condition == 2 then
    onlineRaceManager.onLocalPlayerFinishRace()
    if task.taskName == "Linear Checkpoints No AI" and task.condition == 2 then
      local raceCompleted = false
      for i = 1, 8 do
        local objTO = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
        if objTO and objTO.namedTasks.checkpoints and objTO.namedTasks.checkpoints.networkVars.laps > objTO.namedTasks.checkpoints.coreData.totalLaps then
          raceCompleted = true
          break
        end
      end
      if not raceCompleted then
        phaseManager.modeTimedOut = true
      else
        phaseManager.modeTimedOut = false
      end
    end
    scoreSystem.stopAbilityDrain(localPlayer.localID, false)
    taskObject.coreData.instance:initiateOverTimePhase()
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
