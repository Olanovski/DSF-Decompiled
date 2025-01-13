module("phaseManager")
local stateIndex = NewSessionStateIndex
local stateComplete = false
local function debugCheck()
  NetworkLog.Write(">[LUA] NewSessionState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " multiplayerBusActive = " .. tostring(vehicleManager.multiplayerBusManager.multiplayerBusActive) .. " playerList = " .. tostring(playlistSupport.currentPlaylist))
  print("NewSessionState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " multiplayerBusActive = " .. tostring(vehicleManager.multiplayerBusManager.multiplayerBusActive) .. " playerList = " .. tostring(playlistSupport.currentPlaylist))
end
local function enter()
  stateComplete = false
  if isLocal then
    updateFaceOffFlag(true)
  end
  feedbackSystem.multiplayerSupport.resetNeutralPlayerColours()
  feedbackSystem.menusMaster.onlineSetTextVariable("ButtonACross", localPlayer.buttonLayout.accept)
  feedbackSystem.menusMaster.onlineSetTextVariable("ButtonBCircle", localPlayer.buttonLayout.reject)
  feedbackSystem.menusMaster.onlineSetTextVariable("console_button_X", localPlayer.buttonLayout.accept)
  feedbackSystem.menusMaster.onlineSetTextVariable("console_button_CIRCLE", localPlayer.buttonLayout.reject)
end
local function step()
  if not isLocal and not vehicleManager.multiplayerBusManager.remoteBusVehicle then
    for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
      if vehicle.networkVars.multiplayerBus then
        vehicleManager.multiplayerBusManager.createRemoteMultiplayerBus(vehicle)
        break
      end
    end
  end
  feedbackSystem.multiplayerSupport.stepNeutralPlayerColours()
  if not stateComplete and gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode and SNOID and phaseManager.playlistSupport.SNOID and onlineRaceManager.SNOID and phaseManager.playlistSupport.playlistValid() and isLocal then
    stateComplete = true
    sendMessage(2, stateIndex)
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
  if not forced then
    local missionData = cardSystem.createMission(playlistSupport.getCurrentMission())
    NetworkLog.Write(">[LUA] TEAM - NewSessionState - " .. tostring(missionData.settings.teamGame == true))
    PlayerGamePlay.setIsTeamGame(missionData.settings.teamGame == true)
    if gameStatus.splitscreenSession and GameModeManager.GetSplitScreenMissionMode() == 1 then
      feedbackSystem.splitScreenSupport.disableSSHud = true
    end
  end
end
local newSessionState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(newSessionState, stateIndex, "NewSessionState")
