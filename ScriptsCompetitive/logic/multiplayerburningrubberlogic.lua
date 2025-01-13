module("cardSystem.logic")
missionSetupData["Multiplayer burning rubber"] = {}
missionSetupData["Multiplayer burning rubber"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.roads = routes["MP Burning Rubber Route 01"].roads
    spawnPosition.arrows = routes["MP Burning Rubber Route 01"].arrows
    spawnPosition.route = routes["MP Burning Rubber Route 01"].checkpoints
    spawnPosition.target = routes["MP Burning Rubber Start 01"].checkpoints[1].position
    spawnPosition.positionA = routes["MP Burning Rubber Start 01"].checkpoints[1].position
    spawnPosition.headingA = routes["MP Burning Rubber Start 01"].checkpoints[1].heading
    spawnPosition.targetScore = #routes["MP Burning Rubber Route 01"].checkpoints
  end,
  [2] = function(spawnPosition)
    spawnPosition.roads = routes["MP Burning Rubber Route 02"].roads
    spawnPosition.arrows = routes["MP Burning Rubber Route 02"].arrows
    spawnPosition.route = routes["MP Burning Rubber Route 02"].checkpoints
    spawnPosition.target = routes["MP Burning Rubber Start 02"].checkpoints[1].position
    spawnPosition.positionA = routes["MP Burning Rubber Start 02"].checkpoints[1].position
    spawnPosition.headingA = routes["MP Burning Rubber Start 02"].checkpoints[1].heading
    spawnPosition.targetScore = #routes["MP Burning Rubber Route 02"].checkpoints
  end,
  [3] = function(spawnPosition)
    spawnPosition.roads = routes["MP Burning Rubber Route 03"].roads
    spawnPosition.arrows = routes["MP Burning Rubber Route 03"].arrows
    spawnPosition.route = routes["MP Burning Rubber Route 03"].checkpoints
    spawnPosition.target = routes["MP Burning Rubber Start 03"].checkpoints[1].position
    spawnPosition.positionA = routes["MP Burning Rubber Start 03"].checkpoints[1].position
    spawnPosition.headingA = routes["MP Burning Rubber Start 03"].checkpoints[1].heading
    spawnPosition.targetScore = #routes["MP Burning Rubber Route 03"].checkpoints
  end,
  [4] = function(spawnPosition)
    spawnPosition.roads = routes["MP Burning Rubber Route 04"].roads
    spawnPosition.arrows = routes["MP Burning Rubber Route 04"].arrows
    spawnPosition.route = routes["MP Burning Rubber Route 04"].checkpoints
    spawnPosition.target = routes["MP Burning Rubber Start 04"].checkpoints[1].position
    spawnPosition.positionA = routes["MP Burning Rubber Start 04"].checkpoints[1].position
    spawnPosition.headingA = routes["MP Burning Rubber Start 04"].checkpoints[1].heading
    spawnPosition.targetScore = #routes["MP Burning Rubber Route 04"].checkpoints
  end,
  [5] = function(spawnPosition)
    spawnPosition.roads = routes["MP Burning Rubber Route 05"].roads
    spawnPosition.arrows = routes["MP Burning Rubber Route 05"].arrows
    spawnPosition.route = routes["MP Burning Rubber Route 05"].checkpoints
    spawnPosition.target = routes["MP Burning Rubber Start 05"].checkpoints[1].position
    spawnPosition.positionA = routes["MP Burning Rubber Start 05"].checkpoints[1].position
    spawnPosition.headingA = routes["MP Burning Rubber Start 05"].checkpoints[1].heading
    spawnPosition.targetScore = #routes["MP Burning Rubber Route 05"].checkpoints
  end,
  [6] = function(spawnPosition)
    spawnPosition.roads = routes["MP Burning Rubber Route 06"].roads
    spawnPosition.arrows = routes["MP Burning Rubber Route 06"].arrows
    spawnPosition.route = routes["MP Burning Rubber Route 06"].checkpoints
    spawnPosition.target = routes["MP Burning Rubber Start 06"].checkpoints[1].position
    spawnPosition.positionA = routes["MP Burning Rubber Start 06"].checkpoints[1].position
    spawnPosition.headingA = routes["MP Burning Rubber Start 06"].checkpoints[1].heading
    spawnPosition.targetScore = #routes["MP Burning Rubber Route 06"].checkpoints
  end
}
missionSetupData["Multiplayer burning rubber"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.roads = nil
  spawnPosition.arrows = nil
  spawnPosition.route = nil
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
  spawnPosition.targetScore = nil
end
missionSetupData["Multiplayer burning rubber"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\MP_BurningRubber01.lua",
    propData = {
      name = "BurningRubber01"
    },
    lockingZoneData = {
      name = "Online_BurningRubber01"
    },
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsDowntownFog,
    flagOne = vec.vector(1270.44, 5.84, 1024.86, 1),
    flagTwo = vec.vector(1290.33, 5.8, 1030.66, 1)
  },
  [2] = {
    routeName = "RouteData\\MP_BurningRubber02.lua",
    lockingZoneData = {
      name = "Online_BurningRubber02"
    },
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsSuburbs1,
    flagOne = vec.vector(-2757.17, 63.23, 1477.3, 1),
    flagTwo = vec.vector(-2763.62, 63.19, 1476.92, 1)
  },
  [3] = {
    routeName = "RouteData\\MP_BurningRubber03.lua",
    propData = {
      name = "BurningRubber03"
    },
    lockingZoneData = {
      name = "Online_BurningRubber03"
    },
    vehicleSet = OnlineModeSettings.vehicleTypeMixed,
    moods = OnlineModeSettings.onlineMoodsNatural1,
    flagOne = vec.vector(-1164.34, 174.74, 4124.9, 1),
    flagTwo = vec.vector(-1160.5, 174.87, 4121.41, 1)
  },
  [4] = {
    routeName = "RouteData\\MP_BurningRubber04.lua",
    lockingZoneData = {
      name = "Online_BurningRubber04"
    },
    vehicleSet = OnlineModeSettings.vehicleTypeMixed,
    moods = OnlineModeSettings.onlineMoodsNatural2,
    flagOne = vec.vector(-3589.03, 123.83, -2718.37, 1),
    flagTwo = vec.vector(-3579.5, 123.87, -2713.69, 1)
  },
  [5] = {
    routeName = "RouteData\\MP_BurningRubber05.lua",
    lockingZoneData = {
      name = "Online_BurningRubber05"
    },
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsSuburbs2,
    flagOne = vec.vector(-1755.93, 73.32, 2052.26, 1),
    flagTwo = vec.vector(-1747.96, 73.29, 2042.6, 1)
  },
  [6] = {
    routeName = "RouteData\\MP_BurningRubber06.lua",
    lockingZoneData = {
      name = "Online_BurningRubber06"
    },
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsMarin,
    flagOne = vec.vector(561.62, 30.57, -3807.44, 1),
    flagTwo = vec.vector(556.9, 30.53, -3803.8, 1)
  }
}
missionSetupData["Multiplayer burning rubber"].usableRouteIndicies = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6
}
mpBurningRubberInvunTime = 5
mpBurningRubberDecayTime = 10
mpBurningRubberLapCount = 0
mpBurningRubberTimeLimit = 480
mpBurningRubberTorchPickupRadius = 5
local getPackageTaskList = function()
  return {
    [1] = {
      [1] = {
        task = "MP Torch Fuel",
        specialName = "power",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Torch owner changed"
            }
          }
        }
      },
      [2] = {
        task = "Burning Rubber Checkpoints",
        specialName = "checkpoints",
        dynamicTargets = true,
        coreData = {totalLaps = mpBurningRubberLapCount},
        goalConditions = {
          {
            {
              goal = "Package owner within strip of road",
              params = {value = 6}
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
                  noArrows = true,
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
local getPlayerTaskList = function()
  return {
    [1] = {
      [1] = {
        task = "Payload Tracking",
        specialName = "score",
        taskConditions = {
          {
            {
              goal = "Instance start time valid"
            },
            {
              goal = "Instance time above",
              params = {value = mpBurningRubberTimeLimit}
            }
          }
        },
        HUD = {
          {
            style = "MP Burning Rubber HUD"
          }
        }
      },
      [2] = {
        task = "MP Burning Rubber Objective Collision",
        goalConditions = {
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
              goal = "Team Package active",
              params = {value = true}
            },
            {
              goal = "Team Package on floor",
              params = {value = true}
            },
            {
              goal = "Within radius of team package",
              params = {value = mpBurningRubberTorchPickupRadius}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Team Package active",
              params = {value = true}
            },
            {
              goal = "Team Package on floor",
              params = {value = false}
            },
            {
              goal = "Player is team package owner",
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
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player in package vehicle",
              params = {value = false, team = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            },
            {
              goal = "Collided with objective agent",
              params = {value = true, team = true}
            }
          }
        }
      },
      [3] = {
        task = "MP Burning Rubber Clamp",
        coreData = {powerLossTime = mpBurningRubberDecayTime, speedRestriction = 0},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player in package vehicle",
              params = {value = true, team = true}
            },
            {
              goal = "Time trigger",
              params = {value = 20}
            },
            {
              goal = "Synced time trigger",
              params = {
                coreValue = "powerLossTime"
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Single Fire Player in package vehicle",
              params = {value = true, team = true}
            },
            {
              goal = "Single Fire Player in package vehicle",
              params = {value = false, team = true}
            }
          }
        }
      },
      [4] = {
        task = "Restrict Local Player Zap",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player in package vehicle",
              params = {value = true, team = true}
            },
            {
              goal = "MP Local player zap enabled",
              params = {value = true}
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player vehicle damage above",
              params = {value = 1}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player in package vehicle",
              params = {value = false, team = true}
            },
            {
              goal = "MP Local player zap enabled",
              params = {value = false}
            }
          }
        }
      }
    },
    ["networkFunctions"] = {
      [1] = function(taskObject, player, msgData)
        taskObject.namedTasks.score.networkVars.payload = taskObject.namedTasks.score.networkVars.payload + 1
      end
    }
  }
end
missionSetupData["Multiplayer burning rubber"].taskCreatorFunctionLookups = {
  ["Objective Team 1"] = getPackageTaskList,
  ["Objective Team 2"] = getPackageTaskList,
  ["Player Pool"] = getPlayerTaskList
}
missionSetupData["Multiplayer burning rubber"].onlineProgressionData = {
  localPlayer = {
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.relayRaceTeamCheckpointXP,
        completeText = "ID:186763",
        minShowXP = 0
      },
      {
        goal = "Team crossed checkpoint",
        params = {value = true}
      }
    },
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.relayRaceTeamTorchPassXP,
        completeText = "ID:243726",
        minShowXP = 0
      },
      {
        goal = "Team passed package",
        params = {
          value = true,
          cooldown = onlineProgressionSystem.relayRaceTeamTorchPassCD
        }
      }
    },
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.relayRaceDamageEnemyCarrierXP,
        completeText = "ID:186762",
        minShowXP = 0
      },
      {
        goal = "Damaged opposing team objective",
        params = {
          cooldown = onlineProgressionSystem.relayRaceDamageEnemyCarrierCD,
          minForce = 3500
        }
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
missionSetupData["Multiplayer burning rubber"].stepHighlightColours = function(instance)
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
missionSetupData["Multiplayer burning rubber"].onlineStatisticsData = function(syncedScores)
  assert(syncedScores[localPlayer.playerID], "players score not found in synced score table")
  onlineStatistics.updateSpecificStatistic(syncedScores[localPlayer.playerID])
  onlineStatistics.updateScoreStatistic(onlineProgressionSystem.getLocalPlayerXPGained())
end
missionSetupData["Multiplayer burning rubber"].missionCompleteData = function(instance, syncedScores, syncedTeamScores)
  for playerID, player in next, playerManager.players, nil do
    assert(syncedScores[playerID], "players score not found in synced score table")
    onlineScreenManager.updatePlayerScore(playerID, syncedScores[playerID])
  end
  local playerTeamTotal = 0
  local opponentTeamTotal = 0
  local targetScore = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
  if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
    playerTeamTotal = syncedTeamScores[1]
    opponentTeamTotal = syncedTeamScores[2]
  elseif PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 2 then
    playerTeamTotal = syncedTeamScores[2]
    opponentTeamTotal = syncedTeamScores[1]
  end
  local playerTeamWon = playerTeamTotal > opponentTeamTotal
  if playerTeamWon then
    onlineStatistics.updateWinStatistic(1)
    onlineStatistics.updateModeProfileWinStatistic("MP burning rubber")
    onlineProgressionSystem.progressionMissionComplete(true)
  else
    onlineStatistics.updateLossStatistic(1)
    onlineProgressionSystem.progressionMissionComplete(false)
  end
  local results = onlineScreenManager.getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.score)
  for i, player in ipairs(results) do
    assert(player, "Player not found, an error in sorting of players in onlineScreenManager.getScreenCurrentPlayerTable. i = " .. tostring(i) .. " #results = " .. tostring(results) .. " numPlayers = " .. tostring(playerManager.numberOfPlayers))
    if player.id == localPlayer.playerID then
      onlineStatistics.updatePlayerLastPositionInMode("MP burning rubber", i)
      break
    end
  end
  onlineScreenManager.setBlueTeamCurrentScore(playerTeamTotal)
  onlineScreenManager.setBlueTeamTargetScore(targetScore)
  onlineScreenManager.setRedTeamCurrentScore(opponentTeamTotal)
  onlineScreenManager.setRedTeamTargetScore(targetScore)
  onlineScreenManager.setForceSortType(false)
  onlineScreenManager.setRaceCompleteData(false)
end
missionSetupData["Multiplayer burning rubber"].getLocalPlayerFinalScore = function()
  local playerTO = localPlayer.getTaskObject()
  return playerTO.namedTasks.score and playerTO and 0
end
missionSetupData["Multiplayer burning rubber"].getPlayerFinalScore = function(instance, playerID)
  local playerTO = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[playerID + 1]]
  return playerTO.namedTasks.score and playerTO and 0
end
missionSetupData["Multiplayer burning rubber"].getTeamFinalScore = function(instance)
  local blueTorchTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local redTorchTO = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  local targetScore = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
  if blueTorchTO and blueTorchTO.namedTasks.checkpoints and redTorchTO and redTorchTO.namedTasks.checkpoints then
    local teamOneScore = blueTorchTO.namedTasks.checkpoints.networkVars.checkpoints - 1 + blueTorchTO.namedTasks.checkpoints.networkVars.laps * targetScore
    local teamTwoScore = redTorchTO.namedTasks.checkpoints.networkVars.checkpoints - 1 + redTorchTO.namedTasks.checkpoints.networkVars.laps * targetScore
    return teamOneScore, teamTwoScore
  end
  return 0, 0
end
missionSetupData["Multiplayer burning rubber"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 4,
      gridStyle = 2,
      powerLossTime = mpBurningRubberDecayTime,
      teamGame = true,
      missionVehicleStyle = 1,
      moodStyle = 2,
      introHUD = "MP Burning Rubber Start HUD",
      disableZapOnCompletion = true,
      raceMode = true,
      modeTimeLimit = mpBurningRubberTimeLimit,
      totalLaps = mpBurningRubberLapCount,
      relayRaceArrows = true,
      invunTime = mpBurningRubberInvunTime,
      gridStagger = 0,
      torchPickupRadius = mpBurningRubberTorchPickupRadius
    }
  }
end
missionSetupData["Multiplayer burning rubber"].missionStart = function(instance)
  if not instance.missionStartCalled then
    local routeIndex = instance.networkVars.routeIndex
    local route = instance.challenge.spawnPositions[routeIndex].route
    checkpointSystem.clearNoneSyncronisedCheckpoint()
    for i, checkpointData in ipairs(route) do
      checkpointSystem.createNoneSyncronisedCheckpoint(instance.instanceID, 1, checkpointData)
    end
  end
  local localTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  local torchTaskObject
  if localTeam == 1 then
    torchTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  else
    torchTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  end
  torchTaskObject.oldAgent = torchTaskObject.coreData.agent
  MPZapToAction.setZapToAction(2, torchTaskObject.coreData.agent)
  packageManager.setUpdateZapToActionType(2)
  packageManager.setInvulnerabilityTime(instance.challenge.settings.invunTime)
  packageManager.setlockOwnerInPackageType(true)
  instance.missionStartCalled = true
end
missionSetupData["Multiplayer burning rubber"].onPlayerJoinInProgress = function(remotePlayer)
  if not remotePlayer then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243748")
    onlineInstructionSupport.displayPrompt("ID:234257", localPlayer.buttonLayout.zapReturn)
  end
end
missionSetupData["Multiplayer burning rubber"].initiate = function(instance)
  if not instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]] then
    local index = instance.networkVars.routeIndex
    local package = packageManager.createPackage(false, instance.challenge.spawnPositions[index].flagOne, true, nil, nil, nil, nil, nil, index, true, nil)
    instance:newActorFromAgent(OBJ_TEAM_ONE_STRING_TABLE[1], package)
  end
  if not instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]] then
    local index = instance.networkVars.routeIndex
    local package = packageManager.createPackage(false, instance.challenge.spawnPositions[index].flagTwo, true, nil, nil, nil, nil, nil, index, true, nil)
    instance:newActorFromAgent(OBJ_TEAM_TWO_STRING_TABLE[1], package)
  end
end
missionSetupData["Multiplayer burning rubber"].modeReadyCheck = function(instance)
  local torchObjectOne = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local torchObjectTwo = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  if not torchObjectOne then
    return false
  end
  if torchObjectOne and not torchObjectOne.coreData.agent then
    return false
  end
  if not torchObjectTwo then
    return false
  end
  if torchObjectTwo and not torchObjectTwo.coreData.agent then
    return false
  end
  return true
end
missionSetupData["Multiplayer burning rubber"].update = function(instance)
  local torchTaskObject
  if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
    torchTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  else
    torchTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  end
  if torchTaskObject and torchTaskObject.oldAgent ~= torchTaskObject.coreData.agent then
    torchTaskObject.oldAgent = torchTaskObject.coreData.agent
  end
  onlineProgressionSystem.progressionUpdate()
end
taskCompleteData["Multiplayer burning rubber"] = {}
taskCompleteData["Multiplayer burning rubber"].taskComplete = function(taskObject, task)
  local instance = taskObject.coreData.instance
  local playerTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  if task.taskName == "Burning Rubber Checkpoints" or task.taskName == "Payload Tracking" then
    local localTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
    local objActorID = OBJ_TEAM_ONE_STRING_TABLE[1]
    if localTeam == 2 then
      objActorID = OBJ_TEAM_TWO_STRING_TABLE[1]
    end
    if task.taskName == "Payload Tracking" then
      if task.condition == 1 then
        phaseManager.modeTimedOut = true
      else
        phaseManager.modeTimedOut = false
      end
    end
    MPZapToAction.reset()
    instance:initiateOverTimePhase()
  end
end
local getTorchVehicleDynamicTargets = function(taskObject, task, dynamicListID)
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
missionSetupData["Multiplayer burning rubber"].targetList = {
  ["Objective Team 1"] = getTorchVehicleDynamicTargets,
  ["Objective Team 2"] = getTorchVehicleDynamicTargets
}
