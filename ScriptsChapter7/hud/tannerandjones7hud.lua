feedbackSystem.registerHUD("Tanner and Jones 7 HUD", nil, function(task, settings)
  local leilaPreviousHealth
  local leilaHealth = {
    slot = 1,
    value = 100,
    title = "ID:184100"
  }
  local timer = {slot = 1}
  if settings.updateTimer and settings.timerLength then
    timer.startTime = settings.timerLength
  end
  if settings.updateHealth then
    leilaHealth.value = task.agent.damage
    feedbackSystem.updateHealthBar(leilaHealth)
  end
  local function update()
    if task.specialName == "chase Leila" and localPlayer.primaryFelony and localPlayer.primaryFelony.getawayGameVehicle and leilaHealth.value ~= localPlayer.primaryFelony.getawayGameVehicle.damage then
      leilaHealth.value = localPlayer.primaryFelony.getawayGameVehicle.damage
      feedbackSystem.updateHealthBar(leilaHealth)
    end
    if settings.updateTimer then
      feedbackSystem.stepTimer(timer)
    end
  end
  local function cleanup()
    if settings.updateTimer or settings.updateHealth then
      feedbackSystem.removeSlot(1)
    end
  end
  local function taskComplete()
    if task.specialName == "destination prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245554")
    elseif task.specialName == "destination prompt 2" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:246414")
    end
  end
  return update, nil, taskComplete, cleanup
end)
