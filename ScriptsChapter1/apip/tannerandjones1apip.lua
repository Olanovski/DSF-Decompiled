feedbackSystem.registerAudioPIP("Tanner and Jones Mission 1 APIP", function(task)
  if task.specialName == "Racer task 1" then
    Sound.EnableScoring("jump", true)
  end
  local function goalComplete(conditionKey)
    if task.specialName == "first audio" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_2", nil, "missionCritical")
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "Player in agent 1" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_L_1")
        feedbackSystem.startMusic("Uid04354_CH01_TJ_ProveIt_Play")
      elseif task.specialName == "Racer task 1" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_L_2", nil, "missionCritical")
      elseif task.specialName == "Back in tanner 1" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_3", nil, "missionCritical")
        Sound.EnableScoring("jump", false)
      elseif task.specialName == "Player in agent 2" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_L_3")
      elseif task.specialName == "Racer task 2" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_L_4")
      elseif task.specialName == "Racer task lose cop" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_L_4A", nil, "missionCritical")
      elseif task.specialName == "Back in tanner 2" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_4", nil, "missionCritical")
      elseif task.specialName == "Player in agent 3" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_L_5")
      elseif string.find(task.specialName, "Zap to racer dialogue") then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_2")
      end
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
