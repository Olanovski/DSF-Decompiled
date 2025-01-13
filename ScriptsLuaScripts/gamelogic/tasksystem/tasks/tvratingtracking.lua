taskSystem.registerTask("TV Rating Tracking", {
  {
    name = "tvRating",
    startingValue = 22,
    parseType = "float"
  }
}, function(task)
  local function goalCallback(success, condition, missionData, points)
    points = points or 0.08
    if success then
      task.networkVars.tvRating = math.max(task.networkVars.tvRating + points, 0)
    elseif task.networkVars.tvRating > 0 then
      task.networkVars.tvRating = math.max(task.networkVars.tvRating - points, 0)
    end
  end
  return goalCallback, AIUpdate
end)
