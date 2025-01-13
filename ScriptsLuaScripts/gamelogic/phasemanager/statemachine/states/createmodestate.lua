module("phaseManager")
local stateIndex = CreateModeStateIndex
local stateComplete = false
local uniqueIDSet = false
local waitForStats = false
local statsReceived = false
local function debugCheck()
  NetworkLog.Write(">[LUA] CreateModeState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " networkVars.modeID = " .. tostring(networkVars.modeID) .. "  waitForStats = " .. tostring(waitForStats) .. " statsReceived = " .. tostring(statsReceived))
  print("CreateModeState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " networkVars.modeID = " .. tostring(networkVars.modeID) .. "  waitForStats = " .. tostring(waitForStats) .. " statsReceived = " .. tostring(statsReceived))
end
local function statsCallback()
  statsReceived = true
end
local function enter()
  stateComplete = false
  sessionIDCallbackCalled = true
  waitForStats = false
  statsReceived = false
  if not challengeSystem.instances[networkVars.modeID] or not challengeSystem.instances[networkVars.modeID].networkVars.modeWillReset then
    local chosenModeName = cards.MissionNetworkLookup[networkVars.modeIndex]
    local missionData = cardSystem.createMission(chosenModeName)
    local isTutorial = missionData.settings.tutorial or false
    if not gameStatus.splitscreenSession and (gameStatus.onlineSessionType == gameStatus.onlineSessionID.public or isTutorial) and not gameStatus.onlineIsLan then
      onlineStatistics.setupMissionStatistics(cards.MissionNetworkLookup[networkVars.modeIndex], statsCallback, isTutorial)
      waitForStats = true
      statsReceived = false
    end
  end
  if isLocal then
    if networkVars.modeID == 0 then
      networkVars.modeID = challengeSystem.createInstance(nil, nil, networkVars.modeIndex, networkVars.modeAreaIndex).instanceID
    end
    sendMessage(2, stateIndex)
  end
end
local function step()
  if isLocal and not uniqueIDSet then
    sessionIDCallbackCalled = false
    UniqueSessionID.GenereateNewSessionID("setOnlineSessionID")
    uniqueIDSet = true
  end
  if not stateComplete and networkVars.modeID ~= 0 and challengeSystem.instances[networkVars.modeID] and sessionIDCallbackCalled and (not waitForStats or waitForStats and statsReceived) then
    stateComplete = true
    sendMessage(2, stateIndex)
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    stateMachine.changeState(states[VehicleSpooledStateIndex])
  end
end
local function exit(forced)
  uniqueIDSet = false
  if not forced then
    local missionName = challengeSystem.instances[networkVars.modeID].challenge.name
    local missionID = missionIntroData[missionName].missionID
    NetworkLog.Write(">[LUA] CreateModeState: setSidebar, missionName = " .. tostring(missionName) .. " missionID = " .. tostring(missionID))
    if missionName and missionID then
      local style = challengeSystem.instances[networkVars.modeID].challenge.settings.missionVehicleStyle
      local missionVehicleTable
      if style == 1 then
        missionVehicleTable = challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].vehicleSet[networkVars.missionVehicleIndex].vehicleID
      elseif style == 2 or style == 3 then
        missionVehicleTable = challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].missionVehicle.vehicleID
      elseif style == 4 then
        missionVehicleTable = challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].missionVehicleTable
      elseif style == 5 then
        missionVehicleTable = challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].spoolableVehicles
      elseif style == 6 then
        missionVehicleTable = challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].spoolableVehicles
        table.insert(missionVehicleTable, challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].missionVehicle.vehicleID)
      else
        missionVehicleTable = -1
      end
      onlineMissionSync.setCurrentMissionData(networkVars.trafficID, missionVehicleTable, 0)
    end
    NetworkLog.Write(">[LUA] CreateModeState: setSidebar, modeWillReset = " .. tostring(challengeSystem.instances[networkVars.modeID].networkVars.modeWillReset) .. " isSplitScreenMode() = " .. tostring(gameStatus.splitscreenSession) .. " tutorial = " .. tostring(challengeSystem.instances[networkVars.modeID].challenge.settings.tutorial))
    if not challengeSystem.instances[networkVars.modeID].networkVars.modeWillReset and not gameStatus.splitscreenSession and not challengeSystem.instances[networkVars.modeID].challenge.settings.tutorial then
      onlineSideBar.setSidebar(missionName)
    end
  end
end
local createModeState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(createModeState, stateIndex, "CreateModeState")
