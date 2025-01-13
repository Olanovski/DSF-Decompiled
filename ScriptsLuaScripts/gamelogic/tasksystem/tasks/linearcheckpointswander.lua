taskSystem.registerTask("Linear Checkpoints AI Wander", {
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
  local behaviour = {
    traits = taskSystem.buildDriveTraits(task)
  }
  local function AIUpdate(nonGoalUpdate)
    task.agent:highSpeedDrive(behaviour)
  end
  local function goalCallback(success, condition, completedLap, goalData)
    if completedLap then
      task.networkVars.checkpoints = 1
      task.networkVars.laps = task.networkVars.laps + 1
    else
      if task.instance.challenge.name == "Exposition 04 return to dealer" and task.networkVars.checkpoints == 1 and task.specialName == "Checkpoint race" then
        RaceManager.EnableWrongWay(task.instance.raceId, true)
        RaceManager.EnableOffRoute(task.instance.raceId, true)
      end
      task.networkVars.checkpoints = task.networkVars.checkpoints + 1
    end
  end
  return goalCallback, AIUpdate
end)
