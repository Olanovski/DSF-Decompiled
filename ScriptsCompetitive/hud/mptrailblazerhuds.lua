onlineSideBar.registerSideBar("MP trail blazer", function(instance)
  local initiate = function()
    onlineSideBar.toggleSmallSidebarTitle(1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_game_title", "ID:247262")
  end
  local maxScore = instance.challenge.settings.targetScore
  local playerScore = 0
  local function getData(taskObject)
    if taskObject.initiated then
      playerScore = taskObject.namedTasks.score and 0
      if playerScore > maxScore then
        playerScore = maxScore
      end
      return taskObject.coreData.agent.name, math.ceil(playerScore / maxScore * 100), playerScore, taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID
    else
      return taskObject.coreData.agent.name, 0, 0, taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID
    end
  end
  local cleanup = function()
    onlineSideBar.toggleSidebarTimerFlash(0)
    onlineSideBar.toggleTimerSidebarTitle(0)
    onlineSideBar.toggleSmallSidebarTitle(0)
  end
  return initiate, getData, cleanup, onlineSideBar.standardSortFuncs.playerScoreSort, false, false, true
end)
feedbackSystem.registerHUD("MP Trail Blazer Start HUD", function(task, settings)
end, function(task)
  local instance = localPlayer.getTaskObject().coreData.instance
  local markerSettings = {
    Target = {
      type = "Target",
      targetType = "MultiplayerObjective",
      colour = OnlineModeSettings.yellow32 + OnlineModeSettings.targetAlphaMask32,
      gadgetID = 178,
      radius = 45,
      visible = true,
      markerOffset = 1
    },
    MinimapArrow = {
      type = "Minimap",
      radius = 40,
      visible = true,
      canrotate = true,
      colour = OnlineModeSettings.yellow32,
      gadgetID = 257,
      nofade = true
    },
    Minimap = {
      type = "Minimap",
      radius = 40,
      visible = true,
      canrotate = false,
      colour = OnlineModeSettings.yellow32,
      gadgetID = 255,
      nofade = true
    }
  }
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    local vehicle = taskObject.coreData.agent
    if vehicle.SNVID and not vehicle.colourSet then
      vehicle:disableDisplay(false)
      vehicle:setDisplayColour(OnlineModeSettings.teamYellow, OnlineModeSettings.yellow128)
    end
  end
  local function setMainMarker(vehicle)
    vehicle:disableMinimapMarker(true)
    mainMarker = true
    vehicle.markers = vehicle.markers or {}
    for k, v in next, vehicle.markers, nil do
      Marker:delete(v)
      vehicle.markers[k] = nil
    end
    for k, v in next, markerSettings, nil do
      v.gameVehicle = vehicle.gameVehicle
      if v.type == "World" then
        v.offset = vec.vector(0, vehicle.gameVehicle.height + 1, 0, 0)
      end
      vehicle.markers[k] = Marker:create(v)
    end
  end
  local clearMainMarker = function(vehicle)
    vehicle:disableMinimapMarker(false)
    mainMarker = false
    if vehicle.markers then
      for k, v in next, vehicle.markers, nil do
        Marker:delete(v)
        vehicle.markers[k] = nil
      end
    end
  end
  local trailBlazerTO = instance.taskObjectsByActorID["Objective Team 1 member 1"]
  local function drawMarkers()
    if trailBlazerTO then
      local vehicle = trailBlazerTO.coreData.agent
      if not vehicle.colourSet then
        vehicle:disableDisplay(false)
        vehicle:setDisplayColour(OnlineModeSettings.teamYellow, OnlineModeSettings.yellow128)
      end
    end
  end
  local function update()
    if localPlayer.currentVehicle and not mainMarker then
      drawMarkers()
      setMainMarker(trailBlazerTO.coreData.agent)
    end
  end
  local function cleanupCallback()
    if trailBlazerTO and trailBlazerTO.coreData then
      local vehicle = trailBlazerTO.coreData.agent
      if vehicle and vehicleManager.vehiclesBySNVID[vehicle.SNVID] then
        vehicle:deleteDisplay()
        vehicle:removeLightTrail()
        clearMainMarker(vehicle)
      end
    end
  end
  phaseManager.startHUDCleanupFunction = cleanupCallback
  return update, nil, nil, nil
end)
feedbackSystem.registerHUD("MP Trail Blazer HUD", function(task, settings)
end, function(task)
  if phaseManager.startHUDCleanupFunction then
    phaseManager.startHUDCleanupFunction()
    phaseManager.startHUDCleanupFunction = false
  end
  local instance = task.instance
  local blazingVehicle = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent
  local maxScore = instance.challenge.settings.targetScore
  local stringFormat = "%02d"
  local format = string.format
  local mod = math.mod
  local sub = string.sub
  local maxTime = instance.challenge.settings.modeTimeLimit
  local matchTime = {startTime = maxTime, reset = false}
  local timeToJoinSet = false
  for localID, player in next, localPlayerManager.players, nil do
    onlineInstructionSupport.resetPrompts(localID)
  end
  local resetPrompts = true
  local localPlayerTaskObject = localPlayer.getTaskObject()
  local previousPlayerScore = 0
  feedbackSystem.menusMaster.primaryTextPrompt("ID:169360")
  OneShotSound.Play("HUD_Online_TOW_ObjectiveSpawned_OneShot")
  blazingVehicle:addLightTrail(2, OnlineModeSettings.yellow128, 2, true)
  local blazingVehicleTargetMarker = Marker:create({
    type = "Target",
    targetType = "MultiplayerObjective",
    gameVehicle = blazingVehicle.gameVehicle,
    gadgetID = 178,
    colour = OnlineModeSettings.yellow32 + OnlineModeSettings.targetAlphaMask32,
    radius = 45,
    visible = true,
    showDistance = true,
    markerOffset = 1
  })
  blazingVehicle:disableMinimapMarker(true)
  local blazingVehicleMinimapArrow = Marker:create({
    type = "Minimap",
    gadgetID = 257,
    radius = 40,
    colour = OnlineModeSettings.yellow32,
    visible = true,
    canrotate = true,
    gameVehicle = blazingVehicle.gameVehicle,
    nofade = true
  })
  local blazingVehicleMinimapMarker = Marker:create({
    type = "Minimap",
    gadgetID = 255,
    radius = 40,
    colour = OnlineModeSettings.yellow32,
    visible = true,
    canrotate = false,
    gameVehicle = blazingVehicle.gameVehicle,
    nofade = true
  })
  local winningFeedback = {
    [0] = false,
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,
    [6] = false,
    [7] = false
  }
  local function updateWiningPrompt()
    local taskObject = false
    local playerScore = false
    for i = 1, 8 do
      taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
      if taskObject then
        playerScore = taskObject.namedTasks.score and taskObject.namedTasks.score.networkVars.payload or 0
        if playerScore > maxScore then
          playerScore = maxScore
        end
        if taskObject.coreData.agent.isLocal then
          feedbackSystem.multiplayerSupport.updateBehindVehicleFeedback(playerScore, 1, true, 90)
        end
        if playerScore / maxScore >= 0.9 and not winningFeedback[taskObject.coreData.agent.playerID] then
          if taskObject.coreData.agent.isLocal then
            feedbackSystem.menusMaster.primaryTextPrompt("ID:242108")
          else
            feedbackSystem.menusMaster.primaryTextPrompt("ID:220264", tostring(taskObject.coreData.agent.name), false, false, false, false, false, false, false, true)
            feedbackSystem.eventMessages.addMessage(1, taskObject.coreData.agent.name, "ID:243728", "", taskObject.coreData.agent.playerID, false, false, false, true)
          end
          winningFeedback[taskObject.coreData.agent.playerID] = true
        elseif playerScore / maxScore < 0.9 and winningFeedback[taskObject.coreData.agent.playerID] then
          winningFeedback[taskObject.coreData.agent.playerID] = false
        end
        if not timeToJoinSet and playerScore / maxScore >= phaseManager.timeToJoinExceptionValues.trailblazer then
          phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeException)
          timeToJoinSet = true
        end
      end
    end
  end
  local timerOn = false
  local lowTimeMessage = true
  local lowTimeFlash = true
  local timeRemaining = maxTime
  local prevSeconds = false
  local function drawTimer()
    timeRemaining = maxTime - instance:getTime()
    if not timerOn and timeRemaining <= 60 then
      onlineSideBar.toggleTimerSidebarTitle(1)
      feedbackSystem.menusMaster.primaryTextPrompt("ID:231383", false, false, false, false, false, false, false, false, true)
      timerOn = true
      if not timeToJoinSet then
        phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeOneMinRemain)
        timeToJoinSet = true
      end
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
  local previousLeftFlash = 0
  local previousRightFlash = 0
  local prevScore = 0
  local timeInBlaze = 0
  local lastTimeInBlaze = 0
  local roundedTimeInBlaze = 0
  local function drawFlashColours()
    blazingVehicle:setLightTrailColour(OnlineModeSettings.yellow128)
    for i, player in next, playerManager.players, nil do
      if player.inZap and prevScore > 0 then
        OneShotSound.Play("HUD_Online_TrailBlazer_ExitStream", false)
      end
      if not player.inZap and player.currentVehicle.gameVehicle then
        local score = GameVehicleResource.interceptingTrailCount(player.currentVehicle.gameVehicle)
        if player.isLocal and score > 0 then
          GameVehicleResource.setInterceptedTrailColour(blazingVehicle.gameVehicle, player.currentVehicle.gameVehicle, OnlineModeSettings.blue128)
        end
        if player.isLocal then
          if prevScore == 0 and score > 0 then
            OneShotSound.Play("HUD_Online_TrailBlazer_EnterStream", false)
          elseif prevScore > 0 and score == 0 then
            OneShotSound.Play("HUD_Online_TrailBlazer_ExitStream", false)
          end
          if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public and score == 2 then
            if prevScore == 2 then
              timeInBlaze = timeInBlaze + (g_NetworkTime - lastTimeInBlaze)
              if roundedTimeInBlaze ~= math.floor(timeInBlaze) then
                roundedTimeInBlaze = math.floor(timeInBlaze)
                OnlineAchievements.onValueChange("Trailblazer in blaze", roundedTimeInBlaze)
              end
            end
            lastTimeInBlaze = g_NetworkTime
          end
          prevScore = score
        end
        if player.localID == 0 then
          if score and score > 0 then
            if not player.currentVehicle:vehicleFlashOverridden() then
              player.currentVehicle:overRideFlashColour(OnlineModeSettings.blue32, OnlineModeSettings.blue128)
            end
          elseif player.currentVehicle:vehicleFlashOverridden() then
            player.currentVehicle:removeFlashColourOverRide()
          end
        elseif player.currentVehicle:vehicleFlashOverridden() then
          player.currentVehicle:removeFlashColourOverRide()
        end
      end
    end
  end
  local opponents = {}
  local scored = false
  local function stepInstructionPrompts(taskObject)
    local localID = taskObject.coreData.agent.localID
    if resetPrompts then
      onlineInstructionSupport.setPrompts(true, true, true, true, true, true, true, true, true, true, false, true, false, false, "ID:234338", nil, localID)
      onlineInstructionSupport.modifyPrompt("boost", "message", "ID:234275", localID)
      resetPrompts = false
    end
    opponents = {}
    for playerID, player in next, playerManager.players, nil do
      if playerID ~= taskObject.coreData.agent.playerID then
        table.insert(opponents, {
          vehicle = player.currentVehicle,
          position = player.position
        })
      end
    end
    if localPlayerTaskObject.namedTasks.score.networkVars.payload ~= previousPlayerScore then
      scored = true
      previousPlayerScore = localPlayerTaskObject.namedTasks.score.networkVars.payload
    else
      scored = false
    end
    onlineInstructionSupport.step(blazingVehicle.position, opponents, scored, localID)
  end
  local function update(taskObject)
    drawTimer()
    updateWiningPrompt()
    drawFlashColours()
    stepInstructionPrompts(taskObject)
  end
  local function cleanup(taskObject)
    local fromPurge = taskObject.coreData.instance.deleteFromPurge
    if not fromPurge then
      for playerID, player in next, playerManager.players, nil do
        if playerID ~= localPlayer.playerID then
          feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.red32, OnlineModeSettings.red128)
        end
      end
    end
    feedbackSystem.multiplayerSupport.hideBehindVehicleFeedback()
    OneShotSound.Play("HUD_Online_TrailBlazer_ExitStream")
    if vehicleManager.vehiclesBySNVID[blazingVehicle.SNVID] then
      blazingVehicle:removeLightTrail()
    end
    Marker:delete(blazingVehicleTargetMarker)
    Marker:delete(blazingVehicleMinimapMarker)
    Marker:delete(blazingVehicleMinimapArrow)
    blazingVehicle:disableMinimapMarker(false)
    for i, player in next, playerManager.players, nil do
      if player.currentVehicle and player.currentVehicle:vehicleFlashOverridden() then
        player.currentVehicle:removeFlashColourOverRide()
      end
    end
  end
  update(taskSystem.taskObjects[task.taskObjectID])
  return update, nil, nil, cleanup
end)
