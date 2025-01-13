feedbackSystem.registerHUD("Tanner And Jones 3 HUD", function(task, settings)
end, function(task, settings)
  local lastBPM = 0
  local currentBPM, heartTable, pointsParams, timer
  if task.specialName == "scare timer" then
    timer = {
      slot = 2,
      startTime = 90,
      flashTime = 30,
      promptTime = 30
    }
  elseif task.specialName == "Scare section" then
    heartTable = {
      slot = 1,
      bpm = task.networkVars.payload,
      value = cardSystem.getHeartometerHUDValue(task)
    }
    pointsParams = {pointsSlotPass = 1}
    feedbackSystem.updateHeartMonitor(heartTable)
    feedbackSystem.menusMaster.primaryTextPrompt("ID:232265", false, false, false, false)
  elseif task.specialName == "Initial drive" then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:184393", false, true, false, false)
  end
  local function update()
    if not gameStatus.simulationPaused and task.goalFeedback.Timer and task.specialName == "scare timer" and not task.success then
      feedbackSystem.stepTimer(timer)
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Scare section" and not task.complete then
      currentBPM = math.floor(task.networkVars.payload)
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
    end
  end
  local function taskComplete()
    if task.specialName == "wreck them prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184387", false, false, false, false)
      feedbackSystem.menusMaster.blockHintButton(false)
      feedbackSystem.menusMaster.setCurrentFocusString(4)
      localPlayer:blockAbility("zap", false)
    end
  end
  return update, goalComplete, taskComplete, nil
end)
