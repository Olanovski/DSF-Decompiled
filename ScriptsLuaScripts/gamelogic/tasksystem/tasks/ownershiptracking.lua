taskSystem.registerTask("Ownership tracking", {
  {
    name = "ownerID",
    startingValue = -1,
    parseType = "integer32"
  }
}, function(task)
  local function goalCallback(success, condition, missionData, goalData)
    goalData = goalData or -1
    task.networkVars.ownerID = goalData
  end
  return goalCallback, AIUpdate
end)
