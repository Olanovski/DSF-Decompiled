module("cardSystem.logic")
missionSetupData["Charity 2"] = {}
local LaneTrackFollowerRejectionCallback = function(gameVehicle, reason)
  print("LaneTrackFollowerRejectionCallback " .. tostring(gameVehicle) .. " " .. tostring(reason))
  if reason == "OutSideSimulation" then
    print("OutSideSimulation - Should never fire")
  elseif reason == "OffCarrier" then
    local truckAgent = vehicleManager.vehiclesByGameVehicle[gameVehicle]
    local behaviour = {
      personality = "civ",
      traits = {
        desiredSpeed = 50,
        wanderType = "preferStraight",
        avoidedByCivilianTraffic = true
      }
    }
    truckAgent:highSpeedDrive(behaviour)
  end
end
local function nextVehicle(task)
  localPlayer:clearZapReturnOverride()
  localPlayer:clearCurrentVehicle()
  if task.instance.collectedVehicles == 1 then
    challengeSystem.spawnActors(task.instance, "Never", {
      ["Car 2"] = true,
      ["Truck 2"] = true
    })
    GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID["Truck 2"].coreData.agent.gameVehicle, true)
    localPlayer.missionSupport:setMainTaskObject(task.instance.taskObjectsByActorID["Car 2"])
    localPlayer:zapToAgent(task.instance.taskObjectsByActorID["Car 2"].coreData.agent)
  elseif task.instance.collectedVehicles == 2 then
    challengeSystem.spawnActors(task.instance, "Never", {
      ["Car 3"] = true,
      ["Truck 3"] = true
    })
    GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID["Truck 3"].coreData.agent.gameVehicle, true)
    localPlayer.missionSupport:setMainTaskObject(task.instance.taskObjectsByActorID["Car 3"])
    localPlayer:zapToAgent(task.instance.taskObjectsByActorID["Car 3"].coreData.agent)
  elseif task.instance.collectedVehicles == 3 then
    challengeSystem.spawnActors(task.instance, "Never", {
      ["Car 4"] = true,
      ["Truck 4"] = true,
      ["Spawner 1"] = true,
      ["Spawner 2"] = true,
      ["Spawner 3"] = true
    })
    GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID["Truck 4"].coreData.agent.gameVehicle, true)
    civilianTraffic.AddScriptLaneTrackInterloper(task.instance.taskObjectsByActorID["Truck 4"].coreData.agent.gameVehicle, LaneTrackFollowerRejectionCallback)
    local missionStartBehaviour = {
      traits = taskSystem.buildDriveTraits(task),
      opponentGameVehicle = task.instance.taskObjectsByActorID["Truck 4"].coreData.agent.gameVehicle
    }
    player.removeController(localPlayer.localID)
    task.instance.taskObjectsByActorID["Car 4"].coreData.agent:highSpeedDrive(missionStartBehaviour)
    GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID["Car 4"].coreData.agent.gameVehicle.position, 60)
    localPlayer.missionSupport:setMainTaskObject(task.instance.taskObjectsByActorID["Car 4"])
    localPlayer:zapToAgent(task.instance.taskObjectsByActorID["Car 4"].coreData.agent)
  end
end
local tutorialStarted = false
local startTask = function(goalParams, HUD)
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
              params = {value = 3},
              feedback = "Time"
            }
          }
        },
        HUD = {
          {
            style = "Charity 2 hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Get vehicle in truck start",
        taskConditions = {
          {
            {
              goal = "In back of truck"
            },
            {
              goal = "Time trigger",
              params = {value = 0.6}
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
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Charity 2 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Lock controls",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "In back of truck"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Force to level 2 shift",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        }
      }
    }
  }
  return task
end
local carTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "Get vehicle in truck",
        taskConditions = {
          {
            {
              goal = "In back of truck"
            },
            {
              goal = "Time trigger",
              params = {value = 0.6}
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
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Charity 2 hud"
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
        specialName = "Lock controls",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "In back of truck"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Force to level 2 shift",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        }
      }
    }
  }
  return task
end
local aTeamTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Wander",
        specialName = "PlayerInTanner",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Get vehicle in truck",
        taskConditions = {
          {
            {
              goal = "In back of truck"
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
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Charity 2 hud"
          }
        }
      }
    }
  }
  return task
end
local chaserTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Non-linear Chase",
        dynamicTargets = true,
        specialName = "ATeamChasers",
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
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            {goal = "Got busted"}
          },
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "All targets being towed"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Chasers back off",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Specified actor within radius of specified actor",
              params = {
                firstActorID = "Car 4",
                secondActorID = "Truck 4",
                value = 35
              }
            }
          }
        }
      }
    }
  }
  return task
end
local truckFollowTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "truck waiting to start",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        }
      }
    },
    {
      {
        task = "Follow Route",
        specialName = "truck task",
        taskConditions = {
          {
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            },
            {
              goal = "Changed vehicle"
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
    }
  }
  return task
end
local truckNoAITask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "static truck waiting to start",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "static truck task",
        taskConditions = {
          {
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            },
            {
              goal = "Changed vehicle"
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
    }
  }
  return task
end
missionSetupData["Charity 2"].taskCreatorFunctionLookups = {
  ["Car 1"] = startTask,
  ["Car team"] = carTask,
  ["Car 4"] = aTeamTask,
  ["Truck 3"] = truckFollowTask,
  ["Truck team"] = truckNoAITask,
  ["Spawner team"] = chaserTask
}
missionSetupData["Charity 2"].initiate = function(instance)
  localPlayer:blockAbility("zap", true)
  createCheckpoints(instance)
  GameVehicleResource.registerAttachedVehicleCallback(vehicleManager.attachedVehicleCallback)
  GameVehicleResource.registerAttachedVehicleDeleteRequestFn(vehicleManager.attachedVehicleDeleteRequest)
  GameVehicleResource.setCanCaptureCars(instance.taskObjectsByActorID["Truck 1"].coreData.agent.gameVehicle, true)
  instance.collectedVehicles = 0
  localPlayer:enterCutsceneMode()
end
missionSetupData["Charity 2"].update = nil
local carTeamDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID["Car 4"].coreData.agent
    }, false
  end
end
missionSetupData["Charity 2"].targetList = {
  ["Spawner team"] = carTeamDynamicTargets
}
taskCompleteData["Charity 2"] = {}
taskCompleteData["Charity 2"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.agent,
    cameraShots = cameraShots[2],
    successReason = "ID:245582",
    hint = "ID:235485"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.actor.team == "Car team" then
    if task.success then
      if task.specialName == "Start Challenge tutorial" then
        if not tutorialStarted then
          tutorialStarted = true
          ProfileSettings.SetToolTipShown(toolTipLookupTable.Challenge)
          CutsceneFiles.tutorials.playTutorial("ID:245644")
        end
      elseif task.specialName == "Start Movie Challenge tutorial" then
        if not tutorialStarted then
          tutorialStarted = true
          ProfileSettings.SetToolTipShown(toolTipLookupTable["Movie Challenge"])
          CutsceneFiles.tutorials.playTutorial("ID:245648")
        end
      elseif task.specialName == "Wait for countdown" then
        localPlayer:exitCutsceneMode()
        feedbackSystem.menusMaster.primaryTextPromptParam({
          prompt = "ID:234229",
          delay = true,
          priority = 1
        })
      elseif task.specialName == "Get vehicle in truck start" then
        task.instance.collectedVehicles = task.instance.collectedVehicles + 1
        nextVehicle(task)
      elseif task.specialName == "Get vehicle in truck" then
        task.instance.collectedVehicles = task.instance.collectedVehicles + 1
        if task.instance.collectedVehicles == 4 then
          localPlayer:zapToAgent(task.instance.taskObjectsByActorID["Truck 4"].coreData.agent)
          civilianTraffic.RemoveScriptLaneTrackInterloper(task.instance.taskObjectsByActorID["Truck 4"].coreData.agent.gameVehicle)
          params.vehicle = task.instance.taskObjectsByActorID["Truck 4"].coreData.agent
          if feedbackSystem.getTimer() < math.floor(singlePlayerStatistics.getScoreStatistic()) / 100 then
            params.rating = "PASS"
            params.callback = completeTask
            singlePlayerStatistics.updateScoreStatistic(feedbackSystem.getTimer(), "Time")
          else
            params.failReason = "ID:231222"
            params.rating = "FAIL"
            params.callback = failTask
          end
          localPlayer.challenge.endScreen(taskObject, params)
        else
          nextVehicle(task)
        end
      elseif task.specialName == "Lock controls" then
        localPlayer:enterCutsceneMode()
      elseif task.specialName == "Force to level 2 shift" then
        localPlayer:SetZapLevel(3, nil, true)
      elseif task.specialName == "PlayerInTanner" then
        localPlayer:exitCutsceneMode()
        if task.instance.taskObjectsByActorID["Car 4"] then
          task.instance.taskObjectsByActorID["Car 4"].coreData.agent:stopHighSpeedDriving()
          player.setAttachment(localPlayer.localID, task.instance.taskObjectsByActorID["Car 4"].coreData.agent.gameVehicle)
          player.registerController(localPlayer.localID)
          local evaderGameVehicle = task.instance.taskObjectsByActorID["Car 4"].coreData.agent.gameVehicle
          felony_getaway.addEvader(evaderGameVehicle)
          for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
            if taskObject.coreData.actor.team == "Spawner team" then
              felony_getaway.addChaser(evaderGameVehicle, taskObject.coreData.agent.gameVehicle)
            end
          end
        end
      end
    else
      if 1 <= task.agent.damage then
        params.failReason = "ID:173965"
      else
        params.failReason = "ID:231166"
      end
      params.rating = "FAIL"
      params.callback = failTask
      params.driverIsTanner = true
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "Chasers back off" then
    task.actor.tailingDistance = 35
    task.actor.groupAggression = "Low"
  end
end
missionEndCallback["Charity 2"] = function(instance)
  localPlayer:blockAbility("zap", false)
  if instance.taskObjectsByActorID["Truck 4"] then
    civilianTraffic.RemoveScriptLaneTrackInterloper(instance.taskObjectsByActorID["Truck 4"].coreData.agent.gameVehicle)
  end
  GameVehicleResource.unregisterAttachedVehicleCallback(vehicleManager.attachedVehicleCallback)
  GameVehicleResource.unregisterAttachedVehicleDeleteRequestFn(vehicleManager.attachedVehicleDeleteRequest)
end
