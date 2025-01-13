feedbackSystem.registerHUD("SS Survival Start HUD", function(task, settings)
end, function(instance)
  OneShotSound.Play("HUD_Online_RoundSet")
  feedbackSystem.menusMaster.primaryTextPrompt("#STARTING LEVEL 1")
  local cleanup = function()
  end
  return nil, nil, nil, cleanup
end)
feedbackSystem.registerHUD("SS Survival HUD", function(task, settings)
end, function(task)
  local instance = task.instance
  local timeLimit = instance.challenge.settings.modeTimeLimit
  local localPlayerID = task.agent.localID
  local playerTaskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[localPlayerID + 1]]
  local partnerTaskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[math.abs(localPlayerID - 1) + 1]]
  local packageTO = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
  local payloadIncreaseValue = 100 / instance.challenge.settings.maxLevel
  local workingVector = vec.vector()
  local lastLevel = 1
  local numCheckpoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].levelData[packageTO.namedTasks.level.networkVars.level].route
  local increments = 1 / numCheckpoints
  local aproxRouteLength = 0
  local lastCheckpoint = 0
  local previousScore = 0
  local workingScore = 0
  local tempScore = 0
  local scored = false
  local scoreBarSetup = false
  local chaserTable = {
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,
    [6] = false,
    [7] = false,
    [8] = false
  }
  local chaserTO = false
  local chaserMarkerSettings = {
    minimap = {
      type = "Minimap",
      constrain = false,
      gadgetID = 239,
      colour = vec.vector(0, 255, 255, 255),
      radius = 30,
      visible = true,
      canrotate = true,
      constrain = true,
      nofade = true,
      localID = localPlayerID
    },
    target = {
      type = "Target",
      gadgetID = 5,
      colour = vec.vector(255, 0, 0, 255),
      radius = 50,
      visible = true,
      twoDMarker = false,
      showDistance = false,
      targetType = "Evade",
      localID = localPlayerID
    }
  }
  local flashTime = 0.01
  local colourLookupTable = {
    vec.vector(255, 0, 0, 255),
    vec.vector(255, 255, 255, 255),
    [17] = vec.vector(37, 56, 236, 255)
  }
  onlineInstructionSupport.displayPrompt("ID:245890", nil, localPlayerID)
  playerCurrentPos = onlineRaceManager.getPlayerRank(playerTaskObject.coreData.agent.playerID)
  local function setupScoreBar()
    if Menu.GetSceneStatus("Splitscreen", "ss_racemode_countdown") == 2 then
      feedbackSystem.splitScreenSupport.setupScoringBar(payloadIncreaseValue, true)
      feedbackSystem.splitScreenSupport.updateLevelCounterBarCoop(0, 0, true)
      PauseMenu.allow(true)
      scoreBarSetup = true
    end
  end
  local currentVehicleSNVID = false
  local lastVehicleSNVID = false
  local damagePromptShown = false
  local playerVehicle = false
  local lastDamage = false
  local function updateDamagePrompt()
    playerVehicle = localPlayerManager.players[localPlayerID].currentVehicle
    currentVehicleSNVID = playerVehicle.SNVID or playerVehicle and false
    if not currentVehicleSNVID or currentVehicleSNVID ~= lastVehicleSNVID or lastDamage and playerVehicle and playerVehicle.damage < lastDamage then
      damagePromptShown = false
      lastDamage = false
    elseif currentVehicleSNVID then
      if not damagePromptShown and playerVehicle.damage >= 0.8 then
        if localPlayerID == 0 then
          onlineInstructionSupport.displayPrompt("ID:246054", nil, localPlayerID)
        end
        if localPlayerID == 1 then
          onlineInstructionSupport.displayPrompt("ID:246054", nil, localPlayerID)
        end
        damagePromptShown = true
      end
      lastDamage = playerVehicle.damage
    end
    lastVehicleSNVID = currentVehicleSNVID
    playerVehicle = false
  end
  local function setChaserMarkers(chaserID, vehicle)
    vehicle.markers = vehicle.markers or {}
    for k, v in next, chaserMarkerSettings, nil do
      v.gameVehicle = vehicle.gameVehicle
      if not vehicle.markers[localPlayerID] then
        vehicle.markers[localPlayerID] = {}
      end
      vehicle.markers[localPlayerID][k] = Marker:create(v)
    end
    chaserTable[chaserID] = {
      SNVID = vehicle.SNVID,
      lastUpdate = g_NetworkTime,
      lastColour = 1
    }
  end
  local function removeChaserMarkers(chaserID)
    local vehicle = vehicleManager.vehiclesBySNVID[chaserTable[chaserID].SNVID]
    if vehicle and vehicle.markers and vehicle.markers[localPlayerID] then
      for k, v in next, vehicle.markers[localPlayerID], nil do
        Marker:delete(v)
        vehicle.markers[localPlayerID][k] = nil
      end
    end
    chaserTable[chaserID] = false
  end
  local function udpateChaserFlash(chaserID)
    local vehicle = vehicleManager.vehiclesBySNVID[chaserTable[chaserID].SNVID]
    if vehicle and g_NetworkTime - chaserTable[chaserID].lastUpdate > flashTime and vehicle.markers[localPlayerID].minimap then
      vehicle.markers[localPlayerID].minimap.colour = colourLookupTable[chaserTable[chaserID].lastColour]
      vehicle.markers[localPlayerID].target.colour = colourLookupTable[chaserTable[chaserID].lastColour]
      chaserTable[chaserID].lastColour = chaserTable[chaserID].lastColour + 1
      if chaserTable[chaserID].lastColour > 3 then
        chaserTable[chaserID].lastColour = 1
      end
      chaserTable[chaserID].lastUpdate = g_NetworkTime
    end
  end
  local function updateChaserMarkers()
    for i = 1, 8 do
      chaserTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
      if chaserTO and chaserTO.coreData.agent and chaserTO.namedTasks.chase and chaserTO.namedTasks.chase.dynamicTargets then
        if chaserTO.namedTasks.chase.dynamicTargets[1] == localPlayerManager.players[localPlayerID].currentVehicle then
          if not chaserTable[i] then
            setChaserMarkers(i, chaserTO.coreData.agent)
          elseif chaserTable[i].SNVID ~= chaserTO.coreData.agent.SNVID then
            removeChaserMarkers(i)
            setChaserMarkers(i, chaserTO.coreData.agent)
          else
            udpateChaserFlash(i)
          end
        elseif chaserTable[i] then
          removeChaserMarkers(i)
        end
      end
    end
  end
  onlineInstructionSupport.resetPrompts(localPlayerID)
  onlineInstructionSupport.setPrompt("accelerate", nil, 3, nil, nil, localPlayerID)
  local opponents = {}
  local objectivePosition = false
  local waitTolevelUpShown = false
  local promptPreviousLevel = lastLevel
  local inZap = false
  local function stepInstructionPrompts()
    if not waitTolevelUpShown and not task.agent.currentVehicle and task.agent.inZap and not inZap and lastLevel == promptPreviousLevel then
      waitTolevelUpShown = true
      onlineInstructionSupport.displayPrompt("ID:247182", nil, localPlayerID)
    elseif waitTolevelUpShown and task.agent.currentVehicle then
      waitTolevelUpShown = false
    end
    if packageTO and packageTO.namedTasks.level and task.networkVars.checkpoints ~= 0 then
      objectivePosition = instance.challenge.spawnPositions[instance.networkVars.routeIndex].levelData[packageTO.namedTasks.level.networkVars.level].route[task.networkVars.checkpoints].position
    end
    onlineInstructionSupport.step(objectivePosition, opponents, false, localPlayerID)
    scored = false
    promptPreviousLevel = lastLevel
    inZap = task.agent.inZap
  end
  local leadCheckpoint = 0
  local function update(taskObject)
    if lastLevel ~= packageTO.namedTasks.level.networkVars.level then
      lastLevel = packageTO.namedTasks.level.networkVars.level
      scored = true
      if packageTO.namedTasks.level.networkVars.level <= instance.challenge.settings.maxLevel then
        OneShotSound.PlayGUI("HUD_Gen_Positive")
        onlineInstructionSupport.displayPrompt("ID:246651", nil, localPlayerID)
      end
      if localPlayerID == 0 then
        numCheckpoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].levelData[packageTO.namedTasks.level.networkVars.level].route
        increments = 1 / numCheckpoints
        aproxRouteLength = 0
        lastCheckpoint = 0
        leadCheckpoint = 0
        feedbackSystem.splitScreenSupport.updateLevelCounterBarCoop(0, lastLevel - 1, true)
      end
    end
    if localPlayerID == 0 then
      if not scoreBarSetup then
        setupScoreBar()
      elseif task.networkVars.checkpoints ~= 0 then
        local partnerLeadCP = partnerTaskObject.namedTasks.checkpoints.networkVars.checkpoints
        if partnerLeadCP < task.networkVars.checkpoints or task.networkVars.checkpoints == partnerLeadCP then
          leadCheckpoint = task.networkVars.checkpoints
        elseif partnerLeadCP > task.networkVars.checkpoints then
          leadCheckpoint = partnerLeadCP
        end
        if leadCheckpoint ~= lastCheckpoint then
          aproxRouteLength = workingVector:sub(task.agent.position, instance.challenge.spawnPositions[instance.networkVars.routeIndex].levelData[packageTO.namedTasks.level.networkVars.level].route[leadCheckpoint].position):length()
          lastCheckpoint = leadCheckpoint
        else
          tempScore = math.huge
          for localID, player in next, localPlayerManager.players, nil do
            if not player.inZap then
              workingScore = workingVector:sub(player.position, instance.challenge.spawnPositions[instance.networkVars.routeIndex].levelData[packageTO.namedTasks.level.networkVars.level].route[leadCheckpoint].position):length()
              if workingScore < tempScore then
                tempScore = workingScore
              end
            end
          end
          if tempScore ~= math.huge then
            workingScore = increments * (leadCheckpoint - 1) + increments * (1 - tempScore / aproxRouteLength) + packageTO.namedTasks.level.networkVars.level - 1
            if workingScore > previousScore then
              feedbackSystem.splitScreenSupport.updateScoringBar(0, workingScore, true)
            end
          end
        end
      end
    end
    updateChaserMarkers()
    updateDamagePrompt()
    stepInstructionPrompts()
  end
  local function cleanup(taskObject)
    for i = 1, 8 do
      chaserTO = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[i]]
      if chaserTO and chaserTO.coreData.agent and chaserTable[i] then
        removeChaserMarkers(i)
      end
    end
    if localPlayerID == 0 then
      if not scoreBarSetup then
        PauseMenu.allow(true)
        scoreBarSetup = true
      end
      if taskObject.coreData.instance.deleteFromPurge then
        feedbackSystem.splitScreenSupport.clearScoringBar(true)
      elseif packageTO.namedTasks.level.networkVars.level == instance.challenge.settings.maxLevel + 1 then
        feedbackSystem.splitScreenSupport.updateLevelCounterBarCoop(0, instance.challenge.settings.maxLevel, true)
        feedbackSystem.splitScreenSupport.updateScoringBar(0, instance.challenge.settings.maxLevel, true)
      end
    end
  end
  return update, nil, nil, cleanup
end)
