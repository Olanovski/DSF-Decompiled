taskSystem.registerTask("No AI", {
  {
    name = "eliminatedTargets",
    startingValue = false,
    parseType = "boolean"
  }
}, function(task)
  local function goalCallback(success, condition, allTargetsEliminated)
    if allTargetsEliminated then
      task.networkVars.eliminatedTargets = true
    end
  end
  return goalCallback
end)
