feedbackSystem.registerHUD("Felony chase activity hud", function(task, settings)
end, function(task, settings)
  local getawayHealthBar = {
    slot = 1,
    title = "ID:184067",
    value = 0
  }
  local timer = {}
  if task.instance.challenge.goalValues["Time limit"] then
    timer = {
      slot = 2,
      startTime = task.instance.challenge.goalValues["Time limit"]
    }
  end
  local countdownStarted = false
  local function update()
    if not gameStatus.simulationPaused then
      if task.specialName == "Wait for countdown" then
        if task.instance.challenge.goalValues["Start countdown"] and not countdownStarted then
          feedbackSystem.menusMaster.singlePlayer321Countdown()
          countdownStarted = true
        end
      elseif not localPlayer.inCutscene then
        if task.instance.challenge.goalValues["Time limit"] then
          timer.startTime = task.instance.challenge.goalValues["Time limit"]
          feedbackSystem.stepTimer(timer)
        end
        if localPlayer.primaryFelony.getawayGameVehicle then
          getawayHealthBar.value = localPlayer.primaryFelony.getawayGameVehicle.damage
          feedbackSystem.updateHealthBar(getawayHealthBar)
        end
      end
    end
  end
  local goalComplete = function()
  end
  local taskComplete = function()
  end
  local cleanup = function()
  end
  return update, nil, nil, nil
end)
