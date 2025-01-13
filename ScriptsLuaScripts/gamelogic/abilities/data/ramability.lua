module("abilities", package.seeall)
ram = {}
local active = false
ram.settings = {
  requiredPoints = 0,
  pointDegradeRate = 10,
  ramsPerFullBar = 6,
  minimumCharge = 0,
  maxRamChargeTime = 1.5,
  targetDamageScale = 1.2,
  extraSpeed = 30,
  ramTime = 0.4,
  speedCoeficient = 0.5,
  cameraShakeScale = 0.02,
  cameraMaxZoomOutDistance = 2,
  stabilityDamping = 0.1,
  minSpeedToTrigger = 5,
  allowedHopDistance = 5,
  parachuteTime = 2.5,
  chargeAcceleration = 0.25
}
function ram.setLevel(level)
  active = level and 1
  if not localPlayer.inZap then
    localPlayer.controllerInterface:resetCallbacks()
  end
end
function ram.getLevel()
  return abilities.abilitiesEnabled and active
end
local localPlayer
local maxJumpHeight = 1.5
local maxJumpDistance = 5
local ramCallbackFunction = false
function ram.applySettings()
  local settings = AbilityController.getAbilitySettings("ram")
  for k, v in next, ram.settings, nil do
    settings[k] = v
  end
end
local ramStates = {
  [0] = 0,
  [1] = 0
}
local function ramCallback(rammedGameVehicle, iLocalPlayerIndex, iNewState)
  scoreSystem.stopAbilityGain(iLocalPlayerIndex, false)
  ramStates[iLocalPlayerIndex] = iNewState
  if ramCallbackFunction then
    if rammedGameVehicle then
      ramCallbackFunction(rammedGameVehicle)
    else
      ramCallbackFunction()
    end
  end
  if iNewState == 0 then
    local player = playerManager.players[iLocalPlayerIndex]
    if player and player.currentVehicle and player.currentVehicle.activeAbilityName == "ram" then
      player.currentVehicle:stopAbilityInternal(iLocalPlayerIndex)
    end
  end
end
function ram.registerCallback(f)
  ramCallbackFunction = f
end
function ram.unregisterCallback()
  ramCallbackFunction = nil
end
function ram.getState(playerID)
  return ramStates[playerID]
end
function ram:abilityFunction(callback, localID)
  local player = localPlayerManager.players[localID]
  if player:getAbilityAvailable("ram") then
    local cost = getAbilityCostValue("ram")
    if cost <= player.abilityPoints then
      local AbilityActivated = AbilityController.startAbility("ram", ramCallback, localID)
      if AbilityActivated then
        scoreSystem.decreaseAbility(player, cost)
        scoreSystem.stopAbilityGain(localID, true)
      end
      return AbilityActivated
    end
  end
  return false
end
function ram:stopAbilityFunction(localID)
  localPlayerManager.players[localID].controllerInterface.releaseTime = g_NetworkTime
  return AbilityController.stopAbility("ram", localID)
end
function ram:stepAbilityFunction(localID)
  localPlayer = localPlayerManager.players[localID]
  if not getAllowRamOnDrift() and localPlayer.scoring.isDrifting then
    self:cancelAbility(localID)
  elseif localPlayer.currentVehicle.beingTowed then
    self:cancelAbility(localID)
  elseif localPlayer.scoring.isJumping and (localPlayer.scoring.heightCovered > maxJumpHeight or localPlayer.scoring.distanceCovered > maxJumpDistance) then
    self:cancelAbility(localID)
  elseif scoreSystem.getAbility(localID) <= 0 then
    AbilityController.stopChargingRamBoost(localID)
  end
end
function ram:cancelAbilityFunction(localID)
  localPlayerManager.players[localID].controllerInterface.releaseTime = g_NetworkTime
  return AbilityController.cancelAbility("ram", localID)
end
function TweakRamRequiredPoints(ramRequiredPointsVal)
  print("Old Value: " .. tostring(ram.settings.requiredPoints))
  ram.settings.requiredPoints = ramRequiredPointsVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.requiredPoints = ramRequiredPointsVal
  print("New Value: " .. tostring(settings.requiredPoints))
end
function TweakRamPointDegradeRate(ramRequiredPointDegradeRateVal)
  print("Old Value: " .. tostring(ram.settings.pointDegradeRate))
  ram.settings.pointDegradeRate = ramRequiredPointDegradeRateVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.pointDegradeRate = ramRequiredPointDegradeRateVal
  print("New Value: " .. tostring(settings.pointDegradeRate))
end
function TweakRamsPerFullBar(ramsPerFullBarVal)
  print("Old Value: " .. tostring(ram.settings.ramsPerFullBar))
  ram.settings.ramsPerFullBar = ramsPerFullBarVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.ramsPerFullBar = ramsPerFullBarVal
  print("New Value: " .. tostring(settings.ramsPerFullBar))
end
function TweakRamMinimumCharge(ramMinimumChargeVal)
  print("Old Value: " .. tostring(ram.settings.minimumCharge))
  ram.settings.minimumCharge = ramMinimumChargeVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.minimumCharge = ramMinimumChargeVal
  print("New Value: " .. tostring(settings.minimumCharge))
end
function TweakRamMaxRamChargeTime(ramMaxRamChargeTimeVal)
  print("Old Value: " .. tostring(ram.settings.maxRamChargeTime))
  ram.settings.maxRamChargeTime = ramMaxRamChargeTimeVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.maxRamChargeTime = ramMaxRamChargeTimeVal
  print("New Value: " .. tostring(settings.maxRamChargeTime))
end
function TweakRamTargetDamageScale(ramTargetDamageScaleVal)
  print("Old Value: " .. tostring(ram.settings.targetDamageScale))
  ram.settings.targetDamageScale = ramTargetDamageScaleVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.targetDamageScale = ramTargetDamageScaleVal
  print("New Value: " .. tostring(settings.targetDamageScale))
end
function TweakRamMassMultiplier(ramMassMultiplierVal)
  print("Old Value: " .. tostring(ram.settings.massMultiplier))
  ram.settings.massMultiplier = ramMassMultiplierVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.massMultiplier = ramMassMultiplierVal
  print("New Value: " .. tostring(settings.massMultiplier))
end
function TweakRamExtraSpeed(ramExtraSpeedVal)
  print("Old Value: " .. tostring(ram.settings.extraSpeed))
  ram.settings.extraSpeed = ramExtraSpeedVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.extraSpeed = ramExtraSpeedVal
  print("New Value: " .. tostring(settings.extraSpeed))
end
function TweakRamTime(ramTimeVal)
  print("Old Value: " .. tostring(ram.settings.ramTime))
  ram.settings.ramTime = ramTimeVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.ramTime = ramTimeVal
  print("New Value: " .. tostring(settings.ramTime))
end
function TweakRamDamageScale(ramDamageScaleVal)
  print("Old Value: " .. tostring(ram.settings.damageScale))
  ram.settings.damageScale = ramDamageScaleVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.damageScale = ramDamageScaleVal
  print("New Value: " .. tostring(settings.damageScale))
end
function TweakRamSteeringLimiter(ramSteeringLimiterVal)
  print("Old Value: " .. tostring(ram.settings.steeringLimiter))
  ram.settings.steeringLimiter = ramSteeringLimiterVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.steeringLimiter = ramSteeringLimiterVal
  print("New Value: " .. tostring(settings.steeringLimiter))
end
function TweakRamSpeedCoeficientScale(ramSpeedCoeficientVal)
  print("Old Value: " .. tostring(ram.settings.speedCoeficient))
  ram.settings.speedCoeficient = ramSpeedCoeficientVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.speedCoeficient = ramSpeedCoeficientVal
  print("New Value: " .. tostring(settings.speedCoeficient))
end
function TweakRamCameraShakeScale(ramCameraShakeScaleVal)
  print("Old Value: " .. tostring(ram.settings.cameraShakeScale))
  ram.settings.cameraShakeScale = ramStabilityVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.cameraShakeScale = ramCameraShakeScaleVal
  print("New Value: " .. tostring(settings.cameraShakeScale))
end
function TweakRamCameraMaxZoomOutDistance(ramCameraMaxZoomOutDistanceVal)
  print("Old Value: " .. tostring(ram.settings.cameraMaxZoomOutDistance))
  ram.settings.cameraMaxZoomOutDistance = ramCameraMaxZoomOutDistanceVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.cameraMaxZoomOutDistance = ramCameraMaxZoomOutDistanceVal
  print("New Value: " .. tostring(settings.cameraMaxZoomOutDistance))
end
function TweakRamStability(ramStabilityVal)
  print("Old Value: " .. tostring(ram.settings.stabilityDamping))
  ram.settings.stabilityDamping = ramStabilityVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.stabilityDamping = ramStabilityVal
  print("New Value: " .. tostring(settings.stabilityDamping))
end
function TweakRamChargeAcceleration(ramChargeAccelerationVal)
  print("Old Value: " .. tostring(ram.settings.chargeAcceleration))
  ram.settings.chargeAcceleration = ramChargeAccelerationVal
  local settings = AbilityController.getAbilitySettings("ram")
  settings.chargeAcceleration = ramChargeAccelerationVal
  print("New Value: " .. tostring(settings.chargeAcceleration))
end
function PrintRamValues()
  print("requiredPoints: " .. tostring(ram.settings.requiredPoints))
  print("pointDegradeRate: " .. tostring(ram.settings.pointDegradeRate))
  print("ramsPerFullBar: " .. tostring(ram.settings.ramsPerFullBar))
  print("minimumCharge: " .. tostring(ram.settings.minimumCharge))
  print("maxRamChargeTime: " .. tostring(ram.settings.maxRamChargeTime))
  print("targetDamageScale: " .. tostring(ram.settings.targetDamageScale))
  print("massMultiplier: " .. tostring(ram.settings.massMultiplier))
  print("extraSpeed: " .. tostring(ram.settings.extraSpeed))
  print("ramTime: " .. tostring(ram.settings.ramTime))
  print("damageScale: " .. tostring(ram.settings.damageScale))
  print("steeringLimiter: " .. tostring(ram.settings.steeringLimiter))
  print("speedCoeficient: " .. tostring(ram.settings.speedCoeficient))
  print("cameraShakeScale: " .. tostring(ram.settings.cameraShakeScale))
  print("cameraMaxZoomOutDistance: " .. tostring(ram.settings.cameraMaxZoomOutDistance))
  print("stabilityDamping: " .. tostring(ram.settings.stabilityDamping))
  print("chargeAcceleration: " .. tostring(ram.settings.chargeAcceleration))
end
