module("goalSystem.onlineProgressionSupport", package.seeall)
registeredObjects = {}
local generateConditionData = function(baseConditions, localPlayerTaskObject, object, key)
  local conditionTable = {}
  for conditionKey, condition in ipairs(baseConditions) do
    assert(#condition > 0, [[
GOALSYSTEM ONLINEPROGRESSIONSUPPORT - generateConditionData:
 baseConditions table appears empty, numerically ordered entries expected]])
    local conditionData = {
      autoRefresh = condition.autoRefresh == true,
      __index = {
        onlineProgression = true,
        object = key,
        conditionKey = conditionKey,
        activeGoal = 1,
        operandA = localPlayerTaskObject,
        operandB = object
      }
    }
    for goalInfoKey, goalInfo in ipairs(condition) do
      local goalData = {
        name = goalInfo.goal,
        goalKey = goalInfoKey,
        goalValue = goalInfo.params or {}
      }
      setmetatable(goalData, conditionData)
      conditionData[goalInfoKey] = goalData
    end
    conditionTable[conditionKey] = conditionData
    goalSystem.createActiveCondition(conditionData)
  end
  return conditionTable
end
function registerObject(object, key, baseConditions)
  local localPlayerTaskObject = localPlayer.missionSupport:getMainTaskObject()
  assert(localPlayerTaskObject, [[
GOALSYSTEM ONLINEPROGRESSIONSUPPORT - registerObject:
 LocalPlayer taskObject was not available]])
  assert(not registeredObjects[object], [[
GOALSYSTEM ONLINEPROGRESSIONSUPPORT - registerObject:
 Attempt to re-register a task]])
  registeredObjects[key] = generateConditionData(baseConditions, localPlayerTaskObject, object, key)
end
function unregisterObject(object)
  if registeredObjects[object] then
    goalSystem.clearActiveConditions(registeredObjects[object])
    registeredObjects[object] = nil
  end
end
function unregisterAllObjects()
  for object, conditionData in next, registeredObjects, nil do
    unregisterObject(object)
  end
end
function goalComplete(condition, completionData)
  local conditionData = condition.__index
  onlineProgressionSystem.progressionGoalCompleteCallback(conditionData.object, conditionData.conditionKey, completionData)
end
