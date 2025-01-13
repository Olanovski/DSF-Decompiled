module("goalSystem.taskSupport", package.seeall)
registeredObjects = {}
local generateFeedbackUpdater = function(task, feedbackName)
  return function(value)
    task.goalFeedback[feedbackName] = value
  end
end
function generateConditionData(baseConditions, task, dynamicTargetID, overrideFeedbackFunction)
  local conditionTable = {}
  local target = dynamicTargetID > 0 and task.dynamicTargets[dynamicTargetID]
  assert(dynamicTargetID < 1 or target, [[
GOALSYSTEM TASKSUPPORT - generateConditionData:
 Specified dynamicTargetID ']] .. tostring(dynamicTargetID) .. "' gave no matching target")
  for conditionKey, condition in ipairs(baseConditions) do
    if #condition == 0 then
      printTable(baseConditions)
    end
    assert(#condition > 0, [[
GOALSYSTEM TASKSUPPORT - generateConditionData:
 baseConditions table appears empty, numerically ordered entries expected]])
    local conditionData = {
      autoRefresh = condition.autoRefresh == true,
      skipTargetUpdate = condition.skipTargetUpdate == true,
      triggerCount = condition.triggerCount,
      timesTriggered = 0,
      __index = {
        task = true,
        object = task,
        conditionKey = conditionKey,
        activeGoal = 1,
        operandA = task,
        operandB = target,
        dynamicTargetID = dynamicTargetID
      }
    }
    for goalInfoKey, goalInfo in ipairs(condition) do
      local parameters = {}
      if goalInfo.params then
        if goalInfo.params.coreValue then
          parameters = goalInfo.params
          parameters.value = task.coreData[goalInfo.params.coreValue]
        else
          parameters = goalInfo.params
        end
      end
      local goalData = {
        name = goalInfo.goal,
        goalKey = goalInfoKey,
        goalValue = parameters,
        feedback = goalInfo.feedback and generateFeedbackUpdater(task, goalInfo.feedback),
        feedbackResetValue = goalInfo.feedbackResetValue or false
      }
      if overrideFeedbackFunction then
        goalData.feedback = overrideFeedbackFunction
      end
      setmetatable(goalData, conditionData)
      conditionData[goalInfoKey] = goalData
    end
    conditionTable[conditionKey] = conditionData
    goalSystem.createActiveCondition(conditionData)
  end
  return conditionTable
end
function registerTask(task)
  assert(not registeredObjects[task], [[
GOALSYSTEM TASKSUPPORT - registerTask:
 Attempt to re-register a task]])
  local baseTaskData = taskSystem.getTaskBaseParameters(task)
  local dataTable = {}
  if baseTaskData.taskConditions then
    dataTable.taskCompletionConditions = generateConditionData(baseTaskData.taskConditions, task, -1)
  end
  if baseTaskData.goalConditions then
    if not task.dynamicTargets or baseTaskData.goalConditions.forceNoTarget then
      dataTable.noTargetConditions = generateConditionData(baseTaskData.goalConditions, task, 0)
    else
      local dynamicConditions = {}
      for i, target in ipairs(task.dynamicTargets) do
        dynamicConditions[i] = generateConditionData(baseTaskData.goalConditions, task, i)
      end
      dataTable.dynamicConditions = dynamicConditions
    end
  end
  registeredObjects[task] = dataTable
end
function unregisterTask(task)
  local dataTable = registeredObjects[task]
  if dataTable then
    if dataTable.taskCompletionConditions then
      goalSystem.clearActiveConditions(dataTable.taskCompletionConditions)
    end
    if dataTable.noTargetConditions then
      goalSystem.clearActiveConditions(dataTable.noTargetConditions)
    end
    if dataTable.dynamicConditions then
      for i, targetConditons in ipairs(dataTable.dynamicConditions) do
        goalSystem.clearActiveConditions(targetConditons)
      end
    end
  end
  registeredObjects[task] = nil
end
function synchroniseWithDynamicTargets(task, targetsToRemove)
  local dynamicConditions = registeredObjects[task].dynamicConditions
  if targetsToRemove then
    for i, dynamicTargetID in ripairs(targetsToRemove) do
      goalSystem.clearActiveConditions(dynamicConditions[dynamicTargetID])
      for j = dynamicTargetID + 1, #dynamicConditions do
        local targetConditions = dynamicConditions[j]
        for k, condition in ipairs(targetConditions) do
          condition.__index.dynamicTargetID = j - 1
        end
      end
      table.remove(dynamicConditions, dynamicTargetID)
    end
  end
  local baseGoalConditions = taskSystem.getTaskBaseParameters(task).goalConditions
  assert(#baseGoalConditions > 0, [[
GOALSYSTEM TASKSUPPORT - synchroniseWithDynamicTargets:
 goalConditions table appears empty, numerically ordered entries expected]])
  for i, target in ipairs(task.dynamicTargets) do
    if not dynamicConditions[i] then
      dynamicConditions[i] = generateConditionData(baseGoalConditions, task, i)
    end
  end
end
function goalComplete(condition, completionData)
  local conditionData = condition.__index
  if conditionData.dynamicTargetID >= 0 then
    taskSystem.goalCompleteGoalSystemCallback(conditionData.object, conditionData.conditionKey, conditionData.dynamicTargetID, completionData)
  else
    taskSystem.taskCompleteGoalSystemCallback(conditionData.object, conditionData.conditionKey)
  end
end
function addNoTargetConditions(task, condition)
  assert(registeredObjects[task] and registeredObjects[task].noTargetConditions, "Attempting to add no target conditions to an empty table!")
  local numConditions = #registeredObjects[task].noTargetConditions
  condition.__index.conditionKey = condition.__index.conditionKey + numConditions
  table.insert(registeredObjects[task].noTargetConditions, condition)
end
function removeNoTargetCondition(task, index)
  assert(registeredObjects[task] and registeredObjects[task].noTargetConditions, "Attempting to remove no target conditions from an empty table!")
  for i, condition in pairs(registeredObjects[task].noTargetConditions) do
    if index < i then
      print("Decrementing condition key!")
      condition.__index.conditionKey = condition.__index.conditionKey - 1
    end
  end
  table.remove(registeredObjects[task].noTargetConditions, index)
end
