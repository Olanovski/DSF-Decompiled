module("phaseManager.playlistSupport", package.seeall)
debug_none_random_route_cycle = false
debug_none_random_cycle_lastRoute = 0
debug_none_random_cycle_lastRoute_faceOff = 0
debug_cycle_time = 5
debug_cycle_all_mode = false
debug_cycle_playList_mode = false
debug_cycle_all_mode_start = nil
debug_cycle_all_mode_last_played = nil
playerTutorialVehicleSwap = false
playerTutorialVehicleSpawn = false
playerTutorialShiftImpulse = false
playerTutorialGeneralMechanics = false
playerTutorialShiftTake = false
ssPlayedModeCount = 0
ssPlayedModeResults = {
  tanner = 0,
  jericho = 0,
  wins = {
    [1] = -1,
    [2] = -1,
    [3] = -1,
    [4] = -1,
    [5] = -1,
    [6] = -1,
    [7] = -1
  }
}
ssModeMedals = {
  [1] = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0
  },
  [2] = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0
  }
}
durationSelected = 1
local displayNameLookup = {
  ["MP tag"] = "ID:169349",
  ["MP takedown"] = "ID:169356",
  ["MP burning rubber"] = "ID:168506",
  ["MP circuit race"] = "ID:169316",
  ["MP pure race"] = "ID:169326",
  ["MP sprint race"] = "ID:169346",
  ["MP team circuit race"] = "ID:231134",
  ["MP tug of war"] = "ID:169282",
  ["MP rush down"] = "ID:169332",
  ["MP trail blazer"] = "ID:169361",
  ["MP checkpoint rush"] = "ID:243802",
  ["MP Vehicle Swap Tutorial"] = "ID:235989",
  ["MP Vehicle Spawn Tutorial"] = "ID:235983",
  ["MP shift impulse tutorial"] = "ID:235995",
  ["MP general mechanics tutorial"] = "ID:235997",
  ["MP shift take tutorial"] = "ID:235991",
  ["SS Freedrive"] = "ID:235348",
  ["SS Clean the streets"] = "ID:245431",
  ["SS Survival"] = "ID:245432",
  ["SS Go the Distance"] = "ID:245430"
}
modePool = {
  competitive = {
    ["MP tag"] = false,
    ["MP takedown"] = false,
    ["MP burning rubber"] = false,
    ["MP circuit race"] = false,
    ["MP pure race"] = false,
    ["MP sprint race"] = false,
    ["MP team circuit race"] = false,
    ["MP tug of war"] = false,
    ["MP rush down"] = false,
    ["MP trail blazer"] = false,
    ["MP checkpoint rush"] = false,
    ["MP Vehicle Swap Tutorial"] = false,
    ["MP Vehicle Spawn Tutorial"] = false,
    ["MP shift impulse tutorial"] = false,
    ["MP general mechanics tutorial"] = false,
    ["MP shift take tutorial"] = false
  },
  cooperative = {
    ["SS Freedrive"] = false,
    ["SS Clean the streets"] = false,
    ["SS Survival"] = false,
    ["SS Go the Distance"] = false
  }
}
currentPlaylist = false
currentTrack = false
networkVars = {
  debugCheckIsLocal = function()
    return phaseManager.isLocal
  end,
  updateRequired = true,
  __newindex = networkParsing.metaSetNetworkVar,
  __index = {
    trackID = 1,
    faceOffsEnabled = true,
    playerJoining = false,
    joiningStartTime = 0,
    enableBalancedAbilities = nil,
    allowSwap = nil,
    allowSpawn = nil,
    allowImpulse = nil,
    allowTeamVoiceChat = nil
  }
}
setmetatable(networkVars, networkVars)
networkCustomPlaylist = {updateRequired = true}
function populateMissionPool()
end
function populateMPMissionPool()
  NetworkLog.Write(">[LUA] PLAYERLIST SUPPORT - populateMPMissionPool")
  for i, data in ipairs(cards.MissionNetworkLookup) do
    if modePool.competitive[data] ~= nil then
      modePool.competitive[data] = i
    elseif modePool.cooperative[data] ~= nil then
      modePool.cooperative[data] = i
    end
  end
  for uniqueKey, networkID in ipairs(modePool.competitive) do
    assert(networkID, "PHASEMANAGER PLAYLISTSUPPORT - populateMPMissionPool: Mission '" .. tostring(uniqueKey) .. "' did not get a matching networkID")
  end
  for uniqueKey, networkID in ipairs(modePool.cooperative) do
    assert(networkID, "PHASEMANAGER PLAYLISTSUPPORT - populateMPMissionPool: Mission '" .. tostring(uniqueKey) .. "' did not get a matching networkID")
  end
end
_G.populateMPMissionPool = populateMPMissionPool
function populateCoopMissionPool()
end
_G.populateCoopMissionPool = populateCoopMissionPool
function getPlaylist()
  return 0
end
_G.getPlaylist = getPlaylist
function getMPMissionTitleFromUniqueKey(uniqueKey)
  local networkID = modePool.competitive[uniqueKey]
  return missionInfo[networkID].challengeTitle
end
_G.getMPMissionTitleFromUniqueKey = getMPMissionTitleFromUniqueKey
function getCoopMissionTitleFromUniqueKey(uniqueKey)
  local networkID = modePool.cooperative[uniqueKey]
  return missionInfo[networkID].challengeTitle
end
_G.getCoopMissionTitleFromUniqueKey = getCoopMissionTitleFromUniqueKey
function getCoopMissionHighScore(mission, difficulty)
  return coopSystem.getHighScore(mission, difficulty)
end
_G.getCoopHighScore = getCoopMissionHighScore
function setCoopMissionHighScore(mission, difficulty, score)
  coopSystem.setHighScore(mission, difficulty, score)
end
_G.setCoopHighScore = setCoopMissionHighScore
function setSelectedCoopDifficultyLevel(difficulty)
end
_G.setSelectedCoopDifficulty = setSelectedCoopDifficultyLevel
function getSelectedCoopDifficultyLevel()
  return coopSystem.getSelectedDifficulty()
end
_G.getSelectedCoopDifficulty = getSelectedCoopDifficultyLevel
function setSelectedLocation(iLocation)
  locationSelected = iLocation
  print("setSelectedLocation location set to " .. locationSelected)
end
_G.setSelectedLocation = setSelectedLocation
function getSelectedLocation()
  return locationSelected
end
_G.getSelectedLocation = getSelectedLocation
function clearSplitscreenModeProgression()
  ssPlayedModeCount = 0
  ssPlayedModeResults.tanner = 0
  ssPlayedModeResults.jericho = 0
  for i = 1, 7 do
    ssPlayedModeResults.wins[i] = -1
    ssModeMedals[1][i] = 0
    ssModeMedals[2][i] = 0
  end
end
_G.clearSSProgression = clearSplitscreenModeProgression
function setSelectedDuration(iDuration)
  durationSelected = iDuration
  print("setSelectedDuration duration set to " .. durationSelected)
  clearSplitscreenModeProgression()
end
_G.setSelectedDuration = setSelectedDuration
function getSelectedDuration()
  return durationSelected
end
_G.getSelectedDuration = getSelectedDuration
function getNumberOfCompSSModesPlayed()
  return ssPlayedModeCount
end
_G.getNumberOfCompSSModesPlayed = getNumberOfCompSSModesPlayed
function setSSModeMedals(iMission, iP1Result, iP2Result)
  ssModeMedals[1][iMission] = iP1Result
  ssModeMedals[2][iMission] = iP2Result
  print("missionResults for mission " .. iMission .. " P1 set to " .. ssModeMedals[1][iMission] .. ", P2 set to " .. ssModeMedals[2][iMission])
end
_G.setSSMissionResults = setSSModeMedals
function getSSModeMedals(iMission)
  return ssModeMedals[1][iMission], ssModeMedals[2][iMission], ssPlayedModeResults.wins[iMission] - 1
end
_G.getSSMissionResults = getSSModeMedals
function getCoopMissionDescriptionFromUniqueKey(uniqueKey)
  local networkID = modePool.cooperative[uniqueKey]
  return missionInfo[networkID].description
end
_G.getCoopMissionDescriptionFromUniqueKey = getCoopMissionDescriptionFromUniqueKey
function getCmpMissionDescriptionFromUniqueKey(uniqueKey)
  local networkID = modePool.competitive[uniqueKey]
  return missionInfo[networkID].description
end
_G.getCmpMissionDescriptionFromUniqueKey = getCmpMissionDescriptionFromUniqueKey
function buildPlaylistFromSyncedModes()
  NetworkLog.Write(">[LUA] PLAYERLIST SUPPORT - buildPlaylistFromSyncedModes " .. tostring(networkVars.trackID))
  if #networkCustomPlaylist == 0 then
    Network.matchSyncFailure()
  else
    currentPlaylist = {}
    for i, networkID in ipairs(networkCustomPlaylist) do
      table.insert(currentPlaylist, cards.MissionNetworkLookup[networkID])
    end
    setTrack(networkVars.trackID)
  end
  networkLogPrintTable(currentPlaylist, 1)
end
function clearPlaylist()
  NetworkLog.Write(">[LUA] PLAYERLIST SUPPORT - clearPlaylist")
  currentPlaylist = nil
end
function clearCustomPlaylistTracks()
  NetworkLog.Write(">[LUA] PLAYERLIST SUPPORT - clearCustomPlaylistTracks")
  for i, networkID in ripairs(networkCustomPlaylist) do
    dropCustomPlaylistTrack(i)
  end
end
_G.clearCustomPlaylistTracks = clearCustomPlaylistTracks
function clearAllPlayerLists()
  clearPlaylist()
  clearCustomPlaylistTracks()
end
function addCustomPlaylistTrack(uniqueKey, trackPosition)
  NetworkLog.Write(">[LUA] PLAYERLIST SUPPORT - addCustomPlaylistTrack, uniqueKey = " .. tostring(uniqueKey) .. " , trackPosition " .. tostring(trackPosition))
  trackPosition = trackPosition or #networkCustomPlaylist + 1
  if modePool.competitive[uniqueKey] then
    table.insert(networkCustomPlaylist, trackPosition, modePool.competitive[uniqueKey])
    networkCustomPlaylist.updateRequired = true
    return
  elseif modePool.cooperative[uniqueKey] then
    table.insert(networkCustomPlaylist, trackPosition, modePool.cooperative[uniqueKey])
    networkCustomPlaylist.updateRequired = true
    return
  end
  assert(false, "PHASEMANAGER PLAYLISTSUPPORT - addCustomPlaylistTrack: Mission '" .. tostring(uniqueKey) .. "' not found in mission pool")
end
_G.addCustomPlaylistTrack = addCustomPlaylistTrack
function dropCustomPlaylistTrack(trackPosition)
  NetworkLog.Write(">[LUA] PLAYERLIST SUPPORT - dropCustomPlaylistTrack, trackPosition = " .. tostring(trackPosition))
  assert(networkCustomPlaylist[trackPosition], "PHASEMANAGER PLAYLISTSUPPORT - dropCustomPlaylistTrack: Attempt to drop non-existant track")
  table.remove(networkCustomPlaylist, trackPosition)
  networkCustomPlaylist.updateRequired = true
end
function nextTrack()
  if networkVars.trackID < #currentPlaylist then
    setTrack(networkVars.trackID + 1)
  else
    setTrack(1)
  end
end
function setTrack(trackID)
  NetworkLog.Write(">[LUA] PLAYERLIST SUPPORT - Setting new track, isLocal = " .. tostring(phaseManager.isLocal) .. ", trackID = " .. tostring(trackID))
  if phaseManager.isLocal then
    networkVars.trackID = trackID
  end
  if currentPlaylist then
    currentTrack = currentPlaylist[trackID]
  else
    currentTrack = false
  end
end
function getCurrentMission()
  return currentPlaylist[networkVars.trackID]
end
local DEBUGValidTestMission = function(missionName)
  if missionName == "MP Vehicle Swap Tutorial" then
    return false
  elseif missionName == "MP Vehicle Spawn Tutorial" then
    return false
  elseif missionName == "MP shift impulse tutorial" then
    return false
  elseif missionName == "MP general mechanics tutorial" then
    return false
  elseif missionName == "MP shift take tutorial" then
    return false
  elseif missionName == "SS Clean the streets" then
    return false
  elseif missionName == "SS Survival" then
    return false
  elseif missionName == "SS Go the Distance" then
    return false
  elseif missionName == "SS ShowDown" then
    return false
  elseif missionName == "SS Freedrive" then
    return false
  end
  return true
end
function setNextMission()
  nextTrack()
end
function getChosenMission()
  currentTrack = currentPlaylist[networkVars.trackID]
  assert(currentTrack, "PHASE MANAGER PLAYERLIST SUPPORT, no track")
  local nextNetworkID
  if debug_cycle_all_mode then
    local temp
    debug_cycle_all_mode_start, temp = next(modePool.competitive)
    if debug_cycle_all_mode_last_played then
      local nextMode = false
      for missionName, networkID in next, modePool.competitive, nil do
        if DEBUGValidTestMission(missionName) then
          if nextMode then
            nextNetworkID = networkID
            debug_cycle_all_mode_last_played = missionName
            currentTrack = debug_cycle_all_mode_last_played
            break
          end
          if missionName == debug_cycle_all_mode_last_played then
            nextMode = true
          end
        end
      end
      if not nextMode or not nextNetworkID then
        nextNetworkID = modePool.competitive[debug_cycle_all_mode_start]
        currentTrack = debug_cycle_all_mode_start
        debug_cycle_all_mode_last_played = debug_cycle_all_mode_start
      end
    else
      nextNetworkID = modePool.competitive[debug_cycle_all_mode_start]
      currentTrack = debug_cycle_all_mode_start
      debug_cycle_all_mode_last_played = debug_cycle_all_mode_start
    end
  else
    nextNetworkID = phaseManager.isComp(currentTrack) and modePool.competitive[currentTrack] or modePool.cooperative[currentTrack]
  end
  nextNetworkID = not devMissionSelection or phaseManager.isComp(devMissionSelection) and modePool.competitive[devMissionSelection] or modePool.cooperative[devMissionSelection]
  if playerTutorialVehicleSwap then
    nextNetworkID = modePool.competitive["MP Vehicle Swap Tutorial"]
  end
  if playerTutorialVehicleSpawn then
    nextNetworkID = modePool.competitive["MP Vehicle Spawn Tutorial"]
  end
  if playerTutorialShiftImpulse then
    nextNetworkID = modePool.competitive["MP shift impulse tutorial"]
  end
  if playerTutorialGeneralMechanics then
    nextNetworkID = modePool.competitive["MP general mechanics tutorial"]
  end
  if playerTutorialShiftTake then
    nextNetworkID = modePool.competitive["MP shift take tutorial"]
  end
  local mission = cards.MissionNetworkLookup[nextNetworkID]
  local id
  for i, data in ipairs(cards.MissionNetworkLookup) do
    if data == mission then
      id = i
      break
    end
  end
  local missionData = cardSystem.createMission(mission)
  assert(missionData.spawnPositions, "PHASEMANAGER PLAYLISTSUPPORT, " .. tostring(mission) .. " does not have spawnPosition(s) check your logic file")
  assert(missionData.usableRouteIndicies, "PHASEMANAGER PLAYLISTSUPPORT, " .. tostring(mission) .. " does not have usableRouteIndicies check your logic file")
  local routeIndex
  if missionData.getInitialRouteIndexCallback ~= nil then
    routeIndex = missionData.getInitialRouteIndexCallback()
  elseif debug_none_random_route_cycle then
    if debug_none_random_cycle_lastRoute <= 0 or debug_none_random_cycle_lastRoute > #missionData.usableRouteIndicies then
      debug_none_random_cycle_lastRoute = 1
    end
    routeIndex = missionData.usableRouteIndicies[debug_none_random_cycle_lastRoute]
  else
    local routeIndexLocation = -1
    if gameStatus.splitscreenSession then
      routeIndexLocation = phaseManager.getUsableModeAreaIndex(mission, missionData.usableRouteIndicies[locationSelected], missionData.settings.linearProgression)
      routeIndex = missionData.usableRouteIndicies[locationSelected][routeIndexLocation]
    else
      routeIndexLocation = phaseManager.getUsableModeAreaIndex(mission, missionData.usableRouteIndicies, missionData.settings.linearProgression)
      routeIndex = missionData.usableRouteIndicies[routeIndexLocation]
    end
  end
  return mission, id, routeIndex
end
function getPrivateMatchOptionBalancedAbilities()
  return networkVars.enableBalancedAbilities
end
_G.onlineGetPrivateMatchOptionBalancedAbilities = getPrivateMatchOptionBalancedAbilities
function getPrivateMatchOptionAllowSwap()
  return networkVars.allowSwap
end
_G.onlineGetPrivateMatchOptionAllowSwap = getPrivateMatchOptionAllowSwap
function getPrivateMatchOptionAllowSpawn()
  return networkVars.allowSpawn
end
_G.onlineGetPrivateMatchOptionAllowSpawn = getPrivateMatchOptionAllowSpawn
function getPrivateMatchOptionAllowImpulse()
  return networkVars.allowImpulse
end
_G.onlineGetPrivateMatchOptionAllowImpulse = getPrivateMatchOptionAllowImpulse
function getPrivateMatchOptionAllowVoiceChat()
  return networkVars.allowTeamVoiceChat
end
_G.onlineGetPrivateMatchOptionAllowVoiceChat = getPrivateMatchOptionAllowVoiceChat
function getPrivateMatchOptionFaceOffEnabled()
  return networkVars.faceOffsEnabled
end
_G.onlineGetPrivateMatchOptionFaceOffEnabled = getPrivateMatchOptionFaceOffEnabled
function getNumberOfSelectedModes()
  return #networkCustomPlaylist
end
_G.onlineGetNumberOfSelectedModes = getNumberOfSelectedModes
function getModeID(i)
  assert(networkCustomPlaylist[i], "onlineGetModeID - Mode not found: i = " .. tostring(i) .. "   mode count = " .. tostring(#networkCustomPlaylist))
  for modeID, networkID in next, modePool.competitive, nil do
    if networkCustomPlaylist[i] == networkID then
      return modeID
    end
  end
  for modeID, networkID in next, modePool.cooperative, nil do
    if networkCustomPlaylist[i] == networkID then
      return modeID
    end
  end
  assert(false, "onlineGetModeID - Mode not found: string ID not found")
end
_G.onlineGetModeID = getModeID
function getDisplayName(devName)
  assert(displayNameLookup[devName], "No display name to return for: " .. tostring(devName))
  return displayNameLookup[devName]
end
function playlistValid()
  if currentPlaylist and currentPlaylist[networkVars.trackID] then
    return true
  end
  return false
end
