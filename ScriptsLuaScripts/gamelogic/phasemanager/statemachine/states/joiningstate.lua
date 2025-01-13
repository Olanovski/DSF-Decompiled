module("phaseManager")
local stateIndex = JoiningStateIndex
local stateComplete = false
local zapPlayer = function()
  if not localPlayer.zapBlockedFromCode then
    zapcontroller.EnableZapInput(false, localPlayer.localID)
    localPlayer:blockAbility("zap", true)
    enableAbilities(localPlayer.localID, false)
    scoreSystem.stopAbilityDrain(localPlayer.localID, true)
    OnlineModeSettings.onlineDisableAssert = true
    if not localPlayer.inZap or zapcontroller.getTargetZapLevel(0) ~= 5 then
      localPlayer:SetZapLevel(5, nil, false, {forcedOut = true})
    end
    OnlineModeSettings.onlineDisableAssert = false
    feedbackSystem.multiplayerSupport.disableZapReticle()
    localPlayer:showHUDElements(false)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 0)
    feedbackSystem.multiplayerSupport.enabled = false
    zap.zoomInOutButtonPrompts(false)
    zapWeaponSupport.enableZapWeapons(false)
    removeUserUpdateFunction("JoiningStateZapPlayer")
  end
end
local debugCheck = function()
  print("JoiningState")
  NetworkLog.Write(">[LUA] JoiningState")
end
local function enter(forced)
  stateComplete = false
  stateMachine.catchUp = true
  stateMachine.wasOnCatchup = false
  for i = 0, 7 do
    gamerTag.setPlayerMarkerModel(i, 5)
    gamerTag.setPlayerObjectiveMarker(i, false)
  end
  gamerTag.enabled = false
  if introHUD and introHUD.cleanup then
    introHUD.cleanup()
  end
  introHUD = false
  onlineSideBar.purge()
  addFaceOffXP = false
  playerFaceoffStartTime = false
  playerFaceoffEndTime = false
  if not gameStatus.splitscreenSession then
    if not localPlayer.zapBlockedFromCode then
      zapcontroller.EnableZapInput(false, localPlayer.localID)
      localPlayer:blockAbility("zap", true)
      enableAbilities(localPlayer.localID, false)
      scoreSystem.stopAbilityDrain(localPlayer.localID, true)
      if zapcontroller.getZapLevel(localPlayer.localID) ~= targetZapLevel then
        OnlineModeSettings.onlineDisableAssert = true
        OnlineModeSettings.onlineDisableAssert = false
      end
      feedbackSystem.multiplayerSupport.disableZapReticle()
      localPlayer:showHUDElements(false)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 0)
      feedbackSystem.multiplayerSupport.enabled = false
      zap.zoomInOutButtonPrompts(false)
      zapWeaponSupport.enableZapWeapons(false)
    else
      addUserUpdateFunction("JoiningStateZapPlayer", zapPlayer, 4)
    end
    if forced then
      skipIntroHUD = false
      onlineScreenManager.showScreen(JoiningScreenIndex, g_NetworkTime, onlineScreenManager.screenSortTypes.playerID, "JOINING SCREEN", false, function()
        return false
      end, 4)
    end
  end
end
local step = function()
  if challengeSystem.instances[networkVars.modeID] and challengeSystem.instances[networkVars.modeID]:instanceComplete() then
    challengeSystem.instances[networkVars.modeID]:stepInstanceDeletion()
  end
end
local exit = function(forced)
  removeUserUpdateFunction("JoiningStateZapPlayer")
  if not forced and stateMachine.stateToldToJoin ~= NewSessionStateIndex then
    skipIntroHUD = false
    if gameStatus.onlineSessionType and gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode then
      local missionData = cardSystem.createMission(playlistSupport.getCurrentMission())
      NetworkLog.Write(">[LUA] TEAM - JoiningState - " .. tostring(missionData.settings.teamGame == true))
      PlayerGamePlay.setIsTeamGame(missionData.settings.teamGame == true)
    end
    local missionName = phaseManager.playlistSupport.getCurrentMission()
    if not gameStatus.splitscreenSession and missionName and not phaseManager.playlistSupport.modePool.cooperative[missionName] then
      if phaseManager.networkVars.modeIndex ~= 0 and faceOffSystem.currentFaceOff and not faceOffSystem.currentFaceOff:instanceComplete() then
        local faceOffTimeRemaining = g_NetworkTime - faceOffSystem.currentFaceOff.networkVars.startTime
        if 0 < faceOffSystem.currentFaceOff.networkVars.startTime and phaseManager.faceOffPhaseLength() - faceOffTimeRemaining < phaseManager.faceOffMinJoinTime then
          skipIntroHUD = true
        end
        onlineSideBar.setSidebar("FaceOff", true)
      elseif challengeSystem.instances[networkVars.modeID] and not challengeSystem.instances[networkVars.modeID]:instanceComplete() then
        local modeRemainingTime = challengeSystem.instances[networkVars.modeID].challenge.settings.modeTimeLimit - (g_NetworkTime - challengeSystem.instances[networkVars.modeID].networkVars.startTime)
        if challengeSystem.instances[networkVars.modeID].networkVars.startTime > -1 and modeRemainingTime < modeMinJoinTime then
          skipIntroHUD = true
        end
        onlineSideBar.setSidebar(challengeSystem.instances[networkVars.modeID].challenge.name, true)
      end
    end
  end
end
local partyBusState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(partyBusState, stateIndex, "JoiningState")
