module("phaseManager")
local stateIndex = MoveToModeStateIndex
local stateComplete = false
local moved = false
local screenType = false
local delayStart = false
local function moveToStartArea()
  local position = false
  if challengeSystem.instances[networkVars.modeID] then
    position = challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].target
  else
    local chosenModeName = cards.MissionNetworkLookup[networkVars.modeIndex]
    local missionData = cardSystem.createMission(chosenModeName)
    position = missionData.spawnPositions[networkVars.modeAreaIndex].target
  end
  assert(position, "Failed to get start location")
  delayStart = g_NetworkTime
  addUserUpdateFunction("shiftMove", function()
    if g_NetworkTime - delayStart > 2 then
      for localID, plr in next, localPlayerManager.players, nil do
        zapcontroller.zapTransitionToPointTracking(localID, position, true)
      end
      removeUserUpdateFunction("shiftMove")
    end
  end, 60)
end
local function debugCheck()
  NetworkLog.Write(">[LUA] MoveToModeState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
  print("MoveToModeState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
end
local function enter()
  stateComplete = false
  moved = false
  local chosenModeName = cards.MissionNetworkLookup[networkVars.modeIndex]
  local missionData = cardSystem.createMission(chosenModeName)
  if missionData.settings.teamGame then
    screenType = TeamIntroScreenIndex
  else
    screenType = SoloIntroScreenIndex
  end
end
local function step()
  if not moved then
    if phaseManager.skipIntroHUD or challengeSystem.instances[networkVars.modeID] and challengeSystem.instances[networkVars.modeID].networkVars.modeWillReset then
      moveToStartArea()
    end
    moved = true
  end
  if not stateComplete then
    stateComplete = true
    sendMessage(2, stateIndex)
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    stateMachine.changeState(states[CreateModeStateIndex])
  end
end
local function exit(forced)
  if not forced then
    if not challengeSystem.instances[networkVars.modeID] or not challengeSystem.instances[networkVars.modeID].networkVars.modeWillReset then
      if not gameStatus.splitscreenSession then
        if isLocal and networkVars.screenBlockStartTime == 0 then
          local chosenModeName = cards.MissionNetworkLookup[networkVars.modeIndex]
          local missionData = cardSystem.createMission(chosenModeName)
          networkVars.screenBlockStartTime = g_NetworkTime
          if missionData.settings.tutorial then
            networkVars.screenBlockEndTime = g_NetworkTime + 10
          else
            networkVars.screenBlockEndTime = g_NetworkTime + modeIntroLength()
          end
        end
        onlineScreenManager.showScreen(screenType, networkVars.screenBlockStartTime, onlineScreenManager.screenSortTypes.scoreNoID, cards.MissionNetworkLookup[networkVars.modeIndex], function()
          if not phaseManager.skipIntroHUD and (not challengeSystem.instances[networkVars.modeID] or not challengeSystem.instances[networkVars.modeID].networkVars.modeWillReset) then
            moveToStartArea()
          end
        end, function()
          return false
        end)
      else
        moveToStartArea()
      end
    end
  else
    removeUserUpdateFunction("shiftMove")
  end
end
local moveToModeState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(moveToModeState, stateIndex, "MoveToModeState")
