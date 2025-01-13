taskSystem.registerTask("Almost no functionality", nil, function(task)
  local goalCallback = function(success, condition, missionData, points)
  end
  return goalCallback, AIUpdate
end)
