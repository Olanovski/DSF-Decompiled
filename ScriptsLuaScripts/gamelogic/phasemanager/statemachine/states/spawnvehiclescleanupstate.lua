module("phaseManager")
local stateIndex = SpawnVehiclesCleanupStateIndex
local stateComplete = false
local instance = false
local deleteObjects = function()
  vehicleRemovalFinished = true
  if not stateMachine.catchUp then
    for index, taskObject in next, taskSystem.taskObjects, nil do
      if taskObject.coreData.isLocal and taskObject:canBeDeleted() then
        taskObject:delete(false, false)
      end
      vehicleRemovalFinished = false
    end
    if vehicleRemovalFinished then
      for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
        if vehicle.isLocal and vehicle:canBeDeleted() then
          vehicle:delete()
        end
        vehicleRemovalFinished = false
      end
    end
  end
  return vehicleRemovalFinished
end
local function debugCheck()
  NetworkLog.Write(">[LUA] SpawnVehiclesCleanupState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " deleteObjects = " .. tostring(deleteObjects()))
  print("SpawnVehiclesCleanupState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " deleteObjects = " .. tostring(deleteObjects()))
  networkLogPrintTable(taskSystem.taskObjects, 2)
  networkLogPrintTable(vehicleManager.vehiclesBySNVID)
  printTable(taskSystem.taskObjects, 2)
  printTable(vehicleManager.vehiclesBySNVID)
end
local function enter()
  vehicleRemovalFinished = false
  stateComplete = false
  if not faceOffNext() then
    instance = challengeSystem.instances[networkVars.modeID]
  end
  deleteObjects()
end
local function step()
  if not stateComplete and deleteObjects() then
    stateComplete = true
    sendMessage(2, stateIndex)
  end
  if not faceOffNext() and instance.stepHighlightColours then
    instance.stepHighlightColours(instance)
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    stateMachine.changeState(states[SpawnVehiclesStateIndex])
  end
end
local exit = function(forced)
  Orphanage.deleteAll()
end
local spawnVehiclesCleanupState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(spawnVehiclesCleanupState, stateIndex, "SpawnVehiclesCleanupState")
