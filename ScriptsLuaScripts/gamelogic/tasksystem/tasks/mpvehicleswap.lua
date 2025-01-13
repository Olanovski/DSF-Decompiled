taskSystem.registerTask("MP Vehicle swap", nil, function(task)
  local function goalCallback(success, condition, missionData, goalData)
    local cop = task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].cop
    if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle.model_id ~= cop then
      zap.zapSwap.carSwapTriggered(localPlayer, cop)
    end
  end
  return goalCallback
end)
