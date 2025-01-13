module("onlineScreenManager", package.seeall)
local stackStartTime = 0
local screenStartTime = 0
local displayLength = 0
local endLength = 0
local screenSet = false
local timeRemaining = 0
local playerSortType = false
local soloCompleteScreenComplete = true
local autoRewards = false
local showRewards = false
local rewardsSet = false
local isRaceData = false
local autoRwdStTime = false
local rewardScreenShown = false
local enterSoloCompleteScreen, updateScreenInformation, updateSoloCompleteScreen, exitSoloCompleteScreen
local function getPlayerIDFromEntry(entry)
  if not rewardsSet then
    local playerTable = getScreenCurrentPlayerTable(playerSortType)
    if playerTable and playerTable[entry] then
      return playerTable[entry].id
    end
  else
    return false
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
  assert(false, "ONLINE SCREEN MANAGER: onlineScreenSoloComplete - getEntryFromPlayerID. Trying to get a entry position for a player that is not registered with the screen manager.")
end
local function preEnterScreen()
  soloCompleteScreenComplete = false
end
local function getScreenStatus()
  return soloCompleteScreenComplete
end
local function setCompleteScreenComplete()
  soloCompleteScreenComplete = true
end
function enterSoloCompleteScreen(startTime, displayTime, sortType, missionName, endTime, localScreenStartTime)
  assert(onlineScreenData[missionName], "SCREEN NOT STARTED: " .. tostring(missionName) .. " ENTRY NOT IN THE SCREEN DATA TABLE")
  if onlineScreenData[missionName] then
    phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeResults)
    stackStartTime = startTime
    screenStartTime = localScreenStartTime
    displayLength = displayTime
    playerSortType = sortType
    endLength = endTime
    local playerTable = getScreenCurrentPlayerTable(playerSortType)
    assert(playerTable[1], "No players found in the player data table or a bad sort has occured in onlineScreenManager.getScreenCurrentPlayerTable")
    if playerTable[1].id == localPlayer.playerID then
      feedbackSystem.menusMaster.onlineHUDSetVariable("iShield_Colour", 0)
    else
      feedbackSystem.menusMaster.onlineHUDSetVariable("iShield_Colour", 1)
    end
    OneShotSound.Play("MP_ModeComplete_Solo", false)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 3)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMultiplayer_IconType", onlineScreenData[missionName].screenIconID)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_complete_banner_Game_Type", onlineScreenData[missionName].displayTitle .. ": ")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_complete_banner_xp_earned", "ID:184141")
    local nextMode = phaseManager.playlistSupport.getCurrentMission()
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_qualifying_next_game", onlineScreenData[nextMode].displayTitle)
    if phaseManager.playlistSupport.networkVars.faceOffsEnabled then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:235620")
    else
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:220615")
    end
    clearVoiceChatIcons()
    screenSet = true
    rewardsSet = false
    rewardScreenShown = false
    isRaceData = onlineScreenManager.isRaceCompleteData()
    if isRaceData then
      playerSortType = onlineScreenManager.screenSortTypes.race
    end
    autoRwdStTime = screenStartTime + SMModeResultLength
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
    updateScreenInformation()
    Network.setScriptPlayerListShowing(true)
  end
end
local function setCoreTimers(startTime, displayTime, endTime)
  stackStartTime = startTime
  displayLength = displayTime
  endLength = endTime
end
function updateScreenInformation()
  local isRaceData = onlineScreenManager.isRaceCompleteData()
  local playerTable = false
  if isRaceData then
    playerTable = getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.race)
  else
    playerTable = getScreenCurrentPlayerTable(playerSortType)
  end
  local numOfPlayers = 0
  for i, player in ipairs(playerTable) do
    if player then
      numOfPlayers = numOfPlayers + 1
    else
      break
    end
  end
  assert(numOfPlayers > 0, "updateScreenInformation - No Players found in player data table")
  if numOfPlayers > 4 then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Blue_Team", 4)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Red_Team", numOfPlayers - 4)
  else
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Blue_Team", numOfPlayers)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Red_Team", 0)
  end
  local rank = 0
  local lastScore = -1
  local playerXP = 0
  local playerScore = 0
  local playerLevel = 0
  local previousLevel = 0
  for i, player in ipairs(playerTable) do
    if player then
      playerXP = 0
      playerScore = player.score or 0
      playerLevel = 0
      previousLevel = 0
      if player.xp then
        playerLevel = onlineProgressionSystem.getLevelFromXP(player.xp)
      end
      if player.xp and player.previousXP then
        playerXP = player.xp - player.previousXP
      end
      if player.previousXP then
        previousLevel = onlineProgressionSystem.getLevelFromXP(player.previousXP)
      end
      if not isRaceData then
        if player.score ~= lastScore then
          rank = i
        end
        lastScore = player.score
      else
        if player.secondaryScore ~= lastScore then
          rank = i
        end
        lastScore = player.secondaryScore
      end
      PlayerGamePlay.setPlayerListIconPosition(player.id, i)
      if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
        feedbackSystem.menusMaster.onlineHUDSetVariable(playerLevelUpString[i], 0)
      else
        feedbackSystem.menusMaster.onlineHUDSetVariable(playerLevelUpString[i], 0)
      end
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerMultiNameStrings[i], player.name)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerMultiScoreStrings[i], playerScore)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerMultiLevelStrings[i], playerLevel)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(playerCompRankStrings[i], playerRankValueStrings[rank])
      if player.id == localPlayer.playerID then
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Selection", i)
      end
    else
      break
    end
  end
  local score1 = false
  local score2 = false
  if not isRaceData then
    if playerTable[1] and playerTable[1].score then
      score1 = playerTable[1].score
    end
    if playerTable[2] and playerTable[2].score then
      score2 = playerTable[2].score
    end
  else
    if playerTable[1] and playerTable[1].secondaryScore then
      score1 = playerTable[1].secondaryScore
    end
    if playerTable[2] and playerTable[2].secondaryScore then
      score2 = playerTable[2].secondaryScore
    end
  end
  if phaseManager.networkVars.toFewPlayersType == 0 then
    if score2 and score1 and score1 == score2 then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_complete_banner_complete", "ID:169321")
    elseif score1 then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_complete_banner_complete", "ID:220235", playerTable[1].name)
    end
  else
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_complete_banner_complete", "ID:169320")
  end
  screenUpdated()
end
local function endRewardScreen()
  OneShotSound.Play("MP_ModeComplete_Solo_NoShield", false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 13)
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
function updateSoloCompleteScreen()
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
function exitSoloCompleteScreen()
  if not rewardsSet then
    OneShotSound.Play("MP_Generic_Outro_01", false)
  end
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 0)
  screenSet = false
  displayLength = 0
  stackStartTime = 0
  completeScreenOn = false
  soloCompleteScreenComplete = true
  rewardScreens.exitScreen()
  if isRaceData then
    onlineScreenManager.setRaceCompleteData(false)
    isRaceData = false
  end
  Network.setScriptPlayerListShowing(false)
  Menu.UnloadMPImages()
end
local soloCompleteScreen = {
  enterScreen = enterSoloCompleteScreen,
  updateScreen = updateSoloCompleteScreen,
  exitScreen = exitSoloCompleteScreen,
  preEnter = preEnterScreen,
  getStatus = getScreenStatus,
  toggleRewards = toggleRewardScreen,
  progressRewards = progressRewardScreen,
  finishScreen = setCompleteScreenComplete,
  updateCoreData = setCoreTimers,
  getPlayerIDFromEntry = getPlayerIDFromEntry,
  getEntryFromPlayerID = getEntryFromPlayerID,
  teams = false
}
addScreen(SoloCompleteScreenIndex, "SOLO COMPLETE SCREEN", soloCompleteScreen)
