feedbackSystem.registerAudioPIP("Exposition takedown the getaway APIP", function(task)
  local losingEvaderTimerTriggered = false
  local function goalComplete(conditionKey)
    if task.specialName == "Player in zap" then
      eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_1")
    elseif task.specialName == "Cop 1 damage comments" then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_3")
    elseif task.specialName == "Player is in another vehicle when the cop car starts to lose the evader" then
      eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_1")
    elseif task.specialName == "Back in range speech trigger" then
      if conditionKey == 1 and not losingEvaderTimerTriggered then
        losingEvaderTimerTriggered = true
      elseif conditionKey == 2 and losingEvaderTimerTriggered then
        eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4")
      end
    end
  end
  local function taskComplete()
    if task.specialName == "Is player controlled" then
      eventFeedback(localPlayer.currentVehicle, "PIP01")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
