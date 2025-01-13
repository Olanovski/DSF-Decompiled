module("onlineScreenManager", package.seeall)
local stackStartTime = 0
local screenStartTime = 0
local displayLength = 0
local endLength = 0
local screenSet = false
local timeRemaining = 0
local playerSortType = false
local rewardScreenComplete = true
local teamCompleteScreenComplete = true
local autoRewards = false
local showRewards = false
local rewardsSet = false
local autoRwdStTime = false
local rewardScreenShown = false
local enterTeamCompleteScreen, updateScreenInformation, updateTeamCompleteScreen, exitTeamCompleteScreen
local function getPlayerIDFromEntry(entry)
  if not rewardsSet then
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
  else
    return false
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
  assert(false, "ONLINE SCREEN MANAGER: onlineScreenTeamComplete - getEntryFromPlayerID. Trying to get a entry position for a player that is not registered with the screen manager.")
end
local function preEnterCompleteScreen()
  teamCompleteScreenComplete = false
end
local function getCompleteScreenStatus()
  return teamCompleteScreenComplete
end
local function setCompleteScreenComplete()
  teamCompleteScreenComplete = true
end
function enterTeamCompleteScreen(startTime, displayTime, sortType, missionName, endTime, localScreenStartTime)
  assert(onlineScreenData[missionName], "SCREEN NOT STARTED: " .. tostring(missionName) .. " ENTRY NOT IN THE SCREEN DATA TABLE")
  if onlineScreenData[missionName] then
    phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeResults)
    stackStartTime = startTime
    screenStartTime = localScreenStartTime
    displayLength = displayTime
    playerSortType = sortType
    endLength = endTime
    OneShotSound.Play("MP_ModeComplete_Team", false)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMultiplayer_IconType", onlineScreenData[missionName].screenIconID)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_complete_banner_Game_Type", onlineScreenData[missionName].displayTitle .. ": ")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_team_your_team", "ID:168515")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_team_their_team", "ID:168516")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:220615")
    OneShotSound.Play("HUD_Online_ScoreBoard")
    clearVoiceChatIcons()
    local nextMode = phaseManager.playlistSupport.getCurrentMission()
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_qualifying_next_game", onlineScreenData[nextMode].displayTitle)
    if phaseManager.playlistSupport.networkVars.faceOffsEnabled then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:235620")
    else
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:220615")
    end
    local teamData = getTeamData()
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_team_score_total_blue", teamData[1].targetScore)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_team_score_total_red", teamData[2].targetScore)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_team_score_current_blue", teamData[1].currentScore)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_team_score_current_red", teamData[2].currentScore)
    if phaseManager.networkVars.toFewPlayersType == 0 then
      if teamData[1].currentScore > teamData[2].currentScore then
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_complete_banner_complete", "ID:168512")
        feedbackSystem.menusMaster.onlineHUDSetVariable("iShield_Colour", 0)
      elseif teamData[1].currentScore < teamData[2].currentScore then
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_complete_banner_complete", "ID:168513")
        feedbackSystem.menusMaster.onlineHUDSetVariable("iShield_Colour", 1)
      else
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_complete_banner_complete", "ID:169321")
        feedbackSystem.menusMaster.onlineHUDSetVariable("iShield_Colour", 0)
      end
    else
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_complete_banner_complete", "ID:169320")
      feedbackSystem.menusMaster.onlineHUDSetVariable("iShield_Colour", 1)
    end
    updateScreenInformation()
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 5)
    autoRwdStTime = screenStartTime + SMModeResultLength
    screenSet = true
    rewardsSet = false
    rewardScreenShown = false
    if 0 < getNumRewards() then
      showRewards = true
      completeScreenOn = true
      if onlineProgressionSystem.getLocalPlayerPreviousXP() >= onlineProgressionSystem.onlineLevelData[#onlineProgressionSystem.onlineLevelData].xp then
        autoRewards = false
      else
        autoRewards = true
      end
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reward_Button_Visible", 1)
    else
      showRewards = false
      completeScreenOn = false
      autoRewards = false
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reward_Button_Visible", 0)
    end
    Network.setScriptPlayerListShowing(true)
  end
end
local function setCoreTimers(startTime, displayTime, endTime)
  stackStartTime = startTime
  displayLength = displayTime
  endLength = endTime
end
function updateScreenInformation()
  local playerTable = getScreenCurrentPlayerTable(playerSortType)
  local numOfPlayers = 0
  for i, player in ipairs(playerTable) do
    if player then
      numOfPlayers = numOfPlayers + 1
    else
      break
    end
  end
  assert(numOfPlayers > 0, "No players found in the player data table")
  local localTeam = -1
  local numTeam1 = 0
  local numTeam2 = 0
  for i, player in ipairs(playerTable) do
    if player then
      if player.id == localPlayer.playerID then
        localTeam = player.team
      end
      if player.team == 1 then
        numTeam1 = numTeam1 + 1
      elseif player.team == 2 then
        numTeam2 = numTeam2 + 1
      end
    else
      break
    end
  end
  assert(localTeam > 0, "CANNOT SETUP TEAM COMPLETE SCREEN - LOCAL TEAM IS NOT SET: " .. tostring(localTeam) .. " NUM ON TEAM 1: " .. tostring(numTeam1) .. " NUM ON TEAM 2: " .. tostring(numTeam2))
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
  local playerXP = 0
  local playerScore = 0
  local playerLevel = 0
  local previousLevel = 0
  for i, player in ipairs(playerTable) do
    if player then
      if player.team == localTeam then
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
      playerXP = 0
      playerScore = player.score or 0
      playerLevel = 0
      previousLevel = 0
      if player.xp and player.previousXP then
        playerXP = player.xp - player.previousXP
      end
      if player.xp then
        playerLevel = onlineProgressionSystem.getLevelFromXP(player.xp)
      end
      if player.previousXP then
        previousLevel = onlineProgressionSystem.getLevelFromXP(player.previousXP)
      end
      if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
        feedbackSystem.menusMaster.onlineHUDSetVariable(playerLevelUpString[listI], 0)
      else
        feedbackSystem.menusMaster.onlineHUDSetVariable(playerLevelUpString[listI], 0)
      end
      PlayerGamePlay.setPlayerListIconPosition(player.id, listI)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerMultiNameStrings[listI], player.name)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerMultiScoreStrings[listI], playerScore)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerMultiLevelStrings[listI], playerLevel)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerCompRankStrings[listI], playerRankValueStrings[PosI])
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerRankStrings[listI], playerRankValueStrings[PosI])
      if player.id == localPlayer.playerID then
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Selection", listI)
      end
    else
      break
    end
  end
  screenUpdated()
end
local function endRewardScreen()
  OneShotSound.Play("MP_ModeComplete_Team_NoShield", false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 14)
  clearVoiceChatIcons()
  updateScreenInformation()
  rewardsSet = false
  Network.setScriptPlayerListShowing(true)
  rewardScreens.exitScreen(true)
end
local function toggleRewardScreen()
  if not rewardsSet then
    autoRewards = false
    rewardScreens.enterScreen(g_NetworkTime, math.ceil(endLength - (g_NetworkTime - screenStartTime)), endRewardScreen, not rewardScreenShown)
    Network.setScriptPlayerListShowing(false)
    rewardScreens.setRewardScreenManual()
    rewardsSet = true
    if not rewardScreenShown then
      rewardScreenShown = true
    end
  end
end
local function progressRewardScreen()
  if rewardsSet then
    rewardScreens.progressRewardScreen()
    autoRewards = false
  end
end
local prevTime
function updateTeamCompleteScreen()
  if screenSet then
    if getUpdateRequired() and not rewardsSet then
      updateScreenInformation()
    end
    if showRewards then
      if autoRewards and g_NetworkTime > autoRwdStTime and not rewardsSet then
        rewardScreens.enterScreen(g_NetworkTime, math.ceil(endLength - (g_NetworkTime - screenStartTime)), endRewardScreen, not rewardScreenShown)
        Network.setScriptPlayerListShowing(false)
        rewardsSet = true
        if not rewardScreenShown then
          rewardScreenShown = true
        end
      elseif rewardsSet then
        rewardScreens.updateScreen()
      end
    end
    timeRemaining = math.ceil(displayLength - (g_NetworkTime - stackStartTime))
    if timeRemaining < 0.1 then
      timeRemaining = 0
    end
    if prevTime ~= timeRemaining then
      if timeRemaining < 5 then
        OneShotSound.Play("HUD_Online_GameStart_Timer_Countdown", false)
      end
      prevTime = timeRemaining
    end
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_starting_in_seconds", timeRemaining)
  end
end
function exitTeamCompleteScreen()
  if not rewardsSet then
    OneShotSound.Play("MP_Generic_Outro_01", false)
  end
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 0)
  screenSet = false
  displayLength = 0
  stackStartTime = 0
  completeScreenOn = false
  teamCompleteScreenComplete = true
  completeScreenOn = false
  rewardScreens.exitScreen()
  clearTeamData()
  onlineScreenManager.setBlueTeamCurrentScore(0)
  onlineScreenManager.setRedTeamCurrentScore(0)
  Network.setScriptPlayerListShowing(false)
  Menu.UnloadMPImages()
end
local teamCompleteScreen = {
  enterScreen = enterTeamCompleteScreen,
  updateScreen = updateTeamCompleteScreen,
  exitScreen = exitTeamCompleteScreen,
  preEnter = preEnterCompleteScreen,
  getStatus = getCompleteScreenStatus,
  toggleRewards = toggleRewardScreen,
  progressRewards = progressRewardScreen,
  finishScreen = setCompleteScreenComplete,
  updateCoreData = setCoreTimers,
  getPlayerIDFromEntry = getPlayerIDFromEntry,
  getEntryFromPlayerID = getEntryFromPlayerID,
  teams = true
}
addScreen(TeamCompleteScreenIndex, "TEAM COMPLETE SCREEN", teamCompleteScreen)
