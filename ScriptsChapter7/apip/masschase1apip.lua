feedbackSystem.registerAudioPIP("Mass Chase APIP", function(task)
  local hasJustHitCop, losingCops
  if task.specialName == "Audio - Guardian angel 1" or task.specialName == "Audio - Guardian angel 2" or task.specialName == "Audio - Guardian angel 3" then
    hasJustHitCop = false
  elseif task.specialName == "Audio - Fighting the cops 1" or task.specialName == "Audio - Fighting the cops 2" or task.specialName == "Audio - Fighting the cops 3" then
    losingCops = false
  end
  local function tooLate()
    hasJustHitCop = false
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Audio - To the first waypoint chat" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_2")
    elseif task.specialName == "Audio - To the second waypoint chat" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_4")
    elseif task.specialName == "Audio - Hurry up" and not task.instance.blockHurryAudio then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_6A", nil, "queued")
    elseif task.specialName == "Audio - Hurry up reminder" and not task.instance.blockHurryAudio then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_6B")
    elseif task.specialName == "Audio - Fighting the cops 1" or task.specialName == "Audio - Fighting the cops 2" or task.specialName == "Audio - Fighting the cops 3" then
      if conditionKey == 1 and not losingCops then
        losingCops = true
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_8A", nil, "timeSensitive")
      elseif conditionKey == 2 and losingCops then
        losingCops = false
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_8B", nil, "timeSensitive")
      elseif conditionKey == 3 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_10", nil, "timeSensitive")
      end
    elseif task.specialName == "Audio - Player enters shift 1" or task.specialName == "Audio - Player enters shift 2" then
      feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_L_1")
    elseif task.specialName == "Audio - Player enters shift 3" then
      feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_L_2")
    elseif task.specialName == "Audio - Hit a cop 1" or task.specialName == "Audio - Hit a cop 2" or task.specialName == "Audio - Hit a cop 3" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_9B", nil, "timeSensitive")
    elseif task.specialName == "Audio - Hit by cop 1" or task.specialName == "Audio - Hit by cop 2" or task.specialName == "Audio - Hit by cop 3" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_9A", nil, "timeSensitive")
    elseif task.specialName == "Audio - Guardian angel 1" or task.specialName == "Audio - Guardian angel 2" or task.specialName == "Audio - Guardian angel 3" then
      if conditionKey == 1 then
        hasJustHitCop = true
        removeUserUpdateFunction("shiftBackWait")
        localPlayer.simulationSupport.doWait(3, tooLate, "shiftBackWait")
      elseif hasJustHitCop then
        Commentary.StopCommentary()
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_9C")
        removeUserUpdateFunction("shiftBackWait")
      end
    elseif task.specialName == "Chase" then
      if conditionKey == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_11", nil, "queued")
        task.instance.blockHurryAudio = true
      elseif conditionKey == 2 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_5B", nil, "queued")
      end
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "Audio - First speech" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_1")
      elseif task.specialName == "Second PiP" then
        local function pipCallback()
          if not task.instance.taskObjectsByActorID.Truck then
            local prompt = {
              prompt = "ID:245542",
              delay = true,
              delayTime = 1,
              priority = 1
            }
            feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
            feedbackSystem.menusMaster.setCurrentFocusString(4)
          end
        end
        feedbackSystem.eventFeedback(task.agent, "PIP02", pipCallback)
      elseif task.specialName == "Start the music" then
        feedbackSystem.startMusic("Uid02821_CH05_Standard_IDidItForYou_Play")
      end
    end
  end
  local cleanup = function()
    removeUserUpdateFunction("shiftBackWait")
  end
  return nil, goalComplete, taskComplete, cleanup
end)
