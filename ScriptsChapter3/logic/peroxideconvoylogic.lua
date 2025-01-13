module("cardSystem.logic")
missionSetupData["Peroxide convoy"] = {}
local convoyTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "Follow Route",
        specialName = "Convoy",
        taskConditions = {
          {
            {
              goal = "Within locked area"
            },
            {
              goal = "Time trigger",
              params = {value = 0.6}
            }
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        }
      }
    }
  }
  return task
end
local initialTankerTask = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    enableNonPlayerFeedback = true,
    {
      {
        task = "Follow Route",
        specialName = "Initial tanker",
        taskConditions = {
          {
            {
              goal = "Within locked area"
            },
            {
              goal = "Time trigger",
              params = {value = 0.6}
            }
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Strike tanker",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Simple collision check",
              params = {playerMustHitTarget = true}
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
      }
    }
  }
  return task
end
local tannerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait for marker 1",
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
            },
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
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
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
        specialName = "Get to on ramp hud1",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 78}
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
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            },
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
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
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
        HUD = {
          {
            style = "Peroxide convoy HUD",
            settings = {hud1 = true}
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Init dialogue hud1",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 5},
              feedback = "Timer"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "zap audio 1",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Non-linear Chase",
        specialName = "Initial chase hud2",
        dynamicTargets = true,
        groupProgression = {mustBeSuccessful = true},
        goalConditions = {
          {
            {
              goal = "Target damage above",
              params = {value = 1}
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
            },
            {
              goal = "Is player controlled"
            }
          },
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
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
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
            style = "Peroxide convoy HUD",
            settings = {hud2 = true}
          }
        },
        audioPIP = audio
      },
      {
        task = "Payload Tracking",
        specialName = "first stage - oncoming prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 15}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Changed vehicle",
              params = {value = 1}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "In mission vehicle",
              params = {inverse = true}
            },
            {
              goal = "Against traffic flow"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Payload over",
              params = {value = 3}
            }
          }
        },
        HUD = {
          {
            style = "Peroxide convoy HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "zap audio 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "look at tanker hud1",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "timer timer",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            },
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
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
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
        task = "Wander",
        specialName = "Back to tanner hud1",
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
            },
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
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
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
            style = "Peroxide convoy HUD",
            settings = {hud1 = true}
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait for marker 2",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 4}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            },
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
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
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
        specialName = "transition hud1",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 7.5}
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
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            },
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
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
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
        HUD = {
          {
            style = "Peroxide convoy HUD",
            settings = {hud1 = true}
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Non-linear Chase",
        specialName = "Chase hud - delay hotspot",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Target damage above",
              params = {value = 1}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          },
          {
            {
              goal = "x targets remaining",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            },
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
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
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
            style = "Peroxide convoy HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait for prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 4}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 2.1}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Peroxide convoy HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "highlight target 1",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Any team member within radius of target",
              params = {value = 2500, team = "Race team"}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Any team member within radius of target",
              params = {value = 1500, team = "Race team"}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Any team member within radius of target",
              params = {value = 1000, team = "Race team"}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Any team member within radius of target",
              params = {value = 500, team = "Race team"}
            },
            {
              goal = "All opposing vehicles damage above",
              params = {value = 0.5, inverse = true}
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
            style = "Peroxide convoy HUD"
          }
        }
      },
      {
        task = "Payload Tracking",
        specialName = "oncoming prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Changed vehicle",
              params = {value = 1}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "In mission vehicle",
              params = {inverse = true}
            },
            {
              goal = "Against traffic flow"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Payload over",
              params = {value = 3}
            }
          }
        },
        HUD = {
          {
            style = "Peroxide convoy HUD"
          }
        }
      },
      {
        task = "Non-linear Chase",
        specialName = "Chase hud3",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Target damage above",
              params = {value = 1}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "x targets remaining",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            },
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
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
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
            style = "Peroxide convoy HUD",
            settings = {hud3 = true}
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "zap audio 3",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "highlight target 2",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Any team member within radius of target",
              params = {value = 2500, team = "Race team"}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Any team member within radius of target",
              params = {value = 1500, team = "Race team"}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Any team member within radius of target",
              params = {value = 1000, team = "Race team"}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Any team member within radius of target",
              params = {value = 1700, team = "Race team"}
            },
            {
              goal = "All opposing vehicles damage above",
              params = {value = 0.5, inverse = true}
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
            style = "Peroxide convoy HUD"
          }
        }
      },
      {
        task = "Payload Tracking",
        specialName = "oncoming prompt 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 15}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Changed vehicle",
              params = {value = 1}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "In mission vehicle",
              params = {inverse = true}
            },
            {
              goal = "Against traffic flow"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Payload over",
              params = {value = 3}
            }
          }
        }
      },
      {
        task = "Non-linear Chase",
        specialName = "Pile-up hud3",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Target damage above",
              params = {value = 1}
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
            },
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
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
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
            style = "Peroxide convoy HUD",
            settings = {hud3 = true}
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "zap audio 4",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Back from zap",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Waiting for pile-up hud1",
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
            },
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
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
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
            style = "Peroxide convoy HUD",
            settings = {hud1 = true}
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
missionSetupData["Peroxide convoy"].taskCreatorFunctionLookups = {
  ["Chase team"] = tannerTask,
  ["Race team"] = convoyTask,
  ["Initial tanker team"] = initialTankerTask
}
local onRampLocation = vec.vector(-1076.979, 66.68018, 1897.349, 1)
local firstTankerLocation = vec.vector(-3144.529, 57.14933, 2539.858, 1)
local cityBoundary = vec.vector(1771.872, 45.118, 1502.194, 1)
missionSetupData["Peroxide convoy"].initiate = function(instance)
  local softSaveData = progressionSystem.getSoftSaveData()
  if not configSelector.launchConfig.enableProgression then
    CityLockManager.CityLockState = "CityLockingLevel2"
    CityLockManager.CityLockActive = true
  end
  instance.challenge.actorPool.Convoy1.aiIgnorePlayers = true
  instance.challenge.actorPool.Convoy2.aiIgnorePlayers = true
  instance.challenge.actorPool.Convoy3.aiIgnorePlayers = true
  createFixedPosition(instance, {cityBoundary}, 200)
  createFixedPosition(instance, {onRampLocation}, 102)
  createFixedPosition(instance, {firstTankerLocation}, 103)
  createCheckpoints(instance)
  if softSaveData then
    feedbackSystem.menusMaster.setCurrentFocusString(3)
    instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.speed = 17
    feedbackSystem.startMusic("Uid05907_CH03_Story_FreewayInferno_Play")
  else
    instance.taskObjectsByActorID.Tanner.coreData.actor.rubberbandingActor = "Convoy1"
  end
end
missionSetupData["Peroxide convoy"].update = nil
local getInitialTankerDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Strike tanker" then
    if dynamicListID then
      return false, true
    else
      return {
        task.instance.taskObjectsByActorID.Tanner.coreData.agent
      }, false
    end
  end
end
local getChaseDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "Get to on ramp hud1" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 103), false
    end
  elseif task.specialName == "transition hud1" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 102), false
    end
  elseif task.specialName == "Chase hud3" or task.specialName == "Pile-up hud3" or task.specialName == "Chase hud - delay hotspot" then
    if dynamicListID then
      return false, true
    else
      local teams = {}
      for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.agent.damage < 1 then
          teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
          table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
        end
      end
      if teams["Race team"] then
        return teams["Race team"], false
      else
        return false, true
      end
    end
  elseif task.specialName == "Initial chase hud2" then
    if dynamicListID then
      if 1 < #task.dynamicTargets then
        return false, false
      else
        return false, true
      end
    else
      local teams = {}
      for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
        teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
        table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
      end
      return teams["Initial tanker team"], false
    end
  elseif task.specialName == "highlight target 1" or task.specialName == "highlight target 2" then
    return checkpointSystem.getCheckpoints(task.instance, 200), false
  end
end
missionSetupData["Peroxide convoy"].targetList = {
  ["Chase team"] = getChaseDynamicTargets,
  ["Initial tanker team"] = getInitialTankerDynamicTargets
}
taskCompleteData["Peroxide convoy"] = {}
taskCompleteData["Peroxide convoy"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = taskObject.coreData.agent,
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235487",
    dialogue = "",
    hintIcon1 = localPlayer.buttonLayout.minimapZoom,
    driverIsTanner = false
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  local displayPrompt = function(id)
    feedbackSystem.menusMaster.primaryTextPromptParam({prompt = id, priority = 1})
  end
  local endScreenDelay = function(taskObject, params)
    localPlayer.challenge.endScreen(taskObject, params)
    removeUserUpdateFunction("endScreenDelay")
  end
  if task.specialName == "Wait for marker 1" then
    addUserUpdateFunction("displayPrompt", function()
      displayPrompt("ID:245537")
      removeUserUpdateFunction("displayPrompt")
    end, 120, true)
  elseif task.actor.ID == "Tanner" and task.instance.taskObjectsByActorID.Tanner.coreData.agent.damage >= 1 then
    params.dialogue = "GPMV01_FAILURE_L_1"
    params.callback = failTask
    params.reason = "Wrecked"
    feedbackSystem.stopMusic("Uid05907_CH03_Story_FreewayInferno_Stop")
    if task.specialName == "Get to on ramp hud1" then
      params.hint = "ID:235485"
    end
    params.failReason = "ID:184950"
    params.rating = "FAIL"
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "Get to on ramp hud1" then
    if task.success then
      if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle ~= task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle then
        localPlayer:SetZapLevel(1)
        localPlayer:SetZapLevel(0, task.instance.taskObjectsByActorID.Tanner.coreData.agent, false)
      end
      challengeSystem.spawnActors(task.instance, "Never", {Convoy1 = true})
      GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID.Convoy1.coreData.agent.gameVehicle.position, 35)
      OneShotSound.Play("HUD_Play_Waypoint")
      feedbackSystem.startMusic("Uid05907_CH03_Story_FreewayInferno_Play")
      if task.instance.taskObjectsByActorID.Convoy1 then
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:184622", priority = 1})
      end
      feedbackSystem.menusMaster.setCurrentFocusString(2)
    else
      if localPlayer.currentVehicle == task.instance.taskObjectsByActorID.Tanner.coreData.agent and not localPlayer.inZap then
        params.dialogue = "GPMV01_FAILURE_L_1"
      else
        params.dialogue = "GPMV00_FAILURE_L_1"
      end
      params.hint = "ID:235485"
      params.callback = failTask
      params.failReason = "ID:184950"
      params.reason = "Wrecked"
      params.rating = "FAIL"
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "Initial tanker" then
    if task.success then
      if localPlayer.currentVehicle == task.instance.taskObjectsByActorID.Tanner.coreData.agent and not localPlayer.inZap then
        params.dialogue = "GPMV01_FAILURE_L_2"
      else
        params.dialogue = "GPMV00_FAILURE_L_2"
      end
      feedbackSystem.stopMusic("Uid05907_CH03_Story_FreewayInferno_Stop")
      params.vehicle = taskObject.coreData.agent
      params.callback = failTask
      params.failReason = "ID:184643"
      params.rating = "FAIL"
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "Initial chase hud2" then
    if task.success then
      iCamCrashCam(task.instance.taskObjectsByActorID.Convoy1.coreData.agent.gameVehicle)
      GameVehicleResource.explode({
        gameVehicle = task.instance.taskObjectsByActorID.Convoy1.coreData.agent.gameVehicle,
        offset = vec.vector(1, -1, 0, 1),
        range = 1,
        strength = 20
      })
      GameVehicleResource.explode({
        gameVehicle = task.instance.taskObjectsByActorID.Convoy1.coreData.agent.gameVehicle,
        attachedVehicle = "Child",
        offset = vec.vector(1, -1, 0, 1),
        range = 1,
        strength = 500
      })
      feedbackSystem.removeSlot(1)
      feedbackSystem.menusMaster.blockHintButton(true)
    else
      if localPlayer.currentVehicle == task.instance.taskObjectsByActorID.Tanner.coreData.agent and not localPlayer.inZap then
        params.dialogue = "GPMV01_FAILURE_L_1"
      else
        params.dialogue = "GPMV00_FAILURE_L_1"
      end
      feedbackSystem.stopMusic("Uid05907_CH03_Story_FreewayInferno_Stop")
      params.vehicle = taskObject.coreData.agent
      params.failReason = "ID:184642"
      params.reason = "Wrecked"
      params.callback = failTask
      params.rating = "FAIL"
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "timer timer" then
    if task.success then
      if localPlayer.currentVehicle ~= task.instance.taskObjectsByActorID.Tanner.coreData.agent or localPlayer.inZap then
        localPlayer:zapToAgent(task.instance.taskObjectsByActorID.Tanner.coreData.agent)
      end
    else
      if localPlayer.currentVehicle == task.instance.taskObjectsByActorID.Tanner.coreData.agent and not localPlayer.inZap then
        params.dialogue = "GPMV01_FAILURE_L_1"
      else
        params.dialogue = "GPMV00_FAILURE_L_1"
      end
      feedbackSystem.stopMusic("Uid05907_CH03_Story_FreewayInferno_Stop")
      localPlayer:blockAbility("zap", false)
      params.vehicle = taskObject.coreData.agent
      params.failReason = "ID:184642"
      params.reason = "Wrecked"
      params.callback = failTask
      params.rating = "FAIL"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "Chase hud - delay hotspot" then
    if not task.success then
      if localPlayer.currentVehicle == task.instance.taskObjectsByActorID.Tanner.coreData.agent and not localPlayer.inZap then
        params.dialogue = "GPMV01_FAILURE_L_1"
      else
        params.dialogue = "GPMV00_FAILURE_L_1"
      end
      feedbackSystem.stopMusic("Uid05907_CH03_Story_FreewayInferno_Stop")
      localPlayer:blockAbility("zap", false)
      params.vehicle = taskObject.coreData.agent
      params.failReason = "ID:184642"
      params.reason = "Wrecked"
      params.callback = failTask
      params.rating = "FAIL"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "Wait for marker 2" then
    addUserUpdateFunction("displayPrompt", function()
      displayPrompt("ID:245538")
      removeUserUpdateFunction("displayPrompt")
      feedbackSystem.menusMaster.blockHintButton(false)
      feedbackSystem.menusMaster.setCurrentFocusString(6)
    end, 240, true)
  elseif task.specialName == "transition hud1" then
    task.instance.rubberbandRoute = "Peroxide Convoy Tanker 2 Route"
    challengeSystem.spawnActors(task.instance, "Never", {Convoy2 = true, Convoy3 = true})
    OneShotSound.Play("HUD_Play_Waypoint")
    GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID.Convoy2.coreData.agent.gameVehicle.position, 300)
    task.actor.rubberbandingActor = "Convoy2"
    feedbackSystem.menusMaster.blockHintButton(true)
    progressionSystem.triggerSoftSave({progression = 1})
  elseif task.specialName == "Chase hud3" then
    if 1 <= task.instance.taskObjectsByActorID.Convoy2.coreData.agent.damage then
      task.instance.taskObjectsByActorID.Tanner.coreData.actor.rubberbandingActor = "Convoy3"
    else
      task.instance.taskObjectsByActorID.Tanner.coreData.actor.rubberbandingActor = "Convoy2"
    end
  elseif task.specialName == "Convoy" then
    if task.success then
      if localPlayer.currentVehicle == task.instance.taskObjectsByActorID.Tanner.coreData.agent and not localPlayer.inZap then
        params.dialogue = "GPMV01_FAILURE_L_2"
      else
        params.dialogue = "GPMV00_FAILURE_L_2"
      end
      feedbackSystem.stopMusic("Uid05907_CH03_Story_FreewayInferno_Stop")
      params.callback = failTask
      params.failReason = "ID:184643"
      params.rating = "FAIL"
      params.vehicle = task.agent
      local endScreenPosition = vec.vector(1727.409, 44.65485, 1524.998, 1)
      local endScreenHeading = 1.993707
      GameVehicleResource.ClearAreaOfVehicles(endScreenPosition, 40)
      if task.actor.ID == "Convoy2" then
        if task.instance.taskObjectsByActorID.Convoy2 then
          task.instance.taskObjectsByActorID.Convoy2.coreData.agent:teleportToPositionAndHeading(endScreenPosition, endScreenHeading, nil, nil, nil, false)
          print("TELEPORTING")
        end
      elseif task.actor.ID == "Convoy3" and task.instance.taskObjectsByActorID.Convoy3 then
        task.instance.taskObjectsByActorID.Convoy3.coreData.agent:teleportToPositionAndHeading(endScreenPosition, endScreenHeading, nil, nil, nil, false)
        print("TELEPORTING")
      end
      addUserUpdateFunction("endScreenDelay", function()
        endScreenDelay(taskObject, params)
      end, 4, true)
    else
      iCamCrashCam(taskObject.coreData.agent.gameVehicle)
      GameVehicleResource.explode({
        gameVehicle = taskObject.coreData.agent.gameVehicle,
        offset = vec.vector(1, -1, 0, 1),
        range = 1,
        strength = 10
      })
      if task.actor.ID == "Convoy2" then
        task.instance.taskObjectsByActorID.Tanner.coreData.actor.rubberbandingActor = "Convoy3"
        if task.instance.taskObjectsByActorID.Convoy3 then
          task.instance.taskObjectsByActorID.Convoy3.coreData.actor.aiIgnorePlayers = false
          task.instance.taskObjectsByActorID.Convoy3.coreData.agent:highSpeedDrive({
            traits = taskSystem.buildDriveTraits(task.instance.taskObjectsByActorID.Convoy3.coreData),
            roadRoute = routes[task.actor.routeName].roads,
            routeName = task.actor.routeName
          })
        end
      else
        task.instance.taskObjectsByActorID.Tanner.coreData.actor.rubberbandingActor = "Convoy2"
        if task.instance.taskObjectsByActorID.Convoy2 then
          task.instance.taskObjectsByActorID.Convoy2.coreData.actor.aiIgnorePlayers = false
          task.instance.taskObjectsByActorID.Convoy2.coreData.agent:highSpeedDrive({
            traits = taskSystem.buildDriveTraits(task.instance.taskObjectsByActorID.Convoy2.coreData),
            roadRoute = routes[task.actor.routeName].roads,
            routeName = task.actor.routeName
          })
        end
      end
    end
  elseif task.specialName == "Pile-up hud3" then
    if task.success then
      feedbackSystem.stopMusic("Uid05907_CH03_Story_FreewayInferno_Stop")
    else
      feedbackSystem.stopMusic("Uid05907_CH03_Story_FreewayInferno_Stop")
      if localPlayer.currentVehicle == task.instance.taskObjectsByActorID.Tanner.coreData.agent and not localPlayer.inZap then
        params.dialogue = "GPMV01_FAILURE_L_1"
      else
        params.dialogue = "GPMV00_FAILURE_L_1"
      end
      params.vehicle = taskObject.coreData.agent
      params.failReason = "ID:184642"
      params.reason = "Wrecked"
      params.callback = failTask
      params.rating = "FAIL"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "Back to tanner again hud1" then
    if task.instance.taskObjectsByActorID.Tanner.coreData.agent ~= localPlayer.currentVehicle or localPlayer.inZap then
      localPlayer:zapToAgent(task.instance.taskObjectsByActorID.Tanner.coreData.agent)
    end
  elseif task.specialName == "Waiting for pile-up hud1" then
    if task.success then
      feedbackSystem.stopMusic("Uid05907_CH03_Story_FreewayInferno_Stop")
      localPlayer:blockAbility("zap", false)
      params.callback = completeTask
      params.dialogue = ""
      params.rating = "PASS"
      localPlayer.challenge.endScreen(taskObject, params)
    else
      if localPlayer.currentVehicle == task.instance.taskObjectsByActorID.Tanner.coreData.agent and not localPlayer.inZap then
        params.dialogue = "GPMV01_FAILURE_L_1"
      else
        params.dialogue = "GPMV00_FAILURE_L_1"
      end
      feedbackSystem.stopMusic("Uid05907_CH03_Story_FreewayInferno_Stop")
      localPlayer:blockAbility("zap", false)
      params.vehicle = taskObject.coreData.agent
      params.failReason = "ID:184642"
      params.reason = "Wrecked"
      params.callback = failTask
      params.rating = "FAIL"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  end
end
missionEndCallback["Peroxide convoy"] = function(instance)
  instance.taskObjectsByActorID.Tanner.coreData.actor.rubberbandingActor = "Convoy1"
  instance.rubberbandRoute = nil
  feedbackSystem.menusMaster.blockHintButton(false)
end
