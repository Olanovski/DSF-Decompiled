feedbackSystem.registerAudioPIP("Anything you can do APIP", function(task)
  local rammedJerichoAudio = 0
  local function goalComplete(conditionKey)
    if task.specialName == "Tanner health" then
      if conditionKey == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4A")
      elseif conditionKey == 2 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4B")
      elseif conditionKey == 3 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4C")
      end
    elseif task.specialName == "Mission speech triggers" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_5")
    elseif task.specialName == "Jericho health" then
      if conditionKey == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_7A")
      elseif conditionKey == 2 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_7B")
      elseif conditionKey == 3 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_7C")
      end
    elseif task.specialName == "Ram jericho" then
      if rammedJerichoAudio == 0 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_6A")
        rammedJerichoAudio = 1
      elseif rammedJerichoAudio == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_6B")
        rammedJerichoAudio = 2
      elseif rammedJerichoAudio == 2 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_6C")
        rammedJerichoAudio = 3
      end
    elseif task.specialName == "idle" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_7")
    elseif task.specialName == "In zap" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_R_1")
    elseif task.specialName == "Initial civ speech" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP04")
    end
  end
  local function taskComplete()
    if task.specialName == "Shift back to tanner and trigger end speech" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SUCCESS_L_1")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
