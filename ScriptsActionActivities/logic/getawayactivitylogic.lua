module("cardSystem.logic")
missionSetupData["Felony getaway activity"] = {}
local startPromptParams = {delay = true, priority = 1}
local evadeTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait for countdown",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        HUD = {
          {
            style = "Felony getaway activity hud"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        dynamicTargets = true,
        specialName = "Evader - Checkpoints",
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
              params = {coreValue = "totalLaps"}
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                [goalParams["Checkpoint type"]] = {}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Felony getaway activity hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "FAIL - Wrecked",
        groupProgression = {importantMinorOrder = false},
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
          }
        }
      },
      {
        task = "No AI",
        specialName = "FAIL - Busted",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {goal = "Got busted"}
          }
        }
      },
      {
        task = "No AI",
        specialName = "Change objective if chase status changes",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Has been chased"
            },
            {
              goal = "Being chased"
            }
          },
          {
            {
              goal = "Being chased",
              params = {inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Felony getaway activity hud"
          }
        }
      }
    }
  }
  if goalParams["Start countdown"] then
    task[1][1].taskConditions[1] = {
      {
        goal = "Time trigger",
        params = {value = 3},
        feedback = "Time"
      }
    }
  end
  if goalParams["Lose cops before destination"] then
    task[2][1].goalConditions[1] = {
      {
        goal = "Being chased",
        params = {inverse = true}
      },
      {
        goal = "Within radius",
        params = {value = 15}
      }
    }
    task[2][#task[2] + 1] = {
      task = "No AI",
      dynamicTargets = true,
      specialName = "Lose cops warning",
      groupProgression = {importantMinorOrder = false},
      goalConditions = {
        {
          skipTargetUpdate = true,
          {
            goal = "Within radius",
            params = {value = 150}
          },
          {
            goal = "Being chased"
          }
        },
        {
          skipTargetUpdate = true,
          {
            goal = "Within radius",
            params = {value = 150}
          },
          {
            goal = "Being chased",
            params = {inverse = true}
          }
        },
        {
          skipTargetUpdate = true,
          {
            goal = "Outside radius",
            params = {value = 150}
          }
        }
      },
      HUD = {
        {
          style = "Felony getaway activity hud"
        }
      }
    }
  end
  if goalParams["Time limit"] then
    task[2][#task[2] + 1] = {
      task = "No AI",
      specialName = "FAIL - Time ran out",
      taskConditions = {
        {
          failCondition = true,
          forceTaskComplete = true,
          {
            goal = "Time trigger",
            params = {
              value = goalParams["Time limit"]
            }
          }
        }
      }
    }
  end
  return task
end
local chaseTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait for countdown",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        HUD = {
          {
            style = "Felony getaway activity hud"
          }
        }
      }
    }
  }
  if goalParams["Start countdown"] then
    task[1][1].taskConditions[1] = {
      {
        goal = "Time trigger",
        params = {value = 3},
        feedback = "Time"
      }
    }
  end
  return task
end
missionSetupData["Felony getaway activity"].taskCreatorFunctionLookups = {
  ["Evade team"] = evadeTask,
  ["Chase team"] = chaseTask
}
missionSetupData["Felony getaway activity"].initiate = function(instance)
  if instance.challenge.goalValues["End hotspot position"] then
    createFixedPosition(instance, {
      hotspotData[instance.challenge.goalValues["End hotspot position"]].position
    }, 201)
  end
  createCheckpoints(instance)
  setUpRouteManager(localPlayer:getTaskObject())
  localPlayer:enterCutsceneMode()
  if instance.challenge.props then
    propSystem.setupRuntimeProps(instance.challenge.props, false)
  end
end
missionSetupData["Felony getaway activity"].update = nil
local GetawayDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if dynamicListID then
    if task.instance.challenge.goalValues["End hotspot position"] then
      return false, true
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
  elseif task.instance.challenge.goalValues["End hotspot position"] then
    return checkpointSystem.getCheckpoints(task.instance, 201), false
  else
    return {
      allCheckpoints[task.networkVars.checkpoints]
    }, false
  end
end
missionSetupData["Felony getaway activity"].targetList = {
  ["Evade team"] = GetawayDynamicTargets
}
taskCompleteData["Felony getaway activity"] = {}
taskCompleteData["Felony getaway activity"].taskComplete = function(taskObject, task)
  if task.specialName == "Wait for countdown" then
    localPlayer:exitCutsceneMode()
    if task.instance.challenge.goalValues["Start prompt"] then
      startPromptParams.prompt = task.instance.challenge.goalValues["Start prompt"]
    else
      startPromptParams.prompt = "ID:184901"
    end
    feedbackSystem.menusMaster.primaryTextPromptParam(startPromptParams)
    if task.instance.challenge.goalValues["Secondary start prompt"] then
      feedbackSystem.menusMaster.secondaryTextPrompt(task.instance.challenge.goalValues["Secondary start prompt"], nil, nil, true)
    else
      feedbackSystem.menusMaster.secondaryTextPrompt("ID:186177", nil, nil, true)
    end
    local evaderGameVehicle = task.instance.taskObjectsByActorID.Player.coreData.agent.gameVehicle
    felony_getaway.addEvader(evaderGameVehicle)
    for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team == "Chase team" then
        felony_getaway.addChaser(evaderGameVehicle, taskObject.coreData.agent.gameVehicle)
      end
    end
  else
    local params = {
      vehicle = task.agent,
      cameraShots = cameraShots[2],
      successReason = "ID:245567",
      hint = "ID:235490"
    }
    if task.success then
      local function completeTask()
        progressionSystem.challengeComplete(task.instance, task.agent.matrix)
      end
      local activityGameVehicle = progressionSystem.getActivityGameVehicle()
      if activityGameVehicle and activityGameVehicle.model_id == 298 then
        Achievements.UnlockAchievement(AchievementTable.AchievementID.RAMPEDUP.achievementID)
      end
      params.rating = "PASS"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    else
      local function failTask()
        progressionSystem.challengeFailed(task.instance, task.agent.matrix)
      end
      if task.specialName == "FAIL - Wrecked" then
        params.failReason = "ID:173965"
      elseif task.specialName == "FAIL - Time ran out" then
        params.failReason = "ID:184074"
      elseif task.specialName == "FAIL - Busted" then
        params.failReason = "ID:231166"
      end
      params.callback = failTask
      params.rating = "FAIL"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  end
end
missionEndCallback["Felony getaway activity"] = function(instance)
  if instance.challenge.props then
    propSystem.cleanupRuntimeProps(instance.challenge.props)
  end
  hotspotData = nil
end
