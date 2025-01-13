onlineSideBar.registerSideBar("MP tug of war", function(instance)
  local initiate = function()
    onlineSideBar.toggleSmallSidebarTitle(1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_game_title", "ID:247263")
  end
  local maxScore = instance.challenge.settings.targetScore
  local playerScore = 0
  local isTarget = false
  local packageTO = false
  local flag = false
  local function getData(taskObject)
    if not flag then
      for key, package in next, packageManager.packagesBySNOID, nil do
        flag = package
        break
      end
    end
    if not packageTO then
      packageTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    end
    if taskObject.initiated and flag then
      playerScore = taskObject.namedTasks.score and 0
      isTarget = false
      if flag.playerID and taskObject.coreData.agent.playerID and taskObject.coreData.agent.playerID == flag.playerID then
        isTarget = true
      end
      if isTarget then
        return taskObject.coreData.agent.name, 0, instance.playerScores[taskObject.coreData.agent.playerID + 1], taskObject.coreData.agent.isLocal, 1, taskObject.coreData.agent.playerID
      else
        return taskObject.coreData.agent.name, 0, instance.playerScores[taskObject.coreData.agent.playerID + 1], taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID
      end
    else
      return taskObject.coreData.agent.name, 0, instance.playerScores[taskObject.coreData.agent.playerID + 1], taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID
    end
  end
  local function teamData()
    if packageTO and packageTO.namedTasks.score then
      if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
        return packageTO.namedTasks.score.networkVars.blueTeam + instance.teamScores.team1, maxScore, 0, packageTO.namedTasks.score.networkVars.redTeam + instance.teamScores.team2, maxScore, 0
      else
        return packageTO.namedTasks.score.networkVars.redTeam + instance.teamScores.team2, maxScore, 0, packageTO.namedTasks.score.networkVars.blueTeam + instance.teamScores.team1, maxScore, 0
      end
    elseif PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
      return instance.teamScores.team1, maxScore, 0, instance.teamScores.team2, maxScore, 0
    else
      return instance.teamScores.team2, maxScore, 0, instance.teamScores.team1, maxScore, 0
    end
  end
  local function cleanup()
    packageTO = false
    flag = false
    onlineSideBar.toggleSidebarTimerFlash(0)
    onlineSideBar.toggleTimerSidebarTitle(0)
    onlineSideBar.toggleSmallSidebarTitle(0)
  end
  return initiate, getData, cleanup, onlineSideBar.standardSortFuncs.playerScoreSort, true, false, true, teamData
end)
feedbackSystem.registerHUD("MP tug of war start HUD", function(task, settings)
end, function(task)
  local instance = localPlayer.getTaskObject().coreData.instance
  local localTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  local flagTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local baseTargetMarker, flag
  for key, package in next, packageManager.packagesBySNOID, nil do
    flag = package
    break
  end
  local yellow32 = OnlineModeSettings.yellow32
  local yellow128 = OnlineModeSettings.yellow128
  local ABasePosition = instance.challenge.spawnPositions[flag.index].baseA
  local BBasePosition = instance.challenge.spawnPositions[flag.index].baseB
  local ATeamColour32, ATeamColour128, BTeamColour32, BTeamColour128, ATeamFlagID, BTeamFlagID
  if localTeam == 1 then
    ATeamColour32 = OnlineModeSettings.blue32
    ATeamColour128 = OnlineModeSettings.blue128
    ATeamFlagID = 118
    BTeamColour32 = OnlineModeSettings.red32
    BTeamColour128 = OnlineModeSettings.red128
    BTeamFlagID = 167
  else
    ATeamColour32 = OnlineModeSettings.red32
    ATeamColour128 = OnlineModeSettings.red128
    ATeamFlagID = 167
    BTeamColour32 = OnlineModeSettings.blue32
    BTeamColour128 = OnlineModeSettings.blue128
    BTeamFlagID = 118
  end
  local ABaseMiniMapMarker = false
  local BBaseMiniMapMarker = false
  local worldFlagScale = vec.vector(2.5, 2.5, 2.5, 1)
  local flagTargetMarker = false
  local flagMinimapMarker = false
  local flagWorldMarker = false
  local flagWorldCylinder = false
  local worldFlagCylinderScale = vec.vector(instance.challenge.settings.flagPickupRadius * 2, 1, instance.challenge.settings.flagPickupRadius * 2, 1)
  OneShotSound.Play("HUD_Online_RoundSet")
  feedbackSystem.menusMaster.primaryTextPrompt("ID:221693", instance.networkVars.roundOn)
  ABaseMiniMapMarker = Marker:create({
    type = "Minimap",
    position = ABasePosition,
    gadgetID = 51,
    colour = ATeamColour32,
    radius = 30,
    visible = true,
    canrotate = false
  })
  BBaseMiniMapMarker = Marker:create({
    type = "Minimap",
    position = BBasePosition,
    gadgetID = 51,
    colour = BTeamColour32,
    radius = 30,
    visible = true,
    canrotate = false
  })
  local function update()
    if not flagWorldMarker and not flag.owner then
      flagMinimapMarker = Marker:create({
        type = "Minimap",
        position = flag.position,
        gadgetID = 181,
        colour = yellow32,
        radius = 40,
        visible = true,
        canrotate = false
      })
      flagWorldMarker = Marker:create({
        type = "World",
        position = flag.position,
        gadgetID = 168,
        facing = true,
        visible = true,
        offset = vec.vector(0, 2, 0, 0),
        scale = worldFlagScale,
        colour = OnlineModeSettings.flagAlphaMask
      })
      flagWorldCylinder = Marker:create({
        type = "World",
        position = flag.position,
        gadgetID = 264,
        colour = yellow32,
        visible = true,
        scale = worldFlagCylinderScale,
        sortBias = 1
      })
      flagTargetMarker = Marker:create({
        type = "Target",
        position = flag.position + OnlineModeSettings.targetOffset,
        gadgetID = 181,
        colour = yellow32 + OnlineModeSettings.targetAlphaMask32,
        radius = 60,
        visible = true,
        showDistance = true,
        targetType = "Destination"
      })
    elseif flagWorldMarker and flag.owner then
      Marker:delete(flagMinimapMarker)
      Marker:delete(flagWorldMarker)
      Marker:delete(flagWorldCylinder)
      Marker:delete(flagTargetMarker)
      flagMinimapMarker = false
      flagWorldMarker = false
      flagWorldCylinder = false
      flagTargetMarker = false
    end
  end
  local function cleanupCallback()
    if BBaseMiniMapMarker then
      Marker:delete(BBaseMiniMapMarker)
    end
    if ABaseMiniMapMarker then
      Marker:delete(ABaseMiniMapMarker)
    end
    if flagMinimapMarker then
      Marker:delete(flagMinimapMarker)
    end
    if flagWorldMarker then
      Marker:delete(flagWorldMarker)
      Marker:delete(flagWorldCylinder)
    end
    if flagTargetMarker then
      Marker:delete(flagTargetMarker)
    end
  end
  phaseManager.startHUDCleanupFunction = cleanupCallback
  return update, nil, nil, nil
end)
feedbackSystem.registerHUD("MP tug of war main HUD", function(task, settings)
end, function(task)
  if phaseManager.startHUDCleanupFunction then
    phaseManager.startHUDCleanupFunction()
    phaseManager.startHUDCleanupFunction = false
  end
  local healthBarMarker = false
  local previousHealth = false
  local currentFlagTeam = false
  local currentFlagVehicle = false
  local currentFlagPlayerID = false
  local flagVehicleTargetMarker = false
  local flagVehicleMinimapMarker = false
  local flagVehicleMinimapArrow = false
  local lastKnownFlagOwner = false
  local lastKnownFlagPlayerID = false
  local lastKnowFlagCarrierCaps = 0
  local flagTargetMarker = false
  local flagWorldMarker = false
  local flagWorldCylinder = false
  local flagMinimapMarker = false
  local scored = false
  local hasFlag = false
  local teamHasFlag = false
  local nobodyHasFlag = false
  local opponents = {}
  local flashStartTime = -1
  local carHighLightFlash = false
  local lastFlashTime = -1
  local flashTickTime = 0.1
  local flashTime = 2
  local flashColour32 = false
  local flashColour128 = false
  local flashPlayerID = -1
  local colourA = false
  local flashVehicle = false
  local lowTimeMessage = true
  local lowTimeFlash = true
  local timeRemaining = false
  local prevSeconds = false
  local timerOn = false
  local lastKnownPosition = false
  local ABaseTargetMarker = false
  local BBaseTargetMarker = false
  local targetBaseTargetMarker = false
  local instance = task.instance
  local playerTaskObject = taskSystem.taskObjects[task.taskObjectID]
  local localTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  local flagTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local numFlagsToCapture = instance.challenge.settings.targetScore
  local maxTime = task.instance.challenge.settings.modeTimeLimit
  local origin = vec.vector(0, 0, 0, 1)
  local localTeamFlags = 0
  local remoteTeamFlags = 0
  if localTeam == 1 then
    localTeamFlags = instance.teamScores.team1
    remoteTeamFlags = instance.teamScores.team2
  else
    localTeamFlags = instance.teamScores.team2
    remoteTeamFlags = instance.teamScores.team1
  end
  local stringFormat = "%02d"
  local format = string.format
  local mod = math.mod
  local sub = string.sub
  onlineInstructionSupport.resetPrompts()
  local createPrompts = true
  local resetPrompts = true
  local previousPlayerScore = 0
  local flag
  for key, package in next, packageManager.packagesBySNOID, nil do
    flag = package
    break
  end
  local yellow32 = OnlineModeSettings.yellow32
  local yellow128 = OnlineModeSettings.yellow128
  local ABasePosition = instance.challenge.spawnPositions[flag.index].baseA
  local BBasePosition = instance.challenge.spawnPositions[flag.index].baseB
  local ATeamColour32, ATeamColour128, BTeamColour32, BTeamColour128, ATeamFlagID, BTeamFlagID
  local baseMarkerACreated = false
  local baseMarkerBCreated = false
  if localTeam == 1 then
    ATeamColour32 = OnlineModeSettings.blue32
    ATeamColour128 = OnlineModeSettings.blue128
    ATeamFlagID = 118
    BTeamColour32 = OnlineModeSettings.red32
    BTeamColour128 = OnlineModeSettings.red128
    BTeamFlagID = 167
  else
    ATeamColour32 = OnlineModeSettings.red32
    ATeamColour128 = OnlineModeSettings.red128
    ATeamFlagID = 167
    BTeamColour32 = OnlineModeSettings.blue32
    BTeamColour128 = OnlineModeSettings.blue128
    BTeamFlagID = 118
  end
  local ABaseCylinder = false
  local ABaseStripe = false
  local BBaseCylinder = false
  local BBaseStripe = false
  local radiusCylinder = {
    type = "World",
    facing = false,
    gadgetID = 245,
    scale = vec.vector(25, 6, 25, 0),
    offset = vec.vector(0, 0, 0, 0),
    visible = true,
    colour = vec.vector(0, 0, 0, 255),
    position = vec.vector(0, 0, 0, 0),
    gameVehicle = nil,
    introType = "Fade",
    outroType = "Fade"
  }
  local radiusCylinderStripes = {
    type = "World",
    facing = false,
    gadgetID = 246,
    scale = vec.vector(26, 10, 26, 0),
    offset = vec.vector(0, 5, 0, 0),
    visible = true,
    colour = vec.vector(0, 0, 0, 255),
    position = vec.vector(0, 0, 0, 0),
    gameVehicle = nil,
    introType = "Fade",
    outroType = "Fade"
  }
  local ABaseMiniMapMarker = Marker:create({
    type = "Minimap",
    position = ABasePosition,
    gadgetID = 51,
    colour = ATeamColour32,
    radius = 30,
    visible = true,
    canrotate = false
  })
  local ABaseWorldMarker = Marker:create({
    type = "World",
    position = ABasePosition,
    gadgetID = 50,
    colour = ATeamColour32,
    facing = true,
    offset = vec.vector(0, 5, 0, 0)
  })
  local BBaseMiniMapMarker = Marker:create({
    type = "Minimap",
    position = BBasePosition,
    gadgetID = 51,
    colour = BTeamColour32,
    radius = 30,
    visible = true,
    canrotate = false
  })
  local BBaseWorldMarker = Marker:create({
    type = "World",
    position = BBasePosition,
    gadgetID = 50,
    colour = BTeamColour32,
    facing = true,
    offset = vec.vector(0, 5, 0, 0)
  })
  local worldFlagScale = vec.vector(2.5, 2.5, 2.5, 1)
  local worldFlagCylinderScale = vec.vector(instance.challenge.settings.flagPickupRadius * 2, 1, instance.challenge.settings.flagPickupRadius * 2, 1)
  local localVehicleFlagScale = vec.vector(1.5, 1.5, 1.5, 1)
  local remoteVehicleFlagScale = vec.vector(1.5, 1.5, 1.5, 1)
  radiusCylinder.position = ABasePosition
  radiusCylinder.colour = ATeamColour32 - vec.vector(0, 0, 0, 96)
  ABaseCylinder = Marker:create(radiusCylinder)
  radiusCylinderStripes.position = ABasePosition
  radiusCylinderStripes.colour = ATeamColour32
  ABaseStripe = Marker:create(radiusCylinderStripes)
  radiusCylinder.position = BBasePosition
  radiusCylinder.colour = BTeamColour32 - vec.vector(0, 0, 0, 96)
  BBaseCylinder = Marker:create(radiusCylinder)
  radiusCylinderStripes.position = BBasePosition
  radiusCylinderStripes.colour = BTeamColour32
  BBaseStripe = Marker:create(radiusCylinderStripes)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Impact", 1)
  OneShotSound.Play("HUD_Online_TOW_ObjectivesSpawned_OneShot")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_game_title", "ID:169282")
  onlineSideBar.toggleSmallSidebarTitle(1)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("team_1_score_divider", "/")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("team_2_score_divider", "/")
  local function removeHealthBar()
    if healthBarMarker then
      Marker:delete(healthBarMarker)
      healthBarMarker = false
      previousHealth = false
    end
  end
  local function addHealthBar(vehicle)
    removeHealthBar()
    if localPlayer.currentVehicle ~= vehicle then
      previousHealth = vehicle.gameVehicle.damage
      healthBarMarker = Marker:create({
        type = "World",
        facing = true,
        gameVehicle = vehicle.gameVehicle,
        gadgetID = 97,
        scale = vec.vector(0.1, 0.1, 0.1, 0),
        offset = vec.vector(0, vehicle.gameVehicle.height + 0.5, 0, 0),
        colour = vec.vector(255, 255, 255, 255),
        visible = true,
        uValue = previousHealth,
        vValue = -previousHealth
      })
    end
  end
  local function resetPlayerHightlight()
    if flashVehicle then
      if flashPlayerID ~= localPlayer.playerID then
        flashVehicle:removeFlashColourOverRide()
      else
        flashVehicle:overRideFlashColour(flashColour32, flashColour128)
      end
      if flashVehicle.lightTrail then
        flashVehicle:setLightTrailColour(flashColour128)
      end
    end
    if flashPlayerID ~= localPlayer.playerID then
      Menu.SetPlayerColour(flashPlayerID, flashColour128)
      if flashVehicle and flashVehicle.markers and flashVehicle.markers.Minimap0 then
        flashVehicle.markers.Minimap0.colour = flashColour32
      end
    end
  end
  local function stepFlashCarHighLight(startFlash, playerID, stop)
    if stop and carHighLightFlash then
      flashVehicle = currentFlagVehicle
      resetPlayerHightlight()
      flashStartTime = -1
      lastFlashTime = -1
      flashColour32 = false
      flashColour128 = false
      carHighLightFlash = false
      colourA = false
      flashVehicle = false
    end
    if carHighLightFlash and not startFlash and flashVehicle then
      if g_NetworkTime - flashStartTime < flashTime then
        if g_NetworkTime - lastFlashTime > flashTickTime then
          if colourA then
            flashVehicle:overRideFlashColour(OnlineModeSettings.yellow32, OnlineModeSettings.yellow128)
            if flashVehicle.lightTrail then
              flashVehicle:setLightTrailColour(OnlineModeSettings.yellow128)
            end
            if flashPlayerID ~= localPlayer.playerID then
              Menu.SetPlayerColour(flashPlayerID, OnlineModeSettings.yellow128)
              if flashVehicle.markers and flashVehicle.Minimap0 then
                flashVehicle.markers.Minimap0.colour = OnlineModeSettings.yellow32
              end
            end
            colourA = false
          else
            flashVehicle:overRideFlashColour(flashColour32, flashColour128)
            if flashVehicle.lightTrail then
              flashVehicle:setLightTrailColour(flashColour128)
            end
            if flashPlayerID ~= localPlayer.playerID then
              Menu.SetPlayerColour(flashPlayerID, flashColour128)
              if flashVehicle.markers and flashVehicle.markers.Minimap0 then
                flashVehicle.markers.Minimap0.colour = flashColour32
              end
            end
            colourA = true
          end
          lastFlashTime = g_NetworkTime
        end
      else
        resetPlayerHightlight()
        flashStartTime = -1
        lastFlashTime = -1
        flashColour32 = false
        flashColour128 = false
        carHighLightFlash = false
        colourA = false
        flashVehicle = false
      end
    end
    if startFlash then
      flashStartTime = g_NetworkTime
      lastFlashTime = g_NetworkTime
      local playerTeam = PlayerGamePlay.getPlayerTeam(playerID)
      flashColour32 = OnlineModeSettings.red32
      flashColour128 = OnlineModeSettings.red128
      flashPlayerID = playerID
      carHighLightFlash = true
      colourA = false
      flashVehicle = currentFlagVehicle
    end
  end
  local function removeFlagMarkers()
    if lastKnownFlagOwner and vehicleManager.vehiclesBySNVID[lastKnownFlagOwner.SNVID] then
      lastKnownFlagOwner:removeLightTrail()
    end
    if flagTargetMarker then
      Marker:delete(flagTargetMarker)
      flagTargetMarker = false
    end
    if flagWorldMarker then
      Marker:delete(flagWorldMarker)
      flagWorldMarker = false
    end
    if flagWorldCylinder then
      Marker:delete(flagWorldCylinder)
      flagWorldCylinder = false
    end
    if flagMinimapMarker then
      Marker:delete(flagMinimapMarker)
      flagMinimapMarker = false
    end
    if flagVehicleMinimapMarker then
      Marker:delete(flagVehicleMinimapMarker)
      flagVehicleMinimapMarker = false
    end
    if flagVehicleMinimapArrow then
      Marker:delete(flagVehicleMinimapArrow)
      flagVehicleMinimapArrow = false
    end
    for i = 0, 7 do
      gamerTag.setPlayerMarkerModel(i, 5)
      gamerTag.setPlayerObjectiveMarker(i, false)
    end
  end
  local function setNewFlagCarrierMarkers(vehicle, carrierID, colour32, colour128, flagGadgetID, basePosition)
    if localPlayer.currentVehicle ~= vehicle then
      flagVehicleMinimapArrow = Marker:create({
        type = "Minimap",
        gameVehicle = currentFlagVehicle.gameVehicle,
        gadgetID = 257,
        colour = colour32,
        radius = 40,
        visible = true,
        canrotate = true
      })
      flagVehicleMinimapMarker = Marker:create({
        type = "Minimap",
        gameVehicle = currentFlagVehicle.gameVehicle,
        gadgetID = 252,
        colour = colour32,
        radius = 40,
        visible = true,
        canrotate = false
      })
    end
    vehicle:addLightTrail(32, colour128)
    gamerTag.setPlayerMarkerModel(carrierID, 181)
    gamerTag.setPlayerObjectiveMarker(carrierID, true)
  end
  local function addFlagInWorldMarkers(flagPosition)
    flagTargetMarker = Marker:create({
      type = "Target",
      position = flagPosition + OnlineModeSettings.targetOffset,
      gadgetID = 181,
      colour = yellow32 + OnlineModeSettings.targetAlphaMask32,
      radius = 60,
      visible = true,
      showDistance = true,
      targetType = "Destination"
    })
    flagWorldMarker = Marker:create({
      type = "World",
      position = flagPosition,
      gadgetID = 168,
      facing = true,
      visible = true,
      offset = vec.vector(0, 2, 0, 0),
      scale = worldFlagScale,
      colour = OnlineModeSettings.flagAlphaMask
    })
    flagWorldCylinder = Marker:create({
      type = "World",
      position = flagPosition,
      gadgetID = 264,
      colour = yellow32,
      visible = true,
      scale = worldFlagCylinderScale,
      sortBias = 1
    })
    flagMinimapMarker = Marker:create({
      type = "Minimap",
      position = flagPosition,
      gadgetID = 181,
      colour = yellow32,
      radius = 40,
      visible = true,
      canrotate = false
    })
  end
  addFlagInWorldMarkers(flag.position)
  local function clearZapBaseMarkers()
    if targetBaseTargetMarker then
      Marker:delete(targetBaseTargetMarker)
      targetBaseTargetMarker = false
    end
    if BBaseTargetMarker then
      Marker:delete(BBaseTargetMarker)
      BBaseTargetMarker = false
    end
    if ABaseTargetMarker then
      Marker:delete(ABaseTargetMarker)
      ABaseTargetMarker = false
    end
  end
  local function stepZapBaseMarkers()
    if localPlayer.inZap then
      if targetBaseTargetMarker then
        Marker:delete(targetBaseTargetMarker)
        targetBaseTargetMarker = false
      end
      if not BBaseTargetMarker then
        BBaseTargetMarker = Marker:create({
          type = "Target",
          position = BBasePosition + OnlineModeSettings.basetargetOffset,
          gadgetID = 51,
          colour = BTeamColour32 + OnlineModeSettings.targetAlphaMask32,
          radius = 50,
          visible = true,
          showDistance = true,
          longDistanceTarget = true,
          targetType = "Destination"
        })
        ABaseTargetMarker = Marker:create({
          type = "Target",
          position = ABasePosition + OnlineModeSettings.basetargetOffset,
          gadgetID = 51,
          colour = ATeamColour32 + OnlineModeSettings.targetAlphaMask32,
          radius = 50,
          visible = true,
          showDistance = true,
          longDistanceTarget = true,
          targetType = "Destination"
        })
      end
    else
      if BBaseTargetMarker then
        Marker:delete(BBaseTargetMarker)
        BBaseTargetMarker = false
      end
      if ABaseTargetMarker then
        Marker:delete(ABaseTargetMarker)
        ABaseTargetMarker = false
      end
      if not targetBaseTargetMarker and currentFlagTeam and currentFlagTeam then
        local colour = false
        local basePosition = false
        if currentFlagTeam == 1 then
          colour = ATeamColour32
          basePosition = ABasePosition
        else
          colour = BTeamColour32
          basePosition = BBasePosition
        end
        targetBaseTargetMarker = Marker:create({
          type = "Target",
          position = basePosition + OnlineModeSettings.basetargetOffset,
          gadgetID = 51,
          colour = colour + OnlineModeSettings.targetAlphaMask32,
          radius = 50,
          visible = true,
          showDistance = true,
          longDistanceTarget = true,
          targetType = "Destination"
        })
      end
    end
  end
  local function pickUpFlagEvent()
    removeFlagMarkers()
    clearZapBaseMarkers()
    stepZapBaseMarkers()
    if localTeam == currentFlagTeam then
      OneShotSound.Play("MP_Player_Positive")
    else
      OneShotSound.Play("MP_Player_Negative")
    end
    stepFlashCarHighLight(true, currentFlagPlayerID)
    if currentFlagPlayerID ~= localPlayer.playerID then
      feedbackSystem.eventMessages.addMessage(1, playerManager.players[currentFlagPlayerID].name, "ID:169285", "", currentFlagPlayerID, false, false, false, currentFlagTeam ~= localTeam)
    else
      feedbackSystem.eventMessages.addMessage(1, playerManager.players[currentFlagPlayerID].name, "ID:169285", "", currentFlagPlayerID)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 1)
      currentFlagVehicle:overRideFlashColour(OnlineModeSettings.blue32, OnlineModeSettings.blue128)
    end
    if currentFlagTeam == 1 then
      setNewFlagCarrierMarkers(currentFlagVehicle, currentFlagPlayerID, ATeamColour32, ATeamColour128, ATeamFlagID, ABasePosition)
    else
      setNewFlagCarrierMarkers(currentFlagVehicle, currentFlagPlayerID, BTeamColour32, BTeamColour128, BTeamFlagID, BBasePosition)
    end
    addHealthBar(currentFlagVehicle)
    resetPrompts = true
    lastKnownFlagOwner = currentFlagVehicle
    lastKnownFlagPlayerID = currentFlagPlayerID
    lastKnowFlagCarrierCaps = task.instance.playerScores[currentFlagPlayerID + 1]
  end
  local function dropFlagEvent()
    removeFlagMarkers()
    clearZapBaseMarkers()
    stepZapBaseMarkers()
    stepFlashCarHighLight(nil, nil, true)
    addFlagInWorldMarkers(flag.position)
    removeHealthBar(lastKnownFlagOwner)
    if playerManager.players[lastKnownFlagPlayerID] then
      local lastOwnersTeam = PlayerGamePlay.getPlayerTeam(lastKnownFlagPlayerID)
      if localTeam == lastOwnersTeam then
        OneShotSound.Play("MP_Player_Positive")
      else
        OneShotSound.Play("MP_Player_Negative")
      end
      if lastKnownFlagPlayerID ~= localPlayer.playerID then
        feedbackSystem.eventMessages.addMessage(1, playerManager.players[lastKnownFlagPlayerID].name, "ID:169286", "", lastKnownFlagPlayerID, false, false, false, lastOwnersTeam ~= localTeam)
      else
        feedbackSystem.eventMessages.addMessage(1, playerManager.players[lastKnownFlagPlayerID].name, "ID:169286", "", lastKnownFlagPlayerID)
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 0)
        if localPlayer.currentVehicle and localPlayer.currentVehicle:vehicleFlashOverridden() then
          localPlayer.currentVehicle:removeFlashColourOverRide()
        end
      end
    end
    for i = 0, 7 do
      gamerTag.setPlayerMarkerModel(i, 5)
      gamerTag.setPlayerObjectiveMarker(i, false)
    end
    resetPrompts = true
    lastKnownFlagOwner = false
    lastKnownFlagPlayerID = false
  end
  local function stepFlagOwnershipChanges()
    if currentFlagVehicle then
      if currentFlagPlayerID and playerManager.players[currentFlagPlayerID] then
        if not lastKnownFlagPlayerID then
          pickUpFlagEvent()
        elseif lastKnownFlagPlayerID ~= currentFlagPlayerID then
          dropFlagEvent()
          pickUpFlagEvent()
        end
      end
    elseif lastKnownFlagOwner then
      dropFlagEvent()
    end
  end
  local function stepModeTimer()
    timeRemaining = maxTime - instance:getTime()
    if not timerOn and timeRemaining <= 60 then
      onlineSideBar.toggleTimerSidebarTitle(1)
      feedbackSystem.menusMaster.primaryTextPrompt("ID:231383", false, false, false, false, false, false, false, false, true)
      timerOn = true
      phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeOneMinRemain)
    end
    if timerOn then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_minutes", format(stringFormat, timeRemaining / 60))
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_seconds", "." .. format(stringFormat, mod(timeRemaining, 60)))
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_milliseconds", "." .. sub(mod(timeRemaining, 1), 3, 4))
      if timeRemaining / 60 < 1 then
        local ceilCurrSeconds = math.ceil(mod(timeRemaining, 60))
        if prevSeconds ~= ceilCurrSeconds then
          if ceilCurrSeconds == 15 then
            OneShotSound.Play("HUD_Online_Timer_10Seconds", false)
          elseif ceilCurrSeconds < 15 and ceilCurrSeconds > 5 then
            OneShotSound.Play("HUD_Gen_Timer_02_OneShot", false)
          elseif ceilCurrSeconds <= 5 and ceilCurrSeconds > 0 then
            OneShotSound.Play("HUD_Gen_Timer_03_OneShot", false)
          elseif ceilCurrSeconds == 0 then
            OneShotSound.Play("HUD_Online_Timer_0Seconds")
          end
          prevSeconds = ceilCurrSeconds
        end
      end
      if timeRemaining > 15 and not lowTimeFlash then
        onlineSideBar.toggleSidebarTimerFlash(0)
        lowTimeFlash = true
      end
      if timeRemaining > 17 and not lowTimeMessage then
        lowTimeMessage = true
      end
      if timeRemaining < 15 and lowTimeFlash then
        lowTimeFlash = false
        onlineSideBar.toggleSidebarTimerFlash(1)
      end
      if timeRemaining < 17 and lowTimeMessage then
        lowTimeMessage = false
        feedbackSystem.menusMaster.primaryTextPrompt("ID:169362", false, false, false, false, false, false, false, false, true)
      end
    end
  end
  local function stepScores()
    if localTeam == 1 then
      if localTeamFlags ~= flagTaskObject.namedTasks.score.networkVars.blueTeam then
        localTeamFlags = flagTaskObject.namedTasks.score.networkVars.blueTeam + instance.teamScores.team1
      end
      if remoteTeamFlags ~= flagTaskObject.namedTasks.score.networkVars.redTeam then
        remoteTeamFlags = flagTaskObject.namedTasks.score.networkVars.redTeam + instance.teamScores.team2
      end
    elseif localTeam == 2 then
      if localTeamFlags ~= flagTaskObject.namedTasks.score.networkVars.redTeam then
        localTeamFlags = flagTaskObject.namedTasks.score.networkVars.redTeam + instance.teamScores.team2
      end
      if remoteTeamFlags ~= flagTaskObject.namedTasks.score.networkVars.blueTeam then
        remoteTeamFlags = flagTaskObject.namedTasks.score.networkVars.blueTeam + instance.teamScores.team1
      end
    end
  end
  local function stepFlagMarkerIfReset()
    if not currentFlagVehicle then
      if lastKnownPosition and lastKnownPosition.x ~= flag.position.x and lastKnownPosition.y ~= flag.position.y then
        OneShotSound.Play("HUD_Online_TOW_ObjectivesSpawned_OneShot")
        feedbackSystem.menusMaster.primaryTextPrompt("ID:169287")
        removeFlagMarkers()
        clearZapBaseMarkers()
        stepZapBaseMarkers()
        addFlagInWorldMarkers(flag.position)
        lastKnownPosition = nil
      elseif not lastKnownPosition then
        lastKnownPosition = flag.position
      end
    else
      lastKnownPosition = nil
    end
  end
  local function stepInstructionPrompts()
    if flag and currentFlagPlayerID and currentFlagPlayerID > -1 then
      hasFlag = currentFlagPlayerID == localPlayer.playerID
      teamHasFlag = PlayerGamePlay.getPlayerTeam(currentFlagPlayerID) == localTeam
      nobodyHasFlag = false
    else
      hasFlag = false
      teamHasFlag = false
      nobodyHasFlag = true
    end
    if createPrompts then
      onlineInstructionSupport.addPrompt("deliverFlag", {
        enabled = false,
        shown = false,
        resetOnScore = true,
        startTime = 3,
        resetTime = 45,
        displayFunction = function(self, objectivePos, opponents)
          onlineInstructionSupport.displayPrompt("ID:234350", iconsTable.multiFlagBlue)
          return true
        end
      })
      onlineInstructionSupport.addPrompt("escortFlag", {
        enabled = false,
        shown = false,
        resetOnScore = true,
        startTime = 5,
        resetTime = 45,
        displayFunction = function(self, objectivePos, opponents)
          onlineInstructionSupport.displayPrompt("ID:234352", iconsTable.multiFlagBlue)
          return true
        end
      })
      onlineInstructionSupport.addPrompt("retrieveFlagGround", {
        enabled = false,
        shown = false,
        resetOnScore = true,
        startTime = 10,
        resetTime = 20,
        displayFunction = function(self, objectivePos, opponents)
          onlineInstructionSupport.displayPrompt("ID:234354", iconsTable.multiFlagYellow)
          return true
        end
      })
      onlineInstructionSupport.addPrompt("retrieveFlagEnemy", {
        enabled = false,
        shown = false,
        resetOnScore = true,
        startTime = 10,
        resetTime = 45,
        displayFunction = function(self, objectivePos, opponents)
          onlineInstructionSupport.displayPrompt("ID:234354", iconsTable.multiFlagRed)
          return true
        end
      })
      createPrompts = false
    end
    if resetPrompts then
      if resetFlag then
        onlineInstructionSupport.setPrompts()
      else
        onlineInstructionSupport.setPrompts(true, true, hasFlag or not teamHasFlag, not teamHasFlag, not teamHasFlag, not hasFlag, true, true, not hasFlag, true, false, true, not teamHasFlag, not teamHasFlag)
      end
      onlineInstructionSupport.setPrompt("deliverFlag", hasFlag)
      onlineInstructionSupport.setPrompt("escortFlag", not hasFlag and teamHasFlag)
      onlineInstructionSupport.setPrompt("retrieveFlagGround", nobodyHasFlag and not resetFlag)
      onlineInstructionSupport.setPrompt("retrieveFlagEnemy", not nobodyHasFlag and not teamHasFlag)
      if hasFlag then
        onlineInstructionSupport.modifyPrompt("boost", "message", "ID:234274")
      else
        onlineInstructionSupport.modifyPrompt("boost", "message", "ID:234275")
      end
      resetPrompts = false
    end
    opponents = {}
    for playerID, player in next, playerManager.players, nil do
      if playerID ~= localPlayer.playerID and PlayerGamePlay.getPlayerTeam(playerID) ~= localTeam then
        table.insert(opponents, {
          vehicle = player.currentVehicle,
          position = player.position
        })
      end
    end
    scored = false
    if localTeam == 1 then
      if flagTaskObject.namedTasks.score.networkVars.blueTeam ~= previousPlayerScore then
        scored = true
        previousPlayerScore = flagTaskObject.namedTasks.score.networkVars.blueTeam
      end
    elseif flagTaskObject.namedTasks.score.networkVars.redTeam ~= previousPlayerScore then
      scored = true
      previousPlayerScore = flagTaskObject.namedTasks.score.networkVars.redTeam
    end
    onlineInstructionSupport.step(flag.position, opponents, scored)
  end
  local function stepHealthBar()
    if currentFlagVehicle and healthBarMarker and previousHealth ~= currentFlagVehicle.gameVehicle.damage then
      previousHealth = currentFlagVehicle.gameVehicle.damage
      healthBarMarker.uValue = previousHealth
      healthBarMarker.vValue = -previousHealth
    end
  end
  local function update()
    if not flagTaskObject then
      flagTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    elseif flagTaskObject.namedTasks and flagTaskObject.namedTasks.score then
      if flag.owner then
        currentFlagVehicle = flag.owner
      else
        currentFlagVehicle = false
      end
      if flag.playerID and playerManager.players[flag.playerID] then
        currentFlagPlayerID = flag.playerID
        currentFlagTeam = PlayerGamePlay.getPlayerTeam(currentFlagPlayerID)
      else
        currentFlagPlayerID = false
        currentFlagTeam = false
      end
      stepInstructionPrompts()
      stepScores()
      stepFlagMarkerIfReset()
      stepZapBaseMarkers()
      stepHealthBar()
      stepFlagOwnershipChanges()
      stepFlashCarHighLight()
      if not baseMarkerACreated and spoolsystem.IsLocationResident(ABasePosition) then
        TerrainMarker.Update(0, ABasePosition, ATeamColour128, 25)
        baseMarkerACreated = true
      end
      if not baseMarkerBCreated and spoolsystem.IsLocationResident(BBasePosition) then
        TerrainMarker.Update(1, BBasePosition, BTeamColour128, 25)
        baseMarkerBCreated = true
      end
    end
    stepModeTimer()
  end
  local function cleanup(taskObject)
    local fromPurge = taskObject.coreData.instance.deleteFromPurge
    if lastKnownFlagPlayerID and lastKnowFlagCarrierCaps ~= task.instance.playerScores[lastKnownFlagPlayerID + 1] and playerManager.players[lastKnownFlagPlayerID] then
      feedbackSystem.eventMessages.addMessage(1, playerManager.players[lastKnownFlagPlayerID].name, "ID:186780", "", lastKnownFlagPlayerID, false, false, false, PlayerGamePlay.getPlayerTeam(lastKnownFlagPlayerID) ~= localTeam)
      if lastKnownFlagPlayerID == localPlayer.playerID and gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
        local value = ProfileSettings.GetNumTugOfWarCaptures() + 1
        OnlineAchievements.onValueChange("MP tug of war", value)
        ProfileSettings.SetNumTugOfWarCaptures(value)
      end
    end
    if localPlayer.currentVehicle and localPlayer.currentVehicle:vehicleFlashOverridden() then
      localPlayer.currentVehicle:removeFlashColourOverRide()
    end
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Impact", 0)
    for i = 0, 7 do
      gamerTag.setPlayerMarkerModel(i, 5)
      gamerTag.setPlayerObjectiveMarker(i, false)
    end
    if fromPurge then
      if baseMarkerACreated then
        TerrainMarker.Delete(0)
        baseMarkerACreated = false
      end
      if baseMarkerBCreated then
        TerrainMarker.Delete(1)
        baseMarkerBCreated = false
      end
      if ABaseWorldMarker then
        Marker:delete(ABaseWorldMarker)
      end
      if BBaseWorldMarker then
        Marker:delete(BBaseWorldMarker)
      end
      if ABaseCylinder then
        Marker:delete(ABaseCylinder)
      end
      if ABaseStripe then
        Marker:delete(ABaseStripe)
      end
      if BBaseCylinder then
        Marker:delete(BBaseCylinder)
      end
      if BBaseStripe then
        Marker:delete(BBaseStripe)
      end
      if flagMinimapMarker then
        Marker:delete(flagMinimapMarker)
      end
    else
      for playerID, player in next, playerManager.players, nil do
        if PlayerGamePlay.getPlayerTeam(playerID) == localTeam then
          if playerID ~= localPlayer.playerID then
            feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.blue32, OnlineModeSettings.blue128)
          end
        else
          feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.red32, OnlineModeSettings.red128)
        end
      end
      if baseMarkerACreated then
        feedbackSystem.multiplayerSupport.addWorldMarker("terrain", 0)
      end
      if baseMarkerBCreated then
        feedbackSystem.multiplayerSupport.addWorldMarker("terrain", 1)
      end
      if BBaseWorldMarker then
        feedbackSystem.multiplayerSupport.addWorldMarker("world", BBaseWorldMarker)
      end
      if ABaseWorldMarker then
        feedbackSystem.multiplayerSupport.addWorldMarker("world", ABaseWorldMarker)
      end
      if ABaseCylinder then
        feedbackSystem.multiplayerSupport.addWorldMarker("world", ABaseCylinder)
      end
      if ABaseStripe then
        feedbackSystem.multiplayerSupport.addWorldMarker("world", ABaseStripe)
      end
      if BBaseCylinder then
        feedbackSystem.multiplayerSupport.addWorldMarker("world", BBaseCylinder)
      end
      if BBaseStripe then
        feedbackSystem.multiplayerSupport.addWorldMarker("world", BBaseStripe)
      end
    end
    if flagVehicleMinimapMarker then
      Marker:delete(flagVehicleMinimapMarker)
    end
    if flagVehicleMinimapArrow then
      Marker:delete(flagVehicleMinimapArrow)
    end
    if BBaseMiniMapMarker then
      Marker:delete(BBaseMiniMapMarker)
    end
    if ABaseMiniMapMarker then
      Marker:delete(ABaseMiniMapMarker)
    end
    if flagWorldMarker then
      Marker:delete(flagWorldMarker)
    end
    if flagWorldCylinder then
      Marker:delete(flagWorldCylinder)
    end
    if flagTargetMarker then
      Marker:delete(flagTargetMarker)
    end
    if targetBaseTargetMarker then
      Marker:delete(targetBaseTargetMarker)
    end
    if BBaseTargetMarker then
      Marker:delete(BBaseTargetMarker)
    end
    if ABaseTargetMarker then
      Marker:delete(ABaseTargetMarker)
    end
    if healthBarMarker then
      Marker:delete(healthBarMarker)
    end
    if flagMinimapMarker then
      Marker:delete(flagMinimapMarker)
    end
    if lastKnownFlagOwner and vehicleManager.vehiclesBySNVID[lastKnownFlagOwner.SNVID] then
      lastKnownFlagOwner:removeLightTrail()
    end
  end
  return update, nil, nil, cleanup
end)
