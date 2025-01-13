module("phaseManager")
local stateIndex = ReturnToBusStateIndex
local stateComplete = false
local timer = 4
local startTimer = 0
local promptSet = false
local function debugCheck()
  NetworkLog.Write(">[LUA] ReturnToBusState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " error = " .. tostring(stateMachine.error))
  print("ReturnToBusState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " error = " .. tostring(stateMachine.error))
end
local function enter()
  clearLoadedRouteData()
  if not gameStatus.splitscreenSession then
    onlineSideBar.closeSidebar()
  end
  stateComplete = false
  timer = 5
  promptSet = false
  if playedTutorial then
    timer = 0
    startTimer = g_NetworkTime
  end
  onlineScreenManager.purge()
end
local function step()
  if not stateComplete and onlineScreenManager.areScreensComplete() then
    if not promptSet and not playedTutorial then
      returnToBusWindowOpen = true
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 1)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_rewards_title", "ID:236500")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_contine", "")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_continue_button", "")
      if stateMachine.error then
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_rewards_generic_blurb", "ID:243066")
      else
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_rewards_generic_blurb", "ID:242452")
      end
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Toggle", 0)
      startTimer = g_NetworkTime
      promptSet = true
    end
    if g_NetworkTime - startTimer > timer then
      stateComplete = true
      sendMessage(2, stateIndex)
    end
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and not returnToBusCalled then
    if stateMachine.error then
      Network.leaveMatchAndCreateNewParty()
      returnToBusCalled = true
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 2)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_contine", "ID:221041")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_continue_button", localPlayer.buttonLayout.accept)
      returnToBusWindowOpen = false
    elseif Network.isPartyLeader() then
      Network.returnPartyToBus()
      returnToBusCalled = true
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 2)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_contine", "ID:221041")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_continue_button", localPlayer.buttonLayout.accept)
      returnToBusWindowOpen = false
    elseif g_NetworkTime - startTimer > timer + 4 then
      Network.leaveMatchAndCreateNewParty()
      returnToBusCalled = true
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 2)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_contine", "ID:221041")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_continue_button", localPlayer.buttonLayout.accept)
      returnToBusWindowOpen = false
    end
  end
end
local exit = function(forced)
end
local returnToBusState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(returnToBusState, stateIndex, "ReturnToBusState")
