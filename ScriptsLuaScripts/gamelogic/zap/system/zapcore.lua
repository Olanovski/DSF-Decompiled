module("zap", package.seeall)
local returnZapInvulnerabilityDuration = 1
singlePlayerZapSlowDownMultiplier = 0.2
currentLevel = {
  [0] = 1,
  [1] = 1
}
currentMode = 1
currentUnlockedZapLevel = 0
local challengeSelectionColour = vec.vector(5, 0, 0, 0.5)
local selectionColour = vec.vector(5, 5, 5, 0.5)
function initialise()
  zapcontroller.setZapSelectionColour(challengeSelectionColour, selectionColour)
end
addInitObject(initialise)
local zapTransitionCompleteCallback = false
zapCallbacks = {}
function setZapTransitionCompleteCallback(callback)
  zapTransitionCompleteCallback = callback
end
function transitionOver(parameters)
  local plr = localPlayerManager.players[parameters.localID]
  if vehicleManager.multiplayerBusManager.playerInMultiplayerBus and vehicleManager.multiplayerBusManager.multiplayerBus then
    multiplayerBusSetInternalCamera(vehicleManager.multiplayerBusManager.multiplayerBus)
  end
  if plr.zapReturning and not plr.inCutscene and not plr.inCutsceneOrIcam then
    plr.controllerInterface:registerPlayerControl()
  end
  if parameters.fromZapReturn == true then
    Sound.DoZapBack(false)
  end
  if not plr.inZap then
    if parameters.fromZapReturn then
      plr.currentVehicle:addTemporaryInvulnerability(returnZapInvulnerabilityDuration)
    end
    plr:resetCameraMode()
  end
  Mood.removeMood("FastZap", 0.1)
  local onlineStateIndex = stateMachine.getCurrentStateIndex()
  if parameters.fromZapReturn == true and (not gameStatus.onlineSession or gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode and onlineStateIndex == RunModeStateIndex or onlineStateIndex == RunFaceOffStateIndex or onlineStateIndex == FreeDriveStateIndex) then
    plr.minimapSupport:show()
    local blockIcarSpeedAndDamageBars = false
    if progressionSystem.currentProgression <= 3 and not gameStatus.onlineSession and not bonusChallengeActive then
      blockIcarSpeedAndDamageBars = true
    end
    if not plr.inCutscene and not blockIcarSpeedAndDamageBars and plr.currentVehicle then
      feedbackSystem.menusMaster.enableDamageBar(plr)
      feedbackSystem.menusMaster.currentHUDSetVariable("iCarSpeed_Display", 1)
      feedbackSystem.menusMaster.locationPrompt(true)
    end
  end
  plr.transitioningGameVehicle = nil
  plr.zapReturning = false
  plr.zapToActionActive = false
  plr.zapToPointActive = false
end
function previewVehicle(vehicleAgent)
  player.setAttachment(localPlayer.localID, vehicleAgent.gameVehicle)
  local plr = localPlayerManager.players[localPlayer.localID]
  if not plr.zapReturning then
    spoolsystem.SetSpoolCentreAttachment(localPlayer.localID, vehicleAgent.gameVehicle)
  end
  vehicleManager.previewVehicleManager.triggerVehiclePreview(vehicleAgent)
end
function multiplayerBus(vehicleAgent)
  player.setAttachment(localPlayer.localID, vehicleAgent.gameVehicle)
  vehicleManager.multiplayerBusManager.activateMultiplayerBus()
end
function multiplayerBusSetInternalCamera(vehicleAgent)
  CameraSystemRegisterUpdate("Game_Cam", game_camera, "simulation", Camera_Function_Vehicle_Driver_Eye_Cam, {agent = vehicleAgent})
end
function setZapRadiusLevel(level)
  zapcontroller.setZapCameraLocks(zap.settings.levelData[level].locked)
  currentUnlockedZapLevel = level
end
function disableZapRadius()
  zapcontroller.setZapCameraLocks({
    missile = false,
    low = false,
    mid = false,
    high = false,
    top = false
  })
  print("ZAP RADIUS DISABLED")
end
function vehicleInLockedArea(vehiclePosition)
  if CityLockManager.InsideLockedArea(vehiclePosition) then
    return false
  else
    return true
  end
end
function zoomInOutButtonPrompts(plr, status)
  if not gameStatus.splitscreenSession then
    if status then
      if not ReplaySystem.IsPlayingBack() and localPlayer.isHUDActive() then
        if not gameStatus.onlineSession and isAbilityUnlocked("zap") and currentLevel then
          if currentUnlockedZapLevel > 1 then
            feedbackSystem.menusMaster.currentHUDSetVariable("iZap_ZoomControls_Display", 1)
            if currentLevel[plr.localID] < currentUnlockedZapLevel and currentLevel[plr.localID] == 1 then
              feedbackSystem.menusMaster.currentHUDSetTextVariable("shift_text", "ID:221035")
              feedbackSystem.menusMaster.currentHUDSetTextVariable("shift_button", localPlayer.buttonLayout.zapUp)
            elseif currentLevel[plr.localID] == currentUnlockedZapLevel then
              feedbackSystem.menusMaster.currentHUDSetTextVariable("shift_text", "ID:221034")
              feedbackSystem.menusMaster.currentHUDSetTextVariable("shift_button", localPlayer.buttonLayout.zapDown)
            else
              feedbackSystem.menusMaster.currentHUDSetTextVariable("shift_text", "ID:234219")
              if localPlayer.buttonLayout.zapUpDown.useSeparated then
                Menu.SetTextVariableIcon("Master", "shift_button", "%S%S", buttonsTable[localPlayer.buttonLayout.zapUp.button], buttonsTable[localPlayer.buttonLayout.zapDown.button])
              else
                feedbackSystem.menusMaster.currentHUDSetTextVariable("shift_button", localPlayer.buttonLayout.zapUpDown)
              end
            end
          end
        elseif gameStatus.onlineSession and not gameStatus.splitscreenSession and feedbackSystem.multiplayerSupport.enabled then
          feedbackSystem.menusMaster.currentHUDSetVariable("iZap_ZoomControls_Display", 1)
          if gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode and currentLevel[plr.localID] == 4 then
            feedbackSystem.menusMaster.currentHUDSetTextVariable("shift_text", "ID:221034")
            feedbackSystem.menusMaster.currentHUDSetTextVariable("shift_button", localPlayer.buttonLayout.zapDown)
          elseif gameStatus.onlineSessionType == gameStatus.onlineSessionID.partyMode and currentLevel[plr.localID] == 5 then
            feedbackSystem.menusMaster.currentHUDSetTextVariable("shift_text", "ID:221034")
            feedbackSystem.menusMaster.currentHUDSetTextVariable("shift_button", localPlayer.buttonLayout.zapDown)
          elseif currentLevel[plr.localID] == 1 then
            feedbackSystem.menusMaster.currentHUDSetTextVariable("shift_text", "ID:221035")
            feedbackSystem.menusMaster.currentHUDSetTextVariable("shift_button", localPlayer.buttonLayout.zapUp)
          else
            feedbackSystem.menusMaster.currentHUDSetTextVariable("shift_text", "ID:234219")
            if localPlayer.buttonLayout.zapUpDown.useSeparated then
              Menu.SetTextVariableIcon("Master", "shift_button", "%S%S", buttonsTable[localPlayer.buttonLayout.zapUp.button], buttonsTable[localPlayer.buttonLayout.zapDown.button])
            else
              feedbackSystem.menusMaster.currentHUDSetTextVariable("shift_button", localPlayer.buttonLayout.zapUpDown)
            end
          end
        end
      end
    else
      feedbackSystem.menusMaster.currentHUDSetVariable("iZap_ZoomControls_Display", 0)
    end
  end
end
function CallbackOnZapLevelReached(level, localID)
  if level >= 1 then
    tannerNarration.reminderManager()
  end
  storeZapLevel(level, localID)
end
local zapLevel
function storeZapLevel(level, localID)
  local player = localPlayerManager.players[localID]
  if level == 0 or level == 1 or zapLevel == 1 and level == 3 then
    vehicleManager.lightTrailCallback(level)
  end
  zapLevel = level
  currentLevel[player.localID] = level
  if not Network.isOnlineGame() and localPlayer.isHUDActive() then
    if zapLevel < 5 then
      player.minimapSupport:hideGoogleMap()
      player.minimapSupport:show()
    elseif zapLevel > 4 then
      player.minimapSupport:hide()
      player.minimapSupport:showGoogleMap()
    end
  end
  if not player.minimapSupport.zoomed and not player.inCutscene then
    zoomInOutButtonPrompts(player, true)
  end
  if settings and settings.heightData[zapLevel] then
    sky.scale = settings.heightData[zapLevel].sky_scale
  end
  activeChallenges.updateMissionWarmupMarkers(zapLevel)
end
function getZapLevel()
  return zapLevel
end
function zapCallbacks.onChangeZapLevel(fromLevel, level, localID)
  assert(level > 0 and level <= 8, "Invalid Zap Level passed to onChangeZapLevel: " .. tostring(level))
end
function _G.CallbackOnZapToVehicle(parameters)
  local gameVehicle = parameters.GameVehicle
  local localID = parameters.localID or 0
  local plr = localPlayerManager.players[localID]
  assert(gameVehicle, "vehicle not exist!")
  if gameVehicle then
    if plr.currentVehicle and plr.currentVehicle.gameVehicle == gameVehicle then
      plr.currentVehicle:removeAIDelay()
      local taskObject = plr.currentVehicle:getTaskObject()
      if not taskObject then
        plr.currentVehicle:removeSimulationArea()
      end
    end
    VehicleLodSpooler.RequestVehicle(gameVehicle.model_id, localID)
    if not vehicleManager.vehiclesByGameVehicle[gameVehicle] then
      PatrollingVehicleManager.RemovePatrollingVehicle(gameVehicle)
      if gameVehicle.owner == "Orphan" then
        vehicleManager.takeOwnership({gameVehicle = gameVehicle})
      else
        local maxSpeed = 40
        local minSpeed = 10
        local magicNumber = gameVehicle.speed * (1 + (1 - (gameVehicle.speed - minSpeed) / (maxSpeed - minSpeed)))
        vehicleManager.takeOwnership({
          gameVehicle = gameVehicle,
          forceVelocity = gameVehicle.matrix[2] * magicNumber
        })
      end
    else
      civilianTraffic.RemoveVehicleFromCarrier(gameVehicle)
    end
    local vehicle = vehicleManager.vehiclesByGameVehicle[gameVehicle]
    zap.OnSetZapLevelFinished(plr, 0, vehicle, parameters)
    targetGameVehicle = false
  end
end
function AddZapCallbacks(key, func)
  zapCallbacks[key] = func
end
local magicNumber = 5
function _G.ZapDistanceOutsideLockedArea(vehicle, value)
  nOutOfBoundsDistance = vehicle and value or 0
  if not localPlayer.inZap and vehicle and value and progressionSystem.currentProgression < 6 then
    Mood.addMoodUserDefined(moodSystem.Zap, "OutOfBounds", nOutOfBoundsDistance * magicNumber, 0, -1)
  end
end
function _G.IsMultiplayerBus(SNVID)
  local vehicleAgent = vehicleManager.vehiclesBySNVID[SNVID]
  if vehicleAgent and vehicleAgent.networkVars.multiplayerBus then
    return 1
  else
    return 0
  end
end
function _G.printZapPos(prefix)
  local pos = zapcontroller.ZapCameraGetTargetPos()
  print((prefix or "") .. tostring(pos))
end
function _G.printZapHeading(prefix)
  local heading = zapcontroller.ZapCameraGetTargetHeading()
  print((prefix or "") .. tostring(heading))
end
function _G.printZapPosHeading(prefix)
  printZapPos(prefix)
  printZapHeading(prefix)
end
function _G.printZapMatrix(prefix)
  local m = zapcontroller.ZapCameraGetTargetMatrix()
  local s = string.format("(%.5f,%.5f,%.5f,%.3f, %.5f,%.5f,%.5f,%.3f, %.5f,%.5f,%.5f,%.3f, 0,0,0,1)", m[0][0], m[1][0], m[2][0], m[3][0], m[0][1], m[1][1], m[2][1], m[3][1], m[0][2], m[1][2], m[2][2], m[3][2])
  print((prefix or "") .. s)
end
function OnSetZapLevelStarted(plr, zapLevel, vehicle, parameters)
  if zapLevel == 0 then
    plr:OnPlayerSetZapLevelStarted(zapLevel, vehicle, parameters)
  else
    plr:OnPlayerSetZapLevelStarted(zapLevel, vehicle, parameters)
    if not Network.isOnlineGame() and zapLevel > 1 then
      spoolsystem.EnableCameraTracking(plr.localID)
    end
    forceZapped = parameters.forcedOut or false
  end
end
function OnSetZapLevelFinished(plr, zapLevel, vehicle, parameters)
  if zapLevel == 0 then
    if zapLevel == 0 and vehicle ~= nil and vehicle == vehicleManager.previewVehicleManager.previewVehicle then
      parameters.ShowPreview = 0
    end
    GameVehicleResource.spoolOccupants(vehicle.gameVehicle)
    if vehicle.networkVars.multiplayerBus then
      plr.controls.enableRumble(false)
      multiplayerBus(vehicle)
      if not plr.zapTransition then
        multiplayerBusSetInternalCamera(vehicle)
      end
    elseif parameters.ShowPreview == 1 and not CutsceneFiles.tutorials.tutorialActive then
      if progressionSystem.currentProgression == 10 and vehicle:getTaskObject().coreData.instance.missionType == "mission" and vehicle:getTaskObject().coreData.instance.challenge.name ~= "Tanner & Jones Mission 1" and not ProfileSettings.GetToolTipShown(toolTipLookupTable["City Mission"]) and not ProfileSettings.GetStoryModeComplete() then
        CutsceneFiles.tutorials.playCityMissionTutorial(nil, vehicle)
      else
        previewVehicle(vehicle)
      end
    else
      plr:notifySetZapLevelEvent(0, vehicle)
    end
    for i = 1, #modes[1].oneShotSoundStops do
      OneShotSound.Play(modes[1].oneShotSoundStops[i])
    end
    zap.zoomInOutButtonPrompts(plr, false)
    if (not gameStatus.onlineSession and (progressionSystem.currentProgression > 3 or bonusChallengeActive) or gameStatus.onlineSession and not vehicle.networkVars.multiplayerBus or gameStatus.splitscreenSession) and not vehicleManager.previewVehicleManager.previewVehicle and not plr.inCutscene then
      feedbackSystem.menusMaster.enableDamageBar(plr)
    end
    if parameters.DelayControl == true then
    else
      plr.controls:resetState(modes[1].stateName, 1, plr.localID)
    end
  else
    plr:notifySetZapLevelEvent(zapLevel, vehicle)
    for i, audio in ipairs(modes[1].oneShotSoundStarts) do
      OneShotSound.Play(audio)
    end
    if not ReplaySystem.IsPlayingBack() then
      plr.controls:setState(modes[1].stateName, 1, plr.localID)
      player.setAttachment(plr.localID, plr.camera)
      if gameStatus.onlineSession and not feedbackSystem.multiplayerSupport.enabled and gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode then
        plr.minimapSupport:zoomIn()
        plr.minimapSupport:hide()
      end
      if progressionSystem.currentProgression > 3 or bonusChallengeActive or gameStatus.onlineSession then
        feedbackSystem.menusMaster.disableDamageBar(plr)
      end
      if feedbackSystem.previewScreen.activityBeingPrompted and not vehicleManager.previewVehicleManager.previewVehicle and zapLevel == 1 then
        if feedbackSystem.previewScreen.activityBeingPrompted.hotspotType == "dare" then
          feedbackSystem.previewScreen.showPreview("shiftHotspotPreview", feedbackSystem.previewScreen.activityBeingPrompted)
        else
          feedbackSystem.previewScreen.showPreview("shiftHotspotPreview", feedbackSystem.previewScreen.activityBeingPrompted.ID)
        end
      end
    end
    PIP.Deactivate(true)
    parameters.forcedOut = parameters.forcedOut or false
    GameplayTracking.OnZapOut(parameters.forcedOut == false)
    if not parameters.shutDown and g_zapSlowDownTrigger == false and not gameStatus.onlineSession then
      zapcontroller.setZapSlowMotionMultiplier(singlePlayerZapSlowDownMultiplier)
    elseif not parameters.shutDown and g_zapSlowDownTrigger == true and not gameStatus.onlineSession then
      zapcontroller.setZapSlowMotionMultiplier(1)
    elseif not parameters.shutDown and gameStatus.onlineSession then
      zapcontroller.setZapSlowMotionMultiplier(1)
    end
  end
end
function disableZapSelection()
  zapcontroller.ZapSettings(1, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(2, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(3, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(4, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(5, {CanSelectVehicles = false})
end
function enableZapSelection()
  zapcontroller.ZapSettings(1, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(2, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(3, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(4, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(5, {CanSelectVehicles = true})
end
function setDefaultZapSettingsForPlayer(localPlayerID, isSplitScreen)
  zapcontroller.setZapTransitionSpeed(localPlayerID, "missile", 0.4, 0.4)
  zapcontroller.setZapTransitionSpeed(localPlayerID, "low", 0.4, 0.4)
  zapcontroller.setZapTransitionSpeed(localPlayerID, "mid", 0.4, 0.4)
  zapcontroller.setZapTransitionSpeed(localPlayerID, "high", 2, 0.4)
  zapcontroller.setZapTransitionSpeed(localPlayerID, "top", 1, 0.4)
  zapcontroller.setZapCameraVelocities(localPlayerID, {missile = 64.8208})
  zapcontroller.setZapCameraVelocities(localPlayerID, {low = 71.5264})
  zapcontroller.setZapCameraVelocities(localPlayerID, {mid = 116.2304})
  if isSplitScreen then
    zapcontroller.setZapCameraVelocities(localPlayerID, {high = 268.224})
    zapcontroller.setZapCameraFakedVelocities(localPlayerID, {high = 134.112})
  else
    zapcontroller.setZapCameraVelocities(localPlayerID, {high = 357.632})
  end
  zapcontroller.setZapCameraVelocities(localPlayerID, {top = 1341.12})
  zapcontroller.setZapCameraHeights(localPlayerID, {missile = 6})
  zapcontroller.setZapCameraHeights(localPlayerID, {low = 75})
  zapcontroller.setZapCameraHeights(localPlayerID, {mid = 350})
  zapcontroller.setZapCameraHeights(localPlayerID, {high = 1500})
  zapcontroller.setZapCameraHeights(localPlayerID, {top = 6000})
end
function transitionStartedCallback(localID)
  local plr = localPlayerManager.players[localID]
  plr.zapTransition = true
end
function transitionCompletedCallback(localID)
  local plr = localPlayerManager.players[localID]
  plr.zapTransition = false
  plr.zapToActionActive = false
  plr.zapToPointActive = false
  if zapTransitionCompleteCallback then
    zapTransitionCompleteCallback(localID)
  end
end
function transitionAbortedCallback(localID)
  local plr = localPlayerManager.players[localID]
  plr.zapTransition = false
  plr.zapReturning = false
  plr.zapToActionActive = false
  plr.zapToPointActive = false
  print("**************************************************************")
  print("transitionAbortedCallback CALLED for player " .. tostring(localID))
  print("**************************************************************")
end
