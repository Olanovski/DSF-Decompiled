taskSystem.registerTask("Stop Vehicle", nil, function(task)
  local behaviour = {
    traits = {desiredSpeed = 0}
  }
  local function AIUpdate(nonGoalUpdate)
    task.agent:highSpeedDrive(behaviour)
  end
  local function goalCallback(success, condition, eliminatedAll, goalData)
    if eliminatedAll then
      task.networkVars.eliminatedTargets = true
    end
  end
  return goalCallback, AIUpdate
end)
