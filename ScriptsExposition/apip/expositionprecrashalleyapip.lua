feedbackSystem.registerAudioPIP("Exposition post crash jericho chase alley", function(task)
  local function goalComplete(conditionKey)
    print("================================= GOAL COMPLETE : " .. tostring(task.specialName))
    if task.specialName == "Speech and mission complete" then
      if conditionKey == 1 then
        eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_1")
      elseif conditionKey == 2 then
        eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_2")
      end
    elseif task.specialName == "Look behind prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:170895", false, false, false, false, localPlayer.buttonLayout.lookBack, nil, nil)
    end
  end
  local function taskComplete()
    if task.specialName == "Look behind prompt" then
      if feedbackSystem.menusMaster.primaryPromptActive then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      end
    elseif task.specialName == "TannerAtTheEndOfTheAlleyway" then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_3")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
