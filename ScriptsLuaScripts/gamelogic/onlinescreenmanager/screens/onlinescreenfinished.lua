module("onlineScreenManager", package.seeall)
local compScreenComplete = true
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
function enterCompScreen(startTime, displayTime, sortType, missionName, endTime, screenStartTime)
  OneShotSound.Play("MP_Result_Draw", false)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_you_finished", "ID:184917")
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Finished", 1)
  feedbackSystem.eventMessages.pushXPGroup()
  onlineSideBar.setHidden(true)
  feedbackSystem.multiplayerSupport.enabled = false
  feedbackSystem.taskSupport.purge()
  feedbackSystem.menusMaster.onlineHUDSetVariable("iAbility_Display", 0)
  localPlayer:showHUDElements(false)
  zapWeaponSupport.enableZapWeapons(false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 0)
end
local setCoreTimers = function(startTime, displayTime, endTime)
end
function updateCompScreen()
end
function exitCompScreen(fromPurge)
  if fromPurge then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Finished", 0)
  end
  compScreenComplete = true
end
local soloRaceCompleteScreen = {
  enterScreen = enterCompScreen,
  updateScreen = updateCompScreen,
  exitScreen = exitCompScreen,
  preEnter = preEnterScreen,
  getStatus = getScreenStatus,
  finishScreen = setCompleteScreenComplete,
  updateCoreData = setCoreTimers
}
addScreen(FinishedScreenIndex, "FINISHED SCREEN", soloRaceCompleteScreen)
