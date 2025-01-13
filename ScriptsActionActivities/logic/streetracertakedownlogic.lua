module("cardSystem.logic")
missionSetupData["Streetracer takedown activity"] = {}
local tableOfActorIDs = {
  [1] = "Racer1",
  [2] = "Racer2",
  [3] = "Racer3",
  [4] = "Racer4",
  [4] = "Racer5",
  [4] = "Racer6",
  [4] = "Racer7",
  [4] = "Racer8"
}
local racerTask = function(goalParams)
  local task = {
    enableNonPlayerFeedback = true,
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
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Streetrace activity HUD"
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
            style = "Streetrace activity HUD"
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
            style = "Streetrace activity HUD"
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
              params = {value = 1}
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
              params = {value = 10}
            }
          }
        },
        HUD = {
          {
            style = "Streetrace activity HUD"
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
              goal = "Time trigger",
              params = {value = 20}
            },
            {
              goal = "Is player controlled"
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
              goal = "Against traffic flow"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Payload over",
              params = {value = 5}
            }
          }
        },
        HUD = {
          {
            style = "Streetrace activity HUD"
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Streetracer takedown activity"].taskCreatorFunctionLookups = {
  ["Race team"] = racerTask,
  ["Chase team"] = chaserTask
}
missionSetupData["Streetracer takedown activity"].initiate = function(instance)
  createCheckpoints(instance)
end
missionSetupData["Streetracer takedown activity"].update = nil
local chaseTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    if #task.dynamicTargets == 1 then
      return false, true
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
missionSetupData["Streetracer takedown activity"].targetList = {
  ["Race team"] = raceTargets,
  ["Chase team"] = chaseTargets
}
taskCompleteData["Streetracer takedown activity"] = {}
taskCompleteData["Streetracer takedown activity"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.Chaser.coreData.agent,
    cameraShots = cameraShots[2],
    successReason = "ID:245570",
    failReason = "ID:245566",
    hint = "ID:245409"
  }
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
      local function failTask()
        feedbackSystem.menusMaster.masterSetVariable("iPrompt_Primary_Display", 0)
        progressionSystem.challengeFailed(task.instance, task.agent.matrix)
      end
      params.callback = failTask
      params.rating = "FAIL"
      params.vehicle = task.instance.taskObjectsByActorID.Chaser.coreData.agent
      if localPlayer.currentVehicle ~= task.instance.taskObjectsByActorID.Chaser.coreData.agent then
        params.vehicle = taskObject.coreData.agent
      end
      addUserUpdateFunction("Pause complete while slowdown active", endSlowdown, 4)
    else
      iCamCrashCam(taskObject.coreData.agent.gameVehicle)
    end
  elseif task.specialName == "ChaserTask" and task.success then
    local function completeTask()
      feedbackSystem.menusMaster.masterSetVariable("iPrompt_Primary_Display", 0)
      progressionSystem.challengeComplete(task.instance, task.agent.matrix, perfect)
    end
    params.vehicle = localPlayer.currentVehicle
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
