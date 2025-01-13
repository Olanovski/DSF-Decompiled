taskSystem.registerTask("Non-linear Chase", {
  {
    name = "eliminatedTargets",
    startingValue = false,
    parseType = "boolean"
  }
}, function(task)
  local behaviour = {
    traits = taskSystem.buildChaseTraits(task)
  }
  local function AIUpdate(nonGoalUpdate)
    local closestDistance = math.huge
    local closestTarget
    for key, target in next, task.dynamicTargets, nil do
      if target.damage < 1 then
        local distance = task.agent.position - target.position:length()
        if closestDistance > distance then
          closestDistance = distance
          closestTarget = target
        end
      end
    end
    if closestTarget and behaviour.opponentGameVehicle ~= closestTarget then
      behaviour.opponentGameVehicle = closestTarget.gameVehicle
      task.agent:highSpeedDrive(behaviour)
    end
  end
  local function goalCallback(success, condition, allTargetsEliminated)
    if allTargetsEliminated then
      task.networkVars.eliminatedTargets = true
    end
  end
  return goalCallback, AIUpdate
end)
