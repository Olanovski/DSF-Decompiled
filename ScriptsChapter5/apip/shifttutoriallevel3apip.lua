feedbackSystem.registerAudioPIP("Shift tutorial level 3", function(task)
  local function taskComplete(conditionKey)
    if task.specialName == "Intro finished" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_1")
    else
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_2")
    end
  end
  return nil, nil, taskComplete, nil
end)
