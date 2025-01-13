module("progressionSystem", package.seeall)
local activityGameVehicle, lastActivityID
function triggerSoftSave(data)
  print("************************************** SOFT SAVE")
  if debugSoftSaveWarning then
    Development:add2DText(-95521, "SOFT SAVING", vec.vector(0.4, 0.5, 0, 1), vec.vector(1, 0, 0, 1), 2, 5)
  end
  local data = data
  local playerTaskObject = localPlayer.missionSupport:getMainTaskObject()
  local challengeName = playerTaskObject.coreData.instance.challenge.name
  data.playerActorID = data.playerActorID or playerTaskObject.coreData.actor.ID
  data.infoByActorID = {}
  data.rubberbandRoute = playerTaskObject.coreData.instance.rubberbandRoute
  for actorID, taskObject in next, playerTaskObject.coreData.instance.taskObjectsByActorID, nil do
    local highestMajorOrder = 0
    for i, majorOrder in next, taskObject.taskList, nil do
      if i > highestMajorOrder then
        highestMajorOrder = i
      end
    end
    data.infoByActorID[actorID] = {}
    data.infoByActorID[actorID].majorOrder = highestMajorOrder
    if data.snapToClosestRoad and data.snapToClosestRoad[actorID] then
      data.infoByActorID[actorID].snapToClosestRoad = true
    end
    if softSaveStartPositions and softSaveStartPositions[challengeName] and softSaveStartPositions[challengeName][data.progression] and softSaveStartPositions[challengeName][data.progression][actorID] then
      data.infoByActorID[actorID].spawnLocation = softSaveStartPositions[challengeName][data.progression][actorID]
    else
      data.infoByActorID[actorID].spawnLocation = {
        position = taskObject.coreData.agent.position:clone(),
        heading = taskObject.coreData.agent.heading
      }
    end
  end
  data.snapToClosestRoad = nil
  printTable(data)
  softSaveData = data
end
function getSoftSaveData()
  return softSaveData
end
function clearSoftSave()
  if softSaveData then
    softSaveData = nil
  end
end
function setActivityGameVehicle(gameVehicle, activityID)
  activityGameVehicle = gameVehicle
  progressionSystemReflection.setActivityGameVehicle(activityGameVehicle)
  lastActivityID = activityID
  local childVehicle = activityGameVehicle.childVehicle
  if childVehicle and childVehicle.model_id ~= 123 then
    local agent = vehicleManager.vehiclesByGameVehicle[childVehicle]
    if agent then
      agent:delete()
    else
      childVehicle.owner = "Script"
      GameVehicleResource.destroy(childVehicle)
    end
  end
  local parentVehicle = activityGameVehicle.parentVehicle
  if parentVehicle then
    local agent = vehicleManager.vehiclesByGameVehicle[parentVehicle]
    if agent then
      agent:delete()
    else
      parentVehicle.owner = "Script"
      GameVehicleResource.destroy(parentVehicle)
    end
  end
end
function getActivityGameVehicle()
  return activityGameVehicle
end
function getLastActivityID()
  return lastActivityID
end
function clearActivityGameVehicle()
  activityGameVehicle = nil
  progressionSystemReflection.setActivityGameVehicle(nil)
  lastActivityID = nil
end
