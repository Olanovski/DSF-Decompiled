local showEnemyCount = 0
local killEnemyCount = 0
feedbackSystem.registerAudioPIP("Felony Lure APIP", function(task)
  local played42 = false
  local played70 = false
  local setToPlay80 = false
  local time1Sample = false
  local time2Sample = false
  local zapAudioBlocked = false
  local function update()
    if localPlayer.inZap and not zapAudioBlocked and not didRecentAudio(2) then
      feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_L_1")
      zapAudioBlocked = true
    end
    if task.specialName == "Use alleys" then
      if task.networkVars.payload >= 42 and not played42 and task.networkVars.payload < 70 then
        if not isEventActive() then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_9")
        end
        played42 = true
      elseif task.networkVars.payload < 42 and played42 then
        played42 = false
      end
      if task.networkVars.payload >= 70 and not played70 then
        if not isEventActive() then
          played70 = true
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_10")
        end
      elseif task.networkVars.payload >= 80 and not setToPlay80 then
        setToPlay80 = true
      elseif task.networkVars.payload < 80 and setToPlay80 then
        setToPlay80 = false
        if not isEventActive() then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_11")
        end
      elseif task.networkVars.payload < 70 and played70 then
        played70 = false
      end
    elseif task.specialName == "Player lures cops to the kidnapper" and task.agent.controlled then
      if task.goalFeedback.Time and task.goalFeedback.Time > 60 and not time1Sample then
        local chasers = Getaway.NumberOfChasers(localPlayer.currentVehicle.gameVehicle)
        if chasers >= 3 then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_15A")
        else
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_15B")
        end
        time1Sample = true
      elseif task.goalFeedback.Time and task.goalFeedback.Time > 120 and not time2Sample then
        local chasers = Getaway.NumberOfChasers(localPlayer.currentVehicle.gameVehicle)
        if chasers >= 3 then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_16A")
        else
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_16B")
        end
        time2Sample = true
      end
    end
  end
  local function exitCutSceneMode()
    localPlayer:exitCutsceneMode()
    localPlayer:resetCameraMode()
    task.agent:unlockEmergencyBrakes()
    localPlayer.inCutsceneOrIcam = false
  end
  local function triggerIcam()
    task.agent:lockEmergencyBrakes(1)
    feedbackSystem.eventFeedback(task.agent, "PIP03", exitCutSceneMode)
    localPlayer.cameraSupport.miniSceneCamera()
  end
  local function triggerSecondIcam()
    task.agent:lockEmergencyBrakes(1)
    feedbackSystem.eventFeedback(task.agent, "PIP02", exitCutSceneMode)
    localPlayer.cameraSupport.miniSceneCamera()
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Fail to meet point C criteria" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_6B")
    elseif task.specialName == "Destination A" then
    elseif task.specialName == "Turn the player part 1" then
      localPlayer:enterCutsceneMode()
      if conditionKey == 1 then
        local matrix = alignMatrix(vec.vector(-93.83453, 30.69354, 936.0621, 1), -0.8286089)
        localPlayer.currentVehicle:teleportToMatrix(matrix, nil, function()
          triggerIcam()
          localPlayer.inCutsceneOrIcam = true
        end, nil, true)
      else
        triggerIcam()
        localPlayer.inCutsceneOrIcam = true
      end
    elseif task.specialName == "Destination B timed drive through alleyways" then
      OneShotSound.Play("Suspicion_Meter_Stop")
    elseif task.specialName == "Turn the player part 2" then
      localPlayer:enterCutsceneMode()
      if conditionKey == 1 then
        local matrix = alignMatrix(vec.vector(-3343.908, 52.02667, 1400.08, 1), -2.157344)
        localPlayer.currentVehicle:teleportToMatrix(matrix, nil, function()
          triggerSecondIcam()
          localPlayer.inCutsceneOrIcam = true
        end, nil, true)
      else
        triggerSecondIcam()
        localPlayer.inCutsceneOrIcam = true
      end
    elseif task.specialName == "Destination B mission speech triggers" then
      if conditionKey == 1 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_3")
      elseif conditionKey == 2 then
        feedbackSystem.eventFeedback(task.agent, "PIP01")
      elseif conditionKey == 3 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_4")
      elseif conditionKey == 4 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_5")
      elseif conditionKey == 5 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_6")
      elseif conditionKey == 6 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_8")
      end
    elseif task.specialName == "AI drives to kidnapper having too few cops" and conditionKey == 1 then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_17")
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "Start of mission dialogue" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_1")
      elseif task.specialName == "Felony lure section instructions" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_55")
      elseif task.specialName == "Player lures cops to the kidnapper" then
        OneShotSound.Play("HUD_Play_Waypoint")
      end
    end
  end
  return update, goalComplete, taskComplete
end)
