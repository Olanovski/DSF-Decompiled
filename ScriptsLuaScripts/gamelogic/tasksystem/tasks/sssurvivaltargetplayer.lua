taskSystem.registerTask("SS Survival Target Player", nil, function(task)
  local packageTO = task.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  local level = packageTO and packageTO.namedTasks.level and packageTO.namedTasks.level.networkVars.level or 1
  local behaviour = {
    traits = survivalAI.AITraits[level]
  }
  local function goalCallback(success, condition, eliminatedAll, playerID)
    behaviour.opponentGameVehicle = localPlayerManager.players[playerID].currentVehicle.gameVehicle
    task.agent:stopHighSpeedDriving()
    task.agent:highSpeedDrive(behaviour)
    task.agent.gameVehicle.performance = 1.25
  end
  return goalCallback
end)
