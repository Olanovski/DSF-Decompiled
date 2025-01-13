local bitOffset = 8
local dropOffScores = {
  [0] = 0,
  [1] = 10,
  [2] = 25,
  [3] = 50,
  [4] = 100
}
local targetMaxScore = 0
local maxPlayerScore = 0
onlineSideBar.registerSideBar("MP takedown", function(instance)
  local function initiate()
    onlineSideBar.toggleSmallSidebarTitle(1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_game_title", "ID:169356")
    onlineSideBar.toggleProgressSidebarTitle(1, 2)
    feedbackSystem.menusMaster.masterSetTextVariable("multi_title_progress", "ID:236554")
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Bar_Progress", 100)
    if playerManager.numberOfPlayers * 100 > targetMaxScore then
      targetMaxScore = playerManager.numberOfPlayers * 100
    end
    while targetMaxScore - maxPlayerScore < 100 do
      targetMaxScore = targetMaxScore + 100
    end
  end
  local playerScore = 0
  local playerScorePercent = 0
  local isTarget = false
  local getawayTO = false
  targetMaxScore = 600
  maxPlayerScore = 0
  local tempVar1 = 0
  local tempVar2 = 0
  local tempScore = 0
  local function getData(taskObject)
    if not getawayTO then
      getawayTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    end
    if taskObject.initiated and getawayTO then
      playerScore = math.ceil(taskObject.namedTasks.score and 0)
      playerScorePercent = math.floor(playerScore / targetMaxScore * 100)
      isTarget = getawayTO and getawayTO.namedTasks.owner and getawayTO.namedTasks.owner.networkVars.ownerID == taskObject.coreData.agent.playerID
      if playerScorePercent > 100 then
        playerScorePercent = 100
      end
      if isTarget then
        return taskObject.coreData.agent.name, playerScorePercent, playerScore, taskObject.coreData.agent.isLocal, 2, taskObject.coreData.agent.playerID
      else
        return taskObject.coreData.agent.name, playerScorePercent, playerScore, taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID
      end
    else
      tempVar1 = math.floor(instance.playerScores[taskObject.coreData.agent.playerID + 1] / bitOffset)
      tempVar2 = instance.playerScores[taskObject.coreData.agent.playerID + 1] - tempVar1 * bitOffset
      tempScore = tempVar1 + dropOffScores[tempVar2]
      playerScorePercent = math.floor(tempScore / targetMaxScore * 100)
      if playerScorePercent > 100 then
        playerScorePercent = 100
      end
      return taskObject.coreData.agent.name, playerScorePercent, tempScore, taskObject.coreData.agent.isLocal, false, taskObject.coreData.agent.playerID
    end
  end
  local function cleanup()
    getawayTO = false
    onlineSideBar.toggleSidebarTimerFlash(0)
    onlineSideBar.toggleTimerSidebarTitle(0)
    onlineSideBar.toggleSmallSidebarTitle(0)
    onlineSideBar.toggleProgressSidebarTitle(0)
  end
  return initiate, getData, cleanup, onlineSideBar.standardSortFuncs.playerScoreSort, false, false, true
end)
feedbackSystem.registerHUD("MP takedown start HUD", function(task, settings)
end, function(task)
  local instance = localPlayer.getTaskObject().coreData.instance
  local playedSpawnSound = false
  local function update()
    if not playedSpawnSound and instance and localPlayer.currentVehicle then
      local TO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
      if TO and TO.coreData.agent and TO.coreData.agent == localPlayer.currentVehicle then
        OneShotSound.Play("HUD_Online_TD_GetawayCarSpawn")
        playedSpawnSound = true
      elseif localPlayer.currentVehicle then
        OneShotSound.Play("ZAP_ZapIn_OneShot")
        playedSpawnSound = true
      end
    end
  end
  local cleanup = function()
  end
  return update, nil, nil, cleanup
end)
feedbackSystem.registerHUD("MP takedown main HUD", function(task, settings)
end, function(task)
  zapcontroller.EnableZapInput(true)
  local instance = task.instance
  local startTime = instance.networkVars.startTime
  local startScore
  local getawayTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  local owner, getawayShown, getawayColour128
  local maxTime = task.instance.challenge.settings.modeTimeLimit
  local stringFormat = "%02d"
  local format = string.format
  local mod = math.mod
  local sub = string.sub
  onlineInstructionSupport.resetPrompts()
  local resetPrompts = true
  local localPlayerTaskObject = localPlayer.getTaskObject()
  local previousPlayerScore = 0
  local messageStartTime = false
  local lastTargets = 0
  local getawayPlayerTO = false
  local function updateDropoffFeedback()
    if taskSystem.validTaskObject(getawayPlayerTO) and getawayPlayerTO.namedTasks.score then
      if getawayPlayerTO.namedTasks.score.networkVars.playerDropoffs ~= lastTargets then
        if getawayPlayerTO.coreData.agent.isLocal then
          OneShotSound.Play("MP_Player_Positive")
          feedbackSystem.eventMessages.addMessage(1, localPlayer.name, "ID:215498", "", getawayPlayerTO.coreData.agent.playerID, false, false)
        else
          OneShotSound.Play("MP_Player_Negative")
          feedbackSystem.eventMessages.addMessage(1, getawayPlayerTO.coreData.agent.name, "ID:215498", "", getawayPlayerTO.coreData.agent.playerID, false, false, false, getawayPlayerTO.coreData.agent.playerID ~= localPlayer.playerID)
        end
      end
      lastTargets = getawayPlayerTO.namedTasks.score.networkVars.playerDropoffs
    elseif taskSystem.validTaskObject(getawayTaskObject) and getawayTaskObject.namedTasks.score then
      local taskObj = false
      for i = 1, 8 do
        taskObj = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
        if taskObj and getawayTaskObject.namedTasks.owner.networkVars.ownerID == taskObj.coreData.agent.playerID then
          getawayPlayerTO = taskObj
          break
        end
      end
    end
  end
  local getawayTargetMarker, getawayMinimapMarker, getawayMinimapArrow
  local function clearMarkers(vehicle, keepLightTrail)
    if getawayTargetMarker then
      Marker:delete(getawayTargetMarker)
    end
    if getawayMinimapMarker then
      Marker:delete(getawayMinimapMarker)
    end
    if getawayMinimapArrow then
      Marker:delete(getawayMinimapArrow)
    end
    gamerTag.setPlayerMarkerModel(phaseManager.networkVars.nextTurnTaker, 5)
    gamerTag.setPlayerObjectiveMarker(phaseManager.networkVars.nextTurnTaker, false)
    if not keepLightTrail and vehicleManager.vehiclesBySNVID[vehicle.SNVID] then
      vehicle:removeLightTrail()
    end
  end
  local function getawayMarkers(owner, vehicle)
    clearMarkers(vehicle)
    if not owner then
      getawayMinimapArrow = Marker:create({
        type = "Minimap",
        gameVehicle = vehicle.gameVehicle,
        gadgetID = 257,
        colour = OnlineModeSettings.red32,
        radius = 40,
        visible = true,
        canrotate = true,
        nofade = true
      })
      getawayMinimapMarker = Marker:create({
        type = "Minimap",
        gameVehicle = vehicle.gameVehicle,
        gadgetID = 253,
        colour = OnlineModeSettings.red32,
        radius = 40,
        visible = true,
        canrotate = false,
        nofade = true
      })
      gamerTag.setPlayerMarkerModel(phaseManager.networkVars.nextTurnTaker, 180)
      gamerTag.setPlayerObjectiveMarker(phaseManager.networkVars.nextTurnTaker, true)
    end
    vehicle:addLightTrail(32, getawayColour128)
  end
  local healthBarMarker, getawayDamage
  local function stepVehicleHealthBar()
    if getawayDamage ~= getawayTaskObject.coreData.agent.gameVehicle.damage then
      getawayDamage = getawayTaskObject.coreData.agent.gameVehicle.damage
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Bar_Progress", math.ceil(100 - getawayDamage * 100))
      if getawayDamage >= 1 then
        OneShotSound.Play("HUD_Online_PriorityCarWrecked")
      end
      if localPlayer.currentVehicle and localPlayer.currentVehicle == getawayTaskObject.coreData.agent then
        if getawayDamage < 1 then
          OneShotSound.Play("HUD_Online_PriorityCarDamaged", false)
        end
      elseif not healthBarMarker then
        healthBarMarker = Marker:create({
          type = "World",
          facing = true,
          gameVehicle = getawayTaskObject.coreData.agent.gameVehicle,
          gadgetID = 97,
          scale = vec.vector(0.1, 0.1, 0.1, 0),
          offset = vec.vector(0, getawayTaskObject.coreData.agent.gameVehicle.height + 0.5, 0, 0),
          colour = vec.vector(255, 255, 255, 255),
          visible = true,
          uValue = getawayDamage,
          vValue = -getawayDamage
        })
      else
        healthBarMarker.uValue = getawayDamage
        healthBarMarker.vValue = -getawayDamage
      end
    end
  end
  if getawayTaskObject.coreData.isLocal and not localPlayer.missionSupport:isSubTaskObject(getawayTaskObject) then
    localPlayer.missionSupport:addSubTaskObject(getawayTaskObject, 1)
  end
  local lowTimeMessage = true
  local lowTimeFlash = true
  local timeRemaining
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
  local scored = false
  local opponents = {}
  local function stepInstructionPrompts()
    if resetPrompts then
      onlineInstructionSupport.setPrompts(true, not owner, false, false, false, not owner, not owner, not owner, not owner, true, false, not owner, not owner, false)
      if owner then
        onlineInstructionSupport.setPrompt("score", true, 5, 40, "ID:234304")
        onlineInstructionSupport.modifyPrompt("score", "button", iconsTable.target)
        onlineInstructionSupport.modifyPrompt("boost", "message", "ID:234305")
      else
        onlineInstructionSupport.setPrompt("score", true, 10, 20, "ID:234306")
        onlineInstructionSupport.modifyPrompt("score", "button", iconsTable.multiTakedownRed)
      end
      resetPrompts = false
    end
    if owner then
      opponents = {}
      for playerID, player in next, playerManager.players, nil do
        if playerID ~= localPlayer.playerID then
          table.insert(opponents, {
            vehicle = player.currentVehicle,
            position = player.position
          })
        end
      end
      if getawayTaskObject.namedTasks.checkpoints.networkVars.checkpoints ~= previousPlayerScore then
        scored = true
        previousPlayerScore = getawayTaskObject.namedTasks.checkpoints.networkVars.checkpoints
      else
        scored = false
      end
    else
      opponents = {}
      for playerID, player in next, playerManager.players, nil do
        if playerID ~= localPlayer.playerID and playerID ~= getawayTaskObject.namedTasks.owner.networkVars.ownerID then
          table.insert(opponents, {
            vehicle = player.currentVehicle,
            position = player.position
          })
        end
      end
      if getawayTaskObject.coreData.agent.damage ~= previousPlayerScore then
        scored = true
        previousPlayerScore = getawayTaskObject.coreData.agent.damage
      else
        scored = false
      end
    end
    onlineInstructionSupport.step(getawayTaskObject.coreData.agent.position, opponents, scored)
  end
  local function update()
    updateModeTimer()
    if not startScore then
      if localPlayerTaskObject.namedTasks and localPlayerTaskObject.namedTasks.score and localPlayerTaskObject.namedTasks and localPlayerTaskObject.namedTasks.score and localPlayerTaskObject.namedTasks.score.takedownStartScore then
        startScore = localPlayerTaskObject.namedTasks.score.takedownStartScore
      end
    elseif localPlayerTaskObject.namedTasks and localPlayerTaskObject.namedTasks.score and startScore and getawayTaskObject.namedTasks and getawayTaskObject.namedTasks.owner then
      if getawayTaskObject.namedTasks.owner.networkVars.ownerID == localPlayer.playerID then
        feedbackSystem.multiplayerSupport.updateBehindVehicleFeedback(localPlayerTaskObject.namedTasks.score.networkVars.playerScore - startScore, 4, false, nil, 2)
      else
        feedbackSystem.multiplayerSupport.updateBehindVehicleFeedback(localPlayerTaskObject.namedTasks.score.networkVars.playerScore - startScore)
      end
    end
    if not getawayTaskObject then
      getawayTaskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    elseif getawayTaskObject.namedTasks and getawayTaskObject.namedTasks.owner and getawayTaskObject.namedTasks.owner.networkVars.ownerID ~= -1 then
      if not getawayColour128 then
        owner = getawayTaskObject.namedTasks.owner.networkVars.ownerID == localPlayer.playerID
        if owner then
          getawayColour128 = OnlineModeSettings.blue128
        else
          getawayColour128 = OnlineModeSettings.red128
        end
      end
      if getawayTaskObject.namedTasks.owner and not getawayShown and playerManager.players[getawayTaskObject.namedTasks.owner.networkVars.ownerID] then
        getawayShown = true
        getawayMarkers(owner, getawayTaskObject.coreData.agent)
        getawayTaskObject.coreData.agent:disableMinimapMarker(true)
        local playerIsGetaway = getawayTaskObject.namedTasks.owner.networkVars.ownerID == localPlayer.playerID
        feedbackSystem.eventMessages.addMessage(1, playerManager.players[getawayTaskObject.namedTasks.owner.networkVars.ownerID].name, "ID:243732", "", getawayTaskObject.namedTasks.owner.networkVars.ownerID, false, false, false, not playerIsGetaway)
        if not owner then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:220244", playerManager.players[getawayTaskObject.namedTasks.owner.networkVars.ownerID].name)
        else
          feedbackSystem.menusMaster.primaryTextPrompt("ID:169357")
          messageStartTime = g_NetworkTime
          addUserUpdateFunction("firstDropOffValueMsg", function()
            if g_NetworkTime - messageStartTime > 2.5 then
              feedbackSystem.menusMaster.primaryTextPrompt("ID:243287", tostring(dropOffScores[1]))
              removeUserUpdateFunction("firstDropOffValueMsg")
            end
          end, 1)
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 1)
        end
      end
      for i = 1, 8 do
        local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
        if taskObject and taskObject.namedTasks and taskObject.namedTasks.score and taskObject.namedTasks.score.networkVars.playerScore > maxPlayerScore then
          maxPlayerScore = taskObject.namedTasks.score.networkVars.playerScore
        end
      end
      stepInstructionPrompts()
      stepVehicleHealthBar()
      updateDropoffFeedback()
    end
  end
  local function cleanup(taskObject)
    local fromPurge = taskObject.coreData.instance.deleteFromPurge
    removeUserUpdateFunction("firstDropOffValueMsg")
    if not fromPurge then
      local isGetaway = false
      if getawayTaskObject.namedTasks and getawayTaskObject.namedTasks.owner and getawayTaskObject.namedTasks.owner.networkVars.ownerID == localPlayer.playerID then
        isGetaway = true
      end
      for playerID, player in next, playerManager.players, nil do
        if playerID ~= localPlayer.playerID then
          if isGetaway then
            feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.red32, OnlineModeSettings.red128)
          elseif getawayTaskObject.namedTasks and getawayTaskObject.namedTasks.owner and getawayTaskObject.namedTasks.owner.networkVars.ownerID == playerID then
            feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.red32, OnlineModeSettings.red128)
          else
            feedbackSystem.multiplayerSupport.setPlayerHighlight(playerID + 1, OnlineModeSettings.blue32, OnlineModeSettings.blue128)
          end
        end
      end
      if getawayTaskObject.coreData and getawayTaskObject.coreData.agent and (getawayTaskObject.coreData.agent.controlled or getawayTaskObject.coreData.agent.networkControlled) then
        getawayTaskObject.coreData.agent:disableLightTrailAutoDelete(true)
        feedbackSystem.multiplayerSupport.addWorldMarker("lightTrail", getawayTaskObject.coreData.agent)
      end
    end
    if getawayTaskObject.coreData and getawayTaskObject.coreData.agent then
      if fromPurge or not getawayTaskObject.coreData.agent.controlled and not getawayTaskObject.coreData.agent.networkControlled then
        clearMarkers(getawayTaskObject.coreData.agent)
      else
        clearMarkers(getawayTaskObject.coreData.agent, true)
      end
    end
    feedbackSystem.multiplayerSupport.hideBehindVehicleFeedback()
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 0)
    if healthBarMarker then
      Marker:delete(healthBarMarker)
      healthBarMarker = nil
    end
  end
  return update, nil, nil, cleanup
end)
