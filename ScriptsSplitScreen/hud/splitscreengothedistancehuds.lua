feedbackSystem.registerHUD("SS Go the Distance Start HUD", function(task, settings)
end, function(instance)
  instance = localPlayer.getTaskObject().coreData.instance
  local trailBlazerTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local trailBlazerVehicle = trailBlazerTaskObject.coreData.agent
  local markerSettings = {
    Target = {
      type = "Target",
      colour = OnlineModeSettings.red32 + OnlineModeSettings.targetAlphaMask32,
      targetType = "MultiplayerObjective",
      gadgetID = 178,
      radius = 45,
      visible = true,
      markerOffset = 1
    },
    MinimapArrow = {
      type = "Minimap",
      radius = 40,
      visible = true,
      canrotate = true,
      colour = OnlineModeSettings.red32,
      gadgetID = 257,
      nofade = true
    },
    Minimap = {
      type = "Minimap",
      radius = 40,
      visible = true,
      canrotate = false,
      colour = OnlineModeSettings.red32,
      gadgetID = 255,
      nofade = true
    }
  }
  local clearMainMarker = function(vehicle)
    vehicle:disableMinimapMarker(false)
    if vehicle.markers then
      for k, v in next, vehicle.markers, nil do
        Marker:delete(v)
        vehicle.markers[k] = nil
      end
    end
  end
  local function setMainMarker(vehicle)
    vehicle:disableMinimapMarker(true)
    vehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
    vehicle.markers = vehicle.markers or {}
    for k, v in next, markerSettings, nil do
      v.gameVehicle = vehicle.gameVehicle
      if v.type == "World" then
        v.offset = vec.vector(0, vehicle.gameVehicle.height + 1, 0, 0)
      end
      vehicle.markers[k] = Marker:create(v)
    end
  end
  setMainMarker(trailBlazerVehicle)
  trailBlazerVehicle:disableDisplay(false)
  trailBlazerVehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
  local function cleanup()
    clearMainMarker(trailBlazerVehicle)
    trailBlazerVehicle:deleteDisplay()
  end
  return nil, nil, nil, cleanup
end)
feedbackSystem.registerHUD("SS Go the Distance HUD", function(task, settings)
end, function(task)
  local instance = task.instance
  local trailBlazerTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local trailBlazerVehicle = trailBlazerTaskObject.coreData.agent
  local localPlayerID = task.agent.localID
  local player = task.agent
  local previousFuel = 100
  local increaseValue = 10
  local workingVector = vec.vector()
  local previousLevel = instance.currentSSLevel
  local scoreBarSetup = false
  local routeIndex = instance.networkVars.routeIndex
  local location = phaseManager.playlistSupport.getSelectedLocation()
  assert(location >= 1 and location <= 3, "Mode location not between 1 and 3")
  feedbackSystem.menusMaster.disableDamageBar(player)
  feedbackSystem.menusMaster.ssDamagerBarBlocker = true
  local aproxRouteLength = workingVector:sub(trailBlazerVehicle.position, instance.challenge.spawnPositions[routeIndex].routes[instance.currentSSLevel][#instance.challenge.spawnPositions[routeIndex].routes[instance.currentSSLevel]].position):length()
  local previousScore = 0
  local workingScore = 0
  local fuelBarOn = false
  local alertOn = false
  local scored = false
  local markerSettings = {
    Target = {
      type = "Target",
      colour = OnlineModeSettings.red32 + OnlineModeSettings.targetAlphaMask32,
      gadgetID = 178,
      radius = 45,
      visible = true,
      targetType = "MultiplayerObjective",
      localID = localPlayerID,
      markerOffset = 1
    },
    MinimapArrow = {
      type = "Minimap",
      radius = 40,
      visible = true,
      canrotate = true,
      colour = OnlineModeSettings.red32,
      gadgetID = 257,
      nofade = true,
      localID = localPlayerID
    },
    Minimap = {
      type = "Minimap",
      radius = 40,
      visible = true,
      canrotate = false,
      colour = OnlineModeSettings.red32,
      gadgetID = 255,
      nofade = true,
      localID = localPlayerID
    },
    HealthBarMarker = {
      type = "World",
      facing = true,
      gadgetID = 97,
      scale = vec.vector(0.2, 0.2, 0.2, 0),
      offset = vec.vector(0, 1.6, 0, 0),
      colour = vec.vector(255, 255, 255, 255),
      visible = true,
      localID = localPlayerID
    }
  }
  local checkpointSettings = {
    type = "World",
    facing = false,
    colour = OnlineModeSettings.red32,
    targetScale = vec.vector(1, 1, 1, 1),
    visible = true,
    fadedistance = 120,
    minalpha = 0,
    maxalpha = 255,
    introType = "Fade",
    outroType = "Fade"
  }
  local checkpointMinimapSettings = {
    type = "Minimap",
    colour = OnlineModeSettings.red32,
    radius = 30,
    visible = true,
    nofade = true,
    canrotate = false,
    introType = "BigScaleDown",
    animationType = "WaveScale",
    outroType = "Fade"
  }
  local checkpointColumnSettings = {
    type = "World",
    gadgetID = 79,
    colour = OnlineModeSettings.red32,
    visible = true,
    offset = vec.vector(0, 1.5, 0, 0),
    facing = true,
    fadedistance = 120,
    minalpha = 0,
    maxalpha = 255,
    introType = "Fade",
    outroType = "Fade"
  }
  local checkpointMarker, checkpointColumnMarker, checkpointMinimapMarker, roadWidth, roadHeading, previousRouteIndex, lastFuelValue
  local trailSoundOn = false
  local hasBeenTrailScore = false
  local function removeCheckpoint()
    if checkpointMarker then
      Marker:delete(checkpointMarker)
      checkpointMarker = nil
      Marker:delete(checkpointColumnMarker)
      checkpointColumnMarker = nil
      Marker:delete(checkpointMinimapMarker)
      checkpointMinimapMarker = nil
    end
  end
  local function drawCheckpoint(checkpoint)
    removeCheckpoint()
    if checkpoint.displayWidth and checkpoint.heading then
      roadWidth = checkpoint.displayWidth
      roadHeading = checkpoint.heading
    else
      local roadIndex, distanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(checkpoint.position)
      roadWidth = Atlas.AverageRoadWidth(roadIndex)
      local roadAngle = getVectorRoadAngleAtPosition(roadIndex, distanceAlong)
      roadHeading = math.atan2(roadAngle.x, roadAngle.z)
    end
    checkpointSettings.position = checkpoint.position
    checkpointSettings.heading = roadHeading
    checkpointColumnSettings.position = checkpoint.position
    checkpointMinimapSettings.position = checkpoint.position
    if trailBlazerTaskObject.namedTasks.fuel.networkVars.routeIndex == 10 then
      if roadWidth <= 8 then
        checkpointSettings.gadgetID = 61
      elseif roadWidth <= 16 then
        checkpointSettings.gadgetID = 62
      elseif roadWidth <= 24 then
        checkpointSettings.gadgetID = 63
      elseif roadWidth <= 32 then
        checkpointSettings.gadgetID = 64
      else
        checkpointSettings.gadgetID = 65
      end
      checkpointMinimapSettings.gadgetID = 111
    else
      if roadWidth <= 8 then
        checkpointSettings.gadgetID = 56
      elseif roadWidth <= 16 then
        checkpointSettings.gadgetID = 57
      elseif roadWidth <= 24 then
        checkpointSettings.gadgetID = 58
      elseif roadWidth <= 32 then
        checkpointSettings.gadgetID = 59
      else
        checkpointSettings.gadgetID = 60
      end
      checkpointMinimapSettings.gadgetID = 73
    end
    checkpointMarker = Marker:create(checkpointSettings)
    checkpointColumnMarker = Marker:create(checkpointColumnSettings)
    checkpointMinimapMarker = Marker:create(checkpointMinimapSettings)
  end
  if localPlayerID == 0 then
    previousRouteIndex = trailBlazerTaskObject.namedTasks.fuel.networkVars.routeIndex
    local routeSize = #instance.challenge.spawnPositions[routeIndex].routes[previousRouteIndex]
    drawCheckpoint(instance.challenge.spawnPositions[routeIndex].routes[previousRouteIndex][routeSize])
  end
  local function clearMainMarker(vehicle)
    vehicle:disableMinimapMarker(false)
    if vehicle.markers then
      for k, v in next, vehicle.markers, nil do
        Marker:delete(v)
        vehicle.markers[localPlayerID][k] = nil
      end
    end
  end
  local function setMainMarker(vehicle)
    vehicle:disableMinimapMarker(true)
    vehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
    vehicle.markers = vehicle.markers or {}
    vehicle.markers[localPlayerID] = {}
    for k, v in next, markerSettings, nil do
      v.gameVehicle = vehicle.gameVehicle
      if v.type == "World" then
        v.offset = vec.vector(0, vehicle.gameVehicle.height + 1, 0, 0)
      end
      if k == "HealthBarMarker" then
        v.uValue = 0
        v.vValue = 0
      end
      vehicle.markers[localPlayerID][k] = Marker:create(v)
    end
  end
  setMainMarker(trailBlazerVehicle)
  if localPlayerID == 0 then
    trailBlazerVehicle:disableDisplay(false)
    trailBlazerVehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
    trailBlazerVehicle:addLightTrail(instance.challenge.settings.trailLengths[location][1], OnlineModeSettings.red128, 2, true)
  end
  local function setupScoreBar()
    if Menu.GetSceneStatus("Splitscreen", "ss_racemode_countdown") == 2 then
      feedbackSystem.splitScreenSupport.setupScoringBar(increaseValue, true)
      feedbackSystem.splitScreenSupport.updateLevelCounterBarCoop(0, 0, true)
      PauseMenu.allow(true)
      scoreBarSetup = true
    end
  end
  local function stepProgressBar()
    if previousLevel ~= instance.currentSSLevel then
      previousLevel = instance.currentSSLevel
      aproxRouteLength = workingVector:sub(trailBlazerVehicle.position, instance.challenge.spawnPositions[routeIndex].routes[instance.currentSSLevel][#instance.challenge.spawnPositions[routeIndex].routes[instance.currentSSLevel]].position):length()
      feedbackSystem.splitScreenSupport.updateLevelCounterBarCoop(0, previousLevel - 1, true)
      OneShotSound.PlayGUI("HUD_Gen_Positive")
      scored = true
    end
    workingScore = 1 - workingVector:sub(trailBlazerVehicle.position, instance.challenge.spawnPositions[routeIndex].routes[instance.currentSSLevel][#instance.challenge.spawnPositions[routeIndex].routes[instance.currentSSLevel]].position):length() / aproxRouteLength + instance.currentSSLevel - 1
    if workingScore > previousScore then
      feedbackSystem.splitScreenSupport.updateScoringBar(0, workingScore, true)
      previousScore = workingScore
    end
  end
  if localPlayerID == 0 then
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_fuelbar_display", 1)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_fuelbar_anim", 100)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_fuelbar_alert", 0)
    fuelBarOn = true
  else
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_fuelbar_display", 1)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_fuelbar_anim", 100)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_fuelbar_alert", 0)
    fuelBarOn = true
  end
  local function stepFuelBars()
    if localPlayerID == 0 then
      if player.currentVehicle then
        if not fuelBarOn then
          feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_fuelbar_display", 1)
          feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_fuelbar_anim", 100)
          fuelBarOn = true
        elseif player.currentVehicle.fuel and player.currentVehicle.fuel ~= 0 then
          lastFuelValue = player.currentVehicle.fuel / instance.challenge.settings.playerVehicleFuel[location][trailBlazerTaskObject.namedTasks.fuel.networkVars.routeIndex] * 100
          feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_fuelbar_anim", lastFuelValue)
          if not alertOn and lastFuelValue < 30 then
            feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_fuelbar_alert", 1)
            alertOn = true
          end
        else
          feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_fuelbar_anim", 0)
        end
      elseif fuelBarOn then
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_fuelbar_alert", 0)
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_fuelbar_display", 0)
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_fuelbar_anim", 0)
        fuelBarOn = false
        alertOn = false
      end
    elseif player.currentVehicle then
      if not fuelBarOn then
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_fuelbar_display", 1)
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_fuelbar_anim", 100)
        fuelBarOn = true
      elseif player.currentVehicle.fuel and player.currentVehicle.fuel ~= 0 then
        lastFuelValue = player.currentVehicle.fuel / instance.challenge.settings.playerVehicleFuel[location][trailBlazerTaskObject.namedTasks.fuel.networkVars.routeIndex] * 100
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_fuelbar_anim", lastFuelValue)
        if not alertOn and lastFuelValue < 30 then
          feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_fuelbar_alert", 1)
          alertOn = true
        end
      else
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_fuelbar_anim", 0)
      end
    elseif fuelBarOn then
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_fuelbar_alert", 0)
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_fuelbar_display", 0)
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_fuelbar_anim", 0)
      fuelBarOn = false
      alertOn = false
    end
  end
  local trailSound = 0
  local function stepVehicleHighlight()
    if localPlayerID == 0 then
      trailBlazerVehicle:setLightTrailColour(OnlineModeSettings.red128)
      local anyPlayerInTrails = false
      anyPlayerInTrails = localPlayerManager.players[0].currentVehicle and GameVehicleResource.interceptingTrailCount(localPlayerManager.players[0].currentVehicle.gameVehicle) ~= 0
      anyPlayerInTrails = not localPlayerManager.players[1].currentVehicle or anyPlayerInTrails or GameVehicleResource.interceptingTrailCount(localPlayerManager.players[1].currentVehicle.gameVehicle) ~= 0
      if anyPlayerInTrails then
        trailBlazerVehicle:setDisplayColour(OnlineModeSettings.green32, OnlineModeSettings.green128)
        if trailSound == 0 then
          trailSound = OneShotSound.Play("HUD_Online_TrailBlazer_EnterStream", false, false)
        end
      else
        trailBlazerVehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
        if trailSound ~= 0 then
          OneShotSound.Play("HUD_Online_TrailBlazer_ExitStream", false, false)
          trailSound = 0
        end
      end
    end
    hasBeenTrailScore = false
    for i, player in next, playerManager.players, nil do
      if not player.inZap and player.currentVehicle.gameVehicle then
        local score = GameVehicleResource.interceptingTrailCount(player.currentVehicle.gameVehicle)
        if localPlayerID == 0 and score > 0 then
          GameVehicleResource.setInterceptedTrailColour(trailBlazerVehicle.gameVehicle, player.currentVehicle.gameVehicle, OnlineModeSettings.green128)
          hasBeenTrailScore = true
        end
        if score and score > 0 then
          if not player.currentVehicle:vehicleFlashOverridden(player.localID) then
            player.currentVehicle:overRideFlashColour(OnlineModeSettings.green32, OnlineModeSettings.green128, 0)
            player.currentVehicle:overRideFlashColour(OnlineModeSettings.green32, OnlineModeSettings.green128, 1)
          end
        elseif player.currentVehicle:vehicleFlashOverridden(player.localID) then
          player.currentVehicle:removeFlashColourOverRide(0)
          player.currentVehicle:removeFlashColourOverRide(1)
        end
      end
    end
  end
  local playerInTrails = false
  local function stepMarkerFlashes()
    if trailBlazerVehicle.markers and trailBlazerVehicle.markers[localPlayerID] then
      playerInTrails = false
      if localPlayerManager.players[0].currentVehicle then
        playerInTrails = GameVehicleResource.interceptingTrailCount(localPlayerManager.players[0].currentVehicle.gameVehicle) ~= 0
      end
      if localPlayerManager.players[1].currentVehicle and not playerInTrails then
        playerInTrails = GameVehicleResource.interceptingTrailCount(localPlayerManager.players[1].currentVehicle.gameVehicle) ~= 0
      end
      if playerInTrails then
        trailBlazerVehicle.markers[localPlayerID].Target.colour = OnlineModeSettings.green32 + OnlineModeSettings.targetAlphaMask32
        trailBlazerVehicle.markers[localPlayerID].Minimap.colour = OnlineModeSettings.green32
        trailBlazerVehicle.markers[localPlayerID].MinimapArrow.colour = OnlineModeSettings.green32
      else
        trailBlazerVehicle.markers[localPlayerID].Target.colour = OnlineModeSettings.red32 + OnlineModeSettings.targetAlphaMask32
        trailBlazerVehicle.markers[localPlayerID].Minimap.colour = OnlineModeSettings.red32
        trailBlazerVehicle.markers[localPlayerID].MinimapArrow.colour = OnlineModeSettings.red32
      end
      if playerInTrails and trailBlazerVehicle.markers[localPlayerID].Target.animationType == "Flash" then
        trailBlazerVehicle.markers[localPlayerID].Target.animationType = "None"
      elseif not playerInTrails and trailBlazerVehicle.markers[localPlayerID].Target.animationType == "None" then
        trailBlazerVehicle.markers[localPlayerID].Target.animationType = "Flash"
      end
    end
  end
  onlineInstructionSupport.displayPrompt("ID:246048", nil, localPlayerID)
  onlineInstructionSupport.displayPrompt("ID:246048", nil, localPlayerID)
  onlineInstructionSupport.resetPrompts(localPlayerID)
  onlineInstructionSupport.addPrompt("stayInTrails", {
    enabled = false,
    shown = false,
    resetOnScore = true,
    startTime = 0,
    resetTime = 2,
    displayFunction = function(self, objectivePos, opponents, player)
      local instance = localPlayer.getTaskObject().coreData.instance
      for localPlayerID, player in next, localPlayerManager.players, nil do
        if player.currentVehicle and GameVehicleResource.interceptingTrailCount(player.currentVehicle.gameVehicle) ~= 0 then
          instance.lastTrailIntercept = -1
          break
        end
      end
      if not instance.lastTrailIntercept then
        instance.lastTrailIntercept = g_NetworkTime
      elseif instance.lastTrailIntercept == -1 then
        instance.lastTrailIntercept = false
      elseif g_NetworkTime - instance.lastTrailIntercept > 5 then
        onlineInstructionSupport.displayPrompt("ID:246048", nil, player.localID)
        instance.lastTrailIntercept = false
        return true
      end
      return false
    end
  }, localPlayerID)
  onlineInstructionSupport.addPrompt("lowOnFuel", {
    enabled = false,
    shown = false,
    resetOnScore = true,
    startTime = 0,
    resetTime = 5,
    displayFunction = function(self, objectivePos, opponents, player)
      local fuel = 100
      if trailBlazerTaskObject and trailBlazerTaskObject.namedTasks.fuel then
        fuel = trailBlazerTaskObject.namedTasks.fuel.networkVars.fuel
      end
      if fuel <= 25 then
        onlineInstructionSupport.displayPrompt("ID:246052", nil, player.localID)
        return true
      end
      return false
    end
  }, localPlayerID)
  onlineInstructionSupport.addPrompt("rapidShift", {
    enabled = false,
    shown = false,
    resetOnScore = true,
    startTime = 10,
    resetTime = 15,
    displayFunction = function(self, objectivePos, opponents, player)
      if not player.inZap and not GameVehicleResource.withinRadius(player.currentVehicle.position, objectivePos, 400) then
        onlineInstructionSupport.displayPrompt("ID:248713", nil, player.localID)
        return true
      end
      return false
    end
  }, localPlayerID)
  onlineInstructionSupport.setPrompt("rapidShift", nil, nil, nil, "ID:248713", localPlayerID)
  onlineInstructionSupport.setPrompt("accelerate", nil, 3, nil, nil, localPlayerID)
  onlineInstructionSupport.setPrompt("lowOnFuel", nil, nil, nil, nil, localPlayerID)
  onlineInstructionSupport.setPrompt("stayInTrails", nil, nil, nil, nil, localPlayerID)
  local opponents = {}
  local objectivePosition = false
  local function stepInstructionPrompts()
    if trailBlazerTaskObject then
      objectivePosition = trailBlazerTaskObject.coreData.agent.position
    end
    onlineInstructionSupport.step(objectivePosition, opponents, scored, localPlayerID)
    scored = false
  end
  local function update()
    if trailBlazerTaskObject.namedTasks.fuel.networkVars.routeIndex < 11 then
      if previousFuel ~= trailBlazerTaskObject.namedTasks.fuel.networkVars.fuel then
        previousFuel = trailBlazerTaskObject.namedTasks.fuel.networkVars.fuel
        trailBlazerVehicle.markers[localPlayerID].HealthBarMarker.uValue = 1 - previousFuel / 100
        trailBlazerVehicle.markers[localPlayerID].HealthBarMarker.vValue = -(1 - previousFuel / 100)
      end
      if localPlayerID == 0 then
        if scoreBarSetup then
          stepProgressBar()
        else
          setupScoreBar()
        end
        if previousRouteIndex ~= trailBlazerTaskObject.namedTasks.fuel.networkVars.routeIndex then
          removeCheckpoint()
          previousRouteIndex = trailBlazerTaskObject.namedTasks.fuel.networkVars.routeIndex
          local routeSize = #instance.challenge.spawnPositions[routeIndex].routes[previousRouteIndex]
          drawCheckpoint(instance.challenge.spawnPositions[routeIndex].routes[previousRouteIndex][routeSize])
        end
      end
      stepFuelBars()
      stepVehicleHighlight()
      stepInstructionPrompts()
      stepMarkerFlashes()
    end
  end
  local function cleanup(taskObject)
    feedbackSystem.menusMaster.ssDamagerBarBlocker = false
    if localPlayerID == 0 then
      clearMainMarker(trailBlazerVehicle)
      trailBlazerVehicle:deleteDisplay()
      trailBlazerVehicle:removeLightTrail()
      removeCheckpoint()
      if scoreBarSetup then
        if taskObject.coreData.instance.deleteFromPurge then
          feedbackSystem.splitScreenSupport.clearScoringBar(true)
        elseif instance.currentSSLevel == 11 then
          feedbackSystem.splitScreenSupport.updateScoringBar(0, 100, true)
          feedbackSystem.splitScreenSupport.updateLevelCounterBarCoop(0, instance.currentSSLevel - 1, true)
        else
          stepProgressBar()
        end
      elseif not scoreBarSetup then
        PauseMenu.allow(true)
        scoreBarSetup = true
      end
    end
    OneShotSound.Play("HUD_Online_TrailBlazer_ExitStream", false, true)
    if fuelBarOn then
      if localPlayerID == 0 then
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_fuelbar_alert", 0)
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_fuelbar_display", 0)
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_fuelbar_anim", 0)
      else
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_fuelbar_alert", 0)
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_fuelbar_display", 0)
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_fuelbar_anim", 0)
      end
    end
  end
  return update, nil, nil, cleanup
end)
