module("phaseManager")
local stateIndex = RunModeStateIndex
local stateComplete = false
local instance
local function debugCheck()
  NetworkLog.Write(">[LUA] RunModeState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " missionComplete = " .. tostring(instance:stepInstance()))
  print("RunModeState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " missionComplete = " .. tostring(challengeSystem.instances[networkVars.modeID]:stepInstance()))
end
local function enter()
  stateComplete = false
  skipIntroHUD = false
  instance = challengeSystem.instances[networkVars.modeID]
  if not gameStatus.splitscreenSession and not instance.challenge.settings.tutorial then
    setTimeToJoinScore(missionIntroData[instance.challenge.name].timeToJoinScore)
  end
  for localID, plr in next, localPlayerManager.players, nil do
    zapcontroller.setZapCameraLocks(localID, {
      missile = false,
      low = true,
      mid = false,
      high = false,
      top = true
    })
  end
  if not instance.challenge.settings.zapLock then
    if not instance.challenge.settings.lockZapWeapons and onlineProgressionSystem.areZapWeaponsUnlocked() then
      zapWeaponSupport.enableZapWeapons(true)
      ActiveVehicles.enableSystem(true)
    end
    for localID, plr in next, localPlayerManager.players, nil do
      zapcontroller.EnableZapInput(true, localID)
      plr:blockAbility("zap", false)
    end
  end
  for localID, plr in next, localPlayerManager.players, nil do
    scoreSystem.stopAbilityDrain(localID, false)
    scoreSystem.stopAbilityGain(localID, false)
    scoreSystem.setTimeAbilityGain(localID, true)
    enableAbilities(localID, true)
  end
  if instance.challenge.settings.zapLock then
    for localID, plr in next, localPlayerManager.players, nil do
      if not gameStatus.splitscreenSession then
        scoreSystem.setAbility(localID, 25)
      end
      scoreSystem.setZapBlocked(localID, true)
    end
  end
  feedbackSystem.multiplayerSupport.enabled = true
  Menu.HideZapPreview(false)
  SNV.enableDistanceMigration()
  phaseManager.playerControlLockedUntilGameStart = false
  for localID, player in next, localPlayerManager.players, nil do
    if player.currentVehicle then
      player.controllerInterface:registerPlayerControl()
      player.currentVehicle.networkVars.onlineRequiredVehicle = false
      player.currentVehicle.networkVars.onlineOwnerID = nil
    else
      NetworkLog.Write(">[LUA] RunModeState: dont have a vehicle so return to the lobby!")
      stateMachine.error = true
      stateMachine.forceToState(phaseManager.states[ReturnToBusStateIndex])
      return
    end
  end
  if not gameStatus.splitscreenSession then
    addUserUpdateFunction("removeUnwantedImportantVehicles", removeUnwantedImportantVehicles, 60)
    if not phaseManager.playlistSupport.networkVars.faceOffsEnabled then
      scoreSystem.setAbility(0, instance.challenge.settings.zapLock and 0)
    end
    if onlineProgressionSystem.getPlayerLevel(localPlayer.playerID) ~= 0 or gameStatus.onlineSessionType == gameStatus.onlineSessionID.private and phaseManager.playlistSupport.networkVars.enableBalancedAbilities then
      onlineProgressionSystem.onlineEnableUnlockedAbilities()
      localPlayer.controllerInterface:createCallbacks()
    end
    zapcontroller.HideFlare(false)
    presenceID = presenceSystem.IDs[instance.challenge.name]
    if presenceID then
      if gameStatus.onlineSessionType == gameStatus.onlineSessionID.private then
        Presence.setPresence(14, presenceID, 0)
      else
        Presence.setPresence(14, presenceID, 1)
      end
    end
  else
    phaseManager.failedSSRound = false
    for localID, plr in next, localPlayerManager.players, nil do
      abilities.nitro.setLevel(0)
      abilities.ram.setLevel(0)
      plr:blockAbility("nitro", false)
      plr:blockAbility("ram", true)
      plr.controllerInterface:createCallbacks()
    end
    presenceID = presenceSystem.SSIDs[instance.challenge.name]
    if presenceID then
      Presence.setPresence(12, presenceID)
    end
  end
  local missionName = phaseManager.playlistSupport.getCurrentMission()
  local missionID = missionIntroData[missionName].missionID
  if missionID and missionName then
    NetworkLog.Write(">[LUA] TEAM - RunModeState - " .. tostring(missionIntroData[missionName].teams == true))
    GameModeManager.startGameMode(missionID, gameModePhaseRunning, 0, missionIntroData[missionName].teams == true)
  end
  instance:startInstance()
  if gameStatus.splitscreenSession then
    PauseMenu.allow(true)
    NetworkLog.Write(">[LUA] - PauseMenu.allow ( true ) ")
  end
  zapcontroller.ZapSettings(1, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(2, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(3, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(4, {CanSelectVehicles = true})
  if instance.onPlayerJoinInProgress and 0 < instance.networkVars.startTime and 2 < g_NetworkTime - instance.networkVars.startTime then
    instance.onPlayerJoinInProgress()
  end
  if not stateMachine.wasOnCatchup and Network.isLowestStationID() and instance.challenge.spawnPositions[phaseManager.networkVars.modeAreaIndex].trafficExclusion then
    local trafficExclusion = instance.challenge.spawnPositions[phaseManager.networkVars.modeAreaIndex].trafficExclusion
    for groupNum, exclusionData in ipairs(trafficExclusion) do
      local triggerID = trafficExclusionZone.addTrafficExclusionZoneTrigger(exclusionData.trigger)
      for exclusionID, volume in ipairs(exclusionData.exclusions) do
        trafficExclusionZone.addTrafficExclusionZone(volume, triggerID)
      end
    end
  end
  if addFaceOffXP then
    onlineProgressionSystem.addFaceoffMatchBonus()
    addFaceOffXP = false
  end
  player.EnableDisconnectOnInactivity()
end
local function step()
  if not stateComplete and instance:stepInstance() then
    stateComplete = true
    sendMessage(2, stateIndex)
  end
  if instance.stepHighlightColours then
    instance.stepHighlightColours(instance)
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  instance:checkNetworkVarsValidity()
  if stateComplete and readyCheck() then
    if gameStatus.splitscreenSession or instance.challenge.settings.tutorial then
      stateMachine.changeState(states[ModeResetStateIndex])
    elseif raceModePlayed then
      stateMachine.changeState(states[RaceEndStateIndex])
    else
      stateMachine.changeState(states[PlayerResultsSyncStateIndex])
    end
  end
end
local function exit(forced)
  removeUserUpdateFunction("removeUnwantedImportantVehicles")
  player.DisableDisconnectOnInactivity()
  onlineInstructionSupport.purge()
  for i = 0, 7 do
    gamerTag.setPlayerMarkerModel(i, 5)
  end
  trafficExclusionZone.release()
  if not forced then
    instance:stopTasks()
    instance.missionStartCalled = false
    feedbackSystem.multiplayerSupport.enabled = false
  else
    removeUserUpdateFunction("reenableOnlinePause")
    PauseMenu.allow(true)
  end
  if instance.challenge.settings.zapLock then
    for localID, plr in next, localPlayerManager.players, nil do
      scoreSystem.setZapBlocked(localID, false)
    end
  end
  onlineProgressionSystem.endProgressionGoals()
  checkpointSystem.clearOnlineCheckpointScoreTracking()
  zapcontroller.ZapAttackCancel()
  ActiveVehicles.enableSystem(false)
  vehicleManager.activeVehicles.resetSystem()
end
local runModeState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(runModeState, stateIndex, "RunModeState")
