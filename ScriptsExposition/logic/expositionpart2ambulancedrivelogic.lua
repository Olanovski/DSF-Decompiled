module("cardSystem.logic")
missionSetupData["Exposition part 2"] = {}
local ambulanceTask = function(goalParams, HUD, audio)
  local task = {
    deleteVehicleOnCompletion = false,
    {
      {
        task = "No AI",
        specialName = "PlayerInTheAmbulance",
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.7}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Is player controlled",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Ambulance HUD"
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
        task = "No AI",
        dynamicTargets = true,
        specialName = "PlayerAtTheHosptial start",
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Agent stopped inside radius",
              params = {
                value = 10,
                stopDuration = 1,
                leaveZapBlocked = true
              }
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
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {}
              }
            }
          }
        },
        HUD = {
          {
            style = "Exposition Ambulance HUD"
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
            style = "Exposition Ambulance HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "PIP",
        taskConditions = {
          {
            {
              goal = "Prompt active",
              params = {promptType = "Primary"}
            },
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "2 nd Objective check",
        groupProgression = {priorityMinorOrder = true},
        taskConditions = {
          {
            {
              goal = "Instance time above",
              params = {value = 12}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Event active",
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
            style = "Exposition Ambulance HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "PlayerAtTheHosptial",
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Agent stopped inside radius",
              params = {
                value = 10,
                stopDuration = 1,
                leaveZapBlocked = true
              }
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
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {}
              }
            }
          }
        },
        HUD = {
          {
            style = "Exposition Ambulance HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "Payload Tracking With Multiplyer",
        coreData = {upper = 80, lower = 20},
        specialName = "payload",
        startingValues = {payload = 80},
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 10}
            },
            {
              goal = "Player above speed",
              params = {value = 1, inverse = true}
            },
            {
              goal = "Change payload by amount",
              params = {value = 0}
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            autoRefresh = true,
            triggerCount = 3,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player above speed",
              params = {value = 50}
            },
            {
              goal = "Player on pavement",
              params = {value = suspicionRadius, inverse = true}
            },
            {
              goal = "Player had collision",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 7.5}
            },
            {
              goal = "Change payload by amount",
              params = {value = 0}
            }
          },
          {
            autoRefresh = true,
            triggerCount = 2,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Payload under",
              params = {value = 40}
            },
            {
              goal = "Time trigger",
              params = {value = 5}
            },
            {
              goal = "Simple collision check",
              params = {force = 5000, setOnPlayer = true}
            },
            {
              goal = "Change payload by amount",
              params = {value = 0}
            }
          },
          {
            autoRefresh = true,
            triggerCount = 1,
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Payload under",
              params = {value = 50}
            },
            {
              goal = "Change payload by amount",
              params = {value = 0}
            }
          },
          {
            autoRefresh = true,
            triggerCount = 1,
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Payload under",
              params = {value = 30}
            },
            {
              goal = "Change payload by amount",
              params = {value = 0}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 60, highest = 80}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 2, downMultiplyer = 2}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 30, highest = 60}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 2, downMultiplyer = 1}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 20, highest = 30}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 2, downMultiplyer = 0.25}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Empty dynamicTargets"
            }
          },
          {
            failCondition = true,
            {
              goal = "Payload under",
              params = {value = 20}
            }
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Ambulance HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "PlayerInTanner",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Ambulance HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Main speech 01",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Is player controlled",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Speed 01 is this really happening",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Agent distance from target",
              params = {value = 1600}
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
              goal = "All targets eliminated (Non-linear)"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "PlayerOnRoute",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Agent distance from target",
              params = {value = 800}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
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
        specialName = "idle",
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
              params = {value = 20}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Ambulance HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Wrong way",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Is getting closer to target",
              params = {value = 30, inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Ambulance HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Mission complete",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
local staticAmbulanceTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "Static ambulance"
      }
    }
  }
  return task
end
missionSetupData["Exposition part 2"].taskCreatorFunctionLookups = {
  ["Ambulance team"] = ambulanceTask,
  ["Static ambulance team"] = ambulanceTask
}
local hostpitalPosition = vec.vector(1221.717, 5.976787, 1284.516, 1)
local loadMissionCallBack = function()
  feedbackSystem.startMusic("Uid00759_Exp_HeadTrauma_Play")
end
missionSetupData["Exposition part 2"].initiate = function(instance)
  createFixedPosition(instance, {hostpitalPosition}, 1)
  localPlayer:blockAbility("zap", true)
  Sound.LoadMission(cards.Missions[instance.challenge.name].MissionID, loadMissionCallBack)
  Commentary.LoadMission(cards.Missions[instance.challenge.name].MissionID)
  feedbackSystem.menusMaster.blockHintButton(true)
  feedbackSystem.menusMaster.setFocusButtonText()
end
missionSetupData["Exposition part 2"].update = nil
local getVehicleDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    return false, true
  elseif task.specialName == "payload" and goalConditionKey == 1 then
    return checkpointSystem.getCheckpoints(task.instance, 1), false
  else
    return checkpointSystem.getCheckpoints(task.instance, 1), false
  end
end
missionSetupData["Exposition part 2"].targetList = {
  ["Ambulance team"] = getVehicleDynamicTargets
}
missionEndCallback["Exposition part 2"] = function(instance)
  BillboardManager.BlendBillBoardIn(3, 0.1, 0.1)
  feedbackSystem.stopMusic("Uid00759_Exp_HeadTrauma_Stop")
end
taskCompleteData["Exposition part 2"] = {}
taskCompleteData["Exposition part 2"].taskComplete = function(taskObject, task)
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  local params = {
    vehicle = localPlayer.currentVehicle,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    passCondition = task.instance.challenge.taskCompleteData["Pass condition"],
    passReward = task.instance.challenge.taskCompleteData["Pass reward"],
    hint = "ID:235485",
    hintIcon1 = localPlayer.buttonLayout.minimapZoom,
    driverIsTanner = true,
    keepMusicTrackRunning = true
  }
  local missionStartBehaviour = {
    traits = taskSystem.buildDriveTraits(task),
    destinationPosition = hostpitalPosition
  }
  local tanner = task.instance.taskObjectsByActorID["Tanner Actor"].coreData.agent
  if task.specialName == "PlayerInTaskVehicle" then
    player.removeController(localPlayer.localID)
    tanner:highSpeedDrive(missionStartBehaviour)
  elseif task.specialName == "PlayerInTheAmbulance" then
    tanner:stopHighSpeedDriving()
    player.setAttachment(localPlayer.localID, localPlayer.currentVehicle.gameVehicle)
    player.registerController(localPlayer.localID)
  end
  if task.success then
    if task.specialName == "PlayerAtTheHosptial" then
      localPlayer.cameraSupport.miniSceneCamera()
      localPlayer.controllerInterface:removePlayerControl()
      localPlayer:enterCutsceneMode()
    elseif task.specialName == "Mission complete" then
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == "Static ambulance team" then
          taskObject:delete()
        end
      end
      params.callback = completeTask
      params.rating = "PASS"
      BillboardManager.BlendBillBoardOut(3, 5, 0.1)
      feedbackSystem.stopMusic("Uid00759_Exp_HeadTrauma_Stop")
      localPlayer.challenge.endScreen(taskObject, params)
    end
  else
    params.callback = failTask
    params.rating = "FAIL"
    params.dialogue = "GPMV01_FAILURE_L_2"
    if task.condition == 3 then
      params.failReason = "ID:183989"
      params.dialogue = "GPMV01_FAILURE_L_1"
    end
    feedbackSystem.stopMusic("Uid00759_Exp_HeadTrauma_Stop")
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
