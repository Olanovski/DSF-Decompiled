module("faceOffSystem")
local instanceTemplate = {}
instanceTemplate.__index = instanceTemplate
function buildInstance(networkVars, remoteSNOID, pointTracking)
  local instance = {
    isLocal = not remoteSNOID,
    faceOff = faceOffPool[networkVars.faceOffID],
    agent = localPlayer,
    endFaceOffWheWeCan = false,
    initialised = false
  }
  setmetatable(instance, instanceTemplate)
  instance.pointTracking = {
    debugCheckIsLocal = function()
      return instance.isLocal
    end,
    updateRequired = false,
    __newindex = networkParsing.metaSetNetworkVar,
    __index = pointTracking or {}
  }
  setmetatable(instance.pointTracking, instance.pointTracking)
  instance.networkVars = {
    debugCheckIsLocal = function()
      return instance.isLocal
    end,
    updateRequired = true,
    __newindex = networkParsing.metaSetNetworkVar,
    __index = networkVars
  }
  setmetatable(instance.networkVars, instance.networkVars)
  if instance.faceOff.buildFunctions then
    instance.init, instance.release, instance.startFaceOff, instance.playerJoining = instance.faceOff.buildFunctions(instance)
  end
  if instance.isLocal then
    instance.instanceID = createSNOFromObject(instance)
  else
    instance.instanceID = remoteSNOID
  end
  SNO.setMigrationType(instance.instanceID, 1)
  instance.playerVehicles = {}
  return instance
end
function createInstance(faceOff, faceOffAreaIndex)
  local instance = buildInstance({
    faceOffID = faceOff.ID,
    startTime = -1,
    areaKey = faceOffAreaIndex,
    complete = false
  })
  return instance
end
function faceOffGoalCallback(faceOff, condition, completionData)
  faceOff:claimPoints(1 or completionData)
end
function instanceTemplate:getTime()
  if self.networkVars.startTime and self.networkVars.startTime > 0 then
    return g_NetworkTime - self.networkVars.startTime
  end
  return 0
end
function instanceTemplate:registerPlayer(player)
  if not self.pointTracking[player.playerID] then
    self.pointTracking[player.playerID] = 0
  end
end
function instanceTemplate:unregisterPlayer(player)
  if self.pointTracking[player.playerID] then
    self.pointTracking[player.playerID] = nil
  end
end
function instanceTemplate:claimPoints(points)
  OneShotSound.Play("HUD_Online_FaceOff_PlayerScores_OneShot", false)
  local msg = tostring(points)
  NetworkLog.WriteDetail(">[LUA] FACEOFF SYSTEM - Claim points from the faceoff, SNOID = " .. tostring(self.instanceID) .. ", 2nd param = " .. tostring(0) .. ", 3rd param = " .. msg)
  sendMessage(0, msg)
end
function instanceTemplate:assignPoints(player, claimedPoints)
  if not self.pointTracking[player.playerID] then
    self:registerPlayer(player)
  end
  self.pointTracking[player.playerID] = self.pointTracking[player.playerID] + claimedPoints
  NetworkLog.WriteDetail(">[LUA] FACEOFF SYSTEM - assign points to player: " .. tostring(player.playerID) .. ", points: " .. tostring(claimedPoints) .. ", total points: " .. self.pointTracking[player.playerID])
end
function instanceTemplate:getScore(player)
  return self.pointTracking[player.playerID] or 0
end
allowSidebarToggle = 0
qualifyingRewardTarget = 0.5
qualifyingRewardTable = {
  [1] = {1},
  [2] = {1, 0.5},
  [3] = {
    1,
    0.5,
    0.3
  },
  [4] = {
    1,
    0.5,
    0.3,
    0.2
  },
  [5] = {
    1,
    0.7,
    0.4,
    0.2,
    0.2
  },
  [6] = {
    1,
    0.7,
    0.5,
    0.4,
    0.2,
    0.2
  },
  [7] = {
    1,
    0.8,
    0.6,
    0.4,
    0.3,
    0.2,
    0.2
  },
  [8] = {
    1,
    0.8,
    0.6,
    0.5,
    0.4,
    0.3,
    0.2,
    0.2
  }
}
function instanceTemplate:getRewardMultiplier(player, syncedScores)
  local playerScore = syncedScores[player.playerID]
  local maxScore = math.floor(self.faceOff.settings.areas[self.networkVars.areaKey].maxPoints * qualifyingRewardTarget)
  local playerPosition = 1
  for playerID, score in next, syncedScores, nil do
    if score then
      if playerID ~= player.playerID and score > playerScore then
        playerPosition = playerPosition + 1
      end
      if score > maxScore then
        maxScore = score
      end
    end
  end
  if playerPosition > playerManager.numberOfPlayers then
    playerPosition = playerManager.numberOfPlayers
  end
  if playerScore / maxScore >= 0.5 then
    return qualifyingRewardTable[playerManager.numberOfPlayers][playerPosition]
  else
    return qualifyingRewardTable[playerManager.numberOfPlayers][playerPosition] * (playerScore / maxScore) * 2
  end
end
function instanceTemplate:initiate()
  if self.init then
    self.init()
  end
  if self.faceOff.settings.areas[self.networkVars.areaKey].propData then
    propSystem.setupRuntimeProps(self.faceOff.settings.areas[self.networkVars.areaKey].propData.name, self.faceOff.settings.areas[self.networkVars.areaKey].propData.smashIcon, self.faceOff.settings.areas[self.networkVars.areaKey].propData.minimapIcon)
  end
  feedbackSystem.faceOffSupport.watch(self)
end
function instanceTemplate:start()
  if self.faceOff.settings.areas[self.networkVars.areaKey].lockingZoneData then
    OneShotSound.Play("HUD_Online_MapDefine")
    CityLockManager.CityLockState = self.faceOff.settings.areas[self.networkVars.areaKey].lockingZoneData.name
    CityLockManager.CityLockActive = true
    if self.faceOff.settings.areas[self.networkVars.areaKey].lockingZoneData.drawDistance then
      CityLockManager.FadeInDistance = self.faceOff.settings.areas[self.networkVars.areaKey].lockingZoneData.drawDistance
    end
  end
  goalSystem.faceOffSupport.createFaceOffGoals(self)
  if self.isLocal then
    self.networkVars.startTime = g_NetworkTime
  end
  if self.startFaceOff then
    self.startFaceOff()
  end
  self.initialised = true
end
function instanceTemplate:stop()
  goalSystem.faceOffSupport.removeFaceOffGoals(self)
  feedbackSystem.faceOffSupport.removeFeedback()
  feedbackSystem.faceOffSupport.stopWatching(self)
end
function instanceTemplate:getPlayerFinalScore(playerID)
  return self:getScore(playerManager.players[playerID])
end
function instanceTemplate:onFinalScoresSynced(syncedScores)
  local localReward = self:getRewardMultiplier(localPlayer, syncedScores)
  local localZapFuel = math.ceil(scoreSystem.getMaxAbility() * localReward)
  local localWeaponFuel = math.ceil(zapWeaponSupport.getZapWeaponCooldown() * localReward)
  for playerID, player in next, playerManager.players, nil do
    onlineScreenManager.updatePlayerScore(playerID, syncedScores[playerID])
  end
  onlineScreenManager.updatePlayerSecondaryScore(localPlayer.playerID, localZapFuel)
  onlineScreenManager.updatePlayerWeaponFuel(localPlayer.playerID, localWeaponFuel)
  onlineScreenManager.setForceSortType(false)
  onlineScreenManager.setRaceCompleteData(false)
  GameplayTracking.OnFaceOffComplete(self.faceOff.settings.title, syncedScores[localPlayer.playerID])
  local results = onlineScreenManager.getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.scoreNoID)
  if results[1].id == localPlayer.playerID then
    ProfileSettings.SetNumFaceOffsWon(ProfileSettings.GetNumFaceOffsWon() + 1)
  end
  scoreSystem.setAbility(localPlayer.localID, localZapFuel)
  zapWeaponSupport.setZapWeaponFuel(localWeaponFuel)
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
    onlineProgressionSystem.setFaceOffPercentScore(syncedScores[localPlayer.playerID] / self.faceOff.settings.areas[self.networkVars.areaKey].maxPoints)
  end
end
function instanceTemplate:complete()
  CityLockManager.CityLockState = "CityLockingLevel4"
  CityLockManager.CityLockActive = true
  CityLockManager.FadeInDistance = 80
  if self.release then
    self.release()
  end
  self:delete()
end
function instanceTemplate:delete()
  currentFaceOff = false
  if self.isLocal then
    assert(SNO.canBeDeleted(self.instanceID))
    SNO.setMigrationType(self.instanceID, 0)
    SNO.deleteSNO(self.instanceID)
  end
  for playerID, player in next, playerManager.players, nil do
    player.playerTagSet = nil
  end
  self.playerVehicles = nil
  self.instanceID = nil
  self.initialised = false
end
function instanceTemplate:canBeDeleted()
  if self.isLocal and not SNO.canBeDeleted(self.instanceID) then
    return false
  end
  return true
end
function instanceTemplate:update()
  if self.isLocal and not self.networkVars.complete and self:getTime() > phaseManager.faceOffPhaseLength() then
    self.networkVars.complete = true
  end
  return self.networkVars.complete
end
function instanceTemplate:instanceComplete()
  return currentFaceOff.networkVars.complete
end
function instanceTemplate:playerJoined(player)
  if self.playerJoining then
    self.playerJoining(player)
  end
end
