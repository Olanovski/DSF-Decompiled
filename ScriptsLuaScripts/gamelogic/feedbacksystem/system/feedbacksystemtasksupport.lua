module("feedbackSystem.taskSupport", package.seeall)
hookedTaskObjects = {}
function addTaskObjectHook(taskObject)
  assert(not hookedTaskObjects[taskObject.coreData.taskObjectID], [[
addTaskObjectHook:
 Task Object specified is already hooked]])
  hookedTaskObjects[taskObject.coreData.taskObjectID] = {taskObject = taskObject, displayType = 8}
  updateTaskObject(taskObject, 8)
end
function releaseTaskObjectHook(taskObject)
  for i, taskGroup in next, taskObject.taskList, nil do
    for j, task in ipairs(taskGroup) do
      if task.feedbackSystem then
        clearTaskFeedback(task)
      end
    end
  end
  for i, task in ipairs(taskObject.minorTasks) do
    if task.feedbackSystem then
      clearTaskFeedback(task)
    end
  end
  if hookedTaskObjects[taskObject.coreData.taskObjectID] then
    hookedTaskObjects[taskObject.coreData.taskObjectID] = nil
  end
end
function setTaskObjectDisplayType(taskObject, displayType)
  assert(hookedTaskObjects[taskObject.coreData.taskObjectID], [[
setHookedTaskObjectDisplayType:
 Task Object specified isn't hooked]])
  displayType = displayType + 8
  hookedTaskObjects[taskObject.coreData.taskObjectID].displayType = displayType
  updateTaskObject(taskObject, displayType)
end
local updateFeedback = function(taskObject, feedback)
  if feedback.HUD and feedback.HUD.updateRate > 0 then
    feedback.HUD.updateStep = feedback.HUD.updateStep + 1
    if feedback.HUD.updateStep > feedback.HUD.updateRate then
      feedback.HUD.updateStep = 1
      for i, HUDFuncs in ipairs(feedback.HUD) do
        if HUDFuncs.update then
          HUDFuncs.update(taskObject)
        end
      end
    end
  end
  if feedback.APIP and feedback.APIP.update then
    feedback.APIP.update()
  end
  if feedback.targetManagers then
    for i, managerFuncs in ipairs(feedback.targetManagers) do
      if managerFuncs.updateOnUpdate and managerFuncs.update then
        managerFuncs.update(targetsToRemove)
      end
    end
  end
end
function updateTaskObject(taskObject, displayType)
  local highestMajorOrder = 0
  for i, majorOrder in next, taskObject.taskList, nil do
    if i > highestMajorOrder then
      highestMajorOrder = i
    end
  end
  if highestMajorOrder > 0 then
    for j, task in ipairs(taskObject.taskList[highestMajorOrder]) do
      if not task.stopped then
        if not task.feedbackSystem or task.feedbackSystem.displayType ~= displayType then
          setTaskFeedback(task, displayType)
        end
        updateFeedback(taskObject, task.feedbackSystem)
      end
    end
  end
  for i, task in ipairs(taskObject.minorTasks) do
    if not task.feedbackSystem or task.feedbackSystem.displayType ~= displayType then
      setTaskFeedback(task, displayType)
    end
    updateFeedback(taskObject, task.feedbackSystem)
  end
end
function update()
  for taskObjectID, hookData in next, hookedTaskObjects, nil do
    updateTaskObject(hookData.taskObject, hookData.displayType)
  end
end
function setTaskFeedback(task, displayType)
  if not task.feedbackSystem then
    local displayData = format.binaryNumberToList(displayType)
    task.feedbackSystem = {
      sharedData = {},
      displayData = displayData,
      displayType = displayType
    }
  else
    task.feedbackSystem.displayType = displayType
    format.binaryNumberToList(displayType, task.feedbackSystem.displayData)
  end
  if task.feedbackSystem.displayData[1] then
    if not task.feedbackSystem.targetManagers then
      addTaskTargetManagers(task)
    end
  elseif task.feedbackSystem.targetManagers then
    removeTaskTargetManagers(task)
  end
  if task.feedbackSystem.displayData[2] then
    if not task.feedbackSystem.HUD then
      addTaskHUD(task)
    end
  elseif task.feedbackSystem.HUD then
    removeTaskHUD(task)
  end
  if task.feedbackSystem.displayData[3] then
    if not task.feedbackSystem.APIP then
      addTaskAPIP(task)
    end
  elseif task.feedbackSystem.APIP then
    removeTaskAPIP(task)
  end
end
function clearTaskFeedback(task)
  if task.feedbackSystem.targetManagers then
    removeTaskTargetManagers(task)
  end
  if task.feedbackSystem.HUD then
    removeTaskHUD(task)
  end
  if task.feedbackSystem.APIP then
    removeTaskAPIP(task)
  end
  task.feedbackSystem = nil
end
function addTaskTargetManagers(task)
  local targetManagers = {}
  if task.targetManagersParams then
    for i, managerData in ipairs(task.targetManagersParams) do
      assert(feedbackSystem.targetManagerBuilders[managerData.manager], [[
FEEDBACKSYSTEM - addTaskTargetManagers:
 Couldn't find specified target manager: ]] .. tostring(managerData.manager))
      local newManager = {
        updateOnGoal = feedbackSystem.targetManagerBuilders[managerData.manager].updateOnGoal,
        updateOnInstance = feedbackSystem.targetManagerBuilders[managerData.manager].updateOnInstance,
        updateOnZap = feedbackSystem.targetManagerBuilders[managerData.manager].updateOnZap,
        updateOnUpdate = feedbackSystem.targetManagerBuilders[managerData.manager].updateOnUpdate
      }
      newManager.update, newManager.cleanup = feedbackSystem.targetManagerBuilders[managerData.manager].create(task, managerData.settings)
      if newManager.update then
        newManager.update()
      end
      targetManagers[i] = newManager
    end
  end
  task.feedbackSystem.targetManagers = targetManagers
end
function removeTaskTargetManagers(task)
  for i, managerFuncs in ipairs(task.feedbackSystem.targetManagers) do
    if managerFuncs.cleanup then
      managerFuncs.cleanup()
    end
  end
  task.feedbackSystem.targetManagers = nil
end
function addTaskHUD(task)
  local HUD = {updateRate = 0, updateStep = 0}
  if task.HUDParams then
    HUD.updateRate = task.HUDParams.updateRate or 4
    for i, HUDInfo in ipairs(task.HUDParams) do
      assert(feedbackSystem.HUDBuilders[HUDInfo.style], "FEEDBACKSYSTEM - setTaskFeedback: Couldn't find specified HUD: " .. tostring(HUDInfo.style))
      local subHUD = {
        HUDStyle = HUDInfo.style
      }
      subHUD.update, subHUD.goalComplete, subHUD.taskComplete, subHUD.cleanup = feedbackSystem.HUDBuilders[HUDInfo.style].mission(task, HUDInfo.settings or {})
      if not gameStatus.splitscreenSession and subHUD.update then
        subHUD.update(task.taskObject)
      end
      HUD[i] = subHUD
    end
  end
  task.feedbackSystem.HUD = HUD
end
function removeTaskHUD(task)
  for i, HUDFuncs in ripairs(task.feedbackSystem.HUD) do
    if HUDFuncs.update and not gameStatus.splitscreenSession then
      HUDFuncs.update(task.taskObject)
    end
    if HUDFuncs.cleanup then
      HUDFuncs.cleanup(task.taskObject)
    end
  end
  task.feedbackSystem.HUD = nil
end
function addTaskAPIP(task)
  local newAPIP = {}
  if task.audioPIPParams then
    assert(feedbackSystem.APIPBuilders[task.audioPIPParams], "FEEDBACKSYSTEM - setTaskFeedback: Couldn't find specified Audio/PIP manager: " .. tostring(task.audioPIPParams))
    newAPIP.update, newAPIP.goalComplete, newAPIP.taskComplete = feedbackSystem.APIPBuilders[task.audioPIPParams](task)
    if newAPIP.update then
      newAPIP.update()
    end
  end
  task.feedbackSystem.APIP = newAPIP
end
function removeTaskAPIP(task)
  task.feedbackSystem.APIP = nil
end
function purge()
  for taskObjectID, hookData in next, hookedTaskObjects, nil do
    releaseTaskObjectHook(hookData.taskObject)
  end
end
function goalComplete(task, conditionKey)
  if task.feedbackSystem.HUD then
    for i, HUDFuncs in ipairs(task.feedbackSystem.HUD) do
      if HUDFuncs.goalComplete then
        HUDFuncs.goalComplete(conditionKey)
      end
    end
  end
  if task.feedbackSystem.APIP and task.feedbackSystem.APIP.goalComplete then
    task.feedbackSystem.APIP.goalComplete(conditionKey)
  end
end
function taskComplete(task, success, conditionKey)
  if task.feedbackSystem.HUD then
    for i, HUDFuncs in ipairs(task.feedbackSystem.HUD) do
      if HUDFuncs.taskComplete then
        HUDFuncs.taskComplete(task.taskObject)
      end
    end
  end
  if task.feedbackSystem.APIP and task.feedbackSystem.APIP.taskComplete then
    task.feedbackSystem.APIP.taskComplete(conditionKey)
  end
  clearTaskFeedback(task)
end
function updateTaskTargetManager(task, targetsToRemove)
  if task.feedbackSystem.targetManagers then
    for i, managerFuncs in ipairs(task.feedbackSystem.targetManagers) do
      if managerFuncs.updateOnGoal and managerFuncs.update then
        managerFuncs.update(targetsToRemove)
      end
    end
  end
end
function instanceUpdateEvent()
  for taskObjectID, hookData in next, hookedTaskObjects, nil do
    local highestMajorOrder = 0
    for i, majorOrder in next, hookData.taskObject.taskList, nil do
      if i > highestMajorOrder then
        highestMajorOrder = i
      end
    end
    if highestMajorOrder > 0 then
      for i, task in ipairs(hookData.taskObject.taskList[highestMajorOrder]) do
        if task.feedbackSystem then
          for i, managerFuncs in ipairs(task.feedbackSystem.targetManagers) do
            if managerFuncs.updateOnInstance then
              managerFuncs.update()
            end
          end
        end
      end
    end
    for i, task in ipairs(hookData.taskObject.minorTasks) do
      if task.feedbackSystem then
        for i, managerFuncs in ipairs(task.feedbackSystem.targetManagers) do
          if managerFuncs.updateOnInstance then
            managerFuncs.update()
          end
        end
      end
    end
  end
end
function zapUpdateEvent()
  for taskObjectID, hookData in next, hookedTaskObjects, nil do
    local highestMajorOrder = 0
    for i, majorOrder in next, hookData.taskObject.taskList, nil do
      if i > highestMajorOrder then
        highestMajorOrder = i
      end
    end
    if highestMajorOrder > 0 then
      for i, task in ipairs(hookData.taskObject.taskList[highestMajorOrder]) do
        if task.feedbackSystem then
          for i, managerFuncs in ipairs(task.feedbackSystem.targetManagers) do
            if managerFuncs.updateOnZap then
              managerFuncs.update()
            end
          end
        end
      end
    end
    for i, task in ipairs(hookData.taskObject.minorTasks) do
      if task.feedbackSystem then
        for i, managerFuncs in ipairs(task.feedbackSystem.targetManagers) do
          if managerFuncs.updateOnZap then
            managerFuncs.update()
          end
        end
      end
    end
  end
end
