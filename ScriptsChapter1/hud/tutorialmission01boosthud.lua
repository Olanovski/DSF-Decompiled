feedbackSystem.registerHUD("Tutorial mission 01 boost HUD", function(task, settings)
end, function(task, settings)
  local scoreBar = {
    slot = 2,
    title = "ID:231125",
    barTitle = "",
    value = 0
  }
  local score = 0
  local function update()
    if task.specialName ~= "boost end" or not task.complete then
    end
  end
  local function updateHUD()
    score = score + 1
    scoreBar.value = score * 0.8333333
    feedbackSystem.updateProgressBar(scoreBar)
    if score == 120 then
      removeUserUpdateFunction("updateHUD")
    end
  end
  local function goalComplete(goalCondition)
    if task.specialName == "wrecked 1" then
      if goalCondition == 1 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:183938", nil, false, true, false, localPlayer.buttonLayout.enterZap)
      elseif goalCondition == 2 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:231125", nil, false, true, false)
      end
    elseif task.specialName == "wrecked 2" then
      if goalCondition == 1 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:183938", nil, false, true, false, localPlayer.buttonLayout.enterZap)
      elseif goalCondition == 2 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:245144", nil, false, true, false, localPlayer.buttonLayout.boostAbility)
      end
    elseif task.specialName == "boost end" and not task.complete then
      if goalCondition == 1 then
        if not userUpdateFunctions.updateHUD then
          addUserUpdateFunction("updateHUD", updateHUD, 1)
        end
        feedbackSystem.updateTutorialPanel({tick1 = true})
      elseif goalCondition == 2 then
        score = 0
        scoreBar.value = score
        feedbackSystem.updateProgressBar(scoreBar)
        removeUserUpdateFunction("updateHUD")
        feedbackSystem.updateTutorialPanel({clearTick1 = true})
      end
    end
  end
  local function taskComplete()
    if task.specialName == "Zap prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:183938", nil, false, true, false, localPlayer.buttonLayout.enterZap)
    elseif task.specialName == "Boosted" then
      feedbackSystem.updateTutorialPanel({tick1 = true})
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    elseif task.specialName == "Boost prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:178506", nil, false, true, false, localPlayer.buttonLayout.boostAbility)
      feedbackSystem.updateTutorialPanel({string1 = "ID:245555"})
    elseif task.specialName == "cutscene 2 finished" then
      zapcontroller.AddLockedVehicle({
        gameVehicle = localPlayer.currentVehicle.gameVehicle
      })
      feedbackSystem.updateTutorialPanel({clearTick1 = true})
      localPlayer:blockAbility("nitro", true)
    elseif task.specialName == "WAIT" then
      feedbackSystem.updateTutorialPanel({
        string1 = "ID:245557",
        stringValue1 = 1,
        clearTick1 = true
      })
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245557", 1, false, true, false)
      localPlayer:blockAbility("nitro", false)
    elseif task.specialName == "boost end" then
      feedbackSystem.updateTutorialPanel({tick1 = true})
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      scoreBar.value = 100
      feedbackSystem.updateProgressBar(scoreBar)
    elseif task.specialName == "Trigger tutorial panel" then
      feedbackSystem.removeSlot(2)
      feedbackSystem.updateTutorialPanel({panelState = 3})
      feedbackSystem.menusMaster.primaryTextPrompt("ID:178502", nil, false, false, false)
    elseif task.specialName == "control config change1" or task.specialName == "control config change2" then
      local config = feedbackSystem.menusMaster.getControllerPreset(localPlayer.localID)
      local tutPanel = {
        string1 = "",
        textIcon1 = localPlayer.buttonLayout.boostAbility,
        string2 = "ID:234443"
      }
      tutPanel.string1 = "ID:178506"
      feedbackSystem.updateTutorialPanel(tutPanel)
    end
  end
  return update, goalComplete, taskComplete, nil
end)
