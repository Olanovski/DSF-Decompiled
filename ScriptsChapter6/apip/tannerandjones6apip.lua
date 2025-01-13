feedbackSystem.registerAudioPIP("Tanner and Jones Mission 6 APIP", function(task)
  local trigger = task.specialName
  local taskObject = task.agent:getTaskObject()
  local function playDialogue(inID, inComment, callback)
    if task.agent.controlled then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, inID, callback)
    end
  end
  local function goalComplete(conditionKey)
    if trigger == "Speech trigger 02" then
      playDialogue("GPMV02_SEQUENCE_R_3")
    elseif trigger == "Speech trigger 04" then
      playDialogue("GPMV02_SEQUENCE_R_6")
    elseif trigger == "Player in zap with felony 01" or trigger == "Player in zap with felony 02" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_2")
    elseif trigger == "Player in zap without felony 01" or trigger == "Player in zap without felony 02" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1")
    elseif trigger == "Speech trigger 01" then
      playDialogue("GPMV01_SEQUENCE_L_2")
    end
  end
  local function taskComplete()
    if task.success then
      if trigger == "PlayerInTaskVehicle" then
        playDialogue("GPMV01_SEQUENCE_R_1")
      elseif trigger == "Speech trigger 01" then
        playDialogue("GPMV01_SEQUENCE_L_2")
      elseif trigger == "Waiting for player" then
        playDialogue("GPMV02_SEQUENCE_R_1")
      elseif trigger == "Felony 01" then
        OneShotSound.Play("HUD_Fel_Gained")
        playDialogue("GPMV02_SEQUENCE_R_2")
      elseif trigger == "PIP 01 trigger" then
        playDialogue("PIP01")
      elseif trigger == "lose cops" then
        feedbackSystem.startMusic("Uid06914_CH06_TJ_Escapist_Cue01_Play")
        playDialogue("GPMV02_SEQUENCE_R_4")
      elseif trigger == "Audio before PIP" then
        playDialogue("GPMV02_SEQUENCE_R_4B")
      elseif trigger == "Soft save trigger" then
        feedbackSystem.stopMusic("Uid06914_CH06_TJ_Escapist_Cue01_Stop")
      elseif trigger == "get to destination 1" then
        feedbackSystem.startMusic("Uid06914_CH06_TJ_Escapist_Cue02_Play")
      elseif trigger == "Audio after PIP" then
        playDialogue("GPMV02_SEQUENCE_R_5B")
      elseif trigger == "On approach 2" then
        playDialogue("GPMV02_FAILURE_L_3")
      elseif trigger == "get to destination 2" then
        feedbackSystem.stopMusic("Uid06914_CH06_TJ_Escapist_Cue02_Stop")
      elseif trigger == "mission end" then
        playDialogue("GPMV02_SUCCESS_L_1")
      end
    end
  end
  local cleanup = function()
    feedbackSystem.stopMusic()
  end
  return nil, goalComplete, taskComplete, cleanup
end)
