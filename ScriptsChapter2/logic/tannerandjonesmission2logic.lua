module("cardSystem.logic")
missionSetupData["Tanner & Jones Mission 2"] = {}
local observeRange = 75
local failRadius = 130
local suspicionRadius = 50
local losingRadius = 110
local destinationPoint = vec.vector(-3106.95, 68.39338, -595.7111, 1)
local destinationPointRadius = 132
local function tannerTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Initial sample",
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
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait for marker",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
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
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints AI Wander",
        specialName = "Search for target",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 75}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
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
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Radius with hotspot"] = {
                  radius = observeRange,
                  worldColour = vec.vector(0, 80, 200, 127),
                  offset = vec.vector(0, -3.5, 0, 0)
                }
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Show dest prompt",
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
            style = "Tanner & Jones Mission 2 HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Driving audio",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 15}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "In Tanner",
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
        specialName = "Wait for cutscene",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Soft save",
        taskConditions = {
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
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait for follow prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
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
            style = "Tanner & Jones Mission 2 HUD"
          }
        }
      }
    },
    {
      {
        task = "Linear Chase",
        specialName = "Chase target",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Within locked area",
              params = {target = "Actor", actorID = "Leila"}
            },
            {
              goal = "Player within radius of point",
              params = {value = destinationPointRadius, position = destinationPoint}
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
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        }
      },
      {
        task = "Payload Tracking",
        specialName = "Tail suspicion",
        coreData = {upper = 100, lower = 0},
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Time trigger",
              params = {value = 0.09}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Player on pavement"
            },
            {
              goal = "Time trigger",
              params = {value = 0.25}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Agent in oncoming traffic"
            },
            {
              goal = "Time trigger",
              params = {value = 0.25}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Payload over",
              params = {value = 50, increment = 0}
            }
          },
          {
            triggerCount = 1,
            autoRefresh = true,
            {
              goal = "Payload over",
              params = {value = 80}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 3}
            },
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            },
            {
              goal = "Struck specified actors",
              params = {
                actorIDs = {
                  [1] = "Leila"
                }
              }
            },
            {
              goal = "Change payload by amount",
              params = {value = 25}
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Payload over",
              params = {value = 100}
            }
          }
        },
        HUD = {
          {
            style = "Tanner & Jones Mission 2 HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "audio dialogue",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 28}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 65}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 90}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 125}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Tail warning",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Outside radius",
              params = {value = losingRadius}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Within range",
              params = {minimum = suspicionRadius, maximum = losingRadius}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Outside radius",
              params = {value = failRadius}
            }
          }
        },
        HUD = {
          {
            style = "Tanner & Jones Mission 2 HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Tail fail",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Outside radius",
              params = {value = failRadius}
            },
            {
              goal = "Losing getaway time trigger",
              params = {value = 10, prompt = "ID:243487"}
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Tail warning audio",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            triggerCount = 6,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = suspicionRadius}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 6,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Outside radius",
              params = {value = losingRadius}
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints No AI",
        specialName = "Stopped before the boundary",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Agent stopped inside radius",
              params = {
                value = destinationPointRadius,
                stopDuration = 1,
                unlockBrakes = false
              }
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
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
            style = "Tanner & Jones Mission 2 HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Explanation",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            },
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
              goal = "Time trigger",
              params = {value = 17}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        }
      }
    }
  }
  return task
end
local function leilaTask(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "Head for freeway",
        taskConditions = {
          {
            {
              goal = "Within locked area"
            },
            {
              goal = "Player within radius of point",
              params = {value = destinationPointRadius, position = destinationPoint}
            }
          }
        }
      },
      {
        task = "Linear Checkpoints",
        specialName = "Chased by player",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within strip of road",
              params = {value = 8}
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
        audioPIP = audio
      }
    }
  }
  return task
end
local cutsceneVehicleTask = function(goalParams, HUD, audio)
  local task = {
    deleteVehicleOnCompletion = true,
    {
      {task = "No AI"}
    }
  }
  return task
end
missionSetupData["Tanner & Jones Mission 2"].taskCreatorFunctionLookups = {
  ["Tanner team"] = tannerTask,
  ["Leila team"] = leilaTask,
  ["Prop team"] = cutsceneVehicleTask
}
local ravenID
missionSetupData["Tanner & Jones Mission 2"].initiate = function(instance)
  Sound.SetState("Suspicion_State", "Off")
  createCheckpoints(instance)
  createFixedPosition(instance, {destinationPoint}, 1)
  if not configSelector.launchConfig.enableProgression then
    CityLockManager.CityLockState = "CityLockingLevel2"
    CityLockManager.CityLockActive = true
  end
  localPlayer:blockAbility("zap", true)
  feedbackSystem.menusMaster.setCurrentFocusString(1)
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    feedbackSystem.startMusic("Uid04866_CH02_TJ_RealPoliceWork_Play")
    feedbackSystem.menusMaster.setCurrentFocusString(3)
    instance.taskObjectsByActorID.Leila.coreData.actor.desiredSpeed = 80
    instance.taskObjectsByActorID.Leila.coreData.agent.gameVehicle.performance = 2
    instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.speed = 20
  else
    local allCheckpoints = checkpointSystem.getCheckpoints(instance, instance.taskObjectsByActorID.Tanner.coreData.actor.checkpointGroup)
    ravenID = characterManager.addCirclingRavens(allCheckpoints[1].position, 100)
    feedbackSystem.playRavensSound("Ravens_Circling", allCheckpoints[1].position)
  end
  instance.taskObjectsByActorID.Tanner.coreData.actor.desiredSpeed = 50
  OneShotSound.Play("Suspicion_Meter_Play", false, true)
end
missionSetupData["Tanner & Jones Mission 2"].update = nil
local SPEEDINCREASE = 2.1
local function getDynamicTargets(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "Search for target" or task.specialName == "Chased by player" then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
      if task.networkVars.checkpoints < #allCheckpoints then
        task.actor.desiredSpeed = task.actor.desiredSpeed + SPEEDINCREASE
        return {
          allCheckpoints[task.networkVars.checkpoints + 1]
        }, false
      else
        return {
          allCheckpoints[1]
        }, true
      end
    else
      return {
        allCheckpoints[task.networkVars.checkpoints]
      }, false
    end
  elseif dynamicListID then
    return false, true
  elseif task.specialName == "Stopped before the boundary" then
    return checkpointSystem.getCheckpoints(task.instance, 1), false
  else
    return {
      task.instance.taskObjectsByActorID.Leila.coreData.agent
    }, false
  end
end
missionSetupData["Tanner & Jones Mission 2"].targetList = {
  ["Tanner team"] = getDynamicTargets,
  ["Leila team"] = getDynamicTargets
}
local params
local function setupEndScreen(task)
  params = {
    vehicle = task.instance.taskObjectsByActorID.Tanner.coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235498",
    driverIsTanner = true
  }
end
taskCompleteData["Tanner & Jones Mission 2"] = {}
taskCompleteData["Tanner & Jones Mission 2"].taskComplete = function(taskObject, task)
  if task.success then
    if task.specialName == "Chase target" then
      localPlayer:blockAbility("zap", true)
    elseif task.specialName == "Stopped before the boundary" then
      localPlayer:blockAbility("zap", true)
    elseif task.specialName == "In Tanner" then
      local function cutsceneCompleteFunction()
        GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID.Tanner.coreData.agent.position, 20)
        challengeSystem.spawnActors(task.instance, "Any", {Leila = true})
        task.instance.taskObjectsByActorID.Leila.coreData.actor.desiredSpeed = 80
        task.instance.taskObjectsByActorID.Leila.coreData.agent.gameVehicle.performance = 2
        task.agent.gameVehicle.speed = 20
        task.instance.taskObjectsByActorID.Leila.coreData.actor.rubberbandingToPlayerStrength = "Weaker"
        task.instance.taskObjectsByActorID.Leila.coreData.agent:stopHighSpeedDriving()
        local behaviour = {
          traits = taskSystem.buildDriveTraits(task.instance.taskObjectsByActorID.Leila.coreData)
        }
        if #task.instance.taskObjectsByActorID.Leila.namedTasks["Chased by player"].dynamicTargets ~= 0 then
          behaviour.destinationPosition = task.instance.taskObjectsByActorID.Leila.namedTasks["Chased by player"].dynamicTargets[1].position
        end
        task.instance.taskObjectsByActorID.Leila.coreData.agent:highSpeedDrive(behaviour)
        task.instance.taskObjectsByActorID.Leila.coreData.agent.gameVehicle.performance = 2
      end
      engineCutscene.playCutscene("mis_ch2_realpolicework_01", function()
        characterManager.removeRavenGroup(ravenID)
        feedbackSystem.stopRavensSound()
        ravenID = nil
        local tannerTeleportLocation = softSaveStartPositions["Tanner & Jones Mission 2"][1].Tanner
        task.instance.taskObjectsByActorID.Tanner.coreData.agent:teleportToPositionAndHeading(tannerTeleportLocation.position, tannerTeleportLocation.heading)
      end, cutsceneCompleteFunction)
    elseif task.specialName == "Wait for cutscene" then
      for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == "Prop team" then
          taskObject:delete(true)
        end
      end
    elseif task.specialName == "Soft save" then
      feedbackSystem.menusMaster.setCurrentFocusString(3)
      progressionSystem.triggerSoftSave({progression = 1})
      feedbackSystem.startMusic("Uid04866_CH02_TJ_RealPoliceWork_Play")
    elseif task.specialName == "Explanation" then
      localPlayer:blockAbility("zap", true)
      setupEndScreen(task)
      local function completeTask()
        progressionSystem.challengeComplete(task.instance, task.agent.matrix)
      end
      params.driverIsTanner = true
      params.dialogue = "GPMV01_SUCCESS_L_2"
      params.callback = completeTask
      params.vehicle = task.instance.taskObjectsByActorID.Tanner.coreData.agent
      params.rating = "PASS"
      OneShotSound.Play("Suspicion_Meter_Stop", false, true)
      localPlayer.challenge.endScreen(taskObject, params)
    end
  else
    local waitingForPipClear = false
    local function failTask()
      progressionSystem.challengeFailed(task.instance, task.agent.matrix)
    end
    local function waitForPipToClear()
      if not feedbackSystem.isEventActive() then
        localPlayer.challenge.endScreen(taskObject, params)
        removeUserUpdateFunction("waitForPipToClear")
      end
    end
    feedbackSystem.removeSlot(1)
    setupEndScreen(task)
    if 1 <= task.agent.damage then
      params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
      params.dialogue = "GPMV01_FAILURE_L_1"
      params.reason = "Wrecked"
    elseif task.specialName == "Tail fail" then
      if feedbackSystem.isEventActive() then
        PIP.Deactivate()
        Commentary.StopCommentary()
        waitingForPipClear = true
      end
      params.failReason = task.instance.challenge.taskCompleteData["Failure reason (Leila Lost)"]
      params.dialogue = "GPMV01_FAILURE_L_2"
      params.reason = "Lost getaway"
    else
      params.dialogue = "GPMV01_FAILURE_L_3"
      params.vehicle = task.instance.taskObjectsByActorID.Leila.coreData.agent
      params.failReason = "ID:245871"
      params.driverIsTanner = false
    end
    params.callback = failTask
    params.rating = "FAIL"
    OneShotSound.Play("Suspicion_Meter_Stop", false, true)
    if waitingForPipClear then
      addUserUpdateFunction("waitForPipToClear", waitForPipToClear, 1)
    else
      localPlayer.challenge.endScreen(taskObject, params)
    end
  end
end
missionEndCallback["Tanner & Jones Mission 2"] = function(instance)
  if not configSelector.launchConfig.enableProgression then
    CityLockManager.CityLockActive = false
  end
  localPlayer:blockAbility("zap", false)
  Sound.SetRTPC("Paranoia_Meter", 0)
  OneShotSound.Play("Suspicion_Meter_Stop", false, true)
  if ravenID then
    characterManager.removeRavenGroup(ravenID)
    ravenID = nil
  end
  feedbackSystem.stopRavensSound()
  removeUserUpdateFunction("backToJones")
end
