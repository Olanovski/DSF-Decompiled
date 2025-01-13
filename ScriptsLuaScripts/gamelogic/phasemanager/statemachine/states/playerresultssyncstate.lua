module("phaseManager")
local stateIndex = PlayerResultsSyncStateIndex
local stateComplete = false
local raceEndStartTime = false
local instance = false
local phaseStartTime = false
local isMode = false
local delayTime = false
local usesAdditSyncData = false
local syncedScores = {
  [0] = false,
  [1] = false,
  [2] = false,
  [3] = false,
  [4] = false,
  [5] = false,
  [6] = false,
  [7] = false
}
local additionalSyncData = {
  [0] = false,
  [1] = false,
  [2] = false,
  [3] = false,
  [4] = false,
  [5] = false,
  [6] = false,
  [7] = false
}
local syncedTeamScores = {
  [1] = false,
  [2] = false
}
function onReceivedPlayerScore(playerID, score)
  if playerManager.players[playerID] then
    syncedScores[playerID] = score
  else
    NetworkLog.Write(">[LUA] PlayerResultsSyncState: Warning, we have received a score for a player that does not exist, not storing. playerID = " .. tostring(playerID) .. " score = " .. tostring(score))
  end
end
function onReceivedPlayerAdditionalData(playerID, data)
  if playerManager.players[playerID] then
    additionalSyncData[playerID] = data
  else
    NetworkLog.Write(">[LUA] PlayerResultsSyncState: Warning, we have received additional data for a player that does not exist, not storing. playerID = " .. tostring(playerID) .. " data = " .. tostring(data))
  end
end
local strPID = false
local strScore = false
local index = 1
local function readMessage(value)
  assert(index < 3, "to many numbers")
  if index == 1 then
    strPID = tonumber(value)
  elseif index == 2 then
    strScore = tonumber(value)
  end
  index = index + 1
end
function onReceivedPlayerRoundScore(message)
  strPID = false
  strScore = false
  index = 1
  string.gsub(message, "(.-),", readMessage)
  if playerManager.players[strPID] then
    syncedScores[strPID] = strScore
  else
    NetworkLog.Write(">[LUA] PlayerResultsSyncState: Warning, we have received a packed score for a player that does not exist, not storing. playerID = " .. tostring(strPID) .. " strScore = " .. tostring(strScore))
  end
end
function onReceivedTeamOneScore(score)
  syncedTeamScores[1] = score
end
function onReceivedTeamTwoScore(score)
  syncedTeamScores[2] = score
end
local function debugCheck()
  for playerID, player in next, playerManager.players, nil do
    NetworkLog.Write(">[LUA] PlayerResultsSyncState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " playerID = " .. tostring(playerID) .. " score = " .. tostring(syncedScores[playerID]))
    print("PlayerResultsSyncState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " playerID = " .. tostring(playerID) .. " score = " .. tostring(syncedScores[playerID]))
  end
  NetworkLog.Write(">[LUA] PlayerResultsSyncState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " syncedTeamScores[ 1 ] = " .. tostring(syncedTeamScores[1]) .. " syncedTeamScores[ 2 ] = " .. tostring(syncedTeamScores[2]))
  print("PlayerResultsSyncState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " syncedTeamScores[ 1 ] = " .. tostring(syncedTeamScores[1]) .. " syncedTeamScores[ 2 ] = " .. tostring(syncedTeamScores[2]))
end
local function enter()
  stateComplete = false
  usesAdditSyncData = false
  if challengeSystem.instances[networkVars.modeID] then
    instance = challengeSystem.instances[networkVars.modeID]
    isMode = true
    if instance.challenge.settings.additionalSyncData then
      usesAdditSyncData = true
    end
  else
    instance = faceOffSystem.currentFaceOff
    isMode = false
  end
  assert(instance, "No instance found - " .. tostring(phaseManager.faceOffNext()))
  if not isMode or isMode and not instance.challenge.settings.teamGame then
    syncedTeamScores[1] = true
    syncedTeamScores[2] = true
  end
  if instance.getLocalPlayerFinalScore then
    local score = instance:getLocalPlayerFinalScore()
    syncedScores[localPlayer.playerID] = score
    PlayerGamePlay.broadcastMessage(33, tostring(score))
  end
  if usesAdditSyncData then
    assert(instance.getPlayerAdditionalSyncData, "can't sync additional sync data. Function not found")
    local syncData = instance:getPlayerAdditionalSyncData(localPlayer.playerID)
    additionalSyncData[localPlayer.playerID] = syncData
    PlayerGamePlay.broadcastMessage(37, tostring(syncData))
  end
  if isLocal and instance.getPlayerFinalScore and not instance.getLocalPlayerFinalScore then
    local score = 0
    local sendString = false
    for playerID, player in next, playerManager.players, nil do
      if currentStateList[playerID + 1] ~= JoiningStateIndex and currentStateList[playerID + 1] ~= 0 then
        score = instance:getPlayerFinalScore(playerID)
        sendString = tostring(playerID) .. "," .. tostring(score) .. ","
        PlayerGamePlay.broadcastMessage(34, sendString)
        syncedScores[playerID] = score
      end
    end
  end
  if isLocal and instance.getTeamFinalScore then
    local teamOne, teamTwo = instance:getTeamFinalScore()
    PlayerGamePlay.broadcastMessage(35, tostring(teamOne))
    PlayerGamePlay.broadcastMessage(36, tostring(teamTwo))
    syncedTeamScores[1] = teamOne
    syncedTeamScores[2] = teamTwo
  end
  local showScreen = true
  delayTime = 2.5
  if isMode and not instance.challenge.settings.team and instance.challenge.settings.raceMode then
    showScreen = false
    delayTime = 0
  end
  if showScreen then
    if isLocal then
      networkVars.screenBlockStartTime = g_NetworkTime
      networkVars.screenBlockEndTime = g_NetworkTime + 2.5
    end
    onlineScreenManager.showScreen(FinishedScreenIndex, networkVars.screenBlockStartTime, false, "FINISHED", function()
      return false
    end)
  end
  phaseStartTime = g_NetworkTime
end
local function step()
  for i = 0, 7 do
    if syncedScores[i] and not playerManager.players[i] then
      syncedScores[i] = false
    end
  end
  if not stateComplete then
    stateComplete = true
    for playerID, player in next, playerManager.players, nil do
      if currentStateList[playerID + 1] ~= JoiningStateIndex and currentStateList[playerID + 1] ~= 0 and (not syncedScores[playerID] or usesAdditSyncData and not additionalSyncData[playerID]) then
        stateComplete = false
        break
      end
    end
    if stateComplete and (not syncedTeamScores[1] or not syncedTeamScores[2]) then
      stateComplete = false
    end
    if g_NetworkTime - phaseStartTime < delayTime then
      stateComplete = false
    end
    if g_NetworkTime - phaseStartTime > 10 then
      stateComplete = true
    end
    if stateComplete then
      sendMessage(2, stateIndex)
    end
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    if not phaseManager.faceOffNext() then
      stateMachine.changeState(states[ModeResetStateIndex])
    else
      stateMachine.changeState(states[EndFaceOffStateIndex])
    end
  end
end
local function exit(forced)
  onlineScreenManager.endScreen("FINISHED", forced)
  if not forced then
    local score = 0
    for playerID, player in next, playerManager.players, nil do
      if currentStateList[playerID + 1] ~= JoiningStateIndex and currentStateList[playerID + 1] ~= 0 then
        if not syncedScores[playerID] and instance.getPlayerFinalScore then
          score = instance:getPlayerFinalScore(playerID)
          syncedScores[playerID] = score
        end
        if usesAdditSyncData and not additionalSyncData[playerID] then
          additionalSyncData[playerID] = instance:getPlayerAdditionalSyncData(playerID)
        end
      end
    end
    if instance.getTeamFinalScore then
      local teamOne, teamTwo = instance:getTeamFinalScore()
      if not syncedTeamScores[1] then
        syncedTeamScores[1] = teamOne
      end
      if not syncedTeamScores[2] then
        syncedTeamScores[2] = teamTwo
      end
    end
    for playerID, player in next, playerManager.players, nil do
      if not syncedScores[playerID] then
        syncedScores[playerID] = 0
      end
      if usesAdditSyncData and not additionalSyncData[playerID] then
        additionalSyncData[playerID] = 0
      end
    end
    NetworkLog.Write(">[LUA] - Final Synced Score")
    for playerID, player in next, playerManager.players, nil do
      print(">> PlayerResultsSyncState - Player ID: " .. tostring(playerID) .. "  Score: " .. tostring(syncedScores[playerID]))
      NetworkLog.Write("          Player ID: " .. tostring(playerID) .. "  Score: " .. tostring(syncedScores[playerID]))
    end
    NetworkLog.Write("          Synced additional data: " .. tostring(usesAdditSyncData))
    if usesAdditSyncData then
      for playerID, player in next, playerManager.players, nil do
        print(">> PlayerResultsSyncState Add Data - Player ID: " .. tostring(playerID) .. "  Score: " .. tostring(additionalSyncData[playerID]))
        NetworkLog.Write("          Additional Data - Player ID: " .. tostring(playerID) .. "  Score: " .. tostring(additionalSyncData[playerID]))
      end
    end
    print(">> PlayerResultsSyncState - syncedTeamScores[ 1 ]: " .. tostring(syncedTeamScores[1]))
    NetworkLog.Write("          syncedTeamScores[ 1 ]: " .. tostring(syncedTeamScores[1]))
    print(">> PlayerResultsSyncState - syncedTeamScores[ 2 ]: " .. tostring(syncedTeamScores[2]))
    NetworkLog.Write("          syncedTeamScores[ 2 ]: " .. tostring(syncedTeamScores[2]))
    NetworkLog.Write(">[LUA] - End Final Synced Score")
    if phaseManager.faceOffNext() then
      instance:onFinalScoresSynced(syncedScores)
    else
      if instance.challenge.missionCompleteData then
        instance.challenge.missionCompleteData(instance, syncedScores, syncedTeamScores, additionalSyncData)
      end
      if not instance:shouldReset() and instance.challenge.onlineStatisticsData and gameStatus.onlineSessionType == gameStatus.onlineSessionID.public and not gameStatus.onlineIsLan then
        instance.challenge.onlineStatisticsData(syncedScores, instance, additionalSyncData)
      end
    end
  end
  for i = 0, 7 do
    syncedScores[i] = false
    additionalSyncData[i] = false
  end
  syncedTeamScores[1] = false
  syncedTeamScores[2] = false
  usesAdditSyncData = false
end
local freeDriveState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(freeDriveState, stateIndex, "playerScoreSyncState")
