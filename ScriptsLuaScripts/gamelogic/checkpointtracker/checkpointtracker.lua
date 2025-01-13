module("checkpointTracker", package.seeall)
checkpointTrackerActive = false
local trackersByID = {}
local trackersByTaskObject = {}
local checkpointID = 0
local checkpointsByID = {}
local checkpointsByCheckpointCallBack = {}
local callBacksByTrackIDCheckpointID = {}
function getCheckpointID()
  checkpointID = checkpointID + 1
  return checkpointID
end
function addCheckpoint(taskObject, checkpointData, callBack)
  NetworkLog.Write(">[LUA] checkpointTracker - addCheckpoint, checkpointData = " .. tostring(checkpointData) .. ", callBack = " .. tostring(callBack))
  assert(not checkpointsByCheckpointCallBack[callBack], "CHECKPOINT TRACKER - checkpoint already part of registered checkpoints!")
  local newCheckpointData = deepCopy(checkpointData.toolData)
  newCheckpointData.checkpointID = getCheckpointID()
  checkpointsByCheckpointCallBack[callBack] = newCheckpointData
  checkpointsByID[newCheckpointData.checkpointID] = newCheckpointData
  if not callBacksByTrackIDCheckpointID[taskObject.coreData.taskObjectID] then
    callBacksByTrackIDCheckpointID[taskObject.coreData.taskObjectID] = {}
  end
  callBacksByTrackIDCheckpointID[taskObject.coreData.taskObjectID][newCheckpointData.checkpointID] = callBack
  CheckpointTracker.AddCheckpoints(newCheckpointData)
end
function removeCheckpoint(taskObject, callBack)
  if checkpointsByCheckpointCallBack[callBack] then
    NetworkLog.Write(">[LUA] checkpointTracker - removeCheckpoint, callBack = " .. tostring(callBack))
    CheckpointTracker.RemoveCheckpoint(checkpointsByCheckpointCallBack[callBack].checkpointID)
    callBacksByTrackIDCheckpointID[taskObject.coreData.taskObjectID][checkpointsByCheckpointCallBack[callBack].checkpointID] = nil
    checkpointsByID[checkpointsByCheckpointCallBack[callBack].checkpointID] = nil
    checkpointsByCheckpointCallBack[callBack] = nil
  else
    NetworkLog.Write(">[LUA] checkpointTracker - removeCheckpoint, callBack = " .. tostring(callBack) .. " - this has been ignored")
  end
end
function removeTracker(taskObject)
  NetworkLog.Write(">[LUA] checkpointTracker - removeTracker, taskObject = " .. tostring(taskObject))
  assert(trackersByTaskObject[taskObject], "CHECKPOINT TRACKER - " .. tostring(taskObject.coreData.actor.ID) .. " not part of registered trackers!")
  CheckpointTracker.UnregisterTracker(trackersByTaskObject[taskObject].trackerID)
  trackersByID[trackersByTaskObject[taskObject].trackerID] = nil
  trackersByTaskObject[taskObject] = nil
end
function updateTracker(taskObject, gameVehicle)
  NetworkLog.Write(">[LUA] checkpointTracker - updateTracker, taskObject = " .. tostring(taskObject) .. ", gameVehicle = " .. tostring(gameVehicle))
  assert(trackersByTaskObject[taskObject], "CHECKPOINT TRACKER - " .. tostring(taskObject.coreData.actor.ID) .. " not part of registered trackers!")
  CheckpointTracker.RegisterTrackerVehicle(trackersByTaskObject[taskObject].trackerID, gameVehicle)
  trackersByTaskObject[taskObject].gameVehicle = gameVehicle
  trackersByID[trackersByTaskObject[taskObject].trackerID].gameVehicle = gameVehicle
end
function addTracker(taskObject, gameVehicle)
  NetworkLog.Write(">[LUA] checkpointTracker - addTracker, taskObject = " .. tostring(taskObject) .. ", gameVehicle = " .. tostring(gameVehicle))
  assert(not trackersByTaskObject[taskObject], "CHECKPOINT TRACKER - " .. tostring(taskObject.coreData.actor.ID) .. " already part of registered trackers!")
  if not checkpointTrackerActive then
    checkpointTrackerActive = true
  end
  trackersByTaskObject[taskObject] = {}
  trackersByTaskObject[taskObject].trackerID = taskObject.coreData.taskObjectID
  CheckpointTracker.RegisterTrackerVehicle(trackersByTaskObject[taskObject].trackerID, gameVehicle)
  trackersByTaskObject[taskObject].gameVehicle = gameVehicle
  trackersByTaskObject[taskObject].active = true
  trackersByID[trackersByTaskObject[taskObject].trackerID] = {}
  trackersByID[trackersByTaskObject[taskObject].trackerID].taskObject = taskObject
  trackersByID[trackersByTaskObject[taskObject].trackerID].gameVehicle = gameVehicle
  trackersByID[trackersByTaskObject[taskObject].trackerID].active = true
end
function release()
  NetworkLog.Write(">[LUA] checkpointTracker - release")
  if checkpointTrackerActive then
    checkpointsByID = {}
    checkpointsByCheckpointCallBack = {}
    callBacksByTrackIDCheckpointID = {}
    trackersByTaskObject = {}
    trackersByID = {}
    checkpointID = 0
    CheckpointTracker.RemoveAllCheckpoints()
    CheckpointTracker.UnregisterAllTrackers()
    checkpointTrackerActive = false
  end
end
function checkpointCallback(trackerID, checkpointID)
  NetworkLog.Write(">[LUA] checkpointTracker - checkpointCallback, trackerID = " .. tostring(trackerID) .. ", checkpointID = " .. tostring(checkpointID))
  assert(trackersByID[trackerID].active, "CHECKPOINT TRACKER - tracker " .. tostring(trackerID) .. " not part of tracker list!")
  if callBacksByTrackIDCheckpointID[trackerID][checkpointID] then
    callBacksByTrackIDCheckpointID[trackerID][checkpointID]()
  end
end
function trackerAdded(taskObject)
  return trackersByID[taskObject.coreData.taskObjectID]
end
