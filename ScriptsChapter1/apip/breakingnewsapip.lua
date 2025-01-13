feedbackSystem.registerAudioPIP("Breaking News APIP", function(task)
  if task.specialName == "Wait For Zap" then
    feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1", nil, "missionCritical")
  elseif task.specialName == "HandBrake Turn" then
    Sound.EnableScoring("drift", true)
  elseif task.specialName == "Perform jump" then
    Sound.EnableScoring("jump", true)
  elseif task.specialName == "Get in van" then
    feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_4")
  elseif task.specialName == "Wait for jump camera" then
    Sound.EnableScoring("jump", false)
  elseif task.specialName == "Stop In Hotspot 2" then
    feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_3")
  end
  local function goalComplete(conditionKey)
    if task.specialName == "zap speed" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1", nil, "missionCritical")
    elseif task.specialName == "zap handbrake" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP02_ZAP_2", nil, "missionCritical")
    elseif task.specialName == "zap collision" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP04_ZAP_4", nil, "missionCritical")
    elseif task.specialName == "Speed Past" then
      if conditionKey == 2 then
      elseif conditionKey == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_9")
      end
    elseif task.specialName == "cam ended 1" then
      Commentary.OverrideZapTransition(true)
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_1", function()
        Commentary.OverrideZapTransition(false)
      end, "missionCritical")
    elseif task.specialName == "HandBrake Turn" then
      if conditionKey == 2 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_7A")
      elseif conditionKey == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_10")
      end
    elseif task.specialName == "cam ended 2" then
      Commentary.OverrideZapTransition(true)
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_2", function()
        Commentary.OverrideZapTransition(false)
      end, "missionCritical")
    elseif task.specialName == "Head On Collision" then
      if conditionKey == 2 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_7A")
      elseif conditionKey == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_11")
      end
    elseif task.specialName == "Are we being chased" then
      if conditionKey == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_6")
      elseif conditionKey == 2 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_5")
      elseif conditionKey == 3 then
        OneShotSound.Play("HUD_Play_Waypoint")
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_7")
      elseif conditionKey == 6 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP06_ZAP_6", nil, "missionCritical")
      end
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "Trigger Initial Speech" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_1")
      elseif task.specialName == "Stop In Hotspot" then
        OneShotSound.Play("HUD_Play_Waypoint")
        feedbackSystem.eventFeedback(task.agent, "PIP01")
      elseif task.specialName == "Stop In Hotspot 2" or task.specialName == "Entered alley with cops" then
        OneShotSound.Play("HUD_Play_Waypoint")
      elseif task.specialName == "Kill driftscore sound" then
        Sound.EnableScoring("drift", false)
      elseif task.specialName == "Trigger Icam" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_5")
      elseif task.specialName == "Finish Icam2" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4")
      elseif task.specialName == "Have we jumped" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_8")
      end
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
