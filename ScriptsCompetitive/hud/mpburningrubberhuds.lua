onlineSideBar.registerSideBar("MP burning rubber", function(instance)
  local maxScore = instance.challenge.settings.targetScore
  local playerScore = 0
  local isTarget = false
  local totalCheckpoints = false
  local torchTOOne = false
  local torchTOTwo = false
  local localTeam = false
  local onlocalTeam = false
  local timeToScoreSet = false
  local numLaps = 0
  local function initiate()
    totalCheckpoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
    localTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
    numLaps = instance.challenge.settings.totalLaps + 1
    onlineSideBar.toggleSmallSidebarTitle(1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_game_title", "ID:247253")
    onlineSideBar.toggleProgressSidebarTitle(1, 0)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_progress", "ID:236553")
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Bar_Progress", 0)
  end
  local function getData(taskObject)
    if not torchTOOne then
      torchTOOne = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    end
    if not torchTOTwo then
      torchTOTwo = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
    end
    if taskObject.initiated and torchTOOne and torchTOOne.coreData and torchTOTwo and torchTOTwo.coreData then
      playerScore = taskObject.namedTasks.score and taskObject and 0
      onlocalTeam = false
      if localTeam == PlayerGamePlay.getPlayerTeam(taskObject.coreData.agent.playerID) then
        onlocalTeam = true
      end
      if localTeam == 1 then
        if onlocalTeam then
          isTarget = torchTOOne.coreData.agent == taskObject.coreData.agent.currentVehicle
        else
          isTarget = torchTOTwo.coreData.agent == taskObject.coreData.agent.currentVehicle
        end
      elseif localTeam == 2 then
        if onlocalTeam then
          isTarget = torchTOTwo.coreData.agent == taskObject.coreData.agent.currentVehicle
        else
          isTarget = torchTOOne.coreData.agent == taskObject.coreData.agent.currentVehicle
        end
      end
      if isTarget then
        return taskObject.coreData.agent.name, playerScore / (totalCheckpoints * numLaps) * 100, playerScore, taskObject.coreData.agent.isLocal, 2, taskObject.coreData.agent.playerID
      else
        return taskObject.coreData.agent.name, playerScore / (totalCheckpoints * numLaps) * 100, playerScore, taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID
      end
    else
      return taskObject.coreData.agent.name, 0, 0, taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID
    end
  end
  local teamScore1, teamScore2, team1Prog, team2Prog
  local function teamData()
    if torchTOOne and torchTOOne.namedTasks and torchTOOne.namedTasks.checkpoints and torchTOTwo and torchTOTwo.namedTasks and torchTOTwo.namedTasks.checkpoints then
      teamScore1 = torchTOOne.namedTasks.checkpoints.networkVars.checkpoints - 1 + torchTOOne.namedTasks.checkpoints.networkVars.laps * totalCheckpoints
      teamScore2 = torchTOTwo.namedTasks.checkpoints.networkVars.checkpoints - 1 + torchTOTwo.namedTasks.checkpoints.networkVars.laps * totalCheckpoints
      team1Prog = teamScore1 / (totalCheckpoints * numLaps) * 100
      team2Prog = teamScore2 / (totalCheckpoints * numLaps) * 100
      if not timeToScoreSet and (team1Prog / 100 > phaseManager.timeToJoinExceptionValues.burningRubber or team2Prog / 100 > phaseManager.timeToJoinExceptionValues.burningRubber) then
        phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeException)
        timeToScoreSet = true
      end
      if team1Prog >= team2Prog then
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Bar_Progress", team1Prog)
      else
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Bar_Progress", team2Prog)
      end
      if localTeam == 1 then
        return teamScore1, totalCheckpoints * numLaps, team1Prog, teamScore2, totalCheckpoints * numLaps, team2Prog
      elseif localTeam == 2 then
        return teamScore2, totalCheckpoints * numLaps, team2Prog, teamScore1, totalCheckpoints * numLaps, team1Prog
      end
    else
      return 0, totalCheckpoints * numLaps, 0, 0, totalCheckpoints * numLaps, 0
    end
  end
  local function cleanup()
    torchTOOne = false
    torchTOTwo = false
    onlineSideBar.toggleSidebarTimerFlash(0)
    onlineSideBar.toggleTimerSidebarTitle(0)
    onlineSideBar.toggleSmallSidebarTitle(0)
    onlineSideBar.toggleProgressSidebarTitle(0)
  end
  return initiate, getData, cleanup, onlineSideBar.standardSortFuncs.playerScoreSort, true, false, true, teamData
end)
feedbackSystem.registerHUD("MP Burning Rubber Start HUD", function(task, settings)
end, function(task)
  local instance = localPlayer.getTaskObject().coreData.instance
  local localTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  local blueTeamTorchTaskObject, redTeamTorchTaskObject
  if localTeam == 1 then
    blueTeamTorchTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    redTeamTorchTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  else
    blueTeamTorchTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
    redTeamTorchTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  end
  local flagOnFloorMarkerSettings = {
    world = {
      type = "World",
      facing = true,
      visible = true,
      offset = vec.vector(0, 2, 0, 0),
      scale = vec.vector(2.5, 2.5, 2.5, 1),
      colour = OnlineModeSettings.flagAlphaMask
    },
    target = {
      type = "Target",
      targetType = "Destination",
      colour = vec.vector(255, 255, 255, 255),
      radius = 60,
      visible = true,
      showDistance = true,
      gadgetID = 179
    },
    Minimap = {
      type = "Minimap",
      radius = 40,
      visible = true,
      canrotate = false,
      gadgetID = 179,
      nofade = true
    },
    cylinder = {
      type = "World",
      visible = true,
      colour = OnlineModeSettings.yellow32,
      gadgetID = 264,
      scale = vec.vector(instance.challenge.settings.torchPickupRadius * 2, 1, instance.challenge.settings.torchPickupRadius * 2, 1),
      sortBias = 1
    }
  }
  local flagOnePosition, flagTwoPosition
  if blueTeamTorchTaskObject and blueTeamTorchTaskObject.coreData and blueTeamTorchTaskObject.coreData.agent and redTeamTorchTaskObject and redTeamTorchTaskObject.coreData and redTeamTorchTaskObject.coreData.agent then
    flagOnePosition = blueTeamTorchTaskObject.coreData.agent.position
    flagTwoPosition = redTeamTorchTaskObject.coreData.agent.position
  end
  local blueTeamFlagOnFloorWorldMarker, blueTeamFlagOnFloorCylinderMarker, blueTeamFlagOnFloorMinimapMarker, redTeamFlagOnFloorWorldMarker, redTeamFlagOnFloorMinimapMarker
  if flagOnePosition and flagTwoPosition then
    if not blueTeamTorchTaskObject.coreData.agent.owner then
      flagOnFloorMarkerSettings.world.gadgetID = 263
      flagOnFloorMarkerSettings.world.position = flagOnePosition
      flagOnFloorMarkerSettings.cylinder.position = flagOnePosition
      blueTeamFlagOnFloorWorldMarker = Marker:create(flagOnFloorMarkerSettings.world)
      blueTeamFlagOnFloorCylinderMarker = Marker:create(flagOnFloorMarkerSettings.cylinder)
      flagOnFloorMarkerSettings.Minimap.colour = OnlineModeSettings.yellow32
      flagOnFloorMarkerSettings.Minimap.position = flagOnePosition
      blueTeamFlagOnFloorMinimapMarker = Marker:create(flagOnFloorMarkerSettings.Minimap)
    end
    if not redTeamTorchTaskObject.coreData.agent.owner then
      flagOnFloorMarkerSettings.world.gadgetID = 172
      flagOnFloorMarkerSettings.world.position = flagTwoPosition
      redTeamFlagOnFloorWorldMarker = Marker:create(flagOnFloorMarkerSettings.world)
      flagOnFloorMarkerSettings.Minimap.colour = OnlineModeSettings.red32
      flagOnFloorMarkerSettings.Minimap.position = flagTwoPosition
      redTeamFlagOnFloorMinimapMarker = Marker:create(flagOnFloorMarkerSettings.Minimap)
    end
  end
  local function update()
    if blueTeamTorchTaskObject and blueTeamTorchTaskObject.coreData and blueTeamTorchTaskObject.coreData.agent and redTeamTorchTaskObject and redTeamTorchTaskObject.coreData and redTeamTorchTaskObject.coreData.agent then
      flagOnePosition = blueTeamTorchTaskObject.coreData.agent.position
      flagTwoPosition = redTeamTorchTaskObject.coreData.agent.position
    end
    if not blueTeamFlagOnFloorWorldMarker and not blueTeamTorchTaskObject.coreData.agent.owner then
      flagOnFloorMarkerSettings.world.gadgetID = 263
      flagOnFloorMarkerSettings.world.position = flagOnePosition
      flagOnFloorMarkerSettings.cylinder.position = flagOnePosition
      blueTeamFlagOnFloorWorldMarker = Marker:create(flagOnFloorMarkerSettings.world)
      blueTeamFlagOnFloorCylinderMarker = Marker:create(flagOnFloorMarkerSettings.cylinder)
      flagOnFloorMarkerSettings.Minimap.colour = OnlineModeSettings.yellow32
      flagOnFloorMarkerSettings.Minimap.position = flagOnePosition
      blueTeamFlagOnFloorMinimapMarker = Marker:create(flagOnFloorMarkerSettings.Minimap)
    elseif blueTeamFlagOnFloorWorldMarker and blueTeamTorchTaskObject.coreData.agent.owner then
      Marker:delete(blueTeamFlagOnFloorWorldMarker)
      Marker:delete(blueTeamFlagOnFloorMinimapMarker)
      Marker:delete(blueTeamFlagOnFloorCylinderMarker)
      blueTeamFlagOnFloorWorldMarker = false
      blueTeamFlagOnFloorMinimapMarker = false
      blueTeamFlagOnFloorCylinderMarker = false
    end
    if not redTeamFlagOnFloorWorldMarker and not redTeamTorchTaskObject.coreData.agent.owner then
      flagOnFloorMarkerSettings.world.gadgetID = 172
      flagOnFloorMarkerSettings.world.position = flagTwoPosition
      redTeamFlagOnFloorWorldMarker = Marker:create(flagOnFloorMarkerSettings.world)
      flagOnFloorMarkerSettings.Minimap.colour = OnlineModeSettings.red32
      flagOnFloorMarkerSettings.Minimap.position = flagTwoPosition
      redTeamFlagOnFloorMinimapMarker = Marker:create(flagOnFloorMarkerSettings.Minimap)
    elseif redTeamFlagOnFloorWorldMarker and redTeamTorchTaskObject.coreData.agent.owner then
      Marker:delete(redTeamFlagOnFloorWorldMarker)
      Marker:delete(redTeamFlagOnFloorMinimapMarker)
      redTeamFlagOnFloorWorldMarker = false
      redTeamFlagOnFloorMinimapMarker = false
    end
  end
  local function cleanupCallback()
    if redTeamFlagOnFloorWorldMarker then
      Marker:delete(redTeamFlagOnFloorWorldMarker)
      Marker:delete(redTeamFlagOnFloorMinimapMarker)
    end
    if blueTeamFlagOnFloorWorldMarker then
      Marker:delete(blueTeamFlagOnFloorWorldMarker)
      Marker:delete(blueTeamFlagOnFloorMinimapMarker)
      Marker:delete(blueTeamFlagOnFloorCylinderMarker)
    end
  end
  phaseManager.startHUDCleanupFunction = cleanupCallback
  return update, nil, nil, nil
end)
feedbackSystem.registerHUD("MP Burning Rubber HUD", function(task, settings)
end, function(task)
  if phaseManager.startHUDCleanupFunction then
    phaseManager.startHUDCleanupFunction()
    phaseManager.startHUDCleanupFunction = false
  end
  local instance = task.instance
  local playerTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  local playerTaskObject = taskSystem.taskObjects[task.taskObjectID]
  local redTeamPackageTO, blueTeamPackageTO
  local totalCheckpoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
  local powerLossTime = instance.challenge.settings.powerLossTime
  local timeToLive = 0
  local prevTimeToLive = 0
  local torchDisplayState = 3
  local localTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  local redTeam = 1
  if localTeam == 1 then
    redTeam = 2
  end
  local maxTime = task.instance.challenge.settings.modeTimeLimit
  local stringFormat = "%02d"
  local format = string.format
  local mod = math.mod
  local sub = string.sub
  onlineInstructionSupport.resetPrompts()
  local resetPrompts = true
  local localPlayerTaskObject = localPlayer.getTaskObject()
  local previousPlayerScore = 0
  local flashTime = instance.challenge.settings.invunTime
  local flashStartTime = -1
  local carHighLightFlash = false
  local lastFlashTime = -1
  local flashTickTime = 0.1
  local tagOwnerID = -1
  local colourA = false
  local flashVehicle = false
  local torchOwner = false
  local achievementIncFlag = true
  local currentBlueTeamTorchCarrier = false
  local currentBlueTeamTorchVehicle = false
  local previousBlueTeamTorchCarrier = false
  local previousBlueTeamTorchVehicle = false
  local currentRedTeamTorchCarrier = false
  local currentRedTeamTorchVehicle = false
  local previousRedTeamTorchCarrier = false
  local previousRedTeamTorchVehicle = false
  local markerSettings = {
    MinimapArrow = {
      type = "Minimap",
      radius = 40,
      visible = true,
      canrotate = true,
      gadgetID = 257,
      nofade = true
    },
    Minimap = {
      type = "Minimap",
      radius = 40,
      visible = true,
      canrotate = false,
      gadgetID = 254,
      nofade = true
    }
  }
  local blueTeamFlagOnFloorWorldMarker, blueTeamFlagOnFloorMinimapMarker, blueTeamFlagOnFloorTargetMarker, blueTeamFlagOnFloorCylinderMarker, redTeamFlagOnFloorWorldMarker, redTeamFlagOnFloorMinimapMarker, redTeamFlagOnFloorTargetMarker
  local flagOnFloorMarkerSettings = {
    world = {
      type = "World",
      facing = true,
      visible = true,
      offset = vec.vector(0, 2, 0, 0),
      scale = vec.vector(2.5, 2.5, 2.5, 1),
      colour = OnlineModeSettings.flagAlphaMask
    },
    target = {
      type = "Target",
      targetType = "Destination",
      colour = vec.vector(255, 255, 255, 255),
      radius = 60,
      visible = true,
      showDistance = true,
      gadgetID = 179
    },
    Minimap = {
      type = "Minimap",
      radius = 40,
      visible = true,
      canrotate = false,
      gadgetID = 179,
      nofade = true
    },
    cylinder = {
      type = "World",
      visible = true,
      colour = OnlineModeSettings.yellow32,
      gadgetID = 264,
      scale = vec.vector(instance.challenge.settings.torchPickupRadius * 2, 1, instance.challenge.settings.torchPickupRadius * 2, 1),
      sortBias = 1
    }
  }
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_torch_fuel", "ID:234268")
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Bar", 100)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Impact", 1)
  local clearVehicleMarkers = function(vehicle)
    if vehicle.markers then
      for k, v in next, vehicle.markers, nil do
        Marker:delete(v)
        vehicle.markers[k] = nil
      end
    end
    if vehicleManager.vehiclesBySNVID[vehicle.SNVID] then
      vehicle:removeLightTrail()
    end
  end
  local clearGamerTagMarkers = function(playerID, gadgetID)
    gamerTag.setPlayerMarkerModel(playerID, gadgetID)
    gamerTag.setPlayerObjectiveMarker(playerID, false)
  end
  local setGamerTagMarkers = function(playerID, gadgetID)
    gamerTag.setPlayerMarkerModel(playerID, gadgetID)
    gamerTag.setPlayerObjectiveMarker(playerID, true)
  end
  local function setVehicleMarkers(vehicle, gadgetID, colour)
    if not vehicle.markers then
      vehicle.markers = {}
    end
    for k, v in next, markerSettings, nil do
      v.colour = colour
      v.gameVehicle = vehicle.gameVehicle
      vehicle.markers[k] = Marker:create(v)
    end
  end
  local function resetPlayerHightlight()
    if tagOwnerID ~= localPlayer.playerID then
      flashVehicle:removeFlashColourOverRide()
    else
      flashVehicle:overRideFlashColour(OnlineModeSettings.blue32, OnlineModeSettings.blue128)
    end
    if flashVehicle.lightTrail then
      flashVehicle:setLightTrailColour(OnlineModeSettings.blue128)
    end
    if tagOwnerID ~= localPlayer.playerID then
      Menu.SetPlayerColour(tagOwnerID, OnlineModeSettings.blue128)
      if flashVehicle.markers then
        if flashVehicle.markers.Minimap0 then
          flashVehicle.markers.Minimap0.colour = OnlineModeSettings.blue32
        end
        if flashVehicle.markers.MinimapArrow0 then
          flashVehicle.markers.MinimapArrow0.colour = OnlineModeSettings.blue32
        end
      end
    end
  end
  local function flashCarHighLight(startFlash, playerID, stop)
    if stop and carHighLightFlash then
      flashVehicle = playerManager.players[tagOwnerID].currentVehicle or playerManager.players[tagOwnerID] and false
      if flashVehicle then
        resetPlayerHightlight()
      end
      flashStartTime = -1
      lastFlashTime = -1
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
            if tagOwnerID ~= localPlayer.playerID then
              Menu.SetPlayerColour(tagOwnerID, OnlineModeSettings.yellow128)
              if flashVehicle.markers then
                if flashVehicle.markers.Minimap0 then
                  flashVehicle.markers.Minimap0.colour = OnlineModeSettings.yellow32
                end
                if flashVehicle.markers.MinimapArrow0 then
                  flashVehicle.markers.MinimapArrow0.colour = OnlineModeSettings.yellow32
                end
              end
            end
            colourA = false
          else
            flashVehicle:overRideFlashColour(OnlineModeSettings.blue32, OnlineModeSettings.blue128)
            if flashVehicle.lightTrail then
              flashVehicle:setLightTrailColour(OnlineModeSettings.blue128)
            end
            if tagOwnerID ~= localPlayer.playerID then
              Menu.SetPlayerColour(tagOwnerID, OnlineModeSettings.blue128)
              if flashVehicle.markers then
                if flashVehicle.markers.Minimap0 then
                  flashVehicle.markers.Minimap0.colour = OnlineModeSettings.blue32
                end
                if flashVehicle.markers.MinimapArrow0 then
                  flashVehicle.markers.MinimapArrow0.colour = OnlineModeSettings.blue32
                end
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
        carHighLightFlash = false
        colourA = false
        flashVehicle = false
      end
    end
    if startFlash then
      flashStartTime = g_NetworkTime
      lastFlashTime = g_NetworkTime
      tagOwnerID = playerID
      carHighLightFlash = true
      colourA = false
      flashVehicle = playerManager.players[playerID].currentVehicle
    end
  end
  local function takeTorch()
    torchOwner = true
    achievementIncFlag = true
    OneShotSound.Play("MP_Player_Positive")
    feedbackSystem.menusMaster.primaryTextPrompt("ID:168507")
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 1)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 3)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Bar_Sparks", 1)
  end
  local function loseTorch()
    torchOwner = false
    OneShotSound.Play("MP_Player_Positive")
    if currentBlueTeamTorchCarrier then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:168509", playerManager.players[currentBlueTeamTorchCarrier].name)
    end
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Bar_Sparks", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 0)
  end
  local function clearTeamGamerTags(team)
    for playerID, player in next, playerManager.players, nil do
      if PlayerGamePlay.getPlayerTeam(playerID) == team then
        clearGamerTagMarkers(playerID, 5)
      end
    end
  end
  local function updateTorchVehicle()
    currentBlueTeamTorchCarrier = blueTeamPackageTO.coreData.agent.playerID or blueTeamPackageTO.coreData and false
    currentBlueTeamTorchVehicle = blueTeamPackageTO.coreData.agent.owner or blueTeamPackageTO.coreData and false
    currentRedTeamTorchCarrier = redTeamPackageTO.coreData.agent.playerID or redTeamPackageTO.coreData and false
    currentRedTeamTorchVehicle = redTeamPackageTO.coreData.agent.owner or redTeamPackageTO.coreData and false
    if currentBlueTeamTorchVehicle then
      if playerManager.players[currentBlueTeamTorchCarrier] then
        if not previousBlueTeamTorchVehicle then
          resetPrompts = true
          if localPlayer.playerID ~= currentBlueTeamTorchCarrier then
            setGamerTagMarkers(currentBlueTeamTorchCarrier, 179)
            setVehicleMarkers(currentBlueTeamTorchVehicle, 119, OnlineModeSettings.blue32)
          else
            takeTorch()
          end
          flashCarHighLight(true, currentBlueTeamTorchCarrier)
          previousBlueTeamTorchCarrier = currentBlueTeamTorchCarrier
          previousBlueTeamTorchVehicle = currentBlueTeamTorchVehicle
        elseif currentBlueTeamTorchVehicle ~= previousBlueTeamTorchVehicle then
          resetPrompts = true
          clearTeamGamerTags(localTeam)
          clearVehicleMarkers(previousBlueTeamTorchVehicle)
          if localPlayer.playerID ~= currentBlueTeamTorchCarrier then
            if torchOwner then
              loseTorch()
            end
            setGamerTagMarkers(currentBlueTeamTorchCarrier, 179)
            setVehicleMarkers(currentBlueTeamTorchVehicle, 119, OnlineModeSettings.blue32)
          else
            takeTorch()
          end
          flashCarHighLight(true, currentBlueTeamTorchCarrier)
          previousBlueTeamTorchCarrier = currentBlueTeamTorchCarrier
          previousBlueTeamTorchVehicle = currentBlueTeamTorchVehicle
        end
      end
    elseif previousBlueTeamTorchVehicle then
      resetPrompts = true
      if torchOwner then
        loseTorch()
      end
      clearTeamGamerTags(localTeam)
      clearVehicleMarkers(previousBlueTeamTorchVehicle)
      flashCarHighLight(nil, nil, true)
      previousBlueTeamTorchCarrier = false
      previousBlueTeamTorchVehicle = false
    end
    if currentRedTeamTorchVehicle then
      if playerManager.players[currentRedTeamTorchCarrier] then
        if not previousRedTeamTorchVehicle then
          OneShotSound.Play("MP_Player_Negative")
          if localPlayer.playerID ~= currentRedTeamTorchCarrier then
            setGamerTagMarkers(currentRedTeamTorchCarrier, 179)
            setVehicleMarkers(currentRedTeamTorchVehicle, 172, OnlineModeSettings.red32)
          end
          previousRedTeamTorchCarrier = currentRedTeamTorchCarrier
          previousRedTeamTorchVehicle = currentRedTeamTorchVehicle
        elseif currentRedTeamTorchVehicle ~= previousRedTeamTorchVehicle then
          OneShotSound.Play("MP_Player_Negative")
          clearTeamGamerTags(redTeam)
          clearVehicleMarkers(previousRedTeamTorchVehicle)
          if localPlayer.playerID ~= currentRedTeamTorchCarrier then
            setGamerTagMarkers(currentRedTeamTorchCarrier, 179)
            setVehicleMarkers(currentRedTeamTorchVehicle, 172, OnlineModeSettings.red32)
          end
          previousRedTeamTorchCarrier = currentRedTeamTorchCarrier
          previousRedTeamTorchVehicle = currentRedTeamTorchVehicle
        end
      end
    elseif previousRedTeamTorchVehicle then
      OneShotSound.Play("MP_Player_Positive")
      clearTeamGamerTags(redTeam)
      clearVehicleMarkers(previousRedTeamTorchVehicle)
      previousRedTeamTorchCarrier = false
      previousRedTeamTorchVehicle = false
    end
  end
  local function updateFuelBar()
    if blueTeamPackageTO and blueTeamPackageTO.namedTasks and blueTeamPackageTO.namedTasks.power and blueTeamPackageTO.coreData.agent.owner then
      if blueTeamPackageTO.coreData.agent.owner and blueTeamPackageTO.coreData.agent.owner.controlled or blueTeamPackageTO.coreData.agent.owner and blueTeamPackageTO.coreData.agent.owner.networkControlled then
        timeToLive = math.ceil(100 - (g_NetworkTime - blueTeamPackageTO.namedTasks.power.networkVars.syncedTime) * 100 / powerLossTime)
        timeToLive = 0
      else
        timeToLive = 0
      end
      if prevTimeToLive ~= timeToLive then
        if torchOwner and achievementIncFlag and (100 - timeToLive) * powerLossTime > OnlineAchievements.OnlineAchievementValueUpdate.BurningRubber.variable2 and gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
          local value = ProfileSettings.GetNumTorchCarries() + 1
          OnlineAchievements.onValueChange("BurningRubber", value)
          ProfileSettings.SetNumTorchCarries(value)
          achievementIncFlag = false
        end
        if timeToLive == 0 and torchDisplayState ~= 3 then
          if torchOwner then
            feedbackSystem.menusMaster.primaryTextPrompt("ID:234266", false, false, false, false, false, false, false, false, true)
          else
            feedbackSystem.menusMaster.primaryTextPrompt("ID:234267", false, false, false, false, false, false, false, false, true)
          end
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 8)
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Bar_Sparks", 0)
          torchDisplayState = 3
        elseif timeToLive > 0 and timeToLive < 30 and torchDisplayState ~= 2 then
          if not torchOwner then
            feedbackSystem.menusMaster.primaryTextPrompt("ID:168511", false, false, false, false, false, false, false, false, true)
          end
          OneShotSound.Play("MP_Low_Warning_Play", false)
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 7)
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Bar_Sparks", 1)
          torchDisplayState = 2
        elseif timeToLive >= 30 and torchDisplayState ~= 1 then
          if not torchOwner then
            feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 0)
            feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Bar_Sparks", 0)
          end
          OneShotSound.Play("MP_Low_Warning_Stop", false)
          torchDisplayState = 1
        end
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Bar", timeToLive)
        prevTimeToLive = timeToLive
      end
    elseif torchDisplayState ~= 0 then
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 0)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Bar_Sparks", 0)
      torchDisplayState = 0
      prevTimeToLive = 0
    end
  end
  local lowTimeMessage = true
  local lowTimeFlash = true
  local timeRemaining = maxTime
  local prevSeconds = false
  local timerOn = false
  local function updateModeTimer()
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
      if timeRemaining < 15 and lowTimeFlash then
        lowTimeFlash = false
        onlineSideBar.toggleSidebarTimerFlash(1)
      end
      if timeRemaining > 17 and not lowTimeMessage then
        lowTimeMessage = true
      end
      if timeRemaining < 17 and lowTimeMessage then
        lowTimeMessage = false
        feedbackSystem.menusMaster.primaryTextPrompt("ID:169362", false, false, false, false, false, false, false, false, true)
      end
    end
  end
  onlineInstructionSupport.addPrompt("passTorch", {
    enabled = false,
    shown = false,
    startTime = 35,
    resetTime = 40,
    displayFunction = function(self, objectivePos, opponents)
      onlineInstructionSupport.displayPrompt("ID:234263", iconsTable.multiTorchBlue)
      return true
    end
  })
  onlineInstructionSupport.addPrompt("takeTorch", {
    enabled = false,
    shown = false,
    startTime = 30,
    resetTime = 40,
    displayFunction = function(self, objectivePos, opponents)
      if not blueTeamPackageTO.coreData.agent.owner and blueTeamFlagOnFloorWorldMarker then
        onlineInstructionSupport.displayPrompt("ID:234264", iconsTable.multiTorchYellow)
      else
        onlineInstructionSupport.displayPrompt("ID:234264", iconsTable.multiTorchBlue)
      end
      return true
    end
  })
  local function stepInstructionPrompts()
    if resetPrompts then
      onlineInstructionSupport.setPrompts(true, true, not torchOwner, true, true, not torchOwner, not torchOwner, not torchOwner, not torchOwner, true, false, false, not torchOwner, false)
      onlineInstructionSupport.setPrompt("score", torchOwner, 5, 25, "ID:234265")
      onlineInstructionSupport.setPrompt("passTorch", torchOwner)
      onlineInstructionSupport.setPrompt("takeTorch", not torchOwner)
      onlineInstructionSupport.modifyPrompt("score", "button", iconsTable.multiTorchBlue)
      resetPrompts = false
    end
    opponents = {}
    for playerID, player in next, playerManager.players, nil do
      if playerID ~= localPlayer.playerID and PlayerGamePlay.getPlayerTeam(playerID) ~= playerTeam then
        table.insert(opponents, {
          vehicle = player.currentVehicle,
          position = player.position
        })
      end
    end
    if prevCheckpoints ~= previousPlayerScore then
      scored = true
      previousPlayerScore = prevCheckpoints
    else
      scored = false
    end
    onlineInstructionSupport.step(blueTeamPackageTO.coreData.agent.position, opponents, scored)
  end
  local function updateFlagOnFloorMarkers()
    if blueTeamPackageTO.coreData and not blueTeamPackageTO.coreData.agent.owner and not blueTeamFlagOnFloorWorldMarker then
      flagOnFloorMarkerSettings.world.gadgetID = 263
      flagOnFloorMarkerSettings.world.position = blueTeamPackageTO.coreData.agent.position
      flagOnFloorMarkerSettings.cylinder.position = blueTeamPackageTO.coreData.agent.position
      blueTeamFlagOnFloorWorldMarker = Marker:create(flagOnFloorMarkerSettings.world)
      blueTeamFlagOnFloorCylinderMarker = Marker:create(flagOnFloorMarkerSettings.cylinder)
      flagOnFloorMarkerSettings.Minimap.colour = OnlineModeSettings.yellow32
      flagOnFloorMarkerSettings.Minimap.position = blueTeamPackageTO.coreData.agent.position
      blueTeamFlagOnFloorMinimapMarker = Marker:create(flagOnFloorMarkerSettings.Minimap)
      flagOnFloorMarkerSettings.target.colour = OnlineModeSettings.yellow32 + OnlineModeSettings.targetAlphaMask32
      flagOnFloorMarkerSettings.target.position = blueTeamPackageTO.coreData.agent.position + OnlineModeSettings.targetOffset
      blueTeamFlagOnFloorTargetMarker = Marker:create(flagOnFloorMarkerSettings.target)
    elseif blueTeamPackageTO.coreData and blueTeamPackageTO.coreData.agent.owner and blueTeamFlagOnFloorWorldMarker then
      Marker:delete(blueTeamFlagOnFloorWorldMarker)
      blueTeamFlagOnFloorWorldMarker = nil
      Marker:delete(blueTeamFlagOnFloorMinimapMarker)
      blueTeamFlagOnFloorMinimapMarker = nil
      Marker:delete(blueTeamFlagOnFloorTargetMarker)
      blueTeamFlagOnFloorTargetMarker = nil
      Marker:delete(blueTeamFlagOnFloorCylinderMarker)
      blueTeamFlagOnFloorCylinderMarker = nil
    end
    if redTeamPackageTO.coreData and not redTeamPackageTO.coreData.agent.owner and not redTeamFlagOnFloorWorldMarker then
      flagOnFloorMarkerSettings.world.gadgetID = 172
      flagOnFloorMarkerSettings.world.position = redTeamPackageTO.coreData.agent.position
      redTeamFlagOnFloorWorldMarker = Marker:create(flagOnFloorMarkerSettings.world)
      flagOnFloorMarkerSettings.Minimap.colour = OnlineModeSettings.red32
      flagOnFloorMarkerSettings.Minimap.position = redTeamPackageTO.coreData.agent.position
      redTeamFlagOnFloorMinimapMarker = Marker:create(flagOnFloorMarkerSettings.Minimap)
      flagOnFloorMarkerSettings.target.colour = OnlineModeSettings.red32 + OnlineModeSettings.targetAlphaMask32
      flagOnFloorMarkerSettings.target.position = redTeamPackageTO.coreData.agent.position + OnlineModeSettings.targetOffset
      redTeamFlagOnFloorTargetMarker = Marker:create(flagOnFloorMarkerSettings.target)
    elseif redTeamPackageTO.coreData and redTeamPackageTO.coreData.agent.owner and redTeamFlagOnFloorWorldMarker then
      Marker:delete(redTeamFlagOnFloorWorldMarker)
      redTeamFlagOnFloorWorldMarker = nil
      Marker:delete(redTeamFlagOnFloorMinimapMarker)
      redTeamFlagOnFloorMinimapMarker = nil
      Marker:delete(redTeamFlagOnFloorTargetMarker)
      redTeamFlagOnFloorTargetMarker = nil
    end
  end
  local prevLap = -1
  local currentLap = -1
  local function update()
    if redTeamPackageTO and redTeamPackageTO.coreData and blueTeamPackageTO and blueTeamPackageTO.coreData then
      updateModeTimer()
      updateTorchVehicle()
      updateFuelBar()
      if not localPlayer.missionSupport:isSubTaskObject(blueTeamPackageTO) then
        localPlayer.missionSupport:addSubTaskObject(blueTeamPackageTO, 1)
      end
      if blueTeamPackageTO.namedTasks.checkpoints and blueTeamPackageTO.namedTasks.checkpoints.networkVars.checkpoints ~= prevCheckpoints then
        OneShotSound.Play("HUD_Online_TagScore_Player_OneShot")
        prevCheckpoints = blueTeamPackageTO.namedTasks.checkpoints.networkVars.checkpoints
      end
      currentLap = blueTeamPackageTO.namedTasks.checkpoints and 0
      if prevLap > -1 and prevLap ~= currentLap then
        if currentLap < task.instance.challenge.settings.totalLaps then
          feedbackSystem.menusMaster.primaryTextPromptParam({
            prompt = "ID:243785",
            value = tostring(prevLap + 1),
            value2 = tostring(task.instance.challenge.settings.totalLaps + 1)
          })
        elseif currentLap == task.instance.challenge.settings.totalLaps then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:169318")
        end
      end
      prevLap = currentLap
      stepInstructionPrompts()
      updateFlagOnFloorMarkers()
      flashCarHighLight()
    else
      if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
        blueTeamPackageTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
      else
        blueTeamPackageTO = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
      end
      if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
        redTeamPackageTO = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
      else
        redTeamPackageTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
      end
    end
  end
  local function cleanup(taskObject)
    if redTeamFlagOnFloorWorldMarker then
      Marker:delete(redTeamFlagOnFloorWorldMarker)
      Marker:delete(redTeamFlagOnFloorMinimapMarker)
      Marker:delete(redTeamFlagOnFloorTargetMarker)
    end
    if blueTeamFlagOnFloorWorldMarker then
      Marker:delete(blueTeamFlagOnFloorWorldMarker)
      Marker:delete(blueTeamFlagOnFloorMinimapMarker)
      Marker:delete(blueTeamFlagOnFloorTargetMarker)
      Marker:delete(blueTeamFlagOnFloorCylinderMarker)
    end
    local fromPurge = taskObject.coreData.instance.deleteFromPurge
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Bar_Sparks", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Impact", 0)
    OneShotSound.Play("MP_Low_Warning_Stop", false)
    if currentRedTeamTorchVehicle then
      clearVehicleMarkers(currentRedTeamTorchVehicle)
    end
    if currentBlueTeamTorchVehicle then
      clearVehicleMarkers(currentBlueTeamTorchVehicle)
    end
    if not fromPurge then
      for playerID, player in next, playerManager.players, nil do
        if PlayerGamePlay.getPlayerTeam(playerID) == localTeam then
          if playerID ~= localPlayer.playerID then
            feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.blue32, OnlineModeSettings.blue128)
          end
        else
          feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.red32, OnlineModeSettings.red128)
        end
      end
    end
    for i = 0, 7 do
      gamerTag.setPlayerMarkerModel(i, 5)
      gamerTag.setPlayerObjectiveMarker(i, false)
    end
  end
  update(taskSystem.taskObjects[task.taskObjectID])
  return update, nil, nil, cleanup
end)
