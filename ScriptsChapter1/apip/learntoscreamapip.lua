feedbackSystem.registerAudioPIP("Learn to scream", function(task)
  local payloadStarted = false
  local oncomingTrafficDialoguePlayed = false
  if task.specialName == "payload task" then
    payloadStarted = true
  end
  local function update()
    if payloadStarted and not oncomingTrafficDialoguePlayed and not task.instance.taskObjectsByActorID.Learner.coreData.agent:get_withTrafficFlow() and not isVehicleOnJunction(task.instance.taskObjectsByActorID.Learner.coreData.agent) and task.networkVars.payload and task.networkVars.payload > 90 and not isEventActive() then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_2")
      oncomingTrafficDialoguePlayed = true
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "payload task" then
      if conditionKey == 2 + #cardSystem.heartometerLogicTable + #cardSystem.heartometerFeedbackTable then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_3")
        oncomingTrafficDialoguePlayed = true
      elseif conditionKey == 3 + #cardSystem.heartometerLogicTable + #cardSystem.heartometerFeedbackTable then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP02", nil, "missionCritical")
        oncomingTrafficDialoguePlayed = true
      elseif conditionKey == 4 + #cardSystem.heartometerLogicTable + #cardSystem.heartometerFeedbackTable then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4")
        oncomingTrafficDialoguePlayed = true
      elseif conditionKey == 5 + #cardSystem.heartometerLogicTable + #cardSystem.heartometerFeedbackTable then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01", nil, "missionCritical")
        oncomingTrafficDialoguePlayed = true
      elseif conditionKey == 6 + #cardSystem.heartometerLogicTable + #cardSystem.heartometerFeedbackTable then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_7")
        oncomingTrafficDialoguePlayed = true
      end
    end
  end
  local function taskComplete(conditionKey)
    if task.specialName == "payload task" then
      if conditionKey == 3 then
        feedbackSystem.taskSuccessAudio()
        eventFeedback(task.agent, "GPMV01_SEQUENCE_R_8", nil, "missionCritical")
      end
    elseif task.specialName == "zapped out" then
      eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1")
    elseif task.specialName == "Initial pause" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP03")
    end
  end
  return update, goalComplete, taskComplete, nil
end)
