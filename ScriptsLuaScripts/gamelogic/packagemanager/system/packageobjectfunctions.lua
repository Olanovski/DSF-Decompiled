module("packageManager", package.seeall)
local packageTemplate = {isPackage = true}
packageTemplate.__index = packageTemplate
function createPackage(drawPackage, position, isLocal, damageMultiplier, owner, SNOID, taskObjectID, playerID, index, active, snapToRoad)
  local onFloor = true
  local ownerID = invalidOwnerID
  playerID = playerID or invalidOwnerID
  if owner then
    ownerID = owner.SNVID
    position = owner.position
    onFloor = false
  end
  if not position then
    position = vec.vector(0, 0, 0, 1)
  elseif snapToRoad then
    local roadIndex, distanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(position)
    position = Atlas.RoadPositionAtDistanceAlong(roadIndex, distanceAlong)
    position.y = position.y + 1
  end
  isLocal = isLocal or false
  local package = {
    position = position,
    isLocal = isLocal,
    ownerID = ownerID,
    owner = owner,
    taskObjectID = taskObjectID,
    SNOID = SNOID,
    onFloor = onFloor,
    playerID = playerID,
    damageMultiplier = damageMultiplier,
    drawPackage = drawPackage,
    index = index,
    active = active,
    timeStamp = 0
  }
  setmetatable(package, packageTemplate)
  if not SNOID then
    package.SNOID = createSNOFromObject(package)
    packagesBySNOID[package.SNOID] = package
  else
    package.SNOID = SNOID
    packagesBySNOID[package.SNOID] = package
  end
  SNO.setMigrationType(package.SNOID, 1)
  NetworkLog.Write(">[LUA] PACKAGEMANAGER - Package created with SNO " .. tostring(package.SNOID))
  return package
end
function removePlayer(playerID)
  for SNOID, package in next, packagesBySNOID, nil do
    if package.playerID == playerID then
      package:playerLeft()
    end
  end
end
function packageTemplate:release()
  NetworkLog.Write(">[LUA] PACKAGEMANAGER - Package Release. Package local : " .. tostring(self.isLocal))
  if self.isLocal then
    assert(SNO.canBeDeleted(self.SNOID))
    SNO.setMigrationType(self.SNOID, 0)
    SNO.deleteSNO(self.SNOID)
  end
  packagesBySNOID[self.SNOID] = nil
end
function packageTemplate:canBeDeleted()
  if self.isLocal and not SNO.canBeDeleted(self.SNOID) then
    return false
  end
  return true
end
function packageTemplate:update()
  if self.owner and self.ownerID ~= invalidOwnerID then
    if vehicleManager.vehiclesBySNVID[self.ownerID] then
      self.position = self.owner.position
    else
      local player = playerManager.players[self.playerID]
      if not player then
        self:playerLeft()
      end
    end
  end
  if self.owner and self.ownerID ~= invalidOwnerID then
    for playerID, player in next, playerManager.players, nil do
      if player.currentVehicle and player.currentVehicle == self.owner then
        self.playerID = playerID
        break
      end
    end
  else
    self.playerID = nil
  end
end
function packageTemplate:playerLeft(newBuffer)
  if playerLeftPackageDropType == 1 then
    if self.owner then
      local dropPosition, dropTime = GameVehicleResource.getSnappedPredictedPosition(self.owner.gameVehicle, 0.3)
      self:packageDropped(dropPosition)
    else
      self:packageDropped()
    end
  else
    self.playerID = nil
  end
end
function packageTemplate:packageDropped(position, active)
  NetworkLog.Write(">[LUA] PACKAGEMANAGER - Package Dropped. Package local : " .. tostring(self.isLocal) .. " playerID who dropped the flag " .. tostring(self.playerID))
  if position then
    self.position = position:clone()
  else
    self.position = self.position:clone()
  end
  if active ~= nil then
    self.active = active
  end
  self.onFloor = true
  self.owner = nil
  self.ownerID = nil
  self.playerID = nil
  if self.isLocal then
    updateSNOFromObject(self)
  end
  if updateZapToActionType == 1 then
    MPZapToAction.updateZapToActionTarget(self)
  else
    local torchTaskObject
    if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
      torchTaskObject = self:getTaskObject().coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    else
      torchTaskObject = self:getTaskObject().coreData.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
    end
    if torchTaskObject == self:getTaskObject() then
      MPZapToAction.updateZapToActionTarget(self)
    end
  end
  packageHasBeenDropped(self.SNOID)
end
function packageTemplate:setOwner(vehicle, playerID)
  NetworkLog.Write(">[LUA] PACKAGEMANAGER - Package Set Owner. Package local : " .. tostring(self.isLocal) .. " playerID who picked up the flag " .. tostring(playerID))
  local oldOwner = self.owner
  self.owner = vehicle
  self.ownerID = vehicle.SNVID
  self.onFloor = false
  self.playerID = playerID
  self.owner:set_damageMultiplier(self.damageMultiplier)
  if self.isLocal then
    self.timeStamp = g_NetworkTime
    updateSNOFromObject(self)
  end
  if updateZapToActionType == 1 then
    MPZapToAction.updateZapToActionTarget(self)
  elseif self:getTaskObject() and self:getTaskObject().coreData and self:getTaskObject().coreData.instance then
    local torchTaskObject = false
    if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
      torchTaskObject = self:getTaskObject().coreData.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    else
      torchTaskObject = self:getTaskObject().coreData.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
    end
    if torchTaskObject and torchTaskObject == self:getTaskObject() then
      MPZapToAction.updateZapToActionTarget(self)
    end
  end
  if taskSystem.restrictedObjects[self:getTaskObject()] then
    taskSystem.setAgentUpdateRestriction(self:getTaskObject(), oldOwner)
  end
end
function packageTemplate:getTaskObject()
  if self.taskObjectID then
    return taskSystem.taskObjects[self.taskObjectID]
  end
  return nil
end
function packageTemplate:isPackageCarrier(SNVID)
  if not self.owner then
    return false
  end
  return self.ownerID == SNVID
end
local validTime = function(requestTimeStamp, packageTimeStamp)
  if packageTimeStamp < requestTimeStamp and g_NetworkTime - requestTimeStamp > oldTimeStamp then
    return false
  end
  return true
end
local sendPlayerResponse = function(player, messageType, messageID)
  if player == localPlayer then
    requestDenied(player.playerID, messageType, tostring(messageID))
  else
    PlayerGamePlay.sendMessage(player.playerID, messageType, tostring(messageID))
  end
end
local index, SNVID, timeStamp, messageID
local function fillOwnershipRequestData(value)
  assert(index < 4, "to many numbers")
  if index == 1 then
    SNVID = tonumber(value)
  elseif index == 2 then
    timeStamp = tonumber(value)
  else
    messageID = tonumber(value)
  end
  index = index + 1
end
function packageTemplate:ownershipRequest(fromPlayer, message)
  index = 1
  SNVID = false
  timeStamp = false
  messageID = false
  string.gsub(message, "(.-),", fillOwnershipRequestData)
  if validTime(timeStamp, self.timeStamp) and vehicleManager.vehiclesBySNVID[SNVID] and (not self.owner or self.timeStamp + invulnerabilityTime < timeStamp) and (not self.owner or self.owner ~= vehicleManager.vehiclesBySNVID[SNVID]) then
    self:setOwner(vehicleManager.vehiclesBySNVID[SNVID], fromPlayer.playerID)
  else
    sendPlayerResponse(fromPlayer, 32, tostring(messageID))
  end
end
local function fillDropRequestData(value)
  assert(index < 3, "to many numbers")
  if index == 1 then
    timeStamp = tonumber(value)
  else
    messageID = tonumber(value)
  end
  index = index + 1
end
function packageTemplate:dropRequest(fromPlayer, message)
  index = 1
  timeStamp = false
  messageID = false
  string.gsub(message, "(.-),", fillDropRequestData)
  if validTime(timeStamp, self.timeStamp) and self.owner and (not self.playerID or self.playerID == fromPlayer.playerID) then
    if self.owner then
      local dropPosition, dropTime = GameVehicleResource.getSnappedPredictedPosition(self.owner.gameVehicle, 0.3)
      self:packageDropped(dropPosition)
    else
      self:packageDropped()
    end
  else
    sendPlayerResponse(fromPlayer, 32, tostring(messageID))
  end
end
