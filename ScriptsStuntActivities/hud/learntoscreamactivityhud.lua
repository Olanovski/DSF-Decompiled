feedbackSystem.registerHUD("Learn to scream activity hud", function(task, settings)
end, function(task, settings)
  local heartTable, timer, lastBPM, pointsParams
  local floor = math.floor
  local currentBPM
  local countdownStarted = false
  if task.specialName == "payload task" then
    heartTable = {
      slot = 1,
      bpm = task.networkVars.payload,
      value = cardSystem.getHeartometerHUDValue(task)
    }
    timer = {
      slot = 2,
      startTime = 90,
      timerFlash = 10
    }
    pointsParams = {pointsSlotPass = 1}
    lastBPM = task.networkVars.payload
    feedbackSystem.updateHeartMonitor(heartTable)
  end
  local function update()
    if not gameStatus.simulationPaused and task.specialName == "Wait for countdown" and not countdownStarted then
      feedbackSystem.menusMaster.singlePlayer321Countdown()
      countdownStarted = true
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "payload task" then
      currentBPM = floor(task.networkVars.payload)
      if currentBPM ~= heartTable.bpm then
        heartTable.bpm = currentBPM
        heartTable.value = cardSystem.getHeartometerHUDValue(task)
        feedbackSystem.updateHeartMonitor(heartTable)
      end
      feedbackSystem.stepTimer(timer)
      if conditionKey <= #cardSystem.heartometerLogicTable then
        pointsParams.pointsText = cardSystem.heartometerLogicTable[conditionKey].feedback
        pointsParams.pointsValue = task.networkVars.pointsAwarded
        feedbackSystem.updatePointsFeedback(pointsParams)
      end
    end
  end
  local function taskComplete()
    if task.specialName == "payload task" and task.success then
      OneShotSound.Play("HUD_Gen_Positive", false)
      heartTable.bpm = 180
      heartTable.value = 90
      feedbackSystem.updateHeartMonitor(heartTable)
    end
  end
  return update, goalComplete, taskComplete, nil
end)
