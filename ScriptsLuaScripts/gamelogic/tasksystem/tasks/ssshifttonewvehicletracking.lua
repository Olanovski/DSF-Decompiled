taskSystem.registerTask("SS Shift To New Vehicle Tracking", nil, function(task)
  local function goalCallback(success, condition, completedLap, goalData)
    task.agent.zapToNewVehicle = false
  end
  return goalCallback
end)
