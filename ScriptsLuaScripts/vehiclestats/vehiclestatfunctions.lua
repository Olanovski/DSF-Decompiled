function getVehicleStats(modelID)
  return vehicleStats[modelID]
end
function onlineGetVehicleLargeImage(vehicleID)
  local vehicleStats = getVehicleStats(vehicleID)
  assert(vehicleStats, "Vehicle " .. vehicleID .. " is invalid or missing")
  return vehicleStats.Picture2
end
_G.onlineGetVehicleLargeImage = onlineGetVehicleLargeImage
function onlineGetVehicleSmallImage(vehicleID)
  local vehicleStats = getVehicleStats(vehicleID)
  assert(vehicleStats, "Vehicle " .. vehicleID .. " is invalid or missing")
  return vehicleStats.Picture3
end
_G.onlineGetVehicleSmallImage = onlineGetVehicleSmallImage
vehicleStatsLookupTable = {}
for modelID, data in next, vehicleStats, nil do
  local unlockByActivity = data.UnlockByActivity
  if unlockByActivity then
    if not vehicleStatsLookupTable[unlockByActivity] then
      vehicleStatsLookupTable[unlockByActivity] = {}
      vehicleStatsLookupTable[unlockByActivity].manufacturerName = data.ManufacturerName
      vehicleStatsLookupTable[unlockByActivity].modelName = data.ModelName
    else
      print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
      print("ERROR: MORE THAN 1 VEHICLE IS UNLOCKED BY ACTIVITY " .. unlockByActivity .. " THE SYSTEM CANNOT COPE WITH THIS")
      print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    end
  end
end
