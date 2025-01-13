local targetDisplaySpeed, targetSpeed = feedbackSystem.mphToLocalisedSpeed(60)
feedbackSystem.registerHUD("FinalDestination hud", function(task, settings)
end, function(task, settings)
  local dangerBar = {
    slot = 1,
    title = "ID:186204",
    barTitle = "ID:186205",
    value = 0
  }
  local bombMarkers = false
  local playing25 = false
  local playing50 = false
  local playing75 = false
  local playing100 = false
  local under50Prompt = false
  local defuseBarParams = {
    barText = "ID:186259",
    barIcon = iconsTable.c4Smash,
    barPass = false,
    barValue = 0
  }
  local defuseBarOn = false
  local speedoFlashingState = 0
  local promptStartTime = 0
  local stuntFeedback
  local highlightVehicles = {
    {VehicleModelUID = 187},
    {VehicleModelUID = 165},
    {VehicleModelUID = 134},
    {VehicleModelUID = 274},
    {VehicleModelUID = 194},
    {VehicleModelUID = 242},
    {VehicleModelUID = 207},
    {VehicleModelUID = 269},
    {VehicleModelUID = 272},
    {VehicleModelUID = 271}
  }
  if task.specialName == "bomb ticking" then
    bombMarkers = feedbackSystem.newTarget(task.agent, "Drive under truck markers")
    feedbackSystem.updateDangerBar(dangerBar)
    minimap.AddHighlightedVehicleModelUIDs(highlightVehicles)
    minimap.SetHighlightedVehicles(true)
  elseif task.specialName == "speed check" then
    stuntFeedback = {
      stuntText = "ID:242735",
      stuntFail = true,
      stuntSlotPass = nil,
      stuntHide = true
    }
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
      if task.specialName == "speed check" and not task.complete then
        local playerSpeed = task.agent.gameVehicle.displayedSpeed
        local playerSpeedInMph = math.floor(playerSpeed * 2.236)
        if playerSpeedInMph < targetSpeed then
          if task.agent.controlled then
            if not task.instance.turnOffPrompt and under50Prompt then
              if promptStartTime == 0 then
                promptStartTime = g_NetworkTime
              elseif g_NetworkTime - promptStartTime >= 2.5 and g_NetworkTime - promptStartTime < 2.8 and feedbackSystem.menusMaster.primaryPromptActive then
                feedbackSystem.menusMaster.clearPrimaryTextPrompt()
              elseif g_NetworkTime - promptStartTime > 2.8 then
                if speedoFlashingState == 0 then
                  stuntFeedback.stuntHide = false
                  stuntFeedback.stuntTextValue = feedbackSystem.localiseSpeedFromMetersASecond(playerSpeed)
                  feedbackSystem.updateStuntFeedback(stuntFeedback)
                  speedoFlashingState = speedoFlashingState + 1
                elseif speedoFlashingState == 1 or speedoFlashingState == 2 then
                  stuntFeedback.stuntTextValue = feedbackSystem.localiseSpeedFromMetersASecond(playerSpeed)
                  feedbackSystem.updateStuntFeedback(stuntFeedback)
                  speedoFlashingState = speedoFlashingState + 1
                elseif speedoFlashingState == 3 then
                  stuntFeedback.stuntHide = true
                  feedbackSystem.updateStuntFeedback(stuntFeedback)
                  speedoFlashingState = 0
                end
              end
            elseif promptStartTime > 0 then
              promptStartTime = 0
              stuntFeedback.stuntHide = true
              feedbackSystem.updateStuntFeedback(stuntFeedback)
              speedoFlashingState = 0
            end
          elseif not stuntFeedback.stuntHide then
            stuntFeedback.stuntHide = true
            feedbackSystem.updateStuntFeedback(stuntFeedback)
            speedoFlashingState = 0
          end
        elseif promptStartTime > 0 then
          promptStartTime = 0
          stuntFeedback.stuntHide = true
          feedbackSystem.updateStuntFeedback(stuntFeedback)
          speedoFlashingState = 0
        end
      elseif task.specialName == "payload task 1" then
        dangerBar.value = task.networkVars.payload or 0
        feedbackSystem.updateDangerBar(dangerBar)
      elseif task.specialName == "bomb ticking" then
        if task.goalFeedback.Time and 0 < task.goalFeedback.Time and 1 > task.agent.damage then
          if not defuseBarOn then
            defuseBarOn = true
            defuseBarParams.barHide = false
          end
          defuseBarParams.barValue = 50 * task.goalFeedback.Time
          feedbackSystem.updateBarFeedback(defuseBarParams)
        else
          if defuseBarOn then
            defuseBarParams.barHide = true
            defuseBarOn = false
            feedbackSystem.updateBarFeedback(defuseBarParams)
          end
          defuseBarParams.barValue = 0
        end
      elseif task.specialName == "Final payload" then
        dangerBar.value = task.networkVars.payload
        feedbackSystem.updateDangerBar(dangerBar)
      end
      if task.specialName == "payload task 1" or task.specialName == "Final payload" then
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
          playing100 = true
          OneShotSound.Play("Mis_Bomb_Beep_100_Play")
        end
      end
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Mission start" then
      local prompt = {
        prompt = "ID:245540",
        delay = true,
        priority = 1
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    elseif task.specialName == "speed check" then
      if not task.instance.turnOffPrompt then
        if conditionKey == 1 then
          feedbackSystem.menusMaster.clearPrimaryTextPrompt()
          under50Prompt = false
        elseif conditionKey == 2 then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:231516", targetDisplaySpeed, false, false, false)
          under50Prompt = true
        end
      elseif task.instance.turnOffPrompt then
        under50Prompt = false
      end
    elseif task.specialName == "In small civilian" then
      if minimap.GetHighlightedVehicles() then
        minimap.RemoveAllHighlightedVehicleModelUIDs()
        minimap.SetHighlightedVehicles(false)
      end
      local prompt = {prompt = "ID:186118", priority = 2}
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    elseif task.specialName == "In shift" then
      minimap.AddHighlightedVehicleModelUIDs(highlightVehicles)
      minimap.SetHighlightedVehicles(true)
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    end
  end
  local function taskComplete()
    if task.specialName == "bomb ticking" and not task.success then
      minimap.RemoveAllHighlightedVehicleModelUIDs()
      localPlayer.minimapSupport.highlightedVehicles = false
      defuseBarParams.barHide = true
      feedbackSystem.updateBarFeedback(defuseBarParams)
    elseif task.specialName == "Final payload" then
      minimap.RemoveAllHighlightedVehicleModelUIDs()
      localPlayer.minimapSupport.highlightedVehicles = false
      defuseBarParams.barHide = true
      feedbackSystem.updateBarFeedback(defuseBarParams)
    elseif task.specialName == "payload task 1" then
      stopSoundEffect()
    elseif task.specialName == "Almost at alley" then
      task.instance.turnOffPrompt = true
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    elseif task.specialName == "Find a car text prompt" then
      local prompt = {prompt = "ID:186117", priority = 1}
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    end
  end
  local function cleanup()
    if bombMarkers then
      feedbackSystem.clearTarget(bombMarkers)
      bombMarkers = false
    end
    if defuseBarOn then
      defuseBarParams.barHide = true
      feedbackSystem.updateBarFeedback(defuseBarParams)
    end
    if stuntFeedback then
      stuntFeedback.stuntHide = true
      feedbackSystem.updateStuntFeedback(stuntFeedback)
    end
    stopSoundEffect()
  end
  return update, goalComplete, taskComplete, cleanup
end)
