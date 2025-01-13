module("phaseManager", package.seeall)
STATE_DEBUG_FLAG = false
isLocal = false
SNOID = false
states = {}
raceManagerSet = false
clearModeRoute = false
clearFaceOffRoute = false
initialiseComplete = false
isTeamGame = false
introHUD = false
waitForPlayersRequired = true
raceModePlayed = false
lastModeAreaIndex = false
lastModeIndex = false
lastTurnTaker = false
freeDriveModeID = false
faceOffIntroTimeOut = false
introScreenTimeOutSplitScreen = 6
modeCompleteLengthSplitScreen = 25
roundCompleteLengthSplitScreen = 5
resultScreenLengthSplitScreen = 5
modeIntroLengthSplitScreen = 15
allowTooFewPlayers = false
playerFaceoffStartTime = false
playerFaceoffEndTime = false
addFaceOffXP = false
modeDebugInfo = false
modeTimedOut = false
playerIsObjective = false
playerHasWonRound = false
failedSSRound = false
lastSSRoundNum = false
ssFadedOut = false
splitscreenModeLoaded = false
joiningPlayerHoldUp = false
skipIntroHUD = false
returnToBusCalled = false
sessionIDCallbackCalled = true
publicWaitingForPlayersShownCOOP = false
playedTutorial = false
waitingForPlayersTimeOut = 120
trackingTableData = {}
trackingTableData.missionID = false
trackingTableData.team = false
trackingTableData.displayName = false
playerShortage = false
lastAppliedMood = false
READY_CHECK_DEBUG_ON = false
startHUDCleanupFunction = false
networkVars = {
  debugCheckIsLocal = function()
    return isLocal
  end,
  updateRequired = true,
  __newindex = networkParsing.metaSetNetworkVar,
  __index = {
    moodIndex = 0,
    nextTurnTaker = 255,
    phase = 0,
    modeIndex = 0,
    modeAreaIndex = 0,
    missionVehicleIndex = 0,
    vehicleFreqIndex = 0,
    faceOffNext = true,
    modeID = 0,
    waitForPlayerStartTime = 0,
    screenBlockStartTime = 0,
    screenBlockEndTime = 0,
    screenEarlyEnd = 0,
    toFewPlayersType = 3,
    playersReady = 0,
    sessionID = 0,
    trafficID = 0,
    gameStartTime = 0
  }
}
setmetatable(networkVars, networkVars)
function addState(state, index, debugName)
  assert(not states[index], "PHASE MANAGER, state already uses " .. tostring(index) .. "index, name " .. tostring(debugName))
  states[index] = state
  states[index].name = debugName
end
function initiate()
  framework.seed()
  if gameStatus.onlineSession then
    vehicleManager.multiplayerBusManager.loadRoute()
    scoringSystem.enableFeedback = false
    CityLockManager.CityLockState = "CityLockingLevel4"
    CityLockManager.CityLockActive = true
    CityLockManager.FadeInDistance = 80
    playedTutorial = false
    playerShortage = false
    if Network.isOnlineHost() then
      isLocal = true
      phaseManager.playlistSupport.initiate()
      createSNOFromObject()
      if gameStatus.onlineSessionType == gameStatus.onlineSessionID.private then
        networkVars.toFewPlayersType = 0
      end
    end
  end
end
function update()
  if not Network.isOnlineHost() or not isLocal then
  end
  if not isLocal or not Network.isOnlineHost() then
  end
  stateMachine.step()
  phaseManager.playlistSupport.update()
  if isLocal then
    updateSNOFromObject()
    stepJoiningPlayers()
  end
end
joiningPlayersList = {
  [1] = {messageSent = false},
  [2] = {messageSent = false},
  [3] = {messageSent = false},
  [4] = {messageSent = false},
  [5] = {messageSent = false},
  [6] = {messageSent = false},
  [7] = {messageSent = false},
  [8] = {messageSent = false}
}
waitForJoinTimeOut = 1
function stepJoiningPlayers()
  joiningPlayerHoldUp = false
  for playerID, stateIndex in ipairs(currentStateList) do
    if stateIndex == JoiningStateIndex then
      if playerID == localPlayer.playerID + 1 then
        joiningPlayersList[playerID].messageSent = false
        joiningPlayersList[playerID].wait = nil
      elseif joiningPlayersList[playerID].wait then
        if g_NetworkTime - joiningPlayersList[playerID].wait > waitForJoinTimeOut then
          joiningPlayersList[playerID].wait = nil
        end
      elseif not joiningPlayersList[playerID].messageSent and inSafeState() then
        joiningPlayerHoldUp = true
        joiningPlayersList[playerID].messageSent = true
        if networkVars.phase == NewSessionStateIndex and vehicleManager.multiplayerBusManager.multiplayerBusActive then
          NetworkLog.Write(">[LUA] PHASE MANAGER - stepJoiningPlayers - join bus")
          PlayerGamePlay.sendMessage(playerID - 1, 10, tostring(NewSessionStateIndex))
        else
          NetworkLog.Write(">[LUA] PHASE MANAGER - stepJoiningPlayers - join game")
          PlayerGamePlay.sendMessage(playerID - 1, 10, tostring(JoiningStateIndex))
        end
      elseif joiningPlayersList[playerID].messageSent then
        joiningPlayerHoldUp = true
      end
    elseif joiningPlayersList[playerID].messageSent then
      joiningPlayersList[playerID].messageSent = false
      joiningPlayersList[playerID].wait = nil
    end
  end
end
function inSafeState()
  if networkVars.phase == NewSessionStateIndex and vehicleManager.multiplayerBusManager.multiplayerBusActive then
    NetworkLog.Write(">[LUA] PHASE MANAGER - inSafeState - one " .. tostring(networkVars.phase))
    return true
  elseif networkVars.phase == HighLevelZapStateIndex or networkVars.phase == WaitingForPlayersStateIndex or networkVars.phase == ChooseModeStateIndex or networkVars.phase == ChooseFaceOffStateIndex or networkVars.phase == LoadRouteStateIndex or networkVars.phase == MoveToFaceOffStateIndex or networkVars.phase == MoveToModeStateIndex or networkVars.phase == CreateModeStateIndex or networkVars.phase == CreateFaceOffStateIndex or networkVars.phase == VehicleSpooledStateIndex or networkVars.phase == SpoolLockStateIndex or networkVars.phase == TeamMoveToModeStateIndex or networkVars.phase == RunModeStateIndex and challengeSystem.instances[networkVars.modeID] and not challengeSystem.instances[networkVars.modeID]:instanceComplete() or networkVars.phase == RunFaceOffStateIndex and faceOffSystem.currentFaceOff and not faceOffSystem.currentFaceOff:instanceComplete() then
    NetworkLog.Write(">[LUA] PHASE MANAGER - inSafeState - one " .. tostring(networkVars.phase))
    return true
  end
  return false
end
function purge()
  stateMachine.setSupportState(false)
  timeToJoinScore.lastJoinScore = false
  PlayerGamePlay.allowTeamShuffling(false)
  zapWeaponSupport.resetZapWeapons()
  Menu.HideZapPreview(false)
  sessionIDCallbackCalled = true
  propSystem.cleanupRuntimeProps()
  stateMachine.release()
  onlineScreenManager.purge()
  onlineScreenManager.clearPlayerTables()
  onlineRaceManager.purge()
  checkpointTracker.release()
  zap.zapSpawn.clearZapSpawnFailedCallbacks()
  phaseManager.playlistSupport.purge()
  zapcontroller.HideFlare(true)
  clearModeRoute = false
  clearFaceOffRoute = false
  isLocal = false
  SNOID = false
  initialiseComplete = false
  isTeamGame = false
  introHUD = false
  waitForPlayersRequired = true
  raceModePlayed = false
  lastTurnTaker = false
  freeDriveModeID = false
  skipIntroHUD = false
  returnToBusCalled = false
  addFaceOffXP = false
  playerFaceoffStartTime = false
  playerFaceoffEndTime = false
  splitscreenModeLoaded = false
  trackingTableData = {}
  trackingTableData.missionID = false
  trackingTableData.team = false
  trackingTableData.displayName = false
  publicWaitingForPlayersShownCOOP = false
  PartyBusManager.SetManageProfileAvailability(true)
  networkVars.__index.moodIndex = 0
  networkVars.__index.nextTurnTaker = 255
  networkVars.__index.phase = 0
  networkVars.__index.modeIndex = 0
  networkVars.__index.modeAreaIndex = 0
  networkVars.__index.vehicleFreqIndex = 0
  networkVars.__index.missionVehicleIndex = 0
  networkVars.__index.faceOffNext = true
  networkVars.__index.modeID = 0
  networkVars.__index.waitForPlayerStartTime = 0
  networkVars.__index.screenBlockStartTime = 0
  networkVars.__index.screenBlockEndTime = 0
  networkVars.__index.screenEarlyEnd = 0
  networkVars.__index.toFewPlayersType = 3
  networkVars.__index.playersReady = 0
  networkVars.__index.sessionID = 0
  networkVars.__index.trafficID = 0
  networkVars.__index.gameStartTime = 0
  for localID, plr in next, localPlayerManager.players, nil do
    zapcontroller.EnableZapInput(false, plr.localID)
    plr:blockAbility("zap", false)
    scoreSystem.stopAbilityDrain(plr.localID, false)
    scoreSystem.stopAbilityGain(plr.localID, false)
  end
  onlineProgressionSystem.onlineEnableUnlockedAbilities()
  localPlayer.controllerInterface:createCallbacks()
  joiningPlayersList = {
    [1] = {joining = false, messageSent = false},
    [2] = {joining = false, messageSent = false},
    [3] = {joining = false, messageSent = false},
    [4] = {joining = false, messageSent = false},
    [5] = {joining = false, messageSent = false},
    [6] = {joining = false, messageSent = false},
    [7] = {joining = false, messageSent = false},
    [8] = {joining = false, messageSent = false}
  }
  clearAllModeUsedIndexes()
  zapcontroller.ZapSettings(1, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(2, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(3, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(4, {CanSelectVehicles = true})
  removeUserUpdateFunction("shiftMove")
  removeUserUpdateFunction("hostMigrationTest")
  removeUserUpdateFunction("hostMigrationBusTest")
  removeUserUpdateFunction("showOnlineSidebar")
  removeUserUpdateFunction("removeUnwantedImportantVehicles")
  if startHUDCleanupFunction then
    startHUDCleanupFunction()
    startHUDCleanupFunction = false
  end
  scoringSystem.enableFeedback = unlockProgressionTable.willpowerEnabled
  feedbackSystem.multiplayerSupport.clearPostGameFeedback()
  lastAppliedMood = false
  highLevelZapTriggered = false
  zapcontroller.setSpoolerAttached(true)
end
function turnOnAllowTooFewPlayers(byMessage)
  allowTooFewPlayers = not allowTooFewPlayers
  if not byMessage then
    PlayerGamePlay.broadcastMessage(27, "")
  end
end
function toggleOnlineDebugInfo()
  modeDebugInfo = not modeDebugInfo
end
local getUniqueSessionMissionID = function()
  return networkVars.sessionID
end
_G.onlineGetUniqueSessionMissionID = getUniqueSessionMissionID
function inMission()
  local inRunModeState = phaseManager.networkVars.phase == RunModeStateIndex
  return gameStatus.onlineSession and inRunModeState
end
function getCurrentPhase()
  return phaseManager.networkVars.phase
end
_G.getCurrentPhase = getCurrentPhase
local getCurrentTeamScores = function(modeID)
  local yourTeam, theirTeam = 0, 0
  assert(modeID ~= 0)
  local instance = challengeSystem.instances[modeID]
  local success = false
  if instance and instance.challenge.name then
    if instance.challenge.name == "MP team circuit race" then
      packageTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
      if packageTO and packageTO.namedTasks.gateTracking and packageTO.namedTasks.gateTracking.networkVars.redTeamScore then
        success = true
        yourTeam = packageTO.namedTasks.gateTracking.networkVars.blueTeamScore
        theirTeam = packageTO.namedTasks.gateTracking.networkVars.redTeamScore
      end
    elseif instance.challenge.name == "MP burning rubber" then
      local blueTorchTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
      local redTorchTO = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
      local checkpointsPerLap = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
      if blueTorchTO and redTorchTO and blueTorchTO.namedTasks.checkpoints and redTorchTO.namedTasks.checkpoints then
        if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
          if blueTorchTO.namedTasks.checkpoints.networkVars.checkpoints and blueTorchTO.namedTasks.checkpoints.networkVars.laps then
            success = true
            yourTeam = blueTorchTO.namedTasks.checkpoints.networkVars.checkpoints - 1 + blueTorchTO.namedTasks.checkpoints.networkVars.laps * checkpointsPerLap
            theirTeam = redTorchTO.namedTasks.checkpoints.networkVars.checkpoints - 1 + redTorchTO.namedTasks.checkpoints.networkVars.laps * checkpointsPerLap
          end
        elseif PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 2 and blueTorchTO.namedTasks.checkpoints.networkVars.checkpoints and blueTorchTO.namedTasks.checkpoints.networkVars.laps then
          success = true
          yourTeam = redTorchTO.namedTasks.checkpoints.networkVars.checkpoints - 1 + redTorchTO.namedTasks.checkpoints.networkVars.laps * checkpointsPerLap
          theirTeam = blueTorchTO.namedTasks.checkpoints.networkVars.checkpoints - 1 + blueTorchTO.namedTasks.checkpoints.networkVars.laps * checkpointsPerLap
        end
      end
    elseif instance.challenge.name == "MP rush down" then
      local packageTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
      if packageTO and packageTO.namedTasks.score then
        if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
          if packageTO.namedTasks.score.networkVars.defenceScore then
            success = true
            yourTeam = packageTO.namedTasks.score.networkVars.attackScore
            theirTeam = packageTO.namedTasks.score.networkVars.defenceScore
          end
        elseif PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 2 and packageTO.namedTasks.score.networkVars.defenceScore then
          success = true
          yourTeam = packageTO.namedTasks.score.networkVars.defenceScore
          theirTeam = packageTO.namedTasks.score.networkVars.attackScore
        end
      end
    elseif instance.challenge.name == "MP tug of war" then
      local packageTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
      if packageTO and packageTO.namedTasks.score then
        if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
          if instance.teamScores.team1 and packageTO.namedTasks.score.networkVars.blueTeam then
            success = true
            yourTeam = packageTO.namedTasks.score.networkVars.blueTeam + instance.teamScores.team1
            theirTeam = packageTO.namedTasks.score.networkVars.redTeam + instance.teamScores.team2
          end
        elseif PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 2 and instance.teamScores.team1 and packageTO.namedTasks.score.networkVars.blueTeam then
          success = true
          yourTeam = packageTO.namedTasks.score.networkVars.redTeam + instance.teamScores.team2
          theirTeam = packageTO.namedTasks.score.networkVars.blueTeam + instance.teamScores.team1
        end
      end
    end
  end
  return success, yourTeam, theirTeam
end
function registerPlayer(player)
  local TO = localPlayer.getTaskObject()
  if TO and phaseManager.isLocal == true and TO.initiated and stateMachine.getCurrentStateIndex() == RunModeStateIndex and phaseManager.isTeamGame and phaseManager.networkVars.modeID and phaseManager.networkVars.modeID ~= 0 then
    local success, yourTeam, theirTeam = getCurrentTeamScores(phaseManager.networkVars.modeID)
    if success then
      if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == PlayerGamePlay.getPlayerTeam(player.playerID) then
        PlayerGamePlay.sendMessage(player.playerID, 7, tostring(yourTeam))
        PlayerGamePlay.sendMessage(player.playerID, 8, tostring(theirTeam))
      else
        PlayerGamePlay.sendMessage(player.playerID, 8, tostring(yourTeam))
        PlayerGamePlay.sendMessage(player.playerID, 7, tostring(theirTeam))
      end
    end
  end
  if phaseManager.isLocal and not gameStatus.splitscreenSession and gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode then
    if phaseManager.playlistSupport.networkVars.faceOffsEnabled then
      faceOffSystem.informPlayerOfPlayedFaceOffs(player.playerID)
      phaseManager.informPlayerOfFaceOffsUsedIndexes(player.playerID)
    end
    if phaseManager.playlistSupport.currentPlaylist then
      for i, modeName in ipairs(phaseManager.playlistSupport.currentPlaylist) do
        phaseManager.informPlayerOfModesUsedIndexes(player.playerID, modeName)
      end
    end
  end
  if stateMachine.getCurrentStateIndex() == RunModeStateIndex and challengeSystem.instances[phaseManager.networkVars.modeID] and challengeSystem.instances[phaseManager.networkVars.modeID].onPlayerJoinInProgress then
    challengeSystem.instances[phaseManager.networkVars.modeID].onPlayerJoinInProgress(player)
  end
  faceOffSystem.playerHasJoined(player)
end
function unregisterPlayer(player)
end
local setSessionID = function(id)
  networkVars.sessionID = id
  sessionIDCallbackCalled = true
end
_G.setOnlineSessionID = setSessionID
function readyCheck()
  if stateMachine.catchUp then
    if READY_CHECK_DEBUG_ON then
      print("READYCHECK - TRUE - on catch up")
    end
    return true
  end
  if not isLocal and stateMachine.moveState then
    if READY_CHECK_DEBUG_ON then
      print("READYCHECK - TRUE - not local and move state is set")
    end
    return true
  end
  if isLocal and not joiningPlayerHoldUp then
    for localID, player in next, playerManager.players, nil do
      if currentStateList[localID + 1] ~= 0 and currentStateList[localID + 1] ~= 21 and localPlayerManager.players[1] ~= player then
        for innerlocalID, innerPlayer in next, playerManager.players, nil do
          if currentStateList[innerlocalID + 1] ~= 0 and currentStateList[innerlocalID + 1] ~= 21 and currentStateList[localID + 1] ~= currentStateList[innerlocalID + 1] and localPlayerManager.players[1] ~= playerManager.players[innerlocalID] then
            if READY_CHECK_DEBUG_ON then
              print("READYCHECK - FALSE - outter playerID and current state = " .. tostring(localID) .. " " .. tostring(currentStateList[localID + 1]) .. " - inner playerID and current state = " .. tostring(innerlocalID) .. " " .. tostring(currentStateList[innerlocalID + 1]))
            end
            return false
          end
        end
        for innerlocalID, innerPlayer in next, playerManager.players, nil do
          if currentStateList[innerlocalID + 1] ~= 0 and currentStateList[innerlocalID + 1] ~= 21 and moveToStateList[localID + 1] ~= moveToStateList[innerlocalID + 1] and localPlayerManager.players[1] ~= playerManager.players[innerlocalID] then
            if READY_CHECK_DEBUG_ON then
              print("READYCHECK - FALSE - outter playerID, current state and move to state = " .. tostring(localID) .. " " .. tostring(currentStateList[localID + 1]) .. " " .. tostring(moveToStateList[localID + 1]) .. " - innder playerID, current state and move to state = " .. tostring(innerlocalID) .. " " .. tostring(currentStateList[innerlocalID + 1]) .. " " .. tostring(moveToStateList[innerlocalID + 1]))
            end
            return false
          end
        end
      end
    end
    if READY_CHECK_DEBUG_ON then
      print("READYCHECK - TRUE - everyone is ready")
    end
    return true
  end
  if READY_CHECK_DEBUG_ON then
    print("READYCHECK - FALSE - default out")
  end
  return false
end
function toFewPlayers(type)
  if isLocal then
    networkVars.toFewPlayersType = type
    if networkVars.toFewPlayersType == 2 then
      PlayerGamePlay.rebalanceTeams()
    end
  else
    sendMessage(5, type)
  end
end
function clearLoadedRouteData()
  if clearModeRoute then
    local missionCard = cards.Missions[cards.MissionNetworkLookup[lastModeIndex]]
    local challenge, missionFunctions = cardSystem.createMission(missionCard.name)
    challenge.clearSpawnPositionFunction(challenge.spawnPositions[lastModeAreaIndex])
  elseif clearFaceOffRoute then
    faceOffSystem.faceOffPool[lastModeIndex].settings.clearRouteFunction(faceOffSystem.faceOffPool[lastModeIndex].settings.areas[lastModeAreaIndex])
  end
  lastModeAreaIndex = false
  lastModeIndex = false
  clearFaceOffRoute = false
  clearModeRoute = false
end
function modeOrFaceOffEnded()
  clearLoadedRouteData()
  if isLocal then
    updateFaceOffFlag(true)
    networkVars.modeIndex = 0
    networkVars.modeAreaIndex = 0
    networkVars.modeID = 0
  else
    sendMessage(6)
  end
end
function updateFaceOffFlag(value)
  if isLocal and phaseManager.playlistSupport.networkVars.faceOffsEnabled then
    networkVars.faceOffNext = value
  end
end
function faceOffNext()
  if phaseManager.playlistSupport.networkVars.faceOffsEnabled then
    return networkVars.faceOffNext
  end
  return false
end
function isCoop(mode)
  return phaseManager.playlistSupport.modePool.cooperative[mode]
end
function isComp(mode)
  return phaseManager.playlistSupport.modePool.competitive[mode]
end
function faceOffPhaseLength()
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    return faceOffPhaseLengthPublic
  else
    return faceOffPhaseLengthPrivate
  end
end
function faceOffIntroLength()
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    return faceOffIntroLengthPublic
  else
    return faceOffIntroLengthPrivate
  end
end
function faceOffCompleteLength()
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    return faceOffCompleteLengthPublic
  else
    return faceOffCompleteLengthPrivate
  end
end
function waitForPlayersLength()
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    return waitForPlayersLengthCompPublic
  else
    return waitForPlayersLengthCompPrivate
  end
end
function modeIntroLength()
  if gameStatus.splitscreenSession then
    return modeIntroLengthSplitScreen
  elseif gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    return modeIntroLengthCompPublic
  else
    return modeIntroLengthCompPrivate
  end
end
function introScreenTimeOut()
  if gameStatus.splitscreenSession then
    return introScreenTimeOutSplitScreen
  elseif gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    return introScreenTimeOutCompPublic
  else
    return introScreenTimeOutCompPrivate
  end
end
function modeCompleteLength()
  if gameStatus.splitscreenSession then
    return modeCompleteLengthSplitScreen
  elseif gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    return modeCompleteLengthCompPublic
  else
    return modeCompleteLengthCompPrivate
  end
end
function roundCompleteLength()
  if gameStatus.splitscreenSession then
    return roundCompleteLengthSplitScreen
  elseif gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    return roundCompleteLengthCompPublic
  else
    return roundCompleteLengthCompPrivate
  end
end
function resultScreenLength()
  if gameStatus.splitscreenSession then
    return resultScreenLengthSplitScreen
  elseif gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    return resultScreenLengthCompPublic
  else
    return resultScreenLengthCompPrivate
  end
end
local numPlayers = 0
local playerShortageA = 0
local playerShortageB = 0
local teamOneCount = 0
local teamTwoCount = 0
local playerTeam = -1
function soloModePlayerShortageCheck(minPlayerRequirment)
  numPlayers = 0
  for playerID, player in next, playerManager.players, nil do
    if currentStateList[playerID + 1] ~= JoiningStateIndex and currentStateList[playerID + 1] ~= 0 then
      numPlayers = numPlayers + 1
    end
  end
  return minPlayerRequirment - numPlayers, numPlayers
end
function teamModePlayerShortageCheck(minPlayerRequirment)
  teamOneCount = 0
  teamTwoCount = 0
  playerTeam = -1
  for playerID, player in next, playerManager.players, nil do
    playerTeam = PlayerGamePlay.getPlayerTeam(playerID)
    if playerTeam == 1 then
      if currentStateList[playerID + 1] ~= JoiningStateIndex and currentStateList[playerID + 1] ~= 0 then
        teamOneCount = teamOneCount + 1
      end
    elseif playerTeam == 2 and currentStateList[playerID + 1] ~= JoiningStateIndex and currentStateList[playerID + 1] ~= 0 then
      teamTwoCount = teamTwoCount + 1
    end
  end
  numPlayers = teamOneCount + teamTwoCount
  playerShortageA = minPlayerRequirment - teamOneCount
  playerShortageB = minPlayerRequirment - teamTwoCount
  return playerShortageA, playerShortageB, numPlayers, teamOneCount, teamTwoCount
end
function workOutPlayerShortage(minPlayerRequirment, teamGame)
  if not teamGame then
    playerShortageA = soloModePlayerShortageCheck(minPlayerRequirment)
    playerShortageB = 0
  else
    playerShortageA, playerShortageB = teamModePlayerShortageCheck(minPlayerRequirment)
  end
  if allowTooFewPlayers then
    playerShortageA = 0
    playerShortageB = 0
  end
  if playerShortageA < 0 then
    playerShortageA = 0
  end
  if playerShortageB < 0 then
    playerShortageB = 0
  end
  if not playerShortage and (playerShortageA > 0 or playerShortageB > 0) then
    playerShortage = true
  elseif playerShortage and playerShortageA + playerShortageB == 0 then
    playerShortage = false
  end
end
function forcedToJoining()
  vehicleManager.markAllForDeletion()
  onlineRaceManager.purge()
  checkpointTracker.release()
end
local return1, return2, return3
function markAllForDeletion()
  return1 = challengeSystem.markAllForDeletion()
  return2 = taskSystem.markAllForDeletion()
  return3 = vehicleManager.markAllForDeletion()
  return return2 and return1 and return3
end
function allObjectsDeleted()
  return1 = challengeSystem.allObjectsDeleted()
  return2 = taskSystem.allObjectsDeleted()
  return return1 and return2
end
function removeFlaggedForDeletionObjects()
  challengeSystem.removeFlaggedForDeletionObjects()
  taskSystem.removeFlaggedForDeletionObjects()
end
function markAllRoundObjectsForDeletion()
  return1 = taskSystem.markAllForDeletion()
  return2 = vehicleManager.markAllForDeletion()
  return return1 and return2
end
function allRoundObjectsDeleted()
  return taskSystem.allObjectsDeleted()
end
function removeUnwantedImportantVehicles()
  for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
    if vehicle.isLocal and vehicle.networkVars.onlineOwnerID and not playerManager.players[vehicle.networkVars.onlineOwnerID] then
      vehicle.networkVars.onlineRequiredVehicle = false
      vehicle.networkVars.onlineOwnerID = nil
    end
  end
end
