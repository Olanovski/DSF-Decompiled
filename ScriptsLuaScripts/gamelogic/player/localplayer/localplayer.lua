module("localPlayer", package.seeall)
name = ""
inZap = true
zapToActionActive = false
zapReturning = false
zapToActionActive = false
zapToPointActive = false
playerID = false
isLocal = true
isPlayer = true
TEMPSNPID = false
blockHUD = false
currentVehicle = false
previousVehicle = false
position = vec.vector()
heading = 0
speed = 0
zapSlowDown = 0.2
zapReturnOverrideVehicle = false
abilityPoints = 0
isInControl = false
zapTransition = false
inCutscene = false
waggleStickPrompt = false
blockWagglePrompt = false
carDamageWarningSound = false
teleporting = false
blockDamageBarUpdate = false
blockedAbilities = {}
blockRapidShiftPress = false
wreckedAutoZap = false
wreckAutoZapEnabled = true
inputVehicleReset = false
autoVehicleReset = false
vehicleResetAllowed = false
playerPressedToReset = false
camName = "Game_Cam"
camera = _G.game_camera
localID = 0
gamepad = controller.getPad("GAMEPAD1")
controls = controlHandler
cameraMode = "Normal"
currentMode = 1
shadowName = "MainViewport"
resetE3Demo = false
blockAutoZap = false
function reflectCurrentVehicle(self, v)
  self.currentVehicle = v
  localPlayerManagerReflection.setCurrentVehicle(self.localID, v)
  if checkpointTracker.checkpointTrackerActive and checkpointTracker.trackerAdded(self:getTaskObject()) then
    if self.currentVehicle then
      checkpointTracker.updateTracker(self:getTaskObject(), self.currentVehicle.gameVehicle)
    else
      checkpointTracker.updateTracker(self:getTaskObject())
    end
  end
  onlineRaceManager.updatePlayersAndVehicles()
end
function reflectPreviousVehicle(self, v)
  self.previousVehicle = v
  localPlayerManagerReflection.setPreviousVehicle(self.localID, v)
end
function setInZap(self, b)
  self.inZap = b
  localPlayerManagerReflection.setInZap(self.localID, b)
end
function setWreckedAutoZap(self, b)
  self.wreckedAutoZap = b
  if type(b) == "boolean" then
    localPlayerManagerReflection.setWreckedAutoZap(self.localID, b)
  else
    localPlayerManagerReflection.setWreckedAutoZap(self.localID, b ~= nil)
  end
end
function setWreckAutoZapEnabled(self, b)
  self.wreckAutoZapEnabled = b
  localPlayerManagerReflection.setWreckAutoZapEnabled(self.localID, b)
end
function setBlockWagglePrompt(self, b)
  self.blockWagglePrompt = b
  localPlayerManagerReflection.setBlockWagglePrompt(self.localID, b)
end
function setWaggleStickPrompt(self, b)
  self.waggleStickPrompt = b
  localPlayerManagerReflection.setWaggleStickPrompt(self.localID, b)
end
function setBlockDamageBarUpdate(self, b)
  self.blockDamageBarUpdate = b
  localPlayerManagerReflection.setBlockDamageBarUpdate(self.localID, b)
end
function setBlockAutoZap(self, b)
  self.blockAutoZap = b
  localPlayerManagerReflection.setBlockAutoZap(self.localID, b)
end
function setSelfRighting(self, b)
  self.selfRighting = b
  localPlayerManagerReflection.setSelfRighting(self.localID, b)
end
function initiate()
  for localID, player in next, localPlayerManager.players, nil do
    if not gameStatus.onlineSession and not gameStatus.splitscreenSession then
      player:showHUDElements(true)
    end
    player.primaryFelony = {}
    player:setSelfRighting(false)
    localPlayerManagerReflection.setPrimaryFelony(player.localID, nil)
  end
end
function getLocalID(self)
  return self.localID
end
function purge(self)
  self.playerID = false
  self.minimapSupport:hide()
  if not self.inZap then
    self:SetZapLevel(1, nil, false, {shutDown = true})
  end
end
numberOfVehiclesZappedInto = 0
function getNumberOfVehiclesZappedInto(self)
  return self.numberOfVehiclesZappedInto
end
local numberOfTaskReturns = 0
function getNumberOfTaskReturns()
  return numberOfTaskReturns
end
local createFreedriveMarkers = function(specifiedVehicle)
  local getawayAgent = vehicleManager.getAgentFromGameVehicle(localPlayer.primaryFelony.getawayGameVehicle)
  if specifiedVehicle and not specifiedVehicle.freedriveMarkers and not specifiedVehicle:getTaskObject() and (getawayAgent == specifiedVehicle or not localPlayer.getTaskObject()) and (not localPlayer.primaryFelony.getawayGameVehicle or specifiedVehicle == getawayAgent) then
    specifiedVehicle.freedriveMarkers = {}
    specifiedVehicle.freedriveMarkers[#specifiedVehicle.freedriveMarkers + 1] = feedbackSystem.newTarget(specifiedVehicle, "Vehicle tracking")
    specifiedVehicle.freedriveMarkers[#specifiedVehicle.freedriveMarkers + 1] = feedbackSystem.newTarget(specifiedVehicle, "Light trail")
  end
end
function clearFreedriveMarkers(specifiedVehicle)
  if specifiedVehicle and specifiedVehicle.freedriveMarkers then
    for i = 1, #specifiedVehicle.freedriveMarkers do
      feedbackSystem.clearTarget(specifiedVehicle.freedriveMarkers[i])
    end
    specifiedVehicle.freedriveMarkers = nil
  end
end
function setCurrentVehicle(self, newCurrentVehicle, disableTanner)
  if newCurrentVehicle then
    if self.currentVehicle ~= newCurrentVehicle then
      self.numberOfVehiclesZappedInto = self.numberOfVehiclesZappedInto + 1
      self:reflectCurrentVehicle(newCurrentVehicle)
      player.setAttachment(self.localID, self.currentVehicle.gameVehicle, disableTanner)
      if not gameStatus.onlineSession then
        createFreedriveMarkers(self.currentVehicle)
      end
    else
      player.setAttachment(self.localID, self.currentVehicle.gameVehicle, disableTanner)
    end
    self.currentVehicle.controlled = true
    self.collisionCallbackSettings = {
      callbackFunction = self.scoring.collisionCallback,
      minimumForce = 1000
    }
    self.currentVehicle:addCollisionCallback(self.collisionCallbackSettings)
    self.lastCollisionTime = 0
    self.lastCollidedGameVehicle = false
    if gameStatus.splitscreenSession and self.currentVehicle.networkVars.onlineRequiredVehicle then
      self.currentVehicle.networkVars.onlineRequiredVehicle = false
      self.currentVehicle.networkVars.onlineOwnerID = nil
    end
    local emergencyVehicleType = GameVehicleResource.getEmergencyType(self.currentVehicle.gameVehicle)
    local modelID = self.currentVehicle.gameVehicle.model_id
    PatrollingVehicleManager.SetVehicleToWatch(self.currentVehicle.gameVehicle)
    if emergencyVehicleType == 2 then
      SuspiciousVehicleManager.SetVehicleToWatch(self.currentVehicle.gameVehicle)
      SuspiciousVehicleManager.SetCopModelUID(modelID)
    end
  else
    self:reflectCurrentVehicle(newCurrentVehicle)
    PatrollingVehicleManager.SetVehicleToWatch(nil)
    SuspiciousVehicleManager.SetVehicleToWatch(nil)
  end
  scoreSystem.setPlayerVehicle(self.localID, self.currentVehicle.gameVehicle)
  if gameStatus.onlineSession and self.currentVehicle then
    if self.currentVehicle:get_damageMultiplier() == 0 then
      feedbackSystem.menusMaster.disableDamageBar(self)
    else
      feedbackSystem.menusMaster.enableDamageBar(self)
    end
  end
end
function clearCurrentVehicle(self)
  PatrollingVehicleManager.SetVehicleToWatch(nil)
  SuspiciousVehicleManager.SetVehicleToWatch(nil)
  clearFreedriveMarkers(self.currentVehicle)
  self:reflectCurrentVehicle(false)
end
function setPreviousVehicle(self, specifiedVehicle)
  if not specifiedVehicle and localPlayer.inZap and localPlayer.currentVehicle and localPlayer.currentVehicle ~= self.previousVehicle or specifiedVehicle and specifiedVehicle ~= self.previousVehicle then
    self:clearPreviousVehicle()
    self:reflectPreviousVehicle(specifiedVehicle or localPlayer.currentVehicle)
  end
end
function clearPreviousVehicle(self, keepUpdate)
  if self.previousVehicle then
    if not keepUpdate then
      removeUserUpdateFunction("checkForLockedArea")
    end
    self:reflectPreviousVehicle(false)
  end
end
function createFelony(self, evaderGameVehicle, settings, index)
  local newFelony = {}
  newFelony.getawayGameVehicle = evaderGameVehicle
  newFelony.chasers = {}
  newFelony.settings = settings
  newFelony.status = {}
  self.felonies = self.felonies or {}
  table.insert(self.felonies, index or 1, newFelony)
  self.primaryFelony = self.felonies[1]
  localPlayerManagerReflection.setPrimaryFelony(self.localID, evaderGameVehicle)
  local agent = vehicleManager.getAgentFromGameVehicle(evaderGameVehicle)
  if agent then
    createFreedriveMarkers(agent)
  end
end
function clearFelony(self, evaderGameVehicle)
  for i = 1, #self.felonies do
    local felony = self.felonies[i]
    if evaderGameVehicle == felony.getawayGameVehicle then
      for key, value in next, felony, nil do
        value = nil
      end
      table.remove(self.felonies, i)
      break
    end
  end
  self:clearPreviousVehicle()
  self.primaryFelony = {}
  localPlayerManagerReflection.setPrimaryFelony(self.localID, nil)
end
function clearAllFelonies(self)
  if self.felonies then
    for i = 1, #self.felonies do
      local felony = self.felonies[i]
      for key, value in next, felony, nil do
        value = nil
      end
    end
  end
  self:clearPreviousVehicle()
  self.felonies = {}
  self.primaryFelony = {}
  localPlayerManagerReflection.setPrimaryFelony(localID, nil)
end
function addChaser(self, evaderGameVehicle, chaserGameVehicle)
  for i = 1, #self.felonies do
    local felony = self.felonies[i]
    if evaderGameVehicle == felony.getawayGameVehicle then
      felony.chasers[#felony.chasers + 1] = chaserGameVehicle
    end
  end
end
function getChaserID(self, evaderGameVehicle, chaserGameVehicle)
  for i = 1, #self.felonies do
    local felony = self.felonies[i]
    if evaderGameVehicle == felony.getawayGameVehicle then
      for indexInTable, gameVehicle in next, felony.chasers, nil do
        if chaserGameVehicle == gameVehicle then
          return indexInTable
        end
      end
    end
  end
end
function removeChaser(self, evaderGameVehicle, chaserGameVehicle)
  for i = 1, #self.felonies do
    local felony = self.felonies[i]
    if evaderGameVehicle == felony.getawayGameVehicle then
      local indexToRemove = false
      for indexInTable, gameVehicle in next, felony.chasers, nil do
        if chaserGameVehicle == gameVehicle then
          indexToRemove = indexInTable
          break
        end
      end
      if indexToRemove then
        felony.chasers[indexToRemove] = nil
      end
    end
  end
end
local workingVector = vec.vector()
zapBlockedFromCode = false
local zapBlockedFromScript = false
function blockAbility(self, ability, state, calledFromCode)
  if ability == "zap" then
    if not calledFromCode then
      zapBlockedFromScript = state
    else
      zapBlockedFromCode = state
    end
    self.blockedAbilities[ability] = zapBlockedFromCode or zapBlockedFromScript
  else
    self.blockedAbilities[ability] = state
  end
  if ability == "zapReturn" then
    localPlayer:buildZapReturn()
    if self.blockedAbilities[ability] then
      self:clearPreviousVehicle()
    end
  end
end
function getAbilityAvailable(self, ability)
  if ability == "zapReturn" and gameStatus.onlineSession then
    return false
  else
    return isAbilityUnlocked(ability) and not self.blockedAbilities[ability]
  end
end
local lockedCheckTable = {}
local function lockedVehicleOrLockedRegion(gameVehicle)
  lockedCheckTable.gameVehicle = gameVehicle
  if zapcontroller.IsLockedVehicle(lockedCheckTable) or zap.vehicleInLockedArea(gameVehicle.position) then
    return true
  end
end
function getHasTeamMates(self, playerTaskObject)
  if playerTaskObject then
    for index, taskObject in next, playerTaskObject.coreData.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.agent and playerTaskObject.coreData.agent ~= taskObject.coreData.agent and taskObject.coreData.actor.team == playerTaskObject.coreData.actor.team and taskObject.coreData.agent.gameVehicle and taskObject.coreData.agent.gameVehicle.damage < 1 and not lockedVehicleOrLockedRegion(taskObject.coreData.agent.gameVehicle) then
        return true
      end
    end
  end
end
local function getTeamMateClosestTarget(self, playerTaskObject, isZappingBack)
  local position = localPlayer.inZap and game_camera.matrix[3]:clone() or localPlayer.position
  local closestDistance = math.huge
  local closestVehicle, distance
  local playerTaskObject = playerTaskObject
  return function()
    if playerTaskObject and playerTaskObject.coreData and not self.zapReturnOverrideVehicle then
      position = localPlayer.inZap and localPlayer.position
      closestVehicle = nil
      closestDistance = math.huge
      for index, taskObject in next, playerTaskObject.coreData.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.agent and not taskObject.coreData.agent.controlled and taskObject.coreData.actor.team == playerTaskObject.coreData.actor.team and taskObject.coreData.agent.gameVehicle and taskObject.coreData.agent.gameVehicle.damage < 1 and not lockedVehicleOrLockedRegion(taskObject.coreData.agent.gameVehicle) then
          distance = workingVector:sub(taskObject.coreData.agent.position, position):length()
          if distance < closestDistance then
            closestDistance = distance
            closestVehicle = taskObject.coreData.agent
          end
        end
      end
      if closestVehicle then
        local taskObject = closestVehicle:getTaskObject()
        if taskObject.coreData.agent.zapToTowingVehicle then
          local towingGameVehicle = closestVehicle.gameVehicle.towingVehicle
          if towingGameVehicle then
            local towingAgent = vehicleManager.vehiclesByGameVehicle[towingGameVehicle]
            if towingAgent and currentVehicle ~= towingAgent then
              self:setPreviousVehicle(towingAgent)
            else
              self:clearPreviousVehicle()
            end
          else
            self:setPreviousVehicle(closestVehicle)
          end
        else
          self:setPreviousVehicle(closestVehicle)
        end
      end
    else
      removeUserUpdateFunction("getClosestTeamMate")
    end
  end
end
function checkForLockedArea(self)
  local vehicleWatching = self.previousVehicle
  return function()
    if vehicleWatching and localPlayer.currentVehicle then
      if lockedVehicleOrLockedRegion(vehicleWatching) then
        self:clearPreviousVehicle(true)
      elseif self.previousVehicle ~= vehicleWatching then
        self:setPreviousVehicle(vehicleWatching)
      end
    else
      removeUserUpdateFunction("checkForLockedArea")
    end
  end
end
function buildFreedriveZapReturn(self, level)
  if level and level > 0 and self.currentVehicle and self.currentVehicle.damage < 1 then
    if not lockedVehicleOrLockedRegion(self.currentVehicle.gameVehicle) then
      self:setPreviousVehicle()
      addUserUpdateFunction("checkForLockedArea", self:checkForLockedArea(), 10)
    end
  else
    self:clearPreviousVehicle()
    removeUserUpdateFunction("checkForLockedArea")
  end
end
function buildFelonyZapReturn(self, level)
  if Getaway.IsAGetawayActive() and level and level > 0 then
    local evader = vehicleManager.vehiclesByGameVehicle[self.primaryFelony.getawayGameVehicle]
    if evader and self.currentVehicle == evader and not lockedVehicleOrLockedRegion(evader.gameVehicle) then
      self:setPreviousVehicle(evader)
      addUserUpdateFunction("checkForLockedArea", self:checkForLockedArea(), 10)
    end
  end
end
function buildMissionZapReturn(self, isZappingBack, playerTaskObject)
  if self.zapReturnOverrideVehicle then
    if self.zapReturnOverrideVehicle.damage < 1 and not self.zapReturnOverrideVehicle.inTrailer then
      self:setPreviousVehicle(self.zapReturnOverrideVehicle)
      addUserUpdateFunction("checkForLockedArea", self:checkForLockedArea(), 10)
    else
      self:clearPreviousVehicle()
      removeUserUpdateFunction("checkForLockedArea")
    end
    removeUserUpdateFunction("getClosestTeamMate")
  else
    addUserUpdateFunction("getClosestTeamMate", getTeamMateClosestTarget(self, playerTaskObject, isZappingBack), 10)
  end
end
function buildZapReturn(self, level, vehicle)
  local playerTaskObject = self:getTaskObject()
  if not gameStatus.onlineSession and self:getAbilityAvailable("zapReturn") then
    if self.primaryFelony.getawayGameVehicle and not self.inCutscene and not playerTaskObject then
      self:buildFelonyZapReturn(level)
    elseif playerTaskObject and not level then
      self:buildMissionZapReturn(isZappingBack, playerTaskObject)
    elseif not self.inCutscene and not playerTaskObject then
      self:buildFreedriveZapReturn(level)
    end
  end
end
function overrideZapReturn(self, agent)
  self.zapReturnOverrideVehicle = agent
  self:buildZapReturn()
end
function clearZapReturnOverride(self)
  self.zapReturnOverrideVehicle = false
  self:buildZapReturn()
end
function doZapReturn(self)
  if self:getAbilityAvailable("zapReturn") then
    if self.previousVehicle and feedbackSystem.previewScreen.activityBeingPrompted then
      feedbackSystem.previewScreen.hideZapPreview()
    end
    if self.primaryFelony and self.primaryFelony.getawayGameVehicle and Chase.IsAChaseActive() then
      local gameVehicle = Chase.GetZapReturnChaser()
      if gameVehicle then
        self:reflectPreviousVehicle(vehicleManager.registerVehicle({gameVehicle = gameVehicle}))
        self.previousVehicle:setDebugRequiredVehicles(true)
        self:zapToAgent(self.previousVehicle, {playerInstigated = true})
        self:clearPreviousVehicle()
      end
    elseif self.previousVehicle and (not localPlayer.currentVehicle or self.previousVehicle ~= localPlayer.currentVehicle or self.inZap) and not (self.previousVehicle.damage >= 1) then
      RouteArrowsManager.HideArrows(localPlayer.localID, false)
      self:zapToAgent(self.previousVehicle, {playerInstigated = true})
    end
  end
end
function zapReturnUpdate(self)
end
function zapToAgent(self, targetVehicle, parameters)
  if self.zapReturning then
    return
  end
  Sound.DoZapBack(true)
  Commentary.ZapBackBegin()
  self.zapReturning = true
  feedbackSystem.menusMaster.locationPrompt(false)
  self:CheckDistanceForZapIntoVehicle(targetVehicle, targetVehicle.gameVehicle, true, false, nil, nil, parameters)
end
function zapToAction(self, vehicle, parameters)
  local gameVehicle
  if vehicle then
    gameVehicle = vehicle.gameVehicle
    NetworkLog.Write(">[LUA] LOCAL PLAYER ZAP TO ACTION - zapToAction - localID = " .. tostring(self.localID) .. ", SNVID = " .. tostring(vehicle.SNVID) .. ", zapToActionActive = " .. tostring(self.zapToActionActive))
  else
    NetworkLog.Write(">[LUA] LOCAL PLAYER ZAP TO ACTION - zapToAction - localID = " .. tostring(self.localID) .. ", no vehicle passed in, zapToActionActive = " .. tostring(self.zapToActionActive))
  end
  parameters = parameters or {}
  if not self.zapToActionActive then
    self.zapToActionActive = true
    bVehicleTrackingMode = true
    bZapBackMode = false
    self:CheckDistanceForZapIntoVehicle(vehicle, gameVehicle, bZapBackMode, bVehicleTrackingMode, parameters.cameraAngle)
  else
    zapcontroller.setZapTransitionTargetVehicle(self.localID, gameVehicle)
  end
end
function SetZapLevel(self, zapLevel, vehicle, bForceTransition, parameters)
  if zapLevel == 0 and not localPlayer.inZap then
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    print("ERROR: You have zapped from level 0 to level 0 without going up into zap. Terrible things could happen. Fix this")
    callStack()
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
  end
  assert(OnlineModeSettings.onlineDisableAssert or zapcontroller.getSpoolerAttached() or gameStatus.splitscreenSession, "Error - Spooler is not attached")
  if bForceTransition == nil then
    bForceTransition = false
  end
  local gameVehicle
  if vehicle then
    gameVehicle = vehicle.gameVehicle
  end
  local parameters = parameters or {}
  parameters.bForceTransition = bForceTransition
  parameters.bZapReturnMode = parameters.bZapReturnMode or false
  parameters.bLongDistanceZapReturn = parameters.bLongDistanceZapReturn or false
  parameters.disableZapFlash = parameters.disableZapFlash or false
  if zapLevel == 0 and gameVehicle and vehicleManager.previewVehicleManager.previewVehicle and gameVehicle == vehicleManager.previewVehicleManager.previewVehicle.gameVehicle then
    zapcontroller.stopZapLoadFlashOnNextVehicle()
  end
  local bVehicleTrackingMode = false
  local bZappingIntoNewCar = false
  if zapLevel == 0 and parameters.bZapReturnMode == false then
    bZappingIntoNewCar = true
    self.transitioningGameVehicle = gameVehicle
  end
  if not bForceTransition and not bZappingIntoNewCar and (zapLevel == 0 or vehicle) then
    if zapLevel > 0 and vehicle and self.inZap then
      bVehicleTrackingMode = true
    end
    bZapBackMode = false
    self:CheckDistanceForZapIntoVehicle(vehicle, gameVehicle, bZapBackMode, bVehicleTrackingMode, parameters.cameraAngle)
    return
  end
  if bZappingIntoNewCar and not bForceTransition then
    if zapcontroller.getClosestCameraZapLevel(self.localID) > 3.1 then
      Mood.addMoodUserDefined(moodSystem.TopZap3, "FastZap", 1, 0, -1, self.localID)
    elseif zapcontroller.getClosestCameraZapLevel(self.localID) > 2 then
      Mood.addMoodUserDefined(moodSystem.TopZap2, "FastZap", 1, 0, -1, self.localID)
    end
  end
  zap.OnSetZapLevelStarted(self, zapLevel, self.currentVehicle, parameters)
  zapcontroller.zapFromIntoVehicle(self.localID, zapLevel, gameVehicle, bForceTransition, parameters.bZapReturnMode, false, parameters.bLongDistanceZapReturn, bZappingIntoNewCar, parameters.cameraAngle, parameters.disableZapFlash, self.cameraMode, zap.zapCallbacks)
  if zapLevel ~= 0 then
    if not gameStatus.onlineSession then
      zapcontroller.setZapSlowMotionMultiplier(zapSlowDown)
    end
    cleanupActiveCamera(self.localID)
    if self.currentVehicle then
      local abilityActive = self.currentVehicle.abilityActive
      if abilityActive then
        self.currentVehicle:cancelAbility(self.localID)
      end
    end
    zap.OnSetZapLevelFinished(self, zapLevel, vehicle, parameters)
  end
end
function ZapTransitionToPoint(self, targetPoint, cameraAngle)
  if self.zapToPointActive then
    zapcontroller.setZapTransitionTargetPoint(self.localID, targetPoint, cameraAngle)
  else
    self.zapToPointActive = true
    self:CheckDistanceForZapIntoVehicle(nil, nil, false, false, targetPoint, cameraAngle)
  end
end
function CheckDistanceForZapIntoVehicle(self, targetVehicle, gameVehicle, bZapBackMode, bVehicleTrackingMode, targetPoint, cameraAngle, parameters)
  bLongDistanceZapReturnVal = true
  local posVector = vec.vector()
  if targetPoint then
    posVector = targetPoint
  elseif targetVehicle.position == nil then
    GameVehicleResource.position(gameVehicle, posVector)
  else
    posVector = targetVehicle.position
  end
  bTargetLocationResident = spoolsystem.IsLocationResident(posVector)
  if bTargetLocationResident == true then
    bLongDistanceZapReturnVal = false
  end
  bUseRapidShiftMood = true
  if not self.inZap then
    self:SetZapLevel(1)
  end
  if zapcontroller.getClosestCameraZapLevel(self.localID) > 3.1 then
    bUseRapidShiftMood = false
  end
  if bLongDistanceZapReturnVal or bZapBackMode or bVehicleTrackingMode or targetPoint then
    if gameVehicle then
      VehicleLodSpooler.RequestVehicle(gameVehicle.model_id, self.localID)
    end
    if bUseRapidShiftMood then
      if bLongDistanceZapReturnVal then
        Mood.addMoodUserDefinedOverrideZap(moodSystem.RapidZap, "FastZap", 1, 0.45, -1, self.localID)
      elseif zapcontroller.getClosestCameraZapLevel(self.localID) < 2 then
        Mood.addMoodUserDefinedOverrideZap(moodSystem.RapidZap, "FastZap", 1, 0.1, -1, self.localID)
      else
        Mood.addMoodUserDefinedOverrideZap(moodSystem.RapidZap, "FastZap", 1, 0, -1, self.localID)
      end
    elseif bLongDistanceZapReturnVal then
      Mood.addMoodUserDefinedOverrideZap(moodSystem.TopZap3, "FastZap", 1, 0.45, -1, self.localID)
    else
      Mood.addMoodUserDefinedOverrideZap(moodSystem.TopZap3, "FastZap", 1, 0, -1, self.localID)
    end
    self.minimapSupport:hide()
    feedbackSystem.menusMaster.disableDamageBar(self)
    if not gameStatus.splitscreenSession then
      feedbackSystem.menusMaster.currentHUDSetVariable("iCarSpeed_Display", 0)
    else
      feedbackSystem.multiplayerSupport.disableSSSpeedo(self.localID)
    end
  end
  if targetPoint then
    zapcontroller.zapTransitionToPointTracking(self.localID, targetPoint, bLongDistanceZapReturnVal, cameraAngle)
  else
    self:ZapIntoVehicle(gameVehicle, bZapBackMode, bLongDistanceZapReturnVal, bVehicleTrackingMode, cameraAngle, parameters)
  end
end
function ZapIntoVehicle(self, gameVehicle, bZapBackMode, bLongDistanceZapReturn, bVehicleTrackingMode, cameraAngle, parameters)
  local parameters = parameters or {}
  if not bVehicleTrackingMode then
    zap.OnSetZapLevelStarted(self, 0, vehicleManager.vehiclesByGameVehicle[gameVehicle], {bForceTransition = false})
  end
  if bZapBackMode or bVehicleTrackingMode then
    Sound.DoZapBack(true, bVehicleTrackingMode)
  end
  zapcontroller.zapFromIntoVehicle(self.localID, 0, gameVehicle, false, bZapBackMode, bVehicleTrackingMode, bLongDistanceZapReturn, false, cameraAngle, parameters.disableZapFlash, self.cameraMode, zap.zapCallbacks)
end
function OnPlayerSetZapLevelStarted(self, zapLevel, vehicle, parameters)
  if zapLevel ~= 0 then
    if self.currentVehicle then
      NetworkLog.Write(">[LUA] LOCALPLAYER - Player " .. tostring(self.localID) .. " entering zap mode, currentVehicle SNVID = " .. tostring(self.currentVehicle.SNVID))
    else
      NetworkLog.Write(">[LUA] LOCALPLAYER - Player " .. tostring(self.localID) .. " entering zap mode, currentVehicle SNVID is none ")
    end
    PatrollingVehicleManager.SetVehicleToWatch(nil)
    SuspiciousVehicleManager.SetVehicleToWatch(nil)
    if not gameStatus.splitscreenSession then
      feedbackSystem.menusMaster.currentHUDSetVariable("iCarSpeed_Display", 0)
      feedbackSystem.menusMaster.currentHUDSetVariable("iStick_Waggle", 0)
    else
      feedbackSystem.multiplayerSupport.disableSSSpeedo(self.localID)
    end
    self.scoring:resetDriftScoreOnEnterZap()
    self.scoring:resetJumpScoreOnEnterZap()
    if self.currentVehicle then
      self.currentVehicle:removeCollisionCallback(self.collisionCallbackSettings)
      self.lastCollisionTime = 0
      self.lastCollidedGameVehicle = false
    end
    self:setInZap(true)
    self:setWreckedAutoZap(false)
    self:setWaggleStickPrompt(false)
    if not self.minimapSupport.zoomed then
      self:setBlockWagglePrompt(false)
    end
    if not gameStatus.splitscreenSession then
      dareSystem.hideDarePrompts(true)
    end
    zap.forceZapped = false
    self.controllerInterface:removeCallbacks()
    self.inputVehicleReset = false
    self.autoVehicleReset = false
    if self.cameraMode == "Bumper" then
      VehicleSystem.setPlayerVehicleVisible(1, self.localID)
    end
    if self.currentVehicle then
      if self.currentVehicle.abilityActive then
        self.currentVehicle:cancelAbility(self.localID)
      end
      self.currentVehicle.controlled = false
    end
    self.controllerInterface:removePlayerControl()
    scoreSystem.setPlayerVehicle(self.localID, false)
    self.controllerInterface.abilityActive = false
    self:update()
    if self.currentVehicle then
      local taskObject = self.currentVehicle and self.currentVehicle:getTaskObject()
      if taskObject and self.currentVehicle then
        taskObject:refreshAI()
      end
    end
    spoolsystem.SetSpoolCentreAttachment(self.localID, nil)
    if gameStatus.onlineSession and parameters.discardCurrentVehicle == nil then
      parameters.discardCurrentVehicle = true
    end
    if not parameters.shutDown and parameters.discardCurrentVehicle then
      self:clearCurrentVehicle()
    end
    if self.currentVehicle and Chase.IsAChaser(self.currentVehicle.gameVehicle) then
      local gameVehicle = self.currentVehicle.gameVehicle
      if vehicleManager.vehiclesByGameVehicle[gameVehicle] then
        vehicleManager.unregisterVehicle(self.currentVehicle, false)
        self:clearCurrentVehicle()
      end
      Chase.OKToOwnVehicle(gameVehicle)
    end
    if parameters.shutDown then
      player.setAttachment(self.localID, self.camera)
    end
    taskSystem.forceTaskObjectMinorTaskRefresh()
    if phaseManager.inMission() then
      scoreSystem.stopAbilityDrain(self.localID, false)
    end
  end
end
function notifySetZapLevelEvent(self, zapLevel, vehicle, parameters)
  if parameters ~= nil then
    controlvehicle = not parameters.doNotControlVehicle
  end
  self:OnPlayerSetZapLevelFinished(zapLevel, vehicle, {vehicle = vehicle, controlVehicle = controlvehicle})
  if zapLevel == 0 then
    zapcontroller.exitZapCB(true, self.localID, vehicle)
    if vehicle and not vehicle:getTaskObject() then
      GameVehicleResource.setHiddenFromAIs(vehicle.gameVehicle)
    end
  end
end
local timeToTriggerCarParkChallenge = 4
local deloreanCheck = function()
  local timeToTriggerChallenge = 4
  local timeHit88mph = false
  local vehicle = localPlayer.currentVehicle
  local startAlpha = 0.2
  local targetAlpha = 1
  local lightTrailColour = vec.vector(0.96, 0.77, 0.05, startAlpha)
  local lightTrailLength = 40
  local slowMoSpeed = 0.8
  local waitingForZap = false
  local timeToWaitForZap = 2 * slowMoSpeed
  local waitingForPrompt = false
  local timeToWaitForPrompt = 3 * slowMoSpeed
  local function shiftOutEffect()
    localPlayer:enterCutsceneMode()
    localPlayer:SetZapLevel(1)
    zapcontroller.EnableZapInput(false, localPlayer.localID)
    zapcontroller.setRenderTarget(false, localPlayer.localID)
    zapcontroller.ZapSettings(1, {CanSelectVehicles = false})
    zapcontroller.setZapSlowMotionMultiplier(slowMoSpeed)
    zapcontroller.ZapCameraSetCatchupFactor(localPlayer.localID, 0.001)
    waitingForZap = g_NetworkTime
  end
  local finishedShift = function()
    if not localPlayer.inZap and not localPlayer.zapTransition then
      localPlayer:blockAbility("zapReturn", false)
      localPlayer:exitCutsceneMode()
      zapcontroller.EnableZapInput(true, localPlayer.localID)
      zapcontroller.setRenderTarget(true, localPlayer.localID)
      zapcontroller.ZapSettings(1, {CanSelectVehicles = true})
      removeUserUpdateFunction("finishedShift")
    end
  end
  local function promptDelayCleanup()
    if g_NetworkTime - waitingForPrompt > timeToWaitForPrompt then
      localPlayer:SetZapLevel(0, vehicle, false)
      vehicle:removeLightTrail()
      addUserUpdateFunction("finishedShift", finishedShift, 2)
      removeUserUpdateFunction("DeloreanPromptDelay")
    end
  end
  local function waitForShiftOut()
    if g_NetworkTime - waitingForZap > timeToWaitForZap and not localPlayer.zapTransition then
      local networkID = cards.ReverseMissionNetworkLookup["Car park"]
      CutsceneFiles.tutorials.playTutorial("ID:246333", 0)
      ProfileSettings.SetChallengeUnlocked(networkID)
      shop.purchaseChallenge(networkID)
      waitingForPrompt = g_NetworkTime
      removeUserUpdateFunction("DeloreanShiftDelay")
      addUserUpdateFunction("DeloreanPromptDelay", promptDelayCleanup, 2)
    end
  end
  return function()
    if localPlayer.currentVehicle.gameVehicle.displayedSpeed >= 39 then
      if timeHit88mph then
        local timeTaken = g_NetworkTime - timeHit88mph
        lightTrailColour.w = lerp_value(startAlpha, targetAlpha, timeTaken / timeToTriggerChallenge)
        localPlayer.currentVehicle:setLightTrailColour(lightTrailColour)
        if timeTaken >= timeToTriggerChallenge then
          shiftOutEffect()
          localPlayer:blockAbility("zapReturn", true)
          removeUserUpdateFunction("Delorean")
          addUserUpdateFunction("DeloreanShiftDelay", waitForShiftOut, 2)
        end
      else
        timeHit88mph = g_NetworkTime
        vehicle:addLightTrail(lightTrailLength, lightTrailColour, 1, false)
      end
    elseif timeHit88mph then
      timeHit88mph = false
      vehicle:removeLightTrail()
    end
  end
end
function OnPlayerSetZapLevelFinished(self, zapLevel, vehicle, parameters)
  if zapLevel == 0 then
    scoreSystem.exitingZap(self.localID)
    local blockIcarSpeedAndDamageBars = false
    if progressionSystem.currentProgression <= 3 and not gameStatus.onlineSession and not bonusChallengeActive then
      blockIcarSpeedAndDamageBars = true
    end
    if not self.inCutscene then
      if gameStatus.splitscreenSession then
        if not feedbackSystem.splitScreenSupport.disableSSHud then
          feedbackSystem.multiplayerSupport.enableSSSpeedo(self.localID)
        end
      elseif not blockIcarSpeedAndDamageBars then
        feedbackSystem.menusMaster.currentHUDSetVariable("iCarSpeed_Display", 1)
      end
    end
    zap.zoomInOutButtonPrompts(self, false)
    local turnOnAbilityTime = 1
    local startTime = g_NetworkTime
    self.timeOfLastZap = g_NetworkTime
    addUserUpdateFunction("Pause Ability After Zap", function()
      if g_NetworkTime - startTime >= turnOnAbilityTime then
        removeUserUpdateFunction("Pause Ability After Zap")
      end
    end, 4)
    self:setInZap(false)
    if not gameStatus.onlineSession then
      dareSystem.hideDarePrompts(false)
      if (feedbackSystem.previewScreen.missionDescription or feedbackSystem.previewScreen.activityBeingPrompted) and not localPlayer.isHUDActive() then
        feedbackSystem.previewScreen.hideZapPreview()
      end
    end
    self:setCurrentVehicle(vehicle)
    if not self.zapTransition then
      self:resetCameraMode()
    end
    if not self:getTaskObject() and not gameStatus.onlineSession and vehicle and vehicle.model_id == 171 and not ProfileSettings.GetChallengeUnlocked(cards.ReverseMissionNetworkLookup["Car park"]) then
      addUserUpdateFunction("Delorean", deloreanCheck(), 2)
    end
    if not parameters.returnZap then
      self.controllerInterface:createCallbacks()
    end
    abilities.ram.applySettings()
    abilities.nitro.applySettings()
    Commentary.SetPlayerCarID(self.currentVehicle.gameVehicle)
    playerTaskObject = self:getTaskObject()
    local vehicleTaskObject = parameters.vehicle:getTaskObject()
    if playerTaskObject and vehicleTaskObject and playerTaskObject ~= vehicleTaskObject and playerTaskObject.coreData.actor.team == vehicleTaskObject.coreData.actor.team then
      self.missionSupport:setMainTaskObject(vehicleTaskObject)
    end
    if not vehicleManager.previewVehicleManager.previewVehicle then
      Menu.ShowHUD = 1
    end
    self.minimapSupport:show()
    if self.minimapSupport.googleMapActive then
      self.minimapSupport:hideGoogleMap()
    end
    if feedbackSystem.previewScreen.activityBeingPrompted then
      if feedbackSystem.previewScreen.activityBeingPrompted.hotspotType and feedbackSystem.previewScreen.activityBeingPrompted.hotspotType == "garage" then
        feedbackSystem.previewScreen.showGaragePrompt()
      else
        feedbackSystem.previewScreen.displayActivityPrompt(feedbackSystem.previewScreen.activityBeingPrompted)
      end
    end
    if not phaseManager.playerControlLockedUntilGameStart and not self.zapReturning and not self.inCutscene and not self.inCutsceneOrIcam then
      self.controllerInterface:registerPlayerControl()
    end
    self:update()
    self:setWreckedAutoZap(false)
    taskSystem.forceTaskObjectMinorTaskRefresh()
    if phaseManager.inMission() then
      scoreSystem.stopAbilityDrain(self.localID, false)
    end
    for localID, plr in next, localPlayerManager.players, nil do
      if localID ~= self.localID then
        ZapAIPresence.StartTransition(nil, self.currentVehicle.gameVehicle, localID, localID)
      end
    end
    NetworkLog.Write(">[LUA] LOCALPLAYER - Player exited zap mode, currentVehicle SNVID = " .. tostring(self.currentVehicle.SNVID))
  else
    removeUserUpdateFunction("Delorean")
  end
  self:buildZapReturn(zapLevel, vehicle)
end
function resetCameraMode(self)
  if not ReplaySystem.IsPlayingBack() and zap.currentLevel[self.localID] == 0 then
    resetActiveCamera(self.localID)
  end
end
local HUDActive = false
function isHUDActive()
  return HUDActive
end
function showHUDElements(self, status, params)
  playerTaskObject = self:getTaskObject()
  local params = params or {}
  HUDActive = status
  local numberStatus = 0
  if status then
    numberStatus = 1
    if not gameStatus.onlineSession and zap.getZapLevel() and zap.getZapLevel() > 4 then
      self.minimapSupport:showGoogleMap()
    else
      self.minimapSupport:show()
    end
  else
    if self.minimapSupport.googleMapActive then
      self.minimapSupport:hideGoogleMap()
    else
      self.minimapSupport:zoomIn()
      if not params.minimap then
        self.minimapSupport:hide()
      end
    end
    if not params.prompts then
      feedbackSystem.menusMaster.clearAllTextPrompts()
    end
  end
  local blockIcarSpeedAndDamageBars = false
  if progressionSystem.currentProgression <= 3 and not bonusChallengeActive then
    blockIcarSpeedAndDamageBars = true
  end
  if (not blockIcarSpeedAndDamageBars and not params.carSpeed or Network.isOnlineGame()) and not gameStatus.splitscreenSession then
    if not status then
      feedbackSystem.menusMaster.currentHUDSetVariable("iCarSpeed_Display", numberStatus)
    elseif status and not localPlayer.inZap or status and vehicleManager.previewVehicleManager.previewVehicle then
      feedbackSystem.menusMaster.currentHUDSetVariable("iCarSpeed_Display", numberStatus)
    end
  end
  if (not blockIcarSpeedAndDamageBars or gameStatus.onlineSession or status == false) and not params.carDamage then
    if not status then
      if numberStatus == 1 then
        feedbackSystem.menusMaster.enableDamageBar(self)
      else
        feedbackSystem.menusMaster.disableDamageBar(self)
      end
    elseif status and not localPlayer.inZap or status and vehicleManager.previewVehicleManager.previewVehicle then
      if numberStatus == 1 then
        feedbackSystem.menusMaster.enableDamageBar(self)
      else
        feedbackSystem.menusMaster.disableDamageBar(self)
      end
    end
  end
  if not params.felonyHUD then
    if numberStatus == 1 then
      Chase.EnableHud(true)
      Getaway.EnableHud(true)
    else
      Chase.EnableHud(false)
      Getaway.EnableHud(false)
    end
  end
  if not params.abilityBar then
    local enable = status and abilities.getEnabled()
    enable = not gameStatus.onlineSession and enable and (isAbilityUnlocked("nitro") or isAbilityUnlocked("ram"))
    scoreSystem.showAbilityFeedback(self.localID, enable)
  end
  if isWillpowerEnabled() and not params.willpower and not gameStatus.splitscreenSession then
    feedbackSystem.menusMaster.masterSetVariable("iWillpower_Display", numberStatus)
  end
  if not gameStatus.splitscreenSession and not params.darePanel then
    dareSystem.hideDarePrompts(not status)
  end
  if not gameStatus.splitscreenSession then
    activeChallenges.hidePromptOnShiftOut()
  end
  if self.waggleStickPrompt then
    feedbackSystem.menusMaster.currentHUDSetVariable("iStick_Waggle", numberStatus)
  end
  if not params.hudPanels and not gameStatus.splitscreenSession then
    feedbackSystem.showHUDPanels(status)
  end
  if self.inZap then
    zap.zoomInOutButtonPrompts(self, status)
  end
  feedbackSystem.menusMaster.focusHintButtonState(status)
  if not gameStatus.onlineSession then
    feedbackSystem.menusMaster.locationPrompt(status)
  end
  if not params.willpowerRewards then
    scoreSystem.setWillpowerPromptState(status)
  end
  if feedbackSystem.previewScreen.activityBeingPrompted and not self.inZap then
    feedbackSystem.menusMaster.masterSetVariable("iDare_Prompt", numberStatus)
  end
end
function enterCutsceneMode(self, params)
  local params = params or {}
  if (not self.inCutscene or params.addAI ~= nil) and not gameStatus.onlineSession then
    local hideVehicle = params.hideVehicle or false
    self.inCutscene = true
    self.controls.enableRumble(false)
    Commentary.BlockAI(true)
    felony_suspiciousVehicleManager.enableSuspiciousVehicles(false)
    self.controls:resetState("Player")
    if self.currentVehicle and self.currentVehicle.controlled and self.currentVehicle.abilityActive then
      self.currentVehicle:cancelAbility(self.localID)
    end
    self.controllerInterface:removePlayerControl(params.addAI)
    zapcontroller.EnableZapInput(false)
    self:showHUDElements(false, params)
  end
end
function exitCutsceneMode(self, params)
  if self.inCutscene then
    local params = params or {}
    if not gameStatus.onlineSession then
      self.inCutscene = false
      self.controls.enableRumble(true)
      Commentary.BlockAI(false)
      felony_suspiciousVehicleManager.enableSuspiciousVehicles(true)
      if self.currentVehicle and self.currentVehicle.controlled then
        self.controls:setState("Player")
        if self.currentVehicle.abilityActive then
          self.currentVehicle:cancelAbility(self.localID)
        end
      end
      self.controllerInterface:registerPlayerControl()
      zapcontroller.EnableZapInput(true)
      if not blockHUD then
        self:showHUDElements(true, params)
      end
    end
  end
end
local workingVector = vec.vector()
function inVehicleUpdate(self)
end
function forcedAutoZap(self)
  local workingVector = vec.vector()
  local traffic = TrafficSystem.vehicleList(self.position, 100)
  local furthestDistance = 0
  local furthestGameVehicle
  for k, gameVehicle in next, traffic, nil do
    local distanceFromPlayer = workingVector:sub(self.position, GameVehicleResource.position(gameVehicle, workingVector)):length()
    if furthestDistance < distanceFromPlayer then
      furthestDistance = distanceFromPlayer
      furthestGameVehicle = gameVehicle
    end
  end
  if not self.inZap then
    self:SetZapLevel(1)
  end
  if furthestGameVehicle then
    zapcontroller.AutoZap = true
    SNV.CreateSNVFromGV(furthestGameVehicle)
    self:SetZapLevel(0, vehicleManager.registerVehicle({gameVehicle = furthestGameVehicle}), true)
    return true
  else
    local vehicle = spawnVehicle(self.currentVehicle.gameVehicle.model_id)
    if vehicle then
      self:SetZapLevel(0, vehicleManager.registerVehicle({gameVehicle = vehicle}), true)
      return true
    end
  end
  return false
end
function buildWreckedAutoZap(self)
end
function towTruckID()
  playerTaskObject = self:getTaskObject()
  if playerTaskObject then
    for actorID, taskObject in next, playerTaskObject.coreData.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.agent.isTowing then
        return taskObject.coreData.agent
      end
    end
  end
end
function getTaskObject()
  return missionSupport:getMainTaskObject()
end
function update(self)
end
function lockLocalPlayerZapOut()
  localPlayer:blockAbility("zap", true, true)
end
_G.LockLocalPlayerZapOut = lockLocalPlayerZapOut
function unlockLocalPlayerZapOut()
  localPlayer:blockAbility("zap", false, true)
end
_G.UnlockLocalPlayerZapOut = unlockLocalPlayerZapOut
function restorePlayerControl()
  localPlayer.controllerInterface:resetCallbacks()
end
_G.restorePlayerControl = restorePlayerControl
function enterEngineCutscene()
  Menu.ShowMaster = 0
end
_G.enterEngineCutscene = enterEngineCutscene
function exitEngineCutscene()
  Menu.ShowMaster = 1
end
_G.exitEngineCutscene = exitEngineCutscene
function receiveScriptMessage(fromPlayerID, messageType, messageSize, message)
  if messageType == 1 then
    assert(false, "Script no longer sets teams")
  elseif messageType == 2 then
    if stateMachine.isInitialised() then
      stateMachine.moveState = true
    end
  elseif messageType == 3 then
    if stateMachine.isInitialised() then
      stateMachine.forceToState(phaseManager.states[tonumber(message)])
    end
  elseif messageType == 4 then
    if stateMachine.isInitialised() then
      OnlineModeSettings.onlineDisableAssert = true
      stateMachine.reenterState(phaseManager.states[tonumber(message)])
      OnlineModeSettings.onlineDisableAssert = false
    end
  elseif messageType == 7 then
    onlineScreenManager.setBlueTeamCurrentScore(tonumber(message))
    triggerScreenUpdate()
  elseif messageType == 8 then
    onlineScreenManager.setRedTeamCurrentScore(tonumber(message))
    triggerScreenUpdate()
  elseif messageType == 9 then
    faceOffSystem.removeFaceOffFromAvailablePool(tonumber(message))
  elseif messageType == 10 then
    stateMachine.canJoin(tonumber(message))
  elseif messageType == 11 then
    assert(false, "Do not set the remote players XP via this method")
  elseif messageType == 12 then
    phaseManager.updateUsableModeAreaIndex("MP tag", tonumber(message), false)
  elseif messageType == 13 then
    phaseManager.updateUsableModeAreaIndex("MP takedown", tonumber(message), false)
  elseif messageType == 14 then
    phaseManager.updateUsableModeAreaIndex("MP burning rubber", tonumber(message), false)
  elseif messageType == 15 then
    phaseManager.updateUsableModeAreaIndex("MP circuit race", tonumber(message), false)
  elseif messageType == 16 then
    phaseManager.updateUsableModeAreaIndex("MP pure race", tonumber(message), false)
  elseif messageType == 17 then
    phaseManager.updateUsableModeAreaIndex("MP sprint race", tonumber(message), false)
  elseif messageType == 18 then
    phaseManager.updateUsableModeAreaIndex("MP tug of war", tonumber(message), false)
  elseif messageType == 19 then
    phaseManager.updateUsableModeAreaIndex("MP rush down", tonumber(message), false)
  elseif messageType == 20 then
    phaseManager.updateUsableModeAreaIndex("MP trail blazer", tonumber(message), false)
  elseif messageType == 21 then
    phaseManager.updateUsableModeAreaIndex("MP team circuit race", tonumber(message), false)
  elseif messageType == 22 then
    phaseManager.updateUsableModeAreaIndex("Air", tonumber(message), false)
  elseif messageType == 23 then
    phaseManager.updateUsableModeAreaIndex("Drift", tonumber(message), false)
  elseif messageType == 24 then
    phaseManager.updateUsableModeAreaIndex("Drive far", tonumber(message), false)
  elseif messageType == 25 then
    phaseManager.updateUsableModeAreaIndex("Overtake cars", tonumber(message), false)
  elseif messageType == 26 then
    phaseManager.updateUsableModeAreaIndex("Smash props", tonumber(message), false)
  elseif messageType == 27 then
    phaseManager.turnOnAllowTooFewPlayers(true)
  elseif messageType == 28 then
    onlineRaceManager.lockPlayersPosition(fromPlayerID, tonumber(message))
  elseif messageType == 29 then
    phaseManager.updateUsableModeAreaIndex("MP checkpoint rush", tonumber(message), false)
  elseif messageType == 30 then
    onlineRaceManager.onRemotePlayerFinishRace(fromPlayerID, tonumber(message))
  elseif messageType == 31 then
    onlineRaceManager.onReceiveReplyToPlayerFinish(fromPlayerID, tonumber(message))
  elseif messageType == 32 then
    packageManager.requestDenied(fromPlayerID, messageType, message)
  elseif messageType == 33 then
    phaseManager.onReceivedPlayerScore(fromPlayerID, tonumber(message))
  elseif messageType == 34 then
    phaseManager.onReceivedPlayerRoundScore(message)
  elseif messageType == 35 then
    phaseManager.onReceivedTeamOneScore(tonumber(message))
  elseif messageType == 36 then
    phaseManager.onReceivedTeamTwoScore(tonumber(message))
  elseif messageType == 37 then
    phaseManager.onReceivedPlayerAdditionalData(fromPlayerID, tonumber(message))
  elseif messageType == 38 then
    stateMachine.reSendCurrentState()
    stateMachine.reSendMoveToState()
  end
end
_G.ReceiveScriptMessage = receiveScriptMessage
function isMissionActive()
  local online = Network.isOnlineGame() or Network.isSplitScreenMode()
  if not online then
    feedbackSystem.menusMaster.setPauseMenu()
  end
  local playerTaskObject = localPlayer:getTaskObject()
  if playerTaskObject then
    if online then
      return true
    else
      local mission, potID, subType, type = progressionSystem.findMissionInProgression(playerTaskObject.coreData.instance.challenge.name)
      if not mission.allowActivityIcons then
        return true
      else
        return false
      end
    end
  else
    return false
  end
end
function getMissionType()
  local online = Network.isOnlineGame() or Network.isSplitScreenMode()
  if not online then
    feedbackSystem.menusMaster.setPauseMenu()
  end
  local playerTaskObject = localPlayer:getTaskObject()
  if playerTaskObject then
    local mission, potID, subType, type = progressionSystem.findMissionInProgression(playerTaskObject.coreData.instance.challenge.name)
    if not mission.allowActivityIcons then
      return tostring(type)
    else
      return "none"
    end
  else
    return "none"
  end
end
_G.isMissionActive = isMissionActive
_G.getMissionType = getMissionType
local hudParams = {prompts = true}
function _G.ForceInsideProgressionBoundaries(parameters)
  feedbackSystem.menusMaster.clearAllTextPrompts()
  if vehicleManager.previewVehicleManager.previewVehicle then
    vehicleManager.previewVehicleManager.rejectChallengeCallback()
  end
  CameraSystem.ClearScene()
  if not gameStatus.onlineSession then
    if localPlayerManager.players[parameters.localID].currentVehicle then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:236676")
      local zapWasAvailable = localPlayer:getAbilityAvailable("zap")
      localPlayer:blockAbility("zap", true)
      localPlayerManager.players[parameters.localID].teleporting = true
      print("teleporting")
      spooling.waitForSpooling(localPlayerManager.players[parameters.localID].currentVehicle.gameVehicle.position, function()
        CityLockManager.CachedTeleport()
        if zapWasAvailable then
          localPlayer:blockAbility("zap", false)
        end
      end, nil, function()
        if isAbilityUnlocked("zap") and not gameStatus.onlineSession and not ReplaySystem.IsPlayingBack() then
          tannerNarration.playTannerNarration("CityLimit")
        end
        localPlayerManager.players[parameters.localID].teleporting = false
        print("finished teleporting")
      end, nil, nil, false, true, nil, hudParams)
    end
  elseif not localPlayerManager.players[parameters.localID].inZap then
    localPlayerManager.players[parameters.localID]:SetZapLevel(1, nil, false, {forcedOut = true})
  end
end
function deleteVehicleTaskObjectIfPreview()
  local taskObject = self.currentVehicle and self.currentVehicle:getTaskObject()
  if taskObject and not taskObject.coreData.actor.hasPreview then
    taskObject.coreData.instance:delete()
  end
end
function specialPlayerSwitchVehicle(newVehicle, oldSNVID)
  localPlayer:clearCurrentVehicle()
  local vehicle = vehicleManager.vehiclesBySNVID[oldSNVID]
  vehicleManager.unregisterVehicle(vehicle, false)
  local newVehicle = vehicleManager.takeOwnership({gameVehicle = newVehicle})
  localPlayer:setCurrentVehicle(newVehicle)
end
_G.SpecialPlayerSwitchVehicle = specialPlayerSwitchVehicle
