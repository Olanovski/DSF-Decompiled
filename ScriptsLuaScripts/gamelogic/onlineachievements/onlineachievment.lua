module("OnlineAchievements", package.seeall)
OnlineAchievementRankChange = {
  [1] = {lookUp = "INITIATE", variable = 5},
  [2] = {lookUp = "VETERAN", variable = 20},
  [3] = {lookUp = "MASTER", variable = 38}
}
OnlineAchievementValueUpdate = {
  ["Zap Attacks"] = {lookUp = "AIRRAGE", variable = 10},
  ["CarSwap"] = {
    lookUp = "CONNOISSEUR",
    variable = 20
  },
  ["MP tug of war"] = {
    lookUp = "CARRYTHETEAM",
    variable = 10
  },
  ["BurningRubber"] = {
    lookUp = "PASSTHETORCH",
    variable = 25,
    variable2 = 20
  },
  ["Rushdown"] = {
    lookUp = "RELENTLESSASSAULT",
    variable = 10
  },
  ["Tag"] = {
    lookUp = "TAGYOURIT",
    variable = 50,
    variable2 = 10
  },
  ["Takedown"] = {
    lookUp = "GETTINGAWAYWITHIT",
    variable = 25
  },
  ["Trailblazer in blaze"] = {lookUp = "YOURONFIRE", variable = 30},
  ["Sprint Race Top 3"] = {
    lookUp = "PICKINGUPTHEPACE",
    variable = 10
  },
  ["Pure Race Top 3"] = {
    lookUp = "PROFESSIONALRACER",
    variable = 10
  },
  ["Circuit Race Top 3"] = {
    lookUp = "ROUNDANDROUNDYOUGO",
    variable = 10
  },
  ["Rush 1000 gates"] = {
    lookUp = "STAYWITHTHEPACK",
    variable = 1000
  }
}
function onRankChange(level)
  for i, achievementData in ipairs(OnlineAchievementRankChange) do
    if level >= achievementData.variable then
      Achievements.UnlockAchievement(AchievementTable.AchievementID[achievementData.lookUp].achievementID)
    end
  end
end
function onValueChange(gameKey, variable)
  if gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode and variable == OnlineAchievementValueUpdate[gameKey].variable then
    Achievements.UnlockAchievement(AchievementTable.AchievementID[OnlineAchievementValueUpdate[gameKey].lookUp].achievementID)
    print("UNLOCKING ACHIEMENT " .. AchievementTable.AchievementID[OnlineAchievementValueUpdate[gameKey].lookUp].achievementID)
  end
end
