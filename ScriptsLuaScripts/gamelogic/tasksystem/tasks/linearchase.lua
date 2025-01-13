taskSystem.registerTask("Linear Chase", {
  {
    name = "eliminatedTargets",
    startingValue = false,
    parseType = "boolean"
  }
}, function(task)
  local behaviour = {
    traits = taskSystem.buildChaseTraits(task)
  }
  local chasedGameVehicle
  if task.specialName == "Voices in my head possessed civs" then
    chasedGameVehicle = localPlayer.primaryFelony.chasers[1]
  else
    chasedGameVehicle = task.dynamicTargets[1].gameVehicle
  end
  if chasedGameVehicle and task.agent.controlled then
    vehicleManager.RegisterChasedVehicle(chasedGameVehicle)
    vehicleManager.RegisterChasingVehicleAsChaser(chasedGameVehicle, task.agent.gameVehicle, "Player")
    printTable(vehicleManager.chasingGameVehiclesByChasedGameVehicle)
  end
  local function AIUpdate(nonGoalUpdate)
    if #task.dynamicTargets ~= 0 then
      behaviour.opponentGameVehicle = chasedGameVehicle
    end
    task.agent:highSpeedDrive(behaviour)
  end
  local function goalCallback(success, condition, eliminatedAll, goalData)
    if eliminatedAll then
      task.networkVars.eliminatedTargets = true
    end
  end
  return goalCallback, AIUpdate
end)
