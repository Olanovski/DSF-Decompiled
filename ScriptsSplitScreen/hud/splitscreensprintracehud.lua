feedbackSystem.registerHUD("MP Sprint Race Start HUD", function(task, settings)
end, function(instance)
  OneShotSound.Play("HUD_Online_RoundSet")
  if instance.networkVars.roundOn < instance.challenge.settings.numRounds then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:220240", instance.networkVars.roundOn)
  elseif instance.networkVars.roundOn == instance.challenge.settings.numRounds then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:169345")
  end
  feedbackSystem.menusMaster.blockDamageBar(localPlayerManager.players[0], true)
  feedbackSystem.menusMaster.blockDamageBar(localPlayerManager.players[1], true)
  local cleanup = function()
  end
  return nil, nil, nil, cleanup
end)
feedbackSystem.registerHUD("MP Sprint Race HUD", function(task, settings)
end, function(task)
  local instance = task.instance
  local localPlayerID = task.agent.localID
  local playerTaskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[localPlayerID + 1]]
  local playerVehicleTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[localPlayerID + 1]]
  local playerPreviousPos = false
  local playerCurrentPos = false
  local numCheckpoints = 10
  local playerCurrentCheckpoint = playerVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpoints - 1 + playerVehicleTaskObject.namedTasks.checkpoints.networkVars.laps * numCheckpoints
  local playerPreviousCheckpoint = playerCurrentCheckpoint
  local checkpointIncreaseValue = 100 / numCheckpoints
  local opponents = {}
  local scored = false
  local objectivePosition = false
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
  local function setupScoreBar()
    if Menu.GetSceneStatus("Splitscreen", "ss_racemode_countdown") == 2 then
      feedbackSystem.splitScreenSupport.setupScoringBar(checkpointIncreaseValue)
      feedbackSystem.splitScreenSupport.showRoundsDisplay()
      for i = 1, task.instance.playerScores[1] do
        feedbackSystem.splitScreenSupport.setRoundWinMarker(0, i, 1)
      end
      for i = 1, task.instance.playerScores[2] do
        feedbackSystem.splitScreenSupport.setRoundWinMarker(1, i, 1)
      end
      PauseMenu.allow(true)
      scoreBarSetup = true
    end
  end
  local function stepPlayerProgress()
    playerCurrentCheckpoint = playerVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpoints - 1 + playerVehicleTaskObject.namedTasks.checkpoints.networkVars.laps * numCheckpoints
    if playerCurrentCheckpoint ~= playerPreviousCheckpoint and playerVehicleTaskObject.namedTasks.checkpoints and playerVehicleTaskObject.namedTasks.checkpoints.dynamicTargets then
      objectivePosition = playerVehicleTaskObject.namedTasks.checkpoints.dynamicTargets[1].position
      scored = true
      playerPreviousCheckpoint = playerCurrentCheckpoint
    end
  end
  onlineInstructionSupport.resetPrompts(localPlayerID)
  onlineInstructionSupport.setPrompt("accelerate", nil, 3, nil, nil, localPlayerID)
  onlineInstructionSupport.setPrompt("score", nil, nil, nil, "ID:234269", localPlayerID)
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
    if localPlayerID == 0 then
      stepPlayerPosition()
      if not scoreBarSetup then
        setupScoreBar()
      end
    end
    stepPlayerProgress()
    stepInstructionPrompts()
    if localPlayerID == 0 then
      playerPosition = onlineRaceManager.getPlayerRank(0)
      if previousPlayerPosition ~= playerPosition then
        previousPlayerPosition = playerPosition
      end
    end
  end
  local function cleanup(taskObject)
    if localPlayerID == 0 then
      if scoreBarSetup and taskObject.coreData.instance.deleteFromPurge then
        feedbackSystem.splitScreenSupport.clearRoundWinMarkers()
        feedbackSystem.splitScreenSupport.clearScoringBar()
      elseif not scoreBarSetup then
        PauseMenu.allow(true)
        scoreBarSetup = true
      end
    end
  end
  return update, nil, nil, cleanup
end)
