taskSystem.registerTask("MP Torch Fuel", {
  {
    name = "syncedTime",
    startingValue = 0,
    parseType = "float"
  }
}, function(task)
  local function goalCallback(success, condition)
    task.networkVars.syncedTime = g_NetworkTime
  end
  return goalCallback
end)
