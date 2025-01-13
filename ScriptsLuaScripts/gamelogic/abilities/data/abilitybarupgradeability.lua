module("abilities", package.seeall)
abilityBarUpgrade = {}
local defaultCapacity = 100
local active = false
abilityBarUpgrade.settings = {
  [0] = 120,
  [1] = 140,
  [2] = 160
}
function abilityBarUpgrade.setLevel(level, localID)
  if abilityBarUpgrade.settings[level] then
    active = abilityBarUpgrade.settings[level]
    scoreSystem.setAbilityBarCapacity(localID, abilityBarUpgrade.settings[level])
    Sound.SetAbilityBarLevel(level, localID)
  end
end
function abilityBarUpgrade.getLevel()
  return active
end
function abilityBarUpgrade.getMaxAbilityForLevel(level)
  if level == 1 then
    return defaultCapacity
  else
    return abilityBarUpgrade.settings[level - 2]
  end
end
