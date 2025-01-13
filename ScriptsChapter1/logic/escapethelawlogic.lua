module("cardSystem.logic")
missionSetupData["Escape the law"] = {}
local timeBeforeTimer = 5.5
local initialPause = 2
local function evadeTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Wander",
        specialName = "Initial pause",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = initialPause}
            }
          },
          {
            failCondition = true,
            {goal = "Got busted"}
          },
          {
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
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Follow Route",
        specialName = "Route follow",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Has been chased"
            },
            {
              goal = "Being chased",
              params = {inverse = true}
            }
          }
        }
      },
      {
        task = "No AI Linear Checkpoints",
        specialName = "Main logic",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Being chased",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 40}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Being chased"
            },
            {
              goal = "Within radius",
              params = {value = 400}
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
            {goal = "Got busted"}
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Instance time above",
              params = {
                value = goalParams["Time limit"] + timeBeforeTimer + initialPause
              }
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          },
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
            style = "Escape the law HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "First prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          }
        },
        HUD = {
          {
            style = "Escape the law HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Display timer",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = timeBeforeTimer}
            }
          }
        },
        HUD = {
          {
            style = "Escape the law HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "On approach",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Being chased"
            },
            {
              goal = "Within radius",
              params = {value = 600}
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Being chased toggle",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Being chased",
              params = {inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Escape the law HUD"
          }
        }
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Lose cops warning",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            {
              goal = "Within radius",
              params = {value = 150}
            },
            {
              goal = "Being chased"
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Within radius",
              params = {value = 150}
            },
            {
              goal = "Being chased",
              params = {inverse = true}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Outside radius",
              params = {value = 150}
            }
          },
          {
            {
              goal = "Being chased",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 40}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Being chased",
              params = {inverse = true}
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 80}
            }
          }
        },
        HUD = {
          {
            style = "Escape the law HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "In zap",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Is player controlled",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Use boost prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 50}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 65}
            }
          }
        },
        HUD = {
          {
            style = "Escape the law HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Had collision",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Simple collision check",
              params = {force = 3000}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Damage audio",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Damage above",
              params = {value = 0.35}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Damage above",
              params = {value = 0.6}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Damage above",
              params = {value = 0.85}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "One third of time",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Instance time above",
              params = {
                value = goalParams["Time limit"] / 3
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Two thirds of time",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Instance time above",
              params = {
                value = goalParams["Time limit"] / 3 * 2
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Not being chased",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Being chased",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Still being chased",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 4,
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 35}
            },
            {
              goal = "Being chased"
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "Payload Tracking",
        specialName = "Escaped being busted",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Escaped being busted"
            }
          }
        },
        HUD = {
          {
            style = "Escape the law HUD"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "In Ordell",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            }
          }
        }
      }
    }
  }
  return task
end
local chaseTask = function(goalParams, HUD)
  local task = {
    {
      {task = "No AI"}
    }
  }
  return task
end
missionSetupData["Escape the law"].taskCreatorFunctionLookups = {
  ["Evade team"] = evadeTask,
  ["Chase team"] = chaseTask,
  ["Dropoff team"] = chaseTask
}
missionSetupData["Escape the law"].initiate = function(instance)
  createFixedPosition(instance, {
    spawnPositions["Escape the law dropoff spawn"].position
  }, 999)
  createCheckpoints(instance)
  local evaderGameVehicle = instance.taskObjectsByActorID["evade team member 1"].coreData.agent.gameVehicle
  felony_getaway.addEvader(evaderGameVehicle)
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.team == "Chase team" then
      felony_getaway.addChaser(evaderGameVehicle, taskObject.coreData.agent.gameVehicle)
    end
  end
  FelonyVehicleSpawnManager.SetExclusionZone(spawnPositions["Escape the law dropoff spawn"].position, 200)
  feedbackSystem.startMusic("Uid04816_CH01_MeetTheHeat_Play")
end
missionSetupData["Escape the law"].update = nil
local getEvadeTeamDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "Main logic" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 999), false
    end
  elseif task.specialName == "On approach" or task.specialName == "Lose cops warning" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 999), false
    end
  end
end
missionSetupData["Escape the law"].targetList = {
  ["Evade team"] = getEvadeTeamDynamicTargets
}
taskCompleteData["Escape the law"] = {}
local params
local function setupEndScreen(task)
  params = {
    vehicle = task.instance.taskObjectsByActorID["evade team member 1"].coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    driverIsTanner = true,
    hint = "ID:235490"
  }
end
taskCompleteData["Escape the law"].taskComplete = function(taskObject, task)
  if not showingEndScreen and (task.specialName == "Main logic" or task.specialName == "In Ordell") then
    feedbackSystem.stopMusic("Uid04816_CH01_MeetTheHeat_Stop")
    if task.specialName == "In Ordell" then
      OneShotSound.Play("HUD_Play_Waypoint")
      FelonyVehicleSpawnManager.SetExclusionZone(nil, 0)
      setupEndScreen(task)
      local function completeTask()
        progressionSystem.challengeComplete(task.instance, task.agent.matrix)
      end
      params.callback = completeTask
      params.rating = "PASS"
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "Main logic" and task.success then
      if not task.agent.controlled then
        localPlayer:zapToAgent(task.agent)
      end
    else
      FelonyVehicleSpawnManager.SetExclusionZone(nil, 0)
      setupEndScreen(task)
      if task.condition == 2 then
        params.failReason = task.instance.challenge.taskCompleteData.Arrested
        params.dialogue = "GPMV01_FAILURE_L_1"
        params.reason = "Busted"
      elseif task.condition == 3 then
        params.dialogue = "GPMV01_FAILURE_L_2"
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        params.reason = "Wrecked"
      elseif task.condition == 4 then
        if Getaway.IsBeingChased(task.instance.taskObjectsByActorID["evade team member 1"].coreData.agent.gameVehicle) then
          params.dialogue = "GPMV01_FAILURE_L_1"
        else
          params.dialogue = "GPMV01_FAILURE_L_3"
        end
        params.failReason = task.instance.challenge.taskCompleteData["Out of time"]
      end
      local function failTask()
        progressionSystem.challengeFailed(task.instance, task.agent.matrix)
      end
      params.callback = failTask
      params.rating = "FAIL"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  end
end
missionEndCallback["Escape the law"] = function(instance)
  instance.taskObjectsByActorID["evade team member 1"].coreData.actor.routeName = "Meet the Heat evader loop"
end
