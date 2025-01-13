module("onlineScreenManager", package.seeall)
local soloResultScreenComplete = true
local timerOn = false
local displayActive = false
local displayTimeLimit = false
local displayStartTime = false
local displayTimeRemaining = false
local enterRaceResultsScreen, updateRaceResultsScreen, exitRaceResultsScreen
local function preEnterScreen()
  soloResultScreenComplete = false
end
local function getScreenStatus()
  return soloResultScreenComplete
end
local function setCompleteScreenComplete()
  soloResultScreenComplete = true
end
local getPositionString = function(position)
  if position == 1 then
    return "ID:220324"
  elseif position == 2 then
    return "ID:220325"
  elseif position == 3 then
    return "ID:220327"
  elseif position == 4 then
    return "ID:221138"
  elseif position == 5 then
    return "ID:221144"
  elseif position == 6 then
    return "ID:221145"
  elseif position == 7 then
    return "ID:221146"
  elseif position == 8 then
    return "ID:221180"
  end
  return ""
end
local function pureCircuitResultFunc(position, playerData, draw)
  local endDescription = "ID:236599"
  if phaseManager.modeTimedOut then
    endDescription = "ID:236594"
  end
  if position == 1 then
    if draw then
      return 2, "ID:169321", "ID:248781", "", ""
    else
      return 2, "ID:236595", "ID:248781", "", ""
    end
  else
    local raceWinnerName = ""
    if not phaseManager.modeTimedOut then
      local playerTable = getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.race)
      assert(playerTable[1], "No players found in the player data table or a bad sort in onlineScreenManager.getScreenCurrentPlayerTable")
      raceWinnerName = playerTable[1].name
    end
    return 1, getPositionString(position), endDescription, "", raceWinnerName
  end
end
local modeResultFunctions = {
  ["MP circuit race"] = pureCircuitResultFunc,
  ["MP pure race"] = pureCircuitResultFunc,
  ["MP sprint race"] = function(position, playerData, draw)
    if position == 1 then
      if draw then
        return 2, "ID:169321", "ID:220762", "", playerData.roundScore
      else
        return 2, "ID:236595", "ID:220762", "", playerData.roundScore
      end
    else
      return 1, getPositionString(position), "ID:220762", "", playerData.roundScore
    end
  end
}
local function getModeResultData(modeName, position, playerData, draw)
  if phaseManager.networkVars.toFewPlayersType ~= 0 then
    return 1, "ID:236575", "ID:236574", ""
  end
  return modeResultFunctions[modeName](position, playerData, draw)
end
function enterRaceResultsScreen(startTime, displayTime, sortType, missionName, endTime)
  assert(modeResultFunctions[missionName], "CAN'T SHOW MODE RESULT SCREEN - " .. missionName .. " - NOT IN THE RESULT FUNCTION TABLE")
  feedbackSystem.menusMaster.onlineHUDSetVariable("iAbility_Display", 0)
  localPlayer:showHUDElements(false)
  zapWeaponSupport.enableZapWeapons(false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 0)
  local isRaceData = onlineScreenManager.isRaceCompleteData()
  local forceSort = onlineScreenManager.getForceSortType()
  local playerTable = false
  local screenType = 1
  local string1 = "FAILED TO GET PLAYER RESULT DATA"
  local string2 = "FAILED TO GET PLAYER RESULT DATA"
  local string3 = "FAILED TO GET PLAYER RESULT DATA"
  local string4
  if isRaceData then
    playerTable = getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.race)
  elseif forceSort then
    playerTable = getScreenCurrentPlayerTable(forceSort)
    onlineScreenManager.setForceSortType(false)
  else
    playerTable = getScreenCurrentPlayerTable(sortType)
  end
  local score1 = false
  local score2 = false
  local draw = false
  if forceSort and forceSort == onlineScreenManager.screenSortTypes.round then
    if playerTable[1] and playerTable[1].roundScore then
      score1 = playerTable[1].roundScore
    end
    if playerTable[2] and playerTable[2].roundScore then
      score2 = playerTable[2].roundScore
    end
  elseif forceSort and forceSort == onlineScreenManager.screenSortTypes.race then
    if playerTable[1] and playerTable[1].secondaryScore then
      score1 = playerTable[1].secondaryScore
    end
    if playerTable[2] and playerTable[2].secondaryScore then
      score2 = playerTable[2].secondaryScore
    end
  elseif not isRaceData then
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
  if score2 and score1 and score1 == score2 then
    draw = true
  end
  NetworkLog.Write(">[LUA] - Results Banner data")
  NetworkLog.Write("          sortType = " .. tostring(sortType) .. " forceSort = " .. tostring(forceSort) .. " isRaceData = " .. tostring(isRaceData))
  for i, player in ipairs(playerTable) do
    if player then
      NetworkLog.Write("          Player: " .. tostring(i) .. " ID: " .. tostring(player.id) .. "  score: " .. tostring(player.score) .. "  sec score: " .. tostring(player.secondaryScore) .. " isLocal = " .. tostring(player.id == localPlayer.playerID))
    else
      NetworkLog.Write("          Player: " .. tostring(i) .. " is False")
    end
  end
  NetworkLog.Write(">[LUA] - End Results Banner data")
  for i, player in ipairs(playerTable) do
    if player then
      if player.id == localPlayer.playerID then
        screenType, string1, string2, string3, string4 = getModeResultData(missionName, i, player, draw)
        break
      end
    else
      break
    end
  end
  if screenType == 1 then
    OneShotSound.Play("MP_Result_Lost", false)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_you_lost", string1)
    if string4 then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_lost_description", string2, string4)
    else
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_lost_description", string2)
    end
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_lost_place", string3)
  elseif screenType == 2 then
    OneShotSound.Play("MP_Result_Won", false)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_you_won", string1)
    if string4 then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_won_description", string2, string4)
    else
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_won_description", string2)
    end
  elseif screenType == 3 then
    OneShotSound.Play("MP_Result_Draw", false)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_draw", string1)
  end
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_MatchResult", screenType)
  if challengeSystem.instances[phaseManager.networkVars.modeID] then
    local modeTimeRemaing = -1
    local modeTimeLimit = -1
    local modeStartTime = -1
    local overTimeLimit = -1
    local taskObject = localPlayer.getTaskObject()
    timerOn = true
    displayActive = false
    modeTimeLimit = challengeSystem.instances[phaseManager.networkVars.modeID].challenge.settings.modeTimeLimit
    modeStartTime = challengeSystem.instances[phaseManager.networkVars.modeID].networkVars.startTime
    modeTimeRemaing = modeTimeLimit - (g_NetworkTime - modeStartTime)
    if taskObject then
      for i, majorOrder in ipairs(taskObject.coreData.actor.taskList) do
        for j, minorOrder in ipairs(majorOrder) do
          if minorOrder.task == "MP race end timer" then
            overTimeLimit = minorOrder.taskConditions[1][2].params.value
            break
          end
        end
      end
    end
    if overTimeLimit > 0 and modeTimeRemaing > overTimeLimit then
      displayTimeLimit = overTimeLimit
      displayStartTime = -1
      displayTimeRemaining = overTimeLimit
    elseif modeStartTime > 0 then
      displayTimeLimit = modeTimeLimit
      displayStartTime = modeStartTime
      displayTimeRemaining = modeTimeLimit
    else
      timerOn = false
    end
  end
end
local setCoreTimers = function(startTime, displayTime, endTime)
end
function updateRaceResultsScreen()
  if timerOn then
    if challengeSystem.instances[phaseManager.networkVars.modeID] then
      if displayStartTime > 0 then
        if not displayActive then
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Ending_Timer", 1)
          displayActive = true
        end
        displayTimeRemaining = displayTimeLimit - (g_NetworkTime - displayStartTime)
        if displayTimeRemaining < -0.5 then
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Ending_Timer", 0)
          timerOn = false
          displayActive = false
          return
        end
        displayTimeRemaining = math.ceil(displayTimeRemaining)
        if displayTimeRemaining >= 10 then
          feedbackSystem.menusMaster.onlineHUDSetTextVariable("Multi_Race_Ending_Mins", tostring(displayTimeRemaining))
          feedbackSystem.menusMaster.onlineHUDSetTextVariable("Multi_Race_Ending_Secs", tostring(displayTimeRemaining))
        elseif displayTimeRemaining <= 0 then
          feedbackSystem.menusMaster.onlineHUDSetTextVariable("Multi_Race_Ending_Mins", "00")
          feedbackSystem.menusMaster.onlineHUDSetTextVariable("Multi_Race_Ending_Secs", "00")
        else
          feedbackSystem.menusMaster.onlineHUDSetTextVariable("Multi_Race_Ending_Mins", "0" .. tostring(displayTimeRemaining))
          feedbackSystem.menusMaster.onlineHUDSetTextVariable("Multi_Race_Ending_Secs", "0" .. tostring(displayTimeRemaining))
        end
      elseif 0 < onlineRaceManager.networkVars.raceEndTimer then
        displayStartTime = onlineRaceManager.networkVars.raceEndTimer
      end
    else
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Ending_Timer", 0)
      timerOn = false
      displayActive = false
    end
  end
end
function exitRaceResultsScreen()
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_MatchResult", 0)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Finished", 0)
  soloResultScreenComplete = true
  if localPlayer.currentVehicle then
    localPlayer.currentVehicle:stopHighSpeedDriving()
  end
  zap.enableZapSelection()
  localPlayer.mpEndOfRaceSetDestination = false
  for localID, plr in next, localPlayerManager.players, nil do
    plr:blockAbility("zap", false)
  end
  if timerOn then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Ending_Timer", 0)
    timerOn = false
    displayActive = false
  end
end
local raceCompleteScreen = {
  enterScreen = enterRaceResultsScreen,
  updateScreen = updateRaceResultsScreen,
  exitScreen = exitRaceResultsScreen,
  preEnter = preEnterScreen,
  getStatus = getScreenStatus,
  finishScreen = setCompleteScreenComplete,
  updateCoreData = setCoreTimers
}
addScreen(SoloRaceModeResultIndex, "SOLO RACE RESULTS SCREEN", raceCompleteScreen)
