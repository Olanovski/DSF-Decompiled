module("onlineProgressionSystem", package.seeall)
onlineVehicleData = {
  [1] = {
    name = "Pack 1",
    unlocked = false,
    vehicles = {
      [1] = 173
    }
  },
  [2] = {
    name = "Pack 2",
    unlocked = false,
    vehicles = {
      [1] = 144,
      [2] = 171
    }
  },
  [3] = {
    name = "Pack 3",
    unlocked = false,
    vehicles = {
      [1] = 124,
      [2] = 161
    }
  },
  [4] = {
    name = "Pack 4",
    unlocked = false,
    vehicles = {
      [1] = 176
    }
  },
  [5] = {
    name = "Pack 5",
    unlocked = false,
    vehicles = {
      [1] = 151
    }
  },
  [6] = {
    name = "Pack 6",
    unlocked = false,
    vehicles = {
      [1] = 206,
      [2] = 129
    }
  },
  [7] = {
    name = "Pack 7",
    unlocked = false,
    vehicles = {
      [1] = 143,
      [2] = 150
    }
  },
  [8] = {
    name = "Pack 8",
    unlocked = false,
    vehicles = {
      [1] = 147,
      [2] = 130
    }
  },
  [9] = {
    name = "Pack 9",
    unlocked = false,
    vehicles = {
      [1] = 299,
      [2] = 208,
      [3] = 249
    }
  },
  [10] = {
    name = "Pack 10",
    unlocked = false,
    vehicles = {
      [1] = 228
    }
  },
  [11] = {
    name = "Pack 11",
    unlocked = false,
    vehicles = {
      [1] = 255,
      [2] = 205
    }
  },
  [12] = {
    name = "Pack 12",
    unlocked = false,
    vehicles = {
      [1] = 251,
      [2] = 184
    }
  },
  [13] = {
    name = "Pack 13",
    unlocked = false,
    vehicles = {
      [1] = 134,
      [2] = 213
    }
  },
  [14] = {
    name = "Pack 14",
    unlocked = false,
    vehicles = {
      [1] = 207,
      [2] = 158,
      [3] = 233
    }
  },
  [15] = {
    name = "Pack 15",
    unlocked = false,
    vehicles = {
      [1] = 244,
      [2] = 195
    }
  },
  [16] = {
    name = "Pack 16",
    unlocked = false,
    vehicles = {
      [1] = 133,
      [2] = 239
    }
  },
  [17] = {
    name = "Pack 17",
    unlocked = false,
    vehicles = {
      [1] = 212,
      [2] = 248,
      [3] = 180
    }
  },
  [18] = {
    name = "Pack 18",
    unlocked = false,
    vehicles = {
      [1] = 242,
      [2] = 259
    }
  },
  [19] = {
    name = "Pack 19",
    unlocked = false,
    vehicles = {
      [1] = 189,
      [2] = 188
    }
  },
  [20] = {
    name = "Pack 20",
    unlocked = false,
    vehicles = {
      [1] = 279,
      [2] = 217
    }
  },
  [21] = {
    name = "Pack 21",
    unlocked = false,
    vehicles = {
      [1] = 216,
      [2] = 138
    }
  },
  [22] = {
    name = "Pack 22",
    unlocked = false,
    vehicles = {
      [1] = 243,
      [2] = 162
    }
  },
  [23] = {
    name = "Pack 23",
    unlocked = false,
    vehicles = {
      [1] = 194,
      [2] = 135
    }
  },
  [24] = {
    name = "Pack 24",
    unlocked = false,
    vehicles = {
      [1] = 182,
      [2] = 125,
      [3] = 215
    }
  },
  [25] = {
    name = "Pack 25",
    unlocked = false,
    vehicles = {
      [1] = 211,
      [2] = 175
    }
  },
  [26] = {
    name = "Pack 26",
    unlocked = false,
    vehicles = {
      [1] = 139,
      [2] = 252
    }
  },
  [27] = {
    name = "Pack 27",
    unlocked = false,
    vehicles = {
      [1] = 210,
      [2] = 132
    }
  },
  [28] = {
    name = "Pack 28",
    unlocked = false,
    vehicles = {
      [1] = 225,
      [2] = 126
    }
  },
  [29] = {
    name = "Pack 29",
    unlocked = false,
    vehicles = {
      [1] = 163,
      [2] = 229
    }
  },
  [30] = {
    name = "Pack 30",
    unlocked = false,
    vehicles = {
      [1] = 214,
      [2] = 142
    }
  },
  [31] = {
    name = "Pack 31",
    unlocked = false,
    vehicles = {
      [1] = 232,
      [2] = 191
    }
  },
  [32] = {
    name = "Pack 32",
    unlocked = false,
    vehicles = {
      [1] = 224,
      [2] = 240
    }
  },
  [33] = {
    name = "Pack 33",
    unlocked = false,
    vehicles = {
      [1] = 62,
      [2] = 181
    }
  },
  [34] = {
    name = "Pack 34",
    unlocked = false,
    vehicles = {
      [1] = 265
    }
  },
  [35] = {
    name = "Uplay",
    unlocked = false,
    new = false,
    isUplayPack = true,
    vehicles = {
      [1] = 269
    }
  }
}
local sortUnlockVehicles = function(vehicleID, targetUnlockSlot)
  for j, packData in ipairs(onlineVehicleData) do
    for k, vehicleID_P in ripairs(packData.vehicles) do
      if vehicleID == vehicleID_P then
        table.remove(onlineVehicleData[j].vehicles, k)
      end
    end
  end
  table.insert(onlineVehicleData[targetUnlockSlot].vehicles, vehicleID)
end
function unlockPreOrderCarPack()
  for i, unlockData in ipairs(unlockableVehiclesTable) do
    if not unlockData.onlineUnlocked and unlockData.isRewardUnlocked() then
      sortUnlockVehicles(unlockData.vehicleID, 1)
      unlockableVehiclesTable[i].onlineUnlocked = true
    end
  end
end
function unlockUPlayCarPack()
  for i = 1, #onlineVehicleData do
    if onlineVehicleData[i].isUplayPack then
      onlineVehicleData[i].unlocked = true
    end
  end
end
function onlineGetNumberOfVehiclePacks()
  return #onlineVehicleData
end
_G.onlineGetNumberOfVehiclePacks = onlineGetNumberOfVehiclePacks
function onlineGetVehiclePackName(index)
  if onlineVehicleData[index] then
    return onlineVehicleData[index].name
  end
  return "INVALID VEHICLE INDEX - GET NAME"
end
_G.onlineGetVehiclePackName = onlineGetVehiclePackName
function onlineIsVehiclePackUnlocked(index)
  if onlineVehicleData[index] then
    return onlineVehicleData[index].unlocked
  end
  print("VEHICLE INDEX " .. tostring(index) .. " IS NOT VALID")
  return false
end
_G.onlineIsVehiclePackUnlocked = onlineIsVehiclePackUnlocked
function onlineIsVehiclePackNewlyUnlocked(index)
  if onlineVehicleData[index] then
    return onlineVehicleData[index].new
  end
  print("VEHICLE INDEX " .. tostring(index) .. " IS NOT VALID")
  return false
end
_G.onlineIsVehiclePackNewlyUnlocked = onlineIsVehiclePackNewlyUnlocked
function onlineIsAnyVehiclePackNewlyUnlocked()
  for i, pack in ipairs(onlineVehicleData) do
    if onlineIsVehiclePackNewlyUnlocked(i) == true then
      return true
    end
  end
  return false
end
_G.onlineIsAnyVehiclePackNewlyUnlocked = onlineIsAnyVehiclePackNewlyUnlocked
function onlineVehiclePackClearNew(index)
  if onlineVehicleData[index] then
    onlineVehicleData[index].new = false
    return true
  end
  print("VEHICLE INDEX " .. tostring(index) .. " IS NOT VALID")
  return false
end
_G.onlineVehiclePackClearNew = onlineVehiclePackClearNew
function onlineGetNumOfVehiclesInPack(index)
  if onlineVehicleData[index] then
    return #onlineVehicleData[index].vehicles
  end
  print("VEHICLE INDEX " .. tostring(index) .. " IS NOT VALID")
  return -1
end
_G.onlineGetNumOfVehiclesInPack = onlineGetNumOfVehiclesInPack
function onlineGetVehicleIDInPack(index, vehicle)
  if onlineVehicleData[index] and onlineVehicleData[index].vehicles[vehicle] then
    return onlineVehicleData[index].vehicles[vehicle]
  end
  print("VEHICLE INDEX " .. tostring(index) .. " IS NOT VALID or VEHICLE TABLE INDEX IS " .. tostring(vehicle) .. " INVALID")
  return -1
end
_G.onlineGetVehicleIDInPack = onlineGetVehicleIDInPack
function getVehicleLevelRequirement(index)
  return getLevelRequirementForUnlock(onlineVehicleData, index)
end
_G.getVehicleLevelRequirement = getVehicleLevelRequirement
function isVehiclePackAUplayUnlock(index)
  return onlineVehicleData[index].isUplayPack
end
_G.isVehiclePackAUplayUnlock = isVehiclePackAUplayUnlock
function onlineGetDefaultVehicles()
  return onlineVehicleData[1].vehicles[1], onlineVehicleData[7].vehicles[2]
end
_G.onlineGetDefaultVehicles = onlineGetDefaultVehicles
