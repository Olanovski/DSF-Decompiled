module("onlineProgressionSystem", package.seeall)
onlineAbilityData = {
  [1] = {
    name = "ID:214344",
    unlocked = false,
    balancing = true,
    new = false,
    image = "unlock_boost",
    description = "ID:232342",
    button = function()
      return tonumber(buttonsTable[localPlayer.buttonLayout.boostAbility.button])
    end,
    instruction = "ID:232343",
    unlockFunc = function()
      if not abilities.nitro.isActive() then
        abilities.nitro.setLevel(0)
      else
        localPlayer:blockAbility("nitro", false)
      end
    end,
    resetFunc = function()
      localPlayer:blockAbility("nitro", true)
    end
  }
}
function onlineGetNumberOfAbilities()
  return #onlineAbilityData
end
_G.onlineGetNumberOfAbilities = onlineGetNumberOfAbilities
function onlineGetAbilityName(index)
  if onlineAbilityData[index] then
    return onlineAbilityData[index].name
  end
  return "INVALID ABILITY INDEX - GET NAME"
end
_G.onlineGetAbilityName = onlineGetAbilityName
function onlineIsAbilityUnlocked(index)
  if onlineAbilityData[index] then
    return onlineAbilityData[index].unlocked
  end
  print("ABILITY INDEX " .. tostring(index) .. " IS NOT VALID")
  return false
end
_G.onlineIsAbilityUnlocked = onlineIsAbilityUnlocked
function onlineIsAbilityNewlyUnlocked(index)
  if onlineAbilityData[index] then
    return onlineAbilityData[index].new
  end
  print("ABILITY " .. tostring(index) .. " IS NOT VALID")
  return false
end
_G.onlineIsAbilityNewlyUnlocked = onlineIsAbilityNewlyUnlocked
function onlineIsAnyAbilityNewlyUnlocked()
  for i, pack in ipairs(onlineAbilityData) do
    if onlineIsAbilityNewlyUnlocked(i) == true then
      return true
    end
  end
  return false
end
_G.onlineIsAnyAbilityNewlyUnlocked = onlineIsAnyAbilityNewlyUnlocked
function onlineAbilityClearNew(index)
  if onlineAbilityData[index] then
    onlineAbilityData[index].new = false
    return true
  end
  print("ABILITY " .. tostring(index) .. " IS NOT VALID")
  return false
end
_G.onlineAbilityClearNew = onlineAbilityClearNew
function getAbilityLevelRequirement(index)
  return getLevelRequirementForUnlock(onlineAbilityData, index)
end
_G.getAbilityLevelRequirement = getAbilityLevelRequirement
function onlineGetAbilityDescription(index)
  if onlineAbilityData[index] then
    return onlineAbilityData[index].description
  end
  return "NO DESCRIPTION - NO WEAPON OR INVALID INDEX"
end
_G.onlineGetAbilityDescription = onlineGetAbilityDescription
function onlineGetAbilityInstruction(index)
  if onlineAbilityData[index] then
    return onlineAbilityData[index].instruction
  end
  return "NO DESCRIPTION - NO WEAPON OR INVALID INDEX"
end
_G.onlineGetAbilityInstruction = onlineGetAbilityInstruction
function onlineGetAbilityButton(index)
  if onlineAbilityData[index] and onlineAbilityData[index].button then
    return onlineAbilityData[index].button()
  end
  return 0
end
_G.onlineGetAbilityButton = onlineGetAbilityButton
