module("cardSystem.logic")
missionSetupData["Exposition part 3 zap"] = {}
local chopShopSpeechTriggerPointA = vec.vector(-190.4077, 21.74517, 1228.643, 1)
local chopShopSpeechTriggerPointB = vec.vector(-378.3011, 20.59222, 1107.19, 1)
local chopShopSpeechTriggerPointC = vec.vector(-637.3696, 30.06198, 1233.783, 1)
local function zapTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "PlayerInTanner",
        goalConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "At the billboard",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 20}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {hideTerrainMarker = true}
              }
            }
          }
        },
        HUD = {
          {
            style = "Exposition Zap HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Objective prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2.5}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Zap HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Speech 01",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Instance time above",
              params = {value = 10}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 800, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "On route",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Instance time above",
              params = {value = 10}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 700, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2.5}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Within radius",
              params = {value = 1000}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player within radius of point",
              params = {value = 50, position = chopShopSpeechTriggerPointA}
            },
            {
              goal = "Is target ahead",
              params = {angle = -0.8}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player within radius of point",
              params = {value = 50, position = chopShopSpeechTriggerPointB}
            },
            {
              goal = "Is target ahead",
              params = {angle = -0.8}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player within radius of point",
              params = {value = 50, position = chopShopSpeechTriggerPointC}
            },
            {
              goal = "Is target ahead",
              params = {angle = -0.8}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait for cutscene to start",
        taskConditions = {
          {
            {
              goal = "In cutscene or icam"
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait for cutscene to end",
        taskConditions = {
          {
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "PlayerZappedIntoCar01",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Remove tanner",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "EnterZapPrompt02",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Zap HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "PlayerInZap02",
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 3,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 4}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Zap HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "PlayerZappedIntoCar02",
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          },
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Vehicle selected in shift"
            }
          },
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Vehicle selected in shift",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          },
          {
            triggerCount = 3,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = 10, takeZapIntoAccount = true}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = 4, takeZapIntoAccount = true}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Vehicles zapped into",
              params = {value = 1}
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Zap HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "EnterZapPrompt03",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Zap HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "PlayerInZap03",
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 3,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 4}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {levelOfZap = 1}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Zap HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "PlayerZappedIntoCar03",
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          },
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Vehicle selected in shift"
            }
          },
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Vehicle selected in shift",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          },
          {
            triggerCount = 3,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = 10, takeZapIntoAccount = true}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = 4, takeZapIntoAccount = true}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Zap HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "EnterZapPrompt04",
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Prompt active",
              params = {promptType = "Primary"}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Zap HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "PlayerZappedIntoATaxi",
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Zapped into vehicle",
              params = {value = 272}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          },
          {
            triggerCount = 3,
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2.5}
            }
          },
          {
            {
              goal = "Player in zap",
              params = {value = true}
            }
          },
          {
            {
              goal = "Player zap status has changed",
              params = {transition = "out"}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Is player in vehicle model",
              params = {value = 272, inverse = true}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = 4, takeZapIntoAccount = true}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Zapped into vehicle",
              params = {value = 272}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Zap HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Contiune prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 15}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = true, numberOfTimes = 3}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Zap HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "In zap speech",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 3,
            {
              goal = "Vehicles zapped into",
              params = {value = 3}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Zap HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Never a taxi when you need one",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Taxi wander 01"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Taxi wander 02"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Taxi wander 03"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Taxi wander 04"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Taxi wander 05"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Taxi wander 06"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Taxi wander 07"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Taxi wander 08"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Taxi wander 09"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Taxi wander 10"
                },
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Achievement unlocked",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            {
              goal = "Damage above",
              params = {value = 0.95}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Zap HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Final task",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Damage above",
              params = {value = 0.95}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Zap HUD"
          }
        }
      }
    }
  }
  return task
end
local zapTeamTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "Kill the zap team",
        taskConditions = {
          {
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            }
          }
        }
      }
    }
  }
  return task
end
local taxiTeamTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "Kill respawn",
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Is player in vehicle model",
              params = {value = 272, inverse = true}
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {
                value = 350,
                target = "Player",
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Player within radius in zap",
              params = {
                value = 350,
                useOperandA = true,
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 1, takeZapIntoAccount = true}
            }
          },
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Is player in vehicle model",
              params = {value = 272}
            }
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Exposition part 3 zap"].taskCreatorFunctionLookups = {
  ["Tanner team"] = zapTask,
  ["Zap team"] = zapTeamTask,
  ["Taxi team"] = taxiTeamTask
}
local driveToPosition = vec.vector(-419.5683, 23.7816, 1235.377, 1)
local respawnRequired
local requiredActors = {}
missionSetupData["Exposition part 3 zap"].initiate = function(instance)
  respawnRequired = false
  requiredActors = {}
  shop.purchaseAbility(abilities.abilitySlots.zap, 0, true)
  localPlayer:blockAbility("zap", true)
  zapcontroller.ShowPrompts(true)
  feedbackSystem.menusMaster.setFocusButtonText()
  createFixedPosition(instance, {driveToPosition}, 1)
  Commentary.LoadMission(cards.Missions[instance.challenge.name].MissionID, loadMissionCallBack)
  Sound.LoadMission(cards.Missions[instance.challenge.name].MissionID)
  instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.velocity = instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.matrix[2] * 20
  GameVehicleResource.ClearAreaOfVehicles(instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.position, 60)
  feedbackSystem.menusMaster.blockHintButton(true)
end
local removeTaxiFromTraffic = function(gameVehicle, reason)
  local vehicleAgent = vehicleManager.vehiclesByGameVehicle[gameVehicle]
  local taxiWander = {
    traits = taskSystem.buildDriveTraits(vehicleAgent:getTaskObject().coreData)
  }
  vehicleAgent:getTaskObject().coreData.agent:highSpeedDrive(taxiWander)
end
missionSetupData["Exposition part 3 zap"].update = nil
missionSetupData["Exposition part 3 zap"].goalComplete = function(taskObject, task, conditionKey)
  if task.specialName == "Never a taxi when you need one" then
    local taxiToSpawn = false
    if conditionKey == 1 then
      taxiToSpawn = "Taxi wander 01"
    elseif conditionKey == 2 then
      taxiToSpawn = "Taxi wander 02"
    elseif conditionKey == 3 then
      taxiToSpawn = "Taxi wander 03"
    elseif conditionKey == 4 then
      taxiToSpawn = "Taxi wander 04"
    elseif conditionKey == 5 then
      taxiToSpawn = "Taxi wander 05"
    elseif conditionKey == 6 then
      taxiToSpawn = "Taxi wander 06"
    elseif conditionKey == 7 then
      taxiToSpawn = "Taxi wander 07"
    elseif conditionKey == 8 then
      taxiToSpawn = "Taxi wander 08"
    elseif conditionKey == 9 then
      taxiToSpawn = "Taxi wander 09"
    elseif conditionKey == 10 then
      taxiToSpawn = "Taxi wander 10"
    end
    if taxiToSpawn then
      challengeSystem.spawnActors(task.instance, "Any", {
        [taxiToSpawn] = true
      })
      civilianTraffic.AddVehicleToCarrier(task.instance.taskObjectsByActorID[taxiToSpawn].coreData.agent.gameVehicle, removeTaxiFromTraffic)
    end
  end
end
local getVehicleDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    return false, true
  else
    return checkpointSystem.getCheckpoints(task.instance, 1), false
  end
end
missionSetupData["Exposition part 3 zap"].targetList = {
  ["Tanner team"] = getVehicleDynamicTargets,
  ["Zap team"] = {},
  ["Taxi team"] = {}
}
taskCompleteData["Exposition part 3 zap"] = {}
taskCompleteData["Exposition part 3 zap"].taskComplete = function(taskObject, task)
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local params = {callback = completeTask, rating = "PASS"}
  if task.specialName == "At the billboard" then
    local function triggerCutscene()
      local blendBillboard = function()
        feedbackSystem.menusMaster.blockHintButton(true)
        BillboardManager.BlendBillBoardOut(4, 0.1, 0.1)
      end
      engineCutscene.playCutscene("ch0_gp_Billboard_Do_It_Tanner", blendBillboard, function()
        BillboardManager.BlendBillBoardIn(4, 0.5, 0.5)
        task.instance.taskObjectsByActorID.Tanner.coreData.agent:teleportToPositionAndHeading(vec.vector(-490.5913, 25.32624, 1234.284, 1), -1.548623)
        task.instance.taskObjectsByActorID["Zap Car 01"].coreData.agent.gameVehicle.velocity = task.instance.taskObjectsByActorID["Zap Car 01"].coreData.agent.gameVehicle.matrix[2] * 25
        localPlayer:blockAbility("zap", true)
      end)
    end
    local function startCam()
      challengeSystem.spawnActors(task.instance, "Any", {
        ["Zap Car 01"] = true
      })
      localPlayer:SetZapLevel(1)
      localPlayer:SetZapLevel(0, task.instance.taskObjectsByActorID["Zap Car 01"].coreData.agent, true)
      triggerCutscene()
    end
    fades.down(startCam)
  elseif task.specialName == "EnterZapPrompt04" then
    challengeSystem.spawnActors(task.instance, "Any", {
      ["Taxi wander 01"] = true,
      ["Taxi wander 02"] = true,
      ["Taxi wander 03"] = true,
      ["Taxi wander 04"] = true,
      ["Taxi wander 05"] = true
    })
    challengeSystem.spawnActors(task.instance, "Any", {
      ["Taxi wander 06"] = true,
      ["Taxi wander 07"] = true,
      ["Taxi wander 08"] = true,
      ["Taxi wander 09"] = true,
      ["Taxi wander 10"] = true
    })
    for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team == "Taxi team" and task.instance.taskObjectsByActorID[actorID] then
        civilianTraffic.AddVehicleToCarrier(taskObject.coreData.agent.gameVehicle, removeTaxiFromTraffic)
      end
    end
    minimap.SetHighlightedVehicleModelUID(272)
    minimap.SetHighlightedVehicles(true)
    if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle.model_id == 272 then
      minimap.AddVehicleToExcludeFromHighlights(localPlayer.currentVehicle.gameVehicle)
    end
  elseif task.specialName == "Kill respawn" then
    civilianTraffic.RemoveVehicleFromCarrier(taskObject.coreData.agent.gameVehicle)
  elseif task.specialName == "Achievement unlocked" then
    Achievements.UnlockAchievement(AchievementTable.AchievementID.THISCANTBEREAL.achievementID)
  elseif task.specialName == "Final task" then
    if task.instance.taskObjectsByActorID.Tanner then
      zapcontroller.RemoveLockedVehicle({
        gameVehicle = task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle
      })
      localPlayer:blockAbility("zap", false)
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == "Taxi team" then
          task.instance.taskObjectsByActorID[actorID].coreData.agent.gameVehicle.maxAllowedDamage = 1
        end
      end
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "Remove tanner" then
    task.instance.taskObjectsByActorID.Tanner.coreData.agent:teleportToPositionAndHeading(vec.vector(-400.733, 30.125, 2191.516, 1), -1.650394, nil, nil, nil, false, false)
  elseif task.specialName == "Wait for cutscene to end" then
    GameVehicleResource.ClearAreaOfVehicles(vec.vector(-978.6232, 37.46419, 953.5815, 1), 200)
  elseif task.specialName == "PlayerInZap02" then
    ProfileSettings.SetUserControlledShiftUnlocked(true)
  end
end
missionEndCallback["Exposition part 3 zap"] = function(instance)
  localPlayer:blockAbility("zap", false)
end
