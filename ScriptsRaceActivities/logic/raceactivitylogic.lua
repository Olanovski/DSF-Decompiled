module("cardSystem.logic")
missionSetupData["Generic race activity"] = {}
local hotspotID = 100
local openRace = false
local opponentsFinished = 0
local actorHotspotNumber = {
  ["Player"] = 1,
  ["Opponent 1"] = 2,
  ["Opponent 2"] = 3,
  ["Opponent 3"] = 4,
  ["Opponent 4"] = 5,
  ["Opponent 5"] = 6,
  ["Opponent 6"] = 7,
  ["Opponent 7"] = 8,
  ["Opponent 8"] = 9
}
local startPromptParams = {delay = true, priority = 1}
local openRacePromptParams = {priority = 3}
local racerTask = function(goalParams, HUD)
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
            style = "Race activity hud"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Checkpoints",
        dynamicTargets = true,
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
            style = "Race activity hud"
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
  if goalParams["Hide checkpoints"] then
    table.remove(task[2][1].targetManagers[1])
  end
  if goalParams["Checkpoint type"] == "Hotspot" then
    task[2][1].goalConditions[1] = {
      {
        goal = "Within radius",
        params = {value = 20}
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
      taskConditions = {
        {
          failCondition = true,
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
  return task
end
local opposingRacerTask = function(goalParams, HUD, audio)
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
            style = "Race activity hud"
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
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        }
      }
    },
    {
      {task = "Wander"}
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
  if goalParams["Checkpoint type"] == "Hotspot" then
    task[2][1].goalConditions[1] = {
      {
        goal = "Within radius",
        params = {value = 20}
      }
    }
  end
  return task
end
missionSetupData["Generic race activity"].taskCreatorFunctionLookups = {
  ["Race team 1"] = racerTask,
  ["Race team 2"] = opposingRacerTask,
  ["Race team 3"] = opposingRacerTask,
  ["Race team 4"] = opposingRacerTask
}
missionSetupData["Generic race activity"].initiate = function(instance)
  if instance.challenge.goalValues["Disable Shift"] then
    localPlayer:blockAbility("zap", true)
  end
  createCheckpoints(instance)
  setUpRouteManager(localPlayer:getTaskObject())
  if hotspotData and hotspotData[instance.challenge.name] then
    for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
      taskObject.coreData.agent.positionsCreated = false
    end
  end
  if instance.challenge.goalValues["Checkpoint type"] == "Hotspot" then
    openRace = true
  end
  opponentsFinished = 0
  localPlayer:enterCutsceneMode()
end
missionSetupData["Generic race activity"].update = nil
local function RaceTeamDynamicTargets(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if hotspotData and hotspotData[task.instance.challenge.name] and not task.agent.positionsCreated then
    for index, hotspot in next, hotspotData[task.instance.challenge.name][task.actor.ID].hotspot, nil do
      createFixedPosition(task.instance, {
        hotspot.position
      }, actorHotspotNumber[task.actor.ID] * hotspotID + index)
    end
    task.agent.positionsCreated = true
  end
  if dynamicListID then
    if hotspotData and hotspotData[task.instance.challenge.name] then
      if task.networkVars.checkpoints < #hotspotData[task.instance.challenge.name][task.actor.ID].hotspot then
        if openRace and task.actor.ID == "Player" then
          OneShotSound.Play("HUD_Play_Waypoint")
          if task.networkVars.checkpoints == #hotspotData[task.instance.challenge.name][task.actor.ID].hotspot - 1 then
            openRacePromptParams.prompt = "ID:243130"
          else
            openRacePromptParams.prompt = "ID:243824"
            openRacePromptParams.value = #hotspotData[task.instance.challenge.name][task.actor.ID].hotspot - task.networkVars.checkpoints
          end
          feedbackSystem.menusMaster.primaryTextPromptParam(openRacePromptParams)
        end
        return checkpointSystem.getCheckpoints(task.instance, actorHotspotNumber[task.actor.ID] * hotspotID + task.networkVars.checkpoints + 1), false
      else
        return false, true
      end
    elseif task.networkVars.checkpoints < #allCheckpoints then
      if openRace and task.actor.ID == "Player" then
        OneShotSound.Play("HUD_Play_Waypoint")
        if task.networkVars.checkpoints == #allCheckpoints - 1 then
          openRacePromptParams.prompt = "ID:243130"
        else
          openRacePromptParams.prompt = "ID:243824"
          openRacePromptParams.value = #allCheckpoints - task.networkVars.checkpoints
        end
        feedbackSystem.menusMaster.primaryTextPromptParam(openRacePromptParams)
      end
      return {
        allCheckpoints[task.networkVars.checkpoints + 1]
      }, false
    elseif task.instance.challenge.goalValues["Endless race"] then
      task.networkVars.laps = 0
      task.networkVars.checkpoints = 0
      return {
        allCheckpoints[1]
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
  elseif hotspotData and hotspotData[task.instance.challenge.name] then
    return checkpointSystem.getCheckpoints(task.instance, actorHotspotNumber[task.actor.ID] * hotspotID + task.networkVars.checkpoints), false
  else
    return {
      allCheckpoints[task.networkVars.checkpoints]
    }, false
  end
end
missionSetupData["Generic race activity"].targetList = {
  ["Race team 1"] = RaceTeamDynamicTargets,
  ["Race team 2"] = RaceTeamDynamicTargets,
  ["Race team 3"] = RaceTeamDynamicTargets,
  ["Race team 4"] = RaceTeamDynamicTargets
}
taskCompleteData["Generic race activity"] = {}
taskCompleteData["Generic race activity"].taskComplete = function(taskObject, task)
  if task.specialName == "Wait for countdown" then
    localPlayer:exitCutsceneMode()
    if task.instance.challenge.goalValues["Start prompt"] then
      startPromptParams.prompt = task.instance.challenge.goalValues["Start prompt"]
    else
      startPromptParams.prompt = "ID:184013"
    end
    feedbackSystem.menusMaster.primaryTextPromptParam(startPromptParams)
    if task.instance.challenge.goalValues["Secondary start prompt"] then
      feedbackSystem.menusMaster.secondaryTextPrompt(task.instance.challenge.goalValues["Secondary start prompt"], nil, nil, true)
    end
  else
    local params = {
      vehicle = task.agent,
      cameraShots = cameraShots[2],
      hint = "ID:235494"
    }
    local function completeTask()
      progressionSystem.challengeComplete(task.instance, task.agent.matrix)
    end
    local function failTask()
      progressionSystem.challengeFailed(task.instance, task.agent.matrix)
    end
    if task.success then
      if taskObject.playerTask then
        if task.specialName == "PASS - All opposing vehicles wrecked" then
          params.successReason = "ID:186280"
        elseif opponentsFinished == 0 then
          params.successReason = "ID:183987"
        else
          params.successReason = "ID:184897"
        end
        params.rating = "PASS"
        params.callback = completeTask
        params.driverIsTanner = true
        localPlayer.challenge.endScreen(taskObject, params)
      else
        opponentsFinished = opponentsFinished + 1
        taskObject.coreData.agent.iconsVisible = false
        if opponentsFinished == 2 then
          params.failReason = "ID:182607"
          params.callback = failTask
          params.rating = "FAIL"
          if openRace then
            params.hint = "ID:245263"
          end
          localPlayer.challenge.endScreen(taskObject, params)
        elseif opponentsFinished == 1 then
          feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:184952", priority = 1})
        end
      end
    elseif taskObject.playerTask then
      if task.specialName == "FAIL - Wrecked" then
        params.failReason = "ID:173965"
      elseif task.specialName == "FAIL - Time ran out" then
        params.failReason = "ID:183988"
      elseif task.specialName == "FAIL - Team Mate Wrecked" then
        params.failReason = "ID:184688"
      elseif task.specialName == "FAIL - Busted" then
        params.failReason = "ID:231166"
      else
        params.failReason = "INVALID FAIL, CHECK LOGIC"
      end
      params.callback = failTask
      params.rating = "FAIL"
      params.driverIsTanner = true
      localPlayer.challenge.endScreen(taskObject, params)
    else
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:183974", priority = 1})
    end
  end
end
missionEndCallback["Generic race activity"] = function(instance)
  localPlayer:blockAbility("zap", false)
  propSystem.cleanupRuntimeProps()
  opponentsFinished = 0
  hotspotData = nil
end
