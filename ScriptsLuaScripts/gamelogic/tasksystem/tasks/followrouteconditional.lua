taskSystem.registerTask("Follow Route Conditional", {
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
  },
  {
    name = "shouldDrive",
    startingValue = false,
    parseType = "boolean"
  }
}, function(task)
  local startedDriving = false
  local function createBehaviour()
    local behaviour = {
      traits = taskSystem.buildDriveTraits(task),
      roadRoute = routes[task.actor.routeName].roads,
      routeName = task.actor.routeName
    }
    return behaviour
  end
  local function AIUpdate(nonGoalUpdate)
    if task.networkVars.shouldDrive then
      if not startedDriving then
        print("starting high speed drive >>>>>")
        task.agent:highSpeedDrive(createBehaviour())
        startedDriving = true
      end
    elseif startedDriving then
      print("STOPPING high speed drive  <<<<<")
      task.agent:stopHighSpeedDriving()
      startedDriving = false
    end
  end
  local function goalCallback(success, condition, completedLap)
    if success then
      task.networkVars.shouldDrive = true
    else
      task.networkVars.shouldDrive = false
    end
  end
  return goalCallback, AIUpdate
end)
