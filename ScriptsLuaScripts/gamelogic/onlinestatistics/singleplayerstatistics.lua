module("singlePlayerStatistics", package.seeall)
local missionStatistics = {
  missionID = nil,
  Score = {
    statID = -1,
    startValue = 0,
    value = 0
  }
}
function resetMissionStatistics()
  missionStatistics = {
    missionID = nil,
    Score = {
      statID = -1,
      startValue = 0,
      value = 0
    }
  }
end
function updateScoreStatistic(value, type)
  if missionStatistics.Score.statID ~= -1 then
    if type == "Time" then
      missionStatistics.Score.value = value * 100
    else
      missionStatistics.Score.value = value
    end
  end
end
function updateSplitStatistics(splitTimes)
  for i = 1, #splitTimes - 1 do
    missionStatistics["Split" .. i].value = splitTimes[i]
  end
end
function getScoreStatistic()
  return missionStatistics.Score.startValue
end
function getMissionStatisticsScoreTable()
  return missionStatistics.Score
end
function getMissionStatistics()
  return missionStatistics
end
function returnMissionSplitTimes(missionID)
  local statCollection = generateStatCollectionFromMissionID(missionID)
  local bestSplitTimes = {}
  for i = 1, #statCollection - 1 do
    for index, statTable in next, missionStatistics, nil do
      if index ~= "missionID" and statTable.statID == statCollection[i].statID then
        if statTable.value == 0 then
          return false
        else
          bestSplitTimes[i] = {}
          bestSplitTimes[i].value = statTable.startValue
        end
      end
    end
  end
  return bestSplitTimes
end
function setStatistic(statID, value)
  for index, statTable in next, missionStatistics, nil do
    if statTable.statID == statID then
      statTable.startValue = value
      statTable.value = value
    end
  end
end
function setupMissionStatistics(missionID)
  resetMissionStatistics()
  missionStatistics.missionID = missionID
  local scoreStatID = getStatIDByStatName(missionID)
  missionStatistics.Score.statID = scoreStatID
  missionStatistics.Score.startValue = ProfileSettings.GetChallengeTotalTime(scoreStatID)
  missionStatistics.Score.value = ProfileSettings.GetChallengeTotalTime(scoreStatID)
  if missionStatistics.Score.startValue == 0 then
    local challenge, __, challengeType = progressionSystem.findChallengeInProgression(missionID)
    missionStatistics.Score.startValue = challenge.defaultBest
  end
  local statCollection = generateStatCollectionFromMissionID(missionID)
  for i = 1, #statCollection - 1 do
    local splitStatID = statCollection[i].statID
    missionStatistics["Split" .. i] = {}
    missionStatistics["Split" .. i].statID = splitStatID
    missionStatistics["Split" .. i].startValue = ProfileSettings.GetChallengeSplitTime(splitStatID)
    missionStatistics["Split" .. i].value = ProfileSettings.GetChallengeSplitTime(splitStatID)
  end
end
function updateServerStatistics()
  if missionStatistics.missionID and missionStatistics.Score.startValue ~= missionStatistics.Score.value then
    for index, statTable in next, missionStatistics, nil do
      if index ~= "missionID" then
        statTable.startValue = statTable.value
        if not string.find(index, "Split") then
          ProfileSettings.SetChallengeTotalTime(statTable.statID, statTable.value)
        else
          ProfileSettings.SetChallengeSplitTime(statTable.statID, statTable.value)
        end
      end
    end
  end
end
function clearServerStatistics()
  for index, statTable in next, missionStatistics, nil do
    Statistics.updateStat(statTable.statID, getStatType(statTable.statID), 0)
    statTable.value = 0
    statTable.startValue = 0
  end
  Statistics.dispatchWrite()
end
function resetMyStats()
  Statistics.updateStat(83, getStatType(83), 0)
  Statistics.updateStat(84, getStatType(84), 0)
  Statistics.updateStat(85, getStatType(85), 0)
  Statistics.updateStat(86, getStatType(86), 0)
  Statistics.updateStat(87, getStatType(87), 0)
  Statistics.updateStat(88, getStatType(88), 0)
  Statistics.updateStat(89, getStatType(89), 0)
  Statistics.updateStat(90, getStatType(90), 0)
  Statistics.updateStat(91, getStatType(91), 0)
  Statistics.updateStat(92, getStatType(92), 0)
  Statistics.updateStat(93, getStatType(93), 0)
  Statistics.updateStat(94, getStatType(94), 0)
  Statistics.updateStat(95, getStatType(95), 0)
  Statistics.updateStat(96, getStatType(96), 0)
  Statistics.updateStat(97, getStatType(97), 0)
  Statistics.updateStat(98, getStatType(98), 0)
  Statistics.updateStat(99, getStatType(99), 0)
  Statistics.updateStat(100, getStatType(100), 0)
  Statistics.updateStat(101, getStatType(101), 0)
  Statistics.updateStat(102, getStatType(102), 0)
  Statistics.updateStat(103, getStatType(103), 0)
  Statistics.updateStat(104, getStatType(104), 0)
  Statistics.updateStat(105, getStatType(105), 0)
  Statistics.updateStat(106, getStatType(106), 0)
  Statistics.updateStat(107, getStatType(107), 0)
  Statistics.updateStat(108, getStatType(108), 0)
  Statistics.updateStat(109, getStatType(109), 0)
  Statistics.updateStat(110, getStatType(110), 0)
  Statistics.updateStat(111, getStatType(111), 0)
  Statistics.dispatchWrite()
  for i = 83, 111 do
    Statistics.readStat(i)
  end
  Statistics.dispatchRead()
end
