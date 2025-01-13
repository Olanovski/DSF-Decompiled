module("cardSystem.logic")
missionSetupData["Exposition part 1"] = {}
local tannerTask = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Non-linear Chase",
        dynamicTargets = true,
        specialName = "TannerTask",
        goalConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Target damage above",
              params = {value = 1}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Vehicle tracking"] = {keepTrackingWhenWrecked = true}
              }
            },
            {
              manager = "Instance vehicles"
            }
          }
        },
        HUD = {
          {
            style = "Exposition HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "PlayerInTanner",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "GivePlayerControl",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Objective Prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        },
        HUD = {
          {
            style = "Exposition HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Hint Prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Instance time above",
              params = {value = 10}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          }
        },
        HUD = {
          {
            style = "Exposition HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Speech trigger",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            skipTargetUpdate = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Agent distance from target",
              params = {value = 1400}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            triggerCount = 1,
            skipTargetUpdate = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Agent distance from target",
              params = {value = 1100}
            }
          },
          {
            {
              goal = "Agent stopped inside radius",
              params = {
                value = 10,
                stopDuration = 1,
                leaveZapBlocked = true
              }
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Spawn enemies",
        groupProgression = {importantMinorOrder = false},
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
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Tanner 2nd Task",
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            triggerCount = 1,
            skipTargetUpdate = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Agent distance from target",
              params = {value = 1400}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            triggerCount = 1,
            skipTargetUpdate = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Agent distance from target",
              params = {value = 1100}
            }
          },
          {
            {
              goal = "Agent stopped inside radius",
              params = {
                value = 7.5,
                stopDuration = 1.5,
                leaveZapBlocked = true
              }
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {hideTerrainMarker = true}
              }
            }
          }
        },
        HUD = {
          {
            style = "Exposition HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Player has snook around the back",
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Agent stopped inside radius",
              params = {
                value = 45,
                stopDuration = 2,
                leaveZapBlocked = true
              }
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      }
    }
  }
  return task
end
local jerichoTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "Linear Checkpoints",
        dynamicTargets = true,
        specialName = "JerichoTask",
        goalConditions = {
          {
            {
              goal = "Within strip of road",
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
          }
        }
      }
    }
  }
  return task
end
local driveTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Linear Checkpoints",
        dynamicTargets = true,
        specialName = "drive to",
        goalConditions = {
          {
            {
              goal = "Within strip of road",
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
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Exposition part 1"].taskCreatorFunctionLookups = {
  ["Jericho team"] = jerichoTask,
  ["Tanner team"] = tannerTask,
  ["Drive team"] = driveTask
}
local spawnCops = vec.vector(-527.5415, 32.88605, 2207.578, 1)
local spawnCops2 = vec.vector(-871.1573, 67.08606, 2132.657, 1)
local cutsceneTriggerPoint = vec.vector(-1449.858, 43.47431, 974.0703, 1)
local jerichoDriveToMissionEndDP = vec.vector(-1440.831, 40.83257, 1036.435, 1)
missionSetupData["Exposition part 1"].initiate = function(instance)
  propSystem.reenableAllPropTypes()
  propSystem.disablePropType("DO_NOT_USE_shutter_B", "DO_NOT_USE_Wall_A")
  Atlas.JerichoAlleyWayActive(true)
  propSystem.setupRuntimeProps(instance.challenge.props, false, false)
  createCheckpoints(instance)
  localPlayer:blockAbility("zap", true)
  createFixedPosition(instance, {spawnCops}, 101)
  createFixedPosition(instance, {spawnCops2}, 101)
  createFixedPosition(instance, {cutsceneTriggerPoint}, 201)
  createFixedPosition(instance, {jerichoDriveToMissionEndDP}, 202)
  Commentary.LoadMission(cards.Missions[instance.challenge.name].MissionID, loadMissionCallBack)
  Sound.LoadMission(cards.Missions[instance.challenge.name].MissionID)
  instance.sample01played = false
  instance.sample02played = false
  instance.shiftEventTriggered = false
  instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.velocity = instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.matrix[2] * 15
  GameVehicleResource.setInfiniteMass(instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle, true)
  feedbackSystem.menusMaster.setFocusButtonText()
  feedbackSystem.menusMaster.blockHintButton(true)
end
missionSetupData["Exposition part 1"].update = nil
local function getTannerTargets(taskObject, task, dynamicListID, conditionKey)
  if task.specialName == "TannerTask" then
    if dynamicListID then
      return false, true
    else
      local teams = {}
      for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
        teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
        table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
      end
      return teams["Jericho team"], false
    end
  elseif task.specialName == "Player has snook around the back" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 201), false
    end
  elseif task.specialName == "Tanner 2nd Task" or task.specialName == "Speech trigger" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 202), false
    end
  elseif task.specialName == "Spawn enemies" then
    if dynamicListID then
      if task.dynamicTargets[dynamicListID].position == spawnCops then
        challengeSystem.spawnActors(task.instance, "Never", {
          ["cop 1"] = true,
          ["cop 2"] = true
        })
      elseif task.dynamicTargets[dynamicListID].position == spawnCops2 then
        challengeSystem.spawnActors(task.instance, "Never", {
          ["cop 3"] = true
        })
      end
      return false, false
    else
      return checkpointSystem.getCheckpoints(task.instance, 101), false
    end
  end
end
local JerichoDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if dynamicListID then
    if task.specialName == "hit" then
      return false, true
    elseif task.networkVars.checkpoints < #allCheckpoints then
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
missionSetupData["Exposition part 1"].targetList = {
  ["Tanner team"] = getTannerTargets,
  ["Jericho team"] = JerichoDynamicTargets,
  ["Drive team"] = JerichoDynamicTargets
}
taskCompleteData["Exposition part 1"] = {}
taskCompleteData["Exposition part 1"].taskComplete = function(taskObject, task)
  local function completeTask()
    feedbackSystem.stopMusic("Uid00247_Exp_WakeUp_Stop")
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local params = {
    callback = completeTask,
    rating = "PASS",
    keepMusicTrackRunning = true
  }
  if task.specialName == "PlayerInTanner" then
    local missionStartBehaviour = {
      traits = taskSystem.buildDriveTraits(task),
      opponentGameVehicle = task.instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle
    }
    player.removeController(localPlayer.localID)
    task.instance.taskObjectsByActorID.Tanner.coreData.agent:highSpeedDrive(missionStartBehaviour)
  elseif task.specialName == "GivePlayerControl" then
    task.instance.taskObjectsByActorID.Tanner.coreData.agent:stopHighSpeedDriving()
    player.setAttachment(localPlayer.localID, localPlayer.currentVehicle.gameVehicle)
    player.registerController(localPlayer.localID)
  elseif task.specialName == "JerichoTask" then
    local jericho = task.instance.taskObjectsByActorID.Jericho.coreData.agent
    GameVehicleResource.applyDamage({
      gameVehicle = jericho.gameVehicle,
      damage = 1
    })
    taskObject.coreData.agent:teleportToPositionAndHeading(vec.vector(-1441.647, 42.70099, 990.1451, 1), 2.053279)
  elseif task.specialName == "Tanner 2nd Task" or task.specialName == "Player has snook around the back" then
    for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team == "Jericho team" then
        taskObject:delete()
      end
    end
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Exposition part 1"] = function(instance)
  if userUpdateFunctions.speechTrigger then
    removeUserUpdateFunction("speechTrigger")
  end
  if instance.taskObjectsByActorID.Jericho then
    GameVehicleResource.setInfiniteMass(instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle, true)
  end
  propSystem.reenableAllPropTypes()
  Atlas.JerichoAlleyWayActive(false)
end
