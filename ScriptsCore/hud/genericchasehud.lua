feedbackSystem.registerHUD("Generic chase hud", function(task, settings)
  local health = {
    slot = 1,
    value = 100,
    title = "COP"
  }
  health.value = task.agent.damage
  feedbackSystem.updateHealthBar(health)
end, function(task, settings)
  local health = {
    slot = 1,
    value = 100,
    title = "COP"
  }
  local prevHealth = -1
  local initialTargets = 0
  if task.specialName == "Chaser logic" and task.dynamicTargets then
    for target, opponentVehicle in next, task.dynamicTargets, nil do
      if opponentVehicle then
        initialTargets = initialTargets + 1
      end
    end
  end
  local function update()
    if task.specialName == "Chaser logic" and prevHealth ~= task.agent.damage then
      health.value = task.agent.damage
      feedbackSystem.updateHealthBar(health)
      prevHealth = task.agent.damage
    end
  end
  local function goalComplete()
    if task.specialName == "Chaser logic" and task.dynamicTargets then
      local opponentVehiclesRemainingCount = 0
      for target, opponentVehicle in next, task.dynamicTargets, nil do
        if opponentVehicle then
          opponentVehiclesRemainingCount = opponentVehiclesRemainingCount + 1
        end
      end
    end
  end
  local taskComplete = function()
  end
  return update, goalComplete, taskComplete
end)
