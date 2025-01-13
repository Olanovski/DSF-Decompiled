module("onlineScreenManager", package.seeall)
local soloResultScreenComplete = true
local enterSoloResultsScreen, updateSoloResultsScreen, exitSoloResultsScreen
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
local function tagTrailResultFunc(position, playerData, draw)
  local endDescription = "ID:236598"
  if phaseManager.modeTimedOut then
    endDescription = "ID:236594"
  end
  if position == 1 then
    if draw then
      return 2, "ID:169321", endDescription, ""
    else
      return 2, "ID:231392", endDescription, ""
    end
  else
    return 1, getPositionString(position), endDescription, ""
  end
end
local function pureCircuitResultFunc(position)
  local endDescription = "ID:236599"
  if phaseManager.modeTimedOut then
    endDescription = "ID:236594"
  elseif position == 1 then
    endDescription = "ID:236756"
  end
  if position == 1 then
    return 2, "ID:236595", endDescription, ""
  else
    local raceWinnerName = ""
    if not phaseManager.modeTimedOut then
      local playerTable = getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.race)
      assert(playerTable[1], "No players found in player data table or a bad sort has occured in onlineScreenManager.getScreenCurrentPlayerTable")
      raceWinnerName = playerTable[1].name
    end
    return 1, getPositionString(position), endDescription, "", raceWinnerName
  end
end
local function faceoffResultFunc(position)
  if position == 1 then
    return 2, "ID:236578", getPositionString(position), ""
  else
    return 1, "ID:236578", getPositionString(position), ""
  end
end
local tutorialResultFunc = function()
  local xpGain = onlineProgressionSystem.getLocalPlayerXPGained()
  if xpGain > 0 then
    return 2, "ID:236316", "+" .. xpGain .. " XP"
  end
  return 3, "ID:236316"
end
local modeResultFunctions = {
  ["MP tag"] = tagTrailResultFunc,
  ["MP trail blazer"] = tagTrailResultFunc,
  ["MP takedown"] = function(position, playerData)
    local resultType = 1
    local string1 = ""
    local string2 = ""
    local getawayFound = playerManager.players[phaseManager.lastTurnTaker] and true or false
    if not getawayFound then
      string1 = "ID:236575"
      string2 = "ID:169358"
    elseif phaseManager.modeTimedOut then
      string1 = "ID:236593"
      if phaseManager.playerIsObjective then
        string2 = "ID:241377"
      else
        string2 = "ID:241378"
      end
    elseif phaseManager.playerHasWonRound then
      string1 = "ID:236579"
      if phaseManager.playerIsObjective then
        string2 = "ID:241377"
      else
        string2 = "ID:241379"
      end
      resultType = 2
    else
      string1 = "ID:236580"
      if phaseManager.playerIsObjective then
        string2 = "ID:241376"
      else
        string2 = "ID:241378"
      end
    end
    return resultType, string1, string2, ""
  end,
  ["MP circuit race"] = pureCircuitResultFunc,
  ["MP pure race"] = pureCircuitResultFunc,
  ["MP sprint race"] = function(position, playerData)
    if position == 1 then
      return 2, "ID:236595", "ID:220762", "", playerData.roundScore
    else
      return 1, getPositionString(position), "ID:220762", "", playerData.roundScore
    end
  end,
  ["MP checkpoint rush"] = function(position, playerData)
    local endDescription = "ID:236598"
    if phaseManager.modeTimedOut then
      endDescription = "ID:236594"
    end
    if position == 1 then
      return 2, "ID:231392", endDescription, ""
    else
      return 1, getPositionString(position), endDescription, ""
    end
  end,
  ["MP Vehicle Swap Tutorial"] = tutorialResultFunc,
  ["MP Vehicle Spawn Tutorial"] = tutorialResultFunc,
  ["MP shift impulse tutorial"] = tutorialResultFunc,
  ["MP general mechanics tutorial"] = tutorialResultFunc,
  ["MP shift take tutorial"] = tutorialResultFunc,
  ["Air"] = faceoffResultFunc,
  ["Drift"] = faceoffResultFunc,
  ["Drive far"] = faceoffResultFunc,
  ["Overtake cars"] = faceoffResultFunc,
  ["Smash props"] = faceoffResultFunc,
  ["Stay above 80mph"] = faceoffResultFunc,
  ["SS Survival"] = function(position, playerData)
    if not phaseManager.failedSSRound then
      return 3, "LEVEL " .. tostring(phaseManager.lastSSRoundNum) .. " COMPLETE!"
    end
    return 3, "LEVEL " .. tostring(phaseManager.lastSSRoundNum) .. " FAILED!"
  end
}
local function getModeResultData(modeName, position, playerData, draw)
  if phaseManager.networkVars.toFewPlayersType ~= 0 then
    return 1, "ID:236575", "ID:236574", ""
  end
  return modeResultFunctions[modeName](position, playerData, draw)
end
function enterSoloResultsScreen(startTime, displayTime, sortType, missionName, endTime)
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
  NetworkLog.Write(">[LUA] - Results Banner data")
  NetworkLog.Write("          sortType = " .. tostring(sortType) .. " forceSort = " .. tostring(forceSort) .. " isRaceData = " .. tostring(isRaceData))
  for i, player in ipairs(playerTable) do
    if player then
      NetworkLog.Write("          Player: " .. tostring(i) .. " ID: " .. tostring(player.id) .. "  score: " .. tostring(player.score) .. " isLocal = " .. tostring(player.id == localPlayer.playerID))
    else
      NetworkLog.Write("          Player: " .. tostring(i) .. " is False")
    end
  end
  NetworkLog.Write(">[LUA] - End Results Banner data")
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
end
local setCoreTimers = function(startTime, displayTime, endTime)
end
function updateSoloResultsScreen()
end
function exitSoloResultsScreen()
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_MatchResult", 0)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Finished", 0)
  soloResultScreenComplete = true
end
local soloCompleteScreen = {
  enterScreen = enterSoloResultsScreen,
  updateScreen = updateSoloResultsScreen,
  exitScreen = exitSoloResultsScreen,
  preEnter = preEnterScreen,
  getStatus = getScreenStatus,
  finishScreen = setCompleteScreenComplete,
  updateCoreData = setCoreTimers
}
addScreen(PlayerResultScreenIndex, "SOLO RESULTS SCREEN", soloCompleteScreen)
