module("phaseManager")
local stateIndex = GlobalStateIndex
local numPlayers = -1
local currentStateIndex = 0
local settings = false
local numPlayersNeeded = 0
local instance
local timer = 0
local startTime = 0
local debugCheck = function()
  print("GlobalState")
  NetworkLog.Write(">[LUA] GlobalState")
end
local enter = function()
end
local function step()
  currentStateIndex = stateMachine.getCurrentStateIndex()
  removeFlaggedForDeletionObjects()
  if not returnToBusCalled and currentStateIndex ~= ReturnToBusStateIndex then
    if not allowTooFewPlayers and playerManager.numberOfPlayers == 1 and gameStatus.onlineSessionType == gameStatus.onlineSessionID.private then
      if isLocal and currentStateIndex ~= NewSessionStateIndex and not cardSystem.createMission(playlistSupport.getCurrentMission()).settings.tutorial then
        toFewPlayers(1)
        stateMachine.forceToState(states[ReturnToBusStateIndex], true)
      end
    elseif skipIntroHUD and playerShortage then
      if isLocal then
        stateMachine.resetStateMachine()
      else
        forcedToJoining()
        stateMachine.forceToState(phaseManager.states[JoiningStateIndex])
      end
    elseif faceOffSystem.currentFaceOff and stateMachine.catchUp and faceOffSystem.currentFaceOff:instanceComplete() and (currentStateIndex == HighLevelZapStateIndex or currentStateIndex == WaitingForPlayersStateIndex or currentStateIndex == ChooseFaceOffStateIndex or networkVars.phase == LoadRouteStateIndex or networkVars.phase == MoveToFaceOffStateIndex or currentStateIndex == CreateFaceOffStateIndex or currentStateIndex == VehicleSpooledStateIndex or currentStateIndex == SpoolLockStateIndex or currentStateIndex == TeamMoveToModeStateIndex or currentStateIndex == SpawnVehiclesCleanupStateIndex or currentStateIndex == SpawnVehiclesStateIndex or currentStateIndex == ZoomToModeStateIndex or currentStateIndex == ZapPlayerStateIndex or currentStateIndex == CountDownStateIndex or currentStateIndex == WaitForStartStateIndex) then
      forcedToJoining()
      stateMachine.forceToState(phaseManager.states[JoiningStateIndex])
    end
    if networkVars.modeID and challengeSystem.instances[networkVars.modeID] and not challengeSystem.instances[networkVars.modeID].challenge.settings.tutorial then
      if stateMachine.catchUp and challengeSystem.instances[networkVars.modeID]:instanceComplete() then
        if currentStateIndex == HighLevelZapStateIndex or currentStateIndex == ChooseModeStateIndex or networkVars.phase == LoadRouteStateIndex or networkVars.phase == MoveToModeStateIndex or currentStateIndex == CreateModeStateIndex or currentStateIndex == TeamMoveToModeStateIndex or currentStateIndex == SpawnVehiclesCleanupStateIndex or currentStateIndex == VehicleSpooledStateIndex or currentStateIndex == SpoolLockStateIndex or currentStateIndex == SpawnVehiclesStateIndex or currentStateIndex == ZoomToModeStateIndex or currentStateIndex == ZapPlayerStateIndex or currentStateIndex == CountDownStateIndex or currentStateIndex == WaitForStartStateIndex then
          forcedToJoining()
          stateMachine.forceToState(phaseManager.states[JoiningStateIndex])
        end
      elseif challengeSystem.instances[networkVars.modeID].isLocal and (currentStateIndex == SpawnVehiclesCleanupStateIndex or networkVars.phase == TeamMoveToModeStateIndex or currentStateIndex == SpawnVehiclesStateIndex or currentStateIndex == RunModeStateIndex) then
        settings = challengeSystem.instances[networkVars.modeID].challenge.settings
        if settings.tutorial then
          numPlayersNeeded = 1
        elseif settings.teamGame then
          numPlayersNeeded = 1
        else
          numPlayersNeeded = 2
        end
        workOutPlayerShortage(numPlayersNeeded, settings.teamGame)
        if playerShortage then
          if settings.teamGame then
            toFewPlayers(2)
          else
            toFewPlayers(1)
          end
          if currentStateIndex == RunModeStateIndex and not challengeSystem.instances[networkVars.modeID]:instanceComplete() and challengeSystem.instances[networkVars.modeID].networkVars.startTime > -1 then
            challengeSystem.instances[networkVars.modeID]:initiateOverTimePhase()
            if challengeSystem.instances[networkVars.modeID].challenge.settings.numRounds then
              if challengeSystem.instances[networkVars.modeID].challenge.settings.numRounds > 0 then
                challengeSystem.instances[networkVars.modeID].networkVars.roundOn = challengeSystem.instances[networkVars.modeID].challenge.settings.numRounds
              else
                challengeSystem.instances[networkVars.modeID].networkVars.roundOn = challengeSystem.instances[networkVars.modeID].challenge.settings.maxRounds
              end
            end
          else
            stateMachine.forceToState(states[CleanupStateIndex], true)
          end
        end
      end
    end
    instance = challengeSystem.instances[networkVars.modeID]
    if instance and instance.challenge.settings.raceMode and not instance:instanceComplete() and instance.networkVars.routeIndex ~= 0 and networkVars.modeAreaIndex ~= 0 and instance.challenge.spawnPositions[instance.networkVars.routeIndex].roads then
      if not onlineRaceManager.raceActive then
        onlineRaceManager.setupRace(instance)
        if not instance.challenge.settings.teamGame and localPlayerManager.numberOfPlayers == 1 then
          raceModePlayed = true
        end
      else
        onlineRaceManager.update()
      end
    end
    if phaseManager.playlistSupport.debug_cycle_all_mode or phaseManager.playlistSupport.debug_cycle_playList_mode then
      if challengeSystem.instances[networkVars.modeID] and challengeSystem.instances[networkVars.modeID].isLocal and not challengeSystem.instances[networkVars.modeID]:instanceComplete() then
        if networkVars.phase == RunModeStateIndex then
          timer = g_NetworkTime - startTime
          if timer > phaseManager.playlistSupport.debug_cycle_time then
            challengeSystem.instances[networkVars.modeID]:initiateOverTimePhase()
          end
        else
          timer = 0
          startTime = g_NetworkTime
        end
      end
      if faceOffSystem.currentFaceOff and faceOffSystem.currentFaceOff.isLocal then
        if networkVars.phase == RunFaceOffStateIndex then
          timer = g_NetworkTime - startTime
          if timer > phaseManager.playlistSupport.debug_cycle_time then
            faceOffSystem.forceEndFaceOff()
          end
        else
          timer = 0
          startTime = g_NetworkTime
        end
      end
    end
  end
end
local exit = function(forced)
end
local globalState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(globalState, stateIndex, "GlobalState")
