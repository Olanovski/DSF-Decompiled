onlineSideBar.registerSideBar("MP rush down", function(instance)
  local initiate = function()
    onlineSideBar.toggleSmallSidebarTitle(1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_game_title", "ID:247257")
  end
  local maxScore = instance.challenge.settings.targetScore
  local playerScore = 0
  local playerScorePercent = 0
  local baseTaskObject = false
  local function getData(taskObject)
    if not baseTaskObject then
      baseTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    end
    if taskObject.initiated and baseTaskObject and taskObject.namedTasks.playerScore then
      playerScore = taskObject.namedTasks.playerScore.networkVars.playerAttackBase * taskObject.coreData.instance.challenge.settings.attackPointGain + taskObject.namedTasks.playerScore.networkVars.playerDefendBase * taskObject.coreData.instance.challenge.settings.defendPointGain
      if playerScore > maxScore then
        playerScore = maxScore
      end
      playerScorePercent = math.ceil(playerScore / maxScore * 100)
      return taskObject.coreData.agent.name, playerScorePercent, playerScore, taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID
    else
      return taskObject.coreData.agent.name, 0, 0, taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID
    end
  end
  local localTeamScore = 0
  local oppTeamScore = 0
  local function teamData()
    if baseTaskObject and baseTaskObject.namedTasks.score then
      if playerManager.getPlayerTeam(localPlayer.playerID) == instance.networkVars.roundOn then
        localTeamScore = baseTaskObject and 0
        oppTeamScore = baseTaskObject and 0
      else
        localTeamScore = baseTaskObject and 0
        oppTeamScore = baseTaskObject and 0
      end
      return localTeamScore, maxScore, localTeamScore / maxScore * 100, oppTeamScore, maxScore, oppTeamScore / maxScore * 100
    else
      return 0, maxScore, 0, 0, maxScore, 0
    end
  end
  local function cleanup()
    baseTaskObject = false
    onlineSideBar.toggleSidebarTimerFlash(0)
    onlineSideBar.toggleTimerSidebarTitle(0)
    onlineSideBar.toggleSmallSidebarTitle(0)
  end
  return initiate, getData, cleanup, onlineSideBar.standardSortFuncs.playerScoreSort, true, false, true, teamData
end)
feedbackSystem.registerHUD("MP Rush Down Start HUD", function(task, settings)
end, function(task)
  local instance = localPlayer.getTaskObject().coreData.instance
  local playerTeam = playerManager.getPlayerTeam(localPlayer.playerID)
  OneShotSound.Play("HUD_Online_RoundSet")
  feedbackSystem.menusMaster.primaryTextPrompt("ID:221693", instance.networkVars.roundOn)
  if playerTeam == instance.networkVars.roundOn then
    feedbackSystem.menusMaster.secondaryTextPrompt("ID:169340")
  else
    feedbackSystem.menusMaster.secondaryTextPrompt("ID:169341")
  end
  local update = function()
  end
  local cleanup = function()
  end
  return update, nil, nil, cleanup
end)
feedbackSystem.registerHUD("MP Rush Down HUD", function(task, settings)
end, function(task)
  local localTeam = playerManager.getPlayerTeam(localPlayer.playerID)
  local instance = task.instance
  local playerTaskObject = taskSystem.taskObjects[task.taskObjectID]
  local baseTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local basePosition = instance.challenge.spawnPositions[instance.networkVars.routeIndex].target
  local baseTargetRadius = instance.challenge.spawnPositions[instance.networkVars.routeIndex].targetRadius or 10
  local shieldLevel = -1
  local shieldRadius = 0
  local baseRadius = instance.challenge.settings.baseRadius
  local maxScore = task.instance.challenge.settings.targetScore
  local maxTime = task.instance.challenge.settings.modeTimeLimit
  local firstPlayDone = false
  local timeToScoreSet = false
  local attackScore = 0
  local defenceScore = 0
  local localPlayerScored = false
  local playerScoreTable = {
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,
    [6] = false,
    [7] = false,
    [8] = false
  }
  local stringFormat = "%02d"
  local format = string.format
  local mod = math.mod
  local sub = string.sub
  onlineInstructionSupport.resetPrompts()
  local createPrompts = true
  local resetPrompts = true
  local previousPlayerScore = 0
  local baseMarkerCreated = false
  local baseColour32, baseColour128, minimapColour32, targetColour32
  if localTeam == instance.networkVars.roundOn then
    baseColour32 = OnlineModeSettings.red32
    targetColour32 = OnlineModeSettings.red32 + OnlineModeSettings.targetAlphaMask32
    minimapColour32 = OnlineModeSettings.red32
    baseColour128 = OnlineModeSettings.red128
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_scoring_context", "ID:169340")
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 4)
  else
    baseColour32 = OnlineModeSettings.blue32
    targetColour32 = OnlineModeSettings.blue32 + OnlineModeSettings.targetAlphaMask32
    minimapColour32 = OnlineModeSettings.blue32
    baseColour128 = OnlineModeSettings.blue128
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_scoring_context", "ID:169341")
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 4)
  end
  local baseTargetMarker = Marker:create({
    type = "Target",
    gadgetID = 51,
    colour = targetColour32,
    radius = 50,
    visible = true,
    position = basePosition + OnlineModeSettings.basetargetOffset,
    showDistance = true,
    longDistanceTarget = true,
    targetType = "Destination",
    sortBias = 5
  })
  local baseMiniMapMarker = Marker:create({
    type = "Minimap",
    gadgetID = 51,
    colour = minimapColour32,
    radius = 30,
    visible = true,
    position = basePosition,
    canrotate = false
  })
  local baseWorldMarker = Marker:create({
    type = "World",
    position = basePosition,
    gadgetID = 50,
    facing = true,
    offset = vec.vector(0, 5, 0, 0),
    scale = vec.vector(1, 1, 1, 1),
    colour = baseColour32,
    sortBias = 2
  })
  local baseCylinder = Marker:create({
    type = "World",
    facing = false,
    gadgetID = 245,
    scale = vec.vector(baseTargetRadius * 2, 6, baseTargetRadius * 2, 0),
    offset = vec.vector(0, 0, 0, 0),
    visible = true,
    colour = baseColour32 - vec.vector(0, 0, 0, 160),
    position = basePosition,
    gameVehicle = nil,
    introType = "Fade",
    outroType = "Fade",
    sortBias = 3
  })
  local baseCylinderStripes = Marker:create({
    type = "World",
    facing = false,
    gadgetID = 246,
    scale = vec.vector(baseTargetRadius * 2 + 1, 10, baseTargetRadius * 2 + 1, 0),
    offset = vec.vector(0, 5, 0, 0),
    visible = true,
    colour = baseColour32,
    position = basePosition,
    gameVehicle = nil,
    introType = "Fade",
    outroType = "Fade",
    sortBias = 3
  })
  if localTeam == instance.networkVars.roundOn then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:169333")
  else
    feedbackSystem.menusMaster.primaryTextPrompt("ID:169334")
  end
  local workingVector = vec.vector()
  local currentZapLock = false
  local prevZapLock = false
  local moodFiredOnce = false
  local moodApplied = false
  local inTheZone = false
  local moodName = ""
  if localTeam == instance.networkVars.roundOn then
    moodName = "OnlineRushdownRed"
  else
    moodName = "OnlineRushdownBlue"
  end
  local function updateMoods()
    if localTeam == instance.networkVars.roundOn then
      currentZapLock = playerTaskObject.namedTasks.playerZapLock.networkVars.playerZapLocked or playerTaskObject.namedTasks.playerZapLock and false
      if prevZapLock ~= currentZapLock then
        if currentZapLock then
          if not localPlayer.inZap then
            OneShotSound.Play("HUD_Online_RD_Player_ControlZonePass")
          end
          moodApplied = true
          moodSystem.applyMood(moodName, 0.2)
          CityLockManager.SetDrawTextureWhilstDriving(false)
        elseif moodApplied then
          if not localPlayer.inZap then
            OneShotSound.Play("HUD_Online_RD_Player_ControlZonePass")
          end
          moodSystem.removeMood(moodName)
          moodApplied = false
          CityLockManager.SetDrawTextureWhilstDriving(true)
        end
        prevZapLock = currentZapLock
      elseif not moodFiredOnce then
        CityLockManager.SetDrawTextureWhilstDriving(true)
        moodFiredOnce = true
      end
    else
      if baseTaskObject.namedTasks.score and shieldLevel ~= baseTaskObject.namedTasks.score.networkVars.attackScore then
        shieldLevel = baseTaskObject.namedTasks.score.networkVars.attackScore
        shieldRadius = baseRadius * math.sqrt((maxScore - shieldLevel) / maxScore)
      end
      if localPlayer.currentVehicle then
        inTheZone = GameVehicleResource.withinRadius(localPlayer.currentVehicle.position, basePosition, shieldRadius)
      else
        inTheZone = GameVehicleResource.withinRadius(spoolsystem.position, basePosition, shieldRadius)
      end
      if inTheZone and not localPlayer.inZap or zap.zapAttack.isZapAttackActive() then
        CityLockManager.SetDrawTextureWhilstDriving(false)
      else
        CityLockManager.SetDrawTextureWhilstDriving(true)
      end
      if not moodApplied then
        if inTheZone then
          if firstPlayDone then
            if not localPlayer.inZap then
              OneShotSound.Play("HUD_Online_RD_Player_ControlZonePass")
            end
          else
            firstPlayDone = true
          end
          moodApplied = true
          moodSystem.applyMood(moodName, 0.2)
        end
      elseif not inTheZone then
        if not localPlayer.inZap then
          OneShotSound.Play("HUD_Online_RD_Player_ControlZonePass")
        end
        moodApplied = false
        moodSystem.removeMood(moodName)
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
  local taskObject = false
  local playerScore = 0
  local playerName = ""
  local function updatePlayerScores()
    for i = 1, 8 do
      taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
      if taskObject then
        playerName = taskObject.coreData.agent.name
        if taskObject.namedTasks.playerScore then
          playerScore = taskObject.namedTasks.playerScore.networkVars.playerAttackBase * taskObject.coreData.instance.challenge.settings.attackPointGain + taskObject.namedTasks.playerScore.networkVars.playerDefendBase * taskObject.coreData.instance.challenge.settings.defendPointGain
        else
          playerScore = 0
        end
        if playerScoreTable[i] then
          if playerScoreTable[i] ~= playerScore then
            if taskObject.coreData.agent.isLocal then
              localPlayerScored = true
              feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_scoring_text_number", "+" .. tostring(playerScore - playerScoreTable[i]))
              feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 5)
              feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring", 2)
            end
            if playerManager.getPlayerTeam(taskObject.coreData.agent.playerID) == instance.networkVars.roundOn then
              feedbackSystem.eventMessages.addMessage(1, playerName, "ID:186764", "", taskObject.coreData.agent.playerID, false, false, false, playerManager.getPlayerTeam(taskObject.coreData.agent.playerID) ~= localTeam)
            else
              feedbackSystem.eventMessages.addMessage(1, playerName, "ID:186765", "", taskObject.coreData.agent.playerID, false, false, false, playerManager.getPlayerTeam(taskObject.coreData.agent.playerID) ~= localTeam)
            end
            playerScoreTable[i] = playerScore
          end
        else
          playerScoreTable[i] = playerScore
        end
      else
        playerScoreTable[i] = false
      end
    end
  end
  local function displayScorePrompts()
    if baseTaskObject.namedTasks.score then
      if localPlayerScored then
        if localTeam == instance.networkVars.roundOn and baseTaskObject.namedTasks.score.networkVars.attackScore > attackScore then
          OneShotSound.Play("MP_Player_Positive", false)
          feedbackSystem.menusMaster.primaryTextPrompt("ID:243721")
          attackScore = baseTaskObject.namedTasks.score.networkVars.attackScore
          localPlayerScored = false
        elseif baseTaskObject.namedTasks.score.networkVars.defenceScore > defenceScore then
          OneShotSound.Play("MP_Player_Positive", false)
          feedbackSystem.menusMaster.primaryTextPrompt("ID:243722")
          defenceScore = baseTaskObject.namedTasks.score.networkVars.defenceScore
          localPlayerScored = false
        end
      elseif baseTaskObject.namedTasks.score.networkVars.attackScore > attackScore then
        if localTeam == instance.networkVars.roundOn then
          OneShotSound.Play("MP_Player_Positive", false)
          feedbackSystem.menusMaster.primaryTextPrompt("ID:169335")
        else
          OneShotSound.Play("MP_Player_Negative", false)
          feedbackSystem.menusMaster.primaryTextPrompt("ID:169335", false, false, false, false, false, false, false, false, true)
        end
        attackScore = baseTaskObject.namedTasks.score.networkVars.attackScore
      elseif baseTaskObject.namedTasks.score.networkVars.defenceScore > defenceScore then
        if localTeam == instance.networkVars.roundOn then
          OneShotSound.Play("MP_Player_Negative", false)
        else
          OneShotSound.Play("MP_Player_Positive", false)
        end
        defenceScore = baseTaskObject.namedTasks.score.networkVars.defenceScore
      end
    end
    if not timeToScoreSet and instance.networkVars.roundOn == 2 then
      local defPercentage = defenceScore / instance.challenge.settings.targetScore
      local attPercentage = attackScore / instance.challenge.settings.targetScore
      if defPercentage >= phaseManager.timeToJoinExceptionValues.rushdown or attPercentage >= phaseManager.timeToJoinExceptionValues.rushdown then
        phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeException)
        timeToScoreSet = true
      end
    end
  end
  local isAttack = localTeam == instance.networkVars.roundOn
  local opponents = {}
  local scored = false
  local function stepInstructionPrompts()
    if createPrompts then
      onlineInstructionSupport.addPrompt("findVehicle", {
        enabled = false,
        shown = false,
        resetTime = 60,
        displayFunction = function(self, objectivePos, opponents)
          if localPlayer.inZap then
            onlineInstructionSupport.displayPrompt("ID:234270", iconsTable.multiShieldRed)
            return true
          end
        end
      })
      onlineInstructionSupport.modifyPrompt("zap", "message", "ID:234271")
      onlineInstructionSupport.modifyPrompt("zap", "button", iconsTable.multiShieldBlue)
      onlineInstructionSupport.modifyPrompt("zap", "distance", 400)
      createPrompts = false
    end
    if resetPrompts then
      onlineInstructionSupport.setPrompts(isAttack, true, isAttack, not isAttack, not isAttack, not isAttack, not isAttack, not isAttack, not isAttack, isAttack, false, not isAttack, false, not isAttack)
      if isAttack then
        onlineInstructionSupport.setPrompt("findVehicle")
        onlineInstructionSupport.setPrompt("score", true, 5, 40, "ID:234272")
        onlineInstructionSupport.modifyPrompt("score", "button", iconsTable.multiShieldRed)
      else
        onlineInstructionSupport.setPrompt("score", true, 5, 30, "ID:234273")
      end
      resetPrompts = false
    end
    opponents = {}
    for playerID, player in next, playerManager.players, nil do
      if playerID ~= localPlayer.playerID and playerManager.getPlayerTeam(playerID) ~= localTeam then
        table.insert(opponents, {
          vehicle = player.currentVehicle,
          position = player.position
        })
      end
    end
    scored = false
    if baseTaskObject.namedTasks.score then
      if isAttack then
        if baseTaskObject.namedTasks.score.networkVars.attackScore ~= previousPlayerScore then
          scored = true
          previousPlayerScore = baseTaskObject.namedTasks.score.networkVars.attackScore
        end
      elseif baseTaskObject.namedTasks.score.networkVars.defenceScore ~= previousPlayerScore then
        scored = true
        previousPlayerScore = baseTaskObject.namedTasks.score.networkVars.defenceScore
      end
    end
    onlineInstructionSupport.step(basePosition, opponents, scored)
  end
  local function update()
    updateMoods()
    updateModeTimer()
    updatePlayerScores()
    displayScorePrompts()
    stepInstructionPrompts()
    if not baseMarkerCreated and spoolsystem.IsLocationResident(basePosition) then
      TerrainMarker.Update(0, basePosition, baseColour128, baseTargetRadius + baseTargetRadius)
      baseMarkerCreated = true
    end
  end
  local function cleanup(taskObject)
    local fromPurge = taskObject.coreData.instance.deleteFromPurge
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 0)
    CityLockManager.SetDrawTextureWhilstDriving(false)
    if fromPurge then
      Marker:delete(baseWorldMarker)
      if baseCylinder then
        Marker:delete(baseCylinder)
        baseCylinder = false
      end
      if baseCylinderStripes then
        Marker:delete(baseCylinderStripes)
        baseCylinderStripes = false
      end
      if baseMarkerCreated then
        TerrainMarker.Delete(0)
      end
      if moodApplied then
        moodSystem.removeMood(moodName)
        moodApplied = false
      end
    else
      for playerID, player in next, playerManager.players, nil do
        if PlayerGamePlay.getPlayerTeam(playerID) == localTeam then
          if playerID ~= localPlayer.playerID then
            feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.blue32, OnlineModeSettings.blue128)
          end
        else
          feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.red32, OnlineModeSettings.red128)
        end
      end
      if moodApplied then
        moodApplied = false
        feedbackSystem.multiplayerSupport.addWorldMarker("mood", moodName)
      end
      if baseMarkerCreated then
        feedbackSystem.multiplayerSupport.addWorldMarker("terrain", 0)
      end
      if baseWorldMarker then
        feedbackSystem.multiplayerSupport.addWorldMarker("world", baseWorldMarker)
      end
      if baseCylinder then
        feedbackSystem.multiplayerSupport.addWorldMarker("world", baseCylinder)
      end
      if baseCylinderStripes then
        feedbackSystem.multiplayerSupport.addWorldMarker("world", baseCylinderStripes)
      end
      feedbackSystem.multiplayerSupport.addWorldMarker("shieldZone", 0)
    end
    Marker:delete(baseTargetMarker)
    Marker:delete(baseMiniMapMarker)
  end
  return update, nil, nil, cleanup
end)
