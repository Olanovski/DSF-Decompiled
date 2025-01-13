module("vehicleManager")
local networkVarBuffer = {
  bytes = 64,
  lookupTable = networkParsing.makeLookupTable({
    {
      name = "taskObjectID",
      parseType = "uinteger16"
    },
    {
      name = "multiplayerBus",
      parseType = "boolean"
    },
    {
      name = "onlineRequiredVehicle",
      parseType = "boolean"
    },
    {
      name = "onlineOwnerID",
      parseType = "uinteger16"
    }
  })
}
function networkVarBuffer.bufferUpdate(vehicle, newBuffer)
  vehicle.networkVars.__index = newBuffer
end
function createRemoteSNV(SNVID, numBuffers, gameVehicle)
  NetworkLog.Write(">[LUA] VEHICLE MANAGER - Creating script vehicle from remote, SNVID = " .. tostring(SNVID))
  local parameters = {
    networkVars = networkParsing.readBuffer(SNV, SNVID, 0, networkVarBuffer),
    gameVehicle = gameVehicle
  }
  local vehicle = registerVehicle(parameters)
  if vehicle.networkVars.onlineOwnerID ~= nil and vehicle.networkVars.onlineOwnerID ~= localPlayer.playerID then
    zapcontroller.AddLockedVehicle({
      gameVehicle = vehicle.gameVehicle
    })
  end
end
_G.remoteScriptedNetworkVehicleCreated = createRemoteSNV
function updateRemoteSNV(SNVID, bufferID)
  local vehicle = vehiclesBySNVID[SNVID]
  assert(vehicle, "VEHICLEMANAGER - updateRemoteSNV: COULD NOT FIND VEHICLE WITH SNVID " .. tostring(SNVID))
  NetworkLog.Write(">[LUA] VEHICLE MANAGER - Update remote vehicle from buffer, SNVID = " .. tostring(SNVID) .. ", bufferID = " .. tostring(bufferID))
  local onlineRequiredVehicle = vehicle.networkVars.onlineRequiredVehicle
  if bufferID == 0 then
    networkParsing.readBuffer(SNV, SNVID, bufferID, networkVarBuffer, vehicle)
    vehicleManagerCoreReflection.synchNetworkVars(vehicle.gameVehicle, vehicle.networkVars)
  end
  if onlineRequiredVehicle and not vehicle.networkVars.onlineRequiredVehicle and not taskSystem.isAgentRestricted(vehicle, 0) then
    zapcontroller.RemoveLockedVehicle({
      gameVehicle = vehicle.gameVehicle
    })
  end
end
_G.SNVBufferUpdated = updateRemoteSNV
function setSNVLocalStatus(SNVID, newIsLocal)
  local vehicle = vehiclesBySNVID[SNVID]
  if vehicle then
    newIsLocal = newIsLocal == 1
    if newIsLocal ~= vehicle.isLocal then
      NetworkLog.Write(">[LUA] VEHICLE MANAGER - Update vehicle local status, SNVID = " .. tostring(SNVID) .. ", new isLocal = " .. tostring(newIsLocal))
      if newIsLocal then
        vehicle.isLocal = true
        vehicleManagerCoreReflection.setIsLocal(vehicle.gameVehicle, vehicle.isLocal)
        if vehicle:getTaskObject() then
          vehicle:getTaskObject():refreshAI()
          vehicle:getTaskObject():refreshMinorTaskAI()
        end
      else
        vehicle:stopHighSpeedDriving()
        vehicle.isLocal = false
        vehicleManagerCoreReflection.setIsLocal(vehicle.gameVehicle, vehicle.isLocal)
      end
    end
  end
end
_G.setIsLocal = setSNVLocalStatus
function orphanRemoteSNV(SNVID)
  local vehicle = vehiclesBySNVID[SNVID]
  assert(vehicle, "VEHICLEMANAGER - orphanRemoteSNV: COULD NOT FIND VEHICLE WITH SNVID " .. tostring(SNVID))
  NetworkLog.Write(">[LUA] VEHICLE MANAGER - Convert remote vehicle to orphan, SNVID = " .. tostring(SNVID))
  vehicle:makeOrphan()
end
_G.orphanScriptedNetworkVehicle = orphanRemoteSNV
function deleteRemoteSNV(SNVID)
  local vehicle = vehiclesBySNVID[SNVID]
  assert(vehicle, "VEHICLEMANAGER - deleteRemoteSNV: COULD NOT FIND VEHICLE WITH SNVID " .. tostring(SNVID))
  NetworkLog.Write(">[LUA] VEHICLE MANAGER - Delete remote vehicle, SNVID = " .. tostring(SNVID))
  if vehicle == multiplayerBusManager.multiplayerBus or vehicle == multiplayerBusManager.remoteBusVehicle then
    vehicleManager.multiplayerBusManager.deactivateMultiplayerBus()
  end
  for localID, plr in next, localPlayerManager.players, nil do
    if plr.currentVehicle == vehicle and not plr.inZap then
      plr:SetZapLevel(1, nil, false, {forcedOut = true})
      plr:clearCurrentVehicle()
      plr:clearPreviousVehicle()
    end
  end
  vehicle:delete()
end
_G.deleteScriptedNetworkVehicle = deleteRemoteSNV
local sortPlayers = function(playerA, playerB)
  if playerA.playerID < playerB.playerID then
    return true
  end
  return false
end
function shouldSNVMigrateToLocal(SNVID)
  local vehicle = vehiclesBySNVID[SNVID]
  if vehicle then
    if SNV.SNVShouldMigrateToLocal(SNVID) == true then
      return true
    else
      return false
    end
  end
  return false
end
_G.SNVShouldMigrateToLocal = shouldSNVMigrateToLocal
function vehicleTemplate:updateLocalSNV()
  NetworkLog.Write(">[LUA] VEHICLE MANAGER - Updating buffers for local SNV, SNVID = " .. tostring(self.SNVID))
  networkParsing.writeBuffer(SNV, self.SNVID, 0, networkVarBuffer, self.networkVars)
  self.networkVars.updateRequired = false
end
local damageDetectionCallbacks = {}
function registerDamageDetectionCallback(SNVID, callback)
  damageDetectionCallbacks[SNVID] = callback
end
function clearDamageDetectionCallbacks()
  damageDetectionCallbacks = {}
end
function clearDamageDetectionCallback(SNVID)
  if damageDetectionCallbacks[SNVID] then
    damageDetectionCallbacks[SNVID] = nil
  end
end
function SNVTakenDamageFromRemoteSNV(localSNVID, remoteSNVID)
  if damageDetectionCallbacks[localSNVID] then
    damageDetectionCallbacks[localSNVID](remoteSNVID)
  end
end
_G.SNVTakenDamageFromRemoteSNV = SNVTakenDamageFromRemoteSNV
