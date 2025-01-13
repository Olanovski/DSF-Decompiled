challengeSystem.registerShutDown("Separate", {time = 15}, function(instance, settings)
  return function()
    local allVehiclesFinished = true
    for actorID, vehicle in next, instance.vehicles, nil do
      if not vehicle.challengeInfo.completeTime then
        allVehiclesFinished = false
        break
      end
    end
    if allVehiclesFinished then
      return true
    end
    if g_NetworkTime - instance.networkVars.overTime >= settings.time then
      return true
    end
    return false
  end
end)
