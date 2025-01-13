module("phaseManager")
local stateIndex = RaceEndStateIndex
local stateComplete = false
local raceEndStartTime = false
local instance = false
local function debugCheck()
  NetworkLog.Write(">[LUA] RaceEndState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " racePositionsFinalised = " .. tostring(onlineRaceManager.hasFinishedPositionsBeenSynced()))
  print("RaceEndState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " racePositionsFinalised = " .. tostring(onlineRaceManager.hasFinishedPositionsBeenSynced()))
end
local function enter()
  stateComplete = false
  raceEndStartTime = g_NetworkTime
  instance = challengeSystem.instances[networkVars.modeID]
  onlineRaceManager.onLocalPlayerFinishRace()
  if isLocal then
    networkVars.screenBlockStartTime = g_NetworkTime
    networkVars.screenBlockEndTime = g_NetworkTime + 2.5
  end
  local screenStack = onlineScreenManager.getScreenStack()
  if #screenStack == 0 then
    onlineScreenManager.showScreen(SoloRaceCompleteScreenIndex, networkVars.screenBlockStartTime, false, "FINISHED", function()
      return false
    end)
  end
end
local function step()
  if not stateComplete and onlineRaceManager.hasFinishedPositionsBeenSynced() and g_NetworkTime - raceEndStartTime > 2.5 then
    stateComplete = true
    sendMessage(2, stateIndex)
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    stateMachine.changeState(states[PlayerResultsSyncStateIndex])
  end
end
local function exit(forced)
  onlineRaceManager.printFinshData()
  if not forced and instance.isLocal and instance.onRacePositionsFinalised then
    instance:onRacePositionsFinalised()
  end
end
local freeDriveState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(freeDriveState, stateIndex, "raceEndState")
