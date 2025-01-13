module("onlineRaceManager", package.seeall)
isLocal = false
SNOID = false
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
playersCheckpointNumBuffer = {
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
networkVars = {raceEndTimer = 0}
networkVarBuffer = {
  bytes = 64,
  lookupTable = networkParsing.makeLookupTable({
    {
      name = "raceEndTimer",
      parseType = "float"
    }
  })
}
function createSNOFromObject()
  local SNOID = SNO.createSNO(7)
  NetworkLog.Write(">[LUA] ONLINE RACEMANAGER - createSNOFromObject - SNO Created = SNO: " .. tostring(SNOID))
  SNO.createBuffer(SNOID, playersCheckpointNumBuffer.bytes)
  networkParsing.writeBuffer(SNO, SNOID, 0, playersCheckpointNumBuffer, playersCheckpointNum)
  SNO.createBuffer(SNOID, networkVarBuffer.bytes)
  networkParsing.writeBuffer(SNO, SNOID, 1, networkVarBuffer, networkVars)
  SNO.SNOInitialised(SNOID)
  return SNOID
end
function createObjectFromSNO(SNOID, numBuffers)
  NetworkLog.Write(">[LUA] ONLINE RACEMANAGER - createObjectFromSNO - SNO Created = SNO: " .. tostring(SNOID))
  onlineRaceManager.SNOID = SNOID
  isLocal = false
  networkParsing.readBuffer(SNO, SNOID, 0, playersCheckpointNumBuffer, playersCheckpointNum)
  networkParsing.readBuffer(SNO, SNOID, 1, networkVarBuffer, networkVars)
end
function updateObjectFromSNO(SNOID, bufferID)
  NetworkLog.WriteDetail(">[LUA] ONLINE RACEMANAGER - updateObjectFromSNO - Update SNO: " .. tostring(SNOID) .. " bufferID: " .. tostring(bufferID))
  if bufferID == 0 then
    networkParsing.readBuffer(SNO, SNOID, 0, playersCheckpointNumBuffer, playersCheckpointNum)
    updateRacerCheckpoints()
  elseif bufferID == 1 then
    networkParsing.readBuffer(SNO, SNOID, 1, networkVarBuffer, networkVars)
  end
end
function setObjectIsLocal(SNOID, isLocal)
  if onlineRaceManager.isLocal ~= isLocal then
    NetworkLog.Write(">[LUA] ONLINE RACEMANAGER - setObjectIsLocal - Update SNO: " .. tostring(SNOID) .. " isLocal: " .. tostring(isLocal))
    onlineRaceManager.isLocal = isLocal
  end
end
function deleteObjectFromSNO(SNOID)
  purge()
end
function shouldMigrateToLocal(SNOID)
  if Network.isLowestStationID() then
    return true
  else
    return false
  end
end
function incomingSNOMessage(SNOID, messageType, fromPlayer, data)
  data = tonumber(data)
  if messageType == 1 then
    playersCheckpointNum[fromPlayer.playerID + 1] = data
    networkParsing.writeBuffer(SNO, SNOID, 0, playersCheckpointNumBuffer, playersCheckpointNum)
    updateRacerCheckpoints()
  elseif messageType == 2 and networkVars.raceEndTimer == 0 then
    networkVars.raceEndTimer = data
    networkParsing.writeBuffer(SNO, SNOID, 1, networkVarBuffer, networkVars)
  end
end
function sendMessage(messageType, message)
  message = message ~= nil and tostring(message) or ""
  if isLocal then
    incomingSNOMessage(SNOID, messageType, localPlayer, message)
  else
    SNO.sendMessage(SNOID, messageType, message)
  end
end
