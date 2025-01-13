feedbackSystem.registerHUD("Exposition HUD", function(task, settings)
end, function(task, settings)
  local function goalComplete(conditionKey)
    if task.specialName == "idle prompt" or task.specialName == "Wrong way" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:170894", false, false, false, false)
    end
  end
  local function taskComplete()
    if task.specialName == "Objective Prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:170894", false, false, false, false)
    elseif task.specialName == "TannerTask" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:231398", false, false, false, false, localPlayer.buttonLayout.minimapZoom, nil, {
        button = "Zoom_Minimap",
        pressType = "JustPressed"
      })
      feedbackSystem.menusMaster.blockHintButton(false)
      feedbackSystem.menusMaster.setNextFocusString()
    elseif task.specialName == "Hint Prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245515", false, false, false, false, localPlayer.buttonLayout.focusButton, nil, {
        button = "Focus",
        pressType = "JustPressed"
      })
      feedbackSystem.menusMaster.blockHintButton(false)
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
