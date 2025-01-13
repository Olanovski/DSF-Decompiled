module("onlineScreenManager", package.seeall)
local screenStartTime = 0
local displayLength = 0
local endLength = 0
local screenSet = false
local timeRemaining = 0
local playerSortType = false
local roundScreenComplete = true
local isRaceData = false
local playersShown = true
local showTotals = false
local round = 0
local gameStarting = false
local searching = false
local enterTeamRoundScreen, updateScreenInformation, updateTeamRoundScreen, exitTeamRoundScreen
local getPlayerIDFromEntry = function(entry)
  local playerTable = getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.score)
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
local getEntryFromPlayerID = function(playerID)
  local playerTable = getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.score)
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
  assert(false, "ONLINE SCREEN MANAGER: onlineScreenTeamRound - getEntryFromPlayerID. Trying to get a entry position for a player that is not registered with the screen manager.")
end
local function preEnterRoundScreen()
  roundScreenComplete = false
end
local function getRoundScreenStatus()
  return roundScreenComplete
end
local function setCoreTimers(startTime, displayTime)
  screenStartTime = startTime
  displayLength = displayTime
end
local function setRoundScreenComplete()
  roundScreenComplete = true
end
function enterTeamRoundScreen(startTime, displayTime, sortType, missionName, endTime)
  assert(onlineScreenData[missionName], "SCREEN NOT STARTED: " .. tostring(missionName) .. " ENTRY NOT IN THE SCREEN DATA TABLE")
  if onlineScreenData[missionName] then
    screenStartTime = startTime
    displayLength = displayTime
    playerSortType = sortType
    endLength = endTime
    showTotals = false
    gameStarting = false
    searching = false
    OneShotSound.Play("MP_ModeRound_Team", false)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 10)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_round_complete_races", onlineScreenData[missionName].displayTitle)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_round_complete_title", "ID:242342", challengeSystem.instances[phaseManager.networkVars.modeID].networkVars.roundOn - 1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_team_your_team", "ID:168515")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_team_their_team", "ID:168516")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:220615")
    OneShotSound.Play("HUD_Online_ScoreBoard")
    clearVoiceChatIcons()
    if challengeSystem.instances[phaseManager.networkVars.modeID].networkVars.roundOn == challengeSystem.instances[phaseManager.networkVars.modeID].challenge.settings.numRounds and onlineScreenData[missionName].finalRoundScreenText then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_qualifying_next_game", onlineScreenData[missionName].finalRoundScreenText)
    else
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_qualifying_next_game", onlineScreenData[missionName].roundScreenText, challengeSystem.instances[phaseManager.networkVars.modeID].networkVars.roundOn)
    end
    local teamData = getTeamData()
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_team_score_total_blue", teamData[1].targetScore)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_team_score_total_red", teamData[2].targetScore)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_team_score_current_blue", teamData[1].currentScore)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_team_score_current_red", teamData[2].currentScore)
    updateScreenInformation()
    screenSet = true
    Network.setScriptPlayerListShowing(true)
    PlayerGamePlay.allowTeamShuffling(false)
    phaseManager.setTimeToJoinScore(phaseManager.missionIntroData[challengeSystem.instances[phaseManager.networkVars.modeID].challenge.name].timeToJoinScore)
  end
end
function updateScreenInformation()
  local playerTable = getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.score)
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
  local playerScore = 0
  local playerLevel = 0
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
      playerScore = player.score or 0
      playerLevel = 0
      if player.xp then
        playerLevel = onlineProgressionSystem.getLevelFromXP(player.xp)
      end
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerNameStrings[listI], player.name)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerLevelStrings[listI], playerLevel)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerScoreStrings[listI], playerScore)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerRankStrings[listI], playerRankValueStrings[PosI])
      PlayerGamePlay.setPlayerListIconPosition(player.id, listI)
      if player.id == localPlayer.playerID then
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Selection", listI)
      end
    else
      break
    end
  end
  screenUpdated()
end
function updateTeamRoundScreen()
  if screenSet then
    if getUpdateRequired() then
      updateScreenInformation()
    end
    timeRemaining = math.ceil(displayLength - (g_NetworkTime - screenStartTime))
    if timeRemaining < 0.1 then
      timeRemaining = 0
    end
    if timeRemaining > 0 then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_starting_in_seconds", timeRemaining)
    elseif not phaseManager.playerShortage and not gameStarting then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:242129")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_starting_in_seconds", "")
      phaseManager.setTimeToJoinScore(phaseManager.missionIntroData[challengeSystem.instances[phaseManager.networkVars.modeID].challenge.name].timeToJoinScore)
      gameStarting = true
      searching = false
    elseif phaseManager.playerShortage and not searching then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:242130")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_starting_in_seconds", "")
      phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeIntroTFPlayers)
      gameStarting = false
      searching = true
    end
  end
end
function exitTeamRoundScreen()
  OneShotSound.Play("MP_Generic_Outro_01", false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 0)
  screenSet = false
  displayLength = 0
  screenStartTime = 0
  roundScreenComplete = true
  onlineScreenManager.setBlueTeamCurrentScore(0)
  onlineScreenManager.setRedTeamCurrentScore(0)
  Network.setScriptPlayerListShowing(false)
end
local getOutroSceneName = function()
  return "multi_round_complete_team_outro", 25
end
local teamRoundScreen = {
  enterScreen = enterTeamRoundScreen,
  updateScreen = updateTeamRoundScreen,
  exitScreen = exitTeamRoundScreen,
  preEnter = preEnterRoundScreen,
  getStatus = getRoundScreenStatus,
  finishScreen = setRoundScreenComplete,
  updateCoreData = setCoreTimers,
  getPlayerIDFromEntry = getPlayerIDFromEntry,
  getEntryFromPlayerID = getEntryFromPlayerID,
  getOutroSceneName = getOutroSceneName,
  teams = true
}
addScreen(TeamRoundCompleteScreenIndex, "TEAM GAME ROUND COMPLETE SCREEN", teamRoundScreen)
