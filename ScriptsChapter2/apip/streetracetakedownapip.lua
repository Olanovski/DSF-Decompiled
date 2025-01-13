feedbackSystem.registerAudioPIP("Streetrace takedown APIP", function(task)
  local taskObject = task.agent:getTaskObject()
  local update = function()
  end
  local function goalComplete(conditionKey)
    if taskObject == localPlayer:getTaskObject() then
      if task.specialName == "ChaserTask" and conditionKey == 2 then
        local shiftTag
        if #task.dynamicTargets == 4 then
          shiftTag = "GPZP01_ZAP_1"
        elseif #task.dynamicTargets == 3 then
          shiftTag = "GPZP01_ZAP_2"
        elseif #task.dynamicTargets == 2 then
          shiftTag = "GPZP01_ZAP_4"
        elseif #task.dynamicTargets == 1 then
          shiftTag = "GPZP01_ZAP_5"
        end
        feedbackSystem.eventFeedback(taskObject.coreData.agent, shiftTag, nil, "missionCritical")
      elseif task.specialName == "Audio - Tanner in agent incidental audio" and conditionKey == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_2")
      end
    end
  end
  local taskComplete = function()
  end
  local cleanup = function()
  end
  return nil, goalComplete, nil, nil
end)
