feedbackSystem.registerAudioPIP("Escape the law", function(task)
  local taskObject = task.agent:getTaskObject()
  if task.specialName == "Initial pause" then
    feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_1")
  end
  local played = false
  local pipPlayed = false
  local function goalComplete(conditionKey)
    if task.specialName == "Main logic" and conditionKey == 2 then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_7")
    elseif task.specialName == "In zap" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1")
    elseif task.specialName == "Damage audio" then
      local playerVehicle = task.instance.taskObjectsByActorID["evade team member 1"]
      if conditionKey == 1 and playerVehicle and 1 >= playerVehicle.coreData.agent.damage then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_3A")
      elseif conditionKey == 2 and playerVehicle and 1 >= playerVehicle.coreData.agent.damage then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_3B")
      elseif conditionKey == 3 and playerVehicle and 1 >= playerVehicle.coreData.agent.damage then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_3C")
      end
    elseif task.specialName == "Still being chased" and not pipPlayed then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01")
      pipPlayed = true
    end
  end
  local function taskComplete()
    if task.specialName == "Had collision" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP02")
    elseif task.specialName == "One third of time" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_8A")
    elseif task.specialName == "Two thirds of time" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_8B")
    elseif task.specialName == "Not being chased" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_9")
    end
  end
  local cleanup = function()
  end
  return nil, goalComplete, taskComplete, nil
end)
