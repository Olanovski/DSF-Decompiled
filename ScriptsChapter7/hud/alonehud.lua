feedbackSystem.registerHUD("Alone HUD", function(task, settings)
end, function(task, settings)
  local dontShowPrompt
  if task.specialName == "drive under bridge" then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:245553", nil, true)
  end
  local function goalComplete(conditionKey)
    if task.specialName == "puzzle audio1" then
      if conditionKey == 3 or conditionKey == 4 then
        dontShowPrompt = true
      elseif (conditionKey == 5 or conditionKey == 6) and not dontShowPrompt then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:243091", nil, false, false, false)
      end
    end
  end
  local function taskComplete()
    if task.specialName == "drive to doorway" then
      feedbackSystem.removeSlot(1)
    end
  end
  local function cleanup()
    if task.majorOrder == 3 or task.condition == 2 then
      feedbackSystem.removeSlot(1)
    end
  end
  return nil, goalComplete, taskComplete, cleanup
end)
