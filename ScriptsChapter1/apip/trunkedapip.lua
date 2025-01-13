feedbackSystem.registerAudioPIP("Trunked APIP", function(task)
  local audioCallback = function()
    OneShotSound.Play("Mis_Kidnapped_TrunkAmb_Phone_Stop")
  end
  local startPhoneAmbience = function()
    OneShotSound.Play("Mis_Kidnapped_TrunkAmb_Phone_Play")
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Audio - 1st Destination Zap Prompt" or task.specialName == "Audio - 2nd Destination Zap Prompt" or task.specialName == "Audio - 3rd Destination Zap Prompt" then
      feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_L_1")
    elseif task.specialName == "Audio - 5th Destination Zap Prompt" or task.specialName == "Audio - 6th Destination Zap Prompt" or task.specialName == "Audio - find car zap prompt" then
      feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_L_3")
    elseif task.specialName == "Audio - chase car zap prompt" then
      feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_4")
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "Audio - Wait for 1st Destination Prompt" then
        startPhoneAmbience()
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_1", audioCallback)
      elseif task.specialName == "Reached 1st Destination" then
        OneShotSound.Play("HUD_Play_Waypoint")
        startPhoneAmbience()
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_2", audioCallback)
      elseif task.specialName == "Reached 2nd Destination" then
        OneShotSound.Play("HUD_Play_Waypoint")
        startPhoneAmbience()
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_3", audioCallback)
      elseif task.specialName == "Reached 3rd Destination" then
        OneShotSound.Play("HUD_Play_Waypoint")
        startPhoneAmbience()
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_4", audioCallback)
      elseif task.specialName == "Reached 4th Destination" then
        OneShotSound.Play("HUD_Play_Waypoint")
        feedbackSystem.eventFeedback(task.agent, "PIP01", nil, "missionCritical")
      elseif task.specialName == "Player is in TrunkedBootViewActor1" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_6")
        Sound.EnterAudioState("AuxAmbience", "Mis_Trunked_Trunk_Amb_Play", "Mis_Trunked_Trunk_Amb_Stop")
      elseif task.specialName == "Open trunk" then
        Sound.ExitAudioState("AuxAmbience")
        Sound.EnterAudioState("AuxAmbience", "Mis_Trunked_OpenTrunk_Amb_Play", "Mis_Trunked_OpenTrunk_Amb_Stop")
        OneShotSound.Play("Mis_Kidnapped_TrunkOpen")
      elseif task.specialName == "Player back from TrunkedBootViewActor1" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_7")
        Sound.ExitAudioState("AuxAmbience")
      elseif task.specialName == "Reached 5th Destination" then
        OneShotSound.Play("HUD_Play_Waypoint")
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_8")
      elseif task.specialName == "Arrive at TrunkedBootViewActor2" then
        Sound.EnterAudioState("AuxAmbience", "Mis_Trunked_OpenTrunk_Amb_Play", "Mis_Trunked_OpenTrunk_Amb_Stop")
      elseif task.specialName == "Back from TrunkedBootViewActor2" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_9")
        Sound.ExitAudioState("AuxAmbience")
      elseif task.specialName == "Reached 6th Destination" then
        OneShotSound.Play("HUD_Play_Waypoint")
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_12")
      elseif task.specialName == "Arrive at TrunkedActor" then
        Sound.EnterAudioState("AuxAmbience", "Mis_Trunked_OpenTrunk_Amb_Play", "Mis_Trunked_OpenTrunk_Amb_Stop")
      elseif task.specialName == "Back from TrunkedActor" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_13")
        Sound.ExitAudioState("AuxAmbience")
      end
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
