module("taskSystem")
local taskObjectTemplate = {}
taskObjectTemplate.__index = taskObjectTemplate
function createTaskObject(instance, actor, agent, isLocal, taskObjectID)
  local taskObject = {
    coreData = {
      isLocal = isLocal,
      taskObjectID = taskObjectID,
      instance = instance,
      instanceID = instance.instanceID,
      actor = actor,
      actorID = actor.networkID,
      agent = agent,
      setAgentTrigger = false,
      flagForDeletion = false
    },
    taskList = {},
    namedTasks = {},
    minorTasks = {},
    initiated = false
  }
  local function createTutorialMajorOrder()
    if instance.challenge.name then
      local challenge, potID, subType, type = progressionSystem.findMissionInProgression(instance.challenge.name)
      if type == "challenge" then
        if subType == "movie" and not ProfileSettings.GetToolTipShown(toolTipLookupTable["Movie Challenge"]) then
          local movieChallengeMajorOrder1 = {
            {
              task = "No AI",
              specialName = "Start Movie Challenge tutorial",
              taskConditions = {
                {
                  {
                    goal = "In cutscene",
                    params = {inverse = true}
                  }
                },
                {
                  {
                    goal = "Tutorial panel active"
                  }
                }
              }
            }
          }
          local movieChallengeMajorOrder2 = {
            {
              task = "No AI",
              specialName = "Wait for tutorial",
              taskConditions = {
                {
                  {
                    goal = "Tutorial panel active",
                    params = {inverse = true}
                  }
                }
              }
            }
          }
          table.insert(taskObject.coreData.actor.taskList, 1, movieChallengeMajorOrder2)
          table.insert(taskObject.coreData.actor.taskList, 1, movieChallengeMajorOrder1)
        elseif subType ~= "movie" and not ProfileSettings.GetToolTipShown(toolTipLookupTable.Challenge) then
          local challengeMajorOrder1 = {
            {
              task = "No AI",
              specialName = "Start Challenge tutorial",
              taskConditions = {
                {
                  {
                    goal = "In cutscene",
                    params = {inverse = true}
                  }
                },
                {
                  {
                    goal = "Tutorial panel active"
                  }
                }
              }
            }
          }
          local challengeMajorOrder2 = {
            {
              task = "No AI",
              specialName = "Wait for tutorial",
              taskConditions = {
                {
                  {
                    goal = "Tutorial panel active",
                    params = {inverse = true}
                  }
                }
              }
            }
          }
          table.insert(taskObject.coreData.actor.taskList, 1, challengeMajorOrder2)
          table.insert(taskObject.coreData.actor.taskList, 1, challengeMajorOrder1)
        end
      elseif instance.challenge.name == "Checkpoint activity 1" and not ProfileSettings.GetToolTipShown(toolTipLookupTable.Activity) then
        local challengeMajorOrder1 = {
          {
            task = "No AI",
            specialName = "Start activity tutorial",
            taskConditions = {
              {
                {
                  goal = "In cutscene",
                  params = {inverse = true}
                }
              },
              {
                {
                  goal = "Tutorial panel active"
                }
              }
            }
          }
        }
        local challengeMajorOrder2 = {
          {
            task = "No AI",
            specialName = "Wait for tutorial",
            taskConditions = {
              {
                {
                  goal = "Tutorial panel active",
                  params = {inverse = true}
                }
              }
            }
          }
        }
        table.insert(taskObject.coreData.actor.taskList, 1, challengeMajorOrder2)
        table.insert(taskObject.coreData.actor.taskList, 1, challengeMajorOrder1)
      end
    end
  end
  if instance.taskList[actor.ID] then
    taskObject.coreData.actor.taskList = instance.taskList[actor.ID](instance.challenge.goalValues, instance.challenge.HUD, instance.challenge.audio, agent, actor.ID)
  else
    taskObject.coreData.actor.taskList = instance.taskList[actor.team](instance.challenge.goalValues, instance.challenge.HUD, instance.challenge.audio, agent, actor.ID)
  end
  if taskObject.coreData.actor.taskList[1][1].specialName == "Wait for countdown" then
    createTutorialMajorOrder()
  end
  if agent.isPlayer then
    taskObject.coreData.agentID = agent.playerID
    taskObject.coreData.agentType = 0
  elseif agent.isVehicle then
    taskObject.coreData.agentID = agent.SNVID
    taskObject.coreData.agentType = 1
  else
    taskObject.coreData.agentID = agent.SNOID
    taskObject.coreData.agentType = 2
  end
  if (gameStatus.onlineSession or gameStatus.splitscreenSession) and agent.isVehicle and actor then
    vehicleManager.applyGeneralVehicleSettings(agent, actor)
    vehicleManager.applyInMissionVehicleSettings(agent, actor)
  end
  taskObject.coreData.__index = taskObject.coreData
  setmetatable(taskObject, taskObjectTemplate)
  if isLocal and not taskObjectID then
    taskObject.coreData.taskObjectID = createSNOFromObject(taskObject)
  end
  taskObjects[taskObject.coreData.taskObjectID] = taskObject
  if agent.isVehicle then
    if agent.isLocal then
      agent.networkVars.taskObjectID = taskObject.coreData.taskObjectID
    end
    if actor.hasPreview and (instance.isChallenge or not instance.isChallenge and not localPlayer.challenge.retryingMission) then
      zapcontroller.AddChallengeVehicle({
        gameVehicle = agent.gameVehicle
      })
      GameVehicleResource.registerAttachCallback(vehicleManager.noTowCallback, agent.gameVehicle)
    end
  elseif agent.isPackage then
    agent.taskObjectID = taskObject.coreData.taskObjectID
  end
  instance:registerLinkedObject(taskObject.coreData.taskObjectID, 1)
  instance.taskObjectsByActorID[taskObject.coreData.actor.ID] = taskObject
  if instance.startActor then
    local missionMarkers = instance.challenge.missionMarkers
    if missionMarkers then
      for k, v in next, missionMarkers, nil do
        if taskObject.coreData.actor.ID == v.cardName then
          taskObject.coreData.actor.markerType = v.value
        end
      end
    end
  end
  if agent.isPlayer then
    if agent.isLocal then
      agent.missionSupport:setInstanceHook(instance)
      agent.missionSupport:setMainTaskObject(taskObject)
    end
    SNO.setMigrationType(taskObject.coreData.taskObjectID, 0)
  else
    if taskObject.coreData.actor.taskList.enableNonPlayerFeedback then
      feedbackSystem.taskSupport.addTaskObjectHook(taskObject)
      feedbackSystem.taskSupport.setTaskObjectDisplayType(taskObject, 7)
    end
    SNO.setMigrationType(taskObject.coreData.taskObjectID, 1)
  end
  if taskObject.coreData.actor.restrictionInfo then
    registerRestrictedObject(taskObject)
  end
  if taskObject.coreData.actor.taskList.networkFunctions then
    taskObject.networkFunctions = taskObject.coreData.actor.taskList.networkFunctions
  end
  if taskObject.coreData.instance == localPlayer.missionSupport:getHookedMission() then
    feedbackSystem.taskSupport.instanceUpdateEvent()
  end
  NetworkLog.Write(">[LUA] TASKSYSTEM - TaskObject built, SNOID = " .. tostring(taskObject.coreData.taskObjectID) .. ", local = " .. tostring(taskObject.coreData.isLocal) .. ", agentType = " .. tostring(taskObject.coreData.agentType) .. ", agentID = " .. (taskObject.coreData.agentType == 0 and taskObject.coreData.agent.playerID or taskObject.coreData.agentType == 1 and taskObject.coreData.agent.SNVID or taskObject.coreData.agentType == 2 and taskObject.coreData.agent.SNOID) .. ", mission = " .. tostring(taskObject.coreData.instance.challenge.name) .. ", actor = " .. tostring(taskObject.coreData.actor.ID))
  if gameStatus.onlineSession and not gameStatus.splitscreenSession and agent.isPlayer then
    onlineSideBar.addEntry(taskObject, agent.playerID, true)
  end
  return taskObject
end
function taskObjectTemplate:delete(endOfMissionFlag)
  NetworkLog.Write(">[LUA] TASKSYSTEM - TaskObject deleting, SNOID = " .. tostring(self.coreData.taskObjectID) .. ", local = " .. tostring(self.coreData.isLocal) .. ", agentType = " .. tostring(self.coreData.agentType) .. ", agentID = " .. tostring(self.coreData.agentType == 0 and self.coreData.agent.playerID or self.coreData.agentType == 1 and self.coreData.agent.SNVID or self.coreData.agentType == 2 and self.coreData.agent.SNOID) .. ", mission = " .. tostring(self.coreData.instance.challenge.name) .. ", actor = " .. tostring(self.coreData.actor.ID))
  if gameStatus.onlineSession and not gameStatus.splitscreenSession and self.coreData.agentType == 0 then
    onlineSideBar.removeEntry(self, self.coreData.agentID)
  end
  for i, taskGroup in next, self.taskList, nil do
    for j, task in ipairs(taskGroup) do
      if not task.stopped then
        stopTask(task)
      end
    end
  end
  self:clearMinorTasks()
  if self.coreData.isLocal then
    assert(SNO.canBeDeleted(self.coreData.taskObjectID), "Not safe to delete taskObject")
    SNO.setMigrationType(self.coreData.taskObjectID, 0)
    SNO.deleteSNO(self.coreData.taskObjectID)
  end
  local agent = self.coreData.agent
  if agent.isVehicle then
    removeMissionSpecifics(agent)
  end
  if self.coreData.instance.raceId then
    RaceManager.RemoveRacer(self.coreData.instance.raceId, agent.gameVehicle)
  end
  if restrictedObjects[self] then
    unregisterRestrictedObject(self)
  end
  if agent.isVehicle then
    zapcontroller.RemoveChallengeVehicle({
      gameVehicle = agent.gameVehicle
    })
    zapcontroller.RemoveLockedVehicle({
      gameVehicle = agent.gameVehicle
    })
    if self.coreData.actor.enableSimulationArea then
      agent:removeSimulationArea()
    end
    agent:set_damageCauseScale(1)
    coolDownVehicles[agent.SNVID] = g_NetworkTime + 1
    local plr = localPlayerManager.getPlayerByGameVehicle(agent.gameVehicle)
    plr = plr or localPlayerManager.getPlayerZappingIntoGameVehicle(agent.gameVehicle)
    if agent.isLocal then
      agent.networkVars.taskObjectID = nil
      if endOfMissionFlag then
        if self.coreData.instance.challenge.settings.disableZapOnCompletion then
          if not plr then
            agent:makeOrphan()
          end
        else
          agent:delete()
        end
      elseif not plr then
        if localPlayer:getTaskObject() and self.coreData.actor.taskList.deleteVehicleOnCompletion then
          agent:delete()
        elseif not agent.debugRequiredVehicles and agent.gameVehicle ~= progressionSystem.getActivityGameVehicle() then
          agent:makeOrphan()
        end
      end
    end
  end
  if agent.isPackage then
    assert(agent:canBeDeleted())
    agent:release()
  end
  self.coreData.instance:unregisterLinkedObject(self.coreData.taskObjectID, 1)
  self.coreData.instance.taskObjectsByActorID[self.coreData.actor.ID] = nil
  for localID, plr in next, localPlayerManager.players, nil do
    if plr.missionSupport:isSubTaskObject(self) then
      plr.missionSupport:removeSubTaskObject(self)
    end
    if plr.missionSupport:getMainTaskObject() == self then
      plr.missionSupport:clearMainTaskObject()
    end
  end
  if self.coreData.actor.taskList.enableNonPlayerFeedback then
    feedbackSystem.taskSupport.releaseTaskObjectHook(self)
  end
  taskObjects[self.coreData.taskObjectID] = nil
  self.coreData.taskObjectID = nil
  for localID, plr in next, localPlayerManager.players, nil do
    if self.coreData.instance == plr.missionSupport:getHookedMission() then
      feedbackSystem.taskSupport.instanceUpdateEvent()
    end
  end
  self.namedTasks = nil
  self.coreData = nil
  self.taskList = nil
  self.minorTasks = nil
  self.networkFunctions = nil
  debugTrackDeletion(self, "taskObject")
end
function taskObjectTemplate:canBeDeleted()
  if self.coreData.isLocal and not SNO.canBeDeleted(self.coreData.taskObjectID) then
    print("taskObjectTemplate " .. tostring(self.coreData.taskObjectID) .. " canBeDeleted: false because instance is local but migration is in progress")
    return false
  end
  local agent = self.coreData.agent
  if agent and agent.isLocal and agent.isVehicle and not agent:canBeDeleted() then
    print("taskObjectTemplate " .. tostring(self.coreData.taskObjectID) .. " canBeDeleted: false because agent SNV " .. tostring(agent.SNVID) .. " is local but migration is in progress")
    return false
  end
  if agent and agent.isPackage and not agent:canBeDeleted() then
    print("taskObjectTemplate " .. tostring(self.coreData.taskObjectID) .. " canBeDeleted: false because agent package " .. tostring(agent.SNOID) .. " is local but migration is in progress")
    return false
  end
  return true
end
function taskObjectTemplate:initiate()
  if not self.initiated then
    local buffers = SNO.numberOfBuffers(self.coreData.taskObjectID) - 1
    if buffers > 0 then
      for i = 1, buffers do
        processTaskBuffer(self, i)
      end
    elseif self.coreData.isLocal then
      local softSaveData = progressionSystem.getSoftSaveData()
      if softSaveData and softSaveData.infoByActorID[self.coreData.actor.ID] then
        local majorOrderReached = softSaveData.infoByActorID[self.coreData.actor.ID].majorOrder
        if majorOrderReached then
          self:initiateTaskGroup(majorOrderReached)
        end
      else
        self:initiateTaskGroup(1)
      end
    end
    self.initiated = true
  end
end
function taskObjectTemplate:initiateTaskGroup(taskGroupID)
  for i, task in ipairs(self.coreData.actor.taskList[taskGroupID]) do
    if not self.taskList[taskGroupID] or not self.taskList[taskGroupID][i] then
      buildTask(self, taskGroupID, i)
    end
  end
end
function taskObjectTemplate:taskGroupComplete(taskGroupID, forceTaskComplete)
  local taskGroup = self.taskList[taskGroupID]
  taskGroup.allComplete = true
  for i, task in ipairs(self.taskList[taskGroupID]) do
    if not task.stopped then
      print("STOPPING UNSTOPPED TASKS: " .. tostring(task.specialName))
      stopTask(task)
    end
  end
  if self.coreData.isLocal then
    if taskGroupID < #self.coreData.actor.taskList and not forceTaskComplete and not localPlayer.challenge.showingEndScreen then
      self:initiateTaskGroup(taskGroupID + 1)
    elseif not self.player and (self.coreData.actor.taskList.deleteTaskObjectOnCompletion or self.coreData.actor.taskList.deleteVehicleOnCompletion or forceTaskComplete) and self:canBeDeleted() then
      self:delete()
    end
  end
end
function taskObjectTemplate:setMinorTasks(taskList)
  for i, taskParams in ipairs(taskList) do
    self.minorTasks[i] = buildMinorTask(self, taskParams)
  end
end
function taskObjectTemplate:clearMinorTasks()
  for i, task in ripairs(self.minorTasks) do
    if not task.stopped then
      stopTask(task)
    end
    self.minorTasks[i] = nil
  end
end
function taskObjectTemplate:refreshAI()
  if self.coreData.agent.isVehicle and self.coreData.agent.isLocal and not self.coreData.agent.controlled then
    for i, taskGroup in next, self.taskList, nil do
      if not taskGroup.allComplete then
        for j, task in ipairs(taskGroup) do
          if not task.complete and task.AIUpdate then
            task.AIUpdate(true)
          end
        end
      end
    end
  end
end
function taskObjectTemplate:refreshMinorTaskAI()
  if self.coreData.agent.isVehicle and self.coreData.agent.isLocal and not self.coreData.agent.controlled then
    for i, task in ipairs(self.minorTasks) do
      if task.AIUpdate then
        task.AIUpdate(true)
      end
    end
  end
end
function taskObjectTemplate:setAgent(newAgent)
  NetworkLog.Write(">[LUA] TASKSYSTEM - Set agent on taskObjectID = " .. tostring(self.coreData.taskObjectID) .. " isLocal = " .. tostring(self.coreData.isLocal) .. ", Old agent taskObjectID = " .. tostring(self.coreData.agent.networkVars.taskObjectID) .. " SNVID = " .. tostring(self.coreData.agent.SNVID) .. " isLocal = " .. tostring(self.coreData.agent.isLocal) .. ", New agent taskObjectID = " .. tostring(newAgent.networkVars.taskObjectID) .. " SNVID = " .. tostring(newAgent.SNVID) .. " isLocal = " .. tostring(newAgent.isLocal))
  local oldAgent = self.coreData.agent
  if newAgent ~= oldAgent then
    assert(newAgent.isPlayer == oldAgent.isPlayer, "TASKSYSTEM - setAgent: Agents being set have mis-matching isPlayer flags. Old = " .. tostring(oldAgent.isPlayer) .. ", new = " .. tostring(newAgent.isPlayer))
    self:releaseObject()
    self.coreData.agent = newAgent
    if restrictedObjects[self] then
      setAgentUpdateRestriction(self, oldAgent)
    end
    if newAgent.isPlayer then
      self.coreData.agentID = newAgent.playerID
      SNO.setMigrationType(self.coreData.taskObjectID, 0)
    else
      self.coreData.agentID = newAgent.SNVID
      SNO.setMigrationType(self.coreData.taskObjectID, 1)
    end
    if self.coreData.isLocal then
      updateSNOFromObject(self, true)
      self:claimObject()
      self.coreData.setAgentTrigger = true
      goalSystem.update()
      self.coreData.setAgentTrigger = false
    end
    if oldAgent.isVehicle then
      if oldAgent.isLocal then
        oldAgent.networkVars.taskObjectID = nil
      end
      removeMissionSpecifics(oldAgent)
      zapcontroller.RemoveLockedVehicle({
        gameVehicle = oldAgent.gameVehicle
      })
      zapcontroller.RemoveChallengeVehicle({
        gameVehicle = oldAgent.gameVehicle
      })
      oldAgent:set_damageMultiplier(1)
      oldAgent:set_damageCauseScale(1)
      coolDownVehicles[oldAgent.SNVID] = g_NetworkTime + 1
    end
    if newAgent.isVehicle then
      if newAgent.isLocal then
        newAgent.networkVars.taskObjectID = self.coreData.taskObjectID
      end
      if self.coreData.actor.damageMultiplier then
        newAgent:set_damageMultiplier(self.coreData.actor.damageMultiplier)
      end
      if self.coreData.actor.damageCauseScale then
        newAgent:set_damageCauseScale(self.coreData.actor.damageCauseScale)
      end
      if self.coreData.actor then
        vehicleManager.applyInMissionVehicleSettings(newAgent, self.coreData.actor)
      end
    end
    self:refreshAI()
    self:refreshMinorTaskAI()
    if self.coreData.instance == localPlayer.missionSupport:getHookedMission() then
      feedbackSystem.taskSupport.instanceUpdateEvent()
    end
  end
end
function taskObjectTemplate:isRestricted(accessType)
  local restrictionInfo = self.coreData.actor.restrictionInfo
  if restrictionInfo.noZapInOut then
    if accessType == 0 or accessType == 2 and (not self.coreData.agent.owner or not self.coreData.agent.owner.controlled) then
      return true
    else
      return false
    end
  end
  if accessType == 2 then
    return true
  end
  if restrictionInfo.noWeaponEffect then
    if accessType == 0 then
      return true
    else
      return 2
    end
  end
  local playerTaskObject = localPlayer:getTaskObject()
  if restrictionInfo.friendlyTeamOnly or restrictionInfo.hostileTeamOnly then
    local playerTeam = playerTaskObject and "Objective Team " .. PlayerGamePlay.getPlayerTeam(playerTaskObject.coreData.agent.playerID)
    if playerTeam then
      if restrictionInfo.friendlyTeamOnly then
        return playerTeam ~= self.coreData.actor.team
      else
        return playerTeam == self.coreData.actor.team
      end
    else
      return true
    end
  elseif restrictionInfo.ownerOnly then
    return not self.namedTasks.owner or self.namedTasks.owner.networkVars.ownerID ~= localPlayer.playerID
  end
  return false
end
function taskObjectTemplate:migrateToLocal()
  NetworkLog.Write(">[LUA] TASKSYSTEM - TaskObject migration take attempt, SNOID = " .. tostring(self.coreData.taskObjectID) .. ", agentType = " .. tostring(self.coreData.agentType) .. ", agentID = " .. (self.coreData.agentType == 0 and self.coreData.agent.playerID or self.coreData.agentType == 1 and self.coreData.agent.SNVID or self.coreData.agentType == 2 and self.coreData.agent.SNOID) .. ", mission = " .. tostring(self.coreData.instance.challenge.name) .. ", actor = " .. tostring(self.coreData.actor.ID))
  local instance = self.coreData.instance
  if instance and not instance.endInstanceWhenWeCan then
    SNO.migrateToLocal(self.coreData.taskObjectID)
  else
    print("taskObjectTemplate:migrateToLocal skip migration as object is being deleted")
  end
end
function taskObjectTemplate:claimObject()
  local highestMajorOrder = 0
  for i, majorOrder in next, self.taskList, nil do
    if i > highestMajorOrder then
      highestMajorOrder = i
    end
  end
  if highestMajorOrder > 0 then
    for i, task in ipairs(self.taskList[highestMajorOrder]) do
      if not task.stopped then
        goalSystem.taskSupport.registerTask(task)
      end
    end
  end
  self:refreshAI()
  self:refreshMinorTaskAI()
end
function taskObjectTemplate:releaseObject()
  for i, taskGroup in next, self.taskList, nil do
    if not taskGroup.allComplete then
      for j, task in ipairs(taskGroup) do
        if not task.stopped then
          if task.cleanup then
            task.cleanup()
          end
          goalSystem.taskSupport.unregisterTask(task)
        end
      end
    end
  end
end
function taskObjectTemplate:failTasks()
  if self.coreData.isLocal then
    for i, taskGroup in next, self.taskList, nil do
      for j, task in ipairs(taskGroup) do
        if not task.complete then
          taskComplete(task, false, 0)
        end
      end
    end
  end
end
function taskObjectTemplate:sendMessage(messageType, message, fromPlayer)
  message = message ~= nil and tostring(message) or ""
  if self.coreData.isLocal then
    if localPlayerManager.numberOfPlayers > 1 then
      self:receiveMessage(fromPlayer, messageType, message)
    else
      self:receiveMessage(localPlayer, messageType, message)
    end
  else
    NetworkLog.WriteDetail(">[LUA] TASKSYSTEM - Sending network message to remote TaskObject, SNOID = " .. tostring(self.coreData.taskObjectID) .. ", agentType = " .. tostring(self.coreData.agentType) .. ", agentID = " .. (self.coreData.agentType == 0 and self.coreData.agent.playerID or self.coreData.agentType == 1 and self.coreData.agent.SNVID or self.coreData.agentType == 2 and self.coreData.agent.SNOID) .. ", mission = " .. tostring(self.coreData.instance.challenge.name) .. ", actor = " .. tostring(self.coreData.actor.ID))
    SNO.sendMessage(self.coreData.taskObjectID, messageType, message)
  end
end
function taskObjectTemplate:receiveMessage(player, messageType, message)
  NetworkLog.WriteDetail(">[LUA] TASKSYSTEM - Receiving network message for TaskObject, SNOID = " .. tostring(self.coreData.taskObjectID) .. ", local = " .. tostring(self.coreData.isLocal) .. ", agentType = " .. tostring(self.coreData.agentType) .. ", agentID = " .. (self.coreData.agentType == 0 and self.coreData.agent.playerID or self.coreData.agentType == 1 and self.coreData.agent.SNVID or self.coreData.agentType == 2 and self.coreData.agent.SNOID) .. ", mission = " .. tostring(self.coreData.instance.challenge.name) .. ", actor = " .. tostring(self.coreData.actor.ID))
  self.networkFunctions[messageType](self, player, message)
end
