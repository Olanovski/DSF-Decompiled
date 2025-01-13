module("onlineScreenManager", package.seeall)
screenSortTypes = {
  score = 1,
  scoreNoID = 2,
  race = 3,
  round = 4,
  reverseRnd = 5,
  playerID = 6
}
lastTeamSwap = {
  [0] = {swapID = 0, listPosition = 1},
  [1] = {swapID = 0, listPosition = 1},
  [2] = {swapID = 0, listPosition = 1},
  [3] = {swapID = 0, listPosition = 1},
  [4] = {swapID = 0, listPosition = 1},
  [5] = {swapID = 0, listPosition = 1},
  [6] = {swapID = 0, listPosition = 1},
  [7] = {swapID = 0, listPosition = 1}
}
currentTeamSwap = {
  [0] = {
    swapID = 0,
    listPosition = 1,
    swapTime = 0
  },
  [1] = {
    swapID = 0,
    listPosition = 1,
    swapTime = 0
  },
  [2] = {
    swapID = 0,
    listPosition = 1,
    swapTime = 0
  },
  [3] = {
    swapID = 0,
    listPosition = 1,
    swapTime = 0
  },
  [4] = {
    swapID = 0,
    listPosition = 1,
    swapTime = 0
  },
  [5] = {
    swapID = 0,
    listPosition = 1,
    swapTime = 0
  },
  [6] = {
    swapID = 0,
    listPosition = 1,
    swapTime = 0
  },
  [7] = {
    swapID = 0,
    listPosition = 1,
    swapTime = 0
  }
}
local playerTable = {
  [0] = false,
  [1] = false,
  [2] = false,
  [3] = false,
  [4] = false,
  [5] = false,
  [6] = false,
  [7] = false
}
local teamTable = {
  [1] = {
    currentScore = 0,
    targetScore = 0,
    roundScore = -1
  },
  [2] = {
    currentScore = 0,
    targetScore = 0,
    roundScore = -1
  }
}
local ssModeCompData = {
  scoreLimit = false,
  bronzeMedal = false,
  silverMedal = false,
  goldMedal = false,
  race = false,
  round = false,
  use2ndScore = false,
  finalRound = false,
  roundNum = false
}
local ssCoopModeCompData = {
  level = false,
  maxLevel = false,
  score = false
}
local rewardTable = {}
local updateRequired = false
local raceCompleteData = false
local coopCompleteData = false
local missionResultsText, missionResultsReasonText
local forceSortType = false
function setCoopCompleteData(newCoopCompleteData, newMissionResultsText, newMissionResultsReasonText)
  coopCompleteData = newCoopCompleteData
  missionResultsText = newMissionResultsText
  missionResultsReasonText = newMissionResultsReasonText
  assert(coopCompleteData ~= nil, "Invalid data to coopCompleteData, needs to be TRUE or FALSE. Value input = " .. tostring(coopCompleteData))
end
function getCoopCompleteData()
  return coopCompleteData, missionResultsText or "", missionResultsReasonText or ""
end
function setSSModeCompDataTable(score, bronze, silver, gold, race, round, useSecond, finalRound, roundNum)
  ssModeCompData.scoreLimit = score
  ssModeCompData.bronzeMedal = bronze
  ssModeCompData.silverMedal = silver
  ssModeCompData.goldMedal = gold
  ssModeCompData.race = race or false
  ssModeCompData.round = round or false
  ssModeCompData.use2ndScore = useSecond or false
  ssModeCompData.finalRound = finalRound or false
  ssModeCompData.roundNum = roundNum or false
end
function getSSModeCompDataTable()
  return ssModeCompData
end
function clearSSModeCompDataTable()
  ssModeCompData = {
    scoreLimit = false,
    bronzeMedal = false,
    silverMedal = false,
    goldMedal = false
  }
end
function setSSCoopModeCompDataTable(level, maxLevel, score)
  ssCoopModeCompData.level = level
  ssCoopModeCompData.maxLevel = maxLevel
  ssCoopModeCompData.score = score
end
function getSSCoopModeCompDataTable()
  return ssCoopModeCompData
end
function clearSSCoopModeCompDataTable()
  ssCoopModeCompData = {
    level = false,
    maxLevel = false,
    score = false
  }
end
function isRaceCompleteData()
  return raceCompleteData
end
function setRaceCompleteData(isRaceData)
  raceCompleteData = isRaceData
end
function setForceSortType(force)
  forceSortType = force
end
function getForceSortType()
  return forceSortType
end
function getRewardTable()
  return rewardTable
end
function getNumRewards()
  return #rewardTable
end
function addRewardUnlock(type, info1, info2, info3)
  table.insert(rewardTable, {
    type = type,
    info1 = info1,
    info2 = info2,
    info3 = info3
  })
end
function clearRewardTable()
  rewardTable = {}
end
function triggerScreenUpdate()
  updateRequired = true
end
_G.triggerScreenUpdate = triggerScreenUpdate
function getTeamData()
  return teamTable
end
function setBlueTeamTargetScore(target)
  teamTable[1].targetScore = target
end
function setBlueTeamRoundScore(round)
  teamTable[1].roundScore = round
end
function setBlueTeamCurrentScore(current)
  teamTable[1].currentScore = current
end
function setRedTeamTargetScore(target)
  teamTable[2].targetScore = target
end
function setRedTeamRoundScore(round)
  teamTable[2].roundScore = round
end
function setRedTeamCurrentScore(current)
  teamTable[2].currentScore = current
end
function clearTeamData()
  teamTable[1].targetScore = 0
  teamTable[1].currentScore = 0
  teamTable[2].targetScore = 0
  teamTable[2].currentScore = 0
  teamTable[1].roundScore = -1
  teamTable[2].roundScore = -1
end
function getPlayerScreenDataTable()
  return playerTable
end
function getUpdateRequired()
  return updateRequired
end
function screenUpdated()
  updateRequired = false
end
function addPlayer(id)
  if playerManager.players[id] then
    if playerTable[id] and playerTable[id].name == playerManager.players[id].name then
      return
    end
    if not playerTable[id] then
      playerTable[id] = {}
    end
    playerTable[id].id = id
    playerTable[id].name = playerManager.players[id].name
    playerTable[id].team = PlayerGamePlay.getPlayerTeam(id)
    playerTable[id].previousXP = 0
    playerTable[id].xp = 0
    playerTable[id].score = 0
    playerTable[id].secondaryScore = 8
    playerTable[id].roundScore = 0
    playerTable[id].weaponFuel = 0
    updateRequired = true
    onlineSideBar.updateSideBarScreenDataTable()
    resetGamerCardHighlight()
  end
end
function removePlayer(id)
  playerTable[id] = false
  updateRequired = true
  onlineSideBar.updateSideBarScreenDataTable()
  resetGamerCardHighlight()
  lastTeamSwap[id].swapID = 0
  lastTeamSwap[id].listPosition = 1
  currentTeamSwap[id].swapID = 0
  currentTeamSwap[id].listPosition = 1
end
function clearPlayerTables()
  for i = 0, 7 do
    playerTable[i] = false
  end
  updateRequired = false
end
function updatePlayerXP(id, xp)
  if playerTable[id] then
    playerTable[id].previousXP = playerTable[id].xp or 0
    playerTable[id].xp = xp
    updateRequired = true
  elseif playerManager.players[id] then
    addPlayer(id)
    playerTable[id].xp = xp
    updateRequired = true
  end
end
function setPlayerXP(id, xp)
  if playerTable[id] then
    playerTable[id].previousXP = xp
    playerTable[id].xp = xp
    updateRequired = true
  elseif playerManager.players[id] then
    addPlayer(id)
    playerTable[id].previousXP = xp
    playerTable[id].xp = xp
    updateRequired = true
  end
end
function updatePlayerTeam(id, team)
  if playerTable[id] then
    playerTable[id].team = team
    updateRequired = true
  elseif playerManager.players[id] then
    addPlayer(id)
    playerTable[id].team = team
    updateRequired = true
  end
end
function updatePlayerScore(id, score)
  if playerTable[id] then
    playerTable[id].score = score
    updateRequired = true
  elseif playerManager.players[id] then
    addPlayer(id)
    playerTable[id].score = score
    updateRequired = true
  end
end
function updatePlayerSecondaryScore(id, score)
  if playerTable[id] then
    playerTable[id].secondaryScore = score
    updateRequired = true
  elseif playerManager.players[id] then
    addPlayer(id)
    playerTable[id].secondaryScore = score
    updateRequired = true
  end
end
function updatePlayerWeaponFuel(id, fuel)
  if playerTable[id] then
    playerTable[id].weaponFuel = fuel
    updateRequired = true
  elseif playerManager.players[id] then
    addPlayer(id)
    playerTable[id].weaponFuel = fuel
    updateRequired = true
  end
end
function updatePlayerRoundScore(id, score)
  if playerTable[id] then
    playerTable[id].roundScore = score
    updateRequired = true
  elseif playerManager.players[id] then
    addPlayer(id)
    playerTable[id].roundScore = score
    updateRequired = true
  end
end
local sortPlayersByScore = function(playerA, playerB)
  assert(playerA ~= nil, "sortPlayersByScore - playerA is nil")
  assert(playerB ~= nil, "sortPlayersByScore - playerB is nil")
  if not playerA then
    return false
  end
  if not playerB then
    return true
  end
  assert(playerA.score, "sortPlayersByScore - playerA.score")
  assert(playerB.score, "sortPlayersByScore - playerB.score")
  if playerA.id == playerB.id then
    return false
  end
  if playerA.score == playerB.score then
    if playerA.id == localPlayer.playerID or playerB.id == localPlayer.playerID then
      return playerA.id == localPlayer.playerID
    end
    return playerA.id > playerB.id
  end
  return playerA.score > playerB.score
end
local sortPlayersByScoreNoIDSort = function(playerA, playerB)
  assert(playerA ~= nil, "sortPlayersByScoreNoIDSort - playerA is nil")
  assert(playerB ~= nil, "sortPlayersByScoreNoIDSort - playerB is nil")
  if not playerA then
    return false
  end
  if not playerB then
    return true
  end
  assert(playerA.score, "sortPlayersByScoreNoIDSort - playerA.score")
  assert(playerB.score, "sortPlayersByScoreNoIDSort - playerB.score")
  if playerA.id == playerB.id then
    return false
  end
  return playerA.score > playerB.score
end
local raceSort = function(playerA, playerB)
  assert(playerA ~= nil, "raceSort - playerA is nil")
  assert(playerB ~= nil, "raceSort - playerB is nil")
  if not playerA then
    return false
  end
  if not playerB then
    return true
  end
  assert(playerA.secondaryScore, "raceSort - playerA.secondaryScore")
  assert(playerB.secondaryScore, "raceSort - playerB.secondaryScore")
  if playerA.id == playerB.id then
    return false
  end
  if playerA.secondaryScore == playerB.secondaryScore then
    if playerA.id == localPlayer.playerID or playerB.id == localPlayer.playerID then
      return playerA.id == localPlayer.playerID
    end
    return playerA.id > playerB.id
  end
  return playerA.secondaryScore < playerB.secondaryScore
end
local roundSort = function(playerA, playerB)
  assert(playerA ~= nil, "roundSort - playerA is nil")
  assert(playerB ~= nil, "roundSort - playerB is nil")
  if not playerA then
    return false
  end
  if not playerB then
    return true
  end
  assert(playerA.roundScore, "roundSort - playerA.roundScore")
  assert(playerB.roundScore, "roundSort - playerB.roundScore")
  if playerA.id == playerB.id then
    return false
  end
  if playerA.roundScore == playerB.roundScore then
    return onlineRaceManager.getPlayerRank(playerA.id) < onlineRaceManager.getPlayerRank(playerB.id)
  end
  return playerA.roundScore > playerB.roundScore
end
local reverseRoundSort = function(playerA, playerB)
  assert(playerA ~= nil, "reverseRoundSort - playerA is nil")
  assert(playerB ~= nil, "reverseRoundSort - playerB is nil")
  if not playerA then
    return false
  end
  if not playerB then
    return true
  end
  assert(playerA.roundScore, "reverseRoundSort - playerA.roundScore")
  assert(playerB.roundScore, "reverseRoundSort - playerB.roundScore")
  if playerA.id == playerB.id then
    return false
  end
  if playerA.roundScore == playerB.roundScore then
    return onlineRaceManager.getPlayerRank(playerA.id) > onlineRaceManager.getPlayerRank(playerB.id)
  end
  return playerA.roundScore < playerB.roundScore
end
local sortPlayersByPlayerID = function(playerA, playerB)
  assert(playerA ~= nil, "sortPlayersByScoreNoIDSort - playerA is nil")
  assert(playerB ~= nil, "sortPlayersByScoreNoIDSort - playerB is nil")
  if not playerA then
    return false
  end
  if not playerB then
    return true
  end
  assert(playerA.id, "sortPlayersByScoreNoIDSort - playerA.id")
  assert(playerB.id, "sortPlayersByScoreNoIDSort - playerB.id")
  if playerA.id == playerB.id then
    return false
  end
  return playerA.id < playerB.id
end
local sortedPlayers = {
  [1] = false,
  [2] = false,
  [3] = false,
  [4] = false,
  [5] = false,
  [6] = false,
  [7] = false,
  [8] = false
}
function getScreenCurrentPlayerTable(sortType)
  for i = 0, 7 do
    sortedPlayers[i + 1] = playerTable[i]
  end
  if not sortType then
    callStack()
    assert(false, "onlineScreenManager.getScreenCurrentPlayerTable - sortType is false")
  end
  if sortType == screenSortTypes.score then
    table.sort(sortedPlayers, sortPlayersByScore)
  elseif sortType == screenSortTypes.scoreNoID then
    table.sort(sortedPlayers, sortPlayersByScoreNoIDSort)
  elseif sortType == screenSortTypes.race then
    table.sort(sortedPlayers, raceSort)
  elseif sortType == screenSortTypes.round then
    table.sort(sortedPlayers, roundSort)
  elseif sortType == screenSortTypes.reverseRnd then
    table.sort(sortedPlayers, reverseRoundSort)
  elseif sortType == screenSortTypes.playerID then
    table.sort(sortedPlayers, sortPlayersByPlayerID)
  end
  return sortedPlayers
end
