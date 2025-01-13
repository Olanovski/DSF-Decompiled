module("shop", package.seeall)
local initialise = function()
  Shop.SetAbilities(abilityPrices)
end
addInitObject(initialise)
function getShopVehicles(vehicleID)
  return vehiclePrices[vehicleID]
end
_G.getShopVehicles = getShopVehicles
goalCallbacks = {}
function registerGoalCallback(callback, type)
  print("registerGoalCallback type = " .. type)
  goalCallbacks[type] = goalCallbacks[type] or {}
  goalCallbacks[type][#goalCallbacks[type] + 1] = callback
end
function unregisterGoalCallback(callback, type)
  print("unregisterGoalCallback type = " .. type)
  local remove = false
  for i, storedCallback in ipairs(goalCallbacks[type]) do
    if storedCallback == callback then
      remove = i
      break
    end
  end
  if remove then
    table.remove(goalCallbacks[type], remove)
  end
end
function purchaseVehicle(id)
  ProfileSettings.SetVehicleOwned(id)
  if not ProfileSettings.GetToolTipShown(toolTipLookupTable["Purchased a vehicle"]) then
    ProfileSettings.SetToolTipShown(toolTipLookupTable["Purchased a vehicle"])
  end
end
_G.purchaseVehicle = purchaseVehicle
function purchaseAbility(id, level, save)
  if abilities.abilityList[id] and abilities[abilities.abilityList[id]] then
    abilities[abilities.abilityList[id]].setLevel(level)
    if save then
      ProfileSettings.SetAbilityUnlocked(id, level)
      ProfileSettings.SetAbilityOwned(id, level)
    end
    if abilities.abilityList[id] == "nitro" or abilities.abilityList[id] == "ram" then
      enableAbilities(localPlayer.localID, true)
      scoreSystem.showAbilityFeedback(localPlayer.localID, true)
    end
    for i = 1, progressionSystem.getCurrentChapter() do
      abilityUnlockCheck(i, nil)
    end
    local daresCompleted = dareSystem.getNumberCompletedDares()
    for daresRequired, ability in next, abilities.abilityUnlocksByDares, nil do
      if daresRequired <= daresCompleted then
        abilityUnlockCheck(nil, daresRequired)
      end
    end
  end
end
_G.purchaseAbility = purchaseAbility
local activityTitles = {
  race = "ID:245786",
  action = "ID:245787",
  stunt = "ID:245788"
}
function purchaseChallenge(id, progressTable)
  ProfileSettings.SetChallengeOwned(id)
  local missionID = cards.MissionNetworkLookup[id]
  local mission, pot, missionSubtype, missionType = progressionSystem.findMissionInProgression(missionID)
  local iconType = mission.iconType
  local type = "Challenge"
  if activitiesLookupTable[missionType] then
    type = "Activity"
  end
  activeChallenges.registerActivity(mission, type)
  local title = missionInfo[id].challengeTitle
  if missionType == "activity" then
    title = activityTitles[missionSubtype]
  end
  if missionSubtype == "shop" then
    missionSubtype = "bonus"
  end
  feedbackSystem.menusMaster.queueUnlockPanel("city", missionSubtype, iconType, id, nil, progressTable, title, "ID:245785")
end
_G.purchaseChallenge = purchaseChallenge
function purchaseGarage(id)
  garage.purchaseGarage(id)
end
_G.purchaseGarage = purchaseGarage
