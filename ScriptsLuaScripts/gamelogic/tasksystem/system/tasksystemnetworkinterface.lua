module("taskSystem")
networkQueue = {
  protoObjects = {},
  setAgent = {}
}
local coreDataBuffer = {
  bytes = 64,
  lookupTable = networkParsing.makeLookupTable({
    {name = "instanceID", parseType = "uinteger16"},
    {name = "actorID", parseType = "uinteger8"},
    {name = "agentType", parseType = "uinteger8"},
    {name = "agentID", parseType = "uinteger16"},
    {
      name = "flagForDeletion",
      parseType = "boolean"
    }
  })
}
function coreDataBuffer.bufferUpdate(coreData, newBuffer)
  if coreData.agentID ~= newBuffer.agentID or coreData.agentType ~= newBuffer.agentType then
    networkQueue.setAgent[coreData.taskObjectID] = nil
    local newAgentData = {
      agentType = newBuffer.agentType,
      agentID = newBuffer.agentID
    }
    if not attemptSetAgent(coreData.taskObjectID, newAgentData) then
      networkQueue.setAgent[coreData.taskObjectID] = newAgentData
    end
  else
    coreData.flagForDeletion = newBuffer.flagForDeletion
  end
end
local taskBuffer = {
  bytes = 64,
  lookupTable = networkParsing.makeLookupTable({
    {name = "majorOrder", parseType = "uinteger8"},
    {name = "minorOrder", parseType = "uinteger8"},
    {name = "complete", parseType = "boolean"},
    {name = "success", parseType = "boolean"},
    {name = "condition", parseType = "uinteger8"},
    {
      name = "networkVars",
      subTable = true
    }
  })
}
function taskBuffer.lookupTable.networkVars.getLookup(task)
  return taskBuilders[task.taskName].networkVars
end
function createSNOFromObject(taskObject)
  NetworkLog.Write(">[LUA] TASKSYSTEM - Create SNO for local taskObject")
  local SNOID = SNO.createSNO(1)
  SNO.createBuffer(SNOID, coreDataBuffer.bytes)
  networkParsing.writeBuffer(SNO, SNOID, 0, coreDataBuffer, taskObject.coreData)
  SNO.SNOInitialised(SNOID)
  return SNOID
end
function newTaskBuffer(task)
  if gameStatus.onlineSession then
    local taskObject = taskObjects[task.taskObjectID]
    local maxTasks = 23
    local numTasks = 0
    for i, taskGroup in ipairs(taskObject.taskList) do
      for j, task in ipairs(taskGroup) do
        numTasks = numTasks + 1
      end
    end
    NetworkLog.WriteDetail(">[LUA] TASKSYSTEM - Create task buffer for local taskObject, SNOID = " .. tostring(taskObject.coreData.taskObjectID) .. ", agentType = " .. tostring(taskObject.coreData.agentType) .. ", agentID = " .. (taskObject.coreData.agentType == 0 and taskObject.coreData.agent.playerID or taskObject.coreData.agentType == 1 and taskObject.coreData.agent.SNVID or taskObject.coreData.agentType == 2 and taskObject.coreData.agent.SNOID) .. ", mission = " .. tostring(taskObject.coreData.instance.challenge.name) .. ", actor = " .. tostring(taskObject.coreData.actor.ID) .. ", task Major = " .. tostring(task.majorOrder) .. ", task Minor = " .. tostring(task.minorOrder) .. ", numTasks = " .. tostring(numTasks))
    assert(maxTasks > numTasks, "TASKSYSTEM - newTaskBuffer: Attempt to create a new task which exceeds the maximum limit allowed by network code (Max: " .. maxTasks .. " unique tasks.")
  end
  task.bufferID = SNO.createBuffer(task.taskObjectID, taskBuffer.bytes)
  networkParsing.writeBuffer(SNO, task.taskObjectID, task.bufferID, taskBuffer, task)
end
function updateSNOFromObject(taskObject, updateCoreOnly)
  if updateCoreOnly then
    NetworkLog.WriteDetail(">[LUA] TASKSYSTEM - Update core buffer for local taskObject, SNOID = " .. tostring(taskObject.coreData.taskObjectID) .. ", agentType = " .. tostring(taskObject.coreData.agentType) .. ", agentID = " .. (taskObject.coreData.agentType == 0 and taskObject.coreData.agent.playerID or taskObject.coreData.agentType == 1 and taskObject.coreData.agent.SNVID or taskObject.coreData.agentType == 2 and taskObject.coreData.agent.SNOID) .. ", mission = " .. tostring(taskObject.coreData.instance.challenge.name) .. ", actor = " .. tostring(taskObject.coreData.actor.ID))
    networkParsing.writeBuffer(SNO, taskObject.coreData.taskObjectID, 0, coreDataBuffer, taskObject.coreData)
  else
    for i, taskGroup in ipairs(taskObject.taskList) do
      for j, task in ipairs(taskGroup) do
        if task.networkVars.updateRequired then
          NetworkLog.WriteDetail(">[LUA] TASKSYSTEM - Update task buffer for local taskObject, SNOID = " .. tostring(taskObject.coreData.taskObjectID) .. ", agentType = " .. tostring(taskObject.coreData.agentType) .. ", agentID = " .. (taskObject.coreData.agentType == 0 and taskObject.coreData.agent.playerID or taskObject.coreData.agentType == 1 and taskObject.coreData.agent.SNVID or taskObject.coreData.agentType == 2 and taskObject.coreData.agent.SNOID) .. ", mission = " .. tostring(taskObject.coreData.instance.challenge.name) .. ", actor = " .. tostring(taskObject.coreData.actor.ID) .. ", task Major = " .. tostring(task.majorOrder) .. ", task Minor = " .. tostring(task.minorOrder))
          networkParsing.writeBuffer(SNO, taskObject.coreData.taskObjectID, task.bufferID, taskBuffer, task)
          task.networkVars.updateRequired = false
        end
      end
    end
  end
end
function createObjectFromSNO(SNOID, numBuffers)
  NetworkLog.Write(">[LUA] TASKSYSTEM - Create remote taskObject from SNO, SNOID = " .. tostring(SNOID))
  local protoTaskObject = networkParsing.readBuffer(SNO, SNOID, 0, coreDataBuffer)
  protoTaskObject.isLocal = false
  if not buildProtoTaskObject(protoTaskObject, SNOID) then
    networkQueue.protoObjects[SNOID] = protoTaskObject
  end
end
function updateNetworkQueue()
  for SNOID, protoTaskObject in next, networkQueue.protoObjects, nil do
    if buildProtoTaskObject(protoTaskObject, SNOID) then
      networkQueue.protoObjects[SNOID] = nil
    end
  end
  for taskObjectID, agentData in next, networkQueue.setAgent, nil do
    if attemptSetAgent(taskObjectID, agentData) then
      networkQueue.setAgent[taskObjectID] = nil
    end
  end
end
function buildProtoTaskObject(protoTaskObject, SNOID)
  local instance = challengeSystem.instances[protoTaskObject.instanceID]
  if instance and not instance:checkpointsPresent() then
    return false
  end
  local agent
  if protoTaskObject.agentType == 0 then
    agent = playerManager.players[protoTaskObject.agentID]
  elseif protoTaskObject.agentType == 1 then
    agent = vehicleManager.vehiclesBySNVID[protoTaskObject.agentID]
  else
    agent = packageManager.packagesBySNOID[protoTaskObject.agentID]
  end
  if instance and agent then
    local actor = instance.challenge.actorPool[protoTaskObject.actorID]
    createTaskObject(instance, actor, agent, protoTaskObject.isLocal, SNOID)
    return true
  end
  return false
end
function incomingSNOMessage(taskObjectID, messageType, player, message)
  local taskObject = taskObjects[taskObjectID]
  taskObject:receiveMessage(player, messageType, message)
end
function attemptSetAgent(taskObjectID, agentData)
  local agent
  if agentData.agentType == 0 then
    agent = playerManager.players[agentData.agentID]
  elseif agentData.agentType == 1 then
    agent = vehicleManager.vehiclesBySNVID[agentData.agentID]
  else
    agent = packageManager.packagesBySNOID[agentData.agentID]
  end
  if agent then
    local taskObject = taskObjects[taskObjectID]
    taskObject:setAgent(agent)
    return true
  end
  return false
end
function processTaskBuffer(taskObject, bufferID)
  local blindData = networkParsing.blindReadBuffer(SNO, taskObject.coreData.taskObjectID, bufferID, taskBuffer)
  local majorOrder = blindData[1]
  local minorOrder = blindData[2]
  local complete = blindData[3]
  local success = blindData[4]
  local condition = blindData[5]
  if not taskObject.taskList[majorOrder] or not taskObject.taskList[majorOrder][minorOrder] then
    buildTask(taskObject, majorOrder, minorOrder, bufferID)
  end
  local task = taskObject.taskList[majorOrder][minorOrder]
  local varTable = task.stopped and task.networkVars or task.networkVars.__index
  if taskBuilders[task.taskName].networkVars then
    local networkVarStart = #taskBuffer.lookupTable
    local networkVarEnd = networkVarStart + #taskBuilders[task.taskName].networkVars - 1
    for i = networkVarStart, networkVarEnd do
      local varName = taskBuilders[task.taskName].networkVars[i - (networkVarStart - 1)].name
      if task.networkVars[varName] ~= blindData[i] then
        varTable[varName] = blindData[i]
        if taskBuilders[task.taskName].networkVars[varName].dynamicTargetTrigger then
          local removeList = {}
          local addList = task.instance.getDynamicTargets[task.actor.team](taskObject, task, false)
          for dynamicTargetID, dynamicTarget in ipairs(task.dynamicTargets) do
            table.insert(removeList, dynamicTargetID)
          end
          updateTaskDynamicTargets(task, removeList, addList)
        end
      end
    end
  end
  if complete then
    taskComplete(task, success, condition)
  end
end
function updateObjectFromSNO(SNOID, bufferID)
  if taskObjects[SNOID] then
    NetworkLog.WriteDetail(">[LUA] TASKSYSTEM - Update buffer for remote taskObject, SNOID = " .. tostring(SNOID) .. ", bufferID = " .. tostring(bufferID))
    if bufferID == 0 then
      networkParsing.readBuffer(SNO, SNOID, bufferID, coreDataBuffer, taskObjects[SNOID].coreData)
    elseif taskObjects[SNOID].initiated then
      processTaskBuffer(taskObjects[SNOID], bufferID)
    end
  elseif networkQueue.protoObjects[SNOID] then
    NetworkLog.WriteDetail(">[LUA] TASKSYSTEM - Update buffer for queued remote taskObject, SNOID = " .. tostring(SNOID) .. ", bufferID = " .. tostring(bufferID))
    if bufferID == 0 then
      local isLocal = networkQueue.protoObjects[SNOID].isLocal
      networkQueue.protoObjects[SNOID] = networkParsing.readBuffer(SNO, SNOID, 0, coreDataBuffer)
      networkQueue.protoObjects[SNOID].isLocal = isLocal
    end
  end
end
function setObjectIsLocal(SNOID, isLocal)
  if taskObjects[SNOID] then
    if taskObjects[SNOID].coreData.isLocal ~= isLocal then
      taskObjects[SNOID].coreData.isLocal = isLocal
      NetworkLog.Write(">[LUA] TASKSYSTEM - TaskObject isLocal update, SNOID = " .. tostring(SNOID) .. ", new isLocal = " .. tostring(isLocal))
      if isLocal then
        taskObjects[SNOID]:claimObject()
        local numTasks = #taskObjects[SNOID].taskList
        if gameStatus.onlineSession and taskObjects[SNOID].initiated and numTasks == 0 then
          NetworkLog.Write(">[LUA] TASKSYSTEM - TaskObject isLocal - true - Reinitiating task object as the taskObject has been initiated locally but has no tasks")
          taskObjects[SNOID].initiated = false
          taskObjects[SNOID]:initiate()
        end
      else
        taskObjects[SNOID]:releaseObject()
      end
    end
  elseif networkQueue.protoObjects[SNOID] and networkQueue.protoObjects[SNOID].isLocal ~= isLocal then
    NetworkLog.Write(">[LUA] TASKSYSTEM - Queued TaskObject isLocal update, SNOID = " .. tostring(SNOID) .. ", new isLocal = " .. tostring(isLocal))
    networkQueue.protoObjects[SNOID].isLocal = isLocal
  end
end
function deleteObjectFromSNO(SNOID)
  if taskObjects[SNOID] then
    NetworkLog.Write(">[LUA] TASKSYSTEM - Delete remote taskObject, SNOID = " .. tostring(SNOID))
    taskObjects[SNOID]:delete()
  elseif networkQueue.protoObjects[SNOID] then
    NetworkLog.Write(">[LUA] TASKSYSTEM - Delete remote queued taskObject, SNOID = " .. tostring(SNOID))
    networkQueue.protoObjects[SNOID] = nil
  end
end
function shouldMigrateToLocal(SNOID)
  local taskObject = taskObjects[SNOID]
  if taskObject then
    if taskObject.coreData.agentType == 1 then
      return SNVShouldMigrateToLocal(taskObject.coreData.agent.SNVID)
    elseif taskObject.coreData.agentType == 2 then
      return packageManager.shouldMigrateToLocal(taskObject.coreData.agent.SNOID)
    end
  end
  return false
end
