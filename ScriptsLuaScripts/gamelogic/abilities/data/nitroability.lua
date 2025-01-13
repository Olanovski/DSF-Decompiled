module("abilities", package.seeall)
nitro = {}
local active = false
nitro.settings = {
  requiredPoints = 0,
  pointDegradeRate = 100,
  nitroThrust = 1.5,
  topSpeedIncrement = 2.5,
  heatUpTime = -1,
  attackTime = 0.05,
  decayTime = 0.05,
  releaseTime = 0.05,
  coolDownTime = 0.05,
  pressureMax = 1.5,
  tractionTweak = 0.2,
  cameraDistanceMax = 3,
  cameraDistanceSustain = 2,
  cameraFovMax = 20,
  cameraShakeScale = 0.05
}
function nitro.setLevel(level)
  active = level and 1
  if not localPlayer.inZap then
    localPlayer.controllerInterface:resetCallbacks()
  end
end
function nitro.getLevel()
  return abilities.abilitiesEnabled and active
end
function nitro.isActive()
  return active
end
local localPlayer
local timeAtNitroStart = 0
local previousTimeAtNitroStart = 0
local minimumSpeed = 0
local maxJumpHeight = 1.5
local maxJumpDistance = 5
function nitro:abilityFunction(callback, localID)
  local player = localPlayerManager.players[localID]
  if player:getAbilityAvailable("nitro") and player.currentVehicle.gameVehicle.speedAlongHeading >= minimumSpeed then
    local AbilityActivated = AbilityController.startAbility("nitro", callback, localID)
    if AbilityActivated then
      scoreSystem.decreaseAbility(player, getAbilityCostValue("nitro"))
      scoreSystem.activeAbilityIcon(localID)
      timeAtNitroStart = g_NetworkTime
      ProfileSettings.SetNumTimesBoostTriggered(ProfileSettings.GetNumTimesBoostTriggered() + 1)
    end
    return AbilityActivated
  end
end
function nitro:stopAbilityFunction(localID)
  local totalBoostTime = g_NetworkTime - timeAtNitroStart
  ProfileSettings.SetLongestBoostDuration(math.max(ProfileSettings.GetLongestBoostDuration(), totalBoostTime))
  if previousTimeAtNitroStart ~= timeAtNitroStart then
    ProfileSettings.SetTotalBoostTime(ProfileSettings.GetTotalBoostTime() + totalBoostTime)
    previousTimeAtNitroStart = timeAtNitroStart
  end
  localPlayerManager.players[localID].controllerInterface.releaseTime = g_NetworkTime
  return AbilityController.stopAbility("nitro", localID)
end
function nitro:stepAbilityFunction(localID)
  localPlayer = localPlayerManager.players[localID]
  if not gameStatus.simulationPaused then
    if not scoreSystem.enoughAbilityToUseNitro(localID) or localPlayer.inZap or localPlayer.selfRighting or self.damage >= 1 or self.gameVehicle.towingVehicle or localPlayer.scoring.isJumping and (localPlayer.scoring.heightCovered > maxJumpHeight or localPlayer.scoring.distanceCovered > maxJumpDistance) then
      self:cancelAbility(localID)
    elseif getUseDurationBoost() and g_NetworkTime - timeAtNitroStart > 5 then
      self:stopAbility(localID)
    end
  end
end
function nitro:cancelAbilityFunction(localID)
  localPlayerManager.players[localID].controllerInterface.releaseTime = g_NetworkTime
  return AbilityController.cancelAbility("nitro", localID)
end
function nitro.applySettings()
  local settings = AbilityController.getAbilitySettings("nitro")
  for k, v in next, nitro.settings, nil do
    settings[k] = v
  end
end
function TweakNitroRequiredPoints(nitroRequiredPointsVal)
  print("Old Value: " .. tostring(nitro.settings.requiredPoints))
  nitro.settings.requiredPoints = nitroRequiredPointsVal
  local settings = AbilityController.getAbilitySettings("nitro")
  settings.requiredPoints = nitroRequiredPointsVal
  print("New Value: " .. tostring(settings.requiredPoints))
end
function TweakNitroPointDegradeRate(nitroRequiredPointDegradeRateVal)
  print("Old Value: " .. tostring(nitro.settings.pointDegradeRate))
  nitro.settings.pointDegradeRate = nitroRequiredPointDegradeRateVal
  local settings = AbilityController.getAbilitySettings("nitro")
  settings.pointDegradeRate = nitroRequiredPointDegradeRateVal
  print("New Value: " .. tostring(settings.pointDegradeRate))
end
function TweakNitroThrust(nitroThrustVal)
  print("Old Value: " .. tostring(nitro.settings.nitroThrust))
  nitro.settings.nitroThrust = nitroThrustVal
  local settings = AbilityController.getAbilitySettings("nitro")
  settings.nitroThrust = nitroThrustVal
  print("New Value: " .. tostring(nitro.settings.nitroThrust))
end
function TweakNitroTopSpeedIncrement(nitroTopSpeedVal)
  print("Old Value: " .. tostring(nitro.settings.topSpeedIncrement))
  nitro.settings.topSpeedIncrement = nitroTopSpeedVal
  local settings = AbilityController.getAbilitySettings("nitro")
  settings.topSpeedIncrement = nitroTopSpeedVal
  print("New Value: " .. tostring(settings.topSpeedIncrement))
end
function TweakNitroPressureMax(nitroPressureMaxVal)
  print("Old Value: " .. tostring(nitro.settings.pressureMax))
  nitro.settings.pressureMax = nitroPressureMaxVal
  local settings = AbilityController.getAbilitySettings("nitro")
  settings.pressureMax = nitroPressureMaxVal
  print("New Value: " .. tostring(settings.pressureMax))
end
function TweakNitroCameraDistanceMax(nitroCameraDistanceMaxVal)
  print("Old Value: " .. tostring(nitro.settings.cameraDistanceMax))
  nitro.settings.cameraDistanceMax = nitroCameraDistanceMaxVal
  local settings = AbilityController.getAbilitySettings("nitro")
  settings.cameraDistanceMax = nitroCameraDistanceMaxVal
  print("New Value: " .. tostring(settings.cameraDistanceMax))
end
function TweakNitroCameraFovMax(nitroCameraFovMaxVal)
  print("Old Value: " .. tostring(nitro.settings.cameraFovMax))
  nitro.settings.cameraFovMax = nitroCameraFovMaxVal
  local settings = AbilityController.getAbilitySettings("nitro")
  settings.cameraFovMax = nitroCameraFovMaxVal
  print("New Value: " .. tostring(settings.cameraFovMax))
end
function TweakNitroCameraDistanceSustain(nitroCameraDistanceSustainVal)
  print("Old Value: " .. tostring(nitro.settings.cameraDistanceSustain))
  nitro.settings.cameraDistanceSustain = nitroCameraDistanceSustainVal
  local settings = AbilityController.getAbilitySettings("nitro")
  settings.cameraDistanceSustain = nitroCameraDistanceSustainVal
  print("New Value: " .. tostring(settings.cameraDistanceSustain))
end
function TweakNitroCameraShakeScale(nitroCameraShakeScaleVal)
  print("Old Value: " .. tostring(nitro.settings.cameraShakeScale))
  nitro.settings.cameraShakeScale = nitroCameraShakeScaleVal
  local settings = AbilityController.getAbilitySettings("nitro")
  settings.cameraShakeScale = nitroCameraShakeScaleVal
  print("New Value: " .. tostring(settings.cameraShakeScale))
end
function TweakNitroHeatUpTime(nitroHeatUpTimeVal)
  print("Old Value: " .. tostring(nitro.settings.heatUpTime))
  nitro.settings.heatUpTime = nitroHeatUpTimeVal
  local settings = AbilityController.getAbilitySettings("nitro")
  settings.heatUpTime = nitroHeatUpTimeVal
  print("New Value: " .. tostring(settings.heatUpTime))
end
function TweakNitroAttackTime(nitroAttackTimeVal)
  print("Old Value: " .. tostring(nitro.settings.attackTime))
  nitro.settings.attackTime = nitroAttackTimeVal
  local settings = AbilityController.getAbilitySettings("nitro")
  settings.attackTime = nitroAttackTimeVal
  print("New Value: " .. tostring(settings.attackTime))
end
function TweakNitroDecayTime(nitroDecayTimeVal)
  print("Old Value: " .. tostring(nitro.settings.decayTime))
  nitro.settings.decayTime = nitroDecayTimeVal
  local settings = AbilityController.getAbilitySettings("nitro")
  settings.decayTime = nitroDecayTimeVal
  print("New Value: " .. tostring(settings.decayTime))
end
function TweakNitroReleaseTime(nitroReleaseTimeVal)
  print("Old Value: " .. tostring(nitro.settings.releaseTime))
  nitro.settings.releaseTime = nitroReleaseTimeVal
  local settings = AbilityController.getAbilitySettings("nitro")
  settings.releaseTime = nitroReleaseTimeVal
  print("New Value: " .. tostring(settings.releaseTime))
end
function TweakNitroCoolDownTime(nitroCoolDownTimeVal)
  print("Old Value: " .. tostring(nitro.settings.coolDownTime))
  nitro.settings.coolDownTime = nitroCoolDownTimeVal
  local settings = AbilityController.getAbilitySettings("nitro")
  settings.coolDownTime = nitroCoolDownTimeVal
  print("New Value: " .. tostring(settings.coolDownTime))
end
function PrintNitroValues()
  print("requiredPoints: " .. tostring(nitro.settings.requiredPoints))
  print("pointDegradeRate: " .. tostring(nitro.settings.pointDegradeRate))
  print("nitroThrust: " .. tostring(nitro.settings.nitroThrust))
  print("topSpeedIncrement: " .. tostring(nitro.settings.topSpeedIncrement))
  print("heatUpTime: " .. tostring(nitro.settings.heatUpTime))
  print("attackTime: " .. tostring(nitro.settings.attackTime))
  print("decayTime: " .. tostring(nitro.settings.decayTime))
  print("releaseTime: " .. tostring(nitro.settings.releaseTime))
  print("coolDownTime: " .. tostring(nitro.settings.coolDownTime))
  print("pressureMax: " .. tostring(nitro.settings.pressureMax))
  print("cameraDistanceMax: " .. tostring(nitro.settings.cameraDistanceMax))
  print("cameraDistanceSustain: " .. tostring(nitro.settings.cameraDistanceSustain))
  print("cameraFovMax: " .. tostring(nitro.settings.cameraFovMax))
  print("cameraShakeScale: " .. tostring(nitro.settings.cameraShakeScale))
end
