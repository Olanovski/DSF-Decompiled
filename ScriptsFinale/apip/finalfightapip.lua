feedbackSystem.registerAudioPIP("Final Fight APIP", function(task)
  local firstCivPIPplayed = false
  local firstTannerPIPplayed = false
  local secondTannerPIPplayed = false
  local losingAudioTriggered = false
  local allPIPsPlayed = false
  local hitByACivOnce = false
  local function goalComplete(conditionKey)
    if task.specialName == "chase jericho" then
      if conditionKey == 2 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_1", nil, "missionCritical")
      end
    elseif task.specialName == "Ram jericho" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_2A", nil, "missionCritical")
    elseif task.specialName == "Tanner health" then
      if conditionKey == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4A", nil, "missionCritical")
      elseif conditionKey == 2 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4B", nil, "missionCritical")
      elseif conditionKey == 3 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4C", nil, "missionCritical")
      elseif conditionKey == 4 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_4A", nil, "missionCritical")
      end
    elseif task.specialName == "In civilian or tanner" then
      if conditionKey == 1 then
        if not firstCivPIPplayed then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP07", nil, "missionCritical")
          firstCivPIPplayed = true
        elseif secondTannerPIPplayed and localPlayer.currentVehicle and 2 < localPlayer.currentVehicle.gameVehicle.height then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_5", nil, "missionCritical")
        elseif allPIPsPlayed then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_9", nil, "missionCritical")
        end
      elseif conditionKey == 2 then
        if firstCivPIPplayed and not firstTannerPIPplayed then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP11", nil, "missionCritical")
          firstTannerPIPplayed = true
        elseif firstTannerPIPplayed and not secondTannerPIPplayed then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP08", nil, "missionCritical")
          secondTannerPIPplayed = true
        elseif secondTannerPIPplayed and not allPIPsPlayed then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP10", nil, "missionCritical")
          allPIPsPlayed = true
        elseif allPIPsPlayed then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_14", nil, "missionCritical")
        end
      elseif conditionKey == 3 and secondTannerPIPplayed then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_5", nil, "missionCritical")
      end
    elseif task.specialName == "jericho radius warning" then
      if conditionKey == 1 and not losingAudioTriggered then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_6A", nil, "missionCritical")
        losingAudioTriggered = true
      elseif conditionKey == 2 and losingAudioTriggered then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_6B", nil, "missionCritical")
        losingAudioTriggered = false
      elseif conditionKey == 3 and not losingAudioTriggered then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_6A", nil, "missionCritical")
        losingAudioTriggered = true
      end
    elseif task.specialName == "Voices in my head possessed civs" and conditionKey == 2 then
      if not hitByACivOnce then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_2", nil, "missionCritical")
        hitByACivOnce = true
      elseif hitByACivOnce then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_2B", nil, "missionCritical")
      end
    elseif task.specialName == "Still in Tanner not hurting Jericho" then
      if conditionKey == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_7A", nil, "missionCritical")
      end
    elseif task.specialName == "In zap" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1", nil, "missionCritical")
    end
  end
  local function taskComplete()
    if task.specialName == "Objective prompt & initial speech sample" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_10", nil, "missionCritical")
    elseif task.specialName == "Top Zap" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_15", nil, "missionCritical")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
