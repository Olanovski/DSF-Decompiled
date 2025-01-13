taskSystem.registerTask("SS Vehicle Counter", nil, function(task)
  task.lastSNVID = 0
  task.vehicles = 1
  local function goalCallback(success, condition, missionData, points)
    local currentSNVID = task.agent.currentVehicle.SNVID
    if task.lastSNVID > -1 then
      if task.lastSNVID ~= currentSNVID then
        task.lastSNVID = currentSNVID
        task.vehicles = task.vehicles + 1
      end
    else
      task.lastSNVID = currentSNVID
      task.vehicles = onlineScreenManager.ssFreeDriveStats[task.agent.localID].vehicles + 1
    end
  end
  return goalCallback, AIUpdate
end)
