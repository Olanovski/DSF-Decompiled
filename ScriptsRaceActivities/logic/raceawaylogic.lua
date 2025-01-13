module("cardSystem.logic")
missionSetupData["Race away challenge"] = {}
local opponentFinished = false
local opponentsWrecked = false
local wreckedPromptDisplayed = false
local ambushed = false
local copTargetLookup = {
  ["Fake cop 1"] = "racer1",
  ["Fake cop 2"] = "racer2",
  ["Fake cop 3"] = "racer3",
  ["Fake cop 4"] = "racer1",
  ["Fake cop 5"] = "racer2",
  ["Fake cop 6"] = "racer3"
}
local racerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Linear Checkpoints",
        specialName = "race",
        dynamicTargets = true,
        coreData = {
          totalLaps = goalParams["Total laps"] or 0
        },
        groupProgression = {importantMinorOrder = true},
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
            {
              goal = "All opposing vehicles damage above",
              params = {value = 1}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Specified actors have finished race",
              params = {
                actors = {
                  "racer1",
                  "racer2",
                  "racer3"
                },
                value = 2
              }
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {goal = "Got busted"}
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Checkpoint Gate"] = {}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Race away challenges hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Spawn ambushers",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
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
              goal = "Empty dynamicTargets"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Ambush",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
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
              goal = "Empty dynamicTargets"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Timer toggle",
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Being busted"
            }
          },
          {
            {
              goal = "Being busted",
              params = {inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Race away challenges hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Lose cops focus text",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
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
            style = "Race away challenges hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Start prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "wander",
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Being chased",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            failCondition = true,
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
            style = "Race away challenges hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No functionality",
        specialName = "messageDelay",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Lose cops focus text 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
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
        }
      }
    }
  }
  if goalParams["Ambush radius"] then
    task[1][3].goalConditions[1][1].params.value = goalParams["Ambush radius"]
  end
  return task
end
local racer2Task = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Linear Checkpoints",
        specialName = "AI race",
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
              params = {coreValue = "totalLaps", setRaceFinished = true}
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
  return task
end
local chaserTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "Stop Vehicle",
        specialName = "Wait for ambush"
      }
    }
  }
  return task
end
local fakeCopTask = function(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Linear Chase",
        specialName = "Fake chase",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Target damage above",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Is a felony active",
              params = {inverse = true}
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
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Race away challenges hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Join felony",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "player Actor"
              }
            },
            {
              goal = "Simple collision check",
              params = {
                whereIWasHit = "Side",
                force = 6000,
                playerMustHitTarget = true
              }
            }
          },
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "player Actor"
              }
            },
            {
              goal = "Simple collision check",
              params = {
                whereIWasHit = "Behind",
                force = 12000,
                playerMustHitTarget = true
              }
            }
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Remove fake cop",
        taskConditions = {
          {
            forceTaskComplete = true,
            {
              goal = "Within radius of player",
              params = {value = 200, inverse = true}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Join felony 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Is a felony active"
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
            {
              goal = "Player in agent",
              params = {
                agentName = "player Actor"
              }
            },
            {
              goal = "Simple collision check",
              params = {
                whereIWasHit = "Side",
                force = 6000,
                playerMustHitTarget = true
              }
            }
          },
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "player Actor"
              }
            },
            {
              goal = "Simple collision check",
              params = {
                whereIWasHit = "Behind",
                force = 12000,
                playerMustHitTarget = true
              }
            }
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Race away challenge"].taskCreatorFunctionLookups = {
  ["Race team"] = racerTask,
  ["Race team 2"] = racer2Task,
  ["Chase team"] = chaserTask,
  ["Fake cop team"] = fakeCopTask
}
missionSetupData["Race away challenge"].initiate = function(instance)
  createCheckpoints(instance)
  createFixedPosition(instance, {
    instance.challenge.actorPool.Cop1.spawn.position
  }, 99)
  if instance.challenge.actorPool.Cop2 then
    createFixedPosition(instance, {
      instance.challenge.actorPool.Cop2.spawn.position
    }, 99)
  end
  opponentFinished = false
  opponentsWrecked = false
  wreckedPromptDisplayed = false
  ambushed = false
end
missionSetupData["Race away challenge"].update = nil
local getRaceTeamDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if dynamicListID then
    if task.specialName == "Spawn ambushers" then
      if #task.dynamicTargets == 1 then
        return false, true
      else
        return false, false
      end
    elseif task.specialName == "Ambush" then
      if #task.dynamicTargets == 1 then
        return false, true
      else
        return false, false
      end
    elseif task.networkVars.checkpoints < #allCheckpoints then
      return {
        allCheckpoints[task.networkVars.checkpoints + 1]
      }, false
    else
      return {
        allCheckpoints[1]
      }, true
    end
  elseif task.specialName == "Spawn ambushers" or task.specialName == "Ambush" then
    return checkpointSystem.getCheckpoints(task.instance, 99), false
  else
    return {
      allCheckpoints[task.networkVars.checkpoints]
    }, false
  end
end
local getRaceTeam2DynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if dynamicListID then
    if task.networkVars.checkpoints < #allCheckpoints then
      return {
        allCheckpoints[task.networkVars.checkpoints + 1]
      }, false
    else
      taskObject.coreData.agent.iconsVisible = false
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
local function getFakeCopDynamicTargets(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  elseif task.instance.taskObjectsByActorID[copTargetLookup[task.actor.ID]] then
    return {
      task.instance.taskObjectsByActorID[copTargetLookup[task.actor.ID]].coreData.agent
    }, false
  else
    return false, true
  end
end
missionSetupData["Race away challenge"].targetList = {
  ["Race team"] = getRaceTeamDynamicTargets,
  ["Race team 2"] = getRaceTeam2DynamicTargets,
  ["Fake cop team"] = getFakeCopDynamicTargets
}
missionSetupData["Race away challenge"].goalComplete = function(taskObject, task, conditionKey)
  if task.specialName == "Spawn ambushers" then
    if not ambushed then
      challengeSystem.spawnActors(task.instance, "Never", {Cop1 = true})
    else
      challengeSystem.spawnActors(task.instance, "Never", {Cop2 = true})
    end
    if not task.agent.controlled then
      localPlayer:zapToAgent(task.agent, {disableZapFlash = true})
    end
    localPlayer:blockAbility("zap", true)
  elseif task.specialName == "Ambush" and conditionKey == 1 then
    local copName = "Cop1"
    local fakeCops = {
      "Fake cop 1",
      "Fake cop 2",
      "Rolling cop"
    }
    if ambushed then
      copName = "Cop2"
      fakeCops = {
        "Fake cop 4",
        "Fake cop 5",
        "Rolling cop 2"
      }
    end
    localPlayer.cameraSupport.zoomLookToAgent({
      agent = task.instance.taskObjectsByActorID[copName].coreData.agent
    })
    feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:184902", priority = 1})
    if task.instance.taskObjectsByActorID.racer1 then
      challengeSystem.spawnActors(task.instance, "Never", {
        [fakeCops[1]] = true
      })
    end
    if task.instance.taskObjectsByActorID.racer2 then
      challengeSystem.spawnActors(task.instance, "Never", {
        [fakeCops[2]] = true
      })
    end
    challengeSystem.spawnActors(task.instance, "Never", {
      [fakeCops[3]] = true
    })
    if not Getaway.IsBeingChased(task.agent.gameVehicle) then
      felony_getaway.addEvader(task.agent.gameVehicle)
    end
    for actorID, chaserTaskObject in next, task.instance.taskObjectsByActorID, nil do
      if chaserTaskObject.coreData.actor.team == "Chase team" then
        felony_getaway.addChaser(task.agent.gameVehicle, chaserTaskObject.coreData.agent.gameVehicle)
      end
    end
    OneShotSound.Play("HUD_Fel_Gained")
    localPlayer:blockAbility("zap", false)
    ambushed = true
  end
end
taskCompleteData["Race away challenge"] = {}
taskCompleteData["Race away challenge"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID["player Actor"].coreData.agent,
    cameraShots = cameraShots[2],
    successReason = "ID:247177",
    failReason = "ID:182607",
    hint = "ID:235494"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix, perfect)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.success then
    if task.specialName == "Start prompt" then
      feedbackSystem.menusMaster.primaryTextPromptParam({
        prompt = "ID:184013",
        delay = true,
        priority = 1
      })
    elseif task.specialName == "race" then
      if not opponentFinished then
        if task.condition == 2 then
          feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:232271", priority = 1})
          opponentsWrecked = true
        else
          feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:183987", priority = 1})
        end
      else
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:184897", priority = 1})
      end
      task.instance.taskObjectsByActorID["player Actor"].coreData.actor.ranking = taskObject.coreData.rank
      local icamParams = {
        cameraTargets = {
          task.instance.taskObjectsByActorID["player Actor"].coreData.agent.gameVehicle
        },
        duration = 3,
        speed = 0.2,
        framing = "wide",
        angleYaw = "front quarter",
        hudParams = {prompts = true}
      }
      iCamActivationTableInput(icamParams)
      RouteArrowsManager.ClearArrows()
      RaceManager.EnableWrongWay(task.instance.raceId, false)
      RaceManager.EnableOffRoute(task.instance.raceId, false)
      feedbackSystem.removeSlot(1)
      feedbackSystem.menusMaster.setCurrentFocusString(2)
      for actorID, tO in next, task.instance.taskObjectsByActorID, nil do
        if actorID ~= "player Actor" then
          task.instance.taskObjectsByActorID[actorID]:delete()
        end
      end
    elseif task.specialName == "messageDelay" then
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:184901", priority = 1})
    elseif task.specialName == "wander" then
      if opponentFinished then
        params.successReason = "ID:247178"
      elseif opponentsWrecked then
        params.successReason = "ID:232271"
      end
      params.rating = "PASS"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "AI race" then
      if not opponentFinished then
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:184952", priority = 1})
        opponentFinished = true
      end
    elseif task.specialName == "Join felony" or task.specialName == "Join felony 2" then
      if not Getaway.IsAGetawayActive() then
        felony_getaway.addEvader(task.instance.taskObjectsByActorID["player Actor"].coreData.agent.gameVehicle)
      end
      felony_getaway.addChaser(task.instance.taskObjectsByActorID["player Actor"].coreData.agent.gameVehicle, task.agent.gameVehicle)
    end
  elseif task.specialName == "race" then
    if task.condition == 3 then
      params.failReason = "ID:173965"
    elseif task.condition == 5 then
      params.failReason = "ID:231166"
    end
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "wander" then
    if task.condition == 1 then
      params.failReason = "ID:184950"
    elseif task.condition == 3 then
      params.failReason = "ID:231166"
    end
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "AI race" and not wreckedPromptDisplayed then
    feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:183974", priority = 1})
    wreckedPromptDisplayed = true
  end
end
missionEndCallback["Race away challenge"] = function(instance)
  localPlayer:blockAbility("zap", false)
end
