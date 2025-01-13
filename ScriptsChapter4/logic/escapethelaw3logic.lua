module("cardSystem.logic")
missionSetupData["Escape the law 3"] = {}
local timeToGetToTheMeet = 180
local createCheckpointMinorOrder = function(HUD, audio, number)
  local minorOrder = {
    task = "Linear Checkpoints No AI",
    specialName = "checkpoint " .. tostring(number),
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
      },
      {
        failCondition = true,
        forceTaskComplete = true,
        {goal = "Got busted"}
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
    audioPIP = audio
  }
  return minorOrder
end
local createFinalCheckpointMinorOrder = function(HUD, audio)
  local minorOrder = {
    task = "Linear Checkpoints",
    specialName = "final checkpoint",
    dynamicTargets = true,
    groupProgression = {priorityMinorOrder = true},
    goalConditions = {
      {
        {
          goal = "Within radius",
          params = {value = 22}
        },
        {
          goal = "Being chased",
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
      },
      {
        failCondition = true,
        forceTaskComplete = true,
        {goal = "Got busted"}
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
      },
      {
        manager = "Target list",
        settings = {
          styles = {
            Hotspot = {discScale = 18}
          }
        }
      }
    }
  }
  return minorOrder
end
local createSpawnNewCopMinorOrder = function(HUD, number)
  local minorOrder = {
    task = "No AI",
    specialName = "out of cops " .. tostring(number),
    groupProgression = {importantMinorOrder = false},
    goalConditions = {
      {
        autoRefresh = true,
        {
          goal = "Losing last chaser"
        },
        {
          goal = "Time trigger",
          params = {value = 5}
        }
      }
    },
    HUD = {
      {
        style = HUD,
        settings = {outOfCops = true}
      }
    }
  }
  return minorOrder
end
local createLostCopsMinorOrder = function(HUD, number)
  local minorOrder = {
    task = "No AI",
    specialName = "lost the cops" .. tostring(number),
    groupProgression = {importantMinorOrder = false},
    taskConditions = {
      {
        {
          goal = "Being chased",
          params = {inverse = true}
        }
      }
    }
  }
  return minorOrder
end
local createDamageAudioMinorOrder = function(audio, number, damageValue)
  local minorOrder = {
    task = "No AI",
    groupProgression = {importantMinorOrder = false},
    specialName = "Damage audio " .. tostring(damageValue) .. " " .. tostring(number),
    taskConditions = {
      {
        {
          goal = "Damage has gone above",
          params = {value = damageValue}
        }
      },
      {
        failCondition = true,
        {
          goal = "Damage above",
          params = {value = damageValue}
        },
        {
          goal = "Time trigger",
          params = {value = 0.5}
        }
      }
    },
    audioPIP = audio
  }
  return minorOrder
end
local createZapAudioMinorOrder = function(audio, number)
  local minorOrder = {
    task = "No AI",
    groupProgression = {importantMinorOrder = false},
    specialName = "In zap audio " .. tostring(number),
    goalConditions = {
      {
        {
          goal = "Player in zap",
          params = {value = true}
        }
      }
    },
    audioPIP = audio
  }
  return minorOrder
end
local createReminderAudioMinorOrder = function(audio, number)
  local minorOrder = {
    task = "No AI",
    dynamicTargets = true,
    specialName = "distance cop reminder " .. tostring(number),
    groupProgression = {importantMinorOrder = false},
    goalConditions = {
      {
        skipTargetUpdate = true,
        autoRefresh = true,
        {
          goal = "Being chased"
        },
        {
          goal = "Time trigger",
          params = {value = 20}
        },
        {
          goal = "Event active",
          params = {inverse = true}
        }
      },
      {
        skipTargetUpdate = true,
        autoRefresh = true,
        {
          goal = "Being chased",
          params = {inverse = true}
        },
        {
          goal = "Time trigger",
          params = {value = 15}
        },
        {
          goal = "Event active",
          params = {inverse = true}
        }
      }
    },
    audioPIP = audio
  }
  return minorOrder
end
local function evadeTask(goalParams, HUD, audio)
  local task = {
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
          }
        }
      },
      {task = "Wander"}
    },
    {
      createCheckpointMinorOrder(HUD, audio, 1),
      createSpawnNewCopMinorOrder(HUD, 1),
      {task = "Wander"},
      {
        task = "No AI",
        specialName = "Prompt and pip",
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 6}
            }
          }
        },
        audioPIP = audio,
        HUD = {
          {style = HUD}
        }
      }
    },
    {
      createCheckpointMinorOrder(HUD, audio, 2),
      createSpawnNewCopMinorOrder(HUD, 2),
      {task = "Wander"}
    },
    {
      createCheckpointMinorOrder(HUD, audio, 3),
      createSpawnNewCopMinorOrder(HUD, 3),
      {task = "Wander"}
    },
    {
      {
        task = "No AI",
        specialName = "softsave",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0}
            }
          }
        }
      }
    },
    {
      createCheckpointMinorOrder(HUD, audio, 4),
      createSpawnNewCopMinorOrder(HUD, 4),
      createDamageAudioMinorOrder(audio, 4, 0.35),
      createDamageAudioMinorOrder(audio, 4, 0.6),
      createDamageAudioMinorOrder(audio, 4, 0.85),
      createZapAudioMinorOrder(audio, 4),
      createReminderAudioMinorOrder(audio, 4),
      {task = "Wander"},
      {
        task = "No AI",
        specialName = "ambush trigger1",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
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
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "ambush trigger2",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
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
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      }
    },
    {
      createCheckpointMinorOrder(HUD, audio, 5),
      createSpawnNewCopMinorOrder(HUD, 5),
      createDamageAudioMinorOrder(audio, 5, 0.35),
      createDamageAudioMinorOrder(audio, 5, 0.6),
      createDamageAudioMinorOrder(audio, 5, 0.85),
      createZapAudioMinorOrder(audio, 5),
      createReminderAudioMinorOrder(audio, 5),
      {task = "Wander"},
      {
        task = "No AI",
        specialName = "barn icam",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 6}
            },
            {goal = "Is jumping"}
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
    },
    {
      {
        task = "No AI",
        specialName = "softsave 02",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0}
            }
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "checkpoint lose the cops",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Being chased",
              params = {inverse = true}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {goal = "Got busted"}
          },
          {
            failCondition = true,
            forceTaskComplete = true,
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
              params = {value = timeToGetToTheMeet}
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
            style = HUD,
            settings = {updateTimer = true}
          }
        }
      },
      createDamageAudioMinorOrder(audio, 6, 0.35),
      createDamageAudioMinorOrder(audio, 6, 0.6),
      createDamageAudioMinorOrder(audio, 6, 0.85),
      createZapAudioMinorOrder(audio, 6),
      createReminderAudioMinorOrder(audio, 6),
      {
        task = "No AI",
        specialName = "Play penultimate audio",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Being chased"
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      createFinalCheckpointMinorOrder(HUD, audio),
      {
        task = "No AI",
        specialName = "Prompt get to the meet",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Being chased",
              params = {inverse = true}
            },
            {
              goal = "Prompt active",
              params = {promptType = "MiniMap", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = HUD,
            settings = {updateTimer = true}
          }
        }
      },
      createDamageAudioMinorOrder(audio, 7, 0.35),
      createDamageAudioMinorOrder(audio, 7, 0.6),
      createDamageAudioMinorOrder(audio, 7, 0.85),
      createZapAudioMinorOrder(audio, 7),
      [10] = createReminderAudioMinorOrder(audio, 7)
    }
  }
  return task
end
local chaseTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {task = "No AI"}
    }
  }
  return task
end
local dropoffTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {task = "No AI"}
    }
  }
  return task
end
local roadblockTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "passedRoadblock",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 55}
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
local roadblock2Task = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "hitRoadblock",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Struck by player"
            }
          },
          {
            {
              goal = "Agent within then outside radius of target",
              params = {value = 35}
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
local specialRoadblockTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "specialRoadblock",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 32}
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
    },
    {
      {
        task = "No AI",
        specialName = "specialRoadblock wander",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        }
      }
    }
  }
  return task
end
local specialRoadblockTask2 = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "specialRoadblock2",
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
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "specialRoadblock2 wander",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Escape the law 3"].taskCreatorFunctionLookups = {
  ["Evade team"] = evadeTask,
  ["Chase team"] = chaseTask,
  ["Dropoff team"] = dropoffTask,
  ["Roadblock team"] = roadblockTask,
  ["Roadblock 2 team"] = roadblock2Task,
  ["Roadblocker 4 (group1)"] = specialRoadblockTask,
  ["Roadblocker 3 (group1)"] = specialRoadblockTask2
}
local evaderGameVehicle = false
local enteredFromWrongDirection = false
local function addToChase(taskObject, ID, instance)
  if not Getaway.IsBeingChased(evaderGameVehicle) then
    felony_getaway.addEvader(evaderGameVehicle)
  end
  if instance and instance.taskObjectsByActorID[ID] then
    felony_getaway.addChaser(evaderGameVehicle, instance.taskObjectsByActorID[ID].coreData.agent.gameVehicle)
  elseif taskObject and taskObject.coreData.instance.taskObjectsByActorID[ID] then
    felony_getaway.addChaser(evaderGameVehicle, taskObject.coreData.instance.taskObjectsByActorID[ID].coreData.agent.gameVehicle)
  end
end
local PAdata = {
  Drift = 0.5,
  Jump = 0.5,
  Overtake = 0.5,
  OvertakeOncomming = 0.5,
  Trailer = 1,
  HighSpeedDriving = 1.07,
  SafeDriving = 1.07,
  PlayerCollision = 0,
  DrivingInAnAlley = 2
}
missionSetupData["Escape the law 3"].initiate = function(instance)
  count = 0
  evaderGameVehicle = false
  enteredFromWrongDirection = false
  evaderGameVehicle = instance.taskObjectsByActorID["evade team member 1"].coreData.agent.gameVehicle
  felony_getaway.addEvader(evaderGameVehicle)
  feedbackSystem.menusMaster.setCurrentFocusString(1)
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    if softSaveData.progression == 1 then
      challengeSystem.spawnActors(instance, "Never", {
        ["chase team member 1 (softsave 1)"] = true,
        ["chase team member 2 (softsave 1)"] = true,
        ["chase team member 3 (softsave 1)"] = true,
        ["chase team member 4 (softsave 1)"] = true,
        ["chase team member 5 (softsave 1)"] = true,
        ["chase team member 6 (softsave 1)"] = true
      })
      addToChase(nil, "chase team member 1 (softsave 1)", instance)
      addToChase(nil, "chase team member 2 (softsave 1)", instance)
      addToChase(nil, "chase team member 3 (softsave 1)", instance)
      addToChase(nil, "chase team member 4 (softsave 1)", instance)
      addToChase(nil, "chase team member 5 (softsave 1)", instance)
      addToChase(nil, "chase team member 6 (softsave 1)", instance)
      instance.taskObjectsByActorID["evade team member 1"].coreData.agent.gameVehicle.speed = 20
    elseif softSaveData.progression == 2 then
      GameVehicleResource.ClearAreaOfVehicles(vec.vector(-1495.255, 182.3713, 4139.484, 1), 20)
      challengeSystem.spawnActors(instance, "Never", {
        ["chase team member 1 (softsave 2)"] = true,
        ["chase team member 2 (softsave 2)"] = true,
        ["chase team member 3 (softsave 2)"] = true,
        ["chase team member 4 (softsave 2)"] = true
      })
      addToChase(nil, "chase team member 1 (softsave 2)", instance)
      addToChase(nil, "chase team member 2 (softsave 2)", instance)
      addToChase(nil, "chase team member 3 (softsave 2)", instance)
      addToChase(nil, "chase team member 4 (softsave 2)", instance)
      instance.taskObjectsByActorID["evade team member 1"].coreData.agent.gameVehicle.speed = 20
      feedbackSystem.menusMaster.setCurrentFocusString(2)
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184738")
      PlayerAnalysis.AddWeight("Getaway", PAdata)
    end
    feedbackSystem.startMusic("Uid05966_CH07_Standard_TheGetaway_Play")
  else
    for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team == "Chase team" then
        felony_getaway.addChaser(evaderGameVehicle, taskObject.coreData.agent.gameVehicle)
      end
    end
  end
  createFixedPosition(instance, {
    startPositions["Escape the law 3 checkpoint 1"].position
  }, 1)
  createFixedPosition(instance, {
    startPositions["Escape the law 3 checkpoint 2"].position
  }, 2)
  createFixedPosition(instance, {
    startPositions["Escape the law 3 checkpoint 3"].position
  }, 3)
  createFixedPosition(instance, {
    startPositions["Escape the law 3 checkpoint 4"].position
  }, 4)
  createFixedPosition(instance, {
    startPositions["Escape the law 3 checkpoint 5"].position
  }, 5)
  createFixedPosition(instance, {
    startPositions["Escape the law 3 end"].position
  }, 6)
  createFixedPosition(instance, {
    [4] = vec.vector(-1335.785, 179.9408, 4315.062, 1)
  }, 7)
  createFixedPosition(instance, {
    startPositions["Escape the law 3 ambush trigger1"].position
  }, 8)
  createFixedPosition(instance, {
    startPositions["Escape the law 3 ambush icam"].position
  }, 9)
  challengeSystem.spawnActors(instance, "Never", {
    ["Roadblocker 1 (group1)"] = true,
    ["Roadblocker 2 (group1)"] = true,
    ["Roadblocker 3 (group1)"] = true,
    ["Roadblocker 4 (group1)"] = true
  })
  propSystem.setupRuntimeProps(instance.challenge.props, false, false)
end
missionSetupData["Escape the law 3"].update = nil
local function getEvadeTeamDynamicTargets(taskObject, task, dynamicListID, goalConditionKey)
  if string.find(task.specialName, "checkpoint") then
    if dynamicListID then
      return false, true
    elseif task.specialName == "checkpoint 1" then
      return checkpointSystem.getCheckpoints(task.instance, 1), false
    elseif task.specialName == "checkpoint 2" then
      return checkpointSystem.getCheckpoints(task.instance, 2), false
    elseif task.specialName == "checkpoint 3" then
      return checkpointSystem.getCheckpoints(task.instance, 3), false
    elseif task.specialName == "checkpoint 4" then
      return checkpointSystem.getCheckpoints(task.instance, 4), false
    elseif task.specialName == "checkpoint 5" then
      return checkpointSystem.getCheckpoints(task.instance, 5), false
    elseif task.specialName == "checkpoint lose the cops" then
      task.instance.networkVars.startTime = g_NetworkTime
      return checkpointSystem.getCheckpoints(task.instance, 6), false
    elseif task.specialName == "checkpoint lose cops prompt 1" then
      return checkpointSystem.getCheckpoints(task.instance, 6), false
    elseif task.specialName == "final checkpoint" then
      return checkpointSystem.getCheckpoints(task.instance, 6), false
    elseif task.specialName == "checkpoint lose cops prompt 2" then
      return checkpointSystem.getCheckpoints(task.instance, 6), false
    end
  elseif string.find(task.specialName, "distance cop reminder") then
    return checkpointSystem.getCheckpoints(task.instance, 6), false
  elseif task.specialName == "ambush trigger1" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 8), false
    end
  elseif task.specialName == "ambush trigger2" then
    if dynamicListID then
      if dynamicListID == 2 then
        enteredFromWrongDirection = true
      end
      return false, true
    else
      return {
        checkpointSystem.getCheckpoints(task.instance, 4)[1],
        checkpointSystem.getCheckpoints(task.instance, 7)[1]
      }, false
    end
  elseif task.specialName == "barn icam" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 9), false
    end
  end
end
local roadblockTeamDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID["evade team member 1"].coreData.agent
    }, false
  end
end
missionSetupData["Escape the law 3"].targetList = {
  ["Evade team"] = getEvadeTeamDynamicTargets,
  ["Roadblock team"] = roadblockTeamDynamicTargets,
  ["Roadblock 2 team"] = roadblockTeamDynamicTargets
}
taskCompleteData["Escape the law 3"] = {}
taskCompleteData["Escape the law 3"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = taskObject.coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235490"
  }
  if task.success then
    if string.find(task.specialName, "checkpoint") then
      OneShotSound.Play("HUD_Play_Waypoint")
      local showRemainingCheckpoints = function(checkpointsRemaining)
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:243824", value = checkpointsRemaining})
      end
      if task.specialName == "checkpoint 1" then
        showRemainingCheckpoints(5)
        feedbackSystem.startMusic("Uid05966_CH07_Standard_TheGetaway_Play")
      elseif task.specialName == "checkpoint 2" then
        showRemainingCheckpoints(4)
      elseif task.specialName == "checkpoint 3" then
        showRemainingCheckpoints(3)
      elseif task.specialName == "checkpoint 4" then
        showRemainingCheckpoints(2)
        local function deleteActor(actorID)
          if task.instance.taskObjectsByActorID[actorID] then
            task.instance.taskObjectsByActorID[actorID]:delete()
          end
        end
        deleteActor("Roadblocker 1 (group1)")
        deleteActor("Roadblocker 2 (group1)")
        deleteActor("Roadblocker 3 (group1)")
        deleteActor("Roadblocker 4 (group1)")
      elseif task.specialName == "checkpoint 5" then
        if Getaway.IsBeingChased(task.agent.gameVehicle) then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:184738")
          feedbackSystem.menusMaster.setCurrentFocusString(2)
        else
          feedbackSystem.menusMaster.primaryTextPrompt("ID:245528")
          feedbackSystem.menusMaster.setCurrentFocusString(3)
        end
        challengeSystem.spawnActors(task.instance, "Never", {
          ["Dropoff vehicle"] = true
        })
        zapcontroller.AddLockedVehicle({
          gameVehicle = task.instance.taskObjectsByActorID["Dropoff vehicle"].coreData.agent.gameVehicle
        })
      elseif task.specialName == "final checkpoint" then
        local function completeTask()
          progressionSystem.challengeComplete(task.instance, task.agent.matrix)
        end
        params.callback = completeTask
        params.dialogue = "GPMV00_SUCCESS_L_1"
        params.rating = "PASS"
        localPlayer.challenge.endScreen(taskObject, params)
      end
    elseif task.specialName == "specialRoadblock" then
      task.instance.taskObjectsByActorID["Roadblocker 4 (group1)"].coreData.agent.gameVehicle.speed = 4.2
    elseif task.specialName == "specialRoadblock2" then
      addToChase(taskObject, taskObject.coreData.actor.ID)
    elseif task.specialName == "specialRoadblock wander" then
      addToChase(taskObject, taskObject.coreData.actor.ID)
    elseif task.specialName == "softsave" then
      progressionSystem.triggerSoftSave({progression = 1})
      if not enteredFromWrongDirection then
        challengeSystem.spawnActors(task.instance, "Never", {
          ["Roadblocker 1 (group2)"] = true,
          ["Roadblocker 2 (group2)"] = true,
          ["Roadblocker 4 (group2)"] = true,
          ["Roadblocker 6 (group2)"] = true,
          ["Roadblocker 8 (group2)"] = true,
          ["Roadblocker 10 (group2)"] = true,
          ["Roadblocker 7 (group2)"] = true
        })
      end
    elseif task.specialName == "softsave 02" then
      progressionSystem.triggerSoftSave({progression = 2})
    elseif task.specialName == "hitRoadblock" then
      if taskObject.coreData.actor.ID == "Roadblocker 1 (group1)" or taskObject.coreData.actor.ID == "Roadblocker 2 (group1)" then
        addToChase(nil, "Roadblocker 1 (group1)", task.instance)
        addToChase(nil, "Roadblocker 2 (group1)", task.instance)
      else
        addToChase(taskObject, taskObject.coreData.actor.ID)
      end
    elseif task.specialName == "passedRoadblock" or task.specialName == "add me to chase" then
      addToChase(taskObject, taskObject.coreData.actor.ID)
    elseif task.specialName == "ambush trigger1" then
      challengeSystem.spawnActors(task.instance, "Never", {
        ["chase team member 4"] = true
      })
      addToChase(taskObject, "chase team member 4")
    elseif task.specialName == "ambush trigger2" then
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Roadblocker 1 (group2)"] = true,
        ["Roadblocker 2 (group2)"] = true,
        ["Roadblocker 4 (group2)"] = true,
        ["Roadblocker 6 (group2)"] = true,
        ["Roadblocker 8 (group2)"] = true,
        ["Roadblocker 10 (group2)"] = true,
        ["Roadblocker 7 (group2)"] = true
      })
    elseif task.specialName == "barn icam" then
      if not enteredFromWrongDirection then
        local targets = {
          task.instance.taskObjectsByActorID["evade team member 1"].coreData.agent.gameVehicle
        }
        if task.instance.taskObjectsByActorID["Roadblocker 2 (group2)"] then
          targets[2] = task.instance.taskObjectsByActorID["Roadblocker 2 (group2)"].coreData.agent.gameVehicle
        else
          for k, v in next, task.instance.taskObjectsByActorID, nil do
            if string.find(k, "(group2)") then
              targets[2] = v.coreData.agent.gameVehicle
              break
            end
          end
        end
        local fixedPositions = {
          [5] = vec.vector(-1154.658, 180.8676, 4368.355, 1)
        }
        local iCamTable = {
          cameraTargets = targets,
          duration = 3.5,
          speed = 0.4,
          framing = "verywide",
          angleYaw = "front",
          anglePitch = "mid",
          fixedCameras = fixedPositions,
          disableAI = true
        }
        iCamActivationTableInput(iCamTable)
      end
      addToChase(taskObject, "Roadblocker 1 (group2)")
      addToChase(taskObject, "Roadblocker 2 (group2)")
      addToChase(taskObject, "Roadblocker 4 (group2)")
    end
  else
    local function failTask()
      progressionSystem.challengeFailed(task.instance, task.agent.matrix)
    end
    params.callback = failTask
    params.rating = "FAIL"
    if string.find(task.specialName, "checkpoint") then
      if task.condition == 2 then
        params.dialogue = "GPMV01_FAILURE_L_1"
        params.failReason = task.instance.challenge.taskCompleteData.Arrested
        params.reason = "Busted"
      elseif task.condition == 3 then
        params.dialogue = "GPMV01_FAILURE_L_2"
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
        params.reason = "Wrecked"
      elseif task.condition == 4 or task.condition == 5 then
        params.vehicle = localPlayer.currentVehicle
        params.dialogue = "GPMV01_FAILURE_L_1"
        params.failReason = "ID:184828"
      end
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "Prompt get to the meet" then
      params.vehicle = localPlayer.currentVehicle
      params.failReason = "ID:184828"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  end
end
missionEndCallback["Escape the law 3"] = function(instance)
  if instance.taskObjectsByActorID["Dropoff vehicle"] then
    zapcontroller.RemoveLockedVehicle({
      gameVehicle = instance.taskObjectsByActorID["Dropoff vehicle"].coreData.agent.gameVehicle
    })
  end
end
