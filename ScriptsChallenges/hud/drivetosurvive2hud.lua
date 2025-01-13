feedbackSystem.registerHUD("DriveToSurvive2 hud", function(task, settings)
end, function(task, settings)
  local timer = {slot = 1}
  local previousCountdown = false
  local heartTable, lastBPM, pointsParams
  local floor = math.floor
  local currentBPM
  if task.specialName == "payload task" then
    heartTable = {
      slot = 3,
      bpm = task.networkVars.payload,
      value = cardSystem.getHeartometerHUDValue(task),
      flipFeedback = true
    }
    pointsParams = {pointsSlotPass = 3}
    lastBPM = task.networkVars.payload
    feedbackSystem.updateHeartMonitor(heartTable)
  end
  local countdownStarted = false
  local function update()
    if not gameStatus.simulationPaused then
      if task.specialName == "Wait for countdown" then
        if not countdownStarted then
          feedbackSystem.menusMaster.singlePlayer321Countdown()
          countdownStarted = true
        end
      elseif task.instance.challenge.goalValues["Time limit"] then
        timer.startTime = task.instance.challenge.goalValues["Time limit"]
        feedbackSystem.stepTimer(timer)
      else
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
        if task.networkVars.pointsAwarded < 1 then
          pointsParams.pointsValue = 1
        else
          pointsParams.pointsValue = task.networkVars.pointsAwarded
        end
        feedbackSystem.updatePointsFeedback(pointsParams)
      end
    end
  end
  return update, goalComplete, nil, nil
end)
