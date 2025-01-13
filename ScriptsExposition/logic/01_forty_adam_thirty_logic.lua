module("cardSystem.logic")
missionSetupData["Exposition 01 Forty Adam Thirty"] = {}
local tannerTask = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "Mission start",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        HUD = {
          {
            style = "Forty Adam Thirty HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "PlayerInTaskVehicle",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            }
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Main task",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Within strip of road",
              params = {value = 10}
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
            style = "Forty Adam Thirty HUD"
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
              params = {value = 1.5}
            }
          }
        },
        HUD = {
          {
            style = "Forty Adam Thirty HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "PIP 01 trigger",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Prompt active",
              params = {promptType = "Primary"}
            },
            {
              goal = "Time trigger",
              params = {value = 4.5}
            }
          }
        },
        HUD = {
          {
            style = "Forty Adam Thirty HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Alternative driveToLocation01 trigger",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 10}
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
        specialName = "Give control back to the player",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Accelerate Prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Instance time above",
              params = {value = 12}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Secondary", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Instance time above",
              params = {value = 12}
            },
            {
              goal = "Button Press",
              params = {
                watchFor = "Pressed",
                button = "Vehicle_Accelerate"
              }
            },
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        HUD = {
          {
            style = "Forty Adam Thirty HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Break and Reverse Prompt",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Instance time above",
              params = {value = 15}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 160}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Instance time above",
              params = {value = 15}
            },
            {
              goal = "Button Press",
              params = {
                watchFor = "Pressed",
                button = "Vehicle_Reverse"
              }
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Forty Adam Thirty HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "missionSpeechTrigger",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
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
              params = {value = 2000}
            },
            {
              goal = "Above speed",
              params = {value = 3}
            },
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
        specialName = "Filler speech",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 3,
            {
              goal = "Instance time above",
              params = {value = 15}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 300, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 30}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "idle",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Instance time above",
              params = {value = 15}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Below speed",
              params = {value = 2}
            },
            {
              goal = "Time trigger",
              params = {value = 30}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "driveToLocation02",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within strip of road",
              params = {value = 10}
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
            style = "Forty Adam Thirty HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Camera change prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
            }
          }
        },
        HUD = {
          {
            style = "Forty Adam Thirty HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Filler speech 02",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 3,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 300, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 15}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "idle 02",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Below speed",
              params = {value = 2}
            },
            {
              goal = "Time trigger",
              params = {value = 30}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "driveToLocationOverpass",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within strip of road",
              params = {value = 10}
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
            style = "Forty Adam Thirty HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Filler speech 03",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 3,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 375, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 15}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "idle 03",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 200, inverse = true}
            },
            {
              goal = "Below speed",
              params = {value = 2}
            },
            {
              goal = "Time trigger",
              params = {value = 30}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "mission end",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within strip of road",
              params = {value = 20}
            }
          },
          {
            {
              goal = "Is target ahead",
              params = {inverse = true}
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
        }
      }
    }
  }
  return task
end
missionSetupData["Exposition 01 Forty Adam Thirty"].taskCreatorFunctionLookups = {
  ["Tanner team"] = tannerTask
}
local driveToLocation01 = vec.vector(1295.981, 8.413732, 2504.82, 1)
local driveToLocation02 = vec.vector(1364.077, 8.343556, 2320.697, 1)
local driveToLocationOverpass = vec.vector(1189.541, 15.41695, 2079.48, 1)
local highWayDestination = vec.vector(1187.37, 27.10375, 1901.986, 1)
local alternativeTriggerForDP01 = vec.vector(1260.59, 8.21528, 2490.259, 1)
local loadAudioCallBack = function()
  feedbackSystem.startMusic("Uid04343_Exp_FortyAdamThirty_Play")
end
missionSetupData["Exposition 01 Forty Adam Thirty"].initiate = function(instance)
  createFixedPosition(instance, {driveToLocation01}, 1)
  createFixedPosition(instance, {driveToLocation02}, 2)
  createFixedPosition(instance, {driveToLocationOverpass}, 3)
  createFixedPosition(instance, {highWayDestination}, 4)
  createFixedPosition(instance, {alternativeTriggerForDP01}, 5)
  localPlayer:blockAbility("zap", true)
  Commentary.LoadMission(cards.Missions[instance.challenge.name].MissionID)
  Sound.LoadMission(cards.Missions[instance.challenge.name].MissionID, loadAudioCallBack)
  propSystem.setupRuntimeProps(instance.challenge.props, false, false)
end
missionSetupData["Exposition 01 Forty Adam Thirty"].update = nil
local getVehicleDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "Alternative driveToLocation01 trigger" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 5), false
    end
  elseif dynamicListID then
    return false, true
  elseif task.majorOrder < 3 then
    return checkpointSystem.getCheckpoints(task.instance, 1), false
  elseif task.majorOrder == 3 then
    return checkpointSystem.getCheckpoints(task.instance, 2), false
  elseif task.majorOrder == 4 then
    return checkpointSystem.getCheckpoints(task.instance, 3), false
  elseif task.majorOrder == 5 then
    return checkpointSystem.getCheckpoints(task.instance, 4), false
  end
end
missionSetupData["Exposition 01 Forty Adam Thirty"].targetList = {
  ["Tanner team"] = getVehicleDynamicTargets
}
taskCompleteData["Exposition 01 Forty Adam Thirty"] = {}
taskCompleteData["Exposition 01 Forty Adam Thirty"].taskComplete = function(taskObject, task)
  print("task complete LOGIC : " .. tostring(task.specialName))
  local missionStartBehaviour = {
    traits = taskSystem.buildDriveTraits(task),
    destinationPosition = driveToLocation01
  }
  local missionEndBehaviour = {
    traits = taskSystem.buildDriveTraits(task),
    destinationPosition = highWayDestination
  }
  local function completeTask()
    feedbackSystem.stopMusic("Uid04343_Exp_FortyAdamThirty_Stop")
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local params = {
    callback = completeTask,
    rating = "PASS",
    keepMusicTrackRunning = true
  }
  local tanner = task.instance.taskObjectsByActorID.Tanner.coreData.agent
  if task.specialName == "PlayerInTaskVehicle" then
    player.removeController(localPlayer.localID)
    tanner:highSpeedDrive(missionStartBehaviour)
  elseif task.specialName == "Give control back to the player" then
    tanner:stopHighSpeedDriving()
    player.setAttachment(localPlayer.localID, localPlayer.currentVehicle.gameVehicle)
    player.registerController(localPlayer.localID)
  elseif task.specialName == "driveToLocationOverpass" then
    player.removeController(localPlayer.localID)
    tanner:highSpeedDrive(missionEndBehaviour)
  elseif task.specialName == "mission end" then
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
