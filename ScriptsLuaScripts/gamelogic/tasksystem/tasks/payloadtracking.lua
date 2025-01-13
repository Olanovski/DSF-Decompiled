taskSystem.registerTask("Payload Tracking", {
  {
    name = "payload",
    startingValue = 0,
    parseType = "integer32"
  }
}, function(task)
  if task.agent.remainingWater then
    task.networkVars.payload = task.agent.remainingWater
  end
  local function goalCallback(success, condition, missionData, points)
    points = points or 1
    if success then
      if task.coreData and task.coreData.upper then
        task.networkVars.payload = math.min(task.networkVars.payload + points, task.coreData.upper)
      else
        task.networkVars.payload = task.networkVars.payload + points
      end
    elseif task.coreData and task.coreData.lower then
      task.networkVars.payload = math.max(task.networkVars.payload - points, task.coreData.lower)
    else
      task.networkVars.payload = task.networkVars.payload - points
    end
  end
  return goalCallback, AIUpdate
end)
