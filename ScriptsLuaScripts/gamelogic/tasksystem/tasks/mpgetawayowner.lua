taskSystem.registerTask("MP getaway owner", {
  {
    name = "ownerID",
    startingValue = -1,
    parseType = "integer32"
  }
}, function(task)
  local function goalCallback(success)
    if success then
      task.networkVars.ownerID = phaseManager.networkVars.nextTurnTaker
    else
      task.networkVars.ownerID = -2
    end
  end
  return goalCallback
end)
