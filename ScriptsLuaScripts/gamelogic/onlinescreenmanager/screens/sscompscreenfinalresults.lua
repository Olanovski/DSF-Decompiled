module("onlineScreenManager", package.seeall)
local compScreenComplete = true
local stringTableIndex = false
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
local stringTable = {
  [1] = "SS_09_tanner_wins_final",
  [2] = "SS_10_jericho_wins_final"
}
function enterCompScreen(startTime, displayTime, sortType, missionName, endTime)
  assert(onlineScreenData[missionName], "SCREEN NOT STARTED: " .. tostring(missionName) .. " ENTRY NOT IN THE SCREEN DATA TABLE")
  PauseMenu.allow(false)
  local tannerWin = phaseManager.playlistSupport.ssPlayedModeResults.tanner > phaseManager.playlistSupport.ssPlayedModeResults.jericho
  stringTableIndex = tannerWin and 2
  assert(stringTableIndex == 1 or stringTableIndex == 2, "FAILED TO SET SPLITSCREEN COMP SCREEN - PAGE INDEX")
  Menu.ResetPage("SplitscreenMenus", stringTable[stringTableIndex])
  if stringTableIndex == 1 then
    feedbackSystem.menusMaster.splitscreenMenusSetTextVariable("SS_09_score_1", phaseManager.playlistSupport.ssPlayedModeResults.tanner)
    feedbackSystem.menusMaster.splitscreenMenusSetTextVariable("SS_09_score_2", phaseManager.playlistSupport.ssPlayedModeResults.jericho)
  else
    feedbackSystem.menusMaster.splitscreenMenusSetTextVariable("SS_09_score_2", phaseManager.playlistSupport.ssPlayedModeResults.tanner)
    feedbackSystem.menusMaster.splitscreenMenusSetTextVariable("SS_09_score_1", phaseManager.playlistSupport.ssPlayedModeResults.jericho)
  end
  for i = 1, 7 do
    if phaseManager.playlistSupport.ssPlayedModeResults.wins[i] == 1 then
      setCompSplitscreenMedal(true, tannerWin == true, true, i, true, phaseManager.playlistSupport.ssModeMedals[1][i])
      setCompSplitscreenMedal(false, tannerWin == false, false, i, true, phaseManager.playlistSupport.ssModeMedals[2][i])
    elseif phaseManager.playlistSupport.ssPlayedModeResults.wins[i] == 2 then
      setCompSplitscreenMedal(true, tannerWin == true, false, i, true, phaseManager.playlistSupport.ssModeMedals[1][i])
      setCompSplitscreenMedal(false, tannerWin == false, true, i, true, phaseManager.playlistSupport.ssModeMedals[2][i])
    else
      setCompSplitscreenMedal(true, tannerWin == true, false, i, false, false)
      setCompSplitscreenMedal(false, tannerWin == false, false, i, false, false)
    end
  end
  setCancelButtonCallback(function()
    if SplitScreen.getControllerConnected(0) and SplitScreen.getControllerConnected(1) and not SplitScreen.getIsDisconnectPopupShowing() then
      onlineScreenManager.endScreen(missionName)
      OneShotSound.Play("Menu_Select")
    end
  end)
end
local setCoreTimers = function(startTime, displayTime, endTime)
end
function updateCompScreen()
end
function exitCompScreen(fromPurge)
  PauseMenu.allow(true)
  setCancelButtonCallback(false)
  clearSSModeCompDataTable()
  compScreenComplete = true
  stringTableIndex = false
  phaseManager.playlistSupport.clearSplitscreenModeProgression()
  if not fromPurge then
    Menu.ResetPage("SplitscreenMenus", "SS_01_main_menu")
  end
end
local ssCompFinal = {
  enterScreen = enterCompScreen,
  updateScreen = updateCompScreen,
  exitScreen = exitCompScreen,
  preEnter = preEnterScreen,
  getStatus = getScreenStatus,
  finishScreen = setCompleteScreenComplete,
  updateCoreData = setCoreTimers
}
addScreen(SSCompFinalScreenIndex, "SS COMP FINAL SCREEN", ssCompFinal)
