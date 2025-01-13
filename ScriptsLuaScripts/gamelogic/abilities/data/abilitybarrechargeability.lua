module("abilities", package.seeall)
abilityBarRecharge = {}
local active = false
abilityBarRecharge.settings = {
  [0] = 1.2,
  [1] = 1.4,
  [2] = 1.6
}
function abilityBarRecharge.setLevel(level, localID)
  if abilityBarRecharge.settings[level] then
    active = abilityBarRecharge.settings[level]
    scoreSystem.setAbilityBarRecharge(localID or localPlayer.localID, active)
  end
end
function abilityBarRecharge.getLevel()
  return active
end
