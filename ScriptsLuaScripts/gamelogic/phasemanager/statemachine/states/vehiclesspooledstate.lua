module("phaseManager")
local stateIndex = VehicleSpooledStateIndex
local stateComplete = false
local missionVehicleSpooled = false
local function debugCheck()
  NetworkLog.Write(">[LUA] VehicleSpooledState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " traffic loaded = " .. tostring(onlineMissionSync.isTrafficLoaded()) .. " vehicles loaded = " .. tostring(onlineMissionSync.areVehiclesLoaded()))
  print("VehicleSpooledState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " traffic loaded = " .. tostring(onlineMissionSync.isTrafficLoaded()) .. " vehicles loaded = " .. tostring(onlineMissionSync.areVehiclesLoaded()))
  TrafficSpooler.DumpState()
end
local function enter()
  stateComplete = false
  missionVehicleSpooled = false
end
local function step()
  if not missionVehicleSpooled and onlineMissionSync.isMissionSynched() then
    missionVehicleSpooled = true
  end
  if not stateComplete and missionVehicleSpooled then
    stateComplete = true
    sendMessage(2, stateIndex)
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    stateMachine.changeState(states[SpoolLockStateIndex])
  end
end
local exit = function(forced)
end
local vehicleSpooledState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(vehicleSpooledState, stateIndex, "VehicleSpooledState")
