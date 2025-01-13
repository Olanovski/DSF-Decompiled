feedbackSystem.registerHUD("Exposition Zap HUD", function(task, settings)
end, function(task, settings)
  local zapPrompt = function()
    feedbackSystem.menusMaster.primaryTextPrompt("ID:245133", false, false, true, false, localPlayer.buttonLayout.enterZap)
    localPlayer:blockAbility("zap", false)
  end
  local allowedToDisplay = false
  local function goalComplete(conditionKey)
    if string.find(task.specialName, "PlayerZappedInto") and task.specialName ~= "PlayerZappedIntoATaxi" then
      if conditionKey == 1 then
        localPlayer:blockAbility("zap", true)
        if minimap.GetHighlightedVehicles() then
          minimap.RemoveAllHighlightedVehicleModelUIDs()
        end
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        feedbackSystem.menusMaster.clearSecondaryTextPrompt()
      elseif conditionKey == 3 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:183938", false, false, true, false, localPlayer.buttonLayout.enterZap)
      elseif conditionKey == 4 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:173939", false, false, true, false, localPlayer.buttonLayout.moveHighlight)
      end
    elseif task.specialName == "PlayerZappedIntoATaxi" then
      if conditionKey == 2 then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        feedbackSystem.menusMaster.primaryTextPrompt("ID:173936", false, false, true, false, localPlayer.buttonLayout.enterZap, false)
        feedbackSystem.menusMaster.secondaryTextPrompt("ID:173940", nil, nil, true, true)
        feedbackSystem.menusMaster.blockHintButton(false)
      elseif conditionKey == 4 then
        if allowedToDisplay then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:173936", false, false, true, false, localPlayer.buttonLayout.enterZap, false)
          feedbackSystem.menusMaster.secondaryTextPrompt("ID:173940", nil, nil, true, true)
        end
      elseif conditionKey == 5 then
        feedbackSystem.menusMaster.clearSecondaryTextPrompt()
        if not feedbackSystem.menusMaster.primaryPromptActive then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:245133", false, false, true, false, localPlayer.buttonLayout.enterZap)
        end
        if not allowedToDisplay then
          allowedToDisplay = true
        end
      end
    elseif task.specialName == "EnterZapPrompt04" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    end
  end
  local function taskComplete()
    if task.specialName == "Objective prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245512", false, false, false, false)
      feedbackSystem.menusMaster.blockHintButton(false)
    elseif task.specialName == "At the billboard" then
      feedbackSystem.menusMaster.setNextFocusString()
    elseif task.specialName == "EnterZapPrompt02" or task.specialName == "EnterZapPrompt03" then
      zapPrompt()
      if localPlayer.currentVehicle then
        localPlayer.currentVehicle.gameVehicle.maxAllowedDamage = 1
      end
    elseif task.specialName == "PlayerInZap02" or task.specialName == "PlayerInZap03" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    elseif task.specialName == "EnterZapPrompt04" then
      if localPlayer.currentVehicle then
        localPlayer.currentVehicle.gameVehicle.maxAllowedDamage = 1
      end
      feedbackSystem.menusMaster.setNextFocusString()
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245133", false, false, true, false, localPlayer.buttonLayout.enterZap)
      localPlayer:blockAbility("zap", false)
    elseif task.specialName == "PlayerZappedIntoATaxi" then
      feedbackSystem.menusMaster.blockHintButton(true)
      scoreSystem.tutorialMode(localPlayer.localID, false, false)
      if feedbackSystem.menusMaster.primaryPromptActive then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      end
      if feedbackSystem.menusMaster.secondaryPromptActive then
        feedbackSystem.menusMaster.clearSecondaryTextPrompt()
      end
      if minimap.GetHighlightedVehicles() then
        minimap.RemoveAllHighlightedVehicleModelUIDs()
      end
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
