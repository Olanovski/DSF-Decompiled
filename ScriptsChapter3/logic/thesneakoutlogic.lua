module("cardSystem.logic")
missionSetupData["The Sneakout"] = {}
local firstSafehouseLocation = vec.vector(-1146.299, 27.745, 474.42, 1)
local finalSafehouseLocation = vec.vector(-3550.634, 63.755, 901.023, 1)
local timerBuffer = 3
local function createPayloadMinorOrder(goalParams, HUD, audio, specialName)
  local minorOrder = {
    task = "Payload Tracking",
    coreData = {upper = 100, lower = 0},
    specialName = specialName,
    startingValues = {payload = 0},
    groupProgression = {importantMinorOrder = false},
    goalConditions = {
      {
        autoRefresh = true,
        {
          goal = "Vehicle is in alley",
          params = {inverse = true}
        },
        {
          goal = "Time trigger",
          params = {value = 0.2}
        }
      },
      {
        failCondition = true,
        autoRefresh = true,
        {
          goal = "Vehicle is in alley"
        },
        {
          goal = "Time trigger",
          params = {value = 0.1}
        }
      },
      {
        {
          goal = "Payload over",
          params = {value = 20}
        },
        {
          goal = "Change payload by amount",
          params = {value = 0}
        }
      },
      {
        {
          goal = "Player within radius of point",
          params = {
            value = 120,
            position = firstSafehouseLocation,
            inverse = true
          }
        },
        {
          goal = "Player within radius of point",
          params = {
            value = 120,
            position = finalSafehouseLocation,
            inverse = true
          }
        },
        {
          goal = "Payload over",
          params = {value = 50}
        },
        {
          goal = "Change payload by amount",
          params = {value = 0}
        }
      },
      {
        {
          goal = "Player within radius of point",
          params = {
            value = 120,
            position = firstSafehouseLocation,
            inverse = true
          }
        },
        {
          goal = "Player within radius of point",
          params = {
            value = 120,
            position = finalSafehouseLocation,
            inverse = true
          }
        },
        {
          goal = "Payload over",
          params = {value = 75}
        },
        {
          goal = "Change payload by amount",
          params = {value = 0}
        }
      },
      {
        {
          goal = "Payload over",
          params = {value = 80}
        },
        {
          goal = "Change payload by amount",
          params = {value = 0}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Time trigger",
          params = {value = 3}
        },
        {
          goal = "Vehicle is in alley",
          params = {inverse = true}
        },
        {
          goal = "Simple collision check",
          params = {
            force = 6000,
            type = "Vehicle",
            whereIHit = "Front"
          }
        },
        {
          goal = "Change payload by amount",
          params = {value = 10}
        }
      },
      {
        triggerCount = 1,
        {
          goal = "Prompt active",
          params = {promptType = "Primary", inverse = true}
        },
        {
          goal = "Vehicle is in alley"
        },
        {
          goal = "Payload over",
          params = {value = 10}
        },
        {
          goal = "Time trigger",
          params = {value = 0.5}
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
        },
        {
          goal = "Time trigger",
          params = {value = 0.75}
        }
      }
    },
    HUD = {
      {
        style = "The Sneakout HUD"
      }
    },
    audioPIP = audio
  }
  return minorOrder
end
local function playerTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Trigger intro",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Tutorial trigger",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 6}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
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
            style = "The Sneakout HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Trigger gameplay section 1",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "The Sneakout HUD"
          }
        }
      }
    },
    {
      {
        task = "Follow Route",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        specialName = "First safehouse",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 11}
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
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
          },
          {
            manager = "Instance vehicles"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Audio First suspicion",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = 115, inverse = true}
            },
            {
              goal = "Vehicle is in alley",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = 115, inverse = true}
            },
            {
              goal = "Vehicle is in alley"
            },
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          }
        },
        audioPIP = audio
      },
      [13] = createPayloadMinorOrder(goalParams, HUD, audio, "First suspicion")
    },
    {
      {
        task = "No AI",
        specialName = "Not zap transitioning",
        taskConditions = {
          {
            {
              goal = "Player in zap transition",
              params = {value = false}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Zap to vehicle",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "SoftSave",
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "The Sneakout HUD"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Wait for audio",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Follow Route",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        specialName = "Second safehouse",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 11}
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Time trigger",
              params = {
                value = 120 + timerBuffer
              }
            }
          },
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
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "The Sneakout HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Mission feedback",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {
                value = 30 + timerBuffer
              }
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {
                value = 60 + timerBuffer
              }
            },
            {
              goal = "Within radius",
              params = {value = 250, inverse = true}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {
                value = 90 + timerBuffer
              }
            },
            {
              goal = "Within radius",
              params = {value = 100, inverse = true}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = timerBuffer}
            }
          }
        },
        HUD = {
          {
            style = "The Sneakout HUD"
          }
        },
        audioPIP = audio
      },
      [10] = createPayloadMinorOrder(goalParams, HUD, audio, "Second suspicion")
    }
  }
  return task
end
local suspiciousVehicleTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Stay parked"
      }
    }
  }
  return task
end
missionSetupData["The Sneakout"].taskCreatorFunctionLookups = {
  ["Player team"] = playerTask,
  ["Suspicious vehicle team"] = suspiciousVehicleTask
}
local ravenIDCircling
missionSetupData["The Sneakout"].initiate = function(instance)
  createFixedPosition(instance, {firstSafehouseLocation}, 100)
  createFixedPosition(instance, {finalSafehouseLocation}, 101)
  OneShotSound.Play("Suspicion_Meter_Play")
  Sound.SetRTPC("Paranoia_Meter", 0)
  localPlayer:blockAbility("zap", true)
  ravenIDCircling = characterManager.addCirclingRavens(firstSafehouseLocation + vec.vector(0, 8, 0, 0), 12)
  feedbackSystem.menusMaster.blockHintButton(true)
end
missionSetupData["The Sneakout"].update = nil
local getPlayerTeamDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "First safehouse" or task.specialName == "Tutorial trigger" or task.specialName == "Audio First suspicion" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 100), false
    end
  elseif task.specialName == "Second safehouse" or task.specialName == "Mission feedback" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 101), false
    end
  end
end
missionSetupData["The Sneakout"].targetList = {
  ["Player team"] = getPlayerTeamDynamicTargets
}
taskCompleteData["The Sneakout"] = {}
local params
local function setupEndScreen(task)
  params = {
    vehicle = task.instance.taskObjectsByActorID.Player.coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235486"
  }
end
taskCompleteData["The Sneakout"].taskComplete = function(taskObject, task)
  print(task.specialName)
  if not showingEndScreen then
    if task.specialName == "Tutorial trigger" or task.specialName == "Trigger gameplay section 1" or task.specialName == "Wait for audio" then
      if not task.success then
        local function failTask()
          progressionSystem.challengeFailed(task.instance, task.agent.matrix)
        end
        OneShotSound.Play("Suspicion_Meter_Stop")
        setupEndScreen(task)
        if localPlayer.currentVehicle ~= task.agent then
          params.dialogue = "GPMV00_FAILURE_L_1"
        else
          params.dialogue = "GPMV01_FAILURE_L_2"
        end
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        params.reason = "Wrecked"
        params.callback = failTask
        params.rating = "FAIL"
        localPlayer.challenge.endScreen(taskObject, params)
      end
    elseif task.specialName == "First safehouse" then
      if task.success then
        OneShotSound.Play("HUD_Play_Waypoint")
        localPlayer:enterCutsceneMode()
      else
        local function failTask()
          progressionSystem.challengeFailed(task.instance, task.agent.matrix)
        end
        OneShotSound.Play("Suspicion_Meter_Stop")
        setupEndScreen(task)
        if localPlayer.currentVehicle ~= task.agent then
          params.dialogue = "GPMV00_FAILURE_L_1"
        else
          params.dialogue = "GPMV01_FAILURE_L_2"
        end
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        params.reason = "Wrecked"
        params.callback = failTask
        params.rating = "FAIL"
        localPlayer.challenge.endScreen(taskObject, params)
      end
    elseif task.specialName == "Not zap transitioning" then
      if not task.agent.controlled then
        if not localPlayer.inZap then
          localPlayer:SetZapLevel(1)
        end
        localPlayer:zapToAgent(task.agent)
      end
    elseif task.specialName == "SoftSave" then
      if task.success then
        progressionSystem.triggerSoftSave({progression = 1})
        OneShotSound.Play("Suspicion_Meter_Stop")
        localPlayer:enterCutsceneMode()
        localPlayer:blockAbility("zap", true)
        localPlayer:setBlockWagglePrompt(true)
        local function teleportPlayer()
          task.agent:teleportToPositionAndHeading(vec.vector(-1189.966, 27.715, 482.545, 1), -1.395, nil, nil, nil, false)
        end
        local function giveTannerAKickUpTheArse()
          task.agent.gameVehicle.velocity = task.agent.gameVehicle.matrix[2] * 30
          characterManager.removeRavenGroup(ravenIDCircling)
          ravenIDCircling = nil
          OneShotSound.Play("Suspicion_Meter_Play")
          localPlayer:setBlockWagglePrompt(false)
          localPlayer:blockAbility("zap", false)
          feedbackSystem.menusMaster.setCurrentFocusString(2)
        end
        engineCutscene.playCutscene("mis_ch3_paranoia_01", teleportPlayer, giveTannerAKickUpTheArse)
      else
        local function failTask()
          progressionSystem.challengeFailed(task.instance, task.agent.matrix)
        end
        OneShotSound.Play("Suspicion_Meter_Stop")
        setupEndScreen(task)
        if localPlayer.currentVehicle ~= task.agent then
          params.dialogue = "GPMV00_FAILURE_L_1"
        else
          params.dialogue = "GPMV01_FAILURE_L_2"
        end
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        params.reason = "Wrecked"
        params.callback = failTask
        params.rating = "FAIL"
        localPlayer.challenge.endScreen(taskObject, params)
      end
    elseif task.specialName == "Second safehouse" then
      if task.success then
        OneShotSound.Play("HUD_Play_Waypoint")
        OneShotSound.Play("Suspicion_Meter_Stop")
        setupEndScreen(task)
        local function completeTask()
          progressionSystem.challengeComplete(task.instance, task.agent.matrix)
        end
        params.callback = completeTask
        params.rating = "PASS"
        params.dialogue = "GPMV01_SUCCESS_L_1"
        localPlayer.challenge.endScreen(taskObject, params)
      else
        local function failTask()
          progressionSystem.challengeFailed(task.instance, task.agent.matrix)
        end
        OneShotSound.Play("Suspicion_Meter_Stop")
        setupEndScreen(task)
        if task.condition == 1 then
          params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
          params.reason = "Wrecked"
          params.dialogue = "GPMV01_FAILURE_L_2"
        elseif task.condition == 2 then
          params.failReason = "ID:184542"
          params.dialogue = "GPMV01_FAILURE_L_3"
        end
        if localPlayer.currentVehicle ~= task.agent then
          params.dialogue = "GPMV00_FAILURE_L_1"
        end
        params.callback = failTask
        params.rating = "FAIL"
        localPlayer.challenge.endScreen(taskObject, params)
      end
    elseif not task.success then
      local function failTask()
        progressionSystem.challengeFailed(task.instance, task.agent.matrix)
      end
      OneShotSound.Play("Suspicion_Meter_Stop")
      setupEndScreen(task)
      if localPlayer.currentVehicle == task.agent then
        params.dialogue = "GPMV01_FAILURE_L_1"
      else
        params.dialogue = "GPMV00_FAILURE_L_1"
      end
      params.callback = failTask
      params.rating = "FAIL"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  end
end
missionEndCallback["The Sneakout"] = function(instance)
  Sound.SetRTPC("Paranoia_Meter", 0)
  OneShotSound.Play("Suspicion_Meter_Stop", false, true)
  localPlayer:blockAbility("zap", false)
  if ravenIDCircling then
    characterManager.removeRavenGroup(ravenIDCircling)
    ravenIDCircling = nil
  end
  feedbackSystem.menusMaster.blockHintButton(false)
end
