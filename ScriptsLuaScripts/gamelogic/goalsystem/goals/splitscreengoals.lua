local workingVector = vec.vector()
goalSystem.registerGoal("SS Player in shift", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if params.value == operandA.agent.inZap then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS race score event", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local instance = operandA.instance
  local numCheckpoints = #checkpointSystem.getNoneSyncronisedCheckpoints(instance.instanceID, 1)
  return function()
    for localPlayerID, player in next, localPlayerManager.players, nil do
      if player.currentVehicle and player.currentVehicle == operandA.agent then
        feedbackSystem.splitScreenSupport.updateScoringBar(localPlayerID, operandA.networkVars.checkpoints + operandA.networkVars.laps * numCheckpoints)
        break
      end
    end
    if not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("SS checkpoint race score event", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  return function()
    feedbackSystem.splitScreenSupport.updateScoringBar(operandA.agent.localID, operandA.agent.getTaskObject().namedTasks.checkpoints.networkVars.checkpointsPassed + 1)
    if not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("SS payload score event", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  return function()
    feedbackSystem.splitScreenSupport.updateScoringBar(operandA.agent.localID, operandA.agent:getTaskObject().namedTasks.score.networkVars.payload + 1, params.singleBar, params.audio)
    if not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("SS Objective team 1 wrecked", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local instance = operandA.instance
  local goalConditionsMet = false
  return function()
    goalConditionsMet = true
    for i = 1, instance.challenge.settings.maxNumRacers do
      taskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
      if taskObject and 1 > taskObject.coreData.agent.damage then
        goalConditionsMet = false
        break
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS Objective team 1 within radius", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local instance = operandA.instance
  local goalConditionsMet = false
  local workingVector = vec.vector()
  local targetPosition = false
  local depth = 5
  local taskObject = false
  local roadIndex, distanceAlong, roadLength, minimum, maximum, vehicleRoadIndex, vehicleDistanceAlong
  return function()
    taskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    if not targetPosition or taskObject and taskObject.namedTasks.Checkpoints.dynamicTargets[1] and targetPosition ~= taskObject.namedTasks.Checkpoints.dynamicTargets[1].position then
      targetPosition = taskObject.namedTasks.Checkpoints.dynamicTargets[1].position
      roadIndex, distanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(targetPosition)
      roadLength = Atlas.RoadLength(roadIndex)
      minimum = distanceAlong - depth
      if minimum < 0 then
        minimum = 0
      end
      maximum = distanceAlong + depth
      if maximum > roadLength then
        maximum = roadLength
      end
    else
      goalConditionsMet = false
      for i = 1, params.value do
        taskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
        if taskObject then
          vehicleRoadIndex = taskObject.coreData.agent:get_closestRoadIndex()
          if vehicleRoadIndex == roadIndex then
            vehicleDistanceAlong = taskObject.coreData.agent:get_closestDistanceAlongRoad()
            if vehicleDistanceAlong > minimum and vehicleDistanceAlong < maximum then
              goalConditionsMet = true
              break
            end
          end
        end
      end
      if goalConditionsMet and not goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = true
      elseif not goalConditionsMet and goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = false
      end
    end
  end
end)
goalSystem.registerGoal("SS Mode Level equal", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = params.value == operandA.networkVars.payload
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS Players wrecked", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local wrecked = false
  return function()
    wrecked = false
    if not localPlayerManager.players[0].zapToNewVehicle and not localPlayerManager.players[1].zapToNewVehicle and (localPlayerManager.players[0].inZap or 1 <= localPlayerManager.players[0].currentVehicle.damage) and (localPlayerManager.players[1].inZap or 1 <= localPlayerManager.players[1].currentVehicle.damage) then
      wrecked = true
    end
    goalConditionsMet = params.value == wrecked
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Chaser spawn check", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local taskObject = false
  local packageTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]] or false
  local currentLevel = packageTO and packageTO.namedTasks.level and packageTO.namedTasks.level.networkVars.level or 1
  local stringID = -1
  local numChasers = -1
  return function()
    goalConditionsMet = false
    taskObject = false
    stringID = -1
    if numChasers < 0 then
      numChasers = #operandA.instance.challenge.spawnPositions[operandA.instance.networkVars.routeIndex].levelData[currentLevel].chasers
    end
    for i = params.start, numChasers, params.increment do
      taskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
      if not cardSystem.logic.survivalSwapStatus[i] then
        if not taskObject then
          stringID = i
          goalConditionsMet = true
          break
        elseif taskObject.namedTasks.chase and taskObject.namedTasks.chase.dynamicTargets and taskObject.namedTasks.chase.dynamicTargets[1] and workingVector:sub(taskObject.namedTasks.chase.dynamicTargets[1].position, taskObject.coreData.agent.position):length() > params.distance then
          stringID = i
          goalConditionsMet = true
          break
        end
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      assert(stringID > 0, "Object ID is <= 0: " .. tostring(stringID))
      goalSystem.callbackHandler(UID, stringID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS Chaser Target Player", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local playerID = -1
  local chaserNum = false
  local player = false
  local chaserType = false
  return function()
    goalConditionsMet = false
    playerID = -1
    for i, actorID in ipairs(OBJ_TEAM_ONE_STRING_TABLE) do
      if operandA.actor.ID == actorID then
        chaserNum = i
        break
      end
    end
    if math.mod(chaserNum, 2) == 0 then
      player = localPlayerManager.players[0].currentVehicle and localPlayerManager.players[1]
    else
      player = localPlayerManager.players[1].currentVehicle and localPlayerManager.players[0]
    end
    if player and player.currentVehicle and player.currentVehicle.damage < 1 then
      local vehicleDistance = workingVector:sub(operandA.agent.position, player.currentVehicle.position):length()
      local vehiclePositionDot = workingVector:sub(operandA.agent.position, player.currentVehicle.position):normalise():dot(player.currentVehicle.matrix[2])
      local engageBehaviour = taskSystem.taskObjects[operandA.taskObjectID].engageBehaviour
      playerID = player.localID
      if engageBehaviour <= 1 or player.currentVehicle.gameVehicle.speed < 30 or vehiclePositionDot < 0.5 or vehicleDistance < 30 * (engageBehaviour - 2) then
        goalConditionsMet = true
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, playerID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS Check Swap Complete", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    local chaserNum = -1
    for i, actorID in ipairs(OBJ_TEAM_ONE_STRING_TABLE) do
      if operandA.actor.ID == actorID then
        chaserNum = i
        break
      end
    end
    goalConditionsMet = taskSystem.taskObjects[operandA.taskObjectID].swapComplete
    if goalConditionsMet and not goalReportedSuccessful then
      print("Swap complete " .. chaserNum)
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS Within blaze", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local player = localPlayerManager.players[operandA.agent.localID]
  local numTrails
  return function()
    goalConditionsMet = false
    numTrails = GameVehicleResource.interceptingTrailCount(player.currentVehicle.gameVehicle)
    if numTrails ~= 0 then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, numTrails)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS target in zap", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local inZap = false
  return function()
    goalConditionsMet = false
    inZap = false
    if not localPlayerManager.getPlayerByGameVehicle(operandB.gameVehicle) then
      inZap = true
    end
    goalConditionsMet = params.value == inZap
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS Player in vehicle with no fuel", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local player = localPlayerManager.players[operandA.agent.localID]
  return function()
    if not player.currentVehicle.fuel then
      goalConditionsMet = true
    else
      goalConditionsMet = false
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS Player in shift status changed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if params.value == operandA.agent.inZap then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("Fuel level greater than or equal", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    if operandA.networkVars.fuel <= params.value then
      goalConditionsMet = true
    else
      goalConditionsMet = false
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Route index above", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    if operandA.networkVars.routeIndex > params.value then
      goalConditionsMet = true
    else
      goalConditionsMet = false
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS Player vehicle wrecked", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local player = localPlayerManager.players[operandA.agent.localID]
  return function()
    goalConditionsMet = params.value == (player.currentVehicle.damage >= 1)
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS hit by player", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local vehicleHit = false
  local playerOne = localPlayerManager.players[0]
  local playerTwo = localPlayerManager.players[1]
  local instance = operandA.instance
  local location = phaseManager.playlistSupport.getSelectedLocation()
  assert(location >= 1 and location <= 3, "Mode location not between 1 and 3")
  local function collisionCheck(collisionData)
    if collisionData.CollidedGameVehicle and collisionData.Force > instance.challenge.settings.hitRacerForces[location][instance.currentSSLevel] then
      vehicleHit = vehicleManager.vehiclesByGameVehicle[collisionData.CollidedGameVehicle]
      if playerOne.currentVehicle == vehicleHit or playerTwo.currentVehicle == vehicleHit then
        goalConditionsMet = true
      end
    end
  end
  local callbackSettings = {callbackFunction = collisionCheck, typeOfHit = "Vehicle"}
  operandA.agent:addCollisionCallback(callbackSettings)
  local function update()
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, instance.challenge.settings.racerLife[location][instance.currentSSLevel])
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    operandA.agent:removeCollisionCallback(callbackSettings)
  end
  return update, cleanup
end)
goalSystem.registerGoal("SS partner crossed checkpoint", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local partner = localPlayerManager.players[math.abs(operandA.agent.localID - 1)]
  local partnerTO = partner.getTaskObject()
  return function()
    goalConditionsMet = false
    if partnerTO.namedTasks.checkpoints then
      goalConditionsMet = params.value == (partnerTO.namedTasks.checkpoints.networkVars.checkpoints > operandA.networkVars.checkpoints or partnerTO.namedTasks.checkpoints.networkVars.laps > operandA.networkVars.laps)
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS player completed route", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local playerTO = localPlayerManager.players[0].getTaskObject()
  local lastCheckpoint = playerTO.namedTasks.checkpoints and playerTO.namedTasks.checkpoints.networkVars.laps or 0
  local player2TO = localPlayerManager.players[1].getTaskObject()
  return function()
    goalConditionsMet = false
    if playerTO.namedTasks.checkpoints then
      if playerTO.namedTasks.checkpoints.networkVars.laps == player2TO.namedTasks.checkpoints.networkVars.laps then
        if playerTO.namedTasks.checkpoints.networkVars.laps > lastCheckpoint then
          goalConditionsMet = params.value == true
        else
          goalConditionsMet = params.value == false
        end
      else
        goalConditionsMet = params.value == false
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS survival level above", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  return function()
    goalConditionsMet = false
    if packageTO.namedTasks.level then
      goalConditionsMet = packageTO.namedTasks.level.networkVars.level >= params.value
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS player shifting to new vehicle", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local isZapToNewVehicle = false
  return function()
    isZapToNewVehicle = false
    if operandA.agent.isPlayer then
      goalConditionsMet = params.value == operandA.agent.zapToNewVehicle
    else
      if localPlayerManager.players[0].zapToNewVehicle or localPlayerManager.players[1].zapToNewVehicle then
        isZapToNewVehicle = true
      end
      goalConditionsMet = params.value == isZapToNewVehicle
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS player shift returning", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = params.value == operandA.agent.zapReturning
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS player shift level greater or equal", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    if not operandA.agent.zapTransition then
      goalConditionsMet = zapcontroller.getZapLevel(operandA.agent.localID) >= params.value
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("No Players in blaze", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = true
    for localPlayerID, player in next, localPlayerManager.players, nil do
      if player.currentVehicle and GameVehicleResource.interceptingTrailCount(player.currentVehicle.gameVehicle) ~= 0 then
        goalConditionsMet = false
        break
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS Player distance travelled", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local currentTime = g_NetworkTime
  local distance = 0
  return function()
    if currentTime < g_NetworkTime then
      distance = distance + (g_NetworkTime - currentTime) * operandA.agent.currentVehicle.gameVehicle.displayedSpeed
    end
    currentTime = g_NetworkTime
    goalConditionsMet = distance > params.value
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, {ID = 1, points = distance})
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS jump", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local startJump = operandA.stat
  local lastDistance = operandA.agent.scoring:getTotalAirTimeDistance()
  local currentJump = 0
  return function()
    goalConditionsMet = false
    currentJump = operandA.agent.scoring:getTotalAirTimeDistance()
    goalConditionsMet = currentJump - lastDistance > startJump
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, {
        ID = 4,
        points = currentJump - lastDistance
      })
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS drift", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local startDrift = operandA.stat
  local currentdrift = 0
  return function()
    goalConditionsMet = false
    currentdrift = operandA.agent.scoring:getCurrentDriftDistance()
    goalConditionsMet = currentdrift > startDrift
    if goalConditionsMet and not goalReportedSuccessful then
      operandA.agent.scoring:resetDrift()
      goalSystem.callbackHandler(UID, {ID = 5, points = currentdrift})
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS speed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local lastSpeed = operandA.stat
  return function()
    goalConditionsMet = operandA.agent.currentVehicle.gameVehicle.displayedSpeed > lastSpeed
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, {
        ID = 3,
        points = operandA.agent.currentVehicle.gameVehicle.displayedSpeed
      })
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("SS new level reached", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  local lastLevel = packageTO and packageTO.namedTasks.level and packageTO.namedTasks.level.networkVars.level or 1
  return function()
    if packageTO and packageTO.namedTasks.level then
      goalConditionsMet = params.value == (packageTO.namedTasks.level.networkVars.level > lastLevel)
    else
      packageTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
