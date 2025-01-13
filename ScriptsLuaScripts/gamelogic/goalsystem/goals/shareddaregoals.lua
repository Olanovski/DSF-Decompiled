local sendEvent = function(UID, eventID, data, instance, excludePlayer)
  local msgData = tostring(UID) .. ":" .. tostring(data)
  for i = 1, 2 do
    local playerName = "Player " .. i
    local playerTaskObject = instance.taskObjectsByActorID[playerName]
    if not playerTaskObject then
      assert(0, "Could not get task object for player " .. tostring(playerID))
    elseif playerTaskObject.coreData.agent ~= excludePlayer then
      playerTaskObject:sendMessage(eventID, msgData, playerTaskObject.coreData.agent)
    end
  end
end
local soundEffect = "HUD_Online_DoubleDare_Token"
goalSystem.registerGoal("Dare overtakes in time shared", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local challengeOvertakes = 0
  local previousValue = 0
  local overtakesNeeded = params.value
  local currentOvertakes = localPlayer.scoring:getNumberOfOvertakes()
  local previousOvertakes = currentOvertakes
  local timeAllowance = params.timer
  local previousNetworkTime = g_NetworkTime
  local delay = 1
  local agent = params.agent or localPlayer
  local vehiclesOvertaken = {}
  local sharedOvertakes = 0
  local getSharedOvertakes = params.getSharedDataFn
  local eventID = params.eventID
  local requiredVehicle = params.requiredVehicle
  local function inRequiredVehicle()
    if not requiredVehicle then
      return true
    end
    local inVehicle = false
    if agent.currentVehicle then
      local vehicleModel = agent.currentVehicle.model_id
      if type(requiredVehicle) == "table" then
        for k, v in next, requiredVehicle, nil do
          if v == vehicleModel then
            inVehicle = true
            break
          end
        end
      elseif vehicleModel == requiredVehicle then
        inVehicle = true
      end
    end
    return inVehicle
  end
  local function maintainTable()
    local removed = false
    for i, time in ipairs(vehiclesOvertaken) do
      if timeAllowance and g_NetworkTime > time + timeAllowance then
        table.remove(vehiclesOvertaken, i)
        removed = true
      end
    end
    challengeOvertakes = #vehiclesOvertaken
    if removed then
      sendEvent(params.UID, eventID, challengeOvertakes, operandA.instance, agent)
    end
    sharedOvertakes = getSharedOvertakes(params.UID, agent.localID)
    challengeOvertakes = challengeOvertakes + sharedOvertakes
  end
  sendEvent(params.UID, eventID, 0, operandA.instance, agent)
  return function()
    goalConditionsMet = false
    currentOvertakes = agent.scoring:getNumberOfOvertakes()
    if currentOvertakes ~= previousOvertakes and inRequiredVehicle() then
      table.insert(vehiclesOvertaken, g_NetworkTime)
      maintainTable()
      previousNetworkTime = g_NetworkTime
      previousOvertakes = currentOvertakes
      sendEvent(params.UID, eventID, #vehiclesOvertaken, operandA.instance, agent)
    elseif g_NetworkTime >= previousNetworkTime + delay then
      maintainTable()
      previousNetworkTime = g_NetworkTime
    end
    if feedback and previousValue ~= challengeOvertakes then
      OneShotSound.Play(soundEffect)
      feedback(challengeOvertakes - sharedOvertakes, sharedOvertakes)
      previousValue = challengeOvertakes
    end
    if challengeOvertakes >= overtakesNeeded then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.score)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Tag x number of y vehicle shared", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local vehiclesHit = {}
  local times = {}
  local lastPlayerVehicle
  local newHit = false
  local addTo = false
  local vehicle
  local sharedTags = 0
  local agent = params.agent or localPlayer
  local getSharedTags = params.getSharedDataFn
  local eventID = params.eventID
  local requiredVehicle = params.requiredVehicle or false
  local previousNetworkTime = g_NetworkTime
  local delay = 1
  local function inRequiredVehicle()
    if not requiredVehicle then
      return true
    end
    local inVehicle = false
    if agent.currentVehicle then
      local vehicleModel = agent.currentVehicle.model_id
      if type(requiredVehicle) == "table" then
        for k, v in next, requiredVehicle, nil do
          if v == vehicleModel then
            inVehicle = true
            break
          end
        end
      elseif vehicleModel == requiredVehicle then
        inVehicle = true
      end
    end
    return inVehicle
  end
  local function collisionCheck(collisionData)
    local willCount = false
    if collisionData.CollidedGameVehicle then
      if params.vehicleID then
        for k, v in next, params.vehicleID, nil do
          if collisionData.CollidedGameVehicle.model_id == v then
            willCount = true
            break
          end
        end
      else
        willCount = true
      end
      if willCount and inRequiredVehicle() then
        newHit = true
        vehicle = collisionData.CollidedGameVehicle
      end
    end
  end
  local callbackSettings = {
    callbackFunction = collisionCheck,
    minimumForce = 1000,
    typeOfHit = "Vehicle"
  }
  sendEvent(params.UID, eventID, 0, operandA.instance, agent)
  local function update()
    if agent.currentVehicle and lastPlayerVehicle ~= agent.currentVehicle then
      if lastPlayerVehicle then
        lastPlayerVehicle:removeCollisionCallback(callbackSettings)
      end
      agent.currentVehicle:addCollisionCallback(callbackSettings)
      lastPlayerVehicle = agent.currentVehicle
    end
    if newHit then
      newHit = false
      addTo = true
      for k, v in next, vehiclesHit, nil do
        if vehicle == v then
          addTo = false
          break
        end
      end
      if addTo then
        if params.timer then
          table.insert(times, g_NetworkTime)
        end
        table.insert(vehiclesHit, vehicle)
        addTo = false
        OneShotSound.Play(soundEffect)
        sendEvent(params.UID, eventID, #vehiclesHit, operandA.instance, agent)
      end
      feedback(#vehiclesHit, sharedTags)
    end
    if params.timer then
      local removed = false
      for k, v in next, times, nil do
        if g_NetworkTime - v > params.timer then
          table.remove(vehiclesHit, k)
          table.remove(times, k)
          removed = true
        end
      end
      if removed then
        sendEvent(params.UID, eventID, #vehiclesHit, operandA.instance, agent)
        feedback(#vehiclesHit, sharedTags)
      end
    end
    if g_NetworkTime >= previousNetworkTime + delay then
      sharedTags = getSharedTags(params.UID, agent.localID)
      feedback(#vehiclesHit, sharedTags)
    end
    if #vehiclesHit + sharedTags >= params.value then
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
    if lastPlayerVehicle then
      lastPlayerVehicle:removeCollisionCallback(callbackSettings)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Dare distance jumped in time shared", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local challengeDistance = 0
  local previousValue = 0
  local distanceNeeded = params.value
  local timeAllowance = params.timer
  local getSharedJumps = params.getSharedDataFn
  local eventID = params.eventID
  local requiredVehicle = params.vehicleID or false
  local agent = params.agent or localPlayer
  local distanceJumped = {}
  local toDelete = {}
  local currentDistance = agent.scoring:getTotalAirTimeDistance()
  local previousDistance = agent.scoring:getTotalAirTimeDistance()
  local networkTime = g_NetworkTime
  local previousNetworkTime = g_NetworkTime
  local delay = 0.5
  local needToDelete = false
  local statTrackMsgID = 7
  local statTrackTO = params.taskObject
  local sharedJumpDistance = 0
  local function inRequiredVehicle()
    if not requiredVehicle then
      return true
    end
    local inVehicle = false
    if agent.currentVehicle then
      local vehicleModel = agent.currentVehicle.model_id
      if type(requiredVehicle) == "table" then
        for k, v in next, requiredVehicle, nil do
          if v == vehicleModel then
            inVehicle = true
            break
          end
        end
      elseif vehicleModel == requiredVehicle then
        inVehicle = true
      end
    end
    return inVehicle
  end
  local function maintainTable()
    challengeDistance = 0
    for i, data in ipairs(distanceJumped) do
      if timeAllowance and networkTime > data.time + timeAllowance then
        table.insert(toDelete, i, true)
        needToDelete = true
      else
        challengeDistance = challengeDistance + data.distance
      end
    end
    if needToDelete then
      for k, v in next, toDelete, nil do
        table.remove(distanceJumped, k)
      end
      needToDelete = false
      toDelete = {}
    end
    sendEvent(params.UID, eventID, challengeDistance, operandA.instance, agent)
    if feedback then
      feedback(challengeDistance, sharedJumpDistance)
      previousValue = challengeDistance
    end
  end
  sendEvent(params.UID, eventID, 0, operandA.instance, agent)
  return function()
    local goalConditionsMet = false
    networkTime = g_NetworkTime
    currentDistance = agent.scoring:getTotalAirTimeDistance()
    if currentDistance ~= previousDistance and inRequiredVehicle() then
      table.insert(distanceJumped, {
        time = g_NetworkTime,
        distance = currentDistance - previousDistance
      })
      maintainTable()
      previousNetworkTime = networkTime
      statTrackTO:sendMessage(statTrackMsgID, currentDistance - previousDistance)
      previousDistance = currentDistance
      OneShotSound.Play(soundEffect)
    end
    if networkTime >= previousNetworkTime + delay then
      maintainTable()
      previousNetworkTime = networkTime
      sharedJumpDistance = getSharedJumps(params.UID, agent.localID)
    end
    if challengeDistance + sharedJumpDistance >= distanceNeeded then
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
goalSystem.registerGoal("Player jumped over x vehicles shared", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local count = 0
  local jumpsNeeded = params.value
  local times = {}
  local agent = params.agent or localPlayer
  local sharedJumps = 0
  local getSharedJumps = params.getSharedDataFn
  local eventID = params.eventID
  local previousTime = g_NetworkTime
  local interval = 1
  sendEvent(params.UID, eventID, 0, operandA.instance, agent)
  local function maintainTable()
    local removed = false
    for k, v in next, times, nil do
      if params.timer and g_NetworkTime - v > params.timer then
        table.remove(times, k)
        count = count - 1
        removed = true
      end
    end
    if removed then
      sendEvent(params.UID, eventID, count, operandA.instance, agent)
    end
  end
  local function jumpedOverCallback(jumpInfo)
    local allowed = true
    if allowed and params.inModelID then
      allowed = false
      for k, v in next, params.inModelID, nil do
        if v == agent.currentVehicle.gameVehicle.model_id then
          allowed = true
          break
        end
      end
    end
    if allowed and jumpInfo.VehicleID and jumpInfo.VehicleID ~= 298 then
      if params.value then
        count = count + 1
        if params.timer then
          table.insert(times, g_NetworkTime)
        end
        sendEvent(params.UID, eventID, count, operandA.instance, agent)
        goalConditionsMet = count + sharedJumps >= params.value
      else
        goalConditionsMet = true
      end
    end
  end
  agent.scoring.registerVehicleJumpedStartCallback(jumpedOverCallback)
  return function()
    if g_NetworkTime >= previousTime + interval then
      sharedJumps = getSharedJumps(params.UID, agent.localID)
      if count + sharedJumps >= params.value then
        goalConditionsMet = true
      end
    end
    if params.timer then
      maintainTable()
    end
    if feedback then
      feedback(count + sharedJumps)
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end, function()
    agent.scoring.unregisterVehicleJumpedStartCallback(jumpedOverCallback)
  end
end)
goalSystem.registerGoal("Dare distance drifted in time shared", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local challengeDistance = 0
  local previousValue = 0
  local distanceNeeded = params.value
  local timeAllowance = params.timer
  local agent = params.agent or localPlayer
  local distanceDrifted = {}
  local toDelete = {}
  local currentDistance = agent.scoring:getTotalDriftDistance()
  local previousDistance = agent.scoring:getTotalDriftDistance()
  local networkTime = g_NetworkTime
  local previousNetworkTime = g_NetworkTime
  local delay = 1
  local needToDelete = false
  local sharedDriftDistance = 0
  local getSharedDrifts = params.getSharedDataFn
  local eventID = params.eventID
  local requiredVehicle = params.requiredVehicle
  local function inRequiredVehicle()
    if not requiredVehicle then
      return true
    end
    local inVehicle = false
    if agent.currentVehicle then
      local vehicleModel = agent.currentVehicle.model_id
      if type(requiredVehicle) == "table" then
        for k, v in next, requiredVehicle, nil do
          if v == vehicleModel then
            inVehicle = true
            break
          end
        end
      elseif vehicleModel == requiredVehicle then
        inVehicle = true
      end
    end
    return inVehicle
  end
  local function maintainTable()
    challengeDistance = 0
    for i, data in ipairs(distanceDrifted) do
      if timeAllowance and networkTime > data.time + timeAllowance then
        table.insert(toDelete, i, true)
        needToDelete = true
      else
        challengeDistance = challengeDistance + data.distance
      end
    end
    if needToDelete then
      for k, v in next, toDelete, nil do
        table.remove(distanceDrifted, k)
      end
      needToDelete = false
      toDelete = {}
    end
    sendEvent(params.UID, eventID, challengeDistance, operandA.instance, agent)
    if feedback then
      feedback(challengeDistance, sharedDriftDistance)
      previousValue = challengeDistance
    end
  end
  sendEvent(params.UID, eventID, 0, operandA.instance, agent)
  return function()
    local goalConditionsMet = false
    networkTime = g_NetworkTime
    currentDistance = agent.scoring:getTotalDriftDistance()
    if currentDistance ~= previousDistance and inRequiredVehicle() then
      table.insert(distanceDrifted, {
        time = g_NetworkTime,
        distance = currentDistance - previousDistance
      })
      maintainTable()
      previousNetworkTime = networkTime
      previousDistance = currentDistance
      sharedDriftDistance = getSharedDrifts(params.UID, agent.localID)
      sendEvent(params.UID, eventID, challengeDistance, operandA.instance, agent)
      OneShotSound.Play(soundEffect)
    end
    if networkTime >= previousNetworkTime + delay then
      maintainTable()
      previousNetworkTime = networkTime
      sharedDriftDistance = getSharedDrifts(params.UID, agent.localID)
    end
    if challengeDistance + sharedDriftDistance >= distanceNeeded then
      sendEvent(params.UID, eventID, challengeDistance, operandA.instance, agent)
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
goalSystem.registerGoal("Player driven X metres shared", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = true
  local distance = 0
  local lastLocation
  local collisionOccurred = false
  local previousVehicle
  local workingVector = vec.vector(0, 0, 0, 0)
  local previousTime = g_NetworkTime
  local delay = 0.5
  local agent = params.agent or localPlayer
  local sharedDistance = 0
  local getSharedDistance = params.getSharedDataFn
  local eventID = params.eventID
  local collisionForce = params.collisionForce or -1
  local minSpeed = params.minSpeed
  local againstTraffic = params.againstTraffic
  local inReverse = not params.inReverse and false
  local isPlayingSound = false
  local function collisionCheck(collisionData)
    lastLocation = nil
    distance = 0
    collisionOccurred = false
    sendEvent(params.UID, eventID, distance, operandA.instance, agent)
  end
  local callbackSettings = {
    callbackFunction = collisionCheck,
    minimumForce = params.collisionForce
  }
  sendEvent(params.UID, eventID, 0, operandA.instance, agent)
  local function update()
    goalConditionsMet = false
    if collisionForce > -1 and agent.currentVehicle ~= previousVehicle then
      if previousVehicle then
        previousVehicle:removeCollisionCallback(callbackSettings)
      end
      if agent.currentVehicle then
        agent.currentVehicle:addCollisionCallback(callbackSettings)
        previousVehicle = agent.currentVehicle
      end
    end
    if not agent.inZap then
      if not lastLocation then
        lastLocation = vec.vector()
        lastLocation.x = agent.currentVehicle.position.x
        lastLocation.y = agent.currentVehicle.position.y
        lastLocation.z = agent.currentVehicle.position.z
      else
        local newDistance = workingVector:sub(agent.currentVehicle.position, lastLocation):length()
        local addDistance = true
        if minSpeed then
          local speed
          if params.displayed then
            speed = agent.currentVehicle.gameVehicle.displayedSpeed
          else
            speed = agent.currentVehicle.speed
          end
          speed = speed * 2.236
          if speed < minSpeed then
            addDistance = false
          end
        end
        if againstTraffic and addDistance and agent.currentVehicle then
          if not scoreSystem.isPlayerOffRoad(2, localPlayer.localID) and not agent.currentVehicle:get_withTrafficFlow() or isVehicleOnJunction(agent.currentVehicle) then
            addDistance = true
          else
            addDistance = false
          end
        end
        if inReverse and addDistance and agent.currentVehicle then
          if GameVehicleResource.isReversing(agent.currentVehicle.gameVehicle) then
            addDistance = true
          else
            addDistance = false
          end
        end
        if addDistance then
          distance = distance + newDistance
          if not isPlayingSound then
            OneShotSound.PlayGUI("GUI_Willpower_Progress_Points_Play")
            isPlayingSound = true
          end
        elseif isPlayingSound then
          OneShotSound.PlayGUI("GUI_Willpower_Progress_Points_Stop")
          isPlayingSound = false
        end
        lastLocation.x = agent.currentVehicle.position.x
        lastLocation.y = agent.currentVehicle.position.y
        lastLocation.z = agent.currentVehicle.position.z
      end
    else
      if lastLocation then
        lastLocation = nil
      end
      feedback(0, sharedDistance)
    end
    if g_NetworkTime > previousTime + delay then
      sharedDistance = getSharedDistance(params.UID, agent.localID)
      sendEvent(params.UID, eventID, distance, operandA.instance, agent)
      previousTime = g_NetworkTime
    end
    if feedback then
      feedback(distance, sharedDistance)
    end
    if distance + sharedDistance >= params.value then
      sendEvent(params.UID, eventID, distance, operandA.instance, agent)
      goalConditionsMet = true
      OneShotSound.PlayGUI("GUI_Willpower_Progress_Points_Stop")
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
goalSystem.registerGoal("Dare number of props smashed shared", function(operandA, operandB, UID, params, feedback)
  local props = props or 0
  local tableOfTargets = not tableOfTargets and {}
  local smashWatchAdded = false
  local function propFindCallback(context, instance, region, lo, hi, vector)
    local target = Marker:create({
      type = "Minimap",
      gadgetID = 4,
      radius = 7,
      visible = true,
      canrotate = false,
      colour = vec.vector(255, 0, 0, 255),
      position = vector
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
  local networkTime = g_NetworkTime
  local previousNetworkTime = g_NetworkTime
  local timeAllowance, allow
  local propsSmashed = {}
  local agent = params.agent or localPlayer
  local sharedHits = 0
  local getSharedHits = params.getSharedDataFn
  local eventID = params.eventID
  local requiredVehicle = params.vehicleID or false
  local timeAllowance = params.timer
  local delay = 1
  local statTrackMsgID = 6
  local statTrackTO = params.taskObject
  local function inRequiredVehicle()
    if not requiredVehicle then
      return true
    end
    local inVehicle = false
    if agent.currentVehicle then
      local vehicleModel = agent.currentVehicle.model_id
      if type(requiredVehicle) == "table" then
        for k, v in next, requiredVehicle, nil do
          if v == vehicleModel then
            inVehicle = true
            break
          end
        end
      elseif vehicleModel == requiredVehicle then
        inVehicle = true
      end
    end
    return inVehicle
  end
  local function maintainTable()
    local removed = false
    for i, time in ipairs(propsSmashed) do
      if timeAllowance and networkTime > time + timeAllowance then
        table.remove(propsSmashed, i)
        removed = true
      end
    end
    numberHit = #propsSmashed
    if removed then
      sendEvent(params.UID, eventID, numberHit, operandA.instance, agent)
    end
  end
  local function propSmashCallback(context, gameVehicle, instance, region, lo, hi, pos)
    local workingVector = vec.vector(0, 0, 0, 0)
    local distance = workingVector:sub(agent.position, pos):length()
    if distance < 5 and inRequiredVehicle() then
      statTrackTO:sendMessage(statTrackMsgID, 1)
      hitTarget = true
    end
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
    if params.propData then
      if propType[params.propData.name] then
        PropSystem.AddWatch(propSmashCallback, {
          name = params.propData.name
        })
        smashWatchAdded = true
        if params.highlightTargets then
          PropSystem.FindStaticProps(propFindCallback, {
            context = 1,
            name = params.propData.name,
            position = agent.position,
            radius = 2000
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
              position = agent.position,
              radius = 2000
            })
          end
        end
      end
    else
      PropSystem.AddWatch(propSmashCallback)
      smashWatchAdded = true
    end
  end
  sendEvent(params.UID, eventID, 0, operandA.instance, agent)
  return function()
    networkTime = g_NetworkTime
    local goalConditionsMet = false
    if hitTarget then
      hitTarget = false
      allowed = true
      if params.onlyAlleyProps then
        if agent.currentVehicle then
          allowed = Atlas.IsRoadAnAlleyway(agent.currentVehicle:get_closestRoadIndex())
        else
          allowed = false
        end
      end
      if allowed then
        table.insert(propsSmashed, networkTime)
        maintainTable()
        previousNetworkTime = networkTime
        OneShotSound.Play(soundEffect)
        sendEvent(params.UID, eventID, numberHit, operandA.instance, agent)
      end
      if feedback then
        feedback(numberHit, sharedHits)
      end
    end
    if networkTime >= previousNetworkTime + delay then
      maintainTable()
      sharedHits = getSharedHits(params.UID, agent.localID)
      if feedback then
        feedback(numberHit, sharedHits)
      end
      previousNetworkTime = networkTime
    end
    if numberHit + sharedHits >= targetNumber then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      if params.highlightTargets then
        for i, target in next, tableOfTargets, nil do
          Marker:delete(target.target)
        end
        props = 0
        tableOfTargets = {}
      end
      goalSystem.callbackHandler(UID, params.score)
      goalReportedSuccessful = true
      PropSystem.RemoveWatch(propSmashCallback)
      smashWatchAdded = false
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.score)
      goalReportedSuccessful = false
    end
  end, function()
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
  end, function()
    goalReportedSuccessful = false
  end
end)
