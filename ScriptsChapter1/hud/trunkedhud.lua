feedbackSystem.registerHUD("Trunked HUD", function(task, settings)
end, function(task, settings)
  local timer
  local timerStarted = false
  if settings.timerStart then
    timer = {
      slot = 1,
      startTime = settings.timerStart
    }
  end
  local function update()
    if task.goalFeedback.Timer and not timerStarted then
      feedbackSystem.stepTimer(timer)
      timerStarted = true
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "Wait for 1st Destination Prompt" then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        feedbackSystem.menusMaster.primaryTextPrompt("ID:245530", false, false, false, false)
      elseif task.specialName == "Audio - Wait for 5th Destination Prompt" then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        feedbackSystem.menusMaster.primaryTextPrompt("ID:245531", false, false, false, false)
      elseif string.find(task.specialName, "Reached") then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      elseif task.specialName == "Back from TrunkedActor" then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        feedbackSystem.menusMaster.primaryTextPrompt("ID:184659", false, false, false, false)
      elseif task.specialName == "Reached hospital" then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      end
    else
    end
  end
  local function cleanup()
    if task.specialName == "Reached 5th Destination" or task.specialName == "Reached 6th Destination" or task.specialName == "Find car" or task.specialName == "Chase car" then
      feedbackSystem.removeSlot(1)
    end
  end
  return update, nil, taskComplete, cleanup
end)
