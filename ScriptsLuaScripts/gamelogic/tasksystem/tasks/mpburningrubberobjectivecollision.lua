taskSystem.registerTask("MP Burning Rubber Objective Collision", nil, function(task)
  local goalCallback, AIUpdate, cleanup, packageTaskObject
  if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
    packageTaskObject = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  else
    packageTaskObject = task.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  end
  function goalCallback(success, condition, null, agent)
    if condition == 1 or condition == 3 then
      packageManager.sendFlagRequest(packageTaskObject.coreData.agent.SNOID, localPlayer.currentVehicle)
    elseif condition == 2 then
      packageManager.sendFlagDropRequest(packageTaskObject.coreData.agent.SNOID)
    end
  end
  return goalCallback, AIUpdate, cleanup
end)
