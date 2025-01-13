module("taskSystem")
function getTaskBaseParameters(task)
  return task.actor.taskList[task.majorOrder][task.minorOrder]
end
function buildTask(taskObject, majorOrder, minorOrder, bufferID)
  assert(taskObject.coreData.actor.taskList[majorOrder], [[
TASKSYSTEM - buildTask:
 Couldn't access actor taskList major order ( major order = ]] .. tostring(majorOrder) .. ", actor name = " .. tostring(taskObject.coreData.actor.ID) .. ", challenge name = " .. tostring(taskObject.coreData.instance.challenge.name) .. ")")
  assert(taskObject.coreData.actor.taskList[majorOrder][minorOrder], [[
TASKSYSTEM - buildTask:
 Couldn't access actor taskList minor order ( major order = ]] .. tostring(majorOrder) .. ", minor order = " .. tostring(minorOrder) .. ", actor name = " .. tostring(taskObject.coreData.actor.ID) .. ", challenge name = " .. tostring(taskObject.coreData.instance.challenge.name) .. ")")
  local taskParams = taskObject.coreData.actor.taskList[majorOrder][minorOrder]
  assert(taskParams.task, [[
TASKSYSTEM - buildTask:
 No task name supplied for major task (actor name = ]] .. tostring(taskObject.coreData.actor.ID) .. ", challenge name = " .. tostring(taskObject.coreData.instance.challenge.name) .. ")")
  assert(taskBuilders[taskParams.task], [[
TASKSYSTEM - buildTask:
 Couldn't find specified task: ]] .. tostring(taskParams.task))
  local groupProgression
  if taskParams.groupProgression then
    groupProgression = {
      importantMinorOrder = taskParams.groupProgression.importantMinorOrder or taskParams.groupProgression.priorityMinorOrder,
      mustBeSuccessful = taskParams.groupProgression.mustBeSuccessful,
      priorityMinorOrder = taskParams.groupProgression.priorityMinorOrder
    }
  else
    groupProgression = {
      importantMinorOrder = taskParams.taskConditions and #taskParams.taskConditions > 0,
      mustBeSuccessful = false,
      priorityMinorOrder = false
    }
  end
  local task = {
    taskName = taskParams.task,
    goalFeedback = {},
    specialName = taskParams.specialName,
    groupProgression = groupProgression,
    majorOrder = majorOrder,
    minorOrder = minorOrder,
    bufferID = bufferID,
    complete = false,
    success = false,
    coreData = taskParams.coreData,
    HUDParams = taskParams.HUD,
    audioPIPParams = taskParams.audioPIP,
    targetManagersParams = taskParams.targetManagers
  }
  setmetatable(task, taskObject.coreData)
  task.networkVars = {
    debugCheckIsLocal = function()
      return task.isLocal
    end,
    updateRequired = false,
    __newindex = networkParsing.metaSetNetworkVar,
    __index = {}
  }
  setmetatable(task.networkVars, task.networkVars)
  local defaultVars = taskBuilders[task.taskName].networkVars
  if defaultVars then
    for i, varInfo in ipairs(defaultVars) do
      if taskParams.startingValues and taskParams.startingValues[varInfo.name] then
        task.networkVars.__index[varInfo.name] = taskParams.startingValues[varInfo.name]
      else
        task.networkVars.__index[varInfo.name] = varInfo.startingValue
      end
    end
  end
  if not task.bufferID then
    newTaskBuffer(task)
  end
  if taskParams.dynamicTargets then
    task.dynamicTargets = {}
    local initialTargets = task.instance.getDynamicTargets[task.actor.team](taskObjects[task.taskObjectID], task, false)
    assert(initialTargets, "The initial dynamic targets for task.specialName " .. tostring(task.specialName) .. " are nil.")
    for i, target in ipairs(initialTargets) do
      task.dynamicTargets[i] = target
    end
  end
  task.goalCheckCallback, task.AIUpdate, task.cleanup = taskBuilders[task.taskName].create(task)
  if not taskObject.taskList[majorOrder] then
    taskObject.taskList[majorOrder] = {}
  end
  taskObject.taskList[majorOrder][minorOrder] = task
  task.taskObject = taskObject
  if task.specialName then
    assert(not taskObject.namedTasks[task.specialName], [[
TASKSYSTEM - buildTask:
 Special named task already present - ]] .. tostring(task.specialName) .. " ( major order = " .. tostring(majorOrder) .. ", minor order = " .. tostring(minorOrder) .. ", actor name = " .. tostring(taskObject.coreData.actor.ID) .. ", challenge name = " .. tostring(taskObject.coreData.instance.challenge.name) .. ")")
    taskObject.namedTasks[task.specialName] = task
  end
  if task.isLocal then
    task.networkVars.updateRequired = true
    goalSystem.taskSupport.registerTask(task)
    if not gameStatus.onlineSession then
      feedbackSystem.taskSupport.update()
    end
    if task.AIUpdate then
      if task.agent.isVehicle and task.agent.isLocal and not task.agent.controlled then
        task.AIUpdate(true)
      elseif task.agent.isPackage and task.agent.owner and task.agent.owner.isLocal and not task.agent.owner.controlled then
        task.AIUpdate(true)
      end
    end
  end
end
function buildMinorTask(taskObject, taskParams)
  local task = {
    taskName = taskParams.task,
    forceZapToVehicle = taskParams.forceZapToVehicle,
    forceZapToVehicleFromPlayerVehicle = taskParams.forceZapToVehicleFromPlayerVehicle,
    lookToVehicle = taskParams.lookToVehicle,
    lookToVehicleTriggerRadius = taskParams.lookToVehicleTriggerRadius,
    forceMissionAccept = taskParams.forceMissionAccept,
    HUDParams = taskParams.HUD,
    audioPIPParams = taskParams.audioPIP,
    targetManagersParams = taskParams.targetManagers
  }
  setmetatable(task, taskObject.coreData)
  if task.taskName then
    assert(taskBuilders[task.taskName], [[
TASKSYSTEM - buildMinorTask:
 Couldn't find specified task: ]] .. tostring(task.taskName))
    task.goalCheckCallback, task.AIUpdate, task.cleanup = taskBuilders[task.taskName].create(task)
    if task.isLocal then
      if task.AIUpdate and task.agent.isVehicle and task.agent.isLocal and not task.agent.controlled then
        task.AIUpdate(true)
      elseif task.agent.isPackage and task.agent.owner and task.agent.owner.isLocal and not task.agent.owner.controlled then
        task.AIUpdate(true)
      end
    end
  end
  return task
end
function taskCompleteGoalSystemCallback(task, conditionKey)
  local baseConditions = taskSystem.getTaskBaseParameters(task).taskConditions
  local success = not baseConditions[conditionKey].failCondition
  local forceTaskComplete = baseConditions[conditionKey].forceTaskComplete
  taskComplete(task, success, conditionKey, forceTaskComplete)
end
function goalCompleteGoalSystemCallback(task, conditionKey, dynamicTargetID, completionData)
  local baseConditions = taskSystem.getTaskBaseParameters(task).goalConditions
  local success = true
  if baseConditions[conditionKey] then
    success = not baseConditions[conditionKey].failCondition
  end
  if task.instance.goalComplete then
    task.instance.goalComplete(taskObject, task, conditionKey)
  end
  if dynamicTargetID > 0 and not baseConditions[conditionKey].autoRefresh and not baseConditions[conditionKey].skipTargetUpdate then
    local targetsToAdd, specialData = task.instance.getDynamicTargets[task.actor.team](taskObjects[task.taskObjectID], task, dynamicTargetID, conditionKey)
    updateTaskDynamicTargets(task, {dynamicTargetID}, targetsToAdd)
    task.goalCheckCallback(success, conditionKey, specialData, completionData)
  else
    if task.goalCheckCallback == nil then
      print("task.goalCheckCallback is nil on " .. task.taskName)
    end
    task.goalCheckCallback(success, conditionKey, false, completionData)
  end
  if task.AIUpdate and task.agent.isVehicle and task.agent.isLocal and not task.agent.controlled and not baseConditions[conditionKey].skipTargetUpdate then
    task.AIUpdate()
  elseif task.agent.isPackage and task.agent.owner and task.agent.owner.isLocal and not task.agent.owner.controlled then
    task.AIUpdate()
  end
  if task.feedbackSystem then
    feedbackSystem.taskSupport.goalComplete(task, conditionKey)
  end
end
function updateTaskDynamicTargets(task, targetsToRemove, targetsToAdd)
  if targetsToRemove then
    for i, dynamicTargetID in ripairs(targetsToRemove) do
      table.remove(task.dynamicTargets, dynamicTargetID)
    end
  end
  if targetsToAdd then
    for i, target in next, targetsToAdd, nil do
      for j, currTarget in ipairs(task.dynamicTargets) do
        assert(target ~= currTarget, [[
TASKSYSTEM - updateTaskDynamicTargets:
 Attempt to add a dynamic target that is already part of the current dynamic target list.]])
      end
      table.insert(task.dynamicTargets, target)
    end
  end
  if task.isLocal then
    goalSystem.taskSupport.synchroniseWithDynamicTargets(task, targetsToRemove)
  end
  if task.feedbackSystem then
    feedbackSystem.taskSupport.updateTaskTargetManager(task, targetsToRemove)
  end
end
function stopTask(task)
  goalSystem.taskSupport.unregisterTask(task)
  if task.feedbackSystem then
    feedbackSystem.taskSupport.clearTaskFeedback(task)
  end
  if task.AIUpdate and task.agent.isVehicle and task.agent.isLocal and not task.agent.controlled then
    task.agent:stopHighSpeedDriving()
  elseif task.agent.isPackage and task.agent.owner and task.agent.owner.isLocal and not task.agent.owner.controlled then
    task.agent.owner:stopHighSpeedDriving()
  end
  if task.cleanup then
    task.cleanup()
  end
  task.stopped = true
  task.dynamicTargets = nil
  task.goalFeedback = nil
  task.goalCheckCallback = nil
  task.AIUpdate = nil
  task.cleanup = nil
  task.taskObject = nil
  if task.networkVars then
    task.networkVars = task.networkVars.__index
    task.networkVars.updateRequired = true
  end
end
function runTaskComplete(task, success, condition, forceTaskComplete)
  task.complete = true
  task.success = success
  task.condition = condition
  task.forced = forceTaskComplete
  if task.feedbackSystem then
    feedbackSystem.taskSupport.taskComplete(task, success, condition)
  end
  if not task.stopped then
    stopTask(task)
  end
  local taskObject = taskObjects[task.taskObjectID]
  task.instance.taskComplete(taskObject, task)
  if task.instance.instanceID and task.taskObjectID and task.isLocal then
    assert(taskObject.taskList[task.majorOrder], [[
TASKSYSTEM - runTaskComplete:
 Could not find task list ]] .. tostring(task.taskName))
    local groupComplete = true
    if task.groupProgression.priorityMinorOrder then
      if task.groupProgression.mustBeSuccessful and not task.success then
        groupComplete = false
      end
    elseif not forceTaskComplete then
      for i, task in ipairs(taskObject.taskList[task.majorOrder]) do
        if task.groupProgression.importantMinorOrder and not task.complete then
          groupComplete = false
          break
        end
        if task.groupProgression.mustBeSuccessful and not task.success then
          groupComplete = false
          break
        end
      end
    end
    if groupComplete then
      taskObject:taskGroupComplete(task.majorOrder, forceTaskComplete)
    end
    if taskObjects[task.taskObjectID] then
      task.networkVars.updateRequired = true
      updateSNOFromObject(taskObject)
    end
  end
end
function taskComplete(task, success, condition, forceTaskComplete)
  if dareSystem.watchingDare then
    addUserUpdateFunction("Pause complete while dare active", function()
      if not dareSystem.watchingDare then
        runTaskComplete(task, success, condition)
        removeUserUpdateFunction("Pause complete while dare active")
      end
    end, 4)
  else
    runTaskComplete(task, success, condition, forceTaskComplete)
  end
end
