feedbackSystem.registerHUD("MP Clean the Streets Start HUD", function(task, settings)
end, function(instance)
  return
end)
feedbackSystem.registerHUD("MP Clean the Streets HUD", function(task, settings)
end, function(task)
  local instance = task.instance
  local racerTaskObjectOne = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local packageTO = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  local localPlayerID = task.agent.localID
  local healthBarString = "HealthBarMarker " .. tostring(localPlayerID)
  local scored = false
  local timeLimit = instance.challenge.settings.modeTimeLimit
  local workingVector = vec.vector()
  local scoreLimit = 10
  local payloadIncreaseValue = 100 / scoreLimit
  local timerDisplayed = false
  local scoreBarSetup = false
  local location = phaseManager.playlistSupport.getSelectedLocation()
  assert(location >= 1 and location <= 3, "Mode location not between 1 and 3")
  local markerSettings = {
    ["Target"] = {
      type = "Target",
      colour = OnlineModeSettings.red32 + OnlineModeSettings.targetAlphaMask32,
      gadgetID = 180,
      radius = 45,
      visible = true,
      targetType = "MultiplayerObjective",
      localID = localPlayerID,
      markerOffset = 1
    },
    [healthBarString] = {
      type = "World",
      facing = true,
      gadgetID = 97,
      scale = vec.vector(0.1, 0.1, 0.1, 0),
      colour = vec.vector(255, 255, 255, 255),
      visible = true,
      localID = localPlayerID
    }
  }
  local checkpointSettings = {
    type = "World",
    facing = false,
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
    gadgetID = 73,
    radius = 30,
    visible = true,
    nofade = true,
    canrotate = false,
    localID = nil,
    introType = "BigScaleDown",
    animationType = "WaveScale",
    outroType = "Fade"
  }
  local checkpointColumnSettings = {
    type = "World",
    gadgetID = 79,
    visible = true,
    offset = vec.vector(0, 1.5, 0, 0),
    facing = true,
    fadedistance = 120,
    minalpha = 0,
    maxalpha = 255,
    localID = nil,
    introType = "Fade",
    outroType = "Fade"
  }
  local checkpointNumberSettings = {
    type = "Checkpoint",
    scale = vec.vector(3, 3, 3, 0),
    offset = vec.vector(0, 6, 0.3, 0),
    visible = true,
    angle = 0,
    spacing = 1,
    fadedistance = 120,
    minalpha = 0,
    maxalpha = 255,
    localID = nil,
    introType = "Fade",
    outroType = "Fade"
  }
  local checkpointMarker, checkpointNumber, checkpointColumnMarker, checkpointMinimapMarker, roadWidth, roadDirection, roadHeading, previousCheckpointPos, lastDrawnCheckpoint
  local previousLevel = 1
  local racer, racer2
  local racerMarkers = {}
  local currentBestPos, currentBestDistance, currentDistance, allVehicleDamage
  onlineInstructionSupport.displayPrompt("ID:246055", nil, localPlayerID)
  local function removeCheckpoint()
    if checkpointMarker then
      Marker:delete(checkpointMarker)
      checkpointMarker = nil
      Marker:delete(checkpointColumnMarker)
      checkpointColumnMarker = nil
      Marker:delete(checkpointMinimapMarker)
      checkpointMinimapMarker = nil
      Marker:delete(checkpointNumber)
      checkpointNumber = nil
    end
  end
  local function drawCheckpoint(checkpoint, number)
    if number == 6 then
      onlineInstructionSupport.displayPrompt("ID:246718", nil, localPlayerID)
    elseif number == 9 then
      onlineInstructionSupport.displayPrompt("ID:246719", nil, localPlayerID)
    elseif number == 10 then
      onlineInstructionSupport.displayPrompt("ID:246720", nil, localPlayerID)
    end
    if localPlayerID == 0 then
      removeCheckpoint()
      if checkpoint.toolData and checkpoint.toolData.displayWidth and checkpoint.toolData.heading then
        roadWidth = checkpoint.toolData.displayWidth
        roadHeading = checkpoint.toolData.heading
      else
        local roadIndex, distanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(checkpoint.position)
        roadWidth = Atlas.AverageRoadWidth(roadIndex)
        local roadAngle = getVectorRoadAngleAtPosition(roadIndex, distanceAlong)
        roadHeading = math.atan2(roadAngle.x, roadAngle.z)
      end
      checkpointSettings.position = checkpoint.position
      checkpointSettings.heading = roadHeading
      checkpointNumberSettings.angle = roadHeading
      checkpointColumnSettings.position = checkpoint.position
      checkpointMinimapSettings.position = checkpoint.position
      checkpointNumberSettings.position = checkpoint.position
      checkpointNumberSettings.number = number
      checkpointNumberSettings.numberof = 10
      if number == 10 and instance.currentSSLevel == 10 then
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
        checkpointSettings.colour = OnlineModeSettings.red32
        checkpointNumberSettings.colour = OnlineModeSettings.red32
        checkpointColumnSettings.colour = OnlineModeSettings.red32
        checkpointMinimapSettings.colour = OnlineModeSettings.red32
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
        if number == 10 then
          checkpointSettings.colour = OnlineModeSettings.red32
          checkpointNumberSettings.colour = OnlineModeSettings.red32
          checkpointColumnSettings.colour = OnlineModeSettings.red32
          checkpointMinimapSettings.colour = OnlineModeSettings.red32
        else
          checkpointMinimapSettings.gadgetID = 73
          checkpointSettings.colour = vec.vector(255, 255, 255, 255)
          checkpointNumberSettings.colour = vec.vector(246, 196, 14, 255)
          checkpointColumnSettings.colour = vec.vector(255, 255, 255, 255)
          checkpointMinimapSettings.colour = vec.vector(246, 196, 14, 255)
        end
      end
      checkpointMarker = Marker:create(checkpointSettings)
      checkpointNumber = Marker:create(checkpointNumberSettings)
      checkpointColumnMarker = Marker:create(checkpointColumnSettings)
      checkpointMinimapMarker = Marker:create(checkpointMinimapSettings)
    end
  end
  local stepCheckpoint = function()
  end
  local function clearMainMarker(vehicle)
    vehicle:disableMinimapMarker(false)
    if localPlayerID == 0 then
      vehicle:deleteDisplay()
    end
    if vehicle.markers then
      for k, v in next, vehicle.markers[localPlayerID], nil do
        Marker:delete(v)
        vehicle.markers[localPlayerID][k] = nil
      end
    end
    racerMarkers[vehicle] = nil
  end
  local function setMainMarker(vehicle)
    if localPlayerID == 0 then
      vehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
    end
    vehicle.markers = vehicle.markers or {}
    vehicle.markers[localPlayerID] = {}
    for k, v in next, markerSettings, nil do
      v.gameVehicle = vehicle.gameVehicle
      if k == healthBarString then
        v.uValue = vehicle.damage
        v.vValue = -vehicle.damage
        v.offset = vec.vector(0, vehicle.gameVehicle.height + 1, 0, 0)
      end
      vehicle.markers[localPlayerID][k] = Marker:create(v)
    end
    racerMarkers[vehicle] = vehicle
  end
  for i = 1, task.instance.challenge.settings.maxNumRacers do
    racer = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
    if racer then
      setMainMarker(racer.coreData.agent)
    end
  end
  if localPlayerID == 0 then
    drawCheckpoint(task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].namedTasks.Checkpoints.dynamicTargets[1])
    previousCheckpointPos = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].namedTasks.Checkpoints.dynamicTargets[1].position
    lastDrawnCheckpoint = previousCheckpointPos
  end
  local currentBestCheckpoint, currentBestRacer
  local function stepMarkers()
    currentBestCheckpoint = 0
    for i = 1, task.instance.challenge.settings.maxNumRacers do
      racer = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
      if taskSystem.validTaskObject(racer) and racer.namedTasks.Checkpoints.networkVars.checkpoints > currentBestCheckpoint then
        currentBestCheckpoint = racer.namedTasks.Checkpoints.networkVars.checkpoints
        currentBestRacer = racer
      end
    end
    if taskSystem.validTaskObject(currentBestRacer) and currentBestRacer.namedTasks.Checkpoints and currentBestRacer.namedTasks.Checkpoints.dynamicTargets and currentBestRacer.namedTasks.Checkpoints.dynamicTargets[1] ~= previousCheckpointPos and currentBestRacer.namedTasks.Checkpoints.dynamicTargets[1] ~= lastDrawnCheckpoint then
      lastDrawnCheckpoint = previousCheckpointPos
      drawCheckpoint(currentBestRacer.namedTasks.Checkpoints.dynamicTargets[1], currentBestRacer.namedTasks.Checkpoints.networkVars.checkpoints)
      previousCheckpointPos = currentBestRacer.namedTasks.Checkpoints.dynamicTargets[1]
    end
    if racerTaskObjectOne ~= instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]] then
      for k, vehicle in next, racerMarkers, nil do
        clearMainMarker(vehicle)
      end
      racerTaskObjectOne = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
      for i = 1, task.instance.challenge.settings.maxNumRacers do
        racer = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
        if taskSystem.validTaskObject(racer) then
          setMainMarker(racer.coreData.agent)
        end
      end
      onlineInstructionSupport.displayPrompt("ID:245961", nil, localPlayerID)
    else
      for i = 1, task.instance.challenge.settings.maxNumRacers do
        racer = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
        if taskSystem.validTaskObject(racer) and racer.coreData.agent.markers and racer.coreData.agent.markers[localPlayerID][healthBarString] then
          if 1 <= racer.coreData.agent.damage then
            clearMainMarker(racer.coreData.agent)
            onlineInstructionSupport.displayPrompt("ID:245962", nil, localPlayerID)
            if localPlayerID == 0 then
              GameVehicleResource.setInfiniteMass(racer.coreData.agent.gameVehicle, false)
            end
          else
            racer.coreData.agent.markers[localPlayerID][healthBarString].uValue = racer.coreData.agent.damage
            racer.coreData.agent.markers[localPlayerID][healthBarString].vValue = racer.coreData.agent.damage
          end
        end
      end
    end
  end
  local function setupScoreBar()
    if Menu.GetSceneStatus("Splitscreen", "ss_racemode_countdown") == 2 then
      feedbackSystem.splitScreenSupport.setupScoringBar(payloadIncreaseValue, true)
      feedbackSystem.splitScreenSupport.updateLevelCounterBarCoop(0, 0, true)
      PauseMenu.allow(true)
      scoreBarSetup = true
    end
  end
  onlineInstructionSupport.resetPrompts(localPlayerID)
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
  onlineInstructionSupport.addPrompt("shiftIn", {
    enabled = false,
    shown = false,
    resetOnScore = true,
    startTime = 4,
    resetTime = 6,
    displayFunction = function(self, objectivePos, opponents, player)
      onlineInstructionSupport.displayPrompt("ID:183943", localPlayer.buttonLayout.zapSelect, player.localID)
      return true
    end
  }, localPlayerID)
  local bestCheckpointNum = -1
  local bestCheckpointDistance = -1
  local bestTarget = -1
  local function stepInstructionPrompts()
    opponents = {}
    for i = 1, task.instance.challenge.settings.maxNumRacers do
      racer = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
      if taskSystem.validTaskObject(racer) and racer.namedTasks.Checkpoints and racer.namedTasks.Checkpoints.dynamicTargets and racer.namedTasks.Checkpoints.dynamicTargets[1] and 1 > racer.coreData.agent.damage then
        table.insert(opponents, {
          vehicle = racer.coreData.agent,
          position = racer.coreData.agent.position,
          checkpointNum = racer.namedTasks.Checkpoints.networkVars.checkpoints,
          checkpointPosition = racer.namedTasks.Checkpoints.dynamicTargets[1].position,
          taskObjectID = racer.coreData.taskObjectID
        })
      end
    end
    if #opponents == 0 then
      return
    end
    currentBestPos = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent.position
    currentBestDistance = math.huge
    bestCheckpointNum = -1
    bestCheckpointDistance = math.huge
    bestTarget = -1
    for i, opponent in ipairs(opponents) do
      currentDistance = workingVector:sub(task.agent.position, opponent.position):length()
      if currentBestDistance > currentDistance then
        currentBestDistance = currentDistance
        currentBestPos = opponent.position
      end
      if opponent.checkpointNum >= bestCheckpointNum then
        currentDistance = workingVector:sub(opponent.checkpointPosition, opponent.position):length()
        if currentDistance < bestCheckpointDistance or opponent.checkpointNum > bestCheckpointNum then
          bestCheckpointNum = opponent.checkpointNum
          bestCheckpointDistance = currentDistance
          bestTarget = opponent.taskObjectID
        end
      end
    end
    if -1 < packageTO.zapToActionTarget and bestTarget > -1 and packageTO.zapToActionTarget ~= bestTarget then
      MPZapToAction.updateZapToActionTarget(taskSystem.taskObjects[bestTarget].coreData.agent)
      packageTO.zapToActionTarget = bestTarget
    elseif packageTO.zapToActionTarget == -1 and bestTarget > -1 then
      MPZapToAction.setZapToAction(1, taskSystem.taskObjects[bestTarget].coreData.agent)
      packageTO.zapToActionTarget = bestTarget
    elseif -1 < packageTO.zapToActionTarget and bestTarget == -1 then
      MPZapToAction.reset()
      packageTO.zapToActionTarget = -1
    end
    if localPlayerManager.players[localPlayerID].shiftToTarget and not localPlayerManager.players[localPlayerID].inZap then
      onlineInstructionSupport.setPrompt("shiftIn", false, nil, nil, nil, localPlayerID)
      localPlayerManager.players[localPlayerID].shiftToTarget = nil
    end
    onlineInstructionSupport.step(currentBestPos, opponents, false, localPlayerID)
  end
  local function stepProgressBar()
    allVehicleDamage = 0
    for i = 1, task.instance.challenge.settings.maxNumRacers do
      racer = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
      if taskSystem.validTaskObject(racer) then
        allVehicleDamage = allVehicleDamage + racer.coreData.agent.damage
      end
    end
    feedbackSystem.splitScreenSupport.updateScoringBar(0, instance.currentSSLevel - 1 + allVehicleDamage / instance.challenge.settings.numRacersPerLevel[location][instance.currentSSLevel], true)
  end
  local function update()
    if instance.currentSSLevel ~= 11 then
      stepMarkers()
      if localPlayerID == 0 then
        if scoreBarSetup then
          stepProgressBar()
        else
          setupScoreBar()
        end
      end
      stepInstructionPrompts()
      if previousLevel ~= instance.currentSSLevel then
        previousLevel = instance.currentSSLevel
        onlineInstructionSupport.setPrompt("shiftIn", true, nil, nil, nil, localPlayerID)
        OneShotSound.PlayGUI("HUD_Gen_Positive")
        if localPlayerID == 0 then
          feedbackSystem.splitScreenSupport.updateLevelCounterBarCoop(0, previousLevel - 1, true)
        end
      end
    end
  end
  local function cleanup(taskObject)
    if localPlayerID == 0 then
      if scoreBarSetup and taskObject.coreData.instance.deleteFromPurge then
        feedbackSystem.splitScreenSupport.clearScoringBar(true)
      elseif not scoreBarSetup then
        PauseMenu.allow(true)
        scoreBarSetup = true
      end
      removeCheckpoint()
      if instance.currentSSLevel == 11 then
        feedbackSystem.splitScreenSupport.updateScoringBar(0, 100, true)
        feedbackSystem.splitScreenSupport.updateLevelCounterBarCoop(0, instance.currentSSLevel - 1, true)
      else
        stepProgressBar()
      end
    end
    for k, vehicle in next, racerMarkers, nil do
      clearMainMarker(vehicle)
    end
  end
  return update, nil, nil, cleanup
end)
