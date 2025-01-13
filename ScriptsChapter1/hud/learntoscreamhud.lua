feedbackSystem.registerHUD("Learn to scream hud", function(task, settings)
end, function(task, settings)
  local heartTable, lastBPM, pointsParams, previousHealth
  local floor = math.floor
  local currentBPM
  if task.specialName == "Display prompts and heartometer" then
    heartTable = {
      slot = 1,
      bpm = 80,
      value = 16.5
    }
    feedbackSystem.updateHeartMonitor(heartTable)
  elseif task.specialName == "payload task" then
    heartTable = {
      slot = 1,
      bpm = task.networkVars.payload,
      value = cardSystem.getHeartometerHUDValue(task)
    }
    pointsParams = {pointsSlotPass = 1}
    lastBPM = task.networkVars.payload
    feedbackSystem.updateHeartMonitor(heartTable)
  end
  local function goalComplete(conditionKey)
    if task.specialName == "payload task" then
      currentBPM = floor(task.networkVars.payload)
      if currentBPM ~= heartTable.bpm then
        heartTable.bpm = currentBPM
        heartTable.value = cardSystem.getHeartometerHUDValue(task)
        feedbackSystem.updateHeartMonitor(heartTable)
      end
      if conditionKey <= #cardSystem.heartometerLogicTable then
        pointsParams.pointsSlotPass = 1
        pointsParams.pointsSlotFail = nil
        pointsParams.pointsText = cardSystem.heartometerLogicTable[conditionKey].feedback
        pointsParams.pointsValue = task.networkVars.pointsAwarded
        feedbackSystem.updatePointsFeedback(pointsParams)
      elseif conditionKey <= #cardSystem.heartometerLogicTable + 6 then
        pointsParams.pointsSlotPass = nil
        if conditionKey == #cardSystem.heartometerLogicTable + 3 then
          pointsParams.pointsSlotFail = 1
        elseif conditionKey == #cardSystem.heartometerLogicTable + 6 then
          if pointsParams.pointsSlotPass == nil then
            pointsParams.pointsSlotFail = 1
          end
        else
          pointsParams.pointsSlotFail = nil
          pointsParams.pointsText = tostring(cardSystem.heartometerFeedbackTable[conditionKey - #cardSystem.heartometerLogicTable].feedback)
        end
        feedbackSystem.updatePointsFeedback(pointsParams)
      end
    end
  end
  local function taskComplete()
    if task.specialName == "payload task" and task.success then
      heartTable.bpm = 180
      heartTable.value = 90
      feedbackSystem.updateHeartMonitor(heartTable)
      OneShotSound.Play("HUD_Gen_Positive", false)
    elseif task.specialName == "Text prompts off" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.clearSecondaryTextPrompt()
    elseif task.specialName == "Display prompts and heartometer" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:233880", false, false, false, false)
      feedbackSystem.menusMaster.secondaryTextPrompt("ID:234328", false, false, 0.1, false)
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
