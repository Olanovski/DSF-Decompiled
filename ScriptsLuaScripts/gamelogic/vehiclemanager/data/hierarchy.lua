module("vehicleManager")
function getBestOwnedModelID()
  local garageVehicle = ProfileSettings.GetGarageVehicle()
  if garageVehicle ~= -1 then
    return garageVehicle
  else
    local backupModelID = 179
    ProfileSettings.SetGarageVehicle(backupModelID)
    return backupModelID
  end
end
