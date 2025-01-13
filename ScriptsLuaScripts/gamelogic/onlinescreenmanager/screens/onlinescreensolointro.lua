module("onlineScreenManager", package.seeall)
local screenStartTime = 0
local displayLength = 0
local screenSet = false
local timeRemaining = 0
local playerSortType = false
local numPlayersRequired = 0
local soloIntroScreenComplete = true
local waitScreenComplete = true
local joinScreenComplete = true
local requiredNumPlayers = 0
local isTeamGame = false
local teamOneCount = 0
local teamTwoCount = 0
local playerShortageA = 1
local playerShortageB = 1
local tfpTimerStall = false
local joinTimerStall = false
local gameStarting = false
local timerStalled = false
local enterSoloIntroScreen, enterWaitingScreen, updateScreenInformation, updateSoloIntroScreen, updateWaitingScreen, exitSoloScreen, getPlayerIDFromEntry
local function getPlayerIDFromEntry(entry)
  local playerTable = getScreenCurrentPlayerTable(playerSortType)
  if playerTable and playerTable[entry] then
    return playerTable[entry].id
  end
  return -1
end
local function getEntryFromPlayerID(playerID)
  local playerTable = getScreenCurrentPlayerTable(playerSortType)
  for i, player in ipairs(playerTable) do
    if player and player.id == playerID then
      return i
    end
  end
  print("------------- FAILED TO FIND PLAYER: " .. tostring(playerID))
  printTable(playerTable)
  callStack()
  assert(false, "ONLINE SCREEN MANAGER: onlineScreenSoloIntro - getEntryFromPlayerID. Trying to get a entry position for a player that is not registered with the screen manager.")
end
local function preEnterIntroScreen()
  soloIntroScreenComplete = false
end
local function getIntroScreenStatus()
  if timerStalled then
    return g_NetworkTime > phaseManager.networkVars.screenBlockEndTime
  end
  return soloIntroScreenComplete
end
local function preEnterWaitScreen()
  waitScreenComplete = false
end
local function getWaitScreenStatus()
  return waitScreenComplete
end
local function preEnterJoinScreen()
  joinScreenComplete = false
end
local function getJoinScreenStatus()
  return joinScreenComplete
end
local function setIntroScreenComplete()
  soloIntroScreenComplete = true
end
local function setWaitScreenComplete()
  waitScreenComplete = true
end
local function setJoinScreenComplete()
  joinScreenComplete = true
end
function enterSoloIntroScreen(startTime, displayTime, sortType, missionName)
  assert(onlineScreenData[missionName], "SCREEN NOT STARTED: " .. tostring(missionName) .. " ENTRY NOT IN THE SCREEN DATA TABLE")
  phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeIntro)
  screenStartTime = startTime
  displayLength = displayTime
  playerSortType = sortType
  OneShotSound.Play("MP_ModeIntro_Solo", false)
  feedbackSystem.menusMaster.currentHUDSetVariable("iMulti_Online_Screen_Show", 2)
  feedbackSystem.menusMaster.currentHUDSetVariable("iMultiplayer_IconType", onlineScreenData[missionName].screenIconID)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_game_title", onlineScreenData[missionName].displayTitle)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_goal", onlineScreenData[missionName].description1)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_starting_in", "ID:220615")
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_qualifying_next_game", "")
  local description2Value = false
  if onlineScreenData[missionName].description2_Func then
    description2Value = onlineScreenData[missionName].description2_Func()
  end
  if description2Value then
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_tag_line", onlineScreenData[missionName].description2, description2Value)
  else
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_tag_line", onlineScreenData[missionName].description2)
  end
  if not gameStatus.splitscreenSession then
    clearVoiceChatIcons()
  end
  if not onlineScreenData[missionName].disableInstructions then
    onlineScreenManager.activateInstructionButton()
  else
    onlineScreenManager.desactivateInstructionButton()
  end
  updateScreenInformation()
  if phaseManager.isComp(missionName) and phaseManager.missionIntroData[missionName] and phaseManager.missionIntroData[missionName].getPlayCount and phaseManager.missionIntroData[missionName].getPlayCount() < minNumPlaysForAutoInstructions or phaseManager.isCoop(missionName) then
    displayInstructionScreen()
  end
  joinTimerStall = false
  tfpTimerStall = false
  gameStarting = false
  screenSet = true
  introScreenOn = true
  screenSet = true
  introScreenOn = true
  local missionData = cardSystem.createMission(missionName)
  requiredNumPlayers = missionData.settings.minPlayers
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeIntro)
    phaseManager.setupTimeToScoreUpdate(requiredNumPlayers, false, phaseManager.timeToJoinScore.modeIntro, phaseManager.timeToJoinScore.modeIntroUnbPlayers, phaseManager.timeToJoinScore.modeIntroTFPlayers)
    phaseManager.updateTimeToScoreValue()
  end
  Network.setScriptPlayerListShowing(true)
  PlayerGamePlay.allowTeamShuffling(false)
end
local function setCoreTimers(startTime, displayTime)
  screenStartTime = startTime
  displayLength = displayTime
end
function enterWaitingScreen(startTime, displayTime, sortType, missionName)
  screenStartTime = startTime
  displayLength = displayTime
  playerSortType = sortType
  phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.waitForPlayers)
  OneShotSound.Play("MP_ModeIntro_Searching", false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 1)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_banner_seaching", "ID:100211")
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_banner_for_players", "ID:100212")
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_banner_more_players_needed", "ID:100210")
  feedbackSystem.menusMaster.currentHUDSetVariable("iMulti_ShowMenu_Display", 1)
  clearVoiceChatIcons()
  updateScreenInformation()
  screenSet = true
  Network.setScriptPlayerListShowing(true)
  local missionData = cardSystem.createMission(phaseManager.playlistSupport.getCurrentMission())
  isTeamGame = missionData.settings.teamGame
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.private then
    if missionData.settings.tutorial then
      numPlayersRequired = 1
    elseif isTeamGame then
      numPlayersRequired = 1
    else
      numPlayersRequired = 2
    end
  elseif isTeamGame then
    numPlayersRequired = missionData.settings.minPlayers / 2
  else
    numPlayersRequired = missionData.settings.minPlayers
  end
  teamOneCount = 0
  teamTwoCount = 0
  playerShortageA = 1
  playerShortageB = 1
  PlayerGamePlay.allowTeamShuffling(true)
end
function enterJoiningScreen(startTime, displayTime, sortType, missionName)
  screenStartTime = startTime
  displayLength = displayTime
  playerSortType = sortType
  phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.waitForPlayers)
  OneShotSound.Play("MP_ModeIntro_Searching", false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 1)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_banner_seaching", "ID:233159")
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_banner_for_players", "")
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_banner_more_players_needed", "")
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_banner_number_of_players_needed", "")
  feedbackSystem.menusMaster.currentHUDSetVariable("iMulti_ShowMenu_Display", 0)
  clearVoiceChatIcons()
  updateScreenInformation()
  screenSet = true
  Network.setScriptPlayerListShowing(true)
  player.DisableDisconnectOnInactivity()
  PlayerGamePlay.allowTeamShuffling(false)
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
  assert(numOfPlayers > 0, "No players found in player data table")
  if numOfPlayers > 4 then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Blue_Team", 4)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Red_Team", numOfPlayers - 4)
  else
    feedbackSystem.menusMaster.currentHUDSetVariable("iMulti_Number_Of_Players_Blue_Team", numOfPlayers)
    feedbackSystem.menusMaster.currentHUDSetVariable("iMulti_Number_Of_Players_Red_Team", 0)
  end
  local playerLevel = 0
  for i, player in ipairs(playerTable) do
    if player then
      feedbackSystem.menusMaster.currentHUDSetTextVariable(playerRankStrings[i], playerRankValueStrings[i])
      feedbackSystem.menusMaster.currentHUDSetTextVariable(playerNameStrings[i], player.name)
      playerLevel = 0
      if player.xp then
        playerLevel = onlineProgressionSystem.getLevelFromXP(player.xp)
      end
      PlayerGamePlay.setPlayerListIconPosition(player.id, i)
      feedbackSystem.menusMaster.currentHUDSetTextVariable(playerLevelStrings[i], playerLevel)
      if player.id == localPlayer.playerID then
        feedbackSystem.menusMaster.currentHUDSetVariable("iMulti_Selection", i)
      end
    else
      break
    end
  end
  screenUpdated()
end
local prevSecond
function updateSoloIntroScreen()
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
    if prevSecond ~= timeRemaining then
      if timeRemaining <= 5 then
        OneShotSound.Play("HUD_Online_GameStart_Timer_Countdown", false)
      end
      prevSecond = timeRemaining
    end
    if phaseManager.playerShortage and not tfpTimerStall then
      feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_starting_in", "ID:242130")
      feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_starting_in_seconds", "")
      tfpTimerStall = true
    elseif not phaseManager.playerShortage and tfpTimerStall then
      feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_starting_in", "ID:220615")
      joinTimerStall = false
      tfpTimerStall = false
      gameStarting = false
      timerStalled = true
      if timeRemaining < 5 and phaseManager.isLocal then
        phaseManager.networkVars.screenBlockEndTime = g_NetworkTime + 5
        timeRemaining = 5
      end
    end
    if not tfpTimerStall then
      if timeRemaining == 0 then
        if phaseManager.playlistSupport.networkVars.playerJoining and not joinTimerStall then
          feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_starting_in", "ID:246289")
          feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_starting_in_seconds", "")
          joinTimerStall = true
          phaseManager.playersJoiningLock = true
          if phaseManager.isLocal and phaseManager.playlistSupport.networkVars.joiningStartTime == 0 then
            phaseManager.playlistSupport.networkVars.joiningStartTime = g_NetworkTime
          end
        elseif not phaseManager.playlistSupport.networkVars.playerJoining and joinTimerStall then
          feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_starting_in", "ID:220615")
          joinTimerStall = false
          tfpTimerStall = false
          gameStarting = false
          timerStalled = true
          if phaseManager.isLocal then
            phaseManager.networkVars.screenBlockEndTime = g_NetworkTime + 5
          end
        elseif not phaseManager.playlistSupport.networkVars.playerJoining and not gameStarting then
          feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_starting_in", "ID:242129")
          feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_starting_in_seconds", "")
          gameStarting = true
        end
      else
        if gameStarting or joinTimerStall or tfpTimerStall then
          feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_starting_in", "ID:220615")
          gameStarting = false
          joinTimerStall = false
          tfpTimerStall = false
        end
        feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_start_starting_in_seconds", timeRemaining)
      end
    end
  end
end
function updateWaitingScreen()
  if screenSet then
    if getUpdateRequired() then
      updateScreenInformation()
    end
    if not isTeamGame then
      local numPlayers = 0
      for playerID, player in next, playerManager.players, nil do
        if phaseManager.currentStateList[playerID + 1] == WaitingForPlayersStateIndex then
          numPlayers = numPlayers + 1
        end
      end
      playerShortageA = numPlayersRequired - numPlayers
      playerShortageB = 0
    else
      teamOneCount = 0
      teamTwoCount = 0
      local playerTeam = -1
      for playerID, player in next, playerManager.players, nil do
        if phaseManager.currentStateList[playerID + 1] == WaitingForPlayersStateIndex then
          playerTeam = PlayerGamePlay.getPlayerTeam(playerID)
          if playerTeam == 1 then
            teamOneCount = teamOneCount + 1
          elseif playerTeam == 2 then
            teamTwoCount = teamTwoCount + 1
          end
        end
      end
      playerShortageA = numPlayersRequired - teamOneCount
      playerShortageB = numPlayersRequired - teamTwoCount
    end
    if playerShortageA < 0 then
      playerShortageA = 0
    end
    if playerShortageB < 0 then
      playerShortageB = 0
    end
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_banner_number_of_players_needed", playerShortageA + playerShortageB)
  end
end
function updateJoiningScreen()
  if screenSet and getUpdateRequired() then
    updateScreenInformation()
  end
end
function exitSoloScreen()
  if introScreenOn then
    OneShotSound.Play("MP_Generic_Outro_02", false)
  end
  feedbackSystem.menusMaster.currentHUDSetVariable("iMulti_Online_Screen_Show", 0)
  screenSet = false
  displayLength = 0
  screenStartTime = 0
  soloIntroScreenComplete = true
  waitScreenComplete = true
  joinScreenComplete = true
  introScreenOn = false
  timerStalled = false
  phaseManager.clearTimeToScoreUpdate()
  Network.setScriptPlayerListShowing(false)
  PlayerGamePlay.allowTeamShuffling(false)
end
local getOutroSceneName = function()
  if introScreenOn then
    return "multi_start_outro", 22
  else
    return "multi_searching_outro", 0
  end
end
local waitForPlayersScreen = {
  enterScreen = enterWaitingScreen,
  updateScreen = updateWaitingScreen,
  exitScreen = exitSoloScreen,
  preEnter = preEnterWaitScreen,
  getStatus = getWaitScreenStatus,
  finishScreen = setWaitScreenComplete,
  updateCoreData = setCoreTimers,
  getPlayerIDFromEntry = getPlayerIDFromEntry,
  getEntryFromPlayerID = getEntryFromPlayerID,
  teams = false
}
local soloIntroScreen = {
  enterScreen = enterSoloIntroScreen,
  updateScreen = updateSoloIntroScreen,
  exitScreen = exitSoloScreen,
  preEnter = preEnterIntroScreen,
  getStatus = getIntroScreenStatus,
  finishScreen = setIntroScreenComplete,
  updateCoreData = setCoreTimers,
  getPlayerIDFromEntry = getPlayerIDFromEntry,
  getEntryFromPlayerID = getEntryFromPlayerID,
  getOutroSceneName = getOutroSceneName,
  teams = false
}
local joiningScreen = {
  enterScreen = enterJoiningScreen,
  updateScreen = updateJoiningScreen,
  exitScreen = exitSoloScreen,
  preEnter = preEnterJoinScreen,
  getStatus = getJoinScreenStatus,
  finishScreen = setJoinScreenComplete,
  updateCoreData = setCoreTimers,
  getPlayerIDFromEntry = getPlayerIDFromEntry,
  getEntryFromPlayerID = getEntryFromPlayerID,
  getOutroSceneName = getOutroSceneName,
  teams = false
}
addScreen(WaitForPlayersScreenIndex, "WAITING FOR PLAYERS SCREEN", waitForPlayersScreen)
addScreen(SoloIntroScreenIndex, "SOLO GAME INTRO SCREEN", soloIntroScreen)
addScreen(JoiningScreenIndex, "JOINING SCREEN", joiningScreen)
