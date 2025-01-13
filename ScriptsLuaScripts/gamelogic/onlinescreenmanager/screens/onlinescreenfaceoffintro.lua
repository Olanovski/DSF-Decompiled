module("onlineScreenManager", package.seeall)
local screenStartTime = 0
local displayLength = 0
local screenSet = false
local timeRemaining = 0
local playerSortType = false
local numPlayersRequired = 0
local soloIntroScreenComplete = true
local countDown = true
local updateScreenInformation, updateSoloIntroScreen, exitSoloScreen
local function preEnterIntroScreen()
  soloIntroScreenComplete = false
end
local function getIntroScreenStatus()
  return soloIntroScreenComplete
end
local function setIntroScreenComplete()
  soloIntroScreenComplete = true
end
function enterFaceOffIntroScreen(startTime, displayTime, sortType, missionName)
  assert(onlineScreenData[missionName], "SCREEN NOT STARTED: " .. tostring(missionName) .. " ENTRY NOT IN THE SCREEN DATA TABLE")
  screenStartTime = startTime
  displayLength = displayTime
  playerSortType = sortType
  local nextMode = phaseManager.playlistSupport.getCurrentMission()
  assert(onlineScreenData[nextMode], "FACE OFF SCREEN NOT STARTED. NEXT MODE: " .. tostring(nextMode) .. " ENTRY NOT IN THE SCREEN DATA TABLE")
  local faceoffRewards = onlineScreenData[nextMode].faceOffRewards
  if faceoffRewards == 2 and not onlineProgressionSystem.areZapWeaponsUnlocked() then
    faceoffRewards = 1
  end
  if faceoffRewards == 0 then
    OneShotSound.Play("MP_FaceOffIntro_Norm", false)
  elseif faceoffRewards == 1 then
    OneShotSound.Play("MP_FaceOffIntro_Norm_Ability", false)
  else
    OneShotSound.Play("MP_FaceOffIntro_Norm_Ability_WeaponCharge", false)
  end
  onlineScreenManager.activateInstructionButton()
  if ProfileSettings.GetNumFaceOffPlays() < minNumPlaysForAutoInstructions then
    displayInstructionScreen()
  end
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 11)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Qualifying_Rewards_Display", faceoffRewards)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMultiplayer_IconType", onlineScreenData[missionName].screenIconID)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_qualifying_next_game", onlineScreenData[missionName].displayTitle, onlineScreenData[missionName].description1)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_game_title", onlineScreenData[missionName].displayTitle, onlineScreenData[missionName].description1)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_goal", "")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_tag_line", "ID:243718", onlineScreenData[nextMode].displayTitle)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:220615")
  screenSet = true
  introScreenOn = true
  countDown = true
  PlayerGamePlay.allowTeamShuffling(true)
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    local missionData = cardSystem.createMission(phaseManager.playlistSupport.getCurrentMission())
    local isTeamGame = missionData.settings.teamGame
    local requiredNumPlayers = missionData.settings.minPlayers
    if isTeamGame then
      requiredNumPlayers = requiredNumPlayers / 2
    end
    phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.faceOffIntro)
    phaseManager.setupTimeToScoreUpdate(requiredNumPlayers, isTeamGame, phaseManager.timeToJoinScore.faceOffIntro, phaseManager.timeToJoinScore.faceOffIntroUnbPlayers, phaseManager.timeToJoinScore.faceOffIntroTFPlayers)
    phaseManager.updateTimeToScoreValue()
  end
end
local function setCoreTimers(startTime, displayTime)
  screenStartTime = startTime
  displayLength = displayTime
end
local prevSecond
function updateSoloIntroScreen()
  if screenSet then
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
    if timeRemaining > 0 then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_starting_in_seconds", timeRemaining)
    elseif countDown then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_start_starting_in_seconds", "")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_starting_in", "ID:168323")
      countDown = false
    end
    if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
      phaseManager.updateTimeToScoreValue()
    end
  end
end
function exitSoloScreen()
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 0)
  OneShotSound.Play("MP_Generic_Outro_02", false)
  screenSet = false
  displayLength = 0
  screenStartTime = 0
  soloIntroScreenComplete = true
  introScreenOn = false
  PlayerGamePlay.allowTeamShuffling(false)
  phaseManager.clearTimeToScoreUpdate()
end
local getOutroSceneName = function()
  return "multi_start_qualifying_outro", 30
end
local faceOffIntroScreen = {
  enterScreen = enterFaceOffIntroScreen,
  updateScreen = updateSoloIntroScreen,
  exitScreen = exitSoloScreen,
  preEnter = preEnterIntroScreen,
  getStatus = getIntroScreenStatus,
  finishScreen = setIntroScreenComplete,
  updateCoreData = setCoreTimers,
  getOutroSceneName = getOutroSceneName,
  teams = false
}
addScreen(FaceOffIntroScreenIndex, "FACE OFF GAME INTRO SCREEN", faceOffIntroScreen)
