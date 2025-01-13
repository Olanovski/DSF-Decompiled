feedbackSystem.registerAudioPIP("Dare activity and garage APIP", function(task)
  local function goalComplete(conditionKey)
    if task.specialName == "Dare accepted" and conditionKey == 2 then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_1")
    elseif task.specialName == "Purchased vehicle from garage" and conditionKey == 4 then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_1")
    end
  end
  local function taskComplete(conditionKey)
    if task.specialName == "Activity prompt audio" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_1")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
