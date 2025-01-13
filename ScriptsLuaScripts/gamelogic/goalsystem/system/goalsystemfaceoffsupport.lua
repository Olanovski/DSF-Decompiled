module("goalSystem.faceOffSupport", package.seeall)
registeredObjects = {}
local generateConditionData = function(baseConditions, faceOff)
  local conditionTable = {}
  for conditionKey, condition in ipairs(baseConditions) do
    assert(#condition > 0, "GOALSYSTEM - generateConditionData: baseConditions table is empty, entries expected")
    local conditionData = {
      autoRefresh = true,
      __index = {
        faceOff = true,
        object = faceOff,
        conditionKey = conditionKey,
        activeGoal = 1,
        operandA = faceOff,
        operandB = false
      }
    }
    conditionTable[conditionKey] = conditionData
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
        goalValue = parameters
      }
      setmetatable(goalData, conditionData)
      conditionTable[conditionKey][goalInfoKey] = goalData
    end
  end
  registeredObjects[faceOff] = conditionTable
  for conditionKey, condition in ipairs(conditionTable) do
    goalSystem.createActiveCondition(condition)
  end
end
function createFaceOffGoals(faceOff)
  generateConditionData(faceOff.faceOff.goals, faceOff)
end
function removeFaceOffGoals(faceOff)
  if registeredObjects[faceOff] then
    for conditionKey, condition in ipairs(registeredObjects[faceOff]) do
      goalSystem.removeActiveCondition(condition)
    end
    registeredObjects[faceOff] = nil
  end
end
function goalComplete(condition, completionData)
  local conditionData = condition.__index
  faceOffSystem.faceOffGoalCallback(conditionData.object, conditionData.conditionKey, completionData)
end
