module("cardSystem.logic")
missionSetupData["Tanker on fire activity"] = {}
local tankerStartWaterLevel = 115
local cutsceneMode = function()
  if not localPlayer.inCutscene then
    feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:245560", priority = 1})
    localPlayer:enterCutsceneMode({prompts = true})
    removeUserUpdateFunction("EnterCutscene")
  end
end
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
local playerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Initial wait",
        taskConditions = {
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
        task = "No AI",
        specialName = "In first truck",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "Fire team member 1"
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
        task = "No AI",
        specialName = "First tanker",
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Tanker2"},
                inverse = true
              }
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Tanker1"},
                inverse = true
              }
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Tanker2"},
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
          {style = HUD}
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Congrats 1",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          },
          {
            {
              goal = "Player in zap",
              params = {levelOfZap = 2, checkLevelType = "above"}
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
        task = "No AI",
        specialName = "In second truck",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "Fire team member 2"
              }
            }
          },
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "Fire team member 2a"
              }
            }
          },
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "Fire team member 2b"
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
        task = "No AI",
        specialName = "Second tanker",
        taskConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Tanker3"},
                inverse = true
              }
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Tanker4"},
                inverse = true
              }
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Tanker5"},
                inverse = true
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
        task = "No AI",
        specialName = "Congrats 2",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          },
          {
            {
              goal = "Player in zap",
              params = {levelOfZap = 2, checkLevelType = "above"}
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
        task = "No AI",
        specialName = "In third truck",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "Fire team member 3"
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
        task = "No AI",
        specialName = "Third tanker",
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Tanker7"},
                inverse = true
              }
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Tanker6"},
                inverse = true
              }
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Tanker7"},
                inverse = true
              }
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {style = HUD}
        }
      }
    }
  }
  return task
end
local tankerTask = function(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "Payload Tracking",
        specialName = "Tanker payload",
        startingValues = {payload = 40},
        goalConditions = {
          {
            {
              goal = "Actor is in major order",
              params = {
                actorID = "New Actor",
                value = {
                  3,
                  6,
                  9
                }
              }
            },
            {
              goal = "X time has past",
              params = {value = 0.5}
            },
            {
              goal = "Being sprayed by fire engine",
              params = {
                value = 30,
                inRangeScore = -5,
                outRangeScore = 0.5
              }
            }
          },
          {
            {
              goal = "Actor is in major order",
              params = {
                actorID = "New Actor",
                value = {3}
              }
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Tanker2"},
                inverse = true
              }
            }
          },
          {
            {
              goal = "Actor is in major order",
              params = {
                actorID = "New Actor",
                value = {6}
              }
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Tanker4"},
                inverse = true
              }
            }
          },
          {
            {
              goal = "Actor is in major order",
              params = {
                actorID = "New Actor",
                value = {6}
              }
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Tanker5"},
                inverse = true
              }
            }
          },
          {
            {
              goal = "Actor is in major order",
              params = {
                actorID = "New Actor",
                value = {9}
              }
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Tanker7"},
                inverse = true
              }
            }
          },
          {
            {
              goal = "Payload over",
              params = {value = 80}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Payload under",
              params = {value = 0}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Payload over",
              params = {value = 100}
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
          {style = HUD}
        }
      },
      {
        task = "No AI",
        specialName = "Reminder prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 10}
            }
          },
          {
            {
              goal = "Changed vehicle"
            },
            {
              goal = "Is player in vehicle model",
              params = {value = 186}
            }
          }
        }
      }
    }
  }
  return task
end
local function fireTask(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Follow Route"
      },
      {
        task = "No AI",
        specialName = "Fireman",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Actor is in major order",
              params = {
                actorID = "New Actor",
                value = {
                  3,
                  6,
                  9
                }
              }
            },
            {
              goal = "Within radius of specified actor",
              params = {
                value = 30,
                inverse = true,
                actorID = "New Actor"
              }
            },
            {
              goal = "Within radius of opposing team member (feedback closest target if in radius)",
              params = {value = 30, trailer = true},
              feedback = "Vehicle"
            }
          },
          {
            {
              goal = "Player in zap",
              params = {levelOfZap = 1}
            },
            {
              goal = "Actor is in major order",
              params = {
                actorID = "New Actor",
                value = {
                  3,
                  6,
                  9
                }
              }
            },
            {
              goal = "Within radius of specified actor",
              params = {
                value = 30,
                inverse = true,
                actorID = "New Actor"
              }
            },
            {
              goal = "Within radius of opposing team member (feedback closest target if in radius)",
              params = {value = 30, trailer = true},
              feedback = "Vehicle"
            }
          },
          {
            {
              goal = "Player within radius of opposing team member",
              params = {
                value = 30,
                trailer = true,
                inverse = true
              }
            }
          },
          {
            {
              goal = "Player in zap",
              params = {levelOfZap = 2, checkLevelType = "above"}
            }
          }
        },
        HUD = {
          {style = HUD}
        }
      },
      {
        task = "Payload Tracking",
        specialName = "Fire engine water level",
        startingValues = {payload = tankerStartWaterLevel},
        goalConditions = {
          {
            autoRefresh = true,
            failCondition = true,
            {
              goal = "Player in zap",
              params = {levelOfZap = 3, checkLevelType = "below"}
            },
            {
              goal = "Actor is in major order",
              params = {
                actorID = "New Actor",
                value = {
                  3,
                  6,
                  9
                }
              }
            },
            {
              goal = "Within radius of specified actor",
              params = {
                value = 30,
                inverse = true,
                actorID = "New Actor"
              }
            },
            {
              goal = "Player within radius of opposing team member",
              params = {value = 30, trailer = true},
              feedback = "Vehicle"
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Payload under",
              params = {value = 0}
            }
          },
          {
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {style = HUD}
        }
      }
    }
  }
  return task
end
missionSetupData["Tanker on fire activity"].taskCreatorFunctionLookups = {
  ["Tanker team"] = tankerTask,
  ["Fire team"] = fireTask,
  ["Player team"] = playerTask
}
missionSetupData["Tanker on fire activity"].initiate = function(instance)
  localPlayer:blockAbility("zapReturn", true)
  addUserUpdateFunction("EnterCutscene", cutsceneMode, 1)
  challengeSystem.spawnActors(instance, "Any", {
    ["Tanker2"] = true,
    ["Fire team member 1"] = true
  })
  instance.taskObjectsByActorID.Tanker1.coreData.agent.iconsVisible = false
  instance.taskObjectsByActorID.Tanker2.coreData.agent.iconsVisible = false
  instance.taskObjectsByActorID["New Actor"].coreData.agent.iconsVisible = false
  civilianTraffic.AddScriptLaneTrackInterloper(instance.taskObjectsByActorID.Tanker1.coreData.agent.gameVehicle, LaneTrackFollowerRejectionCallback)
  civilianTraffic.AddScriptLaneTrackInterloper(instance.taskObjectsByActorID.Tanker2.coreData.agent.gameVehicle, LaneTrackFollowerRejectionCallback)
  instance.challenge.actorPool["Fire team member 1"].spawn.relativeToVehicle.actor = "Tanker2"
  instance.challenge.actorPool["Fire team member 3"].spawn.relativeToVehicle.actor = "Tanker7"
end
missionSetupData["Tanker on fire activity"].update = nil
taskCompleteData["Tanker on fire activity"] = {}
taskCompleteData["Tanker on fire activity"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = localPlayer.currentVehicle,
    successReason = "ID:245561",
    failReason = "ID:245562",
    hint = "ID:245266",
    driverIsTanner = true
  }
  if task.success then
    if task.specialName == "Initial wait" then
      localPlayer:exitCutsceneMode()
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:178438", priority = 1})
      task.instance.taskObjectsByActorID["Fire team member 1"].coreData.agent.remainingWater = tankerStartWaterLevel
    elseif task.specialName == "Congrats 1" then
      if not localPlayer.inZap then
        localPlayer:SetZapLevel(5, nil, true)
      end
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:178438", priority = 2})
      challengeSystem.spawnActors(task.instance, "Any", {
        ["Tanker3"] = true,
        ["Tanker4"] = true,
        ["Tanker5"] = true,
        ["Fire team member 2"] = true,
        ["Fire team member 2a"] = true,
        ["Fire team member 2b"] = true
      })
      task.instance.taskObjectsByActorID.Tanker3.coreData.agent.iconsVisible = false
      task.instance.taskObjectsByActorID.Tanker4.coreData.agent.iconsVisible = false
      task.instance.taskObjectsByActorID.Tanker5.coreData.agent.iconsVisible = false
      task.instance.taskObjectsByActorID.Tanker3.namedTasks["Tanker payload"].networkVars.payload = 20
      task.instance.taskObjectsByActorID.Tanker4.namedTasks["Tanker payload"].networkVars.payload = 20
      task.instance.taskObjectsByActorID.Tanker5.namedTasks["Tanker payload"].networkVars.payload = 20
      civilianTraffic.AddScriptLaneTrackInterloper(task.instance.taskObjectsByActorID.Tanker3.coreData.agent.gameVehicle, LaneTrackFollowerRejectionCallback)
      task.instance.taskObjectsByActorID["Fire team member 2"].coreData.agent.remainingWater = tankerStartWaterLevel
    elseif task.specialName == "In second truck" then
      task.instance.taskObjectsByActorID.Tanker3.coreData.agent.iconsVisible = true
      task.instance.taskObjectsByActorID.Tanker4.coreData.agent.iconsVisible = true
      task.instance.taskObjectsByActorID.Tanker5.coreData.agent.iconsVisible = true
    elseif task.specialName == "Congrats 2" then
      if not localPlayer.inZap then
        localPlayer:SetZapLevel(5, nil, true)
      end
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:178438", priority = 2})
      challengeSystem.spawnActors(task.instance, "Any", {
        ["Tanker6"] = true,
        ["Tanker7"] = true,
        ["Fire team member 3"] = true
      })
      task.instance.taskObjectsByActorID.Tanker6.coreData.agent.iconsVisible = false
      task.instance.taskObjectsByActorID.Tanker7.coreData.agent.iconsVisible = false
      task.instance.taskObjectsByActorID.Tanker6.namedTasks["Tanker payload"].networkVars.payload = 40
      task.instance.taskObjectsByActorID.Tanker7.namedTasks["Tanker payload"].networkVars.payload = 50
      civilianTraffic.AddScriptLaneTrackInterloper(task.instance.taskObjectsByActorID.Tanker6.coreData.agent.gameVehicle, LaneTrackFollowerRejectionCallback)
      civilianTraffic.AddScriptLaneTrackInterloper(task.instance.taskObjectsByActorID.Tanker7.coreData.agent.gameVehicle, LaneTrackFollowerRejectionCallback)
      task.instance.taskObjectsByActorID["Fire team member 3"].coreData.agent.remainingWater = tankerStartWaterLevel
    elseif task.specialName == "In third truck" then
      task.instance.taskObjectsByActorID.Tanker6.coreData.agent.iconsVisible = true
      task.instance.taskObjectsByActorID.Tanker7.coreData.agent.iconsVisible = true
    elseif task.specialName == "First tanker" or task.specialName == "Second tanker" then
      for k, v in next, task.instance.taskObjectsByActorID, nil do
        if string.find(k, "Fire") then
          GameVehicleResource.setGunTarget(v.coreData.agent.gameVehicle)
          v:delete()
          break
        end
      end
      Sound.ClearAllSourceVehicles()
      GameVehicleResource.setGunTarget(localPlayer.currentVehicle.gameVehicle)
    elseif task.specialName == "Third tanker" then
      local function completeTask()
        progressionSystem.challengeComplete(task.instance, task.agent.matrix)
      end
      params.callback = completeTask
      params.rating = "PASS"
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "Fire engine water level" or task.specialName == "Fireman" then
      GameVehicleResource.setGunTarget(taskObject.coreData.agent.gameVehicle)
      taskObject:delete(false)
      if task.actor.ID ~= "Fire team member 2" or not not task.instance.taskObjectsByActorID.Tanker3 then
        challengeSystem.spawnActors(task.instance, "Any", {
          [task.actor.ID] = true
        })
        task.instance.taskObjectsByActorID[task.actor.ID].coreData.agent.remainingWater = tankerStartWaterLevel
      end
    elseif task.specialName == "Reminder prompt" then
      if task.condition == 1 then
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:178438", priority = 2})
      end
    elseif task.specialName == "Tanker payload" then
      civilianTraffic.RemoveScriptLaneTrackInterloper(task.agent.gameVehicle)
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:245190", priority = 2})
      if task.actor.ID == "Tanker3" then
        if task.instance.taskObjectsByActorID["Fire team member 2"] then
          GameVehicleResource.setGunTarget(task.instance.taskObjectsByActorID["Fire team member 2"].coreData.agent.gameVehicle)
          task.instance.taskObjectsByActorID["Fire team member 2"]:delete()
        end
      elseif task.actor.ID == "Tanker4" then
        if task.instance.taskObjectsByActorID["Fire team member 2b"] then
          GameVehicleResource.setGunTarget(task.instance.taskObjectsByActorID["Fire team member 2b"].coreData.agent.gameVehicle)
          task.instance.taskObjectsByActorID["Fire team member 2b"]:delete()
        end
      elseif task.actor.ID == "Tanker5" and task.instance.taskObjectsByActorID["Fire team member 2a"] then
        GameVehicleResource.setGunTarget(task.instance.taskObjectsByActorID["Fire team member 2a"].coreData.agent.gameVehicle)
        task.instance.taskObjectsByActorID["Fire team member 2a"]:delete()
      end
    end
  else
    if task.specialName == "Tanker payload" then
      civilianTraffic.RemoveScriptLaneTrackInterloper(task.agent.gameVehicle)
      GameVehicleResource.explode({
        gameVehicle = task.agent.gameVehicle,
        attachedVehicle = "Child",
        offset = vec.vector(0, 3.5, 3.5, 1),
        range = 1,
        strength = 100
      })
    end
    local function failTask()
      progressionSystem.challengeFailed(task.instance, task.agent.matrix)
    end
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Tanker on fire activity"] = function(instance)
  Sound.ClearAllSourceVehicles()
  localPlayer:blockAbility("zapReturn", false)
  localPlayer:exitCutsceneMode()
  removeUserUpdateFunction("EnterCutscene")
  removeUserUpdateFunction("delaySteam")
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.team == "Tanker team" then
      civilianTraffic.RemoveScriptLaneTrackInterloper(taskObject.coreData.agent.gameVehicle)
      ParticleEditor.StopEvent(taskObject.coreData.agent.SNVID)
      ParticleEditor.StopEvent(taskObject.coreData.agent.SNVID * 3)
      ParticleEditor.StopEvent(taskObject.coreData.agent.SNVID * 3 + 1)
      ParticleEditor.StopEvent(taskObject.coreData.agent.SNVID * 3 + 2)
    end
  end
end
