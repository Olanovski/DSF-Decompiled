module("onlineScreenManager", package.seeall)
local screenStartTime = 0
local displayLength = 0
local endLength = 0
local screenSet = false
local timeRemaining = 0
local playerSortType = false
local soloCompleteScreenComplete = true
local faceOffCompleteScreenComplete = true
local setRewards = false
local numRewards = 1
local updateScreenInformation, updateSoloCompleteScreen, exitSoloCompleteScreen, enterFaceOffCompleteScreen
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
  callStack()
  assert(false, "ONLINE SCREEN MANAGER: onlineScreenFaceOffComplete - getEntryFromPlayerID. Trying to get a entry position for player ID " .. playerID .. " that is not registered with the screen manager.")
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
function enterFaceOffCompleteScreen(startTime, displayTime, sortType, missionName)
  assert(onlineScreenData[missionName], "SCREEN NOT STARTED: " .. tostring(missionName) .. " ENTRY NOT IN THE SCREEN DATA TABLE")
  screenStartTime = startTime
  displayLength = displayTime
  playerSortType = sortType
  local nextMode = phaseManager.playlistSupport.getCurrentMission()
  assert(onlineScreenData[nextMode], "FACE OFF SCREEN NOT STARTED: " .. tostring(nextMode) .. " ENTRY NOT IN THE SCREEN DATA TABLE")
  local faceoffRewards = onlineScreenData[nextMode].faceOffRewards
  if faceoffRewards == 2 and not onlineProgressionSystem.areZapWeaponsUnlocked() then
    faceoffRewards = 1
  end
  if faceoffRewards == 0 then
    OneShotSound.Play("MP_FaceOffComplete_Norm", false)
  elseif faceoffRewards == 1 then
    OneShotSound.Play("MP_FaceOffComplete_Norm_Ability", false)
  else
    OneShotSound.Play("MP_FaceOffComplete_Norm_Ability_WeaponCharge", false)
  end
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 12)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMultiplayer_IconType", onlineScreenData[missionName].screenIconID)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Qualifying_Rewards_Display", faceoffRewards)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_qualifying_next_game", onlineScreenData[nextMode].displayTitle)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_game_title", "ID:220727")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_goal", onlineScreenData[missionName].description1)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:220615")
  local description2Value = false
  if onlineScreenData[missionName].description2_Func then
    description2Value = onlineScreenData[missionName].description2_Func()
  end
  if description2Value then
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_tag_line", onlineScreenData[missionName].description2, description2Value)
  else
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_tag_line", onlineScreenData[missionName].description2)
  end
  clearVoiceChatIcons()
  Network.setScriptPlayerListShowing(true)
  screenSet = true
  setRewards = false
  numRewards = faceoffRewards
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Qualifying_ShiftBar", 0)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Qualifying_WeaponsBar", 0)
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    local missionData = cardSystem.createMission(phaseManager.playlistSupport.getCurrentMission())
    local isTeamGame = missionData.settings.teamGame
    local requiredNumPlayers = missionData.settings.minPlayers
    if isTeamGame then
      requiredNumPlayers = requiredNumPlayers / 2
    end
    phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.faceOffResults)
    phaseManager.setupTimeToScoreUpdate(requiredNumPlayers, isTeamGame, phaseManager.timeToJoinScore.faceOffResults, phaseManager.timeToJoinScore.faceOffResultsUnbPlayers, phaseManager.timeToJoinScore.faceOffResultsTFPlayers)
    phaseManager.updateTimeToScoreValue()
  end
  updateScreenInformation()
  PlayerGamePlay.allowTeamShuffling(true)
end
local function setCoreTimers(startTime, displayTime, endTime)
  screenStartTime = startTime
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
  NetworkLog.Write(">[LUA] - Faceoff complete data")
  NetworkLog.Write("          sortType = " .. tostring(playerSortType))
  print("--------------------------------- onlineScreenFaceOffComplete: sortType = " .. tostring(playerSortType))
  for i, player in ipairs(playerTable) do
    if player then
      print("-- onlineScreenFaceOffComplete: Player: " .. tostring(i) .. " ID: " .. tostring(player.id) .. "  score: " .. tostring(player.score) .. " isLocal = " .. tostring(player.id == localPlayer.playerID))
      NetworkLog.Write("          Player: " .. tostring(i) .. " ID: " .. tostring(player.id) .. "  score: " .. tostring(player.score) .. " isLocal = " .. tostring(player.id == localPlayer.playerID))
    else
      print("-- onlineScreenFaceOffComplete: Player: " .. tostring(i) .. " is False")
      NetworkLog.Write("          Player: " .. tostring(i) .. " is False")
    end
  end
  NetworkLog.Write(">[LUA] - End faceoff complete data")
  if numOfPlayers > 4 then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Blue_Team", 4)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Red_Team", numOfPlayers - 4)
  else
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Blue_Team", numOfPlayers)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Number_Of_Players_Red_Team", 0)
  end
  local playerScore = 0
  local playerLevel = 0
  for i, player in ipairs(playerTable) do
    if player then
      local playerScore = player.score or 0
      if player.xp then
        playerLevel = onlineProgressionSystem.getLevelFromXP(player.xp)
      end
      PlayerGamePlay.setPlayerListIconPosition(player.id, i)
      feedbackSystem.menusMaster.currentHUDSetTextVariable(playerRankStrings[i], playerRankValueStrings[i])
      feedbackSystem.menusMaster.currentHUDSetTextVariable(playerNameStrings[i], player.name)
      feedbackSystem.menusMaster.currentHUDSetTextVariable(playerLevelStrings[i], playerLevel)
      if player.id == localPlayer.playerID and not setRewards then
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_grid_position_number", i)
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_highlight_grid_position", i)
        if numRewards > 0 then
          local zapFuel = player.secondaryScore or 0
          local weaponFuel = player.weaponFuel or 0
          if numRewards == 2 then
            feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Qualifying_WeaponsBar", 1)
          else
            weaponFuel = 0
          end
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Qualifying_ShiftBar", 1)
          feedbackSystem.multiplayerSupport.purgeProgBarFiller()
          if zapFuel > 0 then
            feedbackSystem.multiplayerSupport.addBarFill(1, 4, "iMulti_Qualifying_ShiftBar", zapFuel / scoreSystem.getMaxAbility() * 200, 2, function()
              OneShotSound.PlayGUI("HUD_Gen_Currency_Increase_Play", false)
            end, function()
              OneShotSound.PlayGUI("HUD_Gen_Currency_Increase_Stop", false)
            end)
          end
          if weaponFuel > 0 then
            feedbackSystem.multiplayerSupport.addBarFill(1, 1, "iMulti_Qualifying_WeaponsBar", weaponFuel / zapWeaponSupport.getZapWeaponCooldown() * 100, 2, function()
              OneShotSound.PlayGUI("HUD_Gen_Currency_Increase_Play", false)
            end, function()
              OneShotSound.PlayGUI("HUD_Gen_Currency_Increase_Stop", false)
            end)
          end
        end
        setRewards = true
      end
      if player.id == localPlayer.playerID then
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Selection", i)
      end
    else
      break
    end
  end
  if phaseManager.networkVars.toFewPlayersType == 0 then
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_complete_banner_complete", "ID:100213")
  else
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_complete_banner_complete", "ID:169320")
  end
  screenUpdated()
end
local prevTime
function updateSoloCompleteScreen()
  if screenSet then
    if getUpdateRequired() then
      updateScreenInformation()
    end
    if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
      phaseManager.updateTimeToScoreValue()
    end
    timeRemaining = math.ceil(displayLength - (g_NetworkTime - screenStartTime))
    if timeRemaining < 0.1 then
      timeRemaining = 0
    end
    if prevTime ~= timeRemaining then
      if timeRemaining < 5 then
        OneShotSound.Play("HUD_Online_GameStart_Timer_Countdown", false)
      end
      prevTime = timeRemaining
    end
    feedbackSystem.multiplayerSupport.updateBarFiller()
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_starting_in_seconds", timeRemaining)
  end
end
function exitSoloCompleteScreen()
  feedbackSystem.multiplayerSupport.purgeProgBarFiller()
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 0)
  OneShotSound.Play("MP_Generic_Outro_01", false)
  screenSet = false
  displayLength = 0
  screenStartTime = 0
  completeScreenOn = false
  soloCompleteScreenComplete = true
  rewardScreens.exitScreen()
  if isRaceData then
    onlineScreenManager.setRaceCompleteData(false)
    isRaceData = false
  end
  phaseManager.clearTimeToScoreUpdate()
  Network.setScriptPlayerListShowing(false)
  PlayerGamePlay.allowTeamShuffling(false)
end
local faceOffCompleteScreen = {
  enterScreen = enterFaceOffCompleteScreen,
  updateScreen = updateSoloCompleteScreen,
  exitScreen = exitSoloCompleteScreen,
  preEnter = preEnterScreen,
  getStatus = getScreenStatus,
  finishScreen = setCompleteScreenComplete,
  updateCoreData = setCoreTimers,
  getPlayerIDFromEntry = getPlayerIDFromEntry,
  getEntryFromPlayerID = getEntryFromPlayerID,
  teams = false
}
addScreen(FaceOffCompleteScreenIndex, "FACE OFF COMPLETE SCREEN", faceOffCompleteScreen)
