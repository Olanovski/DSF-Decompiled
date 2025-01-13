onlineSideBar.registerSideBar("MP pure race", function(instance)
  local playerScore = 0
  local numLaps = 0
  local vehicleTaskObject = false
  local totalCheckpoints = false
  local rank = 0
  local raceProg = 0
  local function initiate()
    totalCheckpoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
    onlineSideBar.toggleSmallSidebarTitle(1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_game_title", "ID:247256")
    onlineSideBar.toggleProgressSidebarTitle(1, 0)
    feedbackSystem.menusMaster.masterSetTextVariable("multi_title_progress", "ID:236553")
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Bar_Progress", 0)
  end
  local function getData(taskObject)
    if taskObject.initiated then
      vehicleTaskObject = taskObject.coreData.agent.currentVehicle:getTaskObject() or taskObject.coreData.agent.currentVehicle and false
      playerScore = vehicleTaskObject.namedTasks.checkpoints and vehicleTaskObject and 0
      numLaps = instance.challenge.settings.totalLaps + 1
      rank = onlineRaceManager.getPlayerRank(taskObject.coreData.agent.playerID)
      if vehicleTaskObject and vehicleTaskObject.namedTasks.checkpoints and 0 < vehicleTaskObject.namedTasks.checkpoints.networkVars.laps then
        local temp = vehicleTaskObject.namedTasks.checkpoints.networkVars.laps * totalCheckpoints
        playerScore = playerScore + temp
      end
      raceProg = playerScore / (totalCheckpoints * numLaps) * 100
      if onlineRaceManager.getPlayerRank(taskObject.coreData.agent.playerID) == 1 then
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Bar_Progress", raceProg)
      end
      return taskObject.coreData.agent.name, raceProg, rank, taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID, true
    else
      return taskObject.coreData.agent.name, 0, 8, taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID, true
    end
  end
  local cleanup = function()
    onlineSideBar.toggleSmallSidebarTitle(0)
    onlineSideBar.toggleSidebarTimerFlash(0)
    onlineSideBar.toggleTimerSidebarTitle(0)
    onlineSideBar.toggleProgressSidebarTitle(0)
  end
  return initiate, getData, cleanup, onlineSideBar.standardSortFuncs.playerInvScoreSort, false, false, true
end)
feedbackSystem.registerHUD("MP Pure Race Start HUD", function(task, settings)
end, function(task)
  local update = function()
  end
  local cleanup = function()
    OneShotSound.Play("HUD_Online_Announcement_CentreScreen")
  end
  return update, nil, nil, cleanup
end)
feedbackSystem.registerHUD("MP Pure Race HUD", function(task, settings)
end, function(task)
  local instance = task.instance
  local taskObject = taskSystem.taskObjects[task.taskObjectID]
  local totalCheckpoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
  local maxTime = task.instance.challenge.settings.modeTimeLimit
  local matchTime = {startTime = maxTime, reset = false}
  local localVehicleTaskObject = false
  local playerTargetMarker
  local checkpointOffset = vec.vector(0, 10, 0, 0)
  local workingVector = vec.vector()
  local previousCheckpointsPassed = -1
  local previousLapsDone = -1
  local currentPassedCheckpoints = -1
  local currentLapsDone = -1
  local stringFormat = "%02d"
  local format = string.format
  local mod = math.mod
  local sub = string.sub
  for localID, player in next, localPlayerManager.players, nil do
    onlineInstructionSupport.resetPrompts(localID)
  end
  local resetPrompts = true
  local previousPlayerScore = 0
  local lowTimeMessage = true
  local lowTimeFlash = true
  local timeRemaining = false
  local prevSeconds = false
  local timerOn = false
  local overTimeOn = false
  local overTimeRemaining = false
  local overTimeStart = false
  local timerUsed = false
  local function updateModeTimer()
    timeRemaining = maxTime - instance:getTime()
    if timeRemaining < 0.1 then
      timeRemaining = 0
    end
    if not overTimeOn and timeRemaining > cardSystem.logic.mpPureRaceEndTimeLimit and 0 < onlineRaceManager.networkVars.raceEndTimer then
      overTimeOn = true
      overTimeStart = onlineRaceManager.networkVars.raceEndTimer
      onlineSideBar.toggleTimerSidebarTitle(1)
      phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeOneMinRemain)
    end
    if overTimeOn then
      overTimeRemaining = cardSystem.logic.mpPureRaceEndTimeLimit - (g_NetworkTime - overTimeStart)
      if overTimeRemaining < 0.1 then
        overTimeRemaining = 0
      end
    end
    if not timerOn and not overTimeOn and timeRemaining <= 60 then
      onlineSideBar.toggleTimerSidebarTitle(1)
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:231383", onlineRedPrompt = true})
      timerOn = true
      phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeOneMinRemain)
    end
    if timerOn or overTimeOn then
      timerUsed = overTimeOn and timeRemaining
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_minutes", format(stringFormat, timerUsed / 60))
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_seconds", "." .. format(stringFormat, math.ceil(timerUsed)))
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_milliseconds", "." .. sub(mod(timerUsed, 1), 3, 4))
      if 1 > timerUsed / 60 then
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
      if timerUsed > 15 and not lowTimeFlash then
        onlineSideBar.toggleSidebarTimerFlash(0)
        lowTimeFlash = true
      end
      if timerUsed > 17 and not lowTimeMessage then
        lowTimeMessage = true
      end
      if timerUsed < 15 and lowTimeFlash then
        lowTimeFlash = false
        onlineSideBar.toggleSidebarTimerFlash(1)
      end
      if timerUsed < 17 and lowTimeMessage then
        lowTimeMessage = false
        if not overTimeOn then
          feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:169362", onlineRedPrompt = true})
        end
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
  local checkpointPosition
  local displayTargetMarker = false
  local function updateTargetMarker(player)
    if localVehicleTaskObject.namedTasks.checkpoints and localVehicleTaskObject.namedTasks.checkpoints.dynamicTargets then
      currentPassedCheckpoints = localVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpoints - 1
      currentLapsDone = localVehicleTaskObject.namedTasks.checkpoints.networkVars.laps
      if currentPassedCheckpoints > previousCheckpointsPassed or currentLapsDone > previousLapsDone then
        if previousCheckpointsPassed > -1 and previousLapsDone > -1 then
          OneShotSound.Play("HUD_Online_TagScore_Player_OneShot")
        end
        if playerTargetMarker then
          Marker:delete(playerTargetMarker)
          playerTargetMarker = false
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
      previousLapsDone = currentLapsDone
    end
  end
  local opponents = {}
  local scored = false
  local objectivePosition
  local function stepInstructionPrompts(taskObject)
    local plr = taskObject.coreData.agent
    if resetPrompts then
      onlineInstructionSupport.setPrompt("accelerate", nil, nil, nil, nil, plr.localID)
      onlineInstructionSupport.setPrompt("boost", nil, nil, nil, nil, plr.localID)
      onlineInstructionSupport.setPrompt("score", true, 20, 45, "ID:234269", plr.localID)
      resetPrompts = false
    end
    opponents = {}
    for playerID, player in next, playerManager.players, nil do
      if playerID ~= plr.playerID then
        table.insert(opponents, {
          vehicle = player.currentVehicle,
          position = player.position
        })
      end
    end
    if localVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpoints ~= previousPlayerScore then
      scored = true
      previousPlayerScore = localVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpoints
    else
      scored = false
    end
    objectivePosition = plr.currentVehicle and spoolsystem.position
    if localVehicleTaskObject.namedTasks.checkpoints and localVehicleTaskObject.namedTasks.checkpoints.dynamicTargets then
      objectivePosition = localVehicleTaskObject.namedTasks.checkpoints.dynamicTargets[1].position
    end
    onlineInstructionSupport.step(objectivePosition, opponents, scored, plr.localID)
  end
  local prevPosition = false
  local lastLead = false
  local lastLeadUpdate = 0
  local playerPosition = false
  local prevLap = -1
  local placingFeedback = {
    [1] = false,
    [2] = false,
    [3] = false
  }
  local function update(taskObject)
    if localVehicleTaskObject then
      stepInstructionPrompts(taskObject)
      updateModeTimer()
      local currentLap = localVehicleTaskObject.namedTasks.checkpoints.networkVars.laps
      if prevLap > -1 and prevLap ~= currentLap then
        if currentLap < task.instance.challenge.settings.totalLaps then
          feedbackSystem.menusMaster.primaryTextPromptParam({
            prompt = "ID:243785",
            value = tostring(prevLap + 1),
            value2 = tostring(task.instance.challenge.settings.totalLaps + 1)
          })
        elseif currentLap == task.instance.challenge.settings.totalLaps then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:169318")
        end
      end
      prevLap = currentLap
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
        if not placingFeedback[1] and playerPosition and playerPosition == 1 then
          if lastLead and lastLead ~= playerID and g_NetworkTime - lastLeadUpdate > 2 then
            feedbackSystem.eventMessages.addMessage(1, player.name, "ID:243734", "", playerID, false, false, false, playerID ~= localPlayer.playerID)
            lastLeadUpdate = g_NetworkTime
          end
          lastLead = playerID
        end
        if playerPosition and playerPosition <= 3 and not placingFeedback[playerPosition] then
          local taskObj = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[playerID + 1]]
          if taskObj and taskObj.namedTasks.checkpoints and taskObj.namedTasks.checkpoints.networkVars.laps > taskObj.namedTasks.checkpoints.coreData.totalLaps then
            placingFeedback[playerPosition] = true
            if playerID ~= localPlayer.playerID then
              if playerPosition == 1 then
                feedbackSystem.eventMessages.addMessage(1, player.name, "ID:220324", "", playerID, false, false, false, true)
                feedbackSystem.menusMaster.primaryTextPromptParam({
                  prompt = "ID:245856",
                  value = tostring(player.name),
                  onlineRedPrompt = true
                })
              elseif playerPosition == 2 then
                feedbackSystem.eventMessages.addMessage(1, player.name, "ID:220325", "", playerID, false, false, false, true)
                feedbackSystem.menusMaster.primaryTextPromptParam({
                  prompt = "ID:245857",
                  value = tostring(player.name),
                  onlineRedPrompt = true
                })
              elseif playerPosition == 3 then
                feedbackSystem.eventMessages.addMessage(1, player.name, "ID:220327", "", playerID, false, false, false, true)
                feedbackSystem.menusMaster.primaryTextPromptParam({
                  prompt = "ID:245858",
                  value = tostring(player.name),
                  onlineRedPrompt = true
                })
              end
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
  local timeRemaining, playerBeingUpdated
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
