module("onlineScreenManager", package.seeall)
local screenStartTime = 0
local displayLength = 0
local screenSet = false
local timeRemaining = 0
local playerSortType = false
local rewardScreenComplete = true
local teamIntroScreenComplete = true
local teamSwappingSet = false
local playerTeam = 0
local swapRequest = false
local playerTable = false
local tfpTimerStall = false
local joinTimerStall = false
local gameStarting = false
local timerStalled = false
local enterTeamIntroScreen, updateScreenInformation, updateTeamIntroScreen, exitTeamIntroScreen
local function getPlayerIDFromEntry(entry)
  local playerTable = getScreenCurrentPlayerTable(playerSortType)
  local localTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  local redi = 5
  local bluei = 1
  local listI = 0
  for i, player in ipairs(playerTable) do
    if player then
      if PlayerGamePlay.getPlayerTeam(player.id) == localTeam then
        listI = bluei
        bluei = bluei + 1
      else
        listI = redi
        redi = redi + 1
      end
      if listI == entry then
        return player.id
      end
    else
      break
    end
  end
  return -1
end
local function getEntryFromPlayerID(playerID)
  local playerTable = getScreenCurrentPlayerTable(playerSortType)
  local localTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  local redi = 5
  local bluei = 1
  local listI = 0
  for i, player in ipairs(playerTable) do
    if player then
      if PlayerGamePlay.getPlayerTeam(player.id) == localTeam then
        listI = bluei
        bluei = bluei + 1
      else
        listI = redi
        redi = redi + 1
      end
      if player.id == playerID then
        return listI
      end
    else
      break
    end
  end
  print("------------- FAILED TO FIND PLAYER: " .. tostring(playerID))
  printTable(playerTable)
  callStack()
  assert(false, "ONLINE SCREEN MANAGER: onlineScreenTeamIntro - getEntryFromPlayerID. Trying to get a entry position for a player that is not registered with the screen manager.")
end
local function preEnterIntroScreen()
  teamIntroScreenComplete = false
end
local prevTime = 0
local function getIntroScreenStatus()
  if teamSwappingSet or timerStalled then
    if g_NetworkTime - prevTime > 0.15 then
      prevTime = g_NetworkTime
    end
    return g_NetworkTime > phaseManager.networkVars.screenBlockEndTime
  end
  return teamIntroScreenComplete
end
local function setIntroScreenComplete()
  teamIntroScreenComplete = true
end
local getTotalTeamScores = function(missionName, missionData)
  local yourTeam, theirTeam = 0, 0
  if missionName == "MP burning rubber" then
    local checkpointsPerLap = #missionData.spawnPositions[phaseManager.networkVars.modeAreaIndex].route
    theirTeam = (missionData.settings.totalLaps + 1) * checkpointsPerLap
    yourTeam = theirTeam
  elseif missionName == "MP rush down" then
    theirTeam = missionData.spawnPositions[phaseManager.networkVars.modeAreaIndex].targetScore
    yourTeam = theirTeam
  elseif missionName == "MP tug of war" then
    theirTeam = missionData.spawnPositions[phaseManager.networkVars.modeAreaIndex].targetScore
    yourTeam = theirTeam
  end
  return yourTeam, theirTeam
end
local currentModeID = 0
local noTargetScore = false
function enterTeamIntroScreen(startTime, displayTime, sortType, missionName, endTime, localScreenStartTime)
  assert(onlineScreenData[missionName], "SCREEN NOT STARTED: " .. tostring(missionName) .. " ENTRY NOT IN THE SCREEN DATA TABLE")
  phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeIntro)
  screenStartTime = startTime
  displayLength = displayTime
  playerSortType = sortType
  currentModeID = 0
  OneShotSound.Play("MP_ModeIntro_Team", false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 4)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_game_title", onlineScreenData[missionName].displayTitle)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_goal", onlineScreenData[missionName].description1)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMultiplayer_IconType", onlineScreenData[missionName].screenIconID)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_starting_in", "ID:220615")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_qualifying_next_game", "")
  clearVoiceChatIcons()
  local description2Value = false
  if onlineScreenData[missionName].description2_Func then
    description2Value = onlineScreenData[missionName].description2_Func()
  end
  if description2Value then
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_tag_line", onlineScreenData[missionName].description2, description2Value)
  else
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_tag_line", onlineScreenData[missionName].description2)
  end
  local missionData = cardSystem.createMission(missionName)
  if missionData.spawnPositions[phaseManager.networkVars.modeAreaIndex].targetScore then
    yourTotalScore, theirTotalScore = getTotalTeamScores(missionName, missionData)
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_team_score_total_blue", yourTotalScore)
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_team_score_total_red", theirTotalScore)
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_team_score_slash_blue", " / ")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_team_score_slash_red", " / ")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_team_score_current_blue", 0)
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_team_score_current_red", 0)
  else
    noTargetScore = true
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_team_score_total_blue", "")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_team_score_total_red", "")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_team_score_slash_blue", "")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_team_score_slash_red", "")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_team_score_current_blue", "")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_team_score_current_red", "")
  end
  for i = 0, 7 do
    feedbackSystem.menusMaster.onlineHUDSetVariable(playerTeamSwapString[i], 0)
    lastTeamSwap[i].swapID = 0
    lastTeamSwap[i].listPosition = 1
    currentTeamSwap[i].swapID = 0
    currentTeamSwap[i].listPosition = 1
  end
  for playerID, player in next, playerManager.players, nil do
    updatePlayerTeam(playerID, PlayerGamePlay.getPlayerTeam(playerID))
  end
  triggerScreenUpdate()
  updateScreenInformation()
  targetEndTime = localScreenStartTime + endTime
  if phaseManager.isLocal then
    phaseManager.networkVars.nextTurnTaker = 0
    teamSwappingSet = false
  else
    teamSwappingSet = 0 < phaseManager.networkVars.nextTurnTaker and phaseManager.networkVars.nextTurnTaker < 255
    if teamSwappingSet then
      clearCurrentScreenEarlyEndTime()
      feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_starting_in", "ID:243723")
      feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_starting_in_seconds", "")
    end
  end
  local missionData = cardSystem.createMission(missionName)
  local requiredNumPlayers = missionData.settings.minPlayers / 2
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeIntro)
    phaseManager.setupTimeToScoreUpdate(requiredNumPlayers, true, phaseManager.timeToJoinScore.modeIntro, phaseManager.timeToJoinScore.modeIntroUnbPlayers, phaseManager.timeToJoinScore.modeIntroTFPlayers)
    phaseManager.updateTimeToScoreValue()
  end
  joinTimerStall = false
  tfpTimerStall = false
  gameStarting = false
  screenSet = true
  introScreenOn = true
  onlineScreenManager.activateInstructionButton()
  if phaseManager.isComp() and phaseManager.missionIntroData[missionName].getPlayCount and phaseManager.missionIntroData[missionName].getPlayCount() < minNumPlaysForAutoInstructions or phaseManager.isCoop() then
    displayInstructionScreen()
  end
  if (gameStatus.onlineSessionType == gameStatus.onlineSessionID.private or gameStatus.onlineIsLan) and phaseManager.networkVars.phase ~= RunModeStateIndex then
    onlineScreenManager.activateTeamSwapButton()
  end
  Network.setScriptPlayerListShowing(true)
  PlayerGamePlay.allowTeamShuffling(true)
end
local function setCoreTimers(startTime, displayTime)
  screenStartTime = startTime
  displayLength = displayTime
end
function updateScreenInformation()
  playerTable = getScreenCurrentPlayerTable(playerSortType)
  local numOfPlayers = 0
  for i, player in ipairs(playerTable) do
    if player then
      numOfPlayers = numOfPlayers + 1
    else
      break
    end
  end
  assert(numOfPlayers > 0, "No players found in player data table")
  local localTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  local numTeam1 = 0
  local numTeam2 = 0
  for playerID, player in next, playerManager.players, nil do
    if player then
      if PlayerGamePlay.getPlayerTeam(playerID) == 1 then
        numTeam1 = numTeam1 + 1
      elseif PlayerGamePlay.getPlayerTeam(playerID) == 2 then
        numTeam2 = numTeam2 + 1
      end
    else
      break
    end
  end
  local teamData = getTeamData()
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_team_score_current_blue", teamData[1].currentScore)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_team_score_current_red", teamData[2].currentScore)
  if localTeam == 1 then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Red_Team", numTeam2)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Blue_Team", numTeam1)
  else
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Red_Team", numTeam1)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Blue_Team", numTeam2)
  end
  local redi = 5
  local bluei = 1
  local listI = 0
  local BPosI = 1
  local RPosI = 1
  local PosI = 0
  local playerLevel = 0
  for i, player in ipairs(playerTable) do
    if player then
      if PlayerGamePlay.getPlayerTeam(player.id) == localTeam then
        listI = bluei
        PosI = BPosI
        bluei = bluei + 1
        BPosI = BPosI + 1
      else
        listI = redi
        PosI = RPosI
        redi = redi + 1
        RPosI = RPosI + 1
      end
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerRankStrings[listI], playerRankValueStrings[PosI])
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerNameStrings[listI], player.name)
      playerLevel = 0
      if player.xp then
        playerLevel = onlineProgressionSystem.getLevelFromXP(player.xp)
      end
      PlayerGamePlay.setPlayerListIconPosition(player.id, listI)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerLevelStrings[listI], playerLevel)
      if player.id == localPlayer.playerID then
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Selection", listI)
      end
      if gameStatus.onlineSessionType == gameStatus.onlineSessionID.private or gameStatus.onlineIsLan then
        if currentTeamSwap[player.id].swapID ~= lastTeamSwap[player.id].swapID or (currentTeamSwap[player.id].swapID == lastTeamSwap[player.id].swapID and lastTeamSwap[player.id].swapID == 1 or currentTeamSwap[player.id].swapID ~= lastTeamSwap[player.id].swapID) and currentTeamSwap[player.id].listPosition ~= lastTeamSwap[player.id].listPosition then
          feedbackSystem.menusMaster.onlineHUDSetVariable(playerTeamSwapString[listI], currentTeamSwap[player.id].swapID)
          if currentTeamSwap[player.id].swapID ~= lastTeamSwap[player.id].swapID then
            if currentTeamSwap[player.id].swapID == 1 then
              OneShotSound.Play("MP_ModeIntro_TeamSwapIconIn")
            elseif currentTeamSwap[player.id].swapID == 2 or currentTeamSwap[player.id].swapID == 0 then
              OneShotSound.Play("MP_ModeIntro_TeamSwapIconOut")
            end
          end
        end
        if currentTeamSwap[player.id].swapID == 1 then
          feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerTeamSwapTextString[listI], "ID:245972")
        elseif currentTeamSwap[player.id].swapID == 2 or currentTeamSwap[player.id].swapID == 0 then
          feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerTeamSwapTextString[listI], "ID:245973")
        end
      end
    else
      break
    end
  end
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.private or gameStatus.onlineIsLan then
    local free = true
    for i = 1, 8 do
      free = true
      for playerID, player in next, playerManager.players, nil do
        if currentTeamSwap[playerID].listPosition == i and currentTeamSwap[playerID].swapID ~= 0 then
          free = false
          break
        end
      end
      if free then
        feedbackSystem.menusMaster.onlineHUDSetVariable(playerTeamSwapString[i], 0)
      end
    end
  end
  screenUpdated()
end
local function initTeamSwapSync()
  teamSwappingSet = true
  clearCurrentScreenEarlyEndTime()
  if phaseManager.isLocal and phaseManager.networkVars.nextTurnTaker == 0 then
    if phaseManager.networkVars.screenBlockEndTime - phaseManager.networkVars.screenBlockStartTime < 10 then
      phaseManager.networkVars.screenBlockEndTime = phaseManager.networkVars.screenBlockEndTime + 10
    end
    phaseManager.networkVars.nextTurnTaker = 1
    phaseManager.networkVars.screenBlockEndTime = phaseManager.networkVars.screenBlockEndTime + 5
  end
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:243723")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_starting_in_seconds", "")
end
local updateTeamSwapSync = function()
  if phaseManager.networkVars.nextTurnTaker + 1 < 4 then
    phaseManager.networkVars.nextTurnTaker = phaseManager.networkVars.nextTurnTaker + 1
    phaseManager.networkVars.screenBlockEndTime = phaseManager.networkVars.screenBlockEndTime + 5
  end
end
local prevTime
function updateTeamIntroScreen()
  if screenSet then
    if getUpdateRequired() then
      updateScreenInformation()
    end
    if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
      phaseManager.updateTimeToScoreValue()
    end
    if timerStalled and displayLength ~= phaseManager.networkVars.screenBlockEndTime - screenStartTime then
      displayLength = phaseManager.networkVars.screenBlockEndTime - screenStartTime
    end
    timeRemaining = math.ceil(displayLength - (g_NetworkTime - screenStartTime))
    if timeRemaining < 0.1 then
      timeRemaining = 0
    end
    if prevTime ~= timeRemaining then
      if timeRemaining <= 15 then
        OneShotSound.Play("HUD_Online_GameStart_Timer_Countdown", false)
      end
      prevTime = timeRemaining
    end
    if not teamSwappingSet then
      if phaseManager.playerShortage and not tfpTimerStall then
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:242130")
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_starting_in_seconds", "")
        tfpTimerStall = true
      elseif not phaseManager.playerShortage and tfpTimerStall then
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:220615")
        joinTimerStall = false
        tfpTimerStall = false
        gameStarting = false
        timerStalled = true
        if timeRemaining < 5 and phaseManager.isLocal then
          phaseManager.networkVars.screenBlockEndTime = g_NetworkTime + 5
        end
      end
      if not tfpTimerStall then
        if timeRemaining == 0 then
          if phaseManager.playlistSupport.networkVars.playerJoining and not joinTimerStall then
            feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:246289")
            feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_starting_in_seconds", "")
            joinTimerStall = true
            phaseManager.playersJoiningLock = true
            if phaseManager.isLocal and phaseManager.playlistSupport.networkVars.joiningStartTime == 0 then
              phaseManager.playlistSupport.networkVars.joiningStartTime = g_NetworkTime
            end
          elseif not phaseManager.playlistSupport.networkVars.playerJoining and joinTimerStall then
            feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:220615")
            joinTimerStall = false
            tfpTimerStall = false
            gameStarting = false
            timerStalled = true
            if timeRemaining < 5 and phaseManager.isLocal then
              phaseManager.networkVars.screenBlockEndTime = g_NetworkTime + 5
            end
          elseif not phaseManager.playlistSupport.networkVars.playerJoining and not gameStarting then
            feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:242129")
            feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_starting_in_seconds", "")
            gameStarting = true
          end
        else
          if gameStarting or joinTimerStall or tfpTimerStall then
            feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:220615")
            gameStarting = false
            joinTimerStall = false
            tfpTimerStall = false
          end
          feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_starting_in_seconds", timeRemaining)
        end
      end
    end
    playerTable = getPlayerScreenDataTable()
    playerTeam = 0
    if isTeamSwapButtonActivated() and (not teamSwappingSet and targetEndTime - g_NetworkTime <= 2 or teamSwappingSet and phaseManager.networkVars.screenBlockEndTime - g_NetworkTime <= 2) then
      desactivateTeamSwapButton()
      if teamSwappingSet then
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:242129")
        for i = 0, 7 do
          if currentTeamSwap[i].swapID ~= 2 then
            feedbackSystem.menusMaster.onlineHUDSetVariable(playerTeamSwapString[i + 1], 0)
            currentTeamSwap[i].swapID = 0
            currentTeamSwap[i].listPosition = 1
          end
        end
        triggerScreenUpdate()
      end
    end
    for playerID, player in next, playerManager.players, nil do
      playerTeam = PlayerGamePlay.getPlayerTeam(playerID)
      if (gameStatus.onlineSessionType == gameStatus.onlineSessionID.private or gameStatus.onlineIsLan) and isTeamSwapButtonActivated() then
        lastTeamSwap[playerID].swapID = currentTeamSwap[playerID].swapID
        lastTeamSwap[playerID].listPosition = currentTeamSwap[playerID].listPosition
        swapRequest = PlayerGamePlay.isPlayerRequestingTeamSwitch(playerID)
        currentTeamSwap[playerID].swapID = swapRequest and 0
        currentTeamSwap[playerID].listPosition = getEntryFromPlayerID(playerID)
        if lastTeamSwap[playerID].swapID == 2 and currentTeamSwap[playerID].swapID == 0 then
          setTeamSwapPromptText(1)
          if 2 < g_NetworkTime - currentTeamSwap[playerID].swapTime then
            currentTeamSwap[playerID].swapID = 0
            lastTeamSwap[playerID].swapID = 1
            currentTeamSwap[playerID].swapTime = 0
          else
            currentTeamSwap[playerID].swapID = 2
            lastTeamSwap[playerID].swapID = 2
          end
        end
      end
      if playerTeam ~= playerTable[playerID].team or currentTeamSwap[playerID].swapID ~= lastTeamSwap[playerID].swapID then
        if (gameStatus.onlineSessionType == gameStatus.onlineSessionID.private or gameStatus.onlineIsLan) and isTeamSwapButtonActivated() and g_NetworkTime - screenStartTime > 0.5 then
          if playerTeam ~= playerTable[playerID].team then
            lastTeamSwap[playerID].swapID = 0
            currentTeamSwap[playerID].swapID = 2
            currentTeamSwap[playerID].swapTime = g_NetworkTime
          end
          if playerID == localPlayer.playerID then
            if currentTeamSwap[playerID].swapID == 0 or currentTeamSwap[playerID].swapID == 2 then
              setTeamSwapPromptText(1)
            else
              setTeamSwapPromptText(2)
            end
          end
          if not teamSwappingSet then
            initTeamSwapSync()
          elseif teamSwappingSet and phaseManager.isLocal and phaseManager.networkVars.screenBlockEndTime - g_NetworkTime > 2 and playerTable[playerID].teamSwap == 0 then
            updateTeamSwapSync()
          end
        end
        updatePlayerTeam(playerID, playerTeam)
        triggerScreenUpdate()
      end
    end
  end
end
function exitTeamIntroScreen()
  OneShotSound.Play("MP_Generic_Outro_02", false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 0)
  screenSet = false
  displayLength = 0
  screenStartTime = 0
  introScreenOn = false
  playerTable = false
  teamIntroScreenComplete = true
  timerStalled = false
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.private or gameStatus.onlineIsLan then
    onlineScreenManager.desactivateTeamSwapButton()
  end
  for i = 0, 7 do
    feedbackSystem.menusMaster.onlineHUDSetVariable(playerTeamSwapString[i + 1], 0)
    lastTeamSwap[i].swapID = 0
    lastTeamSwap[i].listPosition = 1
    currentTeamSwap[i].swapID = 0
    currentTeamSwap[i].listPosition = 1
  end
  Network.setScriptPlayerListShowing(false)
  if phaseManager.isLocal then
    phaseManager.networkVars.nextTurnTaker = 255
  end
  PlayerGamePlay.allowTeamShuffling(false)
  phaseManager.clearTimeToScoreUpdate()
end
local getOutroSceneName = function()
  return "multi_start_team_outro", 25
end
local teamIntroScreen = {
  enterScreen = enterTeamIntroScreen,
  updateScreen = updateTeamIntroScreen,
  exitScreen = exitTeamIntroScreen,
  preEnter = preEnterIntroScreen,
  getStatus = getIntroScreenStatus,
  finishScreen = setIntroScreenComplete,
  updateCoreData = setCoreTimers,
  getPlayerIDFromEntry = getPlayerIDFromEntry,
  getEntryFromPlayerID = getEntryFromPlayerID,
  getOutroSceneName = getOutroSceneName,
  teams = true
}
addScreen(TeamIntroScreenIndex, "TEAM INTRO SCREEN", teamIntroScreen)
