feedbackSystem.registerAudioPIP("Exposition ambulance", function(task)
  local function goalComplete(conditionKey)
    if task.specialName == "idle" then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_4B")
    elseif task.specialName == "Wrong way" then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_4A")
    elseif task.specialName == "payload" and conditionKey == 3 then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_4C")
    elseif task.specialName == "payload" and conditionKey == 4 then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_4D")
    elseif task.specialName == "PlayerAtTheHosptial" then
      OneShotSound.Play("HUD_Play_Waypoint")
    end
  end
  local function taskComplete()
    if task.specialName == "Main speech 01" then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_1")
    elseif task.specialName == "Speed 01 is this really happening" then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_2")
    elseif task.specialName == "PlayerOnRoute" then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_3")
    elseif task.specialName == "PIP" then
      eventFeedback(localPlayer.currentVehicle, "PIP01")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
