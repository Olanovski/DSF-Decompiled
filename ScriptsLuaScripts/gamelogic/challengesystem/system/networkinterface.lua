module("challengeSystem")
local networkVarBuffer = {
  bytes = 64,
  lookupTable = networkParsing.makeLookupTable({
    {
      name = "challengeID",
      parseType = "uinteger16"
    },
    {
      name = "countDownTime",
      parseType = "float"
    },
    {name = "startTime", parseType = "float"},
    {name = "overTime", parseType = "float"},
    {name = "phase", parseType = "uinteger8"},
    {name = "roundOn", parseType = "uinteger8"},
    {name = "routeIndex", parseType = "uinteger8"},
    {
      name = "modeWillReset",
      parseType = "boolean"
    },
    {name = "isComplete", parseType = "boolean"},
    {
      name = "flagForDeletion",
      parseType = "boolean"
    }
  })
}
function networkVarBuffer.bufferUpdate(instance, newBuffer)
  instance.networkVars.__index = newBuffer
end
local linkedObjectBuffer = {
  bytes = 128,
  simple = true,
  parseType = "uinteger16"
}
local scoreBuffer = {
  bytes = 64,
  lookupTable = networkParsing.makeLookupTable({
    {name = "team1", parseType = "uinteger16"},
    {name = "team2", parseType = "uinteger16"}
  })
}
function scoreBuffer.bufferUpdate(instance, newBuffer)
  instance.teamScores.__index = newBuffer
end
local playerScoreBuffer = {
  bytes = 64,
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
function playerScoreBuffer.bufferUpdate(instance, newBuffer)
  instance.playerScores.__index = newBuffer
end
local turnTrackingBuffer = {
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
function turnTrackingBuffer.bufferUpdate(instance, newBuffer)
  instance.turnTracking.__index = newBuffer
end
function createSNOFromObject(instance)
  NetworkLog.Write(">[LUA] CHALLENGESYSTEM - Create SNO for local mission, mission = " .. tostring(instance.challenge.name))
  local SNOID = SNO.createSNO(0)
  SNO.createBuffer(SNOID, networkVarBuffer.bytes)
  networkParsing.writeBuffer(SNO, SNOID, 0, networkVarBuffer, instance.networkVars)
  for i = 1, 2 do
    SNO.createBuffer(SNOID, linkedObjectBuffer.bytes)
    networkParsing.writeBuffer(SNO, SNOID, i, linkedObjectBuffer, instance.networkLinks[i])
  end
  if instance.playerScores then
    SNO.createBuffer(SNOID, playerScoreBuffer.bytes)
    networkParsing.writeBuffer(SNO, SNOID, 3, playerScoreBuffer, instance.playerScores)
  end
  if instance.teamScores then
    SNO.createBuffer(SNOID, scoreBuffer.bytes)
    networkParsing.writeBuffer(SNO, SNOID, 4, scoreBuffer, instance.teamScores)
  end
  if instance.turnTracking then
    SNO.createBuffer(SNOID, turnTrackingBuffer.bytes)
    networkParsing.writeBuffer(SNO, SNOID, 4, turnTrackingBuffer, instance.turnTracking)
  end
  SNO.SNOInitialised(SNOID)
  return SNOID
end
function updateSNOFromObject(instance)
  if instance.networkVars.updateRequired then
    NetworkLog.WriteDetail(">[LUA] CHALLENGESYSTEM - Update local mission networkVars buffer, SNOID = " .. tostring(instance.instanceID) .. ", mission = " .. tostring(instance.challenge.name))
    networkParsing.writeBuffer(SNO, instance.instanceID, 0, networkVarBuffer, instance.networkVars)
    instance.networkVars.updateRequired = false
  end
  if instance.teamScores and instance.teamScores.updateRequired then
    NetworkLog.WriteDetail(">[LUA] CHALLENGESYSTEM - Update local mission teamScores buffer, SNOID = " .. tostring(instance.instanceID) .. ", mission = " .. tostring(instance.challenge.name))
    networkParsing.writeBuffer(SNO, instance.instanceID, 4, scoreBuffer, instance.teamScores)
    instance.teamScores.updateRequired = false
  end
  if instance.turnTracking and instance.turnTracking.updateRequired then
    NetworkLog.WriteDetail(">[LUA] CHALLENGESYSTEM - Update local mission teamScores buffer, SNOID = " .. tostring(instance.instanceID) .. ", mission = " .. tostring(instance.challenge.name))
    networkParsing.writeBuffer(SNO, instance.instanceID, 4, turnTrackingBuffer, instance.turnTracking)
    instance.turnTracking.updateRequired = false
  end
  if instance.playerScores and instance.playerScores.updateRequired then
    NetworkLog.WriteDetail(">[LUA] CHALLENGESYSTEM - Update local mission playerScores buffer, SNOID = " .. tostring(instance.instanceID) .. ", mission = " .. tostring(instance.challenge.name))
    networkParsing.writeBuffer(SNO, instance.instanceID, 3, playerScoreBuffer, instance.playerScores)
    instance.playerScores.updateRequired = false
  end
  for i = 1, 2 do
    if instance.networkLinks[i].updateRequired then
      NetworkLog.WriteDetail(">[LUA] CHALLENGESYSTEM - Update local mission linkedObjects buffer, SNOID = " .. tostring(instance.instanceID) .. ", mission = " .. tostring(instance.challenge.name) .. ", linkType = " .. i)
      networkParsing.writeBuffer(SNO, instance.instanceID, i, linkedObjectBuffer, instance.networkLinks[i])
      instance.networkLinks[i].updateRequired = false
    end
  end
end
function createObjectFromSNO(SNOID, numBuffers)
  NetworkLog.Write(">[LUA] CHALLENGESYSTEM - Create remote mission from SNO, SNOID = " .. tostring(SNOID))
  local networkVars = networkParsing.readBuffer(SNO, SNOID, 0, networkVarBuffer)
  local networkLinks = {}
  for i = 1, 2 do
    networkLinks[i] = networkParsing.blindReadBuffer(SNO, SNOID, i)
  end
  local instance = buildInstance(networkVars, SNOID, networkLinks)
  if instance.teamScores then
    networkParsing.readBuffer(SNO, SNOID, 4, scoreBuffer, instance)
  end
  if instance.turnTracking then
    networkParsing.readBuffer(SNO, SNOID, 4, turnTrackingBuffer, instance)
  end
  if instance.playerScores then
    networkParsing.readBuffer(SNO, SNOID, 3, playerScoreBuffer, instance)
  end
end
function updateObjectFromSNO(SNOID, bufferID)
  local instance = instances[SNOID]
  if instance then
    NetworkLog.WriteDetail(">[LUA] CHALLENGESYSTEM - Mission buffer update, SNOID = " .. tostring(instance.instanceID) .. ", mission = " .. tostring(instance.challenge.name) .. ", bufferID = " .. tostring(bufferID))
    if bufferID == 0 then
      networkParsing.readBuffer(SNO, SNOID, bufferID, networkVarBuffer, instance)
    elseif bufferID == 4 then
      if 0 < instance.challenge.settings.numRounds then
        networkParsing.readBuffer(SNO, SNOID, bufferID, scoreBuffer, instance)
      elseif 0 > instance.challenge.settings.numRounds then
        networkParsing.readBuffer(SNO, SNOID, bufferID, turnTrackingBuffer, instance)
      end
    elseif bufferID == 3 then
      networkParsing.readBuffer(SNO, SNOID, bufferID, playerScoreBuffer, instance)
    else
      instance.networkLinks[bufferID] = networkParsing.blindReadBuffer(SNO, SNOID, bufferID)
    end
  end
end
function setObjectIsLocal(SNOID, isLocal)
  local instance = instances[SNOID]
  if instance and instance.isLocal ~= isLocal then
    NetworkLog.Write(">[LUA] CHALLENGESYSTEM - Mission isLocal update, SNOID = " .. tostring(instance.instanceID) .. ", mission = " .. tostring(instance.challenge.name) .. ", new isLocal = " .. tostring(isLocal))
    instance.isLocal = isLocal
  end
end
function deleteObjectFromSNO(SNOID)
  local instance = instances[SNOID]
  if instance then
    NetworkLog.Write(">[LUA] CHALLENGESYSTEM - Delete remote mission, SNOID = " .. tostring(instance.instanceID) .. ", mission = " .. tostring(instance.challenge.name))
    instance:endInstanceWhenYouCan()
  end
end
local sortPlayers = function(playerA, playerB)
  if playerA.playerID < playerB.playerID then
    return true
  end
  return false
end
function shouldMigrateToLocal(SNOID)
  local instance = instances[SNOID]
  if instance and Network.isLowestStationID() then
    return true
  end
  return false
end
function sendMessage(instance, messageType, message)
  message = message ~= nil and tostring(message) or ""
  if instance.isLocal then
    incomingSNOMessage(instance.instanceID, messageType, localPlayer, message)
  else
    SNO.sendMessage(instance.instanceID, messageType, message)
  end
end
function incomingSNOMessage(SNOID, messageType, fromPlayer, message)
  if messageType == 1 then
    instances[SNOID]:initiateOverTimePhase()
  end
end
