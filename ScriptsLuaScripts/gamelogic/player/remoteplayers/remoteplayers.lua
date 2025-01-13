module("remotePlayers", package.seeall)
local remotePlayerTemplate = {isPlayer = true, isLocal = false}
remotePlayerTemplate.__index = remotePlayerTemplate
function createPlayer(playerID, numBuffers)
  local player = {
    inZap = true,
    playerID = playerID,
    position = vec.vector(),
    name = PlayerGamePlay.getPlayerName(playerID)
  }
  setmetatable(player, remotePlayerTemplate)
  playerManager.addPlayer(player)
  phaseManager.registerPlayer(player)
  onlineRaceManager.updatePlayersAndVehicles()
end
function update()
  for playerID, player in next, playerManager.players, nil do
    if not player.isLocal then
      player:update()
    end
  end
end
function remotePlayerTemplate:remoteSetZapLevel(level, vehicle)
  if level == 0 then
    self:remoteExitZap(vehicle)
  else
    self:remoteEnterZap()
  end
  onlineRaceManager.updatePlayersAndVehicles()
end
function remotePlayerTemplate:remoteExitZap(vehicle)
  if self.currentVehicle then
    self:remoteSetZapLevel(1)
  end
  self.currentVehicle = vehicle
  self.currentVehicle.gameVehicle.setIsPlayerCar = true
  self.currentVehicle.networkControlled = self
  self.inZap = false
  ZapAIPresence.StartTransition(nil, self.currentVehicle.gameVehicle, self.playerID)
  self:update()
end
function remotePlayerTemplate:remoteEnterZap()
  if self.currentVehicle then
    self.currentVehicle.networkControlled = nil
    if vehicleManager.vehiclesBySNVID[self.currentVehicle.SNVID] then
      local oldVehicleIsEmpty = true
      GameVehicleResource.zapFlash(self.currentVehicle.gameVehicle)
      for playerID, player in next, playerManager.players, nil do
        if player ~= self and player.currentVehicle and player.currentVehicle.SNVID == self.currentVehicle.SNVID then
          oldVehicleIsEmpty = false
          break
        end
      end
      if oldVehicleIsEmpty then
        self.currentVehicle.gameVehicle.setIsPlayerCar = false
      end
    end
  end
  self.currentVehicle = false
  self.inZap = true
  self:update()
end
function remotePlayerTemplate:getTaskObject()
  for taskObjectID, taskObject in next, taskSystem.taskObjects, nil do
    if taskObject.coreData.agent == self then
      return taskObject
    end
  end
  return false
end
function remotePlayerTemplate:getInstance()
  local taskObject = self:getTaskObject()
  if taskObject then
    return taskObject.coreData.instance
  end
  return false
end
function remotePlayerTemplate:update()
  if not self.inZap then
    self.position = self.currentVehicle.position
    self.heading = self.currentVehicle.heading
    self.speed = self.currentVehicle.speed
  end
end
function remotePlayerTemplate:delete()
  if phaseManager.isLocal then
    phaseManager.unregisterPlayer(self)
  end
  if not self.inZap then
    self:remoteSetZapLevel(1)
  end
  playerManager.removePlayer(self)
end
function receivedRemoteStat(remotePlayerId, statId, value)
  if statId == 1 then
    onlineScreenManager.updatePlayerXP(remotePlayerId, value)
  end
end
_G.receivedRemoteStat = receivedRemoteStat
