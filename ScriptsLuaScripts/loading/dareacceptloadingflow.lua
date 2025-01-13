module("dareAcceptLoading", package.seeall)
state = "inactive"
local debugOutput = function(output)
  print("[dareAcceptLoading] : " .. tostring(output))
end
function handleDareAcceptLoading(spawnPosition, spawnHeading, callback)
  debugOutput(" start")
  callStack()
  state = "loadActivityVehicle"
  loadingSystem.loadingStart()
  local f = handleDareAcceptLoading_update(spawnPosition, spawnHeading, callback)
  addUserUpdateFunction("dareAcceptLoading", f, 1)
end
function handleDareAcceptLoading_update(spawnPosition, spawnHeading, callback)
  return function()
    if state == "loadActivityVehicle" then
      state = "active - loadActivityVehicle"
      local gameVehicle = not localPlayer.inZap and localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle
      local vehicleModelToSpawn
      if not gameVehicle then
        vehicleModelToSpawn = vehicleManager.getBestOwnedModelID()
        print("vehicleModelToSpawn = " .. tostring(vehicleModelToSpawn))
      end
      local function spawn()
        local params = {
          position = spawnPosition,
          heading = spawnHeading,
          modelID = vehicleModelToSpawn
        }
        local vehicle = vehicleManager.spawnVehicle(params)
        for i = 1, 3 do
          GameVehicleResource.setCharacterSpoolingEntityIndex(vehicle.gameVehicle, i, -1)
        end
        localPlayer:clearPreviousVehicle()
        if localPlayer.currentVehicle then
          localPlayer.currentVehicle:delete()
        end
        localPlayer:SetZapLevel(0, vehicle, true, {disableZapFlash = true})
        gameVehicle = vehicle.gameVehicle
      end
      local function waitForSpooling()
        if TrafficSpooler.IsPlayerVehicleLoaded() then
          spawn()
          if callback then
            callback()
          end
          loadingSystem.loadingComplete()
          state = "cleanup"
          removeUserUpdateFunction("spawnVehicle")
        end
      end
      if gameVehicle then
        if callback then
          callback()
        end
        state = "cleanup"
      else
        TrafficSpooler.SetAsPlayerVehicle(vehicleModelToSpawn)
        addUserUpdateFunction("spawnVehicle", waitForSpooling, 1)
      end
    elseif state == "cleanup" then
      felony_patrollingVehicleManager.enablePatrollingVehicles(false)
      felony_suspiciousVehicleManager.enableSuspiciousVehicles(false)
      progressionSystem.setTrafficEvents(false)
      vehicleManager.clearOrphanage()
      state = "inactive"
      loadingSystem.loadingComplete()
      removeUserUpdateFunction("dareAcceptLoading")
    end
  end
end
