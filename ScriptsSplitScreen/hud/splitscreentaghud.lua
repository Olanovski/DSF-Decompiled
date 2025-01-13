feedbackSystem.registerHUD("MP Tag Start HUD", function(task, settings)
end, function(instance)
  local tagTaskObject = instance.taskObjectsByActorID["Objective Team 1 member 1"]
  local tagVehicle = tagTaskObject.coreData.agent.owner
  local markerSettings = {
    Target = {
      type = "Target",
      targetType = "MultiplayerObjective",
      colour = OnlineModeSettings.red32 + OnlineModeSettings.targetAlphaMask32,
      gadgetID = 177,
      radius = 45,
      visible = true,
      markerOffset = 1
    },
    MinimapArrow = {
      type = "Minimap",
      radius = 40,
      gadgetID = 257,
      colour = OnlineModeSettings.red32,
      visible = true,
      canrotate = true,
      nofade = true
    },
    Minimap = {
      type = "Minimap",
      radius = 40,
      gadgetID = 256,
      colour = OnlineModeSettings.red32,
      visible = true,
      canrotate = false,
      nofade = true
    }
  }
  local function setMainMarker(vehicle)
    vehicle:disableMinimapMarker(true)
    vehicle.markers = vehicle.markers or {}
    for k, v in next, vehicle.markers, nil do
      Marker:delete(v)
      vehicle.markers[k] = nil
    end
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
  setMainMarker(tagVehicle)
  local function cleanup()
    tagVehicle:deleteDisplay()
    clearMainMarker(tagVehicle)
  end
  return nil, nil, nil, cleanup
end)
feedbackSystem.registerHUD("Tag HUD", function(task, settings)
end, function(task)
  local instance = task.instance
  local tagTaskObject = instance.taskObjectsByActorID["Objective Team 1 member 1"]
  local tagVehicle = tagTaskObject.coreData.agent.owner
  local previousTagVehicle = tagVehicle
  local previousOwnerID = -1
  local ownerID = -1
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
  local redTagIconPromptSet = true
  local scoreBarSetup = false
  local markerSettings = {
    Target = {
      type = "Target",
      targetType = "MultiplayerObjective",
      colour = OnlineModeSettings.red32 + OnlineModeSettings.targetAlphaMask32,
      gadgetID = 177,
      radius = 45,
      visible = true,
      localID = localPlayerID,
      markerOffset = 1
    },
    MinimapArrow = {
      type = "Minimap",
      radius = 40,
      gadgetID = 257,
      colour = OnlineModeSettings.red32,
      visible = true,
      canrotate = true,
      nofade = true,
      localID = localPlayerID
    },
    Minimap = {
      type = "Minimap",
      radius = 40,
      gadgetID = 256,
      colour = OnlineModeSettings.red32,
      visible = true,
      canrotate = false,
      nofade = true,
      localID = localPlayerID
    }
  }
  local function clearMainMarker(vehicle)
    vehicle:removeLightTrail()
    vehicle:disableMinimapMarker(false)
    if vehicle.markers and vehicle.markers[localPlayerID] then
      for k, v in next, vehicle.markers[localPlayerID], nil do
        Marker:delete(v)
        vehicle.markers[localPlayerID][k] = nil
      end
    end
    if previousOwnerID > -1 then
      gamerTag.setPlayerMarkerModel(previousOwnerID, 5)
      gamerTag.setPlayerObjectiveMarker(previousOwnerID, false)
      if previousOwnerID == localPlayerID then
        vehicle:removeFlashColourOverRide(localPlayerID)
      end
    end
  end
  local function setMainMarker(vehicle)
    vehicle:disableMinimapMarker(true)
    vehicle.markers = vehicle.markers or {}
    for k, v in next, markerSettings, nil do
      v.gameVehicle = vehicle.gameVehicle
      if ownerID == -1 then
        if v.type == "Target" then
          v.colour = OnlineModeSettings.red32a
        else
          v.colour = OnlineModeSettings.red32
        end
      end
      if not vehicle.markers[localPlayerID] then
        vehicle.markers[localPlayerID] = {}
      end
      if ownerID == -1 or ownerID > -1 and v.type == "Minimap" then
        vehicle.markers[localPlayerID][k] = Marker:create(v)
      end
    end
    if ownerID > -1 then
      gamerTag.setPlayerMarkerModel(ownerID, 177)
      gamerTag.setPlayerObjectiveMarker(ownerID, true)
    else
      vehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
    end
  end
  tagVehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
  setMainMarker(tagVehicle)
  tagVehicle:addLightTrail(32, OnlineModeSettings.red128)
  local function stepTagMarker()
    tagVehicle = tagTaskObject.coreData.agent.owner
    ownerID = -1
    if tagVehicle ~= previousTagVehicle then
      clearMainMarker(previousTagVehicle)
      for localID, player in next, localPlayerManager.players, nil do
        if player.currentVehicle and player.currentVehicle == tagVehicle then
          if localID == 0 then
            for k, v in next, markerSettings, nil do
              v.colour = OnlineModeSettings.blue32
            end
            if localPlayerID == 0 then
              tagVehicle:addLightTrail(32, OnlineModeSettings.blue128)
            end
            ownerID = 0
            break
          end
          for k, v in next, markerSettings, nil do
            v.colour = OnlineModeSettings.orange32
          end
          if localPlayerID == 0 then
            tagVehicle:addLightTrail(32, OnlineModeSettings.orange128)
          end
          ownerID = 1
          break
        end
      end
      if not task.agent.currentVehicle or task.agent.currentVehicle ~= tagVehicle then
        setMainMarker(tagVehicle)
      end
      if ownerID == localPlayerID then
        onlineInstructionSupport.displayPrompt("ID:245814", false, localPlayerID, false)
        if ownerID == 0 then
          tagVehicle:overRideFlashColour(OnlineModeSettings.blue32, OnlineModeSettings.blue128, localPlayerID)
        else
          tagVehicle:overRideFlashColour(OnlineModeSettings.blue32, OnlineModeSettings.orange128, localPlayerID)
        end
      end
      if previousTagVehicle == localPlayerManager.players[localPlayerID].currentVehicle then
        onlineInstructionSupport.displayPrompt("ID:246717", false, localPlayerID, false)
      end
      OneShotSound.Play("MP_Player_Positive", false)
      previousTagVehicle = tagVehicle
      previousOwnerID = ownerID
    elseif 1 <= tagVehicle.damage and previousOwnerID ~= ownerID then
      clearMainMarker(tagVehicle)
      setMainMarker(tagVehicle)
      previousOwnerID = ownerID
    end
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
    objectivePosition = tagVehicle.position
    if playerCurrentScore ~= playerPreviousScore then
      scored = true
      playerPreviousScore = playerCurrentScore
    end
  end
  onlineInstructionSupport.resetPrompts(localPlayerID)
  onlineInstructionSupport.setPrompt("accelerate", nil, 3, nil, nil, localPlayerID)
  onlineInstructionSupport.setPrompt("score", nil, nil, nil, "ID:236583", localPlayerID)
  onlineInstructionSupport.modifyPrompt("score", "button", iconsTable.multiTagRed, localPlayerID)
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
    if not redTagIconPromptSet then
      if not tagTaskObject.coreData.agent.owner.controlled then
        redTagIconPromptSet = true
        onlineInstructionSupport.modifyPrompt("score", "message", "ID:236583", localPlayerID)
      end
    elseif tagTaskObject.coreData.agent.owner.controlled then
      redTagIconPromptSet = false
      onlineInstructionSupport.modifyPrompt("score", "message", "ID:247213", localPlayerID)
    end
    onlineInstructionSupport.step(objectivePosition, opponents, scored, localPlayerID)
    scored = false
  end
  local function update()
    stepPlayerProgress()
    if not scoreBarSetup and localPlayerID == 0 then
      setupScoreBar()
    end
    stepInstructionPrompts()
    stepTagMarker()
  end
  local function cleanup(taskObject)
    if localPlayerID == 0 then
      if scoreBarSetup and taskObject.coreData.instance.deleteFromPurge then
        feedbackSystem.splitScreenSupport.clearScoringBar()
      elseif not scoreBarSetup then
        PauseMenu.allow(true)
        scoreBarSetup = true
      end
    end
    if previousTagVehicle then
      previousTagVehicle:removeLightTrail()
      clearMainMarker(previousTagVehicle)
    end
  end
  return update, nil, nil, cleanup
end)
