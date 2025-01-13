local workingVector = vec.vector(0, 0, 0, 0)
local losingCountDownActive
local setAgent = function(operandA, operandB, params)
  if params.agent == "Player" then
    return localPlayer.currentVehicle
  elseif params.agent == "Target" then
    return operandB
  else
    return operandA.agent
  end
end
local setTarget = function(operandB, params)
  if params.target == "Player" then
    return localPlayer.currentVehicle
  else
    return operandB
  end
end
local lastKnownPositions = {}
function setLastKnownPosition(agent, newPosition)
  lastKnownPositions[agent] = newPosition
  return newPosition
end
function getLastKnownPosition(agent)
  if not lastKnownPositions[agent] then
    lastKnownPositions[agent] = agent.position
  end
  return lastKnownPositions[agent]
end
goalSystem.registerGoal("Within radius", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local agent = setAgent(operandA, operandB, params)
  local target = setTarget(operandB, params)
  local targetPosition = vec.vector()
  local agentPositionLast, targetPositionLast
  return function()
    goalConditionsMet = false
    if params.agent == "Player" then
      if agent ~= localPlayer.currentVehicle then
        agent = localPlayer.currentVehicle
      end
    elseif params.target == "Player" and target ~= localPlayer.currentVehicle then
      target = localPlayer.currentVehicle
    end
    if params.trailer and target.gameVehicle.towedVehicle then
      GameVehicleResource.position(target.gameVehicle.towedVehicle, targetPosition)
    elseif target then
      targetPosition = target.position
    end
    if targetPosition and GameVehicleResource.withinSweptRadius(agent.position, agentPositionLast, targetPosition, targetPositionLast, params.value) then
      goalConditionsMet = true
    end
    agentPositionLast = agent.position
    targetPositionLast = targetPosition
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.increment)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Agent stopped inside radius", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local agent = setAgent(operandA, operandB, params)
  local target = operandB
  local distance
  local hotspotTriggeredAt = false
  local lockedBrakesDuration = params.stopDuration or 1
  local radius = params.value or 5
  local function update()
    goalConditionsMet = false
    if params.agent == "Player" and agent ~= localPlayer.currentVehicle then
      agent = localPlayer.currentVehicle
    end
    if not hotspotTriggeredAt and GameVehicleResource.withinRadius(agent.position, target.position, radius) then
      hotspotTriggeredAt = g_NetworkTime
      localPlayer:blockAbility("zap", true)
      if not agent.controlled then
        agent:stopHighSpeedDriving()
      end
      agent:lockEmergencyBrakes(lockedBrakesDuration)
      agent:addTemporaryInvulnerability(lockedBrakesDuration)
    end
    if hotspotTriggeredAt and g_NetworkTime >= hotspotTriggeredAt + lockedBrakesDuration then
      if params.unlockBrakes then
        agent:unlockEmergencyBrakes()
        localPlayer:blockAbility("zap", false)
      end
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.increment)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    agent:removeTemporaryInvulnerability()
    if not params.leaveZapBlocked then
      localPlayer:blockAbility("zap", false)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Agent brought to a halt", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local triggeredAt = g_NetworkTime
  local lockedBrakesDuration = 1
  if operandA.agent.controlled then
  else
    operandA.agent:stopHighSpeedDriving()
  end
  operandA.agent:lockEmergencyBrakes(lockedBrakesDuration)
  local function update()
    goalConditionsMet = false
    if g_NetworkTime >= triggeredAt + lockedBrakesDuration then
      operandA.agent:unlockEmergencyBrakes()
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
  local function cleanup()
    operandA.agent:unlockEmergencyBrakes()
  end
  return update, cleanup
end)
goalSystem.registerGoal("Any team member within radius of target", function(operandA, operandB, UID, params, feedback)
  local distance
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    for actorID, taskObject in next, operandA.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team == operandA.actor.team then
        local gameVehicleAgent = taskObject.coreData.agent
        vehiclePosLast = getLastKnownPosition(gameVehicleAgent)
        vehiclePos = setLastKnownPosition(gameVehicleAgent, gameVehicleAgent.position)
        targetPosLast = getLastKnownPosition(operandB)
        targetPos = setLastKnownPosition(operandB, operandB.position)
        if GameVehicleResource.withinSweptRadius(vehiclePos, vehiclePosLast, targetPos, targetPosLast, params.value) then
          goalConditionsMet = true
          break
        end
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      if params.increment then
        goalSystem.callbackHandler(UID, params.increment)
      else
        goalSystem.callbackHandler(UID)
      end
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Outside radius of all targets", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = true
  return function()
    goalConditionsMet = true
    for index, target in next, operandA.dynamicTargets, nil do
      if GameVehicleResource.withinRadius(operandA.agent.position, target.position, params.value) then
        goalConditionsMet = false
      end
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Within radius of opposing team member (feedback closest target if in radius)", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    local closestAgent
    local closestDistanceSq = math.huge
    local agentPos, agentPosLast, targetPos, targetPosLast, isWithinRadius, vehicleDistanceSq
    for actorID, taskObject in next, operandA.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team ~= operandA.actor.team then
        agentPosLast = getLastKnownPosition(taskObject.coreData.agent)
        agentPos = setLastKnownPosition(taskObject.coreData.agent, taskObject.coreData.agent.position)
        targetPosLast = getLastKnownPosition(operandA.agent)
        targetPos = setLastKnownPosition(operandA.agent, operandA.agent.position)
        isWithinRadius, vehicleDistanceSq = GameVehicleResource.withinSweptRadius(agentPos, agentPosLast, targetPos, targetPosLast, params.value)
        if isWithinRadius then
          goalConditionsMet = true
          if closestDistanceSq > vehicleDistanceSq then
            if closestAgent ~= taskObject.coreData.agent then
              goalReportedSuccessful = false
            end
            closestAgent = taskObject.coreData.agent
            closestDistanceSq = vehicleDistanceSq
          end
        end
      end
    end
    if feedback then
      feedback(closestAgent)
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
goalSystem.registerGoal("Agent within then outside radius of target", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local isWithinRadius = {}
  local outsideRadius = params.outsideRadius or params.value
  return function()
    local agentPos, agentPosLast, targetPos, targetPos
    goalConditionsMet = false
    if params.player then
      agentPosLast = getLastKnownPosition(localPlayer.currentVehicle)
      agentPos = setLastKnownPosition(localPlayer.currentVehicle, localPlayer.currentVehicle.position)
    else
      agentPosLast = getLastKnownPosition(operandA.agent)
      agentPos = setLastKnownPosition(operandA.agent, operandA.agent.position)
    end
    for index, target in next, operandA.dynamicTargets, nil do
      targetPosLast = getLastKnownPosition(target)
      targetPos = setLastKnownPosition(target, target.position)
      if isWithinRadius[target] then
        radius = params.value
      else
        radius = outsideRadius
      end
      local inRadius, distanceSq
      inRadius, distanceSq = GameVehicleResource.withinSweptRadius(agentPos, agentPosLast, targetPos, targetPosLast, radius)
      if isWithinRadius[target] and not inRadius then
        goalConditionsMet = true
        break
      elseif not isWithinRadius[target] then
        isWithinRadius[target] = inRadius
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.increment)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Player within then outside radius of agent", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local insideRadius = false
  local distance
  local outsideRadius = params.outsideRadius or params.value
  return function()
    goalConditionsMet = false
    local agentPos, agentPosLast, targetPos, targetPos
    if not localPlayer.inZap and localPlayer.currentVehicle then
      agentPosLast = getLastKnownPosition(localPlayer.currentVehicle)
      agentPos = setLastKnownPosition(localPlayer.currentVehicle, localPlayer.currentVehicle.position)
      targetPosLast = getLastKnownPosition(operandA.agent)
      targetPos = setLastKnownPosition(operandA.agent, operandA.agent.position)
      if insideRadius then
        radius = params.value
      else
        radius = outsideRadius
      end
      local result = GameVehicleResource.withinSweptRadius(agentPos, agentPosLast, targetPos, targetPosLast, radius)
      if insideRadius and not result then
        goalConditionsMet = true
        insideRadius = false
      elseif not insideRadius then
        insideRadius = result
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.increment)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Within range", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local relativeDistance
  return function()
    closestPosition = nil
    goalConditionsMet = false
    local agentPos, agentPosLast, targetPos, targetPos
    if operandB and operandB.position then
      agentPosLast = getLastKnownPosition(operandA.agent)
      agentPos = setLastKnownPosition(operandA.agent, operandA.agent.position)
      targetPosLast = getLastKnownPosition(operandB)
      targetPos = setLastKnownPosition(operandB, operandB.position)
      local withinRadius, distanceSq
      withinRadius, distanceSq = GameVehicleResource.withinSweptRadius(agentPos, agentPosLast, targetPos, targetPosLast, radius)
      if distanceSq > params.minimum * params.minimum and distanceSq < params.maximum * params.maximum then
        goalConditionsMet = true
      end
      if feedback then
        feedback(sqrt(distanceSq))
      end
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      if params.increment then
        goalSystem.callbackHandler(UID, params.increment)
      else
        goalSystem.callbackHandler(UID)
      end
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Player vehicle within radius in front of agent", function(operandA, operandB, UID, params, feedback)
  local relativeDistance, relativeHeight
  local heightDiffAllowed = 8
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local stuntMood = false
  local offset = params.offset or vec.vector(0, 0, 40, 1)
  local graphicsPosition = vec.vector(0, 0, 0, 0)
  local startTime, elapsedTime
  return function()
    goalConditionsMet = false
    Marker.setAnimationLength("Fade", 0.5)
    if not localPlayer.inZap and localPlayer.currentVehicle then
      local position = localPlayer.currentVehicle.position
      local height = position[1]
      operandA.agent.matrix:multiply(offset, graphicsPosition)
      relativeDistance = workingVector:sub(position, graphicsPosition):length()
      relativeHeight = operandA.agent.position[1] - height
      if relativeHeight > -heightDiffAllowed and relativeHeight < heightDiffAllowed then
        if relativeDistance < params.value then
          if params.timedValue then
            if not startTime then
              startTime = g_NetworkTime
            end
            elapsedTime = g_NetworkTime - startTime
            goalConditionsMet = elapsedTime >= params.timedValue
          else
            goalConditionsMet = true
          end
          if feedback then
            feedback(true)
          end
        else
          if feedback then
            feedback(false)
          end
          startTime = nil
        end
      end
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      if params.increment then
        goalSystem.callbackHandler(UID, params.increment)
      else
        goalSystem.callbackHandler(UID)
      end
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end, function()
  end
end)
goalSystem.registerGoal("Player within radius in zap", function(operandA, operandB, UID, params, feedback)
  local relativeDistance
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if localPlayer.inZap and zapcontroller.getZapLevel() < 4 then
      local position = game_camera.matrix[3]:clone()
      if params.useOperandA then
        position.y = operandA.agent.position.y
        relativeDistance = GameVehicleResource.withinRadius(position, operandA.agent.position, params.value)
      else
        position.y = operandB.position.y
        relativeDistance = GameVehicleResource.withinRadius(position, operandB.position, params.value)
      end
      if relativeDistance then
        goalConditionsMet = true
        if feedback then
          feedback(closestPosition)
        end
      elseif feedback then
        feedback(nil)
      end
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      if params.increment then
        goalSystem.callbackHandler(UID, params.increment)
      else
        goalSystem.callbackHandler(UID)
      end
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("AI has reached destination", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = operandA:get_highSpeedDrivingReachedDestination()
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Alongside vehicle", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local transform = vec.matrix()
  local workingVector = vec.vector(0, 0, 0, 0)
  local horizontalDistance = 8
  local angle, tangent
  local heading = vec.vector(0, 0, 0, 0)
  local offset = vec.vector(0, 0, 0, 0)
  local flipOffset = vec.vector(0, 0, 0, 0)
  local limit1 = vec.vector(0, 0, 0, 0)
  local limit2 = vec.vector(0, 0, 0, 0)
  local limit3 = vec.vector(0, 0, 0, 0)
  local limit4 = vec.vector(0, 0, 0, 0)
  local minimum, maximum, dot
  local stripDepth = params.value or 4
  local agentRoadIndex, agentDistanceAlong, targetPosition, targetRoadIndex, targetDistanceAlong, targetRoadLength
  local agent = setAgent(operandA, operandB, params)
  local target = setTarget(operandB, params)
  local function checkRelativeHeading()
    if params.checkSameDirection then
      dot = agent.matrix[2]:dot(target.matrix[2])
      if dot < 0.5 then
        return false
      end
    elseif params.checkAgainstDirection then
      dot = agent.matrix[2]:dot(target.matrix[2])
      if dot > -0.5 then
        return false
      end
    end
    return true
  end
  local function targetOnJunction()
    if checkRelativeHeading() then
      offset.x = horizontalDistance
      flipOffset.x = -horizontalDistance
      heading = getVectorRoadAngleAtPosition(targetRoadIndex, targetDistanceAlong)
      angle = math.atan2(heading.x, heading.z)
      transform[0].x = math.cos(angle)
      transform[2].x = math.sin(angle)
      transform[0].z = -transform[2].x
      transform[2].z = transform[0].x
      transform[3] = target.position
      transform[3] = target.position
      workingVector.x = -stripDepth
      workingVector.y = 0
      workingVector.z = -stripDepth
      workingVector.w = 0
      limit1 = limit1:add(target.position, workingVector * heading)
      workingVector.x = stripDepth
      workingVector.y = 0
      workingVector.z = stripDepth
      workingVector.w = 0
      limit2 = limit2:add(target.position, workingVector * heading)
      limit3 = limit3:add(target.position, transform * flipOffset)
      limit4 = limit4:add(target.position, transform * offset)
      tangent = workingVector:sub(limit4, target.position):normalise()
      if 0 < agent.position - limit1:dot(heading) and 0 > agent.position - limit2:dot(heading) and 0 < agent.position - limit3:dot(tangent) and 0 > agent.position - limit4:dot(tangent) then
        goalConditionsMet = true
      end
    end
  end
  local function targetOnRoad()
    if checkRelativeHeading() and agentRoadIndex == targetRoadIndex then
      minimum = targetDistanceAlong - stripDepth
      if minimum < 0 then
        minimum = 0
      end
      maximum = targetDistanceAlong + stripDepth
      if maximum > targetRoadLength then
        maximum = targetRoadLength
      end
      agentDistanceAlong = agent:get_closestDistanceAlongRoad()
      if agentDistanceAlong > minimum and agentDistanceAlong < maximum then
        goalConditionsMet = true
      end
    end
  end
  return function()
    goalConditionsMet = false
    targetRoadIndex, targetDistanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(target.position)
    targetRoadLength = Atlas.RoadLength(targetRoadIndex)
    agentRoadIndex = agent:get_closestRoadIndex()
    if targetDistanceAlong == 0 or targetDistanceAlong == targetRoadLength then
      targetOnJunction()
    else
      targetOnRoad()
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
goalSystem.registerGoal("Outside radius", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if not GameVehicleResource.withinRadius(operandA.agent.position, operandB.position, params.value) then
      goalConditionsMet = true
    end
    if feedback then
      feedback(goalConditionsMet)
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
goalSystem.registerGoal("Within strip of road", function(operandA, operandB, UID, params)
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
    agent = operandA.agent.currentVehicle or operandA.agent
    goalConditionsMet = false
    vehicleRoadIndex = agent:get_closestRoadIndex()
    if vehicleRoadIndex == roadIndex then
      vehicleDistanceAlong = agent:get_closestDistanceAlongRoad()
      if vehicleDistanceAlong > minimum and vehicleDistanceAlong < maximum then
        goalConditionsMet = true
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
goalSystem.registerGoal("Is player on this road ID", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local playerRoadIndex
  return function()
    goalConditionsMet = false
    if localPlayer.currentVehicle then
      playerRoadIndex = localPlayer.currentVehicle:get_closestRoadIndex()
    end
    if params.roadIndex == playerRoadIndex then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Driving to checkpoint", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if operandA.networkVars.checkpoints == params.value then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Completed lap", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if operandA.networkVars.laps > params.value then
      local taskObject = taskSystem.taskObjects[operandA.taskObjectID]
      if params.setRaceFinished then
        taskObject.coreData.raceFinished = true
      end
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Is getting closer to target", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local distances = {}
  local previousTime = g_NetworkTime
  local agent = setAgent(operandA, operandB, params)
  local target = setTarget(operandB, params)
  if params.agent == "Player" then
    if agent ~= localPlayer.currentVehicle then
      agent = localPlayer.currentVehicle
    end
  elseif params.target == "Player" and target ~= localPlayer.currentVehicle then
    target = localPlayer.currentVehicle
  end
  local relativeDistance
  local previousDistance = workingVector:sub(agent.position, target.position):length()
  local function maintainTable()
    table.insert(distances, relativeDistance)
  end
  local function clearTable()
    distances = {}
  end
  return function()
    goalConditionsMet = false
    if params.agent == "Player" then
      if agent ~= localPlayer.currentVehicle then
        agent = localPlayer.currentVehicle
      end
    elseif params.target == "Player" and target ~= localPlayer.currentVehicle then
      target = localPlayer.currentVehicle
    end
    if g_NetworkTime >= previousTime + (params.timer or 1) then
      relativeDistance = workingVector:sub(agent.position, target.position):length()
      if not params.inverse and relativeDistance < previousDistance or params.inverse and relativeDistance > previousDistance then
        maintainTable()
        if #distances >= params.value then
          goalConditionsMet = true
        end
      else
        clearTable()
      end
      previousDistance = relativeDistance
      previousTime = g_NetworkTime
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
goalSystem.registerGoal("Is player in vehicle model", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local vehicleModel
  local requiredModel = params.value
  local goalConditionsMet = false
  local listOfVehicle
  listOfVehicle = requiredModel and type(requiredModel) == "table"
  return function()
    if localPlayer.currentVehicle then
      goalConditionsMet = false
      if localPlayer.currentVehicle then
        vehicleModel = localPlayer.currentVehicle.model_id
      end
      if vehicleModel then
        if listOfVehicle then
          for k, v in next, requiredModel, nil do
            if v == vehicleModel then
              goalConditionsMet = true
              break
            end
          end
        elseif vehicleModel == requiredModel then
          goalConditionsMet = true
        end
      end
      if params.inverse then
        goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Damage above", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if operandA.agent.damage >= params.value then
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
goalSystem.registerGoal("Damage below", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if operandA.agent.damage < params.value then
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
goalSystem.registerGoal("Damage has gone above", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local startValueBelow = operandA.agent.damage < params.value
  return function()
    goalConditionsMet = false
    if startValueBelow and operandA.agent.damage >= params.value then
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
goalSystem.registerGoal("Target damage above", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if operandB.damage >= params.value then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if feedback then
      feedback(operandB.damage)
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
goalSystem.registerGoal("All targets damage above", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local targetQuantity = #operandA.dynamicTargets
  local goalConditionsMet = false
  return function()
    local targetsRemaining = targetQuantity
    for index, target in next, operandA.dynamicTargets, nil do
      if target.damage >= params.value then
        targetsRemaining = targetsRemaining - 1
      end
    end
    if operandA.networkVars and operandA.networkVars.targetsRemaining then
      operandA.networkVars.targetsRemaining = targetsRemaining
    end
    goalConditionsMet = false
    if targetsRemaining <= 0 and not goalReportedSuccessful then
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
goalSystem.registerGoal("All targets eliminated (Non-linear)", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if operandA.networkVars.eliminatedTargets then
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
goalSystem.registerGoal("Empty dynamicTargets", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if #operandA.dynamicTargets < 1 then
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
goalSystem.registerGoal("Damage has changed by", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local previousDamage = operandA.agent.damage
  return function()
    goalConditionsMet = false
    if params.value then
      if operandA.agent.damage - previousDamage > params.value then
        if not params.inverse then
          goalConditionsMet = true
        end
        previousDamage = operandA.agent.damage
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
goalSystem.registerGoal("Any team member damage above", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local playerTask = taskSystem.taskObjects[operandA.taskObjectID]
  return function()
    goalConditionsMet = false
    if playerTask == localPlayer.missionSupport:getMainTaskObject() then
      for actorID, taskObject in next, operandA.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == operandA.actor.team and taskObject.coreData.agent.damage >= params.value then
          goalConditionsMet = true
          break
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
goalSystem.registerGoal("All team members damage above", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = true
  return function()
    goalConditionsMet = true
    if params.team then
      for actorID, taskObject in next, operandA.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == params.team and taskObject.coreData.agent.damage < params.value then
          goalConditionsMet = false
          break
        end
      end
    else
      for actorID, taskObject in next, operandA.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == operandA.actor.team and taskObject.coreData.agent.damage < params.value then
          goalConditionsMet = false
          break
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
goalSystem.registerGoal("All opposing vehicles damage above", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = true
  return function()
    goalConditionsMet = true
    for actorID, taskObject in next, operandA.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team ~= operandA.actor.team and taskObject.coreData.agent.damage < params.value then
        goalConditionsMet = false
        break
      end
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Button Press", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local pad1 = controlHandler.pad
  local watchForPressed = params.watchFor
  local watchedButton = params.button
  local watchedButton_status
  local watchForNumber = params.number
  local watchForValue, watchNotNeeded, currentNumber
  local stateSet = false
  local pressed = false
  local goalConditionsMet = false
  local function steeringCallback(state, value)
    if watchForPressed == "Right" and value >= 0.75 then
      pressed = true
    elseif watchForPressed == "Left" and value <= -0.75 then
      pressed = true
    elseif watchForPressed == "Either" and (value >= 0.75 or value <= -0.75) then
      pressed = true
    elseif watchForPressed == "Down" and value == -1 then
      pressed = true
    end
  end
  local function update()
    goalConditionsMet = false
    if watchedButton == "Vehicle_Steer" and not stateSet then
      controlHandler:registerState(localPlayer.localID, "vehicleSteeringWatch", {
        [watchedButton] = {
          NotPressed = {
            [1] = steeringCallback
          }
        },
        ["Zoom_Minimap"] = {
          JustPressed = {
            [1] = localPlayer.controllerInterface.ZoomOutMinimap
          },
          JustReleased = {
            [1] = localPlayer.controllerInterface.ZoomInMinimap
          }
        }
      })
      controlHandler:setState("vehicleSteeringWatch")
      stateSet = true
    elseif watchedButton == "Zap_Look_UpDown" and not stateSet then
      controlHandler:registerState(localPlayer.localID, "vehicleCameraWatch", {
        [watchedButton] = {
          NotPressed = {
            [1] = steeringCallback
          }
        },
        ["Zoom_Minimap"] = {
          JustPressed = {
            [1] = localPlayer.controllerInterface.ZoomOutMinimap
          },
          JustReleased = {
            [1] = localPlayer.controllerInterface.ZoomInMinimap
          }
        }
      })
      controlHandler:setState("vehicleCameraWatch")
      stateSet = true
    elseif watchedButton == "Open_Trunk" and not stateSet then
      controlHandler:registerState(localPlayer.localID, "Trunked", {
        [watchedButton] = {
          JustPressed = {
            function()
              pressed = true
              OneShotSound.Play("Mis_Kidnapped_TrunkPress")
            end
          }
        }
      })
      controlHandler:setState("Trunked")
      stateSet = true
    elseif not stateSet then
      watchedButton_status = pad1:status(watchedButton)
    end
    if watchedButton_status == watchForPressed or pressed == true then
      if watchedButton == "Vehicle_Steer" then
        controlHandler:resetState("vehicleSteeringWatch")
        controlHandler:removeState("vehicleSteeringWatch", localPlayer.localID)
        stateSet = false
      elseif watchedButton == "Zap_Look_UpDown" then
        controlHandler:resetState("vehicleCameraWatch")
        controlHandler:removeState("vehicleCameraWatch", localPlayer.localID)
        stateSet = false
      elseif watchedButton == "Open_Trunk" then
        controlHandler:resetState("Trunked")
        controlHandler:removeState("Trunked", localPlayer.localID)
        stateSet = false
      end
      if watchForNumber and pressed then
        pressed = false
        if not currentNumber then
          currentNumber = 0
        end
        currentNumber = currentNumber + 1
        if currentNumber >= watchForNumber then
          goalConditionsMet = true
        end
      elseif watchForNumber and not pressed then
      else
        goalConditionsMet = true
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
  local function cleanup()
    if stateSet then
      if watchedButton == "Vehicle_Steer" then
        controlHandler:resetState("vehicleSteeringWatch")
        controlHandler:removeState("vehicleSteeringWatch", localPlayer.localID)
      elseif watchedButton == "Zap_Look_UpDown" then
        controlHandler:resetState("vehicleCameraWatch")
        controlHandler:removeState("vehicleCameraWatch", localPlayer.localID)
      elseif watchedButton == "Open_Trunk" then
        controlHandler:resetState("Trunked")
        controlHandler:removeState("Trunked", localPlayer.localID)
      end
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Time trigger", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local startTime = 0
  if params.useInstanceStart then
    startTime = operandA.instance.networkVars.startTime
  elseif params.startTimeValue then
    startTime = operandA.instance.timerStartTime
  else
    startTime = g_NetworkTime
  end
  local elapsedTime
  local goalConditionsMet = false
  local function update()
    elapsedTime = g_NetworkTime - startTime
    if params.takeZapIntoAccount and localPlayer.inZap then
      goalConditionsMet = elapsedTime >= params.value * zap.singlePlayerZapSlowDownMultiplier
    else
      goalConditionsMet = elapsedTime >= params.value
    end
    if feedback then
      feedback(elapsedTime)
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
goalSystem.registerGoal("X time has past", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local previousTime = g_NetworkTime
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if g_NetworkTime > previousTime + params.value then
      goalConditionsMet = true
      previousTime = g_NetworkTime
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
goalSystem.registerGoal("Below speed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    local speed
    if params.displayed then
      speed = operandA.agent.gameVehicle.displayedSpeed
    else
      speed = operandA.agent.speed
    end
    speed = speed * 2.236
    if speed < params.value then
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
goalSystem.registerGoal("Above speed", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local maxSpeed = params.value
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    local speed
    if params.displayed then
      speed = operandA.agent.gameVehicle.displayedSpeed
    else
      speed = operandA.agent.speed
    end
    speed = speed * 2.236
    if speed > maxSpeed then
      goalConditionsMet = true
    elseif feedback then
      feedback(0)
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
goalSystem.registerGoal("Target below speed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local target = operandA.dynamicTargets[1]
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if target.speed * 2.236 < params.value then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Player above speed", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local maxSpeed = params.value
  local inverse = not params.inverse and false
  local goalConditionsMet = false
  return function()
    if localPlayer.currentVehicle then
      goalConditionsMet = false
      local speed
      if params.displayed then
        speed = localPlayer.currentVehicle.gameVehicle.displayedSpeed
      else
        speed = localPlayer.currentVehicle.speed
      end
      speed = speed * 2.236
      if speed > maxSpeed then
        goalConditionsMet = true
      end
      if params.inverse then
        goalConditionsMet = not goalConditionsMet
      end
      if feedback then
        feedback(speed)
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
goalSystem.registerGoal("Player is none of actors specified", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local playerTaskObject
  local goalConditionsMet = true
  local function update()
    goalConditionsMet = true
    playerTaskObject = localPlayer.currentVehicle:getTaskObject()
    if playerTaskObject then
      for k, actorID in next, params.actorIDs, nil do
        if actorID == playerTaskObject.coreData.actor.ID then
          goalConditionsMet = false
          break
        end
      end
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Vehicle selected in shift", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local playerTaskObject
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = false
    local gameVehicleSelected = zapcontroller.GetTargetedGameVehicle()
    if gameVehicleSelected then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Specified actors selected in zap", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local playerTaskObject
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = false
    for k, actorID in next, params.actorIDs, nil do
      if operandA.instance.taskObjectsByActorID[actorID] then
        local gameVehicleSelected = zapcontroller.GetTargetedGameVehicle()
        if gameVehicleSelected and gameVehicleSelected == operandA.instance.taskObjectsByActorID[actorID].coreData.agent.gameVehicle then
          goalConditionsMet = true
          break
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
  return update
end)
goalSystem.registerGoal("Struck by player", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local hitByPlayer = false
  local goalConditionsMet = false
  local feedbackInfo
  local function collisionCheck(collisionData)
    hitByPlayer = true
    if feedback then
      if collisionData.WhereIWasHit == "Front" or collisionData.WhereIWasHit == "Behind" then
        feedback(collisionData.WhereIWasHit)
      elseif collisionData.CollidedNormalY > 0 then
        feedback("Right")
      else
        feedback("Left")
      end
    end
  end
  local callbackSettings = {callbackFunction = collisionCheck, localPlayerOnly = true}
  operandA.agent:addCollisionCallback(callbackSettings)
  local function update()
    goalConditionsMet = false
    if hitByPlayer then
      goalConditionsMet = true
      hitByPlayer = false
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
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
goalSystem.registerGoal("Specified actors struck by player", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local previousVehicle
  local hitSpecifiedActor = false
  local specifiedGameVehicles = {}
  local taskObjectsByActorID = operandA.instance.taskObjectsByActorID
  for i = 1, #params.actorIDs do
    local actorID = params.actorIDs[i]
    if operandA.instance.taskObjectsByActorID[actorID] then
      if params.useTrailer and taskObjectsByActorID[actorID].coreData.agent.gameVehicle.towedVehicle then
        specifiedGameVehicles[taskObjectsByActorID[actorID].coreData.agent.gameVehicle.towedVehicle] = true
      else
        specifiedGameVehicles[taskObjectsByActorID[actorID].coreData.agent.gameVehicle] = true
      end
    end
  end
  local function collisionCheck(collisionData)
    if collisionData.CollidedGameVehicle and specifiedGameVehicles[collisionData.CollidedGameVehicle] and vehicleManager.vehiclesByGameVehicle[collisionData.CollidedGameVehicle] and vehicleManager.vehiclesByGameVehicle[collisionData.CollidedGameVehicle]:getTaskObject() then
      hitSpecifiedActor = true
    elseif collisionData.CollidedGameVehicle and specifiedGameVehicles[collisionData.CollidedGameVehicle] and params.useTrailer then
      hitSpecifiedActor = true
    end
  end
  local callbackSettings = {callbackFunction = collisionCheck, typeOfHit = "Vehicle"}
  local function update()
    goalConditionsMet = false
    if localPlayer.currentVehicle and localPlayer.currentVehicle ~= previousVehicle then
      if previousVehicle then
        previousVehicle:removeCollisionCallback(callbackSettings)
      end
      localPlayer.currentVehicle:addCollisionCallback(callbackSettings)
      previousVehicle = localPlayer.currentVehicle
    end
    if hitSpecifiedActor then
      goalConditionsMet = true
      hitSpecifiedActor = false
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    if previousVehicle then
      previousVehicle:removeCollisionCallback(callbackSettings)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Struck specified actors", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local hitBySpecifiedActor = false
  local specifiedGameVehicles = {}
  local taskObjectsByActorID = operandA.instance.taskObjectsByActorID
  for i = 1, #params.actorIDs do
    local actorID = params.actorIDs[i]
    if taskObjectsByActorID[actorID] then
      specifiedGameVehicles[taskObjectsByActorID[actorID].coreData.agent.gameVehicle] = true
    end
  end
  local function collisionCheck(collisionData)
    if collisionData.CollidedGameVehicle and specifiedGameVehicles[collisionData.CollidedGameVehicle] and vehicleManager.vehiclesByGameVehicle[collisionData.CollidedGameVehicle] and vehicleManager.vehiclesByGameVehicle[collisionData.CollidedGameVehicle]:getTaskObject() then
      hitBySpecifiedActor = true
    end
  end
  local callbackSettings = {callbackFunction = collisionCheck, typeOfHit = "Vehicle"}
  operandA.agent:addCollisionCallback(callbackSettings)
  local function update()
    goalConditionsMet = false
    if hitBySpecifiedActor then
      goalConditionsMet = true
      hitBySpecifiedActor = false
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
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
local explosionSettings = {
  offset = vec.vector(1, 0, 0, 1),
  range = 0,
  strength = 5
}
local damageSettings = {damage = 1}
goalSystem.registerGoal("Destroy specified actor after collision", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local hitGameVehicle = false
  local goalConditionsMet = false
  local specifiedGameVehicles = {}
  local taskObjectsByActorID = operandA.instance.taskObjectsByActorID
  for __, actorID in ipairs(params.actorIDs) do
    if taskObjectsByActorID[actorID] then
      specifiedGameVehicles[operandA.instance.taskObjectsByActorID[actorID].coreData.agent.gameVehicle] = true
    end
  end
  local function collisionCheck(collisionData)
    if collisionData.CollidedGameVehicle and specifiedGameVehicles[collisionData.CollidedGameVehicle] and vehicleManager.vehiclesByGameVehicle[collisionData.CollidedGameVehicle] and vehicleManager.vehiclesByGameVehicle[collisionData.CollidedGameVehicle]:getTaskObject() then
      hitGameVehicle = collisionData.CollidedGameVehicle
    end
  end
  local callbackSettings = {callbackFunction = collisionCheck, minimumForce = 1000}
  operandA.agent:addCollisionCallback(callbackSettings)
  local function update()
    goalConditionsMet = false
    if hitGameVehicle then
      if params.explode then
        explosionSettings.gameVehicle = hitGameVehicle
        GameVehicleResource.explode(explosionSettings)
      else
        damageSettings.gameVehicle = hitGameVehicle
        GameVehicleResource.applyDamage(damageSettings)
      end
      goalConditionsMet = true
      hitGameVehicle = false
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
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
goalSystem.registerGoal("Player within radius of opposing team member", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local workingVector2 = vec.vector()
  local closestPostion
  local goalConditionsMet = false
  local agent = setAgent(operandA, operandB, params)
  return function()
    local agentPos, agentPosLast, targetPos, targetPos
    goalConditionsMet = false
    closestPostion = nil
    if params.agent == "Player" and agent ~= localPlayer.currentVehicle then
      agent = localPlayer.currentVehicle
    end
    for k, v in next, operandA.instance.taskObjectsByActorID, nil do
      if v.coreData and v.coreData.actor.team ~= operandA.actor.team then
        agentPosLast = getLastKnownPosition(agent)
        agentPos = setLastKnownPosition(agent, agent.position)
        targetPosLast = getLastKnownPosition(v.coreData.agent)
        targetPos = setLastKnownPosition(v.coreData.agent, v.coreData.agent.position)
        if GameVehicleResource.withinSweptRadius(agentPos, agentPosLast, targetPos, targetPosLast, params.value) then
          closestPostion = v.coreData.agent.position
          goalConditionsMet = true
        end
      end
    end
    if feedback then
      feedback(closestPostion)
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Within radius of player", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    local agentPos, agentPosLast, targetPos, targetPos
    if not localPlayer.inZap and localPlayer.currentVehicle and localPlayer.currentVehicle ~= operandA.agent then
      agentPosLast = getLastKnownPosition(operandA.agent)
      agentPos = setLastKnownPosition(operandA.agent, operandA.agent.position)
      targetPosLast = getLastKnownPosition(localPlayer.currentVehicle)
      targetPos = setLastKnownPosition(localPlayer.currentVehicle, localPlayer.currentVehicle.position)
      if GameVehicleResource.withinSweptRadius(agentPos, agentPosLast, targetPos, targetPosLast, params.value) then
        goalConditionsMet = true
      end
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Player outside radius of specified actors", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local workingVector2 = vec.vector()
  local goalConditionsMet = true
  return function()
    goalConditionsMet = true
    local agentPos, agentPosLast, targetPos, targetPos
    for index, actorID in next, params.actorIDs, nil do
      for k, v in next, operandA.instance.taskObjectsByActorID, nil do
        if localPlayer.currentVehicle and v.coreData and v.coreData.actor.ID == actorID then
          agentPosLast = getLastKnownPosition(v.coreData.agent)
          agentPos = setLastKnownPosition(v.coreData.agent, v.coreData.agent.position)
          targetPosLast = getLastKnownPosition(localPlayer.currentVehicle)
          targetPos = setLastKnownPosition(localPlayer.currentVehicle, localPlayer.currentVehicle.position)
          if GameVehicleResource.withinSweptRadius(agentPos, agentPosLast, targetPos, targetPosLast, params.value) then
            goalConditionsMet = false
            break
          end
        end
      end
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Within radius of specified actor", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    local agentPos, agentPosLast, targetPos, targetPos
    if params.actorID and operandA.instance.taskObjectsByActorID[params.actorID] and operandA.instance.taskObjectsByActorID[params.actorID].coreData.agent then
      agentPosLast = getLastKnownPosition(operandA.agent)
      agentPos = setLastKnownPosition(operandA.agent, operandA.agent.position)
      targetAgent = operandA.instance.taskObjectsByActorID[params.actorID].coreData.agent
      targetPosLast = getLastKnownPosition(targetAgent)
      targetPos = setLastKnownPosition(targetAgent, targetAgent.position)
      if GameVehicleResource.withinSweptRadius(agentPos, agentPosLast, targetPos, targetPosLast, params.value) then
        goalConditionsMet = true
      end
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Specified actor within radius of specified actor", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    local agentPos, agentPosLast, targetPos, targetPos
    if params.firstActorID and operandA.instance.taskObjectsByActorID[params.firstActorID] and operandA.instance.taskObjectsByActorID[params.firstActorID].coreData.agent and params.secondActorID and operandA.instance.taskObjectsByActorID[params.secondActorID] and operandA.instance.taskObjectsByActorID[params.secondActorID].coreData.agent then
      local agent1 = operandA.instance.taskObjectsByActorID[params.firstActorID].coreData.agent
      local agent2 = operandA.instance.taskObjectsByActorID[params.secondActorID].coreData.agent
      agentPosLast = getLastKnownPosition(agent1)
      agentPos = setLastKnownPosition(agent1, agent1.position)
      targetPosLast = getLastKnownPosition(agent2)
      targetPos = setLastKnownPosition(agent2, agent2.position)
      if GameVehicleResource.withinSweptRadius(agentPos, agentPosLast, targetPos, targetPosLast, params.value) then
        goalConditionsMet = true
      end
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Player in target vehicle", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if params.ignoreZap and localPlayer.currentVehicle and localPlayer.currentVehicle == operandB then
      goalConditionsMet = true
    elseif operandB.controlled then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Player in agent", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if operandA.instance.taskObjectsByActorID[params.agentName] and operandA.instance.taskObjectsByActorID[params.agentName].coreData.agent.controlled then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Player in any other vehicle", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = false
    if not localPlayer.inZap and not operandA.agent.controlled and localPlayer.currentVehicle and localPlayer.currentVehicle ~= operandA.agent then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Player in a specified agent", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local wasInZap = true
  local previousValue = false
  local currentActorID
  return function()
    goalConditionsMet = previousValue
    if wasInZap and not localPlayer.inZap then
      wasInZap = false
      for index, actorID in next, params.actorIDs, nil do
        if operandA.instance.taskObjectsByActorID[actorID] and operandA.instance.taskObjectsByActorID[actorID].coreData.agent.controlled then
          previousValue = true
          goalConditionsMet = previousValue
          currentActorID = actorID
        end
      end
    elseif not wasInZap and localPlayer.inZap then
      wasInZap = true
      currentActorID = nil
      previousValue = false
    end
    if previousValue and feedback then
      feedback(currentActorID)
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Player just zapped out of specified actors", function(operandA, operandB, UID, params)
  local goalChecked = false
  local inVehicle = false
  return function()
    if not goalChecked then
      for index, actorName in next, params.actors, nil do
        if operandA.instance.taskObjectsByActorID[actorName] and operandA.instance.taskObjectsByActorID[actorName].coreData.agent == localPlayer.currentVehicle then
          if not localPlayer.inZap then
            inVehicle = true
          end
          break
        end
      end
      if inVehicle and localPlayer.inZap then
        goalChecked = true
        goalSystem.callbackHandler(UID)
      end
    elseif not localPlayer.inZap then
      goalSystem.callbackHandler(UID)
      goalChecked = false
    end
  end
end)
goalSystem.registerGoal("Overtakes", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local startOvertakes = localPlayer.scoring:getNumberOfOvertakes()
  local challengeOvertakesRequired = params.value
  local goalConditionsMet = false
  local inCarOvertakes
  return function()
    goalConditionsMet = false
    local numOvertakes = localPlayer.scoring:getNumberOfOvertakes()
    if operandA.agent.controlled or operandA.agent == localPlayer then
      inCarOvertakes = numOvertakes - startOvertakes
      if feedback then
        feedback(inCarOvertakes)
      end
      if inCarOvertakes >= challengeOvertakesRequired then
        goalConditionsMet = true
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
goalSystem.registerGoal("Drive under trailer", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local startTime = 0
  local underTime
  local under = false
  local bufferStart
  local totalTimeOut = 0
  local allowed = false
  local trailerGameVehicle = false
  local function recycleTrailerGameVehicle(gameVehicle)
    for k, v in next, operandA.instance.previousTrailers, nil do
      if operandA.instance.previousTrailers[k] == gameVehicle then
        operandA.instance.previousTrailers[k] = nil
      end
    end
    GameVehicleResource.UnRegisterDeletionCallback(gameVehicle, recycleTrailerGameVehicle)
  end
  local function checkPreviousTrailers()
    local trailerUsed = false
    if operandA.instance.previousTrailers then
      for index, gameVehicle in next, operandA.instance.previousTrailers, nil do
        if operandA.instance.previousTrailers[index] == trailerGameVehicle then
          trailerUsed = true
          trailerGameVehicle = false
          break
        end
      end
    end
    if not trailerUsed then
      minimap.UnderTrailerArrowsExcludeGameVehicle(trailerGameVehicle)
      if not operandA.instance.previousTrailers then
        operandA.instance.previousTrailers = {}
      end
      table.insert(operandA.instance.previousTrailers, trailerGameVehicle)
      GameVehicleResource.RegisterDeletionCallback(trailerGameVehicle, recycleTrailerGameVehicle)
      trailerGameVehicle = false
      goalConditionsMet = true
    end
  end
  local function underTrailerCallback(callbackInfo)
    if not params.checkPreviousTrailers then
      allowed = false
      if params.self and callbackInfo.GameVehicle == operandA.agent.gameVehicle then
        allowed = true
      end
      if params.useTarget and operandB.gameVehicle and callbackInfo.GameVehicle == operandB.gameVehicle then
        allowed = true
      end
      if params.useDynamicTargets then
        for k, target in next, operandA.dynamicTargets, nil do
          if target.gameVehicle and callbackInfo.GameVehicle == target.gameVehicle then
            allowed = true
            break
          end
        end
      end
      if params.timer and allowed then
        if params.bufferTime and bufferStart ~= nil then
          totalTimeOut = totalTimeOut + (g_NetworkTime - bufferStart)
        else
          startTime = g_NetworkTime
        end
        under = true
      elseif allowed then
        goalConditionsMet = true
      end
    elseif not trailerGameVehicle then
      trailerGameVehicle = callbackInfo.GameVehicle
    end
  end
  local function underTrailerExitCallback(callbackInfo)
    under = false
    if params.bufferTime and allowed then
      bufferStart = g_NetworkTime
    end
    if trailerGameVehicle then
      checkPreviousTrailers()
    end
  end
  localPlayer.scoring.registerUnderTrailerCallback(underTrailerCallback)
  localPlayer.scoring.registerUnderTrailerExitCallback(underTrailerExitCallback)
  local function update()
    if params.timer then
      if params.bufferTime and bufferStart and under then
        bufferStart = nil
      elseif params.bufferTime and bufferStart and g_NetworkTime - bufferStart >= params.bufferTime then
        if feedback then
          feedback(0)
        end
        bufferStart = nil
        underTime = nil
        totalTimeOut = 0
      end
      if params.bufferTime then
        if bufferStart and not under then
          underTime = bufferStart - startTime - totalTimeOut
        elseif under then
          underTime = g_NetworkTime - startTime - totalTimeOut
        end
      elseif under then
        underTime = g_NetworkTime - startTime
      end
      if underTime then
        if feedback then
          feedback(underTime)
        end
        goalConditionsMet = underTime >= params.timer
      end
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    localPlayer.scoring.unregisterUnderTrailerCallback(underTrailerCallback)
    localPlayer.scoring.unregisterUnderTrailerExitCallback(underTrailerExitCallback)
  end
  return update, cleanup
end)
local distInAirStunt = {
  stuntText = "ID:243808",
  stuntTextValue = nil,
  stuntSlotPass = nil,
  stuntFail = false
}
goalSystem.registerGoal("Is jumping", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local distance = 0
  local jumping = false
  local startDist
  if params.centralFeedback then
    scoringSystem.SetDareJumpBarProgression(localPlayer.localID, true, 1, false)
    scoringSystem.UpdateJumpStuntText = true
  end
  local function update()
    goalConditionsMet = false
    if params.centralFeedback then
      if not jumping and localPlayer.scoring.isJumping then
        startDist = localPlayer.scoring:getTotalAirTimeDistance()
        jumping = true
      elseif jumping and not localPlayer.scoring.isJumping then
        distInAirStunt.stuntSlotPass = 2
        distInAirStunt.stuntFail = false
        distInAirStunt.stuntTextValue = localPlayer.scoring:getTotalAirTimeDistance() - startDist
        distInAirStunt.stuntHide = false
        feedbackSystem.updateStuntFeedback(distInAirStunt)
        distInAirStunt.stuntSlotPass = nil
        jumping = false
        goalConditionsMet = true
      end
    end
    if not params.centralFeedback and localPlayer.scoring.isJumping then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      if params.centralFeedback then
        OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
        scoringSystem.UpdateJumpStuntText = false
      end
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    scoringSystem.UpdateJumpStuntText = false
    distInAirStunt.stuntSlotPass = nil
    distInAirStunt.stuntFail = true
    distInAirStunt = {
      stuntText = "ID:243808",
      stuntTextValue = nil,
      stuntSlotPass = nil,
      stuntFail = true
    }
    scoringSystem.SetDareJumpBarProgression(localPlayer.localID, false, 1, false)
  end
  return update, cleanup
end)
goalSystem.registerGoal("Has jumped x meters", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local isCurrentlyJumping = false
  local minimumJumpDistance = params.minimum or 0
  local currentDistance = localPlayer.scoring:getTotalAirTimeDistance()
  local jumpDistance
  return function()
    goalConditionsMet = false
    if localPlayer.scoring.isJumping and isCurrentlyJumping == false then
      isCurrentlyJumping = true
    elseif not localPlayer.scoring.isJumping and isCurrentlyJumping == true then
      jumpDistance = localPlayer.scoring:getTotalAirTimeDistance() - currentDistance
      if jumpDistance >= minimumJumpDistance then
        if params.inverse then
          if jumpDistance < params.value then
            goalConditionsMet = true
          end
        elseif jumpDistance >= params.value then
          goalConditionsMet = true
        end
      end
      currentDistance = localPlayer.scoring:getTotalAirTimeDistance()
      isCurrentlyJumping = false
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
goalSystem.registerGoal("Player jumped or landed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local lastJumpState = localPlayer.scoring.isJumping
  local goalConditionsMet = false
  return function()
    if params.transition then
      if params.transition == "jumping" then
        if not lastJumpState and localPlayer.scoring.isJumping then
          goalConditionsMet = true
        end
      elseif params.transition == "landing" and lastJumpState and not localPlayer.scoring.isJumping then
        goalConditionsMet = true
      end
    elseif localPlayer.scoring.isJumping ~= lastJumpState then
      goalConditionsMet = true
    end
    lastJumpState = localPlayer.scoring.isJumping
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Score jump distance", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local startTotal = localPlayer.scoring:getTotalAirTimeDistance()
  local currentTotal
  local score = 0
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    currentTotal = localPlayer.scoring:getTotalAirTimeDistance()
    if currentTotal > startTotal then
      score = currentTotal - startTotal
      goalConditionsMet = true
      if params.scoreMultiplier then
        score = score * params.scoreMultiplier
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Player jumped a distance of in mid air", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local jumpLength = params.value or 1
  local currentTotal = 0
  local goalConditionsMet = false
  scoringSystem.AddJumpScoringCallback = params.value or 1
  return function()
    goalConditionsMet = false
    if localPlayer.scoring.isJumping then
      if localPlayer.scoring:getCurrentAirTimeDistance() > jumpLength then
        goalConditionsMet = true
      end
    elseif not localPlayer.scoring.isJumping then
      localPlayer.scoring.distanceCovered = 0
      localPlayer.scoring:resetCurrentAirTimeDistance()
      localPlayer.scoring.heightCovered = 0
      localPlayer.scoring:resetCurrentAirTimeHeight()
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Failed jump", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local startTotal = localPlayer.scoring:getTotalDriftDistance()
  local goalConditionsMet = false
  local jumpStarted = false
  return function()
    goalConditionsMet = false
    if localPlayer.scoring.isJumping and localPlayer.scoring:getCurrentAirTimeDistance() > params.startTrigger and not jumpStarted then
      jumpStarted = true
    end
    if jumpStarted and not localPlayer.scoring.isJumping then
      jumpStarted = false
      if localPlayer.scoring:getCurrentAirTimeDistance() == 0 then
        goalConditionsMet = true
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
goalSystem.registerGoal("Is drifting", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  scoringSystem.AddDriftScoringCallback = params.value or 1
  return function()
    goalConditionsMet = false
    if not params.value then
      if localPlayer.scoring.isDrifting then
        goalConditionsMet = true
      end
    elseif localPlayer.scoring.isDrifting and localPlayer.scoring:getCurrentDriftDistance() >= params.value then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if feedback and localPlayer.scoring.isDrifting then
      feedback(true)
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
      scoreSystem.RemoveDriftScoringCallback = goalDistance
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Has drifted x meters", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local isCurrentlyDrifting = false
  local startDistance
  local minimumDriftDistance = params.minimum or 0
  scoringSystem.AddDriftScoringCallback = params.minimum or 1
  return function()
    goalConditionsMet = false
    if localPlayer.scoring.isDrifting and isCurrentlyDrifting == false then
      startDistance = localPlayer.scoring:getTotalDriftDistance()
      isCurrentlyDrifting = true
    elseif not localPlayer.scoring.isDrifting and isCurrentlyDrifting == true then
      if localPlayer.scoring:getTotalDriftDistance() - startDistance > minimumDriftDistance then
        if params.inverse then
          if localPlayer.scoring:getTotalDriftDistance() <= startDistance + params.value then
            goalConditionsMet = true
          end
        elseif localPlayer.scoring:getTotalDriftDistance() >= startDistance + params.value then
          goalConditionsMet = true
        end
      end
      isCurrentlyDrifting = false
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
      scoreSystem.RemoveDriftScoringCallback = goalDistance
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Score drift distance", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local startTotal = localPlayer.scoring:getTotalDriftDistance()
  local currentTotal
  local score = 0
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    currentTotal = localPlayer.scoring:getTotalDriftDistance()
    if currentTotal > startTotal then
      score = currentTotal - startTotal
      goalConditionsMet = true
      if params.scoreMultiplier then
        score = score * params.scoreMultiplier
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Failed drift", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local startTotal = localPlayer.scoring:getTotalDriftDistance()
  local goalConditionsMet = false
  local driftStarted = false
  return function()
    goalConditionsMet = false
    if localPlayer.scoring.isDrifting and localPlayer.scoring:getCurrentDriftDistance() > params.startTrigger and not driftStarted then
      driftStarted = true
    end
    if driftStarted and not localPlayer.scoring.isDrifting then
      driftStarted = false
      if localPlayer.scoring:getCurrentDriftDistance() == 0 then
        goalConditionsMet = true
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
goalSystem.registerGoal("Against traffic flow", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    if localPlayer.currentVehicle then
      goalConditionsMet = false
      if localPlayer.currentVehicle and (not scoreSystem.isPlayerOffRoad(2, localPlayer.localID) and not localPlayer.currentVehicle:get_withTrafficFlow() or isVehicleOnJunction(localPlayer.currentVehicle)) then
        goalConditionsMet = true
      end
      if params.inverse then
        goalConditionsMet = not goalConditionsMet
      end
      if feedback then
        feedback(goalConditionsMet)
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
goalSystem.registerGoal("Player had collision", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = localPlayer.scoring.scoringFreezeAfterCrash
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Simple collision check", function(operandA, operandB, UID, params, feedback)
  local goalConditionsMet = false
  local goalReportedSuccessful = false
  local previousVehicle
  local function collisionCheck(collisionData)
    goalConditionsMet = true
    if params.ignoreSpecifiedActor and collisionData.CollidedGameVehicle == operandA.instance.taskObjectsByActorID[params.ignoreSpecifiedActor].coreData.agent.gameVehicle then
      goalConditionsMet = false
    end
    if params.damage and collisionData.CollidedGameVehicle.damage < params.damage then
      goalConditionsMet = false
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if feedback then
      feedback(collisionData.Force)
    end
  end
  local callbackSettings = {
    callbackFunction = collisionCheck,
    minimumForce = params.force,
    whereIWasHit = params.whereIWasHit,
    whereIHit = params.whereIHit,
    typeOfHit = params.type,
    hitVehicleUID = params.modelID,
    copsOnly = params.copsOnly,
    localPlayerOnly = params.playerMustHitTarget
  }
  if params.mustHitTarget then
    callbackSettings.hitGameVehicle = operandB.gameVehicle
  elseif params.hitActor then
    if operandA.instance.taskObjectsByActorID[params.hitActor] then
      callbackSettings.hitGameVehicle = operandA.instance.taskObjectsByActorID[params.hitActor].coreData.agent.gameVehicle
    else
      print("WARNING: 'Simple collision check' goal created with params.hitActor set to an actor (" .. tostring(params.hitActor) .. ") that is not in the instance")
    end
  end
  if not params.setOnPlayer then
    operandA.agent:addCollisionCallback(callbackSettings)
  end
  local function update()
    if params.setOnPlayer and localPlayer.currentVehicle and localPlayer.currentVehicle ~= previousVehicle then
      if previousVehicle then
        previousVehicle:removeCollisionCallback(callbackSettings)
      end
      localPlayer.currentVehicle:addCollisionCallback(callbackSettings)
      previousVehicle = localPlayer.currentVehicle
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    if not params.setOnPlayer then
      operandA.agent:removeCollisionCallback(callbackSettings)
    elseif previousVehicle then
      previousVehicle:removeCollisionCallback(callbackSettings)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Is target ahead", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local angleComparison
  local angle = params.angle or 0.1
  return function()
    goalConditionsMet = false
    if params.usePlayer then
      angleComparison = operandA.agent.matrix[2]:dot(operandA.agent.position - localPlayer.currentVehicle.position:normalise())
    elseif params.targetsPerspective then
      angleComparison = operandB.matrix[2]:dot(operandB.position - operandA.agent.position:normalise())
    else
      angleComparison = operandA.agent.matrix[2]:dot(operandA.agent.position - operandB.position:normalise())
    end
    if angleComparison < angle then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Agent tipped over", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local angleComparison
  return function()
    goalConditionsMet = false
    if operandA.agent.matrix[1][1] < 0.5 then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Player using nitro", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local active = AbilityController.isAbilityActive("nitro")
  return function()
    goalConditionsMet = false
    if AbilityController.isAbilityActive("nitro") then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Player using ram", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if AbilityController.isAbilityActive("ram") then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Player successfully rammed a gameVehicle", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function playerRammedVehicle(gameVehicle)
    if gameVehicle then
      if params.actorID then
        if vehicleManager.vehiclesByGameVehicle[gameVehicle] == operandA.instance.taskObjectsByActorID[params.actorID].coreData.agent then
          print("__goalConditionsMet = true_______________________________________________________")
          goalConditionsMet = true
          abilities.ram.unregisterCallback()
        end
      else
        goalConditionsMet = true
        abilities.ram.unregisterCallback()
      end
    end
  end
  abilities.ram.registerCallback(playerRammedVehicle)
  local function update()
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
    goalConditionsMet = false
  end
  local cleanup = function()
    abilities.ram.unregisterCallback()
  end
  return update, cleanup
end)
goalSystem.registerGoal("Total successful rams above", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local startValue
  if params.thisInstance then
    startValue = ProfileSettings.GetNumRamHits()
  end
  return function()
    goalConditionsMet = false
    if params.thisInstance then
      if ProfileSettings.GetNumRamHits() - startValue >= params.value then
        goalConditionsMet = true
      end
    elseif ProfileSettings.GetNumRamHits() >= params.value then
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
goalSystem.registerGoal("Vehicles zapped into", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local startZaps = localPlayer:getNumberOfVehiclesZappedInto()
  local zapsRequired = params.value
  local numberOfVehiclesZappedInto = 0
  local currentVehicleUID, previousVehicleUID
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if localPlayer.currentVehicle then
      currentVehicleUID = localPlayer.currentVehicle.gameVehicle
      if not previousVehicleUID then
        previousVehicleUID = currentVehicleUID
      end
      local numberOfZapsDone = localPlayer:getNumberOfVehiclesZappedInto()
      if previousVehicleUID ~= currentVehicleUID then
        if numberOfZapsDone >= startZaps then
          numberOfVehiclesZappedInto = numberOfZapsDone - startZaps
          previousVehicleUID = currentVehicleUID
          falseZapCount = false
        elseif numberOfZapsDone < startZaps then
          startZaps = numberOfZapsDone
        end
      end
      if numberOfVehiclesZappedInto >= zapsRequired then
        goalConditionsMet = true
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
goalSystem.registerGoal("Player in zap transition", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = false
    if localPlayer.zapTransition == params.value then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Player in zap transition to level", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = false
    if zapcontroller.getTargetZapLevel() == params.level then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Zapped into vehicle", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local vehicleModel = vehicleModel
  return function()
    goalConditionsMet = false
    local playerVehicle = localPlayer.currentVehicle.gameVehicle.model_id
    if playerVehicle == params.value then
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
goalSystem.registerGoal("Changed vehicle", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local previousCurrentVehicle = localPlayer.currentVehicle
  return function()
    goalConditionsMet = false
    if previousCurrentVehicle ~= localPlayer.currentVehicle then
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
goalSystem.registerGoal("Payload over", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = false
    if operandA.networkVars.payload >= params.value then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.increment)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.increment)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Payload between", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local aboveLow = false
  local belowHigh = false
  return function()
    goalConditionsMet = false
    aboveLow = false
    belowHigh = false
    if operandA.networkVars.payload >= params.lowest then
      aboveLow = true
    end
    if operandA.networkVars.payload <= params.highest then
      belowHigh = true
    end
    if aboveLow and belowHigh then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.increment)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Payload under", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = false
    if operandA.networkVars.payload <= params.value then
      goalConditionsMet = true
    end
    if feedback then
      feedback(operandA.networkVars.payload)
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.increment)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Payload has decreased", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local previousValue = operandA.networkVars.payload
  local differenceToCheck = params.value or 0
  return function()
    goalConditionsMet = false
    if not params.inverse then
      if operandA.networkVars.payload < previousValue - differenceToCheck then
        goalConditionsMet = true
      else
        previousValue = operandA.networkVars.payload
      end
    elseif operandA.networkVars.payload > previousValue + differenceToCheck then
      goalConditionsMet = true
    else
      previousValue = operandA.networkVars.payload
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
goalSystem.registerGoal("Payload has changed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local previousValue = operandA.networkVars.payload
  return function()
    goalConditionsMet = false
    if operandA.networkVars.payload ~= previousValue then
      goalConditionsMet = true
      previousValue = operandA.networkVars.payload
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Change payload by amount", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local score = 0
  local goalConditionsMet = true
  local function update()
    goalConditionsMet = true
    if operandA.networkVars.payload and params.value then
      score = params.value or 0
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Set payload to specified value", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local score = 0
  local goalConditionsMet = true
  return function()
    goalConditionsMet = true
    if operandA.networkVars.payload then
      if params.same then
        score = 0
      elseif not failCondition then
        if params.percentageUp then
          score = operandA.networkVars.payload * params.percentageUp
        elseif params.percentageDown then
          score = 0 - operandA.networkVars.payload * params.percentageDown
        else
          score = params.value - operandA.networkVars.payload
        end
      elseif params.percentageUp then
        score = 0 - operandA.networkVars.payload * params.percentageUp
      elseif params.percentageDown then
        score = operandA.networkVars.payload * params.percentageDown
      else
        score = operandA.networkVars.payload - params.value
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Total team payload over", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    local totalTeamPayload = 0
    for k, v in next, operandA.instance.taskObjectsByActorID, nil do
      if v.coreData.actor.team == operandA.actor.team then
        totalTeamPayload = totalTeamPayload + v.taskList[1][1].networkVars.payload
      end
    end
    if totalTeamPayload >= params.value then
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
goalSystem.registerGoal("Is player controlled", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local target
  if params.target == "Target" then
    target = operandB
  else
    target = operandA.agent
  end
  local function update()
    goalConditionsMet = target.controlled
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Agent in zap", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function(number)
    goalConditionsMet = params.value == operandA.agent.inZap
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Instance time above", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local elapsedTime = 0
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    elapsedTime = g_NetworkTime - operandA.instance.networkVars.startTime
    if elapsedTime >= params.value then
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
goalSystem.registerGoal("Instance dynamic time above", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local startTime = operandA.instance.softsaveStartTime or operandA.instance.networkVars.startTime
  local elapsedTime
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    elapsedTime = g_NetworkTime - (startTime + 3)
    if elapsedTime >= operandA.instance.timeLimit then
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
goalSystem.registerGoal("Reached checkpoints by times", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local startTime = g_NetworkTime
  local elapsedTime
  local goalConditionsMet = false
  local checkpointTimes = params.checkpointTimes
  local currentCheckpoint
  return function()
    goalConditionsMet = false
    if not currentCheckpoint or currentCheckpoint < operandA.networkVars.checkpoints then
      currentCheckpoint = operandA.networkVars.checkpoints
      startTime = g_NetworkTime
    end
    if currentCheckpoint and checkpointTimes[currentCheckpoint] then
      elapsedTime = g_NetworkTime - startTime
      if elapsedTime >= checkpointTimes[currentCheckpoint] then
        goalConditionsMet = true
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
goalSystem.registerGoal("Player in zap", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local playerEnteredZapCount = 0
  local updateCount = true
  local hintChanged = false
  return function()
    goalConditionsMet = false
    if params.value == localPlayer.inZap then
      if params.numberOfTimes then
        if updateCount then
          playerEnteredZapCount = playerEnteredZapCount + 1
          updateCount = false
          if playerEnteredZapCount >= params.numberOfTimes then
            goalConditionsMet = true
          end
        end
      else
        goalConditionsMet = true
      end
    else
      updateCount = true
    end
    if params.objectiveID then
      if localPlayer.inZap and not hintChanged then
        dareSystem.setDareHint(false)
        hintChanged = true
      elseif not localPlayer.inZap and hintChanged then
        hintChanged = false
      end
    end
    if params.levelOfZap then
      if params.checkLevelType == "above" then
        if zapcontroller.getZapLevel() > params.levelOfZap then
          goalConditionsMet = true
        end
      elseif params.checkLevelType == "below" then
        if zapcontroller.getZapLevel() < params.levelOfZap then
          goalConditionsMet = true
        end
      elseif params.levelOfZap == zapcontroller.getZapLevel() then
        goalConditionsMet = true
      end
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Number of props smashed", function(operandA, operandB, UID, params, feedback)
  local props = props or 0
  local tableOfTargets = not tableOfTargets and {}
  local smashWatchAdded = false
  local goalConditionsMet = false
  local function propFindCallback(context, instance, region, lo, hi, vector)
    local target = Marker:create({
      type = "World",
      gadgetID = 16,
      radius = 100,
      visible = true,
      facing = true,
      colour = vec.vector(0, 255, 0, 255),
      position = vector + vec.vector(0, 4, 0, 0)
    })
    tableOfTargets[props] = {}
    tableOfTargets[props].target = target
    tableOfTargets[props].instance = instance
    tableOfTargets[props].region = region
    props = props + 1
    if context == 0 and props >= 10 then
      return false
    end
    return true
  end
  local goalReportedSuccessful = false
  local targetNumber = params.value
  local numberHit = 0
  local hitTarget = false
  local networkTime, previousNetworkTime, timeAllowance, delay
  local propsSmashed = {}
  if params.timer then
    previousNetworkTime = 0
    timeAllowance = params.timer
    delay = 1
  end
  local function maintainTable()
    for i, time in ipairs(propsSmashed) do
      if networkTime > time + timeAllowance then
        table.remove(propsSmashed, i)
      end
    end
    numberHit = #propsSmashed
  end
  local function propSmashCallback(context, gameVehicle, instance, region, lo, hi, vec)
    hitTarget = true
    if params.highlightTargets then
      for k, v in next, tableOfTargets, nil do
        if v.instance == instance then
          Marker:delete(v.target)
          tableOfTargets[k] = nil
          break
        end
      end
    end
  end
  if not goalReportedSuccessful then
    if propType[params.propData.name] then
      PropSystem.AddWatch(propSmashCallback, {
        name = params.propData.name
      })
      smashWatchAdded = true
      if params.highlightTargets then
        PropSystem.FindStaticProps(propFindCallback, {
          context = 1,
          name = params.propData.name,
          position = localPlayer.position,
          radius = 1000
        })
      end
    elseif propGroup[params.propData.name] then
      for k, v in next, propGroup[params.propData.name], nil do
        PropSystem.AddWatch(propSmashCallback, {name = v})
        smashWatchAdded = true
        if params.highlightTargets then
          PropSystem.FindStaticProps(propFindCallback, {
            context = 1,
            name = v,
            position = localPlayer.position,
            radius = 1000
          })
        end
      end
    end
  end
  local function update()
    networkTime = g_NetworkTime
    goalConditionsMet = false
    if hitTarget then
      hitTarget = false
      numberHit = numberHit + 1
      if params.timer then
        table.insert(propsSmashed, networkTime)
        maintainTable()
        previousNetworkTime = networkTime
      end
      print(numberHit)
      if params.value then
        if numberHit >= targetNumber then
          goalConditionsMet = true
        end
      else
        goalConditionsMet = true
      end
      if feedback then
        feedback(numberHit)
      end
    end
    if params.timer and networkTime >= previousNetworkTime + delay then
      maintainTable()
      if feedback then
        feedback(numberHit)
      end
      previousNetworkTime = networkTime
    end
    if goalConditionsMet and not goalReportedSuccessful then
      if params.highlightTargets then
        for i, target in next, tableOfTargets, nil do
          Marker:delete(target.target)
        end
        props = 0
        tableOfTargets = {}
      end
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
      PropSystem.RemoveWatch(propSmashCallback)
      smashWatchAdded = false
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    if params.highlightTargets then
      for k, v in next, tableOfTargets, nil do
        Marker:delete(v.target)
      end
      props = 0
      tableOfTargets = {}
    end
    if smashWatchAdded then
      PropSystem.RemoveWatch(propSmashCallback)
      smashWatchAdded = false
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Number of smashed", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if propSystem.getInitialPropCount(params.propGroup) - propSystem.getNumberRemainingProps(params.propGroup) >= params.value then
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
goalSystem.registerGoal("Smashed a prop", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local startPropCount = propSystem.getNumberRemainingProps(params.propGroup)
  return function()
    goalConditionsMet = false
    if startPropCount > propSystem.getNumberRemainingProps(params.propGroup) then
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
goalSystem.registerGoal("Accumulative number of props remaining", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    if propSystem.getAccumulativeNumberRemainingProps() == params.value then
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
goalSystem.registerGoal("Being sprayed by fire engine", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = true
  return function()
    local score = params.outRangeScore
    for actorID, taskObject in next, operandA.instance.taskObjectsByActorID, nil do
      if GameVehicleResource.getGunTarget(taskObject.coreData.agent.gameVehicle) == operandA.agent.gameVehicle.towedVehicle then
        score = params.inRangeScore
        break
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Is towing", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if params.usePlayer then
      if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle.towedVehicle then
        goalConditionsMet = true
      end
    elseif operandA.agent.gameVehicle.towedVehicle then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Being towed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if params.towedBy == "Player" then
      if operandA.agent.gameVehicle.towingVehicle == localPlayer.currentVehicle.gameVehicle then
        goalConditionsMet = true
      end
      if params.inverse then
        goalConditionsMet = not goalConditionsMet
      end
    else
      if operandA.agent.gameVehicle.towingVehicle then
        goalConditionsMet = true
      end
      if params.inverse then
        goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Target being towed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if operandB.gameVehicle.towingVehicle then
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
goalSystem.registerGoal("All targets being towed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = true
    for k, target in next, operandA.dynamicTargets, nil do
      if not target.gameVehicle.towingVehicle then
        goalConditionsMet = false
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
goalSystem.registerGoal("Agent being towed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if operandA.instance.taskObjectsByActorID[params.agentName] and operandA.instance.taskObjectsByActorID[params.agentName].coreData.agent.gameVehicle.towingVehicle then
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
goalSystem.registerGoal("Player zap status has changed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local lastStateZap = localPlayer.inZap
  local goalConditionsMet = false
  return function()
    if params.transition then
      if params.transition == "into" then
        if not lastStateZap and localPlayer.inZap then
          goalConditionsMet = true
        end
      elseif params.transition == "out" and lastStateZap and not localPlayer.inZap then
        goalConditionsMet = true
      end
    elseif localPlayer.inZap ~= lastStateZap then
      goalConditionsMet = true
    end
    lastStateZap = localPlayer.inZap
    if goalConditionsMet and not goalReportedSuccessful then
      accumTime = 0
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Local player entered zap", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local currentVehicle = localPlayer.currentVehicle
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if currentVehicle then
      goalConditionsMet = currentVehicle ~= localPlayer.currentVehicle
    else
      currentVehicle = localPlayer.currentVehicle
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
goalSystem.registerGoal("No props attached", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = true
  local targetTable = {
    vehicle = operandA.agent.gameVehicle
  }
  return function()
    goalConditionsMet = PropSystem.GetEffectiveNoOfAttachedProps(targetTable) == 0
    if goalConditionsMet and not goalReportedSuccessful then
      print("goalConditionsMet is true for No props attached")
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("No props attached (target)", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = true
  local function alterGoalCondition()
    goalConditionsMet = false
  end
  local targetTable = {
    vehicle = operandB.gameVehicle
  }
  PropSystem.FindAttachedProps(alterGoalCondition, targetTable)
  return function()
    goalConditionsMet = PropSystem.GetEffectiveNoOfAttachedProps(targetTable) == 0
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("In mission vehicle", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if localPlayer.currentVehicle:getTaskObject() then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Player within radius of point", function(operandA, operandB, UID, params, feedback)
  local relativeDistance
  local goalReportedSuccessful = false
  local playerVehicle = localPlayer.currentVehicle
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if localPlayer.currentVehicle and localPlayer.currentVehicle.controlled and params.position then
      vehiclePosLast = getLastKnownPosition(localPlayer.currentVehicle)
      vehiclePos = setLastKnownPosition(localPlayer.currentVehicle, localPlayer.currentVehicle.position)
      targetPosLast = getLastKnownPosition(params)
      targetPos = setLastKnownPosition(params, params.position)
      if GameVehicleResource.withinSweptRadius(vehiclePos, vehiclePosLast, targetPos, targetPosLast, params.value) then
        goalConditionsMet = true
        if feedback then
          feedback(closestPosition)
        end
      elseif feedback then
        feedback(nil)
      end
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      if params.addValue then
        local score
        if cardSystem.carValues and cardSystem.carValues[localPlayer.currentVehicle.model_id] then
          score = round(cardSystem.carValues[localPlayer.currentVehicle.model_id] * (1 - localPlayer.currentVehicle.damage), 2)
        else
          score = round(20000 * (1 - localPlayer.currentVehicle.damage), 2)
        end
        goalSystem.callbackHandler(UID, score)
      elseif params.increment then
        goalSystem.callbackHandler(UID, params.increment)
      else
        goalSystem.callbackHandler(UID)
      end
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Vehicle is in alley", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = false
    goalConditionsMet = operandA.agent:get_onMainRoad() == false
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.increment)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("In cutscene", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = localPlayer.inCutscene
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("In cutscene or icam", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = localPlayer.inCutsceneOrIcam
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Event active", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = isEventActive()
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Prompt active", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    if params.promptType == "Primary" then
      goalConditionsMet = feedbackSystem.menusMaster.primaryPromptActive
    elseif params.promptType == "Secondary" then
      goalConditionsMet = feedbackSystem.menusMaster.secondaryPromptActive
    elseif params.promptType == "PrimaryAndSecondary" then
      goalConditionsMet = feedbackSystem.menusMaster.primaryAndSecondaryPromptActive
    elseif params.promptType == "MiniMap" then
      goalConditionsMet = feedbackSystem.menusMaster.minimapPromptActive
    elseif params.promptType == "StuntPrompt" then
      goalConditionsMet = feedbackSystem.menusMaster.stuntFeedbackActive
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Actor in front of vehicle along route", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if RaceManager.GetRacerPosition(operandA.instance.raceId, operandA.instance.taskObjectsByActorID[params.actor].coreData.agent.gameVehicle) == params.position then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Team member above race position", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local racerPosition, playerControlCheck
  return function()
    goalConditionsMet = false
    for k, v in next, operandA.instance.taskObjectsByActorID, nil do
      if operandA.actor.team == v.coreData.actor.team then
        playerControlCheck = not params.controlled or params.controlled and v.coreData.agent.controlled
        if playerControlCheck then
          racerPosition = RaceManager.GetRacerPosition(v.coreData.instance.raceId, v.coreData.agent.gameVehicle)
          if racerPosition <= params.value and not params.inverse then
            goalConditionsMet = true
            break
          elseif racerPosition >= params.value and params.inverse then
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
end)
goalSystem.registerGoal("Team member slipped race position", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local inFromPosition = false
  return function()
    for k, v in next, operandA.instance.taskObjectsByActorID, nil do
      if operandA.actor.team == v.coreData.actor.team and not v.coreData.agent.controlled then
        racerPosition = RaceManager.GetRacerPosition(v.coreData.instance.raceId, v.coreData.agent.gameVehicle)
        if racerPosition == params.fromPosition and not inFromPosition then
          inFromPosition = true
          goalConditionsMet = false
        elseif racerPosition == params.toPosition and inFromPosition then
          inFromPosition = false
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
goalSystem.registerGoal("Specified actors in mission", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = true
  return function()
    goalConditionsMet = true
    for k, actorID in next, params.actorIDs, nil do
      if not operandA.instance.taskObjectsByActorID[actorID] then
        goalConditionsMet = false
        break
      end
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Specified actors have finished race", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    local finishedCount = 0
    for index, actorName in next, params.actors, nil do
      if operandA.instance.taskObjectsByActorID[actorName] and operandA.instance.taskObjectsByActorID[actorName].coreData.raceFinished then
        finishedCount = finishedCount + 1
      end
    end
    if finishedCount >= params.value then
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
goalSystem.registerGoal("Player vehicle damage above", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = params.value <= localPlayer.currentVehicle.damage
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
goalSystem.registerGoal("Player vehicle damage below", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = params.value > localPlayer.currentVehicle.damage
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
goalSystem.registerGoal("Player on pavement", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = scoreSystem.isPlayerOffRoad(2, localPlayer.localID)
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Agent in oncoming traffic", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if not operandA.agent:get_withTrafficFlow() and isVehicleOnJunction(operandA.agent) then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("x targets remaining", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local desiredCount = params.value
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if #operandA.dynamicTargets == desiredCount then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Within locked area", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local score
  local goalConditionsMet = false
  local target
  if params.target == "Player" then
    target = localPlayer.currentVehicle
  elseif params.target == "Actor" then
    target = operandA.instance.taskObjectsByActorID[params.actorID].coreData.agent
  else
    target = operandA.agent
  end
  local function update()
    goalConditionsMet = zap.vehicleInLockedArea(target.position)
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Agent distance from target", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local score
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = GameVehicleResource.withinRadius(operandA.agent.position, operandB.position, params.value)
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update
end)
goalSystem.registerGoal("Game has stopped spooling", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = not spoolsystem.IsStalled()
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Actor is in major order", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    if operandA.instance.taskObjectsByActorID[params.actorID] then
      local majorOrder = #operandA.instance.taskObjectsByActorID[params.actorID].taskList
      for k, v in next, params.value, nil do
        if majorOrder == v then
          goalConditionsMet = true
          break
        end
      end
      if params.inverse then
        goalConditionsMet = not goalConditionsMet
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
  return update
end)
goalSystem.registerGoal("Actor has passed checkpoint number", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    if operandA.networkVars.checkpoints > params.value then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("In back of truck", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local target
  return function()
    goalConditionsMet = false
    if params.target == "Target" then
      target = operandB
    else
      target = operandA.agent
    end
    if target.inTrailer then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Player using zap return", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = localPlayer.zapReturning
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Player teleporting", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = localPlayer.teleporting
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Player has jumped off a vehicle", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local timeAllowance = params.timer
  local previousNetworkTime = 0
  local delay = 1
  local count = 0
  localPlayer.scoring.setMinimumJumpOffRelativeSpeed(10)
  local vehiclesJumped = {}
  local highlightedVehicles
  local pointsParams = {
    pointsText = "+" .. tostring(1),
    pointsSlotPass = 2
  }
  if params.highlight then
    minimap.SetHighlightedVehicles(true)
    if params.inVehicleID then
      highlightedVehicles = params.inVehicleID
    elseif params.vehicleID then
      highlightedVehicles = params.vehicleID
    end
    for index, modelID in next, highlightedVehicles, nil do
      local vehicles = {
        {VehicleModelUID = modelID, AllowTowedVehicles = true}
      }
      minimap.AddHighlightedVehicleModelUIDs(vehicles)
    end
  end
  local function jumped(jumpInfo)
    local allowed = true
    if params.modelID then
      allowed = false
      for k, v in next, params.modelID, nil do
        if v == jumpInfo.VehicleID then
          allowed = true
          break
        end
      end
    end
    if allowed and params.inModelID then
      allowed = false
      for k, v in next, params.inModelID, nil do
        if v == localPlayer.currentVehicle.gameVehicle.model_id then
          allowed = true
          break
        end
      end
    end
    if allowed and not vehiclesJumped[localPlayer.currentVehicle.gameVehicle] then
      local id = localPlayer.currentVehicle.gameVehicle
      vehiclesJumped[id] = g_NetworkTime
      count = 0
      for k, v in next, vehiclesJumped, nil do
        count = count + 1
        if params.centralFeedback then
          OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
          feedbackSystem.updatePointsFeedback(pointsParams)
        end
      end
    end
  end
  localPlayer.scoring.registerJumpOffVehicleCallback(jumped)
  local function update()
    if localPlayer.currentVehicle then
      if feedback then
        feedback(count)
      end
      if timeAllowance and g_NetworkTime >= previousNetworkTime + delay then
        previousNetworkTime = g_NetworkTime
      end
      goalConditionsMet = count >= (params.value or 1)
      if goalConditionsMet and not goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = true
      elseif not goalConditionsMet and goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = false
      end
    end
  end
  local function cleanup()
    vehiclesJumped = {}
    minimap.RemoveAllHighlightedVehicleModelUIDs()
    minimap.SetHighlightedVehicles(false)
    localPlayer.scoring.unregisterJumpOffVehicleCallback(jumped)
  end
  return update, cleanup
end)
goalSystem.registerGoal("Player riding a vehicle", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local allowed = true
  local riding = false
  local startTime = 0
  local endTime = 0
  local rideTime = 0
  local vehicleBeingRiden
  local function ridingStarted(ridingInfo)
    allowed = true
    if params.modelID then
      allowed = false
      for k, v in next, params.modelID, nil do
        if v == ridingInfo.VehicleID then
          allowed = true
          break
        end
      end
    end
    if allowed and params.inModelID then
      allowed = false
      for k, v in next, params.inModelID, nil do
        if v == localPlayer.currentVehicle.gameVehicle.model_id then
          allowed = true
          break
        end
      end
    end
    if allowed then
      if params.parked then
        vehicleBeingRiden = ridingInfo.GameVehicle
      end
      startTime = g_NetworkTime
      riding = true
      endTime = nil
    end
  end
  local function ridingEnded(ridingInfo)
    if allowed then
      endTime = g_NetworkTime
      riding = false
      vehicleBeingRiden = nil
    end
    if endTime - startTime < params.value then
      OneShotSound.Play("HUD_Gen_Currency_Fail", false)
    end
  end
  localPlayer.scoring.registerRidingCarStartedCallback(ridingStarted)
  localPlayer.scoring.registerRidingCarEndedCallback(ridingEnded)
  local function update()
    if localPlayer.currentVehicle then
      goalConditionsMet = false
      if feedback then
        if riding then
          if params.parked and vehicleBeingRiden and math.abs(localPlayer.currentVehicle.speed - vehicleBeingRiden.speed) > params.parked then
            startTime = g_NetworkTime
          end
          rideTime = g_NetworkTime - startTime
          feedback(rideTime)
        else
          feedback(0)
        end
      end
      goalConditionsMet = rideTime >= params.value
      if goalConditionsMet and not goalReportedSuccessful then
        OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = true
      elseif not goalConditionsMet and goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = false
      end
    end
  end
  local function cleanup()
    if not goalConditionsMet and riding then
      OneShotSound.Play("HUD_Gen_Currency_Fail", false)
    end
    localPlayer.scoring.unregisterRidingCarStartedCallback(ridingStarted)
    localPlayer.scoring.unregisterRidingCarEndedCallback(ridingEnded)
  end
  return update, cleanup
end)
goalSystem.registerGoal("Player has barrel rolled", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function barrelRollCallback()
    goalConditionsMet = true
  end
  localPlayer.scoring.registerBarrelRollCallback(barrelRollCallback)
  return function()
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end, function()
    localPlayer.scoring.unregisterBarrelRollCallback(barrelRollCallback)
  end
end)
goalSystem.registerGoal("Player has performed a burnout", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function burnOutCallback(burnOutInfo)
    if burnOutInfo.burnoutTime >= params.time then
      goalConditionsMet = true
    end
  end
  localPlayer.scoring.registerBurnOutCallback(burnOutCallback)
  return function()
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end, function()
    localPlayer.scoring.unregisterBurnOutCallback(burnOutCallback)
  end
end)
goalSystem.registerGoal("Player has performed a reverse 180", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function jTurnCallback(jTurnInfo)
    if jTurnInfo.totalAngleChange >= 2 and jTurnInfo.totalAngleChange <= 3.5 or jTurnInfo.totalAngleChange <= -2 and jTurnInfo.totalAngleChange >= -3.5 then
      goalConditionsMet = true
    end
  end
  localPlayer.scoring.registerJTurnCallback(jTurnCallback)
  return function()
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end, function()
    localPlayer.scoring.unregisterJTurnCallback(jTurnCallback)
  end
end)
goalSystem.registerGoal("Player has performed a handbrake turn", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function handbrakeTurnCallback(handbrakeTurnInfo)
    if handbrakeTurnInfo.angleTurned >= params.angle or handbrakeTurnInfo.angleTurned <= params.angle * -1 then
      goalConditionsMet = true
    end
  end
  localPlayer.scoring.registerHandbrakeTurnCallback(handbrakeTurnCallback)
  return function()
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end, function()
    localPlayer.scoring.unregisterHandbrakeTurnCallback(handbrakeTurnCallback)
  end
end)
goalSystem.registerGoal("Player has spun X degrees", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function spinTurnCallback(spinInfo)
    if spinInfo.angleTurned_0 >= params.angle then
      goalConditionsMet = true
    end
  end
  localPlayer.scoring.registerSpinTurnCallback(spinTurnCallback)
  return function()
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end, function()
    localPlayer.scoring.unregisterSpinTurnCallback(spinTurnCallback)
  end
end)
goalSystem.registerGoal("Player jumped over a vehicle", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local correctCameraModeOnJumpStart = false
  local count = 0
  local times = {}
  local pointsParams = {
    pointsText = "+" .. tostring(1),
    pointsSlotPass = 2
  }
  local function maintainTable()
    for k, v in next, times, nil do
      if g_NetworkTime - v > params.timer then
        table.remove(times, k)
        count = count - 1
      end
    end
  end
  local function jumpedOverCallback(jumpInfo)
    local allowed = true
    if allowed and params.inModelID then
      allowed = false
      for k, v in next, params.inModelID, nil do
        if v == localPlayer.currentVehicle.gameVehicle.model_id then
          allowed = true
          break
        end
      end
    end
    if allowed and jumpInfo.VehicleID and jumpInfo.VehicleID ~= 298 then
      if params.value then
        count = count + 1
        if params.centralFeedback then
          print("params.centralFeedback 1")
          OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
          feedbackSystem.updatePointsFeedback(pointsParams)
        end
        if params.timer then
          table.insert(times, g_NetworkTime)
        end
        goalConditionsMet = count >= params.value
      elseif not params.inCameraMode or correctCameraModeOnJumpStart and isInCorrectCameraMode(params.inCameraMode) then
        if params.centralFeedback then
          print("params.centralFeedback 2")
          OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
          feedbackSystem.updatePointsFeedback(pointsParams)
        end
        goalConditionsMet = true
      end
    end
  end
  localPlayer.scoring.registerVehicleJumpedStartCallback(jumpedOverCallback)
  return function()
    if localPlayer.currentVehicle then
      if localPlayer.scoring.isJumping then
        if params.inCameraMode and not correctCameraModeOnJumpStart then
          correctCameraModeOnJumpStart = isInCorrectCameraMode(params.inCameraMode)
        end
      else
        correctCameraModeOnJumpStart = false
      end
      if params.timer then
        maintainTable()
      end
      if feedback then
        feedback(count)
      end
      if goalConditionsMet and not goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = true
      elseif not goalConditionsMet and goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = false
      end
    end
  end, function()
    localPlayer.scoring.unregisterVehicleJumpedStartCallback(jumpedOverCallback)
  end
end)
goalSystem.registerGoal("Drive x vehicles under a trailer", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local previousTime = 0
  local underCount = 0
  local vehcicleList = {}
  local highlightedVehicles
  local pointsParams = {
    pointsText = "+" .. tostring(1),
    pointsSlotPass = 2
  }
  local inZap
  local trailerModels = {285, 286}
  local arrowMarkers = {
    {
      facing = false,
      gadgetID = 78,
      scale = vec.vector(0.3, 0.3, 0.3, 0),
      matrixOffset = vec.matrix(-4.371139E-08, 0, 1, 0, 0, 1, 0, 0, -1, 0, -4.371139E-08, 0, -1.4, -0.5, -4.5, 1),
      visible = true,
      colour = vec.vector(246, 196, 14, 255)
    },
    {
      facing = false,
      gadgetID = 78,
      scale = vec.vector(0.3, 0.3, 0.3, 0),
      matrixOffset = vec.matrix(4.371139E-08, 0, -1, 0, 0, 1, 0, 0, 1, 0, 4.371139E-08, 0, -1.65, -0.5, 4.5, 1),
      visible = true,
      colour = vec.vector(246, 196, 14, 255)
    },
    {
      facing = false,
      gadgetID = 78,
      scale = vec.vector(0.3, 0.3, 0.3, 0),
      matrixOffset = vec.matrix(-4.371139E-08, 0, 1, 0, 0, 1, 0, 0, -1, 0, -4.371139E-08, 0, 1.65, -0.5, -4.5, 1),
      visible = true,
      colour = vec.vector(246, 196, 14, 255)
    },
    {
      facing = false,
      gadgetID = 78,
      scale = vec.vector(0.3, 0.3, 0.3, 0),
      matrixOffset = vec.matrix(4.371139E-08, 0, -1, 0, 0, 1, 0, 0, 1, 0, 4.371139E-08, 0, 1.5, -0.5, 4.5, 1),
      visible = true,
      colour = vec.vector(246, 196, 14, 255)
    }
  }
  local function turnOnHighlight()
    if params.highlight then
      minimap.SetHighlightedVehicles(true)
      if params.inVehicleID then
        highlightedVehicles = params.inVehicleID
      elseif params.vehicleID then
        highlightedVehicles = params.vehicleID
      end
      for index, modelID in next, highlightedVehicles, nil do
        local vehicles = {
          {VehicleModelUID = modelID}
        }
        minimap.AddHighlightedVehicleModelUIDs(vehicles)
      end
    end
    if params.markerArrows then
      minimap.UnderTrailerArrowsSetModelRadius(123, 150, arrowMarkers)
    end
  end
  local function turnOffHighlight()
    if params.highlight then
      minimap.RemoveAllExcludedFromHighlights()
      minimap.RemoveAllHighlightedVehicleModelUIDs()
      minimap.SetHighlightedVehicles(false)
    end
    if params.markerArrows then
      minimap.UnderTrailerArrowsSetModelRadius()
    end
  end
  local function checkForTrailer()
    if localPlayer.currentVehicle then
      local inTrailer = false
      for index, model in next, trailerModels, nil do
        if localPlayer.currentVehicle.gameVehicle.model_id == model then
          inTrailer = true
          break
        end
      end
      if inTrailer and inZap then
        minimap.AddVehicleToExcludeFromHighlights(localPlayer.currentVehicle.gameVehicle.childVehicle)
        minimap.UnderTrailerArrowsExcludeGameVehicle(localPlayer.currentVehicle.gameVehicle)
      elseif not inTrailer and inZap then
        turnOnHighlight()
      end
    end
  end
  inZap = true
  checkForTrailer()
  inZap = localPlayer.inZap
  local function maintainTable()
    for k, v in next, vehcicleList, nil do
      if g_NetworkTime > v + params.timer then
        vehcicleList[k] = nil
        underCount = underCount - 1
      end
    end
  end
  local function underTrailerCallback(callbackInfo)
    if not vehcicleList[localPlayer.currentVehicle.gameVehicle] then
      underCount = underCount + 1
      vehcicleList[localPlayer.currentVehicle.gameVehicle] = g_NetworkTime
      if params.centralFeedback then
        OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
        feedbackSystem.updatePointsFeedback(pointsParams)
      end
    end
    if underCount >= params.value then
      goalConditionsMet = true
    end
  end
  localPlayer.scoring.registerUnderTrailerCallback(underTrailerCallback)
  local function update()
    if params.highlight then
      if inZap and not localPlayer.inZap then
        checkForTrailer()
        inZap = false
      elseif not inZap and localPlayer.inZap then
        minimap.RemoveAllExcludedFromHighlights()
        turnOnHighlight()
        inZap = true
      end
    end
    if localPlayer.currentVehicle then
      if feedback then
        feedback(underCount)
      end
      if params.timer and g_NetworkTime >= previousTime + 0.5 then
        maintainTable()
        previousTime = g_NetworkTime
      end
      if goalConditionsMet and not goalReportedSuccessful then
        if marker then
          feedbackSystem.clearTarget(marker)
          marker = nil
        end
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = true
      elseif not goalConditionsMet and goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = false
      end
    end
  end
  local function cleanup()
    if params.markerArrows then
      minimap.UnderTrailerArrowsSetModelRadius()
    end
    minimap.RemoveAllHighlightedVehicleModelUIDs()
    minimap.SetHighlightedVehicles(false)
    localPlayer.scoring.unregisterUnderTrailerCallback(underTrailerCallback)
    localPlayer.scoring.unregisterUnderTrailerExitCallback(underTrailerExitCallback)
  end
  return update, cleanup
end)
goalSystem.registerGoal("Agent on highway", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    local playerRoad
    if params.usePlayer then
      playerRoad = localPlayer:get_closestRoadIndex()
    else
      playerRoad = operandA.agent:get_closestRoadIndex()
    end
    goalConditionsMet = Atlas.IsRoadAHighway(playerRoad)
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.increment)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Number of team members remaining", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local team = params.team or operandA.actor.team
  local function update()
    local count = 0
    for actorID, taskObject in next, operandA.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team == team and taskObject.coreData.agent.gameVehicle.damage < 1 then
        count = count + 1
      end
    end
    count = params.dontIncludeSelf and count - 1 or count
    if count == params.value then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Current vehicle height is less than", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    if localPlayer.currentVehicle then
      if localPlayer.currentVehicle.gameVehicle.height < params.value then
        goalConditionsMet = true
      end
      if params.inverse then
        goalConditionsMet = not goalConditionsMet
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
  return update
end)
goalSystem.registerGoal("Ghost vehicle collision", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function ghostCallback()
    goalConditionsMet = true
  end
  GhostCar.Settings({callback = ghostCallback})
  return function()
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.increment)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Player outside then within radius of target", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local outRadius = false
  return function()
    goalConditionsMet = false
    if params.player then
      vehiclePosLast = getLastKnownPosition(localPlayer.currentVehicle)
      vehiclePos = setLastKnownPosition(localPlayer.currentVehicle, localPlayer.currentVehicle.position)
    else
      vehiclePosLast = getLastKnownPosition(operandA.agent)
      vehiclePos = setLastKnownPosition(operandA.agent, operandA.agent.position)
    end
    inRadiusCurrent = false
    for index, target in next, operandA.dynamicTargets, nil do
      targetPosLast = getLastKnownPosition(target)
      targetPos = setLastKnownPosition(target, target.position)
      if GameVehicleResource.withinSweptRadius(vehiclePos, vehiclePosLast, targetPos, targetPosLast, params.value) then
        inRadiusCurrent = true
        break
      end
    end
    if not outRadius and not inRadiusCurrent then
      outRadius = true
    end
    if outRadius and inRadiusCurrent then
      goalConditionsMet = true
      outRadius = false
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.increment)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("GoalConditions empty", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local goalData = goalSystem.activeGoals[UID]
  local condition = getmetatable(goalData)
  return function()
    goalConditionsMet = true
    for conditionType, conditions in next, goalSystem.taskSupport.registeredObjects[condition.__index.object], nil do
      if goalConditionsMet and conditionType ~= "taskCompletionConditions" then
        for i, condition in ipairs(conditions) do
          if condition.active then
            goalConditionsMet = false
            break
          end
        end
      else
        break
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.increment)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Change payload multiplyers", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    if operandA.networkVars.upMultiplyer ~= params.upMultiplyer then
      operandA.networkVars.upMultiplyer = params.upMultiplyer
    end
    if operandA.networkVars.downMultiplyer ~= params.downMultiplyer then
      operandA.networkVars.downMultiplyer = params.downMultiplyer
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, nil)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Car park brake test", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local playerReachedSpeed = false
  local speedTime = false
  local percentageFraction = params.percent / 100
  local reducedSpeedValue = 0
  local newReducedSpeedValue = 0
  local crashed = false
  local function collisionCheck(collisionData)
    crashed = true
  end
  local callbackSettings = {callbackFunction = collisionCheck, minimumForce = 1000}
  operandA.agent:addCollisionCallback(callbackSettings)
  local function update()
    goalConditionsMet = false
    local speed = operandA.agent.speed * 2.236
    if speed > params.speedAbove and not playerReachedSpeed then
      reducedSpeedValue = speed * (1 - percentageFraction)
      playerReachedSpeed = true
      speedTime = g_NetworkTime
    end
    if speedTime and crashed then
      playerReachedSpeed = false
      speedTime = false
      reducedSpeedValue = 0
      newReducedSpeedValue = 0
      crashed = false
    end
    if speed < reducedSpeedValue then
      if speedTime and g_NetworkTime < speedTime + params.timeForChange and not crashed then
        goalConditionsMet = true
      else
        playerReachedSpeed = false
        speedTime = false
        reducedSpeedValue = 0
      end
    elseif speed > params.speedAbove then
      newReducedSpeedValue = speed * (1 - percentageFraction)
      if newReducedSpeedValue > reducedSpeedValue then
        reducedSpeedValue = newReducedSpeedValue
        speedTime = g_NetworkTime
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
  local function cleanup()
    operandA.agent:removeCollisionCallback(callbackSettings)
  end
  return update, cleanup
end)
goalSystem.registerGoal("Performed slalom in car park", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local pillarData = params.pillars
  local timeLimit = params.timeLimit or 3
  local previousPlayerPosition = operandA.agent.position
  local lineCrossedTime = false
  local triggeredSlalom = false
  local currentGate
  local slalomDirection = "north"
  local pillarCollection = false
  local completedGates = 2
  local upVector = vec.vector(0, 1, 0, 0)
  local function withinLineBounds(pillarA, pillarB)
    local boundryLine = pillarB - pillarA:normalise()
    local lowerBoundAngleComparison = operandA.agent.position - pillarA:normalise():dot(boundryLine)
    local upperBoundAngleComparison = operandA.agent.position - pillarB:normalise():dot(boundryLine)
    if lowerBoundAngleComparison < 0 and upperBoundAngleComparison > 0 or lowerBoundAngleComparison > 0 and upperBoundAngleComparison < 0 then
      return true
    else
      return false
    end
  end
  local function hasCrossedLine(pillarA, pillarB)
    local lineToCross = pillarB - pillarA:normalise():cross(upVector)
    local previousLocationAngleComparison = previousPlayerPosition - pillarA:normalise():dot(lineToCross)
    local currentLocationAngleComparison = operandA.agent.position - pillarA:normalise():dot(lineToCross)
    if previousLocationAngleComparison >= 0 and currentLocationAngleComparison <= 0 and withinLineBounds(pillarA, pillarB) then
      lineCrossedTime = g_NetworkTime
      completedGates = completedGates + 1
      return true
    elseif previousLocationAngleComparison <= 0 and currentLocationAngleComparison >= 0 and withinLineBounds(pillarA, pillarB) then
      lineCrossedTime = g_NetworkTime
      completedGates = completedGates + 1
      return true
    else
      return false
    end
  end
  local function startedSlalom()
    if not triggeredSlalom then
      if hasCrossedLine(pillarData[1][2], pillarData[1][3]) then
        triggeredSlalom = true
        currentGate = 3
        slalomDirection = "north"
        pillarCollection = 1
      elseif hasCrossedLine(pillarData[1][5], pillarData[1][4]) then
        triggeredSlalom = true
        currentGate = 3
        slalomDirection = "south"
        pillarCollection = 1
      elseif hasCrossedLine(pillarData[2][2], pillarData[2][3]) then
        triggeredSlalom = true
        currentGate = 3
        slalomDirection = "north"
        pillarCollection = 2
      elseif hasCrossedLine(pillarData[2][5], pillarData[2][4]) then
        triggeredSlalom = true
        currentGate = 3
        slalomDirection = "south"
        pillarCollection = 2
      else
        triggeredSlalom = false
      end
    end
    return triggeredSlalom
  end
  local function updateSlalomCheck()
    if lineCrossedTime and g_NetworkTime <= lineCrossedTime + timeLimit then
      if hasCrossedLine(pillarData[pillarCollection][currentGate], pillarData[pillarCollection][currentGate + 1]) then
        if slalomDirection == "north" then
          if currentGate < 5 then
            currentGate = currentGate + 1
          else
            currentGate = 4
            slalomDirection = "south"
          end
        elseif slalomDirection == "south" then
          if currentGate > 1 then
            currentGate = currentGate - 1
          else
            currentGate = 2
            slalomDirection = "north"
          end
        end
      end
    else
      triggeredSlalom = false
      currentGate = nil
      completedGates = 2
    end
  end
  return function()
    if startedSlalom() then
      updateSlalomCheck()
    end
    previousPlayerPosition = operandA.agent.position:clone()
    if completedGates >= 9 then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, nil)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Performed lap in car park", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local cornerPositions = params.corners
  local timeLimit = params.timeLimit or 8
  local hotspotRadius = not params.hotspotRadius and 27
  local hotspotEntryTime = false
  local withinHotspot = false
  local triggeredLap = false
  local clockwiseHotspot, counterClockwiseHotspot, hotspotNumber
  local lapDirection = false
  local completedHotspots = 0
  local activeUpdate = false
  local function exitedHotspot(hotspot)
    if operandA.agent then
      if not GameVehicleResource.withinRadius(operandA.agent.position, hotspot, hotspotRadius) and withinHotspot then
        withinHotspot = false
        removeUserUpdateFunction("Exited " .. tostring(hotspot))
        activeUpdate = false
      end
    else
      removeUserUpdateFunction("Exited " .. tostring(hotspot))
      activeUpdate = false
    end
  end
  local function hasEnteredHotspot(hotspot)
    if GameVehicleResource.withinRadius(operandA.agent.position, hotspot, hotspotRadius) and not withinHotspot then
      withinHotspot = true
      hotspotEntryTime = g_NetworkTime
      completedHotspots = completedHotspots + 1
      if not userUpdateFunctions["Exited " .. tostring(hotspot)] then
        addUserUpdateFunction("Exited " .. tostring(hotspot), function()
          exitedHotspot(hotspot)
        end, 30)
        activeUpdate = "Exited " .. tostring(hotspot)
      end
      return true
    else
      return false
    end
  end
  local function nextHotspot()
    local nextHotspotNumber
    if lapDirection == "clockwise" then
      if hotspotNumber == 1 then
        nextHotspotNumber = 4
      else
        nextHotspotNumber = hotspotNumber - 1
      end
    elseif lapDirection == "counter clockwise" then
      if hotspotNumber == 4 then
        nextHotspotNumber = 1
      else
        nextHotspotNumber = hotspotNumber + 1
      end
    end
    return nextHotspotNumber
  end
  local function startedLap()
    if not triggeredLap then
      if hasEnteredHotspot(cornerPositions[1]) then
        triggeredLap = true
        clockwiseHotspot = 4
        counterClockwiseHotspot = 2
        hotspotNumber = 1
      elseif hasEnteredHotspot(cornerPositions[2]) then
        triggeredLap = true
        clockwiseHotspot = 1
        counterClockwiseHotspot = 3
        hotspotNumber = 2
      elseif hasEnteredHotspot(cornerPositions[3]) then
        triggeredLap = true
        clockwiseHotspot = 2
        counterClockwiseHotspot = 4
        hotspotNumber = 3
      elseif hasEnteredHotspot(cornerPositions[4]) then
        triggeredLap = true
        clockwiseHotspot = 3
        counterClockwiseHotspot = 1
        hotspotNumber = 4
      else
        triggeredLap = false
      end
    end
    return triggeredLap
  end
  local function updateLapCheck()
    if hotspotEntryTime and g_NetworkTime <= hotspotEntryTime + timeLimit then
      if not lapDirection then
        if hasEnteredHotspot(cornerPositions[clockwiseHotspot]) then
          lapDirection = "clockwise"
          hotspotNumber = clockwiseHotspot
          hotspotNumber = nextHotspot()
        elseif hasEnteredHotspot(cornerPositions[counterClockwiseHotspot]) then
          lapDirection = "counter clockwise"
          hotspotNumber = counterClockwiseHotspot
          hotspotNumber = nextHotspot()
        end
      elseif hasEnteredHotspot(cornerPositions[hotspotNumber]) then
        hotspotNumber = nextHotspot()
      end
    else
      triggeredLap = false
      lapDirection = false
      hotspotNumber = false
      withinHotspot = false
      hotspotEntryTime = false
      completedHotspots = 0
      if activeUpdate then
        removeUserUpdateFunction(activeUpdate)
        activeUpdate = false
      end
    end
  end
  return function()
    if startedLap() then
      updateLapCheck()
    end
    if completedHotspots >= 5 then
      if activeUpdate then
        removeUserUpdateFunction(activeUpdate)
        activeUpdate = false
      end
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, nil)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Agent had specified number of collisions in car park", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = operandA.agent.collisions >= params.value
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
goalSystem.registerGoal("Scanned in helicam", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    if operandA.instance.taskObjectsByActorID[params.actorID] and operandA.instance.taskObjectsByActorID[params.actorID].coreData.agent.scannedInHeliCam then
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
goalSystem.registerGoal("Losing getaway time trigger", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local startTime = g_NetworkTime
  local elapsedTime
  local goalConditionsMet = false
  local prompt = params.prompt or "ID:235433"
  local counter
  local timePerStep = 1 / updates.stepRate
  local numSteps = 0
  losingCountDownActive = true
  feedbackSystem.menusMaster.clearMinimapTextPrompt()
  local function update()
    if params.useRealTime then
      numSteps = numSteps + updates.goalSystem
      elapsedTime = numSteps * timePerStep
    else
      elapsedTime = g_NetworkTime - startTime
    end
    counter = math.ceil(params.value - elapsedTime)
    feedbackSystem.menusMaster.minimapTextPrompt(prompt, counter, true)
    goalConditionsMet = elapsedTime >= params.value
    if feedback then
      feedback(elapsedTime)
    end
    if goalConditionsMet and not goalReportedSuccessful then
      losingCountDownActive = false
      feedbackSystem.menusMaster.clearMinimapTextPrompt()
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      feedbackSystem.menusMaster.clearMinimapTextPrompt()
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    feedbackSystem.menusMaster.clearMinimapTextPrompt()
    losingCountDownActive = false
  end
  return update, cleanup
end)
goalSystem.registerGoal("In losing countdown", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = losingCountDownActive
    if params.inverse then
      goalConditionsMet = not losingCountDownActive
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
goalSystem.registerGoal("Recent audio played", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local timeToCheck = params.value or 5
  local function update()
    goalConditionsMet = not didRecentAudio(timeToCheck)
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Is player camera", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local showingCameraMessage = false
  local function update()
    goalConditionsMet = false
    if not showingCameraMessage and params.showTutorial and not isInCorrectCameraMode(params.value) then
      if not localPlayer.inZap then
        if params.value ~= "ThrillCam" then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:236453", false, false, true, false, localPlayer.buttonLayout.changeCamera)
        elseif abilities.thrillCam.getActiveLevel() then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:248622", false, false, true, false, localPlayer.buttonLayout.changeCamera)
        end
        showingCameraMessage = true
      end
    elseif feedbackSystem.menusMaster.primaryPromptActive and showingCameraMessage and isInCorrectCameraMode(params.value) then
      showingCameraMessage = false
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    end
    if isInCorrectCameraMode(params.value) then
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
  local cleanup = function()
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    localPlayer.scoring.unregisterUnderTrailerExitCallback(underTrailerExitCallback)
  end
  return update, cleanup
end)
goalSystem.registerGoal("Reached next checkpoint", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  operandA.agent.nextCheckpointReached = false
  local function update()
    goalConditionsMet = false
    if operandA.agent.nextCheckpointReached == true then
      goalConditionsMet = true
      operandA.agent.nextCheckpointReached = false
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
goalSystem.registerGoal("Total zap returns above", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = false
    if ProfileSettings.GetNumZapReturns() >= params.value then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Controller config has changed", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local lastConfig = feedbackSystem.menusMaster.getControllerPreset(localPlayer.localID)
  local goalConditionsMet = false
  return function()
    if feedbackSystem.menusMaster.getControllerPreset(localPlayer.localID) ~= lastConfig then
      goalConditionsMet = true
    end
    lastConfig = feedbackSystem.menusMaster.getControllerPreset(localPlayer.localID)
    if goalConditionsMet and not goalReportedSuccessful then
      accumTime = 0
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Within blaze SP", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local yellow32 = vec.vector(255, 240, 0, 255)
  local yellow128 = vec.vector(0.9647, 0.7686, 0.0549, 1)
  local score
  local multiplier = params.multiplier or 1
  local function cleanup()
    if score == 0 then
      operandA.agent:removeFlashColourOverRide()
    end
  end
  local function update()
    goalConditionsMet = false
    score = GameVehicleResource.interceptingTrailCount(operandA.agent.gameVehicle)
    if score and score > 0 then
      if not operandA.agent:vehicleFlashOverridden() then
        operandA.agent:overRideFlashColour(yellow32, yellow128)
        OneShotSound.Play("Mis_Frozen_Ambulance_Trail_Play")
      end
      goalConditionsMet = true
    end
    if not goalConditionsMet and operandA.agent:vehicleFlashOverridden() then
      operandA.agent:removeFlashColourOverRide()
      OneShotSound.Play("Mis_Frozen_Ambulance_Trail_Stop")
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score * multiplier)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Player has currentVehicle", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local highlightedVehicles
  if params.highlight then
    minimap.SetHighlightedVehicles(true)
    if params.inVehicleID then
      highlightedVehicles = params.inVehicleID
    elseif params.vehicleID then
      highlightedVehicles = params.vehicleID
    end
    for index, modelID in next, highlightedVehicles, nil do
      local vehicles = {
        {VehicleModelUID = modelID}
      }
      minimap.AddHighlightedVehicleModelUIDs(vehicles)
    end
  end
  local function update()
    goalConditionsMet = false
    if localPlayer.currentVehicle then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local cleanup = function()
    minimap.RemoveAllHighlightedVehicleModelUIDs()
    minimap.SetHighlightedVehicles(false)
  end
  return update, cleanup
end)
goalSystem.registerGoal("Actor completed minor order", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if operandA.instance.taskObjectsByActorID[params.actorID] and operandA.instance.taskObjectsByActorID[params.actorID].namedTasks[params.specialName] then
      goalConditionsMet = operandA.instance.taskObjectsByActorID[params.actorID].namedTasks[params.specialName].complete
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
goalSystem.registerGoal("Instant goal complete", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = true
  return function()
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("In activity hotspot", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = feedbackSystem.previewScreen.activityBeingPrompted
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("In hotspot preview", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = feedbackSystem.previewScreen.previewScreenActive
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
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
goalSystem.registerGoal("Dare complete screen active", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = dareSystem.dareCompleteScreenActive
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Tutorial panel active", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = CutsceneFiles.tutorials.tutorialActive
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("In garage hotspot", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = feedbackSystem.previewScreen.activityBeingPrompted and feedbackSystem.previewScreen.activityBeingPrompted.hotspotType and feedbackSystem.previewScreen.activityBeingPrompted.hotspotType == "garage"
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("In garage", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = not garage.garageExitFinished
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Purchased vehicle from shop", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = ProfileSettings.GetToolTipShown(toolTipLookupTable["Purchased a vehicle"])
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
goalSystem.registerGoal("Was overtake", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local startOvertakes = ProfileSettings.GetNumOvertakes()
  return function()
    if ProfileSettings.GetNumOvertakes() > startOvertakes then
      goalConditionsMet = true
      startOvertakes = ProfileSettings.GetNumOvertakes()
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Was nearmiss", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local startNearmisses = ProfileSettings.GetNumOncomingOvertakes()
  return function()
    if ProfileSettings.GetNumOncomingOvertakes() > startNearmisses then
      goalConditionsMet = true
      startNearmisses = ProfileSettings.GetNumOncomingOvertakes()
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
