onlineSideBar.registerSideBar("MP checkpoint rush", function(instance)
  local playerScore = 0
  local packageTO = false
  local totalCheckpoints = false
  local playerRaceProg = 0
  local function initiate()
    totalCheckpoints = (#instance.challenge.spawnPositions[instance.networkVars.routeIndex].route - 1) * 0.9
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_game_title", "ID:247254")
    onlineSideBar.toggleSmallSidebarTitle(1)
  end
  local function getData(taskObject)
    if not packageTO then
      packageTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    end
    if taskObject.initiated and packageTO then
      playerScore = taskObject.namedTasks.checkpoints and 0
      playerRaceProg = math.ceil(playerScore / totalCheckpoints * 100)
      return taskObject.coreData.agent.name, playerRaceProg, playerScore, taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID
    else
      return taskObject.coreData.agent.name, 0, 0, taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID
    end
  end
  local function cleanup()
    packageTO = false
    onlineSideBar.toggleSidebarTimerFlash(0)
    onlineSideBar.toggleTimerSidebarTitle(0)
    onlineSideBar.toggleSmallSidebarTitle(0)
  end
  return initiate, getData, cleanup, onlineSideBar.standardSortFuncs.playerScoreSort, false, false, true
end)
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
  local taskObject = taskSystem.taskObjects[task.taskObjectID]
  local totalCheckpoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route - 1
  local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(taskObject.coreData.instance.instanceID, 1)
  local localTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  local playerTeamScore = 0
  local opponentTeamScore = 0
  local playerTargetMarker, playerMiniMapMarker
  local lastGlobalTarget = -1
  local localVehicleTaskObject = false
  local packageTaskObject = false
  local timeToJoinScoreSet = false
  local maxTime = task.instance.challenge.settings.modeTimeLimit
  local stringFormat = "%02d"
  local format = string.format
  local mod = math.mod
  local sub = string.sub
  onlineInstructionSupport.resetPrompts()
  local resetPrompts = true
  local previousPlayerScore = 0
  local workingVector = vec.vector()
  local checkpointPosition
  local displayTargetMarker = false
  local function updateTargetMarker()
    if localVehicleTaskObject.namedTasks.checkpoints and packageTaskObject.namedTasks.gateTracking then
      local globalTarget = packageTaskObject.namedTasks.gateTracking.networkVars.leadCheckPoint
      if globalTarget ~= lastGlobalTarget then
        checkpointPosition = localVehicleTaskObject.namedTasks.checkpoints.dynamicTargets[1].position
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
        playerMiniMapMarker = Marker:create(playerMiniMapMarker)
        lastGlobalTarget = globalTarget
      end
      if localPlayer.inZap or not GameVehicleResource.withinRadius(localPlayer.position, checkpointPosition, 300) then
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
        playerTargetMarker = Marker:create(playerTargetMarker)
      end
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
  local opponents = {}
  local scored = false
  local objectivePosition
  local function stepInstructionPrompts()
    if coopSystem.b_EnableSplitScreen == 0 then
      if resetPrompts then
        onlineInstructionSupport.setPrompts(true, true, false, false, true, true, true, true, true, true, false, true, false, true, "ID:234313", 20)
        onlineInstructionSupport.modifyPrompt("score", "button", iconsTable.checkpoint)
        onlineInstructionSupport.modifyPrompt("zap", "distance", 300)
        onlineInstructionSupport.modifyPrompt("zapUp", "distance", 300)
        resetPrompts = false
      end
      opponents = {}
      for playerID, player in next, playerManager.players, nil do
        if playerID ~= localPlayer.playerID and localTeam ~= PlayerGamePlay.getPlayerTeam(playerID) then
          table.insert(opponents, {
            vehicle = player.currentVehicle,
            position = player.position
          })
        end
      end
      if localVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpointsPassed ~= previousPlayerScore then
        scored = true
        previousPlayerScore = localVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpointsPassed
      else
        scored = false
      end
      objectivePosition = localPlayer.currentVehicle and spoolsystem.position
      if lastGlobalTarget and allCheckpoints then
        for i, checkpointData in ipairs(allCheckpoints) do
          if checkpointData.checkpointNum == lastGlobalTarget then
            objectivePosition = checkpointData.position
          end
        end
      end
      onlineInstructionSupport.step(objectivePosition, opponents, scored)
    end
  end
  local initialTSFeedback = true
  local playerTeamAhead = false
  local lastTeamUpdate = 0
  local topPlayerID = -1
  local topScore = 0
  local lastTopPlayerID = -1
  local playerTO = false
  local function update()
    updateModeTimer()
    if localVehicleTaskObject and packageTaskObject then
      stepInstructionPrompts()
      updateTargetMarker()
      if scored then
        OneShotSound.Play("HUD_Play_Checkpoint", false)
      end
      if localVehicleTaskObject.namedTasks.checkpoints and localVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpointsPassed then
        feedbackSystem.multiplayerSupport.updateBehindVehicleFeedback(localVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpointsPassed)
      end
      playerTO = false
      topScore = 0
      for i = 1, 8 do
        playerTO = task.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
        if playerTO and playerTO.namedTasks.checkpoints then
          if not timeToJoinScoreSet and playerTO.namedTasks.checkpoints.networkVars.checkpointsPassed > phaseManager.timeToJoinExceptionValues.checkpointRush then
            phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeException)
            timeToJoinScoreSet = true
          end
          if playerTO.namedTasks.checkpoints.networkVars.checkpointsPassed > topScore then
            topScore = playerTO.namedTasks.checkpoints.networkVars.checkpointsPassed
            topPlayerID = playerTO.coreData.agent.playerID
          end
        end
      end
      if topPlayerID ~= lastTopPlayerID then
        if topPlayerID == localPlayer.playerID then
          feedbackSystem.eventMessages.addMessage(1, localPlayer.name, "ID:243734", "", topPlayerID, false, false)
        else
          feedbackSystem.eventMessages.addMessage(1, playerManager.players[topPlayerID].name, "ID:243734", "", topPlayerID, false, false, false, topPlayerID ~= localPlayer.playerID)
        end
        lastTopPlayerID = topPlayerID
      end
    else
      localVehicleTaskObject = localPlayer:getTaskObject()
      packageTaskObject = task.instance.taskObjectsByActorID["Objective Team 1 member 1"]
    end
  end
  local function cleanup(taskObject)
    local fromPurge = taskObject.coreData.instance.deleteFromPurge
    feedbackSystem.multiplayerSupport.hideBehindVehicleFeedback()
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Bar", 0)
    if not fromPurge then
      for playerID, player in next, playerManager.players, nil do
        if playerID ~= localPlayer.playerID then
          feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.red32, OnlineModeSettings.red128)
        end
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
