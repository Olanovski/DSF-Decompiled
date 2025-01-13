module("onlineStatistics", package.seeall)
onlineStatisticsData = {
  ["MP tag"] = {
    Win = "Tag Wins",
    Loss = "Tag Losses",
    Score = "Tag Score",
    Specific = "Tag Time Tagged",
    Position = "Tag Last Rank",
    UpdateProfileOnWin = function()
      ProfileSettings.SetNumTagWins(ProfileSettings.GetNumTagWins() + 1)
    end
  },
  ["MP takedown"] = {
    Win = "Takedown Wins",
    Loss = "Takedown Losses",
    Score = "Takedown Score",
    Specific = "Takedown Drop Offs",
    Position = "Takedown Last Rank",
    UpdateProfileOnWin = function()
      ProfileSettings.SetNumTakedownWins(ProfileSettings.GetNumTakedownWins() + 1)
    end
  },
  ["MP burning rubber"] = {
    Win = "Burning Wins",
    Loss = "Burning Losses",
    Score = "Burning Score",
    Specific = "Burning Checkpoints Crossed",
    Position = "Burning Rank",
    UpdateProfileOnWin = function()
      ProfileSettings.SetNumBurningRubberWins(ProfileSettings.GetNumBurningRubberWins() + 1)
    end
  },
  ["MP circuit race"] = {
    Win = "Circuit Wins",
    Loss = "Circuit Losses",
    Score = "Circuit Score",
    Specific = "Circuit Average Placing",
    Position = "Circuit Rank",
    UpdateProfileOnWin = function()
      ProfileSettings.SetNumCircuitRacerWins(ProfileSettings.GetNumCircuitRacerWins() + 1)
    end
  },
  ["MP pure race"] = {
    Win = "Pure Wins",
    Loss = "Pure Losses",
    Score = "Pure Score",
    Specific = "Pure Average Placing",
    Position = "Pure Rank",
    UpdateProfileOnWin = function()
      ProfileSettings.SetNumPureRacerWins(ProfileSettings.GetNumPureRacerWins() + 1)
    end
  },
  ["MP sprint race"] = {
    Win = "Sprint Wins",
    Loss = "Sprint Losses",
    Score = "Sprint Score",
    Specific = "Sprint Average Placing",
    Position = "Sprint Rank",
    UpdateProfileOnWin = function()
      ProfileSettings.SetNumSprintRacerWins(ProfileSettings.GetNumSprintRacerWins() + 1)
    end
  },
  ["MP checkpoint rush"] = {
    Win = "Rush Wins",
    Loss = "Rush Losses",
    Score = "Rush Score",
    Specific = "Rush Average Placing",
    Position = "Rush Last Rank",
    UpdateProfileOnWin = function()
      ProfileSettings.SetNumCheckpointRushWins(ProfileSettings.GetNumCheckpointRushWins() + 1)
    end
  },
  ["MP tug of war"] = {
    Win = "Tug Wins",
    Loss = "Tug Losses",
    Score = "Tug Score",
    Specific = "Tug Flags Captured",
    Position = "Tug Rank",
    UpdateProfileOnWin = function()
      ProfileSettings.SetNumTugOfWarWins(ProfileSettings.GetNumTugOfWarWins() + 1)
    end
  },
  ["MP rush down"] = {
    Win = "Rushdown Wins",
    Loss = "Rushdown Losses",
    Score = "Rushdown Score",
    Specific = "Rushdown Objectives Destroyed",
    Position = "Rushdown Rank",
    UpdateProfileOnWin = function()
      ProfileSettings.SetNumRushdownWins(ProfileSettings.GetNumRushdownWins() + 1)
    end
  },
  ["MP trail blazer"] = {
    Win = "Blazer Wins",
    Loss = "Blazer Losses",
    Score = "Blazer Score",
    Specific = "Blazer Time in Trails",
    Position = "Blazer Last Rank",
    UpdateProfileOnWin = function()
      ProfileSettings.SetNumTrailBlazerWins(ProfileSettings.GetNumTrailBlazerWins() + 1)
    end
  },
  ["MP team circuit race"] = {
    Win = "Team Circuit Race Wins",
    Loss = "Team Circuit Race Losses",
    Score = "Team Circuit Race Score",
    Specific = "Team Circuit Race Checkpoints Crossed",
    Position = "Team Circuit Rank",
    UpdateProfileOnWin = function()
      ProfileSettings.SetNumTeamCircuitRacerWins(ProfileSettings.GetNumTeamCircuitRacerWins() + 1)
    end
  },
  ["MP Vehicle Swap Tutorial"] = {
    Win = false,
    Loss = false,
    Score = false,
    Specific = false,
    Position = false,
    UpdateProfileOnWin = false
  },
  ["MP Vehicle Spawn Tutorial"] = {
    Win = false,
    Loss = false,
    Score = false,
    Specific = false,
    Position = false,
    UpdateProfileOnWin = false
  },
  ["MP shift impulse tutorial"] = {
    Win = false,
    Loss = false,
    Score = false,
    Specific = false,
    Position = false,
    UpdateProfileOnWin = false
  },
  ["MP general mechanics tutorial"] = {
    Win = false,
    Loss = false,
    Score = false,
    Specific = false,
    Position = false,
    UpdateProfileOnWin = false
  }
}
