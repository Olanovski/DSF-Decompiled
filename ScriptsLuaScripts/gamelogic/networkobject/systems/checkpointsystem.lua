module("checkpointSystem", package.seeall)
local checkpointsByInstanceID = {}
local prototypeList = {}
local maxBuffers = 4
checkpointSNOs = {}
local addCheckpointToSNO, buildCheckpoint, createCheckpointSNO, deleteCheckpointSNO
local checkpointBuffer = {
  bytes = 64,
  lookupTable = networkParsing.makeLookupTable({
    {
      name = "checkpointNum",
      parseType = "uinteger8"
    },
    {name = "groupID", parseType = "uinteger8"},
    {name = "instanceID", parseType = "uinteger16"},
    {name = "position", vector = true}
  })
}
local SNOBuffer = {
  bytes = 64,
  lookupTable = networkParsing.makeLookupTable({
    {
      name = "numBuffersUsed",
      parseType = "uinteger8"
    },
    {name = "instanceID", parseType = "uinteger16"}
  })
}
function createCheckpoint(instance, position, groupID, checkpointNum, checkpointSNOID, bufferID)
  local checkpoint = buildCheckpoint(position, instance, groupID, checkpointNum, checkpointSNOID, bufferID)
  if not checkpointsByInstanceID[instance.instanceID].checkpoints[groupID] then
    checkpointsByInstanceID[instance.instanceID].checkpoints[groupID] = {}
  end
  checkpointNum = checkpointNum or #checkpointsByInstanceID[instance.instanceID].checkpoints[groupID] + 1
  checkpointsByInstanceID[instance.instanceID].checkpoints[groupID][checkpointNum] = checkpoint
  checkpoint.checkpointNum = checkpointNum
  if not checkpoint.bufferID then
    checkpoint.bufferID = SNO.createBuffer(checkpoint.checkpointSNO.SNOID, checkpointBuffer.bytes)
    networkParsing.writeBuffer(SNO, checkpoint.checkpointSNO.SNOID, checkpoint.bufferID, checkpointBuffer, checkpoint)
  end
end
function purge()
  checkpointsByInstanceID = {}
  checkpointSNOs = {}
  prototypeList = {}
end
function deleteInstanceCheckpoints(instance)
  if checkpointsByInstanceID[instance.instanceID] then
    local checkpointSNO = checkpointsByInstanceID[instance.instanceID].SNO
    if checkpointSNO then
      for SNOID, checkpointSNO in next, checkpointSNO, nil do
        deleteCheckpointSNO(checkpointSNO)
      end
    end
    checkpointsByInstanceID[instance.instanceID] = nil
  end
end
function canDeleteInstanceCheckpoints(instance)
  local canBeDeleted = true
  if checkpointsByInstanceID[instance.instanceID] then
    local checkpointSNO = checkpointsByInstanceID[instance.instanceID].SNO
    if checkpointSNO then
      for SNOID, checkpointSNO in next, checkpointSNO, nil do
        if not canDeleteCheckpointSNO(checkpointSNO) then
          canBeDeleted = false
        end
      end
    end
  end
  return canBeDeleted
end
function getCheckpoints(instance, groupID)
  if gameStatus.onlineSession then
    if checkpointsByInstanceID[instance.instanceID] and checkpointsByInstanceID[instance.instanceID].checkpoints then
      return checkpointsByInstanceID[instance.instanceID].checkpoints[groupID]
    end
  else
    return getNoneSyncronisedCheckpoints(instance.instanceID, groupID)
  end
end
function findNextCheckpoint(instanceID, groupID, checkpointNum)
  if checkpointsByInstanceID[instanceID] and checkpointsByInstanceID[instanceID].checkpoints and checkpointsByInstanceID[instanceID].checkpoints[groupID] then
    return checkpointsByInstanceID[instanceID].checkpoints[groupID][checkpointNum + 1]
  end
end
function createQueuedCheckpoints(SNOID)
  if prototypeList[SNOID] then
    for checkpointSNOID, numBuffers in next, prototypeList[SNOID].SNO, nil do
      local checkPointSNObuffer = networkParsing.readBuffer(SNO, checkpointSNOID, 0, SNOBuffer)
      createCheckpointSNO(challengeSystem.instances[checkPointSNObuffer.instanceID], false, checkpointSNOID, checkPointSNObuffer.numBuffersUsed)
      for bufferIndex = 1, numBuffers do
        local checkpoint = checkpointsByInstanceID[checkPointSNObuffer.instanceID][bufferIndex]
        local checkPointBuffer = networkParsing.readBuffer(SNO, checkpointSNOID, bufferIndex, checkpointBuffer)
        createCheckpoint(challengeSystem.instances[checkPointSNObuffer.instanceID], checkPointBuffer.position, checkPointBuffer.groupID, checkPointBuffer.checkpointNum, checkpointSNOID, bufferIndex)
      end
    end
    prototypeList[SNOID] = nil
  end
end
function addCheckpointToSNO(checkPoint, checkpointSNO)
  checkpointSNO.numBuffersUsed = checkpointSNO.numBuffersUsed + 1
  checkPoint.checkpointSNOID = checkpointSNO.SNOID
  checkPoint.checkpointSNO = checkpointSNO
  assert(checkpointSNO.isLocal, "CHECKPOINT SYSTEM, cannot create checkpoints for remote checkpoint SNO")
end
function buildCheckpoint(position, instance, groupID, checkpointNum, ownerSNOID, bufferID)
  local checkPoint = {
    position = position,
    groupID = groupID,
    instanceID = instance.instanceID,
    checkpointNum = checkpointNum,
    checkpointSNO = checkpointSNOs[ownerSNOID],
    checkpointSNOID = ownerSNOID,
    bufferID = bufferID
  }
  if not checkPoint.checkpointSNO then
    if not checkpointsByInstanceID[instance.instanceID] then
      local checkpointSNO = createCheckpointSNO(instance, true)
      checkpointsByInstanceID[instance.instanceID] = {
        SNO = {
          [checkpointSNO.SNOID] = checkpointSNO
        },
        checkpoints = {}
      }
    end
    local foundBuffer = false
    for SNOID, checkpointSNO in next, checkpointsByInstanceID[instance.instanceID].SNO, nil do
      if checkpointSNO.numBuffersUsed < maxBuffers then
        addCheckpointToSNO(checkPoint, checkpointSNO)
        foundBuffer = true
        break
      end
    end
    if not foundBuffer then
      local checkpointSNO = createCheckpointSNO(instance, true)
      checkpointsByInstanceID[instance.instanceID].SNO[checkpointSNO.SNOID] = checkpointSNO
      addCheckpointToSNO(checkPoint, checkpointSNO)
    end
  end
  return checkPoint
end
function createCheckpointSNO(instance, isLocal, SNOID, numBuffersUsed)
  local checkpointSNO = {
    SNOID = SNOID or SNO.createSNO(2),
    numBuffersUsed = numBuffersUsed or 0,
    instanceID = instance.instanceID,
    isLocal = isLocal
  }
  if not checkpointSNO.isLocal then
    if not checkpointsByInstanceID[instance.instanceID] then
      checkpointsByInstanceID[instance.instanceID] = {
        SNO = {
          [checkpointSNO.SNOID] = checkpointSNO
        },
        checkpoints = {}
      }
    end
    checkpointsByInstanceID[instance.instanceID].SNO[checkpointSNO.SNOID] = checkpointSNO
  end
  if checkpointSNO.isLocal then
    SNO.createBuffer(checkpointSNO.SNOID, SNOBuffer.bytes)
    networkParsing.writeBuffer(SNO, checkpointSNO.SNOID, 0, SNOBuffer, checkpointSNO)
    checkpointSNO.numBuffersUsed = checkpointSNO.numBuffersUsed + 1
    SNO.SNOInitialised(checkpointSNO.SNOID)
  end
  if instance and instance.isLocal then
    instance:registerLinkedObject(checkpointSNO.SNOID, 2)
  end
  checkpointSNOs[checkpointSNO.SNOID] = checkpointSNO
  return checkpointSNO
end
function deleteCheckpointSNO(checkpointSNO)
  local instance = challengeSystem.instances[checkpointSNO.instanceID]
  if instance and instance.isLocal then
    instance:unregisterLinkedObject(checkpointSNO.SNOID, 2)
  end
  if checkpointSNO.isLocal then
    assert(SNO.canBeDeleted(checkpointSNO.SNOID))
    SNO.setMigrationType(checkpointSNO.SNOID, 0)
    SNO.deleteSNO(checkpointSNO.SNOID)
  end
  checkpointsByInstanceID[checkpointSNO.instanceID].SNO[checkpointSNO.SNOID] = nil
  checkpointSNOs[checkpointSNO.SNOID] = nil
end
function canDeleteCheckpointSNO(checkpointSNO)
  if checkpointSNO.isLocal and not SNO.canBeDeleted(checkpointSNO.SNOID) then
    return false
  end
  return true
end
function createObjectFromSNO(SNOID, numBuffers)
  local checkPointSNObuffer = networkParsing.readBuffer(SNO, SNOID, 0, SNOBuffer)
  if challengeSystem.instances[checkPointSNObuffer.instanceID] then
    numBuffers = numBuffers - 1
    createCheckpointSNO(challengeSystem.instances[checkPointSNObuffer.instanceID], false, SNOID, checkPointSNObuffer.numBuffersUsed)
    for bufferIndex = 1, numBuffers do
      local checkpoint = checkpointsByInstanceID[checkPointSNObuffer.instanceID][bufferIndex]
      local checkPointBuffer = networkParsing.readBuffer(SNO, SNOID, bufferIndex, checkpointBuffer)
      createCheckpoint(challengeSystem.instances[checkPointSNObuffer.instanceID], checkPointBuffer.position, checkPointBuffer.groupID, checkPointBuffer.checkpointNum, SNOID, bufferIndex)
    end
  else
    if not prototypeList[checkPointSNObuffer.instanceID] then
      prototypeList[checkPointSNObuffer.instanceID] = {
        SNO = {}
      }
    end
    prototypeList[checkPointSNObuffer.instanceID].SNO[SNOID] = numBuffers - 1
  end
end
function updateObjectFromSNO(SNOID, bufferID)
  if bufferID == 0 then
    networkParsing.readBuffer(SNO, SNOID, 0, SNOBuffer, checkpointSNOs[SNOID])
  else
    local checkPointBuffer = networkParsing.readBuffer(SNO, SNOID, bufferID, checkpointBuffer)
    if not checkpointsByInstanceID[checkPointBuffer.instanceID].checkpoints[checkPointBuffer.groupID][checkPointBuffer.checkpointNum] then
      createCheckpoint(challengeSystem.instances[checkPointBuffer.instanceID], checkPointBuffer.position, checkPointBuffer.groupID, checkPointBuffer.checkpointNum, SNOID, bufferID)
    end
  end
end
function deleteObjectFromSNO(SNOID)
  if checkpointSNOs[SNOID] then
    local instance = challengeSystem.instances[checkpointSNOs[SNOID].instanceID]
    deleteCheckpointSNO(checkpointSNOs[SNOID])
    if not next(checkpointsByInstanceID[instance.instanceID].SNO) then
      checkpointsByInstanceID[instance.instanceID] = nil
    end
  end
end
function shouldMigrateToLocal(SNOID)
  local checkpointSNO = checkpointSNOs[SNOID]
  if checkpointSNO then
    return challengeSystem.shouldMigrateToLocal(checkpointSNO.instanceID)
  end
end
function setObjectIsLocal(SNOID, isLocal)
  local checkpointSNO = checkpointSNOs[SNOID]
  if checkpointSNO and checkpointSNO.isLocal ~= isLocal then
    checkpointSNO.isLocal = isLocal
  end
end
local noneSyncronisedCheckpoints = {}
function createNoneSyncronisedCheckpoint(instanceID, groupID, checkpointData)
  local checkPoint
  if checkpointData.position then
    checkPoint = {
      instanceID = instanceID,
      groupID = groupID,
      position = checkpointData.position,
      checkpointNum = -1,
      toolData = checkpointData
    }
  else
    checkPoint = {
      instanceID = instanceID,
      groupID = groupID,
      position = checkpointData,
      checkpointNum = -1
    }
  end
  if not noneSyncronisedCheckpoints[instanceID] then
    noneSyncronisedCheckpoints[instanceID] = {}
  end
  if not noneSyncronisedCheckpoints[instanceID][groupID] then
    noneSyncronisedCheckpoints[instanceID][groupID] = {}
  end
  table.insert(noneSyncronisedCheckpoints[instanceID][groupID], checkPoint)
  checkPoint.checkpointNum = #noneSyncronisedCheckpoints[instanceID][groupID]
end
function getNoneSyncronisedCheckpoints(instanceID, groupID)
  if not noneSyncronisedCheckpoints[instanceID] or not noneSyncronisedCheckpoints[instanceID][groupID] then
    return false
  end
  return noneSyncronisedCheckpoints[instanceID][groupID]
end
function findNoneSyncronisedCheckpoint(instanceID, groupID, checkpointNum)
  if not noneSyncronisedCheckpoints[instanceID] or not noneSyncronisedCheckpoints[instanceID][groupID] or not noneSyncronisedCheckpoints[instanceID][groupID][checkpointNum] then
    return false
  end
  return noneSyncronisedCheckpoints[instanceID][groupID][checkpointNum]
end
function clearNoneSyncronisedCheckpoint()
  noneSyncronisedCheckpoints = {}
end
function clearNoneSyncronisedCheckpointsByGroupID(instanceID, groupID)
  if noneSyncronisedCheckpoints[instanceID] then
    noneSyncronisedCheckpoints[instanceID][groupID] = nil
  end
end
function printNoneSyncronisedCheckpoints()
  printTable(noneSyncronisedCheckpoints)
end
local onlineRaceDataSet = false
local onlineMaxPoints = 3
local phaseOneGateTime = 1
local phaseTwoGateTime = 0.7
local phaseThreeGateTime = 0.7
local gateFlashTime = 0.2
local numFlashes = 2
local flashEndBuffer = 0.2
function setOnlineCPTimers(phaseOne, phaseTwo, phaseThree, nFlashes, flashTime)
  phaseOneGateTime = phaseOne
  phaseTwoGateTime = phaseTwo
  phaseThreeGateTime = phaseThree
  numFlashes = nFlashes
  gateFlashTime = flashTime
  assert(gateFlashTime * 2 * numFlashes <= phaseThreeGateTime, "Flash time and num of flashes set will not fit into the last colour phase")
end
onlineRaceCheckpointData = {}
function setupOnlineCheckpointScoreTracking(instance, groupID)
  onlineRaceCheckpointData = {}
  if noneSyncronisedCheckpoints[instance.instanceID] then
    local numCheckpoints = #noneSyncronisedCheckpoints[instance.instanceID][groupID]
    for i = 1, numCheckpoints do
      table.insert(onlineRaceCheckpointData, {
        active = false,
        startTime = false,
        endTime = false,
        task = false,
        targetID = false,
        callback = false
      })
    end
    onlineRaceDataSet = true
  else
    onlineRaceDataSet = false
  end
end
function isOnlineCheckpointSystemSetup()
  return onlineRaceDataSet
end
function clearOnlineCheckpointScoreTracking()
  onlineRaceCheckpointData = nil
  onlineRaceDataSet = false
end
function updateOnlineCheckpointScoreTracking()
  if onlineRaceDataSet then
    for i, data in ipairs(onlineRaceCheckpointData) do
      if data.active and g_NetworkTime > data.endTime then
        data.callback(data.task, data.targetID)
        onlineRaceCheckpointData[i].active = false
      end
    end
  end
end
function getOnlineCheckpointPhaseData(checkpointNumber)
  if onlineRaceDataSet and onlineRaceCheckpointData[checkpointNumber] then
    return phaseOneGateTime, phaseTwoGateTime, phaseThreeGateTime, gateFlashTime, numFlashes, onlineRaceCheckpointData[checkpointNumber].startTime, flashEndBuffer
  end
end
function isOnlineCheckpointActive(checkpointNumber)
  if onlineRaceDataSet and onlineRaceCheckpointData[checkpointNumber] then
    return onlineRaceCheckpointData[checkpointNumber].active
  end
  return false
end
function resetOnlineCheckpoint(checkpointNumber)
  if onlineRaceDataSet and onlineRaceCheckpointData[checkpointNumber] then
    onlineRaceCheckpointData[checkpointNumber] = {
      active = false,
      startTime = false,
      endTime = false,
      task = false,
      targetID = false,
      callback = false
    }
  end
end
function activateOnlineCheckpoint(checkpointNumber, task, targetID, callback)
  if onlineRaceDataSet and onlineRaceCheckpointData[checkpointNumber] then
    onlineRaceCheckpointData[checkpointNumber].active = true
    onlineRaceCheckpointData[checkpointNumber].startTime = g_NetworkTime
    onlineRaceCheckpointData[checkpointNumber].endTime = g_NetworkTime + phaseOneGateTime + phaseTwoGateTime + phaseThreeGateTime
    onlineRaceCheckpointData[checkpointNumber].task = task
    onlineRaceCheckpointData[checkpointNumber].targetID = targetID
    onlineRaceCheckpointData[checkpointNumber].callback = callback
  end
end
function debugOnlineGates()
  printTable(onlineRaceCheckpointData)
end
