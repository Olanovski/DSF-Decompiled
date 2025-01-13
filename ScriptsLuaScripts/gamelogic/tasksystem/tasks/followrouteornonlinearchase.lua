taskSystem.registerTask("Follow Route or Non-linear Chase", {
  {
    name = "eliminatedTargets",
    startingValue = false,
    parseType = "boolean"
  }
}, function(task)
  local behaviour = {
    traits = taskSystem.buildChaseTraits(task)
  }
  local function createFollowBehaviour()
    local behaviour = {
      traits = taskSystem.buildDriveTraits(task),
      roadRoute = routes[task.actor.routeName].roads,
      routeName = task.actor.routeName
    }
    return behaviour
  end
  local function AIUpdate(nonGoalUpdate)
    task.agent:stopHighSpeedDriving()
    local closestDistance = math.huge
    local closestTarget
    for key, target in next, task.dynamicTargets, nil do
      if target.damage < 1 then
        local distance = task.agent.position - target.position:length()
        if closestDistance > distance and target.highSpeedDriving then
          closestDistance = distance
          closestTarget = target
          print(closestDistance)
          printTable(closestTarget)
        end
      end
    end
    if closestTarget and behaviour.opponentGameVehicle ~= closestTarget then
      behaviour.opponentGameVehicle = closestTarget.gameVehicle
      task.agent:highSpeedDrive(behaviour)
    else
      task.agent:highSpeedDrive(createFollowBehaviour())
    end
  end
  local function goalCallback(success, condition, allTargetsEliminated)
    if allTargetsEliminated then
      task.networkVars.eliminatedTargets = true
    end
  end
  return goalCallback, AIUpdate
end)
