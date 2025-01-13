taskSystem.registerTask("Follow Route From Route Index", {
  {
    name = "checkpoints",
    startingValue = 1,
    parseType = "integer32",
    dynamicTargetTrigger = true
  },
  {
    name = "laps",
    startingValue = 0,
    parseType = "integer32"
  }
}, function(task)
  local function createBehaviour()
    local routeIndex = task.instance.networkVars.routeIndex
    local behaviour = {
      traits = taskSystem.buildDriveTraits(task),
      roadRoute = routes[task.instance.challenge.spawnPositions[routeIndex].modeRouteName].roads,
      routeName = task.instance.challenge.spawnPositions[routeIndex].modeRouteName
    }
    return behaviour
  end
  local function AIUpdate(nonGoalUpdate)
    task.agent:highSpeedDrive(createBehaviour())
  end
  local function goalCallback(success, condition, completedLap)
    if completedLap then
      task.networkVars.laps = task.networkVars.laps + 1
    end
  end
  return goalCallback, AIUpdate
end)
