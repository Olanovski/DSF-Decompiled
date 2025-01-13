module("phaseManager")
local stateIndex = RunFaceOffStateIndex
local stateComplete = false
local function debugCheck()
  local outputTest = "invalid"
  if not stateComplete then
    outputTest = faceOffSystem.update()
  end
  print("RunFaceOffState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " faceOffComplete = " .. tostring(outputTest))
  NetworkLog.Write(">[LUA] RunFaceOffState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " faceOffComplete = " .. tostring(outputTest))
end
local function enter()
  stateComplete = false
  skipIntroHUD = false
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    local missionData = cardSystem.createMission(playlistSupport.getCurrentMission())
    local isTeamGame = missionData.settings.teamGame
    local requiredNumPlayers = missionData.settings.minPlayers
    if isTeamGame then
      requiredNumPlayers = requiredNumPlayers / 2
    end
    phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.faceOff)
    setupTimeToScoreUpdate(requiredNumPlayers, isTeamGame, timeToJoinScore.faceOff, timeToJoinScore.faceOffUnbPlayers, timeToJoinScore.faceOffTFPlayers)
    updateTimeToScoreValue()
  end
  phaseManager.playerControlLockedUntilGameStart = false
  zapcontroller.EnableZapInput(true)
  scoreSystem.stopAbilityDrain(localPlayer.localID, false)
  scoreSystem.stopAbilityGain(localPlayer.localID, false)
  scoreSystem.setTimeAbilityGain(localPlayer.localID, true)
  feedbackSystem.multiplayerSupport.enabled = true
  for localID, plr in next, localPlayerManager.players, nil do
    zapcontroller.setZapCameraLocks(localID, {
      missile = false,
      low = true,
      mid = false,
      high = false,
      top = true
    })
    plr:blockAbility("zap", false)
  end
  zapcontroller.HideFlare(false)
  if localPlayer.currentVehicle then
    localPlayer.controllerInterface:registerPlayerControl()
    localPlayer.currentVehicle.networkVars.onlineRequiredVehicle = false
    localPlayer.currentVehicle.networkVars.onlineOwnerID = nil
  else
    NetworkLog.Write(">[LUA] RunFaceOffState: dont have a vehicle so return to the lobby!")
    stateMachine.error = true
    stateMachine.forceToState(phaseManager.states[ReturnToBusStateIndex])
    return
  end
  scoreSystem.setAbility(localPlayer.localID, abilities.abilityBarUpgrade.getMaxAbilityForLevel(1))
  enableAbilities(localPlayer.localID, true)
  if onlineProgressionSystem.getPlayerLevel(localPlayer.playerID) ~= 0 or gameStatus.onlineSessionType == gameStatus.onlineSessionID.private and phaseManager.playlistSupport.networkVars.enableBalancedAbilities then
    onlineProgressionSystem.onlineEnableUnlockedAbilities()
    localPlayer.controllerInterface:createCallbacks()
  end
  SNV.enableDistanceMigration()
  local missionData = cardSystem.createMission(playlistSupport.getCurrentMission())
  NetworkLog.Write(">[LUA] TEAM - RunFaceOffState - " .. tostring(missionData.settings.teamGame == true))
  GameModeManager.startGameMode(FaceOffMissionID, gameModePhaseRunning, 1, missionData.settings.teamGame == true)
  playerFaceoffStartTime = g_NetworkTime
  feedbackSystem.multiplayerSupport.resetNeutralPlayerColours()
  zapcontroller.ZapSettings(1, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(2, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(3, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(4, {CanSelectVehicles = true})
  Menu.HideZapPreview(false)
  if not stateMachine.wasOnCatchup and Network.isLowestStationID() and faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].trafficExclusion then
    local trafficExclusion = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].trafficExclusion
    for groupNum, exclusionData in ipairs(trafficExclusion) do
      local triggerID = trafficExclusionZone.addTrafficExclusionZoneTrigger(exclusionData.trigger)
      for exclusionID, volume in ipairs(exclusionData.exclusions) do
        trafficExclusionZone.addTrafficExclusionZone(volume, triggerID)
      end
    end
  end
  faceOffSystem.startFaceOff()
  Presence.setPresence(13, 2)
  player.EnableDisconnectOnInactivity()
  addUserUpdateFunction("removeUnwantedImportantVehicles", removeUnwantedImportantVehicles, 60)
  PlayerGamePlay.allowTeamShuffling(true)
end
local function step()
  feedbackSystem.multiplayerSupport.stepNeutralPlayerColours()
  if not stateComplete and faceOffSystem.update() then
    stateComplete = true
    sendMessage(2, stateIndex)
  elseif gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    updateTimeToScoreValue()
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    stateMachine.changeState(states[PlayerResultsSyncStateIndex])
  end
end
local exit = function(forced)
  removeUserUpdateFunction("removeUnwantedImportantVehicles")
  faceOffSystem.stopFaceOff()
  trafficExclusionZone.release()
  playerFaceoffEndTime = g_NetworkTime
  clearTimeToScoreUpdate()
  feedbackSystem.multiplayerSupport.enabled = false
  player.DisableDisconnectOnInactivity()
  for localID, plr in next, localPlayerManager.players, nil do
    zapcontroller.setZapCameraLocks(localID, {
      missile = false,
      low = true,
      mid = false,
      high = false,
      top = false
    })
  end
end
local runFaceOffState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(runFaceOffState, stateIndex, "RunFaceOffState")
