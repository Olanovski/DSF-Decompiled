feedbackSystem.registerAudioPIP("Avoid the Cars APIP", function(task)
  local ramSample = 0
  local function goalComplete(conditionKey)
    if task.specialName == "Mission speech triggers" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_5", nil, "missionCritical")
    elseif task.specialName == "Button press" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_12A", nil, "missionCritical")
    elseif task.specialName == "Tanner health" then
      if conditionKey == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_4A", nil, "missionCritical")
      elseif conditionKey == 2 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_4B", nil, "missionCritical")
      elseif conditionKey == 3 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_4C", nil, "missionCritical")
      end
    elseif task.specialName == "The chase" and conditionKey == 1 then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_11A", nil, "missionCritical")
    end
  end
  local function taskComplete()
    if task.specialName == "In tanner" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_8", nil, "missionCritical")
      task.instance.taskObjectsByActorID["Tanner Actor"].coreData.agent.throwing = false
    elseif task.specialName == "The chase" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_9", nil, "missionCritical")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
