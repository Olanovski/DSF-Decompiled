module("phaseManager")
local stateIndex = EndModeStateIndex
local stateComplete = false
local isCoopMission = false
local startTime
local rewardScreenSet = false
local function debugCheck()
  NetworkLog.Write(">[LUA] EndModeState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " markAllForDeletion = " .. tostring(markAllForDeletion()) .. " allObjectsDeleted = " .. tostring(allObjectsDeleted()))
  print("EndModeState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " markAllForDeletion = " .. tostring(markAllForDeletion()) .. " allObjectsDeleted = " .. tostring(allObjectsDeleted()))
  networkLogPrintTable(vehicleManager.vehiclesBySNVID)
  printTable(vehicleManager.vehiclesBySNVID)
end
local function enter()
  stateComplete = false
  markAllForDeletion()
  if not gameStatus.splitscreenSession then
    onlineSideBar.closeSidebar()
  end
  SNV.disableDistanceMigration()
  local missionName = phaseManager.playlistSupport.getCurrentMission()
  local missionID = missionIntroData[missionName].missionID
  local resultsScreenTime = resultScreenLength()
  if not phaseManager.playlistSupport.modePool.competitive[missionName] then
    resultsScreenTime = 0
  end
  if phaseManager.playlistSupport.modePool.cooperative[missionName] ~= nil then
    isCoopMission = true
    resultsScreenTime = resultScreenLength()
    print("End coop mission " .. tostring(missionName))
  end
  if missionIntroData[missionName].updateGamePlayCount then
    missionIntroData[missionName].updateGamePlayCount()
  end
  if not isCoopMission and localPlayerManager.numberOfPlayers == 1 then
    onlineSideBar.autoSetSidebarCollapsedPreference()
  end
  ProfileSettings.TriggerAutoSave()
  if networkVars.modeID and challengeSystem.instances[networkVars.modeID] and challengeSystem.instances[networkVars.modeID].isLocal then
    playedTutorial = challengeSystem.instances[networkVars.modeID].challenge.settings.tutorial
    if gameStatus.splitscreenSession then
      networkVars.screenBlockStartTime = g_NetworkTime + 7.5
    else
      networkVars.screenBlockStartTime = g_NetworkTime
    end
    if gameStatus.splitscreenSession then
      networkVars.screenBlockEndTime = g_NetworkTime + 8
    elseif isCoopMission == true then
      networkVars.screenBlockEndTime = g_NetworkTime + resultsScreenTime + roundCompleteLength()
    elseif phaseManager.playlistSupport.networkVars.faceOffsEnabled and networkVars.toFewPlayersType ~= 1 then
      networkVars.screenBlockEndTime = g_NetworkTime + modeCompleteLength() + faceOffIntroLength() + resultsScreenTime
    elseif networkVars.toFewPlayersType == 1 then
      networkVars.screenBlockEndTime = g_NetworkTime + modeCompleteLength() + resultsScreenTime
    else
      networkVars.screenBlockEndTime = g_NetworkTime + modeCompleteLength() + modeIntroLength() + resultsScreenTime
    end
  end
  if gameStatus.splitscreenSession then
    moodSystem.clearMoods()
    phaseManager.playlistSupport.ssPlayedModeCount = phaseManager.playlistSupport.ssPlayedModeCount + 1
    local screenIndex = phaseManager.playlistSupport.modePool.competitive[missionName] and SSCompCompleteScreenIndex or SSCoopCompleteScreenIndex
    onlineScreenManager.showScreen(screenIndex, networkVars.screenBlockStartTime, false, missionName, false, function()
      return false
    end, resultsScreenTime)
    if trackingTableData.missionID then
      NetworkLog.Write(">[LUA] TEAM - EndModeState 1 - " .. tostring(trackingTableData.team))
      GameModeManager.startGameMode(trackingTableData.missionID, gameModePhaseEnd, 0, trackingTableData.team, trackingTableData.displayName)
      trackingTableData.missionID = false
      trackingTableData.team = false
      trackingTableData.displayName = false
    end
  else
    local screenType = SoloCompleteScreenIndex
    local resultType = PlayerResultScreenIndex
    if isTeamGame then
      screenType = TeamCompleteScreenIndex
      resultType = TeamResultScreenIndex
    elseif raceModePlayed and localPlayerManager.numberOfPlayers == 1 then
      resultType = SoloRaceModeResultIndex
    end
    if phaseManager.playlistSupport.modePool.competitive[missionName] then
      startTime = g_NetworkTime
      freeDriveModeID = cards.MissionNetworkLookup[networkVars.modeIndex]
      onlineScreenManager.showScreen(resultType, networkVars.screenBlockStartTime, onlineScreenManager.screenSortTypes.score, cards.MissionNetworkLookup[networkVars.modeIndex], false, function()
        if playedTutorial then
          return true
        end
        return false
      end, resultsScreenTime)
    end
    if not playedTutorial then
      onlineScreenManager.showScreen(screenType, networkVars.screenBlockStartTime, onlineScreenManager.screenSortTypes.score, cards.MissionNetworkLookup[networkVars.modeIndex], false, function()
        return true
      end, resultsScreenTime + modeCompleteLength())
    else
      challengeSystem.instances[networkVars.modeID].challenge.onlineStatisticsData()
      onlineProgressionSystem.processLevelUp()
      onlineStatistics.updateServerStatistics()
      onlineScreenManager.showScreen(OnlineTutorialCompleteIndex, networkVars.screenBlockStartTime, false, cards.MissionNetworkLookup[networkVars.modeIndex], false, function()
        return false
      end, resultsScreenTime)
    end
    if trackingTableData.missionID then
      NetworkLog.Write(">[LUA] TEAM - EndModeState 2 - " .. tostring(trackingTableData.team))
      GameModeManager.startGameMode(trackingTableData.missionID, gameModePhaseEnd, 0, trackingTableData.team, trackingTableData.displayName)
      trackingTableData.missionID = false
      trackingTableData.team = false
      trackingTableData.displayName = false
    end
  end
  feedbackSystem.multiplayerSupport.resetNeutralPlayerColours()
end
local returnValue1, returnValue2
local function step()
  feedbackSystem.multiplayerSupport.stepPostGameFeedback()
  returnValue1 = markAllForDeletion()
  returnValue2 = allObjectsDeleted()
  if not stateComplete then
    if returnValue1 and returnValue2 then
      stateComplete = true
      sendMessage(2, stateIndex)
    end
  elseif not returnValue1 or not returnValue2 then
    stateComplete = false
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() and not gameStatus.splitscreenSession then
    if playedTutorial then
      if onlineScreenManager.areScreensComplete() then
        stateMachine.changeState(states[ReturnToBusStateIndex])
      end
    else
      stateMachine.changeState(states[FreeDriveStateIndex])
    end
  end
  onlineInstructionSupport.releasePrompts()
end
local exit = function(forced)
  if not forced then
    SNV.enableDistanceMigration()
  end
  if isLocal then
    updateFaceOffFlag(true)
    networkVars.modeIndex = 0
    networkVars.modeAreaIndex = 0
    networkVars.modeID = 0
    if not forced and not gameStatus.splitscreenSession then
      phaseManager.playlistSupport.setNextMission()
    end
  end
  zap.zapSpawn.clearZapSpawnFailedCallbacks()
end
local endModeState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(endModeState, stateIndex, "EndModeState")
