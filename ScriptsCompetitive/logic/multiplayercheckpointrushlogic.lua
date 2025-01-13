module("cardSystem.logic")
missionSetupData["Multiplayer checkpoint rush"] = {}
missionSetupData["Multiplayer checkpoint rush"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.roads = routes["Team Circuit Race 01"].roads
    spawnPosition.route = routes["Team Circuit Race 01"].checkpoints
    spawnPosition.arrows = routes["Team Circuit Race 01"].arrows
    spawnPosition.target = routes["Team Circuit Race Start 01"].checkpoints[1].position
    spawnPosition.positionA = routes["Team Circuit Race Start 01"].checkpoints[1].position
    spawnPosition.headingA = routes["Team Circuit Race Start 01"].checkpoints[1].heading
  end,
  [2] = function(spawnPosition)
    spawnPosition.roads = routes["Team Circuit Race 02"].roads
    spawnPosition.route = routes["Team Circuit Race 02"].checkpoints
    spawnPosition.arrows = routes["Team Circuit Race 02"].arrows
    spawnPosition.target = routes["Team Circuit Race Start 02"].checkpoints[1].position
    spawnPosition.positionA = routes["Team Circuit Race Start 02"].checkpoints[1].position
    spawnPosition.headingA = routes["Team Circuit Race Start 02"].checkpoints[1].heading
  end,
  [3] = function(spawnPosition)
    spawnPosition.roads = routes["Team Circuit Race 03"].roads
    spawnPosition.route = routes["Team Circuit Race 03"].checkpoints
    spawnPosition.arrows = routes["Team Circuit Race 03"].arrows
    spawnPosition.target = routes["Team Circuit Race Start 03"].checkpoints[1].position
    spawnPosition.positionA = routes["Team Circuit Race Start 03"].checkpoints[1].position
    spawnPosition.headingA = routes["Team Circuit Race Start 03"].checkpoints[1].heading
  end,
  [4] = function(spawnPosition)
    spawnPosition.roads = routes["Team Circuit Race 04"].roads
    spawnPosition.route = routes["Team Circuit Race 04"].checkpoints
    spawnPosition.arrows = routes["Team Circuit Race 04"].arrows
    spawnPosition.target = routes["Team Circuit Race Start 04"].checkpoints[1].position
    spawnPosition.positionA = routes["Team Circuit Race Start 04"].checkpoints[1].position
    spawnPosition.headingA = routes["Team Circuit Race Start 04"].checkpoints[1].heading
  end,
  [5] = function(spawnPosition)
    spawnPosition.roads = routes["Team Circuit Race 05"].roads
    spawnPosition.route = routes["Team Circuit Race 05"].checkpoints
    spawnPosition.arrows = routes["Team Circuit Race 05"].arrows
    spawnPosition.target = routes["Team Circuit Race Start 05"].checkpoints[1].position
    spawnPosition.positionA = routes["Team Circuit Race Start 05"].checkpoints[1].position
    spawnPosition.headingA = routes["Team Circuit Race Start 05"].checkpoints[1].heading
  end
}
missionSetupData["Multiplayer checkpoint rush"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.roads = nil
  spawnPosition.route = nil
  spawnPosition.arrows = nil
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
end
missionSetupData["Multiplayer checkpoint rush"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\MP_TeamCircuitRace01.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsCoastal,
    trafficSet = 3
  },
  [2] = {
    routeName = "RouteData\\MP_TeamCircuitRace02.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsMarin,
    trafficSet = 3
  },
  [3] = {
    routeName = "RouteData\\MP_TeamCircuitRace03.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsFreeway,
    trafficSet = 3
  },
  [4] = {
    routeName = "RouteData\\MP_TeamCircuitRace04.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsFreeway,
    trafficSet = 3
  },
  [5] = {
    routeName = "RouteData\\MP_TeamCircuitRace05.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsMarin,
    trafficSet = 3
  }
}
missionSetupData["Multiplayer checkpoint rush"].usableRouteIndicies = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5
}
mpCheckpointRushTimeLimit = 480
local playerTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "MP Circuit Race Checkpoints",
        specialName = "checkpoints",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "MP Checkpoint Tracker"
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Online Team Checkpoint Gate"] = {}
              }
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
              params = {value = mpCheckpointRushTimeLimit}
            }
          }
        },
        HUD = {
          {
            style = "MP Checkpoint Rush HUD"
          }
        }
      },
      [2] = {
        task = "MP Gate Activation",
        goalConditions = {
          {
            {
              goal = "Target same gate",
              params = {value = false}
            },
            {
              goal = "Global on target list",
              params = {value = false}
            }
          }
        }
      },
      [3] = {
        task = "MP Team Circuit Race Speed Clamp",
        specialName = "speedClamp",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Lead playerID changed",
              params = {value = true}
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
        task = "MP Team Circuit Race Tracking",
        specialName = "gateTracking",
        taskConditions = {
          {
            {
              goal = "Gate Limit Reached",
              params = {value = true}
            }
          }
        }
      }
    },
    ["networkFunctions"] = {
      [1] = function(taskObject, fromPlayer, msgData)
        if taskObject and taskObject.namedTasks and taskObject.namedTasks.gateTracking then
          local checkpointNumber = tonumber(msgData)
          local instance = taskObject.coreData.instance
          if checkpointNumber > taskObject.namedTasks.gateTracking.networkVars.totalCheckPoints then
            taskObject.namedTasks.gateTracking.networkVars.totalCheckPoints = checkpointNumber
            local numCheckPoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
            if checkpointNumber <= numCheckPoints then
              taskObject.namedTasks.gateTracking.networkVars.leadCheckPoint = checkpointNumber
              taskObject.namedTasks.gateTracking.networkVars.leadPlayerID = fromPlayer.playerID
            else
              local number = checkpointNumber
              while numCheckPoints < number do
                number = number - numCheckPoints
              end
              taskObject.namedTasks.gateTracking.networkVars.leadCheckPoint = number
              taskObject.namedTasks.gateTracking.networkVars.leadPlayerID = fromPlayer.playerID
            end
          end
        end
      end
    }
  }
end
missionSetupData["Multiplayer checkpoint rush"].taskCreatorFunctionLookups = {
  ["Objective Team 1"] = packageTasks,
  ["Player Pool"] = playerTasks
}
missionSetupData["Multiplayer checkpoint rush"].onlineProgressionData = {
  localPlayer = {
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.checkpointRushCheckpointXP,
        completeText = "ID:243727",
        minShowXP = 0,
        groupXP = true,
        groupLimit = 4
      },
      {
        goal = "Checkpoint crossed",
        params = {value = true, ignoreRank = true}
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
missionSetupData["Multiplayer checkpoint rush"].stepHighlightColours = function(instance)
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
missionSetupData["Multiplayer checkpoint rush"].onlineStatisticsData = function()
  local scoreTable = onlineScreenManager.getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.score)
  local playerPosition = -1
  for i, player in ipairs(scoreTable) do
    assert(player, "Player not found of error in sorting of players in onlineScreenManager.getScreenCurrentPlayerTable. i = " .. tostring(i) .. " #scoreTable = " .. tostring(scoreTable) .. " numPlayers = " .. tostring(playerManager.numberOfPlayers))
    if player.id == localPlayer.playerID then
      playerPosition = i
      break
    end
  end
  assert(playerPosition > 0, "Failed to get the local players position")
  local winValue = onlineStatistics.getWinStatistic()
  local lossValue = onlineStatistics.getLossStatistic()
  local specific = onlineStatistics.getSpecificStatistic()
  onlineStatistics.updateSpecificStatistic(specific * -1)
  local numOfRaces = winValue + lossValue
  assert(numOfRaces > 0, "Checkpoint Rush Statistic Gen Error: Number of races should be at least 1 as you just completed a Race")
  local positionTotal = specific * (numOfRaces - 1)
  positionTotal = positionTotal + playerPosition
  local average = positionTotal / numOfRaces
  assert(average > 0 and average < 9, "Checkpoint Rush Statistic Gen Error: average must be between [0,8], value " .. tostring(average))
  onlineStatistics.updateSpecificStatistic(average)
  onlineStatistics.updateScoreStatistic(onlineProgressionSystem.getLocalPlayerXPGained())
end
missionSetupData["Multiplayer checkpoint rush"].missionCompleteData = function(instance, syncedScoreTable)
  for playerID, player in next, playerManager.players, nil do
    assert(syncedScoreTable[playerID], "players score not found in synced score table")
    onlineScreenManager.updatePlayerScore(playerID, syncedScoreTable[playerID])
  end
  local results = onlineScreenManager.getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.score)
  for i, player in ipairs(results) do
    assert(player, "Player not found of error in sorting of players in onlineScreenManager.getScreenCurrentPlayerTable. i = " .. tostring(i) .. " #results = " .. tostring(results) .. " numPlayers = " .. tostring(playerManager.numberOfPlayers))
    if i == 1 then
      if player.id == localPlayer.playerID then
        onlineProgressionSystem.progressionMissionComplete(true)
        onlineStatistics.updateWinStatistic(1)
        onlineStatistics.updateModeProfileWinStatistic("MP checkpoint rush")
      else
        onlineProgressionSystem.progressionMissionComplete(false)
        onlineStatistics.updateLossStatistic(1)
      end
    end
    if player.id == localPlayer.playerID then
      onlineStatistics.updatePlayerLastPositionInMode("MP checkpoint rush", i)
      break
    end
  end
  onlineScreenManager.setForceSortType(false)
  onlineScreenManager.setRaceCompleteData(false)
end
missionSetupData["Multiplayer checkpoint rush"].getLocalPlayerFinalScore = function()
  local playerTO = localPlayer.getTaskObject()
  return playerTO.namedTasks.checkpoints and playerTO and 0
end
missionSetupData["Multiplayer checkpoint rush"].getPlayerFinalScore = function(instance, playerID)
  local playerTO = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[playerID + 1]]
  return playerTO.namedTasks.checkpoints and playerTO and 0
end
missionSetupData["Multiplayer checkpoint rush"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 2,
      spoolStartArea = true,
      gridStyle = 1,
      missionVehicleStyle = 1,
      moodStyle = 2,
      introHUD = "MP Checkpoint Rush Start HUD",
      teamGame = false,
      modeTimeLimit = mpCheckpointRushTimeLimit,
      speedClamp = 0.9,
      gridStagger = 0,
      disableZapOnCompletion = true
    }
  }
end
missionSetupData["Multiplayer checkpoint rush"].initiate = function(instance)
  if not instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]] then
    local package = packageManager.createPackage(false, vec.vector(0, 0, 0, 1), true, 0, nil, nil, nil, nil, 0, true)
    instance:newActorFromAgent(OBJ_TEAM_ONE_STRING_TABLE[1], package)
  end
end
missionSetupData["Multiplayer checkpoint rush"].missionStart = function(instance)
  if not instance.missionStartCalled then
    local routeIndex = instance.networkVars.routeIndex
    local route = instance.challenge.spawnPositions[routeIndex].route
    checkpointSystem.clearNoneSyncronisedCheckpoint()
    for i, checkpointData in ipairs(route) do
      checkpointSystem.createNoneSyncronisedCheckpoint(instance.instanceID, 1, checkpointData)
    end
  end
  if localPlayer.currentVehicle then
    checkpointTracker.addTracker(localPlayer:getTaskObject(), localPlayer.currentVehicle.gameVehicle)
  end
  instance.missionStartCalled = true
end
missionSetupData["Multiplayer checkpoint rush"].onPlayerJoinInProgress = function(remotePlayer)
  if not remotePlayer then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243748")
    onlineInstructionSupport.displayPrompt("ID:234257", localPlayer.buttonLayout.zapReturn)
  end
end
missionSetupData["Multiplayer checkpoint rush"].modeReadyCheck = function(instance)
  local package = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  if package and package.coreData.agent then
    return true
  end
  return false
end
missionSetupData["Multiplayer checkpoint rush"].update = function(instance)
  local package = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  if package.namedTasks.gateTracking and package.namedTasks.gateTracking.networkVars then
    local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(instance.instanceID, 1)
    local leadCheckpoint = allCheckpoints[package.namedTasks.gateTracking.networkVars.leadCheckPoint].position
    local routeIndex = instance.networkVars.routeIndex
    local leadCheckpointHeading = instance.challenge.spawnPositions[routeIndex].route[package.namedTasks.gateTracking.networkVars.leadCheckPoint].heading
    if not package.rapidShiftTarget then
      MPZapToAction.setZapToAction(3, leadCheckpoint, leadCheckpointHeading)
      package.rapidShiftTarget = leadCheckpoint
    elseif package.rapidShiftTarget ~= leadCheckpoint then
      MPZapToAction.updateZapToActionTarget(leadCheckpoint, leadCheckpointHeading)
      package.rapidShiftTarget = leadCheckpoint
    end
  end
  if checkpointSystem.isOnlineCheckpointSystemSetup() then
    checkpointSystem.updateOnlineCheckpointScoreTracking()
  else
    checkpointSystem.setupOnlineCheckpointScoreTracking(instance, 1)
  end
  onlineProgressionSystem.progressionUpdate()
end
taskCompleteData["Multiplayer checkpoint rush"] = {}
taskCompleteData["Multiplayer checkpoint rush"].taskComplete = function(taskObject, task)
  if task.taskName == "MP Circuit Race Checkpoints" and taskObject.coreData.agent.isPlayer and taskObject.coreData.agent.isLocal then
    if task.condition == 1 then
      phaseManager.modeTimedOut = true
    else
      phaseManager.modeTimedOut = false
    end
  end
  localPlayer:blockAbility("zap", false)
  scoreSystem.stopAbilityDrain(localPlayer.localID, false)
  MPZapToAction.reset()
  taskObject.coreData.instance:initiateOverTimePhase()
end
local getPlayerDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(taskObject.coreData.instance.instanceID, 1)
  local targetsToAdd = {}
  local targetData = {}
  if dynamicListID then
    local targets = task.dynamicTargets
    local numTargets = #targets
    local targetID = task.networkVars.nextCheckpoint + 1
    local cpData = {
      cpRemove = {},
      lastCheckpoint = 1
    }
    local package = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    local numCheckPoints = #allCheckpoints
    cpData.lastCheckpoint = task.networkVars.nextCheckpoint
    if numTargets > 1 then
      for i = 1, dynamicListID - 1 do
        table.insert(targetData, i)
      end
      cpData.cpRemove = targetData
    end
    if dynamicListID ~= numTargets then
      local nextTarget = targets[dynamicListID + 1].checkpointNum
      task.networkVars.nextCheckpoint = nextTarget
    else
      task.networkVars.nextCheckpoint = targets[dynamicListID].checkpointNum
      if task.networkVars.nextCheckpoint + 1 > #allCheckpoints then
        task.networkVars.nextCheckpoint = 1
      else
        task.networkVars.nextCheckpoint = task.networkVars.nextCheckpoint + 1
      end
      checkpointSystem.resetOnlineCheckpoint(task.networkVars.nextCheckpoint)
      table.insert(targetsToAdd, allCheckpoints[task.networkVars.nextCheckpoint])
    end
    if #targetsToAdd > 0 and #targetData > 0 then
      for i, addCP in ripairs(targetsToAdd) do
        for j, removeCP in ripairs(cpData.cpRemove) do
          if addCP.checkpointNum == targets[removeCP].checkpointNum then
            checkpointSystem.resetOnlineCheckpoint(addCP.checkpointNum)
            table.remove(cpData.cpRemove, j)
            table.remove(targetsToAdd, i)
          end
        end
      end
    end
    return targetsToAdd, cpData
  else
    return {
      allCheckpoints[task.networkVars.nextCheckpoint]
    }, targetData
  end
end
missionSetupData["Multiplayer checkpoint rush"].targetList = {
  ["Player Pool"] = getPlayerDynamicTargets
}
