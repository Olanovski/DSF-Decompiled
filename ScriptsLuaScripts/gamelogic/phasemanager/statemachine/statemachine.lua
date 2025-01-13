module("stateMachine", package.seeall)
local currentState = false
local globalState = false
local supportState = false
local initialised = false
local timeOnState = 0
local lastTime = 0
local waitTime = 0
error = false
blockErrorCheck = false
local timeOfLastStateChange = 0
local errorStepGracePeriod = 11
catchUp = false
moveState = false
wasOnCatchup = false
stateToldToJoin = 0
function init(startCurrentState, startGlobalState)
  removeUserUpdateFunction("hostMigrationTest")
  initialised = true
  error = false
  timeSinceAnyStateChange = g_NetworkTime
  globalState = startGlobalState
  currentState = startCurrentState
  timeOnState = 0
  lastTime = g_NetworkTime
  moveState = false
  phaseManager.sendMessage(1, currentState.index)
  if phaseManager.isLocal then
    phaseManager.networkVars.phase = currentState.index
  end
  if phaseManager.networkVars.phase ~= 0 then
    print("CHANGE STATE - INIT STATE " .. tostring(phaseManager.states[currentState.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. ", owner's state = " .. tostring(phaseManager.states[phaseManager.networkVars.phase].name))
    NetworkLog.Write(">[LUA] CHANGE STATE - INIT STATE " .. tostring(phaseManager.states[currentState.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. ", owner's state = " .. tostring(phaseManager.states[phaseManager.networkVars.phase].name))
  else
    print("CHANGE STATE - INIT STATE " .. tostring(phaseManager.states[currentState.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. " host no state")
    NetworkLog.Write(">[LUA] CHANGE STATE - INIT STATE " .. tostring(phaseManager.states[currentState.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. " host no state")
  end
  globalState.enter()
  currentState.enter()
end
function isInitialised()
  return initialised
end
function setSupportState(state)
  if supportState then
    supportState.exit()
  end
  supportState = state
  if supportState then
    supportState.enter()
  end
end
function isSupportStateSet()
  return supportState
end
local function stepError()
  if g_NetworkTime - timeSinceAnyStateChange > errorStepGracePeriod and currentState.index ~= NewSessionStateIndex and currentState.index ~= JoiningStateIndex and currentState.index ~= ReturnToBusStateIndex then
    if phaseManager.moveToStateList[localPlayer.playerID + 1] ~= currentState.index then
      if currentState.index == RunFaceOffStateIndex then
        if faceOffSystem.currentFaceOff and faceOffSystem.currentFaceOff:getTime() - 20 > phaseManager.faceOffPhaseLength() or timeOnState > phaseManager.faceOffPhaseLengthPublic + 20 then
          if currentState.debugCheck then
            currentState.debugCheck()
          else
            print("YOU HIT LIMBO BUT HAD NO DEBUG CHECK IN THE STATE THAT CAUSED THE LIMBO! " .. tostring(currentState.index))
            NetworkLog.Write("YOU HIT LIMBO BUT HAD NO DEBUG CHECK IN THE STATE THAT CAUSED THE LIMBO! " .. tostring(currentState.index))
          end
          if faceOffSystem.currentFaceOff then
            NetworkLog.Write(">[LUA] KICK REASON - Faceoff Time " .. tostring(faceOffSystem.currentFaceOff:getTime()) .. " > Faceoff time limit " .. tostring(phaseManager.faceOffPhaseLength()) .. " network time " .. tostring(g_NetworkTime) .. " playerID + 1 = " .. tostring(localPlayer.playerID + 1) .. " current state index = " .. tostring(currentState.index))
          else
            NetworkLog.Write(">[LUA] KICK REASON - NO FACE OFF network time " .. tostring(g_NetworkTime) .. " playerID + 1 = " .. tostring(localPlayer.playerID + 1) .. " current state index = " .. tostring(currentState.index))
          end
          networkLogPrintTable(phaseManager.moveToStateList)
          networkLogPrintTable(phaseManager.currentStateList)
          networkLogPrintTable(onlineScreenManager.getScreenStack())
          printTable(phaseManager.moveToStateList)
          printTable(phaseManager.currentStateList)
          printTable(onlineScreenManager.getScreenStack())
          error = true
          forceToState(phaseManager.states[ReturnToBusStateIndex])
        end
      elseif currentState.index == RunModeStateIndex then
        if challengeSystem.instances[phaseManager.networkVars.modeID] and challengeSystem.instances[phaseManager.networkVars.modeID].challenge.settings.modeTimeLimit and challengeSystem.instances[phaseManager.networkVars.modeID]:getTime() - 20 > challengeSystem.instances[phaseManager.networkVars.modeID].challenge.settings.modeTimeLimit then
          if currentState.debugCheck then
            currentState.debugCheck()
          else
            print("YOU HIT LIMBO BUT HAD NO DEBUG CHECK IN THE STATE THAT CAUSED THE LIMBO! " .. tostring(currentState.index))
            NetworkLog.Write("YOU HIT LIMBO BUT HAD NO DEBUG CHECK IN THE STATE THAT CAUSED THE LIMBO! " .. tostring(currentState.index))
          end
          NetworkLog.Write(">[LUA] KICK REASON - Mode Time " .. tostring(challengeSystem.instances[phaseManager.networkVars.modeID]:getTime()) .. " > mode time limit " .. tostring(challengeSystem.instances[phaseManager.networkVars.modeID].challenge.settings.modeTimeLimit) .. " network time " .. tostring(g_NetworkTime) .. " playerID + 1 = " .. tostring(localPlayer.playerID + 1) .. " current state index = " .. tostring(currentState.index))
          networkLogPrintTable(phaseManager.moveToStateList)
          networkLogPrintTable(phaseManager.currentStateList)
          networkLogPrintTable(onlineScreenManager.getScreenStack())
          printTable(phaseManager.moveToStateList)
          printTable(phaseManager.currentStateList)
          printTable(onlineScreenManager.getScreenStack())
          error = true
          forceToState(phaseManager.states[ReturnToBusStateIndex])
        end
      else
        if currentState.index == WaitingForPlayersStateIndex then
          if phaseManager.playersJoiningLock then
            waitTime = math.huge
          else
            waitTime = phaseManager.waitingForPlayersTimeOut + 10
          end
        elseif currentState.index == SpoolLockStateIndex then
          if phaseManager.playerShortage then
            waitTime = phaseManager.waitingForPlayersTimeOut + 10
          else
            waitTime = phaseManager.modeCompleteLength() + phaseManager.resultScreenLength() + phaseManager.faceOffIntroLength() + 10
          end
        elseif currentState.index == VehicleSpooledStateIndex then
          waitTime = 60
        else
          waitTime = 30
        end
        if gameStatus.onlineSessionType == gameStatus.onlineSessionID.private and phaseManager.isTeamGame then
          waitTime = waitTime + 20
        end
        if timeOnState > waitTime then
          if currentState.debugCheck then
            currentState.debugCheck()
          else
            print("YOU HIT LIMBO BUT HAD NO DEBUG CHECK IN THE STATE THAT CAUSED THE LIMBO! " .. tostring(currentState.index) .. "   waitTime: " .. tostring(waitTime))
            NetworkLog.Write("YOU HIT LIMBO BUT HAD NO DEBUG CHECK IN THE STATE THAT CAUSED THE LIMBO! " .. tostring(currentState.index))
          end
          NetworkLog.Write(">[LUA] KICK REASON - STUCK ON INTRO STATES TO LONG - Network time on force " .. tostring(g_NetworkTime) .. " playerID + 1 = " .. tostring(localPlayer.playerID + 1) .. " current state index = " .. tostring(currentState.index))
          networkLogPrintTable(phaseManager.moveToStateList)
          networkLogPrintTable(phaseManager.currentStateList)
          networkLogPrintTable(onlineScreenManager.getScreenStack())
          printTable(phaseManager.moveToStateList)
          printTable(phaseManager.currentStateList)
          printTable(onlineScreenManager.getScreenStack())
          error = true
          forceToState(phaseManager.states[ReturnToBusStateIndex])
        end
      end
    elseif not catchUp and currentState.index ~= phaseManager.networkVars.phase and timeOnState > 10 then
      if currentState.debugCheck then
        currentState.debugCheck()
      else
        print("YOU HIT LIMBO BUT HAD NO DEBUG CHECK IN THE STATE THAT CAUSED THE LIMBO! " .. tostring(currentState.index) .. "   waitTime: " .. tostring(waitTime))
        NetworkLog.Write("YOU HIT LIMBO BUT HAD NO DEBUG CHECK IN THE STATE THAT CAUSED THE LIMBO! " .. tostring(currentState.index))
      end
      NetworkLog.Write(">[LUA] KICK REASON - AHEAD OF THE HOST - Network time on force " .. tostring(g_NetworkTime) .. " playerID + 1 = " .. tostring(localPlayer.playerID + 1) .. " current state index = " .. tostring(currentState.index))
      networkLogPrintTable(phaseManager.moveToStateList)
      networkLogPrintTable(phaseManager.currentStateList)
      networkLogPrintTable(onlineScreenManager.getScreenStack())
      printTable(phaseManager.moveToStateList)
      printTable(phaseManager.currentStateList)
      printTable(onlineScreenManager.getScreenStack())
      error = true
      forceToState(phaseManager.states[ReturnToBusStateIndex])
    end
  end
end
function step()
  if initialised then
    globalState.step()
    currentState.step()
    if supportState then
      supportState.step()
    end
    if initialised and not playedTutorial and not blockErrorCheck and gameStatus.onlineSession and not gameStatus.splitscreenSession then
      stepError()
    end
    timeOnState = timeOnState + (g_NetworkTime - lastTime)
    lastTime = g_NetworkTime
  end
end
function release()
  if currentState then
    currentState.exit(true)
  end
  initialised = false
  globalState = nil
  currentState = nil
  catchUp = false
  wasOnCatchup = false
  moveState = false
  lastTime = 0
  error = false
  timeOnState = 0
  stateToldToJoin = 0
  removeUserUpdateFunction("joinProgress")
end
function changeState(newState, forced)
  assert(initialised, "STATE MACHINE, changing state when not initialised")
  if Network.isOnlineHost() and gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode and not phaseManager.SNOID or not phaseManager.playlistSupport.SNOID or not onlineRaceManager.SNOID then
    print("Error in StateMachine.changeState() : required SNOs are missing .. match sync failure!")
    Network.matchSyncFailure()
  end
  NetworkLog.Write(">[LUA] CHANGE STATE - changeState network time = " .. tostring(g_NetworkTime) .. ", trying to move to state = " .. tostring(phaseManager.states[currentState.index].name))
  moveState = false
  currentState.exit()
  currentState = newState
  timeOnState = 0
  if catchUp and currentState.index == phaseManager.networkVars.phase then
    catchUp = false
    wasOnCatchup = true
  else
    wasOnCatchup = false
  end
  phaseManager.sendMessage(1, currentState.index)
  if phaseManager.isLocal then
    phaseManager.networkVars.phase = currentState.index
    if not forced then
      remotePlayerChangeState()
    end
  end
  if phaseManager.networkVars.phase ~= 0 then
    print("CHANGE STATE - " .. tostring(phaseManager.states[currentState.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. ", owner's state = " .. tostring(phaseManager.states[phaseManager.networkVars.phase].name))
    NetworkLog.Write(">[LUA] CHANGE STATE " .. tostring(phaseManager.states[currentState.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. ", owner's state = " .. tostring(phaseManager.states[phaseManager.networkVars.phase].name))
  else
    print("CHANGE STATE - " .. tostring(phaseManager.states[currentState.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. " host no state")
    NetworkLog.Write(">[LUA] CHANGE STATE " .. tostring(phaseManager.states[currentState.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. " host no state")
  end
  currentState.enter()
end
function remotePlayerChangeState()
  PlayerGamePlay.broadcastMessage(2, "")
end
function remotePlayerForceChangeState(stateIndex)
  PlayerGamePlay.broadcastMessage(3, tostring(stateIndex))
end
function remotePlayerReEnterState(stateIndex)
  PlayerGamePlay.broadcastMessage(4, tostring(stateIndex))
end
function getCurrentStateIndex()
  if currentState then
    return currentState.index
  end
  return 0
end
function reenterState(newState)
  moveState = false
  if currentState.index == ReturnToBusStateIndex and currentState.index == JoiningStateIndex then
    NetworkLog.Write(">[LUA] CHANGE STATE - RE ENTER STATE - ignored")
    return
  end
  if catchUp or currentState ~= newState and (newState.index ~= SpawnVehiclesCleanupStateIndex or currentState.index ~= SpawnVehiclesStateIndex) then
    NetworkLog.Write(">[LUA] CHANGE STATE - RE ENTER STATE - forceToState JoiningStateIndex, current state = " .. tostring(phaseManager.states[currentState.index].name) .. ", new state = " .. tostring(phaseManager.states[newState.index].name))
    phaseManager.forcedToJoining()
    forceToState(phaseManager.states[JoiningStateIndex])
    return
  end
  if newState.index == SpawnVehiclesStateIndex then
    newState = phaseManager.states[SpawnVehiclesCleanupStateIndex]
  end
  wasOnCatchup = false
  catchUp = false
  currentState = newState
  timeOnState = 0
  NetworkLog.Write(">[LUA] CHANGE STATE - reenterState network time = " .. tostring(g_NetworkTime))
  if phaseManager.networkVars.phase ~= 0 then
    print("CHANGE STATE - RE ENTER STATE " .. tostring(phaseManager.states[currentState.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. ", owner's state = " .. tostring(phaseManager.states[phaseManager.networkVars.phase].name))
    NetworkLog.Write(">[LUA] CHANGE STATE - RE ENTER STATE " .. tostring(phaseManager.states[currentState.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. ", owner's state = " .. tostring(phaseManager.states[phaseManager.networkVars.phase].name))
  else
    print("CHANGE STATE - RE ENTER STATE " .. tostring(phaseManager.states[currentState.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. " host no state")
    NetworkLog.Write(">[LUA] CHANGE STATE - RE ENTER STATE " .. tostring(phaseManager.states[currentState.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. " host no state")
  end
  phaseManager.sendMessage(1, currentState.index)
  if phaseManager.isLocal then
    phaseManager.networkVars.phase = currentState.index
    stateMachine.remotePlayerReEnterState(currentState.index)
  end
  currentState.enter()
end
function forceToState(state, forceAll)
  if phaseManager.startHUDCleanupFunction then
    phaseManager.startHUDCleanupFunction()
    phaseManager.startHUDCleanupFunction = false
  end
  if currentState.index == ReturnToBusStateIndex or currentState.index == JoiningStateIndex and state.index ~= ReturnToBusStateIndex and not phaseManager.isLocal then
    NetworkLog.Write(">[LUA] CHANGE STATE - FORCE STATE - ignoring")
    return
  end
  stateMachine.setSupportState(false)
  catchUp = false
  moveState = false
  wasOnCatchup = false
  NetworkLog.Write(">[LUA] CHANGE STATE - forceToState network time = " .. tostring(g_NetworkTime))
  phaseManager.clearLoadedRouteData()
  callStack()
  if phaseManager.networkVars.phase ~= 0 then
    print("FORCE STATE " .. tostring(phaseManager.states[state.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. ", owner's state = " .. tostring(phaseManager.states[phaseManager.networkVars.phase].name))
    NetworkLog.Write(">[LUA] CHANGE STATE - FORCE STATE " .. tostring(phaseManager.states[state.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. ", owner's state = " .. tostring(phaseManager.states[phaseManager.networkVars.phase].name))
  else
    print("FORCE STATE " .. tostring(phaseManager.states[state.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. " host no state")
    NetworkLog.Write(">[LUA] CHANGE STATE - FORCE STATE " .. tostring(phaseManager.states[state.index].name) .. ", islocal = " .. tostring(phaseManager.isLocal) .. " host no state")
  end
  onlineScreenManager.purge()
  assert(currentState, "stateMachine.forceToState - Something bad has happened, we have not currentState")
  currentState.exit(true)
  currentState = state
  timeOnState = 0
  phaseManager.sendMessage(1, currentState.index)
  if forceAll then
    stateMachine.remotePlayerForceChangeState(currentState.index)
  end
  currentState.enter(true)
end
function resetStateMachine()
  NetworkLog.Write(">[LUA] STATE MACHINE - resetStateMachine")
  if phaseManager.returnToBusWindowOpen then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 2)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_contine", "ID:221041")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_continue_button", localPlayer.buttonLayout.accept)
    phaseManager.returnToBusWindowOpen = nil
  end
  forceToState(phaseManager.states[CleanupStateIndex], true)
end
local function joinProgress()
  local screenStackSize = #onlineScreenManager.getScreenStack()
  local minTimeInState = screenStackSize > 0 and 4 or 0
  if stateToldToJoin == NewSessionStateIndex and phaseManager.SNOID and phaseManager.playlistSupport.SNOID then
    if currentState.index ~= NewSessionStateIndex then
      changeState(phaseManager.states[NewSessionStateIndex])
    end
    removeUserUpdateFunction("joinProgress")
  elseif phaseManager.SNOID and phaseManager.playlistSupport.SNOID and onlineRaceManager.SNOID and phaseManager.playlistSupport.playlistValid() and minTimeInState <= timeOnState then
    if currentState.index ~= HighLevelZapStateIndex and (challengeSystem.instances[phaseManager.networkVars.modeID] and not challengeSystem.instances[phaseManager.networkVars.modeID]:instanceComplete() or faceOffSystem.currentFaceOff and not faceOffSystem.currentFaceOff:instanceComplete() or not challengeSystem.instances[phaseManager.networkVars.modeID] and not faceOffSystem.currentFaceOff) then
      OnlineModeSettings.onlineDisableAssert = true
      changeState(phaseManager.states[HighLevelZapStateIndex])
      OnlineModeSettings.onlineDisableAssert = false
    end
    removeUserUpdateFunction("joinProgress")
  end
end
function canJoin(stateIndex)
  NetworkLog.Write(">[LUA] PHASE MANAGER - canJoin - " .. tostring(stateIndex))
  phaseManager.sendMessage(7)
  if currentState.index == JoiningStateIndex then
    stateToldToJoin = stateIndex
    if phaseManager.waitForPlayersRequired and phaseManager.networkVars.toFewPlayersType == 0 then
      phaseManager.waitForPlayersRequired = false
    end
    addUserUpdateFunction("joinProgress", joinProgress, 1)
  end
end
function reSendCurrentState()
  if phaseManager.currentStateList[localPlayer.playerID + 1] ~= currentState.index then
    phaseManager.sendMessage(1, currentState.index)
  end
end
function reSendMoveToState()
  if phaseManager.moveToStateList[localPlayer.playerID + 1] ~= currentState.index then
    phaseManager.sendMessage(2, currentState.index)
  end
end
