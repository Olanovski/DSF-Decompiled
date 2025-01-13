taskSystem.registerTask("MP race end timer", {
  {
    name = "raceEndTimer",
    startingValue = 0,
    parseType = "float"
  }
}, function(task)
  local function goalCallback(success, condition, missionData, goalData)
    if task.networkVars.raceEndTimer == 0 then
      task.networkVars.raceEndTimer = g_NetworkTime
    end
    onlineRaceManager.sendMessage(2, task.networkVars.raceEndTimer)
  end
  return goalCallback
end)
