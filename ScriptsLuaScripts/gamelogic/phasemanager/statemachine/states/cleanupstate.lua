module("phaseManager")
local stateIndex = CleanupStateIndex
local stateComplete = false
local function debugCheck()
  NetworkLog.Write(">[LUA] CleanupState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " markAllForDeletion = " .. tostring(markAllForDeletion()) .. " allObjectsDeleted = " .. tostring(allObjectsDeleted()) .. " currentFaceOff = " .. tostring(faceOffSystem.currentFaceOff))
  print("CleanupState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " markAllForDeletion = " .. tostring(markAllForDeletion()) .. " allObjectsDeleted = " .. tostring(allObjectsDeleted()) .. " currentFaceOff = " .. tostring(faceOffSystem.currentFaceOff))
end
local function enter()
  stateComplete = false
  removeUserUpdateFunction("shiftMove")
  removeUserUpdateFunction("removeUnwantedImportantVehicles")
  onlineRaceManager.purge()
  checkpointTracker.release()
  if markAllForDeletion() and allObjectsDeleted() and challengeSystem.instances[networkVars.modeID] and challengeSystem.instances[networkVars.modeID].isLocal and challengeSystem.instances[networkVars.modeID].challenge.settings.numRounds then
    if challengeSystem.instances[networkVars.modeID].challenge.settings.numRounds > 0 then
      challengeSystem.instances[networkVars.modeID].networkVars.roundOn = challengeSystem.instances[networkVars.modeID].challenge.settings.numRounds
    else
      challengeSystem.instances[networkVars.modeID].networkVars.roundOn = challengeSystem.instances[networkVars.modeID].challenge.settings.maxRounds
    end
  end
  challengeSystem.endAllInstanceWhenYouCan()
  if faceOffSystem.currentFaceOff then
    faceOffSystem.currentFaceOff.faceOffEnding = true
    if faceOffSystem.currentFaceOff.isLocal then
      faceOffSystem.endFaceOffWhenWeCan()
    else
      faceOffSystem.currentFaceOff:stop()
    end
  else
    feedbackSystem.faceOffSupport.removeFeedback()
  end
  if isLocal then
    updateFaceOffFlag(true)
  end
  if not gameStatus.splitscreenSession then
    onlineSideBar.closeSidebar()
  end
  addFaceOffXP = false
  playerFaceoffStartTime = false
  playerFaceoffEndTime = false
end
local returnValue1, returnValue2
local function step()
  returnValue1 = markAllForDeletion()
  returnValue2 = allObjectsDeleted()
  if not stateComplete then
    if faceOffSystem.currentFaceOff then
      faceOffSystem.stepFaceOffDeletion()
    elseif returnValue1 and returnValue2 then
      stateComplete = true
      sendMessage(2, stateIndex)
    end
  elseif not returnValue1 or not returnValue2 then
    stateComplete = false
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    OnlineModeSettings.onlineDisableAssert = true
    stateMachine.changeState(states[HighLevelZapStateIndex])
    OnlineModeSettings.onlineDisableAssert = false
  end
end
local exit = function(forced)
  modeOrFaceOffEnded()
end
local cleanupState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(cleanupState, stateIndex, "CleanupState")
