module("onlineScreenManager", package.seeall)
local showRewards = false
local rewardsSet = false
local screenSet = false
local tutorialCompleteScreenStatus = true
local endScreenDelay = 0
local delayStart = 0
local missionID = false
local function enterTutorialCompleteScreen(startTime, displayTime, sortType, missionName, endTime)
  assert(missionName, "ERROR SETTING TUTORIAL COMPLETE missionName is NIL")
  controller.enableGameControls()
  stateMachine.blockErrorCheck = true
  missionID = missionName
  screenSet = false
  rewardsSet = false
  completeScreenOn = true
  showRewards = getNumRewards() > 0
  endScreenDelay = showRewards and 0
  delayStart = g_NetworkTime
  zapcontroller.setZapCameraLocks(0, {
    missile = false,
    low = true,
    mid = false,
    high = false,
    top = false
  })
  if not localPlayer.inZap or zapcontroller.getTargetZapLevel(0) ~= 5 then
    localPlayer:SetZapLevel(5, nil, false, {forcedOut = true})
  end
  zapcontroller.setRenderTarget(false, localPlayer.localID)
  zapcontroller.EnableZapInput(false, localPlayer.localID)
  localPlayer:blockAbility("zap", true)
  enableAbilities(localPlayer.localID, false)
  scoreSystem.stopAbilityDrain(localPlayer.localID, true)
  feedbackSystem.multiplayerSupport.enabled = false
  zap.zoomInOutButtonPrompts(false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Qualifying_OnOff", 0)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Spooling_Arrow", 0)
end
local function preEnterScreen()
  tutorialCompleteScreenStatus = false
end
local function getCompleteScreenStatus()
  return tutorialCompleteScreenStatus
end
local endTutorialText = {
  ["MP Vehicle Swap Tutorial"] = {text = "ID:236495", startButton = false},
  ["MP Vehicle Spawn Tutorial"] = {text = "ID:236496", startButton = true},
  ["MP shift impulse tutorial"] = {text = "ID:236497", startButton = true},
  ["MP general mechanics tutorial"] = {text = "ID:236498", startButton = true},
  ["MP shift take tutorial"] = {text = "ID:236499", startButton = false}
}
local function showExitPanel()
  screenSet = true
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_continue_button", localPlayer.buttonLayout.accept)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 1)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_rewards_title", "ID:236500")
  if endTutorialText[missionID].startButton then
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_rewards_generic_blurb", endTutorialText[missionID].text, nil, localPlayer.buttonLayout.exitBus)
  else
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_rewards_generic_blurb", endTutorialText[missionID].text)
  end
end
local function endRewardScreen()
  rewardSet = false
  showRewards = false
  rewardScreens.exitScreen()
  delayStart = g_NetworkTime
end
local function showRewardScreen()
  rewardScreens.enterScreen(g_NetworkTime, g_NetworkTime + 10, endRewardScreen, true)
  rewardScreens.setRewardScreenManual()
  rewardsSet = true
end
local function updateTutorialCompleteScreen()
  if not showRewards and not screenSet and g_NetworkTime - delayStart > endScreenDelay then
    showExitPanel()
  elseif showRewards and not rewardsSet then
    showRewardScreen()
  elseif showRewards and rewardsSet then
    rewardScreens.updateScreen()
  end
end
local function onButtonPress()
  if screenSet then
    tutorialCompleteScreenStatus = true
  elseif rewardsSet then
    rewardScreens.progressRewardScreen()
  end
end
local function exitTutorialCompleteScreen()
  stateMachine.blockErrorCheck = false
  completeScreenOn = false
  tutorialCompleteScreenStatus = true
  rewardScreens.exitScreen()
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 2)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Qualifying_OnOff", 1)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Spooling_Arrow", 1)
  Menu.UnloadMPImages()
end
local tutorialCompleteScreen = {
  enterScreen = enterTutorialCompleteScreen,
  updateScreen = updateTutorialCompleteScreen,
  exitScreen = exitTutorialCompleteScreen,
  preEnter = preEnterScreen,
  getStatus = getCompleteScreenStatus,
  progressRewards = onButtonPress
}
addScreen(OnlineTutorialCompleteIndex, "TUTORIAL COMPLETE SCREEN", tutorialCompleteScreen)
