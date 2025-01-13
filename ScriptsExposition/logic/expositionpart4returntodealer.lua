module("cardSystem.logic")
missionSetupData["Exposition part 4"] = {}
local returnToDealerTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "Wander",
        specialName = "Mission start",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
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
            style = "Exposition Return To Dealer HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "pauseBeforeOvertakesSection",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
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
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Damage prompt 03",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Damage above",
              params = {value = 0.5}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "PlayerInZap 03",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            }
          },
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Overtakes",
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Overtakes",
              params = {value = 1},
              feedback = "Overtakes"
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Overtakes",
              params = {value = 5},
              feedback = "Overtakes"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Overtakes",
              params = {value = 10},
              feedback = "Overtakes"
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
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Damage prompt 04",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Damage above",
              params = {value = 0.5}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Remove overtake prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 4}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "PlayerInZap 04",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            }
          },
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "PIP 02 trigger",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5}
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
            style = "Exposition Return To Dealer HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Damage prompt 010",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Damage above",
              params = {value = 0.5}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "PlayerInZap 022",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            }
          },
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "pauseBeforeDriveToSection",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
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
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "PlayerInZap 09",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            }
          },
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "clear the overtakes HUD panel",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints AI Wander",
        specialName = "Destination",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within range",
              params = {minimum = 0, maximum = 300}
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
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Destination prompt",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within range",
              params = {minimum = 0, maximum = 300}
            }
          },
          {
            {
              goal = "Outside radius",
              params = {value = 300}
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
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
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "PlayerInZap 10",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            }
          },
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints AI Wander",
        specialName = "Jump",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Within radius",
              params = {value = 200}
            },
            {
              goal = "Player jumped a distance of in mid air",
              params = {value = 10}
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
            manager = "Target list",
            settings = {
              styles = {
                ["Radius with hotspot"] = {
                  radius = 200,
                  worldColour = vec.vector(0, 80, 200, 127),
                  offset = vec.vector(0, -30, 0, 0),
                  height = 45
                }
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Jump HUD panel",
        groupProgression = {importantMinorOrder = false},
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
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "PlayerInZap 11",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            }
          },
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Drive prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 30}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      }
    },
    {
      {
        task = "No functionality",
        specialName = "soft save",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Pause before checkpoint section",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
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
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "PlayerInZap 12",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            }
          },
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Lock after soft save",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
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
        task = "Linear Checkpoints AI Wander",
        specialName = "Checkpoint race",
        dynamicTargets = true,
        coreData = {totalLaps = 0},
        goalConditions = {
          {
            {
              goal = "Reached next checkpoint"
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
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Actor has passed checkpoint number",
              params = {value = 1}
            },
            {
              goal = "Time trigger",
              params = {value = 90},
              feedback = "Timer"
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Checkpoint Gate"] = {}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Introduce timer",
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
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Turn the player around before the race",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {value = true}
            },
            {
              goal = "Player within radius of point",
              params = {
                value = 7,
                position = vec.vector(-294.5247, 69.46352, -0.9379952, 1)
              }
            },
            {
              goal = "Is target ahead"
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
                value = 7,
                position = vec.vector(-294.5247, 69.46352, -0.9379952, 1)
              }
            },
            {
              goal = "Is target ahead",
              params = {inverse = true}
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
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Handbrake prompt reminder",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 3,
            {
              goal = "Is player controlled"
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Secondary", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2}
            },
            {
              goal = "Within radius",
              params = {value = 150}
            },
            {
              goal = "Simple collision check",
              params = {force = 3000}
            }
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "PlayerInZap 13",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            }
          },
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "PIP04",
        groupProgression = {importantMinorOrder = false},
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
        HUD = {
          {
            style = "Exposition Return To Dealer HUD"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Mission complete",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
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
            style = "Exposition Return To Dealer HUD"
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Exposition part 4"].taskCreatorFunctionLookups = {
  ["Return to dealer team"] = returnToDealerTask
}
local driveToPosition = vec.vector(-302.899, 70.14696, 159.3777, 1)
local ifThePlayerIsFacingThisPositionThenTeleportThemTheOtherWayToFaceTheFirstCheckpoint = vec.vector(-397.0879, 69.00068, 29.80126, 1)
local lombardStreetHandbrakePromptRadius = vec.vector(-186.7491, 42.24657, -37.4733, 1)
local softSaveData
missionSetupData["Exposition part 4"].initiate = function(instance)
  createFixedPosition(instance, {driveToPosition}, 101)
  createFixedPosition(instance, {ifThePlayerIsFacingThisPositionThenTeleportThemTheOtherWayToFaceTheFirstCheckpoint}, 102)
  createFixedPosition(instance, {lombardStreetHandbrakePromptRadius}, 103)
  createCheckpoints(instance)
  localPlayer:blockAbility("zap", true)
  feedbackSystem.menusMaster.blockHintButton(true)
  local tanner = instance.taskObjectsByActorID.Lamborghini.coreData.agent
  softSaveData = progressionSystem.getSoftSaveData()
  if not softSaveData then
    tanner.gameVehicle.velocity = tanner.gameVehicle.matrix[2] * 20
  else
    feedbackSystem.startMusic("Uid01783_Exp_GoForASpin_Play")
    localPlayer:enterCutsceneMode({prompts = true})
    localPlayer:blockAbility("zap", true)
  end
end
missionSetupData["Exposition part 4"].update = nil
local getVehicleDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "Checkpoint race" then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
      if task.networkVars.checkpoints == 8 then
        eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4")
      end
      if task.networkVars.checkpoints < #allCheckpoints then
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
  elseif task.specialName == "Turn the player around before the race" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 102), false
    end
  elseif task.specialName == "Handbrake prompt reminder" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 103), false
    end
  elseif dynamicListID then
    return false, true
  else
    return checkpointSystem.getCheckpoints(task.instance, 101), false
  end
end
missionSetupData["Exposition part 4"].targetList = {
  ["Return to dealer team"] = getVehicleDynamicTargets
}
taskCompleteData["Exposition part 4"] = {}
taskCompleteData["Exposition part 4"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.Lamborghini.coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235485",
    driverIsTanner = true
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.specialName == "soft save" then
    progressionSystem.triggerSoftSave({progression = 1})
    createCheckpoints(task.instance, "Go for a spin")
  elseif task.specialName == "Destination" then
    OneShotSound.Play("HUD_Play_Waypoint")
  elseif task.specialName == "Lock after soft save" then
    if softSaveData then
      localPlayer:enterCutsceneMode({prompts = true})
    end
  elseif task.specialName == "Introduce timer" then
    if localPlayer.inCutscene then
      localPlayer:exitCutsceneMode()
    end
    localPlayer:blockAbility("zap", false)
  end
  if task.specialName == "Mission complete" and task.success then
    params.callback = completeTask
    params.rating = "PASS"
    params.dialogue = "GPMV01_SUCCESS_L_1"
    feedbackSystem.stopMusic("Uid01783_Exp_GoForASpin_Stop")
    localPlayer.challenge.endScreen(taskObject, params)
  elseif not task.success then
    params.callback = failTask
    params.rating = "FAIL"
    params.dialogue = "GPMV01_FAILURE_L_1"
    if task.specialName == "Checkpoint race" then
      params.hint = "ID:245851"
      if 1 > task.agent.damage then
        params.failReason = "ID:184844"
      end
      params.dialogue = "GPMV01_FAILURE_L_2"
    end
    feedbackSystem.stopMusic("Uid01783_Exp_GoForASpin_Stop")
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Exposition part 4"] = function(instance)
  feedbackSystem.stopMusic("Uid01783_Exp_GoForASpin_Stop")
  Sound.EnableScoring("jump", false)
end
