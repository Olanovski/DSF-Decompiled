taskSystem.registerTask("MP package owner tracking", nil, function(task)
  local function goalCallback(success, condition, loop, returnData)
    if condition == 3 then
      task.agent:packageDropped(task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].target)
    else
      local dropPosition, dropTime = GameVehicleResource.getSnappedPredictedPosition(task.agent.owner.gameVehicle, 0.3)
      task.agent:packageDropped(dropPosition)
    end
  end
  return goalCallback
end)
