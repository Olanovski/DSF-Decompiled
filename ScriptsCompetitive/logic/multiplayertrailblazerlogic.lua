module("cardSystem.logic")
missionSetupData["Multiplayer trail blazer"] = {}
mpTrailTimeLimit = 300
mpTrailScoreLimit = 100
mpTrailTimeTrigger = 1
missionSetupData["Multiplayer trail blazer"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.target = routes.MP_Trailblazer_Spawn_01.checkpoints[1].position
    spawnPosition.positionA = routes.MP_Trailblazer_Spawn_01.checkpoints[1].position
    spawnPosition.headingA = routes.MP_Trailblazer_Spawn_01.checkpoints[1].heading
    spawnPosition.positionB = routes.MP_Trailblazer_Spawn_01.checkpoints[2].position
    spawnPosition.headingB = routes.MP_Trailblazer_Spawn_01.checkpoints[2].heading
  end,
  [2] = function(spawnPosition)
    spawnPosition.target = routes.MP_Trailblazer_Spawn_02.checkpoints[1].position
    spawnPosition.positionA = routes.MP_Trailblazer_Spawn_02.checkpoints[1].position
    spawnPosition.headingA = routes.MP_Trailblazer_Spawn_02.checkpoints[1].heading
    spawnPosition.positionB = routes.MP_Trailblazer_Spawn_02.checkpoints[2].position
    spawnPosition.headingB = routes.MP_Trailblazer_Spawn_02.checkpoints[2].heading
  end,
  [3] = function(spawnPosition)
    spawnPosition.target = routes.MP_Trailblazer_Spawn_03.checkpoints[1].position
    spawnPosition.positionA = routes.MP_Trailblazer_Spawn_03.checkpoints[1].position
    spawnPosition.headingA = routes.MP_Trailblazer_Spawn_03.checkpoints[1].heading
    spawnPosition.positionB = routes.MP_Trailblazer_Spawn_03.checkpoints[2].position
    spawnPosition.headingB = routes.MP_Trailblazer_Spawn_03.checkpoints[2].heading
  end,
  [4] = function(spawnPosition)
    spawnPosition.target = routes.MP_Trailblazer_Spawn_04.checkpoints[1].position
    spawnPosition.positionA = routes.MP_Trailblazer_Spawn_04.checkpoints[1].position
    spawnPosition.headingA = routes.MP_Trailblazer_Spawn_04.checkpoints[1].heading
    spawnPosition.positionB = routes.MP_Trailblazer_Spawn_04.checkpoints[2].position
    spawnPosition.headingB = routes.MP_Trailblazer_Spawn_04.checkpoints[2].heading
  end,
  [5] = function(spawnPosition)
    spawnPosition.target = routes.MP_Trailblazer_Spawn_05.checkpoints[1].position
    spawnPosition.positionA = routes.MP_Trailblazer_Spawn_05.checkpoints[1].position
    spawnPosition.headingA = routes.MP_Trailblazer_Spawn_05.checkpoints[1].heading
    spawnPosition.positionB = routes.MP_Trailblazer_Spawn_05.checkpoints[2].position
    spawnPosition.headingB = routes.MP_Trailblazer_Spawn_05.checkpoints[2].heading
  end,
  [6] = function(spawnPosition)
    spawnPosition.target = routes.MP_Trailblazer_Spawn_06.checkpoints[1].position
    spawnPosition.positionA = routes.MP_Trailblazer_Spawn_06.checkpoints[1].position
    spawnPosition.headingA = routes.MP_Trailblazer_Spawn_06.checkpoints[1].heading
    spawnPosition.positionB = routes.MP_Trailblazer_Spawn_06.checkpoints[2].position
    spawnPosition.headingB = routes.MP_Trailblazer_Spawn_06.checkpoints[2].heading
  end,
  [7] = function(spawnPosition)
    spawnPosition.target = routes.MP_Trailblazer_Spawn_07.checkpoints[1].position
    spawnPosition.positionA = routes.MP_Trailblazer_Spawn_07.checkpoints[1].position
    spawnPosition.headingA = routes.MP_Trailblazer_Spawn_07.checkpoints[1].heading
    spawnPosition.positionB = routes.MP_Trailblazer_Spawn_07.checkpoints[2].position
    spawnPosition.headingB = routes.MP_Trailblazer_Spawn_07.checkpoints[2].heading
  end
}
missionSetupData["Multiplayer trail blazer"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.roads = nil
  spawnPosition.route = nil
  spawnPosition.arrows = nil
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
end
missionSetupData["Multiplayer trail blazer"].spawnPositions = {
  [1] = {
    modeRouteName = "MP_Trailblazer_Route_01",
    routeName = "RouteData\\MP_Trailblazer01.lua",
    moods = OnlineModeSettings.onlineMoodsDowntown1,
    frequenceAndVehicles = {
      [1] = {
        trafficSet = 4,
        trafficFrequency = 0,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic01
      },
      [2] = {
        trafficSet = 4,
        trafficFrequency = 1,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic02
      },
      [3] = {
        trafficSet = 4,
        trafficFrequency = 2,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic03
      }
    },
    missionVehicle = {
      vehicleID = 171,
      shader = {
        [0] = 0
      }
    }
  },
  [2] = {
    modeRouteName = "MP_Trailblazer_Route_02",
    routeName = "RouteData\\MP_Trailblazer02.lua",
    moods = OnlineModeSettings.onlineMoodsSuburbs1,
    frequenceAndVehicles = {
      [1] = {
        trafficSet = 4,
        trafficFrequency = 0,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic01
      },
      [2] = {
        trafficSet = 4,
        trafficFrequency = 1,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic02
      },
      [3] = {
        trafficSet = 4,
        trafficFrequency = 2,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic03
      }
    },
    missionVehicle = {
      vehicleID = 171,
      shader = {
        [0] = 0
      }
    }
  },
  [3] = {
    modeRouteName = "MP_Trailblazer_Route_03",
    routeName = "RouteData\\MP_Trailblazer03.lua",
    moods = OnlineModeSettings.onlineMoodsNatural2,
    frequenceAndVehicles = {
      [1] = {
        trafficSet = 4,
        trafficFrequency = 0,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic01
      },
      [2] = {
        trafficSet = 4,
        trafficFrequency = 1,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic02
      },
      [3] = {
        trafficSet = 4,
        trafficFrequency = 2,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic03
      }
    },
    missionVehicle = {
      vehicleID = 171,
      shader = {
        [0] = 0
      }
    }
  },
  [4] = {
    modeRouteName = "MP_Trailblazer_Route_04",
    routeName = "RouteData\\MP_Trailblazer04.lua",
    moods = OnlineModeSettings.onlineMoodsSuburbs2,
    frequenceAndVehicles = {
      [1] = {
        trafficSet = 4,
        trafficFrequency = 0,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic01
      },
      [2] = {
        trafficSet = 4,
        trafficFrequency = 1,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic02
      },
      [3] = {
        trafficSet = 4,
        trafficFrequency = 2,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic03
      }
    },
    missionVehicle = {
      vehicleID = 171,
      shader = {
        [0] = 0
      }
    }
  },
  [5] = {
    modeRouteName = "MP_Trailblazer_Route_05",
    routeName = "RouteData\\MP_Trailblazer05.lua",
    moods = OnlineModeSettings.onlineMoodsMarin,
    frequenceAndVehicles = {
      [1] = {
        trafficSet = 4,
        trafficFrequency = 0,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic01
      },
      [2] = {
        trafficSet = 4,
        trafficFrequency = 1,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic02
      },
      [3] = {
        trafficSet = 4,
        trafficFrequency = 2,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic03
      }
    },
    missionVehicle = {
      vehicleID = 171,
      shader = {
        [0] = 0
      }
    }
  },
  [6] = {
    modeRouteName = "MP_Trailblazer_Route_06",
    routeName = "RouteData\\MP_Trailblazer06.lua",
    moods = OnlineModeSettings.onlineMoodsFreeway,
    frequenceAndVehicles = {
      [1] = {
        trafficSet = 4,
        trafficFrequency = 0,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic01
      },
      [2] = {
        trafficSet = 4,
        trafficFrequency = 1,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic02
      },
      [3] = {
        trafficSet = 4,
        trafficFrequency = 2,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic03
      }
    },
    missionVehicle = {
      vehicleID = 171,
      shader = {
        [0] = 0
      }
    }
  },
  [7] = {
    modeRouteName = "MP_Trailblazer_Route_07",
    routeName = "RouteData\\MP_Trailblazer07.lua",
    moods = OnlineModeSettings.onlineMoodsDowntown2,
    frequenceAndVehicles = {
      [1] = {
        trafficSet = 4,
        trafficFrequency = 0,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic01
      },
      [2] = {
        trafficSet = 4,
        trafficFrequency = 1,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic02
      },
      [3] = {
        trafficSet = 4,
        trafficFrequency = 2,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic03
      }
    },
    missionVehicle = {
      vehicleID = 171,
      shader = {
        [0] = 0
      }
    }
  }
}
missionSetupData["Multiplayer trail blazer"].usableRouteIndicies = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 7
}
local blazingVehicleTasks = function()
  return {
    [1] = {
      [1] = {
        task = "Follow Route From Route Index"
      }
    }
  }
end
local playerTask = function(param1, param2, param3, agent)
  return {
    [1] = {
      [1] = {
        task = "Payload Tracking",
        specialName = "score",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Instance start time valid"
            },
            {
              goal = "Instance time above",
              params = {value = mpTrailTimeLimit}
            }
          },
          {
            {
              goal = "Payload over",
              params = {value = mpTrailScoreLimit}
            }
          }
        },
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = mpTrailTimeTrigger}
            },
            {
              goal = "Within blaze",
              params = {agent = agent}
            }
          }
        },
        HUD = {
          {
            style = "MP Trail Blazer HUD"
          }
        }
      }
    }
  }
end
missionSetupData["Multiplayer trail blazer"].taskCreatorFunctionLookups = {
  ["Objective Team 1"] = blazingVehicleTasks,
  ["Player Pool"] = playerTask
}
missionSetupData["Multiplayer trail blazer"].onlineProgressionData = {
  localPlayer = {
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.trailblazerTrailsXPS,
        completeText = "ID:186778",
        minShowXP = 35
      },
      {
        goal = "Payload increased timed",
        params = {}
      }
    },
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.trailblazerAttackXP,
        completeText = "ID:186779",
        minShowXP = 0
      },
      {
        goal = "Damaged opponent within radius of objective",
        params = {
          radius = 50,
          cooldown = onlineProgressionSystem.trailblazerAttackCD,
          minForce = 3500
        }
      }
    },
    getMatchBonus = function(timeInMode, threshold, baseXPValue, gainedXP)
      local matchBonus = timeInMode * baseXPValue
      if gainedXP < threshold then
        return math.max(gainedXP / threshold, onlineProgressionSystem.minimumPercentMatchBonus) * matchBonus
      end
      return matchBonus
    end
  }
}
local myVehicle, teammateVehicle
missionSetupData["Multiplayer trail blazer"].stepHighlightColours = function(instance)
  if not instance.playerVehicles then
    instance.playerVehicles = {}
    for playerID, player in next, playerManager.players, nil do
      Menu.SetPlayerColour(player.playerID, OnlineModeSettings.pink128)
    end
  end
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    local vehicle = taskObject.coreData.agent
    if vehicle.SNVID and not vehicle.colourSet then
      vehicle:disableDisplay(false)
      vehicle:setDisplayColour(OnlineModeSettings.yellow32, OnlineModeSettings.yellow128)
    end
  end
  for SNVID, data in next, instance.playerVehicles, nil do
    if not vehicleManager.vehiclesBySNVID[SNVID] then
      instance.playerVehicles[SNVID] = nil
    end
  end
  for playerID, player in next, playerManager.players, nil do
    if player.currentVehicle and playerID ~= localPlayer.playerID then
      if not instance.playerVehicles[player.currentVehicle.SNVID] then
        instance.playerVehicles[player.currentVehicle.SNVID] = {
          ID = player.playerID
        }
        player.currentVehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
      elseif instance.playerVehicles[player.currentVehicle.SNVID].ID ~= player.playerID then
        instance.playerVehicles[player.currentVehicle.SNVID].ID = player.playerID
        player.currentVehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
      end
    end
  end
  for i = 1, 8 do
    local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
    if taskObject and not taskObject.playerTagSet then
      local playerID = i - 1
      local player = playerManager.players[playerID]
      if player then
        if player.playerID == localPlayer.playerID then
          Menu.SetPlayerColour(player.playerID, OnlineModeSettings.blue128)
          taskObject.playerTagSet = true
        else
          Menu.SetPlayerColour(player.playerID, OnlineModeSettings.red128)
          taskObject.playerTagSet = true
        end
      end
    end
  end
end
missionSetupData["Multiplayer trail blazer"].onlineStatisticsData = function(syncedScoreTable)
  assert(syncedScoreTable[localPlayer.playerID], "players score not found in synced score table")
  onlineStatistics.updateSpecificStatistic(syncedScoreTable[localPlayer.playerID])
  onlineStatistics.updateScoreStatistic(onlineProgressionSystem.getLocalPlayerXPGained())
end
missionSetupData["Multiplayer trail blazer"].missionCompleteData = function(instance, syncedScoreTable)
  for playerID, player in next, playerManager.players, nil do
    assert(syncedScoreTable[playerID], "players score not found in synced score table")
    onlineScreenManager.updatePlayerScore(playerID, syncedScoreTable[playerID])
  end
  local results = onlineScreenManager.getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.score)
  onlineScreenManager.setForceSortType(false)
  onlineScreenManager.setRaceCompleteData(false)
  for i, player in ipairs(results) do
    assert(player, "Player not found, an error in sorting of players in onlineScreenManager.getScreenCurrentPlayerTable. i = " .. tostring(i) .. " #results = " .. tostring(results) .. " numPlayers = " .. tostring(playerManager.numberOfPlayers))
    if i == 1 then
      if player.id == localPlayer.playerID then
        onlineProgressionSystem.progressionMissionComplete(true)
        onlineStatistics.updateWinStatistic(1)
        onlineStatistics.updateModeProfileWinStatistic("MP trail blazer")
      else
        onlineProgressionSystem.progressionMissionComplete(false)
        onlineStatistics.updateLossStatistic(1)
      end
    end
    if player.id == localPlayer.playerID then
      onlineStatistics.updatePlayerLastPositionInMode("MP trail blazer", i)
      break
    end
  end
end
missionSetupData["Multiplayer trail blazer"].getLocalPlayerFinalScore = function()
  local playerTO = localPlayer.getTaskObject()
  local score = playerTO and playerTO.namedTasks.score and playerTO.namedTasks.score.networkVars.payload or 0
  if score > mpTrailScoreLimit then
    score = mpTrailScoreLimit
  end
  return score
end
missionSetupData["Multiplayer trail blazer"].getPlayerFinalScore = function(instance, playerID)
  local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[playerID + 1]]
  local score = taskObject and taskObject.namedTasks.score and taskObject.namedTasks.score.networkVars.payload or 0
  if score > mpTrailScoreLimit then
    score = mpTrailScoreLimit
  end
  return score
end
missionSetupData["Multiplayer trail blazer"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 2,
      gridStyle = 1,
      missionVehicleStyle = 2,
      moodStyle = 2,
      introHUD = "MP Trail Blazer Start HUD",
      disableZapOnCompletion = true,
      targetScore = mpTrailScoreLimit,
      modeTimeLimit = mpTrailTimeLimit
    }
  }
end
missionSetupData["Multiplayer trail blazer"].initiate = function(instance)
  if not instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]] then
    local routeIndex = instance.networkVars.routeIndex
    local trailBlazerActor = instance.challenge.actorPool[OBJ_TEAM_ONE_STRING_TABLE[1]]
    local trailBlazerVehicle = vehicleManager.spawnVehicle({
      position = instance.challenge.spawnPositions[routeIndex].positionB,
      modelID = instance.challenge.spawnPositions[routeIndex].missionVehicle.vehicleID,
      heading = instance.challenge.spawnPositions[routeIndex].headingB
    })
    instance:newActorFromAgent(trailBlazerActor.ID, trailBlazerVehicle)
  end
end
missionSetupData["Multiplayer trail blazer"].missionStart = function(instance)
  local blazingTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  MPZapToAction.setZapToAction(1, blazingTO.coreData.agent)
  GameVehicleResource.setInfiniteMass(blazingTO.coreData.agent.gameVehicle, true)
  Network.setTrackedHandle(blazingTO.coreData.agent.SNVID)
  _G.trackVehicle = blazingTO.coreData.agent
  myVehicle = nil
  teammateVehicle = nil
end
missionSetupData["Multiplayer trail blazer"].onPlayerJoinInProgress = function(remotePlayer)
  if not remotePlayer then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243748")
    onlineInstructionSupport.displayPrompt("ID:234257", localPlayer.buttonLayout.zapReturn)
  end
end
missionSetupData["Multiplayer trail blazer"].modeReadyCheck = function(instance)
  local blazingTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  if not blazingTO then
    return false
  end
  if blazingTO and not blazingTO.coreData.agent then
    return false
  end
  return true
end
missionSetupData["Multiplayer trail blazer"].update = function(instance)
  onlineProgressionSystem.progressionUpdate()
end
taskCompleteData["Multiplayer trail blazer"] = {}
taskCompleteData["Multiplayer trail blazer"].taskComplete = function(taskObject, task)
  if task.taskName == "Payload Tracking" then
    local instance = taskObject.coreData.instance
    if task.condition == 1 then
      phaseManager.modeTimedOut = true
    else
      phaseManager.modeTimedOut = false
    end
    MPZapToAction.reset()
    local vehicleTO = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    GameVehicleResource.setInfiniteMass(vehicleTO.coreData.agent.gameVehicle, false)
    instance:initiateOverTimePhase()
  end
end
local getPlayerDynamicTargets = function(taskObject, task, dynamicListID)
  return {
    task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent
  }, false
end
missionSetupData["Multiplayer trail blazer"].targetList = {
  ["Player Pool"] = getPlayerDynamicTargets
}
