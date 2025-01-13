module("cardSystem.logic")
local targetDisplaySpeed, targetSpeed = feedbackSystem.mphToLocalisedSpeed(70)
missionSetupData["Handle challenge"] = {}
local tutorialStarted = false
local function createPayloadMinorOrder(goalParams, HUD, audio, specialName)
  local minorOrder = {
    task = "Payload Tracking With Multiplyer",
    coreData = {upper = 100, lower = 0},
    specialName = specialName,
    startingValues = {payload = 0},
    groupProgression = {priorityMinorOrder = true},
    goalConditions = {
      {
        failCondition = true,
        autoRefresh = true,
        {
          goal = "Above speed",
          params = {value = targetSpeed, displayed = true}
        },
        {
          goal = "Time trigger",
          params = {value = 0.35}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Below speed",
          params = {value = targetSpeed, displayed = true}
        },
        {
          goal = "Time trigger",
          params = {value = 0.25}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Damage has changed by",
          params = {value = 0.002}
        },
        {
          goal = "Change payload by amount",
          params = {value = 6}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Damage has changed by",
          params = {value = 0.0015}
        },
        {
          goal = "Damage has changed by",
          params = {value = 0.00199, inverse = true}
        },
        {
          goal = "Change payload by amount",
          params = {value = 5}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Damage has changed by",
          params = {value = 0.001}
        },
        {
          goal = "Damage has changed by",
          params = {value = 0.00149, inverse = true}
        },
        {
          goal = "Change payload by amount",
          params = {value = 4}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Damage has changed by",
          params = {value = 0.0005}
        },
        {
          goal = "Damage has changed by",
          params = {value = 0.000999, inverse = true}
        },
        {
          goal = "Change payload by amount",
          params = {value = 2}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Damage has changed by",
          params = {value = 0.0002}
        },
        {
          goal = "Damage has changed by",
          params = {value = 0.000499, inverse = true}
        },
        {
          goal = "Change payload by amount",
          params = {value = 1}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Simple collision check",
          params = {
            whereIHit = "Front",
            whereIWasHit = "Front",
            force = 30000
          }
        },
        {
          goal = "Change payload by amount",
          params = {value = 19}
        }
      },
      {
        triggerCount = 1,
        {
          goal = "Event active",
          params = {inverse = true}
        },
        {
          goal = "Payload over",
          params = {value = 50, increment = 0}
        }
      },
      {
        triggerCount = 1,
        {
          goal = "Event active",
          params = {inverse = true}
        },
        {
          goal = "Payload over",
          params = {value = 70, increment = 0}
        }
      },
      {
        triggerCount = 2,
        {
          goal = "Time trigger",
          params = {value = 5}
        },
        {
          goal = "Event active",
          params = {inverse = true}
        },
        {
          goal = "Payload over",
          params = {value = 85, increment = 0}
        }
      },
      {
        triggerCount = 1,
        {
          goal = "Event active",
          params = {inverse = true}
        },
        {
          goal = "Is player controlled"
        },
        {
          goal = "Payload under",
          params = {value = 0, increment = 0}
        }
      },
      {
        {
          goal = "Payload between",
          params = {lowest = 0, highest = 15}
        },
        {
          goal = "Change payload multiplyers",
          params = {upMultiplyer = 2, downMultiplyer = 0.2}
        }
      },
      {
        {
          goal = "Payload between",
          params = {lowest = 15, highest = 39}
        },
        {
          goal = "Change payload multiplyers",
          params = {upMultiplyer = 1.75, downMultiplyer = 0.4}
        }
      },
      {
        {
          goal = "Payload between",
          params = {lowest = 39, highest = 70}
        },
        {
          goal = "Change payload multiplyers",
          params = {upMultiplyer = 1, downMultiplyer = 0.7}
        }
      },
      {
        {
          goal = "Payload between",
          params = {lowest = 70, highest = 90}
        },
        {
          goal = "Change payload multiplyers",
          params = {upMultiplyer = 0.5, downMultiplyer = 1.2}
        }
      },
      {
        {
          goal = "Payload between",
          params = {lowest = 90, highest = 101}
        },
        {
          goal = "Change payload multiplyers",
          params = {upMultiplyer = 0.3, downMultiplyer = 1.3}
        }
      }
    },
    taskConditions = {
      {
        forceTaskComplete = true,
        failCondition = true,
        {
          goal = "Payload over",
          params = {value = 100}
        }
      },
      {
        forceTaskComplete = true,
        failCondition = true,
        {
          goal = "Damage above",
          params = {value = 1}
        }
      }
    },
    HUD = {
      {
        style = "Handle challenge hud"
      }
    }
  }
  return minorOrder
end
local function playerTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait for countdown",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3},
              feedback = "Time"
            }
          }
        },
        HUD = {
          {
            style = "Handle challenge hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "PlayerInTanner",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Slow start",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 6}
            }
          }
        },
        HUD = {
          {
            style = "Handle challenge hud"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "drive to quiet spot",
        groupProgression = {priorityMinorOrder = true},
        dynamicTargets = true,
        coreData = {totalLaps = 0},
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
              params = {coreValue = "totalLaps"}
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
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Handle challenge hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "speed check",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Above speed",
              params = {value = targetSpeed, displayed = true}
            }
          },
          {
            {
              goal = "Below speed",
              params = {value = targetSpeed, displayed = true}
            }
          },
          {
            {
              goal = "Below speed",
              params = {value = targetSpeed, displayed = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Handle challenge hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "final prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 7}
            }
          }
        },
        HUD = {
          {
            style = "Handle challenge hud"
          }
        }
      },
      [8] = createPayloadMinorOrder(goalParams, HUD, audio, "payload task 1")
    }
  }
  return task
end
missionSetupData["Handle challenge"].taskCreatorFunctionLookups = {
  ["Player team"] = playerTask
}
local endLocation2 = vec.vector(-3118.699, 113.6575, -3092.978, 1)
local aiIntroPosition = vec.vector(897.6311, 39.93902, -3752.069, 1)
missionSetupData["Handle challenge"].initiate = function(instance)
  localPlayer:blockAbility("zap", true)
  createFixedPosition(instance, {endLocation2}, 44)
  localPlayer:enterCutsceneMode()
end
missionSetupData["Handle challenge"].update = nil
local getPlayerTeamDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "drive to quiet spot" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 44), false
    end
  end
end
missionSetupData["Handle challenge"].targetList = {
  ["Player team"] = getPlayerTeamDynamicTargets
}
taskCompleteData["Handle challenge"] = {}
taskCompleteData["Handle challenge"].taskComplete = function(taskObject, task)
  local perfect = false
  local params = {
    vehicle = task.agent,
    cameraShots = cameraShots[2],
    successReason = "ID:245581",
    failReason = "ID:245577",
    hint = "ID:235485",
    driverIsTanner = true
  }
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.specialName == "Start Challenge tutorial" then
    if not tutorialStarted then
      tutorialStarted = true
      ProfileSettings.SetToolTipShown(toolTipLookupTable.Challenge)
      CutsceneFiles.tutorials.playTutorial("ID:245644")
    end
  elseif task.specialName == "Start Movie Challenge tutorial" then
    if not tutorialStarted then
      tutorialStarted = true
      ProfileSettings.SetToolTipShown(toolTipLookupTable["Movie Challenge"])
      CutsceneFiles.tutorials.playTutorial("ID:245648")
    end
  elseif task.specialName == "Wait for countdown" then
    localPlayer:exitCutsceneMode()
    feedbackSystem.menusMaster.primaryTextPromptParam({
      prompt = "ID:245601",
      delay = true,
      priority = 1
    })
    if task.instance.taskObjectsByActorID["Bomb car"] then
      task.instance.taskObjectsByActorID["Bomb car"].coreData.agent:stopHighSpeedDriving()
      player.setAttachment(localPlayer.localID, localPlayer.currentVehicle.gameVehicle)
      player.registerController(localPlayer.localID)
    end
  elseif task.specialName == "PlayerInTanner" then
    if task.instance.taskObjectsByActorID["Bomb car"] then
      local missionStartBehaviour = {
        traits = taskSystem.buildDriveTraits(task),
        destinationPosition = aiIntroPosition
      }
      player.removeController(localPlayer.localID)
      task.instance.taskObjectsByActorID["Bomb car"].coreData.agent:highSpeedDrive(missionStartBehaviour)
    end
  elseif task.specialName == "Slow start" then
    feedbackSystem.menusMaster.primaryTextPromptParam({
      prompt = "ID:234231",
      priority = 1,
      value = targetDisplaySpeed
    })
  elseif task.specialName == "final prompt" then
    feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:231391", priority = 1})
  elseif task.specialName == "drive to quiet spot" then
    local function completeTask()
      progressionSystem.challengeComplete(task.instance, task.agent.matrix, perfect)
    end
    if feedbackSystem.getTimer() < math.floor(singlePlayerStatistics.getScoreStatistic()) / 100 then
      params.rating = "PASS"
      params.callback = completeTask
      singlePlayerStatistics.updateScoreStatistic(feedbackSystem.getTimer(), "Time")
    else
      params.failReason = "ID:231222"
      params.rating = "FAIL"
      params.callback = failTask
    end
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "payload task 1" then
    GameVehicleResource.explode({
      gameVehicle = taskObject.coreData.instance.taskObjectsByActorID["Bomb car"].coreData.agent.gameVehicle,
      offset = vec.vector(1, 0, 0, 1),
      range = 0,
      strength = 500
    })
    params.rating = "FAIL"
    GameVehicleResource.applyDamage({
      gameVehicle = taskObject.coreData.instance.taskObjectsByActorID["Bomb car"].coreData.agent.gameVehicle,
      damage = 1
    })
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "Payload Tracking With Multiplyer" then
    GameVehicleResource.explode({
      gameVehicle = taskObject.coreData.instance.taskObjectsByActorID["Bomb car"].coreData.agent.gameVehicle,
      attachedVehicle = "Child",
      offset = vec.vector(1, 0, 0, 1),
      range = 0,
      strength = 100
    })
  end
end
missionEndCallback["Handle challenge"] = function(instance)
  localPlayer:blockAbility("zap", false)
end
