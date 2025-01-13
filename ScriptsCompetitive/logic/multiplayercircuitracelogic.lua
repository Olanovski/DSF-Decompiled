module("cardSystem.logic")
missionSetupData["Multiplayer circuit race"] = {}
missionSetupData["Multiplayer circuit race"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.roads = routes["Circuit Race 01"].roads
    spawnPosition.route = routes["Circuit Race 01"].checkpoints
    spawnPosition.arrows = routes["Circuit Race 01"].arrows
    spawnPosition.target = routes["Circuit Race Start 01"].checkpoints[1].position
    spawnPosition.positionA = routes["Circuit Race Start 01"].checkpoints[1].position
    spawnPosition.headingA = routes["Circuit Race Start 01"].checkpoints[1].heading
  end,
  [2] = function(spawnPosition)
    spawnPosition.roads = routes["Circuit Race 02"].roads
    spawnPosition.route = routes["Circuit Race 02"].checkpoints
    spawnPosition.arrows = routes["Circuit Race 02"].arrows
    spawnPosition.target = routes["Circuit Race Start 02"].checkpoints[1].position
    spawnPosition.positionA = routes["Circuit Race Start 02"].checkpoints[1].position
    spawnPosition.headingA = routes["Circuit Race Start 02"].checkpoints[1].heading
  end,
  [3] = function(spawnPosition)
    spawnPosition.roads = routes["Circuit Race 03"].roads
    spawnPosition.route = routes["Circuit Race 03"].checkpoints
    spawnPosition.arrows = routes["Circuit Race 03"].arrows
    spawnPosition.target = routes["Circuit Race Start 03"].checkpoints[1].position
    spawnPosition.positionA = routes["Circuit Race Start 03"].checkpoints[1].position
    spawnPosition.headingA = routes["Circuit Race Start 03"].checkpoints[1].heading
  end,
  [4] = function(spawnPosition)
    spawnPosition.roads = routes["Circuit Race 04"].roads
    spawnPosition.route = routes["Circuit Race 04"].checkpoints
    spawnPosition.arrows = routes["Circuit Race 04"].arrows
    spawnPosition.target = routes["Circuit Race Start 04"].checkpoints[1].position
    spawnPosition.positionA = routes["Circuit Race Start 04"].checkpoints[1].position
    spawnPosition.headingA = routes["Circuit Race Start 04"].checkpoints[1].heading
  end,
  [5] = function(spawnPosition)
    spawnPosition.roads = routes["Circuit Race 05"].roads
    spawnPosition.route = routes["Circuit Race 05"].checkpoints
    spawnPosition.arrows = routes["Circuit Race 05"].arrows
    spawnPosition.target = routes["Circuit Race Start 05"].checkpoints[1].position
    spawnPosition.positionA = routes["Circuit Race Start 05"].checkpoints[1].position
    spawnPosition.headingA = routes["Circuit Race Start 05"].checkpoints[1].heading
  end,
  [6] = function(spawnPosition)
    spawnPosition.roads = routes["Circuit Race 06"].roads
    spawnPosition.route = routes["Circuit Race 06"].checkpoints
    spawnPosition.arrows = routes["Circuit Race 06"].arrows
    spawnPosition.target = routes["Circuit Race Start 06"].checkpoints[1].position
    spawnPosition.positionA = routes["Circuit Race Start 06"].checkpoints[1].position
    spawnPosition.headingA = routes["Circuit Race Start 06"].checkpoints[1].heading
  end,
  [7] = function(spawnPosition)
    spawnPosition.roads = routes["Circuit Race 07"].roads
    spawnPosition.route = routes["Circuit Race 07"].checkpoints
    spawnPosition.arrows = routes["Circuit Race 07"].arrows
    spawnPosition.target = routes["Circuit Race Start 07"].checkpoints[1].position
    spawnPosition.positionA = routes["Circuit Race Start 07"].checkpoints[1].position
    spawnPosition.headingA = routes["Circuit Race Start 07"].checkpoints[1].heading
  end,
  [8] = function(spawnPosition)
    spawnPosition.roads = routes["Circuit Race 08"].roads
    spawnPosition.route = routes["Circuit Race 08"].checkpoints
    spawnPosition.arrows = routes["Circuit Race 08"].arrows
    spawnPosition.target = routes["Circuit Race Start 08"].checkpoints[1].position
    spawnPosition.positionA = routes["Circuit Race Start 08"].checkpoints[1].position
    spawnPosition.headingA = routes["Circuit Race Start 08"].checkpoints[1].heading
  end,
  [10] = function(spawnPosition)
    spawnPosition.roads = routes["Online Test Route"].roads
    spawnPosition.route = routes["Online Test Route"].checkpoints
    spawnPosition.target = routes["Online Test Route Start"].checkpoints[1].position
    spawnPosition.positionA = routes["Online Test Route Start"].checkpoints[1].position
    spawnPosition.headingA = routes["Online Test Route Start"].checkpoints[1].heading
  end
}
missionSetupData["Multiplayer circuit race"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.roads = nil
  spawnPosition.route = nil
  spawnPosition.arrows = nil
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
end
missionSetupData["Multiplayer circuit race"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\MP_CircuitRace01.lua",
    lockingZoneData = {
      name = "Online_CircuitRace01",
      drawDistance = 30
    },
    propData = {
      name = "CircuitRace01"
    },
    vehicleSet = OnlineModeSettings.vehicleTypeMixed,
    moods = OnlineModeSettings.onlineMoodsSuburbs1
  },
  [2] = {
    routeName = "RouteData\\MP_CircuitRace02.lua",
    lockingZoneData = {
      name = "Online_CircuitRace02",
      drawDistance = 30
    },
    propData = {
      name = "CircuitRace02"
    },
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsCoastalFog
  },
  [3] = {
    routeName = "RouteData\\MP_CircuitRace03.lua",
    lockingZoneData = {
      name = "Online_CircuitRace03",
      drawDistance = 30
    },
    propData = {
      name = "CircuitRace03"
    },
    vehicleSet = OnlineModeSettings.vehicleTypeMuscle,
    moods = OnlineModeSettings.onlineMoodsDowntown2,
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(-61.72, 0, 900, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(-50, 0, 842, 1),
            length = 50,
            width = 50
          }
        }
      }
    }
  },
  [4] = {
    routeName = "RouteData\\MP_CircuitRace04.lua",
    propData = {
      name = "CircuitRace04"
    },
    lockingZoneData = {
      name = "Online_CircuitRace04",
      drawDistance = 30
    },
    propData = {
      name = "CircuitRace04"
    },
    vehicleSet = OnlineModeSettings.vehicleTypeMuscle,
    moods = OnlineModeSettings.onlineMoodsDowntownFog
  },
  [5] = {
    routeName = "RouteData\\MP_CircuitRace05.lua",
    lockingZoneData = {
      name = "Online_CircuitRace05",
      drawDistance = 30
    },
    propData = {
      name = "CircuitRace05"
    },
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsSuburbs2,
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(-3375, 0, 2516, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(-3377, 0, 2446, 1),
            length = 50,
            width = 50
          }
        }
      }
    }
  },
  [6] = {
    routeName = "RouteData\\MP_CircuitRace06.lua",
    lockingZoneData = {
      name = "Online_CircuitRace06",
      drawDistance = 30
    },
    propData = {
      name = "CircuitRace06"
    },
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsMarin,
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(1756, 50, -3688, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(1820, 50, -3688, 1),
            length = 50,
            width = 50
          }
        }
      }
    }
  },
  [7] = {
    routeName = "RouteData\\MP_CircuitRace07.lua",
    lockingZoneData = {
      name = "Online_CircuitRace07",
      drawDistance = 30
    },
    propData = {
      name = "CircuitRace07"
    },
    vehicleSet = OnlineModeSettings.vehicleTypeMuscle,
    moods = OnlineModeSettings.onlineMoodsDowntown1,
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(-164, 0, 363, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(-234, 0, 382, 1),
            length = 50,
            width = 50
          }
        }
      }
    }
  },
  [8] = {
    routeName = "RouteData\\MP_CircuitRace08.lua",
    lockingZoneData = {
      name = "Online_CircuitRace08",
      drawDistance = 30
    },
    propData = {
      name = "CircuitRace08"
    },
    vehicleSet = OnlineModeSettings.vehicleTypeMuscle,
    moods = OnlineModeSettings.onlineMoodsNatural1,
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(-728, 0, 3903, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(-697, 0, 3867, 1),
            length = 50,
            width = 50
          }
        }
      }
    }
  },
  [10] = {
    routeName = "RouteData\\MP_TestRoute.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    trafficSet = 1,
    moods = OnlineModeSettings.onlineMoodsNatural1
  }
}
missionSetupData["Multiplayer circuit race"].usableRouteIndicies = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 7,
  [8] = 8
}
mpCircuitRaceLapCount = 2
mpCircuitRaceTimeLimit = 480
mpCircuitRaceEndTimeLimit = 5
local playerTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "Linear Checkpoints No AI",
        specialName = "checkpoints",
        dynamicTargets = true,
        coreData = {totalLaps = mpCircuitRaceLapCount},
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
              params = {value = mpCircuitRaceTimeLimit}
            }
          },
          {
            {
              goal = "End race timer set",
              params = {value = true}
            },
            {
              goal = "End race time above",
              params = {value = mpCircuitRaceEndTimeLimit}
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
        },
        HUD = {
          {
            style = "MP Circuit Race HUD"
          }
        }
      },
      [2] = {
        task = "MP Weaken Vehicle",
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Zap State changed",
              params = {value = true}
            },
            {
              goal = "Zap State changed",
              params = {value = false}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player position changed",
              params = {value = true}
            }
          }
        }
      }
    },
    [2] = {
      [1] = {
        task = "MP race end",
        coreData = {stdRace = true, playerTO = true},
        goalConditions = {
          {
            {
              goal = "Race end screen set",
              params = {value = false}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Race end screen set",
              params = {value = true}
            }
          }
        }
      }
    },
    [3] = {
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
              params = {value = mpCircuitRaceEndTimeLimit}
            }
          },
          {
            {
              goal = "All players finished race",
              params = {playerTO = true}
            }
          },
          {
            {
              goal = "Instance start time valid"
            },
            {
              goal = "Instance time above",
              params = {value = mpCircuitRaceTimeLimit}
            }
          }
        }
      }
    }
  }
end
missionSetupData["Multiplayer circuit race"].taskCreatorFunctionLookups = {
  ["Player Pool"] = playerTasks
}
missionSetupData["Multiplayer circuit race"].onlineProgressionData = {
  localPlayer = {
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.shiftRaceCheckpointXP,
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
missionSetupData["Multiplayer circuit race"].stepHighlightColours = function(instance)
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
missionSetupData["Multiplayer circuit race"].onlineStatisticsData = function()
  local racePosition = onlineRaceManager.getPlayerRank(localPlayer.playerID)
  assert(racePosition and racePosition > 0 and racePosition < 9, "circuit Race Statistic Gen Error: Race position must be between [0,8], value " .. tostring(racePosition))
  local winValue = onlineStatistics.getWinStatistic()
  local lossValue = onlineStatistics.getLossStatistic()
  local specific = onlineStatistics.getSpecificStatistic()
  onlineStatistics.updateSpecificStatistic(specific * -1)
  local numOfRaces = winValue + lossValue
  assert(numOfRaces > 0, "circuit Race Statistic Gen Error: Number of races should be at least 1 as you just completed a Race")
  local positionTotal = specific * (numOfRaces - 1)
  positionTotal = positionTotal + racePosition
  local average = positionTotal / numOfRaces
  assert(average > 0 and average < 9, "circuit Race Statistic Gen Error: average must be between [0,8], value " .. tostring(average))
  onlineStatistics.updateSpecificStatistic(average)
  onlineStatistics.updateScoreStatistic(onlineProgressionSystem.getLocalPlayerXPGained())
end
missionSetupData["Multiplayer circuit race"].missionCompleteData = function(instance, syncedScoreTable)
  onlineScreenManager.setRaceCompleteData(true)
  onlineScreenManager.setForceSortType(false)
  for playerID, player in next, playerManager.players, nil do
    assert(syncedScoreTable[playerID], "players score not found in synced score table")
    onlineScreenManager.updatePlayerScore(playerID, syncedScoreTable[playerID])
    onlineScreenManager.updatePlayerSecondaryScore(playerID, onlineRaceManager.getPlayerRank(playerID))
  end
  local localPlayerRank = onlineRaceManager.getPlayerRank(localPlayer.playerID)
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public and localPlayerRank <= 3 then
    local value = ProfileSettings.GetNumCircuitRaceTopThree() + 1
    ProfileSettings.SetNumCircuitRaceTopThree(value)
    OnlineAchievements.onValueChange("Circuit Race Top 3", value)
  end
  if localPlayerRank == 1 then
    onlineProgressionSystem.progressionMissionComplete(true)
    onlineStatistics.updateWinStatistic(1)
    onlineStatistics.updateModeProfileWinStatistic("MP circuit race")
  else
    onlineProgressionSystem.progressionMissionComplete(false)
    onlineStatistics.updateLossStatistic(1)
  end
  onlineStatistics.updatePlayerLastPositionInMode("MP circuit race", localPlayerRank)
end
missionSetupData["Multiplayer circuit race"].getLocalPlayerFinalScore = function(instance)
  local playerTO = localPlayer.getTaskObject()
  local numCheckPoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
  if playerTO and playerTO.namedTasks.checkpoints then
    return playerTO.namedTasks.checkpoints.networkVars.checkpoints - 1 + playerTO.namedTasks.checkpoints.networkVars.laps * numCheckPoints
  end
  return 0
end
missionSetupData["Multiplayer circuit race"].getPlayerFinalScore = function(instance, playerID)
  local playerTO = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[playerID + 1]]
  local numCheckPoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
  if playerTO and playerTO.namedTasks.checkpoints then
    return playerTO.namedTasks.checkpoints.networkVars.checkpoints - 1 + playerTO.namedTasks.checkpoints.networkVars.laps * numCheckPoints
  end
  return 0
end
missionSetupData["Multiplayer circuit race"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 2,
      spoolStartArea = true,
      gridStyle = 1,
      missionVehicleStyle = 1,
      moodStyle = 2,
      introHUD = "MP Circuit Race Start HUD",
      raceMode = true,
      disableZapOnCompletion = true,
      modeTimeLimit = mpCircuitRaceTimeLimit,
      totalLaps = mpCircuitRaceLapCount,
      damageMultiplier = {
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1
      }
    }
  }
end
missionSetupData["Multiplayer circuit race"].missionStart = function(instance)
  if not instance.missionStartCalled then
    local routeIndex = instance.networkVars.routeIndex
    local route = instance.challenge.spawnPositions[routeIndex].route
    checkpointSystem.clearNoneSyncronisedCheckpoint()
    for i, checkpointData in ipairs(route) do
      checkpointSystem.createNoneSyncronisedCheckpoint(instance.instanceID, 1, checkpointData)
    end
  end
  instance.missionStartCalled = true
end
missionSetupData["Multiplayer circuit race"].onPlayerJoinInProgress = function(remotePlayer)
  if not remotePlayer then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243748")
  end
end
missionSetupData["Multiplayer circuit race"].update = function(instance)
  onlineProgressionSystem.progressionUpdate()
end
taskCompleteData["Multiplayer circuit race"] = {}
taskCompleteData["Multiplayer circuit race"].taskComplete = function(taskObject, task)
  if task.taskName == "Linear Checkpoints No AI" and task.condition == 1 and taskObject.coreData.isLocal then
    onlineRaceManager.onLocalPlayerFinishRace()
  elseif task.taskName == "Linear Checkpoints No AI" and task.condition ~= 1 or task.taskName == "MP race end timer" and task.condition > 0 then
    local raceCompleted = false
    for i = 1, 8 do
      local objTO = task.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
      if objTO and objTO.namedTasks.checkpoints and objTO.namedTasks.checkpoints.networkVars.laps > objTO.namedTasks.checkpoints.coreData.totalLaps then
        raceCompleted = true
        break
      end
    end
    if not raceCompleted and (task.taskName == "Linear Checkpoints No AI" and task.condition == 2 or task.taskName == "MP race end timer" and task.condition == 3) then
      phaseManager.modeTimedOut = true
    else
      phaseManager.modeTimedOut = false
    end
    for localID, plr in next, localPlayerManager.players, nil do
      plr:blockAbility("zap", true)
    end
    onlineRaceManager.onLocalPlayerFinishRace()
    taskObject.coreData.instance:initiateOverTimePhase()
  end
end
local getPlayerDynamicTargets = function(taskObject, task, dynamicListID)
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
missionSetupData["Multiplayer circuit race"].targetList = {
  ["Player Pool"] = getPlayerDynamicTargets
}
