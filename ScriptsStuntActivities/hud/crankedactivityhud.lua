feedbackSystem.registerHUD("DriveToSurviveActivity hud", function(task, settings)
end, function(task, settings)
  local timer, heartTable, lastBPM, pointsParams
  local floor = math.floor
  local currentBPM
  local countdownStarted = false
  local showLowPrompt = true
  local showCriticalPrompt = true
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
  elseif task.specialName == "Get to end" then
    timer = {
      slot = 2,
      startTime = task.instance.challenge.goalValues["Time limit"] or 300
    }
  end
  local function update()
    if not gameStatus.simulationPaused then
      if task.specialName == "Wait for countdown" then
        if not countdownStarted then
          feedbackSystem.menusMaster.singlePlayer321Countdown()
          countdownStarted = true
        end
      elseif task.specialName == "Get to end" then
        feedbackSystem.stepTimer(timer)
      end
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "payload task" then
      currentBPM = floor(task.networkVars.payload)
      if currentBPM ~= lastBPM then
        heartTable.bpm = currentBPM
        heartTable.value = cardSystem.getHeartometerHUDValue(task)
        feedbackSystem.updateHeartMonitor(heartTable)
        lastBPM = currentBPM
      end
      if conditionKey <= #cardSystem.heartometerLogicTable then
        pointsParams.pointsText = cardSystem.heartometerLogicTable[conditionKey].feedback
        pointsParams.pointsValue = task.networkVars.pointsAwarded
        feedbackSystem.updatePointsFeedback(pointsParams)
      end
      if conditionKey == #cardSystem.heartometerLogicTable + 5 and showLowPrompt then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:245308", priority = 2})
        showLowPrompt = false
      elseif conditionKey == #cardSystem.heartometerLogicTable + 6 and showCriticalPrompt then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:245309", priority = 2})
        showCriticalPrompt = false
      elseif conditionKey == #cardSystem.heartometerLogicTable + 7 and not showLowPrompt and not showCriticalPrompt then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        showLowPrompt = true
        showCriticalPrompt = true
      end
    end
  end
  return update, goalComplete, nil, nil
end)
