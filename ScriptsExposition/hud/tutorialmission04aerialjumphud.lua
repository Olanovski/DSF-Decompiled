feedbackSystem.registerHUD("Tutorial mission 04 aerial jump HUD", function(task, settings)
end, function(task, settings)
  local function goalComplete(goalCondition)
    if string.find(task.specialName, "At level 2") or string.find(task.specialName, "At level 1") then
      zapcontroller.setZapCameraLocks(0, {
        missile = true,
        low = true,
        mid = true,
        high = true,
        top = true
      })
    end
  end
  local function taskComplete()
    if task.specialName == "Zap prompt" then
      feedbackSystem.updateTutorialPanel({panelState = 1})
      feedbackSystem.updateTutorialPanel({panelState = 2})
      feedbackSystem.menusMaster.primaryTextPrompt("ID:234456", nil, false, true, false, localPlayer.buttonLayout.zapUp)
      zapcontroller.setZapCameraLocks(0, {
        missile = true,
        low = true,
        mid = false,
        high = true,
        top = true
      })
    elseif task.specialName == "At level 2" then
      feedbackSystem.updateTutorialPanel({tick1 = true})
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      zapcontroller.setZapCameraLocks(0, {
        missile = true,
        low = true,
        mid = true,
        high = true,
        top = true
      })
    elseif task.specialName == "Well Done" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:234457", nil, false, true, false, localPlayer.buttonLayout.zapDown)
      zapcontroller.setZapCameraLocks(0, {
        missile = false,
        low = true,
        mid = true,
        high = true,
        top = true
      })
    elseif task.specialName == "At level 1" then
      feedbackSystem.updateTutorialPanel({tick2 = true})
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      zapcontroller.setZapCameraLocks(0, {
        missile = true,
        low = true,
        mid = true,
        high = true,
        top = true
      })
    elseif task.specialName == "Complete prompt" then
      feedbackSystem.updateTutorialPanel({panelState = 3})
      feedbackSystem.menusMaster.primaryTextPrompt("ID:178502", nil, false, false, false)
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
