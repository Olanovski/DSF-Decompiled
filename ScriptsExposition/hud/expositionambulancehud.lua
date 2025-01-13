feedbackSystem.registerHUD("Exposition Ambulance HUD", function(task, settings)
end, function(task, settings)
  local score = 80
  local heartTable = {
    slot = 1,
    value = 80,
    flipFeedback = true
  }
  local function update()
    if not gameStatus.simulationPaused and task.specialName == "payload" and not task.complete then
      score = task.networkVars.payload
      heartTable.value = score
      heartTable.bpm = score
      feedbackSystem.updateHeartMonitor(heartTable)
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Wrong way" or task.specialName == "idle" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245511", false, false, false, false)
    elseif task.specialName == "payload" then
      if conditionKey == 5 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:245308", false, false, false, false)
      elseif conditionKey == 6 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:245309", false, false, false, false)
      end
    end
  end
  local function taskComplete()
    if task.specialName == "Objective prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245511", false, false, false, false)
      feedbackSystem.menusMaster.blockHintButton(false)
    elseif task.specialName == "PlayerInTanner" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:242288", false, false, false, false)
    elseif task.specialName == "PlayerAtTheHosptial" or task.specialName == "payload" then
      feedbackSystem.removeSlot(1)
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.clearSecondaryTextPrompt()
    end
  end
  return update, goalComplete, taskComplete
end)
