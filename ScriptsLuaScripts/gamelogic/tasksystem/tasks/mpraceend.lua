taskSystem.registerTask("MP race end", nil, function(task)
  local function goalCallback(success, condition, missionData, goalData)
    if localPlayerManager.numberOfPlayers == 1 then
      onlineScreenManager.showScreen(SoloRaceCompleteScreenIndex, g_NetworkTime, false, "FINISHED", false, function()
        if onlineRaceManager.hasFinishedPositionBeenSynced(localPlayer.playerID) then
          return true
        end
        return false
      end, 2.5)
      freeDriveModeID = task.instance.challenge.name
      onlineScreenManager.showScreen(SoloRaceModeResultIndex, g_NetworkTime, "LIVE RACE", task.instance.challenge.name, function()
        if task.instance and task.instance.challenge and localPlayerManager.numberOfPlayers == 1 then
          if task.coreData and task.coreData.stdRace then
            onlineScreenManager.setRaceCompleteData(true)
            local numCheckPoints = #task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].route
            local taskObject = false
            for playerID, player in next, playerManager.players, nil do
              taskObject = false
              if task.coreData.playerTO then
                taskObject = task.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[playerID + 1]]
              else
                taskObject = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[playerID + 1]]
              end
              if taskObject and taskObject.namedTasks.checkpoints then
                onlineScreenManager.updatePlayerScore(playerID, taskObject.namedTasks.checkpoints.networkVars.checkpoints - 1 + taskObject.namedTasks.checkpoints.networkVars.laps * numCheckPoints)
              end
              onlineScreenManager.updatePlayerSecondaryScore(playerID, onlineRaceManager.getPlayerRank(playerID))
            end
          elseif task.coreData and not task.coreData.stdRace then
            localPlayer.mpEndOfRaceSetDestination = true
            onlineScreenManager.setForceSortType(onlineScreenManager.screenSortTypes.race)
            local numPlayers = playerManager.numberOfPlayers
            local totalCheckpoints = #task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].route
            local playerPosition = 0
            local gatesPassed = 0
            local weight = 0
            local playerTO = false
            local vehicleTO = false
            local baseScore = 0
            local finalScore = 0
            for playerID, player in next, playerManager.players, nil do
              playerTO = task.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[playerID + 1]]
              vehicleTO = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[playerID + 1]]
              if playerTO and vehicleTO then
                playerPosition = onlineRaceManager.getPlayerRank(playerID)
                gatesPassed = vehicleTO.namedTasks.checkpoints.networkVars.checkpoints - 1 + totalCheckpoints * vehicleTO.namedTasks.checkpoints.networkVars.laps
                weight = gatesPassed / totalCheckpoints
                if numPlayers < playerPosition then
                  playerPosition = numPlayers
                end
                baseScore = cardSystem.logic.mpSprintRaceScoreTable[numPlayers][playerPosition]
                finalScore = 0
                if weight >= 0.5 then
                  finalScore = baseScore
                else
                  finalScore = math.ceil(baseScore * weight * 2)
                end
                onlineScreenManager.updatePlayerRoundScore(playerID, finalScore)
              end
              onlineScreenManager.updatePlayerSecondaryScore(playerID, onlineRaceManager.getPlayerRank(playerID))
            end
          end
        end
      end, function()
        return false
      end, 5)
      task.instance.challenge.raceEndScreenSet = true
    end
  end
  function cleanup()
  end
  return goalCallback, AIUpdate, cleanup
end)
