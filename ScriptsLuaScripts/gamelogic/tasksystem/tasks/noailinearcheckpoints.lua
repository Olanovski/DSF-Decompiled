taskSystem.registerTask("No AI Linear Checkpoints", {
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
  local goalCallback, AIUpdate, cleanup
  local function goalCallback(success, condition, completedLap, goalData)
    if completedLap then
      task.networkVars.checkpoints = 1
      task.networkVars.laps = task.networkVars.laps + 1
    else
      task.networkVars.checkpoints = task.networkVars.checkpoints + 1
    end
  end
  return goalCallback, nil, cleanup
end)
