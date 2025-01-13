feedbackSystem.registerAudioPIP("Gone in 59 seconds APIP", function(task)
  if task.specialName == "first second" then
    feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_1")
  end
  local function goalComplete(conditionKey)
    if task.specialName == "damage" and task.actor.ID ~= "Hot Car 2" then
      if conditionKey == 1 and task.agent.damage < 0.6 then
        if task.actor.ID == "Hot Car 1" then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_2A")
        elseif task.actor.ID == "Hot Car 3" then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP02")
        elseif task.actor.ID == "Hot Car 4" then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_R_2A")
        end
      elseif conditionKey == 2 then
        if task.actor.ID == "Hot Car 1" then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_2B")
        elseif task.actor.ID == "Hot Car 3" then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV05_SEQUENCE_R_2B")
        elseif task.actor.ID == "Hot Car 4" then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_R_2B")
        end
      end
    elseif task.specialName == "damage for damaged car" and task.actor.ID == "Hot Car 2" then
      if conditionKey == 1 and task.agent.damage < 0.95 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV04_SEQUENCE_R_2B")
      elseif conditionKey == 2 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01")
      end
    elseif task.specialName == "Do nothing" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_3")
    elseif task.specialName == "hot car task" and conditionKey == 3 then
      local delayAudioTime = g_NetworkTime
      removeUserUpdateFunction("inTruckCheck")
      addUserUpdateFunction("inTruckCheck", function()
        if g_NetworkTime - delayAudioTime > 1.5 and not task.agent.inTrailer then
          if task.actor.ID == "Hot Car 4" then
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_3")
          elseif task.actor.ID == "Hot Car 3" then
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV05_SEQUENCE_3")
          elseif task.actor.ID == "Hot Car 2" then
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV04_SEQUENCE_3")
          elseif task.actor.ID == "Hot Car 1" then
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_3")
          end
          removeUserUpdateFunction("inTruckCheck")
        elseif task.agent.inTrailer then
          removeUserUpdateFunction("inTruckCheck")
        end
      end, 1)
    end
  end
  local function taskComplete()
    if task.specialName == "first second" then
      if not localPlayer.inZap then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_2")
      else
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1")
      end
    elseif task.specialName == "one third through" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_1")
    elseif task.specialName == "two third through" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_2")
    elseif task.specialName == "zapped in to vehicle" then
      if task.actor.ID == "Hot Car 1" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_1")
      elseif task.actor.ID == "Hot Car 2" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV04_SEQUENCE_1")
      elseif task.actor.ID == "Hot Car 3" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV05_SEQUENCE_1A")
      elseif task.actor.ID == "Hot Car 4" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_1")
      end
    elseif task.specialName == "Driving away" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV05_SEQUENCE_1A")
    elseif task.specialName == "Hit by goon" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV05_SEQUENCE_Play")
    elseif task.specialName == "hot car task" then
      if task.instance.recoveredCars == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_2")
      elseif task.instance.recoveredCars == 2 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_3")
      elseif task.instance.recoveredCars == 3 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_4")
      end
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
