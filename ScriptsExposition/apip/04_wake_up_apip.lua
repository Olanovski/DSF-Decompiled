feedbackSystem.registerAudioPIP("Exposition post crash jericho chase", function(task)
  local quickFixToTriggerSpeech = function()
    eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_7")
  end
  local function speechComplete()
    if task.agent then
      localPlayer:zapToAgent(task.agent, {disableZapFlash = true})
      zapcontroller.OverrideZAPCoronaType(NoShiftCorona, 0.1, localPlayer.localID)
      zapcontroller.ResetCoronaOverride(localPlayer.localID)
      localPlayer:exitCutsceneMode()
      zapcontroller.ZapSettings(1, {CanSelectVehicles = true})
      zapcontroller.setRenderTarget(true, localPlayer.localID)
      localPlayer.simulationSupport.doWait(1.5, quickFixToTriggerSpeech)
    end
  end
  local function speechTrigger()
    if zapcontroller.getZapLevel() == 1 and not localPlayer.zapTransition then
      removeUserUpdateFunction("speechTrigger")
      eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_6", speechComplete)
      zapcontroller.setZapSlowMotionMultiplier(0.01)
    end
  end
  function shiftEvent()
    zapcontroller.EnableZapInput(false, localPlayer.localID)
    zapcontroller.setRenderTarget(false, localPlayer.localID)
    zapcontroller.ZapSettings(1, {CanSelectVehicles = false})
    localPlayer:SetZapLevel(1)
    zapcontroller.setZapSlowMotionMultiplier(0.01)
    zapcontroller.ZapCameraSetCatchupFactor(localPlayer.localID, 0.001)
    zapcontroller.OverrideZAPCoronaType(GameShiftCorona2, 0.1, localPlayer.localID)
    zapcontroller.ResetCoronaOverride(localPlayer.localID)
    addUserUpdateFunction("speechTrigger", speechTrigger, 4)
  end
  local musicTrigger = function()
    feedbackSystem.startMusic("Uid00247_Exp_WakeUp_Play")
  end
  local function commitShift()
    shiftEvent()
    localPlayer:enterCutsceneMode()
    task.instance.shiftEventTriggered = true
  end
  local function triggerNextSequence()
    eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_8", commitShift, nil)
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Speech trigger" or task.specialName == "Tanner 2nd Task" then
      if conditionKey == 1 and not task.instance.sample01played then
        eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_2", musicTrigger, nil)
      elseif conditionKey == 2 and not task.instance.sample02played and not task.instance.shiftEventTriggered then
        eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_3", triggerNextSequence, nil)
        task.instance.sample02played = true
      end
    end
  end
  local function taskComplete()
    if task.specialName == "Objective Prompt" then
      eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_1")
    end
  end
  local cleanup = function()
    if userUpdateFunctions.speechTrigger then
      removeUserUpdateFunction("speechTrigger")
    end
  end
  return nil, goalComplete, taskComplete, cleanup
end)
