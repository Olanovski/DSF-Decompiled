local workingVector = vec.vector()
goalSystem.registerGoal("Time controlling taskobject agent", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local startTime = 0
  local timeHeld = 0
  local isTObControlled = false
  local prevIsTOControlled = false
  local function update()
    local goalConditionsMet = false
    local target = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    if target and target.coreData.agent.owner then
      isTObControlled = params.value == target.coreData.agent.owner.controlled
    else
      isTObControlled = false
    end
    if not prevIsTOControlled and isTObControlled then
      startTime = g_NetworkTime
      timeHeld = 0
    end
    if prevIsTOControlled and not isTObControlled or prevIsTOControlled and not onlineProgressionSystem.onlineMissionActive then
      timeHeld = g_NetworkTime - startTime
      timeHeld = math.ceil(timeHeld)
      goalConditionsMet = true
    end
    prevIsTOControlled = isTObControlled
    if goalConditionsMet and not goalReportedSuccessful then
      local completionData = {xpModifier = timeHeld}
      goalSystem.callbackHandler(UID, completionData)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
local takenTOAgentCooldown = 0
goalSystem.registerGoal("Local player taken taskobject agent", function(operandA, operandB, UID, params)
  local target = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local goalReportedSuccessful = false
  local taskObjectControlled = false
  local previousObjectControlled = false
  if takenTOAgentCooldown > g_NetworkTime then
    takenTOAgentCooldown = 0
  end
  previousObjectControlled = target and target.coreData.agent.owner and params.value == target.coreData.agent.owner.controlled
  local function update()
    local goalConditionsMet = false
    target = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    if target and target.coreData.agent.owner then
      taskObjectControlled = params.value == target.coreData.agent.owner.controlled
      if g_NetworkTime - takenTOAgentCooldown > params.cooldown then
        goalConditionsMet = taskObjectControlled and not previousObjectControlled
      end
      previousObjectControlled = taskObjectControlled
    else
      taskObjectControlled = false
      previousObjectControlled = false
    end
    if goalConditionsMet and not goalReportedSuccessful then
      local completionData = {xpModifier = nil}
      takenTOAgentCooldown = g_NetworkTime
      goalSystem.callbackHandler(UID, completionData)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Captured the flag", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local instance = operandA.coreData.instance
  local lastFlagCaps = instance and instance.playerScores[localPlayer.playerID + 1] or 0
  local function update()
    local goalConditionsMet = false
    if instance then
      if lastFlagCaps ~= instance.playerScores[localPlayer.playerID + 1] then
        goalConditionsMet = true
      end
      lastFlagCaps = instance.playerScores[localPlayer.playerID + 1]
    else
      instance = operandA.coreData.instance
    end
    if goalConditionsMet and not goalReportedSuccessful then
      local completionData = {xpModifier = nil}
      goalSystem.callbackHandler(UID, completionData)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
local withinFlagRadiusCooldown = 0
goalSystem.registerGoal("Within radius of flag carrier", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local timeFlagHeld = 0
  local timeWithinRadius = 0
  local timeTracking = g_NetworkTime
  local instance = operandA.coreData.instance
  local flagTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local lastNumOfBlueCaps = flagTO.namedTasks.score and flagTO.namedTasks.score.networkVars.blueTeam or 0
  local lastNumOfRedCaps = flagTO.namedTasks.score and flagTO.namedTasks.score.networkVars.redTeam or 0
  local lastPlayerFlagCaps = instance and instance.playerScores[localPlayer.playerID + 1] or 0
  local function update()
    local goalConditionsMet = false
    local percentage = 0
    local flag = flagTO and flagTO.coreData.agent
    if flag then
      local flagOwnerTeam = 0
      local playerTeam = PlayerGamePlay.getPlayerTeam(operandA.coreData.agent.playerID)
      for i = 1, 8 do
        local taskObject = operandA.coreData.instance and operandA.coreData.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
        if taskObject and taskObject.coreData.agent.currentVehicle and taskObject.coreData.agent.currentVehicle == flag.owner then
          flagOwnerTeam = PlayerGamePlay.getPlayerTeam(taskObject.coreData.agent.playerID)
          break
        end
      end
      if flagOwnerTeam ~= 0 then
        timeFlagHeld = timeFlagHeld + (g_NetworkTime - timeTracking)
        if localPlayer.currentVehicle then
          local distance = workingVector:sub(flag.position, localPlayer.currentVehicle.position):length()
          if distance < params.radius then
            timeWithinRadius = timeWithinRadius + (g_NetworkTime - timeTracking)
          end
        end
      end
      local currentRedTeamScore = flagTO.namedTasks.score and flagTO.namedTasks.score.networkVars.redTeam or 0
      local currentBlueTeamScore = flagTO.namedTasks.score and flagTO.namedTasks.score.networkVars.blueTeam or 0
      if (lastNumOfBlueCaps ~= currentBlueTeamScore or currentRedTeamScore ~= lastNumOfRedCaps) and g_NetworkTime - withinFlagRadiusCooldown > 5 then
        percentage = 0
        local teamCappedFlag = 0
        local playerFlagCaps = instance.playerScores[localPlayer.playerID + 1]
        if lastNumOfBlueCaps ~= currentBlueTeamScore then
          teamCappedFlag = 1
        elseif currentRedTeamScore ~= lastNumOfRedCaps then
          teamCappedFlag = 2
        end
        if lastPlayerFlagCaps == playerFlagCaps then
          percentage = timeWithinRadius / timeFlagHeld
        end
        goalConditionsMet = true
      end
    end
    timeTracking = g_NetworkTime
    if goalConditionsMet and not goalReportedSuccessful then
      local completionData = {xpModifier = percentage}
      withinFlagRadiusCooldown = g_NetworkTime
      goalSystem.callbackHandler(UID, completionData)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
local destroyCarrierCooldown = 0
goalSystem.registerGoal("Destroyed enemy flag carrier", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local collidedWithFlagCarrier = false
  local flagCarrierDead = false
  local timerStart = g_NetworkTime
  local flagTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local previousOwner = false
  local ownerTeam = false
  local function flagCarrierCollisionCheck(collisionData)
    if localPlayer.currentVehicle and collisionData.CollidedGameVehicle == localPlayer.currentVehicle.gameVehicle then
      collidedWithFlagCarrier = true
    end
    if vehicleManager.vehiclesBySNVID[previousOwner].gameVehicle.damage >= 1 then
      flagCarrierDead = true
    end
  end
  local callbackSettings = {callbackFunction = flagCarrierCollisionCheck, typeOfHit = "Vehicle"}
  local function update()
    local goalConditionsMet = false
    local playerTeam = PlayerGamePlay.getPlayerTeam(operandA.coreData.agent.playerID)
    if not flagTO then
      flagTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    end
    if playerTeam and flagTO then
      if previousOwner then
        if flagTO.coreData.agent.owner and vehicleManager.vehiclesBySNVID[previousOwner] then
          if playerManager.players[flagTO.coreData.agent.playerID] then
            local ownerTeamTO = playerManager.players[flagTO.coreData.agent.playerID]:getTaskObject()
            if ownerTeamTO then
              local ownerTeam = PlayerGamePlay.getPlayerTeam(ownerTeamTO.coreData.agent.playerID)
              if ownerTeam == playerTeam then
                vehicleManager.vehiclesBySNVID[previousOwner]:removeCollisionCallback(callbackSettings)
                previousOwner = false
              end
            end
          end
        else
          if vehicleManager.vehiclesBySNVID[previousOwner] then
            vehicleManager.vehiclesBySNVID[previousOwner]:removeCollisionCallback(callbackSettings)
          end
          previousOwner = false
        end
      end
      if not previousOwner and flagTO.coreData.agent.owner and 1 > flagTO.coreData.agent.owner.damage and playerManager.players[flagTO.coreData.agent.playerID] then
        local ownerTO = playerManager.players[flagTO.coreData.agent.playerID]:getTaskObject()
        if ownerTO and ownerTO.coreData.agent then
          ownerTeam = PlayerGamePlay.getPlayerTeam(ownerTO.coreData.agent.playerID)
          if ownerTeam ~= playerTeam then
            previousOwner = flagTO.coreData.agent.owner.SNVID
            if vehicleManager.vehiclesBySNVID[previousOwner] then
              vehicleManager.vehiclesBySNVID[previousOwner]:addCollisionCallback(callbackSettings)
            end
          end
        end
      end
    end
    if g_NetworkTime - timerStart > 0.25 then
      timerStart = g_NetworkTime
      collidedWithFlagCarrier = false
    end
    if flagCarrierDead and collidedWithFlagCarrier and g_NetworkTime - destroyCarrierCooldown > params.cooldown then
      goalConditionsMet = true
      flagCarrierDead = false
      collidedWithFlagCarrier = false
    else
      flagCarrierDead = false
      collidedWithFlagCarrier = false
    end
    if goalConditionsMet and not goalReportedSuccessful then
      local completionData = {xpModifier = nil}
      destroyCarrierCooldown = g_NetworkTime
      goalSystem.callbackHandler(UID, completionData)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    if previousOwner and vehicleManager.vehiclesBySNVID[previousOwner] then
      vehicleManager.vehiclesBySNVID[previousOwner]:removeCollisionCallback(callbackSettings)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Team crossed checkpoint", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local prevCheckpoint = false
  local goalConditionsMet = false
  local teamVehicleTO
  if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
    teamVehicleTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  else
    teamVehicleTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  end
  local function update()
    goalConditionsMet = false
    if teamVehicleTO then
      if teamVehicleTO.namedTasks.checkpoints then
        if prevCheckpoint then
          goalConditionsMet = params.value == (prevCheckpoint ~= teamVehicleTO.namedTasks.checkpoints.networkVars.checkpoints)
        end
        prevCheckpoint = teamVehicleTO.namedTasks.checkpoints.networkVars.checkpoints
      end
    elseif PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
      teamVehicleTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    else
      teamVehicleTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
    end
    if goalConditionsMet ~= goalReportedSuccessful then
      goalSystem.callbackHandler(UID, {xpModifier = nil})
      goalReportedSuccessful = goalConditionsMet
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Checkpoint crossed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local previousCheckpoint = false
  local function update()
    local goalConditionsMet = false
    local playerVehicle = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[localPlayer.playerID + 1]]
    local playerTO = localPlayer.getTaskObject()
    if playerVehicle and playerVehicle.namedTasks.checkpoints then
      if previousCheckpoint and not localPlayer.inZap and playerVehicle.coreData.agent == localPlayer.currentVehicle then
        goalConditionsMet = params.value == (previousCheckpoint ~= playerVehicle.namedTasks.checkpoints.networkVars.checkpoints - 1)
      end
      previousCheckpoint = playerVehicle.namedTasks.checkpoints.networkVars.checkpoints - 1
    elseif playerTO and playerTO.namedTasks.checkpoints then
      if previousCheckpoint and not localPlayer.inZap then
        if playerTO.namedTasks.checkpoints.networkVars.checkpointsPassed then
          goalConditionsMet = params.value == (previousCheckpoint ~= playerTO.namedTasks.checkpoints.networkVars.checkpointsPassed - 1)
        else
          goalConditionsMet = params.value == (previousCheckpoint ~= playerTO.namedTasks.checkpoints.networkVars.checkpoints - 1)
        end
      end
      if playerTO.namedTasks.checkpoints.networkVars.checkpointsPassed then
        previousCheckpoint = playerTO.namedTasks.checkpoints.networkVars.checkpointsPassed - 1
      else
        previousCheckpoint = playerTO.namedTasks.checkpoints.networkVars.checkpoints - 1
      end
    end
    if goalConditionsMet ~= goalReportedSuccessful then
      local reward = -1
      if params.ignoreRank then
        reward = 1
      elseif localPlayer.currentVehicle then
        local position = onlineRaceManager.getPlayerRank(localPlayer.playerID)
        if position and position <= 8 then
          reward = onlineProgressionSystem.onlineRaceRankMultiplier[position]
        end
      end
      local completionData = {xpModifier = reward}
      goalSystem.callbackHandler(UID, completionData)
      goalReportedSuccessful = goalConditionsMet
    end
  end
  return update, cleanup
end)
local damageOpponentRadiusCooldown = 0
goalSystem.registerGoal("Damaged opponent within radius of objective", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local previousVehicle
  local opponentHit = false
  local function collisionCallback(collisionData)
    for i = 1, 8 do
      local taskObject = operandA.coreData.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
      if taskObject and taskObject.coreData.agent and taskObject.coreData.agent.currentVehicle and taskObject.coreData.agent.currentVehicle ~= localPlayer.currentVehicle and collisionData.CollidedGameVehicle == taskObject.coreData.agent.currentVehicle.gameVehicle then
        opponentHit = true
        break
      end
    end
  end
  local callbackSettings = {
    callbackFunction = collisionCallback,
    minimumForce = params.minForce,
    typeOfHit = "Vehicle"
  }
  local function update()
    local goalConditionsMet = false
    if localPlayer.currentVehicle then
      local changed = false
      if previousVehicle and previousVehicle ~= localPlayer.currentVehicle.SNVID then
        if vehicleManager.vehiclesBySNVID[previousVehicle] then
          vehicleManager.vehiclesBySNVID[previousVehicle]:removeCollisionCallback(callbackSettings)
        end
        previousVehicle = nil
        changed = true
      end
      if changed or not previousVehicle then
        previousVehicle = localPlayer.currentVehicle.SNVID
        localPlayer.currentVehicle:addCollisionCallback(callbackSettings)
      end
      if opponentHit and g_NetworkTime - damageOpponentRadiusCooldown > params.cooldown then
        local objectiveTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
        local distanceToObj = 0
        local agentPosLast = getLastKnownPosition(localPlayer.currentVehicle)
        local agentPos = setLastKnownPosition(localPlayer.currentVehicle, localPlayer.currentVehicle.position)
        local targetPosLast = getLastKnownPosition(objectiveTO.coreData.agent)
        local targetPos = setLastKnownPosition(objectiveTO.coreData.agent, objectiveTO.coreData.agent.position)
        if GameVehicleResource.withinSweptRadius(agentPos, agentPosLast, targetPos, targetPosLast, params.radius) then
          goalConditionsMet = true
          damageOpponentRadiusCooldown = g_NetworkTime
        else
          opponentHit = false
        end
      end
    elseif previousVehicle and vehicleManager.vehiclesBySNVID[previousVehicle] then
      vehicleManager.vehiclesBySNVID[previousVehicle]:removeCollisionCallback(callbackSettings)
      previousVehicle = nil
      opponentHit = false
    end
    if goalConditionsMet ~= goalReportedSuccessful then
      local completionData = {xpModifier = nil}
      goalSystem.callbackHandler(UID, completionData)
      goalReportedSuccessful = goalConditionsMet
    end
  end
  local function cleanup()
    if previousVehicle and vehicleManager.vehiclesBySNVID[previousVehicle] then
      vehicleManager.vehiclesBySNVID[previousVehicle]:removeCollisionCallback(callbackSettings)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Damaged opposing team objective", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local collisionAgent = false
  local goalConditionsMet = false
  local opVehicleTO
  local collided = false
  if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
    opVehicleTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  else
    opVehicleTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  end
  if opVehicleTO and not opVehicleTO.damagedOpposingTeamObjectiveCooDown then
    opVehicleTO.damagedOpposingTeamObjectiveCooDown = 0
  end
  local function collisionCallback(collisionData)
    local collidingVehicle = vehicleManager.vehiclesByGameVehicle[collisionData.CollidedGameVehicle]
    if collidingVehicle and not operandA.coreData.agent.inZap and collidingVehicle == operandA.coreData.agent.currentVehicle and g_NetworkTime > opVehicleTO.damagedOpposingTeamObjectiveCooDown + params.cooldown then
      collided = true
      opVehicleTO.damagedOpposingTeamObjectiveCooDown = g_NetworkTime
    end
  end
  local callbackSettings = {
    callbackFunction = collisionCallback,
    minimumForce = params.minForce,
    typeOfHit = "Vehicle"
  }
  local function update()
    if opVehicleTO then
      if opVehicleTO.coreData.agent.owner then
        if not collisionAgent and opVehicleTO.coreData.agent.owner or collisionAgent ~= opVehicleTO.coreData.agent.owner.SNVID then
          if collisionAgent and vehicleManager.vehiclesBySNVID[collisionAgent] then
            vehicleManager.vehiclesBySNVID[collisionAgent]:removeCollisionCallback(callbackSettings)
          end
          collisionAgent = opVehicleTO.coreData.agent.owner.SNVID
          vehicleManager.vehiclesBySNVID[collisionAgent]:addCollisionCallback(callbackSettings)
        end
      elseif collisionAgent and vehicleManager.vehiclesBySNVID[collisionAgent] then
        vehicleManager.vehiclesBySNVID[collisionAgent]:removeCollisionCallback(callbackSettings)
        collisionAgent = false
      end
    else
      if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
        opVehicleTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
      else
        opVehicleTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
      end
      if opVehicleTO and not opVehicleTO.damagedOpposingTeamObjectiveCooDown then
        opVehicleTO.damagedOpposingTeamObjectiveCooDown = 0
      end
    end
    goalConditionsMet = collided
    collided = false
    if goalConditionsMet ~= goalReportedSuccessful then
      goalSystem.callbackHandler(UID, {})
      goalReportedSuccessful = goalConditionsMet
    end
  end
  local function cleanup()
    if collisionAgent and vehicleManager.vehiclesBySNVID[collisionAgent] then
      vehicleManager.vehiclesBySNVID[collisionAgent]:removeCollisionCallback(callbackSettings)
    end
  end
  return update, cleanup
end)
local damagedGetawayCooldown = 0
goalSystem.registerGoal("Damaged target taskObject agent", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local collisionAgent = false
  local goalConditionsMet = false
  local startTime = 0
  local collided = false
  if damagedGetawayCooldown > g_NetworkTime then
    damagedGetawayCooldown = 0
  end
  local function collisionCallback(collisionData)
    local collidingVehicle = vehicleManager.vehiclesByGameVehicle[collisionData.CollidedGameVehicle]
    if collidingVehicle and not operandA.coreData.agent.inZap and collidingVehicle == operandA.coreData.agent.currentVehicle and g_NetworkTime - damagedGetawayCooldown > params.cooldown then
      collided = true
    end
  end
  local callbackSettings = {
    callbackFunction = collisionCallback,
    minimumForce = params.minForce,
    typeOfHit = "Vehicle"
  }
  local function update()
    if not collisionAgent and operandB.coreData.agent.SNVID or collisionAgent ~= operandB.coreData.agent.SNVID then
      if collisionAgent and vehicleManager.vehiclesBySNVID[collisionAgent] then
        vehicleManager.vehiclesBySNVID[collisionAgent]:removeCollisionCallback(callbackSettings)
      end
      collisionAgent = operandB.coreData.agent.SNVID
      vehicleManager.vehiclesBySNVID[collisionAgent]:addCollisionCallback(callbackSettings)
    end
    goalConditionsMet = collided
    collided = false
    if goalConditionsMet ~= goalReportedSuccessful then
      damagedGetawayCooldown = g_NetworkTime
      goalSystem.callbackHandler(UID, {})
      goalReportedSuccessful = goalConditionsMet
    end
  end
  local function cleanup()
    if collisionAgent and vehicleManager.vehiclesBySNVID[collisionAgent] then
      vehicleManager.vehiclesBySNVID[collisionAgent]:removeCollisionCallback(callbackSettings)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("TaskObject agent is target taskObject owner", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local ownerID = operandA.coreData.agent.isPlayer and operandA.coreData.agent.playerID or operandA.coreData.agent.SNVID
  local function update()
    local goalConditionsMet = false
    if operandB and operandB.namedTasks.owner then
      goalConditionsMet = params.value == (ownerID == operandB.namedTasks.owner.networkVars.ownerID)
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
goalSystem.registerGoal("MP Takedown checkpoints DATAHACK", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local checkpoints = operandB.namedTasks.checkpoints.networkVars.checkpoints + operandB.namedTasks.checkpoints.networkVars.laps * operandA.coreData.instance.challenge.settings.numCheckpoints
  local function update()
    local goalConditionsMet = checkpoints < operandB.namedTasks.checkpoints.networkVars.checkpoints + operandB.namedTasks.checkpoints.networkVars.laps * operandA.coreData.instance.challenge.settings.numCheckpoints
    checkpoints = operandB.namedTasks.checkpoints.networkVars.checkpoints + operandB.namedTasks.checkpoints.networkVars.laps * operandA.coreData.instance.challenge.settings.numCheckpoints
    if goalConditionsMet ~= goalReportedSuccessful then
      local completionData = {
        xpModifier = params.xpModifier[checkpoints - 1]
      }
      goalSystem.callbackHandler(UID, completionData)
      goalReportedSuccessful = goalConditionsMet
    end
  end
  return update
end)
local startPaylaodTrack = false
local gameStartTime = 0
goalSystem.registerGoal("Payload increased timed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local timeTracking = g_NetworkTime
  local scoring = false
  local scoreStartTime = 0
  local prevPayload = operandA.namedTasks.score and operandA.namedTasks.score.networkVars.payload or 0
  local xpTime = 0
  local function update()
    local goalConditionsMet = false
    local currentPayload = operandA.namedTasks.score and operandA.namedTasks.score.networkVars.payload or 0
    if operandA.namedTasks.score then
      if not startPaylaodTrack then
        gameStartTime = g_NetworkTime
        startPaylaodTrack = true
      end
      if not localPlayer.inZap then
        if not scoring then
          if currentPayload ~= prevPayload then
            scoring = true
            scoreStartTime = g_NetworkTime
            timeTracking = g_NetworkTime
            xpTime = 0
          end
        else
          local comp = false
          if g_NetworkTime - timeTracking > 1.5 and currentPayload == prevPayload then
            comp = true
          end
          if not onlineProgressionSystem.onlineMissionActive then
            comp = true
          end
          if comp then
            xpTime = g_NetworkTime - scoreStartTime
            goalConditionsMet = true
          elseif currentPayload ~= prevPayload then
            timeTracking = g_NetworkTime
          end
        end
      elseif scoring then
        xpTime = g_NetworkTime - scoreStartTime
        goalConditionsMet = true
      end
    else
      startPaylaodTrack = false
      gameStartTime = 0
    end
    prevPayload = currentPayload
    if goalConditionsMet ~= goalReportedSuccessful then
      local completionData = {xpModifier = xpTime}
      goalSystem.callbackHandler(UID, completionData)
      goalReportedSuccessful = goalConditionsMet
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Reach control point", function(operandA, operandB, UID, params)
  local taskObject = localPlayer.getTaskObject()
  local previousScore = (not taskObject.namedTasks.playerScore or not taskObject.namedTasks.playerScore.networkVars.playerAttackBase) and 0
  local goalReportedSuccessful = false
  local function update()
    local goalConditionsMet = false
    if taskObject.namedTasks.playerScore and previousScore ~= taskObject.namedTasks.playerScore.networkVars.playerAttackBase then
      goalConditionsMet = true
    end
    if goalConditionsMet ~= goalReportedSuccessful then
      local completionData = {xpModifier = nil}
      goalSystem.callbackHandler(UID, completionData)
      goalReportedSuccessful = goalConditionsMet
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Destroyed attacker in shield", function(operandA, operandB, UID, params)
  local taskObject = localPlayer.getTaskObject()
  local previousScore = (not taskObject.namedTasks.playerScore or not taskObject.namedTasks.playerScore.networkVars.playerDefendBase) and 0
  local goalReportedSuccessful = false
  local function update()
    local goalConditionsMet = false
    if taskObject.namedTasks.playerScore and previousScore ~= taskObject.namedTasks.playerScore.networkVars.playerDefendBase then
      goalConditionsMet = true
    end
    if goalConditionsMet ~= goalReportedSuccessful then
      local completionData = {xpModifier = nil}
      goalSystem.callbackHandler(UID, completionData)
      goalReportedSuccessful = goalConditionsMet
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Attack attempt", function(operandA, operandB, UID, params)
  local taskObject = localPlayer.getTaskObject()
  local previousScore = taskObject.namedTasks.playerScore and taskObject.namedTasks.playerScore.networkVars.playerAttackBase or 0
  local baseTaskObject = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local targetPosition = operandA.coreData.instance.challenge.spawnPositions[baseTaskObject.coreData.agent.index].target
  local targetRadius = operandA.coreData.instance.challenge.spawnPositions[baseTaskObject.coreData.agent.index].targetRadius
  local shieldRadius = operandA.coreData.instance.challenge.settings.baseRadius
  local playerPosition = false
  local goalReportedSuccessful = false
  local controlPointReached = false
  local playerXPModifier = 0
  local playerTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  local function update()
    local goalConditionsMet = false
    controlPointReached = taskObject.namedTasks.playerScore and previousScore < taskObject.namedTasks.playerScore.networkVars.playerAttackBase
    if playerTeam and playerTeam == operandA.coreData.instance.networkVars.roundOn then
      if localPlayer.currentVehicle then
        playerPosition = localPlayer.currentVehicle.position
      elseif playerPosition and baseTaskObject.namedTasks.score then
        local currentShieldRadius = shieldRadius * math.sqrt((operandA.coreData.instance.challenge.settings.targetScore - baseTaskObject.namedTasks.score.networkVars.attackScore) / operandA.coreData.instance.challenge.settings.targetScore)
        local currentDistance = workingVector:sub(playerPosition, targetPosition):length()
        local withinBaseRadius = params.value == (currentShieldRadius > currentDistance)
        if not controlPointReached and withinBaseRadius then
          local percentage = 100 - (currentDistance - targetRadius) / (currentShieldRadius - targetRadius) * 100
          if percentage > params.min then
            playerPosition = false
            playerXPModifier = percentage / 100
            goalConditionsMet = true
          end
        end
      end
    end
    if goalConditionsMet ~= goalReportedSuccessful then
      local completionData = {xpModifier = playerXPModifier}
      goalSystem.callbackHandler(UID, completionData)
      goalReportedSuccessful = goalConditionsMet
    end
  end
  return update, cleanup
end)
local teamPassedPackageCooldown = 0
goalSystem.registerGoal("Team passed package", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local localPlayerTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  local packageTO = false
  local lastAgent = false
  if localPlayerTeam == 1 then
    packageTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  else
    packageTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  end
  if packageAgent then
    lastAgent = packageAgent.coreData.agent.owner
  end
  if teamPassedPackageCooldown > g_NetworkTime then
    teamPassedPackageCooldown = 0
  end
  local function update()
    goalConditionsMet = false
    if lastAgent and packageTO and packageTO.coreData and packageTO.coreData.agent.owner then
      if lastAgent ~= packageTO.coreData.agent.owner and g_NetworkTime - teamPassedPackageCooldown > params.cooldown then
        goalConditionsMet = true
      end
      lastAgent = packageTO.coreData.agent.owner
    else
      if not packageTO then
        if localPlayerTeam == 1 then
          packageTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
        else
          packageTO = operandA.coreData.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
        end
      end
      if packageTO then
        lastAgent = packageTO.coreData.agent.owner
      end
    end
    if goalConditionsMet ~= goalReportedSuccessful then
      teamPassedPackageCooldown = g_NetworkTime
      goalSystem.callbackHandler(UID, {xpModifier = nil})
      goalReportedSuccessful = goalConditionsMet
    end
  end
  return update, cleanup
end)
