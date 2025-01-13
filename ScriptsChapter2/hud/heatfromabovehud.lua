feedbackSystem.registerHUD("Heat from above HUD", function(task, settings)
end, function(task, settings)
  local timer
  local updateTimer = false
  if settings.showTimer then
    timer = {
      slot = 1,
      startTime = nil,
      previousCheckpoint = nil
    }
    if settings.startTime then
      timer.startTime = settings.startTime
      updateTimer = true
    end
  end
  local function update()
    if task.goalFeedback.Timer and settings.showTimer then
      if settings.checkpointTimers and task.networkVars.checkpoints ~= timer.previousCheckpoint then
        timer.startTime = settings.checkpointTimers[task.networkVars.checkpoints]
        timer.previousCheckpoint = task.networkVars.checkpoints
        timer.reset = true
        timer.updateStartTime = true
        updateTimer = true
      end
      if updateTimer then
        feedbackSystem.stepTimer(timer)
        updateTimer = false
      end
    end
  end
  local cleanup = function()
    feedbackSystem.removeSlot(1)
  end
  return update, nil, nil, cleanup
end)
