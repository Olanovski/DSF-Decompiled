module("cardSystem.logic")
missionSetupData["Multiplayer trail blazer"] = {}
ssTrailScoreLimit = 100
ssTrailTimeTrigger = 1
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
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    missionVehicle = {
      vehicleID = 171,
      shader = {
        [0] = 0
      }
    },
    playerOneVehicle = {
      vehicleID = 62,
      shader = {
        [0] = 0
      }
    },
    playerTwoVehicle = {
      vehicleID = 176,
      shader = {
        [0] = 1
      }
    },
    spoolableVehicles = {
      [1] = 62,
      [2] = 176
    }
  },
  [2] = {
    modeRouteName = "MP_Trailblazer_Route_02",
    routeName = "RouteData\\MP_Trailblazer02.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    moods = OnlineModeSettings.onlineMoodsDowntown1,
    missionVehicle = {
      vehicleID = 171,
      shader = {
        [0] = 0
      }
    },
    playerOneVehicle = {
      vehicleID = 62,
      shader = {
        [0] = 0
      }
    },
    playerTwoVehicle = {
      vehicleID = 176,
      shader = {
        [0] = 1
      }
    },
    spoolableVehicles = {
      [1] = 62,
      [2] = 176
    }
  },
  [3] = {
    modeRouteName = "MP_Trailblazer_Route_03",
    routeName = "RouteData\\MP_Trailblazer03.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    moods = OnlineModeSettings.onlineMoodsSuburbs1,
    missionVehicle = {
      vehicleID = 171,
      shader = {
        [0] = 0
      }
    },
    playerOneVehicle = {
      vehicleID = 62,
      shader = {
        [0] = 0
      }
    },
    playerTwoVehicle = {
      vehicleID = 176,
      shader = {
        [0] = 1
      }
    },
    spoolableVehicles = {
      [1] = 62,
      [2] = 176
    }
  },
  [4] = {
    modeRouteName = "MP_Trailblazer_Route_04",
    routeName = "RouteData\\MP_Trailblazer04.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    moods = OnlineModeSettings.onlineMoodsNatural2,
    missionVehicle = {
      vehicleID = 171,
      shader = {
        [0] = 0
      }
    },
    playerOneVehicle = {
      vehicleID = 62,
      shader = {
        [0] = 0
      }
    },
    playerTwoVehicle = {
      vehicleID = 176,
      shader = {
        [0] = 1
      }
    },
    spoolableVehicles = {
      [1] = 62,
      [2] = 176
    }
  },
  [5] = {
    modeRouteName = "MP_Trailblazer_Route_05",
    routeName = "RouteData\\MP_Trailblazer05.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    moods = OnlineModeSettings.onlineMoodsSuburbs2,
    missionVehicle = {
      vehicleID = 171,
      shader = {
        [0] = 0
      }
    },
    playerOneVehicle = {
      vehicleID = 62,
      shader = {
        [0] = 0
      }
    },
    playerTwoVehicle = {
      vehicleID = 176,
      shader = {
        [0] = 1
      }
    },
    spoolableVehicles = {
      [1] = 62,
      [2] = 176
    }
  }
}
missionSetupData["Multiplayer trail blazer"].usableRouteIndicies = {
  [1] = {5},
  [2] = {2},
  [3] = {3}
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
              goal = "Payload over",
              params = {value = ssTrailScoreLimit}
            }
          }
        },
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = ssTrailTimeTrigger}
            },
            {
              goal = "Within blaze",
              params = {agent = agent}
            },
            {
              goal = "SS payload score event",
              params = {
                audio = "HUD_Online_TagScore_Player_OneShot"
              }
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
missionSetupData["Multiplayer trail blazer"].stepHighlightColours = function(instance)
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
missionSetupData["Multiplayer trail blazer"].missionCompleteData = function()
  if localPlayer.getTaskObject() and localPlayer.getTaskObject().coreData then
    local instance = localPlayer.getTaskObject().coreData.instance
    onlineScreenManager.setSSModeCompDataTable(ssTrailScoreLimit, 60, 75, 90)
    if instance then
      for i = 1, 8 do
        local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
        if taskObject and taskObject.namedTasks.score then
          local score = taskObject.namedTasks.score.networkVars.payload
          if score > ssTrailScoreLimit then
            score = ssTrailScoreLimit
          end
          onlineScreenManager.updatePlayerScore(taskObject.coreData.agent.playerID, score)
        end
      end
    end
  end
end
missionSetupData["Multiplayer trail blazer"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 2,
      gridStyle = 5,
      missionVehicleStyle = 6,
      moodStyle = 2,
      introHUD = "MP Trail Blazer Start HUD",
      disableZapOnCompletion = true,
      targetScore = ssTrailScoreLimit,
      gridStagger = 0
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
      heading = instance.challenge.spawnPositions[routeIndex].headingB,
      shader = instance.challenge.spawnPositions[routeIndex].missionVehicle.shader
    })
    instance:newActorFromAgent(trailBlazerActor.ID, trailBlazerVehicle)
  end
end
missionSetupData["Multiplayer trail blazer"].missionStart = function(instance)
  local blazingTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  GameVehicleResource.setInfiniteMass(blazingTO.coreData.agent.gameVehicle, true)
  myVehicle = nil
  teammateVehicle = nil
  MPZapToAction.setZapToAction(1, blazingTO.coreData.agent)
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
    MPZapToAction.reset()
    local vehicleTO = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    GameVehicleResource.setInfiniteMass(vehicleTO.coreData.agent.gameVehicle, false)
    if instance.isLocal then
      instance:initiateOverTimePhase()
    end
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
