module("packageManager", package.seeall)
local packageBuffer = {
  bytes = 64,
  lookupTable = networkParsing.makeLookupTable({
    {name = "ownerID", parseType = "integer16"},
    {name = "playerID", parseType = "integer8"},
    {
      name = "taskObjectID",
      parseType = "uinteger16"
    },
    {
      name = "damageMultiplier",
      parseType = "uinteger8"
    },
    {name = "onFloor", parseType = "boolean"},
    {name = "index", parseType = "uinteger8"},
    {name = "active", parseType = "boolean"},
    {name = "timeStamp", parseType = "float"},
    {name = "position", vector = true}
  })
}
networkQueue = {
  protoObjects = {},
  setOwner = {}
}
function packageBuffer.bufferUpdate(package, newBuffer)
  if newBuffer.playerID then
    networkQueue.setOwner[package.SNOID] = {
      package = package,
      newOwnerID = newBuffer.ownerID,
      newplayerID = newBuffer.playerID,
      position = newBuffer.position
    }
  elseif newBuffer.ownerID then
    package:playerLeft(newBuffer)
  else
    package:packageDropped(newBuffer.position, newBuffer.active)
  end
end
function updateNetworkQueue()
  for SNOID, protoData in next, networkQueue.protoObjects, nil do
    if protoData.ownerID and protoData.ownerID ~= invalidOwnerID then
      local owner = vehicleManager.vehiclesBySNVID[protoData.ownerID]
      if owner then
        createPackage(protoData.drawPackage, protoData.position, protoData.isLocal, protoData.damageMultiplier, owner, SNOID, protoData.taskObjectID, protoData.playerID, protoData.index, protoData.active)
        networkQueue.protoObjects[SNOID] = nil
      end
    else
      createPackage(protoData.drawPackage, protoData.position, protoData.isLocal, protoData.damageMultiplier, nil, SNOID, protoData.taskObjectID, protoData.playerID, protoData.index, protoData.active)
      networkQueue.protoObjects[SNOID] = nil
    end
  end
  for SNOID, packageData in next, networkQueue.setOwner, nil do
    local newOwner = vehicleManager.vehiclesBySNVID[packageData.newOwnerID]
    if newOwner and playerManager.players[packageData.newplayerID] then
      packageData.package:setOwner(newOwner, packageData.newplayerID)
      networkQueue.setOwner[SNOID] = nil
    end
  end
end
function createSNOFromObject(package)
  local SNOID = SNO.createSNO(3)
  NetworkLog.Write(">[LUA] PACKAGEMANAGER - Create SNO from package. SNO Created = SNO: " .. tostring(SNOID))
  SNO.createBuffer(SNOID, packageBuffer.bytes)
  networkParsing.writeBuffer(SNO, SNOID, 0, packageBuffer, package)
  SNO.SNOInitialised(SNOID)
  return SNOID
end
function createObjectFromSNO(SNOID, numBuffers)
  NetworkLog.Write(">[LUA] PACKAGEMANAGER - Create package from SNO. SNO: " .. tostring(package.SNOID))
  networkQueue.protoObjects[SNOID] = networkParsing.readBuffer(SNO, SNOID, 0, packageBuffer)
  networkQueue.protoObjects[SNOID].isLocal = false
end
function updateSNOFromObject(package)
  NetworkLog.WriteDetail(">[LUA] PACKAGEMANAGER - Update SNO From package. SNO: " .. tostring(package.SNOID))
  networkParsing.writeBuffer(SNO, package.SNOID, 0, packageBuffer, package)
end
function updateObjectFromSNO(SNOID, bufferID)
  if packagesBySNOID[SNOID] then
    NetworkLog.WriteDetail(">[LUA] PACKAGEMANAGER - Update package from SNO. SNO: " .. tostring(package.SNOID))
    networkParsing.readBuffer(SNO, SNOID, bufferID, packageBuffer, packagesBySNOID[SNOID])
  elseif networkQueue.protoObjects[SNOID] then
    NetworkLog.WriteDetail(">[LUA] PACKAGEMANAGER - Update proto package from SNO. SNO: " .. tostring(package.SNOID))
    local buffer = networkParsing.readBuffer(SNO, SNOID, bufferID, packageBuffer)
    for varName, varValue in next, buffer, nil do
      networkQueue.protoObjects[SNOID][varName] = varValue
    end
  end
end
function setObjectIsLocal(SNOID, isLocal)
  if packagesBySNOID[SNOID] then
    if packagesBySNOID[SNOID].isLocal ~= isLocal then
      packagesBySNOID[SNOID].isLocal = isLocal
      NetworkLog.Write(">[LUA] PACKAGEMANAGER - Set package local. SNO: " .. tostring(SNOID))
      updateSNOFromObject(packagesBySNOID[SNOID])
    end
  elseif networkQueue.protoObjects[SNOID] and networkQueue.protoObjects[SNOID].isLocal ~= isLocal then
    networkQueue.protoObjects[SNOID].isLocal = isLocal
    NetworkLog.Write(">[LUA] PACKAGEMANAGER - Set proto package local. SNO: " .. tostring(SNOID))
  end
end
function deleteObjectFromSNO(SNOID)
  if packagesBySNOID[SNOID] then
    NetworkLog.Write(">[LUA] PACKAGEMANAGER - Delete package. SNO " .. tostring(SNOID))
    packagesBySNOID[SNOID]:release()
  elseif networkQueue.protoObjects[SNOID] then
    networkQueue.protoObjects[SNOID] = nil
  end
end
function shouldMigrateToLocal(SNOID)
  local package = packagesBySNOID[SNOID]
  local returnValue = false
  if package then
    if package:getTaskObject() and challengeSystem.shouldMigrateToLocal(package:getTaskObject().coreData.instanceID) then
      return true
    end
    if package.owner and vehicleManager.shouldSNVMigrateToLocal(package.owner) then
      return true
    end
    if Network.isLowestStationID() then
      return true
    end
  end
  return returnValue
end
function sendMessage(package, messageType, message)
  if package.isLocal then
    incomingSNOMessage(package.SNOID, messageType, localPlayer, message, true)
  else
    SNO.sendMessage(package.SNOID, messageType, message)
  end
end
function incomingSNOMessage(SNOID, messageType, fromPlayer, message, fromSelf)
  local package = packagesBySNOID[SNOID]
  if messageType == 1 then
    package:ownershipRequest(fromPlayer, message)
  elseif messageType == 2 then
    package:dropRequest(fromPlayer, message)
  end
end
