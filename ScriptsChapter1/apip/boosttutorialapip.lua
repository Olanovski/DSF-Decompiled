feedbackSystem.registerAudioPIP("Boost tutorial APIP", function(task)
  local function taskComplete()
    if task.specialName == "Zap prompt" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_1")
    elseif task.specialName == "Boost prompt" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_2")
    elseif task.specialName == "Boosted" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_3")
    elseif task.specialName == "WAIT" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_4")
    elseif task.specialName == "Mid boost" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_5")
    elseif task.specialName == "Trigger tutorial panel" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_6")
    end
  end
  return nil, nil, taskComplete, nil
end)
