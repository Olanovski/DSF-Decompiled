module("phaseManager")
local stateIndex = ZoomToModeStateIndex
local stateComplete = false
local instance = false
local function debugCheck()
  NetworkLog.Write(">[LUA] ZoomToModeState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
  print("ZoomToModeState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()))
end
local function enter()
  stateComplete = false
  gamerTag.setPlayerGamerTagsEnabled(true)
  gamerTag.enabled = true
  for localID, player in next, localPlayerManager.players, nil do
    if zapcontroller.getZapLevel(localID) ~= 3 then
      for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
        if vehicle.networkVars.onlineOwnerID == player.playerID then
          local angle = math.atan2(-vehicle.matrix[2][2], -vehicle.matrix[2][0])
          if not player.currentVehicle then
            zapcontroller.setActionPoinTracking(vehicle.position, angle, 1, localID)
          end
        end
      end
      player:SetZapLevel(1, nil, false, {forcedOut = true})
    end
  end
  if not faceOffNext() then
    instance = challengeSystem.instances[networkVars.modeID]
    if instance.setModeLockingZone then
      instance:setModeLockingZone()
    end
  else
    instance = false
  end
end
local function step()
  if introHUD and introHUD.update then
    introHUD.update()
  end
  if not faceOffNext() and instance.stepHighlightColours then
    instance.stepHighlightColours(instance)
  elseif faceOffNext() then
    feedbackSystem.multiplayerSupport.stepNeutralPlayerColours()
    feedbackSystem.faceOffSupport.update()
  end
  if not stateComplete and zapcontroller.getZapLevel() == 1 then
    stateComplete = true
    sendMessage(2, stateIndex)
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    stateMachine.changeState(states[ZapPlayerStateIndex])
  end
end
local exit = function(forced)
  if forced then
    if introHUD and introHUD.cleanup then
      introHUD.cleanup()
    end
    introHUD = false
    onlineSideBar.purge()
    feedbackSystem.faceOffSupport.removeFeedback()
    PauseMenu.allow(true)
    removeUserUpdateFunction("showOnlineSidebar")
  end
end
local zoomToModeState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(zoomToModeState, stateIndex, "ZoomToModeState")
