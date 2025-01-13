feedbackSystem.registerAudioPIP("Bad Medicine APIP", function(task)
  local taskObject = task.agent:getTaskObject()
  local zapCounter = 1
  local alreadyInZap = false
  local function goalComplete(conditionKey)
    if taskObject == localPlayer:getTaskObject() and task.specialName == "Audio - Incidental Driveto Speech" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_2")
    end
    if task.specialName == "Audio - Player In Zap Chase Convoy" and conditionKey == 1 and not alreadyInZap then
      if zapCounter == 1 then
        feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_1")
      elseif zapCounter == 4 then
        feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_2")
      end
      zapCounter = zapCounter + 1
      alreadyInZap = true
    elseif task.specialName == "Audio - Player In Zap Chase Convoy" and conditionKey == 2 and alreadyInZap then
      alreadyInZap = false
    elseif task.specialName == "Get to boxes" then
      OneShotSound.Play("HUD_Play_Waypoint")
    end
  end
  local function taskComplete(conditionKey)
    if task.specialName == "Soft save" then
      feedbackSystem.startMusic("Uid00221_CH04_Standard_BadMedicine1_Play")
    elseif task.specialName == "First PiP" then
      feedbackSystem.eventFeedback(task.agent, "PIP01")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
