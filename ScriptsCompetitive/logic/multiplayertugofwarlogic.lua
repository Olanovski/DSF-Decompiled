module("cardSystem.logic")
missionSetupData["Multiplayer tug of war"] = {}
mpTugOfWarTimeLimit = 960
mpTugOfWarResetTime = 20
mpCaptureTheFlagPickupRadius = 5
flagCapsToWin = 5
local challengeEndTime = 20
local roundFlagCaps = 1
local capDistance = 12.5
local challengeStartTime = 10
missionSetupData["Multiplayer tug of war"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.baseA = routes["Tug of War 01"].arrows[1].position
    spawnPosition.baseB = routes["Tug of War 01"].arrows[2].position
    spawnPosition.target = routes["Tug of War 01"].arrows[3].position
    spawnPosition.positionA = routes["Tug of War 01"].checkpoints[1].position
    spawnPosition.headingA = routes["Tug of War 01"].checkpoints[1].heading
    spawnPosition.targetScore = flagCapsToWin
  end,
  [2] = function(spawnPosition)
    spawnPosition.baseA = routes["Tug of War 02"].arrows[1].position
    spawnPosition.baseB = routes["Tug of War 02"].arrows[2].position
    spawnPosition.target = routes["Tug of War 02"].arrows[3].position
    spawnPosition.positionA = routes["Tug of War 02"].checkpoints[1].position
    spawnPosition.headingA = routes["Tug of War 02"].checkpoints[1].heading
    spawnPosition.targetScore = flagCapsToWin
  end,
  [3] = function(spawnPosition)
    spawnPosition.baseA = routes["Tug of War 03"].arrows[1].position
    spawnPosition.baseB = routes["Tug of War 03"].arrows[2].position
    spawnPosition.target = routes["Tug of War 03"].arrows[3].position
    spawnPosition.positionA = routes["Tug of War 03"].checkpoints[1].position
    spawnPosition.headingA = routes["Tug of War 03"].checkpoints[1].heading
    spawnPosition.targetScore = flagCapsToWin
  end,
  [4] = function(spawnPosition)
    spawnPosition.baseA = routes["Tug of War 04"].arrows[1].position
    spawnPosition.baseB = routes["Tug of War 04"].arrows[2].position
    spawnPosition.target = routes["Tug of War 04"].arrows[3].position
    spawnPosition.positionA = routes["Tug of War 04"].checkpoints[1].position
    spawnPosition.headingA = routes["Tug of War 04"].checkpoints[1].heading
    spawnPosition.targetScore = flagCapsToWin
  end,
  [5] = function(spawnPosition)
    spawnPosition.baseA = routes["Tug of War 05"].arrows[1].position
    spawnPosition.baseB = routes["Tug of War 05"].arrows[2].position
    spawnPosition.target = routes["Tug of War 05"].arrows[3].position
    spawnPosition.positionA = routes["Tug of War 05"].checkpoints[1].position
    spawnPosition.headingA = routes["Tug of War 05"].checkpoints[1].heading
    spawnPosition.targetScore = flagCapsToWin
  end,
  [6] = function(spawnPosition)
    spawnPosition.baseA = routes["Tug of War 06"].arrows[1].position
    spawnPosition.baseB = routes["Tug of War 06"].arrows[2].position
    spawnPosition.target = routes["Tug of War 06"].arrows[3].position
    spawnPosition.positionA = routes["Tug of War 06"].checkpoints[1].position
    spawnPosition.headingA = routes["Tug of War 06"].checkpoints[1].heading
    spawnPosition.targetScore = flagCapsToWin
  end
}
missionSetupData["Multiplayer tug of war"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.baseA = nil
  spawnPosition.baseB = nil
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
end
missionSetupData["Multiplayer tug of war"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\MP_TugOfWar01.lua",
    moods = OnlineModeSettings.onlineMoodsDowntown1,
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(-769, 22, 378, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(-733.9, 30, 477, 1),
            length = 100,
            width = 100
          },
          [2] = {
            position = vec.vector(-894.9, 21, 318, 1),
            length = 110,
            width = 110
          }
        }
      }
    }
  },
  [2] = {
    routeName = "RouteData\\MP_TugOfWar02.lua",
    moods = OnlineModeSettings.onlineMoodsMarin,
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(1615, 32, -4358, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(1448, 32, -4319, 1),
            length = 100,
            width = 100
          },
          [2] = {
            position = vec.vector(1662, 32, -4447, 1),
            length = 100,
            width = 100
          }
        }
      }
    }
  },
  [3] = {
    routeName = "RouteData\\MP_TugOfWar03.lua",
    moods = OnlineModeSettings.onlineMoodsSuburbs1,
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(-3535, 43, 2190, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(-3379, 52, 2137, 1),
            length = 150,
            width = 150
          },
          [2] = {
            position = vec.vector(-3663, 44, 2150, 1),
            length = 150,
            width = 150
          }
        }
      }
    }
  },
  [4] = {
    routeName = "RouteData\\MP_TugOfWar04.lua",
    moods = OnlineModeSettings.onlineMoodsSuburbFog,
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(-125, 45, 2460, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(-124, 45.5, 2579, 1),
            length = 100,
            width = 100
          },
          [2] = {
            position = vec.vector(-227, 43.5, 2396, 1),
            length = 100,
            width = 100
          }
        }
      }
    }
  },
  [5] = {
    routeName = "RouteData\\MP_TugOfWar05.lua",
    moods = OnlineModeSettings.onlineMoodsSuburbs2,
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(-4283, 33, 1315, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(-4350, 35, 1180, 1),
            length = 150,
            width = 150
          },
          [2] = {
            position = vec.vector(-4083, 45, 1283, 1),
            length = 150,
            width = 150
          }
        }
      }
    }
  },
  [6] = {
    routeName = "RouteData\\MP_TugOfWar06.lua",
    moods = OnlineModeSettings.onlineMoodsCoastal,
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(541, 8, 1424, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(706, 8, 1386, 1),
            length = 160,
            width = 160
          },
          [2] = {
            position = vec.vector(503, 20, 1553, 1),
            length = 150,
            width = 150
          }
        }
      },
      [2] = {
        trigger = {
          position = vec.vector(485, 8, 1357, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(318, 20, 1361, 1),
            length = 140,
            width = 140
          },
          [2] = {
            position = vec.vector(507, 10, 1193, 1),
            length = 140,
            width = 140
          }
        }
      }
    }
  }
}
missionSetupData["Multiplayer tug of war"].usableRouteIndicies = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6
}
local playerTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "MP Capture the flag player",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Package active",
              params = {value = true}
            },
            {
              goal = "Package on floor",
              params = {value = false}
            },
            {
              goal = "Player is package owner",
              params = {value = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player vehicle damage above",
              params = {value = 1}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player vehicle damage below",
              params = {value = 1}
            },
            {
              goal = "Package active",
              params = {value = true}
            },
            {
              goal = "Package on floor",
              params = {value = true}
            },
            {
              goal = "Within radius of package",
              params = {value = mpCaptureTheFlagPickupRadius}
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
              params = {value = mpTugOfWarTimeLimit}
            }
          }
        },
        HUD = {
          {
            style = "MP tug of war main HUD"
          }
        }
      }
    }
  }
end
local function flagTasks(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "MP package owner tracking",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Package active",
              params = {value = true}
            },
            {
              goal = "Package on floor",
              params = {value = false}
            },
            {
              goal = "Package owner in zap",
              params = {value = true}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Package active",
              params = {value = true}
            },
            {
              goal = "Package on floor",
              params = {value = false}
            },
            {
              goal = "Package owner in zap",
              params = {value = true}
            },
            {
              goal = "Package owner changed",
              params = {value = true}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Package active",
              params = {value = true}
            },
            {
              goal = "Package on floor",
              params = {value = true}
            },
            {
              goal = "Outside radius of start location",
              params = {radius = 6}
            },
            {
              goal = "Time trigger",
              params = {value = mpTugOfWarResetTime}
            }
          }
        }
      },
      [2] = {
        task = "MP tug of war score tracking",
        specialName = "score",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Package active",
              params = {value = true}
            },
            {
              goal = "Package on floor",
              params = {value = false}
            },
            {
              goal = "Within team base",
              params = {value = capDistance}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Package activity changed",
              params = {value = 1}
            },
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            failCondition = true
          }
        },
        taskConditions = {
          {
            {
              goal = "Flag captures",
              params = {value = roundFlagCaps}
            }
          }
        }
      }
    }
  }
end
missionSetupData["Multiplayer tug of war"].taskCreatorFunctionLookups = {
  ["Player Pool"] = playerTasks,
  ["Objective Team 1"] = flagTasks
}
missionSetupData["Multiplayer tug of war"].onlineProgressionData = {
  localPlayer = {
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.ctfCaptureXP,
        completeText = "ID:186780",
        minShowXP = 0
      },
      {
        goal = "Captured the flag",
        params = {}
      }
    },
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.ctfDestroyEnemyCarrierXP,
        completeText = "ID:186781",
        minShowXP = 0
      },
      {
        goal = "Destroyed enemy flag carrier",
        params = {
          cooldown = onlineProgressionSystem.ctfDestroyEnemyCarrierCD
        }
      }
    },
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.ctfAssistCarrierXPM,
        completeText = "ID:186782",
        minShowXP = 0
      },
      {
        goal = "Within radius of flag carrier",
        params = {radius = 100}
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
missionSetupData["Multiplayer tug of war"].stepHighlightColours = function(instance)
  if not instance.playersColours then
    instance.playersColours = true
    instance.playerVehicles = {}
    for playerID, player in next, playerManager.players, nil do
      Menu.SetPlayerColour(player.playerID, OnlineModeSettings.pink128)
    end
  end
  localTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
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
  for SNVID, data in next, instance.playerVehicles, nil do
    if not vehicleManager.vehiclesBySNVID[SNVID] then
      instance.playerVehicles[SNVID] = nil
    end
  end
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
end
missionSetupData["Multiplayer tug of war"].onlineStatisticsData = function(syncedScoreTable)
  assert(syncedScoreTable[localPlayer.playerID], "players score not found in synced score table")
  onlineStatistics.updateSpecificStatistic(syncedScoreTable[localPlayer.playerID])
  onlineStatistics.updateScoreStatistic(onlineProgressionSystem.getLocalPlayerXPGained())
end
missionSetupData["Multiplayer tug of war"].missionCompleteData = function(instance, syncedScores, syncedTeamScores)
  for playerID, player in next, playerManager.players, nil do
    assert(syncedScores[playerID], "players score not found in synced score table")
    onlineScreenManager.updatePlayerScore(playerID, syncedScores[playerID])
  end
  onlineScreenManager.clearTeamData()
  onlineScreenManager.setForceSortType(false)
  onlineScreenManager.setRaceCompleteData(false)
  local playerTeamTotal = 0
  local opponentTeamTotal = 0
  if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
    playerTeamTotal = instance.teamScores.team1
    opponentTeamTotal = instance.teamScores.team2
  elseif PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 2 then
    playerTeamTotal = instance.teamScores.team2
    opponentTeamTotal = instance.teamScores.team1
  end
  if instance.networkVars.roundOn == instance.challenge.settings.numRounds then
    if playerTeamTotal > opponentTeamTotal then
      onlineProgressionSystem.progressionMissionComplete(true)
      onlineStatistics.updateWinStatistic(1)
      onlineStatistics.updateModeProfileWinStatistic("MP tug of war")
    else
      onlineProgressionSystem.progressionMissionComplete(false)
      onlineStatistics.updateLossStatistic(1)
    end
    local results = onlineScreenManager.getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.score)
    for i, player in ipairs(results) do
      assert(player, "Player not found of error in sorting of players in onlineScreenManager.getScreenCurrentPlayerTable. i = " .. tostring(i) .. " #results = " .. tostring(results) .. " numPlayers = " .. tostring(playerManager.numberOfPlayers))
      if player.id == localPlayer.playerID then
        onlineStatistics.updatePlayerLastPositionInMode("MP tug of war", i)
        break
      end
    end
  elseif PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
    onlineScreenManager.setRedTeamRoundScore(syncedTeamScores[1])
    onlineScreenManager.setBlueTeamRoundScore(syncedTeamScores[2])
  else
    onlineScreenManager.setRedTeamRoundScore(syncedTeamScores[2])
    onlineScreenManager.setBlueTeamRoundScore(syncedTeamScores[1])
  end
  onlineScreenManager.setBlueTeamCurrentScore(playerTeamTotal)
  onlineScreenManager.setRedTeamCurrentScore(opponentTeamTotal)
  onlineScreenManager.setBlueTeamTargetScore(instance.challenge.settings.targetScore)
  onlineScreenManager.setRedTeamTargetScore(instance.challenge.settings.targetScore)
end
missionSetupData["Multiplayer tug of war"].getPlayerFinalScore = function(instance, playerID)
  return instance.playerScores[playerID + 1] or -1
end
missionSetupData["Multiplayer tug of war"].getTeamFinalScore = function(instance)
  local objTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local blueTeamScore = objTO and objTO.namedTasks.score and objTO.namedTasks.score.networkVars.blueTeam or 0
  local redTeamScore = objTO and objTO.namedTasks.score and objTO.namedTasks.score.networkVars.redTeam or 0
  return redTeamScore, blueTeamScore
end
missionSetupData["Multiplayer tug of war"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 4,
      numRounds = 3,
      noIndexflip = true,
      teamGame = true,
      trackPlayerScores = true,
      gridStyle = 2,
      missionVehicleStyle = 1,
      moodStyle = 3,
      introHUD = "MP tug of war start HUD",
      disableZapOnCompletion = true,
      modeTimeLimit = mpTugOfWarTimeLimit,
      targetScore = flagCapsToWin,
      timeTrigger = 20,
      damageMultiplier = 3,
      gridStagger = 0,
      flagPickupRadius = mpCaptureTheFlagPickupRadius
    }
  }
end
missionSetupData["Multiplayer tug of war"].initiate = function(instance)
  if not instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]] then
    local index = instance.networkVars.routeIndex
    local package = packageManager.createPackage(false, instance.challenge.spawnPositions[index].target, true, instance.challenge.settings.damageMultiplier, nil, nil, nil, nil, index, true, nil)
    instance:newActorFromAgent(OBJ_TEAM_ONE_STRING_TABLE[1], package)
  end
end
missionSetupData["Multiplayer tug of war"].modeReadyCheck = function(instance)
  local flag = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  if not flag then
    return false
  end
  if flag and not flag.coreData.agent then
    return false
  end
  return true
end
missionSetupData["Multiplayer tug of war"].missionStart = function(instance)
  local packageTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  MPZapToAction.setZapToAction(2, packageTaskObject.coreData.agent)
  local modeScore = instance.teamScores.team1 + instance.teamScores.team2
  if modeScore / flagCapsToWin >= phaseManager.timeToJoinExceptionValues.tugOfWar then
    phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeException)
  end
  packageManager.setInvulnerabilityTime(2)
end
missionSetupData["Multiplayer tug of war"].onPlayerJoinInProgress = function(remotePlayer)
  if not remotePlayer then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243748")
    onlineInstructionSupport.displayPrompt("ID:234257", localPlayer.buttonLayout.zapReturn)
  end
end
missionSetupData["Multiplayer tug of war"].update = function(instance)
  if instance.isLocal and not instance.networkVars.overTime then
    local packageTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    local package = packageTO and packageTO.coreData.agent
    if package and package.isLocal and zap.vehicleInLockedArea(package.position) then
      package:packageDropped(instance.challenge.spawnPositions[instance.networkVars.routeIndex].target)
    end
  end
  onlineProgressionSystem.progressionUpdate()
end
taskCompleteData["Multiplayer tug of war"] = {}
taskCompleteData["Multiplayer tug of war"].taskComplete = function(taskObject, task)
  NetworkLog.Write("Multiplayer tug of war - taskComplete")
  if task.taskName == "MP Capture the flag player" then
    if task.condition == 1 then
      phaseManager.modeTimedOut = true
    else
      phaseManager.modeTimedOut = false
    end
  end
  local instance = taskObject.coreData.instance
  MPZapToAction.reset()
  if instance.isLocal and not instance.networkVars.isComplete then
    local objTO = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    if objTO and objTO.namedTasks.score then
      instance.teamScores.team1 = instance.teamScores.team1 + objTO.namedTasks.score.networkVars.blueTeam
      instance.teamScores.team2 = instance.teamScores.team2 + objTO.namedTasks.score.networkVars.redTeam
    end
    if instance.teamScores.team1 == instance.challenge.settings.targetScore or instance.teamScores.team2 == instance.challenge.settings.targetScore then
      instance.networkVars.roundOn = instance.challenge.settings.numRounds
    end
  end
  instance:initiateOverTimePhase()
end
