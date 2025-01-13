module("cardSystem.logic")
missionSetupData["Multiplayer checkpoint rush"] = {}
missionSetupData["Multiplayer checkpoint rush"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.roads = routes["SS Circuit Race 01"].roads
    spawnPosition.route = routes["SS Circuit Race 01"].checkpoints
    spawnPosition.arrows = routes["SS Circuit Race 01"].arrows
    spawnPosition.target = routes["SS Circuit Race Start 01"].checkpoints[1].position
    spawnPosition.positionA = routes["SS Circuit Race Start 01"].checkpoints[1].position
    spawnPosition.headingA = routes["SS Circuit Race Start 01"].checkpoints[1].heading
  end,
  [2] = function(spawnPosition)
    spawnPosition.roads = routes["SS Circuit Race 02"].roads
    spawnPosition.route = routes["SS Circuit Race 02"].checkpoints
    spawnPosition.arrows = routes["SS Circuit Race 02"].arrows
    spawnPosition.target = routes["SS Circuit Race Start 02"].checkpoints[1].position
    spawnPosition.positionA = routes["SS Circuit Race Start 02"].checkpoints[1].position
    spawnPosition.headingA = routes["SS Circuit Race Start 02"].checkpoints[1].heading
  end,
  [3] = function(spawnPosition)
    spawnPosition.roads = routes["SS Circuit Race 03"].roads
    spawnPosition.route = routes["SS Circuit Race 03"].checkpoints
    spawnPosition.arrows = routes["SS Circuit Race 03"].arrows
    spawnPosition.target = routes["SS Circuit Race Start 03"].checkpoints[1].position
    spawnPosition.positionA = routes["SS Circuit Race Start 03"].checkpoints[1].position
    spawnPosition.headingA = routes["SS Circuit Race Start 03"].checkpoints[1].heading
  end
}
missionSetupData["Multiplayer checkpoint rush"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.roads = nil
  spawnPosition.route = nil
  spawnPosition.arrows = nil
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
end
missionSetupData["Multiplayer checkpoint rush"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\SplitScreen_Checkpoint01.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsCoastal,
    trafficSet = 3
  },
  [2] = {
    routeName = "RouteData\\SplitScreen_Checkpoint02.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsMarin,
    trafficSet = 3
  },
  [3] = {
    routeName = "RouteData\\SplitScreen_Checkpoint03.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = OnlineModeSettings.onlineMoodsFreeway,
    trafficSet = 3
  }
}
missionSetupData["Multiplayer checkpoint rush"].usableRouteIndicies = {
  [1] = {1},
  [2] = {2},
  [3] = {3}
}
mpSSCheckpointRushRaceScoreLimit = 100
local bronzeMedal = 60 / mpSSCheckpointRushRaceScoreLimit * 100
local silverMedal = 76 / mpSSCheckpointRushRaceScoreLimit * 100
local goldMedal = 90 / mpSSCheckpointRushRaceScoreLimit * 100
local playerTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "MP Circuit Race Checkpoints",
        specialName = "checkpoints",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "SS Player in shift",
              params = {value = false}
            },
            {
              goal = "MP Checkpoint Tracker"
            },
            {
              goal = "SS checkpoint race score event"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Number of Gates Reached",
              params = {value = true, gateLimit = mpSSCheckpointRushRaceScoreLimit}
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Online Team Checkpoint Gate"] = {}
              }
            }
          }
        },
        HUD = {
          {
            style = "MP Checkpoint Rush HUD"
          }
        }
      },
      [2] = {
        task = "MP Gate Activation",
        goalConditions = {
          {
            {
              goal = "Target same gate",
              params = {value = false}
            },
            {
              goal = "Global on target list",
              params = {value = false}
            }
          }
        }
      },
      [3] = {
        task = "SS Checkpoint Rush Speed Clamp",
        specialName = "speedClamp",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "SS Score Gap Changed",
              params = {minimumChange = 2}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Zap State changed",
              params = {value = true}
            },
            {
              goal = "Zap State changed",
              params = {value = false}
            }
          }
        }
      }
    }
  }
end
local packageTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "MP Team Circuit Race Tracking",
        specialName = "gateTracking"
      }
    },
    ["networkFunctions"] = {
      [1] = function(taskObject, fromPlayer, msgData)
        local checkpointNumber = tonumber(msgData)
        local instance = taskObject.coreData.instance
        if checkpointNumber > taskObject.namedTasks.gateTracking.networkVars.totalCheckPoints then
          taskObject.namedTasks.gateTracking.networkVars.totalCheckPoints = checkpointNumber
          local numCheckPoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
          if checkpointNumber <= numCheckPoints then
            taskObject.namedTasks.gateTracking.networkVars.leadCheckPoint = checkpointNumber
            taskObject.namedTasks.gateTracking.networkVars.leadPlayerID = fromPlayer.playerID
          else
            local number = checkpointNumber
            while numCheckPoints < number do
              number = number - numCheckPoints
            end
            taskObject.namedTasks.gateTracking.networkVars.leadCheckPoint = number
            taskObject.namedTasks.gateTracking.networkVars.leadPlayerID = fromPlayer.playerID
          end
        end
      end
    }
  }
end
missionSetupData["Multiplayer checkpoint rush"].taskCreatorFunctionLookups = {
  ["Objective Team 1"] = packageTasks,
  ["Player Pool"] = playerTasks
}
missionSetupData["Multiplayer checkpoint rush"].stepHighlightColours = function(instance)
  if not instance.playersColours then
    instance.playersColours = {
      [1] = {SNVID = -1},
      [2] = {SNVID = -1}
    }
    Menu.SetPlayerColour(0, OnlineModeSettings.blue128)
    Menu.SetPlayerColour(1, OnlineModeSettings.orange128)
  end
  for playerID, data in next, instance.playersColours, nil do
    if data.SNVID ~= -1 and not vehicleManager.vehiclesBySNVID[data.SNVID] then
      data.SNVID = -1
    end
  end
  for localPlayerID, player in next, localPlayerManager.players, nil do
    if player.currentVehicle and (instance.playersColours[localPlayerID + 1].SNVID == -1 or instance.playersColours[localPlayerID + 1].SNVID ~= player.currentVehicle.SNVID) then
      instance.playersColours[localPlayerID + 1].SNVID = player.currentVehicle.SNVID
      if localPlayerID == 0 then
        player.currentVehicle:setDisplayColour(OnlineModeSettings.blue32, OnlineModeSettings.blue128)
      else
        player.currentVehicle:setDisplayColour(OnlineModeSettings.orange32, OnlineModeSettings.orange128)
      end
    end
  end
end
missionSetupData["Multiplayer checkpoint rush"].missionCompleteData = function()
  local playerTO = localPlayer.getTaskObject()
  if playerTO and playerTO.coreData then
    onlineScreenManager.setSSModeCompDataTable(mpSSCheckpointRushRaceScoreLimit, bronzeMedal, silverMedal, goldMedal)
    local instance = playerTO.coreData.instance
    local taskObject = false
    for i = 1, 2 do
      taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
      if taskObject and taskObject.namedTasks.checkpoints then
        onlineScreenManager.updatePlayerScore(taskObject.coreData.agent.playerID, taskObject.namedTasks.checkpoints.networkVars.checkpointsPassed)
      end
    end
  end
end
missionSetupData["Multiplayer checkpoint rush"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 2,
      spoolStartArea = true,
      gridStyle = 1,
      missionVehicleStyle = 1,
      moodStyle = 1,
      introHUD = "MP Checkpoint Rush Start HUD",
      teamGame = false,
      speedClampMin = 0.8,
      speedClampRate = 0.01,
      gridStagger = 0,
      disableZapOnCompletion = true,
      scoreLimit = mpSSCheckpointRushRaceScoreLimit
    }
  }
end
missionSetupData["Multiplayer checkpoint rush"].initiate = function(instance)
  if not instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]] then
    local package = packageManager.createPackage(false, vec.vector(0, 0, 0, 1), true, 0, nil, nil, nil, nil, 0, true)
    instance:newActorFromAgent(OBJ_TEAM_ONE_STRING_TABLE[1], package)
  end
end
missionSetupData["Multiplayer checkpoint rush"].missionStart = function(instance)
  if not instance.missionStartCalled then
    local routeIndex = instance.networkVars.routeIndex
    local route = instance.challenge.spawnPositions[routeIndex].route
    checkpointSystem.clearNoneSyncronisedCheckpoint()
    for i, checkpointData in ipairs(route) do
      checkpointSystem.createNoneSyncronisedCheckpoint(instance.instanceID, 1, checkpointData)
    end
  end
  for localPlayerID, player in next, localPlayerManager.players, nil do
    checkpointTracker.addTracker(player:getTaskObject(), player.currentVehicle.gameVehicle)
  end
  instance.missionStartCalled = true
end
missionSetupData["Multiplayer checkpoint rush"].modeReadyCheck = function(instance)
  local package = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  if package and package.coreData.agent then
    return true
  end
  return false
end
missionSetupData["Multiplayer checkpoint rush"].update = function(instance)
  local package = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  if package.namedTasks.gateTracking and package.namedTasks.gateTracking.networkVars then
    local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(instance.instanceID, 1)
    local leadCheckpoint = allCheckpoints[package.namedTasks.gateTracking.networkVars.leadCheckPoint].position
    local routeIndex = instance.networkVars.routeIndex
    local leadCheckpointHeading = instance.challenge.spawnPositions[routeIndex].route[package.namedTasks.gateTracking.networkVars.leadCheckPoint].heading
    if not package.rapidShiftTarget then
      package.rapidShiftTarget = leadCheckpoint
    elseif package.rapidShiftTarget ~= leadCheckpoint then
      package.rapidShiftTarget = leadCheckpoint
    end
  end
  if checkpointSystem.isOnlineCheckpointSystemSetup() then
    checkpointSystem.updateOnlineCheckpointScoreTracking()
  else
    checkpointSystem.setupOnlineCheckpointScoreTracking(instance, 1)
  end
end
taskCompleteData["Multiplayer checkpoint rush"] = {}
taskCompleteData["Multiplayer checkpoint rush"].taskComplete = function(taskObject, task)
  localPlayer:blockAbility("zap", false)
  scoreSystem.stopAbilityDrain(localPlayer.localID, false)
  MPZapToAction.reset()
  if taskObject.coreData.instance.isLocal then
    taskObject.coreData.instance:initiateOverTimePhase()
  end
end
local getPlayerDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(taskObject.coreData.instance.instanceID, 1)
  local targetsToAdd = {}
  local targetData = {}
  if dynamicListID then
    local targets = task.dynamicTargets
    local numTargets = #targets
    local targetID = task.networkVars.nextCheckpoint + 1
    local cpData = {
      cpRemove = {},
      lastCheckpoint = 1
    }
    local package = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    local numCheckPoints = #allCheckpoints
    cpData.lastCheckpoint = task.networkVars.nextCheckpoint
    if numTargets > 1 then
      for i = 1, dynamicListID - 1 do
        table.insert(targetData, i)
      end
      cpData.cpRemove = targetData
    end
    if dynamicListID ~= numTargets then
      local nextTarget = targets[dynamicListID + 1].checkpointNum
      task.networkVars.nextCheckpoint = nextTarget
    else
      task.networkVars.nextCheckpoint = targets[dynamicListID].checkpointNum
      if task.networkVars.nextCheckpoint + 1 > #allCheckpoints then
        task.networkVars.nextCheckpoint = 1
      else
        task.networkVars.nextCheckpoint = task.networkVars.nextCheckpoint + 1
      end
      checkpointSystem.resetOnlineCheckpoint(task.networkVars.nextCheckpoint)
      table.insert(targetsToAdd, allCheckpoints[task.networkVars.nextCheckpoint])
    end
    if #targetsToAdd > 0 and #targetData > 0 then
      for i, addCP in ripairs(targetsToAdd) do
        for j, removeCP in ripairs(cpData.cpRemove) do
          if addCP.checkpointNum == targets[removeCP].checkpointNum then
            checkpointSystem.resetOnlineCheckpoint(addCP.checkpointNum)
            table.remove(cpData.cpRemove, j)
            table.remove(targetsToAdd, i)
          end
        end
      end
    end
    return targetsToAdd, cpData
  else
    return {
      allCheckpoints[task.networkVars.nextCheckpoint]
    }, targetData
  end
end
missionSetupData["Multiplayer checkpoint rush"].targetList = {
  ["Player Pool"] = getPlayerDynamicTargets
}
