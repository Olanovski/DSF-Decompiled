Vehicles = {}
module("vehicleManager", package.seeall)
function pushVehicleDataToTable()
  for k, v in next, vehiclesAvailable, nil do
    Vehicles[k] = {
      Model = v.name
    }
    print("[" .. tostring(k) .. "] = " .. tostring(v.name) .. ",")
  end
end
function updateVehicleUnlocks(chapter, activitiesComplete, garageUnlocked)
  local unlocks = false
  if garageUnlocked then
    for modelID, vehicleData in next, vehicleStats, nil do
      if vehicleData.UnlockedInGarage == garageUnlocked and not ProfileSettings.GetVehicleUnlocked(modelID) then
        ProfileSettings.SetVehicleUnlocked(modelID)
        unlocks = unlocks or {}
        table.insert(unlocks, modelID)
      end
    end
  elseif activitiesComplete then
    for modelID, vehicleData in next, vehicleStats, nil do
      if vehicleData.UnlockByActivity == activitiesComplete and not ProfileSettings.GetVehicleUnlocked(modelID) then
        ProfileSettings.SetVehicleUnlocked(modelID)
        unlocks = unlocks or {}
        table.insert(unlocks, modelID)
      end
    end
  elseif chapter and (ProfileSettings.GetMissionAttempted(cards.ReverseMissionNetworkLookup["Tutorial garage"]) or chapter > 0) then
    for modelID, vehicleData in next, vehicleStats, nil do
      if vehicleData.UnlockedInChapter == chapter and not ProfileSettings.GetVehicleUnlocked(modelID) and modelID ~= 62 then
        ProfileSettings.SetVehicleUnlocked(modelID)
        unlocks = unlocks or {}
        table.insert(unlocks, modelID)
      end
    end
  end
  if unlocks then
    local unlockTitle = "ID:245771"
    if #unlocks == 1 then
      unlockTitle = vehicleStats[unlocks[1]].ModelName
    end
    feedbackSystem.menusMaster.queueUnlockPanel("gadget", "vehicle", "vehicle", unlocks, nil, nil, unlockTitle, "ID:245770")
  end
end
