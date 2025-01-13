onlineSideBar.registerSideBar("MP circuit race", function(instance)
  local playerScore = 0
  local numLaps = 0
  local totalCheckpoints = false
  local rank = 0
  local raceProg = 0
  local function initiate()
    totalCheckpoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
    onlineSideBar.toggleSmallSidebarTitle(1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_game_title", "ID:247255")
    onlineSideBar.toggleProgressSidebarTitle(1, 0)
    feedbackSystem.menusMaster.masterSetTextVariable("multi_title_progress", "ID:236553")
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Bar_Progress", 0)
  end
  local function getData(taskObject)
    if taskObject.initiated then
      playerScore = taskObject.namedTasks.checkpoints and 0
      numLaps = instance.challenge.settings.totalLaps + 1
      rank = onlineRaceManager.getPlayerRank(taskObject.coreData.agent.playerID)
      if taskObject.namedTasks.checkpoints and 0 < taskObject.namedTasks.checkpoints.networkVars.laps then
        local temp = taskObject.namedTasks.checkpoints.networkVars.laps * totalCheckpoints
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
    onlineSideBar.toggleSidebarTimerFlash(0)
    onlineSideBar.toggleTimerSidebarTitle(0)
    onlineSideBar.toggleSmallSidebarTitle(0)
    onlineSideBar.toggleProgressSidebarTitle(0)
  end
  return initiate, getData, cleanup, onlineSideBar.standardSortFuncs.playerInvScoreSort, false, false, true
end)
feedbackSystem.registerHUD("MP Circuit Race Start HUD", function(task, settings)
end, function(task)
  local update = function()
  end
  local cleanup = function()
    OneShotSound.Play("HUD_Online_Announcement_CentreScreen")
  end
  return update, nil, nil, cleanup
end)
feedbackSystem.registerHUD("MP Circuit Race HUD", function(task, settings)
end, function(task)
  local instance = task.instance
  local taskObject = taskSystem.taskObjects[task.taskObjectID]
  local totalCheckpoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
  local localVehicleTaskObject = false
  local playerTargetMarker = false
  local currentLapsDone = -1
  local currentPassedCheckpoints = -1
  local previousCheckpointsPassed = -1
  local previousLapsDone = -1
  local previousLap = 1
  local maxTime = task.instance.challenge.settings.modeTimeLimit
  local stringFormat = "%02d"
  local format = string.format
  local mod = math.mod
  local sub = string.sub
  onlineInstructionSupport.resetPrompts()
  local resetPrompts = true
  local localPlayerTaskObject = localPlayer.getTaskObject()
  local previousPlayerScore = 0
  local workingVector = vec.vector()
  local numLaps = task.instance.challenge.settings.totalLaps + 1
  local playerTaskObjects = {}
  for outer, data in next, task.instance.taskObjectsByActorID, nil do
    for inner = 1, 8 do
      if outer == PLAYER_STRING_TABLE[inner] then
        playerTaskObjects[outer] = data
        break
      end
    end
  end
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
    if not timerOn and timeRemaining <= 60 then
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:231383", onlineRedPrompt = true})
      onlineSideBar.toggleTimerSidebarTitle(1)
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
  local function stepInstructionPrompts()
    if resetPrompts then
      onlineInstructionSupport.setPrompts(true, false, true, true, true, false, true, true, false, true, false, true, false, true, "ID:234269")
      resetPrompts = false
    end
    local opponents = {}
    for playerID, player in next, playerManager.players, nil do
      if playerID ~= localPlayer.playerID then
        table.insert(opponents, {
          vehicle = player.currentVehicle,
          position = player.position
        })
      end
    end
    local scored = false
    if localPlayerTaskObject.namedTasks.checkpoints.networkVars.checkpoints ~= prevScore then
      scored = true
      previousPlayerScore = localPlayerTaskObject.namedTasks.checkpoints.networkVars.checkpoints
    end
    local objectivePosition = localPlayer.currentVehicle and localPlayer.currentVehicle.position or spoolsystem.position
    if localVehicleTaskObject.namedTasks.checkpoints and localVehicleTaskObject.namedTasks.checkpoints.dynamicTargets then
      objectivePosition = localVehicleTaskObject.namedTasks.checkpoints.dynamicTargets[1].position
    end
    onlineInstructionSupport.step(objectivePosition, opponents, scored)
  end
  local prevPosition = false
  local lastLead = false
  local lastLeadUpdate = 0
  local playerPosition = false
  local placingFeedback = {
    [1] = false,
    [2] = false,
    [3] = false
  }
  local function update()
    updateModeTimer()
    if localVehicleTaskObject then
      stepInstructionPrompts()
      feedbackSystem.menusMaster.masterSetTextVariable("multi_title_lapcounter_total", task.networkVars.laps + 1)
      if previousLap ~= task.networkVars.laps + 1 then
        if task.networkVars.laps < task.instance.challenge.settings.totalLaps then
          feedbackSystem.menusMaster.primaryTextPromptParam({
            prompt = "ID:243785",
            value = tostring(previousLap),
            value2 = tostring(task.instance.challenge.settings.totalLaps + 1)
          })
        elseif task.networkVars.laps == task.instance.challenge.settings.totalLaps then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:169318")
        end
      end
      previousLap = task.networkVars.laps + 1
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
          local taskObj = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[playerID + 1]]
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
      if localVehicleTaskObject.namedTasks.checkpoints then
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_player_position", localVehicleTaskObject.namedTasks.checkpoints.networkVars.checkpoints)
      end
    else
      localVehicleTaskObject = localPlayer:getTaskObject()
    end
  end
  local function cleanup(taskObject)
    local fromPurge = taskObject.coreData.instance.deleteFromPurge
    if playerTargetMarker then
      Marker:delete(playerTargetMarker)
    end
    if not fromPurge then
      for playerID, player in next, playerManager.players, nil do
        if playerID ~= localPlayer.playerID then
          feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.red32, OnlineModeSettings.red128)
        end
      end
    end
  end
  return update, nil, nil, cleanup
end)
