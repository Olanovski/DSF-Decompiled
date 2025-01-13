taskSystem.registerTask("MP Circuit Race Checkpoints", {
  {
    name = "nextCheckpoint",
    startingValue = 1,
    parseType = "uinteger8",
    dynamicTargetTrigger = true
  },
  {
    name = "checkpointsPassed",
    startingValue = 0,
    parseType = "uinteger8"
  }
}, function(task)
  local localSSPlayer = localPlayerManager.players[task.agent.localID]
  local packageTO = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local numCheckPoints = #task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].route
  local function goalCallback(success, condition, data, goalData)
    if success then
      task.networkVars.checkpointsPassed = task.networkVars.checkpointsPassed + 1
      if not gameStatus.splitscreenSession and gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
        local previousGates = ProfileSettings.GetNumGatesCrossed()
        local newGates = previousGates + 1
        ProfileSettings.SetNumGatesCrossed(newGates)
        OnlineAchievements.onValueChange("Rush 1000 gates", newGates)
      end
      if data.cpRemove and #data.cpRemove > 0 then
        for i, targetID in ipairs(data.cpRemove) do
          checkpointSystem.resetOnlineCheckpoint(task.dynamicTargets[targetID].checkpointNum)
        end
        taskSystem.updateTaskDynamicTargets(task, data.cpRemove, false)
      end
      if packageTO then
        packageTO:sendMessage(1, task.networkVars.nextCheckpoint, localSSPlayer)
      end
    end
  end
  return goalCallback, nil, nil
end)
