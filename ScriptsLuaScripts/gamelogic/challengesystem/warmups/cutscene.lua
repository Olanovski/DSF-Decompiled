challengeSystem.registerWarmup("Cutscene", nil, function(instance, settings)
  local cutsceneFinished = false
  local cutscene = cutscenes[settings.cutscene]
  local function cleanup()
    cutsceneFinished = true
  end
  if cutscene then
    local tab = {action = "callback", callback = cleanup}
    table.insert(cutscene, tab)
    CameraSystem.AddScene(cutscene)
  else
    cutsceneFinished = true
  end
  return function()
    if cutsceneFinished then
      if settings.forceMissionAccept then
        local vehicle
        for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
          if taskObject.coreData.actor.warmup.style == "Cutscene" then
            taskObject.coreData.actor.warmup.static = true
            vehicle = instance.taskObjectsByActorID[actorID].coreData.agent
            vehicleManager.applyInMissionVehicleSettings(vehicle, taskObject.coreData.actor)
            zapcontroller.RemoveChallengeVehicle({
              gameVehicle = vehicle.gameVehicle
            })
            VehicleLodSpooler.RequestVehicle(vehicle.model_id)
            if localPlayer.currentVehicle then
              if localPlayer.currentVehicle ~= vehicle then
                if localPlayer.inZap then
                  localPlayer:SetZapLevel(0, vehicle, true)
                elseif instance.challenge.name ~= "Exposition 03 zap at will" then
                  localPlayer:SetZapLevel(1)
                  localPlayer:SetZapLevel(0, vehicle, true)
                end
              end
            else
              localPlayer:SetZapLevel(0, vehicle, true)
            end
            localPlayer.missionSupport:setHooksFromVehicle(vehicle)
            break
          end
        end
      end
      return true
    end
  end
end)
