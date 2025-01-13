taskSystem.registerTask("Linear Follow Route", {
  {
    name = "routeIndex",
    startingValue = 1,
    parseType = "integer8"
  },
  {
    name = "fuel",
    startingValue = 100,
    parseType = "integer8"
  }
}, function(task)
  local speedAdded = false
  local routeIndex = task.instance.networkVars.routeIndex
  local location = phaseManager.playlistSupport.getSelectedLocation()
  assert(location >= 1 and location <= 3, "Mode location not between 1 and 3")
  task.agent.lastDesiredSpeedIncrease = 0
  local function createBehaviour(fromGoalTask)
    local behaviour = {
      traits = deepCopy(goTheDistanceAI.AITraits[task.networkVars.routeIndex]),
      roadRoute = task.instance.challenge.spawnPositions[routeIndex].roads[task.networkVars.routeIndex],
      routeName = task.instance.challenge.spawnPositions[routeIndex].routeNames[task.networkVars.routeIndex]
    }
    if fromGoalTask == 3 then
      speedAdded = false
      for i, player in next, localPlayerManager.players, nil do
        if player.currentVehicle and GameVehicleResource.interceptingTrailCount(player.currentVehicle.gameVehicle) ~= 0 then
          task.agent.lastDesiredSpeedIncrease = task.agent.lastDesiredSpeedIncrease + task.instance.challenge.settings.inTrailsSpeedIncrease
          speedAdded = true
          break
        end
      end
      if not speedAdded then
        task.agent.lastDesiredSpeedIncrease = task.agent.lastDesiredSpeedIncrease - task.instance.challenge.settings.outTrailsSpeedDecrease
      end
      if task.agent.lastDesiredSpeedIncrease > task.instance.challenge.settings.maxBonusSpeed then
        task.agent.lastDesiredSpeedIncrease = task.instance.challenge.settings.maxBonusSpeed
      elseif 0 > task.agent.lastDesiredSpeedIncrease then
        task.agent.lastDesiredSpeedIncrease = 0
      end
    end
    behaviour.traits.desiredSpeed = behaviour.traits.desiredSpeed + task.agent.lastDesiredSpeedIncrease
    return behaviour
  end
  local function AIUpdate(fromGoalTask)
    if task.instance.currentSSLevel ~= 11 then
      task.agent:highSpeedDrive(createBehaviour(fromGoalTask))
    end
  end
  local function goalCallback(success, condition, routeCompleted)
    if condition == 1 then
      task.networkVars.fuel = task.networkVars.fuel + task.instance.challenge.settings.fuelBonus[location][task.networkVars.routeIndex]
      if task.networkVars.fuel > 100 then
        task.networkVars.fuel = 100
      end
      task.networkVars.routeIndex = task.networkVars.routeIndex + 1
      task.instance.currentSSLevel = task.networkVars.routeIndex
      task.networkVars.checkpoints = 1
      AIUpdate()
      onlineInstructionSupport.displayPrompt("ID:99765", nil, 0)
      onlineInstructionSupport.displayPrompt("ID:99765", nil, 1)
      if task.networkVars.routeIndex < 11 then
        local lastFuelCap = task.instance.challenge.settings.playerVehicleFuel[location][task.networkVars.routeIndex - 1]
        local currentFuelCap = task.instance.challenge.settings.playerVehicleFuel[location][task.networkVars.routeIndex]
        local lastPercentage = 0
        if localPlayerManager.players[0].currentVehicle and localPlayerManager.players[0].currentVehicle.fuel then
          lastPercentage = localPlayerManager.players[0].currentVehicle.fuel / lastFuelCap
          localPlayerManager.players[0].currentVehicle.fuel = currentFuelCap * lastPercentage
        end
        if localPlayerManager.players[1].currentVehicle and localPlayerManager.players[1].currentVehicle.fuel then
          lastPercentage = localPlayerManager.players[1].currentVehicle.fuel / lastFuelCap
          localPlayerManager.players[1].currentVehicle.fuel = currentFuelCap * lastPercentage
        end
      end
      task.agent:setLightTrailLength(task.instance.challenge.settings.trailLengths[location][task.networkVars.routeIndex])
    elseif condition == 2 and task.networkVars.fuel > 0 then
      task.networkVars.fuel = task.networkVars.fuel - task.instance.challenge.settings.fuelDepletionRates[location][task.networkVars.routeIndex]
    end
  end
  return goalCallback, AIUpdate
end)
