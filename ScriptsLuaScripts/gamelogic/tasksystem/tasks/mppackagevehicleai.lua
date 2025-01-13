taskSystem.registerTask("MP Package Vehicle AI", nil, function(task)
  local function createBehaviour()
    local behaviour = {
      traits = taskSystem.buildDriveTraits(task)
    }
    return behaviour
  end
  local function AIUpdate(nonGoalUpdate)
    task.agent.owner:highSpeedDrive(createBehaviour())
  end
  return nil, AIUpdate
end)
