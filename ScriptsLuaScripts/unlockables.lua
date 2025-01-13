local unlockVehicleIDs = {
  [1] = 8,
  [2] = 9,
  [3] = 10,
  [4] = 11,
  [5] = 12,
  [6] = 13,
  [7] = 14,
  [8] = 15,
  [9] = 16,
  [10] = 17
}
unlockableVehiclesTable = {
  [1] = {
    vehicleID = 158,
    onlineUnlocked = false,
    unlockReward = function()
      return false
    end,
    isRewardUnlocked = function()
      return Unlockables.IsUnlocked(unlockVehicleIDs[1])
    end
  },
  [2] = {
    vehicleID = 248,
    onlineUnlocked = false,
    unlockReward = function()
      return false
    end,
    isRewardUnlocked = function()
      return Unlockables.IsUnlocked(unlockVehicleIDs[2])
    end
  },
  [3] = {
    vehicleID = 215,
    onlineUnlocked = false,
    unlockReward = function()
      return false
    end,
    isRewardUnlocked = function()
      return Unlockables.IsUnlocked(unlockVehicleIDs[3])
    end
  },
  [4] = {
    vehicleID = 132,
    onlineUnlocked = false,
    unlockReward = function()
      return false
    end,
    isRewardUnlocked = function()
      return Unlockables.IsUnlocked(unlockVehicleIDs[4])
    end
  },
  [5] = {
    vehicleID = 191,
    onlineUnlocked = false,
    unlockReward = function()
      return false
    end,
    isRewardUnlocked = function()
      return Unlockables.IsUnlocked(unlockVehicleIDs[5])
    end
  },
  [6] = {
    vehicleID = 128,
    onlineUnlocked = false,
    unlockReward = function()
      return false
    end,
    isRewardUnlocked = function()
      return Unlockables.IsUnlocked(unlockVehicleIDs[6])
    end
  },
  [7] = {
    vehicleID = 149,
    onlineUnlocked = false,
    unlockReward = function()
      return false
    end,
    isRewardUnlocked = function()
      return Unlockables.IsUnlocked(unlockVehicleIDs[7])
    end
  },
  [8] = {
    vehicleID = 164,
    onlineUnlocked = false,
    unlockReward = function()
      return false
    end,
    isRewardUnlocked = function()
      return Unlockables.IsUnlocked(unlockVehicleIDs[8])
    end
  },
  [9] = {
    vehicleID = 257,
    onlineUnlocked = false,
    unlockReward = function()
      return false
    end,
    isRewardUnlocked = function()
      return Unlockables.IsUnlocked(unlockVehicleIDs[9])
    end
  },
  [10] = {
    vehicleID = 149,
    onlineUnlocked = false,
    unlockReward = function()
      Unlockables.RoyalPurpleOverride(true)
      return false
    end,
    isRewardUnlocked = function()
      return Unlockables.IsUnlocked(unlockVehicleIDs[10])
    end
  }
}
local unlockablesLookupTable = {
  [0] = function()
    for i, unlockData in ipairs(unlockableVehiclesTable) do
    end
    return false
  end,
  [1] = function()
    local unlocked = false
    for __, challenge in next, challengeLookupTable.unlockable.uniqueKey1, nil do
      if not ProfileSettings.GetChallengeUnlocked(cards.ReverseMissionNetworkLookup[challenge.ID]) then
        unlocked = true
        ProfileSettings.SetChallengeUnlocked(cards.ReverseMissionNetworkLookup[challenge.ID])
        ProfileSettings.SetChallengeOwned(cards.ReverseMissionNetworkLookup[challenge.ID])
      end
    end
    return unlocked
  end,
  [2] = function()
    local unlocked = false
    for __, challenge in next, challengeLookupTable.unlockable.uniqueKey2, nil do
      if not ProfileSettings.GetChallengeUnlocked(cards.ReverseMissionNetworkLookup[challenge.ID]) then
        unlocked = true
        ProfileSettings.SetChallengeUnlocked(cards.ReverseMissionNetworkLookup[challenge.ID])
        ProfileSettings.SetChallengeOwned(cards.ReverseMissionNetworkLookup[challenge.ID])
      end
    end
    return unlocked
  end,
  [3] = function()
    local unlocked = false
    for __, challenge in next, challengeLookupTable.unlockable.uniqueKey3, nil do
      if not ProfileSettings.GetChallengeUnlocked(cards.ReverseMissionNetworkLookup[challenge.ID]) then
        unlocked = true
        ProfileSettings.SetChallengeUnlocked(cards.ReverseMissionNetworkLookup[challenge.ID])
        ProfileSettings.SetChallengeOwned(cards.ReverseMissionNetworkLookup[challenge.ID])
      end
    end
    return unlocked
  end,
  [4] = function()
    local unlocked = false
    for __, challenge in next, challengeLookupTable.unlockable.uniqueKey4, nil do
      if not ProfileSettings.GetChallengeUnlocked(cards.ReverseMissionNetworkLookup[challenge.ID]) then
        unlocked = true
        ProfileSettings.SetChallengeUnlocked(cards.ReverseMissionNetworkLookup[challenge.ID])
        ProfileSettings.SetChallengeOwned(cards.ReverseMissionNetworkLookup[challenge.ID])
      end
    end
    return unlocked
  end,
  [6] = function()
    local unlocked = false
    if not ProfileSettings.GetChallengeUnlocked(cards.ReverseMissionNetworkLookup.Uplaych5) then
      unlocked = true
      ProfileSettings.SetChallengeUnlocked(cards.ReverseMissionNetworkLookup.Uplaych5)
      ProfileSettings.SetChallengeOwned(cards.ReverseMissionNetworkLookup.Uplaych5)
    end
    return unlocked
  end,
  [7] = function()
    local unlocked = false
    if not ProfileSettings.GetChallengeUnlocked(cards.ReverseMissionNetworkLookup.Uplaych1) then
      unlocked = true
      ProfileSettings.SetChallengeUnlocked(cards.ReverseMissionNetworkLookup.Uplaych1)
      ProfileSettings.SetChallengeOwned(cards.ReverseMissionNetworkLookup.Uplaych1)
    end
    if not ProfileSettings.GetChallengeUnlocked(cards.ReverseMissionNetworkLookup.Uplaych2) then
      unlocked = true
      ProfileSettings.SetChallengeUnlocked(cards.ReverseMissionNetworkLookup.Uplaych2)
      ProfileSettings.SetChallengeOwned(cards.ReverseMissionNetworkLookup.Uplaych2)
    end
    if not ProfileSettings.GetChallengeUnlocked(cards.ReverseMissionNetworkLookup.Uplaych3) then
      unlocked = true
      ProfileSettings.SetChallengeUnlocked(cards.ReverseMissionNetworkLookup.Uplaych3)
      ProfileSettings.SetChallengeOwned(cards.ReverseMissionNetworkLookup.Uplaych3)
    end
    if not ProfileSettings.GetChallengeUnlocked(cards.ReverseMissionNetworkLookup.Uplaych4) then
      unlocked = true
      ProfileSettings.SetChallengeUnlocked(cards.ReverseMissionNetworkLookup.Uplaych4)
      ProfileSettings.SetChallengeOwned(cards.ReverseMissionNetworkLookup.Uplaych4)
    end
    return unlocked
  end,
  [unlockVehicleIDs[1]] = function()
    return unlockableVehiclesTable[1].unlockReward()
  end,
  [unlockVehicleIDs[2]] = function()
    return unlockableVehiclesTable[2].unlockReward()
  end,
  [unlockVehicleIDs[3]] = function()
    return unlockableVehiclesTable[3].unlockReward()
  end,
  [unlockVehicleIDs[4]] = function()
    return unlockableVehiclesTable[4].unlockReward()
  end,
  [unlockVehicleIDs[5]] = function()
    return unlockableVehiclesTable[5].unlockReward()
  end,
  [unlockVehicleIDs[6]] = function()
    return unlockableVehiclesTable[6].unlockReward()
  end,
  [unlockVehicleIDs[7]] = function()
    return unlockableVehiclesTable[7].unlockReward()
  end,
  [unlockVehicleIDs[8]] = function()
    return unlockableVehiclesTable[8].unlockReward()
  end,
  [unlockVehicleIDs[9]] = function()
    return unlockableVehiclesTable[9].unlockReward()
  end,
  [unlockVehicleIDs[10]] = function()
    return unlockableVehiclesTable[10].unlockReward()
  end
}
function UnlockRewards(ID)
  print("=================================================== UnlockRewards")
  if ID then
    print("ID = " .. tostring(ID))
    if unlockablesLookupTable[ID] then
      return unlockablesLookupTable[ID]()
    else
      print("Atempted to unlock a non-existant ID (" .. ID .. ")")
      return false
    end
  end
end
