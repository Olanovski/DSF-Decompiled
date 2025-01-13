module("faceOffSystem")
local networkVarBuffer = {
  bytes = 64,
  lookupTable = networkParsing.makeLookupTable({
    {name = "faceOffID", parseType = "uinteger8"},
    {name = "startTime", parseType = "float"},
    {name = "areaKey", parseType = "uinteger8"},
    {name = "complete", parseType = "boolean"}
  })
}
function networkVarBuffer.bufferUpdate(instance, newBuffer)
  instance.networkVars.__index = newBuffer
end
local pointTrackingBuffer = {
  bytes = 128,
  indexed = true,
  indexParseType = "integer8",
  valueParseType = "uinteger16"
}
function pointTrackingBuffer.bufferUpdate(instance, newBuffer)
  instance.pointTracking.__index = newBuffer
end
function createSNOFromObject(instance)
  local SNOID = SNO.createSNO(5)
  SNO.createBuffer(SNOID, networkVarBuffer.bytes)
  networkParsing.writeBuffer(SNO, SNOID, 0, networkVarBuffer, instance.networkVars)
  SNO.createBuffer(SNOID, pointTrackingBuffer.bytes)
  networkParsing.writeBuffer(SNO, SNOID, 1, pointTrackingBuffer, instance.pointTracking)
  SNO.SNOInitialised(SNOID)
  return SNOID
end
function updateSNOFromObject(instance)
  if instance.networkVars.updateRequired then
    networkParsing.writeBuffer(SNO, instance.instanceID, 0, networkVarBuffer, instance.networkVars)
    instance.networkVars.updateRequired = false
  end
  if instance.pointTracking.updateRequired then
    networkParsing.writeBuffer(SNO, instance.instanceID, 1, pointTrackingBuffer, instance.pointTracking)
    instance.pointTracking.updateRequired = false
  end
end
function createObjectFromSNO(SNOID, numBuffers)
  local networkVars = networkParsing.readBuffer(SNO, SNOID, 0, networkVarBuffer)
  local pointTracking = networkParsing.readBuffer(SNO, SNOID, 1, pointTrackingBuffer)
  assert(networkVars.areaKey, "Area lock-out key not arrived in time")
  currentFaceOff = buildInstance(networkVars, SNOID, pointTracking)
end
function updateObjectFromSNO(SNOID, bufferID)
  if bufferID == 0 then
    networkParsing.readBuffer(SNO, SNOID, bufferID, networkVarBuffer, currentFaceOff)
  elseif bufferID == 1 then
    networkParsing.readBuffer(SNO, SNOID, bufferID, pointTrackingBuffer, currentFaceOff)
  end
end
function deleteObjectFromSNO(SNOID)
  if currentFaceOff then
    faceOffSystem.endFaceOffWhenWeCan()
  end
end
function sendMessage(messageType, message)
  message = message ~= nil and tostring(message) or ""
  if currentFaceOff.isLocal then
    incomingSNOMessage(currentFaceOff.instanceID, messageType, localPlayer, message)
  else
    SNO.sendMessage(currentFaceOff.instanceID, messageType, message)
  end
end
function incomingSNOMessage(SNOID, messageType, player, data)
  if messageType == 0 then
    currentFaceOff:assignPoints(player, tonumber(data))
  elseif messageType == 1 then
    forceEndFaceOff()
  end
end
function setObjectIsLocal(SNOID, isLocal)
  NetworkLog.WriteDetail(">[LUA] FACEOFF SYSTEM - setObjectIsLocal: " .. tostring(isLocal) .. ", currentFaceOff.isLocal: " .. tostring(currentFaceOff.isLocal))
  if currentFaceOff and currentFaceOff.isLocal ~= isLocal then
    NetworkLog.WriteDetail(">[LUA] FACEOFF SYSTEM - setObjectIsLocal - claimed")
    currentFaceOff.isLocal = isLocal
  end
end
function shouldMigrateToLocal(SNOID)
  return phaseManager.shouldMigrateToLocal()
end
