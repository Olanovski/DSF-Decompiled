module("challengeSystem")
function createActors(settings)
  if settings.matricesOnly then
    local matrices = Spawn.Spawn(settings)
    return matrices
  else
    local gameVehicles = Spawn.Spawn(settings)
    local vehicles = {}
    for i, gameVehicle in ipairs(gameVehicles) do
      local vehicle = vehicleManager.registerVehicle({gameVehicle = gameVehicle})
      vehicles[i] = vehicle
    end
    for k, v in next, settings.vehicles, nil do
      if v.trailerID then
        local trailerPanelSet = v.trailerPanelSet or -1
        if GameVehicleResource.createTrailerAndHookup({
          gameVehicle = vehicles[k].gameVehicle,
          panelSet = trailerPanelSet,
          trailerId = v.trailerID,
          shaderParams = v.trailerShaderParams
        }) then
          spooling.clearAreaOfVehicles(vehicles[k].gameVehicle.towedVehicle.matrix[3], 5)
        end
      end
    end
    return vehicles
  end
end
function generateVehicleSettings(actor)
  local activityGameVehicle
  if actor.previewMovie then
    activityGameVehicle = progressionSystem.getActivityGameVehicle()
  end
  if activityGameVehicle then
  end
  if activityGameVehicle then
  end
  if activityGameVehicle then
  end
  if activityGameVehicle then
  end
  local vehicleSettings = {
    modelID = activityGameVehicle and actor.modelID,
    panelSet = actor.panelSet,
    shaderParams = actor.shader,
    trailerID = activityGameVehicle.childVehicle and activityGameVehicle and actor.trailerModelID,
    trailerPanelSet = actor.trailerPanelSet or -1,
    trailerShaderParams = actor.trailerShaderParam,
    speed = actor.spawnSpeed or 30,
    disablePanelDetach = actor.disablePanelDetach or nil
  }
  return vehicleSettings
end
function spawnActor(actor, location, fixedPosition, missionStartTeleport)
  if missionStartTeleport then
    print("########################################### Teleport NOT using John's spawn stuff")
  else
    print("########################################### Spawn NOT using John's spawn stuff")
  end
  print("spawnActor: actor.ID = " .. tostring(actor.ID) .. ", fixedPosition = " .. tostring(fixedPosition) .. ", missionStartTeleport = " .. tostring(missionStartTeleport))
  local vehicles
  local location = location
  if fixedPosition then
    if missionStartTeleport then
      if location.matrix then
        return {
          location.matrix
        }
      else
        return {
          [4] = alignMatrix(location.position, location.heading or 0)
        }
      end
    else
      vehicles = {
        [4] = vehicleManager.spawnVehicle({
          matrix = location.matrix,
          position = location.position,
          heading = location.heading or 0,
          modelID = actor.modelID,
          panelSet = actor.panelSet,
          shader = actor.shader,
          actor = actor,
          speed = actor.spawnSpeed or 30,
          disablePanelDetach = actor.disablePanelDetach or nil
        })
      }
      spooling.clearAreaOfVehicles(vehicles[1].gameVehicle.matrix[3], 5)
      if actor.trailerModelID then
        local trailerPanelSet = actor.trailerPanelSet or -1
        if GameVehicleResource.createTrailerAndHookup({
          gameVehicle = vehicles[1].gameVehicle,
          panelSet = trailerPanelSet,
          trailerId = actor.trailerModelID,
          shaderParams = actor.trailerShaderParam
        }) then
          spooling.clearAreaOfVehicles(vehicles[1].gameVehicle.towedVehicle.matrix[3], 5)
        end
      end
    end
  else
    local position = location.position or location.matrix[3]
    local settings = {
      matricesOnly = missionStartTeleport,
      type = "ClosestRoadPosition",
      position = position,
      ignoreVehicles = progressionSystem.getActivityGameVehicle() and {
        [3] = progressionSystem.getActivityGameVehicle()
      },
      vehicles = {}
    }
    settings.vehicles[1] = generateVehicleSettings(actor)
    vehicles = createActors(settings)
  end
  return vehicles
end
local generateSwarm = function(instance, actors, missionStartTeleport)
  if instance.taskObjectsByActorID[actors[1].spawn.swarm.vehicle].coreData.agent.gameVehicle then
    local settings = {
      matricesOnly = missionStartTeleport,
      type = "Swarm",
      vehicle = instance.taskObjectsByActorID[actors[1].spawn.swarm.vehicle].coreData.agent.gameVehicle,
      minDistance = actors[1].spawn.swarm.minimumDistance,
      maxDistance = actors[1].spawn.swarm.maximumDistance
    }
    local vehiclesList = {}
    for actorID, actor in ipairs(actors) do
      local vehicleID = {
        modelID = actor.modelID,
        panelSet = actor.panelSet,
        shaderParams = actor.shader,
        trailerID = actor.trailerModelID,
        trailerModel = actor.trailerPanelSet or -1,
        speed = actor.spawnSpeed or 30,
        disablePanelDetach = actor.disablePanelDetach or nil
      }
      table.insert(vehiclesList, vehicleID)
    end
    settings.vehicles = vehiclesList
    local vehicles = createActors(settings)
    return vehicles
  end
end
local spawnActorRelativeToVehicle = function(instance, actor, alternateSettings, missionStartTeleport, ignorePlayerProximity)
  local settings = {}
  if alternateSettings then
    settings = alternateSettings
  else
    settings = {
      matricesOnly = missionStartTeleport,
      position = actor.spawn.relativeToVehicle.whichLane or "randomLane",
      vehicles = {
        [1] = {
          modelID = actor.modelID,
          panelSet = actor.panelSet,
          shaderParams = actor.shader,
          trailerID = actor.trailerModelID,
          trailerModel = actor.trailerPanelSet or -1,
          disablePanelDetach = actor.disablePanelDetach or nil
        }
      }
    }
    if actor.spawn.relativeToVehicle.aheadOfVehicle then
      settings.type = "InFrontOfVehicle"
      settings.distanceInFront = actor.spawn.relativeToVehicle.distance or 150
    else
      settings.type = "BehindVehicle"
      settings.distanceBehind = actor.spawn.relativeToVehicle.distance or 100
    end
    if actor.spawn.relativeToVehicle.withVehicleDirection then
      settings.direction = "with"
    else
      settings.direction = "against"
    end
    if (missionStartTeleport or localPlayer.challenge.retryingMission) and actor.spawn.position then
      settings = {
        type = "Generic",
        position = actor.spawn.position,
        heading = actor.spawn.heading,
        vehicles = {
          [1] = {
            modelID = actor.modelID,
            panelSet = actor.panelSet,
            shaderParams = actor.shader,
            trailerID = actor.trailerModelID,
            trailerModel = actor.trailerPanelSet or -1,
            disablePanelDetach = actor.disablePanelDetach or nil
          }
        }
      }
    elseif actor.spawn.relativeToVehicle.actor then
      settings.vehicle = instance.taskObjectsByActorID[actor.spawn.relativeToVehicle.actor].coreData.agent.gameVehicle
    elseif localPlayer.inZap == true and actor.spawn.relativeToVehicle.useCameraPositionIfInZap == true then
      settings = {
        type = "AroundLocation",
        position = spoolsystem.position,
        vehicles = {
          [1] = {
            modelID = actor.modelID,
            panelSet = actor.panelSet,
            shaderParams = actor.shader,
            trailerID = actor.trailerModelID,
            trailerModel = actor.trailerPanelSet or -1,
            disablePanelDetach = actor.disablePanelDetach or nil
          }
        },
        distance = actor.spawn.relativeToVehicle.distance or actor.spawn.relativeToVehicle.distanceToSpawnIfUsingCameraPosition or 1
      }
    elseif localPlayer.currentVehicle then
      settings.vehicle = localPlayer.currentVehicle.gameVehicle
    else
      settings = {
        type = "ClosestRoadPosition",
        position = game_camera.matrix[3],
        vehicles = {
          [1] = {
            modelID = actor.modelID,
            panelSet = actor.panelSet,
            shaderParams = actor.shader,
            trailerID = actor.trailerModelID,
            trailerModel = actor.trailerPanelSet or -1,
            speed = actor.spawnSpeed or 30,
            disablePanelDetach = actor.disablePanelDetach or nil
          }
        }
      }
    end
    settings.matricesOnly = missionStartTeleport
    settings.IgnorePlayers = ignorePlayerProximity
  end
  local vehicles = createActors(settings)
  return vehicles
end
local generatePositions = function(instance, actors, missionStartTeleportGameVehicles, missionStartSpawn)
  local startPos, startHeading
  local spawnTable = "spawn"
  if missionStartSpawn and actors[1].missionStartSpawn then
    spawnTable = "missionStartSpawn"
  end
  if actors[1][spawnTable].position then
    startPos = actors[1][spawnTable].position
    startHeading = actors[1][spawnTable].heading
  else
    startPos = instance.challenge.settings.position
    startHeading = instance.challenge.settings.heading
  end
  local missionStartTeleport = false
  if missionStartTeleportGameVehicles then
    missionStartTeleport = true
  end
  local settings = {
    matricesOnly = missionStartTeleport,
    type = "Generic",
    position = startPos,
    heading = startHeading,
    ignoreVehicles = missionStartTeleportGameVehicles or progressionSystem.getActivityGameVehicle() and {
      [7] = progressionSystem.getActivityGameVehicle()
    }
  }
  local positionList = {}
  for i, actor in next, actors, nil do
    if actor[spawnTable].ranking > 0 then
      positionList[actor[spawnTable].ranking] = actor
    else
      print("=========================== Actor: " .. tostring(actor.ID) .. " has been given a Positions spawn card, but hasn't been set a position on that card.")
    end
  end
  local vehiclesList = {}
  for actorID, actor in ipairs(positionList) do
    local vehicleSettings = generateVehicleSettings(actor)
    table.insert(vehiclesList, vehicleSettings)
  end
  settings.vehicles = vehiclesList
  local vehicles = createActors(settings)
  return vehicles, positionList
end
local generateClosestPointOnRoute = function(instance, actors, missionStartTeleport)
  local vehicles = {}
  for i, actor in ipairs(actors) do
    local settings = {
      matricesOnly = missionStartTeleport,
      type = "ClosestPointOnRoute",
      route = routes[actor.spawn.route].roads,
      direction = actor.spawn.direction,
      offset = actor.spawn.distance,
      vehicles = {
        [1] = {
          modelID = actor.modelID,
          panelSet = actor.panelSet,
          shaderParams = actor.shader,
          trailerID = actor.trailerModelID,
          trailerModel = actor.trailerPanelSet or -1,
          disablePanelDetach = actor.disablePanelDetach or nil
        }
      }
    }
    if actor.spawn.actor then
      settings.position = instance.taskObjectsByActorID[actor.spawn.actor].coreData.agent.gameVehicle.position
    elseif localPlayer.currentVehicle then
      settings.position = localPlayer.currentVehicle.gameVehicle.position
    else
      settings = {
        type = "ClosestRoadPosition",
        position = game_camera.matrix[3],
        vehicles = {
          [1] = {
            modelID = actor.modelID,
            panelSet = actor.panelSet,
            shaderParams = actor.shader,
            trailerID = actor.trailerModelID,
            trailerModel = actor.trailerPanelSet or -1,
            speed = actor.spawnSpeed or 30,
            disablePanelDetach = actor.disablePanelDetach or nil
          }
        }
      }
    end
    local actors = createActors(settings)
    for i, actor in ipairs(actors) do
      table.insert(vehicles, actor)
    end
  end
  return vehicles
end
local spawnAroundLocation = function(instance, actors, missionStartTeleport)
  local settings = {
    matricesOnly = missionStartTeleport,
    type = "AroundLocation"
  }
  if actors[1].spawn.aroundLocation.usePlayersLocation then
    if localPlayer.inZap == true and actors[1].spawn.aroundLocation.useCameraPositionIfInZap == true then
      settings.position = game_camera.matrix[3]:clone()
    else
      settings.position = localPlayer.currentVehicle.position
    end
  elseif actors[1].spawn.aroundLocation.centreSpawnLocation then
    settings.position = actors[1].spawn.aroundLocation.centreSpawnLocation
  else
    settings.position = vec.vector(-208.2238, 18.0878, 1008.682, 1)
  end
  settings.distance = actors[1].spawn.aroundLocation.distanceFromSpawnCentre
  if not settings.distance then
    if actors[1].spawn.aroundLocation.usePlayersLocation then
      settings.distance = 100
    else
      settings.distance = localPlayer.currentVehicle.position - settings.position:length()
      settings.IgnoreFirstLocation = true
    end
  end
  settings.heading = math.pi * 2 * math.random() - math.pi
  local vehiclesList = {}
  for actorID, actor in next, actors, nil do
    local vehicleID = {
      modelID = actor.modelID,
      panelSet = actor.panelSet,
      shaderParams = actor.shader,
      trailerID = actor.trailerModelID,
      trailerModel = actor.trailerPanelSet or -1,
      speed = actor.spawnSpeed or 30,
      disablePanelDetach = actor.disablePanelDetach or nil
    }
    table.insert(vehiclesList, vehicleID)
  end
  settings.vehicles = vehiclesList
  local vehicles = createActors(settings)
  return vehicles
end
local function spawnCarriers(instance, actors, missionStartTeleport)
  local settings = {
    matricesOnly = missionStartTeleport,
    type = "CarriersAtEdgeOfSimulation",
    distanceFromEdge = 50
  }
  local vehiclesList = {}
  for i, actor in ipairs(actors) do
    local vehicleID = {
      modelID = actor.modelID,
      panelSet = actor.panelSet,
      shaderParams = actor.shader,
      trailerID = actor.trailerModelID,
      trailerModel = actor.trailerPanelSet or -1,
      speed = actor.spawnSpeed or 30,
      disablePanelDetach = actor.disablePanelDetach or nil
    }
    vehiclesList[i] = vehicleID
  end
  settings.vehicles = vehiclesList
  local vehicles = createActors(settings)
  for i, actor in ipairs(actors) do
    if not vehicles[i] then
      print("resorting to spawnActorRelativeToVehicle for actor " .. tostring(i))
      vehicles[i] = spawnActorRelativeToVehicle(instance, actor, nil, missionStartTeleport)[1]
    end
  end
  return vehicles
end
function createActor(instance, vehicle, actor, missionStartTeleport, whenToSpawn)
  if instance.taskObjectsByActorID[actor.ID] and missionStartTeleport then
    instance.taskObjectsByActorID[actor.ID].coreData.agent:stopHighSpeedDriving()
    instance.taskObjectsByActorID[actor.ID].coreData.agent:missionStartTeleport(vehicle)
  elseif instance.taskObjectsByActorID[actor.ID] then
    instance.taskObjectsByActorID[actor.ID]:setAgent(vehicle)
  else
    local activityGameVehicle = progressionSystem.getActivityGameVehicle()
    local activityVehicle = vehicleManager.vehiclesByGameVehicle[activityGameVehicle]
    if activityVehicle and actor.previewMovie then
      local matrix = vehicle.matrix:clone()
      vehicle:delete()
      activityVehicle:teleport(matrix)
      instance:newActorFromAgent(actor.ID, activityVehicle)
    else
      instance:newActorFromAgent(actor.ID, vehicle)
    end
  end
  local agent = instance.taskObjectsByActorID[actor.ID].coreData.agent
  if whenToSpawn == "On warmup" then
    if missionStartTeleport then
      vehicleManager.applyInMissionVehicleSettings(agent, actor)
    else
      vehicleManager.applyGeneralVehicleSettings(agent, actor)
      if localPlayer.challenge.retryingMission then
        vehicleManager.applyInMissionVehicleSettings(agent, actor)
      end
      if agent.model_id == 62 then
        GameVehicleResource.spoolOccupants(agent.gameVehicle)
        GameVehicleResource.upgradeOccupants(agent.gameVehicle)
      end
    end
  else
    vehicleManager.applyGeneralVehicleSettings(agent, actor)
    vehicleManager.applyInMissionVehicleSettings(agent, actor)
  end
end
function spawnActors(instance, whenToSpawn, actorsToSpawn, missionStartTeleport)
  local setPositionString = "Set position"
  local relativeToVehicleString = "Relative to Vehicle"
  local positionsString = "Positions"
  local closestPointOnRouteString = "Closest point on route"
  local aroundLocationString = "Around location"
  local swarmString = "Swarm"
  local carriersAtEdgeOfSimulationString = "Carriers at edge of simulation"
  local whenToSpawn = whenToSpawn or "On warmup"
  local requiredActors = {}
  local trailerRequired = false
  local missionStartSpawn = false
  if whenToSpawn == "On warmup" and (missionStartTeleport or localPlayer.challenge.retryingMission) then
    missionStartSpawn = true
  end
  local function buildRequiredActorsTable(actor, requiredActors, isAMissionStartSpawn)
    local spawnTable = "spawn"
    if isAMissionStartSpawn then
      spawnTable = "missionStartSpawn"
    end
    if actor[spawnTable].type == positionsString then
      requiredActors[actor[spawnTable].type] = requiredActors[actor[spawnTable].type] or {}
      requiredActors[actor[spawnTable].type][actor[spawnTable].name] = requiredActors[actor[spawnTable].type][actor[spawnTable].name] or {}
      table.insert(requiredActors[actor[spawnTable].type][actor[spawnTable].name], actor)
    else
      requiredActors[actor[spawnTable].type] = requiredActors[actor[spawnTable].type] or {}
      table.insert(requiredActors[actor[spawnTable].type], actor)
    end
    if not trailerRequired and actor.trailerModelID and whenToSpawn == "On mission start" then
      trailerRequired = true
    end
  end
  for i, actor in ipairs(instance.challenge.actorPool) do
    if actor.whenSpawned == "On warmup" and whenToSpawn == "On warmup" or whenToSpawn == "On mission start" and actor.whenSpawned == "On mission start" or whenToSpawn == "Never" and actor.whenSpawned == "Never" and actorsToSpawn[actor.ID] or whenToSpawn == "Any" and actorsToSpawn[actor.ID] then
      if actor.spawn.type == "As localPlayer" then
        if not instance.taskObjectsByActorID[actor.ID] then
          instance:newActorFromAgent(actor.ID, localPlayer)
        end
      elseif missionStartSpawn and actor.missionStartSpawn then
        buildRequiredActorsTable(actor, requiredActors, true)
      else
        buildRequiredActorsTable(actor, requiredActors)
      end
    end
  end
  if trailerRequired then
    spooling.enableTraffic(false)
  end
  if requiredActors[setPositionString] then
    for i, actor in ipairs(requiredActors[setPositionString]) do
      if not missionStartTeleport and not localPlayer.challenge.retryingMission or not actor.spawn.missionTeleportLocation then
        local positionAndHeading = {
          position = actor.spawn.position,
          heading = actor.spawn.heading
        }
      end
      local vehicles = spawnActor(actor, positionAndHeading, actor.spawn.fixedPosition, missionStartTeleport)
      createActor(instance, vehicles[1], actor, missionStartTeleport, whenToSpawn)
    end
  end
  if requiredActors[positionsString] then
    local tableOfGameVehicles = {}
    if missionStartTeleport then
      for spawnCardName, actors in next, requiredActors[positionsString], nil do
        for i = 1, #actors do
          local actorID = actors[i].ID
          tableOfGameVehicles[spawnCardName] = tableOfGameVehicles[spawnCardName] or {}
          tableOfGameVehicles[spawnCardName][#tableOfGameVehicles[spawnCardName] + 1] = instance.taskObjectsByActorID[actorID].coreData.agent.gameVehicle
        end
      end
    end
    for spawnCardName, actors in next, requiredActors[positionsString], nil do
      local vehicles, vehicleOrder = generatePositions(instance, actors, tableOfGameVehicles[spawnCardName], missionStartSpawn)
      for j, actor in next, vehicleOrder, nil do
        createActor(instance, vehicles[j], actor, missionStartTeleport, whenToSpawn)
      end
    end
  end
  if requiredActors[closestPointOnRouteString] then
    local vehicles = generateClosestPointOnRoute(instance, requiredActors[closestPointOnRouteString], missionStartTeleport)
    for i, actor in ipairs(requiredActors[closestPointOnRouteString]) do
      createActor(instance, vehicles[i], actor, missionStartTeleport, whenToSpawn)
    end
  end
  if requiredActors[aroundLocationString] then
    local vehicles = spawnAroundLocation(instance, requiredActors[aroundLocationString], missionStartTeleport)
    for i, actor in ipairs(requiredActors[aroundLocationString]) do
      createActor(instance, vehicles[i], actor, missionStartTeleport, whenToSpawn)
    end
  end
  if requiredActors[swarmString] then
    local vehicles = generateSwarm(instance, requiredActors[swarmString], missionStartTeleport)
    for i, actor in ipairs(requiredActors[swarmString]) do
      createActor(instance, vehicles[i], actor, missionStartTeleport, whenToSpawn)
    end
  end
  if requiredActors[carriersAtEdgeOfSimulationString] then
    local vehicles = spawnCarriers(instance, requiredActors[carriersAtEdgeOfSimulationString], missionStartTeleport)
    for i, actor in ipairs(requiredActors[carriersAtEdgeOfSimulationString]) do
      createActor(instance, vehicles[i], actor, missionStartTeleport, whenToSpawn)
    end
  end
  if requiredActors[relativeToVehicleString] then
    local ignorePlayerProximity = whenToSpawn == "On mission start"
    for i, actor in ipairs(requiredActors[relativeToVehicleString]) do
      local vehicles = spawnActorRelativeToVehicle(instance, actor, nil, missionStartTeleport, ignorePlayerProximity)
      createActor(instance, vehicles[1], actor, missionStartTeleport, whenToSpawn)
    end
  end
  local function raceManagerUpdate(data)
    for num, actor in next, data, nil do
      if actor.raceManagerRoute then
        cardSystem.updateRaceManager(instance, actor)
        return
      end
    end
  end
  if not gameStatus.onlineSession and (whenToSpawn == "Never" or whenToSpawn == "On mission start" or whenToSpawn == "Any") then
    for spawnType, data in next, requiredActors, nil do
      if spawnType == positionsString then
        for cardInstance, card in next, data, nil do
          raceManagerUpdate(card)
        end
      else
        raceManagerUpdate(data)
      end
    end
  end
  if trailerRequired then
    spooling.enableTraffic(true)
  end
end
