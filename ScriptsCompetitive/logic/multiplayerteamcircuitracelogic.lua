module("cardSystem.logic")
missionSetupData["Multiplayer team circuit race"] = {}
missionSetupData["Multiplayer team circuit race"].buildSpawnPositionFunctions = {
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
missionSetupData["Multiplayer team circuit race"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.roads = nil
  spawnPosition.route = nil
  spawnPosition.arrows = nil
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
end
missionSetupData["Multiplayer team circuit race"].spawnPositions = {
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
missionSetupData["Multiplayer team circuit race"].usableRouteIndicies = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5
}
mpTeamCircuitRaceTimeLimit = 480
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
              params = {value = mpTeamCircuitRaceTimeLimit}
            }
          }
        },
        HUD = {
          {
            style = "MP Team Circuit Race HUD"
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
          local redTeamSize = 0
          local blueTeamSize = 0
          for playerID, player in next, playerManager.players, nil do
            if PlayerGamePlay.getPlayerTeam(playerID) == 1 then
              blueTeamSize = blueTeamSize + 1
            else
              redTeamSize = redTeamSize + 1
            end
          end
          if PlayerGamePlay.getPlayerTeam(fromPlayer.playerID) == 1 then
            taskObject.namedTasks.gateTracking.networkVars.blueTeamTotalCheckPoints = taskObject.namedTasks.gateTracking.networkVars.blueTeamTotalCheckPoints + 1
            taskObject.namedTasks.gateTracking.networkVars.blueTeamScore = taskObject.namedTasks.gateTracking.networkVars.blueTeamScore + instance.challenge.settings.gateScore
            if taskObject.namedTasks.gateTracking.networkVars.blueTeamTotalCheckPoints % blueTeamSize == 0 and blueTeamSize < redTeamSize then
              taskObject.namedTasks.gateTracking.networkVars.blueTeamScore = taskObject.namedTasks.gateTracking.networkVars.blueTeamScore + (redTeamSize - blueTeamSize) * instance.challenge.settings.gateScore
            end
          else
            taskObject.namedTasks.gateTracking.networkVars.redTeamTotalCheckPoints = taskObject.namedTasks.gateTracking.networkVars.redTeamTotalCheckPoints + 1
            taskObject.namedTasks.gateTracking.networkVars.redTeamScore = taskObject.namedTasks.gateTracking.networkVars.redTeamScore + instance.challenge.settings.gateScore
            if taskObject.namedTasks.gateTracking.networkVars.redTeamTotalCheckPoints % redTeamSize == 0 and blueTeamSize > redTeamSize then
              taskObject.namedTasks.gateTracking.networkVars.redTeamScore = taskObject.namedTasks.gateTracking.networkVars.redTeamScore + (blueTeamSize - redTeamSize) * instance.challenge.settings.gateScore
            end
          end
        end
      end
    }
  }
end
missionSetupData["Multiplayer team circuit race"].taskCreatorFunctionLookups = {
  ["Objective Team 1"] = packageTasks,
  ["Player Pool"] = playerTasks
}
missionSetupData["Multiplayer team circuit race"].onlineProgressionData = {
  localPlayer = {
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.teamRushCheckpointXP,
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
missionSetupData["Multiplayer team circuit race"].stepHighlightColours = function(instance)
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
missionSetupData["Multiplayer team circuit race"].onlineStatisticsData = function(syncedScores)
  assert(syncedScores[localPlayer.playerID], "players score not found in synced score table")
  onlineStatistics.updateSpecificStatistic(syncedScores[localPlayer.playerID])
  onlineStatistics.updateScoreStatistic(onlineProgressionSystem.getLocalPlayerXPGained())
end
missionSetupData["Multiplayer team circuit race"].missionCompleteData = function(instance, syncedScores, syncedTeamScores)
  for playerID, player in next, playerManager.players, nil do
    assert(syncedScores[playerID], "players score not found in synced score table")
    onlineScreenManager.updatePlayerScore(playerID, syncedScores[playerID])
  end
  local playerTeamScore = 0
  local opponentTeamScore = 0
  if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
    playerTeamScore = syncedTeamScores[1]
    opponentTeamScore = syncedTeamScores[2]
  else
    playerTeamScore = syncedTeamScores[2]
    opponentTeamScore = syncedTeamScores[1]
  end
  onlineScreenManager.setBlueTeamCurrentScore(playerTeamScore)
  onlineScreenManager.setBlueTeamTargetScore("")
  onlineScreenManager.setRedTeamCurrentScore(opponentTeamScore)
  onlineScreenManager.setRedTeamTargetScore("")
  onlineScreenManager.setForceSortType(false)
  onlineScreenManager.setRaceCompleteData(false)
  local playerTeamWin = playerTeamScore > opponentTeamScore
  if playerTeamWin then
    onlineProgressionSystem.progressionMissionComplete(true)
    onlineStatistics.updateWinStatistic(1)
    onlineStatistics.updateModeProfileWinStatistic("MP team circuit race")
  else
    onlineProgressionSystem.progressionMissionComplete(false)
    onlineStatistics.updateLossStatistic(1)
  end
  local results = onlineScreenManager.getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.score)
  for i, player in ipairs(results) do
    assert(player, "Player not found of error in sorting of players in onlineScreenManager.getScreenCurrentPlayerTable. i = " .. tostring(i) .. " #results = " .. tostring(results) .. " numPlayers = " .. tostring(playerManager.numberOfPlayers))
    if player.id == localPlayer.playerID then
      onlineStatistics.updatePlayerLastPositionInMode("MP team circuit race", i)
      break
    end
  end
end
missionSetupData["Multiplayer team circuit race"].getLocalPlayerFinalScore = function()
  local playerTO = localPlayer.getTaskObject()
  return playerTO.namedTasks.checkpoints and playerTO and 0
end
missionSetupData["Multiplayer team circuit race"].getPlayerFinalScore = function(instance, playerID)
  local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[playerID + 1]]
  return taskObject.namedTasks.checkpoints and taskObject and 0
end
missionSetupData["Multiplayer team circuit race"].getTeamFinalScore = function(instance)
  local package = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  if package and package.namedTasks.gateTracking then
    return package.namedTasks.gateTracking.networkVars.blueTeamScore, package.namedTasks.gateTracking.networkVars.redTeamScore
  end
  return 0, 0
end
missionSetupData["Multiplayer team circuit race"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 4,
      spoolStartArea = true,
      gridStyle = 2,
      missionVehicleStyle = 1,
      moodStyle = 2,
      introHUD = "MP Team Circuit Race Start HUD",
      teamGame = true,
      modeTimeLimit = mpTeamCircuitRaceTimeLimit,
      speedClamp = 0.9,
      gridStagger = 0,
      disableZapOnCompletion = true
    }
  }
end
missionSetupData["Multiplayer team circuit race"].initiate = function(instance)
  if not instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]] then
    local package = packageManager.createPackage(false, vec.vector(0, 0, 0, 1), true, 0, nil, nil, nil, nil, 0, true)
    instance:newActorFromAgent(OBJ_TEAM_ONE_STRING_TABLE[1], package)
  end
end
missionSetupData["Multiplayer team circuit race"].missionStart = function(instance)
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
missionSetupData["Multiplayer team circuit race"].onPlayerJoinInProgress = function(remotePlayer)
  if not remotePlayer then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243748")
    onlineInstructionSupport.displayPrompt("ID:234257", localPlayer.buttonLayout.zapReturn)
  end
end
missionSetupData["Multiplayer team circuit race"].modeReadyCheck = function(instance)
  local package = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  if package and package.coreData.agent then
    return true
  end
  return false
end
missionSetupData["Multiplayer team circuit race"].update = function(instance)
  local package = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  if package and package.namedTasks.gateTracking and package.namedTasks.gateTracking.networkVars then
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
taskCompleteData["Multiplayer team circuit race"] = {}
taskCompleteData["Multiplayer team circuit race"].taskComplete = function(taskObject, task)
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
missionSetupData["Multiplayer team circuit race"].targetList = {
  ["Player Pool"] = getPlayerDynamicTargets
}
