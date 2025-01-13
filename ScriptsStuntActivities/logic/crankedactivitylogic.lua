module("cardSystem.logic")
missionSetupData.DriveToSurviveActivity = {}
local lowTrigger = 56
local criticalTrigger = 45
local function playerTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait for countdown",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3},
              feedback = "Time"
            }
          }
        },
        HUD = {
          {
            style = "DriveToSurviveActivity hud"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Get to end",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Within radius",
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
            forceTaskComplete = true,
            {
              goal = "Time trigger",
              params = {
                value = goalParams["Time limit"]
              },
              feedback = "Time"
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
            style = "DriveToSurviveActivity hud",
            settings = {}
          }
        }
      },
      {
        task = "Payload Tracking With Multiplyer",
        coreData = {upper = 167, lower = 30},
        specialName = "payload task",
        startingValues = {payload = 80},
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
              params = {upMultiplyer = 2, downMultiplyer = 0.25}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 45, highest = 55}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.9, downMultiplyer = 0.35}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 55, highest = 70}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.85, downMultiplyer = 0.55}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 70, highest = 80}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.75, downMultiplyer = 0.75}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 80, highest = 100}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.6, downMultiplyer = 0.8}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 100, highest = 110}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.5, downMultiplyer = 0.85}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 110, highest = 120}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.4, downMultiplyer = 0.9}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 120, highest = 140}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.2, downMultiplyer = 0.95}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 140, highest = 155}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.1, downMultiplyer = 0.95}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 155, highest = 170}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1, downMultiplyer = 1}
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
              params = {value = 0.45}
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
              params = {value = 0.5}
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
              params = {value = 0.35}
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
            style = "DriveToSurviveActivity hud",
            settings = {lowTrigger = lowTrigger, criticalTrigger = criticalTrigger}
          }
        }
      }
    }
  }
  cardSystem.createHeartometerParameters(task[2][2])
  return task
end
missionSetupData.DriveToSurviveActivity.taskCreatorFunctionLookups = {
  ["Player team"] = playerTask
}
function missionSetupData.DriveToSurviveActivity.initiate(instance)
  createFixedPosition(instance, {
    routes[instance.challenge.name].checkpoints[1].position
  }, 201)
  Sound.EnableScoring("jump", true)
  Sound.EnableScoring("drift", true)
  localPlayer:enterCutsceneMode()
end
missionSetupData.DriveToSurviveActivity.update = nil
local playerDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  else
    return checkpointSystem.getCheckpoints(task.instance, 201), false
  end
end
missionSetupData.DriveToSurviveActivity.targetList = {
  ["Player team"] = playerDynamicTargets
}
taskCompleteData.DriveToSurviveActivity = {}
function taskCompleteData.DriveToSurviveActivity.taskComplete(taskObject, task)
  local params = {
    driverIsTanner = true,
    vehicle = task.agent,
    cameraShots = cameraShots[2],
    successReason = "ID:245688",
    failReason = "ID:184808",
    hint = "ID:235493"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix, perfect)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.specialName == "Wait for countdown" then
    localPlayer:exitCutsceneMode()
    feedbackSystem.menusMaster.primaryTextPromptParam({
      prompt = "ID:245687",
      delay = true,
      priority = 1
    })
  elseif task.success then
    if task.specialName == "Get to end" then
      OneShotSound.Play("HUD_Play_Waypoint")
      params.rating = "PASS"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
  else
    if task.specialName == "Get to end" then
      if task.condition == 2 then
        params.failReason = "ID:173965"
      elseif task.condition == 3 then
        params.failReason = "ID:231166"
      elseif task.condition == 4 then
        params.failReason = "ID:184074"
      end
    end
    params.rating = "FAIL"
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
function missionEndCallback.DriveToSurviveActivity(instance)
  Sound.EnableScoring("jump", false)
  Sound.EnableScoring("drift", false)
end
