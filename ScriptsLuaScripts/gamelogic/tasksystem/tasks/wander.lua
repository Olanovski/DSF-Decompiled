taskSystem.registerTask("Wander", {
  {
    name = "eliminatedTargets",
    startingValue = false,
    parseType = "boolean"
  }
}, function(task)
  local function createBehaviour()
    local behaviour = {
      traits = taskSystem.buildDriveTraits(task)
    }
    return behaviour
  end
  local function AIUpdate(nonGoalUpdate)
    task.agent:highSpeedDrive(createBehaviour())
  end
  local function goalCallback(success, condition, allTargetsEliminated)
    if allTargetsEliminated then
      task.networkVars.eliminatedTargets = true
    end
  end
  return goalCallback, AIUpdate
end)
