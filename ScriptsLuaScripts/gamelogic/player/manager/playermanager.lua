module("playerManager", package.seeall)
players = {}
playerTeams = {}
playerTeamsUpdated = false
numberOfPlayers = 0
function addPlayer(player)
  if not players[player.playerID] then
    NetworkLog.Write(">[LUA] PLAYERMANAGER - Add player " .. tostring(player.playerID))
    players[player.playerID] = player
    numberOfPlayers = numberOfPlayers + 1
    if Network.isOnlineGame() then
      for gameVehicle, vehicle in next, vehicleManager.vehiclesByGameVehicle, nil do
        if vehicle.isLocal and vehicle.networkVars.onlineRequiredVehicle and vehicle.networkVars.onlineOwnerID and vehicle.networkVars.onlineOwnerID == player.playerID then
          vehicle.networkVars.onlineRequiredVehicle = false
          vehicle.networkVars.onlineOwnerID = nil
          zapcontroller.RemoveLockedVehicle({
            gameVehicle = vehicle.gameVehicle
          })
        end
      end
      updatePlayerTeams(true)
      Menu.SetPlayerColour(player.playerID, OnlineModeSettings.pink128)
      feedbackSystem.multiplayerSupport.playerJoined(player)
      gamerTag.setplayerTagEnabled(player.playerID, true)
      gamerTag.setPlayerMarkerModel(player.playerID, 5)
    end
  end
end
function removePlayer(player)
  if players[player.playerID] then
    NetworkLog.Write(">[LUA] PLAYERMANAGER - Remove player " .. tostring(player.playerID))
    if Network.isOnlineGame() then
      gamerTag.setPlayerMarkerModel(player.playerID, 5)
      gamerTag.setPlayerObjectiveMarker(player.playerID, false)
      local instance = challengeSystem.instances[phaseManager.networkVars.modeID]
      if instance and instance.isLocal and instance.playerScores then
        instance.playerScores[player.playerID + 1] = 0
      end
      if instance and instance.isLocal and instance.turnTracking then
        instance.turnTracking[player.playerID + 1] = 0
      end
      onlineScreenManager.removePlayer(player.playerID)
      feedbackSystem.multiplayerSupport.playerLeft(player)
      phaseManager.removePlayer(player.playerID)
      onlineRaceManager.removePlayer(player.playerID)
      packageManager.removePlayer(player.playerID)
      faceOffSystem.unregisterPlayer(player)
      for gameVehicle, vehicle in next, vehicleManager.vehiclesByGameVehicle, nil do
        if vehicle.isLocal and vehicle.networkVars.onlineRequiredVehicle and vehicle.networkVars.onlineOwnerID and vehicle.networkVars.onlineOwnerID == player.playerID then
          vehicle.networkVars.onlineRequiredVehicle = false
          vehicle.networkVars.onlineOwnerID = nil
          zapcontroller.RemoveLockedVehicle({
            gameVehicle = vehicle.gameVehicle
          })
        end
      end
      players[player.playerID] = nil
      numberOfPlayers = numberOfPlayers - 1
      updatePlayerTeams(true)
    else
      players[player.playerID] = nil
      numberOfPlayers = numberOfPlayers - 1
    end
  end
end
function getPlayerTeam(playerID)
  if players[playerID] then
    updatePlayerTeams()
    if playerTeams[playerID] then
      return playerTeams[playerID]
    end
  end
  return false
end
function purge()
  players = {}
  numberOfPlayers = 0
end
function registerPlayer(playerID, isLocal, localID)
  print("registerPlayer " .. playerID)
  isLocal = isLocal == 1
  if isLocal then
    local plr = localPlayerManager.players[localID]
    plr.playerID = playerID
    plr.name = PlayerGamePlay.getPlayerName(playerID)
    addPlayer(plr)
    onlineScreenManager.addPlayer(playerID)
    if Network.isLANGame() or Network.isLANParty() then
      onlineProgressionSystem.progressionSetup(false)
    end
  else
    remotePlayers.createPlayer(playerID)
    if Network.isOnlineGame() then
      onlineScreenManager.addPlayer(playerID)
    end
  end
end
_G.RegisterPlayer = registerPlayer
function unregisterPlayer(playerID)
  if players[playerID] then
    NetworkLog.Write(">[LUA] PLAYERMANAGER - unregisterPlayer - Player = " .. tostring(playerID))
    assert(playerID ~= localPlayer.playerID, "Cannot delete the local player")
    players[playerID]:delete()
  else
    NetworkLog.Write(">[LUA] PLAYERMANAGER - unregisterPlayer - Didnt have Player = " .. tostring(playerID))
  end
end
_G.UnregisterPlayer = unregisterPlayer
function postUnregisterPlayer(playerID)
  if Network.isOnlineGame() and not Network.isPartyMode() and not Network.isLANParty() then
    phaseManager.checkTeamRebalanceRequired()
  end
end
_G.postUnregisterPlayer = postUnregisterPlayer
function playerZappedOut(playerID, SNVID, forcedOut)
  local player = players[playerID]
  assert(player, [[
PlayerZappedOut:
 Player with ID = ]] .. tostring(playerID) .. " was not found in script playerManager")
  if player.isLocal then
    if vehicleManager.previewVehicleManager.previewVehicle then
      vehicleManager.previewVehicleManager.rejectChallengeCallback()
    end
    CameraSystem.ClearScene()
    if not localPlayer.inZap then
      player:SetZapLevel(1)
    end
  else
    player:remoteSetZapLevel(1)
  end
  return false
end
_G.PlayerZappedOut = playerZappedOut
function playerZappedIn(playerID, SNVID)
  local player = players[playerID]
  assert(player, [[
PlayerZappedIn:
 Player with ID = ]] .. tostring(playerID) .. " was not found in script playerManager")
  if not player.isLocal then
    local vehicle = vehicleManager.vehiclesBySNVID[SNVID]
    assert(player, [[
PlayerZappedIn:
 SNV with ID = ]] .. tostring(SNVID) .. " was not found in script vehicleManager")
    player:remoteSetZapLevel(0, vehicle, true)
  end
end
_G.PlayerZappedIn = playerZappedIn
function updatePlayerTeams(forceUpdate)
  if forceUpdate or g_NetworkTime ~= playerTeamsUpdated then
    for i = 0, 7 do
      if players[i] then
        playerTeams[i] = PlayerGamePlay.getPlayerTeam(i)
      else
        playerTeams[i] = false
      end
    end
    playerTeamsUpdated = g_NetworkTime
  end
end
_G.UpdatePlayerTeams = updatePlayerTeams
function resetPlayerTags()
  for playerID, player in next, players, nil do
    Menu.SetPlayerColour(playerID, OnlineModeSettings.pink128)
  end
end
