feedbackSystem.registerAudioPIP("Rapid shift APIP", function(task)
  local function taskComplete()
    if task.specialName == "In vehicle" then
    elseif task.specialName == "In shift" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_3")
    elseif task.specialName == "In vehicle after first zap return" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_4")
    elseif task.specialName == "Part 3 - In vehicle" then
    elseif task.specialName == "Part 3 - In vehicle 2" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_9")
    end
  end
  return nil, nil, taskComplete, nil
end)
