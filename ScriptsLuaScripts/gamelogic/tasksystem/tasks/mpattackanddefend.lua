taskSystem.registerTask("MP Attack and Defend", {
  {
    name = "playerAttackBase",
    startingValue = 0,
    parseType = "integer8"
  },
  {
    name = "playerDefendBase",
    startingValue = 0,
    parseType = "integer8"
  }
}, function(task)
  local instance = task.instance
  local baseTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local withinDangerZone = false
  local function goalCallback(success, condition, missionData, goalData)
    if localPlayer.currentVehicle then
      GameVehicleResource.explode({
        gameVehicle = localPlayer.currentVehicle.gameVehicle,
        offset = vec.vector(0.25, -1, 0.25, 0),
        range = 5,
        strength = 5,
        disableVisual = true,
        disablePanelDetach = true
      })
    end
    if not success then
      localPlayer.MPScoreBlock = true
      baseTaskObject:sendMessage(1)
      localPlayer:SetZapLevel(4, nil, false, {forcedOut = true})
    elseif not localPlayer.inZap then
      localPlayer:SetZapLevel(3, nil, false, {forcedOut = true})
      baseTaskObject:sendMessage(2, tostring(goalData))
    end
  end
  return goalCallback
end)
