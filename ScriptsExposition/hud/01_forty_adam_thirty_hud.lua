feedbackSystem.registerHUD("Forty Adam Thirty HUD", function(task, settings)
end, function(task, settings)
  local acceleratePromptDisplayed = false
  local brakeReversePromptDisplayed = false
  local changeCameraPromptOnScreen = false
  local function goalComplete()
    if task.specialName == "Accelerate Prompt" then
      acceleratePromptDisplayed = true
      feedbackSystem.menusMaster.primaryTextPrompt("ID:170095", false, false, true, false, localPlayer.buttonLayout.accelerate)
    elseif task.specialName == "Break and Reverse Prompt" then
      brakeReversePromptDisplayed = true
      feedbackSystem.menusMaster.primaryTextPrompt("ID:170721", false, false, false, false, localPlayer.buttonLayout.vehicleBrake, nil)
    elseif task.specialName == "Camera change prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245401", false, false, false, false, localPlayer.buttonLayout.changeCamera, nil, {
        button = "Camera_Change",
        pressType = "JustPressed"
      })
    end
  end
  local function taskComplete()
    if task.specialName == "Objective prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:248762", false, false, false, false, iconsTable.target)
    elseif task.specialName == "Break and Reverse Prompt" then
      if brakeReversePromptDisplayed then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      end
    elseif task.specialName == "Accelerate Prompt" and acceleratePromptDisplayed then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
