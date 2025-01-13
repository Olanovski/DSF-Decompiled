feedbackSystem.registerAudioPIP("Tanner and Jones Mission 2 APIP", function(task)
  local function goalComplete(conditionKey)
    if task.specialName == "audio dialogue" then
      if conditionKey == 1 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_2E", nil, "missioncritical")
      elseif conditionKey == 2 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_2G", nil, "missioncritical")
      elseif conditionKey == 3 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_2H", nil, "missioncritical")
        feedbackSystem.eventFeedback(task.agent, "PIP01", nil, "queued")
      end
    elseif task.specialName == "Chased by player" then
      if task.networkVars.checkpoints == 22 and not isEventActive() then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_2F")
      end
    elseif task.specialName == "Tail warning audio" then
      if conditionKey == 1 then
        if not isEventActive() then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_3A", nil, "timeSensitive")
        end
      elseif conditionKey == 2 and not isEventActive() then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_3B", nil, "timeSensitive")
      end
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "Initial sample" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_1")
      elseif task.specialName == "Driving audio" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_2A")
      elseif task.specialName == "Search for target" then
        OneShotSound.Play("HUD_Play_Waypoint")
      elseif task.specialName == "Stopped before the boundary" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP02")
      end
    end
  end
  return update, goalComplete, taskComplete
end)
