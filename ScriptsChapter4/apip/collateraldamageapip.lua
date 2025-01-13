feedbackSystem.registerAudioPIP("Collateral damage APIP", function(task)
  local playInZapAudio2 = true
  local playInZapAudio3 = true
  local triggerName = task.specialName
  local tanner = task.agent
  local function goalComplete(conditionKey)
    if task.specialName == "Felony chase" then
      if conditionKey == 1 then
        eventFeedback(tanner, "GPMV01_SEQUENCE_L_2A")
      elseif conditionKey == 5 then
        eventFeedback(tanner, "GPMV01_SEQUENCE_R_1")
      elseif conditionKey >= 2 then
        eventFeedback(tanner, "GPMV01_SEQUENCE_R_3A")
      end
    elseif triggerName == "In zap again" then
      eventFeedback(tanner, "GPZP01_ZAP_L_3")
    elseif triggerName == "zap in jericho" and playInZapAudio3 and conditionKey == 1 then
      playInZapAudio3 = false
      eventFeedback(tanner, "GPZP01_ZAP_L_2")
    elseif triggerName == "zap in jericho" and conditionKey == 2 then
      playInZapAudio3 = true
    elseif task.specialName == "civ attack tanner" and conditionKey == 3 then
      if task.instance.taskObjectsByActorID["Tanner 2"].coreData.agent.damage < 0.15 then
        eventFeedback(tanner, "GPMV01_SEQUENCE_R_7A")
      elseif task.instance.taskObjectsByActorID["Tanner 2"].coreData.agent.damage < 0.3 then
        eventFeedback(tanner, "GPMV01_SEQUENCE_R_7B")
      elseif task.instance.taskObjectsByActorID["Tanner 2"].coreData.agent.damage < 0.5 then
        eventFeedback(tanner, "GPMV01_SEQUENCE_R_7C")
      elseif task.instance.taskObjectsByActorID["Tanner 2"].coreData.agent.damage < 0.7 then
        eventFeedback(tanner, "GPMV01_SEQUENCE_R_7D")
      elseif task.instance.taskObjectsByActorID["Tanner 2"].coreData.agent.damage < 0.85 then
        eventFeedback(tanner, "GPMV01_SEQUENCE_R_7E")
      end
    end
  end
  local function taskComplete(conditionKey)
    if triggerName == "Felony chase" then
      feedbackSystem.stopMusic("Uid02306_CH04_Story_CollateralDamage_Stop")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
