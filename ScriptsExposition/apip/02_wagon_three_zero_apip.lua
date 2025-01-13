feedbackSystem.registerAudioPIP("Exposition pre crash jericho chase", function(task)
  local function goalComplete(conditionKey)
    if string.find(task.specialName, "idle message") then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_4A")
    elseif task.specialName == "TannerAtTheAlleyway" then
      OneShotSound.Play("HUD_Play_Waypoint")
    end
  end
  local function taskComplete()
    if task.specialName == "PIP 01 trigger" then
      eventFeedback(localPlayer.currentVehicle, "PIP01")
    elseif task.specialName == "Player near alley 02" then
      eventFeedback(localPlayer.currentVehicle, "PIP02")
      feedbackSystem.stopMusic("Uid04855_Exp_WagonThreeZero_Stop")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
