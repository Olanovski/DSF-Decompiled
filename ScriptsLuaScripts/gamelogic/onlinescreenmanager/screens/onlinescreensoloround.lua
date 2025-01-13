module("onlineScreenManager", package.seeall)
local screenStartTime = 0
local displayLength = 0
local endLength = 0
local screenSet = false
local timeRemaining = 0
local playerSortType = false
local roundScreenComplete = true
local isRaceData = false
local showTotals = false
local round = 0
local modeName = false
local gameStarting = false
local searching = false
local enterSoloRoundScreen, updateScreenInformation, updateSoloRoundScreen, exitSoloRoundScreen
local getPlayerIDFromEntry = function(entry)
  local playerTable = getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.score)
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
  assert(false, "ONLINE SCREEN MANAGER: onlineScreenSoloRound - getEntryFromPlayerID. Trying to get a entry position for a player that is not registered with the screen manager.")
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
function enterSoloRoundScreen(startTime, displayTime, sortType, missionName, endTime)
  assert(onlineScreenData[missionName], "SCREEN NOT STARTED: " .. tostring(missionName) .. " ENTRY NOT IN THE SCREEN DATA TABLE")
  if onlineScreenData[missionName] then
    screenStartTime = startTime
    displayLength = displayTime
    playerSortType = sortType
    endLength = endTime
    showTotals = false
    modeName = missionName
    gameStarting = false
    searching = false
    OneShotSound.Play("MP_ModeRound_Solo", false)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_round_complete_races", onlineScreenData[missionName].displayTitle)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_round_complete_title", "ID:242342", challengeSystem.instances[phaseManager.networkVars.modeID].networkVars.roundOn - 1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:220615")
    if challengeSystem.instances[phaseManager.networkVars.modeID].networkVars.roundOn == challengeSystem.instances[phaseManager.networkVars.modeID].challenge.settings.numRounds and onlineScreenData[missionName].finalRoundScreenText then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_qualifying_next_game", onlineScreenData[missionName].finalRoundScreenText)
    else
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_qualifying_next_game", onlineScreenData[missionName].roundScreenText, challengeSystem.instances[phaseManager.networkVars.modeID].networkVars.roundOn)
    end
    clearVoiceChatIcons()
    updateScreenInformation()
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 9)
    screenSet = true
    Network.setScriptPlayerListShowing(true)
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
  assert(numOfPlayers > 0, "No players found in player data table or bad sort in onlineScreenManager.getScreenCurrentPlayerTable")
  if numOfPlayers > 4 then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Blue_Team", 4)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Red_Team", numOfPlayers - 4)
  else
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Blue_Team", numOfPlayers)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Red_Team", 0)
  end
  local playerLevel = 0
  for i, player in ipairs(playerTable) do
    if player then
      playerLevel = 0
      if player.xp then
        playerLevel = onlineProgressionSystem.getLevelFromXP(player.xp)
      end
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerRankStrings[i], playerRankValueStrings[i])
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerNameStrings[i], player.name)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerLevelStrings[i], playerLevel)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerScoreStrings[i], player.score)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerMultiRankStrings[i], playerRankValueStrings[i])
      if 0 < player.roundScore and onlineScreenData[modeName].showRoundScores and challengeSystem.instances[phaseManager.networkVars.modeID].networkVars.roundOn > 2 then
        feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerRoundScoreTextString[i], "(+%d)", player.roundScore)
        feedbackSystem.menusMaster.onlineHUDSetVariable(playerRoundScoreString[i], 1)
      else
        feedbackSystem.menusMaster.onlineHUDSetVariable(playerRoundScoreString[i], 0)
      end
      PlayerGamePlay.setPlayerListIconPosition(player.id, i)
      if player.id == localPlayer.playerID then
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Selection", i)
      end
    else
      break
    end
  end
  screenUpdated()
end
function updateSoloRoundScreen()
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
function exitSoloRoundScreen()
  OneShotSound.Play("MP_Generic_Outro_01", false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 0)
  screenSet = false
  displayLength = 0
  screenStartTime = 0
  roundScreenComplete = true
  if isRaceData then
    onlineScreenManager.setRaceCompleteData(false)
    isRaceData = false
  end
  Network.setScriptPlayerListShowing(false)
end
local getOutroSceneName = function()
  return "multi_round_complete_outro", 22
end
local soloRoundScreen = {
  enterScreen = enterSoloRoundScreen,
  updateScreen = updateSoloRoundScreen,
  exitScreen = exitSoloRoundScreen,
  preEnter = preEnterRoundScreen,
  getStatus = getRoundScreenStatus,
  finishScreen = setRoundScreenComplete,
  updateCoreData = setCoreTimers,
  getPlayerIDFromEntry = getPlayerIDFromEntry,
  getEntryFromPlayerID = getEntryFromPlayerID,
  getOutroSceneName = getOutroSceneName,
  teams = false
}
addScreen(SoloRoundCompleteScreenIndex, "SOLO GAME ROUND COMPLETE SCREEN", soloRoundScreen)
