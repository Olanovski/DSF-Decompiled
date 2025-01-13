taskSystem.registerTask("SS Charge Blazing Vehicle", {
  {
    name = "payload",
    startingValue = 1,
    parseType = "uinteger8"
  }
}, function(task)
  local blazingTaskObject = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local routeTask
  local settings = task.instance.challenge.settings
  local location = phaseManager.playlistSupport.getSelectedLocation()
  assert(location >= 1 and location <= 3, "Mode location not between 1 and 3")
  local function goalCallback(success, condition, completedLap, goalData)
    routeTask = blazingTaskObject.namedTasks.fuel
    if routeTask.networkVars.routeIndex < 11 then
      if condition == 1 then
        if routeTask.networkVars.fuel and settings.fuelReplenishRates[location][routeTask.networkVars.routeIndex] and goalData then
          routeTask.networkVars.fuel = routeTask.networkVars.fuel + settings.fuelReplenishRates[location][routeTask.networkVars.routeIndex] * goalData
          if routeTask.networkVars.fuel > 100 then
            routeTask.networkVars.fuel = 100
          end
          task.agent.currentVehicle.fuel = task.agent.currentVehicle.fuel - settings.fuelDepletionRates[location][routeTask.networkVars.routeIndex]
          if task.agent.currentVehicle.fuel <= 0 then
            task.agent.currentVehicle.damage = 1
            task.agent.currentVehicle.gameVehicle.damage = 1
            task.agent.currentVehicle.networkVars.onlineRequiredVehicle = nil
            task.agent.currentVehicle.lastLocalOwerID = nil
            task.agent.currentVehicle.fuel = 0
            onlineInstructionSupport.displayPrompt("ID:246053", nil, task.agent.localID)
          end
        end
      elseif condition == 2 then
        task.agent.currentVehicle.fuel = settings.playerVehicleFuel[location][routeTask.networkVars.routeIndex]
        task.agent.currentVehicle.networkVars.onlineRequiredVehicle = true
        task.agent.currentVehicle.lastLocalOwerID = task.agent.localID
      elseif condition == 3 then
        for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
          if vehicle.lastLocalOwerID == task.agent.localID then
            vehicle.damage = 1
            vehicle.gameVehicle.damage = 1
            vehicle.networkVars.onlineRequiredVehicle = nil
            vehicle.lastLocalOwerID = nil
            break
          end
        end
      end
    end
  end
  return goalCallback
end)
