feedbackSystem.registerAudioPIP("Drive to survive APIP", function(task)
  local underSpeechAllowed = true
  local overSpeechAllowed = true
  local function goalComplete(conditionKey)
    if task.specialName == "Show first marker" then
      if conditionKey == 2 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01")
      end
    elseif task.specialName == "payload task" then
      if conditionKey == 1 + #cardSystem.heartometerLogicTable and underSpeechAllowed then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_3A")
        underSpeechAllowed = false
      elseif conditionKey == 2 + #cardSystem.heartometerLogicTable and overSpeechAllowed then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_3B")
        overSpeechAllowed = false
      elseif conditionKey == 3 + #cardSystem.heartometerLogicTable then
        underSpeechAllowed = true
      elseif conditionKey == 4 + #cardSystem.heartometerLogicTable then
        overSpeechAllowed = true
      end
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "in zap (audio)" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1")
      elseif task.specialName == "timer 45s (audio)" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_2")
      elseif task.specialName == "timer 90s (audio)" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_1")
      elseif task.specialName == "PIP 2" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP02")
      end
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
