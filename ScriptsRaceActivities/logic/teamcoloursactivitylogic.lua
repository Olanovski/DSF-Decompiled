module("cardSystem.logic")
missionSetupData["Team colours activity"] = {}
local playerTeam, playerTask
local startPromptParams = {delay = true, priority = 1}
local racerTask = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
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
            style = "Team colours activity hud"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        dynamicTargets = true,
        specialName = "Checkpoints",
        coreData = {
          totalLaps = goalParams["Total laps"] or 0
        },
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
            style = "Team colours activity hud"
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
        specialName = "Rapid shift reminder",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            {
              goal = "Is player controlled"
            },
            {
              goal = "Team member above race position",
              params = {value = 1, controlled = true}
            },
            {
              goal = "Team member above race position",
              params = {value = 3, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            {
              goal = "Is player controlled"
            },
            {
              goal = "Team member slipped race position",
              params = {fromPosition = 2, toPosition = 3}
            },
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Total zap returns above",
              params = {value = 30}
            }
          }
        }
      }
    },
    {
      {
        task = "Follow Route"
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
  if goalParams["Time limit"] then
    task[2][#task[2] + 1] = {
      task = "No AI",
      specialName = "FAIL - Time ran out",
      groupProgression = {importantMinorOrder = false},
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
  if goalParams["Any team member damage above"] then
    task[2][#task[2] + 1] = {
      task = "No AI",
      specialName = "FAIL - Team Mate Wrecked",
      groupProgression = {importantMinorOrder = false},
      taskConditions = {
        {
          failCondition = true,
          forceTaskComplete = true,
          {
            goal = "Any team member damage above",
            params = {
              value = goalParams["Any team member damage above"]
            }
          }
        }
      }
    }
  end
  if goalParams["Destroy opposing teams"] then
    task[2][#task[2] + 1] = {
      task = "No AI",
      specialName = "PASS - All opposing vehicles wrecked",
      groupProgression = {importantMinorOrder = false},
      taskConditions = {
        {
          {
            goal = "All opposing vehicles damage above",
            params = {value = 1}
          }
        }
      }
    }
  end
  if goalParams["Hide checkpoints"] then
    table.remove(task[2][1].targetManagers[1])
  end
  return task
end
missionSetupData["Team colours activity"].taskCreatorFunctionLookups = {
  ["Race team 1"] = racerTask,
  ["Race team 2"] = racerTask,
  ["Race team 3"] = racerTask,
  ["Race team 4"] = racerTask
}
missionSetupData["Team colours activity"].initiate = function(instance)
  playerTeam = false
  playerTask = false
  instance.willpowerReward = instance.challenge.goalValues["Willpower reward"] or 0
  instance.remainingWillpowerNumber = instance.willpowerReward
  instance.remainingWillpowerPercent = 100
  instance.currentTime = g_NetworkTime
  createCheckpoints(instance)
  if instance.challenge.props then
    propSystem.setupRuntimeProps(instance.challenge.props, false, false)
  end
  if instance.challenge.goalValues["Disable Shift"] then
    localPlayer:blockAbility("zap", true)
  end
  if instance.challenge.goalValues["Eject if in lead"] then
    localPlayer:blockAbility("zapReturn", true)
  end
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    taskObject.coreData.agent.blockReturnZap = false
    taskObject.coreData.agent.finishedRace = false
    if taskObject.playerTask then
      playerTeam = taskObject.coreData.actor.team
    end
  end
  localPlayer:enterCutsceneMode()
end
missionSetupData["Team colours activity"].update = nil
local function RaceTeamDynamicTargets(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if dynamicListID then
    if task.networkVars.checkpoints < #allCheckpoints then
      if task.instance.challenge.goalValues["Eject if in lead"] then
        for i, taskVehicle in next, task.instance.taskObjectsByActorID, nil do
          if taskVehicle.coreData.actor.team == playerTeam and not taskObject ~= taskVehicle and not taskVehicle.coreData.agent.controlled then
            if taskObject.coreData.rank < taskVehicle.coreData.rank then
              localPlayer:zapToAgent(taskVehicle.coreData.agent)
              localPlayer.missionSupport:setMainTaskObject(taskVehicle)
            end
            break
          end
        end
      end
      return {
        allCheckpoints[task.networkVars.checkpoints + 1]
      }, false
    elseif task.instance.challenge.goalValues["Total laps"] then
      if task.networkVars.laps == task.instance.challenge.goalValues["Total laps"] then
        RouteArrowsManager.HideArrows(localPlayer.localID, true)
        return false, true
      else
        return {
          allCheckpoints[1]
        }, true
      end
    else
      RouteArrowsManager.HideArrows(localPlayer.localID, true)
      return false, true
    end
  else
    return {
      allCheckpoints[task.networkVars.checkpoints]
    }, false
  end
end
missionSetupData["Team colours activity"].targetList = {
  ["Race team 1"] = RaceTeamDynamicTargets,
  ["Race team 2"] = RaceTeamDynamicTargets,
  ["Race team 3"] = RaceTeamDynamicTargets,
  ["Race team 4"] = RaceTeamDynamicTargets
}
missionSetupData["Team colours activity"].goalComplete = function(taskObject, task, conditionKey)
  if task.specialName == "Rapid shift reminder" and isAbilityUnlocked("zapReturn") then
    feedbackSystem.menusMaster.primaryTextPromptParam({
      prompt = "ID:234447",
      icon1 = localPlayer.buttonLayout.zapReturn,
      watchFor = {
        button = "Zap_Return",
        pressType = "JustPressed"
      },
      priority = 2
    })
  end
end
taskCompleteData = taskCompleteData or {}
taskCompleteData["Team colours activity"] = {}
taskCompleteData["Team colours activity"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.agent,
    cameraShots = cameraShots[2],
    successReason = task.instance.challenge.taskCompleteData["Success reason"] or "ID:245568",
    failReason = task.instance.challenge.taskCompleteData["Failure reason"] or "ID:182607",
    hint = "ID:235495",
    hintIcon1 = localPlayer.buttonLayout.zapReturn
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if taskObject.playerTask and task.success then
    if task.specialName == "Wait for countdown" then
      localPlayer:exitCutsceneMode()
      if task.instance.challenge.goalValues["Start prompt"] then
        startPromptParams.prompt = task.instance.challenge.goalValues["Start prompt"]
      else
        startPromptParams.prompt = "ID:182606"
      end
      feedbackSystem.menusMaster.primaryTextPromptParam(startPromptParams)
    elseif task.specialName == "Checkpoints" then
      RaceManager.RacerCrossedFinishLine(task.instance.raceId, task.agent.gameVehicle)
      task.agent.finishedRace = true
    elseif task.specialName == "PASS - All opposing vehicles wrecked" then
      params.successReason = "ID:186280"
      params.rating = "PASS"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif taskObject.playerTask and not task.success then
    if task.specialName == "FAIL - Wrecked" then
      params.failReason = "ID:173965"
    elseif task.specialName == "FAIL - Time ran out" then
      params.failReason = "ID:183988"
    elseif task.specialName == "FAIL - Team Mate Wrecked" then
      params.failReason = "ID:184688"
    elseif task.specialName == "FAIL - Busted" then
      params.failReason = "ID:231166"
      params.hint = "ID:235490"
    end
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.success then
    if task.specialName == "Checkpoints" then
      if task.actor.team ~= playerTeam then
        params.failReason = "ID:182607"
        params.callback = failTask
        params.rating = "FAIL"
        localPlayer.challenge.endScreen(taskObject, params)
      else
        RaceManager.RacerCrossedFinishLine(task.instance.raceId, task.agent.gameVehicle)
        task.agent.finishedRace = true
      end
    end
  elseif not task.success then
    if task.specialName == "FAIL - Wrecked" then
      if task.actor.team ~= playerTeam then
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:183974", priority = 1})
      else
        params.failReason = "ID:184688"
        params.callback = failTask
        params.rating = "FAIL"
        localPlayer.challenge.endScreen(taskObject, params)
      end
    elseif task.specialName == "FAIL - Busted" then
      if task.actor.team ~= playerTeam then
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:232268", priority = 1})
      else
        params.failReason = "ID:231166"
        params.callback = failTask
        params.rating = "FAIL"
        localPlayer.challenge.endScreen(taskObject, params)
      end
    end
  end
  if task.agent.finishedRace then
    local teamMateAgent, teamMateTaskObject
    for actorID, tO in next, task.instance.taskObjectsByActorID, nil do
      if tO.coreData.actor.team == playerTeam and taskObject ~= tO then
        teamMateTaskObject = tO
        teamMateAgent = tO.coreData.agent
        break
      end
    end
    if not teamMateAgent.finishedRace then
      if task.agent == localPlayer.currentVehicle then
        localPlayer:zapToAgent(teamMateAgent)
        localPlayer.missionSupport:setMainTaskObject(teamMateTaskObject)
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:182717", priority = 1})
      else
        if teamMateAgent ~= localPlayer.currentVehicle then
          localPlayer.missionSupport:setMainTaskObject(teamMateTaskObject)
        end
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:182718", priority = 1})
      end
      task.agent.iconsVisible = false
      task.agent.blockReturnZap = true
    else
      params.rating = "PASS"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
  end
end
missionEndCallback["Team colours activity"] = function(instance)
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.agent.raceId then
      RouteArrowsManager.ClearArrows()
      RaceManager.RemoveRace(taskObject.coreData.agent.raceId)
      taskObject.coreData.agent.raceId = nil
      taskObject.coreData.instance.raceId = nil
      break
    end
  end
  localPlayer:blockAbility("zap", false)
  localPlayer:blockAbility("zapReturn", false)
  propSystem.cleanupRuntimeProps()
end
