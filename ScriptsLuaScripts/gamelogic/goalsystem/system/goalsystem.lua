module("goalSystem", package.seeall)
registeredGoals = {}
activeGoals = {}
activeConditions = {n = 0}
function registerGoal(goalName, goalFunction)
  if LIVERELOAD_ACTIVE then
    print("registerGoal " .. goalName)
  end
  assert(not registeredGoals[goalName] or LIVERELOAD_ACTIVE, [[
GOALSYSTEM - RegisterGoal:
 Attempt to re-register existing goal: ]] .. tostring(goalName))
  registeredGoals[goalName] = {goalFunction = goalFunction}
end
function purge()
  for i, testCondition in ripairs(activeConditions) do
    table.remove(activeConditions, i)
    activeConditions.n = activeConditions.n - 1
  end
end
function update()
  if not localPlayer.challenge.showingEndScreen and not localPlayer.challenge.retryingMission then
    if debugInfo.showActiveMissionLogic and debugInfo.showActiveMissionLogic == true then
      debug_DisplayActiveGoals()
    end
    for i = activeConditions.n, 1, -1 do
      local condition = activeConditions[i]
      if condition then
        local j = 1
        repeat
          condition[j].update()
          j = j + 1
        until j > condition.__index.activeGoal or not condition[j]
      end
    end
  end
end
function createActiveGoal(goalData, runUpdate)
  assert(registeredGoals[goalData.name], [[
GOALSYSTEM - createActiveGoal:
 Attempt to activate unknown goal: ]] .. tostring(goalData.name))
  assert(goalData.operandA, [[
GOALSYSTEM - createActiveGoal:
 No primary operand given]])
  assert(not goalData.UID, [[
GOALSYSTEM - createActiveGoal:
 Goal specified is already an active goal]])
  local UID = 0
  while activeGoals[UID] do
    UID = UID + 1
  end
  activeGoals[UID] = goalData
  goalData.UID = UID
  goalData.update, goalData.cleanup = registeredGoals[goalData.name].goalFunction(goalData.operandA, goalData.operandB, UID, goalData.goalValue, goalData.feedback)
  if runUpdate then
    goalData.update()
  end
end
function removeActiveGoal(goalData)
  assert(goalData.UID, [[
GOALSYSTEM - removeActiveGoal:
 Goal specified is not an active goal]])
  if goalData.feedback then
    goalData.feedback(goalData.feedbackResetValue)
  end
  if goalData.cleanup then
    goalData.cleanup()
  end
  activeGoals[goalData.UID] = nil
  goalData.UID = nil
  goalData.update = nil
  goalData.cleanup = nil
end
function createActiveCondition(condition)
  condition.active = true
  condition.completed = false
  condition.__index.activeGoal = 1
  createActiveGoal(condition[1], false)
  table.insert(activeConditions, condition)
  activeConditions.n = activeConditions.n + 1
end
function removeConditionActiveGoals(condition)
  for i = condition.__index.activeGoal, 1, -1 do
    removeActiveGoal(condition[i])
  end
  condition.__index.activeGoal = 0
end
function removeActiveCondition(condition)
  removeConditionActiveGoals(condition)
  condition.active = false
  for i, testCondition in ipairs(activeConditions) do
    if testCondition == condition then
      table.remove(activeConditions, i)
      activeConditions.n = activeConditions.n - 1
      break
    end
  end
end
function clearActiveConditions(conditions)
  for i, condition in ripairs(conditions) do
    removeActiveCondition(condition)
    table.remove(conditions, i)
  end
end
function updateCondition(condition, goalData, completionData)
  if goalData.goalKey < goalData.activeGoal then
    for goalKey = goalData.goalKey + 1, goalData.activeGoal do
      removeActiveGoal(condition[goalKey])
    end
    condition.__index.activeGoal = goalData.goalKey
    condition.completed = false
  elseif goalData.goalKey == #condition then
    if not condition.completed then
      conditionCompleteCallback(condition, completionData)
    else
      condition.completed = false
    end
  else
    condition.__index.activeGoal = goalData.goalKey + 1
    createActiveGoal(condition[condition.__index.activeGoal], true)
  end
end
function callbackHandler(UID, completionData)
  local goalData = activeGoals[UID]
  local condition = getmetatable(goalData)
  updateCondition(condition, goalData, completionData)
end
function conditionCompleteCallback(condition, completionData)
  if condition.autoRefresh then
    removeConditionActiveGoals(condition)
  else
    condition.completed = true
  end
  local subSystem
  if condition.__index.task then
    subSystem = taskSupport
  elseif condition.__index.faceOff then
    subSystem = faceOffSupport
  elseif condition.__index.dare then
    subSystem = dareSupport
  elseif condition.__index.onlineProgression then
    subSystem = onlineProgressionSupport
  end
  subSystem.goalComplete(condition, completionData)
  if condition.autoRefresh and condition.active then
    condition.__index.activeGoal = 1
    createActiveGoal(condition[1], false)
  end
  if condition.triggerCount then
    condition.timesTriggered = condition.timesTriggered + 1
    if condition.timesTriggered >= condition.triggerCount then
      removeActiveCondition(condition)
    end
  end
end
local goalSystem_DebugTextID = 98989
local goalSystem_debugText_textPosition = vec.vector(0.65, 0.1, 0, 0)
local gs_debugTextColour = vec.vector(1, 1, 1, 1)
function debug_DisplayActiveGoals()
  local y = 0.1
  debug_removeDisplayActiveGoals()
  for i, condition in ripairs(activeConditions) do
    for j, goalData in iActiveGoals(condition) do
      Development:add2DText(goalSystem_DebugTextID, goalData.name, goalSystem_debugText_textPosition, gs_debugTextColour, 0.5, -1)
      goalSystem_DebugTextID = goalSystem_DebugTextID + 1
      y = y + 0.02
      goalSystem_debugText_textPosition[1] = y
    end
  end
end
function debug_removeDisplayActiveGoals()
  local gs_counter
  for gs_counter = 98989, goalSystem_DebugTextID - 1 do
    Development:eraseText(gs_counter)
  end
  goalSystem_DebugTextID = 98989
end
