module("cardSystem.logic")
missionSetupData["Streetracer takedown"] = {}
local racerTask = function(goalParams)
  local task = {
    {
      {
        task = "Linear Checkpoints",
        dynamicTargets = true,
        specialName = "racerTask",
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
      },
      {
        task = "No AI",
        specialName = "Cop wrecked",
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
    }
  }
  return task
end
local chaserTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Non-linear Chase",
        dynamicTargets = true,
        specialName = "ChaserTask",
        goalConditions = {
          {
            {
              goal = "Target damage above",
              params = {value = 1}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Player using zap return",
              params = {inverse = true}
            },
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Empty dynamicTargets"
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
            style = "Streetrace HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Tanner in agent incidental audio",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 5,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in agent",
              params = {agentName = "Chaser"}
            },
            {
              goal = "Time trigger",
              params = {value = 15}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "Cop car destroyed",
        taskConditions = {
          {
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Streetrace HUD"
          }
        }
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "Prompt ram - chaser",
        goalConditions = {
          {
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Player successfully rammed a gameVehicle",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 20}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player using ram",
              params = {inverse = true}
            },
            {
              goal = "Player within radius of opposing team member",
              params = {value = 20}
            },
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          },
          {
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Player using ram"
            },
            {
              goal = "Player within radius of opposing team member",
              params = {value = 15}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            {
              goal = "Player using ram"
            },
            {
              goal = "Player within radius of opposing team member",
              params = {value = 15, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Total successful rams above",
              params = {value = 10, thisInstance = true}
            }
          },
          {
            {
              goal = "Total successful rams above",
              params = {value = 40}
            }
          }
        },
        HUD = {
          {
            style = "Streetrace HUD"
          }
        }
      },
      {
        task = "Payload Tracking",
        groupProgression = {importantMinorOrder = false},
        specialName = "Prompt headon - chaser",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 20}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Changed vehicle"
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "In mission vehicle",
              params = {inverse = true}
            },
            {
              goal = "Against traffic flow"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Payload over",
              params = {value = 3}
            }
          }
        },
        HUD = {
          {
            style = "Streetrace HUD"
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Streetracer takedown"].taskCreatorFunctionLookups = {
  ["Race team"] = racerTask,
  ["Chase team"] = chaserTask
}
local destroyedRacers
missionSetupData["Streetracer takedown"].initiate = function(instance)
  createCheckpoints(instance)
  local playerTaskObject = localPlayer:getTaskObject()
  setUpRouteManager(playerTaskObject)
  destroyedRacers = 0
  feedbackSystem.eventFeedback(instance.taskObjectsByActorID.Chaser.coreData.agent, "GPMV01_SEQUENCE_1", nil, "missionCritical")
end
missionSetupData["Streetracer takedown"].update = nil
local feedbackTable = {
  [4] = {
    Zap = "GPZP01_ZAP_2"
  },
  [3] = {
    Zap = "GPZP01_ZAP_4"
  },
  [2] = {
    Zap = "GPZP01_ZAP_5"
  }
}
local function chaseTargets(taskObject, task, dynamicListID)
  if dynamicListID then
    if task.specialName == "ChaserTask" then
      if #task.dynamicTargets == 1 then
        return false, true
      else
        if #task.dynamicTargets > 1 and localPlayer.inZap then
          feedbackSystem.eventFeedback(taskObject.coreData.instance.taskObjectsByActorID.Chaser.coreData.agent, feedbackTable[#task.dynamicTargets].Zap, nil, "missionCritical")
        end
        return false, false
      end
    else
      return false, false
    end
  else
    local teams = {}
    for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
      teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
      table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
    end
    return teams["Race team"]
  end
end
local raceTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, task.actor.checkpointGroup)
  if dynamicListID then
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
end
missionSetupData["Streetracer takedown"].targetList = {
  ["Race team"] = raceTargets,
  ["Chase team"] = chaseTargets
}
taskCompleteData["Streetracer takedown"] = {}
taskCompleteData["Streetracer takedown"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.Chaser.coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235487"
  }
  local function completeTask()
    feedbackSystem.menusMaster.masterSetVariable("iPrompt_Primary_Display", 0)
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    feedbackSystem.menusMaster.masterSetVariable("iPrompt_Primary_Display", 0)
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  local function endSlowdown()
    if not taskObject then
      removeUserUpdateFunction("Pause complete while slowdown active")
    elseif not localPlayer.inCutscene then
      localPlayer.challenge.endScreen(taskObject, params)
      removeUserUpdateFunction("Pause complete while slowdown active")
    end
  end
  if task.specialName == "racerTask" then
    if task.success then
      params.callback = failTask
      params.rating = "FAIL"
      params.vehicle = task.instance.taskObjectsByActorID.Chaser.coreData.agent
      if localPlayer.currentVehicle == task.instance.taskObjectsByActorID.Chaser.coreData.agent then
        params.dialogue = "GPMV00_FAILURE_L_2"
      else
        params.vehicle = taskObject.coreData.agent
        params.dialogue = "GPMV00_FAILURE_L_1"
      end
      addUserUpdateFunction("Pause complete while slowdown active", endSlowdown, 4)
    elseif task.condition == 2 then
      destroyedRacers = destroyedRacers + 1
      if localPlayer.currentVehicle == task.instance.taskObjectsByActorID.Chaser.coreData.agent and not localPlayer.inZap then
        if destroyedRacers == 1 then
          iCamCrashCam(taskObject.coreData.agent.gameVehicle, function()
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01")
          end)
        elseif destroyedRacers == 2 then
          iCamCrashCam(taskObject.coreData.agent.gameVehicle, function()
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_4", nil, "missionCritical")
          end)
        elseif destroyedRacers == 3 then
          iCamCrashCam(taskObject.coreData.agent.gameVehicle, function()
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP02")
          end)
        elseif destroyedRacers == 4 then
          iCamCrashCam(taskObject.coreData.agent.gameVehicle)
        end
      elseif not localPlayer.inZap then
        iCamCrashCam(taskObject.coreData.agent.gameVehicle)
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_1", nil, "missionCritical")
      end
    end
  elseif task.specialName == "ChaserTask" and task.success then
    if 1 > task.agent.damage then
      params.vehicle = task.agent
    else
      params.vehicle = localPlayer.currentVehicle
    end
    params.dialogue = "GPMV01_SUCCESS_L_1"
    params.callback = completeTask
    params.rating = "PASS"
    addUserUpdateFunction("Pause complete while slowdown active", endSlowdown, 4)
  elseif task.specialName == "Cop wrecked" then
    task.actor.rubberbandingToPlayerStrength = "None"
    task.actor.desiredSpeed = 90
    task.agent:stopHighSpeedDriving()
    local behaviour = {
      traits = taskSystem.buildDriveTraits(task)
    }
    behaviour.traits.desiredSpeed = 90
    behaviour.traits.rubberbandingToPlayerStrength = "None"
    if #taskObject.namedTasks.racerTask.dynamicTargets ~= 0 then
      behaviour.destinationPosition = taskObject.namedTasks.racerTask.dynamicTargets[1].position
    end
    task.agent:highSpeedDrive(behaviour)
  end
end
missionEndCallback["Streetracer takedown"] = function(instance)
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.team == "Race team" then
      taskObject.coreData.actor.rubberbandingToPlayerStrength = "Medium"
      taskObject.coreData.actor.desiredSpeed = 70
    end
  end
end
