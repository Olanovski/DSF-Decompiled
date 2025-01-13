module("goalSystem.dareSupport", package.seeall)
registeredObjects = {}
local generateFeedbackUpdater = function(dare, feedbackHACK)
  return function(value)
    feedbackHACK(dare, value)
  end
end
local function generateConditionData(baseConditions, dare, feedbackHACK)
  local conditionTable = {}
  for conditionKey, condition in ipairs(baseConditions) do
    assert(#condition > 0, [[
GOALSYSTEM DARESUPPORT - generateConditionData:
 baseConditions table appears empty, numerically ordered entries expected]])
    local conditionData = {
      autoRefresh = false,
      __index = {
        dare = true,
        object = dare,
        conditionKey = conditionKey,
        activeGoal = 1,
        operandA = dare,
        operandB = false
      }
    }
    for goalInfoKey, goalInfo in ipairs(condition) do
      local goalData = {
        name = goalInfo.goal,
        goalKey = goalInfoKey,
        goalValue = goalInfo.params or {},
        feedback = goalInfo.feedback and generateFeedbackUpdater(dare, feedbackHACK),
        feedbackResetValue = goalInfo.feedbackResetValue or false
      }
      setmetatable(goalData, conditionData)
      conditionData[goalInfoKey] = goalData
    end
    conditionTable[conditionKey] = conditionData
    goalSystem.createActiveCondition(conditionData)
  end
  registeredObjects[dare] = conditionTable
  return conditionTable
end
function createDareGoals(dare)
  generateConditionData(dare.goals, dare, dareSystem.feedbackCallbackHACK)
end
function removeDareGoals(dare)
  if registeredObjects[dare] then
    for conditionKey, condition in ipairs(registeredObjects[dare]) do
      goalSystem.removeActiveCondition(condition)
    end
    registeredObjects[dare] = nil
  end
end
function goalComplete(condition)
  local conditionData = condition.__index
  dareSystem.dareGoalComplete(conditionData.object, conditionData.conditionKey)
end
