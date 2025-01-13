feedbackSystem.registerAudioPIP("Ram tutorial APIP", function(task)
  local function goalComplete(conditionKey)
    if task.specialName == "button press 2" and conditionKey == 1 then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_3")
    end
  end
  local function taskComplete()
    if task.specialName == "Zap prompt" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_1")
    elseif task.specialName == "cutscene finished" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_2")
    elseif task.specialName == "Player has rammed part 1" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_4")
    elseif task.specialName == "cutscene finished AGAIN" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_5")
    elseif task.specialName == "Trigger tutorial panel" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_6")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
