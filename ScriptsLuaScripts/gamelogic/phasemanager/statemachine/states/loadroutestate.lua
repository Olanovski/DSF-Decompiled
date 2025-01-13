module("phaseManager")
local stateIndex = LoadRouteStateIndex
local stateComplete = false
local function debugCheck()
  print("LoadRouteState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
  NetworkLog.Write(">[LUA] LoadRouteState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
end
local function enter()
  stateComplete = false
end
local function step()
  if not stateComplete then
    if faceOffNext() then
      faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areaBuildFunctions[networkVars.modeAreaIndex](faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex])
    else
      local missionCard = cards.Missions[cards.MissionNetworkLookup[networkVars.modeIndex]]
      local challenge, missionFunctions = cardSystem.createMission(missionCard.name)
      challenge.buildSpawnPositionFunctions[networkVars.modeAreaIndex](challenge.spawnPositions[networkVars.modeAreaIndex])
    end
    lastModeAreaIndex = networkVars.modeAreaIndex
    lastModeIndex = networkVars.modeIndex
    stateComplete = true
    sendMessage(2, stateIndex)
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    if faceOffNext() then
      stateMachine.changeState(states[MoveToFaceOffStateIndex])
    else
      stateMachine.changeState(states[MoveToModeStateIndex])
    end
  end
end
local exit = function(forced)
end
local loadRouteState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(loadRouteState, stateIndex, "LoadRouteState")
