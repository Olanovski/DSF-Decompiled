module("onlineProgressionSystem", package.seeall)
onlinePlaylistUnlockData = {}
onlineRewardData = {
  [1] = onlineAbilityData,
  [2] = onlineWeaponData,
  [3] = onlineVehicleData,
  [4] = onlineIconData,
  [5] = onlineUpgradeData,
  [6] = onlinePlaylistUnlockData
}
onlineRewardID = {
  xp = 1,
  weapon = 2,
  ability = 3,
  playlist = 4,
  vehicle = 5,
  icon = 6
}
onlineLevelData = {
  [0] = {
    xp = 0,
    rewards = {}
  },
  [1] = {
    xp = 1000,
    rewards = {
      [1] = {rewardType = 1, rewardIndex = 1},
      [2] = {rewardType = 4, rewardIndex = 1}
    }
  },
  [2] = {
    xp = 3500,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 2}
    }
  },
  [3] = {
    xp = 7500,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 3}
    }
  },
  [4] = {
    xp = 12500,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 4}
    }
  },
  [5] = {
    xp = 17750,
    rewards = {
      [1] = {rewardType = 2, rewardIndex = 1},
      [2] = {rewardType = 3, rewardIndex = 1}
    }
  },
  [6] = {
    xp = 23250,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 5},
      [2] = {rewardType = 3, rewardIndex = 2}
    }
  },
  [7] = {
    xp = 29000,
    rewards = {
      [1] = {rewardType = 3, rewardIndex = 3}
    }
  },
  [8] = {
    xp = 35000,
    rewards = {
      [1] = {rewardType = 2, rewardIndex = 2},
      [2] = {rewardType = 3, rewardIndex = 4}
    }
  },
  [9] = {
    xp = 41250,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 6},
      [2] = {rewardType = 3, rewardIndex = 5}
    }
  },
  [10] = {
    xp = 47750,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 7},
      [2] = {rewardType = 3, rewardIndex = 6}
    }
  },
  [11] = {
    xp = 54500,
    rewards = {
      [1] = {rewardType = 5, rewardIndex = 1},
      [2] = {rewardType = 3, rewardIndex = 7}
    }
  },
  [12] = {
    xp = 61500,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 8},
      [2] = {rewardType = 3, rewardIndex = 8}
    }
  },
  [13] = {
    xp = 68750,
    rewards = {
      [1] = {rewardType = 3, rewardIndex = 9}
    }
  },
  [14] = {
    xp = 76500,
    rewards = {
      [1] = {rewardType = 2, rewardIndex = 3},
      [2] = {rewardType = 3, rewardIndex = 10}
    }
  },
  [15] = {
    xp = 84750,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 9},
      [2] = {rewardType = 3, rewardIndex = 11}
    }
  },
  [16] = {
    xp = 93500,
    rewards = {
      [1] = {rewardType = 5, rewardIndex = 2},
      [2] = {rewardType = 3, rewardIndex = 12}
    }
  },
  [17] = {
    xp = 102750,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 10},
      [2] = {rewardType = 3, rewardIndex = 13}
    }
  },
  [18] = {
    xp = 112500,
    rewards = {
      [1] = {rewardType = 3, rewardIndex = 14}
    }
  },
  [19] = {
    xp = 122750,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 11},
      [2] = {rewardType = 3, rewardIndex = 15}
    }
  },
  [20] = {
    xp = 133500,
    rewards = {
      [1] = {rewardType = 5, rewardIndex = 3},
      [2] = {rewardType = 3, rewardIndex = 16}
    }
  },
  [21] = {
    xp = 144750,
    rewards = {
      [1] = {rewardType = 3, rewardIndex = 17}
    }
  },
  [22] = {
    xp = 156500,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 12},
      [2] = {rewardType = 3, rewardIndex = 18}
    }
  },
  [23] = {
    xp = 168750,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 13},
      [2] = {rewardType = 3, rewardIndex = 19}
    }
  },
  [24] = {
    xp = 181500,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 14},
      [2] = {rewardType = 3, rewardIndex = 20}
    }
  },
  [25] = {
    xp = 194750,
    rewards = {
      [1] = {rewardType = 5, rewardIndex = 4},
      [2] = {rewardType = 3, rewardIndex = 21}
    }
  },
  [26] = {
    xp = 208750,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 15},
      [2] = {rewardType = 3, rewardIndex = 22}
    }
  },
  [27] = {
    xp = 223500,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 16},
      [2] = {rewardType = 3, rewardIndex = 23}
    }
  },
  [28] = {
    xp = 239000,
    rewards = {
      [1] = {rewardType = 3, rewardIndex = 24}
    }
  },
  [29] = {
    xp = 255250,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 17},
      [2] = {rewardType = 3, rewardIndex = 25}
    }
  },
  [30] = {
    xp = 272250,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 18},
      [2] = {rewardType = 3, rewardIndex = 26}
    }
  },
  [31] = {
    xp = 290000,
    rewards = {
      [1] = {rewardType = 5, rewardIndex = 5},
      [2] = {rewardType = 3, rewardIndex = 27}
    }
  },
  [32] = {
    xp = 308500,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 19},
      [2] = {rewardType = 3, rewardIndex = 28}
    }
  },
  [33] = {
    xp = 327750,
    rewards = {
      [1] = {rewardType = 3, rewardIndex = 29}
    }
  },
  [34] = {
    xp = 347750,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 20},
      [2] = {rewardType = 3, rewardIndex = 30}
    }
  },
  [35] = {
    xp = 368750,
    rewards = {
      [1] = {rewardType = 3, rewardIndex = 31}
    }
  },
  [36] = {
    xp = 390750,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 21},
      [2] = {rewardType = 3, rewardIndex = 32}
    }
  },
  [37] = {
    xp = 413750,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 22},
      [2] = {rewardType = 3, rewardIndex = 33}
    }
  },
  [38] = {
    xp = 438250,
    rewards = {
      [1] = {rewardType = 5, rewardIndex = 6},
      [2] = {rewardType = 4, rewardIndex = 23}
    }
  },
  [39] = {
    xp = 492750,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 24}
    }
  },
  [40] = {
    xp = 667250,
    rewards = {
      [1] = {rewardType = 4, rewardIndex = 25},
      [2] = {rewardType = 3, rewardIndex = 34}
    }
  }
}
function getLevelRequirementForUnlock(unlockType, index)
  local rewardType = -1
  for i, type in ipairs(onlineRewardData) do
    if type == unlockType then
      rewardType = i
      break
    end
  end
  if rewardType ~= -1 then
    for i, rewardData in ipairs(onlineLevelData) do
      for j, rewards in ipairs(rewardData.rewards) do
        if rewards.rewardType == rewardType and rewards.rewardIndex == index then
          return i
        end
      end
    end
  end
  return -1
end
function onlineGetNumberOfXPLevels()
  return #onlineLevelData
end
_G.onlineGetNumberOfXPLevels = onlineGetNumberOfXPLevels
