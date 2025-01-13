feedbackSystem.registerHUD("Test drive", function(task, settings)
end, function(task, settings)
  local timer, countdownStartTimer
  if task.specialName == "Wait to be controlled" then
    feedbackSystem.removeSlot(1)
    countdownStartTimer = false
  elseif task.specialName == "Race" then
    timer = {
      slot = 1,
      startTime = task.instance.challenge.goalValues["Time limit"]
    }
    feedbackSystem.menusMaster.clearMinimapTextPrompt()
    feedbackSystem.stepTimer(timer)
  elseif task.specialName == "Initial drive" then
    feedbackSystem.menusMaster.primaryTextPromptParam({
      prompt = "ID:245547",
      delay = true,
      priority = 1
    })
  end
  local function update()
    if task.specialName == "Race countdown" and not countdownStartTimer then
      feedbackSystem.menusMaster.singlePlayer321Countdown()
      countdownStartTimer = true
    end
  end
  local function taskComplete()
    if task.specialName == "Race" then
      feedbackSystem.removeSlot(1)
    end
  end
  return update, nil, taskComplete, nil
end)
