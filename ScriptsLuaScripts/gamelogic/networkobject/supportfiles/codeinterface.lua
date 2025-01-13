g_NetworkTime = 0
function updateNetworkTime()
  local getTime = Network.getTime
  return function()
    g_NetworkTime = getTime()
  end
end
local SNOTypeLookup = {
  [0] = challengeSystem,
  [1] = taskSystem,
  [2] = checkpointSystem,
  [3] = packageManager,
  [4] = phaseManager,
  [5] = faceOffSystem,
  [6] = phaseManager.playlistSupport,
  [7] = onlineRaceManager
}
function SNORemoteObjectCreated(SNOID, SNOType, numBuffers)
  SNOTypeLookup[SNOType].createObjectFromSNO(SNOID, numBuffers)
end
function SNOBufferUpdated(SNOID, SNOType, bufferID)
  SNOTypeLookup[SNOType].updateObjectFromSNO(SNOID, bufferID)
end
function SNOSetIsLocal(SNOID, SNOType, isLocal)
  isLocal = isLocal == 1
  SNOTypeLookup[SNOType].setObjectIsLocal(SNOID, isLocal)
end
function SNODeleteRemoteObject(SNOID, SNOType)
  SNOTypeLookup[SNOType].deleteObjectFromSNO(SNOID)
end
function SNOShouldMigrateToLocal(SNOID, SNOType)
  return SNOTypeLookup[SNOType].shouldMigrateToLocal(SNOID)
end
function SNOMsgReceived(playerID, SNOID, SNOType, MSGType, dataLength, data)
  local fromPlayer = playerManager.players[playerID]
  assert(fromPlayer, "Received a message from an unknown player, playerID " .. tostring(playerID) .. " SNOType " .. tostring(SNOType) .. " MSGType " .. tostring(MSGType))
  data = string.sub(data, 1, dataLength)
  SNOTypeLookup[SNOType].incomingSNOMessage(SNOID, MSGType, fromPlayer, data)
end
function SNOGetObjectName(SNOID, SNOType)
  if SNOType == 0 then
    return "Challenge Object"
  elseif SNOType == 1 then
    local string = "Task Object - "
    local taskObject = taskSystem.taskObjects[SNOID]
    if taskObject then
      return string .. taskObject.coreData.actor.ID
    else
      return string .. "unknown"
    end
  elseif SNOType == 2 then
    return "Checkpoint Object"
  elseif SNOType == 3 then
    return "Package Object"
  elseif SNOType == 4 then
    return "Phase manager object"
  elseif SNOType == 5 then
    return "Face off object"
  elseif SNOType == 6 then
    return "Play list object"
  elseif SNOType == 7 then
    return "Online Race Manager"
  end
  return "unknown SNOType"
end
function HostPromotion()
  NetworkLog.Write(">[LUA] Netz host changed!")
  local returnToParty = 0
  if not phaseManager.SNOID or not phaseManager.playlistSupport.SNOID or not onlineRaceManager.SNOID then
    NetworkLog.Write(">[LUA] Netz host change and we dont have all SNOs so return to the bus!")
    returnToParty = 1
  end
  if returnToParty == 0 then
    phaseManager.resendTimeToJoinScore()
  end
  return returnToParty
end
