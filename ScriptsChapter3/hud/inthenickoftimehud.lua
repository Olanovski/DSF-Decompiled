feedbackSystem.registerHUD("In the nick of time hud", function(task, settings)
end, function(task, settings)
  local timer, health, previousHealth
  if settings.updateTimer then
    timer = {
      slot = 1,
      startTime = task.instance.challenge.goalValues["Time limit"]
    }
    feedbackSystem.stepTimer(timer)
  end
  if settings.updateHealth then
    health = {
      slot = 1,
      title = "ID:184067",
      value = -1
    }
  end
  local function update()
    if settings.updateHealth and localPlayer.primaryFelony and localPlayer.primaryFelony.getawayGameVehicle and previousHealth ~= localPlayer.primaryFelony.getawayGameVehicle.damage then
      health.value = localPlayer.primaryFelony.getawayGameVehicle.damage
      feedbackSystem.updateHealthBar(health)
      previousHealth = localPlayer.primaryFelony.getawayGameVehicle.damage
    end
  end
  local function taskComplete()
    if task.specialName == "Show Prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184842", nil, false, false, false)
      timer = {
        slot = 1,
        startTime = task.instance.challenge.goalValues["Time limit"]
      }
      feedbackSystem.stepTimer(timer)
    end
  end
  local function cleanup()
    if settings.updateHealth or settings.killTimerAtEnd then
      feedbackSystem.removeSlot(1)
    end
  end
  return update, nil, taskComplete, cleanup
end)
