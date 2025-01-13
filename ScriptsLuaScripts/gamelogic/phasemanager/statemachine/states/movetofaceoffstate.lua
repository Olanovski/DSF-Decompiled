module("phaseManager")
local stateIndex = MoveToFaceOffStateIndex
local stateComplete = false
local moved = false
local screenType = false
local delayStart = false
local moveToStartArea = function()
  if faceOffSystem.faceOffPool[networkVars.modeIndex] then
    zapcontroller.zapTransitionToPointTracking(0, faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].target, true)
  end
end
local function debugCheck()
  NetworkLog.Write(">[LUA] MoveToFaceOffState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " moved = " .. tostring(moved))
  print("MoveToFaceOffState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " moved = " .. tostring(moved))
end
local function enter()
  stateComplete = false
  delayStart = false
  moved = false
  removeUserUpdateFunction("shiftMove")
end
local function step()
  if not stateComplete and networkVars.modeIndex ~= 0 then
    if phaseManager.skipIntroHUD then
      if faceOffSystem.faceOffPool[networkVars.modeIndex] then
        moveToStartArea()
        stateComplete = true
        sendMessage(2, stateIndex)
      end
    else
      stateComplete = true
      sendMessage(2, stateIndex)
    end
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    stateMachine.changeState(states[CreateFaceOffStateIndex])
  end
end
local function exit(forced)
  if isLocal and networkVars.screenBlockStartTime == 0 then
    networkVars.screenBlockStartTime = g_NetworkTime
    networkVars.screenBlockEndTime = g_NetworkTime + faceOffIntroLength()
  end
  if not forced and faceOffSystem.faceOffPool[networkVars.modeIndex] then
    delayStart = false
    onlineScreenManager.showScreen(7, networkVars.screenBlockStartTime, onlineScreenManager.screenSortTypes.scoreNoID, faceOffSystem.faceOffPool[networkVars.modeIndex].settings.title, function()
      if not phaseManager.skipIntroHUD then
        delayStart = g_NetworkTime
        addUserUpdateFunction("shiftMove", function()
          if not delayStart then
            removeUserUpdateFunction("shiftMove")
          elseif g_NetworkTime - delayStart > 2 then
            moveToStartArea()
            removeUserUpdateFunction("shiftMove")
          end
        end, 60)
      end
    end, function()
      if initialiseComplete and stateMachine.moveState then
        return true
      end
      return false
    end, faceOffIntroTimeOut)
  end
end
local moveToFaceOffState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(moveToFaceOffState, stateIndex, "MoveToFaceOffState")
