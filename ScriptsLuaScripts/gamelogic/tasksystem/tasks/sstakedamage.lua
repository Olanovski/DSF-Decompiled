taskSystem.registerTask("SS Take Damage", nil, function(task)
  local function goalCallback(success, condition, completion, goalData)
    task.agent.gameVehicle.damage = task.agent.gameVehicle.damage + 1 / goalData
    task.agent.damage = task.agent.damage + 1 / goalData
  end
  return goalCallback
end)
