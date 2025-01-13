module("cardSystem.logic")
missionSetupData["Multiplayer takedown"] = {}
mpTakeDownVehicleDamageMultipliers = {
  [1] = 1,
  [2] = 1,
  [3] = 1,
  [4] = 1,
  [5] = 1,
  [6] = 1,
  [7] = 1,
  [8] = 1
}
mpTakedownTimeLimit = 180
local challengeEndTime = 15
local scoreMulti = 2
local numCheckpoints = 4
local challengeStartTime = 5
local dropOffXPModifier = {
  [1] = onlineProgressionSystem.takedownDropOff1XP,
  [2] = onlineProgressionSystem.takedownDropOff2XP,
  [3] = onlineProgressionSystem.takedownDropOff3XP,
  [4] = onlineProgressionSystem.takedownDropOff4XP
}
missionSetupData["Multiplayer takedown"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.route = routes.TakeDown_Route_01.checkpoints
    spawnPosition.target = routes.TakeDown_Start_01.checkpoints[1].position
    spawnPosition.positionA = routes.TakeDown_Start_01.checkpoints[2].position
    spawnPosition.headingA = routes.TakeDown_Start_01.checkpoints[2].heading
    spawnPosition.positionB = routes.TakeDown_Start_01.checkpoints[1].position
    spawnPosition.headingB = routes.TakeDown_Start_01.checkpoints[1].heading
  end,
  [2] = function(spawnPosition)
    spawnPosition.route = routes.TakeDown_Route_02.checkpoints
    spawnPosition.target = routes.TakeDown_Start_02.checkpoints[1].position
    spawnPosition.positionA = routes.TakeDown_Start_02.checkpoints[2].position
    spawnPosition.headingA = routes.TakeDown_Start_02.checkpoints[2].heading
    spawnPosition.positionB = routes.TakeDown_Start_02.checkpoints[1].position
    spawnPosition.headingB = routes.TakeDown_Start_02.checkpoints[1].heading
  end,
  [3] = function(spawnPosition)
    spawnPosition.route = routes.TakeDown_Route_03.checkpoints
    spawnPosition.target = routes.TakeDown_Start_03.checkpoints[1].position
    spawnPosition.positionA = routes.TakeDown_Start_03.checkpoints[2].position
    spawnPosition.headingA = routes.TakeDown_Start_03.checkpoints[2].heading
    spawnPosition.positionB = routes.TakeDown_Start_03.checkpoints[1].position
    spawnPosition.headingB = routes.TakeDown_Start_03.checkpoints[1].heading
  end,
  [4] = function(spawnPosition)
    spawnPosition.route = routes.TakeDown_Route_04.checkpoints
    spawnPosition.target = routes.TakeDown_Start_04.checkpoints[1].position
    spawnPosition.positionA = routes.TakeDown_Start_04.checkpoints[2].position
    spawnPosition.headingA = routes.TakeDown_Start_04.checkpoints[2].heading
    spawnPosition.positionB = routes.TakeDown_Start_04.checkpoints[1].position
    spawnPosition.headingB = routes.TakeDown_Start_04.checkpoints[1].heading
  end,
  [5] = function(spawnPosition)
    spawnPosition.route = routes.TakeDown_Route_05.checkpoints
    spawnPosition.target = routes.TakeDown_Start_05.checkpoints[1].position
    spawnPosition.positionA = routes.TakeDown_Start_05.checkpoints[2].position
    spawnPosition.headingA = routes.TakeDown_Start_05.checkpoints[2].heading
    spawnPosition.positionB = routes.TakeDown_Start_05.checkpoints[1].position
    spawnPosition.headingB = routes.TakeDown_Start_05.checkpoints[1].heading
  end,
  [6] = function(spawnPosition)
    spawnPosition.route = routes.TakeDown_Route_01.checkpoints
    spawnPosition.target = routes.TakeDown_Start_01.checkpoints[1].position
    spawnPosition.positionA = routes.TakeDown_Start_01.checkpoints[2].position
    spawnPosition.headingA = routes.TakeDown_Start_01.checkpoints[2].heading
    spawnPosition.positionB = routes.TakeDown_Start_01.checkpoints[1].position
    spawnPosition.headingB = routes.TakeDown_Start_01.checkpoints[1].heading
  end,
  [7] = function(spawnPosition)
    spawnPosition.route = routes.TakeDown_Route_02.checkpoints
    spawnPosition.target = routes.TakeDown_Start_02.checkpoints[1].position
    spawnPosition.positionA = routes.TakeDown_Start_02.checkpoints[2].position
    spawnPosition.headingA = routes.TakeDown_Start_02.checkpoints[2].heading
    spawnPosition.positionB = routes.TakeDown_Start_02.checkpoints[1].position
    spawnPosition.headingB = routes.TakeDown_Start_02.checkpoints[1].heading
  end,
  [8] = function(spawnPosition)
    spawnPosition.route = routes.TakeDown_Route_03.checkpoints
    spawnPosition.target = routes.TakeDown_Start_03.checkpoints[1].position
    spawnPosition.positionA = routes.TakeDown_Start_03.checkpoints[2].position
    spawnPosition.headingA = routes.TakeDown_Start_03.checkpoints[2].heading
    spawnPosition.positionB = routes.TakeDown_Start_03.checkpoints[1].position
    spawnPosition.headingB = routes.TakeDown_Start_03.checkpoints[1].heading
  end,
  [9] = function(spawnPosition)
    spawnPosition.route = routes.TakeDown_Route_04.checkpoints
    spawnPosition.target = routes.TakeDown_Start_04.checkpoints[1].position
    spawnPosition.positionA = routes.TakeDown_Start_04.checkpoints[2].position
    spawnPosition.headingA = routes.TakeDown_Start_04.checkpoints[2].heading
    spawnPosition.positionB = routes.TakeDown_Start_04.checkpoints[1].position
    spawnPosition.headingB = routes.TakeDown_Start_04.checkpoints[1].heading
  end,
  [10] = function(spawnPosition)
    spawnPosition.route = routes.TakeDown_Route_05.checkpoints
    spawnPosition.target = routes.TakeDown_Start_05.checkpoints[1].position
    spawnPosition.positionA = routes.TakeDown_Start_05.checkpoints[2].position
    spawnPosition.headingA = routes.TakeDown_Start_05.checkpoints[2].heading
    spawnPosition.positionB = routes.TakeDown_Start_05.checkpoints[1].position
    spawnPosition.headingB = routes.TakeDown_Start_05.checkpoints[1].heading
  end
}
missionSetupData["Multiplayer takedown"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.route = nil
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
  spawnPosition.positionB = nil
  spawnPosition.headingB = nil
end
missionSetupData["Multiplayer takedown"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\MP_Takedown01.lua",
    vehicleSet = {
      {
        vehicleID = 271,
        shader = {
          [0] = 0
        }
      }
    },
    missionVehicle = {
      vehicleID = 178,
      shader = {
        [0] = 3
      }
    },
    trafficSet = 7,
    moods = OnlineModeSettings.onlineMoodsTakedown1,
    lockingZoneData = {
      name = "Online_Takedown01"
    },
    cop = 271
  },
  [2] = {
    routeName = "RouteData\\MP_Takedown02.lua",
    vehicleSet = {
      {
        vehicleID = 271,
        shader = {
          [0] = 0
        }
      }
    },
    missionVehicle = {
      vehicleID = 230,
      shader = {
        [0] = 9
      }
    },
    trafficSet = 7,
    moods = OnlineModeSettings.onlineMoodsTakedown3,
    lockingZoneData = {
      name = "Online_Takedown02"
    },
    cop = 271
  },
  [3] = {
    routeName = "RouteData\\MP_Takedown03.lua",
    vehicleSet = {
      {
        vehicleID = 271,
        shader = {
          [0] = 0
        }
      }
    },
    missionVehicle = {
      vehicleID = 237,
      shader = {
        [0] = 2
      }
    },
    trafficSet = 7,
    moods = OnlineModeSettings.onlineMoodsTakedown2,
    lockingZoneData = {
      name = "Online_Takedown03"
    },
    cop = 271,
    propData = {name = "TakeDown03"}
  },
  [4] = {
    routeName = "RouteData\\MP_Takedown04.lua",
    vehicleSet = {
      {
        vehicleID = 271,
        shader = {
          [0] = 0
        }
      }
    },
    missionVehicle = {
      vehicleID = 156,
      shader = {
        [0] = 8
      }
    },
    trafficSet = 7,
    moods = OnlineModeSettings.onlineMoodsTakedown1,
    lockingZoneData = {
      name = "Online_Takedown04"
    },
    cop = 271
  },
  [5] = {
    routeName = "RouteData\\MP_Takedown05.lua",
    vehicleSet = {
      {
        vehicleID = 271,
        shader = {
          [0] = 0
        }
      }
    },
    missionVehicle = {
      vehicleID = 146,
      shader = {
        [0] = 7
      }
    },
    trafficSet = 7,
    moods = OnlineModeSettings.onlineMoodsTakedown2,
    lockingZoneData = {
      name = "Online_Takedown05"
    },
    cop = 271
  },
  [6] = {
    routeName = "RouteData\\MP_Takedown01.lua",
    vehicleSet = {
      {
        vehicleID = 269,
        shader = {
          [0] = 0
        }
      }
    },
    missionVehicle = {
      vehicleID = 144,
      shader = {
        [0] = 3
      }
    },
    trafficSet = 7,
    moods = OnlineModeSettings.onlineMoodsTakedown1,
    lockingZoneData = {
      name = "Online_Takedown01"
    },
    cop = 269
  },
  [7] = {
    routeName = "RouteData\\MP_Takedown02.lua",
    vehicleSet = {
      {
        vehicleID = 269,
        shader = {
          [0] = 0
        }
      }
    },
    missionVehicle = {
      vehicleID = 203,
      shader = {
        [0] = 9
      }
    },
    trafficSet = 7,
    moods = OnlineModeSettings.onlineMoodsTakedown3,
    lockingZoneData = {
      name = "Online_Takedown02"
    },
    cop = 269
  },
  [8] = {
    routeName = "RouteData\\MP_Takedown03.lua",
    vehicleSet = {
      {
        vehicleID = 269,
        shader = {
          [0] = 0
        }
      }
    },
    missionVehicle = {
      vehicleID = 148,
      shader = {
        [0] = 2
      }
    },
    trafficSet = 7,
    moods = OnlineModeSettings.onlineMoodsTakedown2,
    lockingZoneData = {
      name = "Online_Takedown03"
    },
    cop = 269
  },
  [9] = {
    routeName = "RouteData\\MP_Takedown04.lua",
    vehicleSet = {
      {
        vehicleID = 269,
        shader = {
          [0] = 0
        }
      }
    },
    missionVehicle = {
      vehicleID = 180,
      shader = {
        [0] = 8
      }
    },
    trafficSet = 7,
    moods = OnlineModeSettings.onlineMoodsTakedown1,
    lockingZoneData = {
      name = "Online_Takedown04"
    },
    cop = 269
  },
  [10] = {
    routeName = "RouteData\\MP_Takedown05.lua",
    vehicleSet = {
      {
        vehicleID = 269,
        shader = {
          [0] = 0
        }
      }
    },
    missionVehicle = {
      vehicleID = 239,
      shader = {
        [0] = 7
      }
    },
    trafficSet = 7,
    moods = OnlineModeSettings.onlineMoodsTakedown2,
    lockingZoneData = {
      name = "Online_Takedown05"
    },
    cop = 269
  }
}
missionSetupData["Multiplayer takedown"].usableRouteIndicies = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 7,
  [8] = 8,
  [9] = 9,
  [10] = 10
}
local getawayTasks = function()
  return {
    [1] = {
      [1] = {
        task = "Non-linear Checkpoints",
        specialName = "checkpoints",
        dynamicTargets = true,
        coreData = {totalLaps = 0},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 10}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Completed lap",
              params = {coreValue = "totalLaps"}
            },
            {
              goal = "Getaway owner final score",
              params = {value = true, points = 4}
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Checkpoint Gate Pre Target"] = {}
              }
            }
          }
        }
      },
      [2] = {
        task = "MP getaway owner",
        specialName = "owner",
        goalConditions = {
          {
            {
              goal = "OwnerID equal",
              params = {value = -1}
            },
            {
              goal = "Valid turn taker",
              params = {value = true}
            }
          },
          {
            {
              goal = "Valid turn taker",
              params = {value = false}
            },
            failCondition = true
          }
        },
        taskConditions = {
          {
            {
              goal = "OwnerID equal",
              params = {value = -2}
            }
          }
        }
      }
    }
  }
end
local playerTask = function()
  return {
    [1] = {
      [1] = {
        task = "MP Takedown Payload Tracking",
        specialName = "score",
        dynamicTargets = true,
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "MP Takedown payload packed",
              params = {value = false}
            },
            {
              goal = "Agent is target taskObject owner",
              params = {value = true}
            },
            {
              goal = "MP takedown checkpoints",
              params = {value = true, pointsModifier = dropOffScoreModifier}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "MP Takedown payload packed",
              params = {value = false}
            },
            {
              goal = "Agent is target taskObject owner",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "MP Takedown payload packed",
              params = {value = false}
            },
            {
              goal = "Agent is target taskObject owner",
              params = {value = false}
            },
            {
              goal = "Collision combo",
              params = {
                minForce = 3500,
                maxForce = 10000,
                comboTime = 0.1,
                directScaler = 2000,
                indirectScaler = 3000,
                maxScore = 30
              }
            }
          },
          {
            {
              goal = "MP Takedown payload packed",
              params = {value = true}
            },
            failCondition = true
          }
        },
        taskConditions = {
          {
            {
              goal = "Instance start time valid"
            },
            {
              goal = "Instance time above",
              params = {value = mpTakedownTimeLimit}
            }
          }
        },
        HUD = {
          {
            style = "MP takedown main HUD"
          }
        }
      },
      [2] = {
        task = "MP Vehicle swap",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player is owner",
              params = {value = false}
            },
            {
              goal = "Player left zap",
              params = {}
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
end
missionSetupData["Multiplayer takedown"].taskCreatorFunctionLookups = {
  ["Objective Team 1"] = getawayTasks,
  ["Player Pool"] = playerTask
}
missionSetupData["Multiplayer takedown"].onlineProgressionData = {
  ["localPlayer"] = {
    getMatchBonus = function(timeInMode, threshold, baseXPValue, gainedXP)
      local matchBonus = timeInMode * baseXPValue
      if gainedXP < threshold then
        return math.max(gainedXP / threshold, onlineProgressionSystem.minimumPercentMatchBonus) * matchBonus
      end
      return matchBonus
    end
  },
  [OBJ_TEAM_ONE_STRING_TABLE[1]] = {
    {
      autoRefresh = true,
      progressionData = {
        exp = 1,
        completeText = "ID:215498",
        minShowXP = 0
      },
      {
        goal = "TaskObject agent is target taskObject owner",
        params = {value = true}
      },
      {
        goal = "MP Takedown checkpoints DATAHACK",
        params = {value = true, xpModifier = dropOffXPModifier}
      }
    },
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.takedownDamageGetawayXP,
        completeText = "ID:186769",
        minShowXP = 0
      },
      {
        goal = "TaskObject agent is target taskObject owner",
        params = {value = false}
      },
      {
        goal = "Damaged target taskObject agent",
        params = {
          cooldown = onlineProgressionSystem.takedownDamageGetawayCD,
          minForce = 3500
        }
      }
    }
  }
}
local colour32, colour128, getawayColour32, getawayColour128, chaserColour32, chaserColour128
local lastTurnTaker = -1
missionSetupData["Multiplayer takedown"].stepHighlightColours = function(instance)
  if phaseManager.networkVars.nextTurnTaker == 255 then
    return
  elseif phaseManager.networkVars.nextTurnTaker ~= lastTurnTaker then
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
  lastTurnTaker = phaseManager.networkVars.nextTurnTaker
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
    lastTurnTaker = -1
  end
  for playerID, data in next, instance.playersColours, nil do
    if data.ID ~= -1 and (not vehicleManager.vehiclesBySNVID[data.ID] or not playerManager.players[playerID - 1]) then
      data.ID = -1
      data.playerColourSet = false
    end
  end
  local isGetaway = phaseManager.networkVars.nextTurnTaker == localPlayer.playerID
  if isGetaway then
    getawayColour32 = OnlineModeSettings.blue32
    getawayColour128 = OnlineModeSettings.blue128
    chaserColour32 = OnlineModeSettings.red32
    chaserColour128 = OnlineModeSettings.red128
  else
    getawayColour32 = OnlineModeSettings.red32
    getawayColour128 = OnlineModeSettings.red128
    chaserColour32 = OnlineModeSettings.blue32
    chaserColour128 = OnlineModeSettings.blue128
  end
  for playerID, player in next, playerManager.players, nil do
    if phaseManager.networkVars.nextTurnTaker == player.playerID then
      colour32 = getawayColour32
      colour128 = getawayColour128
    else
      colour32 = chaserColour32
      colour128 = chaserColour128
    end
    if not instance.playersColours[player.playerID + 1].playerColourSet then
      Menu.SetPlayerColour(player.playerID, colour128)
      instance.playersColours[player.playerID + 1].playerColourSet = true
    end
    if player.currentVehicle and playerID ~= localPlayer.playerID and instance.playersColours[player.playerID + 1].ID ~= player.currentVehicle.SNVID then
      instance.playersColours[player.playerID + 1].ID = player.currentVehicle.SNVID
      player.currentVehicle:setDisplayColour(colour32, colour128)
    end
  end
end
missionSetupData["Multiplayer takedown"].onlineStatisticsData = function(syncedScoreTable, instance, additionalSyncData)
  assert(additionalSyncData[localPlayer.playerID], "player score not found in synced additional table")
  onlineStatistics.updateSpecificStatistic(additionalSyncData[localPlayer.playerID])
  onlineStatistics.updateScoreStatistic(onlineProgressionSystem.getLocalPlayerXPGained())
end
missionSetupData["Multiplayer takedown"].missionCompleteData = function(instance, syncedScoreTable, teamSync, additionalSyncData)
  onlineScreenManager.setForceSortType(false)
  onlineScreenManager.setRaceCompleteData(false)
  local taskObject = false
  local objTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  phaseManager.playerHasWonRound = true
  phaseManager.playerIsObjective = false
  for playerID, player in next, playerManager.players, nil do
    assert(syncedScoreTable[playerID], "players score not found in synced score table")
    assert(additionalSyncData[playerID], "players score not found in synced score table")
    onlineScreenManager.updatePlayerScore(playerID, syncedScoreTable[playerID])
    onlineScreenManager.updatePlayerRoundScore(playerID, syncedScoreTable[playerID])
  end
  if playerManager.players[phaseManager.networkVars.nextTurnTaker] then
    if phaseManager.networkVars.nextTurnTaker == localPlayer.playerID then
      phaseManager.playerIsObjective = true
      if additionalSyncData[localPlayer.playerID] == 4 or phaseManager.modeTimedOut then
        phaseManager.playerHasWonRound = true
      else
        phaseManager.playerHasWonRound = false
      end
    else
      phaseManager.playerIsObjective = false
      if additionalSyncData[phaseManager.networkVars.nextTurnTaker] < 4 and not phaseManager.modeTimedOut then
        phaseManager.playerHasWonRound = true
      else
        phaseManager.playerHasWonRound = false
      end
    end
  end
  if not instance:shouldReset() then
    local results = onlineScreenManager.getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.score)
    for i, player in ipairs(results) do
      assert(player, "Player not found of error in sorting of players in onlineScreenManager.getScreenCurrentPlayerTable. i = " .. tostring(i) .. " #results = " .. tostring(results) .. " numPlayers = " .. tostring(playerManager.numberOfPlayers))
      if i == 1 then
        if player.id == localPlayer.playerID then
          onlineProgressionSystem.progressionMissionComplete(true)
          onlineStatistics.updateWinStatistic(1)
          onlineStatistics.updateModeProfileWinStatistic("MP takedown")
        else
          onlineProgressionSystem.progressionMissionComplete(false)
          onlineStatistics.updateLossStatistic(1)
        end
      end
      if player.id == localPlayer.playerID then
        onlineStatistics.updatePlayerLastPositionInMode("MP takedown", i)
        break
      end
    end
  end
end
missionSetupData["Multiplayer takedown"].getLocalPlayerFinalScore = function()
  local playerTO = localPlayer.getTaskObject()
  return playerTO.namedTasks.score and playerTO and 0
end
missionSetupData["Multiplayer takedown"].getPlayerFinalScore = function(instance, playerID)
  local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[playerID + 1]]
  return taskObject.namedTasks.score and taskObject and 0
end
missionSetupData["Multiplayer takedown"].getPlayerAdditionalSyncData = function(instance, playerID)
  local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[playerID + 1]]
  if taskObject and taskObject.namedTasks and taskObject.namedTasks.score then
    return taskObject.namedTasks.score.networkVars.playerDropoffs
  end
  return 0
end
missionSetupData["Multiplayer takedown"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 2,
      numRounds = -1,
      maxRounds = 1,
      trackPlayerScores = true,
      delayTime = 5,
      noIndexflip = true,
      persistantScore = "score",
      scoreMulti = scoreMulti,
      numCheckpoints = numCheckpoints,
      gridStyle = 4,
      missionVehicleStyle = 3,
      moodStyle = 3,
      introHUD = "MP takedown start HUD",
      turnTracking = true,
      disableZapOnCompletion = true,
      lockZapWeapons = true,
      modeTimeLimit = mpTakedownTimeLimit,
      additionalSyncData = true
    }
  }
end
missionSetupData["Multiplayer takedown"].assignTaskObjects = function(instance, player, vehicle)
  if not player and not instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]] then
    local vehicle = vehicleManager.vehiclesBySNVID[phaseManager.vehicleGrid[9]]
    local actor = instance.challenge.actorPool[OBJ_TEAM_ONE_STRING_TABLE[1]]
    instance:newActorFromAgent(actor.ID, vehicle)
  end
end
local OldOwner
missionSetupData["Multiplayer takedown"].updatePresence = function()
  local localPlayerTO = localPlayer.getTaskObject()
  if localPlayerTO and localPlayerTO.coreData then
    local objTO = localPlayerTO.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  end
end
local swapFinishedCallback = function(gameVehicle)
  for playerID, player in next, playerManager.players, nil do
    if player.currentVehicle and player.currentVehicle.gameVehicle == gameVehicle then
      player.currentVehicle:activateSiren()
    end
  end
end
missionSetupData["Multiplayer takedown"].missionStart = function(instance)
  if not instance.missionStartCalled then
    local routeIndex = instance.networkVars.routeIndex
    local route = instance.challenge.spawnPositions[routeIndex].route
    checkpointSystem.clearNoneSyncronisedCheckpoint()
    for i, checkpointData in ipairs(route) do
      checkpointSystem.createNoneSyncronisedCheckpoint(instance.instanceID, 1, checkpointData)
    end
  end
  instance.getaway = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local getawayVehicle = instance.getaway.coreData.agent
  MPZapToAction.setZapToAction(1, getawayVehicle)
  getawayVehicle:set_damageMultiplier(mpTakeDownVehicleDamageMultipliers[playerManager.numberOfPlayers])
  for id, player in next, localPlayerManager.players, nil do
    if player.currentVehicle then
      local playerGameVehicle = player.currentVehicle.gameVehicle
      if playerGameVehicle == getawayVehicle.gameVehicle then
        player:blockAbility("zap", true)
        scoreSystem.setZapBlocked(id, true)
      else
        player:blockAbility("zap", false)
      end
    end
  end
  for playerID, player in next, playerManager.players, nil do
    if player.currentVehicle then
      player.currentVehicle:activateSiren()
    end
  end
  instance.missionStartCalled = true
  zap.zapSwap.overideSwapCancel = true
  zap.zapSwap.setSwapFinishedCallback(swapFinishedCallback)
  local setTimeToJoinException = true
  if instance.networkVars.roundOn ~= instance.challenge.settings.maxRounds then
    for playerID, players in next, playerManager.players, nil do
      if instance.turnTracking[playerID + 1] == 0 then
        setTimeToJoinException = false
        break
      end
    end
  end
  if setTimeToJoinException then
    phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeException)
  end
  phaseManager.lastTurnTaker = phaseManager.networkVars.nextTurnTaker
end
missionSetupData["Multiplayer takedown"].onPlayerJoinInProgress = function(remotePlayer)
  if not remotePlayer then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243748")
    onlineInstructionSupport.displayPrompt("ID:234257", localPlayer.buttonLayout.zapReturn)
  end
end
missionSetupData["Multiplayer takedown"].modeReadyCheck = function(instance)
  local getaway = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  if not getaway then
    return false
  end
  if getaway and not getaway.coreData.agent then
    return false
  end
  return true
end
missionSetupData["Multiplayer takedown"].missionEnd = function(instance)
  instance.getaway = nil
  if scoreSystem.blockedFeedbackOn then
    scoreSystem.setZapBlocked(localPlayer.localID, false)
  end
  zap.zapSwap.setSwapFinishedCallback(false)
end
missionSetupData["Multiplayer takedown"].update = function(instance)
  onlineProgressionSystem.progressionUpdate()
end
taskCompleteData["Multiplayer takedown"] = {}
taskCompleteData["Multiplayer takedown"].taskComplete = function(taskObject, task)
  if task.taskName == "Non-linear Checkpoints" or task.taskName == "MP Takedown Payload Tracking" or task.taskName == "MP getaway owner" then
    if task.taskName == "MP Takedown Payload Tracking" then
      if task.condition == 1 then
        phaseManager.modeTimedOut = true
      else
        phaseManager.modeTimedOut = false
      end
    end
    MPZapToAction.reset()
    if task.instance.isLocal and task.taskName == "MP Takedown Payload Tracking" then
      for i = 1, 8 do
        local taskObject = task.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
        if taskObject and taskObject.namedTasks.score then
          task.instance.playerScores[i] = taskObject.namedTasks.score.networkVars.payload
        end
      end
    end
    task.instance:initiateOverTimePhase()
  end
end
local getGetawayVehicleDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(taskObject.coreData.instance.instanceID, 1)
  if dynamicListID then
    if task.networkVars.checkpoints < #allCheckpoints then
      return {}, false
    else
      return {}, true
    end
  else
    return allCheckpoints, false
  end
end
local getPlayerDynamicTargets = function(taskObject, task, dynamicListID)
  return {
    task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  }, false
end
missionSetupData["Multiplayer takedown"].targetList = {
  ["Player Pool"] = getPlayerDynamicTargets,
  ["Objective Team 1"] = getGetawayVehicleDynamicTargets
}
