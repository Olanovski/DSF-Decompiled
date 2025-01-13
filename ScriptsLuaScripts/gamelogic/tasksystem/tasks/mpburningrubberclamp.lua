taskSystem.registerTask("MP Burning Rubber Clamp", nil, function(task)
  local packageTaskObject
  if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
    packageTaskObject = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  else
    packageTaskObject = task.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  end
  local function goalCallback(success, condition)
    localPlayer.currentVehicle:setEngineTweak(task.coreData.speedRestriction)
    localPlayer.currentVehicle.gameVehicle.damage = 1.1
    localPlayer.currentVehicle.damage = 1.1
    packageManager.sendFlagDropRequest(packageTaskObject.coreData.agent.SNOID)
  end
  return goalCallback
end)
