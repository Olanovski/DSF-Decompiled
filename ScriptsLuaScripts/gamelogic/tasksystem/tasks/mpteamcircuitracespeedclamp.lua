taskSystem.registerTask("MP Team Circuit Race Speed Clamp", nil, function(task)
  local taskObject = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local function goalCallback(success, condition, missionData)
    if taskObject.namedTasks.gateTracking.networkVars.leadPlayerID == localPlayer.playerID then
      if localPlayer.currentVehicle then
        localPlayer.currentVehicle:setEngineTweak(task.instance.challenge.settings.speedClamp)
      end
    elseif localPlayer.currentVehicle then
      localPlayer.currentVehicle:setEngineTweak(1)
    end
  end
  return goalCallback
end)
