module("onlineProgressionSystem", package.seeall)
onlineWeaponData = {
  [1] = {
    name = "ID:232340",
    unlocked = false,
    new = false,
    showTutorialMessage = false,
    image = "unlock_swap",
    button = function()
      return tonumber(buttonsTable[localPlayer.buttonLayout.vehicleSwap.button])
    end,
    description = "ID:232352",
    instruction = "ID:232353",
    unlockFunc = function()
      abilities.ZapSwap.setLevel(true)
      ActiveVehicles.setUnlockedSlots(1)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMultiplayer_VehiclesAvailable", 1)
      zapWeaponSupport.setNumberAvailableWeapons(1)
    end,
    resetFunc = function()
      abilities.ZapSwap.setLevel(false)
      ActiveVehicles.setUnlockedSlots(0)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMultiplayer_VehiclesAvailable", 0)
      zapWeaponSupport.setNumberAvailableWeapons(0)
    end
  },
  [2] = {
    name = "ID:232338",
    unlocked = false,
    new = false,
    showTutorialMessage = false,
    image = "unlock_impulse",
    button = function()
      return tonumber(buttonsTable[localPlayer.buttonLayout.zapSelect.button])
    end,
    description = "ID:232346",
    instruction = "ID:232347",
    unlockFunc = function()
      abilities.ZapImpulse.setLevel(0)
      zapWeaponSupport.setNumberAvailableWeapons(2)
    end,
    resetFunc = function()
      abilities.ZapImpulse.setLevel(false)
      zapWeaponSupport.setNumberAvailableWeapons(1)
    end
  },
  [3] = {
    name = "ID:232341",
    button = function()
      return tonumber(buttonsTable[localPlayer.buttonLayout.vehicleSwap.button])
    end,
    unlocked = false,
    new = false,
    showTutorialMessage = false,
    image = "unlock_spawn",
    description = "ID:232350",
    instruction = "ID:232351",
    unlockFunc = function()
      abilities.ZapSpawn.setLevel(0)
      zapWeaponSupport.setNumberAvailableWeapons(3)
    end,
    resetFunc = function()
      abilities.ZapSpawn.setLevel(false)
      zapWeaponSupport.setNumberAvailableWeapons(2)
    end
  },
  [4] = {
    name = "ID:232339",
    unlocked = false,
    new = false,
    showTutorialMessage = false,
    image = "unlock_attack",
    button = function()
      return tonumber(buttonsTable[localPlayer.buttonLayout.zapSelect.button])
    end,
    description = "ID:232348",
    instruction = "ID:232349",
    unlockFunc = function()
      abilities.zapAttack.setLevel(0)
      zapWeaponSupport.setNumberAvailableWeapons(4)
    end,
    resetFunc = function()
      abilities.zapAttack.setLevel(false)
      zapWeaponSupport.setNumberAvailableWeapons(3)
    end
  }
}
function onlineGetNumberOfWeapons()
  return #onlineWeaponData
end
_G.onlineGetNumberOfWeapons = onlineGetNumberOfWeapons
function onlineGetWeaponName(index)
  if onlineWeaponData[index] then
    return onlineWeaponData[index].name
  end
  return "INVALID WEAPON INDEX - GET NAME"
end
_G.onlineGetWeaponName = onlineGetWeaponName
function onlineIsWeaponUnlocked(index)
  if onlineWeaponData[index] then
    return onlineWeaponData[index].unlocked
  end
  print("WEAPON INDEX " .. tostring(index) .. " IS NOT VALID")
  return false
end
_G.onlineIsWeaponUnlocked = onlineIsWeaponUnlocked
function onlineIsWeaponNewlyUnlocked(index)
  if onlineWeaponData[index] then
    return onlineWeaponData[index].new
  end
  print("WEAPON " .. tostring(index) .. " IS NOT VALID")
  return false
end
_G.onlineIsWeaponNewlyUnlocked = onlineIsWeaponNewlyUnlocked
function onlineShouldShowWeaponTutorialMsg(index)
  if onlineWeaponData[index] then
    return onlineWeaponData[index].showTutorialMessage
  end
  print("WEAPON " .. tostring(index) .. " IS NOT VALID")
  return false
end
function onlineShouldShowAnyWeaponTutorialMsg(index)
  return onlineShouldShowWeaponTutorialMsg(2) or onlineShouldShowWeaponTutorialMsg(1) or onlineShouldShowWeaponTutorialMsg(3)
end
_G.onlineShouldShowAnyWeaponTutorialMsg = onlineShouldShowAnyWeaponTutorialMsg
function onlineIsAnyWeaponNewlyUnlocked()
  for i, pack in ipairs(onlineWeaponData) do
    if onlineIsWeaponNewlyUnlocked(i) == true then
      return true
    end
  end
  return false
end
_G.onlineIsAnyWeaponNewlyUnlocked = onlineIsAnyWeaponNewlyUnlocked
function onlineWeaponClearNew(index)
  if onlineWeaponData[index] then
    onlineWeaponData[index].new = false
  end
  print("WEAPON " .. tostring(index) .. " IS NOT VALID")
end
_G.onlineWeaponClearNew = onlineWeaponClearNew
function onlineWeaponClearShowTutorialMsg(index)
  if onlineWeaponData[index] then
    onlineWeaponData[index].showTutorialMessage = false
  end
  print("WEAPON " .. tostring(index) .. " IS NOT VALID")
end
function onlineIsWeaponTutorialNew(index)
  return false
end
_G.onlineIsWeaponTutorialNew = onlineIsWeaponTutorialNew
function onlineIsAnyWeaponTutorialNew()
  return false
end
_G.onlineIsAnyWeaponTutorialNew = onlineIsAnyWeaponTutorialNew
function onlineWeaponTutorialClearNew(index)
end
_G.onlineWeaponTutorialClearNew = onlineWeaponTutorialClearNew
function onlineGetWeaponLevel(index)
  local level = 0
  return level
end
_G.onlineGetWeaponLevel = onlineGetWeaponLevel
function onlineGetNumWeaponOfLevels(index)
  return 0
end
_G.onlineGetNumWeaponOfLevels = onlineGetNumWeaponOfLevels
function getWeaponLevelRequirement(index)
  return getLevelRequirementForUnlock(onlineWeaponData, index)
end
_G.getWeaponLevelRequirement = getWeaponLevelRequirement
function onlineGetWeaponDescription(index)
  if onlineWeaponData[index] then
    return onlineWeaponData[index].description
  end
  return "NO DESCRIPTION - NO WEAPON OR INVALID INDEX"
end
_G.onlineGetWeaponDescription = onlineGetWeaponDescription
function onlineGetWeaponInstruction(index)
  if onlineWeaponData[index] then
    return onlineWeaponData[index].instruction
  end
  return "NO DESCRIPTION - NO WEAPON OR INVALID INDEX"
end
_G.onlineGetWeaponInstruction = onlineGetWeaponInstruction
function onlineGetWeaponButton(index)
  if onlineWeaponData[index] and onlineWeaponData[index].button then
    return onlineWeaponData[index].button()
  end
  return 0
end
_G.onlineGetWeaponButton = onlineGetWeaponButton
