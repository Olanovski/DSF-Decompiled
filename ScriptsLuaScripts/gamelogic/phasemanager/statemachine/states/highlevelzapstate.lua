module("phaseManager")
local stateIndex = HighLevelZapStateIndex
local stateComplete = false
local resetting
local targetZapLevel = 5
local allPlayersInZap = false
local allSNVsDeleted = false
highLevelZapTriggered = false
local function debugCheck()
  NetworkLog.Write(">[LUA] HighLevelZapState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " allSNVsDeleted = " .. tostring(allSNVsDeleted) .. " allPlayersInZap = " .. tostring(allPlayersInZap) .. " ZapLevel = " .. tostring(zapcontroller.getZapLevel()))
  print("HighLevelZapState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " allSNVsDeleted = " .. tostring(allSNVsDeleted) .. " allPlayersInZap = " .. tostring(allPlayersInZap) .. " ZapLevel = " .. tostring(zapcontroller.getZapLevel()))
  networkLogPrintTable(taskSystem.taskObjects, 2)
  networkLogPrintTable(vehicleManager.vehiclesBySNVID)
  printTable(taskSystem.taskObjects, 2)
  printTable(vehicleManager.vehiclesBySNVID)
end
local function enter()
  stateComplete = false
  if lastAppliedMood then
    moodSystem.removeMood(lastAppliedMood, 0)
    lastAppliedMood = false
  end
  if faceOffNext() then
    playerShortage = false
  end
  packageManager.clearPackageInteractions()
  propSystem.cleanupRuntimeProps()
  gamerTag.enabled = false
  allPlayersInZap = false
  if gameStatus.splitscreenSession then
    PauseMenu.allow(false)
  elseif faceOffNext() or not phaseManager.playlistSupport.networkVars.faceOffsEnabled then
    zapWeaponSupport.resetZapWeapons()
  end
  local playerPosition = false
  if not highLevelZapTriggered then
    for localID, plr in next, localPlayerManager.players, nil do
      zapcontroller.setZapCameraLocks(localID, {
        missile = false,
        low = false,
        mid = false,
        high = false,
        top = false
      })
      zapcontroller.EnableZapInput(false, localID)
      plr:blockAbility("zap", true)
      enableAbilities(localID, false)
      scoreSystem.stopAbilityDrain(localID, true)
      playerPosition = plr.position
      if not plr.inZap or zapcontroller.getTargetZapLevel(localID) ~= targetZapLevel then
        plr:SetZapLevel(targetZapLevel, nil, false, {forcedOut = true})
        zapcontroller.setActionPoinTracking(playerPosition, math.pi / 2, 1, localID)
      else
        plr.controls:setState(zap.modes[1].stateName, 1, localID)
      end
      highLevelZapTriggered = true
      feedbackSystem.multiplayerSupport.disableZapReticle()
    end
  end
  localPlayer:showHUDElements(false)
  Menu.HideZapPreview(true)
  feedbackSystem.multiplayerSupport.enabled = false
  zap.zoomInOutButtonPrompts(false)
  if not gameStatus.splitscreenSession then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 0)
    zapWeaponSupport.enableZapWeapons(false)
    zapcontroller.HideFlare(true)
  end
  zapcontroller.ZapSettings(1, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(2, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(3, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(4, {CanSelectVehicles = false})
  if networkVars.toFewPlayersType ~= 0 and 3 > networkVars.toFewPlayersType then
    if networkVars.toFewPlayersType == 1 then
      waitForPlayersRequired = true
    end
    if isLocal then
      networkVars.toFewPlayersType = 0
      print("Set toFewPlayersType = 0")
    end
  end
  zapcontroller.setSpoolerAttached(false)
end
local function step()
  allPlayersInZap = true
  allSNVsDeleted = true
  if not stateMachine.catchUp then
    for playerID, player in next, playerManager.players, nil do
      if not player.inZap then
        allPlayersInZap = false
        break
      end
    end
    for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
      allSNVsDeleted = false
      if vehicle.isLocal and vehicle.networkVars.onlineRequiredVehicle then
        vehicleManager.vehiclesBySNVID[SNVID].networkVars.onlineRequiredVehicle = false
      end
    end
  end
  if not stateComplete and zapcontroller.getZapLevel() == targetZapLevel and allPlayersInZap and allSNVsDeleted then
    stateComplete = true
    sendMessage(2, stateIndex)
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    stateMachine.changeState(states[GameModeCleanUpStateIndex])
  end
end
local exit = function(forced)
  highLevelZapTriggered = false
end
local highLevelZapState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(highLevelZapState, stateIndex, "HighLevelZapState")
