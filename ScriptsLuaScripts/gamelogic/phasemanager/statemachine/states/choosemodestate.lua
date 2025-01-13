module("phaseManager")
local stateIndex = ChooseModeStateIndex
local stateComplete = false
local resetting = false
local isTeamSet = false
local function debugCheck()
  NetworkLog.Write(">[LUA] ChooseModeState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " resetting = " .. tostring(resetting))
  print("ChooseModeState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " resetting = " .. tostring(resetting))
end
local function enter()
  stateComplete = false
  resetting = false
  playedTutorial = false
  isTeamSet = false
  for i = 0, 7 do
    gamerTag.setPlayerMarkerModel(i, 5)
    gamerTag.setPlayerObjectiveMarker(i, false)
  end
  if not gameStatus.splitscreenSession then
    stateMachine.setSupportState(states[PlayerCheckStateIndex])
  end
  if networkVars.modeID and challengeSystem.instances[networkVars.modeID] and challengeSystem.instances[networkVars.modeID].networkVars.modeWillReset then
    challengeSystem.instances[networkVars.modeID]:resetFinished()
    resetting = true
    if challengeSystem.instances[networkVars.modeID].isLocal then
      challengeSystem.instances[networkVars.modeID].networkVars.isComplete = false
    end
  end
  if isLocal then
    if networkVars.modeID and challengeSystem.instances[networkVars.modeID] and challengeSystem.instances[networkVars.modeID].networkVars.modeWillReset then
      if not challengeSystem.instances[networkVars.modeID].challenge.settings.noIndexflip then
        networkVars.modeAreaIndex = challengeSystem.instances[networkVars.modeID]:chooseNextAreaIndex()
      end
      if challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].frequenceAndVehicles then
        networkVars.vehicleFreqIndex = framework.random(1, #challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].frequenceAndVehicles)
        networkVars.missionVehicleIndex = framework.random(1, #challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].frequenceAndVehicles[networkVars.vehicleFreqIndex].vehicleSet)
        networkVars.trafficID = onlineMissionSync.generateTrafficID(challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].frequenceAndVehicles[networkVars.vehicleFreqIndex].trafficSet, challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].frequenceAndVehicles[networkVars.vehicleFreqIndex].trafficFrequency)
      elseif challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].vehicleSet then
        networkVars.missionVehicleIndex = framework.random(1, #challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].vehicleSet)
        networkVars.trafficID = onlineMissionSync.generateTrafficID(challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].trafficSet, challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].trafficFrequency)
      end
      local moodStyle = challengeSystem.instances[networkVars.modeID].challenge.settings.moodStyle
      if moodStyle and (moodStyle == 1 or moodStyle == 2 or moodStyle == 3) then
        if moodStyle == 1 then
          networkVars.moodIndex = framework.random(1, #OnlineModeSettings.onlineChapterMoods)
          NetworkLog.Write("MOOD - " .. tostring(OnlineModeSettings.onlineChapterMoods[networkVars.moodIndex]) .. ", MoodStyle " .. tostring(moodStyle) .. ", moodIndex " .. tostring(networkVars.moodIndex) .. ", from " .. tostring(#OnlineModeSettings.onlineChapterMoods))
        elseif moodStyle == 2 and challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].moods then
          networkVars.moodIndex = framework.random(1, #challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].moods)
          NetworkLog.Write("MOOD (new round) - " .. tostring(challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].moods[networkVars.moodIndex]) .. ", MoodStyle " .. tostring(moodStyle) .. ", moodIndex " .. tostring(networkVars.moodIndex) .. ", from " .. tostring(#challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].moods))
        elseif moodStyle == 3 then
          NetworkLog.Write("MOOD (as last round) - " .. tostring(challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].moods[networkVars.moodIndex]) .. ", MoodStyle " .. tostring(moodStyle) .. ", moodIndex " .. tostring(networkVars.moodIndex) .. ", from " .. tostring(#challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].moods))
        else
          networkVars.moodIndex = OnlineModeSettings.onlineDefaultMoodIndex
        end
      else
        networkVars.moodIndex = OnlineModeSettings.onlineDefaultMoodIndex
      end
      local chosenModeName = cards.Missions[cards.MissionNetworkLookup[networkVars.modeIndex]].name
      if chosenModeName then
        if trackingTableData.missionID then
          NetworkLog.Write(">[LUA] TEAM - ChooseModeState 5 - " .. tostring(trackingTableData.team))
          GameModeManager.startGameMode(trackingTableData.missionID, gameModePhaseEnd, 0, trackingTableData.team, trackingTableData.displayName)
        end
        trackingTableData.missionID = missionIntroData[chosenModeName].missionID
        trackingTableData.team = missionIntroData[chosenModeName].teams == true
        trackingTableData.displayName = phaseManager.playlistSupport.getDisplayName(chosenModeName)
        NetworkLog.Write(">[LUA] TEAM - ChooseModeState 6 - " .. tostring(missionIntroData[chosenModeName].teams == true))
        GameModeManager.startGameMode(missionIntroData[chosenModeName].missionID, gameModePhaseStart, 0, missionIntroData[chosenModeName].teams == true, phaseManager.playlistSupport.getDisplayName(chosenModeName), networkVars.modeAreaIndex)
      end
    else
      local chosenModeName
      chosenModeName, networkVars.modeIndex, networkVars.modeAreaIndex = phaseManager.playlistSupport.getChosenMission()
      local missionData = cardSystem.createMission(chosenModeName)
      if missionData.spawnPositions[networkVars.modeAreaIndex].frequenceAndVehicles then
        networkVars.vehicleFreqIndex = framework.random(1, #missionData.spawnPositions[networkVars.modeAreaIndex].frequenceAndVehicles)
        networkVars.missionVehicleIndex = framework.random(1, #missionData.spawnPositions[networkVars.modeAreaIndex].frequenceAndVehicles[networkVars.vehicleFreqIndex].vehicleSet)
        networkVars.trafficID = onlineMissionSync.generateTrafficID(missionData.spawnPositions[networkVars.modeAreaIndex].frequenceAndVehicles[networkVars.vehicleFreqIndex].trafficSet, missionData.spawnPositions[networkVars.modeAreaIndex].frequenceAndVehicles[networkVars.vehicleFreqIndex].trafficFrequency)
      elseif missionData.spawnPositions[networkVars.modeAreaIndex].vehicleSet then
        networkVars.missionVehicleIndex = framework.random(1, #missionData.spawnPositions[networkVars.modeAreaIndex].vehicleSet)
        networkVars.trafficID = onlineMissionSync.generateTrafficID(missionData.spawnPositions[networkVars.modeAreaIndex].trafficSet, missionData.spawnPositions[networkVars.modeAreaIndex].trafficFrequency)
      end
      local moodStyle = missionData.settings.moodStyle
      if moodStyle and (moodStyle == 1 or moodStyle == 2 or moodStyle == 3) then
        if moodStyle == 1 then
          networkVars.moodIndex = framework.random(1, #OnlineModeSettings.onlineChapterMoods)
          NetworkLog.Write("MOOD - " .. tostring(OnlineModeSettings.onlineChapterMoods[networkVars.moodIndex]) .. ", MoodStyle " .. tostring(moodStyle) .. ", moodIndex " .. tostring(networkVars.moodIndex) .. ", from " .. tostring(#OnlineModeSettings.onlineChapterMoods))
        elseif (moodStyle == 2 or moodStyle == 3) and missionData.spawnPositions[networkVars.modeAreaIndex].moods then
          networkVars.moodIndex = framework.random(1, #missionData.spawnPositions[networkVars.modeAreaIndex].moods)
          NetworkLog.Write("MOOD - " .. tostring(missionData.spawnPositions[networkVars.modeAreaIndex].moods[networkVars.moodIndex]) .. ", MoodStyle " .. tostring(moodStyle) .. ", moodIndex " .. tostring(networkVars.moodIndex) .. ", from " .. tostring(#missionData.spawnPositions[networkVars.modeAreaIndex].moods))
        else
          networkVars.moodIndex = OnlineModeSettings.onlineDefaultMoodIndex
        end
      else
        networkVars.moodIndex = OnlineModeSettings.onlineDefaultMoodIndex
      end
      if trackingTableData.missionID then
        NetworkLog.Write(">[LUA] TEAM - ChooseModeState 1 - " .. tostring(trackingTableData.team))
        GameModeManager.startGameMode(trackingTableData.missionID, gameModePhaseEnd, 0, trackingTableData.team, trackingTableData.displayName)
      end
      trackingTableData.missionID = missionIntroData[chosenModeName].missionID
      trackingTableData.team = missionIntroData[chosenModeName].teams == true
      trackingTableData.displayName = phaseManager.playlistSupport.getDisplayName(chosenModeName)
      NetworkLog.Write(">[LUA] TEAM - ChooseModeState 2 - " .. tostring(trackingTableData.team))
      GameModeManager.startGameMode(trackingTableData.missionID, gameModePhaseStart, 0, trackingTableData.team, trackingTableData.displayName, networkVars.modeAreaIndex)
      if missionData.settings.teamGame then
        isTeamGame = true
        PlayerGamePlay.rebalanceTeams()
      else
        isTeamGame = false
      end
      isTeamSet = true
    end
    if not resetting then
      stateComplete = true
      sendMessage(2, stateIndex)
    end
  end
end
local function step()
  if resetting and challengeSystem.instances[networkVars.modeID]:resetFinished() then
    resetting = false
  end
  if not isTeamSet and networkVars.modeIndex ~= 0 and networkVars.modeAreaIndex ~= 0 then
    local chosenModeName = cards.MissionNetworkLookup[networkVars.modeIndex]
    local missionData = cardSystem.createMission(chosenModeName)
    if missionData.settings.teamGame then
      isTeamGame = true
    else
      isTeamGame = false
    end
    isTeamSet = true
  end
  if not stateComplete and not resetting and isTeamSet and networkVars.modeIndex ~= 0 and networkVars.modeAreaIndex ~= 0 then
    stateComplete = true
    sendMessage(2, stateIndex)
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    stateMachine.changeState(states[LoadRouteStateIndex])
  end
end
local exit = function(forced)
  if not forced and not isLocal then
    local chosenModeName = cards.Missions[cards.MissionNetworkLookup[networkVars.modeIndex]].name
    if chosenModeName then
      if trackingTableData.missionID then
        NetworkLog.Write(">[LUA] TEAM - ChooseModeState 3 - " .. tostring(trackingTableData.team))
        GameModeManager.startGameMode(trackingTableData.missionID, gameModePhaseEnd, 0, trackingTableData.team, trackingTableData.displayName)
      end
      trackingTableData.missionID = missionIntroData[chosenModeName].missionID
      trackingTableData.team = missionIntroData[chosenModeName].teams == true
      trackingTableData.displayName = phaseManager.playlistSupport.getDisplayName(chosenModeName)
      NetworkLog.Write(">[LUA] TEAM - ChooseModeState 4 - " .. tostring(missionIntroData[chosenModeName].teams == true))
      GameModeManager.startGameMode(missionIntroData[chosenModeName].missionID, gameModePhaseStart, 0, missionIntroData[chosenModeName].teams == true, phaseManager.playlistSupport.getDisplayName(chosenModeName), networkVars.modeAreaIndex)
    end
    if networkVars.phase ~= RunModeStateIndex then
      phaseManager.updateUsableModeAreaIndex(cards.MissionNetworkLookup[networkVars.modeIndex], networkVars.modeAreaIndex, true)
    end
  end
end
local chooseModeState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(chooseModeState, stateIndex, "ChooseModeState")
