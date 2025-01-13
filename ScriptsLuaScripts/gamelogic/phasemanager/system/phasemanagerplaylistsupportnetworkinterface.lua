module("phaseManager.playlistSupport")
SNOID = false
isLocal = false
local playlistNetworkVarBuffer = {
  bytes = 64,
  lookupTable = networkParsing.makeLookupTable({
    {name = "trackID", parseType = "uinteger8"},
    {
      name = "faceOffsEnabled",
      parseType = "boolean"
    },
    {
      name = "enableBalancedAbilities",
      parseType = "boolean"
    },
    {name = "allowSwap", parseType = "boolean"},
    {name = "allowSpawn", parseType = "boolean"},
    {
      name = "allowImpulse",
      parseType = "boolean"
    },
    {
      name = "allowTeamVoiceChat",
      parseType = "boolean"
    },
    {
      name = "playerJoining",
      parseType = "boolean"
    },
    {
      name = "joiningStartTime",
      parseType = "float"
    }
  })
}
function playlistNetworkVarBuffer.bufferUpdate(networkVars, newBuffer)
  if gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode and gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.lanPartyMode and networkVars.trackID ~= newBuffer.trackID then
    setTrack(newBuffer.trackID)
  end
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.private and not phaseManager.isLocal and (networkVars.enableBalancedAbilities ~= newBuffer.enableBalancedAbilities or networkVars.allowSwap ~= newBuffer.allowSwap or networkVars.allowSpawn ~= newBuffer.allowSpawn or networkVars.allowImpulse ~= newBuffer.allowImpulse or networkVars.allowTeamVoiceChat ~= newBuffer.allowTeamVoiceChat or networkVars.faceOffsEnabled ~= newBuffer.faceOffsEnabled) then
    onlineProgressionSystem.setOnlinePrivateMatchOptions(newBuffer.enableBalancedAbilities, newBuffer.allowSwap, newBuffer.allowSpawn, newBuffer.allowImpulse, newBuffer.allowTeamVoiceChat, newBuffer.faceOffsEnabled)
  end
  networkVars.__index = newBuffer
end
local customPlaylistBuffer = {
  bytes = 128,
  simple = true,
  parseType = "uinteger8"
}
local function createSNOFromObject()
  NetworkLog.Write(">[LUA] PLAYERLIST SUPPORT - Create SNO for local playlist")
  local SNOID = SNO.createSNO(6)
  if devTurnOffFaceOffs or gameStatus.splitscreenSession then
    networkVars.faceOffsEnabled = false
  end
  SNO.createBuffer(SNOID, playlistNetworkVarBuffer.bytes)
  networkParsing.writeBuffer(SNO, SNOID, 0, playlistNetworkVarBuffer, networkVars)
  SNO.createBuffer(SNOID, customPlaylistBuffer.bytes)
  networkParsing.writeBuffer(SNO, SNOID, 1, customPlaylistBuffer, networkCustomPlaylist)
  SNO.SNOInitialised(SNOID)
  return SNOID
end
local function updateSNOFromObject()
  if networkVars.updateRequired or networkCustomPlaylist.updateRequired then
    NetworkLog.Write(">[LUA] PLAYERLIST SUPPORT - Update playlist buffer , SNOID = " .. tostring(SNOID))
    networkParsing.writeBuffer(SNO, SNOID, 0, playlistNetworkVarBuffer, networkVars)
    networkVars.updateRequired = false
    NetworkLog.Write(">[LUA] PLAYERLIST SUPPORT - Update custom playlist buffer , SNOID = " .. tostring(SNOID))
    networkParsing.writeBuffer(SNO, SNOID, 1, customPlaylistBuffer, networkCustomPlaylist)
    networkCustomPlaylist.updateRequired = false
  end
end
function initiate()
  isLocal = true
  SNOID = createSNOFromObject()
end
function update()
  if isLocal then
    updateSNOFromObject()
  end
end
function createObjectFromSNO(SNOID, numBuffers)
  NetworkLog.Write(">[LUA] PLAYERLIST SUPPORT - Syncing with remotely created SNO, SNOID = " .. tostring(SNOID))
  phaseManager.playlistSupport.SNOID = SNOID
  networkCustomPlaylist = networkParsing.blindReadBuffer(SNO, SNOID, 1)
  networkParsing.readBuffer(SNO, SNOID, 0, playlistNetworkVarBuffer, networkVars)
  if not currentPlaylist and #networkCustomPlaylist > 0 and gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode and gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.lanPartyMode then
    phaseManager.playlistSupport.buildPlaylistFromSyncedModes()
  end
end
function updateObjectFromSNO(SNOID, bufferID)
  NetworkLog.Write(">[LUA] PLAYERLIST SUPPORT - Update buffer from remote playlist system, SNOID = " .. tostring(SNOID) .. ", bufferID = " .. tostring(bufferID))
  if bufferID == 0 then
    networkParsing.readBuffer(SNO, SNOID, bufferID, playlistNetworkVarBuffer, networkVars)
  else
    networkCustomPlaylist = networkParsing.blindReadBuffer(SNO, SNOID, 1)
    if not currentPlaylist and 0 < #networkCustomPlaylist and gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode and gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.lanPartyMode then
      phaseManager.playlistSupport.buildPlaylistFromSyncedModes()
    end
  end
end
function setObjectIsLocal(SNOID, isLocal)
  phaseManager.playlistSupport.isLocal = isLocal
  if isLocal and Network.isInMatch() and #networkCustomPlaylist == 0 then
    Network.matchSyncFailure()
  end
end
function shouldMigrateToLocal(SNOID)
  if Network.isLowestStationID() then
    return true
  else
    return false
  end
end
function deleteObjectFromSNO(SNOID)
end
function purge()
  NetworkLog.Write(">[LUA] PLAYERLIST SUPPORT - purge")
  isLocal = false
  SNOID = false
  if networkVars and networkVars.__index then
    networkVars.__index.enableBalancedAbilities = nil
    networkVars.__index.allowSwap = nil
    networkVars.__index.allowSpawn = nil
    networkVars.__index.allowImpulse = nil
    networkVars.__index.allowTeamVoiceChat = nil
    networkVars.__index.trackID = 1
    networkVars.__index.faceOffsEnabled = true
    networkVars.__index.playerJoining = false
    networkVars.__index.joiningStartTime = 0
  end
end
