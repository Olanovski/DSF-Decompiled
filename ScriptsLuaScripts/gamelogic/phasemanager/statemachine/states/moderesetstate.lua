module("phaseManager")
local stateIndex = ModeResetStateIndex
local stateComplete = false
local shouldReset = false
local missionName = false
local instance
local screensSet = false
local function debugCheck()
  NetworkLog.Write(">[LUA] ModeResetState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " markAllRoundObjectsForDeletion = " .. tostring(markAllRoundObjectsForDeletion()) .. " allRoundObjectsDeleted = " .. tostring(allRoundObjectsDeleted()))
  print("ModeResetState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " markAllRoundObjectsForDeletion = " .. tostring(markAllRoundObjectsForDeletion()) .. " allRoundObjectsDeleted = " .. tostring(allRoundObjectsDeleted()))
  networkLogPrintTable(taskSystem.taskObjects, 2)
  printTable(taskSystem.taskObjects, 2)
  networkLogPrintTable(vehicleManager.vehiclesBySNVID)
  printTable(vehicleManager.vehiclesBySNVID)
end
local function enter()
  stateComplete = false
  screensSet = false
  shouldReset = challengeSystem.instances[networkVars.modeID]:shouldReset()
  feedbackSystem.multiplayerSupport.disableZapReticle()
  if (gameStatus.splitscreenSession or challengeSystem.instances[networkVars.modeID].challenge.settings.tutorial) and challengeSystem.instances[networkVars.modeID].challenge.missionCompleteData then
    challengeSystem.instances[networkVars.modeID].challenge.missionCompleteData(challengeSystem.instances[networkVars.modeID])
  end
  missionName = challengeSystem.instances[networkVars.modeID].challenge.name
  if shouldReset and not gameStatus.splitscreenSession and isLocal then
    networkVars.screenBlockStartTime = g_NetworkTime
    if phaseManager.playlistSupport.modePool.competitive[missionName] then
      networkVars.screenBlockEndTime = g_NetworkTime + roundCompleteLength() + resultScreenLength()
    else
      networkVars.screenBlockEndTime = g_NetworkTime + roundCompleteLength()
    end
  end
  instance = challengeSystem.instances[networkVars.modeID]
end
local returnValue1, returnValue2
local function step()
  if not screensSet then
    if onlineRaceManager.raceActive then
      onlineRaceManager.endRace()
    end
    checkpointTracker.release()
    if shouldReset or gameStatus.splitscreenSession then
      local screenType = SoloRoundCompleteScreenIndex
      local resultType = PlayerResultScreenIndex
      local resultLength = resultScreenLength()
      if isTeamGame then
        screenType = TeamRoundCompleteScreenIndex
        resultType = TeamResultScreenIndex
      elseif raceModePlayed and localPlayerManager.numberOfPlayers == 1 then
        resultType = SoloRaceModeResultIndex
      end
      if gameStatus.splitscreenSession then
        networkVars.screenBlockStartTime = g_NetworkTime + 2
        networkVars.screenBlockEndTime = g_NetworkTime + 12
        resultType = SSResultScreenIndex
        resultLength = 10
      end
      freeDriveModeID = missionName
      onlineScreenManager.showScreen(resultType, networkVars.screenBlockStartTime, onlineScreenManager.screenSortTypes.score, missionName, function()
        if gameStatus.splitscreenSession then
          feedbackSystem.splitScreenSupport.clearScoringBar(phaseManager.playlistSupport.modePool.cooperative[missionName] ~= nil)
        end
      end, function()
        if gameStatus.splitscreenSession then
          if shouldReset then
            return false
          else
            return true
          end
        end
        return false
      end, resultLength)
      if not gameStatus.splitscreenSession then
        onlineScreenManager.showScreen(screenType, networkVars.screenBlockStartTime, onlineScreenManager.screenSortTypes.score, missionName, false, function()
          return false
        end)
      end
    end
    screensSet = true
  end
  returnValue1 = markAllRoundObjectsForDeletion()
  returnValue2 = allRoundObjectsDeleted()
  if not stateComplete then
    if returnValue1 and returnValue2 then
      stateComplete = true
      sendMessage(2, stateIndex)
    end
  elseif not returnValue1 or not returnValue2 then
    stateComplete = false
  end
  if instance.stepHighlightColours then
    instance.stepHighlightColours(instance)
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    if shouldReset or gameStatus.splitscreenSession then
      stateMachine.changeState(states[FreeDriveStateIndex])
    else
      stateMachine.changeState(states[EndModeStateIndex])
    end
  end
end
local function exit(forced)
  if isLocal then
    networkVars.nextTurnTaker = 255
  end
  if shouldReset and isLocal and not challengeSystem.instances[networkVars.modeID].challenge.settings.noIndexflip then
    networkVars.modeAreaIndex = 0
    challengeSystem.instances[networkVars.modeID].networkVars.routeIndex = 0
  end
  if shouldReset and instance.isLocal then
    instance.networkVars.isComplete = false
    instance.completeCalled = false
    instance.networkVars.roundOn = instance.networkVars.roundOn + 1
  end
  if shouldReset then
    challengeSystem.instances[networkVars.modeID]:resetFinished()
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
  instance.playersColours = nil
  instance.playerVehicles = nil
end
local modeResetState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(modeResetState, stateIndex, "ModeResetState")
