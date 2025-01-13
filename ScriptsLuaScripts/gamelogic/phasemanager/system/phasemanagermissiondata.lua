module("phaseManager")
gameModePhaseStart = 0
gameModePhaseRunning = 1
gameModePhaseEnd = 2
FaceOffMissionID = 100
missionIDOffsetMP = 0
missionIDOffsetCoop = 256
timeToJoinScore = {lastJoinScore = false, enterSession = 4}
timeToJoinExceptionValues = {}
function setTimeToJoinScore(score, forceSet)
  if devTimeToJoinBlocker and score < 4 then
    return
  end
  print("----------------------------- setTimeToJoinScore = " .. tostring(score))
  if forceSet or not timeToJoinScore.lastJoinScore or timeToJoinScore.lastJoinScore ~= score then
    NetworkLog.Write(">[LUA] PHASE MANAGER - Set Time To Join Score = " .. tostring(score) .. ", last score = " .. tostring(timeToJoinScore.lastJoinScore))
    Network.setTimeToJoinScore(score)
    timeToJoinScore.lastJoinScore = score
  end
end
function resendTimeToJoinScore()
  NetworkLog.Write(">[LUA] PHASE MANAGER - Resend Set Time To Join Score")
  if timeToJoinScore.lastJoinScore then
    setTimeToJoinScore(timeToJoinScore.lastJoinScore, true)
  else
    setTimeToJoinScore(timeToJoinScore.enterSession)
  end
end
local requiredNumPlayers = false
local isTeamGame = false
local playerShortageA = 0
local playerShortageB = 0
local numPlayers = 0
local numTeamOne = 0
local numTeamTwo = 0
local joinTooFewPlayers = false
local unbalancedMode = false
local workingTFP = false
local workingUnb = false
local balancedTTJScore = false
local unbalancedTTJScore = false
local tooFewPlayerTTJScore = false
function setupTimeToScoreUpdate(numRequiredPlayers, teamGame, balanceScore, unbalancedScore, tooFewPlayerScore)
  requiredNumPlayers = numRequiredPlayers
  isTeamGame = teamGame
  playerShortageA = 0
  playerShortageB = 0
  numPlayers = 0
  numTeamOne = 0
  numTeamTwo = 0
  joinTooFewPlayers = false
  unbalancedMode = false
  workingTFP = false
  workingUnb = false
  balancedTTJScore = balanceScore
  unbalancedTTJScore = unbalancedScore
  tooFewPlayerTTJScore = tooFewPlayerScore
end
function updateTimeToScoreValue()
  assert(unbalancedTTJScore and balancedTTJScore and requiredNumPlayers and tooFewPlayerTTJScore, "time to score update not setup correctly")
  if isTeamGame then
    playerShortageA, playerShortageB, numPlayers, numTeamOne, numTeamTwo = teamModePlayerShortageCheck(requiredNumPlayers)
  else
    playerShortageA, numPlayers = soloModePlayerShortageCheck(requiredNumPlayers)
  end
  workingTFP = false
  workingUnb = false
  if isTeamGame then
    if playerShortageA > 0 or playerShortageB > 0 then
      workingTFP = true
    elseif math.abs(numTeamOne - numTeamTwo) >= phaseManager.timeToJoinScore.teamUnbalancedDef then
      workingUnb = true
    end
  elseif playerShortageA > 0 then
    workingTFP = true
  elseif numPlayers < phaseManager.timeToJoinScore.soloUnbalancedDef then
    workingUnb = true
  end
  if workingTFP and not joinTooFewPlayers then
    setTimeToJoinScore(tooFewPlayerTTJScore)
    unbalancedMode = false
    joinTooFewPlayers = true
  elseif workingUnb and not unbalancedMode then
    setTimeToJoinScore(unbalancedTTJScore)
    unbalancedMode = true
    joinTooFewPlayers = false
  elseif (joinTooFewPlayers or unbalancedMode) and not workingUnb and not workingTFP then
    setTimeToJoinScore(balancedTTJScore)
    unbalancedMode = false
    joinTooFewPlayers = false
  end
end
function clearTimeToScoreUpdate()
  requiredNumPlayers = false
  isTeamGame = false
  playerShortageA = 0
  playerShortageB = 0
  numPlayers = 0
  numTeamOne = 0
  numTeamTwo = 0
  joinTooFewPlayers = false
  unbalancedMode = false
  workingTFP = false
  workingUnb = false
  balancedTTJScore = false
  unbalancedTTJScore = false
  tooFewPlayerTTJScore = false
end
missionIntroData = {
  ["MP tag"] = {
    teams = false,
    missionID = 1 + missionIDOffsetMP,
    missionVehicle = 182,
    updateGamePlayCount = function()
      ProfileSettings.SetNumTagPlays(ProfileSettings.GetNumTagPlays() + 1)
    end,
    getPlayCount = ProfileSettings.GetNumTagPlays,
    timeToJoinScore = -1
  },
  ["MP takedown"] = {
    teams = false,
    missionID = 2 + missionIDOffsetMP,
    updateGamePlayCount = function()
      ProfileSettings.SetNumTakedownPlays(ProfileSettings.GetNumTakedownPlays() + 1)
    end,
    getPlayCount = ProfileSettings.GetNumTakedownPlays,
    timeToJoinScore = -1
  },
  ["MP burning rubber"] = {
    teams = true,
    missionID = 3 + missionIDOffsetMP,
    updateGamePlayCount = function()
      ProfileSettings.SetNumBurningRubberPlays(ProfileSettings.GetNumBurningRubberPlays() + 1)
    end,
    getPlayCount = ProfileSettings.GetNumBurningRubberPlays,
    timeToJoinScore = -1
  },
  ["MP circuit race"] = {
    teams = false,
    missionID = 4 + missionIDOffsetMP,
    updateGamePlayCount = function()
      ProfileSettings.SetNumCircuitRacePlays(ProfileSettings.GetNumCircuitRacePlays() + 1)
    end,
    getPlayCount = ProfileSettings.GetNumCircuitRacePlays,
    timeToJoinScore = -1
  },
  ["MP pure race"] = {
    teams = false,
    missionID = 5 + missionIDOffsetMP,
    updateGamePlayCount = function()
      ProfileSettings.SetNumPureRacePlays(ProfileSettings.GetNumPureRacePlays() + 1)
    end,
    getPlayCount = ProfileSettings.GetNumPureRacePlays,
    timeToJoinScore = -1
  },
  ["MP sprint race"] = {
    teams = false,
    missionID = 6 + missionIDOffsetMP,
    updateGamePlayCount = function()
      ProfileSettings.SetNumSprintRacePlays(ProfileSettings.GetNumSprintRacePlays() + 1)
    end,
    getPlayCount = ProfileSettings.GetNumSprintRacePlays,
    timeToJoinScore = -1
  },
  ["MP tug of war"] = {
    teams = true,
    missionID = 7 + missionIDOffsetMP,
    updateGamePlayCount = function()
      ProfileSettings.SetNumTugOfWarPlays(ProfileSettings.GetNumTugOfWarPlays() + 1)
    end,
    getPlayCount = ProfileSettings.GetNumTugOfWarPlays,
    timeToJoinScore = -1
  },
  ["MP rush down"] = {
    teams = true,
    missionID = 8 + missionIDOffsetMP,
    updateGamePlayCount = function()
      ProfileSettings.SetNumRushdownPlays(ProfileSettings.GetNumRushdownPlays() + 1)
    end,
    getPlayCount = ProfileSettings.GetNumRushdownPlays,
    timeToJoinScore = -1
  },
  ["MP trail blazer"] = {
    teams = false,
    missionID = 9 + missionIDOffsetMP,
    updateGamePlayCount = function()
      ProfileSettings.SetNumTrailBlazerPlays(ProfileSettings.GetNumTrailBlazerPlays() + 1)
    end,
    getPlayCount = ProfileSettings.GetNumTrailBlazerPlays,
    missionVehicle = 171,
    timeToJoinScore = -1
  },
  ["MP team circuit race"] = {
    teams = true,
    missionID = 11 + missionIDOffsetMP,
    updateGamePlayCount = function()
      ProfileSettings.SetNumTeamCircuitRacePlays(ProfileSettings.GetNumTeamCircuitRacePlays() + 1)
    end,
    getPlayCount = ProfileSettings.GetNumTakedownPlays,
    timeToJoinScore = -1
  },
  ["MP Vehicle Swap Tutorial"] = {
    teams = false,
    missionID = 12 + missionIDOffsetMP,
    updateGamePlayCount = function()
    end
  },
  ["MP Vehicle Spawn Tutorial"] = {
    teams = false,
    missionID = 13 + missionIDOffsetMP,
    updateGamePlayCount = function()
    end
  },
  ["MP shift impulse tutorial"] = {
    teams = false,
    missionID = 14 + missionIDOffsetMP,
    updateGamePlayCount = function()
    end
  },
  ["MP general mechanics tutorial"] = {
    teams = false,
    missionID = 15 + missionIDOffsetMP,
    updateGamePlayCount = function()
    end
  },
  ["MP shift take tutorial"] = {
    teams = false,
    missionID = 16 + missionIDOffsetMP,
    updateGamePlayCount = function()
    end
  },
  ["MP checkpoint rush"] = {
    teams = false,
    missionID = 17 + missionIDOffsetMP,
    updateGamePlayCount = function()
      ProfileSettings.SetNumCheckpointRushPlays(ProfileSettings.GetNumCheckpointRushPlays() + 1)
    end,
    getPlayCount = ProfileSettings.GetNumCheckpointRushPlays,
    timeToJoinScore = -1
  },
  ["SS Clean the streets"] = {
    teams = false,
    missionID = 18 + missionIDOffsetMP,
    updateGamePlayCount = function()
    end
  },
  ["SS ShowDown"] = {
    teams = false,
    missionID = 19 + missionIDOffsetMP,
    updateGamePlayCount = function()
    end
  },
  ["SS Go the Distance"] = {
    teams = false,
    missionID = 20 + missionIDOffsetMP,
    updateGamePlayCount = function()
    end
  },
  ["SS Survival"] = {
    teams = false,
    missionID = 21 + missionIDOffsetMP,
    updateGamePlayCount = function()
    end
  },
  ["SS Freedrive"] = {
    teams = false,
    missionID = 22 + missionIDOffsetMP,
    updateGamePlayCount = function()
    end
  },
  ["Coop Choose Your Dare"] = {
    teams = false,
    missionID = 1 + missionIDOffsetCoop,
    updateGamePlayCount = function()
      ProfileSettings.SetNumCoopDarePlays(ProfileSettings.GetNumCoopDarePlays() + 1)
    end,
    getPlayCount = ProfileSettings.GetNumCoopDarePlays
  },
  ["MP coop trial"] = {
    teams = false,
    missionID = 2 + missionIDOffsetCoop,
    updateGamePlayCount = function()
      ProfileSettings.SetNumCoopTeamRacePlays(ProfileSettings.GetNumCoopTeamRacePlays() + 1)
    end,
    getPlayCount = ProfileSettings.GetNumCoopTeamRacePlays
  },
  ["MP CO-OP Mayhem"] = {
    teams = false,
    missionID = 3 + missionIDOffsetCoop
  },
  ["MP coop heavy hitter"] = {
    teams = false,
    missionID = 4 + missionIDOffsetCoop
  },
  ["MP coop survival race"] = {
    teams = false,
    missionID = 5 + missionIDOffsetCoop,
    updateGamePlayCount = function()
      ProfileSettings.SetNumCoopDraftRacePlays(ProfileSettings.GetNumCoopDraftRacePlays() + 1)
    end,
    getPlayCount = ProfileSettings.GetNumCoopDraftRacePlays
  },
  ["MP coop Heist"] = {
    teams = false,
    missionID = 6 + missionIDOffsetCoop
  }
}
function isMissionMP(missionID)
  if missionId > 0 and missionId <= missionIDOffsetCoop then
    return true
  end
  return false
end
function isMissionCoop(missionID)
  if missionId > missionIDOffsetCoop then
    return true
  end
  return false
end
function getMissionName(missionID)
  for i, data in next, missionIntroData, nil do
    if data.missionID and data.missionID == missionID then
      return tostring(i)
    end
  end
  return ""
end
_G.getMissionName = getMissionName
