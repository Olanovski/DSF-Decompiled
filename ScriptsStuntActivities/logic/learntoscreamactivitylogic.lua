module("cardSystem.logic")
missionSetupData["Learn to scream activity"] = {}
local learnerTask = function(goalParams, HUD, audio)
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
            style = "Learn to scream activity hud"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "Payload Tracking With Multiplyer",
        coreData = {upper = 180, lower = 80},
        specialName = "payload task",
        startingValues = {payload = 80},
        groupProgression = {importantMinorOrder = true},
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
              params = {upMultiplyer = 2, downMultiplyer = 0.07}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 100, highest = 110}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.8, downMultiplyer = 0.16}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 110, highest = 120}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.7, downMultiplyer = 0.24}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 120, highest = 140}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.65, downMultiplyer = 0.31}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 140, highest = 155}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.6, downMultiplyer = 0.37}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 155, highest = 170}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.45, downMultiplyer = 0.42}
            }
          },
          {
            {
              goal = "Payload between",
              params = {lowest = 170, highest = 180}
            },
            {
              goal = "Change payload multiplyers",
              params = {upMultiplyer = 1.3, downMultiplyer = 0.47}
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
            {
              goal = "Payload over",
              params = {value = 180}
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
              params = {value = 90},
              feedback = "Time"
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
            style = "Learn to scream activity hud"
          }
        },
        audioPIP = audio
      }
    }
  }
  cardSystem.createHeartometerParameters(task[2][2], true)
  return task
end
missionSetupData["Learn to scream activity"].taskCreatorFunctionLookups = {
  ["Learner team"] = learnerTask
}
missionSetupData["Learn to scream activity"].initiate = function(instance)
  localPlayer:enterCutsceneMode()
  Sound.EnableScoring("jump", true)
  Sound.EnableScoring("drift", true)
end
missionSetupData["Learn to scream activity"].update = nil
missionSetupData["Learn to scream activity"].targetList = nil
taskCompleteData["Learn to scream activity"] = {}
taskCompleteData["Learn to scream activity"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.Learner.coreData.agent,
    successReason = "ID:245564",
    failReason = "ID:245565",
    hint = "ID:235493",
    driverIsTanner = true
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.specialName == "Wait for countdown" then
    localPlayer:exitCutsceneMode()
    feedbackSystem.menusMaster.primaryTextPromptParam({
      prompt = "ID:247290",
      delay = true,
      priority = 1
    })
    feedbackSystem.menusMaster.secondaryTextPrompt("ID:234328", false, false, true)
  else
    if task.success then
      params.rating = "PASS"
      params.callback = completeTask
    else
      if task.condition == 1 then
        params.failReason = "ID:173965"
      elseif task.condition == 2 then
        params.failReason = "ID:231166"
      end
      params.rating = "FAIL"
      params.callback = failTask
    end
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Learn to scream activity"] = function(instance)
  Sound.EnableScoring("jump", false)
  Sound.EnableScoring("drift", false)
end
