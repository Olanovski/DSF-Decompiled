local losingPromptActive = false
feedbackSystem.registerHUD("Tutorial mission Rapid shift HUD", nil, function(task, settings)
  local rapidShiftTable = {
    slot = 2,
    barTitle = "ID:245954",
    value = 0
  }
  if task.specialName == "rapid shifting 1" or task.specialName == "rapid shift prompt 2" then
    rapidShiftTable.value = 33
  elseif task.specialName == "rapid shifting 2" or task.specialName == "rapid shift prompt 3" then
    rapidShiftTable.value = 67
  elseif task.specialName == "rapid shifting 3" then
    rapidShiftTable.value = 100
  end
  local zapOverride = function()
  end
  if string.find(task.specialName, "rapid shifting") then
    localPlayer.blockRapidShiftPress = false
  elseif string.find(task.specialName, "rapid shift prompt") then
    localPlayer.blockRapidShiftPress = true
  end
  local function goalComplete(conditionKey)
    if task.specialName == "In shift" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.clearSecondaryTextPrompt()
      feedbackSystem.updateTutorialPanel({tick1 = true})
      zap.SetZapInOverride(zapOverride)
    elseif task.specialName == "kill evader" then
      if conditionKey == 2 and not losingPromptActive and not feedbackSystem.menusMaster.primaryPromptActive then
        losingPromptActive = true
        feedbackSystem.menusMaster.primaryTextPrompt("ID:245232", nil, false, true, true)
      elseif conditionKey == 1 and losingPromptActive then
        losingPromptActive = false
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      end
    end
  end
  local function taskComplete()
    if task.specialName == "Prompt enter shift" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:183939", nil, false, true, true, localPlayer.buttonLayout.enterZap)
    elseif task.specialName == "In shift" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:234447", nil, false, true, nil, localPlayer.buttonLayout.zapReturn)
    elseif task.specialName == "In vehicle after first zap return" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    elseif task.specialName == "First zap return" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.updateTutorialPanel({tick2 = true})
      zap.SetZapInOverride(nil)
    elseif task.specialName == "End of part 1" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    elseif string.find(task.specialName, "rapid shift prompt") then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:234447", nil, false, true, nil, localPlayer.buttonLayout.zapReturn)
      feedbackSystem.updateDangerBar(rapidShiftTable)
      if task.actor.ID == "Tutorial cop" then
        localPlayer:overrideZapReturn(task.instance.taskObjectsByActorID["Tutorial cop 2"].coreData.agent)
      else
        localPlayer:overrideZapReturn(task.instance.taskObjectsByActorID["Tutorial cop"].coreData.agent)
      end
    elseif string.find(task.specialName, "rapid shifting") then
      feedbackSystem.updateDangerBar(rapidShiftTable)
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      if task.specialName == "rapid shifting 3" then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:178502")
      end
      localPlayer:clearZapReturnOverride()
    elseif task.specialName == "kill evader prompt" then
      if task.condition == 1 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:231353")
      end
      localPlayer:clearZapReturnOverride()
    elseif task.specialName == "Part 3 - Before well done" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
