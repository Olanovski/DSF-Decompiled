module("cardSystem.logic")
missionSetupData["Tanner And Jones 3"] = {}
local playerTask = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    deleteVehicleOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "Initial drive",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Agent stopped inside radius",
              params = {
                value = 15,
                unlockBrakes = true,
                stopDuration = 1.5
              }
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
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
            style = "Tanner And Jones 3 HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Player has snook around the back",
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Agent stopped inside radius",
              params = {
                value = 15,
                stopDuration = 1.5,
                unlockBrakes = true
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
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Haines spawner",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "commentary trigger",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 3,
            {
              goal = "Time trigger",
              params = {value = 12}
            },
            {
              goal = "Player within radius of point",
              params = {
                value = 70,
                position = initialDriveToLocation,
                inverse = true
              }
            },
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
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 120}
            },
            {
              goal = "Is player controlled"
            },
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
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player within radius of point",
              params = {value = 150, position = initialDriveToLocation}
            },
            {
              goal = "Player within radius of point",
              params = {
                value = 70,
                position = initialDriveToLocation,
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Shift into haines",
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
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "stay put",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 90, inverse = true}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      }
    }
  }
  return task
end
local insideManTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Inside man waiting",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
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
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Icam complete",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "In cutscene or icam",
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
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "soft save 1",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
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
        }
      }
    },
    {
      {
        task = "Payload Tracking With Multiplyer",
        specialName = "Scare section",
        coreData = {upper = 180, lower = 80},
        startingValues = {payload = 80},
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Payload over",
              params = {value = 110}
            },
            {
              goal = "Recent audio played",
              params = {value = 4}
            },
            {
              goal = "Change payload by amount",
              params = {value = 0}
            }
          },
          {
            triggerCount = 2,
            {
              goal = "Payload over",
              params = {value = 135}
            },
            {
              goal = "Recent audio played",
              params = {value = 4}
            },
            {
              goal = "Change payload by amount",
              params = {value = 0}
            }
          },
          {
            triggerCount = 2,
            {
              goal = "Payload over",
              params = {value = 160}
            },
            {
              goal = "Recent audio played",
              params = {value = 4}
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
              goal = "Is jumping",
              params = {inverse = true}
            },
            {
              goal = "Is drifting",
              params = {inverse = true}
            },
            {
              goal = "Below speed",
              params = {value = 80}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "Is jumping",
              params = {inverse = true}
            },
            {
              goal = "Is drifting",
              params = {inverse = true}
            },
            {
              goal = "Below speed",
              params = {value = 50}
            },
            {
              goal = "Time trigger",
              params = {value = 0.75}
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "Is jumping",
              params = {inverse = true}
            },
            {
              goal = "Is drifting",
              params = {inverse = true}
            },
            {
              goal = "Below speed",
              params = {value = 30}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            autoRefresh = true,
            failCondition = true,
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 80, highest = 100}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 2, downMultiplyer = 0.1}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 100, highest = 110}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.8, downMultiplyer = 0.15}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 110, highest = 120}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.7, downMultiplyer = 0.2}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 120, highest = 140}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.65, downMultiplyer = 0.25}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 140, highest = 155}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.6, downMultiplyer = 0.3}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 155, highest = 170}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.45, downMultiplyer = 0.35}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 170, highest = 180}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.3, downMultiplyer = 0.4}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Payload over",
              params = {value = 180}
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
        HUD = {
          {
            style = "Tanner And Jones 3 HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "scare timer",
        groupProgression = {priorityMinorOrder = true},
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Time trigger",
              params = {value = 5}
            },
            {
              goal = "Time trigger",
              params = {value = 90},
              feedback = "Timer"
            }
          }
        },
        HUD = {
          {
            style = "Tanner And Jones 3 HUD"
          }
        }
      },
      {
        task = "Wander",
        specialName = "zapped one",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 2,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            },
            {
              goal = "Player using zap return",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Pause",
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
        HUD = {
          {
            style = "Tanner And Jones 3 HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "soft save 02",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
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
        }
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
        specialName = "wreck them prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
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
        HUD = {
          {
            style = "Tanner And Jones 3 HUD"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "evade",
        goalConditions = {
          {
            {
              goal = "Felony chaser destroyed"
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
              goal = "Being chased",
              params = {inverse = true}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Haines taking damage when not player controlled",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Damage has changed by",
              params = {value = 0.01}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "zapped two",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 2,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            },
            {
              goal = "Player using zap return",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Zap back to inside man",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
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
        task = "No AI",
        specialName = "Mission end",
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
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        audioPIP = audio
      }
    }
  }
  cardSystem.createHeartometerParameters(task[4][1])
  return task
end
local chaseTask = function(goalParams, HUD, audio)
  local task = {
    {
      {task = "No AI"}
    }
  }
  return task
end
missionSetupData["Tanner And Jones 3"].taskCreatorFunctionLookups = {
  ["Tanner team"] = playerTask,
  ["Chase team"] = chaseTask,
  ["Inside man team"] = insideManTask
}
local initialDriveToLocation = vec.vector(-2543.518, 6.294685, -233.8501, 1)
local roundTheBackofHaines = vec.vector(-2586.181, 20.63091, -163.0464, 1)
missionSetupData["Tanner And Jones 3"].initiate = function(instance)
  createFixedPosition(instance, {initialDriveToLocation}, 99)
  createFixedPosition(instance, {roundTheBackofHaines}, 100)
  createCheckpoints(instance)
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    if softSaveData.progression == 1 then
      feedbackSystem.menusMaster.setCurrentFocusString(3)
    elseif softSaveData.progression == 2 then
      feedbackSystem.menusMaster.setCurrentFocusString(4)
    end
  else
    localPlayer:blockAbility("zap", true)
  end
end
local getTannerDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "stay put" then
    if dynamicListID then
      return false, true
    else
      return {
        task.instance.taskObjectsByActorID["Inside man"].coreData.agent
      }, false
    end
  elseif task.specialName ~= "Player has snook around the back" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 99), false
    end
  elseif dynamicListID then
    return false, true
  else
    return checkpointSystem.getCheckpoints(task.instance, 100), false
  end
end
local getChaserDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID["Inside man"].coreData.agent
    }, false
  end
end
missionSetupData["Tanner And Jones 3"].targetList = {
  ["Tanner team"] = getTannerDynamicTargets,
  ["Chase team"] = getChaserDynamicTargets,
  ["Inside man team"] = getInsideManDynamicTargets
}
missionSetupData["Tanner And Jones 3"].update = nil
local evaderGameVehicle
local spawnCount = 0
missionSetupData["Tanner And Jones 3"].goalComplete = function(taskObject, task)
  if task.specialName == "evade" then
    if spawnCount == 0 then
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Chase member 4"] = true
      })
      spawnCount = 1
    elseif spawnCount == 1 then
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Chase member 5"] = true
      })
      spawnCount = 2
    end
    for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team == "Chase team" then
        felony_getaway.addChaser(evaderGameVehicle, taskObject.coreData.agent.gameVehicle)
      end
    end
  end
end
local params
local function setupEndScreen(task)
  params = {
    vehicle = task.agent,
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = "ID:184390",
    passCondition = task.instance.challenge.taskCompleteData["Pass condition"],
    hint = "",
    dialogue = "",
    driverIsTanner = true
  }
end
taskCompleteData["Tanner And Jones 3"] = {}
taskCompleteData["Tanner And Jones 3"].taskComplete = function(taskObject, task)
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.success then
    if task.specialName == "Shift into haines" then
      local matrix = alignMatrix(vec.vector(-2549.525, 12.09514, -194.4727, 1), 2.936401)
      task.instance.taskObjectsByActorID["Inside man"].coreData.agent:teleportToMatrix(matrix, nil, nil, nil, true)
      local function zapInHaines()
        localPlayer.missionSupport:setMainTaskObject(task.instance.taskObjectsByActorID["Inside man"])
        zapcontroller.RemoveLockedVehicle({
          gameVehicle = task.instance.taskObjectsByActorID["Inside man"].coreData.agent.gameVehicle
        })
        localPlayer:SetZapLevel(1)
        localPlayer:SetZapLevel(0, task.instance.taskObjectsByActorID["Inside man"].coreData.agent, false)
        localPlayer:buildZapReturn()
        localPlayer:enterCutsceneMode()
        zapcontroller.AddLockedVehicle({
          gameVehicle = task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle
        })
      end
      if not localPlayer.inZap then
        local iCamParams = {
          cameraTargets = {
            task.instance.taskObjectsByActorID["Inside man"].coreData.agent.gameVehicle
          },
          duration = 4,
          speed = 1,
          framing = "close",
          angleYaw = "front",
          anglePitch = "low",
          callbackFunction = zapInHaines,
          disableAI = true
        }
        iCamActivationTableInput(iCamParams)
      else
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_1", zapInHaines, "missionCritical")
      end
    elseif task.specialName == "Haines spawner" then
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Inside man"] = true
      })
      task.instance.taskObjectsByActorID["Inside man"].coreData.agent.iconsVisible = false
      zapcontroller.AddLockedVehicle({
        gameVehicle = task.instance.taskObjectsByActorID["Inside man"].coreData.agent.gameVehicle
      })
    elseif task.specialName == "soft save 1" then
      progressionSystem.triggerSoftSave({progression = 1})
      feedbackSystem.menusMaster.setCurrentFocusString(3)
      Sound.EnableScoring("drift", true)
      Sound.EnableScoring("jump", true)
    elseif task.specialName == "Scare section" then
      feedbackSystem.menusMaster.blockHintButton(true)
      OneShotSound.Play("HUD_Play_Waypoint")
      Sound.EnableScoring("drift", false)
      Sound.EnableScoring("jump", false)
      localPlayer:blockAbility("zap", true)
      if localPlayer.currentVehicle ~= task.instance.taskObjectsByActorID["Inside man"].coreData.agent or localPlayer.inZap then
        localPlayer:zapToAgent(task.instance.taskObjectsByActorID["Inside man"].coreData.agent)
      end
    elseif task.specialName == "soft save 02" then
      progressionSystem.triggerSoftSave({progression = 2})
      feedbackSystem.menusMaster.focusHintButtonState(true)
      feedbackSystem.removeSlot(1)
      feedbackSystem.removeSlot(2)
      local teleportTanner = function()
        localPlayer.currentVehicle:teleportToPositionAndHeading(vec.vector(-2418.38, 35.00718, 426.5906, 1), 1.335809, nil, nil, nil, false, false)
      end
      local function giveTannerAKickUpTheArse()
        task.instance.taskObjectsByActorID["Inside man"].coreData.agent.gameVehicle.velocity = task.instance.taskObjectsByActorID["Inside man"].coreData.agent.gameVehicle.matrix[2] * 20
      end
      engineCutscene.playCutscene("mis_ch3_Shakedown_01", teleportTanner, giveTannerAKickUpTheArse)
    elseif task.specialName == "Wait for cutscene to end" then
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Chase member 1"] = true,
        ["Chase member 2"] = true,
        ["Chase member 3"] = true
      })
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == "Inside man team" then
          evaderGameVehicle = taskObject.coreData.agent.gameVehicle
          felony_getaway.addEvader(evaderGameVehicle)
        end
      end
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == "Chase team" then
          felony_getaway.addChaser(evaderGameVehicle, taskObject.coreData.agent.gameVehicle)
        end
      end
    elseif task.specialName == "wreck them prompt" then
      feedbackSystem.startMusic("Uid05378_CH03_TJ_Shakedown_Play")
    elseif task.specialName == "evade" then
      if localPlayer.inZap then
        localPlayer:SetZapLevel(0, task.instance.taskObjectsByActorID["Inside man"].coreData.agent, true)
      elseif localPlayer.currentVehicle ~= task.instance.taskObjectsByActorID["Inside man"].coreData.agent then
        localPlayer:SetZapLevel(1)
        localPlayer:SetZapLevel(0, task.instance.taskObjectsByActorID["Inside man"].coreData.agent, true)
      end
      feedbackSystem.menusMaster.blockHintButton(true)
      localPlayer:blockAbility("zap", true)
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == "Chase team" then
          task.instance.taskObjectsByActorID[actorID]:delete()
        end
      end
    elseif task.specialName == "Zap back to inside man" then
      feedbackSystem.stopMusic("Uid05378_CH03_TJ_Shakedown_Stop")
    elseif task.specialName == "Icam complete" then
      localPlayer:exitCutsceneMode()
      localPlayer:resetCameraMode()
    elseif task.specialName == "Mission end" then
      setupEndScreen(task)
      params.dialogue = "GPMV02_SUCCESS_L_1"
      params.vehicle = taskObject.coreData.agent
      params.callback = completeTask
      params.rating = "PASS"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  else
    setupEndScreen(task)
    if task.specialName == "Initial drive" or task.specialName == "Search for inside man" then
      params.hint = "ID:235485"
      params.dialogue = "GPMV00_FAILURE_L_1"
    elseif task.specialName == "Scare section" then
      params.hint = "ID:243193"
      if task.condition == 2 and localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Inside man"].coreData.agent then
        params.dialogue = "GPMV02_FAILURE_L_1"
      else
        params.dialogue = "GPMV02_FAILURE_L_2"
      end
    elseif task.specialName == "scare timer" then
      params.failReason = "ID:184074"
      params.hint = "ID:243193"
    elseif task.specialName == "evade" or task.specialName == "Zap back to inside man" then
      params.hint = "ID:235489"
    end
    params.vehicle = taskObject.coreData.agent
    params.rating = "FAIL"
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
    feedbackSystem.stopMusic("Uid05378_CH03_TJ_Shakedown_Stop")
  end
end
missionEndCallback["Tanner And Jones 3"] = function(instance)
  spawnCount = 0
  localPlayer:blockAbility("zap", false)
  feedbackSystem.stopMusic("Uid05378_CH03_TJ_Shakedown_Stop")
  Sound.EnableScoring("drift", false)
  Sound.EnableScoring("jump", false)
end
