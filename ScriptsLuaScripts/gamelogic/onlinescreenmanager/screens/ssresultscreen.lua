module("onlineScreenManager", package.seeall)
local resultScreenComplete = true
local tannerWin = false
local draw = false
local roundUIOn = false
local screenStartTime = false
local displayLength = false
local roundCompDone = false
local onFinalRound = false
local gameStartOn = false
local enterResultsScreen, updateResultsScreen, exitResultsScreen
local function preEnterScreen()
  resultScreenComplete = false
end
local function getScreenStatus()
  return resultScreenComplete
end
local function setCompleteScreenComplete()
  resultScreenComplete = true
end
local function showWinUI()
  if tannerWin then
    feedbackSystem.menusMaster.currentHUDSetVariable("iSS_p1_win_anim", 1)
    feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_p1_win", "ID:245842")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_p2_win", "ID:233109")
    OneShotSound.Play("SS_P1Win_Fragment")
  elseif draw then
    feedbackSystem.menusMaster.currentHUDSetVariable("iSS_match_draw_anim", 1)
    feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_p2_win", " ")
    OneShotSound.Play("SS_Draw_Fragment")
  else
    feedbackSystem.menusMaster.currentHUDSetVariable("iSS_p2_win_anim", 1)
    feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_p1_win", "ID:245844")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_p2_win", "ID:233109")
    OneShotSound.Play("SS_P2Win_Fragment")
  end
end
function enterResultsScreen(startTime, displayTime, sortType, missionName, endTime)
  PauseMenu.allow(false)
  screenStartTime = startTime
  displayLength = displayTime
  feedbackSystem.splitScreenSupport.disableSSHud = true
  feedbackSystem.multiplayerSupport.disableSSAbilityBar(0)
  feedbackSystem.multiplayerSupport.disableSSAbilityBar(1)
  localPlayer.minimapSupport.hideSS(0)
  localPlayer.minimapSupport.hideSS(1)
  feedbackSystem.menusMaster.disableDamageBar(localPlayerManager.players[0])
  feedbackSystem.menusMaster.disableDamageBar(localPlayerManager.players[1])
  feedbackSystem.multiplayerSupport.disableSSSpeedo(0)
  feedbackSystem.multiplayerSupport.disableSSSpeedo(1)
  feedbackSystem.taskSupport.purge()
  onlineInstructionSupport.purge()
  for localID, player in next, localPlayerManager.players, nil do
    if player.currentVehicle and player.currentVehicle.abilityActive then
      player.currentVehicle:cancelAbility(localID)
    end
  end
  localPlayer:showHUDElements(false)
  local playerTable = getPlayerScreenDataTable()
  local modeCompData = getSSModeCompDataTable()
  local coopCompData = getSSCoopModeCompDataTable()
  local missionName = phaseManager.playlistSupport.getCurrentMission()
  local isComp = phaseManager.playlistSupport.modePool.competitive[missionName]
  assert(playerTable[0] and playerTable[1], "FAILED TO SET SPLITSCREEN COMP SCREEN - INVALID PLAYER DATA")
  feedbackSystem.menusMaster.currentHUDSetVariable("iSS_sprintGP_win_out", 0)
  feedbackSystem.menusMaster.currentHUDSetVariable("iSS_sprintGP_win", 1)
  roundUIOn = true
  tannerWin = false
  roundCompDone = false
  draw = false
  gameStartOn = false
  if isComp then
    OneShotSound.Play("MP_Result_Won", false)
    assert(onlineScreenData[missionName].ssResultScreenLine1 and onlineScreenData[missionName].ssResultScreenLine2, "mode complete strings not found: " .. tostring(missionName))
    if not modeCompData.round then
      feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_number", "")
      feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_countdown", "ID:248689")
      feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_you_win", onlineScreenData[missionName].ssResultScreenLine1)
      feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_win_description", onlineScreenData[missionName].ssResultScreenLine2)
      onFinalRound = true
    end
    if modeCompData.race then
      if playerTable[0].secondaryScore < playerTable[1].secondaryScore then
        tannerWin = true
      elseif playerTable[0].secondaryScore == playerTable[1].secondaryScore then
        draw = true
        feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_p1_p2_draw", "ID:235574")
      end
    elseif modeCompData.round then
      if playerTable[0].roundScore > playerTable[1].roundScore then
        tannerWin = true
      elseif playerTable[0].roundScore == playerTable[1].roundScore then
        draw = true
        feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_p1_p2_draw", "ID:235574")
      end
      if not modeCompData.finalRound then
        feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_number", "ID:220240", modeCompData.roundNum + 1)
        feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_countdown", "ID:220615")
      else
        feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_number", "")
        feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_countdown", "ID:248689")
      end
      feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_you_win", onlineScreenData[missionName].ssResultScreenLine1, modeCompData.roundNum)
      feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_win_description", onlineScreenData[missionName].ssResultScreenLine2)
      onFinalRound = modeCompData.finalRound
    elseif playerTable[0].score > playerTable[1].score then
      tannerWin = true
    elseif playerTable[0].score == playerTable[1].score then
      draw = true
      feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_p1_p2_draw", "ID:235574")
    end
  else
    assert(onlineScreenData[missionName].ssResultScreenLine1Win and onlineScreenData[missionName].ssResultScreenLine1Lose, "mode complete strings not found: " .. tostring(missionName))
    assert(onlineScreenData[missionName].ssResultScreenLine2Win and onlineScreenData[missionName].ssResultScreenLine2Lose, "mode complete strings not found: " .. tostring(missionName))
    if coopCompData.level == coopCompData.maxLevel then
      OneShotSound.Play("MP_Result_Won", false)
      feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_you_win", onlineScreenData[missionName].ssResultScreenLine1Win)
      feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_win_description", onlineScreenData[missionName].ssResultScreenLine2Win)
    else
      OneShotSound.Play("MP_Result_Lost", false)
      feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_you_win", onlineScreenData[missionName].ssResultScreenLine1Lose)
      feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_win_description", onlineScreenData[missionName].ssResultScreenLine2Lose)
    end
    feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_p1_p2_draw", "ID:235574")
    draw = true
    feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_p1_p2_draw", "ID:245968", coopCompData.level)
    feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_number", "")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_countdown", "ID:248689")
    onFinalRound = true
  end
end
local setCoreTimers = function(startTime, displayTime, endTime)
end
local timeRemaining = 0
local prevSecond = 0
function updateResultsScreen()
  if roundUIOn then
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
    if not roundCompDone and Menu.GetSceneFrame("Splitscreen", "ss_sprintGP_win") >= 100 then
      roundCompDone = true
      showWinUI()
      feedbackSystem.splitScreenSupport.processHiddenWinMarkers()
    end
    if timeRemaining > 0 then
      feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_countdown_timer", timeRemaining)
    elseif not gameStartOn and not onFinalRound then
      feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_countdown_timer", "")
      feedbackSystem.menusMaster.currentHUDSetTextVariable("ss_sprint_countdown", "ID:242129")
      gameStartOn = true
    end
  end
end
function exitResultsScreen(fromPurge)
  if fromPurge then
    PauseMenu.allow(true)
  end
  resultScreenComplete = true
  if roundUIOn then
    feedbackSystem.menusMaster.currentHUDSetVariable("iSS_sprintGP_win", 0)
    feedbackSystem.menusMaster.currentHUDSetVariable("iSS_sprintGP_win_out", 1)
    roundUIOn = false
    feedbackSystem.splitScreenSupport.clearRoundWinMarkers()
  end
  if tannerWin then
    feedbackSystem.menusMaster.currentHUDSetVariable("iSS_p1_win_anim", 0)
  elseif draw then
    feedbackSystem.menusMaster.currentHUDSetVariable("iSS_match_draw_anim", 0)
  else
    feedbackSystem.menusMaster.currentHUDSetVariable("iSS_p2_win_anim", 0)
  end
end
local ssResultsScreen = {
  enterScreen = enterResultsScreen,
  updateScreen = updateResultsScreen,
  exitScreen = exitResultsScreen,
  preEnter = preEnterScreen,
  getStatus = getScreenStatus,
  finishScreen = setCompleteScreenComplete,
  updateCoreData = setCoreTimers
}
addScreen(SSResultScreenIndex, "SS RESULTS SCREEN", ssResultsScreen)
