local removeCheckpointTimeOut = function(task, checkpointID)
  if task and task.dynamicTargets then
    for i, checkpoint in ipairs(task.dynamicTargets) do
      if checkpoint.checkpointNum == checkpointID then
        taskSystem.updateTaskDynamicTargets(task, {i}, false)
        if not localPlayer.inZap and not gameStatus.splitscreenSession then
          OneShotSound.PlayAtPosition("HUD_CheckPointFail_Play", checkpoint.position, vec.vector(0, 0, 0, 0), vec.vector(0, 0, 0, 0), false)
        end
        break
      end
    end
  end
end
taskSystem.registerTask("MP Gate Activation", nil, function(task)
  local goalCallback, AIUpdate, cleanup
  local function goalCallback(success, condition, data, goalData)
    local package = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    local globalTarget = package.namedTasks.gateTracking.networkVars.leadCheckPoint
    local numCheckPoints = #task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].route - 1
    local checkPointsToAdd = {}
    local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(task.instance.instanceID, 1)
    local checkPointTask = task.agent.getTaskObject().namedTasks.checkpoints
    local cpDynamicTargets = checkPointTask and checkPointTask.dynamicTargets or false
    if cpDynamicTargets then
      if globalTarget - 1 > 0 then
        local found = false
        for i, target in ipairs(cpDynamicTargets) do
          if target.checkpointNum == globalTarget - 1 then
            found = true
            break
          end
        end
        if found then
          checkpointSystem.activateOnlineCheckpoint(globalTarget - 1, checkPointTask, globalTarget - 1, removeCheckpointTimeOut)
        end
      else
        local found = false
        for i, target in ipairs(cpDynamicTargets) do
          if target.checkpointNum == numCheckPoints then
            found = true
            break
          end
        end
        if found then
          checkpointSystem.activateOnlineCheckpoint(numCheckPoints, checkPointTask, numCheckPoints, removeCheckpointTimeOut)
        end
      end
    end
    if allCheckpoints[globalTarget] then
      checkpointSystem.resetOnlineCheckpoint(allCheckpoints[globalTarget].checkpointNum)
      table.insert(checkPointsToAdd, allCheckpoints[globalTarget])
    end
    if checkPointTask and cpDynamicTargets and #checkPointsToAdd > 0 then
      taskSystem.updateTaskDynamicTargets(checkPointTask, false, checkPointsToAdd)
    end
  end
  return goalCallback, nil, cleanup
end)
