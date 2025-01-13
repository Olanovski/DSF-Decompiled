module("feedbackSystem.splitScreenSupport", package.seeall)
disableSSHud = false
local stringFormat = "%02d"
local nextSoundTime = 0
local oneMinWarningAudio = false
local mins = 0
local secs = 0
local multiplier = 0
local timerDisplayed = false
local playerOneScore = 0
local playerTwoScore = 0
local playerOnePosition, playerTwoPosition
local firstPlace = "ID:246521"
local secondPlace = "ID:246522"
function setupSSGameTimer(timeLimit, warningAudio)
  nextSoundTime = timeLimit - 1
  oneMinWarningAudio = warningAudio
  mins = string.format(stringFormat, timeLimit / 60)
  feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_timer_minutes", tostring(mins))
  secs = string.format(stringFormat, math.mod(timeLimit, 60))
  feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_timer_seconds", tostring(secs))
  feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_timer_splitseconds", "00")
  feedbackSystem.menusMaster.splitscreenSetVariable("iSS_timer_warning", 0)
  feedbackSystem.menusMaster.splitscreenSetVariable("iSS_timer", 1)
end
function stepSSGameTimer(timeLeft)
  mins = string.format(stringFormat, timeLeft / 60)
  feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_timer_minutes", tostring(mins))
  secs = string.format(stringFormat, math.mod(timeLeft, 60))
  feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_timer_seconds", tostring(secs))
  stepSSGameTimerAudio(timeLeft)
end
function stepSSGameTimerAudio(timeLeft)
  if nextSoundTime == math.ceil(timeLeft) then
    nextSoundTime = math.ceil(timeLeft) - 1
    if math.ceil(timeLeft) <= 5 then
      OneShotSound.PlayCountdown("HUD_Gen_Timer_03_OneShot")
    elseif math.ceil(timeLeft) <= 15 then
      OneShotSound.PlayCountdown("HUD_Gen_Timer_02_OneShot")
      if not timerFlash then
        timerFlash = true
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_timer_warning", 1)
      end
    elseif oneMinWarningAudio and math.ceil(timeLeft) <= 60 then
      OneShotSound.PlayCountdown("HUD_Gen_Timer_01_OneShot")
    end
  end
end
function clearSSGameTimer()
  timerDisplayed = false
  timerFlash = false
  oneMinWarningAudio = false
  nextSoundTime = 0
  feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_timer_minutes", "00")
  feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_timer_seconds", "00")
  feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_timer_splitseconds", "00")
  feedbackSystem.menusMaster.splitscreenSetVariable("iSS_timer_warning", 0)
  feedbackSystem.menusMaster.splitscreenSetVariable("iSS_timer", 0)
end
function setupScoringBar(newMultiplier, singleBar)
  multiplier = newMultiplier
  if singleBar then
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p1_progress_display", 1)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p2_progress_display", 1)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p1_progress_anim", 0)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p2_progress_anim", 0)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p1_progress_counter", 0)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p2_progress_counter", 0)
    feedbackSystem.menusMaster.splitscreenSetTextVariable("SS_coop_p1_progress_counter", "1")
    feedbackSystem.menusMaster.splitscreenSetTextVariable("SS_coop_p2_progress_counter", "1")
  else
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_progress_bar", 1)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_progress_bar", 1)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_position_indicator_anim", 0)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_position_indicator_anim", 0)
    feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_p1_comp_progress_counter", firstPlace)
    feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_p2_comp_progress_counter", secondPlace)
    playerOnePosition = firstPlace
    playerTwoPosition = secondPlace
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_progress_anim", 0)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_progress_anim", 0)
    playerOneScore = 0
    playerTwoScore = 0
  end
end
function updateLevelCounterBarCoop(localPlayerID, level)
  feedbackSystem.menusMaster.splitscreenSetTextVariable("SS_coop_p1_progress_counter", tostring(level))
  feedbackSystem.menusMaster.splitscreenSetTextVariable("SS_coop_p2_progress_counter", tostring(level))
  if level > 0 then
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p1_progress_level_up", 1)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p2_progress_level_up", 1)
  end
end
function updateLevelCounterBarComp(localPlayerID, position)
  if localPlayerID == 0 then
    if position == 1 then
      if playerOnePosition ~= firstPlace then
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_position_flare", 1)
        OneShotSound.Play("HUD_Mis_PositionChange_Positive_OneShot", false)
      end
      feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_p1_comp_progress_counter", firstPlace)
      feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_p2_comp_progress_counter", secondPlace)
      playerOnePosition = firstPlace
      playerTwoPosition = secondPlace
    else
      if playerTwoPosition ~= firstPlace then
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_position_flare", 1)
        OneShotSound.Play("HUD_Mis_PositionChange_Positive_OneShot", false)
      end
      feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_p1_comp_progress_counter", secondPlace)
      feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_p2_comp_progress_counter", firstPlace)
      playerOnePosition = secondPlace
      playerTwoPosition = firstPlace
    end
  elseif position == 2 then
    if playerOnePosition ~= firstPlace then
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_position_flare", 1)
      OneShotSound.Play("HUD_Mis_PositionChange_Positive_OneShot", false)
    end
    feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_p1_comp_progress_counter", firstPlace)
    feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_p2_comp_progress_counter", secondPlace)
    playerOnePosition = firstPlace
    playerTwoPosition = secondPlace
  else
    if playerTwoPosition ~= firstPlace then
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_position_flare", 1)
      OneShotSound.Play("HUD_Mis_PositionChange_Positive_OneShot", false)
    end
    feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_p1_comp_progress_counter", secondPlace)
    feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_p2_comp_progress_counter", firstPlace)
    playerOnePosition = secondPlace
    playerTwoPosition = firstPlace
  end
end
function updateScoringBar(localPlayerID, score, singleBar, audio)
  if singleBar then
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p1_progress_anim", multiplier * score)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p2_progress_anim", multiplier * score)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p1_progress_counter", multiplier * score)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p2_progress_counter", multiplier * score)
    if audio then
      OneShotSound.Play(audio, false)
    end
  elseif localPlayerID == 0 then
    playerOneScore = multiplier * score
    if playerOneScore > playerTwoScore then
      updateLevelCounterBarComp(0, 1)
    elseif playerOneScore < playerTwoScore then
      updateLevelCounterBarComp(0, 2)
    end
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_progress_anim", multiplier * score)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_position_indicator_anim", multiplier * score)
    if audio then
      OneShotSound.Play(audio, false)
    end
  else
    playerTwoScore = multiplier * score
    if playerOneScore > playerTwoScore then
      updateLevelCounterBarComp(0, 1)
    elseif playerOneScore < playerTwoScore then
      updateLevelCounterBarComp(0, 2)
    end
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_progress_anim", multiplier * score)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_position_indicator_anim", multiplier * score)
    if audio then
      OneShotSound.Play(audio, false)
    end
  end
end
function clearScoringBar(singleBar)
  multiplier = 0
  if singleBar then
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p1_progress_anim", 0)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p2_progress_anim", 0)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p1_progress_counter", 0)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p2_progress_counter", 0)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p1_progress_display", 0)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_coop_p2_progress_display", 0)
  else
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_progress_bar", 3)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_progress_bar", 3)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_position_indicator_anim", 0)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_position_indicator_anim", 0)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_progress_anim", 0)
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_progress_anim", 0)
  end
end
local roundWinMarkers = {
  [0] = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    ["displayOn"] = false
  },
  [1] = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    ["displayOn"] = false
  }
}
function showRoundsDisplay()
  if not roundWinMarkers[0].displayOn then
    feedbackSystem.menusMaster.currentHUDSetVariable("iSS_p1_rounds_display", 1)
    roundWinMarkers[0].displayOn = true
  end
  if not roundWinMarkers[1].displayOn then
    feedbackSystem.menusMaster.currentHUDSetVariable("iSS_p2_rounds_display", 1)
    roundWinMarkers[1].displayOn = true
  end
end
function setRoundWinMarker(localID, markerID, on)
  assert(roundWinMarkers[localID] and roundWinMarkers[localID][markerID], "Win Marker Entry not found")
  if roundWinMarkers[localID][markerID] ~= on then
    if localID == 0 then
      if markerID == 1 then
        feedbackSystem.menusMaster.currentHUDSetVariable("iSS_p1_round_1", on)
      elseif markerID == 2 then
        feedbackSystem.menusMaster.currentHUDSetVariable("iSS_p1_round_2", on)
      elseif markerID == 3 then
        feedbackSystem.menusMaster.currentHUDSetVariable("iSS_p1_round_3", on)
      end
    elseif markerID == 1 then
      feedbackSystem.menusMaster.currentHUDSetVariable("iSS_p2_round_1", on)
    elseif markerID == 2 then
      feedbackSystem.menusMaster.currentHUDSetVariable("iSS_p2_round_2", on)
    elseif markerID == 3 then
      feedbackSystem.menusMaster.currentHUDSetVariable("iSS_p2_round_3", on)
    end
    roundWinMarkers[localID][markerID] = on
  end
end
function setRoundWinMarkerHiddenWin(localID, markerID)
  assert(roundWinMarkers[localID] and roundWinMarkers[localID][markerID], "Win Marker Entry not found")
  if roundWinMarkers[localID][markerID] == 0 then
    roundWinMarkers[localID][markerID] = 2
  end
end
function processHiddenWinMarkers()
  for i = 1, 3 do
    if roundWinMarkers[0][i] == 2 then
      setRoundWinMarker(0, i, 1)
    end
    if roundWinMarkers[1][i] == 2 then
      setRoundWinMarker(1, i, 1)
    end
  end
end
function clearRoundWinMarkers()
  for i = 1, 3 do
    if roundWinMarkers[0][i] ~= 2 then
      setRoundWinMarker(0, i, 0)
    end
    if roundWinMarkers[1][i] ~= 2 then
      setRoundWinMarker(1, i, 0)
    end
    roundWinMarkers[0][i] = 0
    roundWinMarkers[1][i] = 0
  end
  if roundWinMarkers[0].displayOn then
    feedbackSystem.menusMaster.currentHUDSetVariable("iSS_p1_rounds_display", 0)
    roundWinMarkers[0].displayOn = false
  end
  if roundWinMarkers[1].displayOn then
    feedbackSystem.menusMaster.currentHUDSetVariable("iSS_p2_rounds_display", 0)
    roundWinMarkers[1].displayOn = false
  end
end
