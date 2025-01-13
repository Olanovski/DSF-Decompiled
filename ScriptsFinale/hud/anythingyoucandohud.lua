feedbackSystem.registerHUD("Anything you can do HUD", nil, function(task, settings)
  local jerichoTable = {
    slot = 1,
    title = "ID:214487",
    value = task.agent.damage
  }
  if task.specialName == "Chase" then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:184960", nil, false, false, false)
    jerichoTable.value = task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.damage
    feedbackSystem.updateHealthBar(jerichoTable)
  end
  local function update()
    if task.specialName == "Chase" and task.instance.taskObjectsByActorID["Jericho Actor"] and not localPlayer.inCutscene and not task.complete and task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.damage ~= 0 then
      jerichoTable.value = task.instance.taskObjectsByActorID["Jericho Actor"].coreData.agent.damage
      feedbackSystem.updateHealthBar(jerichoTable)
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Jericho health" and conditionKey == 4 then
      moodSystem.applyMood("Jericho lite", 2)
    end
  end
  local function taskComplete()
    if task.specialName == "Initial zap" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.clearSecondaryTextPrompt()
      feedbackSystem.menusMaster.primaryTextPrompt("ID:214872", false, false, false, false, localPlayer.buttonLayout.enterZap)
    elseif task.specialName == "Chase" then
      feedbackSystem.removeSlot(1)
      moodSystem.applyMood("Coma", 2)
    end
  end
  return update, goalComplete, taskComplete, nil
end)
