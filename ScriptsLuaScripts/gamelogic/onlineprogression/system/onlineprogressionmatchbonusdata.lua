module("onlineProgressionSystem", package.seeall)
local averageXP = 4.167
local winningTeamAvgXP = 5
local losingTeamAvgXP = 3.472
minimumPercentMatchBonus = 0.2
tagTakeXP = 75
tagTakeCD = 10
tagHoldXPS = 15
trailblazerTrailsXPS = 14
trailblazerAttackXP = 31
trailblazerAttackCD = 20
takedownDropOff1XP = 200
takedownDropOff2XP = 400
takedownDropOff3XP = 600
takedownDropOff4XP = 800
takedownDamageGetawayXP = 200
takedownDamageGetawayCD = 15
classicRaceCheckpointXP = 30
sprintRaceCheckpointXP = 33
shiftRaceCheckpointXP = 14
checkpointRushCheckpointXP = 14
teamRushCheckpointXP = 14
ctfCaptureXP = 1065
ctfDestroyEnemyCarrierXP = 125
ctfDestroyEnemyCarrierCD = 40
ctfAssistCarrierXPM = 800
blitzAttackerScoreXP = 235
blitzAttackerAttemptXPM = 60
blitzDefenderScoreXP = 200
relayRaceTeamCheckpointXP = 30
relayRaceTeamTorchPassXP = 115
relayRaceTeamTorchPassCD = 40
relayRaceDamageEnemyCarrierXP = 35
relayRaceDamageEnemyCarrierCD = 20
onlineMatchBonusData = {
  ["MP tag"] = {
    threshold = 500,
    baseXPValue = function(success)
      return averageXP
    end
  },
  ["MP takedown"] = {
    threshold = 500,
    baseXPValue = function(success)
      return averageXP
    end
  },
  ["MP burning rubber"] = {
    threshold = 425,
    baseXPValue = function(success)
      if success then
        return winningTeamAvgXP
      else
        return losingTeamAvgXP
      end
    end
  },
  ["MP circuit race"] = {
    threshold = 375,
    baseXPValue = function(success)
      return averageXP
    end
  },
  ["MP checkpoint rush"] = {
    threshold = 375,
    baseXPValue = function(success)
      return averageXP
    end
  },
  ["MP pure race"] = {
    threshold = 300,
    baseXPValue = function(success)
      return averageXP
    end
  },
  ["MP sprint race"] = {
    threshold = 575,
    baseXPValue = function(success)
      return averageXP
    end
  },
  ["MP tug of war"] = {
    threshold = 1000,
    baseXPValue = function(success)
      if success then
        return winningTeamAvgXP
      else
        return losingTeamAvgXP
      end
    end
  },
  ["MP rush down"] = {
    threshold = 750,
    baseXPValue = function(success)
      if success then
        return winningTeamAvgXP
      else
        return losingTeamAvgXP
      end
    end
  },
  ["MP trail blazer"] = {
    threshold = 500,
    baseXPValue = function(success)
      return averageXP
    end
  },
  ["MP team circuit race"] = {
    threshold = 625,
    baseXPValue = function(success)
      if success then
        return winningTeamAvgXP
      else
        return losingTeamAvgXP
      end
    end
  },
  ["faceoff"] = {
    threshold = 100,
    baseXPValue = function(success)
      return averageXP
    end
  },
  ["MP Vehicle Swap Tutorial"] = {
    threshold = 0,
    baseXPValue = function(success)
      return 5000
    end
  },
  ["MP Vehicle Spawn Tutorial"] = {
    threshold = 0,
    baseXPValue = function(success)
      return 8000
    end
  },
  ["MP shift impulse tutorial"] = {
    threshold = 0,
    baseXPValue = function(success)
      return 6000
    end
  },
  ["MP shift take tutorial"] = {
    threshold = 0,
    baseXPValue = function(success)
      return 1000
    end
  },
  ["MP general mechanics tutorial"] = {
    threshold = 0,
    baseXPValue = function(success)
      return 1000
    end
  }
}
onlineRaceRankMultiplier = {
  [1] = 1.5,
  [2] = 1.25,
  [3] = 1.1,
  [4] = 1,
  [5] = 0.9,
  [6] = 0.8,
  [7] = 0.75,
  [8] = 0.7
}
