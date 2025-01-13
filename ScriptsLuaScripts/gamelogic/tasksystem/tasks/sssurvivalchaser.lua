taskSystem.registerTask("SS Survival Chase", nil, function(task)
  local packageTO = task.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  local level = packageTO and packageTO.namedTasks.level and packageTO.namedTasks.level.networkVars.level or 1
  local behaviour = {
    traits = deepCopy(survivalAI.AITraits[level])
  }
  local chasedGameVehicle = task.dynamicTargets[1].gameVehicle
  if chasedGameVehicle and task.agent.controlled then
    vehicleManager.RegisterChasedVehicle(chasedGameVehicle)
    vehicleManager.RegisterChasingVehicleAsChaser(chasedGameVehicle, task.agent.gameVehicle, "Player")
    printTable(vehicleManager.chasingGameVehiclesByChasedGameVehicle)
  end
  local function AIUpdate(nonGoalUpdate)
    if #task.dynamicTargets ~= 0 then
      if taskSystem.taskObjects[task.taskObjectID].engageBehaviour then
        if taskSystem.taskObjects[task.taskObjectID].engageBehaviour == 0 then
          behaviour.opponentGameVehicle = task.dynamicTargets[1].gameVehicle
        elseif taskSystem.taskObjects[task.taskObjectID].engageBehaviour > 1 then
          behaviour.traits.desiredSpeed = behaviour.traits.desiredSpeed * 0.7
        end
        task.agent:highSpeedDrive(behaviour)
      end
    else
      task.agent:stopHighSpeedDriving()
      local chaserTO = taskSystem.taskObjects[task.taskObjectID]
      chaserTO:delete()
    end
  end
  local goalCallback = function(success, condition, eliminatedAll, goalData)
  end
  return goalCallback, AIUpdate
end)
