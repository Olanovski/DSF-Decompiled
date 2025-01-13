module("abilities", package.seeall)
abilitiesEnabled = true
abilityList = {
  [0] = "nitro",
  [1] = "ram",
  [2] = "abilityBarUpgrade",
  [3] = "abilityBarRecharge",
  [5] = "collectableDetection",
  [6] = "moneyBags",
  [7] = "thrillCam",
  [8] = "zap",
  [9] = "aerialZap",
  [10] = "zapReturn",
  [11] = "ZapSwap",
  [12] = "ZapImpulse",
  [13] = "ZapSpawn",
  [14] = "zapAttack"
}
abilitySlots = {}
for slot, ability in next, abilityList, nil do
  abilitySlots[ability] = slot
end
preRequisites = {
  abilityBarUpgrade = {nitro = true, ram = true},
  abilityBarRecharge = {nitro = true, ram = true}
}
abilityNames = {
  zap = "ID:234282",
  nitro = "ID:234283",
  zapReturn = "ID:234286",
  aerialZap = "ID:234282",
  ram = "ID:234284",
  abilityBarUpgrade = "ID:234280"
}
gadgetNames = {
  abilityBarUpgrade = "ID:243999",
  abilityBarRecharge = "ID:244004",
  collectableDetection = "ID:244001",
  moneyBags = "ID:244002",
  thrillCam = "ID:244003"
}
abilityUnlocksByChapter = {}
abilityUnlocksByDares = {}
abilityUnlocksByID = {}
for k, unlock in next, abilityPrices, nil do
  if unlock.UnlockedInChapter then
    if not abilityUnlocksByChapter[unlock.UnlockedInChapter] then
      abilityUnlocksByChapter[unlock.UnlockedInChapter] = {}
    end
    table.insert(abilityUnlocksByChapter[unlock.UnlockedInChapter], unlock)
  elseif unlock.UnlockedByDare then
    if not abilityUnlocksByDares[unlock.UnlockedByDare] then
      abilityUnlocksByDares[unlock.UnlockedByDare] = {}
    end
    table.insert(abilityUnlocksByDares[unlock.UnlockedByDare], unlock)
  end
  if not abilityUnlocksByID[unlock.ID] then
    abilityUnlocksByID[unlock.ID] = {}
  end
  table.insert(abilityUnlocksByID[unlock.ID], unlock)
end
function testUnlockRequisites(ability, level)
  local allowed = false
  if level == 0 then
    if preRequisites[ability] then
      for requiredAbility, __ in next, preRequisites[ability], nil do
        if ProfileSettings.GetAbilityOwned(abilitySlots[requiredAbility], 0) == 1 then
          allowed = true
        end
      end
    else
      allowed = true
    end
  elseif ProfileSettings.GetAbilityOwned(abilitySlots[ability], level - 1) == 1 then
    allowed = true
  end
  return allowed
end
constants = {
  single = {
    useDurationBoost = false,
    allowRamOnDrift = true,
    gain = {
      drift = 0,
      overtake = 0,
      oncoming = 0,
      jump = 0
    },
    minimumPoints = {nitro = 10, ram = 20},
    cost = {nitro = 0, ram = 20},
    hold = {
      nitro = {
        [1] = 60,
        [2] = 38,
        [3] = 32,
        [4] = 28
      },
      ram = 8
    },
    holdDecayRate = {nitro = 0, ram = 0},
    holdDecayMin = {nitro = 0, ram = 0}
  },
  multiplayer = {
    useDurationBoost = true,
    allowRamOnDrift = false,
    gain = {
      drift = 0,
      overtake = 0,
      oncoming = 0,
      jump = 0
    },
    minimumPoints = {nitro = 51, ram = 51},
    cost = {nitro = 25, ram = 25},
    hold = {nitro = 0, ram = 0},
    holdDecayRate = {nitro = 0.1, ram = 0},
    holdDecayMin = {nitro = 0.7, ram = 1}
  },
  splitscreen = {
    useDurationBoost = false,
    allowRamOnDrift = true,
    gain = {
      drift = 0,
      overtake = 0,
      oncoming = 0,
      jump = 0
    },
    minimumPoints = {nitro = 10, ram = 10},
    cost = {nitro = 0, ram = 10},
    hold = {nitro = 32, ram = 0},
    holdDecayRate = {nitro = 0, ram = 0},
    holdDecayMin = {nitro = 1, ram = 1}
  }
}
local abilitySettings = constants.single
function setEnabled(status)
  abilitiesEnabled = status
end
function getEnabled()
  return abilitiesEnabled
end
function getAbilityGainValue(ability)
  return abilitySettings.gain[ability]
end
function getPointsToUseAbility(ability)
  return abilitySettings.minimumPoints[ability]
end
function getAbilityCostValue(ability)
  return abilitySettings.cost[ability]
end
function getAbilityHoldValue(ability)
  if ability == "nitro" and type(abilitySettings.hold[ability]) == "table" then
    local abilityLevel = abilityBarUpgrade.getLevel()
    if not abilityLevel then
      return abilitySettings.hold[ability][1]
    elseif abilityLevel == 120 then
      return abilitySettings.hold[ability][2]
    elseif abilityLevel == 140 then
      return abilitySettings.hold[ability][3]
    elseif abilityLevel == 160 then
      return abilitySettings.hold[ability][4]
    end
  else
    return abilitySettings.hold[ability]
  end
end
function getAbilityHoldDecayRate(ability)
  return abilitySettings.holdDecayRate[ability]
end
function getAbilityHoldDecayMin(ability)
  return abilitySettings.holdDecayMin[ability]
end
function getUseDurationBoost()
  return abilitySettings.useDurationBoost
end
function getAllowRamOnDrift()
  return abilitySettings.allowRamOnDrift
end
function setAbilityMode(mode)
  if constants[mode] then
    abilitySettings = constants[mode]
  end
end
