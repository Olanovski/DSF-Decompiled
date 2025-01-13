challengeSystem.registerWarmup("E3InZap", nil, function(instance, settings)
  return function()
    local vehicle
    for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.warmup.style == "E3InZap" then
        if instance.challenge.name == "Exposition 07 Speed dare" then
          vehicle = instance.taskObjectsByActorID[actorID].coreData.agent
          VehicleLodSpooler.RequestVehicle(vehicle.model_id)
          localPlayer.missionSupport:setHooksFromVehicle(vehicle)
          if localPlayer.inZap then
            localPlayer:SetZapLevel(1)
          end
          break
        end
        vehicle = instance.taskObjectsByActorID[actorID].coreData.agent
        VehicleLodSpooler.RequestVehicle(vehicle.model_id)
        if localPlayer.inZap then
          localPlayer.missionSupport:setHooksFromVehicle(vehicle)
        end
        break
      end
    end
    return true
  end
end)
