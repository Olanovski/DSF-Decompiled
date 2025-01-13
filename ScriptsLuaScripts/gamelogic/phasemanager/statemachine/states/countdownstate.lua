module("phaseManager")
local stateIndex = CountDownStateIndex
local stateComplete = false
local countStartTime = 0
local instance
local function debugCheck()
  NetworkLog.Write(">[LUA] CountDownState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
  print("CountDownState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
end
local function enter()
  if isLocal then
    networkVars.gameStartTime = g_NetworkTime + 3.6
  end
  stateComplete = false
  if not faceOffNext() then
    instance = challengeSystem.instances[networkVars.modeID]
  else
    feedbackSystem.multiplayerSupport.resetNeutralPlayerColours()
  end
  if not gameStatus.splitscreenSession then
    if not skipIntroHUD and not stateMachine.catchUp and (faceOffNext() or instance and not instance.challenge.settings.tutorial) then
      if faceOffNext() then
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_race_countdown_qualify", onlineScreenManager.onlineScreenData[faceOffSystem.currentFaceOff.faceOff.settings.title].description1)
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Countdown_Type", 2)
      else
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Countdown_Type", 1)
      end
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Play_Race_Countdown", 1)
      addUserUpdateFunction("reenableOnlinePause", function()
        if Menu.GetSceneStatus("Online_HUD", "multi_race_countdown") == 2 then
          PauseMenu.allow(true)
          removeUserUpdateFunction("reenableOnlinePause")
        end
      end, 60, true)
    else
      PauseMenu.allow(true)
    end
  else
    local missionData = cardSystem.createMission(cards.MissionNetworkLookup[networkVars.modeIndex])
    local introHUDName = missionData.settings.introHUD
    introHUD = {}
    if introHUDName then
      assert(feedbackSystem.HUDBuilders[introHUDName], "FEEDBACKSYSTEM - setTaskFeedback: Couldn't find specified HUD: " .. tostring(introHUDName))
      introHUD.update, introHUD.goalComplete, introHUD.taskComplete, introHUD.cleanup = feedbackSystem.HUDBuilders[introHUDName].mission(instance, {})
    end
    feedbackSystem.menusMaster.currentHUDSetVariable("iSS_racemode_countdown", 1)
    OneShotSound.Play("HUD_Gen_321GO_Play", false)
    PauseMenu.allow(false)
  end
  countStartTime = g_NetworkTime
  if not gameStatus.splitscreenSession then
    localPlayer:showHUDElements(true)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 3)
    if introHUD and not faceOffNext() and onlineSideBar.getSidebarCollapsedPreference() then
      onlineSideBar.forceMinimiseSidbar()
    end
    if faceOffNext() then
      if faceOffSystem.allowSidebarToggle ~= 0 then
        onlineSideBar.showSidebarExpandPrompt()
      end
    elseif not instance.challenge.settings.tutorial then
      if onlineSideBar.isHidden() then
        onlineSideBar.setHidden(false)
        removeUserUpdateFunction("showOnlineSidebar")
      end
      onlineSideBar.showSidebarExpandPrompt()
    end
  end
end
local prevSecond = 0
local function step()
  if not stateComplete then
    if skipIntroHUD or stateMachine.catchUp then
      stateComplete = true
      sendMessage(2, stateIndex)
    elseif not faceOffNext() and instance.challenge.settings.tutorial then
      stateComplete = true
      sendMessage(2, stateIndex)
    elseif g_NetworkTime - countStartTime > 3 then
      stateComplete = true
      sendMessage(2, stateIndex)
    elseif not faceOffNext() then
      if introHUD and introHUD.update then
        introHUD.update()
      end
      if instance and instance.countdownUpdate then
        instance.countdownUpdate(instance)
      end
    end
  end
  if not skipIntroHUD and not stateMachine.catchUp and (faceOffNext() or instance and not instance.challenge.settings.tutorial) then
    local currSecond = math.ceil(g_NetworkTime - countStartTime)
    if currSecond ~= prevSecond then
      if currSecond == 1 then
        OneShotSound.Play("HUD_Gen_321GO", false)
      elseif currSecond == 4 then
      end
      prevSecond = currSecond
    end
  end
  if not faceOffNext() and instance.stepHighlightColours then
    instance.stepHighlightColours(instance)
  elseif faceOffNext() then
    feedbackSystem.multiplayerSupport.stepNeutralPlayerColours()
    feedbackSystem.faceOffSupport.update()
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    if not gameStatus.splitscreenSession then
      stateMachine.changeState(states[WaitForStartStateIndex])
    else
      stateMachine.changeState(states[RunModeStateIndex])
    end
  end
end
local exit = function(forced)
  if introHUD and introHUD.cleanup then
    introHUD.cleanup()
  end
  introHUD = false
  if forced then
    if faceOffNext() then
      feedbackSystem.faceOffSupport.removeFeedback()
    end
    removeUserUpdateFunction("reenableOnlinePause")
    PauseMenu.allow(true)
    removeUserUpdateFunction("showOnlineSidebar")
  end
  local chosenModeName = cards.MissionNetworkLookup[networkVars.modeIndex]
  onlineScreenManager.endScreen(chosenModeName)
end
local countDownState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(countDownState, stateIndex, "CountDownState")
