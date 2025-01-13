module("cardSystem.logic")
missionSetupData["Learn to scream"] = {}
local learnerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Wander",
        specialName = "Initial pause",
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
            failCondition = true,
            forceTaskComplete = true,
            {goal = "Got busted"}
          },
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
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Wait for PiP",
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
            failCondition = true,
            forceTaskComplete = true,
            {goal = "Got busted"}
          },
          {
            {
              goal = "Time trigger",
              params = {value = 1}
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
        specialName = "Soft save",
        taskConditions = {
          {
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
        specialName = "Pause before heartometer",
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
            failCondition = true,
            forceTaskComplete = true,
            {goal = "Got busted"}
          },
          {
            {
              goal = "Time trigger",
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
        task = "Payload Tracking With Multiplyer",
        coreData = {upper = 180, lower = 80},
        specialName = "payload task",
        startingValues = {payload = 80},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Against traffic flow"
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Payload over",
              params = {value = 100}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Payload over",
              params = {value = 115}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Payload over",
              params = {value = 125}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Payload over",
              params = {value = 140}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Payload over",
              params = {value = 160}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 80, highest = 100}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 2, downMultiplyer = 0.08}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 100, highest = 110}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.8, downMultiplyer = 0.17}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 110, highest = 120}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.7, downMultiplyer = 0.255}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 120, highest = 140}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.65, downMultiplyer = 0.325}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 140, highest = 155}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.6, downMultiplyer = 0.39}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 155, highest = 170}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.45, downMultiplyer = 0.44}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 170, highest = 180}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.3, downMultiplyer = 0.495}
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
              params = {value = 50}
            },
            {
              goal = "Time trigger",
              params = {value = 0.375}
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
              params = {value = 0.15}
            }
          },
          {
            autoRefresh = true,
            failCondition = true,
            {
              goal = "Time trigger",
              params = {value = 3}
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
            failCondition = true,
            forceTaskComplete = true,
            {goal = "Got busted"}
          },
          {
            {
              goal = "Payload over",
              params = {value = 180}
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
            style = "Learn to scream hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "Wander",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        specialName = "Display prompts and heartometer",
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
            style = "Learn to scream hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Text prompts off",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 8}
            }
          }
        },
        HUD = {
          {
            style = "Learn to scream hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "zapped out",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player just zapped out of specified actors",
              params = {
                actors = {"Learner"}
              }
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "flatline",
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
    }
  }
  cardSystem.createHeartometerParameters(task[5][1], true)
  return task
end
missionSetupData["Learn to scream"].taskCreatorFunctionLookups = {
  ["Learner team"] = learnerTask
}
missionSetupData["Learn to scream"].initiate = function(instance)
  feedbackSystem.menusMaster.setCurrentFocusString(1)
end
missionSetupData["Learn to scream"].update = nil
missionSetupData["Learn to scream"].targetList = nil
taskCompleteData["Learn to scream"] = {}
taskCompleteData["Learn to scream"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.Learner.coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    driverIsTanner = true,
    hint = "ID:235493"
  }
  local vehicle = taskObject.coreData.agent
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.success then
    if task.specialName == "Soft save" then
      progressionSystem.triggerSoftSave({progression = 1})
    elseif task.specialName == "Display prompts and heartometer" then
      Sound.EnableScoring("jump", true)
      Sound.EnableScoring("drift", true)
    elseif task.specialName == "flatline" then
      params.rating = "PASS"
      params.dialogue = "GPMV01_SUCCESS_L_1"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "payload task" then
      task.agent:set_damageMultiplier(0)
    end
  else
    if task.condition == 1 then
      params.dialogue = "GPMV01_FAILURE_L_1"
      params.reason = "Wrecked"
    else
      params.failReason = "ID:231166"
      if task.condition == 2 then
        params.reason = "Busted"
      end
    end
    params.rating = "FAIL"
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Learn to scream"] = function(instance)
  Sound.EnableScoring("jump", false)
  Sound.EnableScoring("drift", false)
end
