feedbackSystem.registerAudioPIP("In the nick of time APIP", function(task)
  if task.specialName == "getToTheBomb" then
    feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01", nil, "missioncritical")
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Zapped out 1" or task.specialName == "Zapped out 12" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_1", nil, "missioncritical")
    elseif task.specialName == "Zapped out 2" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_2", nil, "missioncritical")
    elseif task.specialName == "player in chase cop" then
      if conditionKey == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_2", nil, "missioncritical")
      elseif conditionKey == 2 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_2", nil, "missioncritical")
      end
    end
  end
  local function taskComplete(conditionKey)
    if task.success then
      if task.specialName == "audio dialogue 1" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_2A", nil, "missioncritical")
      elseif task.specialName == "audio dialogue 2" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_2B", nil, "missioncritical")
      elseif task.specialName == "audio dialogue 3" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_2C", nil, "missioncritical")
      end
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
