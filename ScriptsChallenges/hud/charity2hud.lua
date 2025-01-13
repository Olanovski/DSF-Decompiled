feedbackSystem.registerHUD("Charity 2 hud", function(task, settings)
end, function(task, settings)
  local bar = {
    slot = 3,
    title = "ID:236008",
    barTitle = "ID:236570",
    value = 0,
    numerciValue = 0
  }
  local timer = {slot = 1}
  local countdownStarted = false
  feedbackSystem.updateProgressBar(bar)
  local function update()
    if not gameStatus.simulationPaused then
      if task.specialName == "Wait for countdown" then
        if not countdownStarted then
          feedbackSystem.menusMaster.singlePlayer321Countdown()
          countdownStarted = true
        end
      else
        if task.instance.challenge.goalValues["Time limit"] then
          timer.startTime = task.instance.challenge.goalValues["Time limit"]
          feedbackSystem.stepTimer(timer)
        else
          feedbackSystem.stepTimer(timer)
        end
        bar.numericValue = task.instance.collectedVehicles
        bar.value = task.instance.collectedVehicles / 4 * 100
        feedbackSystem.updateProgressBar(bar)
      end
    end
  end
  local goalComplete = function(conditionKey)
  end
  local taskComplete = function()
  end
  return update, nil, nil, nil
end)
