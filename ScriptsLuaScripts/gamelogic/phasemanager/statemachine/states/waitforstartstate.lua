module("phaseManager")
local stateIndex = WaitForStartStateIndex
local stateComplete = false
local instance
local function debugCheck()
  NetworkLog.Write(">[LUA] WaitForStartState: stateComplete = " .. tostring(stateComplete) .. ", g_NetworkTime = " .. tostring(g_NetworkTime) .. ", gameStartTime = " .. tostring(networkVars.gameStartTime))
  print("WaitForStartState: stateComplete = " .. tostring(stateComplete) .. ", g_NetworkTime = " .. tostring(g_NetworkTime) .. ", gameStartTime = " .. tostring(networkVars.gameStartTime))
end
local function enter()
  stateComplete = false
  if not faceOffNext() then
    instance = challengeSystem.instances[networkVars.modeID]
  else
    instance = false
  end
  startTime = g_NetworkTime
end
local function step()
  if not stateComplete and (not stateMachine.catchUp and (g_NetworkTime > networkVars.gameStartTime or instance and instance.challenge.settings.tutorial) or stateMachine.catchUp and g_NetworkTime - startTime > 1.1) then
    stateComplete = true
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
  if stateComplete then
    if faceOffNext() then
      stateMachine.changeState(states[RunFaceOffStateIndex], true)
    else
      stateMachine.changeState(states[RunModeStateIndex], true)
    end
  end
end
local exit = function(forced)
  if forced then
    onlineSideBar.purge()
    feedbackSystem.faceOffSupport.removeFeedback()
    removeUserUpdateFunction("reenableOnlinePause")
    PauseMenu.allow(true)
    removeUserUpdateFunction("showOnlineSidebar")
  end
end
local waitForStartState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(waitForStartState, stateIndex, "WaitForStartState")
