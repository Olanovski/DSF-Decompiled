feedbackSystem.registerAudioPIP("Final Destination APIP", function(task)
  local unblockShift = function()
    localPlayer:blockAbility("zap", false)
    feedbackSystem.startMusic("Uid00408_CH06_Standard_HandleWithCare_Play")
  end
  local previousVehicle
  local function goalComplete(goalConditionKey)
    if task.specialName == "Mission start" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_1", unblockShift)
    elseif task.specialName == "In large civilian" then
      feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_2")
    elseif task.specialName == "In small civilian" then
      currentVehicle = localPlayer.currentVehicle
      if currentVehicle ~= previousVehicle then
        GameVehicleResource.setCharacterSpoolingEntityIndex(localPlayer.currentVehicle.gameVehicle, 1, "-398284235")
        feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_1")
        previousVehicle = currentVehicle
      end
    elseif task.specialName == "Zap audio - find car" then
      feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_L_2", nil, "missionCritical")
    elseif task.specialName == "payload task 1" and goalConditionKey == 9 then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_3A", nil, "missionCritical")
    elseif task.specialName == "payload task 1" and goalConditionKey == 10 then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_3D", nil, "missionCritical")
    elseif task.specialName == "payload task 1" and goalConditionKey == 11 then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_3E", nil, "missionCritical")
    elseif task.specialName == "Zapped out" then
      feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_L_1", nil, "missionCritical")
    end
  end
  local function taskComplete()
    if task.specialName == "Audio sequence" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_2")
    elseif task.specialName == "Audio sequence2" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_5")
    elseif task.specialName == "PIP 2 play" then
      feedbackSystem.eventFeedback(task.agent, "PIP01")
    elseif task.specialName == "Almost at alley" then
      feedbackSystem.eventFeedback(task.agent, "PIP02")
    elseif task.specialName == "Final payload" then
      feedbackSystem.stopMusic("Uid00408_CH06_Standard_HandleWithCare_Stop")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
