module("challengeSystem")
local instanceTemplate = {}
instanceTemplate.__index = instanceTemplate
function buildInstance(networkVars, remoteSNOID, networkLinks, areaIndex)
  local missionCard = cards.Missions[cards.MissionNetworkLookup[networkVars.challengeID]]
  local challenge, missionFunctions = cardSystem.createMission(missionCard.name)
  networkVars.isComplete = false
  networkVars.modeWillReset = false
  local instance = {
    isLocal = not remoteSNOID,
    hasPlayerPool = cardSystem.formattedMissionData[missionCard.name].challenge.hasPlayerPool,
    challenge = challenge,
    networkVars = {updateRequired = false},
    taskObjectsByActorID = {},
    networkLinks = {
      {updateRequired = false},
      {updateRequired = false}
    },
    syncedPhase = 0,
    taskList = missionFunctions.taskList,
    initiateChallenge = missionFunctions.initiate,
    assignTaskObjects = missionFunctions.assignTaskObjects,
    missionStart = missionFunctions.missionStart,
    countdownUpdate = missionFunctions.countdownUpdate,
    update = missionFunctions.update,
    getDynamicTargets = missionFunctions.targetList,
    goalComplete = missionFunctions.goalComplete,
    taskComplete = missionFunctions.taskComplete,
    completeCallback = missionFunctions.completeCallback,
    startActor = missionFunctions.startActor,
    initiateRemote = missionFunctions.initiateRemote,
    modeReadyCheck = missionFunctions.modeReadyCheck,
    stepHighlightColours = missionFunctions.stepHighlightColours,
    missionEnd = missionFunctions.missionEnd,
    onPlayerJoinInProgress = missionFunctions.onPlayerJoinInProgress,
    setModeLockingZone = missionFunctions.setModeLockingZone,
    getPlayerProgress = missionFunctions.getPlayerProgress,
    onRacePositionsFinalised = missionFunctions.onRacePositionsFinalised,
    getLocalPlayerFinalScore = missionFunctions.getLocalPlayerFinalScore,
    getPlayerFinalScore = missionFunctions.getPlayerFinalScore,
    getTeamFinalScore = missionFunctions.getTeamFinalScore,
    getPlayerAdditionalSyncData = missionFunctions.getPlayerAdditionalSyncData,
    remoteInitialised = false,
    endInstanceWhenWeCan = false,
    completeCalled = false
  }
  setmetatable(instance, instanceTemplate)
  instance.networkVars = {
    updateRequired = false,
    debugCheckIsLocal = function()
      return instance.isLocal
    end,
    __index = networkVars,
    __newindex = networkParsing.metaSetNetworkVar
  }
  setmetatable(instance.networkVars, instance.networkVars)
  if instance.challenge.settings.numRounds then
    if 0 < instance.challenge.settings.numRounds then
      instance.teamScores = {
        updateRequired = false,
        debugCheckIsLocal = function()
          return instance.isLocal
        end,
        __index = {team1 = 0, team2 = 0},
        __newindex = networkParsing.metaSetNetworkVar
      }
      setmetatable(instance.teamScores, instance.teamScores)
    elseif 0 > instance.challenge.settings.numRounds then
      instance.turnTracking = {
        updateRequired = false,
        debugCheckIsLocal = function()
          return instance.isLocal
        end,
        __index = {
          [1] = 0,
          [2] = 0,
          [3] = 0,
          [4] = 0,
          [5] = 0,
          [6] = 0,
          [7] = 0,
          [8] = 0
        },
        __newindex = networkParsing.metaSetNetworkVar
      }
      setmetatable(instance.turnTracking, instance.turnTracking)
    end
  end
  if instance.challenge.settings.trackPlayerScores then
    instance.playerScores = {
      updateRequired = false,
      debugCheckIsLocal = function()
        return instance.isLocal
      end,
      __index = {
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 0,
        [5] = 0,
        [6] = 0,
        [7] = 0,
        [8] = 0
      },
      __newindex = networkParsing.metaSetNetworkVar
    }
    setmetatable(instance.playerScores, instance.playerScores)
  end
  if instance.challenge.multiplayer then
  else
    for index, actor in ipairs(instance.challenge.actorPool) do
      if actor.warmup then
        assert(actor.whenSpawned == "On warmup", "Mission " .. tostring(instance.challenge.name) .. " has actor " .. tostring(actor.ID) .. " with a warmup set but not set to spawn on warmup")
      end
      if actor.warmup and actor.warmup.style and actor.whenSpawned == "On warmup" and warmups[actor.warmup.style].createStatusCheck then
        actor.warmup.conditionCheck = warmups[actor.warmup.style].createStatusCheck(instance, actor.warmup.settings)
      end
    end
  end
  if not instance.challenge.multiplayer then
    local shutdown = instance.challenge.shutdown
    if shutDowns[shutdown.style].createStatusCheck then
      instance.shutDownCheck = shutDowns[shutdown.style].createStatusCheck(instance, shutdown.settings)
    end
  end
  if instance.isLocal then
    instance.networkVars.phase = GlobalStateIndex
    instance.networkVars.roundOn = 1
    instance.networkVars.routeIndex = areaIndex
    instance.instanceID = createSNOFromObject(instance)
  else
    instance.instanceID = remoteSNOID
  end
  SNO.setMigrationType(instance.instanceID, 1)
  instances[instance.instanceID] = instance
  NetworkLog.Write(">[LUA] CHALLENGESYSTEM - Mission built, SNOID = " .. tostring(instance.instanceID) .. ", mission = " .. tostring(instance.challenge.name) .. ", local = " .. tostring(instance.isLocal))
  checkpointSystem.createQueuedCheckpoints(instance.instanceID)
  return instance
end
function createInstance(missionData, matrixOrVehicleList, modeIndex, areaIndex)
  local instance = false
  if modeIndex and areaIndex then
    instance = buildInstance({challengeID = modeIndex, startTime = -1}, nil, nil, areaIndex)
  else
    local id = cards.ReverseMissionNetworkLookup[missionData.challenge.name]
    instance = buildInstance({challengeID = id})
    if matrixOrVehicleList then
      if type(matrixOrVehicleList) == "userdata" then
        instance.matrix = matrixOrVehicleList
      else
        instance.matrix = matrixOrVehicleList[1].gameVehicle.matrix
        setVehicleListActors(matrixOrVehicleList, instance)
      end
    end
    local mission, potID, subType, type = progressionSystem.findMissionInProgression(missionData.challenge.name)
    if type == "challenge" then
      instance.isChallenge = true
    end
    instance.missionType = type
    local activityGameVehicle = progressionSystem.getActivityGameVehicle()
    if activityGameVehicle then
      GameVehicleResource.resetDamage({gameVehicle = activityGameVehicle})
    end
    if instance.missionType == "challenge" then
      local challengeName = instance.challenge.name
      if subType == "movie" and challengeName ~= "HardcoreChallenge" and challengeName ~= "DownhillDrift" then
        feedbackSystem.menusMaster.masterSetVariable("iGrain", 3)
      end
      ProfileSettings.ClearChallengeNew(cards.ReverseMissionNetworkLookup[challengeName])
    end
    if localPlayer.challenge.retryingMission then
      activeChallenges.preventActiveChallenges = true
      local softSaveData = progressionSystem.getSoftSaveData()
      local positionToSpool
      local function skipPreview(agent)
        if instance.missionType == "challenge" then
          if not instance.fromInWorld then
            spooling.fadeIn()
          else
            addUserUpdateFunction("wait for zap transition", function()
              if not localPlayer.inZap and not localPlayer.zapTransition then
                spooling.fadeIn()
                removeUserUpdateFunction("wait for zap transition")
              end
            end, 60)
          end
        else
          zapcontroller.RemoveChallengeVehicle({
            gameVehicle = agent.gameVehicle
          })
          localPlayer.missionSupport:setHooksFromVehicle(agent)
        end
        localPlayer:SetZapLevel(0, agent, true, {disableZapFlash = true})
        activeChallenges.preventActiveChallenges = false
      end
      if softSaveData then
        local function startMission()
          for actorID, info in next, softSaveData.infoByActorID, nil do
            local actor = instance.challenge.actorPool[actorID]
            local vehicles = challengeSystem.spawnActor(actor, softSaveData.infoByActorID[actorID].spawnLocation, not softSaveData.infoByActorID[actorID].snapToClosestRoad)
            local vehicle = vehicles[1]
            createActor(instance, vehicle, actor, nil, actor.whenSpawned)
          end
          for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
            if actorID == softSaveData.playerActorID then
              local vehicle = taskObject.coreData.agent
              skipPreview(vehicle)
              break
            end
          end
        end
        if feedbackSystem.previewScreen.startMissionFromHotspot and instance.missionType == "challenge" then
          startMission()
        else
          for actorID, info in next, softSaveData.infoByActorID, nil do
            if actorID == softSaveData.playerActorID then
              local actor = instance.challenge.actorPool[actorID]
              missionStartLoading.handleMissionStartLoading(missionData.challenge.name, nil, nil, softSaveData.infoByActorID[softSaveData.playerActorID].spawnLocation.position, startMission)
              break
            end
          end
        end
      else
        local actorPool = instance.challenge.actorPool
        local function startMission()
          spawnActors(instance, "On warmup")
          local playerVehicle
          for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
            if instance.missionType ~= "challenge" then
              taskObject.coreData.agent:missionStartTeleport()
            end
            if taskObject.coreData.actor.hasPreview then
              playerVehicle = taskObject.coreData.agent
            end
          end
          skipPreview(playerVehicle)
        end
        if feedbackSystem.previewScreen.startMissionFromHotspot and instance.missionType == "challenge" then
          startMission()
        else
          for i = 1, #actorPool do
            local actor = actorPool[i]
            if actor.hasPreview then
              missionStartLoading.handleMissionStartLoading(missionData.challenge.name, nil, nil, actor.spawn.missionTeleportLocation and actor.spawn.position, startMission)
              break
            end
          end
        end
      end
    else
      spawnActors(instance, "On warmup")
      for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.hasPreview then
          selfRightVehicleList.addTableOfVehicles({
            taskObject.coreData.agent.gameVehicle
          })
        end
        GameVehicleResource.setDisableAllDamage(taskObject.coreData.agent.gameVehicle, true)
      end
    end
    activeChallenges.addActiveChallenge(instance)
    print("Creating instance... ( instanceID = " .. tostring(instance.instanceID) .. ", challenge = " .. tostring(instance.challenge.name) .. " )")
  end
  return instance
end
local startVehicle = {}
local friendlyVehicles = {}
local enemyVehicles = {}
local allVehicles = {}
local function setInstanceVehicles(taskObject)
  startVehicle = {}
  friendlyVehicles = {}
  enemyVehicles = {}
  startVehicle = {
    taskObject.coreData.instance.taskObjectsByActorID[taskObject.coreData.instance.startActor].coreData.agent.gameVehicle
  }
  table.insert(allVehicles, startVehicle)
  local playerTeam = taskObject.coreData.instance.taskObjectsByActorID[taskObject.coreData.instance.startActor].coreData.actor.team
  for k, v in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
    table.insert(allVehicles, v.coreData.agent.gameVehicle)
    if v.coreData.actor.team == playerTeam and k ~= taskObject.coreData.instance.startActor then
      table.insert(friendlyVehicles, v.coreData.agent.gameVehicle)
    elseif k ~= taskObject.coreData.instance.startActor then
      table.insert(enemyVehicles, v.coreData.agent.gameVehicle)
    end
  end
end
local function getInstanceVehicles(all, friendly, enemy)
  local taskObject
  if localPlayer.currentVehicle then
    taskObject = localPlayer.currentVehicle:getTaskObject()
  end
  if taskObject then
    setInstanceVehicles(taskObject)
  else
    return {}
  end
  if all then
    return allVehicles
  elseif friendly then
    return friendlyVehicles
  elseif enemy then
    return enemyVehicles
  end
end
function instanceTemplate:getTime()
  if self.networkVars.startTime and self.networkVars.startTime ~= -1 then
    return g_NetworkTime - self.networkVars.startTime
  end
  return -1
end
function instanceTemplate:newActorFromAgent(actorID, agent)
  local actor = self.challenge.actorPool[actorID]
  assert(actor, "Couldn't find actor '" .. tostring(actorID) .. "' in challenge '" .. tostring(self.challenge.name) .. "'")
  assert(not self.taskObjectsByActorID[actor.ID], "Duplicate actor '" .. tostring(actorID) .. "' already registered in challenge instance")
  local taskObject = taskSystem.createTaskObject(self, actor, agent, true)
  if actor.whenSpawned == "On warmup" and not actor.hasPreview then
    zapcontroller.AddLockedVehicle(localID, {
      gameVehicle = taskObject.coreData.agent.gameVehicle
    })
  end
  return taskObject
end
function instanceTemplate:registerLinkedObject(objectID, objectType)
  if self.isLocal then
    table.insert(self.networkLinks[objectType], objectID)
    self.networkLinks[objectType].updateRequired = true
  end
  local runMode = stateMachine.getCurrentStateIndex() == RunFaceOffStateIndex or stateMachine.getCurrentStateIndex() == RunModeStateIndex or stateMachine.getCurrentStateIndex() == CoopRunModeStateIndex
  if objectType == 1 and (gameStatus.onlineSession and runMode or self.syncedPhase >= WaitingForPlayersStateIndex) then
    local taskObject = taskSystem.taskObjects[objectID]
    taskObject:initiate()
  end
end
function instanceTemplate:unregisterLinkedObject(objectID, objectType)
  for i, SNOID in ipairs(self.networkLinks[objectType]) do
    if SNOID == objectID then
      table.remove(self.networkLinks[objectType], i)
      if self.isLocal then
        self.networkLinks[objectType].updateRequired = true
      end
      break
    end
  end
end
function instanceTemplate:networkLinksValid()
  for i, taskObjectID in ipairs(self.networkLinks[1]) do
    if not taskSystem.taskObjects[taskObjectID] then
      return false
    end
  end
  for i, checkpointSNOID in ipairs(self.networkLinks[2]) do
    if not checkpointSystem.checkpointSNOs[checkpointSNOID] then
      return false
    end
  end
  return true
end
function instanceTemplate:checkpointsPresent()
  for i, checkpointSNOID in ipairs(self.networkLinks[2]) do
    if not checkpointSystem.checkpointSNOs[checkpointSNOID] then
      return false
    end
  end
  return true
end
function instanceTemplate:phaseSync()
  if self.networkVars.phase < CreateFaceOffStateIndex then
    if self:networkLinksValid() then
      local previousSyncedPhase = self.syncedPhase
      self.syncedPhase = self.networkVars.phase
      if self.syncedPhase == ChooseFaceOffStateIndex and self.challenge.shutdown.settings.stopMajorTasks then
        for actorID, taskObject in next, self.taskObjectsByActorID, nil do
          taskObject:failTasks()
        end
      end
      if previousSyncedPhase == CreateFaceOffStateIndex or previousSyncedPhase < WaitingForPlayersStateIndex and self.syncedPhase >= WaitingForPlayersStateIndex and self.syncedPhase < CreateFaceOffStateIndex then
        self:kickStartTaskObjects()
      end
      self:setPhaseMinorTasks()
    end
  else
    self.syncedPhase = self.networkVars.phase
  end
end
function instanceTemplate:kickStartTaskObjects()
  for actorID, taskObject in next, self.taskObjectsByActorID, nil do
    taskObject:initiate()
  end
  localPlayer.missionSupport:setMainTaskObject(localPlayer:getTaskObject())
end
function instanceTemplate:setPhaseMinorTasks()
  for actorID, taskObject in next, self.taskObjectsByActorID, nil do
    local minorTasks = false
    if self.syncedPhase == GlobalStateIndex then
      if taskObject.coreData.actor.warmup then
        minorTasks = taskObject.coreData.actor.warmup.settings.taskList
      elseif self.challenge.warmup and self.challenge.warmup.settings then
        minorTasks = self.challenge.warmup.settings.taskList
      end
    elseif self.syncedPhase == ChooseFaceOffStateIndex then
      if taskObject.coreData.actor.shutdown then
        minorTasks = taskObject.coreData.actor.shutdown.taskList
      elseif self.challenge.shutdown and self.challenge.shutdown.settings then
        minorTasks = self.challenge.shutdown.settings.taskList
      end
    end
    taskObject:clearMinorTasks()
    if minorTasks then
      taskObject:setMinorTasks(minorTasks)
    end
  end
end
function instanceTemplate:initiateCountdownPhase()
  self.networkVars.countDownTime = g_NetworkTime
  self.networkVars.phase = HighLevelZapStateIndex
end
function instanceTemplate:initiateChallengePhase()
  local challengeName = self.challenge.name
  local playerTaskObject = localPlayer:getTaskObject()
  local isStaticWarmup = not playerTaskObject.coreData.actor.warmup or not playerTaskObject.coreData.actor.missionStartSpawn and playerTaskObject.coreData.actor.warmup.static
  self.networkVars.startTime = g_NetworkTime
  for actorID, taskObject in next, self.taskObjectsByActorID, nil do
    local agent = taskObject.coreData.agent
    if agent.isVehicle then
      for localID, plr in next, localPlayerManager.players, nil do
        zapcontroller.RemoveLockedVehicle(localID, {
          gameVehicle = agent.gameVehicle
        })
      end
      GameVehicleResource.setDisableAllDamage(agent.gameVehicle, false)
      taskObject.coreData.agent:set_damageMultiplier(taskObject.coreData.actor.damageMultiplier or 1)
      local actor = taskObject.coreData.actor
      if not localPlayer.challenge.retryingMission and not taskObject.coreData.actor.selfRightIfOverturned then
        selfRightVehicleList.removeTableOfVehicles({
          agent.gameVehicle
        })
      end
    end
  end
  localPlayer.challenge.setRetryingMission(false)
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    self.rubberbandRoute = softSaveData.rubberbandRoute
    self.loadedFromSoftSave = true
  end
  cardSystem.updateRaceManager(self)
  if not softSaveData then
    cardSystem.spawnOnMissionStartActors(self)
  end
  dareSystem.abortActiveDare()
  activeChallenges.enable(false)
  activeChallenges.disableActivities()
  if felony_getaway.getawaySettingsPerMission[challengeName] and felony_getaway.getawaySettingsPerMission[challengeName].modelIDs then
    felony_patrollingVehicleManager.setSpawningModels(felony_getaway.getawaySettingsPerMission[challengeName].modelIDs)
  end
  local felonySettings = self.challenge.felonySettings
  if felonySettings and felonySettings.disablePoliceInTrafficDuringMission then
    felony_patrollingVehicleManager.enablePatrollingVehicles(false)
  end
  for missionType, missionTable in next, localPlayer.playerAnalysis.playerAnalysisForMission, nil do
    for missionID, playerAnalysisParams in next, missionTable, nil do
      if missionID == self.challenge.name then
        if playerAnalysisParams.playerAnalysis then
          local playerAnalysis = playerAnalysisParams.playerAnalysis
          local defaultAnalysis = {}
          duplicateTable(localPlayer.playerAnalysis.defaultPlayerAnalysis, defaultAnalysis)
          for key, value in next, playerAnalysis, nil do
            defaultAnalysis[key] = value
          end
          PlayerAnalysis.AddWeight(missionType, defaultAnalysis)
        end
        if playerAnalysisParams.decay then
          PlayerAnalysis.SetDecay(missionType, playerAnalysisParams.decay)
        end
      end
    end
  end
  if self.initiateChallenge then
    self.initiateChallenge(self)
  end
  Commentary.StartMission()
  localPlayer:buildZapReturn()
  feedbackSystem.menusMaster.locationPrompt(false)
  if feedbackSystem.previewScreen.activityBeingPrompted then
    feedbackSystem.previewScreen.clearActivityBeingPrompted()
  end
  progressionSystem.setTrafficEvents(false)
  scoreSystem.maxAbility(self.localID)
  self.networkVars.phase = WaitingForPlayersStateIndex
  vehicleManager.previewVehicleManager.challengeHUDPanel(challengeName)
  GameplayTracking.OnMissionStart(missionInfo[cards.ReverseMissionNetworkLookup[challengeName]].challengeTitle)
  GameplayTracking.OnObjectiveStart()
  local excludedIVs = spooling.excludedInterestingVehicles and spooling.excludedInterestingVehicles[challengeName]
  if excludedIVs then
    InterestingVehicleManager.Enable(false)
    vehicleManager.clearOrphanage()
    InterestingVehicleManager.ExcludeVehicles(excludedIVs)
    InterestingVehicleManager.Enable(true)
  else
    vehicleManager.clearOrphanage()
  end
  if self.missionType == "challenge" or self.missionType == "activity" then
    ProfileSettings.SetChallengeAttempted(cards.ReverseMissionNetworkLookup[challengeName])
    Commentary.ForceEventChange()
  else
    ProfileSettings.SetMissionAttempted(cards.ReverseMissionNetworkLookup[challengeName])
    ProfileSettings.SetTotalNumMissionAttempts(ProfileSettings.GetTotalNumMissionAttempts() + 1)
  end
  if not localPlayer.challenge.retryingMission then
    local mission, potID, subType = progressionSystem.findMissionInProgression(challengeName)
    if type ~= "progressionTutorial" then
      progressionSystem.saveGame("When you start a mission (" .. challengeName .. ")")
    end
  end
  if playerTaskObject.coreData and self.challenge.settings.clearVehicleRadius then
    spooling.clearAreaOfVehicles(playerTaskObject.coreData.agent.position, self.challenge.settings.clearVehicleRadius)
  end
  if not gameStatus.onlineSession and playerTaskObject.coreData and not isStaticWarmup and not self.loadedFromSoftSave then
    behaviour = {
      personality = "civ",
      traits = {
        desiredSpeed = playerTaskObject.coreData.actor.spawnSpeed or 10,
        wanderType = "preferStraight",
        avoidedByCivilianTraffic = true,
        maintainLane = true
      }
    }
    localPlayer:enterCutsceneMode({addAI = behaviour})
  end
  zapcontroller.EnableZapInput(true)
  spooling.fadeIn()
end
function instanceTemplate:initiateChallengePhaseRemote()
  if self.initiateRemote then
    print("Got remote initialise function")
    self.initiateRemote(self)
  else
    print("Remote initialise is null")
  end
  self.remoteInitialised = true
end
function instanceTemplate:initiateOverTimePhase(forceEnd)
  if self.isLocal then
    if not self.networkVars.isComplete then
      self.networkVars.isComplete = true
    end
    if not self.networkVars.overTime then
      self.networkVars.overTime = g_NetworkTime
    end
    self.networkVars.updateRequired = true
  else
    sendMessage(self, 1)
  end
  if not self.completeCalled then
    self.completeCalled = true
  end
end
function instanceTemplate:multiplayerAttachPlayer(player)
  if not self.taskObjectsByActorID[PLAYER_STRING_TABLE[player.playerID + 1]] then
    local actor = PLAYER_STRING_TABLE[player.playerID + 1]
    self:newActorFromAgent(actor, player)
  end
end
function instanceTemplate:shouldReset()
  if self.networkVars.modeWillReset then
    return true
  end
  if gameStatus.splitscreenSession then
    phaseManager.lastSSRoundNum = self.networkVars.roundOn
    if phaseManager.failedSSRound then
      return false
    end
  end
  if self.challenge.settings.numRounds then
    if self.challenge.settings.numRounds > 0 then
      if self.networkVars.roundOn < self.challenge.settings.numRounds then
        if self.isLocal then
          self.networkVars.modeWillReset = true
          self.networkVars.startTime = -1
        end
        return true
      end
    elseif self.challenge.settings.numRounds < 0 then
      if self.challenge.settings.maxRounds and self.challenge.settings.maxRounds == self.networkVars.roundOn then
        return false
      end
      for playerID, player in next, playerManager.players, nil do
        if self.turnTracking[playerID + 1] == 0 then
          if self.isLocal then
            self.networkVars.modeWillReset = true
            self.networkVars.startTime = -1
          end
          return true
        end
      end
    end
  end
  return false
end
function instanceTemplate:endMission()
  if self.missionEnd then
    self.missionEnd(self)
  end
  self:delete()
end
function instanceTemplate:delete(fromPurge, orphanInstanceVehicles)
  local playerTaskObject = localPlayer:getTaskObject()
  local activityGameVehicle = progressionSystem.getActivityGameVehicle()
  local activityVehicle = vehicleManager.vehiclesByGameVehicle[activityGameVehicle]
  if instances[self.instanceID] then
    NetworkLog.Write(">[LUA] CHALLENGESYSTEM - Delete mission, SNOID = " .. tostring(self.instanceID) .. ", mission = " .. tostring(self.challenge.name) .. ", local = " .. tostring(self.isLocal))
    self.deleteFromPurge = fromPurge
    print("Deleting instance... ( instanceID = " .. tostring(self.instanceID) .. ", challenge = " .. tostring(self.challenge.name) .. " )")
    if self.missionEnd and fromPurge then
      self.missionEnd(self)
    end
    MPZapToAction.reset()
    if not gameStatus.onlineSession then
      activeChallenges.deleteMissionWarmupMarker(self, true)
    end
    if self.backSeatActive then
      BackSeatDriver.Clear()
      localPlayer:resetCameraMode()
    end
    if self.cleanup then
      self.cleanup()
    end
    if self.dangerZone and fromPurge then
      ZAPSHIELDZONE.delete()
      self.dangerZone = false
    end
    for actorID, taskObject in next, self.taskObjectsByActorID, nil do
      if taskObject.coreData.agent and taskObject.coreData.agent.gameVehicle then
        zapcontroller.RemoveLockedVehicle({
          gameVehicle = taskObject.coreData.agent.gameVehicle
        })
      end
    end
    local playersMission = false
    for localID, plr in next, localPlayerManager.players, nil do
      if fromPurge and (not plr.inZap or vehicleManager.previewVehicleManager.previewVehicle) then
        plr:SetZapLevel(1)
      end
      if plr.missionSupport:getHookedMission() == self then
        playersMission = true
        iCamDeActivation()
        Menu.SetVariable("Pause", "minimapVisible", 1)
        feedbackSystem.menusMaster.clearAllTextPrompts()
        feedbackSystem.menusMaster.locationPrompt(true)
        if self.completeCallback then
          self.completeCallback(self)
        end
        PlayerAnalysis.AddWeight("Race", localPlayer.playerAnalysis.defaultPlayerAnalysis)
        PlayerAnalysis.SetDecay("Race", localPlayer.playerAnalysis.playerAnalysisDecay)
        if not gameStatus.onlineSession then
          if not localPlayer.challenge.retryingMission then
            if moodSystem.missionStartMoods[self.challenge.name] then
              moodSystem.removeMood(self.challenge.name)
            elseif playerTaskObject.coreData.instance.missionType == "challenge" then
              local mission, potID, subType, type = progressionSystem.findChallengeInProgression(self.challenge.name)
              local chapter = mission.settings.chapter
              if chapter and chapter ~= progressionSystem.currentChapter then
                local chapterMood
                if chapter ~= 10 then
                  chapterMood = "Chapter" .. chapter
                else
                  chapterMood = "FreeDrive"
                end
                moodSystem.removeMood(chapterMood)
              end
            end
          end
          for actorID, taskObject in next, self.taskObjectsByActorID, nil do
            local agent = taskObject.coreData.agent
            if agent.gameVehicle then
              if agent.gameVehicle.parentVehicle then
                GameVehicleResource.detachVehicle(agent.gameVehicle)
              elseif agent.gameVehicle.childVehicle then
                GameVehicleResource.detachVehicle(agent.gameVehicle.childVehicle)
              end
            end
          end
          if not self.challenge.settings.disableZapOnCompletion then
            if localPlayer.challenge.retryingMission then
              localPlayer:SetZapLevel(7, nil, false, {forcedOut = true})
            else
              localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
            end
          end
          Getaway.StopAll()
          Chase.StopAll()
          localPlayer:clearAllFelonies()
          if not self.challenge.settings.disableZapOnCompletion then
            if felony_chase.endScreenVehicle and felony_chase.endScreenVehicle ~= activityVehicle then
              felony_chase.endScreenVehicle:makeOrphan()
            end
            localPlayer:clearCurrentVehicle()
            localPlayer:clearPreviousVehicle()
            simulation.resetLevel()
            vehicleManager.clearOrphanage()
          end
          felony_chase.endScreenVehicle = nil
          Commentary.StopCommentary()
          tannerNarration.startNarrationManager()
          felony_patrollingVehicleManager.setSpawningModels()
        end
        for localID, plr in next, localPlayerManager.players, nil do
          plr.missionSupport:releaseInstanceHook()
        end
        if not localPlayer.challenge.retryingMission and not gameStatus.onlineSession then
          dareSystem.initialiseSavedDare()
          activeChallenges.enableActivities()
          activeChallenges.enableCollectables()
          abilities.thrillCam.enable()
        end
        localPlayer:clearZapReturnOverride()
        if self.challenge.settings.enableTrafficAtMissionEnd then
          spooling.enableTraffic(true)
        end
        local felonySettings = self.challenge.felonySettings
        if felonySettings then
          felony_patrollingVehicleManager.enablePatrollingVehicles(true)
        end
        if not gameStatus.onlineSession and propSystem.missionPropsActive then
          propSystem.cleanupRuntimeProps()
        end
        if not plr.inZap and not self.challenge.settings.disableZapOnCompletion then
          plr:resetCameraMode()
        end
        if not gameStatus.splitscreenSession and self.challenge.name ~= "Exposition 03 zap at will" then
          feedbackSystem.menusMaster.blockHintButton(false)
          feedbackSystem.menusMaster.focusHintButtonState(true)
          feedbackSystem.menusMaster.masterSetVariable("iGrain", 0)
          feedbackSystem.clearHUD()
        end
        RouteArrowsManager.ClearArrows()
        RaceManager.RemoveRace(self.raceId)
        self.raceId = nil
        checkpointSystem.clearNoneSyncronisedCheckpoint()
        assert(checkpointSystem.canDeleteInstanceCheckpoints(self))
        checkpointSystem.deleteInstanceCheckpoints(self)
        minimap.SetHighlightedVehicles(false)
        progressionSystem.setTrafficEvents(true)
        InterestingVehicleManager.ExcludeVehicles()
        WwiseMotion.TriggerEvent("MOTION_NITRO_ALL_STOP")
      end
    end
    for actorID, taskObject in next, self.taskObjectsByActorID, nil do
      for i, taskGroup in next, taskObject.taskList, nil do
        for j, task in ipairs(taskGroup) do
          if not task.stopped then
            taskSystem.stopTask(task)
          end
        end
      end
    end
    if activityVehicle and not localPlayer.challenge.retryingMission then
      local actor = {previewMovie = true}
      local vehicleSettings = challengeSystem.generateVehicleSettings(actor)
      local location = {
        matrix = activityVehicle.matrix
      }
      local tableOfMatrices = challengeSystem.spawnActor(actor, location, false, true)
      activityVehicle:teleport(tableOfMatrices[1])
    end
    for actorID, taskObject in next, self.taskObjectsByActorID, nil do
      if not taskObject.coreData.doNotDelete and taskObject:canBeDeleted(taskObject.coreData.taskObjectID) then
        local agent = taskObject.coreData.agent
        local shouldDeleteVehicle = agent.gameVehicle ~= progressionSystem.getActivityGameVehicle() and not orphanInstanceVehicles
        agent.raceId = nil
        if orphanInstanceVehicles then
          zapcontroller.AddLockedVehicle({
            gameVehicle = agent.gameVehicle
          })
        end
        taskObject:delete(shouldDeleteVehicle)
        self.taskObjectsByActorID[actorID] = nil
      end
    end
    if playersMission then
      for localID, plr in next, localPlayerManager.players, nil do
        if not progressionSystem.getActivityGameVehicle() and not self.challenge.settings.disableZapOnCompletion or self.challenge.settings.disableZapOnCompletion and plr.challenge.retryingMission then
          if not plr.inZap then
            plr:SetZapLevel(1, nil, false, {forcedOut = true})
            plr:clearCurrentVehicle()
          else
            zapcontroller.FPPShowZapFlare(true)
          end
        end
      end
    end
    activeChallenges.removeActiveChallenge(self)
    instances[self.instanceID] = nil
    if self.isLocal then
      assert(SNO.canBeDeleted(self.instanceID))
      SNO.setMigrationType(self.instanceID, 0)
      SNO.deleteSNO(self.instanceID)
    end
    self.instanceID = nil
    debugTrackDeletion(self, "instance")
    if playersMission and not gameStatus.onlineSession then
      activeChallenges.enable(true)
    end
  end
  self.challenge = nil
end
function instanceTemplate:initiateInstance()
  if self.isLocal and self.initiateChallenge then
    self.initiateChallenge(self)
  end
  if self.challenge.spawnPositions[self.networkVars.routeIndex].propData then
    propSystem.setupRuntimeProps(self.challenge.spawnPositions[self.networkVars.routeIndex].propData.name, self.challenge.spawnPositions[self.networkVars.routeIndex].propData.smashIcon)
  end
  for localID, plr in next, localPlayerManager.players, nil do
    self:multiplayerAttachPlayer(plr)
  end
end
function instanceTemplate:startInstanceTaskObjects()
  for actorID, taskObject in next, self.taskObjectsByActorID, nil do
    if not stateMachine.catchUp or stateMachine.catchUp and (taskObject.coreData.agentType == 0 and taskObject.coreData.agent.playerID ~= localPlayer.playerID or stateMachine.getCurrentStateIndex() == RunModeStateIndex or taskObject.coreData.agentType ~= 0) then
      taskObject:initiate()
    end
  end
  if not stateMachine.catchUp then
    localPlayer.missionSupport:setMainTaskObject(localPlayer:getTaskObject())
  end
  if self.challenge.raceEndScreenSet then
    self.challenge.raceEndScreenSet = false
  end
  for i = 1, 8 do
    local taskObj = self.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
    if taskObj and taskObj.coreData.isLocal and self.challenge.settings.persistantScore and taskObj.namedTasks[self.challenge.settings.persistantScore] and self.playerScores then
      taskObj.namedTasks[self.challenge.settings.persistantScore].networkVars.payload = self.playerScores[i]
    end
  end
end
function instanceTemplate:checkNetworkVarsValidity()
  if self.isLocal and self.networkVars.startTime == -1 then
    if self.challenge.settings.turnTracking then
      self.turnTracking[phaseManager.networkVars.nextTurnTaker + 1] = 1
    end
    self.networkVars.startTime = g_NetworkTime
    self.networkVars.isComplete = false
    self.networkVars.modeWillReset = false
    self.networkVars.overTime = nil
  end
end
function instanceTemplate:startInstance()
  if self.challenge.spawnPositions[self.networkVars.routeIndex].lockingZoneData then
    OneShotSound.Play("HUD_Online_MapDefine")
    CityLockManager.CityLockState = self.challenge.spawnPositions[self.networkVars.routeIndex].lockingZoneData.name
    CityLockManager.CityLockActive = true
    if self.challenge.spawnPositions[self.networkVars.routeIndex].lockingZoneData.drawDistance then
      CityLockManager.FadeInDistance = self.challenge.spawnPositions[self.networkVars.routeIndex].lockingZoneData.drawDistance
    end
  end
  if self.isLocal then
    if self.challenge.settings.turnTracking then
      self.turnTracking[phaseManager.networkVars.nextTurnTaker + 1] = 1
    end
    self.networkVars.startTime = g_NetworkTime
    self.networkVars.isComplete = false
    self.networkVars.modeWillReset = false
    self.networkVars.overTime = nil
    self.completeCalled = false
  end
  if not gameStatus.splitscreenSession and (gameStatus.onlineSessionType == gameStatus.onlineSessionID.public or self.challenge.settings.tutorial and not PlayerCoreStats.getTutorialFlag(self.challenge.settings.tutorialStatID)) then
    onlineProgressionSystem.mainTaskObjectSet(localPlayer.getTaskObject())
  end
  if self.missionStart then
    self.missionStart(self)
  end
  if not gameStatus.splitscreenSession then
    self:startInstanceTaskObjects()
  else
    self:kickStartTaskObjects()
    for i = 1, 8 do
      local taskObj = self.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
      if taskObj and taskObj.coreData.isLocal and self.challenge.settings.persistantScore and taskObj.namedTasks[self.challenge.settings.persistantScore] and self.playerScores then
        taskObj.namedTasks[self.challenge.settings.persistantScore].networkVars.payload = self.playerScores[i]
      end
    end
  end
end
function instanceTemplate:stepTaskObjectDeletion()
  for actorID, taskObject in next, self.taskObjectsByActorID, nil do
    if taskObject.coreData.isLocal and taskObject:canBeDeleted() then
      taskObject:delete()
      self.taskObjectsByActorID[actorID] = nil
    end
  end
end
function instanceTemplate:stepInstance()
  self:update()
  if self.completeCalled and self.islocal and not self.networkVars.isComplete then
    self:initiateOverTimePhase()
  end
  return self.networkVars.isComplete
end
function instanceTemplate:instanceComplete()
  return self.networkVars.isComplete
end
function instanceTemplate:stepInstanceDeletion()
  if gameStatus.onlineSession then
    self:stepTaskObjectDeletion()
  end
  if self.endInstanceWhenWeCan then
    if self:canEndInstance() then
      print("we can end the instance: call endInstance")
      self:endInstance()
    end
  elseif self.isLocal then
    self.endInstanceWhenWeCan = true
  end
end
function instanceTemplate:endInstance()
  CityLockManager.CityLockState = "CityLockingLevel4"
  CityLockManager.CityLockActive = true
  CityLockManager.FadeInDistance = 80
  self:endMission()
end
function instanceTemplate:endInstanceWhenYouCan()
  print("endInstanceWhenYouCan")
  self.endInstanceWhenWeCan = true
  if self:canEndInstance() then
    print("we can end the instance: call endInstance")
    self:endInstance()
  end
end
function instanceTemplate:canEndInstance()
  if self.isLocal and not SNO.canBeDeleted(self.instanceID) then
    print("instanceTemplate " .. tostring(self.instanceID) .. " canEndInstance false because instance is local but migration is in progress")
    return false
  end
  for actorID, taskObject in next, self.taskObjectsByActorID, nil do
    if gameStatus.onlineSession then
      print("instanceTemplate has taskobjects so can not be deleted")
      return false
    end
    if not taskObject.coreData.doNotDelete and not taskObject:canBeDeleted() then
      print("instanceTemplate " .. tostring(self.instanceID) .. " canEndInstance false because taskObject " .. tostring(taskObject.coreData.taskObjectID) .. " can not be deleted")
      return false
    end
  end
  if not checkpointSystem.canDeleteInstanceCheckpoints(self) then
    print("instanceTemplate " .. tostring(self.instanceID) .. " canEndInstance false because we can't delete all the checkpoints")
    return false
  end
  print("instanceTemplate " .. tostring(self.instanceID) .. " canEndInstance true")
  return true
end
function instanceTemplate:updateResetPhase()
  local finishedReset = true
  if checkpointSystem.canDeleteInstanceCheckpoints(self) then
    checkpointSystem.deleteInstanceCheckpoints(self)
  else
    finishedReset = false
  end
  CityLockManager.CityLockActive = false
  for actorID, taskObject in next, self.taskObjectsByActorID, nil do
    finishedReset = false
    if taskObject.coreData.isLocal and taskObject:canBeDeleted() then
      taskObject:delete(true)
    end
  end
  return finishedReset
end
function instanceTemplate:resetFinished()
  return self:updateResetPhase()
end
function instanceTemplate:chooseNextAreaIndex()
  local routeIndex
  if phaseManager.playlistSupport.debug_none_random_route_cycle then
    if phaseManager.playlistSupport.debug_none_random_cycle_lastRoute <= 0 or phaseManager.playlistSupport.debug_none_random_cycle_lastRoute > #self.challenge.usableRouteIndicies then
      phaseManager.playlistSupport.debug_none_random_cycle_lastRoute = 1
    end
    routeIndex = self.challenge.usableRouteIndicies[phaseManager.playlistSupport.debug_none_random_cycle_lastRoute]
  elseif self.challenge.getNextAreaIndexCallback ~= nil then
    routeIndex = self.challenge.getNextAreaIndexCallback()
    phaseManager.playlistSupport.debug_none_random_cycle_lastRoute = routeIndex
  else
    local routeIndexLocation = -1
    if gameStatus.splitscreenSession then
      local locationSelected = phaseManager.playlistSupport.getSelectedLocation()
      routeIndexLocation = phaseManager.getUsableModeAreaIndex(self.challenge.name, self.challenge.usableRouteIndicies[locationSelected], self.challenge.settings.linearProgression)
      routeIndex = self.challenge.usableRouteIndicies[locationSelected][routeIndexLocation]
    else
      routeIndexLocation = phaseManager.getUsableModeAreaIndex(self.challenge.name, self.challenge.usableRouteIndicies, self.challenge.settings.linearProgression)
      routeIndex = self.challenge.usableRouteIndicies[routeIndexLocation]
    end
    phaseManager.playlistSupport.debug_none_random_cycle_lastRoute = routeIndexLocation
  end
  self.networkVars.routeIndex = routeIndex
  return routeIndex
end
function instanceTemplate:stopTasks()
  for actorID, taskObject in next, self.taskObjectsByActorID, nil do
    taskObject:failTasks()
  end
end
