onlineSideBar.registerSideBar("MP team circuit race", function(instance)
  local playerScore = 0
  local packageTO = false
  local totalCheckpoints = false
  local playerRaceProg = 0
  local function initiate()
    totalCheckpoints = (#instance.challenge.spawnPositions[instance.networkVars.routeIndex].route - 1) * 0.9
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_game_title", "ID:247261")
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
  local function teamData()
    if packageTO and packageTO.namedTasks.gateTracking then
      if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
        return packageTO.namedTasks.gateTracking.networkVars.blueTeamScore, false, packageTO.namedTasks.gateTracking.networkVars.blueTeamScore / (totalCheckpoints * 4) * 100, packageTO.namedTasks.gateTracking.networkVars.redTeamScore, false, packageTO.namedTasks.gateTracking.networkVars.redTeamScore / (totalCheckpoints * 4) * 100
      else
        return packageTO.namedTasks.gateTracking.networkVars.redTeamScore, false, packageTO.namedTasks.gateTracking.networkVars.redTeamScore / (totalCheckpoints * 4) * 100, packageTO.namedTasks.gateTracking.networkVars.blueTeamScore, false, packageTO.namedTasks.gateTracking.networkVars.blueTeamScore / (totalCheckpoints * 4) * 100
      end
    else
      return 0, false, 0, 0, false, 0
    end
  end
  local function cleanup()
    packageTO = false
    onlineSideBar.toggleSidebarTimerFlash(0)
    onlineSideBar.toggleTimerSidebarTitle(0)
    onlineSideBar.toggleSmallSidebarTitle(0)
  end
  return initiate, getData, cleanup, onlineSideBar.standardSortFuncs.playerScoreSort, true, false, true, teamData
end)
feedbackSystem.registerHUD("MP Team Circuit Race Start HUD", function(task, settings)
end, function(task)
  local update = function()
  end
  local cleanup = function()
  end
  return update, nil, nil, cleanup
end)
feedbackSystem.registerHUD("MP Team Circuit Race HUD", function(task, settings)
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
  local topPlayer = 0
  local topScore = 0
  local topTaskObject = false
  local timeToScoreSet = false
  local function update()
    updateModeTimer()
    if localVehicleTaskObject and packageTaskObject and packageTaskObject.namedTasks and packageTaskObject.namedTasks.gateTracking then
      stepInstructionPrompts()
      updateTargetMarker()
      if scored then
        OneShotSound.Play("HUD_Play_Checkpoint", false)
      end
      if localVehicleTaskObject.namedTasks.checkpoints and localVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpointsPassed then
        feedbackSystem.multiplayerSupport.updateBehindVehicleFeedback(localVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpointsPassed)
      end
      if localTeam == 1 then
        playerTeamScore = packageTaskObject.namedTasks.gateTracking.networkVars.blueTeamScore
        opponentTeamScore = packageTaskObject.namedTasks.gateTracking.networkVars.redTeamScore
      else
        playerTeamScore = packageTaskObject.namedTasks.gateTracking.networkVars.redTeamScore
        opponentTeamScore = packageTaskObject.namedTasks.gateTracking.networkVars.blueTeamScore
      end
      if not timeToScoreSet and (playerTeamScore > phaseManager.timeToJoinExceptionValues.teamRush or opponentTeamScore > phaseManager.timeToJoinExceptionValues.teamRush) then
        phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeException)
        timeToScoreSet = true
      end
      if playerTeamScore > opponentTeamScore and (initialTSFeedback or not playerTeamAhead and g_NetworkTime - lastTeamUpdate > 2) then
        feedbackSystem.eventMessages.addMessage(1, "ID:168515", "ID:243730", "", localPlayer.playerID, false, false)
        playerTeamAhead = true
        initialTSFeedback = false
        lastTeamUpdate = g_NetworkTime
      elseif playerTeamScore < opponentTeamScore and (initialTSFeedback or playerTeamAhead and g_NetworkTime - lastTeamUpdate > 2) then
        for playerID, player in next, playerManager.players, nil do
          if PlayerGamePlay.getPlayerTeam(playerID) ~= localTeam then
            topTaskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[playerID + 1]]
            if topTaskObject and topTaskObject.namedTasks.checkpoints and topTaskObject.namedTasks.checkpoints.networkVars.checkpointsPassed > topScore then
              topScore = topTaskObject.namedTasks.checkpoints.networkVars.checkpointsPassed
              topPlayer = playerID
            end
          end
        end
        feedbackSystem.eventMessages.addMessage(1, "ID:168516", "ID:243730", "", topPlayer, false, false, false, true)
        playerTeamAhead = false
        initialTSFeedback = false
        lastTeamUpdate = g_NetworkTime
      end
    else
      localVehicleTaskObject = localPlayer:getTaskObject()
      packageTaskObject = task.instance.taskObjectsByActorID["Objective Team 1 member 1"]
    end
  end
  local function cleanup(taskObject)
    local fromPurge = taskObject.coreData.instance.deleteFromPurge
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
    feedbackSystem.multiplayerSupport.hideBehindVehicleFeedback()
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Bar", 0)
    if playerTargetMarker then
      Marker:delete(playerTargetMarker)
    end
    if playerMiniMapMarker then
      Marker:delete(playerMiniMapMarker)
    end
  end
  return update, nil, nil, cleanup
end)
