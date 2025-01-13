taskSystem.registerTask("MP Capture the flag player", nil, function(task)
  local instance = task.instance
  local packageTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local function goalCallback(success, condition, missionData, goalData)
    if condition == 1 then
      packageManager.sendFlagDropRequest(packageTaskObject.coreData.agent.SNOID)
    elseif condition == 2 then
      packageManager.sendFlagRequest(packageTaskObject.coreData.agent.SNOID, localPlayer.currentVehicle)
    end
  end
  return goalCallback
end)
