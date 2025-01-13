module("onlineStatistics", package.seeall)
local statsReceivedCallback = false
local overallStatistics = {
  Score = {
    statID = -1,
    value = 0,
    received = false
  },
  Win = {
    statID = -1,
    value = 0,
    received = false
  },
  Loss = {
    statID = -1,
    value = 0,
    received = false
  },
  winLossRatio = {
    statID = -1,
    startValue = 0,
    value = 0,
    received = false
  }
}
local missionStatistics = {
  missionID = false,
  Win = {
    statID = -1,
    startValue = 0,
    value = 0,
    received = false
  },
  Loss = {
    statID = -1,
    startValue = 0,
    value = 0,
    received = false
  },
  Score = {
    statID = -1,
    startValue = 0,
    value = 0,
    received = false
  },
  Specific = {
    statID = -1,
    startValue = 0,
    value = 0,
    received = false
  }
}
function updateWinStatistic(value)
  print(">>>>>>>> Win Statistic: Add " .. tostring(value))
  NetworkLog.Write(">[LUA] - Statistics - Update Win Statistics: Stat ID = " .. tostring(missionStatistics.Win.statID) .. "  Value = " .. tostring(value))
  if missionStatistics.Win.statID ~= -1 then
    assert(missionStatistics.Win.value ~= nil, "updateWinStatistic - missionStatistics.Win.value is nil")
    assert(value ~= nil, "updateWinStatistic - value is nil")
    missionStatistics.Win.value = missionStatistics.Win.value + value
  end
end
function updateLossStatistic(value)
  print(">>>>>>>> Loss Statistic: Add " .. tostring(value))
  NetworkLog.Write(">[LUA] - Statistics - Update Loss Statistics: Stat ID = " .. tostring(missionStatistics.Loss.statID) .. "  Value = " .. tostring(value))
  if missionStatistics.Loss.statID ~= -1 then
    assert(missionStatistics.Loss.value ~= nil, "updateLossStatistic - missionStatistics.Loss.value is nil")
    assert(value ~= nil, "updateLossStatistic - value is nil")
    missionStatistics.Loss.value = missionStatistics.Loss.value + value
  end
end
function updateScoreStatistic(value)
  if missionStatistics.Score.statID ~= -1 then
    assert(missionStatistics.Score.value ~= nil, "updateScoreStatistic - missionStatistics.Score.value is nil")
    assert(value ~= nil, "updateScoreStatistic - value is nil")
    missionStatistics.Score.value = missionStatistics.Score.value + value
    PlayerCoreStats.updateOfflineSplitScreenScore(tostring(missionStatistics.Score.value))
  end
end
function updateSpecificStatistic(value)
  if missionStatistics.Specific.statID ~= -1 then
    assert(missionStatistics.Specific.value ~= nil, "updateSpecificStatistic - missionStatistics.Specific.value is nil")
    assert(value ~= nil, "updateSpecificStatistic - value is nil")
    missionStatistics.Specific.value = missionStatistics.Specific.value + value
  end
end
function updateOverallScoreStatistic(value)
  print(">>>>>>>> updateOverallScoreStatistic " .. tostring(value))
  if value > 0 then
    print(">>>>>>>> Overall Score Statistic: Add " .. tostring(value))
    NetworkLog.Write(">[LUA] - Statistics - Update Overall Score Statistics: Stat ID = " .. tostring(overallStatistics.Score.statID) .. "  Value = " .. tostring(value))
    overallStatistics.Score.value = overallStatistics.Score.value + value
    Statistics.updateStat(overallStatistics.Score.statID, getStatType(overallStatistics.Score.statID), overallStatistics.Score.value)
  end
end
function getWinStatistic()
  return missionStatistics.Win.value
end
function getLossStatistic()
  return missionStatistics.Loss.value
end
function getSpecificStatistic()
  return missionStatistics.Specific.value
end
function setStatistic(statID, value)
  assert(value ~= nil, "setStatistic - value is nil")
  if missionStatistics.Win.statID == statID then
    missionStatistics.Win.startValue = value
    missionStatistics.Win.value = value
    missionStatistics.Win.received = true
    print(">>>>>>>>>>>>>>>>>>>> Win Statistic: " .. tostring(value))
    NetworkLog.Write(">[LUA] - Statistics - Set Win Statistics: Stat ID = " .. tostring(statID) .. "  Value = " .. tostring(value))
  elseif missionStatistics.Loss.statID == statID then
    missionStatistics.Loss.startValue = value
    missionStatistics.Loss.value = value
    missionStatistics.Loss.received = true
    print(">>>>>>>>>>>>>>>>>>>> Loss Statistic: " .. tostring(value))
    NetworkLog.Write(">[LUA] - Statistics - Set Loss Statistics: Stat ID = " .. tostring(statID) .. "  Value = " .. tostring(value))
  elseif missionStatistics.Score.statID == statID then
    missionStatistics.Score.startValue = value
    missionStatistics.Score.value = value
    missionStatistics.Score.received = true
    print(">>>>>>>>>>>>>>>>>>>> XP Statistic: " .. tostring(value))
    NetworkLog.Write(">[LUA] - Statistics - Set XP Statistics: Stat ID = " .. tostring(statID) .. "  Value = " .. tostring(value))
  elseif missionStatistics.Specific.statID == statID then
    missionStatistics.Specific.startValue = value
    missionStatistics.Specific.value = value
    missionStatistics.Specific.received = true
    print(">>>>>>>>>>>>>>>>>>>> Score Specific Statistic: " .. tostring(value))
    NetworkLog.Write(">[LUA] - Statistics - Set Score Specific Statistics: Stat ID = " .. tostring(statID) .. "  Value = " .. tostring(value))
  elseif overallStatistics.Score.statID == statID then
    overallStatistics.Score.value = value
    overallStatistics.Score.received = true
    print(">>>>>>>>>>>>>>>>>>>> Overall XP Statistic: " .. tostring(value))
    NetworkLog.Write(">[LUA] - Statistics - Set Overall XP Statistics: Stat ID = " .. tostring(statID) .. "  Value = " .. tostring(value))
  elseif overallStatistics.Win.statID == statID then
    overallStatistics.Win.value = value
    overallStatistics.Win.received = true
    print(">>>>>>>>>>>>>>>>>>>> Overall Win Statistic: " .. tostring(value))
    NetworkLog.Write(">[LUA] - Statistics - Set Overall Win Statistics: Stat ID = " .. tostring(statID) .. "  Value = " .. tostring(value))
  elseif overallStatistics.Loss.statID == statID then
    overallStatistics.Loss.value = value
    overallStatistics.Loss.received = true
    print(">>>>>>>>>>>>>>>>>>>> Overall Loss Statistic: " .. tostring(value))
    NetworkLog.Write(">[LUA] - Statistics - Set Overall Loss Statistics: Stat ID = " .. tostring(statID) .. "  Value = " .. tostring(value))
  elseif overallStatistics.winLossRatio.statID == statID then
    overallStatistics.winLossRatio.value = value
    overallStatistics.winLossRatio.startValue = value
    overallStatistics.winLossRatio.received = true
    print(">>>>>>>>>>>>>>>>>>>> Overall Win Loss Ratio Statistic: " .. tostring(value))
    NetworkLog.Write(">[LUA] - Statistics - Set Overall Win Loss Ratio Statistics: Stat ID = " .. tostring(statID) .. "  Value = " .. tostring(value))
  else
    assert(false, "setStatistic - statID not found")
  end
  if missionStatistics.Win.received and missionStatistics.Loss.received and missionStatistics.Score.received and missionStatistics.Specific.received and overallStatistics.Score.received and overallStatistics.Win.received and overallStatistics.Loss.received and overallStatistics.winLossRatio.received then
    assert(statsReceivedCallback, "No stats received callback set")
    statsReceivedCallback()
  end
end
local function clearStats()
  print(">>>>>>>>>>>>>>>>>>>> Clear Statistic")
  NetworkLog.Write(">[LUA] - Statistics - Clear")
  missionStatistics.missionID = false
  statsReceivedCallback = false
  missionStatistics.Win.statID = -1
  missionStatistics.Win.startValue = 0
  missionStatistics.Win.value = 0
  missionStatistics.Win.received = false
  missionStatistics.Loss.statID = -1
  missionStatistics.Loss.startValue = value
  missionStatistics.Loss.value = value
  missionStatistics.Loss.received = false
  missionStatistics.Score.statID = -1
  missionStatistics.Score.startValue = value
  missionStatistics.Score.value = value
  missionStatistics.Score.received = false
  missionStatistics.Specific.statID = -1
  missionStatistics.Specific.startValue = 0
  missionStatistics.Specific.value = 0
  missionStatistics.Specific.received = false
  overallStatistics.Score.statID = -1
  overallStatistics.Score.value = 0
  overallStatistics.Score.received = false
  overallStatistics.Win.statID = -1
  overallStatistics.Win.value = 0
  overallStatistics.Win.received = false
  overallStatistics.Loss.statID = -1
  overallStatistics.Loss.value = 0
  overallStatistics.Loss.received = false
  overallStatistics.winLossRatio.statID = -1
  overallStatistics.winLossRatio.value = 0
  overallStatistics.winLossRatio.startValue = 0
  overallStatistics.winLossRatio.received = false
end
function setupMissionStatistics(missionID, receivedCallback, isTutorial)
  assert(onlineStatisticsData[missionID], "setupMissionStatistics - mode not found")
  if not gameStatus.splitscreenSession and not gameStatus.onlineIsLan then
    print(">>>>>>>>>>>>>>>>>>>> Clear Statistic: Setup " .. tostring(missionID))
    NetworkLog.Write(">[LUA] - Statistics - Setup " .. tostring(missionID))
    assert(gameStatus.onlineSessionType == gameStatus.onlineSessionID.public or isTutorial, "ONLINE STATS - MODE IS NOT A PUBLIC MATCH")
    clearStats()
    missionStatistics.missionID = missionID
    statsReceivedCallback = receivedCallback
    local winStatID = false
    local lossStatID = false
    local scoreStatID = false
    local specificStatID = false
    if onlineStatisticsData[missionID].Win then
      winStatID = getStatIDByStatName(onlineStatisticsData[missionID].Win)
      lossStatID = getStatIDByStatName(onlineStatisticsData[missionID].Loss)
      scoreStatID = getStatIDByStatName(onlineStatisticsData[missionID].Score)
      specificStatID = getStatIDByStatName(onlineStatisticsData[missionID].Specific)
      missionStatistics.Win.statID = winStatID
      missionStatistics.Loss.statID = lossStatID
      missionStatistics.Score.statID = scoreStatID
      missionStatistics.Specific.statID = specificStatID
      Statistics.readStat(winStatID)
      Statistics.readStat(lossStatID)
      Statistics.readStat(scoreStatID)
      Statistics.readStat(specificStatID)
    else
      missionStatistics.Win.received = true
      missionStatistics.Loss.received = true
      missionStatistics.Score.received = true
      missionStatistics.Specific.received = true
    end
    local overallWin = getStatIDByStatName("Overall Wins")
    local overallLoss = getStatIDByStatName("Overall Losses")
    local overallWinLossRatio = getStatIDByStatName("Overall Win/Loss Ratio")
    local overallScore = getStatIDByStatName("Overall Score")
    overallStatistics.Score.statID = overallScore
    overallStatistics.Win.statID = overallWin
    overallStatistics.Loss.statID = overallLoss
    overallStatistics.winLossRatio.statID = overallWinLossRatio
    Statistics.readStat(overallScore)
    Statistics.readStat(overallWin)
    Statistics.readStat(overallLoss)
    Statistics.readStat(overallWinLossRatio)
    NetworkLog.Write(">[LUA] - Statistics - Setup - Win Statistics: Stat ID = " .. tostring(winStatID))
    NetworkLog.Write(">[LUA] - Statistics - Setup - Loss Statistics: Stat ID = " .. tostring(lossStatID))
    NetworkLog.Write(">[LUA] - Statistics - Setup - Score Statistics: Stat ID = " .. tostring(scoreStatID))
    NetworkLog.Write(">[LUA] - Statistics - Setup - Specific Statistics: Stat ID = " .. tostring(specificStatID))
    NetworkLog.Write(">[LUA] - Statistics - Setup - Overall Win Statistics: Stat ID = " .. tostring(overallWin))
    NetworkLog.Write(">[LUA] - Statistics - Setup - Overall Loss Statistics: Stat ID = " .. tostring(overallLoss))
    NetworkLog.Write(">[LUA] - Statistics - Setup - Overall Score Statistics: Stat ID = " .. tostring(overallScore))
    NetworkLog.Write(">[LUA] - Statistics - Setup - Overall winLossRatio Statistics: Stat ID = " .. tostring(overallWinLossRatio))
    Statistics.dispatchRead()
    NetworkLog.Write(">[LUA] - Statistics - Dispatch Read")
  end
end
function updateServerStatistics()
  if missionStatistics.missionID then
    if missionStatistics.Win.startValue ~= missionStatistics.Win.value then
      Statistics.updateStat(missionStatistics.Win.statID, getStatType(missionStatistics.Win.statID), missionStatistics.Win.value)
      missionStatistics.Win.startValue = missionStatistics.Win.value
      print(">>>>>>>>>>>>>>>>>>>> Update Win Statistic: " .. tostring(missionStatistics.Win.value))
      NetworkLog.Write(">[LUA] - Statistics - Update Win Statistics: Stat ID = " .. tostring(missionStatistics.Win.statID) .. "  Value = " .. tostring(missionStatistics.Win.value))
      overallStatistics.Win.value = overallStatistics.Win.value + 1
      Statistics.updateStat(overallStatistics.Win.statID, getStatType(overallStatistics.Win.statID), overallStatistics.Win.value)
      local winLossRatio = overallStatistics.Win.value
      if overallStatistics.Loss.value > 0 then
        winLossRatio = overallStatistics.Win.value / overallStatistics.Loss.value
      end
      overallStatistics.winLossRatio.value = winLossRatio
      print(">>>>>>>>>>>>>>>>>>>> Update Overall Win Statistic: " .. tostring(overallStatistics.Win.value))
      NetworkLog.Write(">[LUA] - Statistics - Update Overall Win Statistics: Stat ID = " .. tostring(overallStatistics.Win.statID) .. "  Value = " .. tostring(overallStatistics.Win.value))
    end
    if missionStatistics.Loss.startValue ~= missionStatistics.Loss.value then
      Statistics.updateStat(missionStatistics.Loss.statID, getStatType(missionStatistics.Loss.statID), missionStatistics.Loss.value)
      missionStatistics.Loss.startValue = missionStatistics.Loss.value
      print(">>>>>>>>>>>>>>>>>>>> Update Loss Statistic: " .. tostring(missionStatistics.Loss.value))
      NetworkLog.Write(">[LUA] - Statistics - Update Loss Statistics: Stat ID = " .. tostring(missionStatistics.Loss.statID) .. "  Value = " .. tostring(missionStatistics.Loss.value))
      overallStatistics.Loss.value = overallStatistics.Loss.value + 1
      Statistics.updateStat(overallStatistics.Loss.statID, getStatType(overallStatistics.Loss.statID), overallStatistics.Loss.value)
      local winLossRatio = 0
      if overallStatistics.Win.value > 0 then
        winLossRatio = overallStatistics.Win.value / overallStatistics.Loss.value
      end
      overallStatistics.winLossRatio.value = winLossRatio
      print(">>>>>>>>>>>>>>>>>>>> Update Overall Loss Statistic: " .. tostring(overallStatistics.Loss.value))
      NetworkLog.Write(">[LUA] - Statistics - Update Overall Loss Statistics: Stat ID = " .. tostring(overallStatistics.Loss.statID) .. "  Value = " .. tostring(overallStatistics.Loss.value))
    end
    if missionStatistics.Score.startValue ~= missionStatistics.Score.value then
      overallStatistics.Score.value = overallStatistics.Score.value + (missionStatistics.Score.value - missionStatistics.Score.startValue)
      Statistics.updateStat(overallStatistics.Score.statID, getStatType(overallStatistics.Score.statID), overallStatistics.Score.value)
      Statistics.updateStat(missionStatistics.Score.statID, getStatType(missionStatistics.Score.statID), missionStatistics.Score.value)
      missionStatistics.Score.startValue = missionStatistics.Score.value
      print(">>>>>>>>>>>>>>>>>>>> Update XP Statistic: " .. tostring(missionStatistics.Score.value))
      NetworkLog.Write(">[LUA] - Statistics - Update XP Statistics: Stat ID = " .. tostring(missionStatistics.Score.statID) .. "  Value = " .. tostring(missionStatistics.Score.value))
      print(">>>>>>>>>>>>>>>>>>>> Update Overall XP Statistic: " .. tostring(overallStatistics.Score.value))
      NetworkLog.Write(">[LUA] - Statistics - Update Overall XP Statistics: Stat ID = " .. tostring(overallStatistics.Score.statID) .. "  Value = " .. tostring(overallStatistics.Score.value))
    end
    if missionStatistics.Specific.startValue ~= missionStatistics.Specific.value then
      Statistics.updateStat(missionStatistics.Specific.statID, getStatType(missionStatistics.Specific.statID), missionStatistics.Specific.value)
      missionStatistics.Specific.startValue = missionStatistics.Specific.value
      print(">>>>>>>>>>>>>>>>>>>> Update Score Specific Statistic: " .. tostring(missionStatistics.Specific.value))
      NetworkLog.Write(">[LUA] - Statistics - Update Score Specific Statistics: Stat ID = " .. tostring(missionStatistics.Specific.statID) .. "  Value = " .. tostring(missionStatistics.Specific.value))
    end
    if overallStatistics.winLossRatio.startValue ~= overallStatistics.winLossRatio.value then
      Statistics.updateStat(overallStatistics.winLossRatio.statID, getStatType(overallStatistics.winLossRatio.statID), overallStatistics.winLossRatio.value)
      overallStatistics.winLossRatio.startValue = overallStatistics.winLossRatio.value
      print(">>>>>>>>>>>>>>>>>>>> Update Win Loss Ratio Statistic: " .. tostring(overallStatistics.winLossRatio.value))
      NetworkLog.Write(">[LUA] - Statistics - Update Win Loss Ratio Statistics: Stat ID = " .. tostring(overallStatistics.winLossRatio.statID) .. "  Value = " .. tostring(overallStatistics.winLossRatio.value))
    end
    Statistics.dispatchWrite()
    NetworkLog.Write(">[LUA] - Statistics - Dispatch Write")
    clearStats()
  end
end
function clearServerStatistics()
  Statistics.updateStat(missionStatistics.Win.statID, getStatType(missionStatistics.Win.statID), 0)
  Statistics.updateStat(missionStatistics.Loss.statID, getStatType(missionStatistics.Loss.statID), 0)
  Statistics.updateStat(missionStatistics.Score.statID, getStatType(missionStatistics.Score.statID), 0)
  Statistics.updateStat(missionStatistics.Specific.statID, getStatType(missionStatistics.Specific.statID), 0)
  missionStatistics.Win.value = 0
  missionStatistics.Loss.value = 0
  missionStatistics.Score.value = 0
  missionStatistics.Specific.value = 0
  missionStatistics.Win.startValue = 0
  missionStatistics.Loss.startValue = 0
  missionStatistics.Score.startValue = 0
  missionStatistics.Specific.startValue = 0
  Statistics.updateStat(overallStatistics.Win.statID, getStatType(overallStatistics.Win.statID), 0)
  Statistics.updateStat(overallStatistics.Loss.statID, getStatType(overallStatistics.Loss.statID), 0)
  Statistics.updateStat(overallStatistics.Score.statID, getStatType(overallStatistics.Score.statID), 0)
  Statistics.updateStat(overallStatistics.winLossRatio.statID, getStatType(overallStatistics.winLossRatio.statID), 0)
  overallStatistics.Score.value = 0
  overallStatistics.Win.value = 0
  overallStatistics.Loss.value = 0
  overallStatistics.winLossRatio.value = 0
  Statistics.dispatchWrite()
end
function clearPlayerXP()
  onlineProgressionSystem.resetPlayerProgression()
  PlayerCoreStats.updateLocalTotalXP(0)
  Statistics.dispatchWrite()
end
function useServerXP()
  onlineProgressionSystem.resetPlayerProgression()
  onlineProgressionSystem.progressionSetup(true)
end
local resetPlayerXP = function()
  onlineProgressionSystem.resetPlayerProgression()
end
local clearPlayerMissionStats = function()
  onlineProgressionSystem.clearServerStatistics()
end
function updateModeProfileWinStatistic(modeID)
  assert(onlineStatisticsData[modeID], "Mode is not in the statistics data table")
  onlineStatisticsData[modeID].UpdateProfileOnWin()
  ProfileSettings.SetNumMultiplayerGamesWon(ProfileSettings.GetNumMultiplayerGamesWon() + 1)
end
function updatePlayerLastPositionInMode(modeID, rank)
  assert(onlineStatisticsData[modeID], "Mode is not in the statistics data table")
  local statID = getStatIDByStatName(onlineStatisticsData[modeID].Position)
  Statistics.updateStat(statID, getStatType(statID), rank)
  print(">>>>>>>>>>>>>>>>>>>> Last Rank Statistic: " .. tostring(rank))
  NetworkLog.Write(">[LUA] - Statistics - Set Players Last Rank Statistics: Stat ID = " .. tostring(statID) .. "  Rank = " .. tostring(rank))
end
