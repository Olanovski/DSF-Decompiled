module("vehicleManager")
local playerAbilityStrings = {
  [0] = {
    stepAbility = "StepAbility0",
    stopAbility = "StopAbility0"
  },
  [1] = {
    stepAbility = "StepAbility1",
    stopAbility = "StopAbility1"
  }
}
local vehicleWithAIDelay = false
chasingGameVehiclesByChasedGameVehicle = {}
function RegisterChasedVehicle(chasedVehicle)
  chasingGameVehiclesByChasedGameVehicle[chasedVehicle] = {}
  vehicleManagerCoreReflection.registerChaserWithChased(chasedVehicle)
end
function UnregisterChasedVehicle(chasedVehicle)
  chasingGameVehiclesByChasedGameVehicle[chasedVehicle] = nil
  vehicleManagerCoreReflection.unregisterChaser(chasedVehicle)
end
function RegisterChasingVehicleAsChaser(chasedVehicle, chasingVehicle, chasingType)
  chasingGameVehiclesByChasedGameVehicle[chasedVehicle][chasingVehicle] = chasingType
  vehicleManagerCoreReflection.registerChaserWithChased(chasedVehicle, chasingVehicle)
end
function UnregisterChasingVehicleAsChaser(chasedVehicle, chasingVehicle)
  chasingGameVehiclesByChasedGameVehicle[chasedVehicle][chasingVehicle] = nil
  vehicleManagerCoreReflection.unregisterChaser(chasedVehicle, chasingVehicle)
end
vehicleTemplate = {
  isVehicle = true,
  abilities = {
    ram = abilities.ram,
    nitro = abilities.nitro
  }
}
vehicleTemplate.__index = vehicleTemplate
function vehicleTemplate:setDebugRequiredVehicles(isDebugRequiredVehicle)
  self.debugRequiredVehicles = isDebugRequiredVehicle
  vehicleManagerCoreReflection.setDebugRequiredVehicles(self.gameVehicle, self.debugRequiredVehicles)
end
function vehicleTemplate:vehicleDeletetionCleanup()
  local plr = localPlayerManager.getPlayerByGameVehicle(self.gameVehicle)
  if plr then
    if not plr.inZap then
      if gameStatus.onlineSession then
        if not plr.inZap or zapcontroller.getTargetZapLevel(plr.localID) ~= 5 then
          plr:SetZapLevel(5, nil, false, {forcedOut = true})
        end
      else
        plr:SetZapLevel(1, nil, false, {forcedOut = true})
      end
    end
    plr:clearCurrentVehicle()
    if self == plr.previousVehicle then
      plr:clearPreviousVehicle()
    end
  end
  if not gameStatus.onlineSession then
    local activityGameVehicle = progressionSystem.getActivityGameVehicle()
    if activityGameVehicle and self.gameVehicle == activityGameVehicle then
      progressionSystem.clearActivityGameVehicle()
    end
  end
  GameVehicleResource.setDisableAllDamage(self.gameVehicle, false)
end
function vehicleTemplate:makeOrphan()
  NetworkLog.Write(">[LUA] VEHICLE MANAGER - Converting vehicle to orphan, SNVID = " .. tostring(self.SNVID) .. ", isLocal = " .. tostring(self.isLocal))
  unregisterVehicle(self, false)
  self:vehicleDeletetionCleanup()
  if Orphanage.createOrphan(self.gameVehicle, "veryimportant") > 0 and gameStatus.onlineSession then
    SNV.setScriptedState(self.SNVID, false)
  end
end
function vehicleTemplate:delete()
  NetworkLog.Write(">[LUA] VEHICLE MANAGER - Deleting vehicle = " .. tostring(self.SNVID) .. ", isLocal = " .. tostring(self.isLocal) .. ", userData = " .. tostring(self.gameVehicle))
  local childVehicle = self.gameVehicle.childVehicle
  local parentVehicle = self.gameVehicle.parentVehicle
  if self.networkVars.onlineOwnerID ~= nil then
    zapcontroller.RemoveLockedVehicle({
      gameVehicle = self.gameVehicle
    })
  end
  if childVehicle then
    if not childVehicle.isArtic then
      GameVehicleResource.unregisterParentPreDeletionCallback(parentPreDeletionCallback, childVehicle)
    end
    if childVehicle.owner == "NoFixedAbode" then
      childVehicle = nil
    end
  end
  unregisterVehicle(self, true)
  self:vehicleDeletetionCleanup()
  GameVehicleResource.destroy(self.gameVehicle)
  if childVehicle then
    if vehiclesByGameVehicle[childVehicle] then
      if not vehiclesByGameVehicle[childVehicle]:getTaskObject() then
        vehiclesByGameVehicle[childVehicle]:delete()
      end
    else
      childVehicle.owner = "Script"
      GameVehicleResource.destroy(childVehicle)
    end
  end
  if parentVehicle then
    if vehiclesByGameVehicle[parentVehicle] then
      if not vehiclesByGameVehicle[parentVehicle]:getTaskObject() and parentVehicle ~= progressionSystem.getActivityGameVehicle() then
        vehiclesByGameVehicle[parentVehicle]:delete()
      end
    else
      parentVehicle.owner = "Script"
      GameVehicleResource.destroy(parentVehicle)
    end
  end
end
function vehicleTemplate:setActiveLifePersonalityTraits(traits)
  if traits then
    ActiveLifeAI.setPersonalityTraits(self.gameVehicle, traits)
  end
end
function vehicleTemplate:update()
end
function vehicleTemplate:restrictTopSpeed(limit)
  limit = limit or self.gameVehicle.topSpeed
  self.gameVehicle.topSpeedLimit = limit
end
function vehicleTemplate:getTaskObject()
  return self.networkVars.taskObjectID and taskSystem.taskObjects[self.networkVars.taskObjectID]
end
function vehicleTemplate:setEngineTweak(tweak)
  self.gameVehicle.engineTweak = tweak or 1
end
function vehicleTemplate:getInstance()
  local taskObject = self:getTaskObject()
  return taskObject and taskObject.coreData.instance
end
local defaultWanderingBehaviour = {
  personality = "civ",
  traits = {
    wanderType = "obeyTrafficRules",
    avoidedByCivilianTraffic = true,
    stayInLockedArea = true
  }
}
function vehicleTemplate:randomWanderWithGetawayBehaviour()
  self:randomWander(felony_getaway.getGetawayBehaviourPerChapter())
end
function vehicleTemplate:randomWander(customBehaviour)
  self:highSpeedDrive(customBehaviour or defaultWanderingBehaviour)
end
function vehicleTemplate:stopHighSpeedDriving(vehicleDeleted)
  self:avoidanceRemovalCheck(vehicleDeleted)
  if self.highSpeedDriving then
    ActiveLifeAI.stopActiveLife(self.gameVehicle)
    self.highSpeedDriving = false
  end
end
function vehicleTemplate:highSpeedDrive(params)
  assert(self.isLocal, "Attempt to set AI driving on a remote SNV")
  if self.highSpeedDriving then
    self:avoidanceRemovalCheck()
  end
  local parameters = {}
  parameters.personality = params.personality
  parameters.roadRoute = params.roadRoute
  parameters.routeName = params.routeName
  parameters.opponentGameVehicle = params.opponentGameVehicle
  parameters.destinationPosition = params.destinationPosition
  parameters.mode = params.mode
  parameters.traits = {}
  parameters.traits = duplicateTable(params.traits, parameters.traits)
  if not parameters.traits then
    local traits = {
      desiredSpeed = 50,
      spawnSpeed = 0,
      avoidAlleyways = 1
    }
  end
  if parameters.traits then
    traits.desiredSpeed = (traits.desiredSpeed or 50) * 0.44704
    traits.spawnSpeed = (traits.spawnSpeed or 30) * 0.44704
    traits.driveOnOncoming = traits.driveInOncoming or 0.1
    traits.driveOnPavements = traits.driveOnPavements or 0.1
    traits.avoidAlleyways = traits.avoidAlleyways or 1
    traits.ignoreOtherAIs = traits.ignoreOtherAis
    traits.forceHighLodAI = traits.forceHighLodAi
    traits.rubberBandAffectedByRaceSpeedTweaks = true
    if traits.unaffectedByRaceSpeedTweaks then
      traits.rubberBandAffectedByRaceSpeedTweaks = false
    end
    if traits.collisionResilience and collisionResilience[traits.collisionResilience] then
      for attribute, value in next, collisionResilience[traits.collisionResilience], nil do
        traits[attribute] = value
      end
    else
      print("The collisionResilience you tried to set this vehicle (" .. tostring(traits.collisionResilience) .. ") to does not exist. Setting to default.")
      for attribute, value in next, collisionResilience.Average, nil do
        traits[attribute] = value
      end
    end
    if traits.drivingSkill and drivingSkill[traits.drivingSkill] then
      for attribute, value in next, drivingSkill[traits.drivingSkill], nil do
        traits[attribute] = value
      end
    else
      print("The drivingSkill you tried to set this vehicle (" .. tostring(traits.drivingSkill) .. ") to does not exist. Setting to default.")
      for attribute, value in next, drivingSkill.Average, nil do
        traits[attribute] = value
      end
    end
    local taskObject = self:getTaskObject()
    if traits.rubberBandMinVelocityTopSpeedFraction then
      traits.rubberBandMaxVelocity = self.gameVehicle.topSpeed * 0.44704
      traits.rubberBandMinVelocity = self.gameVehicle.topSpeed * 0.44704 * traits.rubberBandMinVelocityTopSpeedFraction
    elseif taskObject and taskObject.coreData.instance.challenge.name == "Exposition pre crash chase" then
      traits.rubberBandMaxVelocity = traits.desiredSpeed * 3.5
      traits.rubberBandMinVelocity = traits.desiredSpeed * 0.3
    else
      traits.rubberBandMaxVelocity = traits.desiredSpeed * 2
      traits.rubberBandMinVelocity = traits.desiredSpeed * 0.66
    end
    if traits.rubberbandingStrength and rubberbandingStrength[traits.rubberbandingStrength] then
      traits.rubberBandGroupFollowDistance = traits.distanceFromFrontOfGroup
      for attribute, value in next, rubberbandingStrength[traits.rubberbandingStrength], nil do
        traits[attribute] = value
      end
      if traits.speedMultiplierOverride then
        traits.rubberBandGroupStrength = traits.desiredSpeed * traits.speedMultiplierOverride
      else
        traits.rubberBandGroupStrength = traits.desiredSpeed * traits.rubberBandGroupStrength
      end
    else
      for attribute, value in next, rubberbandingStrength.None, nil do
        traits[attribute] = value
      end
    end
    if traits.rubberbandingToPlayerStrength and rubberbandingToPlayerStrength[traits.rubberbandingToPlayerStrength] then
      traits.rubberBandPlayerFollowDistance = traits.distanceBehindPlayer or 0
      for attribute, value in next, rubberbandingToPlayerStrength[traits.rubberbandingToPlayerStrength], nil do
        traits[attribute] = value
      end
      traits.rubberBandPlayerStrength = traits.desiredSpeed * traits.rubberBandPlayerStrength
    else
      for attribute, value in next, rubberbandingToPlayerStrength.None, nil do
        traits[attribute] = value
      end
    end
    if traits.obeyRaceTowingRules then
      local playerTaskObject = localPlayer:getTaskObject()
      if taskObject and playerTaskObject then
        if taskObject.coreData.actor.team == playerTaskObject.coreData.actor.team then
          traits.allowAutoDetachFromPlayerTowTruck = false
          traits.autoDetachFromTowTruckTime = 5
        else
          traits.allowAutoDetachFromPlayerTowTruck = true
          traits.autoDetachFromTowTruckTime = 5
        end
      end
    end
  end
  if not self.highSpeedDriving then
    ActiveLifeAI.createActiveLife(self.gameVehicle, parameters.personality or "racer")
    self.highSpeedDriving = true
  end
  if parameters.roadRoute then
    if parameters.destinationPosition then
      local lastCheckpointPosition = routes[parameters.routeName].checkpoints[#routes[parameters.routeName].checkpoints].position
      local lastCheckpoint = GameVehicleResource.withinRadius(lastCheckpointPosition, parameters.destinationPosition, 0.5)
      ActiveLifeAI.setBehaviour(self.gameVehicle, "FollowRoute", parameters.destinationPosition, parameters.routeName, parameters.roadRoute, lastCheckpoint)
    else
      ActiveLifeAI.setBehaviour(self.gameVehicle, "FollowRoute", parameters.routeName, parameters.roadRoute)
    end
    ActiveLifeAI.setRouteLoop(self.gameVehicle, true)
  elseif parameters.destinationPosition then
    ActiveLifeAI.setBehaviour(self.gameVehicle, "GetToPosition", parameters.destinationPosition)
  elseif parameters.opponentGameVehicle then
    if traits.reactionTime and reactionTime[traits.reactionTime] then
      for attribute, value in next, reactionTime[traits.reactionTime], nil do
        traits[attribute] = value
      end
    else
      for attribute, value in next, reactionTime.Average, nil do
        traits[attribute] = value
      end
    end
    if parameters.mode == "overtaker" then
      ActiveLifeAI.setBehaviour(self.gameVehicle, "GetPastTarget", parameters.opponentGameVehicle)
    else
      ActiveLifeAI.setBehaviour(self.gameVehicle, "Chase", parameters.opponentGameVehicle)
      if not chasingGameVehiclesByChasedGameVehicle[parameters.opponentGameVehicle] then
        RegisterChasedVehicle(parameters.opponentGameVehicle)
      end
      RegisterChasingVehicleAsChaser(parameters.opponentGameVehicle, self.gameVehicle, "AI")
      local aggressionParams = {}
      if traits.groupAggression and groupAggression[traits.groupAggression] and not traits.customAggression then
        for attribute, value in next, groupAggression[traits.groupAggression], nil do
          aggressionParams[attribute] = value
        end
        if traits.attackStationaryVehicle then
          aggressionParams.groupTakeDownMode = "goonNormal"
        else
          aggressionParams.groupTakeDownMode = "copNormal"
        end
        ActiveLifeAI.setGroupBehaviour(self.gameVehicle, "Takedown")
        ActiveLifeAI.setGroupTakedownParameters(self.gameVehicle, aggressionParams)
      elseif traits.customAggression then
        for attribute, value in next, traits.customAggression, nil do
          aggressionParams[attribute] = value
        end
        if traits.attackStationaryVehicle then
          aggressionParams.groupTakeDownMode = "goonNormal"
        else
          aggressionParams.groupTakeDownMode = "copNormal"
        end
        ActiveLifeAI.setGroupBehaviour(self.gameVehicle, "Takedown")
        ActiveLifeAI.setGroupTakedownParameters(self.gameVehicle, aggressionParams)
      else
        aggressionParams.groupFollowMinDistance = traits.tailingDistance or 10
        ActiveLifeAI.setGroupBehaviour(self.gameVehicle, "Follow")
        ActiveLifeAI.setGroupFollowParameters(self.gameVehicle, aggressionParams)
      end
    end
  else
    traits.wanderType = traits.wanderType or "random"
    ActiveLifeAI.setBehaviour(self.gameVehicle, "Wander")
  end
  if traits.rubberbandingActor then
    ActiveLifeAI.setPlayerRBGameVehicle(self.gameVehicle, traits.rubberbandingActor)
  end
  traits.driveInOncoming = nil
  traits.collisionResilience = nil
  traits.drivingSkill = nil
  traits.speedMultiplierOverride = nil
  traits.rubberbandingStrength = nil
  traits.distanceFromFrontOfGroup = nil
  traits.unaffectedByRaceSpeedTweaks = nil
  traits.distanceBehindPlayer = nil
  traits.rubberbandingToPlayerStrength = nil
  traits.reactionTime = nil
  traits.groupAggression = nil
  traits.tailingDistance = nil
  traits.rubberbandingActor = nil
  traits.evasionLikelihood = nil
  traits.attackStationaryVehicle = nil
  traits.rubberBandMinVelocityTopSpeedFraction = nil
  traits.obeyRaceTowingRules = nil
  traits.ignoreOtherAis = nil
  traits.forceHighLodAi = nil
  ActiveLifeAI.setPersonalityTraits(self.gameVehicle, traits)
end
function vehicleTemplate:avoidanceControl()
end
function vehicleTemplate:avoidanceRemovalCheck(vehicleDeleted)
  if chasingGameVehiclesByChasedGameVehicle[self.gameVehicle] then
    for chasingGameVehicle, controlledBy in next, chasingGameVehiclesByChasedGameVehicle[self.gameVehicle], nil do
      if not controlledBy == "Player" and ActiveLifeAI.isVehicleToAvoid(self.gameVehicle, chasingGameVehicle) then
        ActiveLifeAI.removeVehicleToAvoid(self.gameVehicle, chasingGameVehicle)
      end
    end
  else
    for chasedGameVehicle, chasingGameVehicles in next, chasingGameVehiclesByChasedGameVehicle, nil do
      for chasingGameVehicle, controlledBy in next, chasingGameVehicles, nil do
        if chasingGameVehicle == self.gameVehicle then
          if self.controlled and not vehicleDeleted then
            RegisterChasingVehicleAsChaser(chasedGameVehicle, self.gameVehicle, "Player")
          else
            if controlledBy ~= "Player" and ActiveLifeAI.isVehicleToAvoid(chasedGameVehicle, self.gameVehicle) then
              ActiveLifeAI.removeVehicleToAvoid(chasedGameVehicle, self.gameVehicle)
            end
            UnregisterChasingVehicleAsChaser(chasedGameVehicle, self.gameVehicle)
          end
          local deleteChasedFromTable = true
          for k, v in next, chasingGameVehiclesByChasedGameVehicle[chasedGameVehicle], nil do
            deleteChasedFromTable = false
            break
          end
          if deleteChasedFromTable then
            UnregisterChasedVehicle(chasedGameVehicle)
          end
        end
      end
    end
  end
end
function vehicleTemplate:addAIDelay()
  if vehicleWithAIDelay then
    vehicleWithAIDelay:removeAIDelay()
  end
  vehicleWithAIDelay = self
  addUserUpdateFunction("removeAIDelay", self:updateAIDelay(), 10)
  self:addSimulationArea()
  vehicleManagerCoreReflection.setHasAIDelay(self.gameVehicle, true)
end
function vehicleTemplate:updateAIDelay()
  local delay = 1
  local endTime = g_NetworkTime + delay
  return function()
    if vehicleWithAIDelay then
      if self.gameVehicle == progressionSystem.getActivityGameVehicle() then
        self:removeAIDelay()
      elseif g_NetworkTime > endTime then
        if not self.controlled then
          self:randomWander()
        end
        self:removeAIDelay()
      end
    end
  end
end
function vehicleTemplate:removeAIDelay()
  if self == vehicleWithAIDelay then
    removeUserUpdateFunction("removeAIDelay")
    vehicleWithAIDelay = false
    vehicleManagerCoreReflection.setHasAIDelay(self.gameVehicle, false)
  end
end
function getVehicleWithAIDelay()
  return vehicleWithAIDelay
end
function vehicleTemplate:triggerAbility(callback, abilityName, localID)
  local player = localPlayerManager.players[localID]
  if player.currentVehicle and not self.abilityActive and player.currentVehicle == self and player.abilityPoints > 0 and not player.inZap then
    self.abilityActive = self.abilities[abilityName].abilityFunction(self, function()
      self:stopAbility(localID)
    end, localID)
    if self.abilityActive then
      self.activeAbilityName = abilityName
      scoreSystem.showAbilityUse(localID, true)
      self.abilityStopCallback = callback
      addUserUpdateFunction(playerAbilityStrings[localID].stepAbility, self:stepAbility(localID), 4)
      self.abilityStartTime = g_NetworkTime
    end
  end
end
function vehicleTemplate:stepAbility(localID)
  return function()
    if self.activeAbilityName ~= "none" then
      self.abilities[self.activeAbilityName].stepAbilityFunction(self, localID)
    end
  end
end
function vehicleTemplate:stopAbilityFunction(localID)
  return function()
    if self.abilityActive then
      if self.abilities[self.activeAbilityName].stopAbilityFunction(self, localID) then
        self:stopAbilityInternal(localID)
        removeUserUpdateFunction(playerAbilityStrings[localID].stopAbility)
      end
    else
      removeUserUpdateFunction(playerAbilityStrings[localID].stopAbility)
    end
  end
end
function vehicleTemplate:stopAbility(localID)
  addUserUpdateFunction(playerAbilityStrings[localID].stopAbility, self:stopAbilityFunction(localID), 1)
end
function vehicleTemplate:cancelAbility(localID)
  self.abilities[self.activeAbilityName].cancelAbilityFunction(self, localID)
  self:stopAbilityInternal(localID)
end
function vehicleTemplate:stopAbilityInternal(localID)
  local vehicle = localPlayerManager.players[localID].currentVehicle
  if vehicle and vehicle.activeAbilityName == "ram" then
    Sound.OnAbilityButtonReleased(vehicle.gameVehicle, "Ram", localID)
  end
  scoreSystem.showAbilityUse(localID, false)
  removeUserUpdateFunction(playerAbilityStrings[localID].stepAbility)
  self.abilityActive = false
  self.activeAbilityName = "none"
  self.abilityStopTime = g_NetworkTime
  self.abilityStartTime = 0
end
_G.g_collisionData = {
  GameVehicle = nil,
  CollidedGameVehicle = nil,
  GameVehicleResponsibleForCollision = nil,
  Force = nil,
  Time = nil,
  ObjectPreColVelocity = vec.vector(0, 0, 0, 0),
  CollidedObjectPreColVelocity = vec.vector(0, 0, 0, 0),
  CollidedNormalY = nil,
  CollidedNormalDotVehicleY = nil,
  Type = nil,
  WhereIHit = nil,
  WhereIWasHit = nil
}
function vehicleTemplate:addCollisionCallback(params)
  self.collisionCallbacks[params] = true
  params.gameVehicle = self.gameVehicle
  assert(GameVehicleResource.RegisterCollisionCallback(params) == 0, "Failed to create collision callback - too many already active")
end
function vehicleTemplate:removeCollisionCallback(params)
  if self.collisionCallbacks[params] then
    self.collisionCallbacks[params] = nil
  end
  GameVehicleResource.UnRegisterCollisionCallback(params)
end
function vehicleTemplate:removeAllCollisionCallbacks()
  for params, __ in next, self.collisionCallbacks, nil do
    GameVehicleResource.UnRegisterCollisionCallback(params)
    self.collisionCallbacks[params] = nil
  end
end
local lightDefaults = {
  gameVehicle = false,
  LightType = false,
  State = false
}
function vehicleTemplate:setLights(type, state)
  lightDefaults.gameVehicle = self.gameVehicle
  lightDefaults.LightType = type
  lightDefaults.State = state
  GameVehicleResource.setLights(lightDefaults)
  lightDefaults.gameVehicle = false
end
function vehicleTemplate:activateSiren(fromFelonySystem)
  GameVehicleResource.setSiren(self.gameVehicle, true)
  self:setLights("Siren", true)
  if fromFelonySystem then
    self.felonySiren = true
  else
    self.siren = true
  end
end
function vehicleTemplate:deactivateSiren(fromFelonySystem)
  if fromFelonySystem and not self.siren or not fromFelonySystem and not self.felonySiren then
    GameVehicleResource.setSiren(self.gameVehicle, false)
    self:setLights("Siren", false)
  end
  if fromFelonySystem then
    self.felonySiren = false
  else
    self.siren = false
  end
end
local defaultLightTrailColour = vec.vector(1, 0, 0, 0.5)
local defaultLightTrailLength = 16
local defaultLightTrailStyle = 1
local addLightTrailDefaults = {
  gameVehicle = false,
  Length = defaultLightTrailLength,
  Colour = defaultLightTrailColour,
  Style = defaultLightTrailStyle,
  Collidable = true,
  Type = 0
}
function vehicleTemplate:addLightTrail(length, vectorColour, trailStyle, collidable)
  addLightTrailDefaults.gameVehicle = self.gameVehicle
  addLightTrailDefaults.Length = length or defaultLightTrailLength
  addLightTrailDefaults.Colour = vectorColour or defaultLightTrailColour
  addLightTrailDefaults.Style = trailStyle or defaultLightTrailStyle
  addLightTrailDefaults.Collidable = collidable or false
  GameVehicleResource.setTrail(addLightTrailDefaults)
  addLightTrailDefaults.gameVehicle = false
  self.lightTrail = true
end
lightTrailTable = {}
lightTrailZapState = false
function lightTrailCallback(zapLevel)
  if zapLevel ~= lightTrailZapState then
    for gameVehicle, data in next, lightTrailTable, nil do
      data.update = true
    end
    lightTrailZapState = zapLevel
  end
end
local removeLightTrailDefaults = {gameVehicle = false, Type = 0}
function vehicleTemplate:removeLightTrail()
  removeLightTrailDefaults.gameVehicle = self.gameVehicle
  GameVehicleResource.clearTrail(removeLightTrailDefaults)
  removeLightTrailDefaults.gameVehicle = false
  self.lightTrail = false
end
function vehicleTemplate:setLightTrailColour(vectorColour)
  GameVehicleResource.setTrailColour(self.gameVehicle, vectorColour, 0)
end
function vehicleTemplate:setLightTrailLength(length)
  GameVehicleResource.setTrailLength(self.gameVehicle, length)
end
function vehicleTemplate:disableLightTrailAutoDelete(disable)
  self.disableTrailAutoDelete = disable
end
function vehicleTemplate:get_closestRoadIndex()
  return self.gameVehicle.closestRoadIndex
end
function vehicleTemplate:get_closestDistanceAlongRoad()
  return self.gameVehicle.closestDistanceAlong
end
function vehicleTemplate:get_closestDistanceAcrossRoad()
  return self.gameVehicle.closestDistanceAcross
end
function vehicleTemplate:get_closestTransformationOnRoad()
  return self.gameVehicle.closestTransformationOnRoad
end
function vehicleTemplate:get_withTrafficFlow()
  return self.gameVehicle.withTrafficFlow
end
function vehicleTemplate:get_onMainRoad()
  return self.gameVehicle.onMainRoad
end
function vehicleTemplate:get_damageMultiplier()
  return self.gameVehicle.softness
end
function vehicleTemplate:set_damageMultiplier(value)
  self.gameVehicle.softness = value
  if self.gameVehicle.towedVehicle then
    self.gameVehicle.towedVehicle.softness = value
  end
  if gameStatus.onlineSession then
    for localID, player in next, localPlayerManager.players, nil do
      if player.currentVehicle == self then
        if value == 0 then
          feedbackSystem.menusMaster.disableDamageBar(player)
        else
          feedbackSystem.menusMaster.enableDamageBar(player)
        end
      end
    end
  end
end
function vehicleTemplate:removeTemporaryInvulnerability()
  local string = tostring(self.gameVehicle) .. " invulnerablity"
  if userUpdateFunctions[string] then
    GameVehicleResource.setDisableAllDamage(self.gameVehicle, false)
    removeUserUpdateFunction(string)
  end
end
local stepTemporaryInvulnerability = function(vehicle, timeToRemove)
  return function()
    if timeToRemove < g_NetworkTime then
      vehicle:removeTemporaryInvulnerability()
    end
  end
end
function vehicleTemplate:addTemporaryInvulnerability(duration)
  local duration = duration or 2
  local timeToRemove = g_NetworkTime + duration
  GameVehicleResource.setDisableAllDamage(self.gameVehicle, true)
  addUserUpdateFunction(tostring(self.gameVehicle) .. " invulnerablity", stepTemporaryInvulnerability(self, timeToRemove), 4)
end
function vehicleTemplate:set_damageCauseScale(value)
  self.gameVehicle.damageCauseScale = value
end
function vehicleTemplate:addSimulationArea()
  GameVehicleResource.addVehicleSimulationArea(self.gameVehicle)
end
function vehicleTemplate:removeSimulationArea()
  GameVehicleResource.removeVehicleSimulationArea(self.gameVehicle)
end
function vehicleTemplate:setMaximumDamagePerCollision(value)
  self.gameVehicle.maxOneHitDamage = value
end
function vehicleTemplate:getMaximumDamagePerCollision()
  return self.gameVehicle.maxOneHitDamage
end
function vehicleTemplate:setMaximumDamageAllowed(value)
  self.gameVehicle.maxAllowedDamage = value
end
function vehicleTemplate:getMaximumDamageAllowed(value)
  return self.gameVehicle.maxAllowedDamage
end
local emergencyTypeLookupTable = {
  [0] = "Civilian",
  [1] = "Fire",
  [2] = "Police",
  [3] = "Ambulance"
}
function vehicleTemplate:getEmergencyType()
  local type = GameVehicleResource.getEmergencyType(self.gameVehicle)
  return emergencyTypeLookupTable[type]
end
function vehicleTemplate:lockEmergencyBrakes(overTime)
  GameVehicleResource.lockEmergencyBrakes(self.gameVehicle, overTime)
end
function vehicleTemplate:unlockEmergencyBrakes()
  GameVehicleResource.unlockEmergencyBrakes(self.gameVehicle)
end
function vehicleTemplate:get_highSpeedDrivingReachedDestination()
  return ActiveLifeAI.isWandering(self.gameVehicle)
end
function vehicleTemplate:get_highSpeedDrivingRoadRouteReachedDestination()
  return ActiveLifeAI.isWandering(self.gameVehicle)
end
localVehicleDisplay = false
local minimapStrings = {
  [0] = "miniMapMarker0",
  [1] = "miniMapMarker1"
}
local flashStrings = {
  [0] = "flashColour0",
  [1] = "flashColour1"
}
local minimapColourStrings = {
  [0] = "miniMapColour0",
  [1] = "miniMapColour1"
}
function vehicleTemplate:setDisplayColour(colour, devColour)
  self.displayColour = colour
  self.displayDevColour = devColour
  self.colourSet = true
  self.disableFeedback = false
  if not self.flashColourOverride then
    self.flashColourOverride = {
      [0] = false,
      [1] = false
    }
  end
end
function vehicleTemplate:defaultDisplayColour()
  self.displayColour = OnlineModeSettings.pink32
  self.displayDevColour = OnlineModeSettings.pink128
  self.colourSet = nil
  self.disableFeedback = true
  self.flashColourOverride = nil
end
function vehicleTemplate:disableDisplay(disable)
  if disable then
    self.disableFeedback = true
    for localID, player in next, localPlayerManager.players, nil do
      self:deleteDisplay(nil, localID)
    end
  else
    self.disableFeedback = nil
  end
end
function vehicleTemplate:deleteDisplay(GVdeletion, localID)
  if localID == nil then
    for localID, player in next, localPlayerManager.players, nil do
      self:deleteDisplay(GVdeletion, localID)
    end
    return
  end
  self:defaultDisplayColour()
  self.disableFeedback = true
  if self[minimapStrings[localID]] then
    Marker:delete(self[minimapStrings[localID]])
    self[minimapStrings[localID]] = nil
    self[minimapColourStrings[localID]] = nil
  end
  if self[flashStrings[localID]] and not GVdeletion then
    SNV.resetFlashColour(self.SNVID, localID)
  end
  self[flashStrings[localID]] = nil
end
function vehicleTemplate:disableMinimapMarker(value)
  if value then
    self.minimapMarkerDisable = value
    for localID, player in next, localPlayerManager.players, nil do
      if self[minimapStrings[localID]] then
        Marker:delete(self[minimapStrings[localID]])
        self[minimapStrings[localID]] = nil
        self[minimapColourStrings[localID]] = nil
      end
    end
  else
    self.minimapMarkerDisable = false
  end
end
function vehicleTemplate:stepVehicleDisplayForPlayer(localID)
  plr = localPlayerManager.getPlayerById(localID)
  self:stepVehicleDisplay(zap.currentLevel[plr.localID], plr)
end
function vehicleTemplate:stepVehicleDisplayForPlayers(isSplitScreen)
  plr = localPlayerManager.getPlayerById(0)
  self:stepVehicleDisplay(zap.currentLevel[plr.localID], plr)
  if isSplitScreen then
    plr = localPlayerManager.getPlayerById(1)
    if plr then
      self:stepVehicleDisplay(zap.currentLevel[plr.localID], plr)
    end
  end
end
local steppingDisplayForLocalPlayer = false
function vehicleTemplate:stepVehicleDisplay(zapLevel, plr)
  if self.disableFeedback then
    return
  end
  steppingDisplayForLocalPlayer = localPlayerManager.getPlayerByGameVehicle(self.gameVehicle) == plr
  if not steppingDisplayForLocalPlayer then
    if (not self[minimapStrings[plr.localID]] or self[minimapColourStrings[plr.localID]] ~= self.displayColour) and not self.minimapMarkerDisable then
      if self[minimapStrings[plr.localID]] then
        Marker:delete(self[minimapStrings[plr.localID]])
        self[minimapStrings[plr.localID]] = nil
        self.miniMapColour = nil
      end
      self[minimapColourStrings[plr.localID]] = self.displayColour
      self[minimapStrings[plr.localID]] = Marker:create({
        type = "Minimap",
        gameVehicle = self.gameVehicle,
        gadgetID = 3,
        colour = self.displayColour,
        radius = 30,
        visible = true,
        localID = plr.localID
      })
    end
  elseif self[minimapStrings[plr.localID]] and self[minimapStrings[plr.localID]] then
    Marker:delete(self[minimapStrings[plr.localID]])
    self[minimapStrings[plr.localID]] = nil
    self[minimapColourStrings[plr.localID]] = nil
  end
  if steppingDisplayForLocalPlayer then
    return
  end
  if multiplayerBusManager.playerInMultiplayerBus then
    zapLevel = 1
  end
  if zapLevel < 4 then
    if self[flashStrings[plr.localID]] ~= self.displayColour and not self:vehicleFlashOverridden(plr.localID) then
      SNV.setFlashColour(self.SNVID, self.displayDevColour, plr.localID)
      self[flashStrings[plr.localID]] = self.displayColour
    end
  elseif self[flashStrings[plr.localID]] then
    SNV.resetFlashColour(self.SNVID, plr.localID)
    self[flashStrings[plr.localID]] = nil
  end
end
function vehicleTemplate:overRideFlashColour(colour, devColour, localID)
  localID = localID or 0
  SNV.setFlashColour(self.SNVID, devColour, localID)
  self[flashStrings[localID]] = colour
  if not self.flashColourOverride then
    self.flashColourOverride = {
      [0] = false,
      [1] = false
    }
  end
  self.flashColourOverride[localID] = true
end
function vehicleTemplate:vehicleFlashOverridden(localID)
  localID = localID or 0
  if not self.flashColourOverride then
    return false
  else
    return self.flashColourOverride[localID]
  end
end
function vehicleTemplate:removeFlashColourOverRide(localID)
  localID = localID or 0
  self[flashStrings[localID]] = nil
  SNV.resetFlashColour(self.SNVID, localID)
  if not self.flashColourOverride then
    self.flashColourOverride = {
      [0] = false,
      [1] = false
    }
  end
  self.flashColourOverride[localID] = false
end
function vehicleTemplate:teleport(matrix)
  self.gameVehicle.matrix = matrix
  self.matrix = matrix:clone()
  GameVehicleResource.position(self.gameVehicle, self.position)
  GameVehicleResource.transform(self.gameVehicle, self.matrix)
  self.heading, self.speed, self.damage = GameVehicleResource.getHeadingSpeedDamage(self.gameVehicle)
end
function updatePositionCaches(gameVehicle)
  local scripted = vehiclesByGameVehicle[gameVehicle]
  GameVehicleResource.position(gameVehicle, scripted.position)
  GameVehicleResource.transform(gameVehicle, scripted.matrix)
  scripted.heading, scripted.speed, scripted.damage = GameVehicleResource.getHeadingSpeedDamage(gameVehicle)
end
_G.updatePositionCaches = updatePositionCaches
function vehicleTemplate:teleportToMatrix(matrix, fullyFadedOutFunction, fadeInFunction, fullyFadedInFunction, enableFade, colour)
  local taskObject = self:getTaskObject()
  if self.controlled and not localPlayer.inCutsceneOrIcam then
    localPlayer.teleporting = true
    spooling.waitForSpooling(matrix[3], function()
      self:teleport(matrix)
      localPlayer:resetCameraMode()
      if fullyFadedOutFunction then
        fullyFadedOutFunction()
      end
    end, function()
      spooling.clearAreaOfVehicles(self.gameVehicle.position, 15)
      if fadeInFunction then
        fadeInFunction()
      end
    end, function()
      if fullyFadedInFunction then
        fullyFadedInFunction()
      end
      localPlayer.teleporting = false
    end, nil, nil, not enableFade, enableFade, colour)
  else
    self:teleport(matrix)
  end
end
function vehicleTemplate:teleportToPositionAndHeading(position, heading, fullyFadedOutFunction, fadeInFunction, fullyFadedInFunction, enableFade, colour)
  local matrix = setYRotation(heading)
  matrix[3] = position
  self:teleportToMatrix(matrix, fullyFadedOutFunction, fadeInFunction, fullyFadedInFunction, enableFade, colour)
end
function vehicleTemplate:missionStartTeleport(matrix)
  local taskObject = self:getTaskObject()
  if not taskObject.coreData.actor.spawn.relativeToVehicle or taskObject.coreData.actor.spawn.position then
    local missionTeleportLocation = taskObject.coreData.actor.spawn.missionTeleportLocation
    if missionTeleportLocation and not localPlayer.challenge.retryingMission then
      matrix = setYRotation(missionTeleportLocation.heading)
      matrix[3] = missionTeleportLocation.position
    end
    if matrix then
      self:teleport(matrix)
    end
    if not taskObject.coreData.actor.warmup or not taskObject.coreData.actor.missionStartSpawn and taskObject.coreData.actor.warmup and not taskObject.coreData.actor.warmup.static then
      local speed = 13.4112
      if taskObject.coreData.actor.spawnSpeed and taskObject.coreData.actor.spawnSpeed ~= 0 then
        speed = taskObject.coreData.actor.spawnSpeed * 0.44704
      end
      self.gameVehicle.velocity = self.gameVehicle.matrix[2] * speed
    end
  end
end
function vehicleTemplate:clearTrafficAheadOfVehicle(offset, radius)
  local radius = radius or 10
  local offset = offset or vec.vector(0, 0, 12, 0)
  local heading = self.heading
  local position = self.position:clone()
  position.x = position.x + offset.x * math.cos(heading) + offset.z * math.sin(heading)
  position.z = position.z + offset.z * math.cos(heading) - offset.x * math.sin(heading)
  GameVehicleResource.ClearAreaOfVehicles(position, radius)
end
function getAgentFromGameVehicle(gameVehicle)
  return vehicleManager.vehiclesByGameVehicle[gameVehicle]
end
local highLODGameVehicle = false
function getHighLODGameVehicle()
  return highLODGameVehicle
end
function applyHighLODOccupants(gameVehicle, actorID)
  if not highLODGameVehicle then
    GameVehicleResource.spoolOccupants(gameVehicle)
    GameVehicleResource.upgradeOccupants(gameVehicle)
    highLODGameVehicle = gameVehicle
  else
    print("====================================================================")
    print("WARNING: You tried to applied high LOD occupants to more than 1 vehicle")
    print("This gameVehicle is already using the high LOD slot" .. tostring(highLODGameVehicle) .. " so this one can't " .. tostring(gameVehicle))
    print("====================================================================")
  end
end
function removeHighLODOccupants(gameVehicle)
  if highLODGameVehicle and gameVehicle == highLODGameVehicle then
    if (not localPlayer.primaryFelony.getawayGameVehicle or localPlayer.primaryFelony.getawayGameVehicle ~= gameVehicle) and (not localPlayer.primaryFelony.chasers or not localPlayer.primaryFelony.chasers[gameVehicle]) then
      GameVehicleResource.downgradeOccupants(gameVehicle)
    end
    highLODGameVehicle = false
  end
end
function removeAllHighLODOccupants()
  if highLODGameVehicle then
    GameVehicleResource.downgradeOccupants(highLODGameVehicle)
  end
end
function reapplyAllHighLODOccupants()
  if highLODGameVehicle then
    GameVehicleResource.spoolOccupants(highLODGameVehicle)
    GameVehicleResource.upgradeOccupants(highLODGameVehicle)
  end
end
function RegisterVehicle(gameVehicle)
  registerVehicle({gameVehicle = gameVehicle})
end
function CheckVehicleChaser(playerGameVehicle, gameVehicle)
  for chasedGameVehicle, chasingGameVehicles in next, chasingGameVehiclesByChasedGameVehicle, nil do
    if chasedGameVehicle == gameVehicle then
      for chasingGameVehicle, controlledBy in next, chasingGameVehicles, nil do
        if controlledBy == "Player" and chasingGameVehicle == playerGameVehicle then
          return true
        end
      end
    end
  end
  return false
end
function deleteVehicle(gameVehicle)
  local vehicleAgent = vehiclesByGameVehicle[gameVehicle]
  if vehicleAgent then
    vehicleAgent:delete()
  else
    GameVehicleResource.destroy(gameVehicle)
  end
end
function activeLifeBehaviourCompleteCallback(gameVehicle)
  if felony_chase.goalCallbacks.getawayFinishedLap then
    for i, callback in ipairs(felony_chase.goalCallbacks.getawayFinishedLap) do
      callback(gameVehicle)
    end
  end
end
function vehicleTemplate:canBeDeleted()
  return SNV.canBeDeleted(self.SNVID)
end
