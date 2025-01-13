local forceCalmDown
feedbackSystem.registerAudioPIP("Paranoia APIP", function(task)
  local comesFromMainRoad = false
  local hasBeenInAlley = 2
  if task.specialName == "Audio First suspicion" then
    forceCalmDown = false
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Audio First suspicion" and not didRecentAudio(2) then
      local payload = task.instance.taskObjectsByActorID.Player.namedTasks["First suspicion"].networkVars.payload
      if conditionKey == 1 then
        if hasBeenInAlley == 2 and (payload < 50 or payload > 60) and (payload < 80 or payload > 90) then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_2A")
          hasBeenInAlley = 0
        end
        comesFromMainRoad = true
      elseif conditionKey == 2 and comesFromMainRoad then
        if hasBeenInAlley == 0 then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_3")
          hasBeenInAlley = 1
          forceCalmDown = false
        else
          hasBeenInAlley = 2
          if forceCalmDown then
            feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_3")
            forceCalmDown = false
          end
        end
        comesFromMainRoad = false
      end
    elseif task.specialName == "Second suspicion" and not didRecentAudio(2) then
      if conditionKey == 5 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_8")
      end
    elseif task.specialName == "First suspicion" then
      if conditionKey == 4 and not didRecentAudio(2) then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_2B")
        forceCalmDown = true
      elseif conditionKey == 5 and not didRecentAudio(2) then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_2C")
        forceCalmDown = true
      end
    elseif task.specialName == "Mission feedback" then
      if conditionKey == 2 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_5")
      elseif conditionKey == 3 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_6")
      elseif conditionKey == 4 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_7")
      end
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "Trigger intro" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_1")
      elseif task.specialName == "Wait for audio" and task.agent.controlled then
        feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_2")
      end
    end
  end
  local function cleanup()
    hasBeenInAlley = 2
    comesFromMainRoad = false
    forceCalmDown = false
  end
  return nil, goalComplete, taskComplete, cleanup
end)
