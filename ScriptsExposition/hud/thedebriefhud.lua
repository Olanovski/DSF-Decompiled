feedbackSystem.registerHUD("The debrief hud", function(task, settings)
end, function(task, settings)
  local function goalComplete(conditionKey)
    if task.specialName == "Mission speech" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_1")
    elseif task.specialName == "Tanner drives to location" and conditionKey == 3 then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_1")
    end
  end
  local function taskComplete()
    if task.specialName == "Objective prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245514", false, false, false, false)
    elseif task.specialName == "PIP 01 trigger" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01")
    elseif task.specialName == "Tanner drives to location" or task.specialName == "Tanner drives to half way" then
      OneShotSound.Play("HUD_Play_Waypoint")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
