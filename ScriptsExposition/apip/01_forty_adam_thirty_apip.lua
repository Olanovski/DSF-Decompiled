feedbackSystem.registerAudioPIP("Exposition pre crash drive", function(task)
  local function goalComplete(conditionKey)
    if string.find(task.specialName, "missionSpeechTrigger") then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_1")
    elseif string.find(task.specialName, "idle") then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_2A")
    elseif string.find(task.specialName, "Filler speech") then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_3")
    elseif string.find(task.specialName, "driveToLocation") or task.specialName == "Main task" or task.specialName == "Alternative driveToLocation01 trigger" then
      OneShotSound.Play("HUD_Play_Waypoint")
    end
  end
  local function taskComplete()
    if task.specialName == "PIP 01 trigger" then
      eventFeedback(localPlayer.currentVehicle, "PIP01")
    elseif string.find(task.specialName, "idle") then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_2A")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
