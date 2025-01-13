module("onlineProgressionSystem", package.seeall)
onlineUpgradeData = {
  [1] = {
    name = "ID:214346",
    button = function()
      return tonumber(buttonsTable[localPlayer.buttonLayout.vehicleSlot2.button])
    end,
    unlocked = false,
    balancing = false,
    new = false,
    image = "unlock_vehicle_slot",
    description = "ID:232364",
    instruction = "ID:232365",
    unlockFunc = function()
      ActiveVehicles.setUnlockedSlots(2)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMultiplayer_VehiclesAvailable", 2)
    end,
    resetFunc = function()
      ActiveVehicles.setUnlockedSlots(1)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMultiplayer_VehiclesAvailable", 1)
    end
  },
  [2] = {
    name = "ID:214347",
    unlocked = false,
    balancing = true,
    new = false,
    image = "unlock_ability_bar",
    description = "ID:232354",
    instruction = "ID:232355",
    unlockFunc = function()
      abilities.abilityBarUpgrade.setLevel(0, localPlayer.localID)
    end,
    resetFunc = function()
      scoreSystem.setAbilityBarCapacity(localPlayer.localID, abilities.abilityBarUpgrade.getMaxAbilityForLevel(1))
    end
  },
  [3] = {
    name = "ID:214348",
    unlocked = false,
    balancing = true,
    new = false,
    image = "unlock_ability_bar_2",
    description = "ID:232356",
    instruction = "ID:232357",
    unlockFunc = function()
      abilities.abilityBarUpgrade.setLevel(1, localPlayer.localID)
    end,
    resetFunc = function()
      abilities.abilityBarUpgrade.setLevel(0, localPlayer.localID)
    end
  },
  [4] = {
    name = "ID:214349",
    unlocked = false,
    balancing = true,
    new = false,
    image = "unlock_ability_bar_3",
    description = "ID:232358",
    instruction = "ID:232359",
    unlockFunc = function()
      abilities.abilityBarUpgrade.setLevel(2, localPlayer.localID)
    end,
    resetFunc = function()
      abilities.abilityBarUpgrade.setLevel(1, localPlayer.localID)
    end
  },
  [5] = {
    name = "ID:214350",
    unlocked = false,
    balancing = true,
    new = false,
    image = "unlock_ability_charge",
    description = "ID:232362",
    instruction = "ID:232363",
    unlockFunc = function()
      zap.multiplayerSettings.setOnlineZapFuelLevel(2)
      scoreSystem.maxAbility(localPlayer.localID)
    end,
    resetFunc = function()
      zap.multiplayerSettings.setOnlineZapFuelLevel(1)
      scoreSystem.maxAbility(localPlayer.localID)
    end
  },
  [6] = {
    name = "ID:214356",
    unlocked = false,
    balancing = false,
    new = false,
    image = "unlock_weapon_charge",
    description = "ID:232360",
    instruction = "ID:232361",
    unlockFunc = function()
      zapWeaponSupport.setZapWeaponCooldownUpgraded()
    end,
    resetFunc = function()
      zapWeaponSupport.setZapWeaponCooldownDefault()
    end
  }
}
function onlineIsUpgradeNewlyUnlocked(index)
  if onlineUpgradeData[index] then
    return onlineUpgradeData[index].new
  end
  print("UPGRADE " .. tostring(index) .. " IS NOT VALID")
  return false
end
_G.onlineIsUpgradeNewlyUnlocked = onlineIsUpgradeNewlyUnlocked
function onlineIsAnyUpgradeNewlyUnlocked()
  for i, pack in ipairs(onlineUpgradeData) do
    if onlineIsUpgradeNewlyUnlocked(i) == true then
      return true
    end
  end
  return false
end
_G.onlineIsAnyUpgradeNewlyUnlocked = onlineIsAnyUpgradeNewlyUnlocked
function onlineUpgradeClearNew(index)
  if onlineUpgradeData[index] then
    onlineUpgradeData[index].new = false
    return true
  end
  print("UPGRADE " .. tostring(index) .. " IS NOT VALID")
  return false
end
_G.onlineUpgradeClearNew = onlineUpgradeClearNew
function onlineIsCarSlotTwoUnlocked()
  return onlineUpgradeData[1].unlocked
end
_G.onlineIsCarSlotTwoUnlocked = onlineIsCarSlotTwoUnlocked
function onlineIsCarSlotTwoNewlyUnlocked()
  return onlineUpgradeData[1].new
end
_G.onlineIsCarSlotTwoNewlyUnlocked = onlineIsCarSlotTwoNewlyUnlocked
function onlineCarSlotTwoClearNew()
  onlineUpgradeData[1].new = false
end
_G.onlineCarSlotTwoClearNew = onlineCarSlotTwoClearNew
function onlineGetCarSlotTwoLevelRequirement()
  return getLevelRequirementForUnlock(onlineUpgradeData, 1)
end
_G.onlineGetCarSlotTwoLevelRequirement = onlineGetCarSlotTwoLevelRequirement
function onlineGetNumAbilityBarUpgrades()
  return 3
end
_G.onlineGetNumAbilityBarUpgrades = onlineGetNumAbilityBarUpgrades
function onlineIsAbilityUpgradeUnlocked(upgradeNum)
  local numUpgrades = onlineGetNumAbilityBarUpgrades()
  if upgradeNum > numUpgrades then
    return false
  end
  return onlineUpgradeData[upgradeNum + 1].unlocked
end
_G.onlineIsAbilityUpgradeUnlocked = onlineIsAbilityUpgradeUnlocked
function onlineIsAbilityUpgradeNewlyUnlocked(upgradeNum)
  local numUpgrades = onlineGetNumAbilityBarUpgrades()
  if upgradeNum > numUpgrades then
    return false
  end
  return onlineUpgradeData[upgradeNum + 1].new
end
_G.onlineIsAbilityUpgradeNewlyUnlocked = onlineIsAbilityUpgradeNewlyUnlocked
function onlineGetAbilityUpgradeLevelRequirement(upgradeNum)
  local numUpgrades = onlineGetNumAbilityBarUpgrades()
  if upgradeNum > numUpgrades then
    return -1
  end
  return getLevelRequirementForUnlock(onlineUpgradeData, upgradeNum + 1)
end
_G.onlineGetAbilityUpgradeLevelRequirement = onlineGetAbilityUpgradeLevelRequirement
function onlineIsZapFuelUpgradeUnlocked()
  return onlineUpgradeData[5].unlocked
end
_G.onlineIsZapFuelUpgradeUnlocked = onlineIsZapFuelUpgradeUnlocked
function onlineIsZapFuelUpgradeNewlyUnlocked()
  return onlineUpgradeData[5].new
end
_G.onlineIsZapFuelUpgradeNewlyUnlocked = onlineIsZapFuelUpgradeNewlyUnlocked
function onlineGetZapFuelUpgradeLevelRequirement()
  return getLevelRequirementForUnlock(onlineUpgradeData, 5)
end
_G.onlineGetZapFuelUpgradeLevelRequirement = onlineGetZapFuelUpgradeLevelRequirement
function onlineIsWeaponFuelUpgradeUnlocked()
  return onlineUpgradeData[6].unlocked
end
_G.onlineIsWeaponFuelUpgradeUnlocked = onlineIsWeaponFuelUpgradeUnlocked
function onlineIsWeaponFuelUpgradeNewlyUnlocked()
  return onlineUpgradeData[6].new
end
_G.onlineIsWeaponFuelUpgradeNewlyUnlocked = onlineIsWeaponFuelUpgradeNewlyUnlocked
function onlineGetWeaponFuelUpgradeLevelRequirement()
  return getLevelRequirementForUnlock(onlineUpgradeData, 6)
end
_G.onlineGetWeaponFuelUpgradeLevelRequirement = onlineGetWeaponFuelUpgradeLevelRequirement
function onlineGetAbilityUpgradeDescription(upgradeNum)
  local numUpgrades = onlineGetNumAbilityBarUpgrades()
  if upgradeNum > numUpgrades then
    return "NO DESCRIPTION - NO ABILITY UPGRADE OR INVALID INDEX"
  end
  return onlineUpgradeData[upgradeNum + 1].description
end
_G.onlineGetAbilityUpgradeDescription = onlineGetAbilityUpgradeDescription
function onlineGetAbilityUpgradeInstruction(upgradeNum)
  local numUpgrades = onlineGetNumAbilityBarUpgrades()
  if upgradeNum > numUpgrades then
    return "NO DESCRIPTION - NO ABILITY UPGRADE OR INVALID INDEX"
  end
  return onlineUpgradeData[upgradeNum + 1].instruction
end
_G.onlineGetAbilityUpgradeInstruction = onlineGetAbilityUpgradeInstruction
function onlineGetCarSlotTwoDescription()
  return onlineUpgradeData[1].description
end
_G.onlineGetCarSlotTwoDescription = onlineGetCarSlotTwoDescription
function onlineGetCarSlotTwoInstruction()
  return onlineUpgradeData[1].instruction
end
_G.onlineGetCarSlotTwoInstruction = onlineGetCarSlotTwoInstruction
function onlineGetCarSlotTwoButton()
  return onlineUpgradeData[1].button()
end
_G.onlineGetCarSlotTwoButton = onlineGetCarSlotTwoButton
function onlineGetZapFuelUpgradeDescription()
  return onlineUpgradeData[5].description
end
_G.onlineGetZapFuelUpgradeDescription = onlineGetZapFuelUpgradeDescription
function onlineGetZapFuelUpgradeInstruction()
  return onlineUpgradeData[5].instruction
end
_G.onlineGetZapFuelUpgradeInstruction = onlineGetZapFuelUpgradeInstruction
function onlineGetWeaponFuelUpgradeDescription()
  return onlineUpgradeData[6].description
end
_G.onlineGetWeaponFuelUpgradeDescription = onlineGetWeaponFuelUpgradeDescription
function onlineGetWeaponFuelUpgradeInstruction()
  return onlineUpgradeData[6].instruction
end
_G.onlineGetWeaponFuelUpgradeInstruction = onlineGetWeaponFuelUpgradeInstruction
function onlineGetNumberOfUpgrades()
  return #onlineUpgradeData
end
_G.onlineGetNumberOfUpgrades = onlineGetNumberOfUpgrades
function onlineGetUpgradeName(index)
  if onlineUpgradeData[index] then
    return onlineUpgradeData[index].name
  end
  return "INVALID ABILITY INDEX - GET NAME"
end
_G.onlineGetUpgradeName = onlineGetUpgradeName
function onlineIsUpgradeUnlocked(index)
  if onlineUpgradeData[index] then
    return onlineUpgradeData[index].unlocked
  end
  print("ABILITY INDEX " .. tostring(index) .. " IS NOT VALID")
  return false
end
_G.onlineIsUpgradeUnlocked = onlineIsUpgradeUnlocked
function getUpgradeLevelRequirement(index)
  return getLevelRequirementForUnlock(onlineUpgradeData, index)
end
_G.getUpgradeLevelRequirement = getUpgradeLevelRequirement
function onlineGetUpgradeDescription(index)
  if onlineUpgradeData[index] then
    return onlineUpgradeData[index].description
  end
  return "NO DESCRIPTION - NO WEAPON OR INVALID INDEX"
end
_G.onlineGetUpgradeDescription = onlineGetUpgradeDescription
function onlineGetUpgradeInstruction(index)
  if onlineUpgradeData[index] then
    return onlineUpgradeData[index].instruction
  end
  return "NO DESCRIPTION - NO WEAPON OR INVALID INDEX"
end
_G.onlineGetUpgradeInstruction = onlineGetUpgradeInstruction
function onlineGetUpgradeButton(index)
  if onlineUpgradeData[index] and onlineUpgradeData[index].button then
    return onlineUpgradeData[index].button()
  end
  return 0
end
_G.onlineGetUpgradeButton = onlineGetUpgradeButton
