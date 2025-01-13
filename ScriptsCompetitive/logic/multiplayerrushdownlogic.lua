module("cardSystem.logic")
missionSetupData["Multiplayer rush down"] = {}
mpRushdownTimeLimit = 480
mpRushdownScore = 20
local baseRadius = 450
missionSetupData["Multiplayer rush down"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.positionA = routes["Rushdown Start 01"].checkpoints[2].position
    spawnPosition.headingA = routes["Rushdown Start 01"].checkpoints[2].heading
    spawnPosition.positionB = routes["Rushdown Start 01"].checkpoints[1].position
    spawnPosition.headingB = routes["Rushdown Start 01"].checkpoints[1].heading
    spawnPosition.targetScore = mpRushdownScore
  end,
  [2] = function(spawnPosition)
    spawnPosition.positionA = routes["Rushdown Start 02"].checkpoints[2].position
    spawnPosition.headingA = routes["Rushdown Start 02"].checkpoints[2].heading
    spawnPosition.positionB = routes["Rushdown Start 02"].checkpoints[1].position
    spawnPosition.headingB = routes["Rushdown Start 02"].checkpoints[1].heading
    spawnPosition.targetScore = mpRushdownScore
  end,
  [3] = function(spawnPosition)
    spawnPosition.positionA = routes["Rushdown Start 03"].checkpoints[2].position
    spawnPosition.headingA = routes["Rushdown Start 03"].checkpoints[2].heading
    spawnPosition.positionB = routes["Rushdown Start 03"].checkpoints[1].position
    spawnPosition.headingB = routes["Rushdown Start 03"].checkpoints[1].heading
    spawnPosition.targetScore = mpRushdownScore
  end,
  [4] = function(spawnPosition)
    spawnPosition.positionA = routes["Rushdown Start 04"].checkpoints[2].position
    spawnPosition.headingA = routes["Rushdown Start 04"].checkpoints[2].heading
    spawnPosition.positionB = routes["Rushdown Start 04"].checkpoints[1].position
    spawnPosition.headingB = routes["Rushdown Start 04"].checkpoints[1].heading
    spawnPosition.targetScore = mpRushdownScore
  end,
  [5] = function(spawnPosition)
    spawnPosition.positionA = routes["Rushdown Start 05"].checkpoints[2].position
    spawnPosition.headingA = routes["Rushdown Start 05"].checkpoints[2].heading
    spawnPosition.positionB = routes["Rushdown Start 05"].checkpoints[1].position
    spawnPosition.headingB = routes["Rushdown Start 05"].checkpoints[1].heading
    spawnPosition.targetScore = mpRushdownScore
  end,
  [6] = function(spawnPosition)
    spawnPosition.positionA = routes["Rushdown Start 06"].checkpoints[2].position
    spawnPosition.headingA = routes["Rushdown Start 06"].checkpoints[2].heading
    spawnPosition.positionB = routes["Rushdown Start 06"].checkpoints[1].position
    spawnPosition.headingB = routes["Rushdown Start 06"].checkpoints[1].heading
    spawnPosition.targetScore = mpRushdownScore
  end,
  [7] = function(spawnPosition)
    spawnPosition.positionA = routes["Rushdown Start 07"].checkpoints[2].position
    spawnPosition.headingA = routes["Rushdown Start 07"].checkpoints[2].heading
    spawnPosition.positionB = routes["Rushdown Start 07"].checkpoints[1].position
    spawnPosition.headingB = routes["Rushdown Start 07"].checkpoints[1].heading
    spawnPosition.targetScore = mpRushdownScore
  end,
  [8] = function(spawnPosition)
    spawnPosition.positionA = routes["Rushdown Start 08"].checkpoints[2].position
    spawnPosition.headingA = routes["Rushdown Start 08"].checkpoints[2].heading
    spawnPosition.positionB = routes["Rushdown Start 08"].checkpoints[1].position
    spawnPosition.headingB = routes["Rushdown Start 08"].checkpoints[1].heading
    spawnPosition.targetScore = mpRushdownScore
  end
}
missionSetupData["Multiplayer rush down"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
  spawnPosition.positionB = nil
  spawnPosition.headingB = nil
end
missionSetupData["Multiplayer rush down"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\MP_Rushdown01.lua",
    target = vec.vector(-2595.855, 67.90485, 993.4472, 1),
    targetRadius = 9,
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    trafficSet = 2,
    moods = OnlineModeSettings.onlineMoodsBlitz,
    lockingZoneData = {
      name = "Online_Rushdown_Exclusion"
    }
  },
  [2] = {
    routeName = "RouteData\\MP_Rushdown02.lua",
    target = vec.vector(1243.788, 30, -4054.729, 1),
    targetRadius = 12,
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    trafficSet = 2,
    moods = OnlineModeSettings.onlineMoodsBlitz,
    lockingZoneData = {
      name = "Online_Rushdown_Exclusion"
    }
  },
  [3] = {
    routeName = "RouteData\\MP_Rushdown03.lua",
    target = vec.vector(-3768.267, 47.24696, 2787.61, 1),
    targetRadius = 15,
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    trafficSet = 2,
    moods = OnlineModeSettings.onlineMoodsBlitz,
    lockingZoneData = {
      name = "Online_Rushdown_Exclusion"
    }
  },
  [4] = {
    routeName = "RouteData\\MP_Rushdown04.lua",
    target = vec.vector(-961.3788, 62.47788, 2163.858, 1),
    targetRadius = 8,
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    trafficSet = 2,
    moods = OnlineModeSettings.onlineMoodsBlitz,
    lockingZoneData = {
      name = "Online_Rushdown_Exclusion"
    }
  },
  [5] = {
    routeName = "RouteData\\MP_Rushdown05.lua",
    target = vec.vector(-3388.888, 75.5156, 3983.659, 1),
    targetRadius = 12.5,
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    trafficSet = 2,
    moods = OnlineModeSettings.onlineMoodsBlitz,
    lockingZoneData = {
      name = "Online_Rushdown_Exclusion"
    }
  },
  [6] = {
    routeName = "RouteData\\MP_Rushdown06.lua",
    target = vec.vector(-962.7273, 34.62501, 431.0429, 1),
    targetRadius = 10,
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    trafficSet = 2,
    moods = OnlineModeSettings.onlineMoodsBlitz,
    lockingZoneData = {
      name = "Online_Rushdown_Exclusion"
    }
  },
  [7] = {
    routeName = "RouteData\\MP_Rushdown07.lua",
    target = vec.vector(890.6163, 8.25, 3193.086, 1),
    targetRadius = 9,
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    trafficSet = 2,
    moods = OnlineModeSettings.onlineMoodsBlitz,
    lockingZoneData = {
      name = "Online_Rushdown_Exclusion"
    }
  },
  [8] = {
    routeName = "RouteData\\MP_Rushdown08.lua",
    target = vec.vector(443.5168, 12.71902, 1092.502, 1),
    targetRadius = 9,
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    trafficSet = 2,
    moods = OnlineModeSettings.onlineMoodsBlitz,
    lockingZoneData = {
      name = "Online_Rushdown_Exclusion"
    }
  }
}
missionSetupData["Multiplayer rush down"].usableRouteIndicies = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 7,
  [8] = 8
}
local playerTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "MP Attack and Defend",
        specialName = "playerScore",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "On team round switch",
              params = {value = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Within danger zone",
              params = {value = true}
            },
            failCondition = true
          },
          {
            autoRefresh = true,
            {
              goal = "On team round switch",
              params = {value = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player hit by opponent",
              params = {}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "On team round switch",
              params = {value = true}
            },
            {
              goal = "Within zap shield",
              params = {value = true}
            },
            {
              goal = "Local player entered zap",
              params = {value = true}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Instance start time valid"
            },
            {
              goal = "Instance time above",
              params = {value = mpRushdownTimeLimit}
            }
          }
        },
        HUD = {
          {
            style = "MP Rush Down HUD"
          }
        }
      },
      [2] = {
        task = "MP Lock Zap",
        specialName = "playerZapLock",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "On team round switch",
              params = {value = true}
            },
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "MP Zap Blocked",
              params = {value = false}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "On team round switch",
              params = {value = true}
            },
            {
              goal = "Within zap shield",
              params = {value = false}
            },
            {
              goal = "MP Zap Blocked",
              params = {value = false}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "On team round switch",
              params = {value = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player vehicle damage above",
              params = {value = 1}
            },
            {
              goal = "MP Zap Blocked",
              params = {value = false}
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "On team round switch",
              params = {value = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Within zap shield",
              params = {value = true}
            },
            {
              goal = "Player vehicle damage below",
              params = {value = 1}
            },
            {
              goal = "MP Zap Blocked",
              params = {value = true}
            }
          }
        }
      }
    },
    ["networkFunctions"] = {
      [1] = function(taskObject, player, msgData)
        taskObject.namedTasks.playerScore.networkVars.playerDefendBase = taskObject.namedTasks.playerScore.networkVars.playerDefendBase + 1
      end,
      [2] = function(taskObject, player, msgData)
        if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
          local value = ProfileSettings.GetNumTimesRushdownCaptures() + 1
          OnlineAchievements.onValueChange("Rushdown", value)
          ProfileSettings.SetNumTimesRushdownCaptures(value)
        end
        taskObject.namedTasks.playerScore.networkVars.playerAttackBase = taskObject.namedTasks.playerScore.networkVars.playerAttackBase + 1
      end
    }
  }
end
local baseTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "MP Rush Down Team Score Tracking",
        specialName = "score",
        taskConditions = {
          {
            {
              goal = "Team Reached Score Limit",
              params = {value = true}
            }
          }
        }
      }
    },
    ["networkFunctions"] = {
      [1] = function(taskObject, player, msgData)
        local playerTaskObject = taskObject.coreData.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[player.playerID + 1]]
        if playerTaskObject then
          if taskObject.coreData.instance.networkVars.roundOn == PlayerGamePlay.getPlayerTeam(player.playerID) then
            playerTaskObject:sendMessage(2)
          else
            playerTaskObject:sendMessage(1)
          end
        end
        taskObject.namedTasks.score.networkVars.attackScore = taskObject.namedTasks.score.networkVars.attackScore + taskObject.coreData.instance.challenge.settings.attackPointGain
      end,
      [2] = function(taskObject, player, msgData)
        local playerTaskObject = taskObject.coreData.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[tonumber(msgData)]]
        if playerTaskObject then
          if taskObject.coreData.instance.networkVars.roundOn == PlayerGamePlay.getPlayerTeam(player.playerID) then
            playerTaskObject:sendMessage(1)
          else
            playerTaskObject:sendMessage(2)
          end
        end
        taskObject.namedTasks.score.networkVars.defenceScore = taskObject.namedTasks.score.networkVars.defenceScore + taskObject.coreData.instance.challenge.settings.defendPointGain
      end
    }
  }
end
missionSetupData["Multiplayer rush down"].taskCreatorFunctionLookups = {
  ["Player Pool"] = playerTasks,
  ["Objective Team 1"] = baseTasks
}
missionSetupData["Multiplayer rush down"].onlineProgressionData = {
  localPlayer = {
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.blitzAttackerScoreXP,
        completeText = "ID:186764",
        minShowXP = 0
      },
      {
        goal = "Reach control point",
        params = {value = true}
      }
    },
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.blitzDefenderScoreXP,
        completeText = "ID:186765",
        minShowXP = 0
      },
      {
        goal = "Destroyed attacker in shield",
        params = {value = true}
      }
    },
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.blitzAttackerAttemptXPM,
        completeText = "ID:186766",
        minShowXP = 0
      },
      {
        goal = "Attack attempt",
        params = {value = true, min = 25}
      }
    },
    getMatchBonus = function(timeInMode, threshold, baseXPValue, gainedXP)
      local matchBonus = timeInMode * baseXPValue
      if gainedXP < threshold then
        return math.max(gainedXP / threshold, onlineProgressionSystem.minimumPercentMatchBonus) * matchBonus
      end
      return matchBonus
    end
  }
}
local colour32, colour128, localTeam
missionSetupData["Multiplayer rush down"].stepHighlightColours = function(instance)
  if not instance.playerVehicles then
    instance.playerVehicles = {}
    for playerID, player in next, playerManager.players, nil do
      Menu.SetPlayerColour(player.playerID, OnlineModeSettings.pink128)
    end
  end
  for SNVID, data in next, instance.playerVehicles, nil do
    if not vehicleManager.vehiclesBySNVID[SNVID] then
      instance.playerVehicles[SNVID] = nil
    end
  end
  localTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  for playerID, player in next, playerManager.players, nil do
    if player.currentVehicle and playerID ~= localPlayer.playerID then
      if localTeam == PlayerGamePlay.getPlayerTeam(player.playerID) then
        colour32 = OnlineModeSettings.blue32
        colour128 = OnlineModeSettings.blue128
      else
        colour32 = OnlineModeSettings.red32
        colour128 = OnlineModeSettings.red128
      end
      if not instance.playerVehicles[player.currentVehicle.SNVID] then
        instance.playerVehicles[player.currentVehicle.SNVID] = {
          ID = player.playerID
        }
        player.currentVehicle:setDisplayColour(colour32, colour128)
      elseif instance.playerVehicles[player.currentVehicle.SNVID].ID ~= player.playerID then
        instance.playerVehicles[player.currentVehicle.SNVID].ID = player.playerID
        player.currentVehicle:setDisplayColour(colour32, colour128)
      end
    end
  end
  if localTeam ~= 0 then
    for i = 1, 8 do
      local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
      if taskObject and not taskObject.playerTagSet then
        local player = playerManager.players[i - 1]
        if player then
          if PlayerGamePlay.getPlayerTeam(i - 1) == localTeam then
            Menu.SetPlayerColour(player.playerID, OnlineModeSettings.blue128)
            taskObject.playerTagSet = true
          else
            Menu.SetPlayerColour(player.playerID, OnlineModeSettings.red128)
            taskObject.playerTagSet = true
          end
        end
      end
    end
  end
end
missionSetupData["Multiplayer rush down"].onlineStatisticsData = function(syncedScoreTable)
  assert(syncedScoreTable[localPlayer.playerID], "players score not found in synced score table")
  onlineStatistics.updateSpecificStatistic(syncedScoreTable[localPlayer.playerID])
  onlineStatistics.updateScoreStatistic(onlineProgressionSystem.getLocalPlayerXPGained())
end
local oldTeam
missionSetupData["Multiplayer rush down"].updatePresence = function()
end
missionSetupData["Multiplayer rush down"].missionCompleteData = function(instance, syncedScores, syncedTeamScores)
  for playerID, player in next, playerManager.players, nil do
    assert(syncedScores[playerID], "players score not found in synced score table")
    onlineScreenManager.updatePlayerScore(playerID, syncedScores[playerID])
  end
  local localPlayerTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  local teamTargetScore = instance.challenge.settings.targetScore
  local opponentTeamTotal = 0
  local opponentTeamRound = 0
  local playerTeamTotal = 0
  local playerTeamRound = 0
  if localPlayerTeam == instance.networkVars.roundOn then
    phaseManager.playerIsObjective = true
  else
    phaseManager.playerIsObjective = false
  end
  if localPlayerTeam == instance.networkVars.roundOn then
    playerTeamTotal = syncedTeamScores[1]
    opponentTeamTotal = syncedTeamScores[2]
  else
    playerTeamTotal = syncedTeamScores[2]
    opponentTeamTotal = syncedTeamScores[1]
  end
  playerTeamRound = playerTeamTotal
  opponentTeamRound = opponentTeamTotal
  if instance.networkVars.roundOn == 1 then
    if instance.isLocal then
      instance.teamScores.team1 = syncedTeamScores[1]
      instance.teamScores.team2 = syncedTeamScores[2]
    end
  else
    teamTargetScore = teamTargetScore * 2
    if localPlayerTeam == 1 then
      playerTeamTotal = playerTeamTotal + instance.teamScores.team1
      opponentTeamTotal = opponentTeamTotal + instance.teamScores.team2
    else
      playerTeamTotal = playerTeamTotal + instance.teamScores.team2
      opponentTeamTotal = opponentTeamTotal + instance.teamScores.team1
    end
    if playerTeamTotal > opponentTeamTotal then
      onlineProgressionSystem.progressionMissionComplete(true)
      onlineStatistics.updateWinStatistic(1)
      onlineStatistics.updateModeProfileWinStatistic("MP rush down")
    else
      onlineProgressionSystem.progressionMissionComplete(false)
      onlineStatistics.updateLossStatistic(1)
    end
    local results = onlineScreenManager.getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.score)
    for i, player in ipairs(results) do
      assert(player, "Player not found of error in sorting of players in onlineScreenManager.getScreenCurrentPlayerTable. i = " .. tostring(i) .. " #results = " .. tostring(results) .. " numPlayers = " .. tostring(playerManager.numberOfPlayers))
      if player.id == localPlayer.playerID then
        onlineStatistics.updatePlayerLastPositionInMode("MP rush down", i)
        break
      end
    end
  end
  onlineScreenManager.setBlueTeamCurrentScore(playerTeamTotal)
  onlineScreenManager.setBlueTeamTargetScore(teamTargetScore)
  onlineScreenManager.setBlueTeamRoundScore(playerTeamRound)
  onlineScreenManager.setRedTeamCurrentScore(opponentTeamTotal)
  onlineScreenManager.setRedTeamTargetScore(teamTargetScore)
  onlineScreenManager.setRedTeamRoundScore(opponentTeamRound)
  onlineScreenManager.setForceSortType(false)
  onlineScreenManager.setRaceCompleteData(false)
end
missionSetupData["Multiplayer rush down"].getPlayerFinalScore = function(instance, playerID)
  return instance.playerScores[playerID + 1] or -1
end
missionSetupData["Multiplayer rush down"].getTeamFinalScore = function(instance)
  local packageTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local attackScore = packageTO and packageTO.namedTasks.score and packageTO.namedTasks.score.networkVars.attackScore or 0
  local defenceScore = packageTO and packageTO.namedTasks.score and packageTO.namedTasks.score.networkVars.defenceScore or 0
  return attackScore, defenceScore
end
missionSetupData["Multiplayer rush down"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 4,
      baseRadius = baseRadius,
      numRounds = 2,
      noIndexflip = true,
      trackPlayerScores = true,
      teamGame = true,
      gridStyle = 3,
      swapGrid = true,
      missionVehicleStyle = 1,
      moodStyle = 3,
      introHUD = "MP Rush Down Start HUD",
      disableZapOnCompletion = true,
      modeTimeLimit = mpRushdownTimeLimit,
      targetScore = mpRushdownScore,
      attackPointGain = 2,
      defendPointGain = 1,
      teamCameraTransition = true
    }
  }
end
missionSetupData["Multiplayer rush down"].initiate = function(instance)
  if not instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]] then
    local index = instance.networkVars.routeIndex
    local base = packageManager.createPackage(false, instance.challenge.spawnPositions[index].target, true, 0, nil, nil, nil, nil, index, nil, true)
    instance:newActorFromAgent(OBJ_TEAM_ONE_STRING_TABLE[1], base)
  end
end
missionSetupData["Multiplayer rush down"].missionStart = function(instance)
  local localTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  if localTeam ~= instance.networkVars.roundOn then
    MPZapToAction.setZapToAction(3, instance.challenge.spawnPositions[instance.networkVars.routeIndex].target)
  end
  Network.setMaxTimeToKeepWreckedOrphan(10)
end
missionSetupData["Multiplayer rush down"].missionEnd = function(instance)
  Network.setMaxTimeToKeepWreckedOrphan(30)
end
missionSetupData["Multiplayer rush down"].onPlayerJoinInProgress = function(remotePlayer)
  if not remotePlayer then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243748")
  end
end
missionSetupData["Multiplayer rush down"].modeReadyCheck = function(instance)
  local base = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  if not base then
    return false
  end
  if base and not base.coreData.agent then
    return false
  end
  return true
end
local baseObject, attackScore
missionSetupData["Multiplayer rush down"].setModeLockingZone = function(instance)
  if not instance.dangerZone then
    attackScore = nil
    baseObject = nil
    local zapShieldLocal = false
    if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) ~= 0 then
      if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == instance.networkVars.roundOn then
        zapShieldLocal = true
      end
      local baseColour
      local blueMood = true
      if zapShieldLocal then
        baseColour = OnlineModeSettings.red128:clone()
        blueMood = false
      else
        baseColour = OnlineModeSettings.blue128:clone()
      end
      baseColour[3] = baseColour[3] / 2
      local zoneLocation = instance.challenge.spawnPositions[instance.networkVars.routeIndex].target:clone()
      if instance.challenge.spawnPositions[instance.networkVars.routeIndex].zoneYOffset then
        zoneLocation.y = zoneLocation.y + instance.challenge.spawnPositions[instance.networkVars.routeIndex].zoneYOffset
      end
      ZAPSHIELDZONE.create(zoneLocation, instance.challenge.settings.baseRadius, zapShieldLocal, baseColour)
      instance.dangerZone = true
    end
  end
end
missionSetupData["Multiplayer rush down"].update = function(instance)
  if not baseObject then
    baseObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  end
  if baseObject and instance.dangerZone and baseObject.namedTasks and baseObject.namedTasks.score and attackScore ~= baseObject.namedTasks.score.networkVars.attackScore then
    attackScore = baseObject.namedTasks.score.networkVars.attackScore
    ZAPSHIELDZONE.updateRadius(instance.challenge.settings.baseRadius * math.sqrt((instance.challenge.settings.targetScore - attackScore) / instance.challenge.settings.targetScore))
  end
  onlineProgressionSystem.progressionUpdate()
end
taskCompleteData["Multiplayer rush down"] = {}
taskCompleteData["Multiplayer rush down"].taskComplete = function(taskObject, task)
  if task.taskName == "MP Rush Down Team Score Tracking" or task.taskName == "MP Attack and Defend" then
    localPlayer:blockAbility("zap", false)
    local instance = taskObject.coreData.instance
    MPZapToAction.reset()
    if task.taskName == "MP Attack and Defend" then
      if task.condition == 1 then
        phaseManager.modeTimedOut = true
      else
        phaseManager.modeTimedOut = false
      end
    end
    if instance.isLocal and task.agent.isPlayer and task.agent.isLocal then
      for i = 1, 8 do
        local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
        if taskObject and taskObject.namedTasks.playerScore then
          local baseAttackPoints = taskObject.namedTasks.playerScore.networkVars.playerAttackBase * taskObject.coreData.instance.challenge.settings.attackPointGain
          local baseDefendPoints = taskObject.namedTasks.playerScore.networkVars.playerDefendBase * taskObject.coreData.instance.challenge.settings.defendPointGain
          instance.playerScores[i] = instance.playerScores[i] + baseAttackPoints + baseDefendPoints
        end
      end
    end
    instance:initiateOverTimePhase()
    presenceSystem.setPresenceSystemWatchedInstance()
    Mood.removeMood("RushDownZapMood")
  end
end
missionSetupData["Multiplayer rush down"].targetList = {}
