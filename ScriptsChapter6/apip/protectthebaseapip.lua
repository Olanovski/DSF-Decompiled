feedbackSystem.registerAudioPIP("Protect the base APIP", function(task)
  local shiftOut = "shiftOut"
  local playFirstZapAudio = true
  local function goalComplete(conditionKey)
    if task.specialName == "Audio - Incidental Driveto Speech" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_2", nil, "missionCritical")
    elseif task.specialName == "Play Audio - Shift higher" then
      if playFirstZapAudio then
        feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_R_4", nil, "missionCritical")
        playFirstZapAudio = false
      else
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_4", nil, "missionCritical")
      end
    elseif task.specialName == "Attacker Hits Prison Van" and conditionKey == 1 then
      if task.instance.taskObjectsByActorID.MoneyTruck.coreData.agent.damage < 0.3 then
        feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_3A", nil, "missionCritical")
      elseif task.instance.taskObjectsByActorID.MoneyTruck.coreData.agent.damage >= 0.3 and task.instance.taskObjectsByActorID.MoneyTruck.coreData.agent.damage <= 0.59 then
        feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_3B", nil, "missionCritical")
      elseif task.instance.taskObjectsByActorID.MoneyTruck.coreData.agent.damage >= 0.6 and task.instance.taskObjectsByActorID.MoneyTruck.coreData.agent.damage <= 0.99 then
        feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_L_3C", nil, "missionCritical")
      end
    end
  end
  local function taskComplete(conditionKey)
    if task.specialName == "Trigger PIP01" then
      if localPlayer.currentVehicle and localPlayer.currentVehicle == task.instance.taskObjectsByActorID.MoneyTruck.coreData.agent and not localPlayer.inZap then
        feedbackSystem.eventFeedback(task.agent, "PIP06", nil, "missionCritical")
      end
    elseif task.specialName == "Audio - Whipped Speech Speech" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_1", nil, "missionCritical")
    elseif task.specialName == "Trigger Messages" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_R_1", nil, "missionCritical")
    end
  end
  local cleanup = function()
  end
  return nil, goalComplete, taskComplete, nil
end)
