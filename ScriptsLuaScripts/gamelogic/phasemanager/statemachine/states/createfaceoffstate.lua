module("phaseManager")
local stateIndex = CreateFaceOffStateIndex
local stateComplete = false
local uniqueIDSet = false
local function debugCheck()
  NetworkLog.Write(">[LUA] CreateFaceOffState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
  print("CreateFaceOffState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
end
local function enter()
  stateComplete = false
  sessionIDCallbackCalled = true
  if isLocal then
    faceOffSystem.createFaceOff(networkVars.modeIndex, networkVars.modeAreaIndex)
  end
end
local function step()
  if isLocal and not uniqueIDSet then
    sessionIDCallbackCalled = false
    UniqueSessionID.GenereateNewSessionID("setOnlineSessionID")
    uniqueIDSet = true
  end
  if not stateComplete and sessionIDCallbackCalled then
    stateComplete = true
    sendMessage(2, stateIndex)
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    stateMachine.changeState(states[VehicleSpooledStateIndex])
  end
end
local function exit(forced)
  uniqueIDSet = false
  if not forced and phaseManager.networkVars.modeIndex ~= 0 and faceOffSystem.currentFaceOff then
    onlineSideBar.setSidebar("FaceOff")
  end
end
local createFaceOffState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(createFaceOffState, stateIndex, "CreateFaceOffState")
