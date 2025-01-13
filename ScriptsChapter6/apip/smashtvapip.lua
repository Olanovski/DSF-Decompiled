feedbackSystem.registerAudioPIP("Smash tv APIP", function(task)
  local taskObject = task.agent:getTaskObject()
  local update = function()
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Checkpoints" then
      feedbackSystem.startMusic("Uid00787_CH04_Standard_TripleCross_Play")
    elseif task.specialName == "shift audio 1" then
      feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_R_1")
    elseif task.specialName == "shift audio 2" then
      feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_R_2")
    elseif task.specialName == "player vehicle's damaged part 1" or task.specialName == "player vehicle's damaged part 2" then
      if conditionKey == 1 and task.agent.gameVehicle.damage < 0.8 then
        feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_2")
      elseif conditionKey == 2 then
        feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_3")
      end
    elseif task.specialName == "target's getting destroyed" then
      if conditionKey == 1 and 1 > task.instance.taskObjectsByActorID.Truck.coreData.agent.gameVehicle.damage then
        feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_6")
      elseif conditionKey == 2 then
        feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_7")
      elseif conditionKey == 3 then
        feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_8")
      elseif conditionKey == 4 then
        feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_9")
      end
    elseif task.specialName == "Felony countdown is on 1" or task.specialName == "Felony countdown is on 2" then
      feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_1A")
    end
  end
  local function taskComplete(conditionKey)
    if task.specialName == "Instructions" then
      feedbackSystem.eventFeedback(task.agent, "PIP01")
    elseif task.specialName == "second audio" then
      feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_1")
    end
  end
  local cleanup = function()
  end
  return nil, goalComplete, taskComplete, nil
end)
