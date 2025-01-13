onlineSideBar.registerSideBar("MP tag", function(instance)
  local initiate = function()
    onlineSideBar.toggleSmallSidebarTitle(1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_game_title", "ID:247259")
  end
  local maxScore = instance.challenge.settings.targetScore
  local playerScore = 0
  local isTarget = false
  local packageTO = false
  local function getData(taskObject)
    if not packageTO then
      packageTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    end
    if taskObject.initiated and packageTO and packageTO.coreData then
      playerScore = taskObject.namedTasks.score and 0
      isTarget = packageTO and packageTO.coreData.agent.owner == taskObject.coreData.agent.currentVehicle
      if playerScore > maxScore then
        playerScore = maxScore
      end
      if isTarget then
        return taskObject.coreData.agent.name, math.ceil(playerScore / maxScore * 100), playerScore, taskObject.coreData.agent.isLocal, 1, taskObject.coreData.agent.playerID
      else
        return taskObject.coreData.agent.name, math.ceil(playerScore / maxScore * 100), playerScore, taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID
      end
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
feedbackSystem.registerHUD("MP Tag Start HUD", function(task, settings)
end, function(task)
  local instance = localPlayer.getTaskObject().coreData.instance
  local markerSettings = {
    Target = {
      type = "Target",
      targetType = "MultiplayerObjective",
      colour = OnlineModeSettings.red32 + OnlineModeSettings.targetAlphaMask32,
      gadgetID = 177,
      radius = 45,
      visible = true,
      markerOffset = 1
    },
    MinimapArrow = {
      type = "Minimap",
      radius = 40,
      gadgetID = 257,
      colour = OnlineModeSettings.red32,
      visible = true,
      canrotate = true,
      nofade = true
    },
    Minimap = {
      type = "Minimap",
      radius = 40,
      gadgetID = 256,
      colour = OnlineModeSettings.red32,
      visible = true,
      canrotate = false,
      nofade = true
    }
  }
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
  local packageTO = instance.taskObjectsByActorID["Objective Team 1 member 1"]
  local tagVehicle
  local function drawMarkers()
    if packageTO and localPlayer.currentVehicle then
      tagVehicle = packageTO.coreData.agent.owner
      if not mainMarker and tagVehicle then
        setMainMarker(tagVehicle)
        tagVehicle:addLightTrail(32, OnlineModeSettings.red128)
      end
    end
  end
  local function update()
    drawMarkers()
  end
  local function cleanupCallback()
    if packageTO and packageTO.coreData and packageTO.coreData.agent then
      tagVehicle = packageTO.coreData.agent.owner
      if tagVehicle and vehicleManager.vehiclesBySNVID[tagVehicle.SNVID] then
        tagVehicle:deleteDisplay()
        tagVehicle:removeLightTrail()
        clearMainMarker(tagVehicle)
      end
    end
  end
  phaseManager.startHUDCleanupFunction = cleanupCallback
  return update, nil, nil, nil
end)
feedbackSystem.registerHUD("Tag HUD", function(task, settings)
end, function(task)
  if phaseManager.startHUDCleanupFunction then
    phaseManager.startHUDCleanupFunction()
    phaseManager.startHUDCleanupFunction = false
  end
  local instance = task.instance
  local packageTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local previousOwner = false
  local previousOwnerID = -1
  local previousScore = 0
  local previousScoreSplit = {0, 0}
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
  local previousPlayerScore = {}
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Impact", 1)
  OneShotSound.Play("HUD_Online_TOW_ObjectiveSpawned_OneShot")
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
  local function updateWinningPrompt(taskObject)
    local playerScore = taskObject.namedTasks.score and taskObject.namedTasks.score.networkVars.payload or 0
    if playerScore > maxScore then
      playerScore = maxScore
    end
    if playerScore / maxScore >= 0.9 and not winningFeedback[taskObject.coreData.agent.playerID] then
      if taskObject.coreData.agent.isLocal then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:242108")
      else
        feedbackSystem.eventMessages.addMessage(1, taskObject.coreData.agent.name, "ID:243728", "", taskObject.coreData.agent.playerID, false, false, false, true)
        feedbackSystem.menusMaster.primaryTextPrompt("ID:220264", tostring(taskObject.coreData.agent.name), false, false, false, false, false, false, false, true)
      end
      winningFeedback[taskObject.coreData.agent.playerID] = true
    elseif playerScore / maxScore < 0.9 and winningFeedback[taskObject.coreData.agent.playerID] then
      winningFeedback[taskObject.coreData.agent.playerID] = false
    end
    if not timeToJoinSet and playerScore / maxScore > phaseManager.timeToJoinExceptionValues.tag then
      phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeException)
      timeToJoinSet = true
    end
  end
  local timerOn = false
  local lowTimeMessage = true
  local lowTimeFlash = true
  local timeRemaining = maxTime
  local prevSeconds = false
  local function updateModeTimer()
    timeRemaining = maxTime - instance:getTime()
    if not timerOn and timeRemaining <= 60 then
      onlineSideBar.toggleTimerSidebarTitle(1)
      feedbackSystem.menusMaster.primaryTextPrompt("ID:231383", false, false, false, false, false, false, false, false, true)
      matchTime.startTime = 60
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
  local markerSettings = {
    Target = {
      type = "Target",
      targetType = "MultiplayerObjective",
      colour = OnlineModeSettings.red32 + OnlineModeSettings.targetAlphaMask32,
      radius = 45,
      visible = true,
      gadgetID = 177,
      markerOffset = 1
    },
    MinimapArrow = {
      type = "Minimap",
      colour = OnlineModeSettings.red32,
      radius = 40,
      visible = true,
      canrotate = true,
      gadgetID = 257,
      nofade = true
    },
    Minimap = {
      type = "Minimap",
      colour = OnlineModeSettings.red32,
      radius = 40,
      visible = true,
      canrotate = false,
      gadgetID = 256,
      nofade = true
    }
  }
  local mainMarker = false
  local function setMainMarker(vehicle, playerControlled)
    vehicle:disableMinimapMarker(true)
    mainMarker = true
    vehicle.markers = vehicle.markers or {}
    for k, v in next, vehicle.markers, nil do
      Marker:delete(v)
      vehicle.markers[k] = nil
    end
    for id, plr in next, localPlayerManager.players, nil do
      for k, v in next, markerSettings, nil do
        v.gameVehicle = vehicle.gameVehicle
        if v.type ~= "Target" and v.type ~= "Minimap" then
          if plr.currentVehicle == vehicle then
            v.gadgetID = 116
          else
            v.gadgetID = 165
          end
        end
        if v.type == "World" then
          v.offset = vec.vector(0, vehicle.gameVehicle.height + 1, 0, 0)
        end
        if not playerControlled and v.type ~= "World" or plr.currentVehicle == vehicle and v.type == "World" or playerControlled and plr.currentVehicle ~= vehicle and v.type ~= "Target" then
          v.localID = plr.localID
          vehicle.markers[k .. plr.localID] = Marker:create(v)
        end
      end
    end
  end
  local function clearMainMarker(vehicle)
    vehicle:disableMinimapMarker(false)
    mainMarker = false
    if vehicle.markers then
      for k, v in next, vehicle.markers, nil do
        Marker:delete(v)
        vehicle.markers[k] = nil
      end
    end
  end
  local flashStartTime = -1
  local carHighLightFlash = false
  local lastFlashTime = -1
  local flashTickTime = 0.1
  local flashTime = instance.challenge.settings.invunTime
  local flashColour32 = false
  local flashColour128 = false
  local tagOwnerID = -1
  local colourA = false
  local function resetPlayerHightlight()
    if tagOwnerID ~= localPlayer.playerID then
      packageTO.coreData.agent.owner:removeFlashColourOverRide()
    else
      packageTO.coreData.agent.owner:overRideFlashColour(flashColour32, flashColour128)
    end
    if packageTO.coreData.agent.owner.lightTrail then
      packageTO.coreData.agent.owner:setLightTrailColour(flashColour128)
    end
    if tagOwnerID ~= localPlayer.playerID then
      Menu.SetPlayerColour(tagOwnerID, flashColour128)
      if packageTO.coreData.agent.owner.markers then
        if packageTO.coreData.agent.owner.markers.Minimap0 then
          packageTO.coreData.agent.owner.markers.Minimap0.colour = flashColour32
        end
        if packageTO.coreData.agent.owner.markers.MinimapArrow0 then
          packageTO.coreData.agent.owner.markers.MinimapArrow0.colour = flashColour32
        end
      end
    end
  end
  local function flashCarHighLight(startFlash, playerID)
    if packageTO and packageTO.coreData.agent.owner then
      if carHighLightFlash and not startFlash then
        if g_NetworkTime - flashStartTime < flashTime then
          if g_NetworkTime - lastFlashTime > flashTickTime then
            if colourA then
              packageTO.coreData.agent.owner:overRideFlashColour(OnlineModeSettings.yellow32, OnlineModeSettings.yellow128)
              if packageTO.coreData.agent.owner.lightTrail then
                packageTO.coreData.agent.owner:setLightTrailColour(OnlineModeSettings.yellow128)
              end
              if tagOwnerID ~= localPlayer.playerID then
                Menu.SetPlayerColour(tagOwnerID, OnlineModeSettings.yellow128)
                if packageTO.coreData.agent.owner.markers then
                  if packageTO.coreData.agent.owner.markers.Minimap0 then
                    packageTO.coreData.agent.owner.markers.Minimap0.colour = OnlineModeSettings.yellow32
                  end
                  if packageTO.coreData.agent.owner.markers.MinimapArrow0 then
                    packageTO.coreData.agent.owner.markers.MinimapArrow0.colour = OnlineModeSettings.yellow32
                  end
                end
              end
              colourA = false
            else
              packageTO.coreData.agent.owner:overRideFlashColour(flashColour32, flashColour128)
              if packageTO.coreData.agent.owner.lightTrail then
                packageTO.coreData.agent.owner:setLightTrailColour(flashColour128)
              end
              if tagOwnerID ~= localPlayer.playerID then
                Menu.SetPlayerColour(tagOwnerID, flashColour128)
                if packageTO.coreData.agent.owner.markers then
                  if packageTO.coreData.agent.owner.markers.Minimap0 then
                    packageTO.coreData.agent.owner.markers.Minimap0.colour = flashColour32
                  end
                  if packageTO.coreData.agent.owner.markers.MinimapArrow0 then
                    packageTO.coreData.agent.owner.markers.MinimapArrow0.colour = flashColour32
                  end
                end
              end
              colourA = true
            end
            lastFlashTime = g_NetworkTime
          end
        else
          resetPlayerHightlight()
          flashStartTime = -1
          lastFlashTime = -1
          flashColour32 = false
          flashColour128 = false
          carHighLightFlash = false
          colourA = false
        end
      end
      if startFlash then
        flashStartTime = g_NetworkTime
        lastFlashTime = g_NetworkTime
        flashColour32 = OnlineModeSettings.red32
        flashColour128 = OnlineModeSettings.red128
        tagOwnerID = playerID
        carHighLightFlash = true
        colourA = false
      end
    end
  end
  local isTagged = false
  local opponents = {}
  local scored = false
  local function resetInstructionPrompts(taskObject)
    local localID = taskObject.coreData.agent.localID
    isTagged = taskObject.coreData.agent.currentVehicle == packageTO.coreData.agent.owner
    onlineInstructionSupport.setPrompts(true, not isTagged, not isTagged, true, true, true, true, true, not isTagged, true, false, true, false, true, "ID:236583", nil, localID)
    onlineInstructionSupport.modifyPrompt("score", "button", iconsTable.multiTagRed, localID)
    if isTagged then
      onlineInstructionSupport.modifyPrompt("boost", "message", "ID:234274", localID)
    else
      onlineInstructionSupport.modifyPrompt("boost", "message", "ID:234275", localID)
    end
  end
  local function stepInstructionPrompts(taskObject)
    local localID = taskObject.coreData.agent.localID
    isTagged = taskObject.coreData.agent.currentVehicle == packageTO.coreData.agent.owner
    if resetPrompts then
      resetInstructionPrompts(taskObject)
      resetPrompts = false
    end
    opponents = {}
    for playerID, player in next, playerManager.players, nil do
      if playerID ~= taskObject.coreData.agent.playerID and (isTagged or player.currentVehicle and player.currentVehicle == packageTO.coreData.agent.owner) then
        table.insert(opponents, {
          vehicle = player.currentVehicle,
          position = player.position
        })
      end
    end
    if taskObject.namedTasks.score.networkVars.payload ~= previousPlayerScore[localID] then
      scored = true
      previousPlayerScore[localID] = taskObject.namedTasks.score.networkVars.payload
    else
      scored = false
    end
    onlineInstructionSupport.step(packageTO.coreData.agent.owner.position, opponents, scored, localID)
  end
  local currentOwnerID
  local scoreWhenTagObtained = 0
  local achievementFireOnce = true
  local firstMarkerSet = false
  if packageTO.coreData.agent.owner then
    setMainMarker(packageTO.coreData.agent.owner)
    firstMarkerSet = true
  end
  local function updateOnline(taskObject)
    updateModeTimer()
    if packageTO.coreData.agent.owner then
      if not firstMarkerSet then
        setMainMarker(packageTO.coreData.agent.owner)
        firstMarkerSet = true
      end
      stepInstructionPrompts(taskObject)
      currentOwnerID = -1
      for i = 1, 8 do
        local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
        if taskObject and taskObject.coreData.agent.currentVehicle == packageTO.coreData.agent.owner and taskObject.namedTasks.score then
          local playerScore = taskObject.namedTasks.score and taskObject.namedTasks.score.networkVars.payload or 0
          updateWinningPrompt(taskObject)
          currentOwnerID = i
          if taskObject.coreData.agent.currentVehicle ~= previousOwner then
            previousScore = playerScore
            if localPlayer.currentVehicle == taskObject.coreData.agent.currentVehicle then
              achievementFireOnce = true
              scoreWhenTagObtained = playerScore
            end
          end
          if previousScore ~= playerScore then
            if localPlayer.currentVehicle == taskObject.coreData.agent.currentVehicle then
              if achievementFireOnce and playerScore - scoreWhenTagObtained >= OnlineAchievements.OnlineAchievementValueUpdate.Tag.variable2 and gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
                local value = ProfileSettings.GetNumTimesTagged() + 1
                OnlineAchievements.onValueChange("Tag", value)
                ProfileSettings.SetNumTimesTagged(value)
                achievementFireOnce = false
              end
            else
              OneShotSound.Play("HUD_Online_TagScore_Opponent_OneShot")
            end
            previousScore = playerScore
          end
        end
      end
      if localPlayerTaskObject.namedTasks.score then
        feedbackSystem.multiplayerSupport.updateBehindVehicleFeedback(localPlayerTaskObject.namedTasks.score.networkVars.payload, 2, false, 90)
      end
      flashCarHighLight()
      if previousOwnerID ~= currentOwnerID then
        if previousOwnerID > 0 then
          gamerTag.setPlayerMarkerModel(previousOwnerID - 1, 5)
          gamerTag.setPlayerObjectiveMarker(previousOwnerID - 1, false)
          if currentOwnerID < 0 then
            packageTO.coreData.agent.owner:removeFlashColourOverRide()
          end
          if playerManager.players[previousOwnerID - 1] and playerManager.players[previousOwnerID - 1].currentVehicle then
            local vehicle = playerManager.players[previousOwnerID - 1].currentVehicle
            local colour32 = localPlayer.currentVehicle == packageTO.coreData.agent.owner and OnlineModeSettings.red32 or OnlineModeSettings.blue32
            local colour128 = localPlayer.currentVehicle == packageTO.coreData.agent.owner and OnlineModeSettings.red128 or OnlineModeSettings.blue128
            if previousOwnerID - 1 ~= localPlayer.playerID then
              vehicle:removeFlashColourOverRide()
              Menu.SetPlayerColour(previousOwnerID - 1, colour128)
              if vehicle.markers then
                if vehicle.markers.Minimap0 then
                  vehicle.markers.Minimap0.colour = colour32
                end
                if vehicle.markers.MinimapArrow0 then
                  vehicle.markers.MinimapArrow0.colour = colour32
                end
              end
            else
              vehicle:disableDisplay(true)
            end
          end
        end
        if currentOwnerID > 0 then
          flashCarHighLight(true, currentOwnerID - 1)
          if currentOwnerID - 1 ~= localPlayer.playerID then
            if playerManager.players[currentOwnerID - 1] then
              feedbackSystem.eventMessages.addMessage(1, playerManager.players[currentOwnerID - 1].name, "ID:169351", "", playerManager.players[currentOwnerID - 1].playerID, false, false, false, true)
            end
            if localPlayer.currentVehicle and localPlayer.currentVehicle:vehicleFlashOverridden() then
              localPlayer.currentVehicle:removeFlashColourOverRide()
            end
          else
            feedbackSystem.eventMessages.addMessage(1, localPlayer.name, "ID:169351", "", localPlayer.playerID, false, false)
            localPlayer.currentVehicle:overRideFlashColour(OnlineModeSettings.blue32, OnlineModeSettings.blue128)
          end
          gamerTag.setPlayerMarkerModel(currentOwnerID - 1, 177)
          gamerTag.setPlayerObjectiveMarker(currentOwnerID - 1, true)
        elseif previousOwnerID > 0 then
          for i = 0, 7 do
            gamerTag.setPlayerMarkerModel(i, 5)
            gamerTag.setPlayerObjectiveMarker(i, false)
          end
          if previousOwnerID - 1 ~= localPlayer.playerID then
            if playerManager.players[previousOwnerID - 1] then
              feedbackSystem.eventMessages.addMessage(1, playerManager.players[previousOwnerID - 1].name, "ID:169352", "", playerManager.players[previousOwnerID - 1].playerID, false, false, false, true)
            end
          else
            feedbackSystem.eventMessages.addMessage(1, localPlayer.name, "ID:169352", "", localPlayer.playerID, false, false)
          end
        end
        if mainMarker and previousOwner then
          clearMainMarker(previousOwner)
        end
        setMainMarker(packageTO.coreData.agent.owner, currentOwnerID > 0)
        if currentOwnerID - 1 == localPlayer.playerID then
          OneShotSound.Play("MP_Player_Positive")
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 1)
          feedbackSystem.menusMaster.primaryTextPrompt("ID:169354")
          resetPrompts = true
        elseif previousOwnerID - 1 == localPlayer.playerID then
          OneShotSound.Play("MP_Player_Negative")
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 0)
          feedbackSystem.menusMaster.primaryTextPrompt("ID:169355", false, false, false, false, iconsTable.multiTagRed, false, false, false, true)
          resetPrompts = true
        end
      end
      if previousOwnerID ~= currentOwnerID or previousOwner ~= packageTO.coreData.agent.owner then
        if previousOwner and vehicleManager.vehiclesBySNVID[previousOwner.SNVID] then
          previousOwner:removeLightTrail()
        end
        if currentOwnerID - 1 == localPlayer.playerID then
          packageTO.coreData.agent.owner:addLightTrail(32, OnlineModeSettings.blue128)
        else
          packageTO.coreData.agent.owner:addLightTrail(32, OnlineModeSettings.red128)
        end
      end
      previousOwner = packageTO.coreData.agent.owner
      previousOwnerID = currentOwnerID
    end
  end
  local function cleanup(taskObject)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iTargetPosition", 0)
    feedbackSystem.multiplayerSupport.hideBehindVehicleFeedback()
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Impact", 0)
    for i = 0, 7 do
      gamerTag.setPlayerMarkerModel(i, 5)
      gamerTag.setPlayerObjectiveMarker(i, false)
    end
    if taskObject and taskObject.coreData and taskObject.coreData.instance and not taskObject.coreData.instance.deleteFromPurge then
      local playerIsTagged = localPlayer.currentVehicle == previousOwner
      for playerID, player in next, playerManager.players, nil do
        if playerIsTagged then
          if playerID == localPlayer.playerID then
            feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.blue32, OnlineModeSettings.blue128)
          else
            feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.red32, OnlineModeSettings.red128)
          end
        elseif player.currentVehicle ~= previousOwner and playerID ~= localPlayer.playerID then
          feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.blue32, OnlineModeSettings.blue128)
        else
          feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.red32, OnlineModeSettings.red128)
        end
      end
    end
    if previousOwner then
      if taskObject and taskObject.coreData and taskObject.coreData.instance and not taskObject.coreData.instance.deleteFromPurge and (previousOwner.controlled or previousOwner.networkControlled) then
        previousOwner:disableLightTrailAutoDelete(true)
        feedbackSystem.multiplayerSupport.addWorldMarker("lightTrail", previousOwner)
      end
      if mainMarker then
        clearMainMarker(previousOwner)
      end
    end
  end
  updateOnline(taskSystem.taskObjects[task.taskObjectID])
  return updateOnline, nil, nil, cleanup
end)
