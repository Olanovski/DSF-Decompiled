taskSystem.registerTask("Static awaiting target", {
  {
    name = "eliminatedTargets",
    startingValue = false,
    parseType = "boolean"
  }
}, function(task)
  local function goalCallback(success, condition, eliminatedAll, goalData)
    if eliminatedAll then
      task.networkVars.eliminatedTargets = true
    end
  end
  return goalCallback, nil
end)
