module("phaseManager")
local stateIndex = SpoolLockStateIndex
local stateComplete = false
local spoolPoint = false
local minimumPhaseTime = 9
local phaseStartTime = 0
local minimumPhaseTimerFinished = false
local moodStyle = 0
local moodIndex = OnlineModeSettings.onlineDefaultMoodIndex
local mood = OnlineModeSettings.onlineChapterMoods[moodIndex]
local locationSpooled = false
local missionData = false
local function debugCheck()
  local networkLinks = "invalid"
  if networkVars.modeID and challengeSystem.instances[networkVars.modeID] then
    networkLinks = challengeSystem.instances[networkVars.modeID]:networkLinksValid()
  end
  print("SpoolLockState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " locationSpooled = " .. tostring(locationSpooled) .. " AreVehiclesSpooled = " .. tostring(vehicleManager.activeVehicles.getAreVehiclesSpooled()) .. " screensComplete = " .. tostring(onlineScreenManager.areScreensComplete()) .. " network links = " .. tostring(networkLinks) .. " faceOffNext = " .. tostring(faceOffNext()) .. " minimumPhaseTimerFinished = " .. tostring(minimumPhaseTimerFinished) .. " playerShortage = " .. tostring(playerShortage) .. " playerJoining = " .. tostring(playlistSupport.networkVars.playerJoining))
  NetworkLog.Write(">[LUA] SpoolLockState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " locationSpooled = " .. tostring(locationSpooled) .. " AreVehiclesSpooled = " .. tostring(vehicleManager.activeVehicles.getAreVehiclesSpooled()) .. " screensComplete = " .. tostring(onlineScreenManager.areScreensComplete()) .. " network links = " .. tostring(networkLinks) .. " faceOffNext = " .. tostring(faceOffNext()) .. " minimumPhaseTimerFinished = " .. tostring(minimumPhaseTimerFinished) .. " playerShortage = " .. tostring(playerShortage) .. " playerJoining = " .. tostring(playlistSupport.networkVars.playerJoining))
end
local function enter()
  stateComplete = false
  initialiseComplete = false
  locationSpooled = false
  if lastAppliedMood then
    moodSystem.removeMood(lastAppliedMood, 0)
    lastAppliedMood = false
  end
  if networkVars.moodIndex then
    moodIndex = networkVars.moodIndex
  else
    moodIndex = OnlineModeSettings.onlineDefaultMoodIndex
  end
  if not faceOffNext() then
    local chosenModeName = cards.MissionNetworkLookup[networkVars.modeIndex]
    missionData = cardSystem.createMission(chosenModeName)
    spoolPoint = missionData.spawnPositions[networkVars.modeAreaIndex].target
    if missionData.settings.moodStyle and (missionData.settings.moodStyle == 2 or missionData.settings.moodStyle == 3) then
      mood = missionData.spawnPositions[networkVars.modeAreaIndex].moods[moodIndex]
    else
      mood = OnlineModeSettings.onlineChapterMoods[moodIndex]
    end
  else
    spoolPoint = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].target
    if faceOffSystem.faceOffPool[networkVars.modeIndex].settings.moodStyle and faceOffSystem.faceOffPool[networkVars.modeIndex].settings.moodStyle == 2 then
      mood = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].moods[moodIndex]
    else
      mood = OnlineModeSettings.onlineChapterMoods[moodIndex]
    end
  end
  moodSystem.applyMood(mood)
  lastAppliedMood = mood
  phaseStartTime = g_NetworkTime
  minimumPhaseTimerFinished = true
  zapcontroller.setSpoolerAttached(true)
end
local function step()
  assert(spoolPoint, "spool point is nil, the current mode must not have a target position inside it's spawn positions")
  if spoolsystem.IsLocationResident(spoolPoint) then
    locationSpooled = true
    initialiseComplete = true
  elseif STATE_DEBUG_FLAG then
    print("Area may have failed to spool, Is area spooled? " .. tostring(spoolPoint) .. " spool center? " .. tostring(spoolsystem.position) .. " zap cursor position " .. tostring(zapcontroller.ZapCameraGetTargetPos()))
  end
  if not minimumPhaseTimerFinished and g_NetworkTime - phaseStartTime > minimumPhaseTime then
    minimumPhaseTimerFinished = true
  end
  if not stateComplete and locationSpooled and onlineScreenManager.areScreensComplete() and vehicleManager.activeVehicles.getAreVehiclesSpooled() and minimumPhaseTimerFinished and not playerShortage and not playlistSupport.networkVars.playerJoining then
    if faceOffNext() and faceOffSystem.currentFaceOff then
      stateComplete = true
      sendMessage(2, stateIndex)
    elseif not faceOffNext() and networkVars.modeID ~= 0 and challengeSystem.instances[networkVars.modeID] and challengeSystem.instances[networkVars.modeID]:networkLinksValid() then
      stateComplete = true
      sendMessage(2, stateIndex)
    end
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    if faceOffNext() and faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].gridStyle ~= 3 and faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].gridStyle ~= 6 or not faceOffNext() and not challengeSystem.instances[networkVars.modeID].challenge.settings.teamCameraTransition then
      stateMachine.changeState(states[SpawnVehiclesCleanupStateIndex])
    else
      stateMachine.changeState(states[TeamMoveToModeStateIndex])
    end
  end
  if isLocal and not faceOffNext() and g_NetworkTime - phaseStartTime > waitingForPlayersTimeOut and not playersJoiningLock then
    if missionData.settings.teamGame then
      toFewPlayers(2)
    else
      toFewPlayers(1)
    end
    stateMachine.forceToState(states[ReturnToBusStateIndex], true)
    return
  end
end
local exit = function(forced)
  stateMachine.setSupportState(false)
  if forced and lastAppliedMood then
    moodSystem.removeMood(lastAppliedMood, 0)
    lastAppliedMood = false
  end
end
local spoolLockState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(spoolLockState, stateIndex, "SpoolLockState")
