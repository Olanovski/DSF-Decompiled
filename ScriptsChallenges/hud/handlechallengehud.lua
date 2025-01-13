local targetDisplaySpeed, targetSpeed = feedbackSystem.mphToLocalisedSpeed(70)
feedbackSystem.registerHUD("Handle challenge hud", function(task, settings)
end, function(task, settings)
  local timer = {slot = 1}
  local scoreBar = {
    slot = 3,
    title = "ID:186204",
    barTitle = "ID:186205",
    value = 0
  }
  local stuntFeedback = {
    stuntText = "ID:242735",
    stuntFail = true,
    stuntSlotPass = nil,
    stuntHide = true
  }
  local instance = task.instance
  local playing25 = false
  local playing50 = false
  local playing75 = false
  local playing100 = false
  local under70Prompt = false
  local countdownStarted = false
  local promptStartTime = false
  local speedoPrompt = false
  feedbackSystem.updateDangerBar(scoreBar)
  local taskObject = task.agent:getTaskObject()
  local currentPayload
  if task.specialName == "Slow start" then
    scoreBar.slot = 3
  end
  local function stopSoundEffect()
    if playing25 then
      OneShotSound.Play("Mis_Bomb_Beep_25_Stop")
      playing25 = false
    elseif playing50 then
      OneShotSound.Play("Mis_Bomb_Beep_50_Stop")
      playing50 = false
    elseif playing75 then
      OneShotSound.Play("Mis_Bomb_Beep_75_Stop")
      playing75 = false
    elseif playing100 then
      OneShotSound.Play("Mis_Bomb_Beep_100_Stop")
      playing100 = false
    end
  end
  local function update()
    if not gameStatus.simulationPaused then
      if task.specialName == "Wait for countdown" then
        if not countdownStarted then
          feedbackSystem.menusMaster.singlePlayer321Countdown()
          countdownStarted = true
        end
      else
        if instance.challenge.goalValues["Time limit"] then
          timer.startTime = instance.challenge.goalValues["Time limit"]
          feedbackSystem.stepTimer(timer)
        else
          feedbackSystem.stepTimer(timer)
        end
        if speedoPrompt then
          if g_NetworkTime - promptStartTime >= 0.5 then
            if stuntFeedback.stuntHide then
              stuntFeedback.stuntHide = false
            else
              stuntFeedback.stuntHide = true
            end
            promptStartTime = g_NetworkTime
          end
          stuntFeedback.stuntTextValue = feedbackSystem.localiseSpeedFromMetersASecond(task.agent.gameVehicle.displayedSpeed)
          feedbackSystem.updateStuntFeedback(stuntFeedback)
        end
        if task.specialName == "Slow start" or task.specialName == "payload task 1" then
          scoreBar.value = task.networkVars.payload or 0
          feedbackSystem.updateDangerBar(scoreBar)
        elseif task.specialName == "Payload Tracking With Multiplyer" then
          scoreBar.value = task.networkVars.payload
          feedbackSystem.updateDangerBar(scoreBar)
        end
        if task.specialName == "payload task 1" then
          if task.networkVars.payload < 25 and not playing25 then
            stopSoundEffect()
            OneShotSound.Play("Mis_Bomb_Beep_25_Play")
            playing25 = true
          elseif task.networkVars.payload < 50 and task.networkVars.payload > 25 and not playing50 then
            stopSoundEffect()
            OneShotSound.Play("Mis_Bomb_Beep_50_Play")
            playing50 = true
          elseif task.networkVars.payload < 75 and task.networkVars.payload > 50 and not playing75 then
            stopSoundEffect()
            OneShotSound.Play("Mis_Bomb_Beep_75_Play")
            playing75 = true
          elseif task.networkVars.payload <= 100 and task.networkVars.payload > 75 and not playing100 then
            stopSoundEffect()
            OneShotSound.Play("Mis_Bomb_Beep_100_Play")
            playing100 = true
          end
        end
      end
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "speed check" then
      if conditionKey == 1 and under70Prompt then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        if speedoPrompt then
          stuntFeedback.stuntHide = true
          feedbackSystem.updateStuntFeedback(stuntFeedback)
          speedoPrompt = false
        end
        under70Prompt = false
      elseif conditionKey == 2 and not under70Prompt then
        feedbackSystem.menusMaster.primaryTextPromptParam({
          prompt = "ID:234231",
          value = targetDisplaySpeed,
          priority = 2
        })
        under70Prompt = true
      elseif conditionKey == 3 then
        speedoPrompt = true
        promptStartTime = g_NetworkTime
        stuntFeedback.stuntTextValue = feedbackSystem.localiseSpeedFromMetersASecond(task.agent.gameVehicle.displayedSpeed)
        stuntFeedback.stuntHide = false
        feedbackSystem.updateStuntFeedback(stuntFeedback)
      end
    end
  end
  local function taskComplete()
    if task.specialName == "bomb ticking" and not task.success then
      minimap.RemoveAllHighlightedVehicleModelUIDs()
      minimap.highlightedVehicles = false
    elseif task.specialName == "payload task 1" then
      stopSoundEffect()
    end
  end
  local function cleanup()
    stopSoundEffect()
  end
  return update, goalComplete, taskComplete, cleanup
end)
