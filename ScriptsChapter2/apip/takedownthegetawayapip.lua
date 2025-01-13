feedbackSystem.registerAudioPIP("Take down", function(task)
  local firstTeamMateDestroyed = false
  local shiftedOnce = false
  local function goalComplete(conditionKey)
    if task.specialName == "Audio - Player in zap" then
      if not shiftedOnce then
        feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_1", nil, "missioncritical")
        shiftedOnce = true
      else
        feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_2", nil, "missioncritical")
        shiftedOnce = false
      end
    elseif localPlayer.currentVehicle then
      if task.specialName == "Audio - Zapped into" then
        if conditionKey == 1 then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_1", nil, "missioncritical")
        elseif conditionKey == 2 then
          feedbackSystem.eventFeedback(task.agent, "GPMV03_SEQUENCE_R_1", nil, "missioncritical")
        end
      elseif task.specialName == "Audio - team mate destroyed" then
        if task.instance.playerPreviousVehicle == 1 then
          feedbackSystem.eventFeedback(task.agent, "PIP02")
        elseif task.instance.playerPreviousVehicle == 2 then
          feedbackSystem.eventFeedback(task.agent, "GPMV03_SEQUENCE_L_6")
        end
      end
    end
  end
  local function taskComplete(conditionKey)
    if task.specialName == "Audio - team mate destroyed" then
      if conditionKey == 2 and task.instance.playerPreviousVehicle == 1 then
        feedbackSystem.eventFeedback(task.agent, "PIP02")
      elseif conditionKey == 1 and task.instance.playerPreviousVehicle == 2 then
        feedbackSystem.eventFeedback(task.agent, "GPMV03_SEQUENCE_L_5")
      end
    elseif task.specialName == "Audio - getaway nearly wrecked" then
      if task.instance.playerPreviousVehicle == 1 then
        feedbackSystem.eventFeedback(task.agent, "PIP01")
      elseif task.instance.playerPreviousVehicle == 1 then
        feedbackSystem.eventFeedback(task.agent, "GPMV03_SEQUENCE_L_4")
      end
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
