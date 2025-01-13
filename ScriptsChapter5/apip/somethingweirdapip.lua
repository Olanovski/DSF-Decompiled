feedbackSystem.registerAudioPIP("Something Weird APIP", function(task)
  local played1stCollision = false
  local playedAudioInTrails = false
  local playedAudioFailing = false
  local playedAudio1 = false
  local playedAudio2 = false
  local playedAudio3 = false
  local playedAudio4 = false
  if task.specialName == "Chase ambulance" then
    feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_2A")
  elseif task.specialName == "Chase ambulance 2" then
    feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_2G")
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Audio - Chase 1 zap prompt" or task.specialName == "Audio - Chase 2 zap prompt" then
      feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_L_1", nil, "missionCritical")
    elseif task.specialName == "Trigger text 2" then
      if not played1stCollision then
        Commentary.StopCommentary()
        PIP.Activate("playfmv COM:fmv\\PiPs\\UID02818_Pip02.bik", nil)
        played1stCollision = true
      end
    elseif task.specialName == "Chase ambulance" then
      if conditionKey == 1 then
        if not playedAudioInTrails then
          playedAudioInTrails = feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_2C")
        elseif task.networkVars.payload < 175 and not playedAudio1 then
          playedAudio1 = feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_2E")
        elseif task.networkVars.payload < 170 and not playedAudio2 then
          playedAudio2 = feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_2E")
        elseif task.networkVars.payload < 165 and not playedAudio3 then
          playedAudio3 = feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_2F")
        elseif task.networkVars.payload < 160 and not playedAudio4 then
          playedAudio4 = feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_2F")
        end
      elseif conditionKey == 3 and task.networkVars.payload < 190 and not playedAudioFailing then
        playedAudioFailing = feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_60")
      end
    elseif task.specialName == "Chase ambulance 2" then
      if conditionKey == 1 then
        if task.networkVars.payload < 150 and not playedAudio1 then
          playedAudio1 = feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_2H")
        elseif task.networkVars.payload < 130 and not playedAudio2 then
          playedAudio2 = feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_2H")
        elseif task.networkVars.payload < 110 and not playedAudio3 then
          playedAudio3 = feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_2I")
        elseif task.networkVars.payload < 90 and not playedAudio4 then
          playedAudio4 = feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_2I")
        end
      elseif conditionKey == 3 and task.networkVars.payload < 190 and not playedAudioFailing then
        playedAudioFailing = feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_60")
      end
    elseif task.specialName == "Target switch" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_5")
    elseif task.specialName == "Target switch2" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_10")
    elseif task.specialName == "Respawn2" or task.specialName == "Respawn2" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_15")
    end
  end
  local function taskComplete()
    if task.specialName == "Initial audio" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_1", nil, "missionCritical")
    elseif task.specialName == "Chase ambulance" and task.success then
      Commentary.StopCommentary()
      playedAudio3 = feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_2E", nil, "missionCritical")
    elseif task.specialName == "Transition" then
      feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_2B")
    elseif task.specialName == "Prompt start chase" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_2")
    end
  end
  return nil, goalComplete, taskComplete
end)
