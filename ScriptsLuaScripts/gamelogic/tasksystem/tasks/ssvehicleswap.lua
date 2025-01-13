taskSystem.registerTask("SS Vehicle swap", nil, function(task)
  local function goalCallback(success, condition, missionData, goalData)
    if task.agent.currentVehicle then
      if task.agent.currentVehicle.gameVehicle.model_id ~= task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].playerVehicles[task.instance.currentSSLevel] then
        zap.zapSwap.carSwapTriggered(task.agent, task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].playerVehicles[task.instance.currentSSLevel])
      else
        task.agent.currentVehicle:activateSiren()
      end
    end
  end
  return goalCallback
end)
