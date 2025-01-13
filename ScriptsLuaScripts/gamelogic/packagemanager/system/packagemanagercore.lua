module("packageManager", package.seeall)
numPackages = 0
packagesBySNOID = {}
invalidOwnerID = -2
invulnerabilityTime = 2
updateZapToActionType = 1
playerLeftPackageDropType = 1
oldTimeStamp = 5
lockOwnerInPackage = false
function setInvulnerabilityTime(value)
  invulnerabilityTime = value
end
function setUpdateZapToActionType(value)
  updateZapToActionType = value
end
function setPlayerLeftPackageDropType(value)
  playerLeftPackageDropType = value
end
function setlockOwnerInPackageType(value)
  lockOwnerInPackage = value
end
function update()
  updateNetworkQueue()
  for SNOID, package in next, packagesBySNOID, nil do
    package:update()
  end
  stepRequests()
end
function purge()
  for SNOID, package in next, packagesBySNOID, nil do
    package:release()
  end
  packagesBySNOID = {}
end
function importantPackageManagerVehicle(SNVID)
  for SNOID, package in next, packagesBySNOID, nil do
    if package:isPackageCarrier(SNVID) then
      return true
    end
  end
  return false
end
_G.importantPackageManagerVehicle = importantPackageManagerVehicle
function getTaskObjectByVehicle(vehicle)
  for SNOID, package in next, packagesBySNOID, nil do
    if package:isPackageCarrier(vehicle.SNVID) then
      return package:getTaskObject()
    end
  end
  return nil
end
function vehicleBeingDeleted(vehicle)
  for SNOID, package in next, packagesBySNOID, nil do
    if package.isLocal and package.owner and package.owner == vehicle then
      package:packageDropped()
    end
  end
end
local player
function playerNotLockedInPackage(localID)
  if lockOwnerInPackage then
    player = localPlayerManager.players[localID]
    if player.currentVehicle then
      for SNOID, package in next, packagesBySNOID, nil do
        if package.owner and package.owner == player.currentVehicle then
          return false
        end
      end
    end
  end
  return true
end
