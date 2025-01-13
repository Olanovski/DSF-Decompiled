module("zapWeaponSupport", package.seeall)
local zapWeaponCooldownDefault = 45
local zapWeaponCooldownUpgrade = 40
local zapWeaponCooldown = zapWeaponCooldownDefault
local lastZapWeaponFired = 0
local zapWeaponsEnabled = false
local updateZapWeaponCooldown = false
local zapWeaponFuel = 0
local numberWeaponsActive = 0
local zapWeaponFuelPause = false
local firedDelayActive = false
local chargeDelay = 1
local availableWeapons = {
  swap = 1,
  impulse = 1,
  spawn = 1,
  take = 1
}
onlineWeaponCosts = {
  [1] = {success = 0.5},
  [2] = {success = 1, fail = 0.5},
  [3] = {success = 0.5},
  [4] = {success = 1}
}
function getZapWeaponCooldown()
  return zapWeaponCooldown
end
function getZapWeaponCharge()
  return zapWeaponFuel
end
function getAreWeaponsEnabled()
  return zapWeaponsEnabled
end
function areZapWeaponsAvailable()
  return zapWeaponsEnabled and not updateZapWeaponCooldown and zapWeaponFuel >= zapWeaponCooldown and not firedDelayActive
end
function setSwapSpawnUnavailableFeedback()
  if numberWeaponsActive > 2 then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon03_State", 0)
  end
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon01_State", 0)
end
function setZapWeaponFireTime(failed, weapon)
  local function startCharge()
    if g_NetworkTime - startDelayTime > chargeDelay then
      lastZapWeaponFired = g_NetworkTime
      updateZapWeaponCooldown = true
      if failed then
        assert(onlineWeaponCosts[weapon].fail, "Weapon has no fail costs. weapon: = " .. tostring(weapon))
        zapWeaponFuel = zapWeaponCooldown - zapWeaponCooldown * onlineWeaponCosts[weapon].fail
      else
        assert(onlineWeaponCosts[weapon].success, "Weapon has no success costs. weapon: = " .. tostring(weapon))
        zapWeaponFuel = zapWeaponCooldown - zapWeaponCooldown * onlineWeaponCosts[weapon].success
      end
      feedbackSystem.menusMaster.onlineHUDSetVariable("iWeapons_Charge_Display", 1)
      OneShotSound.Play("MP_Weapon_Charging")
      firedDelayActive = false
      availableWeapons.swap = 0
      availableWeapons.impulse = 0
      availableWeapons.spawn = 0
      availableWeapons.take = 0
      removeUserUpdateFunction("startCharge")
    end
  end
  addUserUpdateFunction("startCharge", startCharge, 1)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon01_State", 0)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon02_State", 0)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon03_State", 0)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon04_State", 0)
  OneShotSound.Play("MP_Weapon_StateUsed")
  firedDelayActive = true
  startDelayTime = g_NetworkTime
end
function enableZapWeapons(enabled)
  zapWeaponsEnabled = enabled
  if enabled then
    lastZapWeaponFired = g_NetworkTime
    if zapWeaponFuel < zapWeaponCooldown then
      feedbackSystem.menusMaster.onlineHUDSetVariable("iWeapons_Charge_Display", 1)
      OneShotSound.Play("MP_Weapon_Charging")
      updateZapWeaponCooldown = true
      firedDelayActive = false
    else
      feedbackSystem.menusMaster.onlineHUDSetVariable("iWeapons_Charge_Display", 2)
      updateZapWeaponCooldown = false
      firedDelayActive = false
    end
  else
    feedbackSystem.menusMaster.onlineHUDSetVariable("iWeapons_Charge", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iWeapons_Charge_Display", 0)
    removeUserUpdateFunction("startCharge")
    zap.zapSwap.overideSwapCancel = false
  end
end
function resetZapWeapons()
  availableWeapons.swap = 1
  availableWeapons.impulse = 1
  availableWeapons.spawn = 1
  availableWeapons.take = 1
  lastZapWeaponFired = 0
  zapWeaponsEnabled = false
  updateZapWeaponCooldown = false
  zapWeaponFuel = 0
  firedDelayActive = false
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon01_State", 1)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon02_State", 1)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon03_State", 1)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon04_State", 1)
  zap.zapSwap.reset()
  zap.zapSpawn.reset()
end
function paused()
  lastZapWeaponFired = g_NetworkTime
  updateZapWeaponCooldown = true
  firedDelayActive = false
  zapWeaponFuel = 0
  feedbackSystem.menusMaster.onlineHUDSetVariable("iWeapons_Charge_Display", 1)
end
function pauseZapWeaponFuel(pause)
  zapWeaponFuelPause = pause
  if not pause then
    lastZapWeaponFired = g_NetworkTime
  end
end
local debugColour = vec.vector(0.75, 0.21, 0.75, 1)
local debugPos8 = vec.vector(0.6, 0.26, 0, 1)
function displayZapWeaponCooldown()
  if zapWeaponFuelPause then
    return
  end
  if zapWeaponsEnabled and updateZapWeaponCooldown then
    if g_NetworkTime - lastZapWeaponFired > 0.1 then
      zapWeaponFuel = zapWeaponFuel + (g_NetworkTime - lastZapWeaponFired)
      lastZapWeaponFired = g_NetworkTime
    end
    if zapWeaponFuel > zapWeaponCooldown then
      zapWeaponFuel = zapWeaponCooldown
    end
    if zapWeaponFuel / zapWeaponCooldown ~= 1 then
      feedbackSystem.menusMaster.onlineHUDSetVariable("iWeapons_Charge", zapWeaponFuel / zapWeaponCooldown * 100)
    else
      feedbackSystem.menusMaster.onlineHUDSetVariable("iWeapons_Charge_Display", 2)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iWeapons_Charge", 0)
      updateZapWeaponCooldown = false
    end
    if phaseManager.modeDebugInfo then
      Development:add2DText(3111, "Zap Weapon Cooldown Time: " .. tostring(zapWeaponCooldown) .. " CURRENT TIME:" .. tostring(zapWeaponFuel), debugPos8, debugColour, 0.75, 4)
    end
  end
end
function setZapWeaponCooldownTime(cooldownTime)
  zapWeaponCooldown = cooldownTime
end
function setZapWeaponCooldownDefault()
  zapWeaponCooldown = zapWeaponCooldownDefault
end
function setZapWeaponCooldownUpgraded()
  zapWeaponCooldown = zapWeaponCooldownUpgrade
end
function resetZapWeaponCooldown()
  if onlineProgressionSystem.onlineUpgradeData[6].unlocked then
    zapWeaponCooldown = zapWeaponCooldownUpgrade
  else
    zapWeaponCooldown = zapWeaponCooldownDefault
  end
end
function setZapWeaponFuel(fuel)
  zapWeaponFuel = fuel
  if zapWeaponFuel > zapWeaponCooldown then
    zapWeaponFuel = zapWeaponCooldown
  end
end
function setWeaponDefaultValue(value)
  zapWeaponCooldownDefault = value
  zapWeaponCooldown = value
end
function setWeaponUpgradeValue(value)
  zapWeaponCooldownUpgrade = value
end
function setNumberAvailableWeapons(numOfWeapons)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMultiplayer_WeaponsAvailable", numOfWeapons)
  numberWeaponsActive = numOfWeapons
end
function updateAvailableWeaponDisplay()
  if areZapWeaponsAvailable() then
    if not localPlayer.inZap then
      if availableWeapons.impulse ~= 0 and numberWeaponsActive > 1 then
        availableWeapons.impulse = 0
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon02_State", 0)
      end
      if availableWeapons.spawn ~= 0 and numberWeaponsActive > 2 then
        availableWeapons.spawn = 0
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon03_State", 0)
      end
      if availableWeapons.take ~= 0 and numberWeaponsActive > 3 then
        availableWeapons.take = 0
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon04_State", 0)
      end
      if localPlayer.blockedAbilities.ZapSwap and availableWeapons.swap ~= 0 then
        availableWeapons.swap = 0
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon01_State", 0)
      elseif not localPlayer.blockedAbilities.ZapSwap and availableWeapons.swap ~= 1 then
        availableWeapons.swap = 1
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon01_State", 1)
      end
    else
      if localPlayer.blockedAbilities.ZapSwap and availableWeapons.swap ~= 0 then
        availableWeapons.swap = 0
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon01_State", 0)
      elseif not localPlayer.blockedAbilities.ZapSwap and availableWeapons.swap ~= 1 then
        availableWeapons.swap = 1
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon01_State", 1)
      end
      if localPlayer.blockedAbilities.ZapImpulse and availableWeapons.impulse ~= 0 and numberWeaponsActive > 1 or not localPlayer.blockedAbilities.ZapImpulse and availableWeapons.impulse ~= 0 and numberWeaponsActive > 1 and 1 < zapcontroller.getZapLevel(0) then
        availableWeapons.impulse = 0
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon02_State", 0)
      elseif not localPlayer.blockedAbilities.ZapImpulse and availableWeapons.impulse ~= 1 and numberWeaponsActive > 1 and zapcontroller.getZapLevel(0) == 1 then
        availableWeapons.impulse = 1
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon02_State", 1)
      end
      if localPlayer.blockedAbilities.ZapSpawn and availableWeapons.spawn ~= 0 and numberWeaponsActive > 2 then
        availableWeapons.spawn = 0
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon03_State", 0)
      elseif not localPlayer.blockedAbilities.ZapSpawn and availableWeapons.spawn ~= 1 and numberWeaponsActive > 2 then
        availableWeapons.spawn = 1
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon03_State", 1)
      end
      if localPlayer.blockedAbilities.ZapAttack and availableWeapons.take ~= 0 and numberWeaponsActive > 3 or not localPlayer.blockedAbilities.ZapAttack and availableWeapons.take ~= 0 and numberWeaponsActive > 3 and 1 < zapcontroller.getZapLevel(0) then
        availableWeapons.take = 0
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon04_State", 0)
      elseif not localPlayer.blockedAbilities.ZapAttack and availableWeapons.take ~= 1 and numberWeaponsActive > 3 and zapcontroller.getZapLevel(0) == 1 then
        availableWeapons.take = 1
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Weapon04_State", 1)
      end
    end
  end
end
zapAttackData = {}
function unlimitedAbilityPoints(value)
  zapAttackData.unlimitedAbilityPoints = value
  scoreSystem.increaseAbility(localPlayer, 1200)
end
