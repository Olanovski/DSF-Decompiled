module("cardSystem.logic")
missionSetupData["In the nick of time"] = {}
local chaseSettings = felony_chase.getSpecifiedMissionChaseSettings("In the nick of time")
local spawnSpeed = 13.41
local ramPromptActive = false
local disposalVanTasks = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Linear Checkpoints No AI",
        specialName = "getToTheBomb",
        dynamicTargets = true,
        coreData = {
          totalLaps = goalParams["Total laps"] or 0
        },
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 350}
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
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Instance time above",
              params = {
                value = goalParams["Time limit"]
              }
            }
          },
          {
            forceTaskComplete = true,
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
          {style = HUD}
        },
        audioPIP = audio
      },
      {
        task = "Follow Route",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        specialName = "Show Prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
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
        specialName = "closeToCops",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Outside radius of all targets",
              params = {value = 150}
            },
            {
              goal = "Losing getaway time trigger",
              params = {value = 15, prompt = "ID:245304"}
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "audio dialogue 1",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 20}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "audio dialogue 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 40}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "audio dialogue 3",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {
                value = goalParams["Time limit"] / 4 * 3
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Zapped out 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
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
        audioPIP = audio
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "getToTheBomb2",
        dynamicTargets = true,
        coreData = {
          totalLaps = goalParams["Total laps"] or 0
        },
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 110}
            }
          },
          {
            {
              goal = "Being towed",
              params = {towedBy = "Player"}
            },
            {
              goal = "Within radius",
              params = {value = 110}
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
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Instance time above",
              params = {
                value = goalParams["Time limit"]
              }
            }
          },
          {
            forceTaskComplete = true,
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
          },
          {
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {}
              }
            }
          }
        },
        HUD = {
          {
            style = HUD,
            settings = {killTimerAtEnd = true}
          }
        }
      },
      {
        task = "No AI",
        specialName = "Zapped out 12",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
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
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "transition finished",
        taskConditions = {
          {
            {
              goal = "Player in zap transition",
              params = {value = false}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "cutscene finished",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          }
        }
      }
    }
  }
  return task
end
local copChaseTasks = function(goalParams, HUD, audio)
  local task = {
    {
      {task = "No AI"}
    }
  }
  return task
end
local playerTasks = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait for chase",
        taskConditions = {
          {
            {
              goal = "Is a felony active"
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Chaser logic",
        taskConditions = {
          {
            failCondition = true,
            {
              goal = "All chaser teammates wrecked"
            }
          },
          {
            failCondition = true,
            {
              goal = "Getaway escaped"
            }
          },
          {
            {
              goal = "Busted getaway"
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
            style = HUD,
            settings = {updateHealth = true}
          }
        }
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "Ram reminder",
        goalConditions = {
          {
            autoRefresh = true,
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
              params = {value = 10}
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
              goal = "Within radius of getaway",
              params = {value = 40}
            },
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Player using ram"
            },
            {
              goal = "Within radius of getaway",
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
              params = {value = 2, thisInstance = true}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "player in chase cop",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            }
          },
          {
            {
              goal = "Player controlling specified chaser",
              params = {ID = 2}
            }
          },
          {
            {
              goal = "Player controlling specified chaser",
              params = {
                ID = {1, 2},
                inverse = true
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Zapped out 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
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
        audioPIP = audio
      }
    }
  }
  return task
end
local copEscortTasks = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Follow Route",
        specialName = "copEscort",
        dynamicTargets = true,
        coreData = {
          totalLaps = goalParams["Total laps"] or 0
        },
        groupProgression = {priorityMinorOrder = true},
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
              params = {coreValue = "totalLaps"}
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
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Bomb goon"}
              }
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "copEscortStop",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Agent stopped inside radius",
              params = {value = 8, stopDuration = 0.2}
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
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Bomb goon"}
              }
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait at bomb"
      }
    }
  }
  return task
end
missionSetupData["In the nick of time"].taskCreatorFunctionLookups = {
  ["Disposal van team"] = disposalVanTasks,
  ["Cop team"] = copEscortTasks,
  ["Bomb goon team"] = copChaseTasks,
  ["Cop chase team"] = copChaseTasks,
  ["Cop prop team"] = copChaseTasks,
  ["Player team"] = playerTasks
}
missionSetupData["In the nick of time"].initiate = function(instance)
  createCheckpoints(instance)
  instance.playerPreviousVehicle = nil
  local softSaveData = progressionSystem.getSoftSaveData()
  if not softSaveData then
    feedbackSystem.startMusic("Uid05367_CH03_Standard_NickOfTime_Play")
  end
  ramPromptActive = false
end
missionSetupData["In the nick of time"].update = nil
local disposalVanRouteTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "getToTheBomb" or task.specialName == "getToTheBomb2" then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
      return {
        allCheckpoints[1]
      }, true
    else
      return {
        allCheckpoints[task.networkVars.checkpoints]
      }, false
    end
  elseif task.specialName == "closeToCops" or task.specialName == "closeToCops2" then
    if dynamicListID then
      return false, true
    else
      local teams = {}
      for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == "Cop team" then
          table.insert(teams, taskObject.coreData.agent)
        end
      end
      return teams, false
    end
  end
end
local copRouteTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "copEscort" then
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
  elseif task.specialName == "copEscortStop" then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
      return false, true
    else
      return {
        allCheckpoints[#allCheckpoints]
      }, false
    end
  end
end
local playerTargets = function(taskObject, task, dynamicListID)
  local teams = {}
  for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
    teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
    table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
  end
  return teams["Bomb goon team"], false
end
missionSetupData["In the nick of time"].targetList = {
  ["Cop team"] = copRouteTargets,
  ["Disposal van team"] = disposalVanRouteTargets,
  ["Player team"] = playerTargets
}
missionSetupData["In the nick of time"].goalComplete = function(taskObject, task, conditionKey)
  if task.specialName == "Ram reminder" then
    if conditionKey == 1 then
      ramPromptActive = true
      local prompt = {
        prompt = "ID:245322",
        priority = 3,
        icon1 = localPlayer.buttonLayout.ramAbility,
        watchFor = {
          button = "Activate_Ram",
          pressType = "Pressed"
        },
        endCallback = function()
          ramPromptActive = false
        end
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    elseif conditionKey == 2 then
      ramPromptActive = true
      local prompt = {
        prompt = "ID:246400",
        priority = 3,
        icon1 = localPlayer.buttonLayout.ramAbility,
        watchFor = {
          button = "Activate_Ram",
          pressType = "NotPressed"
        },
        endCallback = function()
          ramPromptActive = false
        end
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    elseif conditionKey == 3 and ramPromptActive then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      ramPromptActive = false
    end
  elseif task.specialName == "player in chase cop" then
    task.instance.playerPreviousVehicle = conditionKey
  end
end
local startTime
taskCompleteData["In the nick of time"] = {}
taskCompleteData["In the nick of time"].taskComplete = function(taskObject, task)
  local params = {
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "",
    dialogue = "",
    hintIcon1 = localPlayer.buttonLayout.zapReturn,
    driverIsTanner = false
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if taskObject.coreData.actor.team == "Disposal van team" then
    if task.success then
      if task.specialName == "getToTheBomb" then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        feedbackSystem.menusMaster.primaryTextPrompt("ID:184850", nil, false, false, false)
        feedbackSystem.menusMaster.setCurrentFocusString(2)
        if task.instance.taskObjectsByActorID["Cop escort 1"] then
          task.instance.taskObjectsByActorID["Cop escort 1"].coreData.actor.markerType = "Objective"
        end
        if task.instance.taskObjectsByActorID["Cop escort 2"] then
          task.instance.taskObjectsByActorID["Cop escort 2"].coreData.actor.markerType = "Objective"
        end
      elseif task.specialName == "getToTheBomb2" then
        localPlayer:blockAbility("zapReturn", true)
        localPlayer:blockAbility("zap", true)
      elseif task.specialName == "transition finished" then
        for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
          if taskObject.coreData.actor.team == "Cop team" or taskObject.coreData.actor.team == "Cop prop team" then
            taskObject:delete()
          end
        end
        progressionSystem.triggerSoftSave({progression = 1})
        feedbackSystem.stopMusic("Uid05367_CH03_Standard_NickOfTime_Stop")
        OneShotSound.Play("HUD_Play_Waypoint")
        engineCutscene.playCutscene("mis_ch3_nickoftime_01", function()
          if taskObject.coreData.agent.gameVehicle.isBeingTowed then
            GameVehicleResource.detachVehicle(taskObject.coreData.agent.gameVehicle)
          end
          challengeSystem.spawnActors(task.instance, "Never", {
            ["Cop chaser 1"] = true,
            ["Player"] = true
          })
          if not localPlayer.inZap then
            localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
          end
          localPlayer:SetZapLevel(0, task.instance.taskObjectsByActorID["Cop chaser 1"].coreData.agent, true)
          localPlayer:blockAbility("zapReturn", false)
          localPlayer:blockAbility("zap", false)
          localPlayer.missionSupport:setMainTaskObject(task.instance.taskObjectsByActorID.Player)
        end, function()
          challengeSystem.spawnActors(task.instance, "Never", {
            ["Bomb goon"] = true,
            ["Cop chaser 2"] = true
          })
          GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID["Cop chaser 1"].coreData.agent.position, 100)
          GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID["Bomb goon"].coreData.agent.position, 100)
          task.instance.taskObjectsByActorID["Bomb goon"].coreData.agent.gameVehicle.speed = spawnSpeed
          task.instance.taskObjectsByActorID["Cop chaser 1"].coreData.agent.gameVehicle.speed = spawnSpeed
          task.instance.taskObjectsByActorID["Cop chaser 2"].coreData.agent.gameVehicle.speed = spawnSpeed
          local evaderGameVehicle = task.instance.taskObjectsByActorID["Bomb goon"].coreData.agent.gameVehicle
          local chaserGameVehicle = task.instance.taskObjectsByActorID["Cop chaser 1"].coreData.agent.gameVehicle
          felony_chase.startChase(evaderGameVehicle, chaserGameVehicle)
          felony_chase.addChaser(evaderGameVehicle, task.instance.taskObjectsByActorID["Cop chaser 2"].coreData.agent.gameVehicle)
          feedbackSystem.menusMaster.setCurrentFocusString(3)
          feedbackSystem.menusMaster.primaryTextPrompt("ID:184843", false, true)
          localPlayer:resetCameraMode()
        end, nil, nil, nil)
      elseif task.success and task.specialName == "Ram reminder" and ramPromptActive then
        feedbackSystem.menusMaster.clearSecondaryTextPrompt()
        ramPromptActive = false
      end
    else
      params.vehicle = task.instance.taskObjectsByActorID["Disposal van"].coreData.agent
      if task.specialName == "closeToCops" then
        params.failReason = "ID:184855"
        params.dialogue = "GPMV00_FAILURE_L_2"
      elseif task.specialName == "getToTheBomb" or task.specialName == "getToTheBomb2" then
        if task.condition == 3 then
          params.reason = "Wrecked"
          params.failReason = "ID:182731"
          if localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Disposal van"].coreData.agent then
            params.dialogue = "GPMV01_FAILURE_L_2"
          else
            params.dialogue = "GPMV00_FAILURE_L_1"
          end
        elseif task.condition == 2 then
          if localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Disposal van"].coreData.agent then
            params.dialogue = "GPMV01_FAILURE_L_1"
          else
            params.dialogue = "GPMV00_FAILURE_L_1"
          end
        end
      end
      params.hint = "ID:235497"
      params.rating = "FAIL"
      params.callback = failTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif taskObject.coreData.actor.team == "Cop team" then
    if task.specialName == "copEscort" then
      if task.success then
        taskObject.coreData.agent:lockEmergencyBrakes(3)
      elseif task.condition == 2 then
        local teamMembers = 0
        for ID, vehicle in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
          if vehicle.coreData.actor.team == "Cop team" and 1 > vehicle.coreData.agent.damage then
            teamMembers = teamMembers + 1
          end
        end
        params.vehicle = task.instance.taskObjectsByActorID["Disposal van"].coreData.agent
        if teamMembers == 0 then
          params.dialogue = "GPMV00_FAILURE_L_2"
          feedbackSystem.stopMusic("Uid05367_CH03_Standard_NickOfTime_Stop")
          params.failReason = "ID:220680"
          params.rating = "FAIL"
          params.callback = failTask
          params.hint = "ID:235497"
          localPlayer.challenge.endScreen(taskObject, params)
        else
          feedbackSystem.menusMaster.primaryTextPrompt("ID:184848", false, false, false)
        end
      end
    end
  elseif task.specialName == "Chaser logic" then
    if task.success then
      params.vehicle = felony_chase.endScreenVehicle
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243498")
      if task.instance.playerPreviousVehicle == 1 then
        params.dialogue = "GPMV00_SUCCESS_L_2"
      else
        params.dialogue = "GPMV00_SUCCESS_L_1"
      end
      feedbackSystem.stopMusic("Uid05367_CH03_Standard_NickOfTime_Stop")
      params.rating = "PASS"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    else
      params.vehicle = felony_chase.endScreenVehicle
      if task.condition == 1 then
        if task.instance.playerPreviousVehicle == 1 then
          params.dialogue = "GPMV00_FAILURE_L_5"
        elseif task.instance.playerPreviousVehicle == 2 then
          params.dialogue = "GPMV00_FAILURE_L_4"
        end
        params.reason = "Wrecked"
        params.failReason = "ID:221975"
        params.rating = "FAIL"
        params.hint = "ID:235488"
        params.callback = failTask
        localPlayer.challenge.endScreen(taskObject, params)
      else
        params.reason = "Lost getaway"
        params.dialogue = "GPMV00_FAILURE_L_2"
        params.failReason = "ID:184856"
        params.rating = "FAIL"
        params.callback = failTask
        if isAbilityUnlocked("ram") then
          params.hint = "ID:235488"
        else
          params.hint = "ID:236772"
        end
        localPlayer.challenge.endScreen(taskObject, params)
      end
    end
  end
end
missionEndCallback["In the nick of time"] = function(instance)
  localPlayer:blockAbility("zapReturn", false)
  localPlayer:blockAbility("zap", false)
end
