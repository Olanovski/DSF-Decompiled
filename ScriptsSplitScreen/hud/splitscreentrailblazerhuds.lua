feedbackSystem.registerHUD("MP Trail Blazer Start HUD", function(task, settings)
end, function(instance)
  local trailBlazerTaskObject = instance.taskObjectsByActorID["Objective Team 1 member 1"]
  local trailBlazerVehicle = trailBlazerTaskObject.coreData.agent
  local markerSettings = {
    Target = {
      type = "Target",
      colour = OnlineModeSettings.red32 + OnlineModeSettings.targetAlphaMask32,
      gadgetID = 178,
      radius = 45,
      visible = true,
      targetType = "MultiplayerObjective",
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
  local function setMainMarker(vehicle)
    vehicle:disableMinimapMarker(true)
    vehicle.markers = vehicle.markers or {}
    for k, v in next, markerSettings, nil do
      v.gameVehicle = vehicle.gameVehicle
      vehicle.markers[k] = Marker:create(v)
    end
  end
  local clearMainMarker = function(vehicle)
    vehicle:disableMinimapMarker(false)
    if vehicle.markers then
      for k, v in next, vehicle.markers, nil do
        Marker:delete(v)
        vehicle.markers[k] = nil
      end
    end
  end
  setMainMarker(trailBlazerVehicle)
  local function cleanup()
    trailBlazerVehicle:deleteDisplay()
    clearMainMarker(trailBlazerVehicle)
  end
  return nil, nil, nil, cleanup
end)
feedbackSystem.registerHUD("MP Trail Blazer HUD", function(task, settings)
end, function(task)
  local instance = task.instance
  local trailBlazerTaskObject = instance.taskObjectsByActorID["Objective Team 1 member 1"]
  local trailBlazerVehicle = trailBlazerTaskObject.coreData.agent
  local localPlayerID = task.agent.localID
  local opponents = {}
  local scored = false
  local objectivePosition = false
  local playerTaskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[localPlayerID + 1]]
  local playerCurrentScore = playerTaskObject.namedTasks.score.networkVars.payload
  local playerPreviousScore = playerCurrentScore
  local scoreLimit = 100
  local payloadIncreaseValue = 100 / scoreLimit
  local timerDisplayed = false
  local scoreBarSetup = false
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
    }
  }
  local function clearMainMarker(vehicle)
    vehicle:disableMinimapMarker(false)
    if vehicle.markers and vehicle.markers[localPlayerID] then
      for k, v in next, vehicle.markers[localPlayerID], nil do
        Marker:delete(v)
        vehicle.markers[localPlayerID][k] = nil
      end
    end
  end
  local function setMainMarker(vehicle)
    vehicle:disableMinimapMarker(true)
    vehicle.markers = vehicle.markers or {}
    for k, v in next, markerSettings, nil do
      v.gameVehicle = vehicle.gameVehicle
      if not vehicle.markers[localPlayerID] then
        vehicle.markers[localPlayerID] = {}
      end
      vehicle.markers[localPlayerID][k] = Marker:create(v)
    end
  end
  setMainMarker(trailBlazerVehicle)
  if localPlayerID == 0 then
    trailBlazerVehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
    trailBlazerVehicle:addLightTrail(2, OnlineModeSettings.red128, 2, true)
  end
  local function setupScoreBar()
    if Menu.GetSceneStatus("Splitscreen", "ss_racemode_countdown") == 2 then
      feedbackSystem.splitScreenSupport.setupScoringBar(payloadIncreaseValue)
      PauseMenu.allow(true)
      scoreBarSetup = true
    end
  end
  local function stepPlayerProgress()
    playerCurrentScore = playerTaskObject.namedTasks.score.networkVars.payload
    objectivePosition = trailBlazerVehicle.position
    if playerCurrentScore ~= playerPreviousScore then
      scored = true
      playerPreviousScore = playerCurrentScore
    end
  end
  local inTrails = false
  local function stepVehicleHighlight()
    if localPlayerID == 0 then
      trailBlazerVehicle:setLightTrailColour(OnlineModeSettings.red128)
    end
    for i, player in next, playerManager.players, nil do
      if not player.inZap and player.currentVehicle.gameVehicle then
        local score = GameVehicleResource.interceptingTrailCount(player.currentVehicle.gameVehicle)
        if localPlayerID == 0 and score > 0 then
          if player.localID == 0 then
            GameVehicleResource.setInterceptedTrailColour(trailBlazerVehicle.gameVehicle, player.currentVehicle.gameVehicle, OnlineModeSettings.blue128)
          else
            GameVehicleResource.setInterceptedTrailColour(trailBlazerVehicle.gameVehicle, player.currentVehicle.gameVehicle, OnlineModeSettings.orange128)
          end
        end
        if score and score > 0 then
          if not player.currentVehicle:vehicleFlashOverridden(player.localID) and player.localID == localPlayerID then
            if localPlayerID == 0 then
              player.currentVehicle:overRideFlashColour(OnlineModeSettings.blue32, OnlineModeSettings.blue128, player.localID)
            else
              player.currentVehicle:overRideFlashColour(OnlineModeSettings.orange32, OnlineModeSettings.orange128, player.localID)
            end
            if not inTrails then
              OneShotSound.Play("HUD_Online_TrailBlazer_EnterStream", false, false, player.localID)
              inTrails = true
            end
          end
        else
          if player.currentVehicle:vehicleFlashOverridden(player.localID) then
            player.currentVehicle:removeFlashColourOverRide(player.localID)
          end
          if player.localID == localPlayerID and inTrails then
            OneShotSound.Play("HUD_Online_TrailBlazer_ExitStream", false, false, player.localID)
            inTrails = false
          end
        end
      elseif player.localID == localPlayerID and inTrails and player.inZap then
        OneShotSound.Play("HUD_Online_TrailBlazer_ExitStream", false, false, player.localID)
        inTrails = false
      end
    end
  end
  onlineInstructionSupport.resetPrompts(localPlayerID)
  onlineInstructionSupport.setPrompt("accelerate", nil, 3, nil, nil, localPlayerID)
  onlineInstructionSupport.setPrompt("score", nil, nil, nil, "ID:234338", localPlayerID)
  local function stepInstructionPrompts()
    opponents = {}
    for localID, player in next, localPlayerManager.players, nil do
      if localID ~= localPlayerID then
        table.insert(opponents, {
          vehicle = player.currentVehicle,
          position = player.position
        })
        break
      end
    end
    onlineInstructionSupport.step(objectivePosition, opponents, scored, localPlayerID)
    scored = false
  end
  local function update()
    if not scoreBarSetup and localPlayerID == 0 then
      setupScoreBar()
    end
    stepPlayerProgress()
    stepVehicleHighlight()
    stepInstructionPrompts()
  end
  local function cleanup(taskObject)
    if localPlayerID == 0 then
      if scoreBarSetup and taskObject.coreData.instance.deleteFromPurge then
        feedbackSystem.splitScreenSupport.clearScoringBar()
      elseif not scoreBarSetup then
        PauseMenu.allow(true)
        scoreBarSetup = true
      end
      trailBlazerVehicle:deleteDisplay()
      trailBlazerVehicle:removeLightTrail()
    end
    OneShotSound.Play("HUD_Online_TrailBlazer_ExitStream", false, true, localPlayerID)
    clearMainMarker(trailBlazerVehicle)
  end
  return update, nil, nil, cleanup
end)
