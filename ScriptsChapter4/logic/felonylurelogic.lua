module("cardSystem.logic")
missionSetupData["Felony lure"] = {}
local createPayloadMinorOrder = function(goalParams, HUD, audio, specialName)
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
          goal = "Payload under",
          params = {value = 50}
        },
        {
          goal = "Vehicle is in alley",
          params = {inverse = true}
        },
        {
          goal = "Time trigger",
          params = {value = 0.3}
        },
        {
          goal = "Change payload by amount",
          params = {value = 2}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Payload over",
          params = {value = 50}
        },
        {
          goal = "Payload under",
          params = {value = 80}
        },
        {
          goal = "Vehicle is in alley",
          params = {inverse = true}
        },
        {
          goal = "Time trigger",
          params = {value = 0.5}
        },
        {
          goal = "Change payload by amount",
          params = {value = 2}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Payload over",
          params = {value = 80}
        },
        {
          goal = "Vehicle is in alley",
          params = {inverse = true}
        },
        {
          goal = "Time trigger",
          params = {value = 0.68}
        },
        {
          goal = "Change payload by amount",
          params = {value = 2}
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
        },
        {
          goal = "Change payload by amount",
          params = {value = 2}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Payload under",
          params = {value = 50}
        },
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
          params = {force = 5000, type = "Vehicle"}
        },
        {
          goal = "Change payload by amount",
          params = {value = 10}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Payload over",
          params = {value = 50}
        },
        {
          goal = "Payload under",
          params = {value = 80}
        },
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
          params = {force = 5000, type = "Vehicle"}
        },
        {
          goal = "Change payload by amount",
          params = {value = 7.5}
        }
      },
      {
        autoRefresh = true,
        {
          goal = "Payload over",
          params = {value = 80}
        },
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
          params = {force = 5000, type = "Vehicle"}
        },
        {
          goal = "Change payload by amount",
          params = {value = 5}
        }
      },
      {
        {
          goal = "Payload over",
          params = {value = 25}
        },
        {
          goal = "Change payload by amount",
          params = {value = 0}
        }
      },
      {
        {
          goal = "Prompt active",
          params = {promptType = "Primary", inverse = true}
        },
        {
          goal = "Time trigger",
          params = {value = 20}
        },
        {
          goal = "Payload over",
          params = {value = 25}
        },
        {
          goal = "Change payload by amount",
          params = {value = 0}
        }
      },
      {
        {
          goal = "Prompt active",
          params = {promptType = "Primary", inverse = true}
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
        triggerCount = 1,
        {
          goal = "Payload over",
          params = {value = 10}
        },
        {
          goal = "Vehicle is in alley"
        },
        {
          goal = "Change payload by amount",
          params = {value = 0}
        }
      },
      {
        triggerCount = 1,
        {
          goal = "Vehicle is in alley",
          params = {inverse = true}
        },
        {
          goal = "Change payload by amount",
          params = {value = 0}
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
        style = "Felony lure HUD"
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
        specialName = "Mission start",
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
            style = "Felony lure HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Destination A",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Agent stopped inside radius",
              params = {
                value = 10,
                stopDuration = 1,
                unlockBrakes = true
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
                Hotspot = {}
              }
            }
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
            style = "Felony lure HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Start of mission dialogue",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 4}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Turn the player part 1",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {value = true}
            },
            {
              goal = "Player within radius of point",
              params = {
                value = 20,
                position = vec.vector(-93.83453, 30.69354, 936.0621, 1)
              }
            },
            {
              goal = "Is target ahead",
              params = {inverse = true, angle = -0.9}
            }
          },
          {
            {
              goal = "Is player controlled",
              params = {value = true}
            },
            {
              goal = "Player within radius of point",
              params = {
                value = 20,
                position = vec.vector(-93.83453, 30.69354, 936.0621, 1)
              }
            },
            {
              goal = "Is target ahead"
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
    },
    {
      {
        task = "No AI",
        specialName = "Pause to bring the HUD elements in",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 5}
            },
            {
              goal = "Event active",
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
        task = "No AI",
        specialName = "Trigger softsave 1",
        taskConditions = {
          {
            {
              goal = "Event active",
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
        task = "Linear Checkpoints",
        specialName = "Destination B timed drive through alleyways",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Agent stopped inside radius",
              params = {
                value = 10,
                stopDuration = 1,
                unlockBrakes = false
              }
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
              goal = "Completed lap",
              params = {value = 0}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Time trigger",
              params = {value = 150}
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
            style = "Felony lure HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Dest B instructions",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        HUD = {
          {
            style = "Felony lure HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Destination B mission speech triggers",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            skipTargetUpdate = true,
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 15}
            },
            {
              goal = "Within radius",
              params = {value = 150, inverse = true}
            }
          },
          {
            triggerCount = 1,
            skipTargetUpdate = true,
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 55}
            },
            {
              goal = "Within radius",
              params = {value = 150, inverse = true}
            }
          },
          {
            triggerCount = 1,
            skipTargetUpdate = true,
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 80}
            },
            {
              goal = "Within radius",
              params = {value = 150, inverse = true}
            }
          },
          {
            triggerCount = 1,
            skipTargetUpdate = true,
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 110}
            },
            {
              goal = "Within radius",
              params = {value = 150, inverse = true}
            }
          },
          {
            triggerCount = 1,
            skipTargetUpdate = true,
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 140}
            },
            {
              goal = "Within radius",
              params = {value = 150, inverse = true}
            }
          },
          {
            autoRefresh = true,
            skipTargetUpdate = true,
            {
              goal = "Recent audio played",
              params = {value = 10}
            },
            {
              goal = "Vehicle is in alley",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      },
      [10] = createPayloadMinorOrder(goalParams, HUD, audio, "Use alleys")
    },
    {
      {
        task = "No AI",
        specialName = "Turn the player part 2",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Is target ahead",
              params = {inverse = true, angle = -0.9}
            }
          },
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Is target ahead"
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
        HUD = {
          {
            style = "Felony lure HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Felony lure section instructions",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
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
        HUD = {
          {
            style = "Felony lure HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Pause to bring the HUD elements in DEUX",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            }
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Player lures cops to the kidnapper",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Being chased",
              params = {
                numberOfChasers = 2,
                condition = "moreThan",
                NumberOfChasersShownOnTheHud = true
              }
            },
            {
              goal = "Within radius",
              params = {value = 40}
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
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {goal = "Got busted"}
          },
          {
            failCondition = true,
            {
              goal = "Time trigger",
              params = {value = 180},
              feedback = "Time"
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
            style = "Felony lure HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "AI drives to kidnapper having too few cops",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Being chased",
              params = {
                numberOfChasers = 3,
                condition = "lessThan",
                NumberOfChasersShownOnTheHud = true
              }
            },
            {
              goal = "Within radius",
              params = {value = 45}
            }
          },
          {
            {
              goal = "Being chased",
              params = {
                numberOfChasers = 2,
                condition = "moreThan",
                NumberOfChasersShownOnTheHud = true
              }
            },
            {
              goal = "Within radius",
              params = {value = 45}
            }
          },
          {
            {
              goal = "Being chased",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 45}
            }
          }
        },
        HUD = {
          {
            style = "Felony lure HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Highlighted cop car manager",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Being chased",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          },
          {
            {
              goal = "Being chased"
            }
          }
        },
        HUD = {
          {
            style = "Felony lure HUD"
          }
        }
      }
    }
  }
  return task
end
local kidnapperTask = function(goalParams, HUD, audio)
  local task = {
    {
      {task = "No AI"}
    }
  }
end
missionSetupData["Felony lure"].taskCreatorFunctionLookups = {
  ["Player team"] = playerTask,
  ["Kidnapper team"] = kidnapperTask
}
local destinationA = vec.vector(-93.83453, 30.69354, 936.0621, 1)
local destinationAheadingPoint = vec.vector(-146.9498, 18.94304, 984.2425, 1)
local destinationB = vec.vector(-3345.92, 52.1796, 1398.829, 1)
local destinationBheadingPoint = vec.vector(-3380.346, 53.67186, 1371.369, 1)
local destinationC = vec.vector(-2270.136, 2.795701, -264.2636, 1)
missionSetupData["Felony lure"].initiate = function(instance)
  createFixedPosition(instance, {destinationA}, 100)
  createFixedPosition(instance, {destinationAheadingPoint}, 103)
  createFixedPosition(instance, {destinationB}, 101)
  createFixedPosition(instance, {destinationBheadingPoint}, 104)
  createFixedPosition(instance, {destinationC}, 102)
end
missionSetupData["Felony lure"].update = nil
local playerTeamDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "Destination A" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 100), false
    end
  elseif task.specialName == "Destination B timed drive through alleyways" then
    OneShotSound.Play("Suspicion_Meter_Play")
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 101), false
    end
  elseif task.specialName == "Destination B mission speech triggers" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 101), false
    end
  elseif task.specialName == "Player lures cops to the kidnapper" or task.specialName == "AI drives to kidnapper having too few cops" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 102), false
    end
  elseif task.specialName == "Turn the player part 1" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 103), false
    end
  elseif task.specialName == "Turn the player part 2" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 104), false
    end
  end
end
missionSetupData["Felony lure"].targetList = {
  ["Player team"] = playerTeamDynamicTargets
}
taskCompleteData["Felony lure"] = {}
taskCompleteData["Felony lure"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.MissionVehicle.coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    passCondition = task.instance.challenge.taskCompleteData["Pass condition"],
    passReward = task.instance.challenge.taskCompleteData["Pass reward"],
    hintIcon1 = localPlayer.buttonLayout.minimapZoom
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function zapToMission()
    if not localPlayer.zapTransition then
      if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle ~= task.instance.taskObjectsByActorID.MissionVehicle.coreData.agent.gameVehicle then
        localPlayer:SetZapLevel(1)
      end
      if localPlayer.inZap then
        localPlayer:SetZapLevel(0, task.instance.taskObjectsByActorID.MissionVehicle.coreData.agent, true)
      end
      removeUserUpdateFunction("waitForZap")
    end
  end
  if task.success then
    if task.specialName == "Player lures cops to the kidnapper" then
      params.callback = completeTask
      params.successReason = "ID:186155"
      params.rating = "PASS"
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "Destination A" or task.specialName == "Turn the player part 1" then
      addUserUpdateFunction("waitForZap", zapToMission, 1)
      if localPlayer.currentVehicle.abilityActive then
        localPlayer.currentVehicle:cancelAbility(localPlayer.localID)
      end
      replays.pause()
      localPlayer.cameraSupport.miniSceneCamera()
      localPlayer:enterCutsceneMode()
    elseif task.specialName == "Trigger softsave 1" then
      progressionSystem.triggerSoftSave({progression = 1})
    elseif task.specialName == "Pause to bring the HUD elements in" then
      replays.unPause()
    elseif task.specialName == "Destination B timed drive through alleyways" then
      addUserUpdateFunction("waitForZap", zapToMission, 1)
      if localPlayer.currentVehicle.abilityActive then
        localPlayer.currentVehicle:cancelAbility(localPlayer.localID)
      end
      replays.pause()
      localPlayer.cameraSupport.miniSceneCamera()
      localPlayer:enterCutsceneMode()
    elseif task.specialName == "Felony lure section instructions" then
      replays.unPause()
      progressionSystem.triggerSoftSave({progression = 2})
      felony_patrollingVehicleManager.enablePatrollingVehicles(true)
      feedbackSystem.startMusic("Uid04942_SM_FelonyLure_Play")
    end
  else
    local function failTask()
      minimap.RemoveAllHighlightedVehicleModelUIDs()
      localPlayer.minimapSupport.highlightedVehicles = false
      progressionSystem.challengeFailed(task.instance, task.agent.matrix)
    end
    local failReasons = {
      ["out of time 1"] = "ID:186145",
      ["collision"] = "ID:186146",
      ["wrecked"] = "ID:186147",
      ["draw attention"] = "ID:186146",
      ["out of time 2"] = "ID:186148",
      ["not enough cops"] = "ID:186149",
      ["Busted"] = "ID:186264"
    }
    if task.specialName ~= "AI drives to kidnapper having too few cops" then
      if 1 <= task.agent.damage then
        params.reason = "Wrecked"
        if not task.agent.controlled then
          params.dialogue = "GPMV00_FAILURE_L_1"
        else
          params.dialogue = "GPMV01_FAILURE_L_4"
        end
        params.hint = "ID:235485"
        params.failReason = failReasons.wrecked
      elseif task.specialName == "Destination A" then
        params.hint = "ID:235485"
      elseif task.specialName == "Destination B timed drive through alleyways" then
        if task.condition == 3 then
          params.failReason = failReasons["out of time 1"]
          params.hint = "ID:235486"
          if not task.agent.controlled then
            params.dialogue = "GPMV00_FAILURE_L_1"
          else
            params.dialogue = "GPMV01_FAILURE_L_1"
          end
        else
          params.hint = "ID:235486"
        end
      elseif task.specialName == "Use alleys" then
        params.hint = "ID:235486"
        if not task.agent.controlled then
          params.dialogue = "GPMV00_FAILURE_L_1"
        else
          params.dialogue = "GPMV01_FAILURE_L_2"
        end
        params.failReason = failReasons["draw attention"]
      elseif task.specialName == "Player lures cops to the kidnapper" then
        if task.condition < 4 then
          params.failReason = failReasons.Busted
          params.reason = "Busted"
          params.hint = "ID:236268"
          if not task.agent.controlled then
            params.dialogue = "GPMV00_FAILURE_L_1"
          end
        elseif task.condition == 4 then
          if not task.agent.controlled then
            params.dialogue = "GPMV00_FAILURE_L_1"
          else
            params.dialogue = "GPMV01_FAILURE_L_7"
          end
          params.hint = "ID:236268"
          params.failReason = failReasons["out of time 2"]
        end
      end
      params.callback = failTask
      params.rating = "FAIL"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  end
end
missionEndCallback["Felony lure"] = function(instance)
  Sound.SetRTPC("Paranoia_Meter", 0)
  PatrollingVehicleManager.EnableHud(true)
  OneShotSound.Play("Suspicion_Meter_Stop", false, true)
  feedbackSystem.stopMusic("Uid04942_SM_FelonyLure_ Stop")
  minimap.RemoveAllHighlightedVehicleModelUIDs()
  localPlayer.minimapSupport.highlightedVehicles = false
  removeUserUpdateFunction("waitForZap")
  localPlayer:blockAbility("zap", false)
end
