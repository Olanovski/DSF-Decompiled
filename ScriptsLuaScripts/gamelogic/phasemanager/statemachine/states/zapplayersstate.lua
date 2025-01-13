module("phaseManager")
playerControlLockedUntilGameStart = false
local stateIndex = ZapPlayerStateIndex
local stateComplete = false
local stateStartTime = 0
local timeBeforeZap = 1
local instance
local playerZapCalled = {
  [0] = false,
  [1] = false
}
local function debugCheck()
  NetworkLog.Write(">[LUA] ZapPlayerState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. "  playerZapCalled[ 0 ] = " .. tostring(playerZapCalled[0]) .. " playerZapCalled[ 1 ] = " .. tostring(playerZapCalled[1]))
  print("ZapPlayerState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. "  playerZapCalled[ 0 ] = " .. tostring(playerZapCalled[0]) .. " playerZapCalled[ 1 ] = " .. tostring(playerZapCalled[1]))
  networkLogPrintTable(vehicleManager.vehiclesBySNVID)
  printTable(vehicleManager.vehiclesBySNVID)
end
local function enter()
  stateComplete = false
  stateStartTime = g_NetworkTime
  if not faceOffNext() then
    instance = challengeSystem.instances[networkVars.modeID]
  else
    feedbackSystem.multiplayerSupport.resetNeutralPlayerColours()
  end
  playerZapCalled[0] = false
  playerZapCalled[1] = not localPlayerManager.players[1] and true or false
end
local function zapPlayer()
  if not localPlayer.zapBlockedFromCode then
    for localID, player in next, localPlayerManager.players, nil do
      if not playerZapCalled[localID] then
        for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
          if vehicle.networkVars.onlineOwnerID == player.playerID then
            if not player.currentVehicle then
              if gameStatus.splitscreenSession then
                OneShotSound.Play("ZAP_CutsceneMixTransition_OneShot", false)
              end
              player:SetZapLevel(0, vehicle, nil, {disableZapFlash = true, forcedOut = true})
            end
            playerControlLockedUntilGameStart = true
            player.controllerInterface:removePlayerControl()
            playerZapCalled[localID] = true
          end
        end
      end
    end
  end
end
local function step()
  if (not playerZapCalled[0] or not playerZapCalled[1]) and g_NetworkTime - stateStartTime > timeBeforeZap then
    if faceOffNext() then
      zapPlayer()
    elseif networkVars.modeID and challengeSystem.instances[networkVars.modeID] then
      zapPlayer()
    end
  end
  if not faceOffNext() and instance.stepHighlightColours then
    instance.stepHighlightColours(instance)
  elseif faceOffNext() then
    feedbackSystem.multiplayerSupport.stepNeutralPlayerColours()
    feedbackSystem.faceOffSupport.update()
  end
  if not stateComplete then
    stateComplete = true
    for localID, player in next, localPlayerManager.players, nil do
      if not player.currentVehicle or player.zapTransition then
        stateComplete = false
        break
      end
    end
    if stateComplete then
      sendMessage(2, stateIndex)
    end
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    if not gameStatus.splitscreenSession then
      gamerTag.enabled = true
      stateMachine.changeState(states[CountDownStateIndex])
    else
      stateMachine.changeState(states[SplitscreenContinueStateIndex])
    end
  end
end
local exit = function(forced)
  feedbackSystem.multiplayerSupport.enableZapReticle()
  if forced then
    PauseMenu.allow(true)
    onlineSideBar.purge()
    feedbackSystem.faceOffSupport.removeFeedback()
    removeUserUpdateFunction("showOnlineSidebar")
  end
end
local zapPlayerState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(zapPlayerState, stateIndex, "ZapPlayerState")
