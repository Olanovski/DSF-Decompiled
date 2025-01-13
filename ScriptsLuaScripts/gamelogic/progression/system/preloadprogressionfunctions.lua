function generateReverseNetworkLookup()
  cards.ReverseMissionNetworkLookup = {}
  for i, data in ipairs(cards.MissionNetworkLookup) do
    missionInfo[i].networkID = i
    cards.ReverseMissionNetworkLookup[data] = i
  end
end
generateReverseNetworkLookup()
function hasSinglePlayerBeenStarted()
  local firstMission = challengeProgressionTable[1].storyMission[1].ID
  return ProfileSettings.GetMissionAttempted(cards.ReverseMissionNetworkLookup[firstMission])
end
local collected = false
local collectablesPerChallenge = 10
function initialiseCollected()
  collected = 0
  if collectablesByUID then
    for uid, token in next, collectablesByUID, nil do
      if ProfileSettings.GetCollectableOwned(token.uid) then
        incrementTokensCollected()
      end
    end
  end
end
function incrementTokensCollected()
  if not collected then
    initialiseCollected()
  end
  collected = collected + 1
end
function getTokensCollected()
  if not collected then
    initialiseCollected()
  end
  return collected
end
function getTokensRequiredPerChallenge()
  return collectablesPerChallenge
end
function getProgression()
  local getProgressionTable = {}
  for potNumber, pot in ipairs(challengeProgressionTable) do
    if pot.settings.chapter and pot.settings.chapter > 0 then
      local chapter = "chapter " .. pot.settings.chapter
      getProgressionTable[chapter] = getProgressionTable[chapter] or {}
      if pot.missions then
        for __, challenge in ipairs(pot.missions) do
          table.insert(getProgressionTable[chapter], missionInfo[cards.ReverseMissionNetworkLookup[challenge.ID]])
        end
      end
      if pot.tannerMission then
        getProgressionTable[chapter].tannerMission = getProgressionTable[chapter].tannerMission or {}
        for __, challenge in ipairs(pot.tannerMission) do
          table.insert(getProgressionTable[chapter].tannerMission, missionInfo[cards.ReverseMissionNetworkLookup[challenge.ID]])
        end
      end
      if pot.storyMission then
        getProgressionTable[chapter].storyMission = getProgressionTable[chapter].storyMission or {}
        for __, challenge in ipairs(pot.storyMission) do
          table.insert(getProgressionTable[chapter].storyMission, missionInfo[cards.ReverseMissionNetworkLookup[challenge.ID]])
        end
      end
    end
  end
  return getProgressionTable
end
function unlockAllMissions()
  ProfileSettings.SetChapter(9)
  ProfileSettings.SetProgression(#challengeProgressionTable)
  for potID, pot in ipairs(challengeProgressionTable) do
    for missionType, missions in next, pot, nil do
      for __, mission in ipairs(missions) do
        ProfileSettings.SetMissionCompleted(cards.ReverseMissionNetworkLookup[mission.ID], mission.statsMission)
      end
    end
  end
end
local images = {
  ["DowntownSprint"] = "challenge_header_DowntownSprint",
  ["GoldenGateCircuit"] = "challenge_header_GoldenGateCircuit",
  ["Offroad"] = "challenge_header_Offroad",
  ["FreewayFaceoff"] = "challenge_header_FreewayFaceoff",
  ["Deactivating bombs 2"] = "challenge_header_TickingClock",
  ["DriveToSurvive2"] = "challenge_header_DriveToSurvive",
  ["ChinatownDrift"] = "challenge_header_ChinatownDrift",
  ["Big break 2"] = "challenge_header_TheBigBreak",
  ["RallyFaceOff"] = "challenge_header_RallyFaceOff",
  ["Speed"] = "challenge_header_Speed",
  ["Handle challenge"] = "challenge_header_HandleWithCare",
  ["Charity 2"] = "challenge_header_ItsForCharity",
  ["Escape"] = "challenge_header_Escape",
  ["TheGetaway"] = "challenge_header_TheGetaway",
  ["RussianHillTakedown"] = "challenge_header_RussianHillTakedown",
  ["TheFreewayRun"] = "challenge_header_TheFreewayRun",
  ["CopOut"] = "challenge_header_CopOut",
  ["ItalianJob"] = "challenge_header_TheItalianJob",
  ["LuckyEscape"] = "challenge_header_LuckyEscape",
  ["SutroDrift"] = "challenge_header_SutroDrift",
  ["TheDriver"] = "challenge_header_TheDriver",
  ["MarinCopRun"] = "challenge_header_MarinCopRun",
  ["DownhillDrift"] = "challenge_header_BurningRubber",
  ["MarinEscape"] = "challenge_header_MarinEscape",
  ["Survival"] = "challenge_header_Survival",
  ["Car park"] = "challenge_header_BlastFromThePast",
  ["RelayRace"] = "challenge_header_RelayRace",
  ["Team colours tutorial"] = "challenge_header_RussianHillRacers",
  ["Mass Chase 2"] = "challenge_header_MassChase",
  ["Smoketrail"] = "challenge_header_Taxi",
  ["HardcoreChallenge"] = "challenge_header_StockholmChallenge",
  ["Uplaych1"] = "challenge_header_Uplay1",
  ["Uplaych2"] = "challenge_header_Uplay2",
  ["Uplaych3"] = "challenge_header_Uplay3",
  ["Uplaych4"] = "challenge_header_Uplay4",
  ["Uplaych5"] = "challenge_header_Uplay5"
}
local sortOrder = {
  [1] = "shop",
  [2] = "movie",
  [3] = "special",
  [4] = "unlockable"
}
function getChallengeList()
  local challengeList = {
    bonus = {},
    movie = {},
    uplay = {},
    special = {}
  }
  local function addChallengeList(challengeType, unlockID, challenges)
    for i, challenge in ipairs(challenges) do
      local challengeTable = missionInfo[cards.ReverseMissionNetworkLookup[challenge.ID]]
      local type = challengeType
      if challengeType == "movie" then
        challengeTable.unlockQuantity = unlockID * collectablesPerChallenge
      end
      if challengeType == "unlockable" and unlockID ~= "uplay" then
        challengeTable.uniqueKey = true
      end
      if challengePrices[challenge.ID] then
        challengeTable.price = challengePrices[challenge.ID].Price
        challengeTable.UnlockedInChapter = challengePrices[challenge.ID].UnlockCriteria
      end
      challengeTable.objectiveType = challenge.objectiveType
      challengeTable.iconType = challenge.iconType
      challengeTable.image = images[challenge.ID]
      if not challengeList[challengeType] then
        if challengeType == "shop" then
          type = "bonus"
        elseif unlockID == "uplay" then
          type = unlockID
        else
          type = "special"
        end
      end
      table.insert(challengeList[type], challengeTable)
    end
  end
  for __, challengeType in ipairs(sortOrder) do
    local typePot = challengeLookupTable[challengeType]
    if typePot then
      if typePot[1] then
        for unlockID, challenges in ipairs(typePot) do
          addChallengeList(challengeType, unlockID, challenges)
        end
      else
        for unlockID, challenges in next, typePot, nil do
          addChallengeList(challengeType, unlockID, challenges)
        end
      end
    end
  end
  return challengeList
end
function MissionNameFromNetworkID(networkID)
  return cards.MissionNetworkLookup[networkID]
end
function NetworkIDFromMissionName(name)
  return cards.ReverseMissionNetworkLookup[name]
end
function unlockAllChallenges()
  local challengeList = getChallengeList()
  for challengeType, challengeList in next, challengeList, nil do
    for __, challenge in ipairs(challengeList) do
      ProfileSettings.SetChallengeUnlocked(challenge.networkID, challenge.type == "activity", challenge.objectiveType == "Movie")
      ProfileSettings.SetChallengeOwned(challenge.networkID, challenge.type == "activity", challenge.objectiveType == "Movie")
    end
  end
end
function unlockAllVehicles()
  for modelID, modelData in next, vehicleStats, nil do
    ProfileSettings.SetVehicleUnlocked(modelID)
    ProfileSettings.SetVehicleOwned(modelID)
  end
end
local multiLevelAbilities = {
  [2] = "abilityBarUpgrade",
  [3] = "abilityBarRecharge",
  [5] = "collectableDetection",
  [6] = "moneyBags",
  [9] = "aerialZap"
}
function unlockAllAbilities()
  for i = 0, 9 do
    ProfileSettings.SetAbilityUnlocked(i, 0)
    ProfileSettings.SetAbilityOwned(i, 0)
    if multiLevelAbilities[i] then
      for j = 1, 2 do
        ProfileSettings.SetAbilityUnlocked(i, j)
        ProfileSettings.SetAbilityOwned(i, j)
      end
    end
  end
end
function unlockAllGarages()
  for __, currentGarage in next, garage.locations, nil do
    ProfileSettings.SetGarageUnlocked(currentGarage.ID)
    ProfileSettings.SetGarageOwned(currentGarage.ID)
  end
  ProfileSettings.SetGarageTutorialPlayed(true)
  ProfileSettings.SetGarageWillpowerTutorialPlayed(true)
end
function getOasisIDFromNetworkID(networkID)
  return missionInfo[networkID].challengeTitle
end
function getGarageNameFromID(garageID)
  return garage.locations[garageID].name
end
