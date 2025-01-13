feedbackSystem.registerHUD("Deactivating bombs 2 hud", function(task, settings)
end, function(task, settings)
  local bar = {
    slot = 3,
    title = "ID:236569",
    barTitle = "ID:231369",
    value = 0,
    numericValue = 0
  }
  local timer = {slot = 1}
  local trucksCompleted = 0
  local countdownStarted = false
  if task.specialName == "payload task" then
    bar.numericValue = trucksCompleted
    bar.value = trucksCompleted
    feedbackSystem.updateProgressBar(bar)
  end
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
  local function goalComplete(conditionKey)
    if task.specialName == "payload task" then
      OneShotSound.Play("HUD_Mis_PointsAdd_OneShot")
      trucksCompleted = trucksCompleted + 1
      bar.numericValue = trucksCompleted
      bar.value = trucksCompleted / task.instance.challenge.goalValues["Amount of trucks to drive under"] * 100
      feedbackSystem.updateProgressBar(bar)
    end
  end
  local taskComplete = function()
  end
  return update, goalComplete, nil, nil
end)
