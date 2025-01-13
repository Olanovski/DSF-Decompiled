module("phaseManager")
local stateIndex = GameModeCleanUpStateIndex
local stateComplete = false
local playerMessageReceived = {
  [0] = false,
  [1] = false,
  [2] = false,
  [3] = false,
  [4] = false,
  [5] = false,
  [6] = false,
  [7] = false
}
function onReceivedPlayerCleanupMessage(playerID)
  assert(playerManager.players[playerID], "Player not found")
  playerMessageReceived[playerID] = true
end
local function debugCheck()
  NetworkLog.Write(">[LUA] GameModeCleanUpState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
  print("GameModeCleanUpState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
  for playerID, players in next, playerManager.players, nil do
    if currentStateList[playerID + 1] ~= JoiningStateIndex then
      NetworkLog.Write(">[LUA] GameModeCleanUpState: playerID = " .. tostring(playerID) .. " playerMessageReceived[ playerID ] = " .. tostring(playerMessageReceived[playerID]))
      print("GameModeCleanUpState: playerID = " .. tostring(playerID) .. " playerMessageReceived[ playerID ] = " .. tostring(playerMessageReceived[playerID]))
    end
  end
end
local function enter()
  stateComplete = false
  if not stateMachine.catchUp then
    GameModeManager.startCleanupPhase()
    playerMessageReceived[localPlayer.playerID] = true
    if gameStatus.splitscreenSession then
      playerMessageReceived[0] = true
      playerMessageReceived[1] = true
    end
  else
    stateComplete = true
  end
end
local function step()
  if not stateComplete then
    stateComplete = true
    for playerID, players in next, playerManager.players, nil do
      if currentStateList[playerID + 1] ~= JoiningStateIndex and currentStateList[playerID + 1] ~= 0 and not playerMessageReceived[playerID] then
        stateComplete = false
        break
      end
    end
    if stateComplete then
      sendMessage(2, stateIndex)
    end
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    if faceOffNext() then
      stateMachine.changeState(states[WaitingForPlayersStateIndex])
      PartyBusManager.SetManageProfileAvailability(true)
    elseif gameStatus.splitscreenSession and challengeSystem.instances[networkVars.modeID] and not challengeSystem.instances[networkVars.modeID].networkVars.modeWillReset then
      stateMachine.changeState(states[EndModeStateIndex])
    else
      stateMachine.changeState(states[ChooseModeStateIndex])
      PartyBusManager.SetManageProfileAvailability(false)
    end
  end
end
local function exit(forced)
  if not stateMachine.catchUp then
    GameModeManager.stopCleanupPhase()
  end
  for i = 0, 7 do
    playerMessageReceived[i] = false
  end
end
local highLevelZapState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(highLevelZapState, stateIndex, "GameModeCleanUpState")
