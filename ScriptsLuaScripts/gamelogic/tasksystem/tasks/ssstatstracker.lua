taskSystem.registerTask("SS Stats Tracker", nil, function(task)
  task.stat = 0
  local function goalCallback(success, condition, missionData, statInfo)
    if statInfo.ID == 1 then
      task.stat = task.stat + statInfo.points
    elseif statInfo.ID == 3 then
      task.stat = statInfo.points
    elseif statInfo.ID == 4 then
      task.stat = statInfo.points
    elseif statInfo.ID == 5 then
      task.stat = statInfo.points
    end
  end
  return goalCallback, AIUpdate
end)
