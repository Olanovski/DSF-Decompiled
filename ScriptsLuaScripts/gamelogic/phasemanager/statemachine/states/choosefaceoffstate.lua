module("phaseManager")
local stateIndex = ChooseFaceOffStateIndex
local stateComplete = false
local function debugCheck()
  NetworkLog.Write(">[LUA] ChooseFaceOffState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " modeIndex = " .. tostring(networkVars.modeIndex))
  print("ChooseFaceOffState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " modeIndex = " .. tostring(networkVars.modeIndex))
end
local function enter()
  stateComplete = false
  for i = 0, 7 do
    gamerTag.setPlayerMarkerModel(i, 5)
    gamerTag.setPlayerObjectiveMarker(i, false)
  end
  if isLocal then
    networkVars.modeIndex, networkVars.modeAreaIndex = faceOffSystem.chooseRandomFaceOff()
    networkVars.trafficID = onlineMissionSync.generateTrafficID(faceOffSystem.faceOffPool[networkVars.modeIndex].settings.trafficSet, faceOffSystem.faceOffPool[networkVars.modeIndex].settings.trafficFrequency)
    networkVars.missionVehicleIndex = framework.random(1, #faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].vehicleSet)
    local moodStyle = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.moodStyle
    if moodStyle and (moodStyle == 1 or moodStyle == 2) then
      if moodStyle == 1 then
        networkVars.moodIndex = framework.random(1, #OnlineModeSettings.onlineChapterMoods)
        NetworkLog.Write("MOOD - Qualifying - " .. tostring(OnlineModeSettings.onlineChapterMoods[networkVars.moodIndex]) .. ", MoodStyle " .. tostring(moodStyle) .. ", moodIndex " .. tostring(networkVars.moodIndex) .. ", from " .. tostring(#OnlineModeSettings.onlineChapterMoods))
      elseif moodStyle == 2 and faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].moods then
        networkVars.moodIndex = framework.random(1, #faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].moods)
        NetworkLog.Write("MOOD - Qualifying - " .. tostring(faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].moods[networkVars.moodIndex]) .. ", MoodStyle " .. tostring(moodStyle) .. ", moodIndex " .. tostring(networkVars.moodIndex) .. ", from " .. tostring(#faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].moods))
      else
        networkVars.moodIndex = OnlineModeSettings.onlineDefaultMoodIndex
      end
    else
      networkVars.moodIndex = OnlineModeSettings.onlineDefaultMoodIndex
    end
    stateComplete = true
    sendMessage(2, stateIndex)
  end
end
local function step()
  if not stateComplete and networkVars.modeIndex ~= 0 then
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
local delayStart = false
local exit = function(forced)
  if not isLocal and networkVars.phase ~= RunFaceOffStateIndex and faceOffSystem.faceOffPool[networkVars.modeIndex] then
    faceOffSystem.updateFaceOffPool(networkVars.modeIndex)
    phaseManager.updateUsableModeAreaIndex(faceOffSystem.faceOffPool[networkVars.modeIndex].settings.title, networkVars.modeAreaIndex, false)
  end
  if not forced and faceOffSystem.faceOffPool[networkVars.modeIndex] then
    onlineMissionSync.setCurrentMissionData(networkVars.trafficID, faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].vehicleSet[networkVars.missionVehicleIndex].vehicleID, 0)
    local missionData = cardSystem.createMission(playlistSupport.getCurrentMission())
    if trackingTableData.missionID then
      NetworkLog.Write(">[LUA] TEAM - ChooseFaceOffState 1 - " .. tostring(trackingTableData.team))
      GameModeManager.startGameMode(trackingTableData.missionID, gameModePhaseEnd, 1, trackingTableData.team)
    end
    trackingTableData.missionID = FaceOffMissionID
    trackingTableData.team = missionData.settings.teamGame == true
    NetworkLog.Write(">[LUA] TEAM - ChooseFaceOffState 2 - " .. tostring(trackingTableData.team))
    GameModeManager.startGameMode(trackingTableData.missionID, gameModePhaseStart, 1, trackingTableData.team)
  end
end
local chooseFaceOffState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(chooseFaceOffState, 4, "ChooseFaceOffState")
