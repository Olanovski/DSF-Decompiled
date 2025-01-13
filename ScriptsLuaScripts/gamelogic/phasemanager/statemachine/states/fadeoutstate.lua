module("phaseManager")
local stateIndex = FadeOutStateIndex
local stateComplete = false
local function debugCheck()
  NetworkLog.Write(">[LUA] FadeOutState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
  print("FadeOutState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
end
local function enter()
  stateComplete = false
end
local function step()
  if not ssFadedOut and not localPlayerManager.players[0].zapTransition and not localPlayerManager.players[1].zapTransition then
    stateComplete = false
    local willReset = challengeSystem.instances[networkVars.modeID].networkVars.modeWillReset
    transitions.fadeto(vec.vector(0, 0, 0, 1), -1, 1, function()
      sendMessage(2, stateIndex)
      stateComplete = true
    end, false, true, "all", nil, nil)
    ssFadedOut = true
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    stateMachine.changeState(states[HighLevelZapStateIndex])
  end
end
local exit = function(forced)
end
local fadeOutState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(fadeOutState, stateIndex, "fadeOutState")
