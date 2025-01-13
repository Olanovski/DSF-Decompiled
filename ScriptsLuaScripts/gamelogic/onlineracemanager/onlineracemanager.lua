module("onlineRaceManager", package.seeall)
local relayRaceArrows = false
relayRaceArrowsPlayersCheckpointNum = false
local modeInstance = false
local objTeamOneTO = false
local objTeamTwoTO = false
local arrowsOn = {}
local wrongWayFeedbackOn = {
  [0] = false,
  [1] = false
}
local missedCheckpointOn = false
local callBackTable = {}
local positionFinalisedCallbacks = {}
raceActive = false
local storedRaceRank = {
  [0] = false,
  [1] = false,
  [2] = false,
  [3] = false,
  [4] = false,
  [5] = false,
  [6] = false,
  [7] = false
}
local racers = {
  [0] = {
    raceVehicle = false,
    racePosition = false,
    active = false,
    isLocal = false,
    locked = false,
    finishPosition = false,
    lastFinishUpdate = false,
    actualFinishPos = false
  },
  [1] = {
    raceVehicle = false,
    racePosition = false,
    active = false,
    isLocal = false,
    locked = false,
    finishPosition = false,
    lastFinishUpdate = false,
    actualFinishPos = false
  },
  [2] = {
    raceVehicle = false,
    racePosition = false,
    active = false,
    isLocal = false,
    locked = false,
    finishPosition = false,
    lastFinishUpdate = false,
    actualFinishPos = false
  },
  [3] = {
    raceVehicle = false,
    racePosition = false,
    active = false,
    isLocal = false,
    locked = false,
    finishPosition = false,
    lastFinishUpdate = false,
    actualFinishPos = false
  },
  [4] = {
    raceVehicle = false,
    racePosition = false,
    active = false,
    isLocal = false,
    locked = false,
    finishPosition = false,
    lastFinishUpdate = false,
    actualFinishPos = false
  },
  [5] = {
    raceVehicle = false,
    racePosition = false,
    active = false,
    isLocal = false,
    locked = false,
    finishPosition = false,
    lastFinishUpdate = false,
    actualFinishPos = false
  },
  [6] = {
    raceVehicle = false,
    racePosition = false,
    active = false,
    isLocal = false,
    locked = false,
    finishPosition = false,
    lastFinishUpdate = false,
    actualFinishPos = false
  },
  [7] = {
    raceVehicle = false,
    racePosition = false,
    active = false,
    isLocal = false,
    locked = false,
    finishPosition = false,
    lastFinishUpdate = false,
    actualFinishPos = false
  }
}
function printData()
  printTable(storedRaceRank)
  printTable(racers)
  printTable(callBackTable)
  printTable(playersCheckpointNum)
end
function initiate()
  if gameStatus.onlineSession and Network.isOnlineHost() then
    isLocal = true
    SNOID = createSNOFromObject()
  end
end
function purge()
  if raceActive then
    endRace()
  end
end
function setupRace(instance)
  NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - setup race - routeIndex = " .. tostring(instance.networkVars.routeIndex))
  print("ONLINE RACE MANAGER - setup race - routeIndex = " .. tostring(instance.networkVars.routeIndex))
  assert(not raceActive, "ONLINE RACE MANAGER - Race already active")
  callBackTable = {}
  OnlineRaceManager.Clear()
  assert(instance.challenge.spawnPositions[instance.networkVars.routeIndex], "ONLINE RACE MANAGER SETUP FAIL - ROUTE INDEX " .. tostring(instance.networkVars.routeIndex) .. " DOES NOT EXIST IN THE SPAWN POSITIONS")
  assert(instance.challenge.spawnPositions[instance.networkVars.routeIndex].roads, "ONLINE RACE MANAGER SETUP FAIL - ROADS NOT IN THE SPAWN LOCATION DATA TABLE. INDEX: " .. tostring(instance.networkVars.routeIndex))
  assert(instance.challenge.spawnPositions[instance.networkVars.routeIndex].route, "ONLINE RACE MANAGER SETUP FAIL - ROUTE NOT IN THE SPAWN LOCATION DATA TABLE. INDEX: " .. tostring(instance.networkVars.routeIndex))
  OnlineRaceManager.AddRoute(instance.challenge.spawnPositions[instance.networkVars.routeIndex].roads)
  OnlineRaceManager.AddCheckpoints(instance.challenge.spawnPositions[instance.networkVars.routeIndex].route)
  for localID, plr in next, localPlayerManager.players, nil do
    RouteArrowsManager.AddArrows(localID, -1, instance.challenge.spawnPositions[instance.networkVars.routeIndex].roads, instance.challenge.spawnPositions[instance.networkVars.routeIndex].arrows)
    RouteArrowsManager.SetActiveArrowColour(localID, OnlineModeSettings.yellow32)
    arrowsOn[localID] = true
  end
  modeInstance = instance
  objTeamOneTO = false
  objTeamTwoTO = false
  if instance.challenge.settings.relayRaceArrows then
    relayRaceArrows = true
    relayRaceArrowsPlayersCheckpointNum = deepCopy(playersCheckpointNum)
    for localID, plr in next, localPlayerManager.players, nil do
      RouteArrowsManager.HideArrows(localID, true)
      arrowsOn[localID] = false
    end
  else
    relayRaceArrows = false
    relayRaceArrowsPlayersCheckpointNum = false
  end
  racers = {
    [0] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [1] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [2] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [3] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [4] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [5] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [6] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [7] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    }
  }
  storedRaceRank = {
    [0] = false,
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,
    [6] = false,
    [7] = false
  }
  if isLocal then
    playersCheckpointNum = {
      [1] = 0,
      [2] = 0,
      [3] = 0,
      [4] = 0,
      [7] = 0,
      [5] = 0,
      [6] = 0,
      [8] = 0
    }
    networkParsing.writeBuffer(SNO, SNOID, 0, playersCheckpointNumBuffer, playersCheckpointNum)
    networkVars.raceEndTimer = 0
    networkParsing.writeBuffer(SNO, SNOID, 1, networkVarBuffer, networkVars)
  end
  raceActive = true
  for playerID, player in next, playerManager.players, nil do
    if player.isLocal and not relayRaceArrows then
      addRacer(playerID, player.currentVehicle, 0, player.isLocal, relayRaceArrows)
    else
      addRacer(playerID, player.currentVehicle, playersCheckpointNum[playerID + 1], player.isLocal, relayRaceArrows)
    end
  end
  wrongWayFeedbackOn = {
    [0] = false,
    [1] = false
  }
  missedCheckpointOn = false
end
function endRace()
  NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - end race")
  print("ONLINE RACE MANAGER - end race")
  assert(raceActive, "ONLINE RACE MANAGER - Race not active")
  callBackTable = {}
  for localID, plr in next, localPlayerManager.players, nil do
    RouteArrowsManager.HideArrows(localID, false)
    RouteArrowsManager.ClearArrows(localID)
    arrowsOn[localID] = true
  end
  for playerID, raceData in next, racers, nil do
    if raceData.active then
      storedRaceRank[playerID] = OnlineRaceManager.GetPlayerRank(playerID)
    end
  end
  OnlineRaceManager.Clear()
  raceActive = false
  relayRaceArrows = false
  relayRaceArrowsPlayersCheckpointNum = false
  modeInstance = false
  objTeamOneTO = false
  objTeamTwoTO = false
  removeUserUpdateFunction("genFinishPosPlayer0")
  removeUserUpdateFunction("genFinishPosPlayer1")
  removeUserUpdateFunction("genFinishPosPlayer2")
  removeUserUpdateFunction("genFinishPosPlayer3")
  removeUserUpdateFunction("genFinishPosPlayer4")
  removeUserUpdateFunction("genFinishPosPlayer5")
  removeUserUpdateFunction("genFinishPosPlayer6")
  removeUserUpdateFunction("genFinishPosPlayer7")
  racers = {
    [0] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [1] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [2] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [3] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [4] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [5] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [6] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [7] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    }
  }
  if isLocal then
    playersCheckpointNum = {
      [1] = 0,
      [2] = 0,
      [3] = 0,
      [4] = 0,
      [7] = 0,
      [5] = 0,
      [6] = 0,
      [8] = 0
    }
    networkParsing.writeBuffer(SNO, SNOID, 0, playersCheckpointNumBuffer, playersCheckpointNum)
    networkVars.raceEndTimer = 0
    networkParsing.writeBuffer(SNO, SNOID, 1, networkVarBuffer, networkVars)
  end
  if gameStatus.splitscreenSession then
    if wrongWayFeedbackOn[0] then
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_instruct", 0)
      wrongWayFeedbackOn[0] = false
    elseif wrongWayFeedbackOn[1] then
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_instruct", 0)
      wrongWayFeedbackOn[1] = false
    end
  elseif wrongWayFeedbackOn[0] then
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    wrongWayFeedbackOn[0] = false
  end
  if missedCheckpointOn then
    feedbackSystem.menusMaster.clearSecondaryTextPrompt()
    missedCheckpointOn = false
  end
end
function addRacer(playerID, vehicle, currentCheckpointNum, tempIsLocal, setTargetWithoutLocal)
  assert(not racers[playerID].active, "ONLINE RACE MANAGER - Racer already active, playerID: " .. tostring(playerID))
  OnlineRaceManager.AddPlayer(playerID)
  if vehicle then
    NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - addRacer - playerID " .. tostring(playerID) .. ", checkpoint number = " .. tostring(currentCheckpointNum) .. ", isLocal = " .. tostring(tempIsLocal) .. ", SNVID = " .. tostring(vehicle.SNVID))
    OnlineRaceManager.SetCurrentVehicle(playerID, vehicle.gameVehicle)
    racers[playerID].raceVehicle = vehicle
  else
    NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - addRacer - playerID " .. tostring(playerID) .. ", checkpoint number = " .. tostring(currentCheckpointNum) .. ", isLocal = " .. tostring(tempIsLocal) .. ", SNVID = nil")
    OnlineRaceManager.SetCurrentVehicle(playerID, nil)
    racers[playerID].raceVehicle = false
  end
  racers[playerID].active = true
  OnlineRaceManager.SetCurrentCheckpoint(playerID, currentCheckpointNum)
  if tempIsLocal then
    sendMessage(1, currentCheckpointNum)
  end
  if setTargetWithoutLocal and tempIsLocal then
    local localID = playerManager.players[playerID].localID
    RouteArrowsManager.SetTarget(localID, playerID)
    RouteArrowsManager.HideArrows(localID, true)
    arrowsOn[localID] = false
  elseif not setTargetWithoutLocal and tempIsLocal then
    local localID = playerManager.players[playerID].localID
    racers[playerID].isLocal = true
    OnlineRaceManager.SetLocalPlayer(playerID, tempIsLocal)
    RouteArrowsManager.SetTarget(localID, playerID)
  end
end
function updateRacer(playerID, vehicle, currentCheckpointNum)
  assert(racers[playerID].active, "ONLINE RACE MANAGER - Racer not active, playerID: " .. tostring(playerID))
  NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - updateRacer - playerID " .. tostring(playerID) .. ", checkpoint number = " .. tostring(currentCheckpointNum))
  if vehicle then
    OnlineRaceManager.SetCurrentVehicle(playerID, vehicle.gameVehicle)
    racers[playerID].raceVehicle = vehicle
  else
    OnlineRaceManager.SetCurrentVehicle(playerID, nil)
    racers[playerID].raceVehicle = false
  end
  OnlineRaceManager.SetCurrentCheckpoint(playerID, currentCheckpointNum)
end
function updateRacerVehicle(playerID, vehicle)
  assert(racers[playerID].active, "ONLINE RACE MANAGER - Racer not active, playerID: " .. tostring(playerID))
  if vehicle then
    NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - updateRacerVehicle - playerID " .. tostring(playerID) .. ", vehicle = " .. tostring(vehicle.SNVID))
    OnlineRaceManager.SetCurrentVehicle(playerID, vehicle.gameVehicle)
    racers[playerID].raceVehicle = vehicle
  else
    NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - updateRacerVehicle - playerID " .. tostring(playerID) .. ", vehicle = nil")
    OnlineRaceManager.SetCurrentVehicle(playerID, nil)
    racers[playerID].raceVehicle = false
  end
end
function updateRacerCheckpoint(playerID, currentCheckpointNum)
  NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - updateRacerCheckpoint - playerID " .. tostring(playerID) .. ", checkpoint number = " .. tostring(currentCheckpointNum))
  if raceActive and not racers[playerID].isLocal then
    assert(racers[playerID].active, "ONLINE RACE MANAGER - Racer not active, playerID: " .. tostring(playerID))
    OnlineRaceManager.SetCurrentCheckpoint(playerID, currentCheckpointNum)
  end
end
function getPlayerRank(playerID)
  if raceActive then
    if racers[playerID].active and not racers[playerID].locked then
      storedRaceRank[playerID] = OnlineRaceManager.GetPlayerRank(playerID)
      return storedRaceRank[playerID] or 8
    else
      return storedRaceRank[playerID] or 8
    end
  else
    return storedRaceRank[playerID] or 8
  end
end
function updateRacerCheckpoints()
  for playerID, raceData in next, racers, nil do
    if raceData.active then
      updateRacerCheckpoint(playerID, playersCheckpointNum[playerID + 1])
    end
  end
  if relayRaceArrows then
    relayRaceArrowsPlayersCheckpointNum = deepCopy(playersCheckpointNum)
  end
end
function updatePlayersAndVehicles()
  if raceActive then
    for playerID, player in next, playerManager.players, nil do
      if racers[playerID].active then
        if player.currentVehicle then
          if racers[playerID].raceVehicle then
            if racers[playerID].raceVehicle ~= player.currentVehicle then
              updateRacerVehicle(playerID, player.currentVehicle)
            end
          else
            updateRacerVehicle(playerID, player.currentVehicle)
          end
        elseif racers[playerID].raceVehicle then
          updateRacerVehicle(playerID, nil)
        end
      elseif player.isLocal and not relayRaceArrows then
        addRacer(playerID, player.currentVehicle, 0, player.isLocal, relayRaceArrows)
      else
        addRacer(playerID, player.currentVehicle, playersCheckpointNum[playerID + 1], player.isLocal, relayRaceArrows)
      end
    end
  end
end
function update()
  assert(raceActive, "CANNOT UPDATE THE RACE MANAGER - RACE MANAGER NOT SETUP")
  if relayRaceArrows then
    if modeInstance then
      if taskSystem.validTaskObject(objTeamOneTO) and taskSystem.validTaskObject(objTeamTwoTO) and objTeamOneTO.namedTasks.checkpoints and objTeamTwoTO.namedTasks.checkpoints then
        for localID, plr in next, localPlayerManager.players, nil do
          local playerVehicle = plr.currentVehicle
          if playerVehicle then
            local playerID = plr.playerID
            local playerTeam = PlayerGamePlay.getPlayerTeam(plr.playerID)
            local objVehicle = false
            local checkpoint = false
            if playerTeam == 1 then
              objVehicle = objTeamOneTO.coreData.agent.owner
              checkpoint = (objTeamOneTO.namedTasks.checkpoints.networkVars.checkpoints - 1) * (objTeamOneTO.namedTasks.checkpoints.networkVars.laps + 1)
            else
              objVehicle = objTeamTwoTO.coreData.agent.owner
              checkpoint = (objTeamTwoTO.namedTasks.checkpoints.networkVars.checkpoints - 1) * (objTeamTwoTO.namedTasks.checkpoints.networkVars.laps + 1)
            end
            if objVehicle then
              if objVehicle == playerVehicle then
                if not arrowsOn[localID] then
                  RouteArrowsManager.HideArrows(localID, false)
                  arrowsOn[localID] = true
                end
                if relayRaceArrowsPlayersCheckpointNum[playerID + 1] ~= checkpoint then
                  relayRaceArrowsPlayersCheckpointNum[playerID + 1] = checkpoint
                  sendMessage(1, checkpoint)
                end
              elseif arrowsOn[localID] then
                RouteArrowsManager.HideArrows(localID, true)
                arrowsOn[localID] = false
              end
            elseif arrowsOn[localID] then
              RouteArrowsManager.HideArrows(localID, true)
              arrowsOn[localID] = false
            end
          elseif arrowsOn[localID] then
            RouteArrowsManager.HideArrows(localID, true)
            arrowsOn[localID] = false
          end
        end
      else
        objTeamOneTO = modeInstance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
        objTeamTwoTO = modeInstance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
      end
    else
      modeInstance = localPlayer.getTaskObject().coreData.instance
    end
  end
end
function addCheckpointCallback(callBack, playerID)
  NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - addCheckpointCallback " .. tostring(playerID))
  if not callBackTable[playerID] then
    callBackTable[playerID] = callBack
  end
end
function removeCheckpointCallback(callBack, playerID)
  NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - removeCheckpointCallback " .. tostring(playerID))
  if callBackTable[playerID] then
    callBackTable[playerID] = nil
  end
end
function checkpointCallback(playerID, checkpointNumber)
  assert(racers[playerID].active, "ONLINE RACE MANAGER - Racer not active, playerID: " .. tostring(playerID))
  NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - checkpointCallback - playerID " .. tostring(playerID) .. ", checkpointNumber " .. tostring(checkpointNumber))
  if callBackTable[playerID] then
    sendMessage(1, checkpointNumber)
    callBackTable[playerID](playerID)
  else
    NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - checkpointCallback ignored " .. tostring(playerID))
  end
end
function wrongWayCallback(playerID, wrongWay)
  if not gameStatus.splitscreenSession then
    if not racers[playerID].actualFinishPos then
      assert(racers[playerID].active, "ONLINE RACE MANAGER - Racer not active, playerID: " .. tostring(playerID))
      if playerID == localPlayer.playerID and wrongWay and not wrongWayFeedbackOn[0] then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:245965", false, false, true)
        wrongWayFeedbackOn[0] = true
      elseif playerID == localPlayer.playerID and not wrongWay and wrongWayFeedbackOn[0] then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        wrongWayFeedbackOn[0] = false
      end
    end
  elseif wrongWay then
    if not wrongWayFeedbackOn[playerID] then
      if playerID == 0 then
        feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_p1_instruct", "ID:245965")
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_instruct", 1)
      else
        feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_p2_instruct", "ID:245965")
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_instruct", 1)
      end
      wrongWayFeedbackOn[playerID] = true
    end
  elseif wrongWayFeedbackOn[playerID] then
    if playerID == 0 then
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_instruct", 0)
    else
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_instruct", 0)
    end
    wrongWayFeedbackOn[playerID] = false
  end
end
function removePlayer(playerID)
  NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - remove racer " .. tostring(playerID))
  if racers[playerID].active then
    OnlineRaceManager.RemovePlayer(playerID)
    racers[playerID] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    }
    playersCheckpointNum[playerID + 1] = 0
    if isLocal then
      networkParsing.writeBuffer(SNO, SNOID, 0, playersCheckpointNumBuffer, playersCheckpointNum)
    end
  end
end
function lockPlayersPosition(playerID, position)
  if raceActive and racers[playerID].active then
    racers[playerID].racePosition = position
    storedRaceRank[playerID] = position
    racers[playerID].locked = true
  end
end
function sendLockPlayersPosition()
  PlayerGamePlay.broadcastMessage(28, tostring(getPlayerRank(localPlayer.playerID)))
  lockPlayersPosition(localPlayer.playerID, getPlayerRank(localPlayer.playerID))
end
function missedCheckpointCallback(playerID, missedCheckpoint)
  if not gameStatus.splitscreenSession then
    assert(racers[playerID].active, "ONLINE RACE MANAGER - Racer not active, playerID: " .. tostring(playerID))
    if playerID == localPlayer.playerID and missedCheckpoint and not missedCheckpointOn then
      feedbackSystem.menusMaster.secondaryTextPrompt("ID:243842", false, false, false, true)
      missedCheckpointOn = true
    elseif playerID == localPlayer.playerID and not missedCheckpoint and missedCheckpointOn then
      feedbackSystem.menusMaster.clearSecondaryTextPrompt()
      missedCheckpointOn = false
    end
  end
end
local function finalisePlayersPosition(id)
  assert(racers[id].active, "ONLINE RACE MANAGER - Racer not active, playerID: " .. tostring(playerID))
  local duplicationCount = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0,
    [8] = 0
  }
  local tempPosition = racers[id].actualFinishPos
  for playerID, player in next, playerManager.players, nil do
    if playerID ~= id and racers[playerID].actualFinishPos then
      duplicationCount[racers[playerID].actualFinishPos] = duplicationCount[racers[playerID].actualFinishPos] + 1
    end
  end
  local minPosition = 1
  for i = 1, tempPosition - 1 do
    minPosition = minPosition + duplicationCount[i]
  end
  if tempPosition < minPosition then
    tempPosition = minPosition
  end
  racers[id].locked = true
  racers[id].finishPosition = tempPosition
  storedRaceRank[id] = tempPosition
  for name, callback in next, positionFinalisedCallbacks, nil do
    callback(id)
  end
  removeUserUpdateFunction("genFinishPosPlayer" .. tostring(id))
end
local function generateFinishPositionData(id)
  if raceActive then
    finalise = false
    assert(racers[id].lastFinishUpdate, "ONLINE RACE MANAGER - racers[ id ].lastFinishUpdate is invalid ID = " .. tostring(id))
    if g_NetworkTime - racers[id].lastFinishUpdate < 5 then
      finalise = true
      for playerID, player in next, playerManager.players, nil do
        if playerID ~= id and playerID ~= localPlayer.playerID then
          if racers[playerID].lastFinishUpdate and not racers[playerID].actualFinishPos and racers[playerID].lastFinishUpdate < racers[id].lastFinishUpdate then
            finalise = false
            break
          elseif not racers[playerID].lastFinishUpdate then
            finalise = false
            break
          end
        end
      end
    else
      finalise = true
    end
    if finalise then
      finalisePlayersPosition(id)
    end
  end
end
function onLocalPlayerFinishRace(position)
  if raceActive then
    assert(racers[localPlayer.playerID].active, "ONLINE RACE MANAGER - Racer not active, playerID: " .. tostring(localPlayer.playerID))
    if not racers[localPlayer.playerID].actualFinishPos then
      if wrongWayFeedbackOn[0] then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        wrongWayFeedbackOn[0] = false
      end
      local finishPosition = false
      if position then
        finishPosition = position
      else
        finishPosition = getPlayerRank(localPlayer.playerID)
      end
      NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - Local Player crossed the finish line. ID = " .. tostring(localPlayer.playerID) .. "  Position = " .. tostring(finishPosition))
      OnlineRaceManager.PlayerCrossedFinishLine(localPlayer.playerID, finishPosition)
      racers[localPlayer.playerID].actualFinishPos = finishPosition
      racers[localPlayer.playerID].lastFinishUpdate = g_NetworkTime
      PlayerGamePlay.broadcastMessage(30, tostring(finishPosition))
      addUserUpdateFunction("genFinishPosPlayer" .. tostring(localPlayer.playerID), function()
        generateFinishPositionData(localPlayer.playerID)
      end, 1)
    end
  end
end
function getLocalPlayerActualFinishPosition()
  if raceActive then
    return racers[localPlayer.playerID].actualFinishPos
  end
  return false
end
function onRemotePlayerFinishRaceLocalPosition(playerID)
  if raceActive then
    assert(racers[playerID].active, "ONLINE RACE MANAGER - Racer not active, playerID: " .. tostring(playerID))
    if not racers[playerID].actualFinishPos then
      NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - Remote Player crossed the finish line. Local position locked. ID = " .. tostring(playerID) .. "  Position = " .. tostring(getPlayerRank(playerID)))
      OnlineRaceManager.PlayerCrossedFinishLine(playerID, getPlayerRank(playerID))
    end
  end
end
function onRemotePlayerFinishRace(playerID, position)
  if raceActive then
    assert(racers[playerID].active, "ONLINE RACE MANAGER - Racer not active, playerID: " .. tostring(playerID))
    local localFinishPosition = racers[localPlayer.playerID].actualFinishPos
    OnlineRaceManager.PlayerCrossedFinishLine(playerID, position)
    PlayerGamePlay.broadcastMessage(31, tostring(localFinishPosition or -1))
    racers[playerID].actualFinishPos = position
    racers[playerID].lastFinishUpdate = g_NetworkTime
    NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - Remote Player crossed the finish line. ID = " .. tostring(playerID) .. "  Position = " .. tostring(position))
    addUserUpdateFunction("genFinishPosPlayer" .. tostring(playerID), function()
      generateFinishPositionData(playerID)
    end, 1)
  end
end
function onReceiveReplyToPlayerFinish(playerID, remotePosition)
  if raceActive then
    assert(racers[playerID].active, "ONLINE RACE MANAGER - Racer not active, playerID: " .. tostring(playerID))
    if remotePosition > 0 and not racers[playerID].actualFinishPos then
      racers[playerID].actualFinishPos = remotePosition
    elseif remotePosition > 0 and racers[playerID].actualFinishPos then
      assert(racers[playerID].actualFinishPos == remotePosition, "Finish positions are mismatched!")
    end
    racers[playerID].lastFinishUpdate = g_NetworkTime
  end
end
function addPositionFinalisedCallback(name, callback)
  positionFinalisedCallbacks[name] = callback
end
function removePositionFinalisedCallback(name)
  if positionFinalisedCallbacks[name] then
    positionFinalisedCallbacks[name] = nil
  end
end
function hasFinishedPositionBeenSynced(playerID)
  return racers[playerID].finishPosition
end
function hasFinishedPositionsBeenSynced()
  for playerID, players in next, playerManager.players, nil do
    if phaseManager.currentStateList[playerID + 1] ~= JoiningStateIndex and phaseManager.currentStateList[playerID + 1] ~= 0 and racers[playerID].active and not racers[playerID].finishPosition then
      return false
    end
  end
  return true
end
function crossedFinishLineCallback(playerID)
end
function runFinalPositionTestCase()
  racers = {
    [0] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [1] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [2] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [3] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [4] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [5] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [6] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    },
    [7] = {
      raceVehicle = false,
      racePosition = false,
      active = false,
      isLocal = false,
      locked = false,
      finishPosition = false,
      lastFinishUpdate = false,
      actualFinishPos = false
    }
  }
  for playerID, player in next, playerManager.players, nil do
    racers[playerID].active = true
  end
end
function printFinshData()
  NetworkLog.Write(">[LUA] - Final Race Positions")
  for playerID, player in next, playerManager.players, nil do
    NetworkLog.Write("          PlayerID: " .. tostring(playerID) .. " Actual Finish Pos: " .. tostring(racers[playerID].actualFinishPos) .. " Synced Finish Position: " .. tostring(racers[playerID].finishPosition) .. " getPlayerRank = " .. tostring(getPlayerRank(playerID)))
  end
  NetworkLog.Write(">[LUA] - End Final Race Positions")
end
