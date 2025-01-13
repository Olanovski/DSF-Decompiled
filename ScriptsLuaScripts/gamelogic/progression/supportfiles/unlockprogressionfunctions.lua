local unlockedAbilities = {}
local maxAbilityLevel = 2
toolTipLookupTable = {
  ["Garage tutorial"] = 0,
  ["Activity"] = 1,
  ["Dare"] = 2,
  ["Challenge"] = 3,
  ["Movie Challenge"] = 4,
  ["City Mission"] = 5,
  ["Purchased a vehicle"] = 6,
  ["Completed a dare"] = 7,
  ["Willpower tutorial"] = 8,
  ["Reached Finale"] = 9
}
function loadAbilitiesFromProfile()
  print("LOAD ABILITIES FROM PROFILE")
  if gameStatus.onlineSession then
    abilities.zap.setLevel(1)
    for i = 0, maxAbilityLevel do
      abilities.aerialZap.setLevel(i)
    end
  else
    for slot, ability in next, abilities.abilityList, nil do
      for i = 0, maxAbilityLevel do
        if ProfileSettings.GetAbilityOwned(slot, i) == 1 then
          abilities[ability].setLevel(i)
        end
      end
    end
  end
end
function isAbilityUnlocked(ability, level)
  return abilities[ability].getLevel()
end
function abilityUnlockCheck(chapter, daresCompleted)
  local unlocks = false
  local levels = false
  if chapter then
    if abilities.abilityUnlocksByChapter[chapter] then
      for __, unlock in ipairs(abilities.abilityUnlocksByChapter[chapter]) do
        if abilities.testUnlockRequisites(abilities.abilityList[unlock.ID], unlock.Tier - 1) and not ProfileSettings.GetAbilityUnlocked(unlock.ID, unlock.Tier - 1) then
          ProfileSettings.SetAbilityUnlocked(unlock.ID, unlock.Tier - 1)
          unlocks = unlocks or {}
          levels = levels or {}
          table.insert(unlocks, unlock.ID)
          table.insert(levels, unlock.Tier - 1)
        end
      end
    end
  elseif daresCompleted and abilities.abilityUnlocksByDares[daresCompleted] then
    for __, unlock in ipairs(abilities.abilityUnlocksByDares[daresCompleted]) do
      if abilities.testUnlockRequisites(abilities.abilityList[unlock.ID], unlock.Tier - 1) and not ProfileSettings.GetAbilityUnlocked(unlock.ID, unlock.Tier - 1) then
        ProfileSettings.SetAbilityUnlocked(unlock.ID, unlock.Tier - 1)
        unlocks = unlocks or {}
        levels = levels or {}
        table.insert(unlocks, unlock.ID)
        table.insert(levels, unlock.Tier - 1)
      end
    end
  end
  if unlocks then
    local upgradeText = "ID:245772"
    if #unlocks == 1 then
      upgradeText = abilities.gadgetNames[abilities.abilityList[unlocks[1]]]
    end
    feedbackSystem.menusMaster.queueUnlockPanel("gadget", "ability", "ability", unlocks, levels, nil, upgradeText, "ID:245770")
  end
end
function setMaxZapLevel(maxZapLevel)
  local zapLevel = abilities.zap.getLevel()
  local aerialZapLevel = abilities.aerialZap.getLevel()
  if zapLevel and aerialZapLevel then
    local unlockedLevel = math.max(zapLevel, aerialZapLevel)
    local maxAllowedLevel = math.min(unlockedLevel, maxZapLevel)
    zap.setZapRadiusLevel(maxAllowedLevel)
  end
end
function isWillpowerEnabled()
  return unlockProgressionTable.willpowerEnabled
end
function enableWillpower(status)
  scoringSystem.enableFeedback = status
  unlockProgressionTable.willpowerEnabled = status
end
function enableAbilities(localID, status)
  abilities.setEnabled(status)
  if status then
    if gameStatus.onlineSession or isAbilityUnlocked("nitro") or isAbilityUnlocked("ram") then
      scoreSystem.stopAbilityGain(localID, false)
      scoreSystem.showAbilityFeedback(localID, true)
    end
  else
    scoreSystem.stopAbilityGain(localID, true)
    scoreSystem.showAbilityFeedback(localID, false)
  end
end
function forceZap(status)
  unlockProgressionTable.forceZap = status
end
function isCityLockingEnabled()
  return unlockProgressionTable.cityLocking
end
function enableCityLocking(status)
  if status ~= false and configSelector.launchConfig.enableProgression and not gameStatus.onlineSession then
    if status == "completelyUnlocked" then
      CityLockManager.CityLockActive = false
    else
      unlockProgressionTable.cityLocking = status
      CityLockManager.CityLockState = status
      CityLockManager.CityLockActive = true
    end
  elseif status == "completelyUnlocked" then
    CityLockManager.CityLockActive = false
  else
    unlockProgressionTable.cityLocking = "CityLockingLevel4"
    CityLockManager.CityLockState = "CityLockingLevel4"
    CityLockManager.CityLockActive = true
  end
end
local newZapLevelPromptStart = 2
local newZapLevelPromptEnd = 7
local startTime = g_NetworkTime
local newZapPromptOn = false
function isZapLevel()
  return unlockProgressionTable.zapLevelSetting
end
function enableZapAttack(status)
  zapcontroller.SetZapAttackAllow(status, 0)
end
