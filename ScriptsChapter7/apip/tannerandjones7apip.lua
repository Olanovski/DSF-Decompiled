feedbackSystem.registerAudioPIP("Tanner and Jones Mission 7 APIP", function(task)
  if task.specialName == "get to decoy" then
    feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_1", nil, "missioncritical")
  end
  local function goalComplete(conditionKey)
    if task.specialName == "in zap on highway" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_2", nil, "missioncritcal")
    elseif task.specialName == "losing Leila" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_3B", nil, "missioncritcal")
    elseif string.find(task.specialName, "Damage watch") then
      if conditionKey == 1 and not task.instance.firstDamagePlayed then
        task.instance.firstDamagePlayed = true
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_13", nil, "missioncritcal")
      elseif conditionKey == 2 and not task.instance.secondDamagePlayed then
        task.instance.secondDamagePlayed = true
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_13", nil, "missioncritcal")
      elseif conditionKey == 3 and not task.instance.thirdDamagePlayed then
        task.instance.thirdDamagePlayed = true
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_13", nil, "missioncritcal")
      end
    end
  end
  local function taskComplete(conditionKey)
    if task.specialName == "icam ended" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_8", nil, "missioncritcal")
    elseif task.specialName == "get to midpoint" or task.specialName == "get to midpoint 2" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_12", nil, "missioncritcal")
    elseif task.specialName == "set up felony" then
      feedbackSystem.eventFeedback(task.agent, "PIP02", nil, "missioncritcal")
    elseif task.specialName == "zap before bomb" then
      feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_1A", nil, "missioncritcal")
    elseif task.specialName == "Wait before respawn" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_11", nil, "missioncritcal")
    elseif task.specialName == "Zoom to Leila" and conditionKey == 1 then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_15", nil, "missioncritcal")
    elseif task.specialName == "Second speech" and conditionKey == 2 then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_2", nil, "missioncritcal")
    elseif task.specialName == "get to leila audio 1" or task.specialName == "get to leila audio 2" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_10", nil, "missioncritcal")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
