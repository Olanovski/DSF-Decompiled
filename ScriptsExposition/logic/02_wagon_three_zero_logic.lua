module("cardSystem.logic")
missionSetupData["Exposition pre crash chase"] = {}
local alleyEntrancePosition = vec.vector(437.257, 18.03195, 1755.96, 1)
local function tannerTask(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "TannerChasingJericho",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Jericho"}
              }
            },
            {
              goal = "Within radius of specified actor",
              params = {
                value = 150,
                actorID = "Jericho",
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 20}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Jericho"},
                inverse = true
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
            style = "Exposition pre crash chase HUD"
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
        },
        HUD = {
          {
            style = "Exposition pre crash chase HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Objective prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          }
        },
        HUD = {
          {
            style = "Exposition pre crash chase HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "PIP 01 trigger",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Prompt active",
              params = {promptType = "Primary"}
            },
            {
              goal = "Time trigger",
              params = {value = 4.5}
            }
          }
        },
        HUD = {
          {
            style = "Exposition pre crash chase HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "idle message",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Instance time above",
              params = {value = 15}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Below speed",
              params = {value = 2}
            },
            {
              goal = "Time trigger",
              params = {value = 15}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Player at the alley",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 15}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Player within radius of point",
              params = {
                value = 15,
                position = alleyEntrancePosition,
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Player within radius of point",
              params = {value = 15, position = alleyEntrancePosition}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Player within radius of point",
              params = {
                value = 35,
                position = alleyEntrancePosition,
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Time trigger",
              params = {value = 30}
            }
          }
        },
        HUD = {
          {
            style = "Exposition pre crash chase HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "Linear Checkpoints",
        specialName = "Player at the alley 02",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 80}
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
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "TannerAtTheAlleyway",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 30}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Time trigger",
              params = {value = 30}
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
            style = "Exposition pre crash chase HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Player near alley 02",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within range",
              params = {minimum = 10, maximum = 110}
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
        specialName = "idle message 04 repeat",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Below speed",
              params = {value = 2}
            },
            {
              goal = "Time trigger",
              params = {value = 12}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "mission end",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within strip of road",
              params = {value = 30}
            }
          },
          {
            {
              goal = "Is target ahead",
              params = {inverse = true}
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
local jerichoTask = function(goalParams, HUD)
  local task = {
    enableNonPlayerFeedback = true,
    deleteVehicleOnCompletion = true,
    {
      {
        task = "Linear Checkpoints",
        specialName = "JerichoAtTheAlleyway",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Within strip of road",
              params = {value = 15}
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
        },
        HUD = {
          {
            style = "Exposition pre crash chase HUD"
          }
        }
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Kill task earlier",
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 10}
            },
            {
              goal = "Within radius",
              params = {
                value = 60,
                target = "Player",
                inverse = true
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
      },
      {
        task = "No AI",
        dynamicTargets = true,
        specialName = "Halt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            {
              goal = "Within radius",
              params = {value = 150, target = "Player"}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Is target ahead",
              params = {inverse = true, usePlayer = true}
            },
            {
              goal = "Within radius",
              params = {
                value = 150,
                target = "Player",
                inverse = true
              }
            }
          }
        },
        HUD = {
          {
            style = "Exposition pre crash chase HUD"
          }
        }
      }
    }
  }
  return task
end
local civTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.05}
            }
          }
        }
      }
    },
    {
      {
        task = "Linear Chase",
        dynamicTargets = true,
        specialName == "actor hit",
        taskConditions = {
          {
            {
              goal = "Simple collision check",
              params = {force = 10000, type = "Vehicle"}
            }
          }
        }
      }
    }
  }
  return task
end
local copAttack = function(goalParams, HUD)
  local task = {
    {
      {
        task = "Linear Chase",
        dynamicTargets = true,
        specialName == "jericho hit",
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 50}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Simple collision check",
              params = {force = 8000, type = "Vehicle"}
            }
          },
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          }
        }
      }
    },
    {
      {
        task = "Stop Vehicle"
      }
    }
  }
  return task
end
local busTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "Wander",
        taskConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Garbage"}
              }
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        }
      }
    },
    {
      {
        task = "Stop Vehicle"
      }
    }
  }
  return task
end
local staticTask = function(goalParams, HUD)
  local task = {
    {
      {task = "No AI"}
    }
  }
  return task
end
local driveThenStopTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "Wander",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        }
      }
    },
    {
      {
        task = "Stop Vehicle"
      }
    }
  }
  return task
end
local ambulanceTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Wander",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 6}
            }
          }
        }
      }
    }
  }
  return task
end
local fireTruckTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Linear Checkpoints",
        dynamicTargets = true,
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
missionSetupData["Exposition pre crash chase"].taskCreatorFunctionLookups = {
  ["Jericho team"] = jerichoTask,
  ["Tanner team"] = tannerTask,
  ["Bus Team"] = driveThenStopTask,
  ["Crash Team"] = civTask,
  ["Static Team"] = staticTask,
  ["Approaching cop"] = copAttack,
  ["Approaching cop 2"] = copAttack,
  ["Cop"] = copAttack,
  ["Ambulance"] = ambulanceTask,
  ["Ambulance 2"] = ambulanceTask,
  ["Fire Truck"] = fireTruckTask,
  ["Fire Truck 2"] = fireTruckTask,
  ["Alley cop"] = driveThenStopTask,
  ["Lost cop 1"] = ambulanceTask,
  ["Lost cop 2"] = ambulanceTask
}
local audioLoaded = false
local function loadCommentaryCallBack()
  audioLoaded = true
end
local loadAudioCallBack = function()
  feedbackSystem.startMusic("Uid04855_Exp_WagonThreeZero_Play")
end
local spawnAmbulance2 = vec.vector(87.724, 28.6835, 1538.608, 1)
local spawnGarbage = vec.vector(624.0364, 6.21565, 1158.844, 1)
local spawnFireTruck = vec.vector(700.7288, 6.266353, 1227.473, 1)
local spawnAmbulance = vec.vector(-50.59483, 41.42196, 1600.933, 1)
local spawnApproachingCop = vec.vector(277.103, 15.73109, 1403.839, 1)
local spawnLostCops = vec.vector(707.549, 6.256015, 1385.354, 1)
local fireTarget = vec.vector(980.2525, 6.164065, 1154.941, 1)
local crashAlleyStartPosition = vec.vector(298.9255, 21.62483, 1752.496, 1)
local failSafeDestination = vec.vector(349.3333, 21.54689, 1781.755, 1)
local alleyDriveToLocation = vec.vector(279.0682, 22.43129, 1761.147, 1)
local killJerichosTaskEarlyTriggerPoint = vec.vector(413.5352, 19.98625, 1779.206, 1)
missionSetupData["Exposition pre crash chase"].initiate = function(instance)
  propSystem.disablePropType("DO_NOT_USE_shutter_A", "DO_NOT_USE_shutter_B", "DO_NOT_USE_Wall_A")
  Atlas.JerichoAlleyWayActive(true)
  createCheckpoints(instance)
  localPlayer:blockAbility("zap", true)
  createFixedPosition(instance, {spawnAmbulance2}, 101)
  createFixedPosition(instance, {spawnGarbage}, 101)
  createFixedPosition(instance, {spawnAmbulance}, 101)
  createFixedPosition(instance, {spawnApproachingCop}, 101)
  createFixedPosition(instance, {spawnFireTruck}, 101)
  createFixedPosition(instance, {spawnLostCops}, 101)
  createFixedPosition(instance, {fireTarget}, 102)
  createFixedPosition(instance, {alleyEntrancePosition}, 250)
  createFixedPosition(instance, {crashAlleyStartPosition}, 251)
  createFixedPosition(instance, {alleyDriveToLocation}, 252)
  createFixedPosition(instance, {failSafeDestination}, 253)
  createFixedPosition(instance, {killJerichosTaskEarlyTriggerPoint}, 254)
  Commentary.LoadMission(cards.Missions[instance.challenge.name].MissionID, loadCommentaryCallBack)
  Sound.LoadMission(cards.Missions[instance.challenge.name].MissionID, loadAudioCallBack)
  feedbackSystem.menusMaster.setFocusButtonText()
  GameVehicleResource.setInfiniteMass(instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle, true)
  instance.taskObjectsByActorID.Jericho.coreData.actor.rubberBandIgnoreRaceCheckpoints = true
end
missionSetupData["Exposition pre crash chase"].update = nil
local function TannerTargets(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "TannerAtTheAlleyway" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 251), false
    end
  elseif task.specialName == "Player near alley" or task.specialName == "Player near alley 02" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 251), false
    end
  elseif task.specialName == "Spawn enemies" then
    if dynamicListID then
      if task.dynamicTargets[dynamicListID].position == spawnAmbulance then
        challengeSystem.spawnActors(task.instance, "Never", {Ambulance = true})
      elseif task.dynamicTargets[dynamicListID].position == spawnAmbulance2 then
        challengeSystem.spawnActors(task.instance, "Never", {
          ["Ambulance 2"] = true
        })
      elseif task.dynamicTargets[dynamicListID].position == spawnGarbage then
        challengeSystem.spawnActors(task.instance, "Never", {Garbage = true})
      elseif task.dynamicTargets[dynamicListID].position == spawnFireTruck then
        challengeSystem.spawnActors(task.instance, "Never", {
          ["Fire Truck"] = true,
          ["Fire Truck 2"] = true
        })
      elseif task.dynamicTargets[dynamicListID].position == spawnLostCops then
        challengeSystem.spawnActors(task.instance, "Never", {
          ["Lost cop 2"] = true
        })
      end
      return false, false
    else
      return checkpointSystem.getCheckpoints(task.instance, 101), false
    end
  elseif task.specialName == "Tanner outside the alley" or task.specialName == "Player at the alley" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 250), false
    end
  elseif task.specialName == "Player at the alley 02" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 253), false
    end
  elseif task.specialName == "mission end" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 254), false
    end
  end
end
local JerichoDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "JerichoAtTheAlleyway" then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
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
  elseif task.specialName == "Halt" then
    if dynamicListID then
      return {
        task.instance.taskObjectsByActorID.Tanner.coreData.agent
      }, true
    else
      return {
        task.instance.taskObjectsByActorID.Tanner.coreData.agent
      }, false
    end
  elseif task.specialName == "Kill task earlier" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 254), false
    end
  end
end
local CrashDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if dynamicListID then
    return false, false
  elseif taskObject.coreData.actor.ID == "Civ 1" then
    return {
      task.instance.taskObjectsByActorID["Civ 2"].coreData.agent
    }, false
  elseif taskObject.coreData.actor.ID == "Civ 2" then
    return {
      task.instance.taskObjectsByActorID["Civ 1"].coreData.agent
    }, false
  elseif taskObject.coreData.actor.ID == "Fire Truck" then
    return checkpointSystem.getCheckpoints(task.instance, 102), false
  else
    return {
      task.instance.taskObjectsByActorID.Jericho.coreData.agent
    }, false
  end
end
missionSetupData["Exposition pre crash chase"].targetList = {
  ["Tanner team"] = TannerTargets,
  ["Jericho team"] = JerichoDynamicTargets,
  ["Crash Team"] = CrashDynamicTargets
}
taskCompleteData["Exposition pre crash chase"] = {}
taskCompleteData["Exposition pre crash chase"].taskComplete = function(taskObject, task)
  local missionEndBehaviour = {
    traits = taskSystem.buildDriveTraits(task),
    destinationPosition = alleyDriveToLocation
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  local params = {callback = completeTask, rating = "PASS"}
  if task.success then
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
    elseif task.specialName == "TannerAtTheAlleyway" then
      player.removeController(localPlayer.localID)
      task.instance.taskObjectsByActorID.Tanner.coreData.agent:highSpeedDrive(missionEndBehaviour)
    elseif task.specialName == "mission end" then
      localPlayer:enterCutsceneMode()
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "JerichoAtTheAlleyway" or task.specialName == "Kill task earlier" then
      GameVehicleResource.setInfiniteMass(task.instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle, false)
    elseif task.specialName == "actor hit" then
      GameVehicleResource.applyDamage({
        gameVehicle = task.agent.gameVehicle,
        damage = 1
      })
    end
  elseif task.specialName == "Player at the alley" or task.specialName == "TannerAtTheAlleyway" then
    params.callback = failTask
    params.rating = "FAIL"
    params.failReason = "ID:231193"
    params.hint = "ID:248332"
    params.vehicle = task.agent
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Exposition pre crash chase"] = function(instance)
  if instance.taskObjectsByActorID.Jericho then
    GameVehicleResource.setInfiniteMass(instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle, false)
  end
end
