feedbackSystem.registerHUD("MP Checkpoint Rush Start HUD", function(task, settings)
end, function(task)
  local update = function()
  end
  local cleanup = function()
  end
  return update, nil, nil, cleanup
end)
feedbackSystem.registerHUD("MP Checkpoint Rush HUD", function(task, settings)
end, function(task)
  local instance = task.instance
  local localPlayerID = task.agent.localID
  local playerTaskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[localPlayerID + 1]]
  local packageTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local numCheckpoints = instance.challenge.settings.scoreLimit
  local playerCurrentCheckpoint = playerTaskObject.namedTasks.checkpoints.networkVars.checkpointsPassed
  local playerPreviousCheckpoint = -1
  local checkpointIncreaseValue = 100 / numCheckpoints
  local opponents = {}
  local scored = false
  local objectivePosition = false
  local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(instance.instanceID, 1)
  local playerTargetMarker, playerMiniMapMarker
  local workingVector = vec.vector()
  local checkpointPosition, checkpointHeading
  local displayTargetMarker = false
  local globalTarget = false
  local lastGlobalTarget = false
  local timerDisplayed = false
  local scoreBarSetup = false
  local function updateTargetMarker()
    if taskSystem.validTaskObject(playerTaskObject) and taskSystem.validTaskObject(packageTaskObject) then
      globalTarget = packageTaskObject.namedTasks.gateTracking.networkVars.leadCheckPoint
      if globalTarget ~= lastGlobalTarget then
        checkpointPosition = playerTaskObject.namedTasks.checkpoints.dynamicTargets[1].position
        checkpointHeading = instance.challenge.spawnPositions[instance.networkVars.routeIndex].route[packageTaskObject.namedTasks.gateTracking.networkVars.leadCheckPoint].heading
        for i, checkpointData in ipairs(allCheckpoints) do
          if checkpointData.checkpointNum == globalTarget then
            checkpointPosition = checkpointData.position
          end
        end
        if playerTargetMarker then
          Marker:delete(playerTargetMarker)
          playerTargetMarker = false
        end
        if playerMiniMapMarker then
          Marker:delete(playerMiniMapMarker)
        end
        playerMiniMapMarker = OnlineModeSettings.createMiniMapMarker()
        playerMiniMapMarker.position = checkpointPosition
        playerMiniMapMarker.localID = localPlayerID
        playerMiniMapMarker = Marker:create(playerMiniMapMarker)
        lastGlobalTarget = globalTarget
        if not packageTaskObject.zapToActionSet then
          MPZapToAction.setZapToAction(3, checkpointPosition, checkpointHeading)
          packageTaskObject.zapToActionSet = true
        else
          MPZapToAction.updateZapToActionTarget(checkpointPosition, checkpointHeading)
        end
      end
      if task.agent.inZap or workingVector:sub(task.agent.position, checkpointPosition):length() > 300 then
        displayTargetMarker = true
      else
        displayTargetMarker = false
      end
      if not displayTargetMarker and playerTargetMarker then
        Marker:delete(playerTargetMarker)
        playerTargetMarker = false
      elseif displayTargetMarker and not playerTargetMarker and checkpointPosition then
        playerTargetMarker = OnlineModeSettings.createTargetMarker()
        playerTargetMarker.position = playerTargetMarker.position + checkpointPosition
        playerTargetMarker.localID = localPlayerID
        playerTargetMarker = Marker:create(playerTargetMarker)
      end
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
  onlineInstructionSupport.setPrompt("score", nil, nil, nil, "ID:248753", localPlayerID)
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
  local function setupScoreBar()
    if Menu.GetSceneStatus("Splitscreen", "ss_racemode_countdown") == 2 then
      feedbackSystem.splitScreenSupport.setupScoringBar(checkpointIncreaseValue)
      PauseMenu.allow(true)
      scoreBarSetup = true
    end
  end
  local function stepPlayerProgress()
    playerCurrentCheckpoint = playerTaskObject.namedTasks.checkpoints.networkVars.checkpointsPassed
    if playerCurrentCheckpoint ~= playerPreviousCheckpoint then
      objectivePosition = playerTaskObject.namedTasks.checkpoints.dynamicTargets[1].position
      scored = true
      if playerPreviousCheckpoint ~= -1 then
        OneShotSound.Play("HUD_Play_Checkpoint", false)
      end
      playerPreviousCheckpoint = playerCurrentCheckpoint
    end
  end
  local function update()
    if not scoreBarSetup and localPlayerID == 0 then
      setupScoreBar()
    end
    stepPlayerProgress()
    updateTargetMarker()
    stepInstructionPrompts()
  end
  local function cleanup(taskObject)
    if playerTaskObject.namedTasks.checkpoints.networkVars.checkpointsPassed ~= playerPreviousCheckpoint and playerPreviousCheckpoint ~= -1 then
      OneShotSound.Play("HUD_Play_Checkpoint", false)
    end
    if localPlayerID == 0 then
      if scoreBarSetup and taskObject.coreData.instance.deleteFromPurge then
        feedbackSystem.splitScreenSupport.clearScoringBar()
      elseif not scoreBarSetup then
        PauseMenu.allow(true)
        scoreBarSetup = true
      end
    end
    if playerTargetMarker then
      Marker:delete(playerTargetMarker)
    end
    if playerMiniMapMarker then
      Marker:delete(playerMiniMapMarker)
    end
  end
  return update, nil, nil, cleanup
end)
