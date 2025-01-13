feedbackSystem.registerHUD("DriveToSurvive hud", function(task, settings)
end, function(task, settings)
  local heartTable, lastBPM, pointsParams, floor, currentBPM, showLowPrompt, showCriticalPrompt
  if task.specialName == "payload task" then
    heartTable = {
      slot = 1,
      bpm = task.networkVars.payload,
      value = cardSystem.getHeartometerHUDValue(task),
      flipFeedback = true
    }
    pointsParams = {pointsSlotPass = 1}
    lastBPM = task.networkVars.payload
    feedbackSystem.updateHeartMonitor(heartTable)
    showLowPrompt = true
    showCriticalPrompt = true
    floor = math.floor
  end
  local function promptsReady()
    showLowPrompt = true
    showCriticalPrompt = true
    removeUserUpdateFunction("promptsReady")
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Show first marker" then
      if conditionKey == 1 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:245511")
      end
    elseif task.specialName == "payload task" then
      currentBPM = floor(task.networkVars.payload)
      if currentBPM ~= lastBPM then
        heartTable.bpm = currentBPM
        heartTable.value = cardSystem.getHeartometerHUDValue(task)
        feedbackSystem.updateHeartMonitor(heartTable)
        lastBPM = currentBPM
      end
      if conditionKey == #cardSystem.heartometerLogicTable + 5 and showLowPrompt then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:245308", priority = 2})
        showLowPrompt = false
      elseif conditionKey == #cardSystem.heartometerLogicTable + 6 and showCriticalPrompt then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:245309", priority = 2})
        showCriticalPrompt = false
      elseif conditionKey == #cardSystem.heartometerLogicTable + 7 then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        addUserUpdateFunction("promptsReady", promptsReady, 1200, true)
      end
      if conditionKey <= #cardSystem.heartometerLogicTable then
        pointsParams.pointsText = cardSystem.heartometerLogicTable[conditionKey].feedback
        pointsParams.pointsValue = task.networkVars.pointsAwarded
        feedbackSystem.updatePointsFeedback(pointsParams)
      end
    end
  end
  local function taskComplete()
    if task.success and task.specialName == "Show first marker" then
      heartTable = {
        slot = 1,
        bpm = 80,
        value = 42.37226,
        flipFeedback = true
      }
      feedbackSystem.updateHeartMonitor(heartTable)
    end
  end
  return update, goalComplete, taskComplete, nil
end)
