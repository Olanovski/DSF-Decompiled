module("coopSystem", package.seeall)
coopData = coopData or {}
coopSystem.timers = {}
coopSystem.sharedData = {}
coopData.blipsTable = {}
coopData.taskObjectDeletionTable = coopData.taskObjectDeletionTable or {}
coopData.actorCreationTable = coopData.actorCreationTable or {}
coopData.colors = {
  brightwhite = vec.vector(255, 255, 255, 255),
  blue = vec.vector(102, 174, 223, 150),
  red = vec.vector(174, 102, 223, 150),
  otherblue = vec.vector(50, 150, 12, 150)
}
coopSystem._DIFF_EASY = 1
coopSystem._DIFF_MEDIUM = 2
coopSystem._DIFF_HARD = 3
coopSystem._TEXT_MISSION_COMPLETE = "ID:221036"
coopSystem._TEXT_MISSION_FAILED = "ID:214857"
coopSystem._TEXT_RACE_WON = "ID:236595"
coopSystem._TEXT_RACE_LOST = "ID:236596"
coopSystem._TEXT_ROUND_WON = "ID:236579"
coopSystem._TEXT_ROUND_LOST = "ID:236580"
coopSystem.selectedMissionIndex = 0
coopSystem.selectedDifficulty = 1
CoopMissionOrder = {}
CoopMissionOrder[1] = "Coop Choose Your Dare"
CoopMissionOrder[2] = "MP coop heavy hitter"
CoopMissionOrder[3] = "MP CO-OP Mayhem"
CoopMissionOrder[4] = "MP coop survival race"
CoopMissionOrder[5] = "MP coop Heist"
CoopMissionOrder[6] = "MP coop trial"
CoopMissionOrder[7] = "SS Go the Distance"
CoopMissionOrder[8] = "SS Clean the streets"
CoopMissionOrder[9] = "SS Survival"
CoopMissionOrder[10] = "SS Freedrive"
function getCoopMissionOrder(index)
  local name = CoopMissionOrder[index]
  return name
end
_G.getCoopMissionOrder = getCoopMissionOrder
function getNumCoopMissions()
  local result = #CoopMissionOrder
  return result
end
_G.getNumCoopMissions = getNumCoopMissions
coopSystem.highScores = {}
coopSystem.highScores["MP coop survival race"] = {
  1111,
  2222,
  3333,
  4444
}
coopSystem.highScores["MP CO-OP Mayhem"] = {
  1111,
  2222,
  3333,
  4444
}
coopSystem.highScores["MP coop trial"] = {
  1111,
  2222,
  3333,
  4444
}
coopSystem.highScores["Coop Choose Your Dare"] = {
  1111,
  2222,
  3333,
  4444
}
coopSystem.highScores["MP coop Heist"] = {
  1111,
  2222,
  3333,
  4444
}
coopSystem.highScores["MP coop heavy hitter"] = {
  1111,
  2222,
  3333,
  4444
}
coopSystem.highScores["SS Go the Distance"] = {
  1111,
  2222,
  3333,
  4444
}
coopSystem.highScores["SS Clean the streets"] = {
  1111,
  2222,
  3333,
  4444
}
coopSystem.highScores["SS Survival"] = {
  1111,
  2222,
  3333,
  4444
}
coopSystem.missionStats = {}
coopSystem.missionStats["MP coop survival race"] = {
  1111,
  2222,
  3333
}
coopSystem.missionStats["MP CO-OP Mayhem"] = {
  1111,
  2222,
  3333
}
coopSystem.missionStats["MP coop trial"] = {
  999999,
  0,
  999999
}
coopSystem.missionStats["Coop Choose Your Dare"] = {
  1111,
  2222,
  3333
}
coopSystem.missionStats["MP coop Heist"] = {
  1111,
  2222,
  3333
}
coopSystem.missionStats["MP coop heavy hitter"] = {
  1111,
  2222,
  3333
}
coopSystem.missionStats["SS Go the Distance"] = {
  1111,
  2222,
  3333
}
coopSystem.missionStats["SS Clean the streets"] = {
  1111,
  2222,
  3333
}
coopSystem.missionStats["SS Survival"] = {
  1111,
  2222,
  3333
}
coopSystem.missionIndices = {}
coopSystem.missionIndices["MP coop survival race"] = 3
coopSystem.missionIndices["MP CO-OP Mayhem"] = 0
coopSystem.missionIndices["MP coop trial"] = 2
coopSystem.missionIndices["Coop Choose Your Dare"] = 4
coopSystem.missionIndices["MP coop Heist"] = 1
coopSystem.missionIndices["MP coop heavy hitter"] = 5
coopSystem.missionIndices["SS Go the Distance"] = 6
coopSystem.missionIndices["SS Clean the streets"] = 7
coopSystem.missionIndices["SS Survival"] = 8
coopSystem.highScoreStatID = {}
coopSystem.highScoreStatID["MP coop survival race"] = {
  121,
  122,
  123
}
coopSystem.highScoreStatID["MP CO-OP Mayhem"] = {
  100,
  101,
  102
}
coopSystem.highScoreStatID["MP coop trial"] = {
  114,
  115,
  116
}
coopSystem.highScoreStatID["Coop Choose Your Dare"] = {
  128,
  129,
  130
}
coopSystem.highScoreStatID["MP coop Heist"] = {
  107,
  108,
  109
}
coopSystem.highScoreStatID["MP coop heavy hitter"] = {
  135,
  136,
  137
}
coopSystem.highScoreStatID["SS Go the Distance"] = {
  235,
  236,
  237
}
coopSystem.highScoreStatID["SS Clean the streets"] = {
  238,
  239,
  240
}
coopSystem.highScoreStatID["SS Survival"] = {
  241,
  242,
  243
}
function getCoopHighScoreStatID(challengeName, difficulty)
  local stat = coopSystem.highScoreStatID[challengeName][difficulty]
  return stat
end
_G.getCoopHighScoreStatID = getCoopHighScoreStatID
coopSystem.medalNames = {
  "ID:235411",
  "ID:235410",
  "ID:235409",
  "ID:235412"
}
coopSystem.medalScores = {}
coopSystem.medalScores["MP coop survival race"] = {
  {
    15000,
    30000,
    50000,
    60000
  },
  {
    15000,
    30000,
    50000,
    60000
  },
  {
    15000,
    30000,
    50000,
    60000
  }
}
coopSystem.medalScores["MP CO-OP Mayhem"] = {
  {
    40000,
    80000,
    120000,
    140000
  },
  {
    40000,
    80000,
    120000,
    140000
  },
  {
    40000,
    80000,
    120000,
    140000
  }
}
coopSystem.medalScores["MP coop trial"] = {
  {
    10000,
    20000,
    40000,
    80000
  },
  {
    10000,
    20000,
    40000,
    80000
  },
  {
    10000,
    20000,
    40000,
    80000
  }
}
coopSystem.medalScores["Coop Choose Your Dare"] = {
  {
    20000,
    40000,
    60000,
    90000
  },
  {
    20000,
    40000,
    60000,
    90000
  },
  {
    20000,
    40000,
    60000,
    90000
  }
}
coopSystem.medalScores["MP coop Heist"] = {
  {
    10000,
    15000,
    18000,
    120000
  },
  {
    40000,
    60000,
    100000,
    120000
  },
  {
    40000,
    60000,
    100000,
    120000
  }
}
coopSystem.medalScores["MP coop heavy hitter"] = {
  {
    40000,
    80000,
    120000,
    140000
  },
  {
    40000,
    80000,
    120000,
    140000
  },
  {
    40000,
    80000,
    120000,
    140000
  }
}
coopSystem.medalScores["SS Go the Distance"] = {
  {
    10000,
    20000,
    40000,
    80000
  },
  {
    10000,
    20000,
    40000,
    80000
  },
  {
    10000,
    20000,
    40000,
    80000
  }
}
coopSystem.medalScores["SS Clean the streets"] = {
  {
    10000,
    20000,
    40000,
    80000
  },
  {
    10000,
    20000,
    40000,
    80000
  },
  {
    10000,
    20000,
    40000,
    80000
  }
}
coopSystem.medalScores["SS Survival"] = {
  {
    10000,
    20000,
    40000,
    80000
  },
  {
    10000,
    20000,
    40000,
    80000
  },
  {
    10000,
    20000,
    40000,
    80000
  }
}
function getCoopMedalScore(challengeName, level, medal)
  local score = coopSystem.medalScores[challengeName][level][medal]
  return score
end
_G.getCoopMedalScore = getCoopMedalScore
coopSystem.coopRewards = {}
coopSystem.coopRewards["MP coop survival race"] = {
  {"ID:233166", "ID:233165"},
  {"ID:233166", "$Nothing"},
  {"$Nothing", "ID:233169"}
}
coopSystem.coopRewards["MP CO-OP Mayhem"] = {
  {"$Ram", "ID:233166"},
  {"ID:233166", "ID:233165"},
  {"ID:233166", "ID:233169"}
}
coopSystem.coopRewards["MP coop trial"] = {
  {"ID:233166", "ID:233165"},
  {"ID:233166", "ID:233166"},
  {"$Nothing", "ID:233169"}
}
coopSystem.coopRewards["Coop Choose Your Dare"] = {
  {"ID:233166", "$Ram"},
  {"ID:233165", "ID:233166"},
  {"ID:233166", "ID:233169"}
}
coopSystem.coopRewards["MP coop Heist"] = {
  {"ID:233166", "ID:233165"},
  {"ID:233166", "ID:233167"},
  {"ID:233168", "ID:233169"}
}
coopSystem.coopRewards["MP coop heavy hitter"] = {
  {"ID:233166", "ID:233165"},
  {"$Ram", "ID:233166"},
  {"ID:233166", "ID:233169"}
}
coopSystem.coopRewards["SS Go the Distance"] = {
  {"GTD1", "GTD1"},
  {"GTD2", "GTD2"},
  {"GTD3", "GTD3"}
}
coopSystem.coopRewards["SS Clean the streets"] = {
  {"CTS1", "CTS1"},
  {"CTS2", "CTS2"},
  {"CTS3", "CTS3"}
}
coopSystem.coopRewards["SS Survival"] = {
  {"SUR1", "SUR1"},
  {"SUR2", "SUR2"},
  {"SUR3", "SUR3"}
}
function getCoopReward(challengeName, levelIndex, rewardIndex)
  local reward = coopSystem.coopRewards[challengeName][levelIndex][rewardIndex]
  return reward
end
_G.getCoopReward = getCoopReward
coopSystem.coopRewardPoints = {}
coopSystem.coopRewardPoints["MP coop survival race"] = {15000, 50000}
coopSystem.coopRewardPoints["MP CO-OP Mayhem"] = {40000, 80000}
coopSystem.coopRewardPoints["MP coop trial"] = {10000, 40000}
coopSystem.coopRewardPoints["Coop Choose Your Dare"] = {20000, 20000}
coopSystem.coopRewardPoints["MP coop Heist"] = {40000, 100000}
coopSystem.coopRewardPoints["MP coop heavy hitter"] = {40000, 80000}
coopSystem.coopRewardPoints["SS Go the Distance"] = {10000, 40000}
coopSystem.coopRewardPoints["SS Clean the streets"] = {10000, 40000}
coopSystem.coopRewardPoints["SS Survival"] = {10000, 40000}
function getCoopRewardPoints(challengeName, rewardIndex)
  local rewardPoints = coopSystem.coopRewardPoints[challengeName][rewardIndex]
  return rewardPoints
end
_G.getCoopRewardPoints = getCoopRewardPoints
coopSystem.coopRouteTitleStrings = {}
coopSystem.coopRouteTitleStrings["MP coop survival race"] = {
  "ID:233969",
  "ID:233970",
  "ID:233968"
}
coopSystem.coopRouteTitleStrings["MP CO-OP Mayhem"] = {
  "ID:233956",
  "ID:233957",
  "ID:233958"
}
coopSystem.coopRouteTitleStrings["MP coop trial"] = {
  "ID:233959",
  "ID:233960",
  "ID:233961"
}
coopSystem.coopRouteTitleStrings["Coop Choose Your Dare"] = {
  "ID:233962",
  "ID:233963",
  "ID:233964"
}
coopSystem.coopRouteTitleStrings["MP coop Heist"] = {
  "ID:233971",
  "ID:233972",
  "ID:233973"
}
coopSystem.coopRouteTitleStrings["MP coop heavy hitter"] = {
  "ID:233965",
  "ID:233966",
  "ID:233967"
}
coopSystem.coopRouteTitleStrings["SS Go the Distance"] = {
  "-",
  "-",
  "-"
}
coopSystem.coopRouteTitleStrings["SS Clean the streets"] = {
  "-",
  "-",
  "-"
}
coopSystem.coopRouteTitleStrings["SS Survival"] = {
  "-",
  "-",
  "-"
}
function getCoopRouteTitle(challengeName, levelIndex)
  local name = coopSystem.coopRouteTitleStrings[challengeName][levelIndex]
  return name
end
_G.getCoopRouteTitle = getCoopRouteTitle
coopSystem.miscStatID = {}
coopSystem.miscStatID["MP coop survival race"] = {
  125,
  126,
  127
}
coopSystem.miscStatID["MP CO-OP Mayhem"] = {
  104,
  105,
  106
}
coopSystem.miscStatID["MP coop trial"] = {
  118,
  119,
  120
}
coopSystem.miscStatID["Coop Choose Your Dare"] = {
  132,
  133,
  134
}
coopSystem.miscStatID["MP coop Heist"] = {
  111,
  112,
  113
}
coopSystem.miscStatID["MP coop heavy hitter"] = {
  139,
  140,
  141
}
coopSystem.miscStatID["SS Go the Distance"] = {
  139,
  140,
  141
}
coopSystem.miscStatID["SS Clean the streets"] = {
  139,
  140,
  141
}
coopSystem.miscStatID["SS Survival"] = {
  139,
  140,
  141
}
function getCoopMiscStatID(challengeName, statIndex)
  local stat = coopSystem.miscStatID[challengeName][statIndex]
  return stat
end
_G.getCoopMiscStatID = getCoopMiscStatID
coopSystem.roundDescription = {}
coopSystem.roundDescription["MP coop survival race"] = "ID:242207"
coopSystem.roundDescription["MP CO-OP Mayhem"] = "ID:242212"
coopSystem.roundDescription["MP coop trial"] = "ID:242211"
coopSystem.roundDescription["Coop Choose Your Dare"] = "ID:242213"
coopSystem.roundDescription["MP coop Heist"] = "ID:242209"
coopSystem.roundDescription["MP coop heavy hitter"] = "ID:242205"
coopSystem.roundDescription["SS Go the Distance"] = "GoTheDist"
coopSystem.roundDescription["SS Clean the streets"] = "CleanStr"
coopSystem.roundDescription["SS Survival"] = "Survival"
coopSystem.roundGoal = {}
coopSystem.roundGoal["MP coop survival race"] = "ID:242208"
coopSystem.roundGoal["MP CO-OP Mayhem"] = ""
coopSystem.roundGoal["MP coop trial"] = ""
coopSystem.roundGoal["Coop Choose Your Dare"] = "ID:242214"
coopSystem.roundGoal["MP coop Heist"] = "ID:242210"
coopSystem.roundGoal["MP coop heavy hitter"] = "ID:242206"
coopSystem.roundGoal["SS Go the Distance"] = "GoTheDist"
coopSystem.roundGoal["SS Clean the streets"] = "CleanStr"
coopSystem.roundGoal["SS Survival"] = "Survival"
coopSystem.numRounds = {}
coopSystem.numRounds["MP coop survival race"] = {
  1,
  1,
  1
}
coopSystem.numRounds["MP CO-OP Mayhem"] = {
  1,
  1,
  1
}
coopSystem.numRounds["MP coop trial"] = {
  1,
  1,
  1
}
coopSystem.numRounds["Coop Choose Your Dare"] = {
  3,
  3,
  3
}
coopSystem.numRounds["MP coop Heist"] = {
  3,
  3,
  3
}
coopSystem.numRounds["MP coop heavy hitter"] = {
  3,
  3,
  3
}
coopSystem.numRounds["SS Go the Distance"] = {
  3,
  3,
  3
}
coopSystem.numRounds["SS Clean the streets"] = {
  3,
  3,
  3
}
coopSystem.numRounds["SS Survival"] = {
  3,
  3,
  3
}
coopSystem.objectiveTitle = {}
coopSystem.objectiveTitle["MP coop survival race"] = "ID:243140"
coopSystem.objectiveTitle["MP CO-OP Mayhem"] = "ID:243140"
coopSystem.objectiveTitle["MP coop trial"] = "ID:243140"
coopSystem.objectiveTitle["Coop Choose Your Dare"] = "ID:243140"
coopSystem.objectiveTitle["MP coop Heist"] = "ID:243140"
coopSystem.objectiveTitle["MP coop heavy hitter"] = "ID:243141"
coopSystem.objectiveTitle["SS Go the Distance"] = "GoTheDist"
coopSystem.objectiveTitle["SS Clean the streets"] = "CleanStr"
coopSystem.objectiveTitle["SS Survival"] = "Survival"
coopSystem.objectiveInfo = {}
coopSystem.objectiveInfo["MP coop survival race"] = {
  "$INFO",
  "$INFO",
  "$INFO"
}
coopSystem.objectiveInfo["MP CO-OP Mayhem"] = {
  "$INFO",
  "$INFO",
  "$INFO"
}
coopSystem.objectiveInfo["MP coop trial"] = {
  "$INFO",
  "$INFO",
  "$INFO"
}
coopSystem.objectiveInfo["Coop Choose Your Dare"] = {
  "00:60.00",
  "00:60.00",
  "00:60.00"
}
coopSystem.objectiveInfo["MP coop Heist"] = {
  {
    "00:45.00",
    "00:30.00",
    "00:30.00",
    "00:45.00"
  },
  {
    "00:30.00",
    "00:30.00",
    "00:30.00",
    "00:30.00"
  },
  {
    "00:24.00",
    "00:33.00",
    "00:27.00",
    "00:24.00"
  }
}
coopSystem.objectiveInfo["MP coop heavy hitter"] = {
  {
    "4666m",
    "5192m",
    "5490m",
    "6058m"
  },
  {
    "6309m",
    "7068m",
    "7135m",
    "7441m"
  },
  {
    "6345m",
    "7833m",
    "8454m",
    "8476m"
  }
}
coopSystem.objectiveInfo["SS Go the Distance"] = {
  {
    "4666m",
    "5192m",
    "5490m",
    "6058m"
  },
  {
    "6309m",
    "7068m",
    "7135m",
    "7441m"
  },
  {
    "6345m",
    "7833m",
    "8454m",
    "8476m"
  }
}
coopSystem.objectiveInfo["SS Clean the streets"] = {
  {
    "4666m",
    "5192m",
    "5490m",
    "6058m"
  },
  {
    "6309m",
    "7068m",
    "7135m",
    "7441m"
  },
  {
    "6345m",
    "7833m",
    "8454m",
    "8476m"
  }
}
coopSystem.objectiveInfo["SS Survival"] = {
  {
    "4666m",
    "5192m",
    "5490m",
    "6058m"
  },
  {
    "6309m",
    "7068m",
    "7135m",
    "7441m"
  },
  {
    "6345m",
    "7833m",
    "8454m",
    "8476m"
  }
}
coopSystem.roundActivity = {}
coopSystem.roundActivity["MP coop survival race"] = {
  "ID:242234",
  "ID:242235",
  "ID:242236",
  ""
}
coopSystem.roundActivity["MP CO-OP Mayhem"] = {
  "ID:242228",
  "ID:242229",
  "ID:242230",
  "ID:242231"
}
coopSystem.roundActivity["MP coop trial"] = {
  "ID:242232",
  "ID:242233",
  "",
  ""
}
coopSystem.roundActivity["Coop Choose Your Dare"] = {
  "ID:242224",
  "ID:242225",
  "ID:242226",
  "ID:242227"
}
coopSystem.roundActivity["MP coop Heist"] = {
  "ID:242237",
  "ID:242238",
  "ID:243136",
  ""
}
coopSystem.roundActivity["MP coop heavy hitter"] = {
  "ID:242220",
  "ID:242221",
  "ID:242222",
  "ID:242218"
}
coopSystem.roundActivity["SS Go the Distance"] = {
  "GoTheDist",
  "GoTheDist",
  "GoTheDist",
  "GoTheDist"
}
coopSystem.roundActivity["SS Clean the streets"] = {
  "CleanStr",
  "CleanStr",
  "CleanStr",
  "CleanStr"
}
coopSystem.roundActivity["SS Survival"] = {
  "Survival",
  "Survival",
  "Survival",
  "Survival"
}
coopSystem.gameplayTip = {}
coopSystem.gameplayTip["MP coop survival race"] = {
  "ID:242258",
  "ID:242259",
  "ID:242260",
  "ID:242261",
  "ID:242262"
}
coopSystem.gameplayTip["MP CO-OP Mayhem"] = {
  "ID:242268",
  "ID:242269",
  "ID:242270",
  "ID:242271",
  "ID:242272"
}
coopSystem.gameplayTip["MP coop trial"] = {
  "ID:242273",
  "ID:242274",
  "ID:242275",
  "ID:242276",
  "ID:242277"
}
coopSystem.gameplayTip["Coop Choose Your Dare"] = {
  "ID:242278",
  "ID:242279",
  "ID:242280",
  "ID:242281",
  "ID:242282"
}
coopSystem.gameplayTip["MP coop Heist"] = {
  "ID:242253",
  "ID:242254",
  "ID:242255",
  "ID:242256",
  "ID:242257"
}
coopSystem.gameplayTip["MP coop heavy hitter"] = {
  "ID:242263",
  "ID:242264",
  "ID:242265",
  "ID:242266",
  "ID:242267"
}
coopSystem.gameplayTip["SS Go the Distance"] = {
  "GoTheDist",
  "GoTheDist",
  "GoTheDist",
  "GoTheDist",
  "GoTheDist"
}
coopSystem.gameplayTip["SS Clean the streets"] = {
  "CleanStr",
  "CleanStr",
  "CleanStr",
  "CleanStr",
  "CleanStr"
}
coopSystem.gameplayTip["SS Survival"] = {
  "Survival",
  "Survival",
  "Survival",
  "Survival",
  "Survival"
}
coopSystem.lobbyTitle = {}
coopSystem.lobbyTitle["MP coop survival race"] = "ID:221710"
coopSystem.lobbyTitle["MP CO-OP Mayhem"] = "ID:221700"
coopSystem.lobbyTitle["MP coop trial"] = "ID:221706"
coopSystem.lobbyTitle["Coop Choose Your Dare"] = "ID:221715"
coopSystem.lobbyTitle["MP coop Heist"] = "ID:221718"
coopSystem.lobbyTitle["MP coop heavy hitter"] = "ID:221701"
coopSystem.lobbyTitle["SS Go the Distance"] = "GoTheDist"
coopSystem.lobbyTitle["SS Clean the streets"] = "CleanStr"
coopSystem.lobbyTitle["SS Survival"] = "Survival"
coopSystem.lobbyImageStrings = {}
coopSystem.lobbyImageStrings["MP coop survival race"] = {
  "ID:242190",
  "ID:242191",
  "ID:242192"
}
coopSystem.lobbyImageStrings["MP CO-OP Mayhem"] = {
  "ID:242178",
  "ID:242179",
  "ID:242180",
  "ID:242181",
  "ID:242182",
  "ID:242183"
}
coopSystem.lobbyImageStrings["MP coop trial"] = {
  "ID:242193",
  "ID:242194",
  "ID:242195",
  "ID:242196",
  "ID:242197",
  "ID:242198"
}
coopSystem.lobbyImageStrings["Coop Choose Your Dare"] = {
  "",
  "",
  ""
}
coopSystem.lobbyImageStrings["MP coop Heist"] = {
  "",
  "",
  ""
}
coopSystem.lobbyImageStrings["MP coop heavy hitter"] = {
  "",
  "",
  ""
}
coopSystem.lobbyImageStrings["SS Go the Distance"] = {
  "GoTheDist",
  "GoTheDist",
  "GoTheDist"
}
coopSystem.lobbyImageStrings["SS Clean the streets"] = {
  "CleanStr",
  "CleanStr",
  "CleanStr"
}
coopSystem.lobbyImageStrings["SS Survival"] = {
  "Survival",
  "Survival",
  "Survival"
}
coopSystem.lobbyImages = {}
coopSystem.lobbyImages["MP coop survival race"] = {
  "coop_type_01",
  "coop_type_01",
  "coop_type_01"
}
coopSystem.lobbyImages["MP CO-OP Mayhem"] = {
  "coop_type_01",
  "coop_type_01",
  "coop_type_01",
  "coop_type_01",
  "coop_type_01",
  "coop_type_01"
}
coopSystem.lobbyImages["MP coop trial"] = {
  "coop_type_01",
  "coop_type_01",
  "coop_type_01",
  "coop_type_01",
  "coop_type_01",
  "coop_type_01"
}
coopSystem.lobbyImages["Coop Choose Your Dare"] = {
  "coop_type_04",
  "coop_type_05",
  "coop_type_06"
}
coopSystem.lobbyImages["MP coop Heist"] = {
  "coop_type_07",
  "coop_type_08",
  "coop_type_09"
}
coopSystem.lobbyImages["MP coop heavy hitter"] = {
  "coop_type_01",
  "coop_type_02",
  "coop_type_03"
}
coopSystem.lobbyImages["SS Go the Distance"] = {
  "coop_type_01",
  "coop_type_02",
  "coop_type_03"
}
coopSystem.lobbyImages["SS Clean the streets"] = {
  "coop_type_01",
  "coop_type_02",
  "coop_type_03"
}
coopSystem.lobbyImages["SS Survival"] = {
  "coop_type_01",
  "coop_type_02",
  "coop_type_03"
}
coopSystem.lobbyDescription = coopSystem.roundDescription
coopSystem.debounceTable = {}
coopSystem.debounceTable.Menu_Shoulder_L2 = {false, false}
coopSystem.debounceTable.Menu_Shoulder_R2 = {false, false}
coopSystem.debounceTable.Menu_Cancel = {false, false}
coopSystem.debounceTable.Menu_ExtraFirst = {false, false}
coopSystem.debounceTable.Menu_Select = {false, false}
local heistNumCarsNeeded = {
  {
    5,
    6,
    5
  },
  {
    6,
    6,
    6
  },
  {
    5,
    6,
    6
  }
}
local takedownsNeeded = {
  {
    5,
    6,
    7
  },
  {
    6,
    8,
    10
  },
  {
    7,
    10,
    13
  }
}
coopSystem.eJump = 1
coopSystem.eDrift = 2
coopSystem.eDrive = 3
coopSystem.eOvertake = 4
coopSystem.eTag = 5
coopSystem.eSmash = 6
local findMissionNameFromIndex = function(index)
  for key, value in next, coopSystem.missionIndices, nil do
    if value == index then
      return key
    end
  end
  return "Unknown"
end
local debouncedInputRead = function(button, player, localPlayerID)
  local result = false
  if player.gamepad:status(button) == "Pressed" then
    if coopSystem.debounceTable[button][localPlayerID + 1] == true then
      result = true
    end
    coopSystem.debounceTable[button][localPlayerID + 1] = false
  else
    coopSystem.debounceTable[button][localPlayerID + 1] = true
  end
  return result
end
function removePlayerControl(player, switchToAI)
  player.controls:resetState("Player")
  if player.currentVehicle and not player.inZap and player.currentVehicle.abilityActive then
    player.currentVehicle:cancelAbility(player.localID)
  end
  player.controllerInterface:removePlayerControl(switchToAI)
  zapcontroller.EnableZapInput(false, player.localID)
  player:blockAbility("zap", true)
  player.controllerInterface:resetCallbacks()
  scoreSystem.stopAbilityDrain(player.localID, true)
  scoreSystem.stopAbilityGain(player.localID, true)
end
function givePlayerControl(player)
  player.controllerInterface:registerPlayerControl()
  zapcontroller.EnableZapInput(true, player.localID)
  player:blockAbility("zap", false)
  scoreSystem.stopAbilityDrain(player.localID, false)
  scoreSystem.stopAbilityGain(player.localID, false)
  player.controllerInterface:resetCallbacks()
end
function getHighScore(mission, difficulty)
  local result = 0
  if type(mission) == "number" then
    mission = findMissionNameFromIndex(mission)
  elseif type(mission) == "string" then
  else
    print(">> coopSystem.getHighScore :: INVALID INPUT TO MISSION : " .. tostring(mission))
  end
  if coopSystem.highScores[mission] then
    if coopSystem.highScores[mission][difficulty] then
      result = coopSystem.highScores[mission][difficulty]
    else
      print(">> coopSystem.getHighScore :: INVALID DIFFICULTY : " .. tostring(difficulty))
    end
  else
    print(">> coopSystem.getHighScore :: INVALID MISSION : " .. tostring(mission))
  end
  return result
end
function setHighScore(mission, difficulty, score)
  if type(mission) == "number" then
    mission = findMissionNameFromIndex(mission)
  elseif type(mission) == "string" then
  else
    print(">> coopSystem.setHighScore :: INVALID INPUT - MISSION : " .. tostring(mission))
  end
  if coopSystem.highScores[mission] then
    if coopSystem.highScores[mission][difficulty] then
      coopSystem.highScores[mission][difficulty] = score
      print(">> coopSystem.setHighScore :: " .. tostring(mission) .. " " .. tostring(difficulty) .. " " .. tostring(score))
    else
      print(">> coopSystem.setHighScore :: INVALID DIFFICULTY : " .. tostring(difficulty))
    end
  else
    print(">> coopSystem.setHighScore :: INVALID MISSION : " .. tostring(mission))
  end
end
function getMissionStat(mission, statIndex)
  local result = 0
  if type(mission) == "number" then
    mission = findMissionNameFromIndex(mission)
  elseif type(mission) == "string" then
  else
    print(">> coopSystem.getMissionStat :: INVALID INPUT - MISSION : " .. tostring(mission))
  end
  if coopSystem.missionStats[mission] then
    if coopSystem.missionStats[mission][statIndex] then
      result = coopSystem.missionStats[mission][statIndex]
    else
      print(">> coopSystem.getMissionStat :: INVALID STAT INDEX : " .. tostring(statIndex))
    end
  else
    print(">> coopSystem.getMissionStat :: INVALID MISSION : " .. tostring(mission))
  end
  return result
end
_G.getCoopMissionStat = getMissionStat
function setMissionStat(mission, statIndex, stat)
  if type(mission) == "number" then
    mission = findMissionNameFromIndex(mission)
  elseif type(mission) == "string" then
  else
    print(">> coopSystem.setMissionStat :: INVALID INPUT - MISSION : " .. tostring(mission))
  end
  if coopSystem.missionStats[mission] then
    if coopSystem.missionStats[mission][statIndex] then
      coopSystem.missionStats[mission][statIndex] = stat
      print(">> coopSystem.setMissionStat :: " .. tostring(mission) .. " " .. tostring(statIndex) .. " " .. tostring(stat))
    else
      print(">> coopSystem.setMissionStat :: INVALID STAT INDEX : " .. tostring(statIndex))
    end
  else
    print(">> coopSystem.setMissionStat :: INVALID MISSION : " .. tostring(mission))
  end
end
_G.setCoopMissionStat = setMissionStat
function getSelectedDifficulty()
  local result = 1
  if Network.isSplitScreenMode() then
    result = coopSystem.selectedDifficulty
  else
    result = phaseManager.networkVars.coopDifficulty
  end
  if result ~= nil then
    result = math.max(1, math.min(3, result))
  else
    result = 1
  end
  return result
end
function setSelectedDifficulty(difficulty)
  print(">> [ignored] coopSystem.setSelectedDifficulty : " .. tostring(difficulty))
end
function setSelectedMissionIndex(index)
  coopSystem.selectedMissionIndex = index
  print("------ coopSystem.setSelectedIndex : " .. tostring(index))
end
function getSelectedMissionIndex()
  return coopSystem.selectedMissionIndex
end
function unlockNitro(displayMsg, unlimited)
  if unlimited then
    zapWeaponSupport.unlimitedAbilityPoints(true)
    for localID, plr in next, localPlayerManager.players, nil do
      scoreSystem.setAbilityLevel(localID, 4)
    end
  end
  abilities.nitro.setLevel(0)
  for localID, plr in next, localPlayerManager.players, nil do
    enableAbilities(localID, true)
    plr:blockAbility("nitro", false)
    plr.controllerInterface:resetCallbacks()
  end
  print("coopSystem.unlockNitro()")
end
function lockAbilities()
  zapWeaponSupport.unlimitedAbilityPoints(false)
  for localID, plr in next, localPlayerManager.players, nil do
    scoreSystem.setAbilityLevel(localID, 1)
    plr:blockAbility("nitro", true)
    plr:blockAbility("ram", true)
    plr.controllerInterface:resetCallbacks()
  end
end
function createHud(mainType, subType, mainText, subText)
  if not Network.isSplitScreenMode() then
    feedbackSystem.menusMaster.masterSetVariable("iMissionpanel_Display", 1)
    feedbackSystem.menusMaster.masterSetVariable("iMission_Main", mainType or 0)
    feedbackSystem.menusMaster.masterSetVariable("iMission_Sub", subType or 0)
    if mainType == 1 then
      feedbackSystem.menusMaster.masterSetTextVariable("mission_bar_title", mainText or "$SCORE")
    elseif mainType == 2 then
      feedbackSystem.menusMaster.masterSetTextVariable("mission_timer_title", mainText or "$TIME")
    elseif mainType == 3 then
      feedbackSystem.menusMaster.masterSetTextVariable("mission_counter_title", mainText or "$COUNT")
    end
    if subType == 1 then
      feedbackSystem.menusMaster.masterSetTextVariable("mission_sub_bar_title", subText or "$HEALTH")
    elseif subType == 2 then
      feedbackSystem.menusMaster.masterSetTextVariable("mission_sub_timer_title", subText or "$TIME")
    elseif subType == 3 then
      feedbackSystem.menusMaster.masterSetTextVariable("mission_sub_counter_title", subText or "$COUNT")
    elseif subType == 4 then
      feedbackSystem.menusMaster.masterSetTextVariable("mission_sub_timer_title", subText or "$TIME")
    elseif subType == 5 then
      feedbackSystem.menusMaster.masterSetTextVariable("mission_sub_counter_title", subText or "$Count")
    end
  end
end
local coopPanels
local timerFlashTime = 10
timerFlash = false
function setupHUD(bTimer, bar1, bar2)
  if not Network.isSplitScreenMode() then
    feedbackSystem.menusMaster.masterSetVariable("L_iHide_All", 0)
    if bTimer then
      feedbackSystem.menusMaster.masterSetVariable("iCoop_mission_panel_timer", 1)
      feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_1_timer_title", "$TIMER")
      coopSystem.timerFlash = false
      feedbackSystem.menusMaster.masterSetVariable("iCoop_mission_panel_timer_urgent", 0)
    end
    if bar1 then
      if bar1.bScore then
        feedbackSystem.menusMaster.masterSetVariable("iCoop_mission_panel_progress_bar", 1)
        feedbackSystem.menusMaster.masterSetTextVariable("coop_mission_panel_title_2", bar1.scoreTitle)
      else
        feedbackSystem.menusMaster.masterSetVariable("iCoop_mission_panel_lap_counter", 1)
        feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_2_bar_title", bar1.barTitle or bar1.iconTitle)
        feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_2_counter_current", bar1.currentValue)
        feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_2_counter_slash", "/")
        feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_2_counter_total", bar1.totalValue)
        coopPanels = coopPanels or {}
        coopPanels[bar1.slot] = {}
        coopPanels[bar1.slot].currentCount = 0
      end
    end
    if bar2 then
    end
  end
end
function finishHUD()
  coopData.isSplitScreenMode = Network.isSplitScreenMode()
end
function cleanupHUD()
  if coopData.isSplitScreenMode then
    coopSystem.ss_hud.removeAll()
    feedbackSystem.removeTimerSS()
  else
    feedbackSystem.menusMaster.splitscreenSetVariable("iCoop_team_score", 0)
    feedbackSystem.menusMaster.splitscreenSetVariable("iCoop_mission_panel_timer", 0)
    feedbackSystem.menusMaster.splitscreenSetVariable("iCoop_mission_panel_lap_counter", 0)
  end
  coopPanels = nil
  print("coopSystem.cleanupHUD() done.")
end
function addMarkerToVehicle(instance, actorName, color, targetVisible, showDistance, hideMinimap, gadgetType, minimapGadgetType, text, animation)
  local vehicle = instance.taskObjectsByActorID[actorName]
  if coopData.blipsTable[actorName] == nil then
    coopData.blipsTable[actorName] = {}
  end
  if not vehicle then
    return
  end
  if color == coopData.colors.brightwhite then
    local destinationTargetMarker = markerCreateWrapper({
      type = "Target",
      gameVehicle = vehicle.coreData.agent.gameVehicle,
      gadgetID = 15,
      colour = blipColour or coopData.colors.brightwhite,
      radius = 40,
      visible = true,
      showDistance = true,
      targetType = "Destination"
    })
    local destinationMinimapMarker = markerCreateWrapper({
      type = "Minimap",
      gameVehicle = vehicle.coreData.agent.gameVehicle,
      gadgetID = 15,
      colour = blipColour or coopData.colors.brightwhite,
      radius = 25,
      visible = true,
      canrotate = false
    })
    table.insert(coopData.blipsTable[actorName], destinationTargetMarker)
    table.insert(coopData.blipsTable[actorName], destinationMinimapMarker)
  else
    local blip = markerCreateWrapper({
      type = "Target",
      animationType = animation or nil,
      gameVehicle = vehicle.coreData.agent.gameVehicle,
      gadgetID = gadgetType or 51,
      colour = color or coopData.colors.blue,
      radius = 45,
      visible = targetVisible == nil or targetVisible == true,
      showDistance = showDistance == nil or showDistance == true,
      attachedText = tostring(text) or ""
    })
    if coopData.blipsTable[actorName] == nil then
      coopData.blipsTable[actorName] = {}
    end
    table.insert(coopData.blipsTable[actorName], blip)
    if not hideMinimap then
      local minimapBlip = markerCreateWrapper({
        type = "Minimap",
        gameVehicle = vehicle.coreData.agent.gameVehicle,
        gadgetID = minimapGadgetType or 3,
        colour = color or coopData.colors.blue,
        radius = 30,
        visible = true,
        canrotate = true
      })
      table.insert(coopData.blipsTable[actorName], minimapBlip)
    end
  end
end
function addMarkerCircleToVehicle(instance, actorName)
  local vehicle = instance.taskObjectsByActorID[actorName]
  if not vehicle then
    return
  end
  if coopData.blipsTable[actorName] == nil then
    coopData.blipsTable[actorName] = {}
  end
  local minimapBlip = markerCreateWrapper({
    type = "Minimap",
    constrain = false,
    gameVehicle = vehicle.coreData.agent.gameVehicle,
    gadgetID = 82,
    colour = vec.vector(255, 0, 0, 127),
    radius = 140,
    visible = true,
    canrotate = false
  })
  table.insert(coopData.blipsTable[actorName], minimapBlip)
end
function spawnMissionVehicleXYZHeading(instance, actorName, vecXYZPosition, headingAngle, vehicleModelOverride)
  local vehicleActor = instance.challenge.actorPool[actorName]
  local vehicleSpawn = vehicleManager.spawnVehicle({
    position = vecXYZPosition,
    heading = headingAngle,
    modelID = vehicleModelOverride or vehicleActor.modelID,
    shader = vehicleActor.shaderParams
  })
  instance:newActorFromAgent(vehicleActor.ID, vehicleSpawn)
  return vehicleSpawn
end
function displayScreenPrompt(textString, displaySetting, playerID)
  if not textString then
    print(">> CoopScriptSystem.lua, displayScreenPrompt - Invalid String")
    return
  end
  feedbackSystem.menusMaster.masterSetTextVariable("prompt_secondary_button", "")
  feedbackSystem.menusMaster.masterSetTextVariable("prompt_secondary", textString)
  feedbackSystem.menusMaster.masterSetVariable("iPrompt_Secondary_Display", displaySetting or 2)
end
function clearSSScreenPrompt(user)
  local display = "iSS_p" .. user .. "_instruct"
  feedbackSystem.menusMaster.splitscreenSetVariable(display, 0)
end
function displaySplitScreenPrompt(user, textString, param1, param2)
  if not textString then
    print(">> CoopScriptSystem.lua, displayScreenPrompt - Invalid String")
    return
  end
  assert(user >= 1 and user <= 2, "user number is out of range 1-2.  user: " .. tostring(user))
  local display = "iSS_p" .. user .. "_instruct"
  feedbackSystem.menusMaster.masterSetVariable(display, 1)
  display = "ss_p" .. user .. "_instruct"
  Menu.SetTextVariable("Master", display, textString, param1, param2)
  coopSystem.doWaitCallback(3.5, clearSSScreenPrompt, nil, user)
end
function endDisplayTrophyIcon()
  feedbackSystem.menusMaster.splitscreenSetVariable("iCoop_trophy_show", 0)
end
function displayTrophyIcon(trophyColour)
  feedbackSystem.menusMaster.splitscreenSetVariable("iCoop_trophy_show", 1)
  feedbackSystem.menusMaster.splitscreenSetVariable("iCoop_trophy_anim", 1)
  feedbackSystem.menusMaster.splitscreenSetVariable("iCoop_trophy_settle", 1)
  doWaitCallback(2, endDisplayTrophyIcon)
end
function onMedalAchieved(medal)
  local medalText
  if medal == 1 then
    medalText = "ID:235411"
  elseif medal == 2 then
    medalText = "ID:235410"
  elseif medal == 3 then
    medalText = "ID:235409"
  elseif medal == 4 then
    medalText = "ID:235412"
  end
end
function explodeVehicle(gameVehicle, power)
  GameVehicleResource.applyDamage({gameVehicle = gameVehicle, damage = 1})
end
b_EnableSplitScreen = 0
function enableSplitScreen(enable)
  b_EnableSplitScreen = enable
end
function IsSplitScreenEnabled()
  return b_EnableSplitScreen == 1
end
_G.IsSplitScreenEnabled = IsSplitScreenEnabled
_G.enableSplitScreen = enableSplitScreen
function createNewLocalPlayer()
  local localID = localPlayerManager.numberOfPlayers
  if localID > 1 then
    return
  end
  local new_cam = CameraSystem.CreateCamera()
  new_cam.viewport = 1
  local matrix2 = vec.matrix()
  matrix2[3] = configSelector.launchConfig.StartPoint
  matrix2[3][2] = matrix2[3][2] + 1
  new_cam.matrix = matrix2
  new_cam.aspect_ratio = 0.8888889
  local new_player = deepCopy(localPlayer)
  new_player.controls = deepCopy(controlHandler)
  new_player.gamepad = controller.getPad("GAMEPAD" .. tostring(localID + 1))
  new_player.controls.pad = new_player.gamepad
  new_player.camera = new_cam
  new_player.camName = "Game Cam " .. tostring(localID + 1)
  new_player.localID = localID
  new_player.controllerInterface.parent = new_player
  new_player.scoring.parent = new_player
  new_player.missionSupport.parent = new_player
  new_player.minimapSupport.parent = new_player
  new_player.position = vec.vector()
  new_player.shadowName = "SecondaryViewport"
  function new_player.getTaskObject()
    return new_player.missionSupport:getMainTaskObject()
  end
  if savedLocalPlayerSettings[localID] then
    new_player.currentMode = savedLocalPlayerSettings[localID].camera.currentMode
    new_player.cameraMode = savedLocalPlayerSettings[localID].camera.cameraMode
  end
  new_player.playerID = localID
  localPlayerManager.addPlayer(new_player)
  playerManager.addPlayer(new_player)
  spoolsystem.AddSpoolCentre(configSelector.launchConfig.StartVehiclePosition)
  PIP.SplitScreenActivate()
  zapcontroller.setZapCameraLocks(localID, {
    missile = false,
    low = false,
    mid = false,
    high = false,
    top = false
  })
  player.setAttachment(new_player.localID, new_player.camera)
  new_player.controls:setState("zap")
  OnlineModeSettings.onlineDisableAssert = true
  new_player:SetZapLevel(4)
  OnlineModeSettings.onlineDisableAssert = false
  zap.setDefaultZapSettingsForPlayer(localID, true)
  return new_player
end
_G.createNewLocalPlayer = createNewLocalPlayer
function deleteLocalPlayer(localID)
  zap.setDefaultZapSettingsForPlayer(0, false)
  if localPlayerManager.players[localID] then
    local new_player = localPlayerManager.players[localID]
    if localID == 1 then
      saveLocalPlayerSettings(localID)
    end
    localPlayerManager.removePlayer(new_player)
    PIP.SplitScreenDeactivate()
    new_player.controllerInterface:removeCallbacks()
    new_player.controllerInterface:removePlayerControl()
    controlHandler:clearInput(localID)
    new_player:purge()
    local scriptCam = cameraController.getCamera(new_player.camName)
    if scriptCam then
      cameraController.deleteCam(scriptCam)
    end
    new_player.camera:delete()
    playerManager.removePlayer(new_player)
    spoolsystem.RemoveSpoolCentre(new_player.localID)
    new_player = nil
  end
end
_G.deleteNewLocalPlayer = deleteLocalPlayer
savedLocalPlayerSettings = {}
function saveLocalPlayerSettings(localID)
  local player = localPlayerManager.players[localID]
  local saved_camera = {}
  saved_camera.currentMode = player.currentMode
  saved_camera.cameraMode = player.cameraMode
  savedLocalPlayerSettings[localID] = {}
  savedLocalPlayerSettings[localID].camera = saved_camera
end
local getIDFunction
local _getUID = function()
  local startUID = 17000
  local range = 1000
  local uid = startUID - 1
  return function()
    uid = uid + 1
    if uid >= startUID + range then
      uid = startUID
    end
    return uid
  end
end
getIDFunction = _getUID()
function generateUID()
  local result = getIDFunction()
  return result
end
function doWaitCallback(waitTime, callback, nameOverride, ...)
  local waitEnd = g_NetworkTime + waitTime
  local uid = generateUID()
  local updateName = (nameOverride or "waitUpdate") .. tostring(uid)
  addUserUpdateFunction(updateName, function()
    if g_NetworkTime >= waitEnd then
      removeUserUpdateFunction(updateName)
      if callback then
        coopSystem.removeTimer(updateName)
        callback(unpack(arg))
      end
    end
  end, 1)
  table.insert(coopSystem.timers, updateName)
  return updateName
end
function removeTimer(timerName, searchGroup)
  for i, entry in pairs(coopSystem.timers) do
    if not searchGroup then
      if timerName == entry then
        removeUserUpdateFunction(timerName)
        coopSystem.timers[i] = nil
        return true
      end
    elseif string.match(entry, timerName, 1) then
      print(">> coopSystem.removeTimer GROUP MATCH! " .. entry .. " / " .. timerName)
      removeUserUpdateFunction(entry)
      coopSystem.timers[i] = nil
    else
      print(">> coopSystem.removeTimer GROUP NO MATCH! " .. entry .. " / " .. timerName)
    end
  end
end
function removeAllTimers()
  for i, entry in pairs(coopSystem.timers) do
    print(">> coopSystem.removeAllTimers " .. entry)
    removeUserUpdateFunction(entry)
  end
  coopSystem.timers = {}
end
function purge()
  print("PURGE: coopSystem")
  coopSystem.removeAllTimers()
end
local HideWillPowerDisc = function()
  feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 0)
end
function hideAllHUD()
  coopSystem.ss_hud.hideAll()
end
function showAllHUD()
end
lobbyScreen = {}
lobbyScreen.inLobbyScreen = false
lobbyScreen.everyBodyReady = false
lobbyScreen.startCountdown = 0
lobbyScreen.playerReady = {false, false}
lobbyScreen.readyCallback = nil
lobbyScreen.missionName = nil
lobbyScreen.currentNumPlayers = 0
lobbyScreen.neededNumPlayers = 0
lobbyScreen.returnPartyToBusCalled = false
lobbyScreen.firstFrame = true
lobbyScreen.imageIndex = 1
function lobbyScreen.IsLobbyScreenActive()
  return lobbyScreen.inLobbyScreen
end
function lobbyScreen.EnterLobbyScreen(numPlayers, numPlayersNeeded, newReadyCallback)
  lobbyScreen.inLobbyScreen = true
  if phaseManager.isLocal then
    phaseManager.networkVars.playersReady = 0
  end
  lobbyScreen.missionName = phaseManager.playlistSupport.getCurrentMission()
  lobbyScreen.everyBodyReady = false
  lobbyScreen.imageIndex = 1
  lobbyScreen.returnPartyToBusCalled = false
  lobbyScreen.firstFrame = true
  lobbyScreen.playerReady = {false, false}
  lobbyScreen.bLoading = true
  addUserUpdateFunction("CoopLobbyUpdate", lobbyScreen.UpdateLobby, 2)
  if lobbyScreen.missionName == "MP coop Heist" then
    propSystem.disablePropType("DO_NOT_USE_shutter_A", "DO_NOT_USE_shutter_B", "DO_NOT_USE_Wall_A")
    Atlas.JerichoAlleyWayActive(true)
  end
  Menu.UnloadMPImages()
  local images = coopSystem.lobbyImages[lobbyScreen.missionName]
  Menu.LoadMPUnlockImage(images[lobbyScreen.imageIndex])
  Menu.DisplayMPUnlock(images[lobbyScreen.imageIndex])
  lobbyScreen.UpdateLobbyData(numPlayers, numPlayersNeeded, newReadyCallback)
end
function lobbyScreen.UpdateLobby()
  if lobbyScreen.bLoading then
    feedbackSystem.menusMaster.masterSetTextVariable("controls_button_line_8", "")
    feedbackSystem.menusMaster.masterSetTextVariable("round_results_prompt", "ID:241356")
  else
    feedbackSystem.menusMaster.masterSetTextVariable("controls_button_line_8", "D")
    feedbackSystem.menusMaster.masterSetTextVariable("round_results_prompt", "ID:242251")
  end
  if lobbyScreen.firstFrame then
    lobbyScreen.firstFrame = false
    feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_lobby_title", coopSystem.lobbyTitle[lobbyScreen.missionName])
    feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_lobby_title_2", coopSystem.lobbyDescription[lobbyScreen.missionName])
    local imageStrings = coopSystem.lobbyImageStrings[lobbyScreen.missionName]
    feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_lobby_hint", imageStrings[lobbyScreen.imageIndex])
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_lobby_display", 1)
  end
  local images = coopSystem.lobbyImages[lobbyScreen.missionName]
  for localPlayerID, player in next, localPlayerManager.players, nil do
    local imageStrings = coopSystem.lobbyImageStrings[lobbyScreen.missionName]
    local numImages = #images
    if debouncedInputRead("Menu_Shoulder_L2", player, localPlayerID) then
      lobbyScreen.imageIndex = 1 + math.mod(lobbyScreen.imageIndex + numImages - 2, numImages)
      print("Display image " .. tostring(lobbyScreen.imageIndex) .. " " .. tostring(imageStrings[lobbyScreen.imageIndex]))
      feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_lobby_hint", imageStrings[lobbyScreen.imageIndex])
      Menu.UnloadMPImages()
      Menu.LoadMPUnlockImage(images[lobbyScreen.imageIndex])
    end
    if debouncedInputRead("Menu_Shoulder_R2", player, localPlayerID) then
      lobbyScreen.imageIndex = 1 + math.mod(lobbyScreen.imageIndex, numImages)
      print("Display image " .. tostring(lobbyScreen.imageIndex) .. " " .. tostring(imageStrings[lobbyScreen.imageIndex]))
      feedbackSystem.menusMaster.splitscreenSetTextVariable("ss_lobby_hint", imageStrings[lobbyScreen.imageIndex])
      Menu.UnloadMPImages()
      Menu.LoadMPUnlockImage(images[lobbyScreen.imageIndex])
    end
  end
  Menu.DisplayMPUnlock(images[lobbyScreen.imageIndex])
  for localPlayerID, player in next, localPlayerManager.players, nil do
    if debouncedInputRead("Menu_Cancel", player, localPlayerID) and lobbyScreen.returnPartyToBusCalled == false and Network.isPartyLeader() then
      lobbyScreen.returnPartyToBusCalled = true
      lobbyScreen.ExitLobbyScreen()
      Network.returnPartyToBus()
    end
  end
  local ready = false
  if lobbyScreen.bLoading == false and currentNumPlayers == neededNumPlayers then
    for localPlayerID, player in next, localPlayerManager.players, nil do
      local ready = false
      local button = "Menu_ExtraFirst"
      if Network.isSplitScreenMode() then
        button = "Menu_Select"
      end
      if debouncedInputRead(button, player, localPlayerID) then
        ready = true
      end
      if ready and not lobbyScreen.playerReady[localPlayerID + 1] then
        lobbyScreen.playerReady[localPlayerID + 1] = true
        phaseManager.sendMessage(8, player.playerID + 1)
      end
    end
  end
  local everybodyReadyNow = false
  if Network.isSplitScreenMode() then
    if phaseManager.networkVars.playersReady > 0 then
      everybodyReadyNow = true
    end
  elseif phaseManager.networkVars.playersReady == 3 then
    everybodyReadyNow = true
  end
  if everybodyReadyNow and not lobbyScreen.everyBodyReady then
    lobbyScreen.everyBodyReady = true
    lobbyScreen.startCountdown = g_NetworkTime
  end
  local countdownLength = 0
  local countdown = countdownLength
  if lobbyScreen.everyBodyReady then
    countdown = countdownLength - (g_NetworkTime - lobbyScreen.startCountdown)
    countdown = math.max(countdown, 0)
    if countdown == 0 and lobbyScreen.readyCallback ~= nil then
      lobbyScreen.readyCallback()
      lobbyScreen.readyCallback = nil
    end
  end
end
function lobbyScreen.UpdateLobbyPlayerData(numPlayers, numPlayersNeeded)
  lobbyScreen.currentNumPlayers = numPlayers
  lobbyScreen.neededNumPlayers = numPlayersNeeded
end
function lobbyScreen.UpdateLobbyData(bLoading, newReadyCallback)
  lobbyScreen.readyCallback = newReadyCallback
  lobbyScreen.bLoading = bLoading
end
function lobbyScreen.ExitLobbyScreen()
  lobbyScreen.inLobbyScreen = false
  removeUserUpdateFunction("CoopLobbyUpdate")
  lobbyScreen.everyBodyReady = false
  lobbyScreen.playerReady = {false, false}
  lobbyScreen.readyCallback = nil
  Menu.UnloadMPImages()
  feedbackSystem.menusMaster.splitscreenSetVariable("iSS_lobby_display", 0)
end
matchResultsScreen = {}
matchResultsScreen.everyBodyReady = false
matchResultsScreen.playerReady = {false, false}
matchResultsScreen.screen = 1
matchResultsScreen.localPlayerQuit = false
matchResultsScreen.somebodyQuit = false
matchResultsScreen.newHighScore = false
matchResultsScreen.medal = 0
matchResultsScreen.oldMedal = 0
matchResultsScreen.newMedal = false
matchResultsScreen.scoreTip = "$ScoreTip"
matchResultsScreen.p1RoundScore = {
  -1,
  -1,
  -1,
  -1
}
matchResultsScreen.p2RoundScore = {
  -1,
  -1,
  -1,
  -1
}
matchResultsScreen.oldHighScore = 0
matchResultsScreen.p1MatchScore = 0
matchResultsScreen.p2MatchScore = 0
matchResultsScreen.readyCallback = nil
matchResultsScreen.firstFrame = false
matchResultsScreen.missionName = "MP coop Heist"
matchResultsScreen.startTimer = 0
matchResultsScreen.winLoseTimer = 3
function matchResultsScreen.EnterMatchResults(newReadyCallback)
  hideAllHUD()
  PauseMenu.allow(false)
  matchResultsScreen.returnToBusCalled = false
  matchResultsScreen.everyBodyReady = false
  matchResultsScreen.playerReady = {false, false}
  matchResultsScreen.screen = 1
  matchResultsScreen.localPlayerQuit = false
  matchResultsScreen.somebodyQuit = false
  matchResultsScreen.newHighScore = false
  matchResultsScreen.firstFrame = true
  matchResultsScreen.readyCallback = newReadyCallback
  matchResultsScreen.startTimer = g_NetworkTime
  if phaseManager.isLocal then
    phaseManager.networkVars.playersReady = 0
  end
  matchResultsScreen.difficulty = coopSystem.getSelectedDifficulty()
  local hints = coopSystem.gameplayTip[matchResultsScreen.missionName]
  if hints ~= nil then
    matchResultsScreen.scoreTip = hints[framework.random(1, #hints)]
  else
    matchResultsScreen.scoreTip = "$Please set matchResultsScreen.missionName"
  end
  addUserUpdateFunction("EndCoopRetryScreen", matchResultsScreen.UpdateMatchResults, 2)
end
function matchResultsScreen.UpdateMatchResults()
  local nextScreen = false
  if matchResultsScreen.screen == 1 then
    local countdown = matchResultsScreen.winLoseTimer - (g_NetworkTime - matchResultsScreen.startTimer)
    if countdown <= 0 then
      nextScreen = true
    end
  elseif matchResultsScreen.screen == 2 or matchResultsScreen.screen == 3 then
    for localPlayerID, player in next, localPlayerManager.players, nil do
      local buttons = {
        "Menu_Select",
        "Menu_ExtraFirst"
      }
      for i, v in ipairs(buttons) do
        if debouncedInputRead(v, player, localPlayerID) then
          nextScreen = true
        end
      end
    end
  else
    for localPlayerID, player in next, localPlayerManager.players, nil do
      local ready = false
      local buttons = {
        "Menu_ExtraFirst"
      }
      for i, v in ipairs(buttons) do
        if player.gamepad:status(v) == "Pressed" then
          print("Player ready " .. tostring(v))
          ready = true
        end
      end
      local playerWantsToQuit = true
      if player.gamepad:status("Menu_ExtraFirst") == "Pressed" then
        print("Retrying old mission")
        ProfileSettings.SplitscreenRetryMission()
      end
      if playerWantsToQuit and not matchResultsScreen.localPlayerQuit then
        matchResultsScreen.localPlayerQuit = true
        if matchResultsScreen.readyCallback ~= nil then
          matchResultsScreen.readyCallback()
          matchResultsScreen.readyCallback = nil
        end
        phaseManager.sendMessage(8, 100)
      end
      if ready and not matchResultsScreen.playerReady[localPlayerID + 1] then
        matchResultsScreen.playerReady[localPlayerID + 1] = true
        phaseManager.sendMessage(8, player.playerID + 1)
      end
    end
    local everybodyReadyNow = phaseManager.networkVars.playersReady == 3
    if everybodyReadyNow and not matchResultsScreen.everyBodyReady then
      matchResultsScreen.everyBodyReady = true
      if matchResultsScreen.readyCallback ~= nil then
        matchResultsScreen.readyCallback()
        matchResultsScreen.readyCallback = nil
      end
    end
  end
  matchResultsScreen.somebodyQuit = phaseManager.networkVars.playersReady > 99
  if nextScreen then
    if matchResultsScreen.screen == 1 then
      feedbackSystem.menusMaster.splitscreenSetVariable("iMulti_MatchResult", 0)
      matchResultsScreen.screen = 2
      matchResultsScreen.firstFrame = true
    elseif matchResultsScreen.screen == 2 then
      if matchResultsScreen.newHighScore then
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_match_results_high_score", 0)
      end
      if matchResultsScreen.newMedal then
        matchResultsScreen.screen = 3
      else
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_match_results_display", 0)
        matchResultsScreen.screen = 4
      end
      matchResultsScreen.firstFrame = true
    elseif matchResultsScreen.screen == 3 then
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_match_results_display", 0)
      matchResultsScreen.screen = 4
      matchResultsScreen.firstFrame = true
    end
  end
  local debugColour = vec.vector(0, 1, 0, 1)
  local debugPos1 = vec.vector(0.45, 0.3, 0, 1)
  local debugPos2 = vec.vector(0.45, 0.35, 0, 1)
  local debugPos3 = vec.vector(0.45, 0.4, 0, 1)
  local debugPos4 = vec.vector(0.45, 0.45, 0, 1)
  local debugPos5 = vec.vector(0.45, 0.5, 0, 1)
  local debugPos6 = vec.vector(0.45, 0.55, 0, 1)
  local debugPos7 = vec.vector(0.45, 0.6, 0, 1)
  local debugPos8 = vec.vector(0.45, 0.65, 0, 1)
  local debugPos9 = vec.vector(0.45, 0.7, 0, 1)
  local timeOnScreen = 0.033
  local textScale = 1
  if matchResultsScreen.screen == 1 then
    if matchResultsScreen.firstFrame == true then
      matchResultsScreen.firstFrame = false
      local coopCompleteData, string1, string2 = onlineScreenManager.getCoopCompleteData()
      local screenType = 1
      if coopCompleteData then
        screenType = 2
      end
      if screenType == 2 then
        feedbackSystem.menusMaster.masterSetTextVariable("multi_you_won", string1)
        feedbackSystem.menusMaster.masterSetTextVariable("multi_won_description", string2)
      else
        feedbackSystem.menusMaster.masterSetTextVariable("multi_you_lost", string1)
        feedbackSystem.menusMaster.masterSetTextVariable("multi_lost_description", string2)
        feedbackSystem.menusMaster.masterSetTextVariable("multi_lost_place", "")
      end
      feedbackSystem.menusMaster.splitscreenSetVariable("iMulti_MatchResult", screenType)
    end
  elseif matchResultsScreen.screen == 2 then
    if matchResultsScreen.firstFrame == true then
      matchResultsScreen.firstFrame = false
      matchResultsScreen.matchScore = CoopScoringSystem.getScoreTotal()
      local playerScores = CoopScoringSystem.getPlayerScores()
      print("final playerScores p1 " .. tostring(playerScores[1]) .. " p2 " .. tostring(playerScores[2]))
      matchResultsScreen.p1MatchScore = playerScores[1]
      matchResultsScreen.p2MatchScore = playerScores[2]
      local missionIndex = coopSystem.getSelectedMissionIndex()
      if 1 < localPlayerManager.numberOfPlayers then
        matchResultsScreen.oldHighScore = ProfileSettings.GetSplitScreenCoopHighScore(missionIndex, difficulty)
        if matchResultsScreen.matchScore > matchResultsScreen.oldHighScore then
          print("New high score - old score=" .. tostring(matchResultsScreen.oldHighScore) .. " new score=" .. tostring(matchResultsScreen.matchScore))
          print("New high score - missionIndex=" .. tostring(missionIndex) .. " difficulty=" .. tostring(difficulty))
          ProfileSettings.SetSplitScreenCoopHighScore(missionIndex, difficulty, matchResultsScreen.matchScore)
          matchResultsScreen.newHighScore = true
        end
      else
        matchResultsScreen.oldHighScore = 0
      end
      ProfileSettings.TriggerAutoSave()
      local medalScores = coopSystem.medalScores[matchResultsScreen.missionName][matchResultsScreen.difficulty]
      matchResultsScreen.oldMedal = 0
      matchResultsScreen.medal = 0
      for index, value in next, medalScores, nil do
        if value <= matchResultsScreen.matchScore then
          matchResultsScreen.medal = index
        end
        if value <= matchResultsScreen.oldHighScore then
          matchResultsScreen.oldMedal = index
        end
      end
      local p1FinalRoundScore = matchResultsScreen.p1MatchScore
      local p2FinalRoundScore = matchResultsScreen.p2MatchScore
      local iFinalRound = 1
      for iRound = 1, 4 do
        local p1RoundScore = matchResultsScreen.p1RoundScore[iRound]
        if type(p1RoundScore) == "number" and p1RoundScore >= 0 then
          iFinalRound = iRound + 1
          p1FinalRoundScore = p1FinalRoundScore - p1RoundScore
        end
        local p2RoundScore = matchResultsScreen.p2RoundScore[iRound]
        if type(p2RoundScore) == "number" and p2RoundScore >= 0 then
          p2FinalRoundScore = p2FinalRoundScore - p2RoundScore
        end
      end
      matchResultsScreen.p1RoundScore[iFinalRound] = p1FinalRoundScore
      matchResultsScreen.p2RoundScore[iFinalRound] = p2FinalRoundScore
      feedbackSystem.menusMaster.masterSetTextVariable("rr_match_title_1", "ID:242240")
      feedbackSystem.menusMaster.masterSetTextVariable("rr_match_score_title", "ID:220601")
      feedbackSystem.menusMaster.masterSetTextVariable("rr_gamertag_p1", SplitScreen.getPlayerName(0))
      feedbackSystem.menusMaster.masterSetTextVariable("rr_gamertag_p2", SplitScreen.getPlayerName(1))
      Menu.SetTextVariable("Master", "rr_round_1", "ID:242242", 1)
      Menu.SetTextVariable("Master", "rr_round_2", "ID:242242", 2)
      Menu.SetTextVariable("Master", "rr_round_3", "ID:242242", 3)
      Menu.SetTextVariable("Master", "rr_round_4", "")
      for iRound = 1, 4 do
        if 0 > matchResultsScreen.p1RoundScore[iRound] then
          matchResultsScreen.p1RoundScore[iRound] = "ID:242252"
        end
        if 0 > matchResultsScreen.p2RoundScore[iRound] then
          matchResultsScreen.p2RoundScore[iRound] = "ID:242252"
        end
      end
      feedbackSystem.menusMaster.masterSetTextVariable("rr_round_score_1_p1", matchResultsScreen.p1RoundScore[1])
      feedbackSystem.menusMaster.masterSetTextVariable("rr_round_score_2_p1", matchResultsScreen.p1RoundScore[2])
      feedbackSystem.menusMaster.masterSetTextVariable("rr_round_score_3_p1", matchResultsScreen.p1RoundScore[3])
      feedbackSystem.menusMaster.masterSetTextVariable("rr_round_score_4_p1", "")
      feedbackSystem.menusMaster.masterSetTextVariable("rr_round_score_1_p2", matchResultsScreen.p2RoundScore[1])
      feedbackSystem.menusMaster.masterSetTextVariable("rr_round_score_2_p2", matchResultsScreen.p2RoundScore[2])
      feedbackSystem.menusMaster.masterSetTextVariable("rr_round_score_3_p2", matchResultsScreen.p2RoundScore[3])
      feedbackSystem.menusMaster.masterSetTextVariable("rr_round_score_4_p2", "")
      feedbackSystem.menusMaster.masterSetTextVariable("rr_total_title", "ID:242219")
      feedbackSystem.menusMaster.masterSetTextVariable("rr_total_score", matchResultsScreen.matchScore)
      feedbackSystem.menusMaster.masterSetTextVariable("rr_game_hint", matchResultsScreen.scoreTip)
      feedbackSystem.menusMaster.masterSetTextVariable("round_results_prompt", "ID:242251")
      feedbackSystem.menusMaster.masterSetTextVariable("controls_button_line_5", "A")
      feedbackSystem.menusMaster.masterSetTextVariable("controls_button_line_8", "D")
      feedbackSystem.menusMaster.masterSetTextVariable("rr_high_score_title", "ID:242241")
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_match_results_display", 1)
      if matchResultsScreen.newHighScore then
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_match_results_high_score", 1)
      end
    end
  elseif matchResultsScreen.screen == 3 then
    if matchResultsScreen.firstFrame == true then
      matchResultsScreen.firstFrame = false
      local medalName = coopSystem.medalNames[matchResultsScreen.medal]
      if matchResultsScreen.medal == 1 then
        Menu.SetTextVariable("Master", "rr_medal_score_title", "ID:235408", "ID:235411")
      elseif matchResultsScreen.medal == 2 then
        Menu.SetTextVariable("Master", "rr_medal_score_title", "ID:235408", "ID:235410")
      elseif matchResultsScreen.medal == 3 then
        Menu.SetTextVariable("Master", "rr_medal_score_title", "ID:235408", "ID:235409")
      elseif matchResultsScreen.medal == 4 then
        Menu.SetTextVariable("Master", "rr_medal_score_title", "ID:235408", "ID:235412")
      end
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_match_results_high_medal", 1)
    end
  elseif matchResultsScreen.screen == 4 then
  end
end
function matchResultsScreen.ExitMatchResults()
  removeUserUpdateFunction("EndCoopRetryScreen")
end
roundResultsScreen = {}
roundResultsScreen.playerReady = {false, false}
roundResultsScreen.everyBodyReady = false
roundResultsScreen.readyCallback = nil
roundResultsScreen.missionName = nil
roundResultsScreen.firstFrame = true
roundResultsScreen.roundOn = 1
roundResultsScreen.roundPlayerScores = {0, 0}
roundResultsScreen.roundScore = 0
roundResultsScreen.screen = 2
roundResultsScreen.activity_1_p1 = 0
roundResultsScreen.activity_2_p1 = 0
roundResultsScreen.activity_3_p1 = 0
roundResultsScreen.activity_4_p1 = 0
roundResultsScreen.activity_1_p2 = 0
roundResultsScreen.activity_2_p2 = 0
roundResultsScreen.activity_3_p2 = 0
roundResultsScreen.activity_4_p2 = 0
roundResultsScreen.timebonus_p1 = 42
roundResultsScreen.timebonus_p2 = 66
roundResultsScreen.startTimer = 0
roundResultsScreen.winLoseTimer = 3
roundResultsScreen.spoolPoint = nil
roundResultsScreen.bLoading = true
function roundResultsScreen.EnterRoundResultsScreen(challengeInstance, newReadyCallback)
  local myChallenge = challengeInstance.challenge
  PauseMenu.allow(false)
  hideAllHUD()
  if Network.isSplitScreenMode() then
    PauseMenu.allow(false)
    NetworkLog.Write(">[LUA] - PauseMenu.allow ( true ) ")
  end
  if phaseManager.isLocal then
    phaseManager.networkVars.playersReady = 0
    print("EnterRoundResultsScreen() phaseManager.networkVars.playersReady " .. tostring(phaseManager.networkVars.playersReady))
  end
  print("round results scores p1 " .. tostring(roundResultsScreen.roundPlayerScores[1]) .. " p2 " .. tostring(roundResultsScreen.roundPlayerScores[2]))
  matchResultsScreen.p1RoundScore[roundResultsScreen.roundOn] = roundResultsScreen.roundPlayerScores[1]
  matchResultsScreen.p2RoundScore[roundResultsScreen.roundOn] = roundResultsScreen.roundPlayerScores[2]
  if roundResultsScreen.spoolPoint ~= nil then
    for id, player in next, localPlayerManager.players, nil do
      zapcontroller.ZapCameraSetTargetPos(roundResultsScreen.spoolPoint.x, roundResultsScreen.spoolPoint.z, id)
    end
    roundResultsScreen.bLoading = true
  else
    roundResultsScreen.bLoading = false
  end
  roundResultsScreen.missionName = challengeInstance.challenge.name
  roundResultsScreen.firstFrame = true
  roundResultsScreen.startTimer = g_NetworkTime
  roundResultsScreen.screen = 2
  roundResultsScreen.everyBodyReady = false
  roundResultsScreen.playerReady = {false, false}
  roundResultsScreen.readyCallback = newReadyCallback
  addUserUpdateFunction("CoopRoundResultsUpdate", roundResultsScreen.UpdateRoundResults, 2)
end
function roundResultsScreen.UpdateRoundResults()
  if roundResultsScreen.spoolPoint ~= nil and spoolsystem.IsLocationResident(roundResultsScreen.spoolPoint) then
    roundResultsScreen.bLoading = false
  end
  local nextScreen = false
  if roundResultsScreen.screen == 1 then
    local countdown = roundResultsScreen.winLoseTimer - (g_NetworkTime - roundResultsScreen.startTimer)
    if countdown <= 0 then
      nextScreen = true
    end
  elseif roundResultsScreen.screen == 2 and roundResultsScreen.firstFrame == false then
    for localPlayerID, player in next, localPlayerManager.players, nil do
      local ready = false
      local buttons = {
        "Menu_ExtraFirst"
      }
      if Network.isSplitScreenMode() then
        buttons = {
          "Menu_Select"
        }
      end
      if roundResultsScreen.bLoading == false then
        for i, v in ipairs(buttons) do
          if player.gamepad:status(v) == "Pressed" then
            print("Player ready " .. tostring(v))
            ready = true
          end
        end
      end
      if ready and not roundResultsScreen.playerReady[localPlayerID] then
        roundResultsScreen.playerReady[localPlayerID] = true
        phaseManager.sendMessage(8, player.playerID + 1)
      end
    end
  end
  if nextScreen and roundResultsScreen.screen == 1 then
    roundResultsScreen.screen = 2
    roundResultsScreen.firstFrame = true
  end
  local totalScore = CoopScoringSystem.getScoreTotal()
  if roundResultsScreen.screen == 1 then
    local debugColour = vec.vector(0, 1, 0, 1)
    local debugPos1 = vec.vector(0.45, 0.3, 0, 1)
    local debugPos2 = vec.vector(0.45, 0.35, 0, 1)
    local timeOnScreen = 0.033
    local textScale = 1
    local str1 = "WIN/LOSE PLACEHOLDER"
    Development:add2DText(2678, str1, debugPos1, debugColour, textScale, timeOnScreen)
    local str2 = "Countdown " .. tostring(roundResultsScreen.winLoseTimer - (g_NetworkTime - roundResultsScreen.startTimer))
    Development:add2DText(2679, str2, debugPos2, debugColour, textScale, timeOnScreen)
  elseif roundResultsScreen.screen == 2 then
    if roundResultsScreen.bLoading == true then
      feedbackSystem.menusMaster.masterSetTextVariable("controls_button_line_5", "")
      feedbackSystem.menusMaster.masterSetTextVariable("controls_button_line_8", "")
      feedbackSystem.menusMaster.masterSetTextVariable("round_results_prompt", "ID:241356")
    else
      feedbackSystem.menusMaster.masterSetTextVariable("controls_button_line_5", "A")
      feedbackSystem.menusMaster.masterSetTextVariable("controls_button_line_8", "D")
      feedbackSystem.menusMaster.masterSetTextVariable("round_results_prompt", "ID:242251")
    end
    if roundResultsScreen.firstFrame == true then
      roundResultsScreen.firstFrame = false
      local missionName = roundResultsScreen.missionName
      Menu.SetTextVariable("Master", "round_results_title", "ID:242215", roundResultsScreen.roundOn)
      feedbackSystem.menusMaster.masterSetTextVariable("round_results_title_2", "")
      feedbackSystem.menusMaster.masterSetTextVariable("round_results_number", "")
      for iActivity = 1, 4 do
        local activity = coopSystem.roundActivity[missionName][iActivity]
        if activity == "" then
          if iActivity == 1 then
            roundResultsScreen.activity_1_p1 = ""
            roundResultsScreen.activity_1_p2 = ""
          elseif iActivity == 2 then
            roundResultsScreen.activity_2_p1 = ""
            roundResultsScreen.activity_2_p2 = ""
          elseif iActivity == 3 then
            roundResultsScreen.activity_3_p1 = ""
            roundResultsScreen.activity_3_p2 = ""
          elseif iActivity == 4 then
            roundResultsScreen.activity_4_p1 = ""
            roundResultsScreen.activity_4_p2 = ""
          end
        end
      end
      feedbackSystem.menusMaster.masterSetTextVariable("round_results_activity_1", coopSystem.roundActivity[missionName][1])
      feedbackSystem.menusMaster.masterSetTextVariable("round_results_activity_2", coopSystem.roundActivity[missionName][2])
      feedbackSystem.menusMaster.masterSetTextVariable("round_results_activity_3", coopSystem.roundActivity[missionName][3])
      feedbackSystem.menusMaster.masterSetTextVariable("round_results_activity_4", coopSystem.roundActivity[missionName][4])
      feedbackSystem.menusMaster.masterSetTextVariable("round_results_p1", SplitScreen.getPlayerName(0))
      feedbackSystem.menusMaster.masterSetTextVariable("round_results_p2", SplitScreen.getPlayerName(1))
      feedbackSystem.menusMaster.masterSetTextVariable("rr_activity_1_p1", tostring(roundResultsScreen.activity_1_p1))
      feedbackSystem.menusMaster.masterSetTextVariable("rr_activity_2_p1", tostring(roundResultsScreen.activity_2_p1))
      feedbackSystem.menusMaster.masterSetTextVariable("rr_activity_3_p1", tostring(roundResultsScreen.activity_3_p1))
      feedbackSystem.menusMaster.masterSetTextVariable("rr_activity_4_p1", tostring(roundResultsScreen.activity_4_p1))
      feedbackSystem.menusMaster.masterSetTextVariable("rr_activity_1_p2", tostring(roundResultsScreen.activity_1_p2))
      feedbackSystem.menusMaster.masterSetTextVariable("rr_activity_2_p2", tostring(roundResultsScreen.activity_2_p2))
      feedbackSystem.menusMaster.masterSetTextVariable("rr_activity_3_p2", tostring(roundResultsScreen.activity_3_p2))
      feedbackSystem.menusMaster.masterSetTextVariable("rr_activity_4_p2", tostring(roundResultsScreen.activity_4_p2))
      if missionName == "MP coop heavy hitter" then
        feedbackSystem.menusMaster.masterSetTextVariable("round_results_timebonus", "")
        feedbackSystem.menusMaster.masterSetTextVariable("round_results_time_p1", "")
        feedbackSystem.menusMaster.masterSetTextVariable("round_results_time_p2", "")
      else
        feedbackSystem.menusMaster.masterSetTextVariable("round_results_timebonus", "ID:242217")
        feedbackSystem.menusMaster.masterSetTextVariable("round_results_time_p1", tostring(roundResultsScreen.timebonus_p1))
        feedbackSystem.menusMaster.masterSetTextVariable("round_results_time_p2", tostring(roundResultsScreen.timebonus_p2))
      end
      feedbackSystem.menusMaster.masterSetTextVariable("round_results_score_title", "ID:243137")
      feedbackSystem.menusMaster.masterSetTextVariable("round_results_score_total", tostring(roundResultsScreen.roundScore))
      local hints = coopSystem.gameplayTip[missionName]
      feedbackSystem.menusMaster.masterSetTextVariable("round_results_hint", hints[framework.random(1, #hints)])
      feedbackSystem.menusMaster.splitscreenSetVariable("iRound_results_1_display", 1)
    end
  end
  local everybodyReadyNow = false
  if Network.isSplitScreenMode() then
    if 0 < phaseManager.networkVars.playersReady then
      everybodyReadyNow = true
    end
  elseif phaseManager.networkVars.playersReady == 3 then
    everybodyReadyNow = true
  end
  if everybodyReadyNow and not roundResultsScreen.everyBodyReady then
    roundResultsScreen.everyBodyReady = true
    if roundResultsScreen.readyCallback ~= nil then
      print("roundResultsScreen.readyCallback()")
      roundResultsScreen.readyCallback()
      roundResultsScreen.readyCallback = nil
    end
  end
end
function roundResultsScreen.ExitRoundResultsScreen()
  feedbackSystem.menusMaster.splitscreenSetVariable("iRound_results_1_display", 0)
  roundResultsScreen.everyBodyReady = false
  roundResultsScreen.playerReady = {false, false}
  roundResultsScreen.readyCallback = nil
  removeUserUpdateFunction("CoopRoundResultsUpdate")
  roundResultsScreen.activity_1_p1 = 0
  roundResultsScreen.activity_2_p1 = 0
  roundResultsScreen.activity_3_p1 = 0
  roundResultsScreen.activity_4_p1 = 0
  roundResultsScreen.activity_1_p2 = 0
  roundResultsScreen.activity_2_p2 = 0
  roundResultsScreen.activity_3_p2 = 0
  roundResultsScreen.activity_4_p2 = 0
end
countdownScreen = {}
countdownScreen.roundOn = 1
countdownScreen.firstFrame = true
countdownScreen.readyCallback = nil
countdownScreen.screen = 1
countdownScreen.startCountdown = g_NetworkTime
countdownScreen.missionName = ""
countdownScreen.skipTo321 = false
function countdownScreen.EnterCountdownScreen(challengeInstance, newReadyCallback, skipTo321)
  hideAllHUD()
  countdownScreen.missionName = challengeInstance.challenge.name
  countdownScreen.firstFrame = true
  countdownScreen.readyCallback = newReadyCallback
  countdownScreen.skipTo321 = skipTo321
  if countdownScreen.skipTo321 then
    countdownScreen.screen = 6
    countdownScreen.countdownLength = 3
  else
    countdownScreen.screen = 1
    countdownScreen.countdownLength = 1
  end
  countdownScreen.startCountdown = g_NetworkTime
  addUserUpdateFunction("CoopCountdownUpdate", countdownScreen.UpdateCountdownScreen, 2)
end
countdownScreen.timerString = ""
countdownScreen.mins = 0
countdownScreen.secs = 0
countdownScreen.Text = ""
countdownScreen.textParam1 = nil
countdownScreen.textParam2 = nil
countdownScreen.takedownDistance = 0
function countdownScreen.UpdateCountdownScreen()
  local missionName = countdownScreen.missionName
  local countdown = countdownScreen.countdownLength - (g_NetworkTime - countdownScreen.startCountdown)
  countdown = math.max(countdown, 0)
  local isRepo = false
  local isTakedown = false
  local isDares = false
  if missionName == "MP coop Heist" then
    isRepo = true
  elseif missionName == "MP coop heavy hitter" then
    isTakedown = true
  elseif missionName == "Coop Choose Your Dare" then
    isDares = true
  end
  local secondsRemaining = math.ceil(countdown)
  if countdown <= 0 then
    if countdownScreen.screen == 1 then
      countdownScreen.screen = 2
      countdownScreen.firstFrame = true
      countdownScreen.startCountdown = g_NetworkTime
      countdownScreen.countdownLength = 2
    elseif countdownScreen.screen == 2 then
      if isRepo then
        countdownScreen.screen = 3
      else
        countdownScreen.screen = 4
      end
      countdownScreen.firstFrame = true
      countdownScreen.startCountdown = g_NetworkTime
      countdownScreen.countdownLength = 2
    elseif countdownScreen.screen == 3 then
      countdownScreen.screen = 4
      countdownScreen.firstFrame = true
      countdownScreen.startCountdown = g_NetworkTime
      countdownScreen.countdownLength = 2
    elseif countdownScreen.screen == 4 then
      countdownScreen.screen = 5
      countdownScreen.firstFrame = true
      countdownScreen.startCountdown = g_NetworkTime
      countdownScreen.countdownLength = 2
    elseif countdownScreen.screen == 5 then
      countdownScreen.screen = 6
      countdownScreen.firstFrame = true
      countdownScreen.startCountdown = g_NetworkTime
      countdownScreen.countdownLength = 3
    elseif countdownScreen.screen == 6 and countdownScreen.readyCallback ~= nil then
      countdownScreen.readyCallback()
      countdownScreen.readyCallback = nil
    end
  end
  if countdownScreen.screen == 1 then
    if countdownScreen.firstFrame == true then
      countdownScreen.firstFrame = false
      local difficulty = getSelectedDifficulty()
      local value
      if missionName == "MP coop Heist" then
        value = heistNumCarsNeeded[difficulty][countdownScreen.roundOn]
      elseif missionName == "Coop Choose Your Dare" then
        value = 3
      elseif missionName == "MP coop heavy hitter" then
        value = takedownsNeeded[difficulty][countdownScreen.roundOn]
      end
      local ss_objectives_inf
      if missionName == "MP coop Heist" or missionName == "MP coop heavy hitter" then
        ss_objectives_inf = coopSystem.objectiveInfo[missionName][difficulty][countdownScreen.roundOn]
      else
        ss_objectives_inf = coopSystem.objectiveInfo[missionName][difficulty]
      end
      feedbackSystem.menusMaster.masterSetTextVariable("ss_teamscore_counter", tostring(0))
    end
  elseif countdownScreen.screen == 2 then
    if countdownScreen.firstFrame == true then
      countdownScreen.firstFrame = false
      Menu.SetTextVariable("Master", "ss_dare_description_mini", countdownScreen.Text, countdownScreen.textParam1, countdownScreen.textParam2)
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_dare_bar_anim", 0)
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_dare_bar_anim_p2", 0)
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_dare_bar_intro", 1)
    end
  elseif countdownScreen.screen == 3 then
    if countdownScreen.firstFrame == true then
      countdownScreen.firstFrame = false
      coopSystem.ss_hud.darebar:Add()
      feedbackSystem.menusMaster.masterSetTextVariable("ss_repo_score_p1", tostring(1000))
      feedbackSystem.menusMaster.masterSetTextVariable("ss_repo_score_p2", tostring(1000))
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_repo_intro", 1)
    end
  elseif countdownScreen.screen == 4 then
    if countdownScreen.firstFrame == true then
      countdownScreen.firstFrame = false
      if isRepo then
        coopSystem.ss_hud.repovalue:Add()
      else
        coopSystem.ss_hud.darebar:Add()
      end
      if isTakedown then
        Menu.SetTextVariable("Master", "ss_pressure_value", countdownScreen.takedownDistance)
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_pressure_intro", 1)
      else
        feedbackSystem.menusMaster.masterSetTextVariable("ss_timer", countdownScreen.timerString)
        feedbackSystem.menusMaster.masterSetTextVariable("ss_timer_minutes", countdownScreen.mins)
        feedbackSystem.menusMaster.masterSetTextVariable("ss_timer_seconds", countdownScreen.secs)
        feedbackSystem.menusMaster.masterSetTextVariable("ss_timer_splitseconds", "00")
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_timer_intro", 1)
      end
    end
  elseif countdownScreen.screen == 6 and countdownScreen.firstFrame == true then
    countdownScreen.firstFrame = false
    if not countdownScreen.skipTo321 then
      if isTakedown then
        coopSystem.ss_hud.takedownpressure:Add()
      else
        coopSystem.ss_hud.timer:Add()
      end
    end
    feedbackSystem.menusMaster.splitscreenSetVariable("iMulti_Play_Race_Countdown", 1)
    OneShotSound.Play("HUD_Gen_321GO", false)
  end
end
function countdownScreen.ClearObjectiveTriggers()
end
function countdownScreen.ExitCountdownScreen()
  countdownScreen.readyCallback = nil
  removeUserUpdateFunction("CoopCountdownUpdate")
  if Network.isSplitScreenMode() then
    PauseMenu.allow(true)
    NetworkLog.Write(">[LUA] - PauseMenu.allow ( true ) ")
  end
  zap.enableZapSelection()
end
function getPropTypename(propHandle)
  local modelID = PropSystem.GetModelID(propHandle)
  for name, prop in pairs(propType) do
    if prop.modelUID == modelID then
      return name
    end
  end
  return nil
end
function deleteActorByName(actorName)
  local instance = localPlayer:getTaskObject().coreData.instance
  local taskObject = instance.taskObjectsByActorID[actorName]
  if taskObject and taskObject.coreData.isLocal then
    taskObject:delete()
  end
end
function spawnActorNearActor(actorName, targetName, distance, actorModelOverride)
  local instance = localPlayer:getTaskObject().coreData.instance
  local vehicleActor = instance.challenge.actorPool[actorName]
  local vehicles = coopSystem.spawnActorNearActorData(vehicleActor, instance, actorName, targetName, distance, actorModelOverride)
  instance:newActorFromAgent(vehicleActor.ID, vehicles[1])
end
function spawnActorNearActorData(actor, instance, actorName, targetName, distance, actorModelOverride)
  local settings = {}
  settings = {
    position = "randomLane",
    vehicles = {
      [1] = {
        modelID = actorModelOverride or actor.modelID,
        shaderParams = actor.shader
      }
    },
    direction = "with",
    vehicle = instance.taskObjectsByActorID[targetName].coreData.agent.gameVehicle
  }
  distance = distance or -100
  if distance and distance > 0 then
    settings.type = "InFrontOfVehicle"
    settings.distanceInFront = math.abs(distance)
    settings.direction = "against"
  else
    settings.type = "BehindVehicle"
    settings.distanceBehind = math.abs(distance)
    settings.direction = "with"
  end
  local vehicles = coopSystem.spawnActorNearActorCodeStuff(settings)
  return vehicles
end
function spawnActorNearActorCodeStuff(settings)
  local gameVehicles = Spawn.Spawn(settings)
  local vehicles = {}
  for i, gameVehicle in ipairs(gameVehicles) do
    local vehicle = vehicleManager.registerVehicle({gameVehicle = gameVehicle})
    table.insert(vehicles, vehicle)
  end
  return vehicles
end
sweepTaskObjectDeletionTable = nil
function requestTaskObjectDeletion(deleteTaskObject)
  if deleteTaskObject then
    print("requestTaskObjectDeletion for " .. tostring(deleteTaskObject.coreData.taskObjectID))
    if deleteTaskObject and deleteTaskObject.coreData.isLocal and deleteTaskObject.coreData.taskObjectID then
      coopData.taskObjectDeletionTable[deleteTaskObject.coreData.taskObjectID] = true
    end
    sweepTaskObjectDeletionTable()
  else
    print("requestTaskObjectDeletion: THERE IS NO TASK OBJECT ALREADY!")
  end
end
function isTaskObjectPendingDeletion(deleteTaskObject)
  if deleteTaskObject then
    print("isTaskObjectPendingDeletion " .. tostring(deleteTaskObject.coreData.taskObjectID) .. " is " .. tostring(coopData.taskObjectDeletionTable[deleteTaskObject.coreData.taskObjectID]))
    return coopData.taskObjectDeletionTable[deleteTaskObject.coreData.taskObjectID]
  else
    return false
  end
end
function sweepTaskObjectDeletionTable()
  for toID, bInTable in pairs(coopData.taskObjectDeletionTable) do
    if bInTable then
      deleteTaskObject = taskSystem.taskObjects[toID]
      if deleteTaskObject and deleteTaskObject.coreData.isLocal and deleteTaskObject:canBeDeleted() then
        deleteTaskObject:delete()
        coopData.taskObjectDeletionTable[toID] = nil
        print("sweepTaskObjectDeletionTable() - taskObject " .. tostring(toID) .. " deleted.")
      end
      if not deleteTaskObject then
        coopData.taskObjectDeletionTable[toID] = nil
      end
    end
  end
end
sweepActorCreationTable = nil
function requestTaskObjectCreation(actorName, instance, pos, heading, markerColour, callback, dependentActor)
  print("requestTaskObjectCreation for " .. tostring(actorName))
  coopData.actorCreationTable[actorName] = {}
  coopData.actorCreationTable[actorName].instance = instance
  coopData.actorCreationTable[actorName].pos = pos
  coopData.actorCreationTable[actorName].heading = heading
  coopData.actorCreationTable[actorName].markerColour = markerColour
  coopData.actorCreationTable[actorName].callback = callback
  coopData.actorCreationTable[actorName].dependentActor = dependentActor
  sweepActorCreationTable()
end
function sweepActorCreationTable()
  for actorName, entry in pairs(coopData.actorCreationTable) do
    if entry then
      potentialTO = entry.instance.taskObjectsByActorID[actorName]
      if not potentialTO and (entry.dependentActor and entry.instance.taskObjectsByActorID[entry.dependentActor] or not entry.dependentActor) then
        spawnMissionVehicleXYZHeading(entry.instance, actorName, entry.pos, entry.heading, nil)
        if entry.markerColour then
          addMarkerToVehicle(entry.instance, actorName, entry.markerColour)
        end
        if entry.callback then
          entry.callback()
        end
        coopData.actorCreationTable[actorName] = nil
        print("sweepActorCreationTable() - taskObject " .. tostring(actorName) .. " created.")
      end
    end
  end
end
function isVehicleValid(actorName)
  local result = false
  local taskObject = false
  if localPlayer:getTaskObject() and localPlayer:getTaskObject().coreData and localPlayer:getTaskObject().coreData.instance and localPlayer:getTaskObject().coreData.instance.taskObjectsByActorID[actorName] then
    taskObject = localPlayer:getTaskObject().coreData.instance.taskObjectsByActorID[actorName]
  end
  result = taskObject and taskObject.coreData.agent and taskObject.coreData.agent.SNVID
  return result
end
function getInstance()
  return localPlayer:getTaskObject().coreData.instance
end
local stringFormat = "%02d"
local startTime
local function coopTimerUpdate(params)
  if not vehicleManager.previewVehicleManager.previewVehicle and not localPlayer.challenge.showingEndScreen and not localPlayer.inCutscene and not blockHUD and not removeTimerUpdate then
    if not setStartTime then
      startTime = g_NetworkTime
      setStartTime = true
    end
    if params.startTime then
      timeRemaining = params.startTime - (g_NetworkTime - startTime)
    else
      timeRemaining = g_NetworkTime - startTime
    end
    local mins = string.format(stringFormat, timeRemaining / 60)
    local secs = string.format(stringFormat, math.mod(timeRemaining, 60))
    local milli_num = feedbackSystem.round_num(100 * (timeRemaining - math.floor(timeRemaining)))
    local milli = string.format(stringFormat, milli_num)
    feedbackSystem.menusMaster.masterSetTextVariable("coop_mission_panel_1_timer_colon", ":")
    feedbackSystem.menusMaster.masterSetTextVariable("coop_mission_panel_1_timer_dot", ".")
    if timeRemaining then
      if timeRemaining < 0 then
        if params.slot then
          feedbackSystem.menusMaster.masterSetTextVariable("coop_mission_panel_1_timer_mins", "00")
          feedbackSystem.menusMaster.masterSetTextVariable("coop_mission_panel_1_timer_secs", "00")
          feedbackSystem.menusMaster.masterSetTextVariable("coop_mission_panel_1_timer_milli", "00")
          feedbackSystem.menusMaster.splitscreenSetVariable("iCoop_mission_panel_timer_urgent", 0)
        end
        if params.startTime then
          OneShotSound.Play("HUD_Online_Timer_0Seconds")
        end
      elseif string.len(mins) <= 2 then
        feedbackSystem.menusMaster.masterSetTextVariable("coop_mission_panel_1_timer_mins", mins)
        feedbackSystem.menusMaster.masterSetTextVariable("coop_mission_panel_1_timer_secs", secs)
        feedbackSystem.menusMaster.masterSetTextVariable("coop_mission_panel_1_timer_milli", milli)
      end
      if params.flashTime and params.flashTime >= timeRemaining and not coopSystem.timerFlash and params.startTime then
        feedbackSystem.menusMaster.splitscreenSetVariable("iCoop_mission_panel_timer_urgent", 1)
        OneShotSound.PlayCountdown("HUD_Online_Timer_10Seconds")
        print("activating timer flash")
        coopSystem.timerFlash = true
      elseif params.flashTime and timeRemaining > params.flashTime and coopSystem.timerFlash and params.startTime then
        feedbackSystem.menusMaster.splitscreenSetVariable("iCoop_mission_panel_timer_urgent", 0)
        print("DEactivating timer flash")
        coopSystem.timerFlash = false
      end
    end
  else
  end
  return timeRemaining
end
function stepCoopTimer(params)
  if blockHUD or localPlayer.challenge.showingEndScreen then
    feedbackSystem.menusMaster.splitscreenSetVariable("iCoop_mission_panel_timer", 0)
  end
  if not vehicleManager.previewVehicleManager.previewVehicle and not userUpdateFunctions.timerUpdate and not params.timeToBeat then
    addUserUpdateFunction("timerUpdate", function()
      coopTimerUpdate(params)
    end, 2)
  end
  if params.reset then
    setStartTime = false
  end
end
function updateCoopCounter(params)
  if not Network.isSplitScreenMode() and (not blockHUD or not localPlayer.challenge.showingEndScreen) then
    if params.iconTitle or params.barTitle then
      feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_2_bar_title", params.barTitle or params.iconTitle)
    else
      feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_2_bar_title", "")
    end
    if params.currentValue and not localPlayer.challenge.showingEndScreen then
      feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_2_counter_current", string.format(stringFormat, params.currentValue))
      if coopPanels[params.slot].currentCount < params.currentValue then
        OneShotSound.Play("HUD_Mis_ObjectiveCounter_Flash_Positive_OneShot", false)
        coopPanels[params.slot].currentCount = params.currentValue
      elseif coopPanels[params.slot].currentCount > params.currentValue then
        OneShotSound.Play("HUD_Mis_ObjectiveCounter_Flash_Negative_OneShot", false)
        coopPanels[params.slot].currentCount = params.currentValue
      end
    end
    if params.totalValue then
      feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_2_counter_total", string.format(stringFormat, params.totalValue))
    else
      feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_2_counter_total", "")
      feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_2_counter_slash", "")
    end
  end
end
local barUpdate = function(slot, value, score)
  if value then
    barValue = math.ceil(100 - value * 100)
  elseif score then
    barValue = score
  end
  if slot == 2 then
    feedbackSystem.menusMaster.splitscreenSetVariable("iCoop_mission_progress_bar_anim", barValue)
  else
    if slot == 3 then
    else
    end
  end
  feedbackSystem.menusMaster.masterSetTextVariable("coop_mission_panel_title_2_percent", tostring(feedbackSystem.round_num(barValue)) .. "%")
end
function updateCoopHealthBar(params)
  if not Network.isSplitScreenMode() and (not blockHUD or not localPlayer.challenge.showingEndScreen) then
    if not params.score then
      feedbackSystem.menusMaster.masterSetTextVariable("coop_mission_panel_title_2", "ID:182930")
    elseif params.barTitle then
      feedbackSystem.menusMaster.masterSetTextVariable("coop_mission_panel_title_2", params.barTitle)
    end
    if params.title then
      feedbackSystem.menusMaster.masterSetTextVariable("coop_mission_panel_title_2_info", params.title)
    else
      feedbackSystem.menusMaster.masterSetTextVariable("coop_mission_panel_title_2_info", "")
    end
    barUpdate(params.slot, params.value, params.score)
  end
end
function class(base, init)
  local c = {}
  if not init and type(base) == "function" then
    init = base
    base = nil
  elseif type(base) == "table" then
    for i, v in pairs(base) do
      c[i] = v
    end
    c._base = base
  end
  c.__index = c
  local mt = {}
  function mt.__call(class_tbl, ...)
    local obj = {}
    setmetatable(obj, c)
    if init then
      init(obj, ...)
    elseif base and base.init then
      base.init(obj, ...)
    end
    return obj
  end
  c.init = init
  function c:is_a(klass)
    local m = getmetatable(self)
    while m do
      if m == klass then
        return true
      end
      m = m._base
    end
    return false
  end
  setmetatable(c, mt)
  return c
end
local HudStates = {
  HudNotShown = 0,
  HudOnScreen = 1,
  HudHidden = 2
}
HudElement = class(function(self, name, masterVar1, masterVar2)
  self.name = name
  self.state = {
    [0] = "HudNotShown",
    [1] = "HudNotShown"
  }
  self.masterVar = {
    [0] = masterVar1,
    [1] = masterVar2
  }
end)
function HudElement:DoHide(localID)
  for realID, plr in next, localPlayerManager.players, nil do
    if (localID == nil or realID == localID) and self.masterVar[realID] then
      feedbackSystem.menusMaster.splitscreenSetVariable(self.masterVar[realID], 0)
    end
  end
end
function HudElement:OnScreen(localID)
  for realID, plr in next, localPlayerManager.players, nil do
    if (localID == nil or realID == localID) and self.state[realID] == "HudOnScreen" then
      return true
    end
  end
  return false
end
function HudElement:Hide(localID)
  for realID, plr in next, localPlayerManager.players, nil do
    if (localID == nil or realID == localID) and self.state[realID] == "HudOnScreen" then
      self.state[realID] = "HudHidden"
      self:DoHide(realID)
    else
    end
  end
end
function HudElement:DoUnHide(localID)
  for realID, plr in next, localPlayerManager.players, nil do
    if (localID == nil or realID == localID) and self.masterVar[realID] then
      feedbackSystem.menusMaster.splitscreenSetVariable(self.masterVar[realID], 1)
    end
  end
end
function HudElement:Unhide(localID)
  for realID, plr in next, localPlayerManager.players, nil do
    if (localID == nil or realID == localID) and self.state[realID] == "HudHidden" then
      self.state[realID] = "HudOnScreen"
      self:DoUnHide(realID)
    else
    end
  end
end
function HudElement:AddPlayer(hidden, localID)
  if self.state[localID] == "HudNotShown" then
    self.state[localID] = "HudHidden"
  end
  if not hidden then
    self:Unhide(localID)
  end
end
function HudElement:RemovePlayer(localID)
  self:Hide(localID)
  if self.state[localID] == "HudHidden" then
    self.state[localID] = "HudNotShown"
  end
end
function HudElement:Add(hidden, localID)
  for realID, plr in next, localPlayerManager.players, nil do
    if localID == nil or realID == localID then
      self:AddPlayer(hidden, realID)
    end
  end
end
function HudElement:Remove(localID)
  for realID, plr in next, localPlayerManager.players, nil do
    if localID == nil or realID == localID then
      self:RemovePlayer(realID)
    end
  end
end
coopSystem.ss_hud = {}
coopSystem.ss_hud.elements = {}
function coopSystem.ss_hud.removeAll(localID)
  for name, element in next, coopSystem.ss_hud.elements, nil do
    element:Remove(localID)
  end
end
function coopSystem.ss_hud.hideAll(localID)
  for name, element in next, coopSystem.ss_hud.elements, nil do
    element:Hide(localID)
  end
end
function coopSystem.ss_hud.unhideAll(localID)
  for name, element in next, coopSystem.ss_hud.elements, nil do
    element:Unhide(localID)
  end
end
function SplitScreenPauseToggle(enable)
  if enable == 1 then
    coopSystem.ss_hud.hideAll()
  else
    coopSystem.ss_hud.unhideAll()
  end
end
_G.SplitScreenPauseToggle = SplitScreenPauseToggle
