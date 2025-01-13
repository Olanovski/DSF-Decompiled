feedbackSystem.registerHUD("Tutorial mission 02 ram HUD", function(task, settings)
end, function(task, settings)
  local ramTable = {
    slot = 3,
    barTitle = "ID:245954",
    value = 0
  }
  if task.specialName == "Player has rammed part 2" then
    ramTable.value = task.networkVars.payload
    feedbackSystem.updateDangerBar(ramTable)
  elseif task.specialName == "Player has rammed part 1" then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:183931", nil, false, true, false)
  end
  local function goalComplete(goalCondition)
    if string.find(task.specialName, "button") then
      if goalCondition == 1 then
        feedbackSystem.updateTutorialPanel({tick1 = true})
      elseif goalCondition == 2 then
        feedbackSystem.updateTutorialPanel({clearTick1 = true, clearTick2 = true})
      end
    elseif string.find(task.specialName, "in shift") then
      if goalCondition == 1 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:183938", nil, false, true, false, localPlayer.buttonLayout.enterZap)
      elseif goalCondition == 2 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:183931", nil, false, true, false)
      end
    elseif string.find(task.specialName, "control config chang") then
      local config = feedbackSystem.menusMaster.getControllerPreset(localPlayer.localID)
      local tutPanel = {
        string1 = "",
        textIcon1 = localPlayer.buttonLayout.ramAbility,
        string2 = "ID:234454",
        textIcon2 = localPlayer.buttonLayout.ramAbility
      }
      tutPanel.string1 = "ID:234453"
      feedbackSystem.updateTutorialPanel(tutPanel)
    elseif task.specialName == "Player has rammed part 2" then
      if goalCondition == 1 then
        feedbackSystem.updateTutorialPanel({tick2 = true})
        ramTable.value = task.networkVars.payload * 33
        feedbackSystem.updateDangerBar(ramTable)
        if not feedbackSystem.menusMaster.primaryPromptActive then
          feedbackSystem.updatePointsFeedback({pointsText = "+1", pointsSlotPass = 3})
        end
      else
        feedbackSystem.menusMaster.primaryTextPrompt("ID:183931", nil, false, false, false)
      end
    end
  end
  local function taskComplete()
    if task.specialName == "Start tutorial" then
      feedbackSystem.updateTutorialPanel({highlight1 = true})
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245147", nil, false, true, false)
      scoreSystem.increaseAbility(localPlayer, 1200)
      scoreSystem.showAbilityFeedback(localPlayer.localID, true)
    elseif string.find(task.specialName, "rammed") then
      feedbackSystem.updateTutorialPanel({tick2 = true})
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    elseif task.specialName == "cutscene finished AGAIN" then
      feedbackSystem.updateTutorialPanel({clearTick1 = true, clearTick2 = true})
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245610", nil, false, false, false)
      scoreSystem.increaseAbility(localPlayer, 1200)
    elseif task.specialName == "Player has rammed part 2" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    elseif task.specialName == "Trigger tutorial panel" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:178502", nil, false, false, false)
      feedbackSystem.removeSlot(ramTable.slot)
      feedbackSystem.updateTutorialPanel({panelState = 3})
    elseif task.specialName == "cutscene finished AGAIN AGAIN" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    elseif task.specialName == "Zap prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:183938", false, false, true, false, localPlayer.buttonLayout.enterZap)
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
