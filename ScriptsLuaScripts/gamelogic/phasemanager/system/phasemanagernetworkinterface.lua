module("phaseManager")
local coreNetworkVarBuffer = {
  bytes = 64,
  lookupTable = networkParsing.makeLookupTable({
    {name = "phase", parseType = "uinteger8"},
    {
      name = "nextTurnTaker",
      parseType = "uinteger8"
    },
    {name = "modeIndex", parseType = "uinteger8"},
    {
      name = "modeAreaIndex",
      parseType = "uinteger8"
    },
    {name = "moodIndex", parseType = "uinteger8"},
    {
      name = "missionVehicleIndex",
      parseType = "uinteger8"
    },
    {
      name = "faceOffNext",
      parseType = "boolean"
    },
    {name = "modeID", parseType = "uinteger16"},
    {
      name = "waitForPlayerStartTime",
      parseType = "float"
    },
    {
      name = "screenBlockStartTime",
      parseType = "float"
    },
    {
      name = "screenBlockEndTime",
      parseType = "float"
    },
    {
      name = "screenEarlyEnd",
      parseType = "float"
    },
    {
      name = "toFewPlayersType",
      parseType = "uinteger8"
    },
    {name = "sessionID", parseType = "integer16"},
    {name = "trafficID", parseType = "integer8"},
    {
      name = "gameStartTime",
      parseType = "float"
    },
    {
      name = "vehicleFreqIndex",
      parseType = "integer8"
    }
  })
}
function coreNetworkVarBuffer.bufferUpdate(networkVars, newBuffer)
  networkVars.__index = newBuffer
end
currentStateList = {
  [1] = 0,
  [2] = 0,
  [3] = 0,
  [4] = 0,
  [5] = 0,
  [6] = 0,
  [7] = 0,
  [8] = 0
}
local currentStateBuffer = {
  bytes = 64,
  lookupTable = networkParsing.makeLookupTable({
    {name = 1, parseType = "uinteger8"},
    {name = 2, parseType = "uinteger8"},
    {name = 3, parseType = "uinteger8"},
    {name = 4, parseType = "uinteger8"},
    {name = 5, parseType = "uinteger8"},
    {name = 6, parseType = "uinteger8"},
    {name = 7, parseType = "uinteger8"},
    {name = 8, parseType = "uinteger8"}
  })
}
moveToStateList = {
  [1] = 0,
  [2] = 0,
  [3] = 0,
  [4] = 0,
  [5] = 0,
  [6] = 0,
  [7] = 0,
  [8] = 0
}
local moveToStateBuffer = {
  bytes = 64,
  lookupTable = networkParsing.makeLookupTable({
    {name = 1, parseType = "uinteger8"},
    {name = 2, parseType = "uinteger8"},
    {name = 3, parseType = "uinteger8"},
    {name = 4, parseType = "uinteger8"},
    {name = 5, parseType = "uinteger8"},
    {name = 6, parseType = "uinteger8"},
    {name = 7, parseType = "uinteger8"},
    {name = 8, parseType = "uinteger8"}
  })
}
vehicleGrid = {
  [1] = 0,
  [2] = 0,
  [3] = 0,
  [4] = 0,
  [5] = 0,
  [6] = 0,
  [7] = 0,
  [8] = 0,
  [9] = 0,
  [10] = 0,
  [11] = 0,
  [12] = 0,
  [13] = 0,
  [14] = 0,
  [15] = 0,
  [16] = 0
}
vehicleGridBuffer = {
  bytes = 128,
  lookupTable = networkParsing.makeLookupTable({
    {name = 1, parseType = "uinteger16"},
    {name = 2, parseType = "uinteger16"},
    {name = 3, parseType = "uinteger16"},
    {name = 4, parseType = "uinteger16"},
    {name = 5, parseType = "uinteger16"},
    {name = 6, parseType = "uinteger16"},
    {name = 7, parseType = "uinteger16"},
    {name = 8, parseType = "uinteger16"}
  })
}
function createSNOFromObject()
  NetworkLog.Write(">[LUA] PHASE MANAGER - Create SNO for local phase manager")
  SNOID = SNO.createSNO(4)
  SNO.createBuffer(SNOID, coreNetworkVarBuffer.bytes)
  networkParsing.writeBuffer(SNO, SNOID, 0, coreNetworkVarBuffer, networkVars)
  currentStateList = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0,
    [8] = 0
  }
  SNO.createBuffer(SNOID, currentStateBuffer.bytes)
  networkParsing.writeBuffer(SNO, SNOID, 1, currentStateBuffer, currentStateList)
  moveToStateList = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0,
    [8] = 0
  }
  SNO.createBuffer(SNOID, moveToStateBuffer.bytes)
  networkParsing.writeBuffer(SNO, SNOID, 2, moveToStateBuffer, moveToStateList)
  vehicleGrid = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0,
    [8] = 0,
    [9] = 0,
    [10] = 0,
    [11] = 0,
    [12] = 0,
    [13] = 0,
    [14] = 0,
    [15] = 0,
    [16] = 0
  }
  SNO.createBuffer(SNOID, vehicleGridBuffer.bytes)
  networkParsing.writeBuffer(SNO, SNOID, 3, vehicleGridBuffer, vehicleGrid)
  if gameStatus.splitscreenSession then
    stateMachine.init(states[NewSessionStateIndex], states[SplitScreenGlobalStateIndex])
  else
    stateMachine.init(states[NewSessionStateIndex], states[GlobalStateIndex])
  end
  SNO.SNOInitialised(SNOID)
end
function updateSNOFromObject()
  if networkVars.updateRequired then
    NetworkLog.WriteDetail(">[LUA] PHASE MANAGER - Update core buffer for local phase manager, SNOID = " .. tostring(SNOID))
    networkParsing.writeBuffer(SNO, SNOID, 0, coreNetworkVarBuffer, networkVars)
    networkVars.updateRequired = false
  end
end
function createObjectFromSNO(SNOID, numBuffers)
  NetworkLog.Write(">[LUA] PHASE MANAGER - Syncing with remotely created SNO, SNOID = " .. tostring(SNOID))
  phaseManager.SNOID = SNOID
  networkParsing.readBuffer(SNO, SNOID, 0, coreNetworkVarBuffer, networkVars)
  networkParsing.readBuffer(SNO, SNOID, 1, currentStateBuffer, currentStateList)
  networkParsing.readBuffer(SNO, SNOID, 2, moveToStateBuffer, moveToStateList)
  networkParsing.readBuffer(SNO, SNOID, 3, vehicleGridBuffer, vehicleGrid)
  stateMachine.init(states[JoiningStateIndex], states[GlobalStateIndex])
  stateMachine.catchUp = true
  stateMachine.wasOnCatchup = false
end
function updateObjectFromSNO(SNOID, bufferID)
  NetworkLog.WriteDetail(">[LUA] PHASE MANAGER - Update buffer from remote phase manager, SNOID = " .. tostring(SNOID) .. ", bufferID = " .. tostring(bufferID))
  if bufferID == 0 then
    networkParsing.readBuffer(SNO, SNOID, bufferID, coreNetworkVarBuffer, networkVars)
  elseif bufferID == 1 then
    networkParsing.readBuffer(SNO, SNOID, bufferID, currentStateBuffer, currentStateList)
    stateMachine.timeSinceAnyStateChange = g_NetworkTime
  elseif bufferID == 2 then
    networkParsing.readBuffer(SNO, SNOID, bufferID, moveToStateBuffer, moveToStateList)
    stateMachine.timeSinceAnyStateChange = g_NetworkTime
  else
    if bufferID == 3 then
      networkParsing.readBuffer(SNO, SNOID, bufferID, vehicleGridBuffer, vehicleGrid)
    else
    end
  end
end
local function checkStateTable()
  local changed = false
  for playerID, stateIndex in ipairs(currentStateList) do
    if stateIndex ~= 0 and not playerManager.players[playerID - 1] then
      vehicleGrid[playerID] = 0
      currentStateList[playerID] = 0
      moveToStateList[playerID] = 0
      changed = true
    end
  end
  if changed then
    networkParsing.writeBuffer(SNO, SNOID, 1, currentStateBuffer, currentStateList)
    networkParsing.writeBuffer(SNO, SNOID, 2, moveToStateBuffer, moveToStateList)
    stateMachine.timeSinceAnyStateChange = g_NetworkTime
  end
end
function checkTeamRebalanceRequired()
  if networkVars.phase == WaitingForPlayersStateIndex then
    PlayerGamePlay.rebalanceTeams()
  elseif faceOffNext() and #onlineScreenManager.getScreenStack() == 0 then
    PlayerGamePlay.rebalanceTeams()
  elseif gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    local modeResetting = false
    if networkVars.modeID and challengeSystem.instances[networkVars.modeID] and challengeSystem.instances[networkVars.modeID].networkVars.modeWillReset then
      modeResetting = true
    end
    if stateMachine.isSupportStateSet() and not modeResetting then
      PlayerGamePlay.rebalanceTeams()
    end
  end
end
function setObjectIsLocal(SNOID, isLocal)
  if phaseManager.isLocal ~= isLocal then
    NetworkLog.Write(">[LUA] PHASE MANAGER - PHASE MANAGER isLocal update, SNOID = " .. tostring(SNOID) .. ", new isLocal = " .. tostring(isLocal))
    phaseManager.isLocal = isLocal
    if phaseManager.isLocal then
      if gameStatus.onlineSessionType == gameStatus.onlineSessionID.partyMode then
        stateMachine.forceToState(states[NewSessionStateIndex], false)
      else
        checkTeamRebalanceRequired()
        local currentStateIndex = stateMachine.getCurrentStateIndex()
        checkStateTable()
        if stateMachine.catchUp or currentStateIndex == JoiningStateIndex or currentStateIndex == ReturnToBusStateIndex then
          stateMachine.resetStateMachine()
        elseif currentStateIndex ~= RunModeStateIndex and currentStateIndex ~= RunFaceOffStateIndex and currentStateIndex ~= CountDownStateIndex and currentStateIndex ~= WaitForStartStateIndex then
          stateMachine.reenterState(states[currentStateIndex])
        end
      end
      networkVars.phase = stateMachine.getCurrentStateIndex()
      PlayerGamePlay.broadcastMessage(38, "")
      incomingSNOMessage(SNOID, 1, localPlayer, stateMachine.getCurrentStateIndex(), true)
      incomingSNOMessage(SNOID, 2, localPlayer, stateMachine.getCurrentStateIndex(), true)
    end
  end
end
function deleteObjectFromSNO()
  NetworkLog.Write(">[LUA] PHASE MANAGER - deleteObjectFromSNO!")
  SNOID = false
end
function shouldMigrateToLocal(SNOID)
  if Network.isLowestStationID() then
    return true
  else
    return false
  end
end
function sendMessage(messageType, message)
  if localPlayer.playerID and SNOID then
    message = message ~= nil and tostring(message) or ""
    if isLocal then
      incomingSNOMessage(SNOID, messageType, localPlayer, message, true)
    else
      SNO.sendMessage(SNOID, messageType, message)
    end
  end
end
function incomingSNOMessage(SNOID, messageType, fromPlayer, message, fromSelf)
  message = tonumber(message)
  if messageType == 1 then
    if fromPlayer.playerID ~= localPlayer.playerID or fromPlayer.playerID == localPlayer.playerID and fromSelf then
      currentStateList[fromPlayer.playerID + 1] = message
      networkParsing.writeBuffer(SNO, SNOID, 1, currentStateBuffer, currentStateList)
      stateMachine.timeSinceAnyStateChange = g_NetworkTime
    end
  elseif messageType == 2 then
    if fromPlayer.playerID ~= localPlayer.playerID or fromPlayer.playerID == localPlayer.playerID and fromSelf then
      moveToStateList[fromPlayer.playerID + 1] = message
      networkParsing.writeBuffer(SNO, SNOID, 2, moveToStateBuffer, moveToStateList)
      stateMachine.timeSinceAnyStateChange = g_NetworkTime
    end
  elseif messageType == 3 then
    vehicleRequest(fromPlayer)
  elseif messageType == 4 then
    vehicleManager.callForDeletion(message, true)
  elseif messageType == 5 then
    toFewPlayers(message)
  elseif messageType == 6 then
    modeOrFaceOffEnded()
  elseif messageType == 7 then
    joiningPlayersList[fromPlayer.playerID + 1].wait = g_NetworkTime
    joiningPlayersList[fromPlayer.playerID + 1].messageSent = false
  end
end
function removePlayer(playerID)
  if isLocal then
    vehicleGrid[playerID + 1] = 0
    currentStateList[playerID + 1] = 0
    moveToStateList[playerID + 1] = 0
    networkParsing.writeBuffer(SNO, SNOID, 1, currentStateBuffer, currentStateList)
    networkParsing.writeBuffer(SNO, SNOID, 2, moveToStateBuffer, moveToStateList)
    stateMachine.timeSinceAnyStateChange = g_NetworkTime
  end
  joiningPlayersList[playerID + 1].messageSent = false
  joiningPlayersList[playerID + 1].wait = nil
end
function receiveEndCleanUpPhase(playerID)
  print("receiveEndCleanUpPhase for player " .. tostring(playerID))
  phaseManager.onReceivedPlayerCleanupMessage(playerID)
end
_G.ReceiveEndCleanUpPhase = receiveEndCleanUpPhase
