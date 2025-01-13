module("raceManager", package.seeall)
wrongWayPromptActive = false
offRoutePromptActive = false
function checkpointCallback(racerGameVehicle, checkpointNumber)
  local vehicleAgent = vehicleManager.vehiclesByGameVehicle[racerGameVehicle]
  if vehicleAgent then
    vehicleAgent.nextCheckpointReached = true
  end
end
function wrongWayCallback(wrongWay)
  if wrongWay then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:242924", nil, nil, true)
    OneShotSound.Play("HUD_Reminder_Prompt_OneShot", false)
    wrongWayPromptActive = true
    feedbackSystem.updateSplitTime()
    feedbackSystem.updateStuntFeedback()
  else
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    wrongWayPromptActive = false
  end
end
function offRouteCallback(offRoute)
  if offRoute then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:242925", nil, nil, true)
    OneShotSound.Play("HUD_Reminder_Prompt_OneShot", false)
    offRoutePromptActive = true
    feedbackSystem.updateSplitTime()
    feedbackSystem.updateStuntFeedback()
  else
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    offRoutePromptActive = false
  end
end
