module("cardSystem.logic")
missionSetupData["The debrief"] = {}
local tannerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Wander",
        specialName = "Mission start",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 5}
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
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "The debrief hud"
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
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "The debrief hud"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Tanner drives to half way",
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
              goal = "All targets eliminated (Non-linear)"
            }
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 0.95}
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
                Hotspot = {hideTerrainMarker = true}
              }
            }
          }
        },
        audioPIP = audio,
        HUD = {
          {
            style = "The debrief hud"
          }
        }
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
              params = {value = 4}
            }
          }
        },
        HUD = {
          {
            style = "The debrief hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Mission speech",
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
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "The debrief hud"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Tanner drives to location",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 20}
            }
          },
          {
            {
              goal = "Agent stopped inside radius",
              params = {value = 20, stopDuration = 1}
            }
          },
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
              params = {value = 750, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 5}
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
            {
              goal = "Damage above",
              params = {value = 0.95}
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
        audioPIP = audio,
        HUD = {
          {
            style = "The debrief hud"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Mission end",
        groupProgression = {importantMinorOrder = false},
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
          }
        }
      }
    }
  }
  return task
end
local staticPoliceTask = function(goalParams, HUD)
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
missionSetupData["The debrief"].taskCreatorFunctionLookups = {
  ["Tanner team"] = tannerTask,
  ["Static police team"] = staticPoliceTask
}
local halfWaypoint = vec.vector(-1134.516, 27.91326, 405.8167, 1)
local policeStationLocation = vec.vector(-334.7884, 69.89542, 176.8511, 1)
missionSetupData["The debrief"].initiate = function(instance)
  createFixedPosition(instance, {policeStationLocation}, 1)
  createFixedPosition(instance, {halfWaypoint}, 2)
  localPlayer:blockAbility("zap", true)
  GameVehicleResource.ClearAreaOfVehicles(instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.position, 100)
end
missionSetupData["The debrief"].update = nil
local tannerDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Tanner drives to location" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 1), false
    end
  elseif task.specialName == "Tanner drives to half way" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 2), false
    end
  end
end
missionSetupData["The debrief"].targetList = {
  ["Tanner team"] = tannerDynamicTargets
}
missionEndCallback["The debrief"] = function(instance)
  localPlayer:blockAbility("zap", false)
end
taskCompleteData["The debrief"] = {}
taskCompleteData["The debrief"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.Tanner.coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    successReasonPerfect = task.instance.challenge.taskCompleteData["Success reason (perfect)"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    passCondition = task.instance.challenge.taskCompleteData["Pass condition"],
    passReward = task.instance.challenge.taskCompleteData["Pass reward"],
    perfectCondition = task.instance.challenge.taskCompleteData["Perfect condition"],
    hint = "ID:235485"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
    localPlayer:blockAbility("zap", false)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
    localPlayer:blockAbility("zap", false)
  end
  if task.success then
    if task.specialName == "Mission start" then
      GameVehicleResource.setCharacterSpoolingEntityIndex(task.instance.taskObjectsByActorID["Static cop 01"].coreData.agent.gameVehicle, 0, "-1")
      GameVehicleResource.setCharacterSpoolingEntityIndex(task.instance.taskObjectsByActorID["Static cop 02"].coreData.agent.gameVehicle, 0, "-1")
      GameVehicleResource.setCharacterSpoolingEntityIndex(task.instance.taskObjectsByActorID["Static cop 04"].coreData.agent.gameVehicle, 0, "-1")
    elseif task.specialName == "Tanner drives to location" then
      params.callback = completeTask
      params.rating = "PASS"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  else
    Commentary.StopCommentary()
    params.rating = "FAIL"
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
