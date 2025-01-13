module("phaseManager")
local stateIndex = FreeDriveStateIndex
local stateComplete = false
local freeDriveStartTime = 0
local freeDriveDuration = 0
local levelingProcessed = false
local shouldReset = false
local function debugCheck()
  NetworkLog.Write(">[LUA] FreeDriveState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
  print("FreeDriveState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
end
local function enter()
  stateComplete = false
  freeDriveStartTime = g_NetworkTime
  feedbackSystem.multiplayerSupport.resetNeutralPlayerColours()
  if challengeSystem.instances[networkVars.modeID] then
    shouldReset = challengeSystem.instances[networkVars.modeID]:shouldReset()
  else
    shouldReset = false
  end
  freeDriveDuration = gameStatus.splitscreenSession and resultScreenLength()
end
local function step()
  if shouldReset or faceOffNext() or not phaseManager.playlistSupport.networkVars.faceOffsEnabled then
    feedbackSystem.multiplayerSupport.stepPostGameFeedback()
  else
    feedbackSystem.multiplayerSupport.stepNeutralPlayerColours()
  end
  if networkVars.modeID == 0 and not levelingProcessed and not gameStatus.splitscreenSession and faceOffNext() and gameStatus.onlineSessionType == gameStatus.onlineSessionID.public and not gameStatus.onlineIsLan then
    onlineProgressionSystem.processLevelUp()
    onlineStatistics.updateServerStatistics()
    levelingProcessed = true
  end
  if not stateComplete and g_NetworkTime - freeDriveStartTime > freeDriveDuration then
    stateComplete = true
    sendMessage(2, stateIndex)
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    if gameStatus.splitscreenSession then
      feedbackSystem.multiplayerSupport.disableSSAbilityBar(0)
      feedbackSystem.multiplayerSupport.disableSSAbilityBar(1)
      localPlayer.minimapSupport.hideSS(0)
      localPlayer.minimapSupport.hideSS(1)
      gamerTag.enabled = false
      stateMachine.changeState(states[FadeOutStateIndex])
    else
      stateMachine.changeState(states[HighLevelZapStateIndex])
    end
  end
end
local function exit(forced)
  clearLoadedRouteData()
  propSystem.cleanupRuntimeProps()
  feedbackSystem.multiplayerSupport.clearPostGameFeedback()
  raceModePlayed = false
  if freeDriveModeID and not gameStatus.splitscreenSession then
    onlineScreenManager.endScreen(freeDriveModeID)
  end
  freeDriveModeID = false
  Menu.HideZapPreview(true)
  for localID, plr in next, localPlayerManager.players, nil do
    zapcontroller.setZapCameraLocks(localID, {
      missile = false,
      low = true,
      mid = false,
      high = false,
      top = false
    })
    if gameStatus.splitscreenSession then
      OneShotSound.Play("ZAP_CutsceneMixTransition_OneShot", false)
      if not plr.inZap then
        plr:SetZapLevel(1, nil, false, {forcedOut = true})
      end
      zapcontroller.EnableZapInput(false, localID)
      plr:blockAbility("zap", true)
    end
  end
  levelingProcessed = false
end
local freeDriveState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(freeDriveState, stateIndex, "freeDriveState")
