local workingVector = vec.vector()
goalSystem.registerGoal("Synced time trigger", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTaskObject
  if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
    packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  else
    packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  end
  local function update()
    goalConditionsMet = false
    if packageTaskObject.namedTasks and packageTaskObject.namedTasks.power then
      goalConditionsMet = g_NetworkTime > packageTaskObject.namedTasks.power.networkVars.syncedTime + params.value
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Agent is target taskObject owner", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = false
    if operandB.namedTasks.owner then
      goalConditionsMet = params.value == (operandA.agent.playerID == operandB.namedTasks.owner.networkVars.ownerID)
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Localplayer controlling taskObject agent", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local taskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local function update()
    if taskSystem.validTaskObject(taskObject) and localPlayer.currentVehicle then
      goalConditionsMet = params.value == (taskObject.coreData.agent.owner == localPlayer.currentVehicle)
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
  return update
end)
goalSystem.registerGoal("On team round switch", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local taskObject = taskSystem.taskObjects[operandA.taskObjectID]
  local function update()
    goalConditionsMet = params.value == (PlayerGamePlay.getPlayerTeam(taskObject.coreData.agent.playerID) == operandA.instance.networkVars.roundOn)
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Collision combo", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local comboTime = 0
  local overkillForce = 0
  local comboScore = 0
  local comboBreak = false
  local comboAgent = operandB.coreData.agent
  local function collisionCheck(collisionData)
    if collisionData.CollidedGameVehicle and comboAgent.damage < 1 then
      local collidingVehicle = vehicleManager.vehiclesByGameVehicle[collisionData.CollidedGameVehicle]
      local collisionForce = collisionData.Force - params.minForce
      local overkill = 0
      if collisionForce > params.maxForce then
        NetworkLog.Write("=== Capped Force = " .. math.ceil(collisionForce) .. " to " .. params.maxForce)
        overkill = collisionForce - params.maxForce
        collisionForce = params.maxForce
      end
      if collidingVehicle then
        if collidingVehicle.networkControlled and not collidingVehicle.networkControlled.inZap then
          comboBreak = true
          return
        elseif collidingVehicle == operandA.agent.currentVehicle and not operandA.inZap and collisionForce > 0 then
          comboScore = comboScore + math.ceil(collisionForce / params.directScaler)
          overkillForce = overkillForce + overkill
          comboTime = g_NetworkTime
          NetworkLog.Write("Direct CollisionForce = " .. math.ceil(collisionForce) .. ", score +" .. math.ceil(collisionForce / params.directScaler))
          return
        end
      end
      if comboTime > 0 and collisionForce > 0 then
        comboScore = comboScore + math.ceil(collisionForce / params.indirectScaler)
        NetworkLog.Write("Indirect CollisionForce = " .. math.ceil(collisionForce) .. ", score +" .. math.ceil(collisionForce / params.indirectScaler))
        comboTime = g_NetworkTime
      end
    end
  end
  local callbackSettings = {
    callbackFunction = collisionCheck,
    minimumForce = params.minForce,
    typeOfHit = "Vehicle"
  }
  comboAgent:addCollisionCallback(callbackSettings)
  local function update()
    if comboBreak or comboTime > 0 and g_NetworkTime - comboTime > params.comboTime then
      local overkillScore = 0
      if overkillForce > 90000 then
        overkillScore = 25
      elseif overkillForce > 70000 then
        overkillScore = 20
      elseif overkillForce > 50000 then
        overkillScore = 10
      elseif overkillForce > 30000 then
        overkillScore = 5
      end
      NetworkLog.Write("Combo = " .. comboScore + overkillScore .. " (" .. comboScore .. " + overkill " .. overkillScore .. " (" .. overkillForce .. "))")
      comboScore = comboScore + overkillScore
      if comboScore > params.maxScore then
        comboScore = params.maxScore
      end
      goalSystem.callbackHandler(UID, comboScore)
    end
  end
  local function cleanup()
    comboAgent:removeCollisionCallback(callbackSettings)
  end
  return update, cleanup
end)
goalSystem.registerGoal("MP takedown checkpoints", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local checkpoints = operandB.namedTasks.checkpoints.networkVars.checkpoints + operandB.namedTasks.checkpoints.networkVars.laps * operandA.instance.challenge.settings.numCheckpoints
  local function update()
    goalConditionsMet = checkpoints < operandB.namedTasks.checkpoints.networkVars.checkpoints + operandB.namedTasks.checkpoints.networkVars.laps * operandA.instance.challenge.settings.numCheckpoints
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("MP Takedown payload packed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = params.value == (operandA.networkVars.payload > 0 and operandA.networkVars.playerScore == 0)
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Within team base", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local package = operandA.agent
  local redBase = operandA.instance.challenge.spawnPositions[package.index].baseB
  local blueBase = operandA.instance.challenge.spawnPositions[package.index].baseA
  local teamName, playerBasePosition, playerToBaseDistance, vehiclePosLast, vehiclePos
  local function update()
    goalConditionsMet = false
    for i = 1, 8 do
      local taskObject = operandA.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
      if taskObject and taskObject.coreData.agent.currentVehicle and package.owner == taskObject.coreData.agent.currentVehicle then
        if PlayerGamePlay.getPlayerTeam(taskObject.coreData.agent.playerID) == 1 then
          playerBasePosition = blueBase
          teamName = "blueTeam"
        elseif PlayerGamePlay.getPlayerTeam(taskObject.coreData.agent.playerID) == 2 then
          playerBasePosition = redBase
          teamName = "redTeam"
        else
          teamName = nil
          playerBasePosition = nil
          playerToBaseDistance = nil
        end
        if playerBasePosition then
          vehiclePosLast = getLastKnownPosition(taskObject.coreData.agent)
          vehiclePos = setLastKnownPosition(taskObject.coreData.agent, taskObject.coreData.agent.position)
          if GameVehicleResource.withinSweptRadius(vehiclePos, vehiclePosLast, playerBasePosition, playerBasePosition, params.value) then
            goalConditionsMet = true
            break
          end
        end
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, teamName)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID, teamName)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Player is package owner", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local function update()
    goalConditionsMet = params.value == (localPlayer.playerID == packageTaskObject.coreData.agent.playerID)
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Player is team package owner", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTaskObject
  if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
    packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  else
    packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  end
  local function update()
    goalConditionsMet = params.value == (localPlayer.playerID == packageTaskObject.coreData.agent.playerID)
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Team Package on floor", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTaskObject
  if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
    packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  else
    packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  end
  local function update()
    goalConditionsMet = params.value == packageTaskObject.coreData.agent.onFloor
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Package on floor", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local function update()
    goalConditionsMet = params.value == packageTaskObject.coreData.agent.onFloor
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Within radius of package", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local vehiclePosLast, vehiclePos
  local function update()
    goalConditionsMet = false
    vehiclePosLast = getLastKnownPosition(localPlayer.currentVehicle)
    vehiclePos = setLastKnownPosition(localPlayer.currentVehicle, localPlayer.currentVehicle.position)
    if GameVehicleResource.withinSweptRadius(vehiclePos, vehiclePosLast, packageTaskObject.coreData.agent.position, packageTaskObject.coreData.agent.position, params.value) then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, playerVehicle)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID, playerVehicle)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Within radius of team package", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTaskObject, agentPosLast, agentPos
  if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
    packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  else
    packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  end
  local function update()
    goalConditionsMet = false
    agentPosLast = getLastKnownPosition(localPlayer.currentVehicle)
    agentPos = setLastKnownPosition(localPlayer.currentVehicle, localPlayer.currentVehicle.position)
    if GameVehicleResource.withinSweptRadius(agentPos, agentPosLast, packageTaskObject.coreData.agent.position, packageTaskObject.coreData.agent.position, params.value) then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, playerVehicle)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID, playerVehicle)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Package owner in zap", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local function update()
    goalConditionsMet = false
    if playerManager.players[packageTaskObject.coreData.agent.playerID] and playerManager.players[packageTaskObject.coreData.agent.playerID].inZap then
      goalConditionsMet = params.value == true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Package owner changed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local ownerplayerID = packageTaskObject.coreData.agent.playerID
  local function update()
    goalConditionsMet = false
    local playerVehicle
    for key, player in next, playerManager.players, nil do
      if not player.inZap and key ~= ownerplayerID and player.currentVehicle.damage < 1 and packageTaskObject.coreData.agent.owner == player.currentVehicle then
        playerVehicle = player.currentVehicle
        goalConditionsMet = true
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, playerVehicle)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Within zap shield", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local baseTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local targetPosition = operandA.instance.challenge.spawnPositions[baseTaskObject.coreData.agent.index].target
  local shieldRadius = operandA.instance.challenge.settings.baseRadius
  local shieldLevel = -1
  local currentShieldRadius = 0
  local vehiclePosLast, vehiclePos
  local function update()
    if baseTaskObject.namedTasks.score and shieldLevel ~= baseTaskObject.namedTasks.score.networkVars.attackScore then
      shieldLevel = baseTaskObject.namedTasks.score.networkVars.attackScore
      currentShieldRadius = shieldRadius * math.sqrt((operandA.instance.challenge.settings.targetScore - shieldLevel) / operandA.instance.challenge.settings.targetScore)
    end
    vehiclePosLast = getLastKnownPosition(localPlayer)
    vehiclePos = setLastKnownPosition(localPlayer, localPlayer.position)
    goalConditionsMet = params.value == GameVehicleResource.withinSweptRadius(vehiclePos, vehiclePosLast, targetPosition, targetPosition, currentShieldRadius)
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Within danger zone", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local baseTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local targetPosition = operandA.instance.challenge.spawnPositions[baseTaskObject.coreData.agent.index].target
  local targetRadius = operandA.instance.challenge.spawnPositions[baseTaskObject.coreData.agent.index].targetRadius
  local vehiclePosLast, vehiclePos
  local function update()
    vehiclePosLast = getLastKnownPosition(operandA.agent.currentVehicle)
    vehiclePos = setLastKnownPosition(operandA.agent.currentVehicle, operandA.agent.currentVehicle.position)
    goalConditionsMet = params.value == GameVehicleResource.withinSweptRadius(vehiclePos, vehiclePosLast, targetPosition, targetPosition, targetRadius)
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Player hit by opponent", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local playerVehicle = localPlayer.currentVehicle
  local hitPlayerID = 0
  local function collisionCallback(collisionData)
    if collisionData.CollidedGameVehicle then
      for i = 1, 8 do
        local taskObject = operandA.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
        if taskObject and PlayerGamePlay.getPlayerTeam(taskObject.coreData.agent.playerID) ~= operandA.instance.networkVars.roundOn then
          for key, player in next, playerManager.players, nil do
            if key == taskObject.coreData.agent.playerID and player.currentVehicle and player.currentVehicle.gameVehicle == collisionData.CollidedGameVehicle then
              goalConditionsMet = true
              hitPlayerID = i
              break
            end
          end
        end
      end
    end
  end
  local callbackSettings = {callbackFunction = collisionCallback, typeOfHit = "Vehicle"}
  playerVehicle:addCollisionCallback(callbackSettings)
  local function damageFromRemoteSNVCheck(remoteSNVID)
    if not goalConditionsMet then
      local collidingVehicle = vehicleManager.vehiclesBySNVID[remoteSNVID]
      for i = 1, 8 do
        local taskObject = operandA.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
        if taskObject and PlayerGamePlay.getPlayerTeam(taskObject.coreData.agent.playerID) ~= operandA.instance.networkVars.roundOn then
          for key, player in next, playerManager.players, nil do
            if key == taskObject.coreData.agent.playerID and player.currentVehicle and player.currentVehicle == collidingVehicle then
              goalConditionsMet = true
              hitPlayerID = i
              break
            end
          end
        end
      end
    end
  end
  vehicleManager.registerDamageDetectionCallback(playerVehicle.SNVID, damageFromRemoteSNVCheck)
  local function update()
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, hitPlayerID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID, hitPlayerID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    if vehicleManager.vehiclesBySNVID[playerVehicle.SNVID] then
      playerVehicle:removeCollisionCallback(callbackSettings)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Team Reached Score Limit", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local baseTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local targetScore = operandA.instance.challenge.settings.targetScore
  local function update()
    goalConditionsMet = false
    if baseTaskObject.namedTasks.score.networkVars.defenceScore >= targetScore or baseTaskObject.namedTasks.score.networkVars.attackScore >= targetScore then
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
  return update
end)
goalSystem.registerGoal("Flag captures", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if operandA.networkVars.blueTeam == params.value or operandA.networkVars.redTeam == params.value then
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
goalSystem.registerGoal("Within blaze", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local blazingVehicle = operandB
  local playerTaskObject = taskSystem.taskObjects[operandA.taskObjectID]
  local agent = params.agent or localPlayer
  return function()
    goalConditionsMet = false
    for i, player in next, playerManager.players, nil do
      if not player.inZap then
        assert(player.currentVehicle)
        local score = GameVehicleResource.interceptingTrailCount(player.currentVehicle.gameVehicle)
        if score and score > 0 and player.isLocal and player == agent then
          points = score
          goalConditionsMet = true
        end
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, points)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID, points)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("MP Zap Blocked", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = params.value == localPlayer:getAbilityAvailable("zap")
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Package activity changed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local packageActivity = packageTaskObject.coreData.agent.active
  local function update()
    if packageActivity ~= packageTaskObject.coreData.agent.active then
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
  return update
end)
goalSystem.registerGoal("Team Package active", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTaskObject = false
  if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
    packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  else
    packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  end
  local function update()
    goalConditionsMet = false
    if packageTaskObject then
      if packageTaskObject.coreData and packageTaskObject.coreData.agent and packageTaskObject.coreData.agent.active == params.value then
        goalConditionsMet = true
      end
    elseif PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
      packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    else
      packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Package active", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local function update()
    goalConditionsMet = false
    if packageTaskObject then
      if packageTaskObject.coreData and packageTaskObject.coreData.agent and packageTaskObject.coreData.agent.active == params.value then
        goalConditionsMet = true
      end
    else
      packageTaskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("OwnerID equal", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = false
    if operandA.networkVars.ownerID == params.value then
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
  return update
end)
goalSystem.registerGoal("Getaway owner final score", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local taskObject = taskSystem.taskObjects[operandA.taskObjectID]
  local getawayOwnerTaskObject = false
  local function update()
    if getawayOwnerTaskObject then
      if getawayOwnerTaskObject.namedTasks and getawayOwnerTaskObject.namedTasks.score then
        goalConditionsMet = params.value == (getawayOwnerTaskObject.namedTasks.score.networkVars.playerDropoffs == params.points)
      end
    elseif taskObject.namedTasks and taskObject.namedTasks.owner and taskObject.namedTasks.owner.networkVars.ownerID and playerManager.players[taskObject.namedTasks.owner.networkVars.ownerID] then
      getawayOwnerTaskObject = playerManager.players[taskObject.namedTasks.owner.networkVars.ownerID]:getTaskObject()
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Player left zap", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local inZap = operandA.agent.inZap
  local function update()
    if inZap then
      goalConditionsMet = not operandA.agent.inZap
    else
      inZap = operandA.agent.inZap
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
  return update
end)
goalSystem.registerGoal("Player is owner", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local taskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local function update()
    goalConditionsMet = params.value == (taskObject.namedTasks.owner and localPlayer.playerID == taskObject.namedTasks.owner.networkVars.ownerID)
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Distance travelled", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local currentTime = g_NetworkTime
  local distance = 0
  local function update()
    if currentTime < g_NetworkTime then
      distance = distance + (g_NetworkTime - currentTime) * localPlayer.currentVehicle.speed
    end
    currentTime = g_NetworkTime
    goalConditionsMet = distance > params.value
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("MP Hit prop", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local numProps = propSystem.getNumberSmashed()
  return function()
    goalConditionsMet = propSystem.getNumberSmashed() - numProps >= params.value
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("MP Local player zap enabled", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    if not localPlayer.zapBlockedFromPackageInteractions then
      goalConditionsMet = params.value == localPlayer:getAbilityAvailable("zap")
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
goalSystem.registerGoal("Player objective vehicle created", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local playerObjectiveVehicle = false
  local objectiveCreated = false
  local function update()
    playerObjectiveVehicle = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[localPlayer.playerID + 1]]
    objectiveCreated = false
    if playerObjectiveVehicle then
      objectiveCreated = true
    end
    goalConditionsMet = params.value == objectiveCreated
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("In player objective vehicle", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local playerObjectiveVehicle = false
  local inVehicle = false
  local function update()
    inVehicle = false
    playerObjectiveVehicle = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[localPlayer.playerID + 1]]
    if playerObjectiveVehicle and localPlayer.currentVehicle and playerObjectiveVehicle.coreData.agent == localPlayer.currentVehicle then
      inVehicle = true
    end
    goalConditionsMet = params.value == inVehicle
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, localPlayer.currentVehicle)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Valid turn taker", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = false
    if params.value then
      if playerManager.players[phaseManager.networkVars.nextTurnTaker] then
        goalConditionsMet = true
      end
    elseif not playerManager.players[phaseManager.networkVars.nextTurnTaker] then
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
  return update
end)
goalSystem.registerGoal("Target same gate", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local checkpointsEqual = false
  local package = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local player = operandA.agent
  local function update()
    goalConditionsMet = false
    checkpointsEqual = false
    if package then
      if package.namedTasks.gateTracking and player.getTaskObject() and player.getTaskObject().namedTasks.checkpoints then
        if package.namedTasks.gateTracking.networkVars.leadCheckPoint == player.getTaskObject().namedTasks.checkpoints.networkVars.nextCheckpoint then
          checkpointsEqual = true
        elseif player.getTaskObject().namedTasks.checkpoints.networkVars.nextCheckpoint - package.namedTasks.gateTracking.networkVars.leadCheckPoint == 1 then
          checkpointsEqual = true
        end
        goalConditionsMet = params.value == checkpointsEqual
      end
    else
      package = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Global on target list", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local onlist = false
  local package = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local globalGate = package.namedTasks.gateTracking.networkVars.leadCheckPoint
  local player = operandA.agent
  local targetList = player.getTaskObject().namedTasks.checkpoints.dynamicTargets
  local function update()
    goalConditionsMet = false
    onlist = false
    targetList = player.getTaskObject().namedTasks.checkpoints.dynamicTargets
    globalGate = package.namedTasks.gateTracking.networkVars.leadCheckPoint
    if targetList then
      for i, checkpoint in ipairs(targetList) do
        if checkpoint.checkpointNum == globalGate then
          onlist = true
          break
        end
      end
    end
    goalConditionsMet = params.value == onlist
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Gate Limit Reached", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(operandA.instance.instanceID, 1)
  local numCheckPoints = #allCheckpoints
  local function update()
    goalConditionsMet = params.value == (operandA.networkVars.totalCheckPoints > numCheckPoints)
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Number of Gates Reached", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = params.value == (operandA.networkVars.checkpointsPassed >= params.gateLimit)
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Instance start time valid", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    if operandA.instance.networkVars.startTime == -1 then
      goalConditionsMet = false
    else
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
goalSystem.registerGoal("MP Player 2 Active", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    goalConditionsMet = params.value == (localPlayerManager.numberOfPlayers > 1)
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("MP Player in task vehicle", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local inVehicle = false
  return function()
    goalConditionsMet = false
    inVehicle = false
    if localPlayerManager.players[params.localID] and operandA.agent.controlled and localPlayerManager.players[params.localID].currentVehicle == operandA.agent then
      inVehicle = true
    end
    goalConditionsMet = inVehicle == params.value
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("MP Player zap enabled", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if localPlayerManager.players[params.localID] and not localPlayerManager.players[params.localID].zapBlockedFromPackageInteractions then
      goalConditionsMet = localPlayerManager.players[params.localID]:getAbilityAvailable("zap") == params.value
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
goalSystem.registerGoal("Player in objective vehicle", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local objectiveTO = false
  local playerTO = taskSystem.taskObjects[operandA.taskObjectID]
  local playerTeam = PlayerGamePlay.getPlayerTeam(playerTO.coreData.agent.playerID)
  return function()
    goalConditionsMet = false
    objectiveTO = false
    if not params.team or params.team and playerTeam == 1 then
      objectiveTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    elseif params.team and playerTeam == 2 then
      objectiveTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
    end
    if objectiveTO and objectiveTO.coreData.agent then
      local playerVehicle = playerTO.coreData.agent.currentVehicle
      goalConditionsMet = params.value == (objectiveTO.coreData.agent == playerVehicle)
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
goalSystem.registerGoal("Player in package vehicle", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local objectiveTO = false
  local playerTO = taskSystem.taskObjects[operandA.taskObjectID]
  local playerTeam = PlayerGamePlay.getPlayerTeam(playerTO.coreData.agent.playerID)
  return function()
    goalConditionsMet = false
    objectiveTO = false
    if not params.team or params.team and playerTeam == 1 then
      objectiveTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    elseif params.team and playerTeam == 2 then
      objectiveTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
    end
    if objectiveTO and objectiveTO.coreData.agent.owner then
      local playerVehicle = playerTO.coreData.agent.currentVehicle
      goalConditionsMet = params.value == (objectiveTO.coreData.agent.owner == playerVehicle)
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
goalSystem.registerGoal("Collided with objective agent", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local validCollision = false
  local objectiveAgent = false
  local playerVehicle = false
  local playerTO = taskSystem.taskObjects[operandA.taskObjectID]
  local playerTeam = PlayerGamePlay.getPlayerTeam(playerTO.coreData.agent.playerID)
  local objTO = false
  local function collisionCallback(collisionData)
    if collisionData.CollidedGameVehicle and not validCollision then
      local collidingVehicle = vehicleManager.vehiclesByGameVehicle[collisionData.CollidedGameVehicle]
      if collidingVehicle == objectiveAgent then
        validCollision = true
      end
    end
  end
  local function damageFromRemoteSNVCheck(remoteSNVID)
    if not validCollision then
      local collidingVehicle = vehicleManager.vehiclesBySNVID[remoteSNVID]
      if collidingVehicle == objectiveAgent then
        validCollision = true
      end
    end
  end
  local callbackSettings = {callbackFunction = collisionCallback, typeOfHit = "Vehicle"}
  local function update()
    if not objectiveAgent then
      objTO = false
      if not params.team or params.team and playerTeam == 1 then
        objTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
      elseif params.team and playerTeam == 2 then
        objTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
      end
      if objTO and objTO.coreData.agent.owner then
        objectiveAgent = objTO.coreData.agent.owner
        local playerTO = taskSystem.taskObjects[operandA.taskObjectID]
        playerVehicle = playerTO.coreData.agent.currentVehicle
        playerVehicle:addCollisionCallback(callbackSettings)
        vehicleManager.registerDamageDetectionCallback(playerVehicle.SNVID, damageFromRemoteSNVCheck)
      end
    elseif taskSystem.validTaskObject(objTO) and objTO.coreData.agent.owner ~= objectiveAgent then
      objectiveAgent = objTO.coreData.agent.owner
    elseif validCollision and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
  local function cleanup()
    objectiveAgent = false
    validCollision = false
    if playerVehicle and vehicleManager.vehiclesBySNVID[playerVehicle.SNVID] then
      playerVehicle:removeCollisionCallback(callbackSettings)
      vehicleManager.clearDamageDetectionCallback(playerVehicle.SNVID)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Player in zap by task object", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    local playerTO = taskSystem.taskObjects[operandA.taskObjectID]
    local player = playerTO.coreData.agent
    goalConditionsMet = params.value == player.inZap
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Ram enabled", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local zapBlocked = false
  return function()
    if onlineProgressionSystem.onlineAbilityData[2].unlocked then
      if localPlayer.blockedAbilities.ram then
        zapBlocked = false
      else
        zapBlocked = true
      end
      goalConditionsMet = zapBlocked == params.value
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
goalSystem.registerGoal("Tutorial confirm", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local controlHandle = "confirm" .. tostring(UID)
  local function callback()
    if not gameStatus.onlinePaused then
      goalConditionsMet = true
    end
  end
  local buttonChecks = {
    Menu_Select = {
      JustPressed = {
        [1] = callback
      }
    }
  }
  controlHandler:registerState(params.localID, controlHandle, buttonChecks)
  controlHandler:setState(controlHandle)
  local function update()
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    controlHandler:resetState(controlHandle)
    controlHandler:removeState(controlHandle, localPlayer.localID)
  end
  return update, cleanup
end)
goalSystem.registerGoal("Pass ID", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = true
  return function()
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.value)
      goalConditionsMet = false
    end
  end
end)
goalSystem.registerGoal("Task done", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = operandA.networkVars.done
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Are zap weapons available", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = zapWeaponSupport.areZapWeaponsAvailable() == params.value
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("Zap Impulsed Target Vehicle", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = operandA.networkVars.impulsedVehicle == params.value
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("Vehicle been zap impulsed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    if operandA.agent.zapImpulsed then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      operandA.agent.zapImpulsed = false
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("Has zap lock on", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local lockOn = false
  local tValue = 0
  local hasLockOn = false
  return function()
    lockOn, tValue = zap.zapAttack.getLockOnTValue()
    if lockOn and tValue == 1 then
      hasLockOn = true
    else
      hasLockOn = false
    end
    goalConditionsMet = params.value == hasLockOn
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("Smash marked vehicle within time", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local timer = 0
  local startTime = g_NetworkTime
  local callBackSet = false
  local hitWrongPosition = false
  local markedVehicleTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local function collisionCallback(collisionData)
    if collisionData.CollidedGameVehicle and markedVehicleTO.coreData.agent.gameVehicle == collisionData.CollidedGameVehicle then
      if params.hitPosition then
        if collisionData.WhereIHit == params.hitPosition then
          goalConditionsMet = true
          hitWrongPosition = false
        else
          hitWrongPosition = true
        end
      else
        goalConditionsMet = true
      end
    end
  end
  local callbackSettings = {callbackFunction = collisionCallback, typeOfHit = "Vehicle"}
  local function update()
    if localPlayer.currentVehicle then
      if not callBackSet then
        localPlayer.currentVehicle:addCollisionCallback(callbackSettings)
        callBackSet = true
      end
      timer = g_NetworkTime - startTime
      if params.correctVehicle and localPlayer.currentVehicle.gameVehicle.model_id ~= params.correctVehicle then
        goalConditionsMet = false
        params.failReason = 4
      end
      if (timer > params.value or goalConditionsMet) and not goalReportedSuccessful then
        localPlayer.currentVehicle:removeCollisionCallback(callbackSettings)
        goalSystem.callbackHandler(UID, {
          wrongVehicle = localPlayer.currentVehicle.gameVehicle.model_id ~= params.correctVehicle,
          done = params.done,
          removeMarkers = params.removeMarkers,
          clear = params.clear,
          failed = not goalConditionsMet,
          promptID = params.promptID,
          failReason = params.failReason,
          extraData = params.extraData,
          welldone = params.welldone,
          tick = params.tick,
          hitWrongPosition = hitWrongPosition
        })
        goalReportedSuccessful = true
      end
    end
  end
  local function cleanup()
    if localPlayer.currentVehicle then
      localPlayer.currentVehicle:removeCollisionCallback(callbackSettings)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("General mechanics tasks complete", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    if params.all then
      if operandA.networkVars.taskOneComp and operandA.networkVars.taskTwoComp and operandA.networkVars.taskThreeComp then
        goalConditionsMet = true
      end
    elseif params.allFalse then
      if not operandA.networkVars.taskOneComp and not operandA.networkVars.taskTwoComp and not operandA.networkVars.taskThreeComp then
        goalConditionsMet = true
      end
    elseif params.value == 1 then
      goalConditionsMet = params.complete == operandA.networkVars.taskOneComp
    elseif params.value == 2 then
      goalConditionsMet = params.complete == operandA.networkVars.taskTwoComp
    elseif params.value == 3 then
      goalConditionsMet = params.complete == operandA.networkVars.taskThreeComp
    elseif params.value == 4 then
      goalConditionsMet = params.complete == operandA.networkVars.wellDone
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("Player can zap", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    if scoreSystem.enoughAbilityToUseShift(0) then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("General mechanics timer ran out", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  localPlayer.timeupCalled = nil
  return function()
    if not operandA.networkVars.reseting and operandA.networkVars.raceStartTime ~= 0 and g_NetworkTime - operandA.networkVars.raceStartTime > params.time then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      localPlayer.timeupCalled = true
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      localPlayer.timeupCalled = nil
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Is zap attack active", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local isActive = false
  return function()
    goalConditionsMet = params.value == zap.zapAttack.isZapAttackActive()
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("Correct slot active", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local currentSlot = ActiveVehicles.getActiveVehicleSlot()
  return function()
    if currentSlot ~= ActiveVehicles.getActiveVehicleSlot() then
      if ActiveVehicles.getActiveVehicleSlot() == 1 then
        goalConditionsMet = true
      end
      if not goalReportedSuccessful then
        goalSystem.callbackHandler(UID, {
          extraData = params.extraData,
          slotCorrect = goalConditionsMet
        })
        goalReportedSuccessful = true
      end
    end
  end
end)
goalSystem.registerGoal("Lead playerID changed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local taskObject = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local currentLeadPlayerID = -1
  return function()
    if currentLeadPlayerID == -1 then
      if taskObject.namedTasks.gateTracking and taskObject.namedTasks.gateTracking.networkVars then
        currentLeadPlayerID = taskObject.namedTasks.gateTracking.networkVars.leadPlayerID
      end
    else
      goalConditionsMet = params.value == (currentLeadPlayerID ~= taskObject.namedTasks.gateTracking.networkVars.leadPlayerID)
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
goalSystem.registerGoal("SS Score Gap Changed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local p1Task = operandA.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[1]]
  local p2Task = operandA.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[2]]
  local p1Score = 0
  local p2Score = 0
  local lastScoreGap
  local newScoreGap = 0
  return function()
    p1Score = p1Task.namedTasks.checkpoints.networkVars.checkpointsPassed
    p2Score = p2Task.namedTasks.checkpoints.networkVars.checkpointsPassed
    if not lastScoreGap then
      lastScoreGap = p1Score - p2Score
    end
    newScoreGap = p1Score - p2Score
    if math.abs(newScoreGap - lastScoreGap) >= params.minimumChange then
      goalConditionsMet = true
      lastScoreGap = newScoreGap
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
goalSystem.registerGoal("Player position changed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local currentPlayerPosition = -1
  return function()
    if currentPlayerPosition == -1 then
      currentPlayerPosition = onlineRaceManager.getPlayerRank(localPlayer.playerID)
    else
      goalConditionsMet = params.value == (currentPlayerPosition ~= onlineRaceManager.getPlayerRank(localPlayer.playerID))
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
goalSystem.registerGoal("Zap State changed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = params.value == operandA.agent.inZap
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("General mechanics timeup called", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local value = false
  return function()
    if localPlayer.timeupCalled == nil then
      value = false
    else
      value = localPlayer.timeupCalled
    end
    goalConditionsMet = params.value == value
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("General mechanics is player reseting", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local value = false
  return function()
    if localPlayer.resetingToStart == nil then
      value = false
    else
      value = localPlayer.resetingToStart
    end
    goalConditionsMet = params.value == value
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Outside radius of start location", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local instance = operandA.instance
  local startLocation
  return function()
    startLocation = instance.challenge.spawnPositions[instance.networkVars.routeIndex].target
    if operandA.agent.position and startLocation then
      goalConditionsMet = not GameVehicleResource.withinRadius(operandA.agent.position, startLocation, params.radius)
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
goalSystem.registerGoal("Race end screen set", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local endScreenSet = false
  return function()
    goalConditionsMet = false
    endScreenSet = false
    if operandA.instance.challenge.raceEndScreenSet then
      endScreenSet = true
    end
    goalConditionsMet = endScreenSet == params.value
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Race finished", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local objTO = false
  local taskObject = taskSystem.taskObjects[operandA.taskObjectID]
  return function()
    goalConditionsMet = false
    if params.playerTO then
      objTO = operandA.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[taskObject.coreData.agent.playerID + 1]]
    else
      objTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[taskObject.coreData.agent.playerID + 1]]
    end
    if objTO and objTO.namedTasks.checkpoints and objTO.namedTasks.checkpoints.networkVars.laps > objTO.namedTasks.checkpoints.coreData.totalLaps then
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
goalSystem.registerGoal("End race timer set", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = params.value == (onlineRaceManager.networkVars.raceEndTimer > 0)
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("End race time above", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if g_NetworkTime - onlineRaceManager.networkVars.raceEndTimer > params.value then
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
goalSystem.registerGoal("All players finished race", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local objTO = false
  return function()
    goalConditionsMet = true
    for i = 1, 8 do
      if params.playerTO then
        objTO = operandA.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
      else
        objTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
      end
      if objTO and objTO.namedTasks.checkpoints and objTO.namedTasks.checkpoints.networkVars.laps <= objTO.namedTasks.checkpoints.coreData.totalLaps then
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
goalSystem.registerGoal("MP Crossed Checkpoint", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local player = false
  local function checkpointCrossedCallBack(playerID)
    NetworkLog.Write(">[LUA] ONLINE RACE MANAGER - Goal - checkpointCrossedCallBack " .. tostring(playerID))
    goalConditionsMet = true
    goalSystem.update()
  end
  local function getPlayer()
    if operandA.agent.isPlayer then
      player = operandA.agent
      onlineRaceManager.addCheckpointCallback(checkpointCrossedCallBack, player.playerID)
    else
      for playerID, loopPlayer in next, playerManager.players, nil do
        if loopPlayer.currentVehicle == operandA.taskObject.coreData.agent then
          player = loopPlayer
          onlineRaceManager.addCheckpointCallback(checkpointCrossedCallBack, player.playerID)
          break
        end
      end
    end
  end
  getPlayer()
  local function update()
    if not player then
      getPlayer()
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
  local function cleanup()
    if player then
      onlineRaceManager.removeCheckpointCallback(checkpointCrossedCallBack, player.playerID)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Is Zap Spawn Button Down", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = zap.zapSpawn.spawnButtonDown == params.value
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("Released spawn at speed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local zapSpeed = 0
  local prevTime = 0
  local lastPosition = false
  local timeLaps = false
  local distance = false
  local lastSpeed = false
  local delayStart = false
  local delayValue = 2
  return function()
    goalConditionsMet = false
    zapSpeed = 0
    timeLaps = g_NetworkTime - prevTime
    if localPlayer and localPlayer.inZap and lastPosition and timeLaps > 1E-05 then
      distance = workingVector:sub(lastPosition, spoolsystem.position):length()
      zapSpeed = distance * (1 / timeLaps) * 2.236936
      lastSpeed = zapSpeed
    elseif lastSpeed then
      goalConditionsMet = lastSpeed >= params.minSpeed
    end
    if localPlayer and spoolsystem and spoolsystem.position then
      lastPosition = spoolsystem.position
    end
    prevTime = g_NetworkTime
    if not zapWeaponSupport.areZapWeaponsAvailable() and not delayStart then
      delayStart = g_NetworkTime
    end
    if delayStart and g_NetworkTime - delayStart >= delayValue or not zapWeaponSupport.areZapWeaponsAvailable() and goalConditionsMet then
      goalSystem.callbackHandler(UID, {
        failReason = params.failReason,
        failed = not goalConditionsMet,
        done = goalConditionsMet,
        clear = goalConditionsMet,
        failReason = params.failReason,
        welldone = goalConditionsMet
      })
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("Player using boost", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    if localPlayer.currentVehicle then
      goalConditionsMet = AbilityController.isAbilityActive("nitro")
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("Package owner Damage above", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  return function()
    goalConditionsMet = false
    if packageTO.coreData.agent.owner and packageTO.coreData.agent.owner.damage >= params.value then
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
goalSystem.registerGoal("Package owner Damage below", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local packageTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  return function()
    goalConditionsMet = false
    if packageTO.coreData.agent.owner and packageTO.coreData.agent.owner.damage < params.value then
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
goalSystem.registerGoal("MP is Player 0", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = params.value == (operandA.agent.localID == 0)
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Package owner within strip of road", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local areaCentre = operandB.position
  local roadIndex, distanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(areaCentre)
  local roadLength = Atlas.RoadLength(roadIndex)
  local depth = params.value or 4
  local minimum = distanceAlong - depth
  if minimum < 0 then
    minimum = 0
  end
  local maximum = distanceAlong + depth
  if roadLength < maximum then
    maximum = roadLength
  end
  local vehicleRoadIndex, vehicleDistanceAlong, agent
  return function()
    agent = operandA.agent.owner
    goalConditionsMet = false
    if agent then
      vehicleRoadIndex = agent:get_closestRoadIndex()
      if vehicleRoadIndex == roadIndex then
        vehicleDistanceAlong = agent:get_closestDistanceAlongRoad()
        if vehicleDistanceAlong > minimum and vehicleDistanceAlong < maximum then
          goalConditionsMet = true
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
end)
goalSystem.registerGoal("Torch owner changed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local firstOwner = operandA.agent.owner or false
  return function()
    if firstOwner and firstOwner ~= operandA.agent.owner or not firstOwner and operandA.agent.owner then
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
goalSystem.registerGoal("Single Fire Player in package vehicle", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local objectiveTO = false
  local playerTO = taskSystem.taskObjects[operandA.taskObjectID]
  local playerTeam = PlayerGamePlay.getPlayerTeam(playerTO.coreData.agent.playerID)
  return function()
    goalConditionsMet = false
    objectiveTO = false
    if not params.team or params.team and playerTeam == 1 then
      objectiveTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    elseif params.team and playerTeam == 2 then
      objectiveTO = operandA.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
    end
    if objectiveTO and objectiveTO.coreData.agent.owner then
      local playerVehicle = playerTO.coreData.agent.currentVehicle
      goalConditionsMet = params.value == (objectiveTO.coreData.agent.owner == playerVehicle)
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
end)
goalSystem.registerGoal("MP Checkpoint Tracker", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local taskObject = taskSystem.taskObjects[operandA.taskObjectID]
  local function checkpointCrossedCallBack()
    NetworkLog.Write(">[LUA] checkpointTracker - Goal - checkpointCrossedCallBack " .. tostring(playerID))
    goalConditionsMet = true
    goalSystem.update()
  end
  checkpointTracker.addCheckpoint(taskObject, operandB, checkpointCrossedCallBack)
  local function update()
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    end
  end
  local function cleanup()
    checkpointTracker.removeCheckpoint(taskObject, checkpointCrossedCallBack)
  end
  return update, cleanup
end)
goalSystem.registerGoal("General mechanics fade complete", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = params.value == operandA.networkVars.fadeComplete
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
