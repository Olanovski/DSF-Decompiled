feedbackSystem.registerHUD("MP Pure Race Start HUD", function(task, settings)
end, function(task)
  feedbackSystem.menusMaster.blockDamageBar(localPlayerManager.players[0], true)
  feedbackSystem.menusMaster.blockDamageBar(localPlayerManager.players[1], true)
  local update = function()
  end
  local cleanup = function()
  end
  return update, nil, nil, cleanup
end)
feedbackSystem.registerHUD("MP Pure Race HUD", function(task, settings)
end, function(task)
  local instance = task.instance
  local localPlayerID = task.agent.localID
  local playerTaskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[localPlayerID + 1]]
  local playerVehicleTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[localPlayerID + 1]]
  local playerPreviousPos = false
  local playerCurrentPos = false
  local numCheckpoints = #checkpointSystem.getNoneSyncronisedCheckpoints(instance.instanceID, 1)
  local playerCurrentCheckpoint = playerVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpoints - 1 + playerVehicleTaskObject.namedTasks.checkpoints.networkVars.laps * numCheckpoints
  local playerPreviousCheckpoint = playerCurrentCheckpoint
  local checkpointIncreaseValue = 100 / (numCheckpoints / (instance.challenge.settings.totalLaps + 1))
  local opponents = {}
  local scored = false
  local objectivePosition = playerVehicleTaskObject.namedTasks.checkpoints.dynamicTargets[1].position
  local targetMarker = false
  local targetMarkerVisible = false
  local workingVector = vec.vector()
  local playerPosition = 1
  local previousPlayerPosition = 1
  local scoreBarSetup = false
  localPlayerManager.players[localPlayerID].missionSupport:addSubTaskObject(playerVehicleTaskObject, 1)
  playerCurrentPos = onlineRaceManager.getPlayerRank(playerTaskObject.coreData.agent.playerID)
  playerPreviousPos = playerCurrentPos
  local function stepPlayerPosition()
    playerCurrentPos = onlineRaceManager.getPlayerRank(playerTaskObject.coreData.agent.playerID)
    if playerCurrentPos ~= playerPreviousPos then
      feedbackSystem.splitScreenSupport.updateLevelCounterBarComp(localPlayerID, playerCurrentPos)
    end
    playerPreviousPos = playerCurrentPos
  end
  local function createMarker()
    if targetMarker then
      Marker:delete(targetMarker)
      targetMarker = nil
    end
    targetMarker = OnlineModeSettings.createTargetMarker()
    targetMarker.localID = localPlayerID
    targetMarker.position = targetMarker.position + objectivePosition
    targetMarker = Marker:create(targetMarker)
    if not GameVehicleResource.withinRadius(task.agent.position, objectivePosition, 200) then
      targetMarker.visible = true
      targetMarkerVisible = true
    else
      targetMarker.visible = false
      targetMarkerVisible = true
    end
  end
  createMarker()
  local function stepTargetMarker()
    if not GameVehicleResource.withinRadius(task.agent.position, objectivePosition, 200) then
      if not targetMarkerVisible then
        targetMarker.visible = true
        targetMarkerVisible = true
      end
    elseif targetMarkerVisible then
      targetMarker.visible = false
      targetMarkerVisible = false
    end
  end
  local function setupScoreBar()
    if Menu.GetSceneStatus("Splitscreen", "ss_racemode_countdown") == 2 then
      feedbackSystem.splitScreenSupport.setupScoringBar(checkpointIncreaseValue)
      PauseMenu.allow(true)
      scoreBarSetup = true
    end
  end
  local function stepPlayerProgress()
    playerCurrentCheckpoint = playerVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpoints - 1 + playerVehicleTaskObject.namedTasks.checkpoints.networkVars.laps * numCheckpoints
    if playerCurrentCheckpoint ~= playerPreviousCheckpoint then
      objectivePosition = playerVehicleTaskObject.namedTasks.checkpoints.dynamicTargets[1].position
      scored = true
      playerPreviousCheckpoint = playerCurrentCheckpoint
      createMarker()
    end
  end
  onlineInstructionSupport.resetPrompts(localPlayerID)
  onlineInstructionSupport.setPrompt("accelerate", nil, 3, nil, nil, localPlayerID)
  onlineInstructionSupport.setPrompt("score", true, 20, 45, "ID:234269", localPlayerID)
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
    if taskSystem.validTaskObject(playerVehicleTaskObject) and playerVehicleTaskObject.namedTasks.checkpoints.dynamicTargets then
      stepPlayerProgress()
      stepTargetMarker()
      stepInstructionPrompts()
      if localPlayerID == 0 then
        stepPlayerPosition()
        if not scoreBarSetup then
          setupScoreBar()
        end
      end
      if localPlayerID == 0 then
        playerPosition = onlineRaceManager.getPlayerRank(0)
        if previousPlayerPosition ~= playerPosition then
          previousPlayerPosition = playerPosition
        end
      end
    end
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
    if targetMarker then
      Marker:delete(targetMarker)
    end
  end
  return update, nil, nil, cleanup
end)
