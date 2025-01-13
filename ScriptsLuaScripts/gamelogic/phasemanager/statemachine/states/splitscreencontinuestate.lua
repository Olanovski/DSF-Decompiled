module("phaseManager")
local stateIndex = SplitscreenContinueStateIndex
local stateComplete = false
local countStartTime = 0
local instance
local function debugCheck()
  NetworkLog.Write(">[LUA] SplitscreenContinueState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
  print("SplitscreenContinueState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
end
local function enter()
  stateComplete = false
  onlineScreenManager.onSplitscreenModeLoaded()
end
local function step()
  if ssFadedOut and onlineScreenManager.splitscreenContinuPressed and not localPlayerManager.players[0].zapTransition and not localPlayerManager.players[1].zapTransition then
    onlineScreenManager.closeSplitscreenIntro()
    onlineScreenManager.endScreen(cards.MissionNetworkLookup[networkVars.modeIndex])
    OneShotSound.Play("ZAP_CutsceneMixTransition_OneShot", false)
    transitions.fadeto(vec.vector(0, 0, 0, 0), 1, 3, function()
      stateComplete = true
    end, false, true, "all", nil, nil)
    ssFadedOut = false
    feedbackSystem.splitScreenSupport.disableSSHud = false
    zap.multiplayerSettings.setOnlineZapFuelLevel(3)
    scoreSystem.maxAbility(0)
    scoreSystem.maxAbility(1)
    feedbackSystem.multiplayerSupport.enableSSAbilityBar(0)
    feedbackSystem.multiplayerSupport.enableSSAbilityBar(1)
    enableAbilities(0, true)
    enableAbilities(1, true)
    localPlayer.minimapSupport.showSS(0)
    localPlayer.minimapSupport.showSS(1)
    feedbackSystem.multiplayerSupport.enableSSSpeedo(0)
    feedbackSystem.multiplayerSupport.enableSSSpeedo(1)
    feedbackSystem.menusMaster.enableDamageBar(localPlayerManager.players[0])
    feedbackSystem.menusMaster.enableDamageBar(localPlayerManager.players[1])
  end
  if stateComplete and readyCheck() then
    stateMachine.changeState(states[CountDownStateIndex])
  end
end
local exit = function(forced)
  gamerTag.enabled = true
end
local ssContinueState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(ssContinueState, stateIndex, "SplitscreenContinueState")
