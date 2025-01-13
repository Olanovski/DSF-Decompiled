module("onlineScreenManager", package.seeall)
local teamResultScreenComplete = true
local enterTeamResultsScreen, updateTeamResultsScreen, exitTeamResultsScreen
local function preEnterScreen()
  teamResultScreenComplete = false
end
local function getScreenStatus()
  return teamResultScreenComplete
end
local function setCompleteScreenComplete()
  teamResultScreenComplete = true
end
local modeResultFunctions = {
  ["MP burning rubber"] = function(playerScore, opposingScore)
    if opposingScore < playerScore then
      if phaseManager.modeTimedOut then
        return 2, "ID:236595", "ID:236594", ""
      else
        return 2, "ID:236595", "ID:247141", ""
      end
    elseif playerScore < opposingScore then
      if phaseManager.modeTimedOut then
        return 1, "ID:236596", "ID:236594", ""
      else
        return 1, "ID:236596", "ID:247135", ""
      end
    elseif phaseManager.modeTimedOut then
      return 1, "ID:169321", "ID:236594", ""
    else
      return 2, "ID:169321", "ID:247143", ""
    end
  end,
  ["MP tug of war"] = function(playerScore, opposingScore)
    local teamData = getTeamData()
    if teamData[1].roundScore ~= -1 then
      if phaseManager.modeTimedOut then
        return 3, "ID:236594"
      elseif opposingScore < playerScore then
        return 2, "ID:236579", "ID:236581", ""
      else
        return 1, "ID:236580", "ID:236582", ""
      end
    else
      local endDescription = ""
      if phaseManager.modeTimedOut then
        endDescription = "ID:236594"
      else
        endDescription = "ID:236598"
      end
      if playerScore == opposingScore then
        return 1, "ID:169321", endDescription, ""
      elseif opposingScore < playerScore then
        return 2, "ID:220265", endDescription, ""
      else
        return 1, "ID:220266", endDescription, ""
      end
    end
  end,
  ["MP rush down"] = function(playerScore, opposingScore)
    if not phaseManager.playerIsObjective then
      if phaseManager.modeTimedOut then
        return 2, "ID:236594", "ID:236589", ""
      elseif playerScore < opposingScore then
        return 1, "ID:236580", "ID:236591", ""
      else
        return 2, "ID:236579", "ID:236589", ""
      end
    elseif phaseManager.modeTimedOut then
      return 1, "ID:236594", "ID:236592", ""
    elseif playerScore < opposingScore then
      return 1, "ID:236580", "ID:236592", ""
    else
      return 2, "ID:236579", "ID:236590", ""
    end
  end,
  ["MP team circuit race"] = function(playerScore, opposingScore)
    local endDescription = ""
    if phaseManager.modeTimedOut then
      endDescription = "ID:236594"
    else
      endDescription = "ID:236598"
    end
    if opposingScore < playerScore then
      return 2, "ID:236595", endDescription, ""
    elseif playerScore < opposingScore then
      return 1, "ID:236596", endDescription, ""
    else
      return 1, "ID:169321", endDescription, ""
    end
  end
}
local function getModeResultData(modeName, playerScore, opposingScore)
  if phaseManager.networkVars.toFewPlayersType ~= 0 then
    return 1, "ID:236575", "ID:236574", ""
  end
  return modeResultFunctions[modeName](playerScore, opposingScore)
end
function enterTeamResultsScreen(startTime, displayTime, sortType, missionName, endTime)
  assert(modeResultFunctions[missionName], "CAN'T SHOW MODE RESULT SCREEN - " .. missionName .. " - NOT IN THE RESULT FUNCTION TABLE")
  feedbackSystem.menusMaster.onlineHUDSetVariable("iAbility_Display", 0)
  localPlayer:showHUDElements(false)
  zapWeaponSupport.enableZapWeapons(false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 0)
  local teamData = getTeamData()
  local string1 = "FAILED TO GET PLAYER RESULT DATA"
  local string2 = "FAILED TO GET PLAYER RESULT DATA"
  local string3 = "FAILED TO GET PLAYER RESULT DATA"
  local screenType = 1
  if teamData[1].roundScore ~= -1 then
    screenType, string1, string2, string3 = getModeResultData(missionName, teamData[1].roundScore, teamData[2].roundScore)
  else
    screenType, string1, string2, string3 = getModeResultData(missionName, teamData[1].currentScore, teamData[2].currentScore)
  end
  if screenType == 1 then
    OneShotSound.Play("MP_Result_Lost", false)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_you_lost", string1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_lost_description", string2)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_lost_place", string3)
  elseif screenType == 2 then
    OneShotSound.Play("MP_Result_Won", false)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_you_won", string1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_won_description", string2)
  elseif screenType == 3 then
    OneShotSound.Play("MP_Result_Draw", false)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_draw", string1)
  end
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_MatchResult", screenType)
end
local setCoreTimers = function(startTime, displayTime, endTime)
end
function updateTeamResultsScreen()
end
function exitTeamResultsScreen()
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_MatchResult", 0)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Finished", 0)
  teamResultScreenComplete = true
end
local teamResultScreen = {
  enterScreen = enterTeamResultsScreen,
  updateScreen = updateTeamResultsScreen,
  exitScreen = exitTeamResultsScreen,
  preEnter = preEnterScreen,
  getStatus = getScreenStatus,
  finishScreen = setCompleteScreenComplete,
  updateCoreData = setCoreTimers
}
addScreen(TeamResultScreenIndex, "TEAM RESULTS SCREEN", teamResultScreen)
