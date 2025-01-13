onlineSideBar.registerSideBar("MP sprint race", function(instance)
  local playerScore = 0
  local vehicleTaskObject = false
  local totalCheckpoints = false
  local rank = 0
  local raceProg = 0
  local function initiate()
    totalCheckpoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
    onlineSideBar.toggleSmallSidebarTitle(1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_game_title", "ID:242336", tostring(instance.networkVars.roundOn) .. "/" .. tostring(instance.challenge.settings.numRounds))
    onlineSideBar.toggleProgressSidebarTitle(1, 0)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_progress", "ID:236553")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_minutes", "00")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_seconds", "." .. tostring(instance.challenge.settings.modeTimeLimit))
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Bar_Progress", 0)
  end
  local function getData(taskObject)
    if taskObject.initiated then
      vehicleTaskObject = taskObject.coreData.agent.currentVehicle:getTaskObject() or taskObject.coreData.agent.currentVehicle and false
      playerScore = vehicleTaskObject.namedTasks.checkpoints and vehicleTaskObject and 0
      rank = onlineRaceManager.getPlayerRank(taskObject.coreData.agent.playerID)
      if vehicleTaskObject and vehicleTaskObject.namedTasks.checkpoints and 0 < vehicleTaskObject.namedTasks.checkpoints.networkVars.laps then
        playerScore = totalCheckpoints
      end
      raceProg = playerScore / totalCheckpoints * 100
      if onlineRaceManager.getPlayerRank(taskObject.coreData.agent.playerID) == 1 then
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Bar_Progress", raceProg)
      end
      return taskObject.coreData.agent.name, raceProg, rank, taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID, true
    else
      return taskObject.coreData.agent.name, 0, 8, taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID, true
    end
  end
  local cleanup = function()
    onlineSideBar.toggleSidebarTimerFlash(0)
    onlineSideBar.toggleTimerSidebarTitle(0)
    onlineSideBar.toggleSmallSidebarTitle(0)
    onlineSideBar.toggleProgressSidebarTitle(0)
  end
  return initiate, getData, cleanup, onlineSideBar.standardSortFuncs.playerInvScoreSort, false, false, true
end)
local previousRankings = {}
feedbackSystem.registerHUD("MP Sprint Race Start HUD", function(task, settings)
end, function(task)
  local instance = localPlayer.getTaskObject().coreData.instance
  OneShotSound.Play("HUD_Online_RoundSet")
  if instance.networkVars.roundOn < instance.challenge.settings.numRounds then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:220240", instance.networkVars.roundOn)
  elseif instance.networkVars.roundOn == instance.challenge.settings.numRounds then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:169345")
  end
  local update = function()
  end
  local cleanup = function()
    OneShotSound.Play("HUD_Online_Announcement_CentreScreen")
  end
  return update, nil, nil, cleanup
end)
feedbackSystem.registerHUD("MP Sprint Race HUD", function(task, settings)
end, function(task)
  local instance = task.instance
  local taskObject = taskSystem.taskObjects[task.taskObjectID]
  local totalCheckpoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
  local matchTime = {startTime = 45, reset = false}
  local maxTime = task.instance.challenge.settings.modeTimeLimit
  local stringFormat = "%02d"
  local format = string.format
  local mod = math.mod
  local sub = string.sub
  local localVehicleTaskObject = false
  local playerTargetMarker
  local workingVector = vec.vector()
  local currentPassedCheckpoints = -1
  local previousCheckpointsPassed = -1
  onlineInstructionSupport.resetPrompts()
  local resetPrompts = true
  local previousPlayerScore = 0
  local playerTaskObjects = {}
  for outer, data in next, task.instance.taskObjectsByActorID, nil do
    for inner = 1, 8 do
      if outer == PLAYER_STRING_TABLE[inner] then
        playerTaskObjects[outer] = data
        break
      end
    end
  end
  local clearMarkers = function(vehicle)
    if vehicle.markers then
      for k, v in next, vehicle.markers, nil do
        Marker:delete(v)
        vehicle.markers[k] = nil
      end
    end
  end
  local timerOn = false
  local timeRemaining = maxTime
  local prevSeconds = false
  local overTimeOn = false
  local overTimeRemaining = false
  local overTimeStart = false
  local timerUsed = false
  local function updateModeTimer()
    timeRemaining = maxTime - instance:getTime()
    if timeRemaining < 0.1 then
      timeRemaining = 0
    end
    if not overTimeOn and timeRemaining > cardSystem.logic.mpSprintRaceEndTimeLimit and 0 < onlineRaceManager.networkVars.raceEndTimer then
      overTimeOn = true
      overTimeStart = onlineRaceManager.networkVars.raceEndTimer
      onlineSideBar.toggleTimerSidebarTitle(1)
    end
    if overTimeOn then
      overTimeRemaining = cardSystem.logic.mpSprintRaceEndTimeLimit - (g_NetworkTime - overTimeStart)
      if overTimeRemaining < 0.1 then
        overTimeRemaining = 0
      end
    end
    if not timerOn and not overTimeOn and timeRemaining <= 16 then
      onlineSideBar.toggleTimerSidebarTitle(1)
      onlineSideBar.toggleSidebarTimerFlash(1)
      feedbackSystem.menusMaster.primaryTextPrompt("ID:169362", false, false, false, false, false, false, false, false, true)
      timerOn = true
    end
    if timerOn or overTimeOn then
      timerUsed = overTimeOn and timeRemaining
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_minutes", format(stringFormat, timerUsed / 60))
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_seconds", "." .. format(stringFormat, math.ceil(timerUsed)))
      local ceilCurrSeconds = math.ceil(mod(timerUsed, 60))
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
  end
  local checkpointPosition
  local displayTargetMarker = false
  local function updateTargetMarker(player)
    if localVehicleTaskObject.namedTasks.checkpoints and localVehicleTaskObject.namedTasks.checkpoints.dynamicTargets then
      currentPassedCheckpoints = localVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpoints
      if currentPassedCheckpoints > previousCheckpointsPassed then
        clearMarkers(localVehicleTaskObject.coreData.agent)
        if playerTargetMarker then
          Marker:delete(playerTargetMarker)
          playerTargetMarker = false
        end
        if previousCheckpointsPassed > -1 then
          OneShotSound.Play("HUD_Online_TagScore_Player_OneShot", false)
        end
        if localVehicleTaskObject.namedTasks.checkpoints.dynamicTargets then
          checkpointPosition = localVehicleTaskObject.namedTasks.checkpoints.dynamicTargets[1].position
        end
      end
      if not GameVehicleResource.withinRadius(player.position, checkpointPosition, 200) then
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
        playerTargetMarker.localID = player.localID
        playerTargetMarker = Marker:create(playerTargetMarker)
      end
      previousCheckpointsPassed = currentPassedCheckpoints
    end
  end
  local opponents = {}
  local scored = false
  local objectivePosition
  local function stepInstructionPrompts()
    if resetPrompts then
      onlineInstructionSupport.setPrompt("accelerate")
      onlineInstructionSupport.setPrompt("boost")
      onlineInstructionSupport.setPrompt("score", true, 10, 20, "ID:234269")
      resetPrompts = false
    end
    opponents = {}
    for playerID, player in next, playerManager.players, nil do
      if playerID ~= localPlayer.playerID then
        table.insert(opponents, {
          vehicle = player.currentVehicle,
          position = player.position
        })
      end
    end
    if localVehicleTaskObject.namedTasks.checkpoints and localVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpoints ~= previousPlayerScore then
      scored = true
      previousPlayerScore = localVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpoints
    else
      scored = false
    end
    objectivePosition = localPlayer.currentVehicle and spoolsystem.position
    if localVehicleTaskObject.namedTasks.checkpoints and localVehicleTaskObject.namedTasks.checkpoints.dynamicTargets then
      objectivePosition = localVehicleTaskObject.namedTasks.checkpoints.dynamicTargets[1].position
    end
    onlineInstructionSupport.step(objectivePosition, opponents, scored)
  end
  local function splitScreenBarsUpdate(taskObject)
    taskObject1 = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[1]]
    taskObject2 = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[2]]
    race1Ranking = onlineRaceManager.getPlayerRank(taskObject1.coreData.agent.playerID)
    race2Ranking = onlineRaceManager.getPlayerRank(taskObject2.coreData.agent.playerID)
    if race1Ranking < race2Ranking then
      feedbackSystem.menusMaster.masterSetTextVariable("ss_p1_title", "1st")
      feedbackSystem.menusMaster.masterSetTextVariable("ss_p2_title", "2nd")
    else
      feedbackSystem.menusMaster.masterSetTextVariable("ss_p2_title", "1st")
      feedbackSystem.menusMaster.masterSetTextVariable("ss_p1_title", "2nd")
    end
    local vehicleTaskObject = taskObject.coreData.agent.currentVehicle and taskObject.coreData.agent.currentVehicle:getTaskObject()
    local playerScore = vehicleTaskObject and vehicleTaskObject.namedTasks.checkpoints and vehicleTaskObject.namedTasks.checkpoints.networkVars.checkpoints - 1 or 0
    local raceProg = playerScore / totalCheckpoints * 100
    playerIndex = taskObject.player.localID + 1
  end
  local prevSeconds = 0
  local prevPosition = false
  local playerPosition = false
  local placingFeedback = {
    [1] = false,
    [2] = false,
    [3] = false
  }
  local function update(taskObject)
    if localVehicleTaskObject then
      updateModeTimer()
      stepInstructionPrompts()
      for playerID, player in next, playerManager.players, nil do
        playerPosition = onlineRaceManager.getPlayerRank(playerID)
        if playerID == localPlayer.playerID then
          if playerPosition and prevPosition then
            if playerPosition > prevPosition then
              OneShotSound.Play("HUD_Mis_PositionChange_Negative_OneShot", false)
            elseif playerPosition < prevPosition then
              OneShotSound.Play("HUD_Mis_PositionChange_Positive_OneShot", false)
            end
          end
          prevPosition = playerPosition
        end
        if playerPosition and playerPosition <= 3 and not placingFeedback[playerPosition] then
          local taskObj = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[playerID + 1]]
          if taskObj and taskObj.namedTasks.checkpoints and taskObj.namedTasks.checkpoints.networkVars.laps > taskObj.namedTasks.checkpoints.coreData.totalLaps then
            placingFeedback[playerPosition] = true
            if playerID ~= localPlayer.playerID and playerPosition == 1 then
              feedbackSystem.eventMessages.addMessage(1, player.name, "ID:220324", "", playerID, false, false, false, true)
            end
          end
        end
      end
      if not localPlayer.missionSupport:isSubTaskObject(localVehicleTaskObject) then
        localPlayer.missionSupport:addSubTaskObject(localVehicleTaskObject, 1)
      end
    else
      localVehicleTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[localPlayer.playerID + 1]]
    end
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
    if playerTargetMarker then
      Marker:delete(playerTargetMarker)
    end
  end
  return update, nil, nil, cleanup
end)
