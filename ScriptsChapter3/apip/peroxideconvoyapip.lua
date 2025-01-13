feedbackSystem.registerAudioPIP("Peroxide Convoy APIP", function(task)
  local update = function()
  end
  local goalComplete = function(conditionKey)
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "Init dialogue hud1" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_1")
      elseif task.specialName == "look at tanker hud1" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_2")
      elseif task.specialName == "Initial chase hud2" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_3A")
      elseif task.specialName == "Back to tanner hud1" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01")
      elseif task.specialName == "Chase hud3" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_4A")
      elseif task.specialName == "Back from zap" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_4B")
      elseif task.specialName == "Pile-up hud3" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_5")
      elseif task.specialName == "Back to tanner again hud1" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SUCCESS_L_1")
      elseif task.specialName == "Strike tanker" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_2B")
      elseif task.specialName == "final timer" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SUCCESS_L_1")
      elseif task.specialName == "zap audio 1" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_1")
      elseif task.specialName == "zap audio 2" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_2")
      elseif task.specialName == "zap audio 3" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_3")
      elseif task.specialName == "zap audio 4" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_4")
      elseif task.specialName == "mini timer" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_5")
      end
    else
    end
  end
  local cleanup = function()
  end
  return nil, goalComplete, taskComplete, nil
end)
