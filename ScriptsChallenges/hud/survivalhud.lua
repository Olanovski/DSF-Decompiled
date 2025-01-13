feedbackSystem.registerHUD("Survival hud", function(task, settings)
end, function(task, settings)
  local timer = {slot = 1}
  local countdownStarted = false
  local function update()
    if not gameStatus.simulationPaused then
      if task.specialName == "Wait for countdown" then
        if not countdownStarted then
          feedbackSystem.menusMaster.singlePlayer321Countdown()
          countdownStarted = true
        end
      elseif task.instance.challenge.goalValues["Time limit"] then
        timer.startTime = task.instance.challenge.goalValues["Time limit"]
        feedbackSystem.stepTimer(timer)
      else
        feedbackSystem.stepTimer(timer)
      end
    end
  end
  local goalComplete = function(conditionKey)
  end
  return update, nil, nil, nil
end)
