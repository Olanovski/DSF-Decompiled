taskSystem.registerTask("Non-linear Checkpoints", {
  {
    name = "laps",
    startingValue = 0,
    parseType = "integer32"
  },
  {
    name = "checkpoints",
    startingValue = 1,
    parseType = "integer32",
    dynamicTargetTrigger = true
  },
  {
    name = "eliminatedTargets",
    startingValue = false,
    parseType = "boolean"
  }
}, function(task)
  local function setupRoute()
    local roadRoute
    if task.actor.routeName and routes[task.actor.routeName] then
      roadRoute = routes[task.actor.routeName].roads
    end
    return roadRoute
  end
  local function createBehaviour()
    local behaviour = {
      traits = taskSystem.buildDriveTraits(task),
      roadRoute = setupRoute(),
      routeName = task.actor.routeName
    }
    local closestDistance = math.huge
    local closestCheckpoint
    for key, target in next, task.dynamicTargets, nil do
      if target then
        local distance = task.agent.position - target.position:length()
        if closestDistance > distance then
          closestDistance = distance
          closestCheckpoint = target.position
        end
      end
      if closestCheckpoint and behaviour.destinationPosition ~= closestCheckpoint then
        behaviour.destinationPosition = closestCheckpoint
      end
    end
    return behaviour
  end
  local function AIUpdate(nonGoalUpdate)
    task.agent:highSpeedDrive(createBehaviour())
  end
  local function goalCallback(success, condition, completedLap, goalData)
    if completedLap then
      task.networkVars.checkpoints = 1
      task.networkVars.laps = task.networkVars.laps + 1
    else
      task.networkVars.checkpoints = task.networkVars.checkpoints + 1
    end
  end
  return goalCallback, AIUpdate
end)
