module("phaseManager")
local stateIndex = WaitingForPlayersStateIndex
local stateComplete = false
local waitScreenComplete = false
local enterStateTime = 0
local numPlayers = 0
local numPlayersNeeded = 2
local playerShortageA = 0
local playerShortageB = 0
local isTeamGame = false
local teamOneCount = 0
local teamTwoCount = 0
local function debugCheck()
  NetworkLog.Write(">[LUA] WaitingForPlayersState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " waitForPlayersRequired = " .. tostring(waitForPlayersRequired) .. " waitScreenComplete = " .. tostring(waitScreenComplete) .. " numPlayers = " .. tostring(numPlayers) .. " allowTooFewPlayers = " .. tostring(allowTooFewPlayers))
  print("WaitingForPlayersState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " waitForPlayersRequired = " .. tostring(waitForPlayersRequired) .. " waitScreenComplete = " .. tostring(waitScreenComplete) .. " numPlayers = " .. tostring(numPlayers) .. " allowTooFewPlayers = " .. tostring(allowTooFewPlayers))
end
local function enter()
  stateComplete = false
  waitScreenComplete = false
  enterStateTime = g_NetworkTime
  if networkVars.toFewPlayersType == 0 and stateMachine.catchUp or gameStatus.onlineSessionType == gameStatus.onlineSessionID.private then
    waitForPlayersRequired = false
  end
  if waitForPlayersRequired then
    playerShortageA = 0
    playerShortageB = 0
    local missionData = cardSystem.createMission(playlistSupport.getCurrentMission())
    isTeamGame = missionData.settings.teamGame or false
    if isLocal then
      networkVars.waitForPlayerStartTime = g_NetworkTime
      networkVars.screenBlockStartTime = 0
      networkVars.screenBlockEndTime = g_NetworkTime + waitForPlayersLength()
    end
    onlineScreenManager.showScreen(WaitForPlayersScreenIndex, networkVars.waitForPlayerStartTime, onlineScreenManager.screenSortTypes.playerID, "WAIT", false, function()
      waitScreenComplete = true
      return false
    end)
  end
end
local function step()
  if waitForPlayersRequired then
    if allowTooFewPlayers then
      playerShortageA = 0
      playerShortageB = 0
    elseif isTeamGame then
      teamOneCount = 0
      teamTwoCount = 0
      for playerID, player in next, playerManager.players, nil do
        if currentStateList[playerID + 1] == stateIndex then
          if PlayerGamePlay.getPlayerTeam(playerID) == 1 then
            teamOneCount = teamOneCount + 1
          else
            teamTwoCount = teamTwoCount + 1
          end
        end
      end
      playerShortageA = numPlayersNeeded - teamOneCount
      playerShortageB = numPlayersNeeded - teamTwoCount
      if playerShortageA < 0 then
        playerShortageA = 0
      end
      if playerShortageB < 0 then
        playerShortageB = 0
      end
    else
      numPlayers = 0
      for playerID, player in next, playerManager.players, nil do
        if currentStateList[playerID + 1] == stateIndex then
          numPlayers = numPlayers + 1
        end
      end
      playerShortageA = numPlayersNeeded - numPlayers
      if playerShortageA < 0 then
        playerShortageA = 0
      end
    end
  end
  if not stateComplete and (waitForPlayersRequired and waitScreenComplete and playerShortageA + playerShortageB == 0 or not waitForPlayersRequired) then
    stateComplete = true
    sendMessage(2, stateIndex)
  end
  if isLocal and g_NetworkTime - enterStateTime > waitingForPlayersTimeOut and not playersJoiningLock then
    stateMachine.forceToState(states[ReturnToBusStateIndex], true)
    return
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    assert(faceOffNext(), "IN WAITING FOR PLAYERS STATE WHEN WE ARE PLAYING A MODE NEXT!")
    stateMachine.changeState(states[ChooseFaceOffStateIndex])
  end
end
local exit = function(forced)
  if waitForPlayersRequired then
    onlineScreenManager.endScreen("WAIT")
    waitForPlayersRequired = false
  end
  if isLocal and networkVars.toFewPlayersType == 3 then
    networkVars.toFewPlayersType = 0
  end
end
local waitingForPlayersState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(waitingForPlayersState, stateIndex, "WaitingForPlayersState")
