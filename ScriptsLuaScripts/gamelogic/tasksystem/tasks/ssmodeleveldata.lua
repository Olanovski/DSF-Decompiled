taskSystem.registerTask("SS Mode level data", {
  {
    name = "payload",
    startingValue = 1,
    parseType = "uinteger8"
  },
  {
    name = "laps",
    startingValue = 0,
    parseType = "uinteger8"
  }
}, function(task)
  local packageTaskObject = task.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  local workingVector = vec.vector()
  local routeIndex = task.instance.networkVars.routeIndex
  local function goalCallback(success, condition, completedLap, goalData)
    if completedLap then
      task.networkVars.laps = task.networkVars.laps + 1
      local racer
      for i = 1, task.instance.challenge.settings.maxNumRacers do
        racer = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
        if racer then
          checkpointTracker.removeTracker(racer)
          racer:delete()
        end
      end
    else
      packageTaskObject.namedTasks.score.networkVars.payload = packageTaskObject.namedTasks.score.networkVars.payload + 1
      task.instance.currentSSLevel = packageTaskObject.namedTasks.score.networkVars.payload
      local level = packageTaskObject.namedTasks.score.networkVars.payload
      local location = phaseManager.playlistSupport.getSelectedLocation()
      assert(location >= 1 and location <= 3, "Mode location not between 1 and 3")
      local racer
      for i = 1, task.instance.challenge.settings.maxNumRacers do
        racer = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
        if racer then
          checkpointTracker.removeTracker(racer)
          racer:delete()
        end
      end
      if level ~= 11 then
        local spawnVehicles = {}
        for i = 1, task.instance.challenge.settings.numRacersPerLevel[location][level] do
          table.insert(spawnVehicles, {
            modelID = task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].racerVehicles[level],
            shaderParams = {
              [0] = framework.random(0, 5)
            }
          })
        end
        local spawnData = {
          type = "Grid",
          position = task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].spawnPositions[level].pos,
          gridSpacing = 10,
          vehicles = spawnVehicles,
          heading = task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].spawnPositions[level].heading,
          gridMaxVehicles = task.instance.challenge.settings.numRacersPerLevel[location][level],
          staggeredGridSpacing = 0
        }
        local playerOneTarget = false
        local playerTwoTarget = false
        local grid = Spawn.Spawn(spawnData)
        local vehicle, racerTaskObject
        for i = 1, task.instance.challenge.settings.numRacersPerLevel[location][level] do
          vehicle = vehicleManager.takeOwnership({
            gameVehicle = grid[i]
          })
          racerTaskObject = task.instance:newActorFromAgent(OBJ_TEAM_ONE_STRING_TABLE[i], vehicle)
          checkpointTracker.addTracker(racerTaskObject, racerTaskObject.coreData.agent.gameVehicle)
          GameVehicleResource.setInfiniteMass(vehicle.gameVehicle, true)
          vehicle:set_damageMultiplier(0)
          if not playerOneTarget then
            playerOneTarget = vehicle
          else
            playerTwoTarget = playerTwoTarget or vehicle
          end
        end
        playerTwoTarget = playerTwoTarget or playerOneTarget
        assert(playerTwoTarget and playerTwoTarget, "SS Mode level data - no target vehicles to track")
        if not localPlayerManager.players[0].inZap or localPlayerManager.players[0].inZap and zapcontroller.getTargetZapLevel(0) == 0 then
          localPlayerManager.players[0]:SetZapLevel(1)
        end
        if playerOneTarget then
          localPlayerManager.players[0]:zapToAction(playerOneTarget)
          localPlayerManager.players[0].shiftToTarget = true
        end
        if not localPlayerManager.players[1].inZap or localPlayerManager.players[1].inZap and zapcontroller.getTargetZapLevel(1) == 0 then
          localPlayerManager.players[1]:SetZapLevel(1)
        end
        if playerTwoTarget then
          localPlayerManager.players[1]:zapToAction(playerTwoTarget)
          localPlayerManager.players[1].shiftToTarget = true
        end
        if task.instance.challenge.spawnPositions[routeIndex].playerVehicles[level + 1] and task.instance.challenge.spawnPositions[routeIndex].playerVehicles[level + 1] ~= task.instance.challenge.spawnPositions[routeIndex].playerVehicles[level] then
          TrafficSpooler.RequestMissionVehicle(task.instance.challenge.spawnPositions[routeIndex].playerVehicles[level + 1])
        end
        if task.instance.challenge.spawnPositions[routeIndex].playerVehicles[level - 1] and task.instance.challenge.spawnPositions[routeIndex].playerVehicles[level - 1] ~= task.instance.challenge.spawnPositions[routeIndex].playerVehicles[level] then
          TrafficSpooler.ReleaseMissionVehicle(task.instance.challenge.spawnPositions[routeIndex].playerVehicles[level - 1])
        end
        if task.instance.challenge.spawnPositions[routeIndex].racerVehicles[level + 1] and task.instance.challenge.spawnPositions[routeIndex].racerVehicles[level + 1] ~= task.instance.challenge.spawnPositions[routeIndex].racerVehicles[level] then
          TrafficSpooler.RequestMissionVehicle(task.instance.challenge.spawnPositions[routeIndex].racerVehicles[level + 1])
        end
        if task.instance.challenge.spawnPositions[routeIndex].racerVehicles[level - 1] and task.instance.challenge.spawnPositions[routeIndex].racerVehicles[level - 1] ~= task.instance.challenge.spawnPositions[routeIndex].racerVehicles[level] then
          TrafficSpooler.ReleaseMissionVehicle(task.instance.challenge.spawnPositions[routeIndex].racerVehicles[level - 1])
        end
      end
    end
  end
  return goalCallback
end)
