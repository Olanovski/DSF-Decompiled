module("phaseManager")
local stateIndex = PlayerCheckStateIndex
local isTeamGame = false
local missionData = false
local modeResetting = false
local numPlayersNeeded = -1
local playerJoinResetTimer = -1
playersJoiningLock = false
playerShortage = false
local debugCheck = function()
  print("PlayerCheckState")
  NetworkLog.Write(">[LUA] PlayerCheckState")
end
local function enter()
  missionData = cardSystem.createMission(playlistSupport.getCurrentMission())
  isTeamGame = missionData.settings.teamGame
  playerJoinResetTimer = false
  if networkVars.modeID and challengeSystem.instances[networkVars.modeID] and challengeSystem.instances[networkVars.modeID].networkVars.modeWillReset then
    modeResetting = true
  else
    modeResetting = false
  end
  if missionData.settings.tutorial then
    numPlayersNeeded = 1
  elseif gameStatus.onlineSessionType == gameStatus.onlineSessionID.private then
    if isTeamGame then
      numPlayersNeeded = 1
    else
      numPlayersNeeded = 2
    end
  elseif isTeamGame then
    numPlayersNeeded = missionData.settings.minPlayers / 2
  else
    numPlayersNeeded = missionData.settings.minPlayers
  end
end
local function step()
  if isLocal then
    local playerJoin = PlayerGamePlay.isPartyJoiningOurMatch()
    if playlistSupport.networkVars.joiningStartTime > 0 and playlistSupport.networkVars.playerJoining and g_NetworkTime - playlistSupport.networkVars.joiningStartTime > 15 then
      playlistSupport.networkVars.playerJoining = false
      playersJoiningLock = true
      playerJoin = false
      if not modeResetting then
        PlayerGamePlay.rebalanceTeams()
      end
    elseif playerJoin ~= playlistSupport.networkVars.playerJoining and (not playersJoiningLock or playersJoiningLock and not playerJoin) then
      if not playerJoin and not playerJoinResetTimer then
        if not modeResetting then
          PlayerGamePlay.rebalanceTeams()
        end
        playerJoinResetTimer = true
      elseif playerJoin then
        playerJoinResetTimer = false
        playlistSupport.networkVars.playerJoining = playerJoin
      end
      playlistSupport.networkVars.playerJoining = playerJoin
    end
    if playerJoinResetTimer then
      local inJoinState = false
      for playerID, player in next, playerManager.players, nil do
        if currentStateList[playerID + 1] == JoiningStateIndex or currentStateList[playerID + 1] == 0 then
          inJoinState = true
          break
        end
      end
      if not inJoinState then
        playlistSupport.networkVars.playerJoining = false
        playerJoinResetTimer = false
      end
    end
  end
  workOutPlayerShortage(numPlayersNeeded, isTeamGame)
end
local function exit(forced)
  if isLocal then
    playlistSupport.networkVars.playerJoining = false
    playlistSupport.networkVars.joiningStartTime = 0
  end
  playersJoiningLock = false
  playerJoinResetTimer = -1
end
local playerCheckState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(playerCheckState, stateIndex, "PlayerCheckState")
