module("localPlayer.missionSupport", package.seeall)
hookedMission = false
mainTaskObject = false
subTaskObjects = {}
parent = localPlayer
function setInstanceHook(self, instance)
  if self.hookedMission ~= instance then
    if self.hookedMission then
      self:releaseInstanceHook()
    end
    self.hookedMission = instance
    if not gameStatus.onlineSession then
      setMissionMode(instance)
      activeChallenges.disableActivities()
      abilities.thrillCam.disable()
    end
    for actorID, taskObject in next, self.hookedMission.taskObjectsByActorID, nil do
      if taskObject.coreData.agent.isVehicle then
        zapcontroller.RemoveChallengeVehicle({
          gameVehicle = taskObject.coreData.agent.gameVehicle
        })
      end
    end
    if instance.challenge.onlineProgressionData then
      onlineProgressionSystem.setProgressionData(instance.challenge.onlineProgressionData)
    end
  end
end
function releaseInstanceHook(self)
  assert(self.hookedMission, [[
releaseInstanceHook:
 Attempt to release non-existant instance hook]])
  for i, taskObject in next, self.hookedMission.taskObjectsByActorID, nil do
    if taskObject.coreData.agent.isVehicle then
      zapcontroller.AddChallengeVehicle({
        gameVehicle = taskObject.coreData.agent.gameVehicle
      })
    end
  end
  if gameStatus.onlineSession then
    onlineProgressionSystem.cleanupProgressionData()
  end
  if self.mainTaskObject then
    if not gameStatus.onlineSession then
      setFreedriveMode(self.mainTaskObject)
    end
    self:clearMainTaskObject()
  end
  self:removeAllSubTaskObjects()
  self.hookedMission = false
end
function getHookedMission(self)
  return self.hookedMission
end
function setMainTaskObject(self, taskObject)
  assert(self.hookedMission, [[
setMainTaskObject:
 There is no hooked mission instance]])
  assert(self.hookedMission == taskObject.coreData.instance, [[
setMainTaskObject:
 TaskObject mission instance doesn't match hooked mission instance]])
  if self.mainTaskObject then
    self:clearMainTaskObject()
  end
  self.mainTaskObject = taskObject
  self.mainTaskObject.playerTask = true
  assert(self.mainTaskObject.player == nil)
  self.mainTaskObject.player = self.parent
  localPlayerManagerReflection.setTaskObject(self.mainTaskObject.player.localID, true)
  feedbackSystem.taskSupport.addTaskObjectHook(self.mainTaskObject)
  feedbackSystem.taskSupport.setTaskObjectDisplayType(self.mainTaskObject, 7)
  if not gameStatus.onlineSession then
    RouteArrowsManager.ClearArrows()
  end
  if taskObject.coreData.instance.challenge.showRouteArrows == "All" then
    RouteArrowsManager.AddArrows(localPlayer.localID, taskObject.coreData.instance.raceId, routes[taskObject.coreData.actor.routeName].roads, routes[taskObject.coreData.actor.routeName].arrows)
    RouteArrowsManager.HideArrows(localPlayer.localID, true)
  end
  if taskObject.coreData.actor.routeName and taskObject.coreData.instance.raceId then
    RouteArrowsManager.SetTarget(self.parent.localID, taskObject.coreData.instance.raceId, taskObject.coreData.agent.gameVehicle)
  end
  tannerNarration.disableNarrationManager()
  localPlayer:buildZapReturn()
end
function clearMainTaskObject(self)
  assert(self.mainTaskObject, [[
clearMainTaskObject:
 Attempt to clear non-existant main taskObject]])
  localPlayerManagerReflection.setTaskObject(self.mainTaskObject.player.localID, false)
  feedbackSystem.taskSupport.releaseTaskObjectHook(self.mainTaskObject)
  self.mainTaskObject.playerTask = false
  self.mainTaskObject.player = nil
  self.mainTaskObject = false
end
function getMainTaskObject(self)
  return self.mainTaskObject
end
function addSubTaskObject(self, taskObject, displayType)
  assert(not self.subTaskObjects[taskObject.coreData.taskObjectID], [[
addSubTaskObject:
 Attempt to add subTaskObject that is already present]])
  self.subTaskObjects[taskObject.coreData.taskObjectID] = taskObject
  assert(taskObject.player == nil)
  taskObject.player = self.parent
  feedbackSystem.taskSupport.addTaskObjectHook(taskObject)
  self:setSubTaskObjectDisplayType(taskObject, displayType)
end
function removeSubTaskObject(self, taskObject)
  assert(self.subTaskObjects[taskObject.coreData.taskObjectID], [[
removeSubTaskObject:
 Attempt to remove subTaskObject that is not present]])
  feedbackSystem.taskSupport.releaseTaskObjectHook(taskObject)
  taskObject.player = nil
  self.subTaskObjects[taskObject.coreData.taskObjectID] = nil
end
function removeAllSubTaskObjects(self)
  for taskObjectID, taskObject in next, self.subTaskObjects, nil do
    self:removeSubTaskObject(taskObject)
  end
end
function setSubTaskObjectDisplayType(self, taskObject, displayType)
  assert(self.subTaskObjects[taskObject.coreData.taskObjectID], [[
setSubTaskObjectDisplayType:
 Attempt to set displayType on a subTaskObject that is not present]])
  feedbackSystem.taskSupport.setTaskObjectDisplayType(taskObject, displayType)
end
function isSubTaskObject(self, taskObject)
  return self.subTaskObjects[taskObject.coreData.taskObjectID] ~= nil
end
function setHooksFromVehicle(self, vehicle)
  local taskObject = vehicle:getTaskObject()
  self:setInstanceHook(taskObject.coreData.instance)
  self:setMainTaskObject(taskObject)
  feedbackSystem.menusMaster.setFocusButtonText()
  if taskObject.coreData.instance.challenge.missionMarkers then
    local missionMarkers = cardSystem.formattedMissionData[taskObject.coreData.instance.challenge.name].challenge.missionMarkers
    if missionMarkers then
      for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
        for index, markers in next, missionMarkers, nil do
          if markers.cardName == actorID then
            taskObject.coreData.actor.markerType = markers.value
            break
          end
        end
      end
    end
  end
end
function setMissionMode(instance)
  felony_suspiciousVehicleManager.enableSuspiciousVehicles(false)
  if presenceSystem.Missions[instance.challenge.name] then
    print("Presence set to Playing Mission " .. tostring(presenceSystem.Missions[instance.challenge.name]))
    presenceSystem.setPresence(10, presenceSystem.Missions[instance.challenge.name])
  else
    print("WARNING: Rich presence ID not found for mission " .. tostring(instance.challenge.name))
  end
  if instance.missionType == "mission" then
    feedbackSystem.stopFreeDriveMusic(cards.Missions[instance.challenge.name].MissionID)
  end
  Sound.ExitPreview()
end
function setFreedriveMode()
  local currentProgression = progressionSystem.currentProgression
  local chapter = challengeProgressionTable[currentProgression].settings.chapter
  local blockFreeDriveMusic = false
  if currentProgression <= 9 and not ProfileSettings.GetMissionCompleted(cards.ReverseMissionNetworkLookup["Exposition 06 Law Breaker (cop)"]) or chapter == 8 or chapter == 9 then
    blockFreeDriveMusic = true
  end
  if not blockFreeDriveMusic then
    felony_suspiciousVehicleManager.enableSuspiciousVehicles(true)
    feedbackSystem.startFreeDriveMusic()
  end
  InteractiveIconsManager.clearBuffer()
end
