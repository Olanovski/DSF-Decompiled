module("taskSystem")
restrictedObjects = {}
local toggleNormalZapRestriction = function(taskObject, restrictionData)
  restrictionData.normalZapRestricted = not restrictionData.normalZapRestricted
  for localID, plr in next, localPlayerManager.players, nil do
    if restrictionData.normalZapRestricted then
      if taskObject.coreData.agent.isVehicle then
        zapcontroller.AddLockedVehicle(localID, {
          gameVehicle = taskObject.coreData.agent.gameVehicle
        })
      elseif taskObject.coreData.agent.owner then
        zapcontroller.AddLockedVehicle(localID, {
          gameVehicle = taskObject.coreData.agent.owner.gameVehicle
        })
      end
    elseif taskObject.coreData.agent.isVehicle then
      zapcontroller.RemoveLockedVehicle(localID, {
        gameVehicle = taskObject.coreData.agent.gameVehicle
      })
    elseif taskObject.coreData.agent.owner then
      zapcontroller.RemoveLockedVehicle(localID, {
        gameVehicle = taskObject.coreData.agent.owner.gameVehicle
      })
    end
  end
end
function registerRestrictedObject(taskObject)
  restrictedObjects[taskObject] = {normalZapRestricted = false}
end
function unregisterRestrictedObject(taskObject)
  local restrictionData = restrictedObjects[taskObject]
  if restrictionData.normalZapRestricted then
    toggleNormalZapRestriction(taskObject, restrictionData)
  end
  restrictedObjects[taskObject] = nil
end
function updateRestrictedObjects()
  for taskObject, restrictionData in next, restrictedObjects, nil do
    if restrictionData.normalZapRestricted ~= taskObject:isRestricted(0) then
      toggleNormalZapRestriction(taskObject, restrictionData)
    end
  end
end
function setAgentUpdateRestriction(taskObject, oldAgent)
  local restrictionData = restrictedObjects[taskObject]
  if restrictionData.normalZapRestricted then
    for localID, plr in next, localPlayerManager.players, nil do
      if oldAgent and oldAgent.isVehicle and vehicleManager.vehiclesBySNVID[oldAgent.SNVID] then
        zapcontroller.RemoveLockedVehicle(localID, {
          gameVehicle = oldAgent.gameVehicle
        })
      end
      if taskObject.coreData.agent.isVehicle then
        zapcontroller.AddLockedVehicle(localID, {
          gameVehicle = taskObject.coreData.agent.gameVehicle
        })
      elseif taskObject.coreData.agent.owner then
        zapcontroller.AddLockedVehicle(localID, {
          gameVehicle = taskObject.coreData.agent.owner.gameVehicle
        })
      end
    end
  end
end
function isAgentRestricted(agent, accessType)
  local taskObject = agent:getTaskObject()
  taskObject = taskObject or packageManager.getTaskObjectByVehicle(agent)
  if taskObject and restrictedObjects[taskObject] then
    return taskObject:isRestricted(accessType)
  end
  return false
end
