module("cardSystem.logic")
missionSetupData["All clubbed out"] = {}
local clubPosition = vec.vector(598.037, 34.235, 579.102, 1)
local function playerTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Follow Route",
        specialName = "Initial pause",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 4}
            }
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"]
              }
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
            style = "All clubbed out hud"
          }
        }
      }
    },
    {
      {
        task = "Follow Route",
        specialName = "Exit from tutorial",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"]
              }
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
            style = "All clubbed out hud"
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
      },
      {
        task = "No AI",
        specialName = "First text prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          }
        },
        HUD = {
          {
            style = "All clubbed out hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "Follow Route",
        specialName = "Small pause",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"]
              }
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
        task = "Follow Route",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        specialName = "Saboteur route",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 11}
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
              params = {
                value = goalParams["Damage amount for fail"]
              }
            }
          },
          {
            failCondition = true,
            {
              goal = "Instance dynamic time above"
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
            style = "All clubbed out hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Setup route arrows",
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
            style = "All clubbed out hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Display destination marker",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Player within radius of point",
              params = {value = 300, position = clubPosition}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "1/3 complete",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Number of smashed",
              params = {value = 16}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "75% complete",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Number of smashed",
              params = {value = 32}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "100% complete",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Accumulative number of props remaining",
              params = {value = 0}
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
missionSetupData["All clubbed out"].taskCreatorFunctionLookups = {
  ["Player team"] = playerTask
}
local marker
missionSetupData["All clubbed out"].initiate = function(instance)
  instance.timeLimit = instance.challenge.goalValues["Time limit"]
  createFixedPosition(instance, {clubPosition}, 101)
  createCheckpoints(instance)
  propSystem.setupRuntimeProps(instance.challenge.props, true, true, true)
  feedbackSystem.startMusic("Uid00244_CH02_TheBigBreak_Play")
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    instance.taskObjectsByActorID.Agent.coreData.agent.gameVehicle.speed = 22.35
  end
end
missionSetupData["All clubbed out"].update = nil
local getPlayersDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    return false, true
  else
    return checkpointSystem.getCheckpoints(task.instance, 101), false
  end
end
missionSetupData["All clubbed out"].targetList = {
  ["Player team"] = getPlayersDynamicTargets
}
missionEndCallback["All clubbed out"] = function(instance)
  propSystem.cleanupRuntimeProps("All clubbed out")
  feedbackSystem.clearTarget(marker)
  RouteArrowsManager.ClearArrows(localPlayer.localID)
  marker = nil
end
taskCompleteData["All clubbed out"] = {}
taskCompleteData["All clubbed out"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.Agent.coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    passCondition = task.instance.challenge.taskCompleteData["Pass condition"],
    hint = "ID:235496"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.success then
    if task.specialName == "Saboteur route" then
      feedbackSystem.stopMusic("Uid00244_CH02_TheBigBreak_Stop")
      params.dialogue = "GPMV01_SUCCESS_L_1"
      params.rating = "PASS"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "Setup route arrows" then
      RouteArrowsManager.HideArrows(localPlayer.localID, false)
    elseif task.specialName == "Display destination marker" then
      marker = feedbackSystem.newTarget({position = clubPosition}, "Hotspot")
    elseif task.specialName == "Soft save" then
      progressionSystem.triggerSoftSave({progression = 1})
    elseif task.specialName == "Small pause" then
      task.instance.softsaveStartTime = g_NetworkTime - 3
    end
  else
    if task.condition == 2 then
      params.failReason = "ID:184287"
      params.reason = "Wrecked"
    elseif task.condition == 3 then
      params.failReason = "ID:184293"
    end
    params.callback = failTask
    params.rating = "FAIL"
    params.dialogue = "GPMV01_FAILURE_L_1"
    feedbackSystem.stopMusic("Uid00244_CH02_TheBigBreak_Stop")
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
