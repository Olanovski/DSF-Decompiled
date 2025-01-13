module("phaseManager")
local stateIndex = EndFaceOffStateIndex
local stateComplete = false
local faceOffCompleteScreenComplete = false
local waitForFaceOffDeletion = false
local function debugCheck()
  NetworkLog.Write(">[LUA] EndFaceOffState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
  print("EndFaceOffState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
end
local function enter()
  stateComplete = false
  faceOffCompleteScreenComplete = false
  waitForFaceOffDeletion = false
  SNV.disableDistanceMigration()
  if faceOffSystem.currentFaceOff and faceOffSystem.currentFaceOff.isLocal then
    waitForFaceOffDeletion = true
    faceOffSystem.currentFaceOff.faceOffEnding = true
    faceOffSystem.endFaceOffWhenWeCan()
  elseif faceOffSystem.currentFaceOff then
    waitForFaceOffDeletion = true
    faceOffSystem.currentFaceOff.faceOffEnding = true
  end
  if isLocal then
    networkVars.screenBlockStartTime = g_NetworkTime
    if networkVars.toFewPlayersType == 0 then
      networkVars.screenBlockEndTime = g_NetworkTime + faceOffCompleteLength() + modeIntroLength() + resultScreenLength()
    else
      networkVars.screenBlockEndTime = g_NetworkTime + faceOffCompleteLength() + resultScreenLength()
    end
  end
  ProfileSettings.SetNumFaceOffPlays(ProfileSettings.GetNumFaceOffPlays() + 1)
  ProfileSettings.TriggerAutoSave()
  freeDriveModeID = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.title
  onlineScreenManager.showScreen(PlayerResultScreenIndex, networkVars.screenBlockStartTime, onlineScreenManager.screenSortTypes.scoreNoID, faceOffSystem.faceOffPool[networkVars.modeIndex].settings.title, false, function()
    return false
  end, resultScreenLength())
  onlineScreenManager.showScreen(FaceOffCompleteScreenIndex, networkVars.screenBlockStartTime, onlineScreenManager.screenSortTypes.scoreNoID, faceOffSystem.faceOffPool[networkVars.modeIndex].settings.title, false, function()
    return true
  end, resultScreenLength() + faceOffCompleteLength())
  enableAbilities(localPlayer.localID, false)
  local missionData = cardSystem.createMission(playlistSupport.getCurrentMission())
  if trackingTableData.missionID then
    NetworkLog.Write(">[LUA] TEAM - EndFaceOffState - " .. tostring(trackingTableData.team))
    GameModeManager.startGameMode(trackingTableData.missionID, gameModePhaseEnd, 1, trackingTableData.team)
    trackingTableData.missionID = false
    trackingTableData.team = false
  end
  feedbackSystem.multiplayerSupport.resetNeutralPlayerColours()
  onlineSideBar.closeSidebar()
  vehicleManager.markAllForDeletion()
end
local function step()
  feedbackSystem.multiplayerSupport.stepNeutralPlayerColours()
  if not stateComplete then
    if waitForFaceOffDeletion then
      if not faceOffSystem.currentFaceOff then
        waitForFaceOffDeletion = false
      else
        faceOffSystem.stepFaceOffDeletion()
      end
      vehicleManager.markAllForDeletion()
    elseif vehicleManager.markAllForDeletion() then
      SNV.enableDistanceMigration()
      stateComplete = true
      sendMessage(2, stateIndex)
    end
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    stateMachine.changeState(states[FreeDriveStateIndex])
  end
end
local exit = function(forced)
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public and playerFaceoffStartTime and playerFaceoffEndTime then
    onlineProgressionSystem.setTimeInFaceOff(playerFaceoffEndTime - playerFaceoffStartTime)
    addFaceOffXP = true
  end
  playerFaceoffStartTime = false
  playerFaceoffEndTime = false
  if isLocal then
    updateFaceOffFlag(false)
    networkVars.modeIndex = 0
    networkVars.modeAreaIndex = 0
  end
  zap.zapSpawn.clearZapSpawnFailedCallbacks()
  onlineInstructionSupport.releasePrompts()
end
local endFaceOffState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(endFaceOffState, stateIndex, "EndFaceOffState")
