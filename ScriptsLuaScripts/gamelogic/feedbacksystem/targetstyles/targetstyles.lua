local _getUID = function()
  local startUID = 11000
  local range = 1000
  local uid = startUID - 1
  return function()
    uid = uid + 1
    if uid >= startUID + range then
      uid = startUID
    end
    return uid
  end
end
local getUID = _getUID()
local setDestinationTargetMarkerValues = function()
  Marker.TargetShowDistance = 500
  Marker.TargetHideDistance = 500
  Marker.TargetHideBehindDistance = 40
  Menu.SetPauseMarkerScales(80, 100, 110, 130, 60, 80, 60, 80, 30, 60)
end
addInitObject(setDestinationTargetMarkerValues)
local workingVector = vec.vector()
local standardCheckpointColour = vec.vector(246, 196, 14, 255)
local checkpointGateMarkers = {
  checkpointGate = {
    type = "World",
    facing = false,
    colour = vec.vector(255, 255, 255, 255),
    targetScale = vec.vector(1, 1, 1, 1),
    visible = true,
    heading = 0,
    fadedistance = 120,
    minalpha = 0,
    maxalpha = 255,
    introType = "Fade",
    outroType = "Fade"
  },
  activeGateMinimap = {
    type = "Minimap",
    gadgetID = 73,
    colour = vec.vector(246, 196, 14, 255),
    radius = 30,
    visible = true,
    position = vec.vector(0, 0, 0, 0),
    nofade = true,
    canrotate = false,
    heading = 0,
    localID = nil,
    introType = "BigScaleDown",
    animationType = "WaveScale",
    outroType = "Fade"
  },
  secondActiveGateMinimap = {
    type = "Minimap",
    gadgetID = 73,
    colour = vec.vector(246, 196, 14, 80),
    radius = 30,
    visible = true,
    position = vec.vector(0, 0, 0, 0),
    canrotate = false,
    localID = nil,
    introType = "Fade",
    outroType = "Fade"
  },
  checkpointColumn = {
    type = "World",
    gadgetID = 79,
    colour = vec.vector(255, 255, 255, 255),
    visible = true,
    position = vec.vector(0, 0, 0, 0),
    offset = vec.vector(0, 1.5, 0, 0),
    facing = true,
    fadedistance = 120,
    minalpha = 0,
    maxalpha = 255,
    localID = nil,
    introType = "Fade",
    outroType = "Fade"
  },
  checkpointNumber = {
    type = "Checkpoint",
    position = vec.vector(0, 0, 0, 0),
    colour = vec.vector(246, 196, 14, 255),
    scale = vec.vector(3, 3, 3, 0),
    offset = vec.vector(0, 6, 0.3, 0),
    visible = true,
    angle = 0,
    spacing = 1,
    number = 0,
    numberof = 0,
    fadedistance = 120,
    minalpha = 0,
    maxalpha = 255,
    localID = nil,
    introType = "Fade",
    outroType = "Fade"
  },
  checkpointTarget = {
    type = "Target",
    gadgetID = 73,
    colour = standardCheckpointColour,
    radius = 50,
    visible = true,
    twoDMarker = false,
    twoDMarkerRadius = 0,
    targetType = "Destination",
    flashes = false,
    showDistance = true,
    proximityFlash = true,
    zapBackPrompt = false,
    zapBackPromptAboveCar = false,
    introType = "Fade",
    outroType = "Fade"
  }
}
lap1Complete = {}
feedbackSystem.registerTargetStyle("Checkpoint Gate", {}, function(target, params, task)
  local checkpointMarkers = {}
  local settings = {}
  local plr = task.taskObject.player
  if not params.noArrows then
    RouteArrowsManager.HideArrows(plr.localID, false)
  end
  local roadWidth, roadAngle
  if target.toolData then
    if target.toolData.displayWidth then
      roadWidth = target.toolData.displayWidth
    end
    if target.toolData.heading then
      roadAngle = target.toolData.heading
    end
  end
  if not roadWidth or not roadAngle then
    local roadIndex, distanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(target.position)
    roadWidth = roadWidth or Atlas.AverageRoadWidth(roadIndex)
    local roadHeading = getVectorRoadAngleAtPosition(roadIndex, distanceAlong)
    roadAngle = roadAngle or math.atan2(roadHeading.x, roadHeading.z)
  end
  if roadWidth == 0 then
    roadWidth = 18
  end
  local checkpointsPerLap, ghostCheckpoint, allCheckpoints, currentLap, totalLaps, totalCheckpoints
  local dontDrawGate = false
  local hideEndScreenMarkers = false
  Marker.setAnimationLength("Fade", 0.5)
  duplicateTable(checkpointGateMarkers, settings)
  settings.checkpointGate.scale = params.targetScale
  settings.checkpointGate.heading = roadAngle
  if not params.dontShowLastGate then
    local taskObject = plr.missionSupport:getMainTaskObject()
    if gameStatus.onlineSession then
      allCheckpoints = task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].route
      if not allCheckpoints then
        NetworkLog.Write(">[LUA] TARGET STYLE - Checkpoint Gate - allCheckpoints is nil, routeIndex = " .. tostring(task.instance.networkVars.routeIndex))
        networkLogPrintTable(callStackAsTable())
        return
      end
    elseif taskObject and taskObject.coreData.actor.routeName then
      allCheckpoints = routes[taskObject.coreData.actor.routeName].checkpoints
    end
    currentLap = task.networkVars.laps + 1
    totalLaps = task.coreData.totalLaps + 1
    checkpointsPerLap = #allCheckpoints
    totalCheckpoints = #allCheckpoints * totalLaps
    if params.noneSyncronisedCheckpoint or not gameStatus.onlineSession then
      ghostCheckpoint = checkpointSystem.findNoneSyncronisedCheckpoint(target.instanceID, target.groupID, target.checkpointNum + 1)
    else
      ghostCheckpoint = checkpointSystem.findNextCheckpoint(target.instanceID, target.groupID, target.checkpointNum)
    end
    settings.checkpointNumber.angle = roadAngle
    if params.showAsLaps then
      settings.checkpointNumber.number = target.checkpointNum
      settings.checkpointNumber.numberof = checkpointsPerLap or params.gateNum
    else
      if currentLap ~= totalLaps and not lap1Complete[plr.localID] then
        settings.checkpointNumber.number = target.checkpointNum
      else
        settings.checkpointNumber.number = totalCheckpoints - checkpointsPerLap + target.checkpointNum
      end
      settings.checkpointNumber.numberof = totalCheckpoints or params.gateNum
    end
    if currentLap == totalLaps and target.checkpointNum == 1 and settings.checkpointNumber.number > target.checkpointNum then
      dontDrawGate = true
    elseif currentLap ~= totalLaps or ghostCheckpoint then
      if not ghostCheckpoint then
        if params.noneSyncronisedCheckpoint or not gameStatus.onlineSession then
          ghostCheckpoint = checkpointSystem.findNoneSyncronisedCheckpoint(target.instanceID, target.groupID, 1)
        else
          ghostCheckpoint = checkpointSystem.findNextCheckpoint(target.instanceID, target.groupID, 0)
        end
      end
      lastCheckpoint = false
    else
      lastCheckpoint = true
    end
    if target.checkpointNum == checkpointsPerLap - 1 and currentLap == totalLaps then
      settings.secondActiveGateMinimap.gadgetID = 111
    end
  end
  if currentLap ~= totalLaps and target.checkpointNum == checkpointsPerLap then
    lap1Complete[plr.localID] = true
  else
    lap1Complete[plr.localID] = false
  end
  if roadWidth > 75 then
    settings.checkpointNumber.offset = vec.vector(0, 7, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 248
    else
      settings.checkpointGate.gadgetID = 250
    end
  elseif roadWidth > 66 then
    settings.checkpointNumber.offset = vec.vector(0, 7, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 262
    else
      settings.checkpointGate.gadgetID = 261
    end
  elseif roadWidth > 54 then
    settings.checkpointNumber.offset = vec.vector(0, 7, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 249
    else
      settings.checkpointGate.gadgetID = 247
    end
  elseif roadWidth > 45 then
    settings.checkpointNumber.offset = vec.vector(0, 7, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 260
    else
      settings.checkpointGate.gadgetID = 259
    end
  elseif roadWidth > 35 then
    settings.checkpointNumber.offset = vec.vector(0, 7, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 65
    else
      settings.checkpointGate.gadgetID = 60
    end
  elseif roadWidth > 26 then
    settings.checkpointNumber.offset = vec.vector(0, 7.7, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 64
    else
      settings.checkpointGate.gadgetID = 59
    end
  elseif roadWidth > 18 then
    settings.checkpointNumber.offset = vec.vector(0, 6.7, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 63
    else
      settings.checkpointGate.gadgetID = 58
    end
  elseif roadWidth > 8 then
    settings.checkpointNumber.offset = vec.vector(0, 6.8, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 62
    else
      settings.checkpointGate.gadgetID = 57
    end
  else
    settings.checkpointNumber.offset = vec.vector(0, 5.8, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 61
    else
      settings.checkpointGate.gadgetID = 56
    end
  end
  if lastCheckpoint then
    settings.activeGateMinimap.gadgetID = 111
  end
  if not dontDrawGate then
    for marker, markerData in next, settings, nil do
      markerData.position = target.position
      markerData.localID = plr.localID
      if marker == "secondActiveGateMinimap" and ghostCheckpoint then
        markerData.position = ghostCheckpoint.position
      end
      if marker == "checkpointTarget" then
        markerData.position = target.position + vec.vector(0, 5, 0, 0)
        if params.dontShowTrackingMarker or not gameStatus.onlineSession then
          markerData.visible = false
        end
        if params.multiplayerRace then
          markerData.colour = vec.vector(246, 196, 14, 255) + OnlineModeSettings.targetAlphaMask32
        else
          markerData.colour = standardCheckpointColour
        end
      end
      if params.dontShowLastGate and marker == "secondActiveGateMinimap" or marker == "secondActiveGateMinimap" and lastCheckpoint or params.hideCheckpointNumber and marker == "checkpointNumber" then
        markerData.visible = false
      end
      checkpointMarkers[marker] = Marker:create(markerData)
    end
  end
  local function update()
    if localPlayer.challenge.showingEndScreen and not hideEndScreenMarkers then
      for k, v in next, checkpointMarkers, nil do
        v.visible = false
      end
      hideEndScreenMarkers = true
    end
  end
  local function cleanup()
    if not params.blockCheckpointAudio then
      OneShotSound.Play("HUD_Play_Checkpoint")
    end
    if checkpointMarkers then
      for marker, markerData in next, checkpointMarkers, nil do
        assert(markerData, "v does not exist, marker:" .. marker)
        Marker:delete(markerData)
        checkpointMarkers[marker] = nil
      end
    end
  end
  return update, cleanup
end)
feedbackSystem.registerTargetStyle("Static minimap marker", {
  type = "Minimap",
  gadgetID = 5,
  colour = vec.vector(255, 0, 0, 255),
  radius = 40,
  visible = true,
  twoDMarker = false,
  twoDMarkerRadius = 0,
  showDistance = false,
  proximityFlash = true,
  targetType = "Opponent"
}, function(target, params)
  local marker = Marker:create({
    radius = params.radius,
    heading = params.heading,
    colour = params.colour,
    position = target.position,
    gadgetID = params.gadgetID,
    type = params.type,
    visible = params.visible,
    canrotate = params.canrotate
  })
  local function cleanup()
    assert(marker, "marker does not exist")
    Marker:delete(marker)
  end
  return nil, cleanup
end)
local opponentMarkerSettings = {
  minimap = {
    type = "Minimap",
    gadgetID = 3,
    colour = vec.vector(255, 0, 0, 255),
    radius = 30,
    visible = true,
    nofade = true
  },
  radius = {
    type = "Minimap",
    gadgetID = 108,
    colour = vec.vector(255, 0, 0, 150),
    radius = 300,
    visible = false,
    canrotate = true,
    constrain = false,
    drawInPerspective = true,
    pausemapscaled = false
  },
  healthBar = {
    type = "World",
    facing = true,
    gadgetID = 97,
    scale = vec.vector(0.08, 0.08, 0.08, 0),
    colour = vec.vector(255, 255, 255, 255),
    visible = false,
    uValue = 1,
    vValue = 0
  },
  target = {
    type = "Target",
    gadgetID = 5,
    colour = vec.vector(255, 0, 0, 255),
    radius = 50,
    visible = true,
    twoDMarker = false,
    twoDMarkerRadius = 0,
    flashes = false,
    showDistance = false,
    proximityFlash = true,
    targetType = "Standard",
    zapBackPrompt = false,
    zapBackPromptAboveCar = false
  },
  opponentMarker = {true}
}
local objectiveMarkerSettings = {
  minimap = {
    type = "Minimap",
    gadgetID = 3,
    colour = vec.vector(0, 182, 255, 255),
    radius = 30,
    visible = true,
    nofade = true
  },
  radius = {
    type = "Minimap",
    gadgetID = 108,
    colour = vec.vector(0, 0, 255, 150),
    radius = 150,
    visible = false,
    canrotate = true,
    constrain = false,
    drawInPerspective = true,
    pausemapscaled = false
  },
  healthBar = {
    type = "World",
    facing = true,
    gadgetID = 97,
    scale = vec.vector(0.08, 0.08, 0.08, 0),
    colour = vec.vector(255, 255, 255, 255),
    visible = false,
    uValue = 1,
    vValue = 0
  },
  target = {
    type = "Target",
    gadgetID = 5,
    colour = vec.vector(0, 182, 255, 255),
    radius = 50,
    visible = true,
    twoDMarker = false,
    twoDMarkerRadius = 0,
    flashes = false,
    showDistance = true,
    proximityFlash = true,
    targetType = "Friendly",
    zapBackPrompt = false,
    zapBackPromptAboveCar = false
  },
  objectiveMarker = {true}
}
local iconSettings = {
  hideIcons = {
    minimap = false,
    target = false,
    healthBar = false,
    radius = false
  },
  showIcons = {
    minimap = true,
    target = true,
    healthBar = true,
    radius = false
  },
  radius = {
    minimap = true,
    target = true,
    healthBar = true,
    radius = true
  },
  noHealthBar = {
    minimap = true,
    target = true,
    healthBar = false,
    radius = false
  },
  minimapOnly = {
    minimap = true,
    target = false,
    healthBar = false,
    radius = false
  },
  jerichoRadius = {
    minimap = true,
    target = true,
    healthBar = false,
    radius = true
  }
}
local racerMissions = {
  ["1 Downtown race"] = true,
  ["Easy Street"] = true,
  ["Team colours 01"] = true,
  ["Speed Race"] = true,
  ["Race away"] = true,
  ["Marin County race"] = true,
  ["High plains drifter"] = true
}
local radiusMarkerTypes = {
  ["Red Marker, Getaway Radius"] = true,
  ["Red Marker, Fake Felony Radius"] = true,
  ["Blue Marker, Cop Radius"] = true,
  ["Blue Marker, Getaway Radius"] = true,
  ["Yellow Marker, Getaway Radius"] = true,
  ["Jericho Marker"] = true
}
local objectiveMarkerTypes = {
  ["Objective"] = true,
  ["Blue Marker, Cop Radius"] = true,
  ["Objective (No light trails)"] = true,
  ["Objective (No light trails/health)"] = true
}
local noHealthBarMarkerTypes = {
  ["Red Marker, No Health Bar"] = true,
  ["Black Marker, No Health Bar"] = true,
  ["Objective (No light trails/health)"] = true
}
local noHealthBarShowRadiusMarkerTypes = {
  ["Avoid The Cars"] = true,
  ["Survival"] = true,
  ["Red Marker, Fake Felony Radius"] = true,
  ["Red Marker, Getaway Radius"] = true
}
local hideMarkerTypes = {
  ["Kill Tanner"] = true
}
local truckID = {
  [180] = true,
  [251] = true,
  [252] = true,
  [288] = true,
  [199] = true
}
local redRadius = vec.vector(255, 0, 0, 150)
local blueRadius = vec.vector(0, 0, 255, 150)
local yellowMarker = vec.vector(246, 196, 14, 255)
local blackMarker = vec.vector(0, 0, 0, 255)
feedbackSystem.registerTargetStyle("Vehicle tracking", {}, function(target, params)
  local vehicleHeight
  local keepTrackingWhenWrecked = params.keepTrackingWhenWrecked or false
  target.markers = target.markers or {}
  for k, v in next, target.markers, nil do
    assert(v, "v does not exist, k:" .. k)
    Marker:delete(v)
    target.markers[k] = nil
  end
  local settings = {}
  local targetTaskObject = target:getTaskObject()
  local missionName
  if targetTaskObject then
    missionName = targetTaskObject.coreData.instance.challenge.name
    target.markerType = targetTaskObject.coreData.actor.markerType
  else
    target.markerType = "Objective"
  end
  if target.freedriveMarkers then
    duplicateTable(objectiveMarkerSettings, settings)
  elseif target.markerType then
    if objectiveMarkerTypes[target.markerType] then
      duplicateTable(objectiveMarkerSettings, settings)
    else
      duplicateTable(opponentMarkerSettings, settings)
    end
    if target.markerType == "Opponent" or target.markerType == "Opponent (objective)" then
      if racerMissions[missionName] then
        settings.target.targetType = "Racer"
      end
    elseif target.markerType == "Yellow Marker, Destination Vehicle" then
      settings.target.targetType = "Destination"
      settings.target.radius = 50
      settings.target.colour = yellowMarker
      settings.minimap.colour = yellowMarker
    elseif target.markerType == "Red Marker, Getaway Radius" or target.markerType == "Yellow Marker, Getaway Radius" then
      if missionName == "Something weird" then
        settings.radius.radius = 200
        settings.radius.colour = redRadius
      elseif missionName == "Tanner & Jones Mission 2" then
        settings.radius.radius = 140
        settings.radius.colour = blueRadius
        settings.target.colour = yellowMarker
        settings.minimap.colour = yellowMarker
      elseif missionName == "Tanner & Jones Mission 4" then
        settings.radius.radius = 150
        settings.radius.colour = blueRadius
        settings.target.colour = yellowMarker
        settings.minimap.colour = yellowMarker
      elseif missionName == "Trunked" then
        settings.radius.radius = 200
      elseif missionName == "Collateral Damage" then
        settings.radius.radius = 150
      elseif missionName == "Epilogue pt 2" or missionName == "Final fight" then
        settings.radius.radius = felony_chase.defaultChaseSettings.radius
      end
    elseif target.markerType == "Red Marker, Fake Felony Radius" then
      settings.radius.radius = felony_chase.defaultChaseSettings.radius
    elseif target.markerType == "Black Marker, No Health Bar" then
      settings.target.colour = blackMarker
      settings.minimap.colour = blackMarker
    elseif target.markerType == "Objective (No light trails/health)" then
      settings.target.colour = yellowMarker
      settings.minimap.colour = yellowMarker
    end
  end
  vehicleHeight = target.gameVehicle.height
  if vehicleHeight > 2 then
    vehicleHeight = vehicleHeight + 0.5
  elseif truckID[target.gameVehicle.model_id] then
    vehicleHeight = vehicleHeight + 0.25
  elseif target.gameVehicle.model_id == 181 then
    vehicleHeight = vehicleHeight + 0.1
  elseif vehicleHeight < 1 then
    vehicleHeight = 1.1
  end
  if settings.healthBar then
    settings.healthBar.offset = vec.vector(0, vehicleHeight + 0.45, 0, 0)
  end
  if settings and target.gameVehicle then
    for k, v in next, settings, nil do
      v.gameVehicle = target.gameVehicle
      if v.type then
        target.markers[k] = Marker:create(v)
      end
    end
  end
  local hideMarkerMission = hideMarkerTypes[missionName] or false
  local noHealthBarShowRadiusMission = noHealthBarShowRadiusMarkerTypes[missionName] or false
  local previousState
  local currentState = 0
  local previousMarkerType = false
  local noHealthBarShowRadiusMarker, noHealthBarMarker, radiusMarker
  local function updateMarkerSpecificVariables(markerType)
    noHealthBarShowRadiusMarker = noHealthBarShowRadiusMarkerTypes[target.markerType] or false
    noHealthBarMarker = noHealthBarMarkerTypes[target.markerType] or false
    radiusMarker = radiusMarkerTypes[target.markerType] or false
  end
  local hideIcons = 1
  local minimapOnly = 2
  local jerichoRadius = 3
  local noHealthBar = 4
  local radius = 5
  local showIcons = 6
  local function update()
    if previousMarkerType ~= target.markerType then
      updateMarkerSpecificVariables(target.markerType)
      previousMarkerType = target.markerType
    end
    if target.controlled or hideMarkerMission then
      currentState = hideIcons
    elseif not localPlayer.inZap and target.gameVehicle and localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle.towedVehicle == target.gameVehicle then
      currentState = minimapOnly
    elseif target.iconsVisible ~= nil and target.iconsVisible == false or target.damage >= 1 and not params.keepTrackingWhenWrecked or localPlayer.inCutscene then
      currentState = hideIcons
    elseif noHealthBarShowRadiusMission and noHealthBarShowRadiusMarker then
      currentState = jerichoRadius
    elseif noHealthBarMarker then
      currentState = noHealthBar
    elseif radiusMarker then
      currentState = radius
    else
      currentState = showIcons
    end
    if currentState ~= previousState then
      if currentState == hideIcons then
        currentIconStatus = iconSettings.hideIcons
      elseif currentState == minimapOnly then
        currentIconStatus = iconSettings.minimapOnly
      elseif currentState == jerichoRadius then
        currentIconStatus = iconSettings.jerichoRadius
      elseif currentState == noHealthBar then
        currentIconStatus = iconSettings.noHealthBar
      elseif currentState == radius then
        currentIconStatus = iconSettings.radius
      elseif currentState == showIcons then
        currentIconStatus = iconSettings.showIcons
      end
      for k, v in next, currentIconStatus, nil do
        if target.markers and target.markers[k] then
          target.markers[k].visible = v
        end
      end
      previousState = currentState
    end
    if target.markers and target.markers.target then
      if target.markers.target.distance and localPlayer.inZap and 1 < zapcontroller.getTargetZapLevel() then
        target.markers.target.distance = false
      elseif not target.markers.target.distance and (not localPlayer.inZap or zapcontroller.getClosestCameraZapLevel() == 1) then
        target.markers.target.distance = true
      end
      if localPlayer.previousVehicle == target and not localPlayer.zapTransition and localPlayer:getAbilityAvailable("zapReturn") then
        target.markers.target.zapBackPrompt = true
      else
        target.markers.target.zapBackPrompt = false
      end
    end
  end
  local function cleanup()
    if target.markers then
      for k, v in next, target.markers, nil do
        assert(v, "v does not exist, k:" .. k)
        Marker:delete(v)
        target.markers[k] = nil
      end
      target.iconStatus = nil
      target.iconsVisible = nil
      target.markerType = nil
      target.markers = nil
    end
  end
  return update, cleanup
end)
feedbackSystem.registerTargetStyle("Light trail", {
  length = 40,
  colour = vec.vector(1, 0, 0, 0)
}, function(target, params)
  local maxAlpha = 0.06
  local maxAlphaInZap = 1
  local redLightTrail = vec.vector(1, 0, 0, maxAlpha)
  local blueLightTrail = vec.vector(0, 0.7, 1, maxAlpha)
  local yellowLightTrail = vec.vector(0.96, 0.77, 0.05, maxAlpha)
  local lightTrailLength = 4
  local collidable = false
  local lightTrailTable
  vehicleManager.lightTrailTable[target.gameVehicle] = {
    update = true,
    currentTrail = vec.vector()
  }
  lightTrailTable = vehicleManager.lightTrailTable[target.gameVehicle]
  local targetTaskObject = target:getTaskObject()
  local missionName
  if targetTaskObject then
    missionName = targetTaskObject.coreData.instance.challenge.name
  end
  if missionName == "Something weird" then
    lightTrailLength = 40
    collidable = true
  end
  if targetTaskObject then
    missionName = targetTaskObject.coreData.instance.challenge.name
    if targetTaskObject.coreData.actor.markerType then
      if targetTaskObject.coreData.actor.markerType == "Objective" or targetTaskObject.coreData.actor.markerType == "Blue Marker, Cop Radius" or targetTaskObject.coreData.actor.markerType == "Blue Marker, Getaway Radius" then
        cloneVectorIntoVector(blueLightTrail, lightTrailTable.currentTrail)
      elseif targetTaskObject.coreData.actor.markerType == "Yellow Marker, Destination Vehicle" or targetTaskObject.coreData.actor.markerType == "Yellow Marker, Getaway Radius" then
        cloneVectorIntoVector(yellowLightTrail, lightTrailTable.currentTrail)
      else
        cloneVectorIntoVector(redLightTrail, lightTrailTable.currentTrail)
      end
    end
  else
    cloneVectorIntoVector(blueLightTrail, lightTrailTable.currentTrail)
  end
  if target.controlled then
    lightTrailTable.currentTrail[3] = 0
  end
  target:addLightTrail(lightTrailLength, lightTrailTable.currentTrail, nil, collidable)
  local function update()
    if target.lightTrail then
      if not lightTrailBlocked then
        if target.gameVehicle.damage < 1 then
          if vehicleManager.lightTrailTable[target.gameVehicle].update and not localPlayer.zapTransition then
            if target.controlled then
              if lightTrailTable.currentTrail[3] > 0 then
                if lightTrailTable.currentTrail[3] > maxAlpha then
                  lightTrailTable.currentTrail[3] = maxAlpha
                end
                lightTrailTable.currentTrail[3] = lightTrailTable.currentTrail[3] - maxAlpha / (2 * updates.feedbackSystem)
                target:setLightTrailColour(lightTrailTable.currentTrail)
              else
                lightTrailTable.currentTrail[3] = 0
                target:setLightTrailColour(lightTrailTable.currentTrail)
                vehicleManager.lightTrailTable[target.gameVehicle].update = false
              end
            elseif 1 < vehicleManager.lightTrailZapState and vehicleManager.lightTrailZapState < 6 then
              lightTrailTable.currentTrail[3] = maxAlphaInZap
              target:setLightTrailColour(lightTrailTable.currentTrail)
              vehicleManager.lightTrailTable[target.gameVehicle].update = false
            else
              lightTrailTable.currentTrail[3] = maxAlpha
              target:setLightTrailColour(lightTrailTable.currentTrail)
              vehicleManager.lightTrailTable[target.gameVehicle].update = false
            end
          end
        else
          target:removeLightTrail()
        end
      else
        target:removeLightTrail()
      end
    end
  end
  local function cleanup()
    if target.lightTrail then
      target:removeLightTrail()
    end
    vehicleManager.lightTrailTable[target.gameVehicle] = nil
  end
  return update, cleanup
end)
local arrowMarkers = {
  arrow1 = {
    type = "World",
    facing = false,
    gadgetID = 78,
    scale = vec.vector(0.3, 0.3, 0.3, 0),
    matrixOffset = vec.matrix(-4.371139E-08, 0, 1, 0, 0, 1, 0, 0, -1, 0, -4.371139E-08, 0, -2, -0.69, -4.5, 1),
    visible = true,
    colour = vec.vector(246, 196, 14, 255),
    gameVehicle = nil
  },
  arrow2 = {
    type = "World",
    facing = false,
    gadgetID = 78,
    scale = vec.vector(0.3, 0.3, 0.3, 0),
    matrixOffset = vec.matrix(4.371139E-08, 0, -1, 0, 0, 1, 0, 0, 1, 0, 4.371139E-08, 0, -2, -0.69, 4.5, 1),
    visible = true,
    colour = vec.vector(246, 196, 14, 255),
    gameVehicle = nil
  },
  arrow3 = {
    type = "World",
    facing = false,
    gadgetID = 78,
    scale = vec.vector(0.3, 0.3, 0.3, 0),
    matrixOffset = vec.matrix(-4.371139E-08, 0, 1, 0, 0, 1, 0, 0, -1, 0, -4.371139E-08, 0, 2, -0.69, -4.5, 1),
    visible = true,
    colour = vec.vector(246, 196, 14, 255),
    gameVehicle = nil
  },
  arrow4 = {
    type = "World",
    facing = false,
    gadgetID = 78,
    scale = vec.vector(0.3, 0.3, 0.3, 0),
    matrixOffset = vec.matrix(4.371139E-08, 0, -1, 0, 0, 1, 0, 0, 1, 0, 4.371139E-08, 0, 2, -0.69, 4.5, 1),
    visible = true,
    colour = vec.vector(246, 196, 14, 255),
    gameVehicle = nil
  }
}
feedbackSystem.registerTargetStyle("Drive under truck markers", {visible = true}, function(target, params)
  target.driveUnderTruckMarkers = target.driveUnderTruckMarkers or {}
  for k, v in next, arrowMarkers, nil do
    v.gameVehicle = target.gameVehicle.towedVehicle
    target.driveUnderTruckMarkers[k] = Marker:create(v)
  end
  local update = function()
  end
  local function cleanup()
    for k, v in next, target.driveUnderTruckMarkers, nil do
      assert(v, "v does not exist, k:" .. k)
      Marker:delete(v)
      target.driveUnderTruckMarkers[k] = nil
    end
  end
  return update, cleanup
end)
feedbackSystem.registerTargetStyle("Spotted marker", {
  type = "World",
  facing = true,
  gadgetID = 113,
  scale = vec.vector(0.7, 0.7, 0.7, 0),
  offset = vec.vector(0, 2.5, 0, 0),
  colour = vec.vector(255, 0, 0, 200),
  visible = true,
  introType = "Fade",
  outroType = "Fade"
}, function(target, params)
  target.markers.eyeMarker = target.markers.eyeMarker or {}
  params.gameVehicle = target.gameVehicle
  target.markers.eyeMarker = Marker:create(params)
  target.eyeMarkerActive = true
  local function cleanup()
    if target.markers and target.markers.eyeMarker then
      Marker:delete(target.markers.eyeMarker)
      target.markers.eyeMarker = nil
    end
    target.eyeMarkerActive = nil
  end
  return nil, cleanup
end)
feedbackSystem.registerTargetStyle("Exclamation marker", {
  type = "World",
  facing = true,
  gadgetID = 174,
  scale = vec.vector(2, 2, 2, 0),
  offset = vec.vector(0, 7, 0, 0),
  colour = vec.vector(0, 153, 255, 255),
  visible = true,
  introType = "Fade",
  outroType = "Fade"
}, function(target, params)
  target.exclaimMarker = target.exclaimMarker or {}
  params.gameVehicle = target.gameVehicle
  target.exclaimMarker = Marker:create(params)
  local function cleanup()
    if target.exclaimMarker then
      Marker:delete(target.exclaimMarker)
      target.exclaimMarker = nil
    end
  end
  return nil, cleanup
end)
local possessedVehicleMarkers = {
  minimap = {
    type = "Minimap",
    gadgetID = 3,
    colour = vec.vector(0, 0, 0, 255),
    radius = 30,
    visible = true,
    introType = "BigScaleDown"
  },
  target = {
    type = "Target",
    gadgetID = 5,
    colour = vec.vector(0, 0, 0, 255),
    radius = 50,
    visible = true,
    twoDMarker = false,
    twoDMarkerRadius = 0,
    flashes = false,
    showDistance = false,
    proximityFlash = true,
    targetType = "Standard",
    zapBackPrompt = false,
    zapBackPromptAboveCar = false,
    introType = "Fade",
    outroType = "Fade"
  }
}
feedbackSystem.registerTargetStyle("Possessed vehicles", {}, function(target, params)
  print("======================== triggering")
  target.possessedMarker = target.possessedMarker or {}
  for k, v in next, possessedVehicleMarkers, nil do
    v.gameVehicle = target.gameVehicle
    target.possessedMarker[k] = Marker:create(v)
  end
  local function cleanup()
    for k, v in next, target.possessedMarker, nil do
      assert(v, "v does not exist, k:" .. k)
      Marker:delete(v)
      target.possessedMarker[k] = nil
    end
  end
  return nil, cleanup
end)
local hotspotMarker = {
  World1 = {
    type = "World",
    position = vec.vector(0, 0, 0, 0),
    gadgetID = 8,
    offset = vec.vector(0, -2, 0, 0),
    colour = vec.vector(255, 255, 255, 255),
    visible = false,
    facing = true,
    fadedistance = 120,
    minalpha = 0,
    maxalpha = 255,
    introType = "Fade",
    outroType = "Fade",
    gameVehicle = nil
  },
  World2 = {
    type = "World",
    position = vec.vector(0, 0, 0, 0),
    gadgetID = 173,
    offset = vec.vector(0, -2, 0, 0),
    colour = vec.vector(255, 255, 255, 255),
    visible = false,
    facing = true,
    fadedistance = 120,
    minalpha = 0,
    maxalpha = 255,
    introType = "Fade",
    outroType = "Fade",
    gameVehicle = nil
  },
  World3 = {
    type = "Target",
    position = vec.vector(0, 0, 0, 0),
    gadgetID = 15,
    radius = 35,
    colour = vec.vector(255, 255, 255, 170),
    showDistance = true,
    visible = true,
    targetType = "Destination",
    introType = "Pulse",
    outroType = "Fade",
    gameVehicle = nil
  },
  World4 = {
    type = "Minimap",
    position = vec.vector(0, 0, 0, 0),
    gadgetID = 15,
    radius = 25,
    colour = vec.vector(255, 255, 255, 255),
    canrotate = false,
    visible = true,
    nofade = true,
    introType = "BigScaleDown",
    animationType = "WaveScale",
    gameVehicle = nil
  }
}
feedbackSystem.registerTargetStyle("Hotspot", {discScale = 11}, function(target, params)
  target.hotspot = target.hotspot or {}
  for k, v in next, target.hotspot, nil do
    Marker:delete(v)
    target.hotspot[k] = nil
  end
  local distance = false
  local hideLowLodModelDistance = 400
  local settings = {}
  duplicateTable(hotspotMarker, settings)
  Marker.setAnimationLength("Fade", 0.8)
  for k, v in next, settings, nil do
    if k == "World3" then
      v.position = target.position + vec.vector(0, 5, 0, 0)
    else
      v.position = target.position
    end
    target.hotspot[k] = Marker:create(v)
  end
  Marker:LinkMinimapAnimationToTarget(target.hotspot.World4, target.hotspot.World3)
  if not params.hideTerrainMarker then
    terrainMarker = true
    target.hotspotTerrainMarkerUID = getUID()
    TerrainMarker.Update(target.hotspotTerrainMarkerUID, target.position, vec.vector(0, 0, 0, 0.8), params.discScale)
  end
  local function update()
    if not localPlayer.challenge.showingEndScreen and target.hotspot.World1 and target.hotspot.World2 then
      distance = GameVehicleResource.withinRadius(localPlayer.position, target.position, hideLowLodModelDistance)
      if distance and not target.hotspot.World1.visible then
        target.hotspot.World1.visible = true
        target.hotspot.World2.visible = false
      elseif not distance and not target.hotspot.World2.visible then
        target.hotspot.World1.visible = false
        target.hotspot.World2.visible = true
      end
    end
    if target.hotspot.World3 then
      if localPlayer.inCutscene then
        if target.hotspot.World3.visible then
          target.hotspot.World3.visible = false
        end
      elseif not target.hotspot.World3.visible then
        target.hotspot.World3.visible = true
      end
    end
    if localPlayer.challenge.showingEndScreen then
      for k, v in next, target.hotspot, nil do
        v.visible = false
      end
      if target.hotspotTerrainMarkerUID then
        TerrainMarker.Update(target.hotspotTerrainMarkerUID, target.position, vec.vector(0, 0, 0, 0), params.discScale)
      end
    end
  end
  local function cleanup()
    if target.hotspotTerrainMarkerUID then
      TerrainMarker.Delete(target.hotspotTerrainMarkerUID)
      target.hotspotTerrainMarkerUID = nil
    end
    for k, v in next, target.hotspot, nil do
      Marker:delete(v)
      target.hotspot[k] = nil
    end
  end
  return update, cleanup
end)
local radiusCylinder = {
  type = "World",
  facing = false,
  gadgetID = 170,
  scale = vec.vector(10, 10, 10, 0),
  offset = vec.vector(0, 5, 0, 0),
  colour = vec.vector(0, 0, 0, 255),
  position = vec.vector(0, 0, 0, 0),
  visible = true,
  gameVehicle = nil,
  introType = "Fade",
  outroType = "Fade",
  NoRollInheritance = false
}
local radiusCylinderStripes = {
  type = "World",
  facing = false,
  gadgetID = 171,
  scale = vec.vector(10, 10, 10, 0),
  offset = vec.vector(0, 4, 0, 0),
  colour = vec.vector(0, 0, 0, 255),
  position = vec.vector(0, 0, 0, 0),
  visible = true,
  gameVehicle = nil,
  introType = "Fade",
  outroType = "Fade",
  NoRollInheritance = false
}
local radiusMinimap = {
  type = "Minimap",
  facing = false,
  gadgetID = 108,
  scale = vec.vector(10, 10, 10, 0),
  offset = vec.vector(0, 0, 0, 0),
  colour = vec.vector(0, 0, 0, 255),
  position = vec.vector(0, 0, 0, 0),
  visible = true,
  gameVehicle = nil,
  introType = "Fade",
  outroType = "Fade",
  nofade = true,
  canrotate = true,
  constrain = false,
  drawInPerspective = true,
  pausemapscaled = false
}
feedbackSystem.registerTargetStyle("Radius with hotspot", {visible = true}, function(target, params)
  local inWorldMarkerRadius = params.radius or 10
  local inWorldMarkerColour = params.worldColour or vec.vector(0, 80, 200, 150)
  local minimapMarkerColour = params.minimapColour or inWorldMarkerColour
  local inWorldMarkerHeight = params.height or 10
  local inWorldMarkerOffset = params.offset or vec.vector(0, 0, 0, 0)
  local hideTargetDistance, hotspotShown, hideLowLodModelDistance
  local stuntMood = false
  if not params.hideHotspot then
    target.hotspot = target.hotspot or {}
    for k, v in next, target.hotspot, nil do
      Marker:delete(v)
      target.hotspot[k] = nil
    end
    hideTargetDistance = params.distanceToHideHotspot or params.radius or 10
    hotspotShown = false
    hideLowLodModelDistance = 400
    local settings = {}
    duplicateTable(hotspotMarker, settings)
    for k, v in next, settings, nil do
      if k ~= "World1" and k ~= "World2" then
        if k == "World3" then
          v.position = target.position + vec.vector(0, 5, 0, 0)
          v.showDistance = false
        else
          v.position = target.position
        end
        v.offset = inWorldMarkerOffset
        v.gameVehicle = target.gameVehicle
        v.visible = false
        target.hotspot[k] = Marker:create(v)
        hotspotShown = false
      end
    end
    Marker:LinkMinimapAnimationToTarget(target.hotspot.World4, target.hotspot.World3)
  end
  target.radiusMarkers = target.radiusMarkers or {}
  Marker.setAnimationLength("Fade", 0.5)
  local cylinder, minimap
  if not params.hideInMinimap and target.radiusMarkers.minimap == nil then
    minimap = {}
    duplicateTable(radiusMinimap, minimap)
    minimap.gameVehicle = target.gameVehicle
    minimap.position = target.position
    minimap.colour = minimap.colour:clone()
    minimap.colour = vec.vector(minimapMarkerColour[0], minimapMarkerColour[1], minimapMarkerColour[2], minimapMarkerColour[3])
    minimap.scale = minimap.scale:clone()
    minimap.scale = vec.vector(inWorldMarkerRadius * 2, 10, inWorldMarkerRadius * 2, 1)
    minimap.offset = minimap.offset:clone()
    minimap.offset = inWorldMarkerOffset
    target.radiusMarkers.minimap = Marker:create(minimap)
  end
  if not params.hideInWorld and target.radiusMarkers.inWorldMarker == nil then
    cylinder = {}
    duplicateTable(radiusCylinder, cylinder)
    cylinder.gameVehicle = target.gameVehicle
    if target.gameVehicle then
      cylinder.NoRollInheritance = true
    end
    cylinder.position = target.position
    cylinder.colour = cylinder.colour:clone()
    cylinder.colour = vec.vector(inWorldMarkerColour[0], inWorldMarkerColour[1], inWorldMarkerColour[2], inWorldMarkerColour[3])
    cylinder.scale = cylinder.scale:clone()
    cylinder.scale = vec.vector(inWorldMarkerRadius * 2, inWorldMarkerHeight, inWorldMarkerRadius * 2, 1)
    cylinder.offset = cylinder.offset:clone()
    cylinder.offset = inWorldMarkerOffset
    target.radiusMarkers.inWorldMarker = Marker:create(cylinder)
  end
  local function update()
    if not localPlayer.challenge.showingEndScreen then
      if not params.hideHotspot and not params.hideInWorld then
        if localPlayer.inZap then
          playerPosition = game_camera.matrix[3]
        else
          playerPosition = localPlayer.position
        end
        if not localPlayer.inCutscene and (not GameVehicleResource.withinRadius(playerPosition, target.radiusMarkers.inWorldMarker.position, hideTargetDistance) or GameVehicleResource.withinRadius(playerPosition, target.radiusMarkers.inWorldMarker.position, hideTargetDistance) and params.showHotspotAboveZapLevel and localPlayer.inZap and zapcontroller.getClosestCameraZapLevel() >= params.showHotspotAboveZapLevel) then
          if not hotspotShown then
            target.hotspot.World3.visible = true
            target.hotspot.World4.visible = true
            hotspotShown = true
          end
        elseif hotspotShown then
          for k, v in next, target.hotspot, nil do
            v.visible = false
          end
          hotspotShown = false
        end
      end
      if not params.hideMood and not params.hideInWorld then
        if localPlayer.currentVehicle then
          if GameVehicleResource.withinRadius(localPlayer.currentVehicle.position, target.radiusMarkers.inWorldMarker.position, inWorldMarkerRadius) and not stuntMood then
            stuntMood = true
            moodSystem.applyMood("StuntZoneNoSky", 0)
          elseif not GameVehicleResource.withinRadius(localPlayer.currentVehicle.position, target.radiusMarkers.inWorldMarker.position, inWorldMarkerRadius) and stuntMood then
            stuntMood = false
            moodSystem.removeMood("StuntZoneNoSky")
          end
        elseif stuntMood then
          stuntMood = false
          moodSystem.removeMood("StuntZoneNoSky")
        end
      end
    end
  end
  local function cleanup()
    if target.hotspot then
      for k, v in next, target.hotspot, nil do
        Marker:delete(v)
        target.hotspot[k] = nil
      end
    end
    if target.radiusMarkers then
      for k, v in next, target.radiusMarkers, nil do
        assert(v, "v does not exist, k:" .. k)
        Marker:delete(v)
        target.radiusMarkers[k] = nil
      end
      target.radiusMarkers = nil
    end
    if stuntMood then
      moodSystem.removeMood("StuntZoneNoSky")
      stuntMood = false
    end
  end
  return update, cleanup
end)
feedbackSystem.registerTargetStyle("Online Team Checkpoint Gate", {
  type = "World",
  facing = false,
  colour = vec.vector(255, 255, 255, 255),
  targetScale = vec.vector(1, 1, 1, 1),
  visible = true,
  heading = 0
}, function(target, params, task)
  params.position = target.position
  local player
  if gameStatus.splitscreenSession then
    player = task.agent
  else
    player = localPlayer
  end
  local roadWidth, roadAngle
  if target.toolData then
    if target.toolData.displayWidth then
      roadWidth = target.toolData.displayWidth
    end
    if target.toolData.heading then
      roadAngle = target.toolData.heading
    end
  end
  if not roadWidth or not roadAngle then
    local roadIndex, distanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(target.position)
    roadWidth = roadWidth or Atlas.AverageRoadWidth(roadIndex)
    local roadHeading = getVectorRoadAngleAtPosition(roadIndex, distanceAlong)
    roadAngle = roadAngle or math.atan2(roadHeading.x, roadHeading.z)
  end
  local checkpointColumnData = {
    type = "World",
    gadgetID = 79,
    colour = vec.vector(255, 255, 255, 255),
    visible = true,
    position = vec.vector(0, 0, 0, 0),
    offset = vec.vector(0, 1.5, 0, 0),
    minalpha = 100,
    maxalpha = 255,
    fadedistance = 150,
    facing = true,
    localID = player.localID
  }
  params.localID = player.localID
  local checkpointGate
  local checkpointColumn = false
  local ghostCheckpoint, allCheckpoints, totalCheckpoints
  local gateNumber = target.checkpointNum
  if roadWidth == 0 then
    roadWidth = 18
  end
  params.scale = params.targetScale
  params.heading = roadAngle
  checkpointColumnData.position = target.position
  RouteArrowsManager.SetActiveArrowColour(player.localID, vec.vector(246, 196, 14, 255))
  local taskObject = player.missionSupport:getMainTaskObject()
  local packageTO = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local globalTarget = false
  if packageTO and packageTO.namedTasks.gateTracking then
    globalTarget = packageTO.namedTasks.gateTracking.networkVars.leadCheckPoint
  end
  allCheckpoints = task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].route
  if not allCheckpoints then
    NetworkLog.Write(">[LUA] TARGET STYLE - Online Team Checkpoint Gate - allCheckpoints is nil, routeIndex = " .. tostring(task.instance.networkVars.routeIndex))
    networkLogPrintTable(callStackAsTable())
    return
  end
  totalCheckpoints = #allCheckpoints
  ghostCheckpoint = checkpointSystem.findNoneSyncronisedCheckpoint(target.instanceID, target.groupID, target.checkpointNum + 1)
  if ghostCheckpoint then
    lastCheckpoint = false
  else
    lastCheckpoint = true
  end
  if lastCheckpoint then
    if roadWidth <= 8 then
      params.gadgetID = 61
    elseif roadWidth <= 16 then
      params.gadgetID = 62
    elseif roadWidth <= 24 then
      params.gadgetID = 63
    elseif roadWidth <= 32 then
      params.gadgetID = 64
    else
      params.gadgetID = 65
    end
    checkpointGate = Marker:create(params)
    checkpointColumn = Marker:create(checkpointColumnData)
  else
    if roadWidth <= 8 then
      params.gadgetID = 56
    elseif roadWidth <= 16 then
      params.gadgetID = 57
    elseif roadWidth <= 24 then
      params.gadgetID = 58
    elseif roadWidth <= 32 then
      params.gadgetID = 59
    else
      params.gadgetID = 60
    end
    checkpointGate = Marker:create(params)
    checkpointColumn = Marker:create(checkpointColumnData)
  end
  local phaseOneEndTime = false
  local phaseTwoEndTime = false
  local phaseThreeEndTime = false
  local colourProg = 1
  local gateActive = false
  local gateFlashTime = false
  local flashStartTime = false
  local totalFlashTime = false
  local numFlashes = false
  local flashOn = false
  local gateColours = {
    vec.vector(255, 100, 255, 255),
    vec.vector(255, 50, 255, 255),
    [6] = vec.vector(255, 0, 255, 255)
  }
  local lastFlashTime = -1
  local gateFlashComplete = false
  local function flashCheckpointGate(flash)
    if checkpointGate then
      if flashOn then
        if g_NetworkTime - flashStartTime < totalFlashTime then
          if g_NetworkTime - lastFlashTime > gateFlashTime then
            if checkpointGate.visible then
              checkpointGate.visible = false
              lastFlashTime = g_NetworkTime
            else
              checkpointGate.visible = true
              lastFlashTime = g_NetworkTime
            end
          end
        else
          gateFlashComplete = true
          flashOn = false
          checkpointGate.visible = true
        end
      elseif flash then
        flashOn = true
        lastFlashTime = g_NetworkTime
        gateFlashComplete = false
        checkpointGate.visible = false
      end
    end
  end
  local function update()
    if not gateActive and checkpointSystem.isOnlineCheckpointActive(target.checkpointNum) then
      local gateOneTime, gateTwoTime, gateThreeTime, gateStartTime, flashEndBuffer
      gateOneTime, gateTwoTime, gateThreeTime, gateFlashTime, numFlashes, gateStartTime, flashEndBuffer = checkpointSystem.getOnlineCheckpointPhaseData(target.checkpointNum)
      phaseOneEndTime = gateStartTime + gateOneTime
      phaseTwoEndTime = phaseOneEndTime + gateTwoTime
      phaseThreeEndTime = phaseTwoEndTime + gateThreeTime
      totalFlashTime = gateFlashTime * 2 * numFlashes
      flashStartTime = phaseThreeEndTime - totalFlashTime
      gateActive = true
    elseif gateActive then
      if g_NetworkTime > flashStartTime then
        if colourProg == 3 then
          checkpointGate.colour = gateColours[colourProg]
          colourProg = colourProg + 1
        end
        if not flashOn and not gateFlashComplete then
          flashCheckpointGate(true)
        else
          flashCheckpointGate()
        end
      elseif g_NetworkTime > phaseTwoEndTime and colourProg == 3 then
        checkpointGate.colour = gateColours[colourProg]
        colourProg = colourProg + 1
      elseif g_NetworkTime > phaseOneEndTime and colourProg == 2 then
        checkpointGate.colour = gateColours[colourProg]
        colourProg = colourProg + 1
      elseif colourProg == 1 then
        checkpointGate.colour = gateColours[colourProg]
        colourProg = colourProg + 1
      end
    end
    if checkpointColumn then
      if packageTO and packageTO.namedTasks.gateTracking then
        if target.checkpointNum < packageTO.namedTasks.gateTracking.networkVars.leadCheckPoint then
          Marker:delete(checkpointColumn)
          checkpointColumn = false
        end
      else
        packageTO = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
      end
    end
  end
  local function cleanup()
    assert(checkpointGate, "checkpointGate does not exist")
    Marker:delete(checkpointGate)
    if checkpointColumn then
      Marker:delete(checkpointColumn)
      checkpointColumn = false
    end
  end
  return update, cleanup
end)
feedbackSystem.registerTargetStyle("Checkpoint Gate Pre Target", nil, function(target, params, task)
  local gateSettings = {}
  local cylinderSettings = {}
  local cylStripesSettings = {}
  duplicateTable(checkpointGateMarkers, gateSettings)
  duplicateTable(radiusCylinder, cylinderSettings)
  duplicateTable(radiusCylinderStripes, cylStripesSettings)
  gateSettings.activeGateMinimap.gadgetID = 15
  gateSettings.activeGateMinimap.position = target.position
  local activeGateMinimap = Marker:create(gateSettings.activeGateMinimap)
  gateSettings.checkpointColumn.position = target.position
  local checkpointColumn = Marker:create(gateSettings.checkpointColumn)
  local checkpointTargetMarker = OnlineModeSettings.createTargetMarker()
  checkpointTargetMarker.targetType = "MultiplayerObjective"
  checkpointTargetMarker.gadgetID = 15
  checkpointTargetMarker.position = checkpointTargetMarker.position + target.position
  checkpointTargetMarker.colour = vec.vector(255, 255, 255, 255) + OnlineModeSettings.targetAlphaMask32
  checkpointTargetMarker.radius = 50
  checkpointTargetMarker = Marker:create(checkpointTargetMarker)
  cylinderSettings.position = target.position
  cylinderSettings.colour = OnlineModeSettings.yellow32 - vec.vector(0, 0, 0, 96)
  cylinderSettings.scale = vec.vector(10, 6, 10, 0)
  cylinderSettings.offset = vec.vector(0, 0, 0, 0)
  cylinderSettings.gadgetID = 245
  local cyclinder = Marker:create(cylinderSettings)
  cylStripesSettings.position = target.position
  cylStripesSettings.colour = OnlineModeSettings.yellow32
  cylStripesSettings.scale = vec.vector(10.5, 10, 10.5, 0)
  cylStripesSettings.offset = vec.vector(0, 5, 0, 0)
  cylStripesSettings.gadgetID = 246
  local cyclinderStripe = Marker:create(cylStripesSettings)
  local function cleanup()
    OneShotSound.Play("HUD_Play_Checkpoint")
    print("==================== CHECKPOINT AUDIO 02")
    assert(activeGateMinimap, "activeGateMinimap does not exist")
    assert(checkpointColumn, "checkpointColumn does not exist")
    assert(checkpointTargetMarker, "checkpointTargetMarker does not exist")
    assert(cyclinder, "cyclinder does not exist")
    assert(cyclinderStripe, "cyclinderStripe does not exist")
    Marker:delete(activeGateMinimap)
    Marker:delete(checkpointColumn)
    Marker:delete(checkpointTargetMarker)
    Marker:delete(cyclinder)
    Marker:delete(cyclinderStripe)
  end
  return nil, cleanup
end)
local movieChallengeSettings = {
  icon = {
    type = "World",
    facing = true,
    gadgetID = 133,
    scale = vec.vector(4, 4, 4, 1),
    colour = vec.vector(255, 255, 255, 255),
    visible = true,
    introType = "Fade",
    outroType = "Fade"
  }
}
feedbackSystem.registerTargetStyle("Movie challenge icon", {}, function(target, params)
  target.markers = target.markers or {}
  for k, v in next, movieChallengeSettings, nil do
    local offset = vec.vector(0, 4, 0, 0)
    v.position = workingVector:add(target.position, offset)
    target.markers[k] = Marker:create(v)
  end
  local UID = getUID()
  local hotspotOffset = vec.vector(0, 4, 0, 0)
  local position = workingVector:add(target.position, hotspotOffset)
  TerrainMarker.Update(UID, target.position, vec.vector(0, 0, 0, 0.8), activeChallenges.movieChallengeRadius * 1.3)
  local function cleanup()
    for k, v in next, target.markers, nil do
      Marker:delete(v)
    end
    target.markers = nil
    TerrainMarker.Delete(UID)
  end
  return nil, cleanup
end)
local shiftMinimapIconSettings = {
  minimap = {
    type = "Minimap",
    colour = vec.vector(255, 255, 255, 255),
    constrain = false,
    gadgetID = 71,
    radius = 35,
    visible = true,
    canrotate = false,
    constrain = false,
    nofade = true,
    animationType = "None"
  },
  shift = {
    type = "Shift",
    colour = vec.vector(255, 255, 255, 255),
    gadgetID = 71,
    radius = 35,
    visible = true,
    canrotate = false
  }
}
local activityInWorldIconSettings = {
  hotspot = {
    type = "World",
    gadgetID = 202,
    scale = vec.vector(9, 9, 9, 0),
    colour = vec.vector(255, 255, 255, 200),
    visible = true,
    facing = true,
    facinginzap = false,
    isoffsetinzap = false,
    introType = "Fade",
    outroType = "Fade"
  },
  icon = {
    type = "World",
    gadgetID = 215,
    scale = vec.vector(1.9, 1.9, 1.9, 0),
    colour = vec.vector(255, 255, 255, 220),
    offset = vec.vector(0, 7.9, 0, 0),
    visible = true,
    facing = true,
    facinginzap = false,
    isoffsetinzap = false,
    introType = "Fade",
    outroType = "Fade",
    sortBias = 15
  },
  willpowerNumber = {
    type = "Willpower",
    colour = vec.vector(255, 255, 255, 255),
    scale = vec.vector(2.8, 2.8, 2.8, 0),
    offset = vec.vector(-1.8, 6.3, 0, 0),
    visible = false,
    angle = 0,
    spacing = 1.2,
    number = 50,
    numberof = 0,
    facing = true,
    fadedistance = 120,
    minalpha = 100,
    maxalpha = 255,
    localID = nil,
    introType = "Fade",
    outroType = "Fade"
  }
}
local dareInWorldIconSettings = {
  column = {
    type = "World",
    gadgetID = 204,
    colour = vec.vector(255, 255, 255, 200),
    scale = vec.vector(8, 5, 1, 0),
    offset = vec.vector(0, 0, 0, 0),
    visible = true,
    facing = true,
    fadedistance = 120,
    minalpha = 100,
    maxalpha = 255,
    introType = "Fade",
    outroType = "Fade",
    sortBias = 1
  },
  icon = {
    type = "World",
    gadgetID = 215,
    scale = vec.vector(0.9, 0.9, 0.9, 0),
    colour = vec.vector(255, 255, 255, 255),
    offset = vec.vector(0, 3, 0, 0),
    visible = true,
    facing = true,
    facinginzap = false,
    isoffsetinzap = false,
    introType = "Fade",
    outroType = "Fade",
    sortBias = 2
  },
  willpowerNumber = {
    type = "Willpower",
    colour = vec.vector(255, 255, 255, 255),
    scale = vec.vector(2.8, 2.8, 2.8, 0),
    offset = vec.vector(-1.8, 6.3, 0, 0),
    visible = false,
    angle = 0,
    spacing = 1.2,
    number = 50,
    numberof = 0,
    facing = true,
    fadedistance = 120,
    minalpha = 100,
    maxalpha = 255,
    localID = nil,
    introType = "Fade",
    outroType = "Fade"
  }
}
local inWorldIconLookupTable = {
  challengeRace = {
    newGadgetID = 300,
    completedGadgetID = 304,
    newIcon = 280,
    completedIcon = 279,
    hotspot = 270,
    column = 204,
    activityFilterID = 1,
    challengeFilterID = 4
  },
  challengeTimeTrial = {
    newGadgetID = 300,
    completedGadgetID = 304,
    newIcon = 280,
    completedIcon = 279,
    hotspot = 270,
    column = 204,
    activityFilterID = 1,
    challengeFilterID = 4
  },
  challengeEscape = {
    newGadgetID = 301,
    completedGadgetID = 303,
    newIcon = 278,
    completedIcon = 277,
    hotspot = 270,
    column = 207,
    activityFilterID = 2,
    challengeFilterID = 4
  },
  challengeGetaway = {
    newGadgetID = 301,
    completedGadgetID = 303,
    newIcon = 278,
    completedIcon = 277,
    hotspot = 270,
    column = 207,
    activityFilterID = 2,
    challengeFilterID = 4
  },
  challengeDrift = {
    newGadgetID = 302,
    completedGadgetID = 305,
    newIcon = 276,
    completedIcon = 281,
    hotspot = 270,
    column = 210,
    activityFilterID = 3,
    challengeFilterID = 4
  },
  challengeStunt = {
    newGadgetID = 302,
    completedGadgetID = 305,
    newIcon = 276,
    completedIcon = 281,
    hotspot = 270,
    column = 210,
    activityFilterID = 3,
    challengeFilterID = 4
  },
  movieRace = {
    newGadgetID = 300,
    completedGadgetID = 304,
    newIcon = 280,
    completedIcon = 279,
    hotspot = 270,
    column = 204,
    activityFilterID = 1,
    challengeFilterID = 4
  },
  movieAction = {
    newGadgetID = 301,
    completedGadgetID = 303,
    newIcon = 278,
    completedIcon = 277,
    hotspot = 270,
    column = 207,
    activityFilterID = 2,
    challengeFilterID = 4
  },
  movieStunt = {
    newGadgetID = 302,
    completedGadgetID = 305,
    newIcon = 276,
    completedIcon = 281,
    hotspot = 270,
    column = 210,
    activityFilterID = 3,
    challengeFilterID = 4
  },
  standardRace = {
    newGadgetID = 285,
    completedGadgetID = 286,
    newIcon = 273,
    completedIcon = 272,
    hotspot = 270,
    column = 204,
    activityFilterID = 1,
    challengeFilterID = 5
  },
  standardTeamRace = {
    newGadgetID = 285,
    completedGadgetID = 286,
    newIcon = 273,
    completedIcon = 272,
    hotspot = 270,
    column = 204,
    activityFilterID = 1,
    challengeFilterID = 5
  },
  standardEscape = {
    newGadgetID = 282,
    completedGadgetID = 283,
    newIcon = 269,
    completedIcon = 268,
    hotspot = 270,
    column = 207,
    activityFilterID = 2,
    challengeFilterID = 5
  },
  standardTakedown = {
    newGadgetID = 282,
    completedGadgetID = 283,
    newIcon = 269,
    completedIcon = 268,
    hotspot = 270,
    column = 207,
    activityFilterID = 2,
    challengeFilterID = 5
  },
  standardCheckpointTrial = {
    newGadgetID = 287,
    completedGadgetID = 284,
    newIcon = 267,
    completedIcon = 274,
    hotspot = 270,
    column = 210,
    activityFilterID = 3,
    challengeFilterID = 5
  },
  standardStunt = {
    newGadgetID = 287,
    completedGadgetID = 284,
    newIcon = 267,
    completedIcon = 274,
    hotspot = 270,
    column = 210,
    activityFilterID = 3,
    challengeFilterID = 5
  },
  dareSpeed = {
    gadgetID = 288,
    icon = 271,
    hotspot = 275,
    column = 275,
    activityFilterID = 1,
    challengeFilterID = 5
  },
  dareAction = {
    gadgetID = 288,
    icon = 271,
    hotspot = 275,
    column = 275,
    activityFilterID = 2,
    challengeFilterID = 5
  },
  dareStunt = {
    gadgetID = 288,
    icon = 271,
    hotspot = 275,
    column = 275,
    activityFilterID = 3,
    challengeFilterID = 5
  },
  story = {gadgetID = 299, icon = 292}
}
function targetStyleInWorldVisible(target, state)
  if state then
    target.markers = target.markers or {}
    if not target.markers.icon then
      local settings = {}
      local dare = false
      if target.iconType == "dareSpeed" or target.iconType == "dareAction" or target.iconType == "dareStunt" then
        dare = true
      end
      if dare then
        duplicateTable(dareInWorldIconSettings, settings)
      else
        duplicateTable(activityInWorldIconSettings, settings)
      end
      if not target.hotspotTerrainMarkerUID then
        target.hotspotTerrainMarkerUID = getUID()
        TerrainMarker.Update(target.hotspotTerrainMarkerUID, target.position, vec.vector(0.05, 0.08, 0.15, 0.7), 7.5)
      end
      if dare and settings.willpowerNumber then
        settings.willpowerNumber.number = willpowerRewards.dares[target.chapter]
      elseif target.ID and settings.willpowerNumber then
        settings.willpowerNumber.number = progressionSystem.getChallengeWillpowerReward(target.ID)
      end
      for icon, data in next, settings, nil do
        data.position = target.position
        if icon == "icon" then
          if target.ID and target.iconType ~= "story" then
            local iconType = ProfileSettings.GetChallengeCompleted(cards.ReverseMissionNetworkLookup[target.ID]) and "completedIcon" or "newIcon"
            data.gadgetID = inWorldIconLookupTable[target.iconType][iconType]
          else
            data.gadgetID = inWorldIconLookupTable[target.iconType][icon]
          end
        else
          data.gadgetID = inWorldIconLookupTable[target.iconType][icon]
        end
        target.markers[icon] = Marker:create(data)
      end
    end
  elseif target.markers then
    if target.hotspotTerrainMarkerUID then
      TerrainMarker.Delete(target.hotspotTerrainMarkerUID)
      target.hotspotTerrainMarkerUID = nil
    end
    for icon, data in next, target.markers, nil do
      if icon ~= "minimap" and icon ~= "shift" then
        Marker:delete(data)
        target.markers[icon] = nil
      end
    end
  end
end
function targetStyleInWorldSetComplete(target)
  if target.markers then
    for icon, marker in next, target.markers, nil do
      if shiftMinimapIconSettings[icon] then
        Marker:delete(marker)
        local data = shiftMinimapIconSettings[icon]
        data.position = target.position
        data.radius = 35
        data.gadgetID = inWorldIconLookupTable[target.iconType].completedGadgetID
        data.constrain = false
        data.animationType = "None"
        target.markers[icon] = Marker:create(data)
      end
    end
  end
end
local trackingMarker = {
  type = "Target",
  colour = vec.vector(255, 255, 255, 255),
  radius = 50,
  visible = true,
  flashes = false,
  showDistance = true,
  targetType = "Destination",
  animationType = "Pulse"
}
function unlockTrackingMarker(target, missionID)
  local deleteTrackingMarker = function(target, markerInfo)
    if activeChallenges.drawnInstances and activeChallenges.drawnInstances[target.ID] then
      if markerInfo and markerInfo.markers and markerInfo.markers.tracking then
        Marker:delete(markerInfo.markers.tracking)
        markerInfo.markers.tracking = nil
      end
    elseif target.markers and target.markers.tracking then
      Marker:delete(target.markers.tracking)
      target.markers.tracking = nil
    end
  end
  local markerInfo = false
  local name = "unlockTrackingMarker" .. tostring(missionID)
  trackingMarker.position = target.position
  trackingMarker.gadgetID = inWorldIconLookupTable[target.iconType].newGadgetID or inWorldIconLookupTable[target.iconType].gadgetID
  if activeChallenges.drawnInstances and activeChallenges.drawnInstances[target.ID] then
    for k, v in next, activeChallenges.drawnInstances[target.ID], nil do
      markerInfo = v
      break
    end
    if markerInfo then
      markerInfo.markers = markerInfo.markers or {}
      trackingMarker.gameVehicle = markerInfo.agent.gameVehicle
      markerInfo.markers.tracking = Marker:create(trackingMarker)
      trackingMarker.gameVehicle = nil
    end
  elseif target.markers then
    target.markers.tracking = Marker:create(trackingMarker)
  end
  addUserUpdateFunction(name, function()
    deleteTrackingMarker(target, markerInfo)
    removeUserUpdateFunction(name)
  end, 20 * updates.stepRate, true)
end
feedbackSystem.registerTargetStyle("In world icon", {}, function(target, params)
  target.markers = target.markers or {}
  if target.markers then
    for k, v in next, target.markers, nil do
      if k == "minimap" or k == "shift" then
        Marker:delete(v)
      end
    end
  end
  for icon, data in next, shiftMinimapIconSettings, nil do
    if icon == "minimap" or icon == "shift" then
      if target.ID then
        local iconType = ProfileSettings.GetChallengeCompleted(cards.ReverseMissionNetworkLookup[target.ID]) and "completedGadgetID" or "newGadgetID"
        data.gadgetID = inWorldIconLookupTable[params.type][iconType]
      else
        data.gadgetID = inWorldIconLookupTable[params.type].gadgetID
      end
      data.position = target.position
      if icon == "minimap" and not ProfileSettings.GetStoryModeComplete() and not ProfileSettings.GetMissionCompleted(cards.ReverseMissionNetworkLookup["Tutorial activity"]) and (configSelector.launchConfig.Name == "Single Player" or configSelector.launchConfig.Name == "Post Debrief") then
        data.constrain = true
        data.animationType = "WaveScale"
      else
        data.constrain = false
        data.animationType = "None"
      end
      if target.iconType == "dareSpeed" or target.iconType == "dareAction" or target.iconType == "dareStunt" then
        data.radius = 60
      else
        data.radius = 35
      end
      target.markers[icon] = Marker:create(data)
      if icon == "shift" and not target.activityFilterID then
        target.activityFilterID = inWorldIconLookupTable[params.type].activityFilterID
        target.challengeFilterID = inWorldIconLookupTable[params.type].challengeFilterID
      end
      if not target.markers[icon] then
        print("Warning: Failed to create " .. tostring(icon) .. " icon for " .. tostring(params.type))
      end
    end
  end
  local function cleanup()
    for k, v in next, target.markers, nil do
      Marker:delete(v)
    end
    target.markers = nil
    target.activityFilterID = nil
    target.challengeFilterID = nil
  end
  return nil, cleanup
end)
local tokenIconSettings = {
  type = "World",
  scale = vec.vector(0.7, 0.7, 0.7, 0),
  colour = vec.vector(255, 255, 255, 255),
  offset = vec.vector(0, 1.5, 0, 0),
  gadgetID = 289,
  visible = true,
  facing = true,
  facinginzap = false,
  isoffsetinzap = false,
  introType = "Fade"
}
feedbackSystem.registerTargetStyle("Token In World", {}, function(target, params)
  target.markers = target.markers or {}
  local data = tokenIconSettings
  data.position = target.position
  target.markers.icon = Marker:create(data)
  if not target.markers.icon then
    print("Warning: Failed to create in world icon for token")
  end
  local function cleanup()
    Marker:delete(target.markers.icon)
    target.markers.icon = nil
  end
  return nil, cleanup
end)
local tokenMinimapSettings = {
  type = "Minimap",
  gadgetID = 290,
  colour = vec.vector(255, 255, 255, 255),
  radius = 15,
  heading = math.pi,
  visible = true,
  canrotate = false,
  constrain = false
}
feedbackSystem.registerTargetStyle("Token Minimap", {}, function(target, params)
  target.markers = target.markers or {}
  local data = tokenMinimapSettings
  data.position = target.position
  target.markers.minimap = Marker:create(data)
  if not target.markers.minimap then
    print("Warning: Failed to create minimap icon for token")
  end
  local function cleanup()
    Marker:delete(target.markers.minimap)
    target.markers.minimap = nil
  end
  return nil, cleanup
end)
feedbackSystem.registerTargetStyle("SS Coop Survival Checkpoint Gate", {}, function(target, params, task)
  local checkpointMarkers = {}
  local settings = {}
  local plr = task.taskObject.player
  local roadWidth, roadAngle
  if target.toolData and target.toolData.displayWidth and target.toolData.heading then
    roadWidth = target.toolData.displayWidth
    roadAngle = target.toolData.heading
  else
    local roadIndex, distanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(target.position)
    roadWidth = Atlas.AverageRoadWidth(roadIndex)
    local roadHeading = getVectorRoadAngleAtPosition(roadIndex, distanceAlong)
    roadAngle = math.atan2(roadHeading.x, roadHeading.z)
  end
  if roadWidth == 0 then
    roadWidth = 18
  end
  local allCheckpoints = false
  local numCheckpoints = 0
  local dontDrawGate = false
  local hideEndScreenMarkers = false
  local lastCheckpoint = false
  Marker.setAnimationLength("Fade", 0.5)
  duplicateTable(checkpointGateMarkers, settings)
  settings.checkpointGate.scale = params.targetScale
  settings.checkpointGate.heading = roadAngle
  local taskObject = plr.missionSupport:getMainTaskObject()
  local packageTO = task.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  local level = packageTO and packageTO.namedTasks.level and packageTO.namedTasks.level.networkVars.level or 1
  allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(taskObject.coreData.instance.instanceID, level)
  numCheckpoints = #allCheckpoints
  settings.checkpointNumber.angle = roadAngle
  settings.checkpointNumber.number = target.checkpointNum
  settings.checkpointNumber.numberof = numCheckpoints
  if target.checkpointNum == numCheckpoints then
    if level == params.maxLevel then
      lastCheckpoint = true
      settings.activeGateMinimap.gadgetID = 111
    end
    settings.activeGateMinimap.colour = vec.vector(255, 0, 0, 255)
    settings.checkpointGate.colour = vec.vector(255, 0, 0, 255)
    settings.checkpointColumn.colour = vec.vector(255, 0, 0, 255)
    settings.checkpointNumber.colour = vec.vector(255, 0, 0, 255)
    settings.checkpointTarget.colour = vec.vector(255, 0, 0, 255)
  end
  if roadWidth > 65 then
    settings.checkpointNumber.offset = vec.vector(0, 7, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 248
    else
      settings.checkpointGate.gadgetID = 250
    end
  elseif roadWidth > 45 then
    settings.checkpointNumber.offset = vec.vector(0, 7, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 249
    else
      settings.checkpointGate.gadgetID = 247
    end
  elseif roadWidth > 35 then
    settings.checkpointNumber.offset = vec.vector(0, 7, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 65
    else
      settings.checkpointGate.gadgetID = 60
    end
  elseif roadWidth > 26 then
    settings.checkpointNumber.offset = vec.vector(0, 7.7, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 64
    else
      settings.checkpointGate.gadgetID = 59
    end
  elseif roadWidth > 18 then
    settings.checkpointNumber.offset = vec.vector(0, 6.7, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 63
    else
      settings.checkpointGate.gadgetID = 58
    end
  elseif roadWidth > 8 then
    settings.checkpointNumber.offset = vec.vector(0, 6.8, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 62
    else
      settings.checkpointGate.gadgetID = 57
    end
  else
    settings.checkpointNumber.offset = vec.vector(0, 5.8, 0, 0)
    if lastCheckpoint then
      settings.checkpointGate.gadgetID = 61
    else
      settings.checkpointGate.gadgetID = 56
    end
  end
  for marker, markerData in next, settings, nil do
    markerData.position = target.position
    markerData.localID = plr.localID
    if marker == "checkpointTarget" then
      markerData.position = target.position + vec.vector(0, 10, 0, 0)
      markerData.colour = markerData.colour + OnlineModeSettings.targetAlphaMask32
      markerData.longDistanceTarget = true
    end
    checkpointMarkers[marker] = Marker:create(markerData)
  end
  local function cleanup()
    OneShotSound.Play("HUD_Play_Checkpoint")
    if checkpointMarkers then
      for marker, markerData in next, checkpointMarkers, nil do
        assert(markerData, "v does not exist, marker:" .. marker)
        Marker:delete(markerData)
        checkpointMarkers[marker] = nil
      end
    end
  end
  return nil, cleanup
end)
