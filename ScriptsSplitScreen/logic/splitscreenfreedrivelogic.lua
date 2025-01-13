module("cardSystem.logic")
missionSetupData = missionSetupData or {}
missionSetupData["Split Screen Freedrive"] = {}
missionSetupData["Split Screen Freedrive"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.target = routes["Survival 2 Level 1 start "].checkpoints[1].position
    spawnPosition.positionA = routes["Survival 2 Level 1 start "].checkpoints[1].position
    spawnPosition.headingA = routes["Survival 2 Level 1 start "].checkpoints[1].heading
    spawnPosition.positionB = routes["Survival 2 Level 1 start "].checkpoints[2].position
    spawnPosition.headingB = routes["Survival 2 Level 1 start "].checkpoints[2].heading
  end,
  [2] = function(spawnPosition)
    spawnPosition.target = routes.Tag_Start_02.checkpoints[1].position
    spawnPosition.positionA = routes.Tag_Start_02.checkpoints[1].position
    spawnPosition.headingA = routes.Tag_Start_02.checkpoints[1].heading
    spawnPosition.positionB = routes.Tag_Start_02.checkpoints[2].position
    spawnPosition.headingB = routes.Tag_Start_02.checkpoints[2].heading
  end,
  [3] = function(spawnPosition)
    spawnPosition.target = routes["Survival 1 Level 2 start"].checkpoints[1].position
    spawnPosition.positionA = routes["Survival 1 Level 2 start"].checkpoints[1].position
    spawnPosition.headingA = routes["Survival 1 Level 2 start"].checkpoints[1].heading
    spawnPosition.positionB = routes["Survival 1 Level 2 start"].checkpoints[2].position
    spawnPosition.headingB = routes["Survival 1 Level 2 start"].checkpoints[2].heading
  end
}
missionSetupData["Split Screen Freedrive"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
  spawnPosition.positionB = nil
  spawnPosition.headingB = nil
end
missionSetupData["Split Screen Freedrive"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\SplitScreen_Survival02.lua",
    playerOneVehicle = {
      vehicleID = 62,
      shader = {
        [0] = 0
      }
    },
    playerTwoVehicle = {
      vehicleID = 192,
      shader = {
        [0] = 1
      }
    },
    spoolableVehicles = {
      [1] = 62,
      [2] = 192
    },
    moods = {
      [1] = "OnlineBandit",
      [2] = "OnlineBandit",
      [3] = "OnlineCannonBall",
      [4] = "OnlineFog",
      [5] = "OnlineWhiteStripe",
      [6] = "OnlineWhiteStripe",
      [7] = "OnlineDefault",
      [8] = "OnlineDefault",
      [9] = "OnlineJerichoLite",
      [10] = "OnlineLAConnection",
      [11] = "OnlineLAConnection",
      [12] = "OnlineVanishing",
      [13] = "OnlineVanishing"
    }
  },
  [2] = {
    routeName = "RouteData\\MP_Tag02.lua",
    playerOneVehicle = {
      vehicleID = 62,
      shader = {
        [0] = 0
      }
    },
    playerTwoVehicle = {
      vehicleID = 192,
      shader = {
        [0] = 1
      }
    },
    spoolableVehicles = {
      [1] = 62,
      [2] = 192
    },
    moods = {
      [1] = "OnlineBandit",
      [2] = "OnlineBandit",
      [3] = "OnlineCannonBall",
      [4] = "OnlineFog",
      [5] = "OnlineWhiteStripe",
      [6] = "OnlineWhiteStripe",
      [7] = "OnlineDefault",
      [8] = "OnlineDefault",
      [9] = "OnlineJerichoLite",
      [10] = "OnlineLAConnection",
      [11] = "OnlineLAConnection",
      [12] = "OnlineVanishing",
      [13] = "OnlineVanishing"
    }
  },
  [3] = {
    routeName = "RouteData\\SplitScreen_Survival01.lua",
    playerOneVehicle = {
      vehicleID = 62,
      shader = {
        [0] = 0
      }
    },
    playerTwoVehicle = {
      vehicleID = 192,
      shader = {
        [0] = 1
      }
    },
    spoolableVehicles = {
      [1] = 62,
      [2] = 192
    },
    moods = {
      [1] = "OnlineBandit",
      [2] = "OnlineBandit",
      [3] = "OnlineCannonBall",
      [4] = "OnlineFog",
      [5] = "OnlineWhiteStripe",
      [6] = "OnlineWhiteStripe",
      [7] = "OnlineDefault",
      [8] = "OnlineDefault",
      [9] = "OnlineJerichoLite",
      [10] = "OnlineLAConnection",
      [11] = "OnlineLAConnection",
      [12] = "OnlineVanishing",
      [13] = "OnlineVanishing"
    }
  }
}
missionSetupData["Split Screen Freedrive"].usableRouteIndicies = {
  [1] = {1},
  [2] = {2},
  [3] = {3}
}
local getPlayerTaskList = function(param1, param2, param3, agent)
  return {
    [1] = {
      [1] = {
        task = "SS Vehicle Counter",
        specialName = "vehicle",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "SS Player in shift status changed",
              params = {value = true}
            },
            {
              goal = "SS Player in shift status changed",
              params = {value = false}
            }
          }
        },
        HUD = {
          {
            style = "SS Freedrive HUD"
          }
        }
      },
      [2] = {
        task = "SS Stats Tracker",
        specialName = "distance",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "SS Player in shift",
              params = {value = false}
            },
            {
              goal = "SS Player distance travelled",
              params = {value = 10}
            }
          }
        }
      },
      [3] = {
        task = "SS Stats Tracker",
        specialName = "jump",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "SS Player in shift",
              params = {value = false}
            },
            {goal = "SS jump"}
          }
        }
      },
      [4] = {
        task = "SS Stats Tracker",
        specialName = "drift",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "SS Player in shift",
              params = {value = false}
            },
            {goal = "SS drift"}
          }
        }
      },
      [5] = {
        task = "SS Stats Tracker",
        specialName = "speed",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "SS Player in shift",
              params = {value = false}
            },
            {goal = "SS speed"}
          }
        }
      }
    }
  }
end
missionSetupData["Split Screen Freedrive"].taskCreatorFunctionLookups = {
  ["Player Pool"] = getPlayerTaskList
}
missionSetupData["Split Screen Freedrive"].stepHighlightColours = function(instance)
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
missionSetupData["Split Screen Freedrive"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 2,
      spoolStartArea = true,
      gridStyle = 5,
      missionVehicleStyle = 5,
      moodStyle = 2,
      disableZapOnCompletion = true
    }
  }
end
missionSetupData["Split Screen Freedrive"].initiate = function(instance)
end
missionSetupData["Split Screen Freedrive"].missionStart = function(instance)
  resetSSFreeDriveStats()
end
missionSetupData["Split Screen Freedrive"].onPlayerJoinInProgress = function(remotePlayer)
end
missionSetupData["Split Screen Freedrive"].modeReadyCheck = function(instance)
  return true
end
missionSetupData["Split Screen Freedrive"].update = function(instance)
end
taskCompleteData = taskCompleteData or {}
taskCompleteData["Split Screen Freedrive"] = {}
taskCompleteData["Split Screen Freedrive"].taskComplete = function(taskObject, task)
end
