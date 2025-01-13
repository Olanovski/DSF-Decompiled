feedbackSystem.registerAudioPIP("Kill Tanner APIP", function(task)
  local checkpointNum = 0
  local playCount = 0
  local function goalComplete(conditionKey)
    if task.specialName == "Drive route" then
      checkpointNum = checkpointNum + 1
      if checkpointNum == 1 then
        moodSystem.removeMood("Kill Tanner", 5)
      elseif checkpointNum == 2 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_6")
      elseif checkpointNum == 5 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_7")
      elseif checkpointNum == 3 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_8")
      end
    elseif task.specialName == "Zap attempt2" and playCount < 2 then
      local played = feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_3")
      if played then
        playCount = playCount + 1
      end
    end
  end
  local function taskComplete()
    if task.specialName == "Init audio" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_1", nil, "missionCritical")
    elseif task.specialName == "Init audio ordell" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_1")
    elseif task.specialName == "Close to tanner" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_2")
    elseif task.specialName == "Ordell damaged" or task.specialName == "Ordell damaged2" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_L_3B")
    elseif task.specialName == "Zap attempt1" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_1")
    elseif task.specialName == "Cutscene" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01", function()
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_4")
      end)
      feedbackSystem.startMusic("Uid03330_CH06_Story_TheTarget_Play")
    elseif task.specialName == "Control audio" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_11")
    elseif task.specialName == "Second back seat audio" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_5")
    elseif task.specialName == "Tanner damaged" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_L_3A")
    elseif task.specialName == "Turn off back seat" then
      feedbackSystem.stopMusic("Uid03330_CH06_Story_TheTarget_Stop")
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_10")
    elseif task.specialName == "Drive route" and task.success then
      OneShotSound.Play("LailaSharan_218996_Dial")
      local playAudio = function()
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_9", function()
          OneShotSound.Play("LailaSharan_218996_HangUp")
        end, "missionCritical")
        removeUserUpdateFunction("playAudio")
      end
      addUserUpdateFunction("playAudio", playAudio, 600, true)
    elseif task.specialName == "Play shift audio" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_12")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
