feedbackSystem.registerAudioPIP("Breaking news 2", function(task)
  local playDialogue = function(inID, inComment)
    feedbackSystem.eventFeedback(localPlayer.currentVehicle, inID)
  end
  if task.specialName == "Zap out" then
    Sound.EnableScoring("drift", true)
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Drift zap out" then
      playDialogue("GPZP04_ZAP_4", "Zap drift")
    elseif task.specialName == "Speed zap out" then
      playDialogue("GPZP01_ZAP_1", "Zap speed")
    elseif task.specialName == "Cop zap out" then
      if conditionKey == 1 then
        playDialogue("GPZP03_ZAP_3A", "Zap cop - chasers")
      else
        playDialogue("GPZP03_ZAP_3B", "Zap cop - no chasers")
      end
    elseif task.specialName == "Oncoming zap out" then
      playDialogue("GPZP05_ZAP_5", "Zap oncoming")
    elseif task.specialName == "Smash zap out" then
      playDialogue("GPZP02_ZAP_2", "Zap smash")
    end
  end
  local function taskComplete()
    if task.specialName == "Drift complete audio" then
      playDialogue("GPMV00_SEQUENCE_R_1", "Speech when drift")
    elseif task.specialName == "Wait to display speed prompt" then
      Sound.EnableScoring("drift", false)
    elseif task.specialName == "Speed complete audio" then
      playDialogue("GPMV00_SEQUENCE_R_2", "Speech when speed")
    elseif task.specialName == "Cop complete audio" then
      playDialogue("GPMV00_SEQUENCE_R_4", "Speech when cop")
    elseif task.specialName == "Oncoming complete audio" then
      playDialogue("GPMV00_SEQUENCE_R_3", "Speech when oncoming")
    elseif task.specialName == "Smash complete audio" then
      playDialogue("GPMV00_SEQUENCE_R_6", "Speech when colliding")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
