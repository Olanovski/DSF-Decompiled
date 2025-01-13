module("cardSystem.logic")
missionSetupData = missionSetupData or {}
missionSetupData["Multiplayer tag"] = {}
missionSetupData["Multiplayer tag"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.target = routes.Tag_Start_01.checkpoints[1].position
    spawnPosition.positionA = routes.Tag_Start_01.checkpoints[1].position
    spawnPosition.headingA = routes.Tag_Start_01.checkpoints[1].heading
    spawnPosition.positionB = routes.Tag_Start_01.checkpoints[2].position
    spawnPosition.headingB = routes.Tag_Start_01.checkpoints[2].heading
  end,
  [2] = function(spawnPosition)
    spawnPosition.target = routes.Tag_Start_02.checkpoints[1].position
    spawnPosition.positionA = routes.Tag_Start_02.checkpoints[1].position
    spawnPosition.headingA = routes.Tag_Start_02.checkpoints[1].heading
    spawnPosition.positionB = routes.Tag_Start_02.checkpoints[2].position
    spawnPosition.headingB = routes.Tag_Start_02.checkpoints[2].heading
  end,
  [3] = function(spawnPosition)
    spawnPosition.target = routes.Tag_Start_03.checkpoints[1].position
    spawnPosition.positionA = routes.Tag_Start_03.checkpoints[1].position
    spawnPosition.headingA = routes.Tag_Start_03.checkpoints[1].heading
    spawnPosition.positionB = routes.Tag_Start_03.checkpoints[2].position
    spawnPosition.headingB = routes.Tag_Start_03.checkpoints[2].heading
  end,
  [4] = function(spawnPosition)
    spawnPosition.target = routes.Tag_Start_04.checkpoints[1].position
    spawnPosition.positionA = routes.Tag_Start_04.checkpoints[1].position
    spawnPosition.headingA = routes.Tag_Start_04.checkpoints[1].heading
    spawnPosition.positionB = routes.Tag_Start_04.checkpoints[2].position
    spawnPosition.headingB = routes.Tag_Start_04.checkpoints[2].heading
  end,
  [5] = function(spawnPosition)
    spawnPosition.target = routes.Tag_Start_05.checkpoints[1].position
    spawnPosition.positionA = routes.Tag_Start_05.checkpoints[1].position
    spawnPosition.headingA = routes.Tag_Start_05.checkpoints[1].heading
    spawnPosition.positionB = routes.Tag_Start_05.checkpoints[2].position
    spawnPosition.headingB = routes.Tag_Start_05.checkpoints[2].heading
  end
}
missionSetupData["Multiplayer tag"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
  spawnPosition.positionB = nil
  spawnPosition.headingB = nil
end
missionSetupData["Multiplayer tag"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\MP_Tag01.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    moods = OnlineModeSettings.onlineMoodsDowntown1,
    missionVehicle = {
      vehicleID = 203,
      shader = {
        [0] = 1
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
    routeName = "RouteData\\MP_Tag02.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    moods = OnlineModeSettings.onlineMoodsDowntown2,
    missionVehicle = {
      vehicleID = 203,
      shader = {
        [0] = 1
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
    routeName = "RouteData\\MP_Tag03.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    moods = OnlineModeSettings.onlineMoodsDowntown1,
    missionVehicle = {
      vehicleID = 203,
      shader = {
        [0] = 1
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
    routeName = "RouteData\\MP_Tag04.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    moods = OnlineModeSettings.onlineMoodsSuburbs1,
    missionVehicle = {
      vehicleID = 203,
      shader = {
        [0] = 1
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
    routeName = "RouteData\\MP_Tag05.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeTraffic,
    moods = OnlineModeSettings.onlineMoodsSuburbs2,
    missionVehicle = {
      vehicleID = 203,
      shader = {
        [0] = 1
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
missionSetupData["Multiplayer tag"].usableRouteIndicies = {
  [1] = {2},
  [2] = {1},
  [3] = {5}
}
ssTagScoreLimit = 100
ssTagTimeTrigger = 1.5
local getPackageTaskList = function()
  return {
    [1] = {
      [1] = {
        task = "MP Package Vehicle AI"
      }
    }
  }
end
local getPlayerTaskList = function(param1, param2, param3, agent)
  return {
    [1] = {
      [1] = {
        task = "Payload Tracking",
        specialName = "score",
        dynamicTargets = true,
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player in package vehicle",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = ssTagTimeTrigger}
            },
            {
              goal = "SS payload score event",
              params = {
                audio = "HUD_Online_TagScore_Player_OneShot"
              }
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Payload over",
              params = {value = ssTagScoreLimit}
            }
          }
        },
        HUD = {
          {style = "Tag HUD"}
        }
      },
      [2] = {
        task = "MP Tag Objective Collision",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player in zap by task object",
              params = {value = false}
            },
            {
              goal = "Player in package vehicle",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            },
            {
              goal = "Collided with objective agent",
              params = {value = true}
            }
          }
        }
      },
      [3] = {
        task = "Restrict Player 1 Zap",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "MP is Player 0",
              params = {value = true}
            },
            {
              goal = "Player in package vehicle",
              params = {value = true}
            },
            {
              goal = "Package owner Damage below",
              params = {value = 1}
            },
            {
              goal = "MP Player zap enabled",
              params = {value = true, localID = 0}
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "MP is Player 0",
              params = {value = true}
            },
            {
              goal = "Player in package vehicle",
              params = {value = false}
            },
            {
              goal = "MP Player zap enabled",
              params = {value = false, localID = 0}
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "MP is Player 0",
              params = {value = true}
            },
            {
              goal = "Player in package vehicle",
              params = {value = true}
            },
            {
              goal = "Package owner Damage above",
              params = {value = 1}
            },
            {
              goal = "MP Player zap enabled",
              params = {value = false, localID = 0}
            }
          }
        }
      },
      [4] = {
        task = "Restrict Player 2 Zap",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "MP is Player 0",
              params = {value = false}
            },
            {
              goal = "Player in package vehicle",
              params = {value = true}
            },
            {
              goal = "Package owner Damage below",
              params = {value = 1}
            },
            {
              goal = "MP Player zap enabled",
              params = {value = true, localID = 1}
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "MP is Player 0",
              params = {value = false}
            },
            {
              goal = "Player in package vehicle",
              params = {value = false}
            },
            {
              goal = "MP Player zap enabled",
              params = {value = false, localID = 1}
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "MP is Player 0",
              params = {value = false}
            },
            {
              goal = "Player in package vehicle",
              params = {value = true}
            },
            {
              goal = "Package owner Damage above",
              params = {value = 1}
            },
            {
              goal = "MP Player zap enabled",
              params = {value = false, localID = 1}
            }
          }
        }
      }
    }
  }
end
missionSetupData["Multiplayer tag"].taskCreatorFunctionLookups = {
  ["Objective Team 1"] = getPackageTaskList,
  ["Player Pool"] = getPlayerTaskList
}
missionSetupData["Multiplayer tag"].stepHighlightColours = function(instance)
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
missionSetupData["Multiplayer tag"].missionCompleteData = function()
  if localPlayer.getTaskObject() and localPlayer.getTaskObject().coreData then
    onlineScreenManager.setSSModeCompDataTable(ssTagScoreLimit, 60, 75, 90)
    local instance = localPlayer.getTaskObject().coreData.instance
    if instance then
      for i = 1, 8 do
        local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
        if taskObject and taskObject.namedTasks.score then
          onlineScreenManager.updatePlayerScore(taskObject.coreData.agent.playerID, taskObject.namedTasks.score.networkVars.payload)
        end
      end
    end
  end
end
missionSetupData["Multiplayer tag"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 2,
      spoolStartArea = true,
      gridStyle = 5,
      missionVehicleStyle = 6,
      moodStyle = 2,
      introHUD = "MP Tag Start HUD",
      disableZapOnCompletion = true,
      targetScore = ssTagScoreLimit,
      invunTime = ssTagTimeTrigger,
      gridStagger = 0
    }
  }
end
missionSetupData["Multiplayer tag"].initiate = function(instance)
  if not instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]] then
    local routeIndex = instance.networkVars.routeIndex
    local tagStartPosition = instance.challenge.spawnPositions[routeIndex].positionB
    local tagStartHeading = instance.challenge.spawnPositions[routeIndex].headingB
    local packageActor = instance.challenge.actorPool[OBJ_TEAM_ONE_STRING_TABLE[1]]
    local packageVehicle = vehicleManager.spawnVehicle({
      position = tagStartPosition,
      heading = tagStartHeading,
      modelID = instance.challenge.spawnPositions[routeIndex].missionVehicle.vehicleID,
      shader = instance.challenge.spawnPositions[routeIndex].missionVehicle.shader
    })
    local package = packageManager.createPackage(false, nil, true, nil, packageVehicle, nil, nil, nil, nil, true, nil)
    instance:newActorFromAgent(OBJ_TEAM_ONE_STRING_TABLE[1], package)
  end
end
missionSetupData["Multiplayer tag"].missionStart = function(instance)
  local tagTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  MPZapToAction.setZapToAction(2, tagTO.coreData.agent)
  packageManager.setInvulnerabilityTime(instance.challenge.settings.invunTime)
  packageManager.setlockOwnerInPackageType(true)
end
missionSetupData["Multiplayer tag"].modeReadyCheck = function(instance)
  local tagTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  if not tagTO then
    return false
  end
  if tagTO and not tagTO.coreData.agent then
    return false
  end
  return true
end
missionSetupData["Multiplayer tag"].update = function(instance)
  onlineProgressionSystem.progressionUpdate()
end
taskCompleteData = taskCompleteData or {}
taskCompleteData["Multiplayer tag"] = {}
taskCompleteData["Multiplayer tag"].taskComplete = function(taskObject, task)
  if taskObject.coreData.actor.playerTaskObject and task.taskName == "Payload Tracking" then
    phaseManager.modeTimedOut = false
    if task.success then
      local instance = taskObject.coreData.instance
      MPZapToAction.reset()
      if instance.isLocal then
        instance:initiateOverTimePhase()
      end
    end
  end
end
local getPlayerDynamicTargets = function(taskObject, task, dynamicListID)
  return {
    task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  }, false
end
missionSetupData["Multiplayer tag"].targetList = {
  ["Player Pool"] = getPlayerDynamicTargets
}
