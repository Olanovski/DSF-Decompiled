local points = 0
local time = 1
local LeaderboardConfigurations = {
  {
    format = time,
    name = "Checkpoint Race",
    visible = 1
  },
  {
    format = time,
    name = "Lose Em (Cop)",
    visible = 0
  },
  {
    format = time,
    name = "Lose Em (Getaway)",
    visible = 0
  },
  {
    format = points,
    name = "Points (Taxi/Novice)",
    visible = 0
  },
  {
    format = points,
    name = "Multiplayer",
    visible = 1
  },
  {
    format = time,
    name = "Drop Off",
    visible = 0
  },
  {
    format = time,
    name = "8-player Checkpoint",
    visible = 0
  },
  {
    format = points,
    name = "Not Just Your Average",
    visible = 0
  },
  {
    format = time,
    name = "Islais Creek",
    visible = 0
  },
  {
    format = time,
    name = "The Perfect Landing",
    visible = 0
  },
  {
    format = time,
    name = "High Speed Endurance",
    visible = 0
  },
  {
    format = points,
    name = "Jump!",
    visible = 0
  },
  {
    format = time,
    name = "Nitro!",
    visible = 0
  },
  {
    format = points,
    name = "The Perfect Line",
    visible = 0
  },
  {
    format = points,
    name = "Rack Em Up",
    visible = 0
  },
  {
    format = points,
    name = "Fare Game",
    visible = 0
  },
  {
    format = time,
    name = "Frequent Flyer",
    visible = 0
  },
  {
    format = points,
    name = "Last Stop",
    visible = 0
  },
  {
    format = points,
    name = "Dumped",
    visible = 0
  },
  {
    format = points,
    name = "Feel the Breeze",
    visible = 0
  },
  {
    format = time,
    name = "Unfair Competition",
    visible = 0
  },
  {
    format = points,
    name = "Zap",
    visible = 0
  },
  {
    format = points,
    name = "Unused",
    visible = 0
  },
  {
    format = points,
    name = "Unused",
    visible = 0
  },
  {
    format = points,
    name = "Unused",
    visible = 0
  },
  {
    format = points,
    name = "Unused",
    visible = 0
  },
  {
    format = points,
    name = "Unused",
    visible = 0
  }
}
function getLeaderboardFormat(leaderboardID)
  return LeaderboardConfigurations[leaderboardID].format
end
function getLeaderboardName(leaderboardID)
  return LeaderboardConfigurations[leaderboardID].name
end
function isLeaderboardVisible(leaderboardID)
  return LeaderboardConfigurations[leaderboardID].visible
end
function getLeaderboardInfo(leaderboardID)
  return LeaderboardConfigurations[leaderboardID].format, LeaderboardConfigurations[leaderboardID].name, LeaderboardConfigurations[leaderboardID].visible
end
