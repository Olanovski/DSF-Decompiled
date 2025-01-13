feedbackSystem.registerAudioPIP("Wrecked evidence APIP", function(task)
  if task.specialName == "Add Spoolcenter To Truck" then
    feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_4", nil, "missionCritical")
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Player Zapped Out Of Truck" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1", nil, "missionCritical")
    elseif task.specialName == "Near to Mission TowTruck" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_2", nil, "missionCritical")
    elseif task.specialName == "Audio - Play chatter" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_1", nil, "missionCritical")
    elseif task.specialName == "Audio - Play waiting for" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_3", nil, "missionCritical")
    elseif task.specialName == "Player has Zapped Out - Goon" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP02_ZAP_1", nil, "missionCritical")
    elseif task.specialName == "Has Player Zapped 2" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP03_ZAP_1", nil, "missionCritical")
    end
  end
  local function taskComplete(taskConditionKey)
    if task.success then
      if task.specialName == "Spawn 1st Attackers Pt 2" and task.instance.taskObjectsByActorID["Tow Truck"] and localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Tow Truck"].coreData.agent then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_4", nil, "queued")
      elseif task.specialName == "Audio - Play locked in" and task.instance.taskObjectsByActorID["Tow Truck"] and localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Tow Truck"].coreData.agent then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_L_3", nil, "missionCritical")
      elseif task.specialName == "Audio - Play PIP02" then
        local function onPIPEnd()
          if task.instance.taskObjectsByActorID["Tow Truck"] and localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Tow Truck"].coreData.agent then
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_2", nil, "missionCritical")
          end
        end
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP02", onPIPEnd, "missionCritical")
      end
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
