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
  end,
  [6] = function(spawnPosition)
    spawnPosition.target = routes.Tag_Start_06.checkpoints[1].position
    spawnPosition.positionA = routes.Tag_Start_06.checkpoints[1].position
    spawnPosition.headingA = routes.Tag_Start_06.checkpoints[1].heading
    spawnPosition.positionB = routes.Tag_Start_06.checkpoints[2].position
    spawnPosition.headingB = routes.Tag_Start_06.checkpoints[2].heading
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
    moods = OnlineModeSettings.onlineMoodsDowntown1,
    missionVehicle = {
      vehicleID = 181,
      shader = {
        [0] = 0
      }
    },
    frequenceAndVehicles = {
      [1] = {
        trafficSet = 0,
        trafficFrequency = 0,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic01
      },
      [2] = {
        trafficSet = 0,
        trafficFrequency = 1,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic02
      },
      [3] = {
        trafficSet = 0,
        trafficFrequency = 2,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic03
      }
    }
  },
  [2] = {
    routeName = "RouteData\\MP_Tag02.lua",
    moods = OnlineModeSettings.onlineMoodsDowntown2,
    missionVehicle = {
      vehicleID = 181,
      shader = {
        [0] = 0
      }
    },
    frequenceAndVehicles = {
      [1] = {
        trafficSet = 0,
        trafficFrequency = 0,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic01
      },
      [2] = {
        trafficSet = 0,
        trafficFrequency = 1,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic02
      },
      [3] = {
        trafficSet = 0,
        trafficFrequency = 2,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic03
      }
    }
  },
  [3] = {
    routeName = "RouteData\\MP_Tag03.lua",
    moods = OnlineModeSettings.onlineMoodsDowntown1,
    missionVehicle = {
      vehicleID = 181,
      shader = {
        [0] = 0
      }
    },
    frequenceAndVehicles = {
      [1] = {
        trafficSet = 0,
        trafficFrequency = 0,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic01
      },
      [2] = {
        trafficSet = 0,
        trafficFrequency = 1,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic02
      },
      [3] = {
        trafficSet = 0,
        trafficFrequency = 2,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic03
      }
    }
  },
  [4] = {
    routeName = "RouteData\\MP_Tag04.lua",
    moods = OnlineModeSettings.onlineMoodsSuburbs1,
    missionVehicle = {
      vehicleID = 181,
      shader = {
        [0] = 0
      }
    },
    frequenceAndVehicles = {
      [1] = {
        trafficSet = 0,
        trafficFrequency = 0,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic01
      },
      [2] = {
        trafficSet = 0,
        trafficFrequency = 1,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic02
      },
      [3] = {
        trafficSet = 0,
        trafficFrequency = 2,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic03
      }
    }
  },
  [5] = {
    routeName = "RouteData\\MP_Tag05.lua",
    moods = OnlineModeSettings.onlineMoodsSuburbs2,
    missionVehicle = {
      vehicleID = 181,
      shader = {
        [0] = 0
      }
    },
    frequenceAndVehicles = {
      [1] = {
        trafficSet = 0,
        trafficFrequency = 0,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic01
      },
      [2] = {
        trafficSet = 0,
        trafficFrequency = 1,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic02
      },
      [3] = {
        trafficSet = 0,
        trafficFrequency = 2,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic03
      }
    }
  },
  [6] = {
    routeName = "RouteData\\MP_Tag06.lua",
    moods = OnlineModeSettings.onlineMoodsMarin,
    missionVehicle = {
      vehicleID = 181,
      shader = {
        [0] = 0
      }
    },
    frequenceAndVehicles = {
      [1] = {
        trafficSet = 0,
        trafficFrequency = 0,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic01
      },
      [2] = {
        trafficSet = 0,
        trafficFrequency = 1,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic02
      },
      [3] = {
        trafficSet = 0,
        trafficFrequency = 2,
        vehicleSet = OnlineModeSettings.vehicleTypeTraffic03
      }
    }
  }
}
missionSetupData["Multiplayer tag"].usableRouteIndicies = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6
}
mpTagTimeLimit = 480
mpTagScoreLimit = 100
mpTagTimeTrigger = 1
local invincibleTime = 3
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
              goal = "Localplayer controlling taskObject agent",
              params = {value = true, agent = agent}
            },
            {
              goal = "Time trigger",
              params = {value = mpTagTimeTrigger}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Payload over",
              params = {value = mpTagScoreLimit}
            }
          },
          {
            {
              goal = "Instance start time valid"
            },
            {
              goal = "Instance time above",
              params = {value = mpTagTimeLimit}
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
      }
    }
  }
end
missionSetupData["Multiplayer tag"].taskCreatorFunctionLookups = {
  ["Objective Team 1"] = getPackageTaskList,
  ["Player Pool"] = getPlayerTaskList
}
missionSetupData["Multiplayer tag"].onlineProgressionData = {
  localPlayer = {
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.tagHoldXPS,
        completeText = "ID:186767",
        minShowXP = 30
      },
      {
        goal = "Time controlling taskobject agent",
        params = {value = true}
      }
    },
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.tagTakeXP,
        completeText = "ID:186768",
        minShowXP = 0
      },
      {
        goal = "Local player taken taskobject agent",
        params = {
          value = true,
          cooldown = onlineProgressionSystem.tagTakeCD
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
local lastTaggedVehicleOwnerID = -1
local taggedChange = false
local lastVehicle = false
local colour32, colour128, taggedColour32, taggedColour128, chaserColour32, chaserColour128, myVehicle, teammateVehicle
missionSetupData["Multiplayer tag"].stepHighlightColours = function(instance)
  if not instance.playersColours then
    instance.playersColours = true
    instance.playerVehicles = {}
    lastTaggedVehicleOwnerID = -1
    taggedChange = false
    lastVehicle = false
    for playerID, player in next, playerManager.players, nil do
      Menu.SetPlayerColour(player.playerID, OnlineModeSettings.pink128)
    end
  end
  local packageTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  if packageTO then
    local taggedVehicleOwnerID = -1
    for i = 1, 8 do
      local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
      if taskObject and taskObject.coreData.agent.currentVehicle == packageTO.coreData.agent.owner then
        taggedVehicleOwnerID = i - 1
        break
      end
    end
    if taggedVehicleOwnerID ~= lastTaggedVehicleOwnerID then
      taggedChange = true
    end
    for i = 1, 8 do
      local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
      if taskObject and (not taskObject.playerTagSet or taggedChange) then
        local playerID = i - 1
        local player = playerManager.players[playerID]
        if player then
          if taggedVehicleOwnerID == -1 then
            Menu.SetPlayerColour(player.playerID, OnlineModeSettings.blue128)
            taskObject.playerTagSet = true
          elseif player.playerID == taggedVehicleOwnerID and player.playerID == localPlayer.playerID then
            Menu.SetPlayerColour(player.playerID, OnlineModeSettings.blue128)
            taskObject.playerTagSet = true
          elseif player.playerID == taggedVehicleOwnerID and player.playerID ~= localPlayer.playerID then
            Menu.SetPlayerColour(player.playerID, OnlineModeSettings.red128)
            taskObject.playerTagSet = true
          elseif player.playerID ~= taggedVehicleOwnerID and taggedVehicleOwnerID == localPlayer.playerID then
            Menu.SetPlayerColour(player.playerID, OnlineModeSettings.red128)
            taskObject.playerTagSet = true
          elseif player.playerID ~= taggedVehicleOwnerID and taggedVehicleOwnerID ~= localPlayer.playerID then
            Menu.SetPlayerColour(player.playerID, OnlineModeSettings.blue128)
            taskObject.playerTagSet = true
          end
        end
      end
    end
    for SNVID, data in next, instance.playerVehicles, nil do
      if not vehicleManager.vehiclesBySNVID[SNVID] then
        instance.playerVehicles[SNVID] = nil
      end
    end
    if taggedVehicleOwnerID == localPlayer.playerID then
      taggedColour32 = OnlineModeSettings.blue32
      taggedColour128 = OnlineModeSettings.blue128
      chaserColour32 = OnlineModeSettings.red32
      chaserColour128 = OnlineModeSettings.red128
    elseif taggedVehicleOwnerID == -1 then
      taggedColour32 = OnlineModeSettings.red32
      taggedColour128 = OnlineModeSettings.red128
      chaserColour32 = OnlineModeSettings.blue32
      chaserColour128 = OnlineModeSettings.blue128
    else
      taggedColour32 = OnlineModeSettings.red32
      taggedColour128 = OnlineModeSettings.red128
      chaserColour32 = OnlineModeSettings.blue32
      chaserColour128 = OnlineModeSettings.blue128
    end
    local vehicle = packageTO.coreData.agent.owner
    if vehicle and vehicle.SNVID and not vehicle.colourSet then
      vehicle:disableDisplay(false)
      vehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
    end
    for playerID, player in next, playerManager.players, nil do
      if player.currentVehicle and playerID ~= localPlayer.playerID then
        if player.playerID == taggedVehicleOwnerID then
          colour32 = taggedColour32
          colour128 = taggedColour128
        else
          colour32 = chaserColour32
          colour128 = chaserColour128
        end
        if not instance.playerVehicles[player.currentVehicle.SNVID] then
          instance.playerVehicles[player.currentVehicle.SNVID] = {
            ID = player.playerID
          }
          player.currentVehicle:setDisplayColour(colour32, colour128)
        elseif instance.playerVehicles[player.currentVehicle.SNVID].ID ~= player.playerID then
          instance.playerVehicles[player.currentVehicle.SNVID].ID = player.playerID
          player.currentVehicle:setDisplayColour(colour32, colour128)
        elseif taggedChange and instance.playerVehicles[player.currentVehicle.SNVID].ID == player.playerID then
          player.currentVehicle:setDisplayColour(colour32, colour128)
        end
      end
    end
    taggedChange = false
    lastTaggedVehicleOwnerID = taggedVehicleOwnerID
    lastVehicle = localPlayer.currentVehicle
  end
end
missionSetupData["Multiplayer tag"].onlineStatisticsData = function(syncedScoreTable)
  assert(syncedScoreTable[localPlayer.playerID], "players score not found in synced score table")
  onlineStatistics.updateSpecificStatistic(syncedScoreTable[localPlayer.playerID])
  onlineStatistics.updateScoreStatistic(onlineProgressionSystem.getLocalPlayerXPGained())
end
missionSetupData["Multiplayer tag"].missionCompleteData = function(instance, syncedScoreTable)
  for playerID, player in next, playerManager.players, nil do
    assert(syncedScoreTable[playerID], "players score not found in synced score table")
    onlineScreenManager.updatePlayerScore(playerID, syncedScoreTable[playerID])
  end
  onlineScreenManager.setForceSortType(false)
  onlineScreenManager.setRaceCompleteData(false)
  local results = onlineScreenManager.getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.score)
  for i, player in ipairs(results) do
    assert(player, "Player not found, an error in sorting of players in onlineScreenManager.getScreenCurrentPlayerTable. i = " .. tostring(i) .. " #results = " .. tostring(results) .. " numPlayers = " .. tostring(playerManager.numberOfPlayers))
    if i == 1 then
      if player.id == localPlayer.playerID then
        onlineProgressionSystem.progressionMissionComplete(true)
        onlineStatistics.updateWinStatistic(1)
        onlineStatistics.updateModeProfileWinStatistic("MP tag")
      else
        onlineProgressionSystem.progressionMissionComplete(false)
        onlineStatistics.updateLossStatistic(1)
      end
    end
    if player.id == localPlayer.playerID then
      onlineStatistics.updatePlayerLastPositionInMode("MP tag", i)
      break
    end
  end
end
missionSetupData["Multiplayer tag"].getLocalPlayerFinalScore = function()
  local playerTO = localPlayer.getTaskObject()
  return playerTO.namedTasks.score and playerTO and 0
end
missionSetupData["Multiplayer tag"].getPlayerFinalScore = function(instance, playerID)
  local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[playerID + 1]]
  return taskObject.namedTasks.score and taskObject and 0
end
missionSetupData["Multiplayer tag"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 2,
      spoolStartArea = true,
      gridStyle = 1,
      missionVehicleStyle = 2,
      moodStyle = 2,
      introHUD = "MP Tag Start HUD",
      disableZapOnCompletion = true,
      modeTimeLimit = mpTagTimeLimit,
      targetScore = mpTagScoreLimit,
      invunTime = invincibleTime
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
      modelID = instance.challenge.spawnPositions[routeIndex].missionVehicle.vehicleID
    })
    local package = packageManager.createPackage(false, nil, true, nil, packageVehicle, nil, nil, nil, nil, true, nil)
    instance:newActorFromAgent(OBJ_TEAM_ONE_STRING_TABLE[1], package)
  end
end
missionSetupData["Multiplayer tag"].missionStart = function(instance)
  local tagTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
  MPZapToAction.setZapToAction(2, tagTO.coreData.agent)
  myVehicle = nil
  teammateVehicle = nil
  packageManager.setInvulnerabilityTime(instance.challenge.settings.invunTime)
  packageManager.setPlayerLeftPackageDropType(2)
  packageManager.setlockOwnerInPackageType(true)
end
missionSetupData["Multiplayer tag"].onPlayerJoinInProgress = function(remotePlayer)
  if not remotePlayer then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243748")
    onlineInstructionSupport.displayPrompt("ID:234257", localPlayer.buttonLayout.zapReturn)
  end
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
    if task.condition == 2 then
      phaseManager.modeTimedOut = true
    else
      phaseManager.modeTimedOut = false
    end
    MPZapToAction.reset()
    task.instance:initiateOverTimePhase()
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
