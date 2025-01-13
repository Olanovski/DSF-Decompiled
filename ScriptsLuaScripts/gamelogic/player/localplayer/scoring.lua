module("localPlayer.scoring", package.seeall)
scoringDisabled = false
parent = localPlayer
onlineTutorialFeedback = false
function disableScoring(self, state)
  self.scoringDisabled = state
end
numberOfOvertakes = 0
function getNumberOfOvertakes(self)
  return self.numberOfOvertakes
end
totalDriftDistance = 0
function getTotalDriftDistance(self)
  return self.totalDriftDistance
end
currentDriftDistance = 0
function getCurrentDriftDistance(self)
  return self.currentDriftDistance
end
vehiclesJumped = 0
function getNumberOfVehiclesJumped(self)
  return self.vehiclesJumped
end
totalAirTimeDistance = 0
function getTotalAirTimeDistance(self)
  return self.totalAirTimeDistance
end
totalAirTimeHeight = 0
function getTotalAirTimeHeight(self)
  return self.totalAirTimeHeight
end
currentAirTimeDistance = 0
function getCurrentAirTimeDistance(self)
  return self.currentAirTimeDistance
end
currentAirTimeHeight = 0
function getCurrentAirTimeHeight(self)
  return self.currentAirTimeHeight
end
function resetCurrentAirTimeDistance(self)
  self.currentAirTimeDistance = 0
end
function resetCurrentAirTimeHeight(self)
  self.currentAirTimeHeight = 0
end
perfectLandings = 0
function getPerfectLandings(self)
  return self.perfectLandings
end
rammedVehicles = 0
function getRammedVehicles(self)
  return self.rammedVehicles
end
vehiclesDestroyed = 0
function getVehiclesDestroyed(self)
  return self.vehiclesDestroyed
end
scoringFreezeAfterCrash = false
scoringFreezeStartTime = g_NetworkTime
scoringFreezeDuration = 1
local driftChainingAllowance = 1
isDrifting = false
function resetDrift(self)
  self.currentDriftDistance = 0
end
function resetDriftScoreOnEnterZap(self)
  if isDrifting then
    self:resetDrift()
  end
end
function _G.scoringDriftStart(localID)
  local player = localPlayerManager.players[localID]
  local self = player.scoring
  if self.scoringDisabled then
    return
  end
  self.isDrifting = true
  self.currentDriftDistance = 0
end
function _G.scoringDriftCallback(localID, Distance)
  local player = localPlayerManager.players[localID]
  local self = player.scoring
  self.currentDriftDistance = Distance
end
function _G.scoringDriftEnd(localID, Distance)
  local player = localPlayerManager.players[localID]
  local self = player.scoring
  if self.scoringDisabled then
    return
  end
  self.currentDriftDistance = Distance
  localPlayer.simulationSupport.doWait(0.5, function()
    scoreSystem.increaseAbility(player, Distance * abilities.getAbilityGainValue("drift"))
  end)
  self.totalDriftDistance = self.totalDriftDistance + Distance
  if onlineTutorialFeedback and onlineTutorialFeedback == 1 then
    onlineTutorialErrorFeedback(1)
  end
  self.isDrifting = false
end
local minimumDistanceCovered = 2
isJumping = false
takeOffPosition = false
landedPosition = false
workingVector = vec.vector()
currentPosition = vec.vector()
distanceCovered = 0
heightCovered = 0
landedOrCrashedMidAir = false
onWheelsOrUpsideDown = false
wheelsOnGround = false
resetScoreTimer = g_NetworkTime
resetScore = false
local air = {
  [-2] = true
}
rewardJump = true
function cancelJumpScoring(self)
  if self.distanceCovered > minimumDistanceCovered then
  end
  self.distanceCovered = 0
  self:resetCurrentAirTimeDistance()
  self.heightCovered = 0
  self:resetCurrentAirTimeHeight()
end
function resetJumpScoreOnEnterZap(self)
  if isJumping then
    self:cancelJumpScoring()
  end
end
function _G.scoringAirTimeStart(localID)
  local player = localPlayerManager.players[localID]
  local self = player.scoring
  if self.scoringDisabled or self.scoringFreezeAfterCrash then
    return
  end
  self.isJumping = true
  self.takeOffPosition = self.parent.currentVehicle.position:clone()
  self.resetScore = false
end
function _G.scoringAirTimeDistanceCallback(airTimeInfo)
  local player = localPlayerManager.players[airTimeInfo.localID]
  local self = player.scoring
  if self.scoringDisabled or self.scoringFreezeAfterCrash then
    return
  end
  self.currentAirTimeDistance = airTimeInfo.Distance
end
function _G.scoringAirTimeEnd(airTimeInfo)
  local player = localPlayerManager.players[airTimeInfo.localID]
  local self = player.scoring
  self.isJumping = false
  self.rewardJump = true
  self.landedOrCrashedMidAir = false
  self.onWheelsOrUpsideDown = false
  self.wheelsOnGround = false
  self.takeOffPosition = nil
  self.isJumping = false
  self.heightCovered = 0
  if 0 < airTimeInfo.Distance then
    local flooredDistanceCovered = math.floor(airTimeInfo.Distance)
    self.totalAirTimeDistance = self.totalAirTimeDistance + flooredDistanceCovered
    self.perfectLandings = self.perfectLandings + 1
    localPlayer.simulationSupport.doWait(0.5, function()
      scoreSystem.increaseAbility(self.parent, flooredDistanceCovered * abilities.getAbilityGainValue("jump"))
    end)
    self.resetScoreTimer = g_NetworkTime
    self.resetScore = true
  end
  if not self.onWheelsOrUpsideDown then
    self.onWheelsOrUpsideDown = true
  end
end
local overtakeSpeedMultiplier = 0.05
local overtakeScoreMultiplier = 3
local minimumRelativeDifference = 20
local chainedOvertakeTimeAllowance = 2
local timeOfPreviousOvertake = 0
local chainedOvertakes = 0
function _G.playerHasOvertaken(overtakeInfo)
  local player = localPlayerManager.players[overtakeInfo.localID]
  local self = player.scoring
  local overtakeFlag = true
  if self.scoringDisabled or self.scoringFreezeAfterCrash or scoreSystem.isPlayerOffRoad(2, localPlayer.localID) then
    overtakeFlag = false
  else
    local playerSpeed = self.parent.currentVehicle.speed * 2.237
    local vehicleSpeed = overtakeInfo.VehicleSpeed * 2.237
    local relativeSpeed, score
    if overtakeInfo.WithTrafficFlow then
      relativeSpeed = playerSpeed - vehicleSpeed
      if relativeSpeed > 20 then
        score = overtakeScoreMultiplier * math.floor(relativeSpeed * overtakeSpeedMultiplier)
        localPlayer.simulationSupport.doWait(0.5, function()
          scoreSystem.increaseAbility(player, abilities.getAbilityGainValue("overtake"))
        end)
        self.numberOfOvertakes = self.numberOfOvertakes + 1
        if self.isJumping then
          self.vehiclesJumped = self.vehiclesJumped + 1
        end
        if overtakeInfo.localID == 0 then
          ProfileSettings.SetNumOvertakes(ProfileSettings.GetNumOvertakes() + 1)
        end
      else
        overtakeFlag = false
      end
    else
      relativeSpeed = playerSpeed + vehicleSpeed
      if relativeSpeed > overtakeInfo.VehicleSpeed then
        score = abilities.getAbilityGainValue("oncoming")
        scoreSystem.increaseAbility(player, score)
        self.numberOfOvertakes = self.numberOfOvertakes + 1
        if self.isJumping then
          self.vehiclesJumped = self.vehiclesJumped + 1
        end
        if overtakeInfo.localID == 0 then
          ProfileSettings.SetNumOncomingOvertakes(ProfileSettings.GetNumOncomingOvertakes() + 1)
        end
      else
        overtakeFlag = false
      end
    end
    if scoreSystem.feedbackVisible and (not scoreSystem.limitedFeedback or scoreSystem.limitedFeedback == 3) then
      feedbackSystem.menusMaster.masterSetVariable("iSkill_Overtake", 1)
    end
    if overtakeInfo.localID == 0 then
      ProfileSettings.SetNumNearMisses(ProfileSettings.GetNumNearMisses() + 1)
    end
    if overtakeFlag then
      if g_NetworkTime - timeOfPreviousOvertake > chainedOvertakeTimeAllowance then
        ProfileSettings.SetLongestOvertakeChain(math.max(ProfileSettings.GetLongestOvertakeChain(), chainedOvertakes))
        chainedOvertakes = 0
      end
      chainedOvertakes = chainedOvertakes + 1
      timeOfPreviousOvertake = g_NetworkTime
    end
  end
  return overtakeFlag and GetHUDOn()
end
local toleranceTime = 0.25
local air = {
  [-1] = true
}
local collisionData = {
  [1] = {
    name = "glance",
    force = 2000,
    spPenalty = 0,
    mpPenalty = 0,
    scoringFreezeDuration = 0
  },
  [2] = {
    name = "scrape",
    force = 4000,
    spPenalty = 1,
    mpPenalty = 1,
    scoringFreezeDuration = 1
  },
  [3] = {
    name = "dent",
    force = 7500,
    spPenalty = 3,
    mpPenalty = 2,
    scoringFreezeDuration = 1
  },
  [4] = {
    name = "smash",
    force = 12500,
    spPenalty = 5,
    mpPenalty = 2,
    scoringFreezeDuration = 1
  },
  [5] = {
    name = "wipeOut",
    force = 22500,
    spPenalty = 7.5,
    mpPenalty = 2,
    scoringFreezeDuration = 1
  }
}
function collisionCallback(collisionInfo)
  local player = localPlayerManager.getPlayerByGameVehicle(collisionInfo.GameVehicle)
  local self = player.scoring
  local previousCollisionTime = 0
  local minimumTimeBetweenCollisions = 1
  local previousZapTime = g_NetworkTime
  local noZapDuration = 2
  local newVehicle
  local textOnScreen = false
  local collisionType, collisionNumber
  if collisionInfo.CollidedNormalY > 0.707 and 0.707 < collisionInfo.CollidedNormalDotVehicleY then
    collisionType = collisionData[1].name
    collisionNumber = 1
  else
    for i = #collisionData, 1, -1 do
      if collisionData[i].force and collisionInfo.Force >= collisionData[i].force and (collisionData[i].name == "glance" and collisionInfo.Type ~= "Other" or collisionData[i].name ~= "glance") then
        collisionType = collisionData[i].name
        collisionNumber = i
        break
      end
    end
  end
  if collisionInfo.CollidedGameVehicle then
    player.lastCollisionTime = collisionInfo.Time
    player.lastCollidedGameVehicle = collisionInfo.CollidedGameVehicle
  end
  if collisionType then
    local usingRam = AbilityController.isAbilityActive("ram")
    local usingNitro = AbilityController.isAbilityActive("nitro")
    if collisionInfo.Time > previousCollisionTime + minimumTimeBetweenCollisions and collisionType ~= "glance" then
      if usingRam and collisionInfo.Type == "Vehicle" then
        self.rammedVehicles = self.rammedVehicles + 1
      end
      if collisionInfo.CollidedGameVehicle and collisionInfo.CollidedGameVehicle.damage >= 0.4 then
        self.vehiclesDestroyed = self.vehiclesDestroyed + 1
      end
      if collisionInfo.WhereIWasHit == "Behind" then
        local reducedCollision = collisionData[collisionNumber - 1]
        if reducedCollision then
          collisionType = reducedCollision.name
        end
      end
      if not usingRam then
        for k, v in next, collisionData, nil do
          if collisionType == v.name then
            self.scoringFreezeDuration = v.scoringFreezeDuration
            self.scoringFreezeAfterCrash = 1 < v.spPenalty
            break
          end
        end
        self.scoringFreezeStartTime = g_NetworkTime
      end
      previousCollisionTime = collisionInfo.Time
    end
  end
end
function update(self)
  if self.scoringFreezeAfterCrash and g_NetworkTime >= self.scoringFreezeStartTime + self.scoringFreezeDuration then
    self.scoringFreezeDuration = 1
    self.scoringFreezeAfterCrash = false
  end
  if self.resetScore then
    local jumpTime = g_NetworkTime - self.resetScoreTimer
    if jumpTime > 1.5 then
      self.resetScore = false
    end
  end
end
local vehicleJumpedStartCallbacks = {}
local vehicleJumpedStartRemoveCallbacks = {}
function registerVehicleJumpedStartCallback(callback)
  if callback then
    table.insert(vehicleJumpedStartCallbacks, #vehicleJumpedStartCallbacks + 1, callback)
  else
  end
end
function unregisterVehicleJumpedStartCallback(callback)
  if callback then
    for i, storedCallback in ipairs(vehicleJumpedStartCallbacks) do
      if storedCallback == callback then
        table.insert(vehicleJumpedStartRemoveCallbacks, #vehicleJumpedStartRemoveCallbacks + 1, callback)
        break
      end
    end
  else
  end
end
function _G.scoringJumpedCar(scoringJumpedCar)
  for i, storedCallback in ripairs(vehicleJumpedStartRemoveCallbacks) do
    for j, callback in ripairs(vehicleJumpedStartCallbacks) do
      if storedCallback == callback then
        table.remove(vehicleJumpedStartRemoveCallbacks, i)
        table.remove(vehicleJumpedStartCallbacks, j)
        break
      end
    end
  end
  for i, callback in ipairs(vehicleJumpedStartCallbacks) do
    callback(scoringJumpedCar)
  end
end
local vehicleJumpedEndedCallbacks = {}
local vehicleJumpedEndRemoveCallbacks = {}
function registerVehicleJumpedEndedCallback(callback)
  if callback then
    table.insert(vehicleJumpedEndedCallbacks, #vehicleJumpedEndedCallbacks + 1, callback)
  else
  end
end
function unregisterVehicleJumpedEndedCallback(callback)
  if callback then
    for i, storedCallback in ipairs(vehicleJumpedEndedCallbacks) do
      if storedCallback == callback then
        table.insert(vehicleJumpedEndRemoveCallbacks, #vehicleJumpedEndRemoveCallbacks + 1, callback)
        break
      end
    end
  else
  end
end
function _G.scoringJumpedCarEnded(scoringJumpedCar)
  for i, storedCallback in ripairs(vehicleJumpedEndRemoveCallbacks) do
    for j, callback in ripairs(vehicleJumpedEndedCallbacks) do
      if storedCallback == callback then
        table.remove(vehicleJumpedEndRemoveCallbacks, i)
        table.remove(vehicleJumpedEndedCallbacks, j)
        break
      end
    end
  end
  for i, callback in ripairs(vehicleJumpedEndedCallbacks) do
    callback(scoringJumpedCar)
  end
end
local ProfileVehicleJumpCallback = function(scoringJumpedCar)
  ProfileSettings.SetNumVehiclesJumpedOver(ProfileSettings.GetNumVehiclesJumpedOver() + 1)
end
registerVehicleJumpedEndedCallback(ProfileVehicleJumpCallback)
local JumpOffVehicleCallbacks = {}
function setMinimumJumpOffPlayerSpeed(value)
  scoringSystem.jumpOffMinPlayerSpeed = value
end
function setMinimumJumpOffRelativeSpeed(value)
  scoringSystem.jumpOffMinRelativeSpeed = value
end
function registerJumpOffVehicleCallback(callback)
  if callback then
    table.insert(JumpOffVehicleCallbacks, #JumpOffVehicleCallbacks + 1, callback)
  else
  end
end
function unregisterJumpOffVehicleCallback(callback)
  if callback then
    local remove = false
    for i, storedCallback in ipairs(JumpOffVehicleCallbacks) do
      if storedCallback == callback then
        remove = i
        break
      end
    end
    if not remove then
    else
      table.remove(JumpOffVehicleCallbacks, remove)
    end
  else
  end
end
function _G.scoringJumpedOffVehicle(scoringJumpedOffVehicle)
  for i, callback in ripairs(JumpOffVehicleCallbacks) do
    callback(scoringJumpedOffVehicle)
  end
end
local ridingCarStartedCallbacks = {}
function registerRidingCarStartedCallback(callback)
  if callback then
    table.insert(ridingCarStartedCallbacks, #ridingCarStartedCallbacks + 1, callback)
  else
  end
end
function unregisterRidingCarStartedCallback(callback)
  if callback then
    local remove = false
    for i, storedCallback in ipairs(ridingCarStartedCallbacks) do
      if storedCallback == callback then
        remove = i
        break
      end
    end
    if not remove then
    else
      table.remove(ridingCarStartedCallbacks, remove)
    end
  else
  end
end
function _G.scoringRidingCarStarted(scoringRidingCar)
  for i, callback in ripairs(ridingCarStartedCallbacks) do
    callback(scoringRidingCar)
  end
end
local ProfileRampTruckJumpCallback = function(scoringRidingCar)
  if scoringRidingCar.VehicleID == 298 then
    ProfileSettings.SetNumRampTruckJumps(ProfileSettings.GetNumRampTruckJumps() + 1)
  end
end
registerRidingCarStartedCallback(ProfileRampTruckJumpCallback)
local ridingCarEndedCallbacks = {}
function registerRidingCarEndedCallback(callback)
  if callback then
    table.insert(ridingCarEndedCallbacks, #ridingCarEndedCallbacks + 1, callback)
  else
  end
end
function unregisterRidingCarEndedCallback(callback)
  if callback then
    local remove = false
    for i, storedCallback in ipairs(ridingCarEndedCallbacks) do
      if storedCallback == callback then
        remove = i
        break
      end
    end
    if not remove then
    else
      table.remove(ridingCarEndedCallbacks, remove)
    end
  else
  end
end
function _G.scoringRidingCarEnded(scoringRidingCar)
  for i, callback in ripairs(ridingCarEndedCallbacks) do
    callback(scoringRidingCar)
  end
end
local barrelRollCallbacks = {}
function registerBarrelRollCallback(callback)
  if callback then
    table.insert(barrelRollCallbacks, #barrelRollCallbacks + 1, callback)
  else
  end
end
function unregisterBarrelRollCallback(callback)
  if callback then
    local remove = false
    for i, storedCallback in ipairs(barrelRollCallbacks) do
      if storedCallback == callback then
        remove = i
        break
      end
    end
    if not remove then
    else
      table.remove(barrelRollCallbacks, remove)
    end
  else
  end
end
function _G.scoringBarrelRoll(scoringBarrelRoll)
  for i, callback in ripairs(barrelRollCallbacks) do
    callback(scoringRidingCar)
  end
end
local spinTurnCallbacks = {}
function registerSpinTurnCallback(callback)
  if callback then
    table.insert(spinTurnCallbacks, #spinTurnCallbacks + 1, callback)
  else
  end
end
function unregisterSpinTurnCallback(callback)
  if callback then
    local remove = false
    for i, storedCallback in ipairs(spinTurnCallbacks) do
      if storedCallback == callback then
        remove = i
        break
      end
    end
    if not remove then
    else
      table.remove(spinTurnCallbacks, remove)
    end
  else
  end
end
function _G.scoringSpinTurn(scoringSpinTurn)
  for i, callback in ripairs(spinTurnCallbacks) do
    callback(scoringSpinTurn)
  end
end
local underTrailerCallbacks = {}
local underTrailerRemoveCallbacks = {}
function registerUnderTrailerCallback(callback)
  if callback then
    table.insert(underTrailerCallbacks, #underTrailerCallbacks + 1, callback)
  else
  end
end
function unregisterUnderTrailerCallback(callback)
  if callback then
    for i, storedCallback in ipairs(underTrailerCallbacks) do
      if storedCallback == callback then
        table.insert(underTrailerRemoveCallbacks, #underTrailerRemoveCallbacks + 1, callback)
        break
      end
    end
  else
  end
end
function _G.scoringPlayerUnderTrailer(scoringPlayerUnderTrailer)
  for i, storedCallback in ripairs(underTrailerRemoveCallbacks) do
    for j, callback in ripairs(underTrailerCallbacks) do
      if storedCallback == callback then
        table.remove(underTrailerRemoveCallbacks, i)
        table.remove(underTrailerCallbacks, j)
        break
      end
    end
  end
  for i, callback in ripairs(underTrailerCallbacks) do
    callback(scoringPlayerUnderTrailer)
  end
end
local underTrailerExitCallbacks = {}
local underTrailerExitRemoveCallbacks = {}
function registerUnderTrailerExitCallback(callback)
  if callback then
    table.insert(underTrailerExitCallbacks, #underTrailerExitCallbacks + 1, callback)
  else
  end
end
function unregisterUnderTrailerExitCallback(callback)
  if callback then
    for i, storedCallback in ipairs(underTrailerExitCallbacks) do
      if storedCallback == callback then
        table.insert(underTrailerExitRemoveCallbacks, #underTrailerExitRemoveCallbacks + 1, callback)
        break
      end
    end
  else
  end
end
function _G.scoringPlayerUnderTrailerExit(scoringPlayerUnderTrailerExit)
  for i, storedCallback in ripairs(underTrailerExitRemoveCallbacks) do
    for j, callback in ripairs(underTrailerExitCallbacks) do
      if storedCallback == callback then
        table.remove(underTrailerExitRemoveCallbacks, i)
        table.remove(underTrailerExitCallbacks, j)
        break
      end
    end
  end
  for i, callback in ripairs(underTrailerExitCallbacks) do
    callback(scoringPlayerUnderTrailerExit)
  end
end
local jTurnCallbacks = {}
function registerJTurnCallback(callback)
  if callback then
    table.insert(jTurnCallbacks, #jTurnCallbacks + 1, callback)
  else
  end
end
function unregisterJTurnCallback(callback)
  if callback then
    local remove = false
    for i, storedCallback in ipairs(jTurnCallbacks) do
      if storedCallback == callback then
        remove = i
        break
      end
    end
    if not remove then
    else
      table.remove(jTurnCallbacks, remove)
    end
  else
  end
end
function _G.scoringJTurn(scoringJTurn)
  for i, callback in ripairs(jTurnCallbacks) do
    callback(scoringJTurn)
  end
end
local handbrakeTurnCallbacks = {}
function registerHandbrakeTurnCallback(callback)
  if callback then
    table.insert(handbrakeTurnCallbacks, #handbrakeTurnCallbacks + 1, callback)
  else
  end
end
function unregisterHandbrakeTurnCallback(callback)
  if callback then
    local remove = false
    for i, storedCallback in ipairs(handbrakeTurnCallbacks) do
      if storedCallback == callback then
        remove = i
        break
      end
    end
    if not remove then
    else
      table.remove(handbrakeTurnCallbacks, remove)
    end
  else
  end
end
function _G.scoringHandbrakeTurn(scoringHandbrakeTurn)
  for i, callback in ripairs(handbrakeTurnCallbacks) do
    callback(scoringHandbrakeTurn)
  end
end
local burnOutCallbacks = {}
function registerBurnOutCallback(callback)
  if callback then
    table.insert(burnOutCallbacks, #burnOutCallbacks + 1, callback)
    scoringSystem.burnOutCheckEnabled = true
  else
  end
end
function unregisterBurnOutCallback(callback)
  if callback then
    local remove = false
    for i, storedCallback in ipairs(burnOutCallbacks) do
      if storedCallback == callback then
        remove = i
        break
      end
    end
    if not remove then
    else
      table.remove(burnOutCallbacks, remove)
    end
  else
  end
  if table.isEmpty(burnOutCallbacks) then
    scoringSystem.burnOutCheckEnabled = false
  end
end
function _G.scoringBurnout(scoringBurnout)
  local player = localPlayerManager.players[0]
  local self = player.scoring
  for i, callback in ripairs(burnOutCallbacks) do
    callback(scoringBurnout)
  end
end
