local transitionEndCallback = function(localID)
  if localPlayerManager.players[math.abs(localID - 1)].currentVehicle then
    zapcontroller.setZapActionTrackVehicle(true, localPlayerManager.players[math.abs(localID - 1)].currentVehicle.gameVehicle, localID, false)
  end
  zap.setZapTransitionCompleteCallback(false)
end
taskSystem.registerTask("SS Track Partner", nil, function(task)
  local function goalCallback(success, condition, completedLap, goalData)
    task.agent:zapToAction(localPlayerManager.players[math.abs(task.agent.localID - 1)].currentVehicle)
    zap.setZapTransitionCompleteCallback(transitionEndCallback)
  end
  return goalCallback
end)
