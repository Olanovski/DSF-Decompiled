local workingVector = vec.vector()
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
goalSystem.registerGoal("Is a felony active", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = Chase.IsAChaseActive() or Getaway.IsAGetawayActive()
    previousTime = g_NetworkTime
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
goalSystem.registerGoal("Agent escaping chasers", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  if params.inverse then
    goalConditionsMet = not goalConditionsMet
  end
  local agent = setAgent(operandA, operandB, params)
  local function losingLastChaserCallback(evader)
    if agent.gameVehicle == evader then
      goalConditionsMet = true
      if params.inverse then
        goalConditionsMet = not goalConditionsMet
      end
    end
  end
  felony_getaway.registerGoalCallback(losingLastChaserCallback, "losingLastChaser")
  local function chaseStartedAgainCallback(evader)
    if agent.gameVehicle == evader then
      goalConditionsMet = false
      if params.inverse then
        goalConditionsMet = not goalConditionsMet
      end
    end
  end
  felony_getaway.registerGoalCallback(chaseStartedAgainCallback, "chaseReinstated")
  local function update()
    if params.agent == "Player" and agent ~= localPlayer.currentVehicle then
      agent = localPlayer.currentVehicle
    end
    if goalConditionsMet and not goalReportedSuccessful then
      print("Agent escaping chasers goal " .. tostring(UID) .. " is false")
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      print("Agent escaping chasers goal " .. tostring(UID) .. " is false")
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    felony_getaway.unregisterGoalCallback(chaseStartedAgainCallback, "chaseReinstated")
    felony_getaway.unregisterGoalCallback(losingLastChaserCallback, "losingLastChaser")
  end
  return update, cleanup
end)
goalSystem.registerGoal("Felony chaser destroyed", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function chaserDestroyedCallback(evader)
    if operandA.agent.gameVehicle == evader then
      goalConditionsMet = true
    end
  end
  felony_getaway.registerGoalCallback(chaserDestroyedCallback, "chaserDestroyed")
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
    felony_getaway.unregisterGoalCallback(chaserDestroyedCallback, "chaserDestroyed")
  end
  return update, cleanup
end)
goalSystem.registerGoal("Losing last chaser", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local agent = setAgent(operandA, operandB, params)
  local function losingLastChaserCallback(evader)
    if agent.gameVehicle == evader then
      goalConditionsMet = true
      if params.inverse then
        goalConditionsMet = not goalConditionsMet
      end
    end
  end
  felony_getaway.registerGoalCallback(losingLastChaserCallback, "losingLastChaser")
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
    felony_getaway.unregisterGoalCallback(losingLastChaserCallback, "losingLastChaser")
  end
  return update, cleanup
end)
goalSystem.registerGoal("Player in getaway vehicle", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if not localPlayer.inZap and localPlayer.currentVehicle and Getaway.IsBeingChased(localPlayer.currentVehicle.gameVehicle) then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      print("Player in getaway vehicle goal " .. tostring(UID) .. " is true")
      if params.increment then
        goalSystem.callbackHandler(UID, params.increment)
      else
        goalSystem.callbackHandler(UID)
      end
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      print("Player in getaway vehicle goal " .. tostring(UID) .. " is false")
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Specified actor is getaway", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local previousTime
  local previousValue = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = previousValue
    if not previousTime or g_NetworkTime >= previousTime + 0.5 then
      goalConditionsMet = Getaway.IsBeingChased(operandA.instance.taskObjectsByActorID[params.actorID].coreData.agent.gameVehicle)
      previousTime = g_NetworkTime
      if params.inverse then
        goalConditionsMet = not goalConditionsMet
      end
      previousValue = goalConditionsMet
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
goalSystem.registerGoal("Being busted", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  if params.inverse then
    goalConditionsMet = not goalConditionsMet
  end
  local agent = setAgent(operandA, operandB, params)
  local function beingBustedCallback(evader)
    if agent.gameVehicle == evader then
      goalConditionsMet = true
      if params.inverse then
        goalConditionsMet = not goalConditionsMet
      end
    end
  end
  felony_getaway.registerGoalCallback(beingBustedCallback, "beingBusted")
  local function notBeingBustedCallback(evader)
    if agent.gameVehicle == evader then
      goalConditionsMet = false
      if params.inverse then
        goalConditionsMet = not goalConditionsMet
      end
    end
  end
  felony_getaway.registerGoalCallback(notBeingBustedCallback, "notBeingBusted")
  local function update()
    if params.agent == "Player" and agent ~= localPlayer.currentVehicle then
      agent = localPlayer.currentVehicle
    end
    if goalConditionsMet and not goalReportedSuccessful then
      print("Agent being busted goal " .. tostring(UID) .. " is false")
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      print("Agent being busted goal " .. tostring(UID) .. " is false")
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    felony_getaway.unregisterGoalCallback(beingBustedCallback, "beingBusted")
    felony_getaway.unregisterGoalCallback(notBeingBustedCallback, "notBeingBusted")
  end
  return update, cleanup
end)
goalSystem.registerGoal("Escaped being busted", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local agent = setAgent(operandA, operandB, params)
  local currentlyBeingBusted = false
  local function beingBustedCallback(evader)
    if agent.gameVehicle == evader then
      currentlyBeingBusted = true
      print("BEING BUSTED")
    end
  end
  felony_getaway.registerGoalCallback(beingBustedCallback, "beingBusted")
  local function notBeingBustedCallback(evader)
    if agent.gameVehicle == evader and currentlyBeingBusted then
      goalConditionsMet = true
      currentlyBeingBusted = false
      print("NOT BEING BUSTED")
    end
  end
  felony_getaway.registerGoalCallback(notBeingBustedCallback, "notBeingBusted")
  local function update()
    if params.agent == "Player" and agent ~= localPlayer.currentVehicle then
      agent = localPlayer.currentVehicle
    end
    if goalConditionsMet and not goalReportedSuccessful then
      print("Agent being busted goal " .. tostring(UID) .. " is false")
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      print("Agent being busted goal " .. tostring(UID) .. " is false")
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    felony_getaway.unregisterGoalCallback(beingBustedCallback, "beingBusted")
    felony_getaway.unregisterGoalCallback(notBeingBustedCallback, "notBeingBusted")
  end
  return update, cleanup
end)
goalSystem.registerGoal("Got busted", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function callback(evader)
    if operandA.agent.gameVehicle == evader then
      goalConditionsMet = true
    end
  end
  felony_getaway.registerGoalCallback(callback, "gotBusted")
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
    felony_getaway.unregisterGoalCallback(callback, "gotBusted")
  end
  return update, cleanup
end)
goalSystem.registerGoal("Being chased", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if params.numberOfChasers then
      local numberOfChasers = 0
      if params.usePlayer and localPlayer.currentVehicle then
        if not params.NumberOfChasersShownOnTheHud then
          numberOfChasers = Getaway.NumberOfChasers(localPlayer.currentVehicle.gameVehicle)
        else
          numberOfChasers = Getaway.NumberOfChasersShownOnTheHud(localPlayer.currentVehicle.gameVehicle)
        end
      elseif not params.NumberOfChasersShownOnTheHud then
        numberOfChasers = Getaway.NumberOfChasers(operandA.agent.gameVehicle)
      else
        numberOfChasers = Getaway.NumberOfChasersShownOnTheHud(operandA.agent.gameVehicle)
      end
      if params.condition then
        if params.condition == "moreThan" then
          if numberOfChasers > params.numberOfChasers then
            goalConditionsMet = true
          end
        elseif params.condition == "lessThan" then
          if numberOfChasers < params.numberOfChasers then
            goalConditionsMet = true
          end
        elseif params.condition == "equal" and numberOfChasers == params.numberOfChasers then
          goalConditionsMet = true
        end
      elseif numberOfChasers >= params.numberOfChasers then
        goalConditionsMet = true
      end
    elseif params.usePlayer and localPlayer.currentVehicle then
      goalConditionsMet = Getaway.IsBeingChased(localPlayer.currentVehicle.gameVehicle)
    else
      goalConditionsMet = Getaway.IsBeingChased(operandA.agent.gameVehicle)
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
goalSystem.registerGoal("Has been chased", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local previousTime
  local beenInChase = false
  local inChase = false
  local goalConditionsMet = false
  return function()
    goalConditionsMet = false
    if not beenInChase then
      if not previousTime or g_NetworkTime >= previousTime + 0.5 then
        if not inChase then
          if params.usePlayer and localPlayer.currentVehicle then
            inChase = Getaway.IsBeingChased(localPlayer.currentVehicle.gameVehicle)
          else
            inChase = Getaway.IsBeingChased(operandA.agent.gameVehicle)
          end
        elseif params.usePlayer and localPlayer.currentVehicle then
          beenInChase = not Getaway.IsBeingChased(localPlayer.currentVehicle.gameVehicle)
        else
          beenInChase = not Getaway.IsBeingChased(operandA.agent.gameVehicle)
        end
        previousTime = g_NetworkTime
      end
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
goalSystem.registerGoal("Busted getaway", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function callback(evader)
    if localPlayer.primaryFelony.getawayGameVehicle and localPlayer.primaryFelony.getawayGameVehicle == evader then
      goalConditionsMet = true
    end
  end
  felony_chase.registerGoalCallback(callback, "bustedGetaway")
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
    felony_chase.unregisterGoalCallback(callback, "bustedGetaway")
  end
  return update, cleanup
end)
goalSystem.registerGoal("Losing getaway", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = false
    if localPlayer.primaryFelony.status then
      goalConditionsMet = localPlayer.primaryFelony.status.losingGetaway
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
goalSystem.registerGoal("Getaway escaped", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function callback(evader)
    if localPlayer.primaryFelony.getawayGameVehicle and localPlayer.primaryFelony.getawayGameVehicle == evader then
      goalConditionsMet = true
    end
  end
  felony_chase.registerGoalCallback(callback, "getawayEscaped")
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
    felony_chase.unregisterGoalCallback(callback, "getawayEscaped")
  end
  return update, cleanup
end)
goalSystem.registerGoal("All chaser teammates wrecked", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function callback(evader)
    if localPlayer.primaryFelony.getawayGameVehicle and localPlayer.primaryFelony.getawayGameVehicle == evader then
      goalConditionsMet = true
    end
  end
  felony_chase.registerGoalCallback(callback, "allChasersWrecked")
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
    felony_chase.unregisterGoalCallback(callback, "allChasersWrecked")
  end
  return update, cleanup
end)
goalSystem.registerGoal("Getaway reached end of route", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local agent = setAgent(operandA, operandB, params)
  local function callback(evader)
    if localPlayer.primaryFelony.getawayGameVehicle and localPlayer.primaryFelony.getawayGameVehicle == evader then
      goalConditionsMet = true
    end
  end
  felony_chase.registerGoalCallback(callback, "getawayFinishedLap")
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
    felony_chase.unregisterGoalCallback(callback, "getawayFinishedLap")
  end
  return update, cleanup
end)
goalSystem.registerGoal("Getaway damage above", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function update()
    goalConditionsMet = false
    if localPlayer.primaryFelony.getawayGameVehicle and localPlayer.primaryFelony.getawayGameVehicle.damage >= params.value then
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
goalSystem.registerGoal("Specified chaser damage above", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local function callback(chaserID)
    if chaserID == params.ID then
      goalConditionsMet = true
    end
  end
  felony_chase.registerGoalCallback(callback, "chaserWrecked")
  local function update()
    if localPlayer.primaryFelony.chasers and localPlayer.primaryFelony.chasers[params.ID] then
      goalConditionsMet = false
      if localPlayer.primaryFelony.chasers[params.ID].damage >= params.value and params.value < 1 then
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
    felony_chase.unregisterGoalCallback(callback, "chaserWrecked")
  end
  return update, cleanup
end)
goalSystem.registerGoal("Chaser damage has changed by", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local previousDamage
  return function()
    goalConditionsMet = false
    if params.value then
      if localPlayer.primaryFelony.chasers and localPlayer.primaryFelony.chasers[params.ID] then
        if not previousDamage then
          previousDamage = localPlayer.primaryFelony.chasers[params.ID].damage
        end
        if localPlayer.primaryFelony.chasers[params.ID].damage - previousDamage > params.value then
          if not params.inverse then
            goalConditionsMet = true
          end
          previousDamage = localPlayer.primaryFelony.chasers[params.ID].damage
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
goalSystem.registerGoal("Player controlling specified chaser", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local loopThroughTable = false
  if type(params.ID) == "table" then
    loopThroughTable = true
  end
  local function update()
    goalConditionsMet = false
    if localPlayer.currentVehicle and not localPlayer.inZap and localPlayer.primaryFelony.chasers then
      if loopThroughTable then
        for k, v in next, params.ID, nil do
          if localPlayer.primaryFelony.chasers[v] and localPlayer.primaryFelony.chasers[v] == localPlayer.currentVehicle.gameVehicle then
            goalConditionsMet = true
          end
        end
      elseif localPlayer.primaryFelony.chasers[params.ID] and localPlayer.primaryFelony.chasers[params.ID] == localPlayer.currentVehicle.gameVehicle then
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
  return update
end)
goalSystem.registerGoal("Within radius of getaway", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local agent
  local target = {}
  return function()
    goalConditionsMet = false
    if agent ~= localPlayer.currentVehicle then
      agent = localPlayer.currentVehicle
    end
    target.position = localPlayer.primaryFelony.getawayGameVehicle and localPlayer.primaryFelony.getawayGameVehicle.position
    if agent and target.position and GameVehicleResource.withinRadius(agent.position, target.position, params.value) then
      goalConditionsMet = true
    end
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
goalSystem.registerGoal("Player within radius of getaway", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local target = {}
  return function()
    goalConditionsMet = false
    playerPosition = localPlayer.inZap and localPlayer.position
    target.position = localPlayer.primaryFelony.getawayGameVehicle and localPlayer.primaryFelony.getawayGameVehicle.position
    if playerPosition and target.position and GameVehicleResource.withinRadius(playerPosition, target.position, params.value) then
      goalConditionsMet = true
    end
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
goalSystem.registerGoal("Actor within radius of getaway", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local target = {}
  return function()
    goalConditionsMet = false
    target.position = localPlayer.primaryFelony.getawayGameVehicle and localPlayer.primaryFelony.getawayGameVehicle.position
    if target.position and GameVehicleResource.withinRadius(operandA.agent.position, target.position, params.value) then
      goalConditionsMet = true
    end
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
goalSystem.registerGoal("Getaway within radius", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local target = {}
  return function()
    goalConditionsMet = false
    target.position = localPlayer.primaryFelony.getawayGameVehicle and localPlayer.primaryFelony.getawayGameVehicle.position
    if target.position and GameVehicleResource.withinRadius(operandB.position, target.position, params.value) then
      goalConditionsMet = true
    end
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
goalSystem.registerGoal("Another chaser within radius of getaway", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local target = localPlayer.primaryFelony.getawayGameVehicle
  return function()
    goalConditionsMet = false
    if localPlayer.primaryFelony.chasers then
      for key, gameVehicle in next, localPlayer.primaryFelony.chasers, nil do
        if (not localPlayer.currentVehicle or gameVehicle ~= localPlayer.currentVehicle.gameVehicle) and GameVehicleResource.withinRadius(gameVehicle.position, target.position, params.value) then
          goalConditionsMet = true
        end
      end
    end
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
goalSystem.registerGoal("Player within then outside radius of getaway", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local insideRadius = false
  local outsideRadius = params.outsideRadius or params.value
  local target = localPlayer.primaryFelony.getawayGameVehicle
  local agentPos, agentPosLast, targetPos, targetPosLast
  return function()
    goalConditionsMet = false
    agentPosLast = getLastKnownPosition(localPlayer.currentVehicle)
    agentPos = setLastKnownPosition(localPlayer.currentVehicle, localPlayer.currentVehicle.position)
    targetPosLast = getLastKnownPosition(target)
    targetPos = setLastKnownPosition(target, target.position)
    result = GameVehicleResource.withinSweptRadius(agentPos, agentPosLast, targetPos, targetPosLast, radius)
    if not insideRadius and result then
      insideRadius = true
    end
    if insideRadius and not result then
      goalConditionsMet = true
      insideRadius = false
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
