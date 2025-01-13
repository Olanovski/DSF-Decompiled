feedbackSystem.registerAudioPIP("Escape the law 3 APIP", function(task)
  local update = function()
  end
  local playPip = function()
    if not isEventActive() then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01")
      removeUserUpdateFunction("playPip")
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Prompt and pip" then
      if conditionKey == 2 then
        addUserUpdateFunction("playPip", playPip, 1, false)
      end
    elseif task.specialName == "Play penultimate audio" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_7")
    elseif string.find(task.specialName, "In zap audio") then
      if Getaway.IsBeingChased(task.agent.gameVehicle) then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1")
      else
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_2")
      end
    elseif string.find(task.specialName, "distance cop reminder") then
      if conditionKey == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_7A")
      else
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_7B")
      end
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "checkpoint 2" and not isEventActive() then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_1")
      elseif task.specialName == "checkpoint 3" and not isEventActive() then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_2B")
      elseif task.specialName == "checkpoint 4" and not isEventActive() then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_8C")
      elseif string.find(task.specialName, "Damage audio 0.35") then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_10A")
      elseif string.find(task.specialName, "Damage audio 0.6") then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_10B")
      elseif string.find(task.specialName, "Damage audio 0.85") then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_10C")
      end
    end
  end
  local cleanup = function()
    removeUserUpdateFunction("playPip")
  end
  return nil, goalComplete, taskComplete, nil
end)
