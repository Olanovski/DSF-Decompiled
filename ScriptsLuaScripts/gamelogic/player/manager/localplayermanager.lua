module("localPlayerManager", package.seeall)
players = {}
numberOfPlayers = 0
maxNumOfPlayers = 2
function getPlayers()
  return players
end
function getPlayerById(localID)
  return players[localID]
end
function addPlayer(plr)
  if not players[plr.localID] then
    players[plr.localID] = plr
    numberOfPlayers = numberOfPlayers + 1
    player.addPlayer()
    localPlayerManagerReflection.addPlayer(plr.localID, plr)
    localPlayerManagerReflection.setCurrentVehicle(plr.localID, plr.currentVehicle)
    localPlayerManagerReflection.setPreviousVehicle(plr.localID, plr.previousVehicle)
    localPlayerManagerReflection.setInZap(plr.localID, plr.inZap)
    localPlayerManagerReflection.setWreckedAutoZap(plr.localID, plr.wreckedAutoZap)
    localPlayerManagerReflection.setWreckAutoZapEnabled(plr.localID, plr.wreckAutoZapEnabled)
    localPlayerManagerReflection.setBlockWagglePrompt(plr.localID, plr.blockWagglePrompt)
    localPlayerManagerReflection.setWaggleStickPrompt(plr.localID, plr.waggleStickPrompt)
    localPlayerManagerReflection.setBlockDamageBarUpdate(plr.localID, plr.blockDamageBarUpdate)
    localPlayerManagerReflection.setBlockAutoZap(plr.localID, plr.blockAutoZap)
    localPlayerManagerReflection.setSelfRighting(plr.localID, plr.selfRighting)
    zap.settings.initialise(plr.localID)
  end
end
function removePlayer(plr)
  if players[plr.localID] then
    moodSystem.clearMoods()
    players[plr.localID] = nil
    localPlayerManagerReflection.removePlayer(plr.localID)
    numberOfPlayers = numberOfPlayers - 1
    player.removePlayer()
  end
end
function getPlayerByGameVehicle(gameVehicle)
  for localID, player in next, players, nil do
    if player.currentVehicle and player.currentVehicle.gameVehicle == gameVehicle then
      return player
    end
  end
  return nil
end
function getPlayerZappingIntoGameVehicle(gameVehicle)
  for localID, player in next, players, nil do
    if player.zapTransition and player.transitioningGameVehicle == gameVehicle then
      return player
    end
  end
  return nil
end
function getPlayerByPreviousGameVehicle(gameVehicle)
  for localID, player in next, players, nil do
    if player.previousVehicle and player.previousVehicle.gameVehicle == gameVehicle then
      return player
    end
  end
  return nil
end
function isPlayerIDLocal(playerID)
  for localID, player in next, players, nil do
    if player.playerID == playerID then
      return true
    end
  end
  return false
end
function initiate()
  for localID, player in next, players, nil do
    player:initiate()
  end
end
function purge()
  for localID, player in next, players, nil do
    player:purge()
  end
  localPlayer.challenge.purge()
  localPlayer.simulationSupport.purge()
end
function update()
  localPlayerManagerReflection.update()
end
function modeDeleted()
  for localID, player in next, players, nil do
    if player.playerTaskObject then
      player.playerTaskObject = nil
    end
  end
end
