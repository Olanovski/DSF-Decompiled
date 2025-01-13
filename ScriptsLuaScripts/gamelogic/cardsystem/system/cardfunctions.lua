module("cardSystem", package.seeall)
function clearModeData()
  _G.g_currentModePackage = false
  package.loaded["cardSystem.logic"] = nil
  cardSystem.logic = nil
  missionSetupData = nil
  missionEndCallback = nil
  taskCompleteData = nil
  formattedMissionData = nil
  _G.cards.Missions = nil
  _G.routes = nil
  _G.startPositions = nil
  _G.spawnPositions = nil
  _G.missionProps = nil
  feedbackSystem.clearMissionFeedbacks()
  collectgarbage("collect")
  createSubModule()
  missionSetupData = {}
  missionEndCallback = {}
  taskCompleteData = {}
  formattedMissionData = {}
end
function generateFelonySettings(name)
  local felonySettings = cards.Missions[name].cardInstances.FelonySettings
  local settings = {}
  if felonySettings then
    for instance, value in next, felonySettings, nil do
      settings = value[1]
    end
  end
  return settings
end
function generateMissionSettings(name)
  local missionSettings = cards.Missions[name].cardInstances.MissionSettings
  if missionSettings then
    local challenge = {}
    local settings = {}
    for instance, value in next, missionSettings, nil do
      settings = value[1]
    end
    if settings["Spawn type"] == "Always active" then
      local startLocation = settings["Start location"]
      challenge.settings = {alwaysActiveChallenge = true}
      if startLocation then
        challenge.settings.position = startPositions[startLocation].position
        challenge.settings.heading = startPositions[startLocation].heading
      else
        print("You have not supplied a start location in your Mission Settings card for " .. name .. ".")
      end
    else
      challenge.settings = {playerPositionBasedChallenge = true}
    end
    challenge.audio = settings["Audio logic file"]
    challenge.HUD = settings["Hud logic file"]
    challenge.props = settings["Mission props"]
    challenge.settings.disablePlayerIgnoring = settings.disablePlayerIgnoring
    challenge.missionStartCutscene = settings["Cutscene on mission start"]
    if settings["Disable traffic"] then
      challenge.settings.disableTraffic = true
    end
    challenge.settings.loadTrafficOnStart = settings["Load traffic on start"]
    challenge.missionEndCutscene = settings["Cutscene at mission end"]
    challenge.freezeFrameOnMissionEndCutscene = settings.freezeFrameOnMissionEndCutscene
    challenge.afterEndScreenCutscene = settings["Cutscene after mission end screen"]
    challenge.afterEndScreenLocation = afterEndScreenLocations and afterEndScreenLocations[settings["Mission end location"]]
    if settings["Enable traffic at mission end"] then
      challenge.settings.enableTrafficAtMissionEnd = true
    end
    if settings["Disable auto-zap out on mission complete"] then
      challenge.settings.disableZapOnCompletion = true
    end
    if settings["Clear area around vehicles"] then
      challenge.settings.clearVehicleRadius = settings["Clear area around vehicles"]
    end
    if settings["Disable interesting vehicles"] then
      challenge.settings.disableInterestingVehicles = true
    end
    if settings["Enable race status prompts"] then
      challenge.settings.enableRaceStatusPrompts = true
    end
    if settings["Delete task object on reject preview"] then
      challenge.settings.deleteTaskOnReject = true
    end
    return challenge, settings
  else
    print("Mission: " .. tostring(name) .. " is missing it's MissionSettings card.")
  end
end
function buildMission(name)
  local challenge, settings = generateMissionSettings(name)
  if settings then
    challenge.startup = {style = "None"}
    challenge.shutdown = {style = "Synced"}
    challenge.felonySettings = generateFelonySettings(name)
    return challenge
  else
    print("Could not generate settings for mission: " .. tostring(name) .. ".")
  end
end
local buildSpawnTypes = function(uniqueID, spawnTypeCard, typeInstance, challenge, referenceToSpawnCard)
  local spawnTable = {}
  if spawnTypeCard.name == "Positions" then
    spawnTable.ranking = -1
    spawnTable.position = challenge.settings.position
    spawnTable.heading = challenge.settings.heading
    spawnTable.name = referenceToSpawnCard.name
    for i, field in next, spawnTypeCard[typeInstance], nil do
      if i == "alternateLocation" then
        if spawnPositions[spawnTypeCard[typeInstance].alternateLocation] then
          spawnTable.position = spawnPositions[spawnTypeCard[typeInstance].alternateLocation].position
          spawnTable.heading = spawnPositions[spawnTypeCard[typeInstance].alternateLocation].heading
        elseif startPositions[spawnTypeCard[typeInstance].alternateLocation] then
          spawnTable.position = startPositions[spawnTypeCard[typeInstance].alternateLocation].position
          spawnTable.heading = startPositions[spawnTypeCard[typeInstance].alternateLocation].heading
        else
          print(spawnTypeCard[typeInstance].alternateLocation .. " not found in either spawnPositions or startPositions")
        end
      elseif field == uniqueID then
        spawnTable.ranking = tonumber(i)
      end
    end
  elseif spawnTypeCard.name == "Set position" then
    if spawnPositions[spawnTypeCard[typeInstance]["Spawn location"]] then
      spawnTable.position = spawnPositions[spawnTypeCard[typeInstance]["Spawn location"]].position
      spawnTable.heading = spawnPositions[spawnTypeCard[typeInstance]["Spawn location"]].heading
    elseif startPositions[spawnTypeCard[typeInstance]["Spawn location"]] then
      spawnTable.position = startPositions[spawnTypeCard[typeInstance]["Spawn location"]].position
      spawnTable.heading = startPositions[spawnTypeCard[typeInstance]["Spawn location"]].heading
    else
      print(spawnTypeCard[typeInstance]["Spawn location"] .. " not found in either spawnPositions or startPositions")
    end
    spawnTable.fixedPosition = not spawnTypeCard[typeInstance]["Snap to closest road"]
  elseif spawnTypeCard.name == "Closest point on route" then
    spawnTable.route = spawnTypeCard[typeInstance].route
    spawnTable.actor = spawnTypeCard[typeInstance].spawnInRelationToActor
    spawnTable.distance = spawnTypeCard[typeInstance].distanceInFrontOfActor
    spawnTable.direction = spawnTypeCard[typeInstance].directionOnRoute
  elseif spawnTypeCard.name == "Swarm" then
    spawnTable.swarm = {}
    for k, v in next, spawnTypeCard[1].actorToSwarmAround, nil do
      if v.value == "true" then
        spawnTable.swarm.vehicle = v.cardName
        break
      end
    end
    spawnTable.swarm.minimumDistance = spawnTypeCard[1].minimumDistance
    spawnTable.swarm.maximumDistance = spawnTypeCard[1].maximumDistance
  elseif spawnTypeCard.name == "Around location" then
    spawnTable.aroundLocation = {}
    if spawnTypeCard[typeInstance].alternateLocation then
      spawnTable.aroundLocation.centreSpawnLocation = spawnPositions[spawnTypeCard[typeInstance].alternateLocation].position
    end
    spawnTable.aroundLocation.usePlayersLocation = spawnTypeCard[typeInstance].usePlayersLocation
    spawnTable.aroundLocation.useCameraPositionIfInZap = spawnTypeCard[typeInstance].useCameraPositionIfInZap
    spawnTable.aroundLocation.distanceFromSpawnCentre = spawnTypeCard[typeInstance].distanceFromLocation
  elseif spawnTypeCard.name == "Relative to Vehicle" then
    spawnTable.relativeToVehicle = {}
    spawnTable.relativeToVehicle.actor = spawnTypeCard[typeInstance].actor
    spawnTable.relativeToVehicle.distance = spawnTypeCard[typeInstance].distance
    spawnTable.relativeToVehicle.withVehicleDirection = spawnTypeCard[typeInstance].withVehicleDirection
    spawnTable.relativeToVehicle.aheadOfVehicle = spawnTypeCard[typeInstance].aheadOfVehicle
    spawnTable.relativeToVehicle.whichLane = spawnTypeCard[typeInstance].whichLane
    spawnTable.relativeToVehicle.useCameraPositionIfInZap = spawnTypeCard[typeInstance].useCameraPositionIfInZap
    spawnTable.relativeToVehicle.distanceToSpawnIfUsingCameraPosition = spawnTypeCard[typeInstance].distanceToSpawnIfUsingCameraPosition
    spawnTable.relativeToVehicle.missionStartLocation = spawnTypeCard[typeInstance].missionStartLocation
    if spawnTable.relativeToVehicle.missionStartLocation then
      spawnTable.fixedPosition = true
      if spawnPositions[spawnTable.relativeToVehicle.missionStartLocation] then
        spawnTable.position = spawnPositions[spawnTable.relativeToVehicle.missionStartLocation].position
        spawnTable.heading = spawnPositions[spawnTable.relativeToVehicle.missionStartLocation].heading
      elseif startPositions[spawnTable.relativeToVehicle.missionStartLocation] then
        spawnTable.position = startPositions[spawnTable.relativeToVehicle.missionStartLocation].position
        spawnTable.heading = startPositions[spawnTable.relativeToVehicle.missionStartLocation].heading
      end
    end
  elseif spawnTypeCard.name == "Carriers at edge of simulation" then
    spawnTable.carriersAtEdgeOfSimulation = {}
    spawnTable.carriersAtEdgeOfSimulation.modelID = spawnTypeCard[typeInstance].modelID
    spawnTable.relativeToVehicle = {}
    spawnTable.relativeToVehicle.actor = spawnTypeCard[typeInstance].actor
    spawnTable.relativeToVehicle.distance = spawnTypeCard[typeInstance].distance
    spawnTable.relativeToVehicle.withVehicleDirection = spawnTypeCard[typeInstance].withVehicleDirection
    spawnTable.relativeToVehicle.aheadOfVehicle = spawnTypeCard[typeInstance].aheadOfVehicle
    spawnTable.relativeToVehicle.whichLane = spawnTypeCard[typeInstance].whichLane
    spawnTable.relativeToVehicle.useCameraPositionIfInZap = spawnTypeCard[typeInstance].useCameraPositionIfInZap
    spawnTable.relativeToVehicle.distanceToSpawnIfUsingCameraPosition = spawnTypeCard[typeInstance].distanceToSpawnIfUsingCameraPosition
  end
  return spawnTable
end
local warmupRouteStyle = "Player present custom task"
local warmupRouteTaskList = {
  {
    task = "Warmup route"
  }
}
local overtakePlayerStyle = "Player present custom task"
local overtakePlayerTaskList = {
  {
    task = "Overtake player"
  }
}
local staticWarmup = {
  style = "Player present custom task",
  settings = {
    taskList = {
      {task = "No target"}
    }
  },
  static = true
}
local staticToRollingWarmup = {
  style = "Player present custom task",
  settings = {
    taskList = {
      {task = "No target"}
    }
  },
  rollingStart = true
}
local cutsceneWarmup = {style = "Cutscene"}
local defaultWarmup = {
  style = "Player present custom task",
  settings = {
    taskList = {
      {task = "No target"}
    }
  }
}
local addedExtrasTask = "Zap to vehicle"
function buildWarmupTaskList(mission, actor, uniqueID, challenge)
  local newActor = {}
  newActor.ID = uniqueID
  if actor.warmupType then
    local warmupType = mission.cardInstances.WarmupTypes[actor.warmupType.name]
    if warmupType then
      if warmupType.name == "Warmup route" then
        newActor.warmup = {
          style = warmupRouteStyle,
          settings = {
            taskList = warmupRouteTaskList,
            routeName = warmupType[actor.warmupType.instance].warmupRouteName,
            matchTrafficSpeed = warmupType[actor.warmupType.instance].matchTrafficSpeed,
            driveInOncoming = warmupType[actor.warmupType.instance].driveInOncoming,
            actorToChase = warmupType[actor.warmupType.instance].actorToChase
          }
        }
      elseif warmupType.name == "Overtake player" then
        newActor.warmup = {
          style = overtakePlayerStyle,
          settings = {
            taskList = overtakePlayerTaskList,
            isLeader = warmupType[actor.warmupType.instance].isLeader
          }
        }
      elseif warmupType.name == "Static" then
        newActor.warmup = staticWarmup
      elseif warmupType.name == "Static to rolling" then
        newActor.warmup = staticToRollingWarmup
      elseif warmupType.name == "Cutscene" then
        newActor.warmup = {
          style = "Cutscene",
          settings = {
            cutscene = warmupType[actor.warmupType.instance].cutscene,
            forceMissionAccept = warmupType[actor.warmupType.instance].forceMissionAccept
          }
        }
      else
        newActor.warmup = defaultWarmup
      end
      local addedExtras = {
        task = addedExtrasTask,
        forceZapToVehicle = warmupType[actor.warmupType.instance].forceZapToVehicle,
        forceZapToVehicleFromPlayerVehicle = warmupType[actor.warmupType.instance].forceZapToVehicleFromPlayerVehicle,
        lookToVehicle = warmupType[actor.warmupType.instance].lookToVehicle,
        lookToVehicleTriggerRadius = warmupType[actor.warmupType.instance].lookToVehicleTriggerRadius,
        forceMissionAccept = warmupType[actor.warmupType.instance].forceMissionAccept
      }
      if addedExtras.forceZapToVehicle or addedExtras.lookToVehicle or addedExtras.forceZapToVehicleFromPlayerVehicle then
        table.insert(newActor.warmup.settings.taskList, addedExtras)
      end
    else
      print("Actor: " .. tostring(uniqueID) .. " has malformed WarmupType card link. Set to link to 'Unassigned' if it isn't necessary he have one.")
    end
  end
  local referenceToSpawnCard = actor.spawnType
  if referenceToSpawnCard then
    local spawnTypeCard = mission.cardInstances.SpawnTypes[referenceToSpawnCard.name]
    if spawnTypeCard then
      newActor.spawn = buildSpawnTypes(uniqueID, spawnTypeCard, referenceToSpawnCard.instance, challenge, referenceToSpawnCard)
      newActor.spawn.type = spawnTypeCard.name
      local missionStartTeleport = spawnTypeCard[referenceToSpawnCard.instance]["Mission start teleport location"]
      if missionStartTeleport then
        local location = spawnPositions[missionStartTeleport]
        if location then
          newActor.spawn.missionTeleportLocation = location
        else
          print("Actor: " .. tostring(newActor.ID) .. " attempting to teleport after warmup but received an invalid startPosition")
        end
      end
    else
      print("Actor: " .. tostring(actor.ID) .. " has malformed SpawnType card link. Set to link to 'Unassigned' if it isn't necessary he have one.")
    end
    local referenceToMissionStartSpawnCard = mission.cardInstances.SpawnTypes[referenceToSpawnCard.name][1].missionStartSpawnType
    if referenceToMissionStartSpawnCard then
      local missionStartSpawnTypeCard = mission.cardInstances.SpawnTypes[referenceToMissionStartSpawnCard.name]
      if missionStartSpawnTypeCard then
        newActor.missionStartSpawn = buildSpawnTypes(uniqueID, missionStartSpawnTypeCard, referenceToMissionStartSpawnCard.instance, challenge, referenceToSpawnCard)
        newActor.missionStartSpawn.type = missionStartSpawnTypeCard.name
      end
    end
  end
  return newActor
end
function spawnOnMissionStartActors(instance)
  challengeSystem.spawnActors(instance, "On mission start")
end
function updateRaceManager(instance, actor)
  local raceId
  if actor and instance.raceId and instance.rubberbandRoute ~= actor.routeName then
    for actor, object in next, instance.taskObjectsByActorID, nil do
      RaceManager.RemoveRacer(instance.raceId, object.coreData.agent.gameVehicle)
      object.coreData.agent.raceId = nil
    end
    RaceManager.RemoveRace(instance.raceId)
    instance.raceId = nil
  end
  if not instance.raceId then
    for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.routeName then
        if instance.rubberbandRoute ~= taskObject.coreData.actor.routeName and (not instance.loadedFromSoftSave or instance.challenge.name == "Tanner and Jones 7") then
          raceId = RaceManager.CreateRace()
          instance.raceId = raceId
          RaceManager.AddRoute(raceId, routes[taskObject.coreData.actor.routeName].roads)
          RaceManager.AddCheckpoints(raceId, routes[taskObject.coreData.actor.routeName].checkpoints)
          instance.rubberbandRoute = taskObject.coreData.actor.routeName
          break
        elseif instance.rubberbandRoute == taskObject.coreData.actor.routeName and instance.loadedFromSoftSave then
          raceId = RaceManager.CreateRace()
          instance.raceId = raceId
          RaceManager.AddRoute(raceId, routes[taskObject.coreData.actor.routeName].roads)
          RaceManager.AddCheckpoints(raceId, routes[taskObject.coreData.actor.routeName].checkpoints)
        end
      end
    end
  end
  if instance.raceId then
    for actor, object in next, instance.taskObjectsByActorID, nil do
      if object.coreData.actor.wrongWayIndicator then
        RaceManager.EnableWrongWay(instance.raceId, true)
        RaceManager.EnableOffRoute(instance.raceId, true)
      end
      if not object.coreData.agent.raceId then
        RaceManager.AddRacer(instance.raceId, object.coreData.agent.gameVehicle)
        object.coreData.agent.raceId = instance.raceId
      end
    end
  end
end
function createCheckpoints(instance, routeName)
  if routeName then
    if instance.raceId then
      for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
        RaceManager.RemoveRacer(instance.raceId, taskObject.coreData.agent.gameVehicle)
        taskObject.coreData.agent.raceId = nil
      end
      RaceManager.RemoveRace(instance.raceId)
      instance.raceId = nil
    end
    local raceId
    raceId = RaceManager.CreateRace()
    instance.raceId = raceId
    RaceManager.AddRoute(raceId, routes[routeName].roads)
    RaceManager.AddCheckpoints(raceId, routes[routeName].checkpoints)
    instance.rubberbandRoute = routeName
    for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
      RaceManager.AddRacer(instance.raceId, taskObject.coreData.agent.gameVehicle)
      taskObject.coreData.agent.raceId = instance.raceId
    end
  else
    updateRaceManager(instance)
  end
  local checkpoints = {}
  local checkpointLookup = {}
  for i, actor in ipairs(instance.challenge.actorPool) do
    if actor.routeName then
      if not checkpoints[actor.routeName] then
        checkpoints[actor.routeName] = {}
        for k, checkpoint in next, routes[actor.routeName].checkpoints, nil do
          table.insert(checkpoints[actor.routeName], checkpoint)
        end
        checkpointSystem.clearNoneSyncronisedCheckpointsByGroupID(instance.instanceID, i)
        createManualCheckpoints(instance, checkpoints[actor.routeName], i)
        checkpointLookup[actor.routeName] = i
      end
      actor.checkpointGroup = checkpointLookup[actor.routeName]
    end
  end
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.showTargets == "Display" then
      for index, positions in next, checkpoints, nil do
        if index == taskObject.coreData.actor.routeName then
          instance.targetsToShow = positions
        end
      end
    end
  end
end
function setUpRouteManager(taskObject)
  if taskObject.coreData.instance.challenge.showRouteArrows == "All" then
    RouteArrowsManager.AddArrows(localPlayer.localID, taskObject.coreData.instance.raceId, routes[taskObject.coreData.actor.routeName].roads, routes[taskObject.coreData.actor.routeName].arrows)
  end
  if taskObject.coreData.actor.routeName then
    RouteArrowsManager.SetTarget(localPlayer.localID, taskObject.coreData.instance.raceId, taskObject.coreData.agent.gameVehicle)
    RouteArrowsManager.HideArrows(localPlayer.localID, true)
  end
end
local seatLookup = {
  ["Driver id"] = 0,
  ["Passenger id"] = 1,
  ["Behind driver id"] = 2,
  ["Behind passenger id"] = 3
}
LIVERELOAD_ENABLE = false
LIVERELOAD_TABLE = {}
if LIVERELOAD_ENABLE then
  LIVERELOAD_TABLE["MP coop team race"] = true
end
function recreateAllMissions()
  assert(LIVERELOAD_ENABLE, "LIVERELOAD_ENABLE = true needs to be enabled.")
  for missionID, v in next, cards.Missions, nil do
    if LIVERELOAD_TABLE[missionID] then
      print("Recreate mission " .. missionID)
      createMission(missionID, true)
    end
  end
end
function createMission(missionID, forceRebuild)
  local challenge = {}
  local missionFunctions = {}
  if not formattedMissionData[missionID] or forceRebuild then
    formattedMissionData[missionID] = {}
    local mission = cards.Missions[missionID]
    if printInfo then
      printTable(mission)
    end
    if not mission.cardInstances.Multiplayers then
      challenge = buildMission(missionID)
    end
    local missionFunctions = {}
    challenge.name = mission.name
    challenge.title = mission.title
    challenge.description = mission.description
    local missionType
    challenge.goalValues = {}
    local tempTeamsTable = {}
    if not mission.cardInstances.MissionTypes then
      print("The MissionTypes card for mission (" .. tostring(missionID) .. ") does not exist. Check whether you have added one.")
      return
    end
    for missionTypeName, missionTypeData in next, mission.cardInstances.MissionTypes, nil do
      missionType = missionTypeData.name
      challenge.missionType = missionType
      for paramName, param in next, missionTypeData[1], nil do
        if type(param) == "table" and param.type and param.type == "Teams" then
          if not tempTeamsTable[paramName] then
            tempTeamsTable[paramName] = {
              instance = param.instance,
              name = param.name
            }
          end
        else
          challenge.goalValues[paramName] = param
        end
      end
    end
    local actorCount = 0
    local actors = {}
    for uniqueID, actorSet in next, mission.cardInstances.Actors, nil do
      for index, actor in ipairs(actorSet) do
        local newActor = {}
        if not mission.cardInstances.Multiplayers then
          newActor = buildWarmupTaskList(mission, actor, uniqueID, challenge)
        end
        for paramName, param in next, actor, nil do
          if type(param) ~= "table" and paramName ~= "vehicleId" and paramName ~= "vehicleTrailerId" and paramName ~= "trailerShaderParam" and paramName ~= "shaderParam" and paramName ~= "trailerPanelSet" and paramsName ~= "panelSet" and paramName ~= "customAggression" then
            newActor[paramName] = param
          end
        end
        newActor.modelID = actor.vehicleId
        if actor.vehicleTrailerId and actor.vehicleTrailerId ~= -1 then
          newActor.trailerModelID = actor.vehicleTrailerId
        end
        if actor.trailerPanelSet and actor.trailerPanelSet ~= -1 then
          newActor.trailerPanelSet = actor.trailerPanelSet
        end
        if actor.panelSet and actor.panelSet ~= -1 then
          newActor.panelSet = actor.panelSet
        end
        if actor.shaderParam then
          newActor.shader = {
            [0] = actor.shaderParam
          }
        end
        if actor.trailerShaderParam then
          newActor.trailerShaderParam = {
            [0] = actor.trailerShaderParam
          }
        end
        if actor.previewMovie then
          newActor.hasPreview = true
          missionFunctions.startActor = uniqueID
        end
        if newActor.isMultiplayerActor then
          newActor.playerTaskObject = true
        end
        newActor.isMultiplayerActor = nil
        if not actor.team then
          print("Actor " .. uniqueID .. " does not have a team card linked to it.")
          return
        end
        local teamData = mission.cardInstances.Teams[actor.team.name][actor.team.instance]
        for missionTeamName, value in next, tempTeamsTable, nil do
          if value.name == actor.team.name and value.instance == actor.team.instance then
            newActor.team = missionTeamName
          end
        end
        if not missionSetupData[missionType] then
          print("MissionSetupData[" .. tostring(missionType) .. "] does not exist. Check whether your logic file is being loaded.")
          return
        end
        if not missionSetupData[missionType].taskCreatorFunctionLookups[newActor.team] and not missionSetupData[missionType].taskCreatorFunctionLookups[uniqueID] then
          print("Team (" .. tostring(newActor.team) .. ") not found in (" .. tostring(missionType) .. ") logic file or the local function it links to is nil. Add it or change the team name in your MissionType definition card to match the logic.")
          return
        end
        if actor.characters then
          local characters = mission.cardInstances.Characters[actor.characters.name][actor.characters.instance]
          local tempCharactersTable = {}
          for seat, characterID in next, characters, nil do
            tempCharactersTable[seatLookup[seat]] = characterID
          end
          newActor.characters = tempCharactersTable
        end
        if actor.restrictedVehicleType and 0 < actor.restrictedVehicleType then
          newActor.restrictionInfo = {
            ownerOnly = actor.restrictedVehicleType == 1,
            friendlyTeamOnly = actor.restrictedVehicleType == 2,
            hostileTeamOnly = actor.restrictedVehicleType == 3,
            noWeaponEffect = actor.restrictedVehicleType == 4,
            noZapInOut = actor.restrictedVehicleType == 5
          }
        end
        for paramName, param in next, actor, nil do
          if paramName == "customAggression" then
            newActor.customAggression = mission.cardInstances.CustomAggressionSettings[param][1]
          end
        end
        newActor.ID = uniqueID
        actorCount = actorCount + 1
        table.insert(actors, newActor)
      end
    end
    challenge.actorPool = {}
    for i, actor in ipairs(actors) do
      actor.ID = tostring(actor.ID)
      actor.networkID = i
      challenge.actorPool[actor.ID] = actor
      challenge.actorPool[actor.networkID] = actor
    end
    missionFunctions.taskList = missionSetupData[missionType].taskCreatorFunctionLookups
    missionFunctions.initiate = missionSetupData[missionType].initiate
    missionFunctions.assignTaskObjects = missionSetupData[missionType].assignTaskObjects
    missionFunctions.initiateRemote = missionSetupData[missionType].initiateRemote
    missionFunctions.update = missionSetupData[missionType].update
    missionFunctions.targetList = missionSetupData[missionType].targetList
    missionFunctions.missionStart = missionSetupData[missionType].missionStart
    missionFunctions.countdownUpdate = missionSetupData[missionType].countdownUpdate
    missionFunctions.modeReadyCheck = missionSetupData[missionType].modeReadyCheck
    missionFunctions.stepHighlightColours = missionSetupData[missionType].stepHighlightColours
    missionFunctions.missionEnd = missionSetupData[missionType].missionEnd
    missionFunctions.onPlayerJoinInProgress = missionSetupData[missionType].onPlayerJoinInProgress
    missionFunctions.setModeLockingZone = missionSetupData[missionType].setModeLockingZone
    missionFunctions.goalComplete = missionSetupData[missionType].goalComplete
    missionFunctions.getPlayerProgress = missionSetupData[missionType].getPlayerProgress
    missionFunctions.onRacePositionsFinalised = missionSetupData[missionType].onRacePositionsFinalised
    missionFunctions.getLocalPlayerFinalScore = missionSetupData[missionType].getLocalPlayerFinalScore
    missionFunctions.getPlayerFinalScore = missionSetupData[missionType].getPlayerFinalScore
    missionFunctions.getTeamFinalScore = missionSetupData[missionType].getTeamFinalScore
    missionFunctions.getPlayerAdditionalSyncData = missionSetupData[missionType].getPlayerAdditionalSyncData
    if mission.cardInstances.Multiplayers then
      challenge.multiplayer = true
      local setupData = missionSetupData[missionType].setupDataGenerator(mission.cardInstances)
      challenge.settings = setupData.settings
      challenge.startup = setupData.startup
      challenge.warmup = setupData.warmup
      challenge.shutdown = setupData.shutdown
      missionFunctions.taskComplete = taskCompleteData[missionType].taskComplete
      challenge.hasPlayerPool = mission.cardInstances.Teams["Player Pool"] ~= nil
    else
      challenge.taskCompleteData = {}
      if mission.cardInstances.MissionCompletes then
        for key, value in next, mission.cardInstances.MissionCompletes, nil do
          missionFunctions.taskComplete = taskCompleteData[value.name].taskComplete
          for k, v in next, value[1], nil do
            challenge.taskCompleteData[k] = v
          end
        end
      elseif taskCompleteData[missionType] then
        missionFunctions.taskComplete = taskCompleteData[missionType].taskComplete
      else
        print("You have not added a MissionCompletes card to your mission or added a taskComplete function to your logic.")
      end
      if missionEndCallback[missionType] then
        missionFunctions.completeCallback = missionEndCallback[missionType]
      end
      if mission.cardInstances.MissionInfos then
        local infoFound = false
        for name, data in next, mission.cardInstances.MissionInfos, nil do
          if infoFound then
            print("You appear to have multiple MissionInfo cards. This is bad. Only the first will be applied to your mission.")
            break
          end
          for paramName, paramValue in next, data[1], nil do
            local textKey = string.find(paramName, " Text")
            local iconKey = string.find(paramName, " Icon")
            if textKey or iconKey then
              local key = tonumber(string.sub(paramName, 0, textKey or iconKey))
              if textKey then
                challenge.focusButtons = challenge.focusButtons or {}
                challenge.focusButtons[key] = challenge.focusButtons[key] or {}
                challenge.focusButtons[key].text = paramValue
              elseif paramValue > 0 then
                challenge.focusButtons = challenge.focusButtons or {}
                challenge.focusButtons[key] = challenge.focusButtons[key] or {}
                challenge.focusButtons[key].icon = paramValue
              end
            elseif paramName == "missionMarkers" or paramName == "showRouteArrows" then
              challenge[paramName] = paramValue
            else
              challenge.taskCompleteData[paramName] = paramValue
            end
            infoFound = true
          end
        end
      end
    end
    if missionSetupData[missionType].onlineProgressionData then
      challenge.onlineProgressionData = missionSetupData[missionType].onlineProgressionData
    end
    if missionSetupData[missionType].onlineStatisticsData then
      challenge.onlineStatisticsData = missionSetupData[missionType].onlineStatisticsData
    end
    if missionSetupData[missionType].updatePresence then
      challenge.updatePresence = missionSetupData[missionType].updatePresence
    end
    if missionSetupData[missionType].spawnPositions then
      challenge.spawnPositions = missionSetupData[missionType].spawnPositions
    end
    if missionSetupData[missionType].usableRouteIndicies then
      challenge.usableRouteIndicies = missionSetupData[missionType].usableRouteIndicies
    end
    if missionSetupData[missionType].getInitialRouteIndexCallback then
      challenge.getInitialRouteIndexCallback = missionSetupData[missionType].getInitialRouteIndexCallback
    end
    if missionSetupData[missionType].buildSpawnPositionFunctions then
      challenge.buildSpawnPositionFunctions = missionSetupData[missionType].buildSpawnPositionFunctions
    end
    if missionSetupData[missionType].clearSpawnPositionFunction then
      challenge.clearSpawnPositionFunction = missionSetupData[missionType].clearSpawnPositionFunction
    end
    if missionSetupData[missionType].getNextAreaIndexCallback then
      challenge.getNextAreaIndexCallback = missionSetupData[missionType].getNextAreaIndexCallback
    end
    if missionSetupData[missionType].missionCompleteData then
      challenge.missionCompleteData = missionSetupData[missionType].missionCompleteData
    end
    local missionSettings = cards.Missions[missionID].cardInstances.MissionSettings
    if missionSettings then
      local settings = {}
      for instance, value in next, missionSettings, nil do
        settings = value[1]
      end
      formattedMissionData[missionID].missionSettings = settings
    end
    if not LIVERELOAD_ENABLE or not LIVERELOAD_TABLE[missionID] then
      cards.Missions[missionID].cardInstances = nil
    end
    formattedMissionData[missionID].challenge = challenge
    formattedMissionData[missionID].missionFunctions = missionFunctions
    collectgarbage("collect")
  end
  return formattedMissionData[missionID].challenge, formattedMissionData[missionID].missionFunctions
end
function initialiseAllLoadedMissions()
  for missionID, v in next, cards.Missions, nil do
    print("Create mission " .. tostring(missionID))
    createMission(missionID, false)
  end
end
function setupGenericLevers(task, goalParams, HUD)
  local originalNumberOfTasks = #task[1]
  local function setup()
    print("######################################################### shit added by setupGenericLevers.")
    if not task[1][originalNumberOfTasks + 1] then
      task[1][originalNumberOfTasks + 1] = {
        task = "Payload Tracking",
        goalConditions = {},
        taskConditions = {}
      }
    end
    return #task[1]
  end
  if goalParams["Overtake target (+ score)"] then
    genericTaskIndex = setup()
    task[1][genericTaskIndex].goalConditions[#task[1][genericTaskIndex].goalConditions + 1] = {
      autoRefresh = true,
      {
        goal = "Changed vehicle",
        params = {value = 1}
      },
      {
        goal = "Player above speed",
        params = {value = 60}
      },
      {
        goal = "Alongside vehicle",
        params = {value = 1}
      }
    }
  end
  if goalParams["Next to for duration (+ score)"] then
    genericTaskIndex = setup()
    task[1][genericTaskIndex].goalConditions[#task[1][genericTaskIndex].goalConditions + 1] = {
      autoRefresh = true,
      {
        goal = "Within radius",
        params = {value = 100}
      },
      {
        goal = "Time trigger",
        params = {value = 1}
      }
    }
  end
  if goalParams["Score drift distance"] or goalParams["Distance drifted (+ score)"] then
    genericTaskIndex = setup()
    task[1][genericTaskIndex].goalConditions[#task[1][genericTaskIndex].goalConditions + 1] = {
      autoRefresh = true,
      {
        goal = "Is player controlled"
      },
      {
        goal = "Score drift distance"
      }
    }
  end
  if goalParams["Score jump distance"] or goalParams["Duration in air (+ score)"] then
    genericTaskIndex = setup()
    task[1][genericTaskIndex].goalConditions[#task[1][genericTaskIndex].goalConditions + 1] = {
      autoRefresh = true,
      {
        goal = "Is player controlled"
      },
      {
        goal = "Score jump distance"
      }
    }
  end
  if goalParams["Prop type to smash"] then
    genericTaskIndex = setup()
    task[1][genericTaskIndex].goalConditions[#task[1][genericTaskIndex].goalConditions + 1] = {
      autoRefresh = true,
      {
        goal = "Number of props smashed",
        params = {
          propData = {
            name = goalParams["Prop type to smash"]
          },
          value = 1,
          highlightTargets = true
        }
      }
    }
  end
  if goalParams["Prop group type to smash"] then
    genericTaskIndex = setup()
    task[1][genericTaskIndex].goalConditions[#task[1][genericTaskIndex].goalConditions + 1] = {
      autoRefresh = true,
      {
        goal = "Number of props smashed",
        params = {
          propData = {
            name = goalParams["Prop group type to smash"]
          },
          value = 1,
          highlightTargets = true
        }
      }
    }
  end
  if goalParams["Vehicle to hit"] then
    local targetModelID
    for k, v in next, Vehicles, nil do
      if v.Model == goalParams["Vehicle to hit"] then
        targetModelID = k
      end
    end
    genericTaskIndex = setup()
    task[1][genericTaskIndex].goalConditions[#task[1][genericTaskIndex].goalConditions + 1] = {
      autoRefresh = true,
      {
        goal = "Simple collision check",
        params = {modelID = targetModelID}
      }
    }
  end
  if goalParams["Speed below (- score)"] then
    genericTaskIndex = setup()
    task[1][genericTaskIndex].goalConditions[#task[1][genericTaskIndex].goalConditions + 1] = {
      failCondition = true,
      {
        goal = "Is player controlled"
      },
      {
        goal = "Below speed",
        params = {
          value = goalParams["Speed below (- score)"]
        }
      },
      {
        goal = "Time trigger",
        params = {
          value = goalParams["Duration below speed"] or 1
        }
      }
    }
  end
  if goalParams["Score to win"] then
    genericTaskIndex = setup()
    task[1][genericTaskIndex].taskConditions[#task[1][genericTaskIndex].taskConditions + 1] = {
      {
        goal = "Payload over",
        params = {
          value = goalParams["Score to win"]
        }
      }
    }
  end
  if goalParams["Score to lose"] then
    genericTaskIndex = setup()
    task[1][genericTaskIndex].taskConditions[#task[1][genericTaskIndex].taskConditions + 1] = {
      failCondition = true,
      {
        goal = "Payload over",
        params = {
          value = goalParams["Score to lose"]
        }
      }
    }
  end
  if goalParams["Damage amount for fail"] then
    genericTaskIndex = setup()
    task[1][genericTaskIndex].taskConditions[#task[1][genericTaskIndex].taskConditions + 1] = {
      failCondition = true,
      {
        goal = "Damage above",
        params = {
          value = goalParams["Damage amount for fail"]
        }
      }
    }
  end
  return task
end
heartometerLogicTable = {
  {
    feedback = "ID:243806",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Has drifted x meters",
      params = {
        value = 50,
        inverse = true,
        minimum = 5
      }
    },
    {
      goal = "Change payload by amount",
      params = {value = 3}
    }
  },
  {
    feedback = "ID:243807",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Has drifted x meters",
      params = {value = 50}
    },
    {
      goal = "Change payload by amount",
      params = {value = 6}
    }
  },
  {
    feedback = "ID:243808",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Has jumped x meters",
      params = {
        value = 50,
        inverse = true,
        minimum = 5
      }
    },
    {
      goal = "Change payload by amount",
      params = {value = 5}
    }
  },
  {
    feedback = "ID:243816",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Has jumped x meters",
      params = {value = 50}
    },
    {
      goal = "Change payload by amount",
      params = {value = 10}
    }
  },
  {
    feedback = "ID:243809",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Was overtake"
    },
    {
      goal = "Change payload by amount",
      params = {value = 1}
    }
  },
  {
    feedback = "ID:243810",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Was nearmiss"
    },
    {
      goal = "Change payload by amount",
      params = {value = 2}
    }
  },
  {
    feedback = "ID:243811",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Player in zap",
      params = {value = false}
    },
    {
      goal = "Drive under trailer",
      params = {checkPreviousTrailers = true}
    },
    {
      goal = "Change payload by amount",
      params = {value = 4}
    }
  },
  {
    feedback = "ID:243812",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Above speed",
      params = {value = 100}
    },
    {
      goal = "Time trigger",
      params = {value = 2}
    },
    {
      goal = "Change payload by amount",
      params = {value = 2}
    }
  },
  {
    feedback = "ID:243813",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Player has barrel rolled"
    },
    {
      goal = "Change payload by amount",
      params = {value = 2}
    }
  },
  {
    feedback = "ID:243814",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Player jumped over a vehicle"
    },
    {
      goal = "Change payload by amount",
      params = {value = 2}
    }
  },
  {
    feedback = "ID:243815",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Dare number of props smashed",
      params = {
        value = 5,
        highlightTargets = false,
        disableFeedback = true
      }
    },
    {
      goal = "Change payload by amount",
      params = {value = 1}
    }
  }
}
heartometerFeedbackTable = {
  {
    feedback = "ID:182722",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Is drifting",
      params = {value = 5}
    },
    {
      goal = "Is drifting",
      params = {value = 50, inverse = true}
    },
    {
      goal = "Set payload to specified value",
      params = {same = true}
    }
  },
  {
    feedback = "ID:182722",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Is drifting",
      params = {value = 50}
    },
    {
      goal = "Set payload to specified value",
      params = {same = true}
    }
  },
  {
    feedback = "ID:182722",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Failed drift",
      params = {startTrigger = 5}
    },
    {
      goal = "Set payload to specified value",
      params = {same = true}
    }
  },
  {
    feedback = "ID:182723",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Player jumped or landed",
      params = {transition = "jumping"}
    },
    {
      goal = "Player jumped a distance of in mid air",
      params = {value = 5}
    },
    {
      goal = "Set payload to specified value",
      params = {same = true}
    }
  },
  {
    feedback = "ID:182723",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Player jumped or landed",
      params = {transition = "jumping"}
    },
    {
      goal = "Player jumped a distance of in mid air",
      params = {value = 50}
    },
    {
      goal = "Set payload to specified value",
      params = {same = true}
    }
  },
  {
    feedback = "ID:182723",
    autoRefresh = true,
    {
      goal = "Is player controlled"
    },
    {
      goal = "Failed jump",
      params = {startTrigger = 5}
    },
    {
      goal = "Set payload to specified value",
      params = {same = true}
    }
  }
}
function createHeartometerParameters(tableToUpdate, addFeedback)
  for key, value in ipairs(heartometerLogicTable) do
    table.insert(tableToUpdate.goalConditions, key, value)
  end
  if addFeedback then
    for key, value in ipairs(heartometerFeedbackTable) do
      table.insert(tableToUpdate.goalConditions, key + #heartometerLogicTable, value)
    end
  end
end
function getHeartometerHUDValue(task)
  return (task.networkVars.payload - task.coreData.lower) * (75 / (task.coreData.upper - task.coreData.lower)) + 15
end
