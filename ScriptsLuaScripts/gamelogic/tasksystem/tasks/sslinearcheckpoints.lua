taskSystem.registerTask("SS Linear Checkpoints", {
  {
    name = "checkpoints",
    startingValue = 1,
    parseType = "integer8",
    dynamicTargetTrigger = true
  },
  {
    name = "laps",
    startingValue = 0,
    parseType = "integer8"
  }
}, function(task)
  local function createBehaviour()
    local behaviour = {
      traits = cleanTheStreetsAI.AITraits[task.instance.currentSSLevel],
      roadRoute = task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].roads[task.instance.currentSSLevel],
      routeName = task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].routeNames[task.instance.currentSSLevel]
    }
    return behaviour
  end
  local function AIUpdate(nonGoalUpdate)
    if task.instance.currentSSLevel ~= 11 then
      task.agent:highSpeedDrive(createBehaviour())
    end
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
