module("collectables", package.seeall)
local collectablesPerChallenge = getTokensRequiredPerChallenge()
local timeLastTokenCollected = 0
local timeBeforeSave = 0.5
function updateCollectableUnlocks(chapter)
  if collectableLookupTable[chapter] then
    for uid, token in next, collectableLookupTable[chapter], nil do
      if token.position and not ProfileSettings.GetCollectableOwned(token.uid) then
        ProfileSettings.SetCollectableUnlocked(token.uid)
        activeChallenges.registerActivity(token, "Token")
        if abilities.collectableDetection.getLevel() == math.huge then
          showAbilityIcon(token, true)
        end
      end
    end
  end
end
function showIcon(token, show)
  if show then
    token.iconIndex = feedbackSystem.newTarget(token, "Token In World")
  elseif token.iconIndex then
    feedbackSystem.clearTarget(token.iconIndex)
    token.iconIndex = nil
  end
end
function showAbilityIcon(token, show)
  if show then
    if not token.minimapIndex then
      token.minimapIndex = feedbackSystem.newTarget(token, "Token Minimap")
    end
  elseif token.minimapIndex then
    feedbackSystem.clearTarget(token.minimapIndex)
    token.minimapIndex = nil
  end
end
function setAbilityRadius(radius)
  if radius == math.huge then
    for uid, token in next, collectablesByUID, nil do
      if ProfileSettings.GetCollectableUnlocked(uid) and not ProfileSettings.GetCollectableOwned(uid) then
        showAbilityIcon(token, true)
      end
    end
  else
    activeChallenges.updateProximityRadii("Token", radius)
  end
end
local function triggerAutoSave()
  if g_NetworkTime >= timeBeforeSave + timeLastTokenCollected then
    progressionSystem.saveGame("When you collect a token")
    removeUserUpdateFunction("collectableSave")
  end
end
local function saveCollection(uid)
  ProfileSettings.SetCollectableOwned(uid)
  timeLastTokenCollected = g_NetworkTime
  addUserUpdateFunction("collectableSave", triggerAutoSave, 2)
end
local progressTable = {
  type = "movie",
  total = collectablesPerChallenge,
  message = "ID:245785"
}
function collectToken(token)
  if not ProfileSettings.GetCollectableOwned(token.uid) then
    incrementTokensCollected()
    local collected = getTokensCollected()
    saveCollection(token.uid)
    scoreSystem.willpowerReward(willpowerRewards.token[token.chapter], "Token")
    activeChallenges.removeActivity(token, true)
    OneShotSound.Play("HUD_Gen_TokenPickup_OneShot", false)
    local collectedInThisSet = math.mod(collected, collectablesPerChallenge)
    if collectedInThisSet == 0 then
      progressTable.current = collectablesPerChallenge
      local unlock = collected / collectablesPerChallenge
      if challengeLookupTable.movie[unlock] then
        for __, challenge in ipairs(challengeLookupTable.movie[unlock]) do
          local networkID = cards.ReverseMissionNetworkLookup[challenge.ID]
          ProfileSettings.SetChallengeUnlocked(networkID, false, true)
          progressTable.iconid = unlockPanelIconLookup[challenge.iconType]
          progressTable.title = missionInfo[networkID].challengeTitle
          shop.purchaseChallenge(networkID, progressTable)
        end
      end
    else
      progressTable.current = collectedInThisSet
      feedbackSystem.menusMaster.queueUnlockPanel("progress", "token", "token", token.uid, nil, progressTable, "TOKEN COLLECTED", "")
    end
  end
end
