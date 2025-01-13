module("vehicleManager", package.seeall)
numVehicles = 0
vehiclesByGameVehicle = {}
vehiclesBySNVID = {}
function initialise()
  GameVehicleResource.setVehicleCollisionZoneScalars(3.5, 4.9, 4)
  GameVehicleResource.setVehicleCollisionMassEqualiser(4000)
  GameVehicleResource.setOverallDamageScalar(0.025)
  GameVehicleResource.setDamageLinearQuadTransitionScale(1.9)
end
addInitObject(initialise)
function update()
  vehicleManagerCoreReflection.update()
end
function purge()
  multiplayerBusManager.deleteMultiplayerBus()
  for localID, plr in next, localPlayerManager.players, nil do
    player.setAttachment(plr.localID, plr.camera)
  end
  for gameVehicle, vehicle in next, vehiclesByGameVehicle, nil do
    vehicle:delete()
  end
  clearDamageDetectionCallbacks()
end
function registerVehicle(parameters)
  assert(parameters.gameVehicle, "VEHICLEMANAGER - registerVehicle: NO GAMEVEHICLE GIVEN")
  assert(not vehiclesByGameVehicle[parameters.gameVehicle], "VEHICLEMANAGER - registerVehicle: GAMEVEHICLE ALREADY REGISTERED TO VEHICLES LIST")
  if parameters.forceVelocity then
    parameters.gameVehicle.velocity = parameters.forceVelocity
  end
  local vehicle = {
    gameVehicle = parameters.gameVehicle
  }
  setmetatable(vehicle, vehicleTemplate)
  vehicleManagerCoreReflection.registerVehicle(vehicle.gameVehicle)
  vehicle.networkVars = {
    vehicleTemplateOwner = vehicle,
    debugCheckIsLocal = function()
      return vehicle.isLocal
    end,
    updateRequired = false,
    __newindex = networkParsing.metaSetNetworkVar,
    __index = parameters.networkVars or {}
  }
  setmetatable(vehicle.networkVars, vehicle.networkVars)
  vehicleManagerCoreReflection.synchNetworkVars(vehicle.gameVehicle, vehicle.networkVars)
  vehicle.SNVID = SNV.getSNVFromGameVehicle(parameters.gameVehicle)
  vehicle.isLocal = SNV.isLocal(vehicle.SNVID)
  vehicleManagerCoreReflection.setIsLocal(vehicle.gameVehicle, vehicle.isLocal)
  if vehicle.isLocal then
    vehicle:updateLocalSNV()
  end
  vehicle.gameVehicle.owner = "Script"
  vehicle.abilityActive = false
  vehicle.activeAbilityName = "none"
  vehicle.abilityStopTime = 0
  vehicle.abilityStartTime = 0
  vehicle.collisionCallbacks = {}
  vehicle.position = vehicle.gameVehicle.position
  vehicle.matrix = vehicle.gameVehicle.transform
  vehicle.heading = vehicle.gameVehicle.heading
  vehicle.speed = vehicle.gameVehicle.speed
  vehicle.damage = vehicle.gameVehicle.damage
  vehicle.highSpeedDriving = false
  vehicle.model_id = vehicle.gameVehicle.model_id
  vehicle.disableHandbrake = vehicle.gameVehicle.disableHandbrake or false
  numVehicles = numVehicles + 1
  vehiclesByGameVehicle[vehicle.gameVehicle] = vehicle
  vehiclesBySNVID[vehicle.SNVID] = vehicle
  NetworkLog.Write(">[LUA] VEHICLE MANAGER - Registered vehicle, SNVID = " .. tostring(vehicle.SNVID) .. ", isLocal = " .. tostring(vehicle.isLocal))
  if gameStatus.onlineSession then
    vehicle:defaultDisplayColour()
  end
  return vehicle
end
function unregisterVehicle(vehicle, GVdeletion)
  assert(vehiclesByGameVehicle[vehicle.gameVehicle], "VEHICLEMANAGER - unregisterVehicle: VEHICLE NOT FOUND IN REGISTERED VEHICLES LIST")
  NetworkLog.Write(">[LUA] VEHICLE MANAGER - Unregistering vehicle, SNVID = " .. tostring(vehicle.SNVID) .. ", isLocal = " .. tostring(vehicle.isLocal) .. ", userData = " .. tostring(vehicle.gameVehicle))
  packageManager.vehicleBeingDeleted(vehicle)
  taskSystem.removeMissionSpecifics(vehicle)
  if chasingGameVehiclesByChasedGameVehicle[vehicle.gameVehicle] then
    for chasingGameVehicle, bool in next, chasingGameVehiclesByChasedGameVehicle[vehicle.gameVehicle], nil do
      if vehicleManager.vehiclesByGameVehicle[chasingGameVehicle] then
        vehicleManager.vehiclesByGameVehicle[chasingGameVehicle]:stopHighSpeedDriving()
      end
    end
  end
  vehicle:stopHighSpeedDriving(true)
  vehicle:setDebugRequiredVehicles(false)
  vehicle:removeAllCollisionCallbacks()
  vehicle:removeTemporaryInvulnerability()
  vehicle:removeAIDelay()
  vehicle:removeSimulationArea()
  selfRightVehicleList.removeTableOfVehicles({
    vehicle.gameVehicle
  })
  removeHighLODOccupants(vehicle.gameVehicle)
  civilianTraffic.RemoveVehicleFromCarrier(vehicle.gameVehicle)
  vehicleManager.UnregisterChasedVehicle(vehicle.gameVehicle)
  vehicleManagerCoreReflection.unregisterVehicle(vehicle.gameVehicle)
  numVehicles = numVehicles - 1
  vehiclesByGameVehicle[vehicle.gameVehicle] = nil
  vehiclesBySNVID[vehicle.SNVID] = nil
  for localID, player in next, localPlayerManager.players, nil do
    vehicle:deleteDisplay(GVdeletion, localID)
  end
  debugTrackDeletion(vehicle, "vehicle")
end
function spawnVehicle(parameters)
  parameters.gameVehicle = GameVehicleResource.create({
    SnapToTerrain = parameters.snapToTerrain or true,
    Model_Id = parameters.modelID,
    ShaderParams = parameters.shader,
    Matrix = parameters.matrix,
    Position = parameters.position,
    Heading = parameters.heading,
    InitialVelocity = parameters.initialVelocity,
    DisableHandbrake = parameters.disableHandbrake or false,
    MinKillDamageChange = parameters.minKillDamageChange or 0.05,
    NoOccupants = parameters.actor and parameters.actor.noOccupants,
    PanelSet = parameters.panelSet or nil,
    DisablePanelDetach = parameters.disablePanelDetach or nil
  })
  local vehicle = registerVehicle(parameters)
  return vehicle
end
function applyGeneralVehicleSettings(vehicle, actor)
  local characters = actor.characters or {}
  if not actor.noOccupants then
    for j = 0, 3 do
      if not characters[j] then
        if j == 0 then
          characters[j] = 0
        else
          characters[j] = -1
        end
      end
      GameVehicleResource.setCharacterSpoolingEntityIndex(vehicle.gameVehicle, j, characters[j])
    end
  end
  if actor.enableSiren then
    vehicle:activateSiren()
  end
end
function applyInMissionVehicleSettings(vehicle, actor)
  if actor.applyDamage then
    GameVehicleResource.applyDamage({
      gameVehicle = vehicle.gameVehicle,
      damage = actor.applyDamage
    })
  end
  if actor.damageMultiplier and actor.damageMultiplier ~= 1 then
    vehicle:set_damageMultiplier(actor.damageMultiplier)
  end
  if actor.maxAllowedDamage then
    vehicle:setMaximumDamageAllowed(actor.maxAllowedDamage)
  end
  if actor.damageCauseScale then
    vehicle:set_damageCauseScale(actor.damageCauseScale)
  end
  if actor.maximumDamagePerCollision then
    vehicle:setMaximumDamagePerCollision(actor.maximumDamagePerCollision)
  end
  if actor.enableSimulationArea then
    vehicle:addSimulationArea()
  end
  if actor.blockTow then
    vehicle.blockTow = true
  end
  if actor.takeNonPlayerDamage then
    GameVehicleResource.playerOnlyTakedown({
      gameVehicle = vehicle.gameVehicle,
      enabled = false
    })
  end
  if actor.forceHighLodCharacters then
    applyHighLODOccupants(vehicle.gameVehicle, actor.ID)
  end
  if actor.selfRightIfOverturned then
    selfRightVehicleList.addTableOfVehicles({
      vehicle.gameVehicle
    })
  end
end
function convertOrphanToScript(gameVehicle)
  if gameVehicle and gameVehicle.model_id then
    NetworkLog.Write(">[LUA] VEHICLE MANAGER - Converting orphan vehicle to script")
    SNV.setScriptedState(SNV.getSNVFromGameVehicle(gameVehicle), true)
    local vehicle = registerVehicle({gameVehicle = gameVehicle})
    return vehicle
  end
  return false
end
_G.convertOrphanToAgent = convertOrphanToScript
function takeOwnership(params)
  local gameVehicle = params.gameVehicle
  if gameVehicle.owner == "Orphan" then
    convertOrphanToScript(gameVehicle)
  elseif not vehiclesByGameVehicle[gameVehicle] then
    if gameVehicle.towingVehicle then
      params.forceVelocity = nil
    end
    registerVehicle(params)
  end
  local vehicle = vehiclesByGameVehicle[gameVehicle]
  if gameVehicle.towedVehicle then
    vehicle.isTowing = true
  end
  if gameVehicle.isBeingTowed then
    vehicle.beingTowed = true
  end
  return vehicle
end
function parentPreDeletionCallback(parentGameVehicle, childGameVehicle)
  local gameVehicle = GameVehicleResource.create({
    Model_Id = parentGameVehicle.model_id,
    ShaderParams = parentGameVehicle.shaderParams,
    Matrix = parentGameVehicle.matrix,
    InitialVelocity = parentGameVehicle.velocity
  })
  local vehicle = registerVehicle({gameVehicle = gameVehicle})
  vehicle:randomWander()
  vehicle:setDebugRequiredVehicles(true)
  GameVehicleResource.unregisterAttachCallback(vehicleManager.hookupCallback)
  GameVehicleResource.unregisterDetachCallback(vehicleManager.unhookCallback)
  GameVehicleResource.detachVehicle(parentGameVehicle)
  GameVehicleResource.attachVehicle({
    LeadGameVehicle = gameVehicle,
    TowedGameVehicle = childGameVehicle,
    Instant = true
  })
  GameVehicleResource.registerAttachCallback(vehicleManager.hookupCallback)
  GameVehicleResource.registerDetachCallback(vehicleManager.unhookCallback)
  return true
end
_G.parentPreDeletionCallback = parentPreDeletionCallback
function hookupCallback(towingGameVehicle, towedGameVehicle)
  local towingVehicle = vehiclesByGameVehicle[towingGameVehicle]
  local towedVehicle = vehiclesByGameVehicle[towedGameVehicle]
  if towedVehicle and towedVehicle.blockTow then
    return false
  else
    if towedVehicle then
      towedVehicle.beingTowed = true
    end
    if towingVehicle then
      towingVehicle.isTowing = true
    end
    if not towingGameVehicle.isArtic then
      feedbackSystem.menusMaster.clearAllTextPrompts()
      if towedVehicle and towedVehicle:getTaskObject() then
        GameVehicleResource.registerParentPreDeletionCallback(vehicleManager.parentPreDeletionCallback, towedGameVehicle)
      end
    end
    if towedVehicle and towedVehicle.zapToTowingVehicle then
      localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
      localPlayer:ZapIntoVehicle(towingGameVehicle, false, false, false, nil, {disableZapFlash = true})
      localPlayer:buildZapReturn()
    end
    if towedVehicle and towedVehicle.controlled or towingVehicle and towingVehicle.controlled then
      ProfileSettings.SetNumVehiclesTowed(ProfileSettings.GetNumVehiclesTowed() + 1)
      localPlayer.controllerInterface:createCallbacks()
    end
    return true
  end
end
_G.hookupCallback = hookupCallback
function unhookCallback(towingGameVehicle, towedGameVehicle)
  local towedVehicle = vehiclesByGameVehicle[towedGameVehicle]
  local towingVehicle = vehiclesByGameVehicle[towingGameVehicle]
  if towingVehicle then
    towingVehicle.isTowing = false
  end
  if towedVehicle then
    towedVehicle.beingTowed = false
  end
  if not towingGameVehicle.isArtic then
    GameVehicleResource.unregisterParentPreDeletionCallback(vehicleManager.parentPreDeletionCallback, towedGameVehicle)
  end
  if towedVehicle and towedVehicle.controlled then
    localPlayer.controllerInterface:removePlayerControl()
    localPlayer.controllerInterface:registerPlayerControl()
    localPlayer.controllerInterface:createCallbacks()
  end
end
_G.unhookCallback = unhookCallback
function attachedVehicleCallback(baseGameVehicle, childGameVehicle)
  local baseVehicle = vehiclesByGameVehicle[baseGameVehicle]
  local childVehicle = vehiclesByGameVehicle[childGameVehicle]
  if childVehicle then
    childVehicle:stopHighSpeedDriving()
    childVehicle:setDebugRequiredVehicles(true)
    childVehicle.inTrailer = true
    zapcontroller.AddLockedVehicle(localPlayer.localID, {
      gameVehicle = childVehicle.gameVehicle
    })
    if childVehicle.controlled then
      localPlayer:SetZapLevel(1, nil, true, {forcedOut = true})
    end
    localPlayer:buildZapReturn()
  end
  return true
end
function attachedVehicleDeleteRequest(attachedGameVehicle)
  local attachedVehicle = vehiclesByGameVehicle[attachedGameVehicle]
  if attachedVehicle then
    if attachedVehicle:getTaskObject() then
      attachedVehicle:getTaskObject():delete()
    end
    attachedVehicle:delete()
  end
  return true
end
function noTowCallback()
  return false
end
_G.noTowCallback = noTowCallback
function unhookPlayerVehicle()
  local params = {}
  GameVehicleResource.detachVehicle(localPlayer.currentVehicle.gameVehicle)
end
_G.unhookPlayerVehicle = unhookPlayerVehicle
function unhookPlayerVehicleWithWaggle(state, value)
  c_timeout = 1.5
  c_alternations = 10
  lastDirection = lastDirection or 0
  nextCounter = nextCounter or 0
  waggleCounters = waggleCounters or {}
  local registerWaggle = function(curTime)
    waggleCounters[nextCounter] = curTime
    nextCounter = nextCounter + 1
    if nextCounter == c_alternations then
      nextCounter = 0
    end
    if waggleCounters[nextCounter] and curTime < waggleCounters[nextCounter] + c_timeout then
      unhookPlayerVehicle()
      localPlayer.controllerInterface:resetCallbacks()
    end
  end
  if value > 0.5 then
    if lastDirection == -1 or lastDirection == 0 then
      registerWaggle(g_NetworkTime)
      lastDirection = 1
    end
  elseif value < -0.5 and (lastDirection == 1 or lastDirection == 0) then
    registerWaggle(g_NetworkTime)
    lastDirection = -1
  end
end
_G.unhookPlayerVehicleWithWaggle = unhookPlayerVehicleWithWaggle
function toggleVehicleDisplay(disable)
  disableVehicleDisplay = disable
  if disableVehicleDisplay then
    for gameVehicle, vehicle in next, vehiclesByGameVehicle, nil do
      vehicle:deleteDisplay(zap.currentLevel[localPlayer.localID])
    end
  end
end
function callForDeletion(SNVID, remote)
  local vehicle = vehiclesBySNVID[SNVID]
  if vehicle then
    if vehicle.isLocal then
      vehicle:delete()
    elseif not remote then
      phaseManager.sendMessage(4, SNVID)
    end
  end
end
function clearOrphanage()
  Orphanage.deleteAll()
end
function shouldVehicleHaveHighPhysicsPriority(gameVehicle)
  local instance = challengeSystem.instances[phaseManager.networkVars.modeID]
  local vehicle = vehiclesByGameVehicle[gameVehicle]
  if vehicle and instance and instance.challenge.missionType == "Multiplayer burning rubber" then
    local torchVehicleOne = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    if torchVehicleOne and torchVehicleOne.coreData.agent == vehicle then
      return true
    end
    local torchVehicleTwo = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
    if torchVehicleTwo and torchVehicleTwo.coreData.agent == vehicle then
      return true
    end
  end
  return false
end
_G.shouldVehicleHaveHighPhysicsPriority = shouldVehicleHaveHighPhysicsPriority
local returnValue
function markAllForDeletion()
  returnValue = true
  for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
    if vehicle.isLocal and vehicle.networkVars.onlineRequiredVehicle or vehicle.networkVars.onlineOwnerID then
      vehicle.networkVars.onlineRequiredVehicle = nil
      vehicle.networkVars.onlineOwnerID = nil
    end
    if vehicle.networkVars.onlineRequiredVehicle or vehicle.networkVars.onlineOwnerID then
      returnValue = false
    end
  end
  return returnValue
end
function allObjectsDeleted()
  for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
    return false
  end
  return true
end
