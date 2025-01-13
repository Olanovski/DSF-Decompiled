taskSystem.registerTask("MP Tag Objective Collision", nil, function(task)
  local goalCallback, AIUpdate, cleanup
  function goalCallback(success, condition, null, agent)
    local objTO = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    if objTO then
      packageManager.sendFlagRequest(objTO.coreData.agent.SNOID, task.agent.currentVehicle)
    end
  end
  return goalCallback, AIUpdate, cleanup
end)
