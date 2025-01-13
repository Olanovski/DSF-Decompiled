module("cardSystem.logic")
missionSetupData.DriveToSurvive = {}
local lowTrigger = 56
local criticalTrigger = 45
local function playerTask(goalParams, HUD, audio)
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
        specialName = "Show first marker",
        coreData = {totalLaps = 0},
        dynamicTargets = true,
        goalConditions = {
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 6}
            }
          }
        },
        taskConditions = {
          {
            skipTargetUpdate = true,
            {
              goal = "Time trigger",
              params = {value = 6.1}
            },
            {
              goal = "Event active",
              params = {inverse = true}
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
            style = "DriveToSurvive hud"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        coreData = {totalLaps = 0},
        specialName = "Get to end",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
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
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            }
          },
          {
            {
              goal = "Completed lap",
              params = {coreValue = "totalLaps"}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {goal = "Got busted"}
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
        specialName = "in zap (audio)",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "timer 90s (audio)",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 90}
            },
            {
              goal = "Is player controlled"
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
        task = "No AI",
        specialName = "timer 45s (audio)",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 45}
            },
            {
              goal = "Is player controlled"
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
        task = "No AI",
        specialName = "PIP 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
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
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Display handbrake reminder",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 40}
            }
          },
          {
            failCondition = true,
            {
              goal = "Player has performed a handbrake turn",
              params = {angle = 0.5}
            }
          }
        }
      },
      {
        task = "Payload Tracking With Multiplyer",
        coreData = {upper = 167, lower = 30},
        specialName = "payload task",
        startingValues = {
          payload = 80,
          upMultiplyer = 0,
          downMultiplyer = 0
        },
        groupProgression = {importantMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Payload under",
              params = {value = 65}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Payload over",
              params = {value = 145}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Payload over",
              params = {value = 80}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Payload under",
              params = {value = 135}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            {
              goal = "Payload over",
              params = {value = criticalTrigger}
            },
            {
              goal = "Payload under",
              params = {value = lowTrigger}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            {
              goal = "Payload under",
              params = {value = criticalTrigger}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            {
              goal = "Payload over",
              params = {value = lowTrigger}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 30, highest = 45}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 2, downMultiplyer = 0.3}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 45, highest = 55}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.9, downMultiplyer = 0.5}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 55, highest = 70}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.85, downMultiplyer = 0.7}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 70, highest = 80}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.75, downMultiplyer = 0.9}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 80, highest = 100}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.6, downMultiplyer = 1}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 100, highest = 110}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.5, downMultiplyer = 1.25}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 110, highest = 120}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.4, downMultiplyer = 1.5}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 120, highest = 140}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.2, downMultiplyer = 2}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 140, highest = 155}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.1, downMultiplyer = 2.5}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 155, highest = 170}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1, downMultiplyer = 3}
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
              params = {value = 200}
            },
            {
              goal = "Above speed",
              params = {value = 50}
            },
            {
              goal = "Time trigger",
              params = {value = 0.4}
            },
            {
              goal = "Change payload by amount",
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
              params = {value = 80}
            },
            {
              goal = "Time trigger",
              params = {value = 0.4}
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
              params = {value = 0.4}
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
              params = {value = 0.4}
            }
          },
          {
            autoRefresh = true,
            failCondition = true,
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            {
              goal = "Payload under",
              params = {value = 30}
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
            style = "DriveToSurvive hud",
            settings = {lowTrigger = lowTrigger, criticalTrigger = criticalTrigger}
          }
        },
        audioPIP = audio
      }
    }
  }
  cardSystem.createHeartometerParameters(task[3][7])
  return task
end
missionSetupData.DriveToSurvive.taskCreatorFunctionLookups = {
  ["Player team"] = playerTask
}
local firstMarker = vec.vector(-3403.41, 80.90577, 2920.841, 1)
function missionSetupData.DriveToSurvive.initiate(instance)
  createCheckpoints(instance)
  createFixedPosition(instance, {firstMarker}, 200)
  feedbackSystem.menusMaster.primaryTextPrompt("ID:236468", nil, true)
  feedbackSystem.menusMaster.setCurrentFocusString(1)
  Sound.EnableScoring("drift", true)
  Sound.EnableScoring("jump", true)
end
missionSetupData.DriveToSurvive.update = nil
local playerDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Show first marker" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 200), false
    end
  else
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
      if task.networkVars.checkpoints < #allCheckpoints then
        OneShotSound.Play("HUD_Play_Waypoint")
        if task.networkVars.checkpoints == #allCheckpoints - 1 then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:243130")
        else
          feedbackSystem.menusMaster.primaryTextPromptParam({
            prompt = "ID:243824",
            value = #allCheckpoints - task.networkVars.checkpoints
          })
        end
        return {
          allCheckpoints[task.networkVars.checkpoints + 1]
        }, false
      else
        taskObject.coreData.agent.iconsVisible = false
        return {
          allCheckpoints[1]
        }, true
      end
    else
      return {
        allCheckpoints[task.networkVars.checkpoints]
      }, false
    end
  end
end
missionSetupData.DriveToSurvive.targetList = {
  ["Player team"] = playerDynamicTargets
}
taskCompleteData.DriveToSurvive = {}
function taskCompleteData.DriveToSurvive.taskComplete(taskObject, task)
  local params = {
    driverIsTanner = true,
    vehicle = playerVehicle or taskObject.coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235493"
  }
  local vehicle = taskObject.coreData.agent
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  local displayPrimaryPrompt = function(id)
    feedbackSystem.menusMaster.primaryTextPrompt(id, false, false, false, false)
    removeUserUpdateFunction("displayPrimaryPrompt")
  end
  local displaySecondaryPrompt = function(id)
    feedbackSystem.menusMaster.secondaryTextPrompt(id, false, false, false, false)
    removeUserUpdateFunction("displaySecondaryPrompt")
  end
  if task.success then
    if task.specialName == "Show first marker" then
      feedbackSystem.menusMaster.setCurrentFocusString(2)
      addUserUpdateFunction("displayPrimaryPrompt", function()
        displayPrimaryPrompt("ID:233881")
      end, 120, true)
      addUserUpdateFunction("displaySecondaryPrompt", function()
        displaySecondaryPrompt("ID:234328")
      end, 120, true)
    elseif task.specialName == "Display handbrake reminder" then
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:245442", priority = 1})
    elseif task.specialName == "Get to end" then
      OneShotSound.Play("HUD_Play_Waypoint")
      params.rating = "PASS"
      params.dialogue = "GPMV01_SUCCESS_L_1"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "payload task" or task.specialName == "Get to end" or task.specialName == "Wait for audio" or task.specialName == "Wait for message" then
    params.dialogue = "GPMV01_FAILURE_L_1"
    if task.specialName == "Get to end" or task.specialName == "Wait for audio" or task.specialName == "Wait for message" then
      if task.condition == 1 then
        params.dialogue = "GPMV01_FAILURE_L_2"
        params.failReason = "ID:184950"
        params.reason = "Wrecked"
      elseif task.condition == 3 then
        params.dialogue = "GPMV01_FAILURE_L_3"
        params.failReason = "ID:186264"
        params.reason = "Busted"
      end
    end
    params.rating = "FAIL"
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
function missionEndCallback.DriveToSurvive(instance)
  Sound.EnableScoring("drift", false)
  Sound.EnableScoring("jump", false)
end
