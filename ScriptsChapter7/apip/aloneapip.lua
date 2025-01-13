feedbackSystem.registerAudioPIP("Alone APIP", function(task)
  if task.specialName == "drive under bridge" then
    feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_1")
  elseif task.specialName == "puzzle audio1" then
    print("======================================")
    feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_3")
  end
  local function goalComplete(conditionKey)
    if task.specialName == "health1" or task.specialName == "health2" then
      if conditionKey == 1 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_12A")
      elseif conditionKey == 2 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_12B")
      elseif conditionKey == 3 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_12C")
      elseif conditionKey == 4 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_12D")
      end
    elseif task.specialName == "weird audio" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_2")
    elseif string.find(task.specialName, "puzzle audio") then
      if task.specialName == "puzzle audio1" then
        if conditionKey == 1 then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_5C")
        end
      elseif task.specialName == "puzzle audio2" then
        if conditionKey == 1 then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_5D")
        elseif conditionKey == 2 then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_4")
        end
      elseif task.specialName == "puzzle audio4" then
        if conditionKey == 1 then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_8D")
        elseif conditionKey == 2 then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_7")
        end
      end
    elseif string.find(task.specialName, "time delay") then
      if task.specialName == "time delay1" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_6")
      elseif task.specialName == "time delay2" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_9")
      end
    elseif string.find(task.specialName, "tried to shift out") then
      feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_L_1")
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "mass chase" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_11")
      elseif task.specialName == "alley chase audio" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_20")
      end
    end
  end
  return nil, goalComplete, taskComplete
end)
