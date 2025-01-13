module("onlineScreenManager", package.seeall)
local compScreenComplete = true
local audioOn = false
local bronze1Set = false
local silver1Set = false
local gold1Set = false
local barFillComplete = false
local enterCompScreen, updateCompScreen, exitCompScreen
local function preEnterScreen()
  compScreenComplete = false
end
local function getScreenStatus()
  return compScreenComplete
end
local function setCompleteScreenComplete()
  compScreenComplete = true
end
function enterCompScreen(startTime, displayTime, sortType, missionName, endTime)
  PauseMenu.allow(false)
  assert(onlineScreenData[missionName], "SCREEN NOT STARTED: " .. tostring(missionName) .. " ENTRY NOT IN THE SCREEN DATA TABLE")
  local modeCompData = getSSModeCompDataTable()
  local coopCompData = getSSCoopModeCompDataTable()
  assert(modeCompData.silverMedal and modeCompData.bronzeMedal and modeCompData.scoreLimit and modeCompData.goldMedal, "FAILED TO SET SPLITSCREEN COMP SCREEN - INVALID COMPLETE DATA")
  local teamScore = coopCompData.score / modeCompData.scoreLimit * 100
  local medalEarned = 0
  if teamScore >= modeCompData.goldMedal then
    medalEarned = 1
  elseif teamScore >= modeCompData.silverMedal then
    medalEarned = 2
  elseif teamScore >= modeCompData.bronzeMedal then
    medalEarned = 3
  end
  setSSCoopModeResults(coopCompData.level, medalEarned)
  Menu.ResetPage("SplitscreenMenus", "SS_20_menu_cooperative_results")
  feedbackSystem.menusMaster.splitscreenMenusSetVariable("iSS_20_bronze_position", modeCompData.bronzeMedal)
  feedbackSystem.menusMaster.splitscreenMenusSetVariable("iSS_20_silver_position", modeCompData.silverMedal)
  feedbackSystem.menusMaster.splitscreenMenusSetVariable("iSS_20_gold_position", modeCompData.goldMedal)
  feedbackSystem.menusMaster.splitscreenMenusSetVariable("iSS_20_team_win_bar_anim", 0)
  feedbackSystem.menusMaster.splitscreenMenusSetVariable("iSS_team_level_bar_anim", 0)
  feedbackSystem.menusMaster.splitscreenMenusSetVariable("iSS_20_bronze_flare", 0)
  feedbackSystem.menusMaster.splitscreenMenusSetVariable("iSS_20_silver_flare", 0)
  feedbackSystem.menusMaster.splitscreenMenusSetVariable("iSS_20_gold_flare", 0)
  feedbackSystem.multiplayerSupport.purgeProgBarFiller()
  if teamScore == 100 then
    feedbackSystem.menusMaster.splitscreenMenusSetTextVariable("SS_20_coop_results_title", "ID:245916")
  else
    feedbackSystem.menusMaster.splitscreenMenusSetTextVariable("SS_20_coop_results_title", "ID:245918")
  end
  if teamScore > 0 then
    barFillComplete = false
    feedbackSystem.multiplayerSupport.addBarFill(1, 1, "iSS_20_team_win_bar_anim", teamScore, 2, function()
      OneShotSound.PlayGUI("HUD_Gen_Currency_Increase_Play", false)
      audioOn = true
    end, function()
      if audioOn then
        OneShotSound.PlayGUI("HUD_Gen_Currency_Increase_Stop", false)
        audioOn = false
      end
      barFillComplete = true
    end, function(value)
      feedbackSystem.menusMaster.splitscreenMenusSetVariable("iSS_team_level_bar_anim", value)
      if not bronze1Set and value >= modeCompData.bronzeMedal then
        feedbackSystem.menusMaster.splitscreenMenusSetVariable("iSS_20_bronze_flare", 1)
        bronze1Set = true
        OneShotSound.Play("HUD_Gen_Positive_Lite", false)
      elseif not silver1Set and value >= modeCompData.silverMedal then
        feedbackSystem.menusMaster.splitscreenMenusSetVariable("iSS_20_silver_flare", 1)
        silver1Set = true
        OneShotSound.Play("HUD_Gen_Positive_Lite", false)
      elseif not gold1Set and value >= modeCompData.goldMedal then
        feedbackSystem.menusMaster.splitscreenMenusSetVariable("iSS_20_gold_flare", 1)
        gold1Set = true
        OneShotSound.Play("HUD_Gen_Positive_Lite", false)
      end
    end)
  else
    barFillComplete = true
  end
  feedbackSystem.menusMaster.splitscreenMenusSetTextVariable("SS_20_team_level_counter", tostring(coopCompData.level))
  setCancelButtonCallback(function()
    if SplitScreen.getControllerConnected(0) and SplitScreen.getControllerConnected(1) and not SplitScreen.getIsDisconnectPopupShowing() and barFillComplete then
      onlineScreenManager.endScreen(missionName)
      OneShotSound.Play("Menu_Select")
    end
  end)
end
local setCoreTimers = function(startTime, displayTime, endTime)
end
function updateCompScreen()
  feedbackSystem.multiplayerSupport.updateBarFiller()
end
function exitCompScreen()
  PauseMenu.allow(true)
  if not fromPurge then
    Menu.ResetPage("SplitscreenMenus", "SS_01_main_menu")
  end
  feedbackSystem.menusMaster.splitscreenMenusSetVariable("iSS_20_bronze_flare", 0)
  feedbackSystem.menusMaster.splitscreenMenusSetVariable("iSS_20_silver_flare", 0)
  feedbackSystem.menusMaster.splitscreenMenusSetVariable("iSS_20_gold_flare", 0)
  if audioOn then
    OneShotSound.PlayGUI("HUD_Gen_Currency_Increase_Stop", false)
    audioOn = false
  end
  feedbackSystem.multiplayerSupport.purgeProgBarFiller()
  setCancelButtonCallback(false)
  clearSSCoopModeCompDataTable()
  compScreenComplete = true
  stringTableIndex = false
  bronze1Set = false
  silver1Set = false
  gold1Set = false
end
local ssCoopCompComplete = {
  enterScreen = enterCompScreen,
  updateScreen = updateCompScreen,
  exitScreen = exitCompScreen,
  preEnter = preEnterScreen,
  getStatus = getScreenStatus,
  finishScreen = setCompleteScreenComplete,
  updateCoreData = setCoreTimers
}
addScreen(SSCoopCompleteScreenIndex, "SS COOP COMP COMPLETE SCREEN", ssCoopCompComplete)
