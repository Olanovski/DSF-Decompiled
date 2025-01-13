feedbackSystem.registerHUD("Breaking news hud", function(task, settings)
end, function(task, settings)
  local copCars = {
    267,
    271,
    280,
    269,
    265
  }
  local endTimer, inRadius
  local blockStuntFeedback = false
  local timeSincePreviousReminder, hotspotMarker, jumpMarker, stuntFeedback, updateStuntFeedback
  if settings.showStuntFeedback then
    updateStuntFeedback = false
    stuntFeedback = {
      stuntText = "",
      stuntFail = nil,
      stuntSlotPass = nil,
      stuntHide = true
    }
  end
  local function promptCallback()
    blockStuntFeedback = false
  end
  local promptParams = {
    prompt = "",
    permanent = true,
    priority = 1,
    endCallback = promptCallback
  }
  local showHUD = function(params)
    Sound.ExitAudioState("FilmRolling")
    feedbackSystem.showHUDPanels(true)
    if params then
      feedbackSystem.updateChecklist(params)
    end
  end
  local function failedStunt()
    if g_NetworkTime - endTimer > 2 then
      removeUserUpdateFunction("failedStunt")
      stuntFeedback.stuntHide = true
      feedbackSystem.updateStuntFeedback(stuntFeedback)
    end
  end
  local function showCops()
    for index, modelID in next, copCars, nil do
      local vehicles = {
        {VehicleModelUID = modelID, AllowTowedVehicles = false}
      }
      minimap.AddHighlightedVehicleModelUIDs(vehicles)
    end
    localPlayer.minimapSupport.setHighlightedVehicleModelType("smash")
    minimap.SetHighlightedVehicles(true)
    PatrollingVehicleManager.EnableHud(false)
  end
  local hideCops = function()
    minimap.SetHighlightedVehicles(false)
    minimap.RemoveAllHighlightedVehicleModelUIDs()
    PatrollingVehicleManager.EnableHud(true)
  end
  if task.specialName == "Wait For Zap" then
    feedbackSystem.menusMaster.setCurrentFocusString(9)
    promptParams.prompt = "ID:182582"
    promptParams.icon1 = localPlayer.buttonLayout.enterZap
    promptParams.permanent = false
    feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
  elseif task.specialName == "Speed Past" then
    feedbackSystem.menusMaster.setCurrentFocusString(2)
    promptParams.prompt = "ID:243788"
    promptParams.value = settings.targetDisplaySpeed
    feedbackSystem.updateChecklist({
      slot = 1,
      icon1 = "speed",
      icon1State = 1
    })
    promptParams.permanent = false
    blockStuntFeedback = true
    feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
    stuntFeedback.stuntText = "ID:242735"
    feedbackSystem.menusMaster.blockHintButton(false)
    promptParams.value = nil
  elseif task.specialName == "HandBrake Turn" then
    feedbackSystem.menusMaster.setCurrentFocusString(3)
    promptParams.prompt = "ID:243144"
    feedbackSystem.updateChecklist({
      slot = 1,
      icon2 = "drift",
      icon2State = 1
    })
    promptParams.permanent = false
    blockStuntFeedback = true
    feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
    stuntFeedback.stuntText = "ID:245410"
    feedbackSystem.menusMaster.blockHintButton(false)
  elseif task.specialName == "Head On Collision" then
    feedbackSystem.menusMaster.setCurrentFocusString(4)
    promptParams.prompt = "ID:182588"
    feedbackSystem.updateChecklist({
      slot = 1,
      icon3 = "smash",
      icon3State = 1
    })
    promptParams.permanent = false
    blockStuntFeedback = true
    feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
    feedbackSystem.menusMaster.blockHintButton(false)
  elseif task.specialName == "Get in van" then
    feedbackSystem.removeSlot(1)
    feedbackSystem.removeSlot(2)
  end
  local function update()
    if settings.showStuntFeedback then
      if inRadius then
        if task.specialName == "Speed Past" and localPlayer.currentVehicle then
          local playerSpeed = localPlayer.currentVehicle.gameVehicle.displayedSpeed
          local playerSpeedInMph = math.floor(playerSpeed * 2.236)
          if playerSpeedInMph < settings.speedToHit and not localPlayer.inZap then
            stuntFeedback.stuntTextValue = feedbackSystem.localiseSpeedFromMetersASecond(playerSpeed)
            stuntFeedback.stuntHide = false
            updateStuntFeedback = true
          elseif not stuntFeedback.stuntHide then
            stuntFeedback.stuntHide = true
            updateStuntFeedback = true
          end
        elseif task.specialName == "HandBrake Turn" then
          local activeDrift = localPlayer.scoring:getCurrentDriftDistance()
          if localPlayer.scoring.isDrifting and activeDrift < settings.amountToDrift and not localPlayer.inZap then
            if userUpdateFunctions.failedStunt then
              removeUserUpdateFunction("failedStunt")
            end
            stuntFeedback.stuntFail = false
            stuntFeedback.stuntHide = false
            stuntFeedback.stuntTextValue = activeDrift
            updateStuntFeedback = true
          elseif not localPlayer.scoring.isDrifting and activeDrift < settings.amountToDrift and not stuntFeedback.stuntFail and not stuntFeedback.stuntHide and not localPlayer.inZap then
            stuntFeedback.stuntFail = true
            endTimer = g_NetworkTime
            addUserUpdateFunction("failedStunt", failedStunt, 4)
            updateStuntFeedback = true
          elseif localPlayer.scoring.isDrifting and activeDrift >= settings.amountToDrift and not stuntFeedback.stuntHide or localPlayer.inZap and not stuntFeedback.stuntHide then
            stuntFeedback.stuntHide = true
            updateStuntFeedback = true
          end
        end
      end
      if updateStuntFeedback and not blockStuntFeedback then
        feedbackSystem.updateStuntFeedback(stuntFeedback)
        updateStuntFeedback = false
      end
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Speed Past" or task.specialName == "HandBrake Turn" or task.specialName == "Head On Collision" then
      if conditionKey == 3 then
        if not blockStuntFeedback then
          promptParams.permanent = true
          if task.specialName == "Speed Past" then
            promptParams.prompt = "ID:243788"
            promptParams.value = settings.targetDisplaySpeed
          elseif task.specialName == "HandBrake Turn" then
            promptParams.prompt = "ID:243144"
          elseif task.specialName == "Head On Collision" then
            promptParams.prompt = "ID:182588"
          end
          feedbackSystem.menusMaster.secondaryTextPromptParam(promptParams)
          promptParams.prompt = "ID:243787"
          feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
          promptParams.value = nil
        end
      elseif conditionKey == 4 then
        if not blockStuntFeedback then
          if not timeSincePreviousReminder then
            timeSincePreviousReminder = g_NetworkTime
            feedbackSystem.menusMaster.clearPrimaryTextPrompt()
            feedbackSystem.menusMaster.clearSecondaryTextPrompt()
          elseif timeSincePreviousReminder >= g_NetworkTime - 20 then
            feedbackSystem.menusMaster.clearPrimaryTextPrompt()
            feedbackSystem.menusMaster.clearSecondaryTextPrompt()
          else
            feedbackSystem.menusMaster.clearSecondaryTextPrompt()
            if task.specialName == "Speed Past" then
              promptParams.prompt = "ID:243788"
              promptParams.value = settings.targetDisplaySpeed
            elseif task.specialName == "HandBrake Turn" then
              promptParams.prompt = "ID:243144"
            elseif task.specialName == "Head On Collision" then
              promptParams.prompt = "ID:182588"
            end
            promptParams.permanent = false
            feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
            timeSincePreviousReminder = g_NetworkTime
            promptParams.value = nil
          end
        end
      elseif conditionKey == 5 then
        inRadius = false
        if stuntFeedback.stuntTextValue then
          stuntFeedback.stuntFail = true
          endTimer = g_NetworkTime
          addUserUpdateFunction("failedStunt", failedStunt, 4)
          updateStuntFeedback = true
        end
      elseif conditionKey == 6 then
        if userUpdateFunctions.failedStunt then
          removeUserUpdateFunction("failedStunt")
        end
        stuntFeedback.stuntFail = false
        inRadius = true
      end
    elseif task.specialName == "cam ended 1" then
      stuntFeedback.stuntTextValue = nil
      stuntFeedback.stuntText = "ID:178489"
      stuntFeedback.stuntFail = false
      stuntFeedback.stuntSlotPass = 1
      updateStuntFeedback = true
      showHUD({
        slot = 1,
        icon1 = "speed",
        icon1State = 2,
        audio = 2
      })
    elseif task.specialName == "cam ended 2" then
      stuntFeedback.stuntTextValue = nil
      stuntFeedback.stuntText = "ID:243144"
      stuntFeedback.stuntFail = false
      stuntFeedback.stuntSlotPass = 1
      updateStuntFeedback = true
      showHUD({
        slot = 1,
        icon1 = "speed",
        icon1State = 4,
        icon2 = "drift",
        icon2State = 2,
        audio = 2
      })
    elseif task.specialName == "cam ended 3" then
      stuntFeedback.stuntTextValue = nil
      stuntFeedback.stuntText = "ID:235447"
      stuntFeedback.stuntFail = false
      stuntFeedback.stuntSlotPass = 1
      updateStuntFeedback = true
      showHUD({
        slot = 1,
        icon1 = "speed",
        icon1State = 4,
        icon2 = "drift",
        icon2State = 4,
        icon3 = "smash",
        icon3State = 2,
        audio = 2
      })
    elseif task.specialName == "Show handbrake reminder" then
      promptParams.permanent = false
      promptParams.prompt = "ID:242945"
      feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
    elseif task.specialName == "Are we being chased" then
      if conditionKey == 1 then
        hideCops()
      elseif conditionKey == 2 then
        showCops()
        feedbackSystem.menusMaster.primaryTextPrompt("ID:243188")
        feedbackSystem.menusMaster.setCurrentFocusString(6)
        if hotspotMarker then
          feedbackSystem.clearTarget(hotspotMarker)
          hotspotMarker = nil
        end
        if jumpMarker then
          feedbackSystem.clearTarget(jumpMarker)
          jumpMarker = nil
        end
      elseif conditionKey == 3 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:243149")
        feedbackSystem.menusMaster.setCurrentFocusString(8)
        if hotspotMarker then
          feedbackSystem.clearTarget(hotspotMarker)
          hotspotMarker = nil
        end
        if not jumpMarker then
          jumpMarker = feedbackSystem.newTarget({
            position = settings.jumpAreaPosition
          }, "Radius with hotspot", {
            showInWorld = true,
            terrainMarker = false,
            stuntArea = true,
            radius = 20,
            distanceToHideHotspot = 75
          })
        end
      elseif conditionKey == 4 or conditionKey == 5 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:243155", false, false, false, nil, localPlayer.buttonLayout.enterZap)
        feedbackSystem.menusMaster.setCurrentFocusString(9)
        if hotspotMarker then
          feedbackSystem.clearTarget(hotspotMarker)
          hotspotMarker = nil
        end
        if jumpMarker then
          feedbackSystem.clearTarget(jumpMarker)
          jumpMarker = nil
        end
      elseif conditionKey == 7 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:246398")
        if hotspotMarker then
          feedbackSystem.clearTarget(hotspotMarker)
          hotspotMarker = nil
        end
        if jumpMarker then
          feedbackSystem.clearTarget(jumpMarker)
          jumpMarker = nil
        end
      elseif conditionKey == 8 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:243146")
        feedbackSystem.menusMaster.setCurrentFocusString(7)
        if jumpMarker then
          feedbackSystem.clearTarget(jumpMarker)
          jumpMarker = nil
        end
        if not hotspotMarker then
          hotspotMarker = feedbackSystem.newTarget({
            position = settings.hotspotPosition
          }, "Hotspot")
        end
      end
    end
  end
  local function taskComplete()
    if task.specialName == "Speed Past" or task.specialName == "HandBrake Turn" or task.specialName == "Head On Collision" or task.specialName == "Have we jumped" then
      Sound.EnterAudioState("FilmRolling", "Film_Rolling_Play", "Film_Rolling_Stop")
      feedbackSystem.menusMaster.masterSetVariable("iTV_Cam", 1)
      local iCamParams = {
        cameraTargets = {
          localPlayer.currentVehicle.gameVehicle
        },
        duration = 3.5,
        speed = 0.3,
        framing = "wide",
        fixedCameras = {
          [4] = vec.vector(-262.9255, 26.44583, 905.8636, 1)
        }
      }
      if task.specialName == "Speed Past" then
        function iCamParams.callbackFunction()
          feedbackSystem.menusMaster.masterSetVariable("iTV_Cam", 0)
          feedbackSystem.menusMaster.blockHintButton(true)
        end
      elseif task.specialName == "HandBrake Turn" then
        function iCamParams.callbackFunction()
          feedbackSystem.menusMaster.masterSetVariable("iTV_Cam", 0)
          feedbackSystem.menusMaster.blockHintButton(true)
        end
      elseif task.specialName == "Head On Collision" then
        function iCamParams.callbackFunction()
          feedbackSystem.menusMaster.masterSetVariable("iTV_Cam", 0)
          feedbackSystem.menusMaster.blockHintButton(true)
        end
      elseif task.specialName == "Have we jumped" then
        iCamParams.fixedCameras = {
          [4] = vec.vector(102.2568, 45.86682, 841.9017, 1)
        }
        function iCamParams.callbackFunction()
          feedbackSystem.menusMaster.masterSetVariable("iTV_Cam", 0)
          Sound.ExitAudioState("FilmRolling")
        end
        OneShotSound.Play("HUD_Gen_Positive", false)
      end
      iCamActivationTableInput(iCamParams)
    elseif task.specialName == "Prompt to return to van" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243145", false, false, true, nil, localPlayer.buttonLayout.enterZap)
      feedbackSystem.menusMaster.blockHintButton(false)
      feedbackSystem.menusMaster.setCurrentFocusString(5)
    elseif task.specialName == "Get in van" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.setCurrentFocusString(1)
    elseif task.specialName == "Prompt to get to next destination" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245529")
      feedbackSystem.menusMaster.setCurrentFocusString(1)
    end
  end
  local function cleanup()
    if userUpdateFunctions.failedStunt then
      removeUserUpdateFunction("failedStunt")
    end
    if hotspotMarker then
      feedbackSystem.clearTarget(hotspotMarker)
      hotspotMarker = nil
    end
    if jumpMarker then
      feedbackSystem.clearTarget(jumpMarker)
      jumpMarker = nil
    end
  end
  return update, goalComplete, taskComplete, cleanup
end)
