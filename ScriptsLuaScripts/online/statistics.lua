local type_int32 = 0
local type_float = 1
local type_string = 2
local policy_Add = 0
local policy_Sub = 1
local policy_Overwrite = 2
local policy_ReplaceIfMax = 3
local policy_ReplaceIfMin = 4
local base_Coop_StatID = 100
local base_Coop_StatBoard = 16
local coop_Num_Stats_Per_Board = 7
local start_Coop_StatID = 100
local end_Coop_StatID = 143
local scored = 0
local timed = 1
local illegal = -1
local RankingOrder_Ascending = 0
local RankingOrder_Descending = 1
local RankingOrder_Invalid = -1
local StatisticList = {
  {
    statBoard = 1,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 1,
    statFriendComparison = 0,
    statID = 1,
    statName = "XP"
  },
  {
    statBoard = 1,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 1,
    statFriendComparison = 0,
    statID = 2,
    statName = "Icon"
  },
  {
    statBoard = 1,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 1,
    statFriendComparison = 0,
    statID = 3,
    statName = "ZapSpawnCars"
  },
  {
    statBoard = 1,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 4,
    statName = "TutorialCompleteFlags"
  },
  {
    statBoard = 2,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 20,
    statName = "Tag Score"
  },
  {
    statBoard = 2,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 21,
    statName = "Tag Wins"
  },
  {
    statBoard = 2,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 22,
    statName = "Tag Losses"
  },
  {
    statBoard = 2,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 23,
    statName = "Tag Time Tagged",
    feName = "ID:236476"
  },
  {
    statBoard = 3,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 24,
    statName = "Takedown Score"
  },
  {
    statBoard = 3,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 25,
    statName = "Takedown Wins"
  },
  {
    statBoard = 3,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 26,
    statName = "Takedown Losses"
  },
  {
    statBoard = 3,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 27,
    statName = "Takedown Drop Offs",
    feName = "ID:243744"
  },
  {
    statBoard = 4,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 28,
    statName = "Blazer Score"
  },
  {
    statBoard = 4,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 29,
    statName = "Blazer Wins"
  },
  {
    statBoard = 4,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 30,
    statName = "Blazer Losses"
  },
  {
    statBoard = 4,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 31,
    statName = "Blazer Time in Trails",
    feName = "ID:236478"
  },
  {
    statBoard = 5,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 32,
    statName = "Tug Score"
  },
  {
    statBoard = 5,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 33,
    statName = "Tug Wins"
  },
  {
    statBoard = 5,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 34,
    statName = "Tug Losses"
  },
  {
    statBoard = 5,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 35,
    statName = "Tug Flags Captured",
    feName = "ID:236479"
  },
  {
    statBoard = 6,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 36,
    statName = "Burning Score"
  },
  {
    statBoard = 6,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 37,
    statName = "Burning Wins"
  },
  {
    statBoard = 6,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 38,
    statName = "Burning Losses"
  },
  {
    statBoard = 6,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 39,
    statName = "Burning Checkpoints Crossed",
    feName = "ID:236480"
  },
  {
    statBoard = 7,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 40,
    statName = "Rushdown Score"
  },
  {
    statBoard = 7,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 41,
    statName = "Rushdown Wins"
  },
  {
    statBoard = 7,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 42,
    statName = "Rushdown Losses"
  },
  {
    statBoard = 7,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 43,
    statName = "Rushdown Objectives Destroyed",
    feName = "ID:236481"
  },
  {
    statBoard = 8,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 44,
    statName = "Sprint Score"
  },
  {
    statBoard = 8,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 45,
    statName = "Sprint Wins"
  },
  {
    statBoard = 8,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 46,
    statName = "Sprint Losses"
  },
  {
    statBoard = 8,
    statInBoardId = 4,
    statType = type_float,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 47,
    statName = "Sprint Average Placing",
    feName = "ID:236482",
    statDisplayType = type_int32
  },
  {
    statBoard = 9,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 48,
    statName = "Circuit Score"
  },
  {
    statBoard = 9,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 49,
    statName = "Circuit Wins"
  },
  {
    statBoard = 9,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 50,
    statName = "Circuit Losses"
  },
  {
    statBoard = 9,
    statInBoardId = 4,
    statType = type_float,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 51,
    statName = "Circuit Average Placing",
    feName = "ID:236482",
    statDisplayType = type_int32
  },
  {
    statBoard = 10,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 52,
    statName = "Pure Score"
  },
  {
    statBoard = 10,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 53,
    statName = "Pure Wins"
  },
  {
    statBoard = 10,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 54,
    statName = "Pure Losses"
  },
  {
    statBoard = 10,
    statInBoardId = 4,
    statType = type_float,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 55,
    statName = "Pure Average Placing",
    feName = "ID:236482",
    statDisplayType = type_int32
  },
  {
    statBoard = 11,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 56,
    statName = "Team Circuit Race Score"
  },
  {
    statBoard = 11,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 57,
    statName = "Team Circuit Race Wins"
  },
  {
    statBoard = 11,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 58,
    statName = "Team Circuit Race Losses"
  },
  {
    statBoard = 11,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 59,
    statName = "Team Circuit Race Checkpoints Crossed",
    feName = "ID:236480"
  },
  {
    statBoard = 12,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 60,
    statName = "Overall Score"
  },
  {
    statBoard = 12,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 61,
    statName = "Overall Wins"
  },
  {
    statBoard = 12,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 62,
    statName = "Overall Losses"
  },
  {
    statBoard = 12,
    statInBoardId = 4,
    statType = type_float,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 63,
    statName = "Overall Win/Loss Ratio",
    feName = "ID:248719"
  },
  {
    statBoard = 13,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 64,
    statName = "Rush Score"
  },
  {
    statBoard = 13,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 65,
    statName = "Rush Wins"
  },
  {
    statBoard = 13,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 66,
    statName = "Rush Losses"
  },
  {
    statBoard = 13,
    statInBoardId = 4,
    statType = type_float,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 67,
    statName = "Rush Average Placing",
    feName = "ID:236482",
    statDisplayType = type_int32
  },
  {
    statBoard = 26,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 150,
    statName = "TheFreewayRun_SplitTime_1"
  },
  {
    statBoard = 26,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 151,
    statName = "TheFreewayRun_SplitTime_2"
  },
  {
    statBoard = 26,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 152,
    statName = "TheFreewayRun_SplitTime_3"
  },
  {
    statBoard = 26,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 153,
    statName = "TheFreewayRun_SplitTime_4"
  },
  {
    statBoard = 26,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 154,
    statName = "TheFreewayRun_SplitTime_5"
  },
  {
    statBoard = 26,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 155,
    statName = "TheFreewayRun_SplitTime_6"
  },
  {
    statBoard = 26,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 156,
    statName = "TheFreewayRun_SplitTime_7"
  },
  {
    statBoard = 26,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 157,
    statName = "TheFreewayRun_SplitTime_8"
  },
  {
    statBoard = 26,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 158,
    statName = "TheFreewayRun_SplitTime_9"
  },
  {
    statBoard = 26,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 159,
    statName = "TheFreewayRun_SplitTime_10"
  },
  {
    statBoard = 26,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 160,
    statName = "TheFreewayRun_SplitTime_11"
  },
  {
    statBoard = 26,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 161,
    statName = "TheFreewayRun_SplitTime_12"
  },
  {
    statBoard = 26,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 162,
    statName = "TheFreewayRun_SplitTime_13"
  },
  {
    statBoard = 26,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 163,
    statName = "TheFreewayRun_SplitTime_14"
  },
  {
    statBoard = 26,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 164,
    statName = "TheFreewayRun_SplitTime_15"
  },
  {
    statBoard = 26,
    statInBoardId = 16,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 165,
    statName = "TheFreewayRun_SplitTime_16"
  },
  {
    statBoard = 26,
    statInBoardId = 17,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 166,
    statName = "TheFreewayRun_SplitTime_17"
  },
  {
    statBoard = 27,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 167,
    statName = "TheFreewayRun"
  },
  {
    statBoard = 28,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 200,
    statName = "DowntownSprint_SplitTime_1"
  },
  {
    statBoard = 28,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 201,
    statName = "DowntownSprint_SplitTime_2"
  },
  {
    statBoard = 28,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 202,
    statName = "DowntownSprint_SplitTime_3"
  },
  {
    statBoard = 28,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 203,
    statName = "DowntownSprint_SplitTime_4"
  },
  {
    statBoard = 28,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 204,
    statName = "DowntownSprint_SplitTime_5"
  },
  {
    statBoard = 28,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 205,
    statName = "DowntownSprint_SplitTime_6"
  },
  {
    statBoard = 28,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 206,
    statName = "DowntownSprint_SplitTime_7"
  },
  {
    statBoard = 28,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 207,
    statName = "DowntownSprint_SplitTime_8"
  },
  {
    statBoard = 28,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 208,
    statName = "DowntownSprint_SplitTime_9"
  },
  {
    statBoard = 28,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 209,
    statName = "DowntownSprint_SplitTime_10"
  },
  {
    statBoard = 28,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 210,
    statName = "DowntownSprint_SplitTime_11"
  },
  {
    statBoard = 28,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 211,
    statName = "DowntownSprint_SplitTime_12"
  },
  {
    statBoard = 28,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 212,
    statName = "DowntownSprint_SplitTime_13"
  },
  {
    statBoard = 29,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 213,
    statName = "DowntownSprint"
  },
  {
    statBoard = 30,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 250,
    statName = "Escape_SplitTime_1"
  },
  {
    statBoard = 30,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 251,
    statName = "Escape_SplitTime_2"
  },
  {
    statBoard = 30,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 252,
    statName = "Escape_SplitTime_3"
  },
  {
    statBoard = 30,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 253,
    statName = "Escape_SplitTime_4"
  },
  {
    statBoard = 30,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 254,
    statName = "Escape_SplitTime_5"
  },
  {
    statBoard = 30,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 255,
    statName = "Escape_SplitTime_6"
  },
  {
    statBoard = 30,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 256,
    statName = "Escape_SplitTime_7"
  },
  {
    statBoard = 30,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 257,
    statName = "Escape_SplitTime_8"
  },
  {
    statBoard = 30,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 258,
    statName = "Escape_SplitTime_9"
  },
  {
    statBoard = 30,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 259,
    statName = "Escape_SplitTime_10"
  },
  {
    statBoard = 30,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 260,
    statName = "Escape_SplitTime_11"
  },
  {
    statBoard = 30,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 261,
    statName = "Escape_SplitTime_12"
  },
  {
    statBoard = 30,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 262,
    statName = "Escape_SplitTime_13"
  },
  {
    statBoard = 30,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 263,
    statName = "Escape_SplitTime_14"
  },
  {
    statBoard = 30,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 264,
    statName = "Escape_SplitTime_15"
  },
  {
    statBoard = 30,
    statInBoardId = 16,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 265,
    statName = "Escape_SplitTime_16"
  },
  {
    statBoard = 30,
    statInBoardId = 17,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 266,
    statName = "Escape_SplitTime_17"
  },
  {
    statBoard = 30,
    statInBoardId = 18,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 267,
    statName = "Escape_SplitTime_18"
  },
  {
    statBoard = 30,
    statInBoardId = 19,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 268,
    statName = "Escape_SplitTime_19"
  },
  {
    statBoard = 30,
    statInBoardId = 20,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 269,
    statName = "Escape_SplitTime_20"
  },
  {
    statBoard = 30,
    statInBoardId = 21,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 270,
    statName = "Escape_SplitTime_21"
  },
  {
    statBoard = 30,
    statInBoardId = 22,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 271,
    statName = "Escape_SplitTime_22"
  },
  {
    statBoard = 30,
    statInBoardId = 23,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 272,
    statName = "Escape_SplitTime_23"
  },
  {
    statBoard = 30,
    statInBoardId = 24,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 273,
    statName = "Escape_SplitTime_24"
  },
  {
    statBoard = 30,
    statInBoardId = 25,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 274,
    statName = "Escape_SplitTime_25"
  },
  {
    statBoard = 31,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 275,
    statName = "Escape"
  },
  {
    statBoard = 32,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMax,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 300,
    statDataInfo = scored,
    statName = "ChinatownDrift"
  },
  {
    statBoard = 33,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 350,
    statName = "TheGetaway"
  },
  {
    statBoard = 34,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 400,
    statName = "GoldenGateCircuit_SplitTime_1"
  },
  {
    statBoard = 34,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 401,
    statName = "GoldenGateCircuit_SplitTime_2"
  },
  {
    statBoard = 34,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 402,
    statName = "GoldenGateCircuit_SplitTime_3"
  },
  {
    statBoard = 34,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 403,
    statName = "GoldenGateCircuit_SplitTime_4"
  },
  {
    statBoard = 34,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 404,
    statName = "GoldenGateCircuit_SplitTime_5"
  },
  {
    statBoard = 34,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 405,
    statName = "GoldenGateCircuit_SplitTime_6"
  },
  {
    statBoard = 34,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 406,
    statName = "GoldenGateCircuit_SplitTime_7"
  },
  {
    statBoard = 34,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 407,
    statName = "GoldenGateCircuit_SplitTime_8"
  },
  {
    statBoard = 34,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 408,
    statName = "GoldenGateCircuit_SplitTime_9"
  },
  {
    statBoard = 34,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 409,
    statName = "GoldenGateCircuit_SplitTime_10"
  },
  {
    statBoard = 34,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 410,
    statName = "GoldenGateCircuit_SplitTime_11"
  },
  {
    statBoard = 34,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 411,
    statName = "GoldenGateCircuit_SplitTime_12"
  },
  {
    statBoard = 34,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 412,
    statName = "GoldenGateCircuit_SplitTime_13"
  },
  {
    statBoard = 34,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 413,
    statName = "GoldenGateCircuit_SplitTime_14"
  },
  {
    statBoard = 34,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 414,
    statName = "GoldenGateCircuit_SplitTime_15"
  },
  {
    statBoard = 34,
    statInBoardId = 16,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 415,
    statName = "GoldenGateCircuit_SplitTime_16"
  },
  {
    statBoard = 34,
    statInBoardId = 17,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 416,
    statName = "GoldenGateCircuit_SplitTime_17"
  },
  {
    statBoard = 34,
    statInBoardId = 18,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 417,
    statName = "GoldenGateCircuit_SplitTime_18"
  },
  {
    statBoard = 34,
    statInBoardId = 19,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 418,
    statName = "GoldenGateCircuit_SplitTime_19"
  },
  {
    statBoard = 34,
    statInBoardId = 20,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 419,
    statName = "GoldenGateCircuit_SplitTime_20"
  },
  {
    statBoard = 34,
    statInBoardId = 21,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 420,
    statName = "GoldenGateCircuit_SplitTime_21"
  },
  {
    statBoard = 34,
    statInBoardId = 22,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 421,
    statName = "GoldenGateCircuit_SplitTime_22"
  },
  {
    statBoard = 34,
    statInBoardId = 23,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 422,
    statName = "GoldenGateCircuit_SplitTime_23"
  },
  {
    statBoard = 35,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 423,
    statName = "GoldenGateCircuit"
  },
  {
    statBoard = 36,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 483,
    statName = "RussianHillTakedown"
  },
  {
    statBoard = 37,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 500,
    statName = "Offroad_SplitTime_1"
  },
  {
    statBoard = 37,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 501,
    statName = "Offroad_SplitTime_2"
  },
  {
    statBoard = 37,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 502,
    statName = "Offroad_SplitTime_3"
  },
  {
    statBoard = 37,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 503,
    statName = "Offroad_SplitTime_4"
  },
  {
    statBoard = 37,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 504,
    statName = "Offroad_SplitTime_5"
  },
  {
    statBoard = 37,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 505,
    statName = "Offroad_SplitTime_6"
  },
  {
    statBoard = 37,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 506,
    statName = "Offroad_SplitTime_7"
  },
  {
    statBoard = 37,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 507,
    statName = "Offroad_SplitTime_8"
  },
  {
    statBoard = 37,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 508,
    statName = "Offroad_SplitTime_9"
  },
  {
    statBoard = 37,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 509,
    statName = "Offroad_SplitTime_10"
  },
  {
    statBoard = 37,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 510,
    statName = "Offroad_SplitTime_11"
  },
  {
    statBoard = 38,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 511,
    statName = "Offroad"
  },
  {
    statBoard = 39,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 550,
    statName = "LuckyEscape_SplitTime_1"
  },
  {
    statBoard = 39,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 551,
    statName = "LuckyEscape_SplitTime_2"
  },
  {
    statBoard = 39,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 552,
    statName = "LuckyEscape_SplitTime_3"
  },
  {
    statBoard = 39,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 553,
    statName = "LuckyEscape_SplitTime_4"
  },
  {
    statBoard = 39,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 554,
    statName = "LuckyEscape_SplitTime_5"
  },
  {
    statBoard = 39,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 555,
    statName = "LuckyEscape_SplitTime_6"
  },
  {
    statBoard = 39,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 556,
    statName = "LuckyEscape_SplitTime_7"
  },
  {
    statBoard = 39,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 557,
    statName = "LuckyEscape_SplitTime_8"
  },
  {
    statBoard = 39,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 558,
    statName = "LuckyEscape_SplitTime_9"
  },
  {
    statBoard = 39,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 559,
    statName = "LuckyEscape_SplitTime_10"
  },
  {
    statBoard = 39,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 560,
    statName = "LuckyEscape_SplitTime_11"
  },
  {
    statBoard = 39,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 561,
    statName = "LuckyEscape_SplitTime_12"
  },
  {
    statBoard = 39,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 562,
    statName = "LuckyEscape_SplitTime_13"
  },
  {
    statBoard = 39,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 563,
    statName = "LuckyEscape_SplitTime_14"
  },
  {
    statBoard = 39,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 564,
    statName = "LuckyEscape_SplitTime_15"
  },
  {
    statBoard = 40,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 565,
    statName = "LuckyEscape"
  },
  {
    statBoard = 41,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 600,
    statName = "Speed_SplitTime_1"
  },
  {
    statBoard = 41,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 601,
    statName = "Speed_SplitTime_2"
  },
  {
    statBoard = 41,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 602,
    statName = "Speed_SplitTime_3"
  },
  {
    statBoard = 41,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 603,
    statName = "Speed_SplitTime_4"
  },
  {
    statBoard = 41,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 604,
    statName = "Speed_SplitTime_5"
  },
  {
    statBoard = 41,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 605,
    statName = "Speed_SplitTime_6"
  },
  {
    statBoard = 41,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 606,
    statName = "Speed_SplitTime_7"
  },
  {
    statBoard = 41,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 607,
    statName = "Speed_SplitTime_8"
  },
  {
    statBoard = 41,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 608,
    statName = "Speed_SplitTime_9"
  },
  {
    statBoard = 41,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 609,
    statName = "Speed_SplitTime_10"
  },
  {
    statBoard = 41,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 610,
    statName = "Speed_SplitTime_11"
  },
  {
    statBoard = 41,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 611,
    statName = "Speed_SplitTime_12"
  },
  {
    statBoard = 41,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 612,
    statName = "Speed_SplitTime_13"
  },
  {
    statBoard = 41,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 613,
    statName = "Speed_SplitTime_14"
  },
  {
    statBoard = 41,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 614,
    statName = "Speed_SplitTime_15"
  },
  {
    statBoard = 42,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 615,
    statName = "Speed"
  },
  {
    statBoard = 43,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 650,
    statName = "MarinCopRun_SplitTime_1"
  },
  {
    statBoard = 43,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 651,
    statName = "MarinCopRun_SplitTime_2"
  },
  {
    statBoard = 43,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 652,
    statName = "MarinCopRun_SplitTime_3"
  },
  {
    statBoard = 43,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 653,
    statName = "MarinCopRun_SplitTime_4"
  },
  {
    statBoard = 43,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 654,
    statName = "MarinCopRun_SplitTime_5"
  },
  {
    statBoard = 43,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 655,
    statName = "MarinCopRun_SplitTime_6"
  },
  {
    statBoard = 43,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 656,
    statName = "MarinCopRun_SplitTime_7"
  },
  {
    statBoard = 43,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 657,
    statName = "MarinCopRun_SplitTime_8"
  },
  {
    statBoard = 43,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 658,
    statName = "MarinCopRun_SplitTime_9"
  },
  {
    statBoard = 44,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 659,
    statName = "MarinCopRun"
  },
  {
    statBoard = 46,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 750,
    statName = "RallyFaceOff_SplitTime_1"
  },
  {
    statBoard = 46,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 751,
    statName = "RallyFaceOff_SplitTime_2"
  },
  {
    statBoard = 46,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 752,
    statName = "RallyFaceOff_SplitTime_3"
  },
  {
    statBoard = 46,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 753,
    statName = "RallyFaceOff_SplitTime_4"
  },
  {
    statBoard = 46,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 754,
    statName = "RallyFaceOff_SplitTime_5"
  },
  {
    statBoard = 46,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 755,
    statName = "RallyFaceOff_SplitTime_6"
  },
  {
    statBoard = 46,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 756,
    statName = "RallyFaceOff_SplitTime_7"
  },
  {
    statBoard = 46,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 757,
    statName = "RallyFaceOff_SplitTime_8"
  },
  {
    statBoard = 46,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 758,
    statName = "RallyFaceOff_SplitTime_9"
  },
  {
    statBoard = 46,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 759,
    statName = "RallyFaceOff_SplitTime_10"
  },
  {
    statBoard = 46,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 760,
    statName = "RallyFaceOff_SplitTime_11"
  },
  {
    statBoard = 46,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 761,
    statName = "RallyFaceOff_SplitTime_12"
  },
  {
    statBoard = 47,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 762,
    statName = "RallyFaceOff"
  },
  {
    statBoard = 48,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 800,
    statName = "TheDriver"
  },
  {
    statBoard = 49,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 850,
    statName = "FreewayFaceoff_SplitTime_1"
  },
  {
    statBoard = 49,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 851,
    statName = "FreewayFaceoff_SplitTime_2"
  },
  {
    statBoard = 49,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 852,
    statName = "FreewayFaceoff_SplitTime_3"
  },
  {
    statBoard = 49,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 853,
    statName = "FreewayFaceoff_SplitTime_4"
  },
  {
    statBoard = 49,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 854,
    statName = "FreewayFaceoff_SplitTime_5"
  },
  {
    statBoard = 49,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 855,
    statName = "FreewayFaceoff_SplitTime_6"
  },
  {
    statBoard = 49,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 856,
    statName = "FreewayFaceoff_SplitTime_7"
  },
  {
    statBoard = 49,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 857,
    statName = "FreewayFaceoff_SplitTime_8"
  },
  {
    statBoard = 49,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 858,
    statName = "FreewayFaceoff_SplitTime_9"
  },
  {
    statBoard = 49,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 859,
    statName = "FreewayFaceoff_SplitTime_10"
  },
  {
    statBoard = 49,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 860,
    statName = "FreewayFaceoff_SplitTime_11"
  },
  {
    statBoard = 49,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 861,
    statName = "FreewayFaceoff_SplitTime_12"
  },
  {
    statBoard = 49,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 862,
    statName = "FreewayFaceoff_SplitTime_13"
  },
  {
    statBoard = 49,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 863,
    statName = "FreewayFaceoff_SplitTime_14"
  },
  {
    statBoard = 49,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 864,
    statName = "FreewayFaceoff_SplitTime_15"
  },
  {
    statBoard = 49,
    statInBoardId = 16,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 865,
    statName = "FreewayFaceoff_SplitTime_16"
  },
  {
    statBoard = 49,
    statInBoardId = 17,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 866,
    statName = "FreewayFaceoff_SplitTime_17"
  },
  {
    statBoard = 49,
    statInBoardId = 18,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 867,
    statName = "FreewayFaceoff_SplitTime_18"
  },
  {
    statBoard = 49,
    statInBoardId = 19,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 868,
    statName = "FreewayFaceoff_SplitTime_19"
  },
  {
    statBoard = 49,
    statInBoardId = 20,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 869,
    statName = "FreewayFaceoff_SplitTime_20"
  },
  {
    statBoard = 49,
    statInBoardId = 21,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 870,
    statName = "FreewayFaceoff_SplitTime_21"
  },
  {
    statBoard = 49,
    statInBoardId = 22,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 871,
    statName = "FreewayFaceoff_SplitTime_22"
  },
  {
    statBoard = 49,
    statInBoardId = 23,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 872,
    statName = "FreewayFaceoff_SplitTime_23"
  },
  {
    statBoard = 49,
    statInBoardId = 24,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 873,
    statName = "FreewayFaceoff_SplitTime_24"
  },
  {
    statBoard = 49,
    statInBoardId = 25,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 874,
    statName = "FreewayFaceoff_SplitTime_25"
  },
  {
    statBoard = 49,
    statInBoardId = 26,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 875,
    statName = "FreewayFaceoff_SplitTime_26"
  },
  {
    statBoard = 49,
    statInBoardId = 27,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 876,
    statName = "FreewayFaceoff_SplitTime_27"
  },
  {
    statBoard = 49,
    statInBoardId = 28,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 877,
    statName = "FreewayFaceoff_SplitTime_28"
  },
  {
    statBoard = 49,
    statInBoardId = 29,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 878,
    statName = "FreewayFaceoff_SplitTime_29"
  },
  {
    statBoard = 50,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 879,
    statName = "FreewayFaceoff"
  },
  {
    statBoard = 51,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMax,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 900,
    statName = "Survival"
  },
  {
    statBoard = 53,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1000,
    statName = "MarinEscape_SplitTime_1"
  },
  {
    statBoard = 53,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1001,
    statName = "MarinEscape_SplitTime_2"
  },
  {
    statBoard = 53,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1002,
    statName = "MarinEscape_SplitTime_3"
  },
  {
    statBoard = 53,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1003,
    statName = "MarinEscape_SplitTime_4"
  },
  {
    statBoard = 53,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1004,
    statName = "MarinEscape_SplitTime_5"
  },
  {
    statBoard = 53,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1005,
    statName = "MarinEscape_SplitTime_6"
  },
  {
    statBoard = 53,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1006,
    statName = "MarinEscape_SplitTime_7"
  },
  {
    statBoard = 53,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1007,
    statName = "MarinEscape_SplitTime_8"
  },
  {
    statBoard = 53,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1008,
    statName = "MarinEscape_SplitTime_9"
  },
  {
    statBoard = 53,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1009,
    statName = "MarinEscape_SplitTime_10"
  },
  {
    statBoard = 53,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1010,
    statName = "MarinEscape_SplitTime_11"
  },
  {
    statBoard = 53,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1011,
    statName = "MarinEscape_SplitTime_12"
  },
  {
    statBoard = 53,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1012,
    statName = "MarinEscape_SplitTime_13"
  },
  {
    statBoard = 53,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1013,
    statName = "MarinEscape_SplitTime_14"
  },
  {
    statBoard = 53,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1014,
    statName = "MarinEscape_SplitTime_15"
  },
  {
    statBoard = 54,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1015,
    statName = "MarinEscape"
  },
  {
    statBoard = 55,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1050,
    statName = "ItalianJob_SplitTime_1"
  },
  {
    statBoard = 55,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1051,
    statName = "ItalianJob_SplitTime_2"
  },
  {
    statBoard = 55,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1052,
    statName = "ItalianJob_SplitTime_3"
  },
  {
    statBoard = 55,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1053,
    statName = "ItalianJob_SplitTime_4"
  },
  {
    statBoard = 55,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1054,
    statName = "ItalianJob_SplitTime_5"
  },
  {
    statBoard = 55,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1055,
    statName = "ItalianJob_SplitTime_6"
  },
  {
    statBoard = 55,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1056,
    statName = "ItalianJob_SplitTime_7"
  },
  {
    statBoard = 55,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1057,
    statName = "ItalianJob_SplitTime_8"
  },
  {
    statBoard = 55,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1058,
    statName = "ItalianJob_SplitTime_9"
  },
  {
    statBoard = 55,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1059,
    statName = "ItalianJob_SplitTime_10"
  },
  {
    statBoard = 55,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1060,
    statName = "ItalianJob_SplitTime_11"
  },
  {
    statBoard = 55,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1061,
    statName = "ItalianJob_SplitTime_12"
  },
  {
    statBoard = 55,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1062,
    statName = "ItalianJob_SplitTime_13"
  },
  {
    statBoard = 55,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1063,
    statName = "ItalianJob_SplitTime_14"
  },
  {
    statBoard = 55,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1064,
    statName = "ItalianJob_SplitTime_15"
  },
  {
    statBoard = 55,
    statInBoardId = 16,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1065,
    statName = "ItalianJob_SplitTime_16"
  },
  {
    statBoard = 55,
    statInBoardId = 17,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1066,
    statName = "ItalianJob_SplitTime_17"
  },
  {
    statBoard = 55,
    statInBoardId = 18,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1067,
    statName = "ItalianJob_SplitTime_18"
  },
  {
    statBoard = 55,
    statInBoardId = 19,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1068,
    statName = "ItalianJob_SplitTime_19"
  },
  {
    statBoard = 55,
    statInBoardId = 20,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1069,
    statName = "ItalianJob_SplitTime_20"
  },
  {
    statBoard = 55,
    statInBoardId = 21,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1070,
    statName = "ItalianJob_SplitTime_21"
  },
  {
    statBoard = 55,
    statInBoardId = 22,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1071,
    statName = "ItalianJob_SplitTime_22"
  },
  {
    statBoard = 55,
    statInBoardId = 23,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1072,
    statName = "ItalianJob_SplitTime_23"
  },
  {
    statBoard = 55,
    statInBoardId = 24,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1073,
    statName = "ItalianJob_SplitTime_24"
  },
  {
    statBoard = 55,
    statInBoardId = 25,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1074,
    statName = "ItalianJob_SplitTime_25"
  },
  {
    statBoard = 56,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1080,
    statName = "ItalianJob"
  },
  {
    statBoard = 57,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1100,
    statName = "Uplaych1_SplitTime_1"
  },
  {
    statBoard = 57,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1101,
    statName = "Uplaych1_SplitTime_2"
  },
  {
    statBoard = 57,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1102,
    statName = "Uplaych1_SplitTime_3"
  },
  {
    statBoard = 57,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1103,
    statName = "Uplaych1_SplitTime_4"
  },
  {
    statBoard = 57,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1104,
    statName = "Uplaych1_SplitTime_5"
  },
  {
    statBoard = 57,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1105,
    statName = "Uplaych1_SplitTime_6"
  },
  {
    statBoard = 57,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1106,
    statName = "Uplaych1_SplitTime_7"
  },
  {
    statBoard = 57,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1107,
    statName = "Uplaych1_SplitTime_8"
  },
  {
    statBoard = 57,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1108,
    statName = "Uplaych1_SplitTime_9"
  },
  {
    statBoard = 57,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1109,
    statName = "Uplaych1_SplitTime_10"
  },
  {
    statBoard = 57,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1110,
    statName = "Uplaych1_SplitTime_11"
  },
  {
    statBoard = 57,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1111,
    statName = "Uplaych1_SplitTime_12"
  },
  {
    statBoard = 57,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1112,
    statName = "Uplaych1_SplitTime_13"
  },
  {
    statBoard = 57,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1113,
    statName = "Uplaych1_SplitTime_14"
  },
  {
    statBoard = 57,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1114,
    statName = "Uplaych1_SplitTime_15"
  },
  {
    statBoard = 57,
    statInBoardId = 16,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1115,
    statName = "Uplaych1_SplitTime_16"
  },
  {
    statBoard = 57,
    statInBoardId = 17,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1116,
    statName = "Uplaych1_SplitTime_17"
  },
  {
    statBoard = 57,
    statInBoardId = 18,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1117,
    statName = "Uplaych1_SplitTime_18"
  },
  {
    statBoard = 57,
    statInBoardId = 19,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1118,
    statName = "Uplaych1_SplitTime_19"
  },
  {
    statBoard = 57,
    statInBoardId = 20,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1119,
    statName = "Uplaych1_SplitTime_20"
  },
  {
    statBoard = 57,
    statInBoardId = 21,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1120,
    statName = "Uplaych1_SplitTime_21"
  },
  {
    statBoard = 57,
    statInBoardId = 22,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1121,
    statName = "Uplaych1_SplitTime_22"
  },
  {
    statBoard = 58,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1122,
    statName = "Uplaych1"
  },
  {
    statBoard = 59,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1150,
    statName = "Uplaych2_SplitTime_1"
  },
  {
    statBoard = 59,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1151,
    statName = "Uplaych2_SplitTime_2"
  },
  {
    statBoard = 59,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1152,
    statName = "Uplaych2_SplitTime_3"
  },
  {
    statBoard = 59,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1153,
    statName = "Uplaych2_SplitTime_4"
  },
  {
    statBoard = 59,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1154,
    statName = "Uplaych2_SplitTime_5"
  },
  {
    statBoard = 59,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1155,
    statName = "Uplaych2_SplitTime_6"
  },
  {
    statBoard = 59,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1156,
    statName = "Uplaych2_SplitTime_7"
  },
  {
    statBoard = 59,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1157,
    statName = "Uplaych2_SplitTime_8"
  },
  {
    statBoard = 59,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1158,
    statName = "Uplaych2_SplitTime_9"
  },
  {
    statBoard = 59,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1159,
    statName = "Uplaych2_SplitTime_10"
  },
  {
    statBoard = 59,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1160,
    statName = "Uplaych2_SplitTime_11"
  },
  {
    statBoard = 59,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1161,
    statName = "Uplaych2_SplitTime_12"
  },
  {
    statBoard = 59,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1162,
    statName = "Uplaych2_SplitTime_13"
  },
  {
    statBoard = 59,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1163,
    statName = "Uplaych2_SplitTime_14"
  },
  {
    statBoard = 59,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1164,
    statName = "Uplaych2_SplitTime_15"
  },
  {
    statBoard = 59,
    statInBoardId = 16,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1165,
    statName = "Uplaych2_SplitTime_16"
  },
  {
    statBoard = 59,
    statInBoardId = 17,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1166,
    statName = "Uplaych2_SplitTime_17"
  },
  {
    statBoard = 59,
    statInBoardId = 18,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1167,
    statName = "Uplaych2_SplitTime_18"
  },
  {
    statBoard = 59,
    statInBoardId = 19,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1168,
    statName = "Uplaych2_SplitTime_19"
  },
  {
    statBoard = 60,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1169,
    statName = "Uplaych2"
  },
  {
    statBoard = 61,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1200,
    statName = "Uplaych3"
  },
  {
    statBoard = 62,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMax,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 1230,
    statDataInfo = scored,
    statName = "Uplaych4"
  },
  {
    statBoard = 63,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1250,
    statName = "Uplaych5_SplitTime_1"
  },
  {
    statBoard = 63,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1251,
    statName = "Uplaych5_SplitTime_2"
  },
  {
    statBoard = 63,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1252,
    statName = "Uplaych5_SplitTime_3"
  },
  {
    statBoard = 63,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1253,
    statName = "Uplaych5_SplitTime_4"
  },
  {
    statBoard = 63,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1254,
    statName = "Uplaych5_SplitTime_5"
  },
  {
    statBoard = 63,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1255,
    statName = "Uplaych5_SplitTime_6"
  },
  {
    statBoard = 63,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1256,
    statName = "Uplaych5_SplitTime_7"
  },
  {
    statBoard = 63,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1257,
    statName = "Uplaych5_SplitTime_8"
  },
  {
    statBoard = 63,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1258,
    statName = "Uplaych5_SplitTime_9"
  },
  {
    statBoard = 63,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1259,
    statName = "Uplaych5_SplitTime_10"
  },
  {
    statBoard = 63,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1260,
    statName = "Uplaych5_SplitTime_11"
  },
  {
    statBoard = 63,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1261,
    statName = "Uplaych5_SplitTime_12"
  },
  {
    statBoard = 63,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1262,
    statName = "Uplaych5_SplitTime_13"
  },
  {
    statBoard = 63,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1263,
    statName = "Uplaych5_SplitTime_14"
  },
  {
    statBoard = 63,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1264,
    statName = "Uplaych5_SplitTime_15"
  },
  {
    statBoard = 63,
    statInBoardId = 16,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1265,
    statName = "Uplaych5_SplitTime_16"
  },
  {
    statBoard = 63,
    statInBoardId = 17,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1266,
    statName = "Uplaych5_SplitTime_17"
  },
  {
    statBoard = 63,
    statInBoardId = 18,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1267,
    statName = "Uplaych5_SplitTime_18"
  },
  {
    statBoard = 63,
    statInBoardId = 19,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1268,
    statName = "Uplaych5_SplitTime_19"
  },
  {
    statBoard = 63,
    statInBoardId = 20,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1269,
    statName = "Uplaych5_SplitTime_20"
  },
  {
    statBoard = 63,
    statInBoardId = 21,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1280,
    statName = "Uplaych5_SplitTime_21"
  },
  {
    statBoard = 63,
    statInBoardId = 22,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1281,
    statName = "Uplaych5_SplitTime_22"
  },
  {
    statBoard = 63,
    statInBoardId = 23,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1282,
    statName = "Uplaych5_SplitTime_23"
  },
  {
    statBoard = 64,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1283,
    statName = "Uplaych5"
  },
  {
    statBoard = 65,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1300,
    statName = "RelayRace_SplitTime_1"
  },
  {
    statBoard = 65,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1301,
    statName = "RelayRace_SplitTime_2"
  },
  {
    statBoard = 65,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1302,
    statName = "RelayRace_SplitTime_3"
  },
  {
    statBoard = 65,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1303,
    statName = "RelayRace_SplitTime_4"
  },
  {
    statBoard = 65,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1304,
    statName = "RelayRace_SplitTime_5"
  },
  {
    statBoard = 65,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1305,
    statName = "RelayRace_SplitTime_6"
  },
  {
    statBoard = 65,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1306,
    statName = "RelayRace_SplitTime_7"
  },
  {
    statBoard = 65,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1307,
    statName = "RelayRace_SplitTime_8"
  },
  {
    statBoard = 65,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1308,
    statName = "RelayRace_SplitTime_9"
  },
  {
    statBoard = 65,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1309,
    statName = "RelayRace_SplitTime_10"
  },
  {
    statBoard = 65,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1310,
    statName = "RelayRace_SplitTime_11"
  },
  {
    statBoard = 65,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1311,
    statName = "RelayRace_SplitTime_12"
  },
  {
    statBoard = 65,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1312,
    statName = "RelayRace_SplitTime_13"
  },
  {
    statBoard = 65,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1313,
    statName = "RelayRace_SplitTime_14"
  },
  {
    statBoard = 65,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1314,
    statName = "RelayRace_SplitTime_15"
  },
  {
    statBoard = 65,
    statInBoardId = 16,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1315,
    statName = "RelayRace_SplitTime_16"
  },
  {
    statBoard = 65,
    statInBoardId = 17,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1316,
    statName = "RelayRace_SplitTime_17"
  },
  {
    statBoard = 65,
    statInBoardId = 18,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1317,
    statName = "RelayRace_SplitTime_18"
  },
  {
    statBoard = 65,
    statInBoardId = 19,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1318,
    statName = "RelayRace_SplitTime_19"
  },
  {
    statBoard = 65,
    statInBoardId = 20,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1319,
    statName = "RelayRace_SplitTime_20"
  },
  {
    statBoard = 65,
    statInBoardId = 21,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1320,
    statName = "RelayRace_SplitTime_21"
  },
  {
    statBoard = 65,
    statInBoardId = 22,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1321,
    statName = "RelayRace_SplitTime_22"
  },
  {
    statBoard = 65,
    statInBoardId = 23,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1322,
    statName = "RelayRace_SplitTime_23"
  },
  {
    statBoard = 65,
    statInBoardId = 24,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1323,
    statName = "RelayRace_SplitTime_24"
  },
  {
    statBoard = 65,
    statInBoardId = 25,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1324,
    statName = "RelayRace_SplitTime_25"
  },
  {
    statBoard = 65,
    statInBoardId = 26,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1325,
    statName = "RelayRace_SplitTime_26"
  },
  {
    statBoard = 65,
    statInBoardId = 27,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1326,
    statName = "RelayRace_SplitTime_27"
  },
  {
    statBoard = 65,
    statInBoardId = 28,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1327,
    statName = "RelayRace_SplitTime_28"
  },
  {
    statBoard = 65,
    statInBoardId = 29,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1328,
    statName = "RelayRace_SplitTime_29"
  },
  {
    statBoard = 65,
    statInBoardId = 30,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1329,
    statName = "RelayRace_SplitTime_30"
  },
  {
    statBoard = 65,
    statInBoardId = 31,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1330,
    statName = "RelayRace_SplitTime_31"
  },
  {
    statBoard = 65,
    statInBoardId = 32,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1331,
    statName = "RelayRace_SplitTime_32"
  },
  {
    statBoard = 65,
    statInBoardId = 33,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1332,
    statName = "RelayRace_SplitTime_33"
  },
  {
    statBoard = 65,
    statInBoardId = 34,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1333,
    statName = "RelayRace_SplitTime_34"
  },
  {
    statBoard = 65,
    statInBoardId = 35,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1334,
    statName = "RelayRace_SplitTime_35"
  },
  {
    statBoard = 65,
    statInBoardId = 36,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1335,
    statName = "RelayRace_SplitTime_36"
  },
  {
    statBoard = 65,
    statInBoardId = 37,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1336,
    statName = "RelayRace_SplitTime_37"
  },
  {
    statBoard = 65,
    statInBoardId = 38,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1337,
    statName = "RelayRace_SplitTime_38"
  },
  {
    statBoard = 65,
    statInBoardId = 39,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1338,
    statName = "RelayRace_SplitTime_39"
  },
  {
    statBoard = 65,
    statInBoardId = 40,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1339,
    statName = "RelayRace_SplitTime_40"
  },
  {
    statBoard = 65,
    statInBoardId = 41,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1340,
    statName = "RelayRace_SplitTime_41"
  },
  {
    statBoard = 65,
    statInBoardId = 42,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1341,
    statName = "RelayRace_SplitTime_42"
  },
  {
    statBoard = 65,
    statInBoardId = 43,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1342,
    statName = "RelayRace_SplitTime_43"
  },
  {
    statBoard = 65,
    statInBoardId = 44,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1343,
    statName = "RelayRace_SplitTime_44"
  },
  {
    statBoard = 66,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1344,
    statName = "RelayRace"
  },
  {
    statBoard = 67,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1350,
    statName = "Team colours tutorial_SplitTime_1"
  },
  {
    statBoard = 67,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1351,
    statName = "Team colours tutorial_SplitTime_2"
  },
  {
    statBoard = 67,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1352,
    statName = "Team colours tutorial_SplitTime_3"
  },
  {
    statBoard = 67,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1353,
    statName = "Team colours tutorial_SplitTime_4"
  },
  {
    statBoard = 67,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1354,
    statName = "Team colours tutorial_SplitTime_5"
  },
  {
    statBoard = 67,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1355,
    statName = "Team colours tutorial_SplitTime_6"
  },
  {
    statBoard = 67,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1356,
    statName = "Team colours tutorial_SplitTime_7"
  },
  {
    statBoard = 67,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1357,
    statName = "Team colours tutorial_SplitTime_8"
  },
  {
    statBoard = 67,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1358,
    statName = "Team colours tutorial_SplitTime_9"
  },
  {
    statBoard = 67,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1359,
    statName = "Team colours tutorial_SplitTime_10"
  },
  {
    statBoard = 67,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1360,
    statName = "Team colours tutorial_SplitTime_11"
  },
  {
    statBoard = 67,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1361,
    statName = "Team colours tutorial_SplitTime_12"
  },
  {
    statBoard = 67,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1362,
    statName = "Team colours tutorial_SplitTime_13"
  },
  {
    statBoard = 67,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1363,
    statName = "Team colours tutorial_SplitTime_14"
  },
  {
    statBoard = 67,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1364,
    statName = "Team colours tutorial_SplitTime_15"
  },
  {
    statBoard = 67,
    statInBoardId = 16,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1365,
    statName = "Team colours tutorial_SplitTime_16"
  },
  {
    statBoard = 67,
    statInBoardId = 17,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1366,
    statName = "Team colours tutorial_SplitTime_17"
  },
  {
    statBoard = 67,
    statInBoardId = 18,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1367,
    statName = "Team colours tutorial_SplitTime_18"
  },
  {
    statBoard = 67,
    statInBoardId = 19,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1368,
    statName = "Team colours tutorial_SplitTime_19"
  },
  {
    statBoard = 67,
    statInBoardId = 20,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1369,
    statName = "Team colours tutorial_SplitTime_20"
  },
  {
    statBoard = 67,
    statInBoardId = 21,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1370,
    statName = "Team colours tutorial_SplitTime_21"
  },
  {
    statBoard = 67,
    statInBoardId = 22,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1371,
    statName = "Team colours tutorial_SplitTime_22"
  },
  {
    statBoard = 67,
    statInBoardId = 23,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1372,
    statName = "Team colours tutorial_SplitTime_23"
  },
  {
    statBoard = 67,
    statInBoardId = 24,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1373,
    statName = "Team colours tutorial_SplitTime_24"
  },
  {
    statBoard = 67,
    statInBoardId = 25,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1374,
    statName = "Team colours tutorial_SplitTime_25"
  },
  {
    statBoard = 67,
    statInBoardId = 26,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1375,
    statName = "Team colours tutorial_SplitTime_26"
  },
  {
    statBoard = 67,
    statInBoardId = 27,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1376,
    statName = "Team colours tutorial_SplitTime_27"
  },
  {
    statBoard = 67,
    statInBoardId = 28,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1377,
    statName = "Team colours tutorial_SplitTime_28"
  },
  {
    statBoard = 67,
    statInBoardId = 29,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1378,
    statName = "Team colours tutorial_SplitTime_29"
  },
  {
    statBoard = 67,
    statInBoardId = 30,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1379,
    statName = "Team colours tutorial_SplitTime_30"
  },
  {
    statBoard = 67,
    statInBoardId = 31,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1380,
    statName = "Team colours tutorial_SplitTime_31"
  },
  {
    statBoard = 67,
    statInBoardId = 32,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1381,
    statName = "Team colours tutorial_SplitTime_32"
  },
  {
    statBoard = 67,
    statInBoardId = 33,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1382,
    statName = "Team colours tutorial_SplitTime_33"
  },
  {
    statBoard = 67,
    statInBoardId = 34,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1383,
    statName = "Team colours tutorial_SplitTime_34"
  },
  {
    statBoard = 67,
    statInBoardId = 35,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1384,
    statName = "Team colours tutorial_SplitTime_35"
  },
  {
    statBoard = 67,
    statInBoardId = 36,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1385,
    statName = "Team colours tutorial_SplitTime_36"
  },
  {
    statBoard = 67,
    statInBoardId = 37,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1386,
    statName = "Team colours tutorial_SplitTime_37"
  },
  {
    statBoard = 68,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1387,
    statName = "Team colours tutorial"
  },
  {
    statBoard = 69,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1400,
    statName = "Mass Chase 2"
  },
  {
    statBoard = 70,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1450,
    statName = "Smoketrail_SplitTime_1"
  },
  {
    statBoard = 70,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1451,
    statName = "Smoketrail_SplitTime_2"
  },
  {
    statBoard = 70,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1452,
    statName = "Smoketrail_SplitTime_3"
  },
  {
    statBoard = 70,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1453,
    statName = "Smoketrail_SplitTime_4"
  },
  {
    statBoard = 70,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1454,
    statName = "Smoketrail_SplitTime_5"
  },
  {
    statBoard = 70,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1455,
    statName = "Smoketrail_SplitTime_6"
  },
  {
    statBoard = 70,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1456,
    statName = "Smoketrail_SplitTime_7"
  },
  {
    statBoard = 71,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1457,
    statName = "Smoketrail"
  },
  {
    statBoard = 72,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1500,
    statName = "Car park"
  },
  {
    statBoard = 73,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1550,
    statName = "CopOut_SplitTime_1"
  },
  {
    statBoard = 73,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1551,
    statName = "CopOut_SplitTime_2"
  },
  {
    statBoard = 73,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1552,
    statName = "CopOut_SplitTime_3"
  },
  {
    statBoard = 73,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1553,
    statName = "CopOut_SplitTime_4"
  },
  {
    statBoard = 73,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1554,
    statName = "CopOut_SplitTime_5"
  },
  {
    statBoard = 73,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1555,
    statName = "CopOut_SplitTime_6"
  },
  {
    statBoard = 73,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1556,
    statName = "CopOut_SplitTime_7"
  },
  {
    statBoard = 73,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1557,
    statName = "CopOut_SplitTime_8"
  },
  {
    statBoard = 73,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1558,
    statName = "CopOut_SplitTime_9"
  },
  {
    statBoard = 73,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1559,
    statName = "CopOut_SplitTime_10"
  },
  {
    statBoard = 73,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1560,
    statName = "CopOut_SplitTime_11"
  },
  {
    statBoard = 73,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1561,
    statName = "CopOut_SplitTime_12"
  },
  {
    statBoard = 73,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1562,
    statName = "CopOut_SplitTime_13"
  },
  {
    statBoard = 73,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1563,
    statName = "CopOut_SplitTime_14"
  },
  {
    statBoard = 73,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1564,
    statName = "CopOut_SplitTime_15"
  },
  {
    statBoard = 73,
    statInBoardId = 16,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1565,
    statName = "CopOut_SplitTime_16"
  },
  {
    statBoard = 73,
    statInBoardId = 17,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1566,
    statName = "CopOut_SplitTime_17"
  },
  {
    statBoard = 73,
    statInBoardId = 18,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1567,
    statName = "CopOut_SplitTime_18"
  },
  {
    statBoard = 73,
    statInBoardId = 19,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1568,
    statName = "CopOut_SplitTime_19"
  },
  {
    statBoard = 73,
    statInBoardId = 20,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1569,
    statName = "CopOut_SplitTime_20"
  },
  {
    statBoard = 74,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1570,
    statName = "CopOut"
  },
  {
    statBoard = 75,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1600,
    statName = "Handle challenge"
  },
  {
    statBoard = 76,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMax,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 1650,
    statName = "DriveToSurvive2"
  },
  {
    statBoard = 77,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1700,
    statName = "Charity 2"
  },
  {
    statBoard = 78,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1750,
    statName = "Deactivating bombs 2"
  },
  {
    statBoard = 79,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMax,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Descending,
    statID = 1800,
    statName = "Big break 2"
  },
  {
    statBoard = 80,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 700,
    statName = "DownhillDrift_SplitTime_1"
  },
  {
    statBoard = 80,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 701,
    statName = "DownhillDrift_SplitTime_2"
  },
  {
    statBoard = 80,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 702,
    statName = "DownhillDrift_SplitTime_3"
  },
  {
    statBoard = 80,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 703,
    statName = "DownhillDrift_SplitTime_4"
  },
  {
    statBoard = 80,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 704,
    statName = "DownhillDrift_SplitTime_5"
  },
  {
    statBoard = 80,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 705,
    statName = "DownhillDrift_SplitTime_6"
  },
  {
    statBoard = 80,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 706,
    statName = "DownhillDrift_SplitTime_7"
  },
  {
    statBoard = 80,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 707,
    statName = "DownhillDrift_SplitTime_8"
  },
  {
    statBoard = 80,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 708,
    statName = "DownhillDrift_SplitTime_9"
  },
  {
    statBoard = 80,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 709,
    statName = "DownhillDrift_SplitTime_10"
  },
  {
    statBoard = 80,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 710,
    statName = "DownhillDrift_SplitTime_11"
  },
  {
    statBoard = 80,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 711,
    statName = "DownhillDrift_SplitTime_12"
  },
  {
    statBoard = 80,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 712,
    statName = "DownhillDrift_SplitTime_13"
  },
  {
    statBoard = 80,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 713,
    statName = "DownhillDrift_SplitTime_14"
  },
  {
    statBoard = 80,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 714,
    statName = "DownhillDrift_SplitTime_15"
  },
  {
    statBoard = 80,
    statInBoardId = 16,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 715,
    statName = "DownhillDrift_SplitTime_16"
  },
  {
    statBoard = 80,
    statInBoardId = 17,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 716,
    statName = "DownhillDrift_SplitTime_17"
  },
  {
    statBoard = 80,
    statInBoardId = 18,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 717,
    statName = "DownhillDrift_SplitTime_18"
  },
  {
    statBoard = 80,
    statInBoardId = 19,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 718,
    statName = "DownhillDrift_SplitTime_19"
  },
  {
    statBoard = 80,
    statInBoardId = 20,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 719,
    statName = "DownhillDrift_SplitTime_20"
  },
  {
    statBoard = 81,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 720,
    statName = "DownhillDrift"
  },
  {
    statBoard = 82,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1850,
    statName = "HardcoreChallenge_SplitTime_1"
  },
  {
    statBoard = 82,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1851,
    statName = "HardcoreChallenge_SplitTime_2"
  },
  {
    statBoard = 82,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1852,
    statName = "HardcoreChallenge_SplitTime_3"
  },
  {
    statBoard = 82,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1853,
    statName = "HardcoreChallenge_SplitTime_4"
  },
  {
    statBoard = 82,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1854,
    statName = "HardcoreChallenge_SplitTime_5"
  },
  {
    statBoard = 82,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1855,
    statName = "HardcoreChallenge_SplitTime_6"
  },
  {
    statBoard = 82,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1856,
    statName = "HardcoreChallenge_SplitTime_7"
  },
  {
    statBoard = 82,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1857,
    statName = "HardcoreChallenge_SplitTime_8"
  },
  {
    statBoard = 82,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1858,
    statName = "HardcoreChallenge_SplitTime_9"
  },
  {
    statBoard = 82,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1859,
    statName = "HardcoreChallenge_SplitTime_10"
  },
  {
    statBoard = 82,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1860,
    statName = "HardcoreChallenge_SplitTime_11"
  },
  {
    statBoard = 82,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1861,
    statName = "HardcoreChallenge_SplitTime_12"
  },
  {
    statBoard = 82,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1862,
    statName = "HardcoreChallenge_SplitTime_13"
  },
  {
    statBoard = 82,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1863,
    statName = "HardcoreChallenge_SplitTime_14"
  },
  {
    statBoard = 82,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1864,
    statName = "HardcoreChallenge_SplitTime_15"
  },
  {
    statBoard = 82,
    statInBoardId = 16,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1865,
    statName = "HardcoreChallenge_SplitTime_16"
  },
  {
    statBoard = 82,
    statInBoardId = 17,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1866,
    statName = "HardcoreChallenge_SplitTime_17"
  },
  {
    statBoard = 82,
    statInBoardId = 18,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1867,
    statName = "HardcoreChallenge_SplitTime_18"
  },
  {
    statBoard = 82,
    statInBoardId = 19,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1868,
    statName = "HardcoreChallenge_SplitTime_19"
  },
  {
    statBoard = 82,
    statInBoardId = 20,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1869,
    statName = "HardcoreChallenge_SplitTime_20"
  },
  {
    statBoard = 82,
    statInBoardId = 21,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1870,
    statName = "HardcoreChallenge_SplitTime_21"
  },
  {
    statBoard = 82,
    statInBoardId = 22,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1871,
    statName = "HardcoreChallenge_SplitTime_22"
  },
  {
    statBoard = 82,
    statInBoardId = 23,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1872,
    statName = "HardcoreChallenge_SplitTime_23"
  },
  {
    statBoard = 82,
    statInBoardId = 24,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1873,
    statName = "HardcoreChallenge_SplitTime_24"
  },
  {
    statBoard = 82,
    statInBoardId = 25,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1874,
    statName = "HardcoreChallenge_SplitTime_25"
  },
  {
    statBoard = 82,
    statInBoardId = 26,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1875,
    statName = "HardcoreChallenge_SplitTime_26"
  },
  {
    statBoard = 82,
    statInBoardId = 27,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1876,
    statName = "HardcoreChallenge_SplitTime_27"
  },
  {
    statBoard = 82,
    statInBoardId = 28,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1877,
    statName = "HardcoreChallenge_SplitTime_28"
  },
  {
    statBoard = 82,
    statInBoardId = 29,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1878,
    statName = "HardcoreChallenge_SplitTime_29"
  },
  {
    statBoard = 82,
    statInBoardId = 30,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 1879,
    statName = "HardcoreChallenge_SplitTime_30"
  },
  {
    statBoard = 83,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 1880,
    statName = "HardcoreChallenge"
  },
  {
    statBoard = 84,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 950,
    statName = "SutroDrift_SplitTime_1"
  },
  {
    statBoard = 84,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 951,
    statName = "SutroDrift_SplitTime_2"
  },
  {
    statBoard = 84,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 952,
    statName = "SutroDrift_SplitTime_3"
  },
  {
    statBoard = 84,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 953,
    statName = "SutroDrift_SplitTime_4"
  },
  {
    statBoard = 84,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 954,
    statName = "SutroDrift_SplitTime_5"
  },
  {
    statBoard = 84,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 955,
    statName = "SutroDrift_SplitTime_6"
  },
  {
    statBoard = 84,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 956,
    statName = "SutroDrift_SplitTime_7"
  },
  {
    statBoard = 84,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 957,
    statName = "SutroDrift_SplitTime_8"
  },
  {
    statBoard = 84,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 958,
    statName = "SutroDrift_SplitTime_9"
  },
  {
    statBoard = 84,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 959,
    statName = "SutroDrift_SplitTime_10"
  },
  {
    statBoard = 84,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 960,
    statName = "SutroDrift_SplitTime_11"
  },
  {
    statBoard = 84,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 961,
    statName = "SutroDrift_SplitTime_12"
  },
  {
    statBoard = 84,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 962,
    statName = "SutroDrift_SplitTime_13"
  },
  {
    statBoard = 84,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 963,
    statName = "SutroDrift_SplitTime_14"
  },
  {
    statBoard = 84,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 964,
    statName = "SutroDrift_SplitTime_15"
  },
  {
    statBoard = 84,
    statInBoardId = 16,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 965,
    statName = "SutroDrift_SplitTime_16"
  },
  {
    statBoard = 84,
    statInBoardId = 17,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 966,
    statName = "SutroDrift_SplitTime_17"
  },
  {
    statBoard = 84,
    statInBoardId = 18,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 967,
    statName = "SutroDrift_SplitTime_18"
  },
  {
    statBoard = 85,
    statInBoardId = 1,
    statType = type_int32,
    statWritePolicy = policy_ReplaceIfMin,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statRankingOrder = RankingOrder_Ascending,
    statID = 968,
    statName = "SutroDrift"
  },
  {
    statBoard = 100,
    statInBoardId = 1,
    statType = type_float,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2544,
    statName = "GetTimePlayed"
  },
  {
    statBoard = 100,
    statInBoardId = 2,
    statType = type_float,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2545,
    statName = "Vehicle_GetTimeInAnyCar"
  },
  {
    statBoard = 100,
    statInBoardId = 3,
    statType = type_float,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2546,
    statName = "Vehicle_GetAverageSpeed"
  },
  {
    statBoard = 100,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2547,
    statName = "Favourite car"
  },
  {
    statBoard = 100,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2548,
    statName = "Vehicle_GetDistanceForward"
  },
  {
    statBoard = 100,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2549,
    statName = "HitMiss_GetNumCarsHit"
  },
  {
    statBoard = 100,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2550,
    statName = "HitMiss_GetNumNearMisses"
  },
  {
    statBoard = 100,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2551,
    statName = "HitMiss_GetNumOvertakes"
  },
  {
    statBoard = 100,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2552,
    statName = "HitMiss_GetLongestOvertakeChain"
  },
  {
    statBoard = 100,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2553,
    statName = "Manoeuvres_GetNumHandbrakeTurns"
  },
  {
    statBoard = 100,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2554,
    statName = "Manoeuvres_GetNum180s"
  },
  {
    statBoard = 100,
    statInBoardId = 12,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2555,
    statName = "Manoeuvres_GetNum360s"
  },
  {
    statBoard = 100,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2556,
    statName = "Manoeuvres_GetNumJTurns"
  },
  {
    statBoard = 100,
    statInBoardId = 14,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2557,
    statName = "Manoeuvres_GetNumTrailersDrivenUnder"
  },
  {
    statBoard = 100,
    statInBoardId = 15,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2558,
    statName = "Manoeuvres_GetNumVehicleTowed"
  },
  {
    statBoard = 100,
    statInBoardId = 16,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2559,
    statName = "Zap_GetNumZaps"
  },
  {
    statBoard = 100,
    statInBoardId = 17,
    statType = type_float,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2560,
    statName = "Zap_GetTimeInZap"
  },
  {
    statBoard = 100,
    statInBoardId = 18,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2561,
    statName = "Felony_GetNumFeloniesTriggered"
  },
  {
    statBoard = 100,
    statInBoardId = 19,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2562,
    statName = "Chase_GetCriminalsAprehended"
  },
  {
    statBoard = 100,
    statInBoardId = 20,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2563,
    statName = "Chase_GetCriminalsEscaped"
  },
  {
    statBoard = 100,
    statInBoardId = 21,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2564,
    statName = "Getaway_GetTimesTriggered"
  },
  {
    statBoard = 100,
    statInBoardId = 22,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2565,
    statName = "Getaway_GetTimesEscaped"
  },
  {
    statBoard = 100,
    statInBoardId = 23,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2566,
    statName = "Getaway_GetTimesAprehended"
  },
  {
    statBoard = 100,
    statInBoardId = 24,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2567,
    statName = "Jumps_GetNumJumps"
  },
  {
    statBoard = 100,
    statInBoardId = 25,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2568,
    statName = "Jumps_GetTotalJumpDistance"
  },
  {
    statBoard = 100,
    statInBoardId = 26,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2569,
    statName = "Jumps_GetLongestJumpDistance"
  },
  {
    statBoard = 100,
    statInBoardId = 27,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2570,
    statName = "Jumps_GetAverageJumpDistance"
  },
  {
    statBoard = 100,
    statInBoardId = 28,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2571,
    statName = "Jumps_GetNumVehiclesJumpedOver"
  },
  {
    statBoard = 100,
    statInBoardId = 29,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2572,
    statName = "Jumps_GetNumRampTruckJumped"
  },
  {
    statBoard = 100,
    statInBoardId = 30,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2573,
    statName = "Drift_GetNumDrifts"
  },
  {
    statBoard = 100,
    statInBoardId = 31,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2574,
    statName = "Drift_GetTotalDistance"
  },
  {
    statBoard = 100,
    statInBoardId = 32,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2575,
    statName = "Drift_GetLongestSingleDistance"
  },
  {
    statBoard = 100,
    statInBoardId = 33,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2576,
    statName = "Boost_GetNumBoosts"
  },
  {
    statBoard = 100,
    statInBoardId = 34,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2577,
    statName = "Boost_GetLongest"
  },
  {
    statBoard = 100,
    statInBoardId = 35,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2578,
    statName = "Ram_GetNumRams"
  },
  {
    statBoard = 100,
    statInBoardId = 36,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2579,
    statName = "Ram_PercentHit"
  },
  {
    statBoard = 100,
    statInBoardId = 37,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2580,
    statName = "SP_GetActivitiesCompleted"
  },
  {
    statBoard = 100,
    statInBoardId = 38,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2581,
    statName = "SP_GetDaresCompleted"
  },
  {
    statBoard = 100,
    statInBoardId = 39,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2582,
    statName = "SP_GetMovieTokensCollected"
  },
  {
    statBoard = 100,
    statInBoardId = 40,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2583,
    statName = "iMissionsPassed"
  },
  {
    statBoard = 100,
    statInBoardId = 41,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2584,
    statName = "MP_GetNumCarSwaps"
  },
  {
    statBoard = 100,
    statInBoardId = 42,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2585,
    statName = "MP_GetNumSuccessfulZapAttacks"
  },
  {
    statBoard = 100,
    statInBoardId = 43,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2586,
    statName = "Challenges_GetNumCompleted"
  },
  {
    statBoard = 100,
    statInBoardId = 44,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2587,
    statName = "Challenges_GetFavouriteChallengeID"
  },
  {
    statBoard = 100,
    statInBoardId = 45,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2588,
    statName = "SP_GetSWillpowerEarned"
  },
  {
    statBoard = 100,
    statInBoardId = 46,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2589,
    statName = "SP_GetSpentWillpower"
  },
  {
    statBoard = 100,
    statInBoardId = 47,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2590,
    statName = "SP_GetWillpowerFromMissions"
  },
  {
    statBoard = 100,
    statInBoardId = 48,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2591,
    statName = "SP_GetWillpowerFromDriving"
  },
  {
    statBoard = 100,
    statInBoardId = 49,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2592,
    statName = "SP_GetWillpowerFromGarages"
  },
  {
    statBoard = 100,
    statInBoardId = 50,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2593,
    statName = "Garages_GetGaragesOwned"
  },
  {
    statBoard = 100,
    statInBoardId = 51,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2594,
    statName = "Garages_GetVehiclesOwned"
  },
  {
    statBoard = 100,
    statInBoardId = 52,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2595,
    statName = "Garages_GarageUpgrades"
  },
  {
    statBoard = 100,
    statInBoardId = 53,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2596,
    statName = "Chase_GetTimesTriggered"
  },
  {
    statBoard = 100,
    statInBoardId = 54,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparisom = 0,
    statID = 2597,
    statName = "SP_GetMostPlayedActivity"
  },
  {
    statBoard = 100,
    statInBoardId = 55,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 2598,
    statName = "MP_LEVEL"
  },
  {
    statBoard = 100,
    statInBoardId = 56,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 2599,
    statName = "SP_GetGameCompletitionPercentage"
  },
  {
    statBoard = 100,
    statInBoardId = 57,
    statType = type_float,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 2600,
    statName = "Manoeuvres_GetNumBarrelRolls"
  },
  {
    statBoard = 101,
    statInBoardId = 2,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 2601,
    statName = "Tag Last Rank"
  },
  {
    statBoard = 101,
    statInBoardId = 3,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 2602,
    statName = "Takedown Last Rank"
  },
  {
    statBoard = 101,
    statInBoardId = 4,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 2603,
    statName = "Blazer Last Rank"
  },
  {
    statBoard = 101,
    statInBoardId = 5,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 2604,
    statName = "Tug Rank"
  },
  {
    statBoard = 101,
    statInBoardId = 6,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 2605,
    statName = "Burning Rank"
  },
  {
    statBoard = 101,
    statInBoardId = 7,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 2606,
    statName = "Rushdown Rank"
  },
  {
    statBoard = 101,
    statInBoardId = 8,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 2607,
    statName = "Sprint Rank"
  },
  {
    statBoard = 101,
    statInBoardId = 9,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 2608,
    statName = "Circuit Rank"
  },
  {
    statBoard = 101,
    statInBoardId = 10,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 2609,
    statName = "Pure Rank"
  },
  {
    statBoard = 101,
    statInBoardId = 11,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 2610,
    statName = "Team Circuit Rank"
  },
  {
    statBoard = 101,
    statInBoardId = 13,
    statType = type_int32,
    statWritePolicy = policy_Overwrite,
    statInstantBroadcast = 0,
    statFriendComparison = 0,
    statID = 2611,
    statName = "Rush Last Rank"
  }
}
function getStatType(_statID)
  for i = 1, #StatisticList do
    if StatisticList[i].statID == _statID then
      return StatisticList[i].statType
    end
  end
  callStack()
  assert(false, "getStatType: Can't find a stat with statID " .. tostring(_statID))
  return type_int32
end
_G.getStatType = getStatType
function getStatDisplayType(statBoardId, statInBoardId)
  for i = 1, #StatisticList do
    if StatisticList[i].statBoard == statBoardId and StatisticList[i].statInBoardId == statInBoardId then
      if StatisticList[i].statDisplayType then
        return StatisticList[i].statDisplayType
      else
        return StatisticList[i].statType
      end
    end
  end
  callStack()
  assert(false, "getStatDisplayType: Can't find a stat with statID " .. tostring(_statID))
  return type_int32
end
_G.getStatDisplayType = getStatDisplayType
function getCoopStartIndex()
  print("getCoopStartIndex()")
  return start_Coop_StatID
end
function getCoopEndIndex()
  print("getCoopEndIndex()")
  return end_Coop_StatID
end
function getCoopHighScoreStatIndex(missionIndex, level)
  print("getCoopHighScoreStatIndex()")
  return start_Coop_StatID
end
_G.getCoopStartStatIndex = getCoopStartIndex
_G.getCoopEndStatIndex = getCoopEndIndex
_G.getCoopHighScoreStatIndex = getCoopHighScoreStatIndex
function getStatIDFromName(statName)
  for i = 1, #StatisticList do
    if StatisticList[i].statName == statName then
      return StatisticList[i].statID
    end
  end
  callStack()
  assert(false, "Can't find a stat with name " .. tostring(statName))
  return 0
end
_G.getStatIDFromName = getStatIDFromName
function getStatBoardFromName(statName)
  for i = 1, #StatisticList do
    if StatisticList[i].statName == statName then
      return StatisticList[i].statBoard
    end
  end
  callStack()
  assert(false, "Can't find a stat with name " .. tostring(statName))
  return 0
end
_G.getStatBoardIDFromName = getStatIDFromName
function getStatID(statBoardId, statInBoardId)
  for i = 1, #StatisticList do
    if StatisticList[i].statBoard == statBoardId and StatisticList[i].statInBoardId == statInBoardId then
      return StatisticList[i].statID
    end
  end
  callStack()
  assert(false, "getStatID: Can't find a stat with statBoardId " .. tostring(statBoardId) .. " and statInBoardId " .. tostring(statInBoardId))
  return -1
end
function getStatNameFromStatID(statBoardId, statInBoardId)
  for i = 1, #StatisticList do
    if StatisticList[i].statBoard == statBoardId and StatisticList[i].statInBoardId == statInBoardId then
      return StatisticList[i].statName
    end
  end
  callStack()
  assert(false, "getStatNameFromStatID: Can't find a stat with statBoardId " .. tostring(statBoardId) .. " and statInBoardId " .. tostring(statInBoardId))
  return "null"
end
_G.getStatNameFromStatID = getStatNameFromStatID
function getFENameFromStatID(statBoardId, statInBoardId)
  for i = 1, #StatisticList do
    if StatisticList[i].statBoard == statBoardId and StatisticList[i].statInBoardId == statInBoardId then
      return StatisticList[i].feName
    end
  end
  callStack()
  assert(false, "getFENameFromStatID: Can't find a stat with statBoardId " .. tostring(statBoardId) .. " and statInBoardId " .. tostring(statInBoardId))
  return "null"
end
_G.getFENameFromStatID = getFENameFromStatID
function getStatIDByStatName(name)
  for i = 1, #StatisticList do
    if StatisticList[i].statName == name then
      return StatisticList[i].statID
    end
  end
  callStack()
  assert(false, "getStatIDByStatName: Can't find a stat with name " .. tostring(name))
  return -1
end
function generateStatCollectionFromMissionID(missionID)
  local statCollection = {}
  for i = 1, #StatisticList do
    local position = string.find(StatisticList[i].statName, missionID)
    if position == 1 and StatisticList[i].statBoard >= 26 then
      table.insert(statCollection, StatisticList[i])
    end
  end
  return statCollection
end
function getStatInfo(_statID)
  for i = 1, #StatisticList do
    if StatisticList[i].statID == _statID then
      return StatisticList[i].statBoard, StatisticList[i].statInBoardId, StatisticList[i].statWritePolicy, StatisticList[i].statInstantBroadcast, StatisticList[i].statFriendComparison, StatisticList[i].statName
    end
  end
  print("getStatInfo: Can't find a stat with statID " .. tostring(_statID))
end
_G.getStatInfo = getStatInfo
function receivedStat(statBoardId, statInBoardId, value)
  local statID = getStatID(statBoardId, statInBoardId)
  print("receivedStat boardId " .. tostring(statBoardId) .. " inboardId " .. tostring(statInBoardId) .. " value " .. tostring(value) .. " statID " .. tostring(statID))
  assert(value ~= nil, "receivedStat - value received is nil")
  if statBoardId < 18 then
    onlineStatistics.setStatistic(statID, value)
  elseif statBoardId < 26 then
  else
    singlePlayerStatistics.setStatistic(statID, value)
  end
end
_G.receivedStat = receivedStat
function getStatDataInfo(statBoardId, statInBoardId)
  for i = 1, #StatisticList do
    if StatisticList[i].statBoard == statBoardId and StatisticList[i].statInBoardId == statInBoardId then
      if StatisticList[i].statDataInfo then
        return StatisticList[i].statDataInfo
      else
        return timed
      end
    end
  end
  return illegal
end
_G.getStatDataInfo = getStatDataInfo
function getStatRankingOrder(statBoardId, statInBoardId)
  for i = 1, #StatisticList do
    if StatisticList[i].statBoard == statBoardId and StatisticList[i].statInBoardId == statInBoardId then
      return StatisticList[i].statRankingOrder
    end
  end
  return RankingOrder_Invalid
end
_G.getStatRankingOrder = getStatRankingOrder
function coreStatsReceivedCallback(playerID)
  if playerID == localPlayer.playerID then
    onlineProgressionSystem.progressionSetup(true)
  else
    onlineScreenManager.setPlayerXP(playerID, PlayerCoreStats.getPlayerTotalXP(playerID))
  end
end
_G.CoreStatsReceived = coreStatsReceivedCallback
