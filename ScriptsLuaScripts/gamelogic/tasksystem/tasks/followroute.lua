taskSystem.registerTask("Follow Route", {
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
    local behaviour = {
      traits = taskSystem.buildDriveTraits(task),
      roadRoute = routes[task.actor.routeName].roads,
      routeName = task.actor.routeName
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
