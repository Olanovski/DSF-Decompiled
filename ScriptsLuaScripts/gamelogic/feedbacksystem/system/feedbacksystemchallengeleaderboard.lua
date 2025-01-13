module("feedbackSystem.leaderboard", package.seeall)
leaderboardPreviewActive = false
leaderboardActive = false
local stringFormat = "%02d"
local mod = math.mod
local sub = string.sub
local floor = math.floor
local leaderboardMission = false
local leaderboardCallBack = false
local currentSelection = 1
local menuCount = 1
local endOfList = false
function round_num(x)
  return floor(x + 0.5)
end
function showLeaderboardPreviewPanel(mission)
  leaderboardPreviewActive = true
  singlePlayerStatistics.setupMissionStatistics(mission.ID)
  local statsTable = singlePlayerStatistics.getMissionStatisticsScoreTable()
  local showDefaultBest = false
  local timeToBeat = 0
  feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_2_title", "ID:245384")
  feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_vehicle_title", "ID:245903")
  feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_3_title", "ID:245860")
  feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_toggle", "")
  if mission.ID == "DriveToSurvive2" or mission.ID == "Survival" or mission.ID == "Big break 2" or mission.ID == "ChinatownDrift" or mission.ID == "Uplaych4" then
    if statsTable.startValue <= mission.defaultBest or statsTable.startValue == 0 then
      feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_2_title", "ID:245383")
      showDefaultBest = true
    end
  elseif statsTable.startValue >= mission.defaultBest or statsTable.startValue == 0 then
    feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_2_title", "ID:245383")
    showDefaultBest = true
  end
  if mission.scoreType == "Score" then
    if showDefaultBest then
      feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_string", mission.defaultBest)
    else
      feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_string", statsTable.startValue)
    end
    feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Popup", 2)
  else
    if showDefaultBest then
      timeToBeat = math.floor(mission.defaultBest) / 100
    else
      timeToBeat = math.floor(statsTable.startValue) / 100
    end
    if timeToBeat ~= 0 then
      local mins, secs, milli = feedbackSystem.formatTime(timeToBeat)
      feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_minutes", mins)
      feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_seconds", secs)
      feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_milli", milli)
    else
      feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_minutes", "--")
      feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_seconds", "--")
      feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_milli", "--")
    end
    feedbackSystem.menusMaster.masterSetTextVariable("Mission_panel_2_timer_colon", ":")
    feedbackSystem.menusMaster.masterSetTextVariable("Mission_panel_2_timer_dot", ".")
    feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Popup", 1)
  end
  feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_3_string", "--")
end
function hideLeaderboardPreviewPanel()
  leaderboardPreviewActive = false
  feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Popup", 0)
end
function showLeaderboardPanel()
  if Menu.GetVariable("Master", "PC_OfflineMode") == 1 then
    return
  end
  leaderboardActive = true
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle", 0)
  feedbackSystem.menusMaster.masterSetTextVariable("leaderboards_errorMessageTitle", "")
  feedbackSystem.menusMaster.masterSetTextVariable("leaderboards_errorMessageCopy", "")
  feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_1_controls", "ID:249118")
  feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_gamercard_button", localPlayer.buttonLayout.accept)
  if Menu.GetVariable("Master", "challengeLeaderboardMode") == 1 then
    feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_2_controls", "ID:220336")
  else
    feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_2_controls", "ID:220335")
  end
  feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Display", 1)
  OneShotSound.Play("HUD_Mission_Leaderboard_Intro", false)
  feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_toggle", "ID:245798", nil, localPlayer.buttonLayout.reject)
end
function hideLeaderboardPanel(mission)
  leaderboardActive = false
  controlHandler:resetState("PreviewLeaderboard")
  controlHandler:removeState("PreviewLeaderboard", localPlayer.localID)
  removeUserUpdateFunction("checkUp")
  removeUserUpdateFunction("checkDown")
  feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Selected", 1)
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle", 1)
  feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Display", 0)
  OneShotSound.Play("HUD_Mission_Leaderboard_Outro", false)
  OneShotSound.Play("HUD_Mission_Preview_Intro", false)
  if Menu.GetVariable("Master", "iActivity_Preview_Reward") ~= 0 and localPlayer.challenge.showingEndScreen then
    OneShotSound.Play("HUD_Mission_Complete_Intro_WP")
  end
  if mission and mission.scoreType == "Score" then
    feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Popup", 2)
  else
    feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Popup", 1)
  end
end
function _G.exitInGameLeaderboard()
  if leaderboardCallBack then
    feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Selected", 0)
    local bOfflineMode = Menu.GetVariable("Master", "PC_OfflineMode")
    if bOfflineMode == 0 then
      feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_toggle", "ID:245797", nil, localPlayer.buttonLayout.openLeaderboard)
    else
      feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_toggle", "")
    end
    hideLeaderboardPanel(leaderboardMission)
    OneShotSound.Play("Menu_Select")
    leaderboardCallBack()
    leaderboardCallBack = false
    leaderboardMission = false
  end
end
local function resetLeaderboard()
  removeUserUpdateFunction("checkUp")
  removeUserUpdateFunction("checkDown")
  currentSelection = 1
  menuCount = 1
  endOfList = false
  feedbackSystem.menusMaster.masterSetVariable("challengeLeaderboardState", menuCount)
  feedbackSystem.menusMaster.masterSetVariable("challengeLeaderboardIndex", currentSelection)
  feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Selected", currentSelection)
  if Menu.GetVariable("Master", "challengeLeaderboardMode") == 1 then
    feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_2_controls", "ID:245768")
  else
    feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_2_controls", "ID:245767")
  end
end
function setLeaderboardButtons(mission, callback)
  controlHandler:resetState("Preview")
  controlHandler:removeState("Preview", localPlayer.localID)
  currentSelection = 1
  menuCount = 1
  endOfList = false
  leaderboardMission = mission
  leaderboardCallBack = callback
  feedbackSystem.menusMaster.masterSetVariable("challengeLeaderboardState", menuCount)
  feedbackSystem.menusMaster.masterSetVariable("challengeLeaderboardIndex", currentSelection)
  feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Selected", currentSelection)
  local function setMenuDown()
    local playerPosition = Menu.GetVariable("Master", "challengeLeaderboardPlayerRow")
    local visiblePlayerCount = Menu.GetVariable("Master", "visiblePlayerCount")
    if visiblePlayerCount > 1 then
      currentSelection = currentSelection + 1
      if currentSelection > 9 and playerPosition == 10 then
        currentSelection = 9
        menuCount = menuCount + 1
      elseif currentSelection > 10 and (playerPosition <= 9 or playerPosition == -1) then
        currentSelection = 10
        menuCount = menuCount + 1
      end
      feedbackSystem.menusMaster.masterSetVariable("challengeLeaderboardState", menuCount)
      OneShotSound.Play("Menu_Move")
      addUserUpdateFunction("checkDown", function()
        local visiblePlayerCount = Menu.GetVariable("Master", "visiblePlayerCount")
        if visiblePlayerCount < currentSelection and visiblePlayerCount < 10 then
          feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Selected", visiblePlayerCount)
          feedbackSystem.menusMaster.masterSetVariable("challengeLeaderboardIndex", visiblePlayerCount)
          endOfList = true
        else
          feedbackSystem.menusMaster.masterSetVariable("challengeLeaderboardIndex", currentSelection)
          feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Selected", currentSelection)
        end
        removeUserUpdateFunction("checkDown")
      end, 0.1 * updates.stepRate, true)
    end
  end
  local function setMenuUp()
    endOfList = false
    local playerPosition = Menu.GetVariable("Master", "challengeLeaderboardPlayerRow")
    local visiblePlayerCount = Menu.GetVariable("Master", "visiblePlayerCount")
    if visiblePlayerCount > 1 then
      currentSelection = currentSelection - 1
      if currentSelection < 2 and playerPosition == 1 and menuCount ~= 1 then
        currentSelection = 2
        menuCount = menuCount - 1
      elseif currentSelection < 1 and (playerPosition >= 2 or playerPosition == -1) then
        currentSelection = 1
        menuCount = menuCount - 1
      end
      if menuCount < 1 then
        menuCount = 1
      end
      if currentSelection < 1 then
        currentSelection = 1
      end
      feedbackSystem.menusMaster.masterSetVariable("challengeLeaderboardState", menuCount)
      feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Selected", currentSelection)
      feedbackSystem.menusMaster.masterSetVariable("challengeLeaderboardIndex", currentSelection)
      OneShotSound.Play("Menu_Move")
      addUserUpdateFunction("checkUp", function()
        removeUserUpdateFunction("checkUp")
      end, 0.1 * updates.stepRate, true)
    end
  end
  local function menuSelectionDown()
    if not userUpdateFunctions.checkDown and not userUpdateFunctions.checkUp and not endOfList then
      setMenuDown()
    end
  end
  local function menuSelectionUp()
    if not userUpdateFunctions.checkDown and not userUpdateFunctions.checkUp then
      setMenuUp()
    end
  end
  controlHandler:registerState(localPlayer.localID, "PreviewLeaderboard", {
    MissionComplete_Analog_Up = {
      Pressed = {
        [1] = menuSelectionUp
      }
    },
    MissionComplete_Analog_Down = {
      Pressed = {
        [1] = menuSelectionDown
      }
    },
    MissionComplete_DPad_Up = {
      Pressed = {
        [1] = menuSelectionUp
      }
    },
    MissionComplete_DPad_Down = {
      Pressed = {
        [1] = menuSelectionDown
      }
    },
    Menu_ExtraSecond = {
      JustPressed = {
        [1] = resetLeaderboard
      }
    },
    Menu_Cancel = {
      JustPressed = {
        [1] = function()
          if Menu.GetVariable("Master", "showChallengeLeaderboards") ~= -1 then
            exitInGameLeaderboard()
          end
        end
      }
    }
  })
  feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Selected", 0)
  feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Popup", 3)
  controlHandler:setState("PreviewLeaderboard")
end
