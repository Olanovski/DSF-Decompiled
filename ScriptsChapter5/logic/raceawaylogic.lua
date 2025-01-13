module("cardSystem.logic")
missionSetupData["Race away"] = {}
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
        groupProgression = {importantMinorOrder = true, mustBeSuccessful = false},
        goalConditions = {
          {
            {
              goal = "Reached next checkpoint"
            }
          },
          {
            triggerCount = 1,
            {
              goal = "All opposing vehicles damage above",
              params = {value = 1}
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Racer damage for chaser win"]
              }
            }
          },
          {
            forceTaskComplete = true,
            {
              goal = "Completed lap",
              params = {coreValue = "totalLaps"}
            },
            {
              goal = "Being chased",
              params = {inverse = true}
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
            {
              goal = "Completed lap",
              params = {coreValue = "totalLaps"}
            },
            {
              goal = "Number of team members remaining",
              params = {
                value = 0,
                team = "Race team 2",
                inverse = true
              }
            },
            {
              goal = "Being chased"
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {goal = "Got busted"}
          },
          {
            forceTaskComplete = true,
            {
              goal = "All team members damage above",
              params = {
                team = "Race team 2",
                value = 1
              }
            },
            {
              goal = "Being chased",
              params = {inverse = true}
            }
          },
          {
            {
              goal = "All team members damage above",
              params = {
                team = "Race team 2",
                value = 1
              }
            },
            {
              goal = "Being chased"
            }
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
            style = "Race away hud",
            settings = {Part = 1}
          }
        },
        audioPIP = audio
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
        specialName = "Ambush",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"cop2"}
              }
            },
            {
              goal = "Within radius",
              params = {value = 25}
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
        specialName = "spotted",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Being chased"
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "in player car",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Is player controlled"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "zap",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "zapped into racer1",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in agent",
              params = {agentName = "racer1"}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "zapped into racer2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in agent",
              params = {agentName = "racer2"}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "zapped into racer3",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Player in agent",
              params = {agentName = "racer3"}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "zapped out of enemy racer",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player just zapped out of specified actors",
              params = {
                actors = {
                  "racer1",
                  "racer2",
                  "racer3"
                }
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "lost cops",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Has been chased"
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
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
            style = "Race away hud"
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
            style = "Race away hud"
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
              params = {
                value = goalParams["Racer damage for chaser win"]
              }
            }
          },
          {
            {
              goal = "Damage below",
              params = {value = 1}
            },
            {
              goal = "Is a felony active",
              params = {inverse = true}
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
            style = "Race away hud",
            settings = {Part = 2}
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
        },
        HUD = {
          {
            style = "Race away hud"
          }
        }
      }
    }
  }
  return task
end
local racer2Task = function(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
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
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Trigger ram cops audio",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Simple collision check",
              params = {copsOnly = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Trigger ram racer audio",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Simple collision check",
              params = {hitActor = "racer1"}
            }
          },
          {
            {
              goal = "Simple collision check",
              params = {hitActor = "racer2"}
            }
          },
          {
            {
              goal = "Simple collision check",
              params = {hitActor = "racer3"}
            }
          }
        },
        audioPIP = audio
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
missionSetupData["Race away"].taskCreatorFunctionLookups = {
  ["Race team"] = racerTask,
  ["Race team 2"] = racer2Task,
  ["Chase team"] = chaserTask
}
local racerFinished = false
local racersWrecked = false
local ambushPosition = vec.vector(-388.62, 95.79, -4600.157, 1)
local ambusherSpawnPosition = vec.vector(-167.582, 87.545, -4567.306, 1)
local losingWarningShown = false
missionSetupData["Race away"].initiate = function(instance)
  createCheckpoints(instance)
  createFixedPosition(instance, {ambushPosition}, 99)
  createFixedPosition(instance, {ambusherSpawnPosition}, 98)
  racerFinished = false
  racersWrecked = false
  losingWarningShown = false
  propSystem.setupRuntimeProps("RaceAway", false, false)
  feedbackSystem.startFreeDriveMusic(cards.Missions[instance.challenge.name].MissionID)
  feedbackSystem.menusMaster.primaryTextPrompt("ID:184014", nil, true)
  instance.taskObjectsByActorID.racer1.coreData.agent.gameVehicle.performance = 1.25
  instance.taskObjectsByActorID.racer2.coreData.agent.gameVehicle.performance = 1.25
  instance.taskObjectsByActorID.racer3.coreData.agent.gameVehicle.performance = 1.25
end
missionSetupData["Race away"].update = nil
local function getRaceTeamDynamicTargets(taskObject, task, dynamicListID, goalConditionKey)
  if task.majorOrder == 1 then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
      if task.specialName == "Spawn ambushers" or task.specialName == "Ambush" then
        return nil, true
      elseif task.networkVars.checkpoints < #allCheckpoints then
        if #allCheckpoints - task.networkVars.checkpoints == 3 and not losingWarningShown and not task.instance.taskObjectsByActorID["player Actor"].coreData.agent.controlled then
          losingWarningShown = true
          feedbackSystem.menusMaster.primaryTextPrompt("ID:245684")
        end
        return {
          allCheckpoints[task.networkVars.checkpoints + 1]
        }, false
      else
        return {
          allCheckpoints[1]
        }, true
      end
    elseif task.specialName == "Spawn ambushers" then
      return checkpointSystem.getCheckpoints(task.instance, 98), false
    elseif task.specialName == "Ambush" then
      return checkpointSystem.getCheckpoints(task.instance, 99), false
    else
      return {
        allCheckpoints[task.networkVars.checkpoints]
      }, false
    end
  end
end
local function getRaceTeam2DynamicTargets(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if dynamicListID then
    if task.networkVars.checkpoints < #allCheckpoints then
      if #allCheckpoints - task.networkVars.checkpoints == 3 and not losingWarningShown and not task.instance.taskObjectsByActorID["player Actor"].coreData.agent.controlled then
        losingWarningShown = true
        if task.instance.taskObjectsByActorID["player Actor"].coreData.rank ~= 2 then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:245685")
        end
      end
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
missionSetupData["Race away"].targetList = {
  ["Race team"] = getRaceTeamDynamicTargets,
  ["Race team 2"] = getRaceTeam2DynamicTargets
}
taskCompleteData["Race away"] = {}
taskCompleteData["Race away"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID["player Actor"].coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    successReasonPerfect = task.instance.challenge.taskCompleteData["Success reason (perfect)"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235494"
  }
  local vehicle = taskObject.coreData.agent
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if taskObject.coreData.actor.team ~= "Chase team" then
    if taskObject.playerTask then
      if task.success then
        if task.specialName == "lost cops" then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:184014")
        elseif task.specialName == "race" then
          feedbackSystem.menusMaster.clearPrimaryTextPrompt()
          if task.condition == 2 then
            feedbackSystem.stopFreeDriveMusic()
            if taskObject.coreData.rank == 1 then
              params.successReason = params.successReasonPerfect
              params.dialogue = "GPMV01_SUCCESS_L_1"
            elseif taskObject.coreData.rank == 2 then
              params.dialogue = "GPMV01_SUCCESS_L_2"
            end
            params.rating = "PASS"
            params.callback = completeTask
            localPlayer.challenge.endScreen(taskObject, params)
          elseif task.condition == 6 then
            feedbackSystem.stopFreeDriveMusic()
            params.rating = "PASS"
            params.successReason = "ID:232271"
            params.callback = completeTask
            localPlayer.challenge.endScreen(taskObject, params)
          elseif task.condition == 4 then
            if taskObject.coreData.rank == 1 then
              feedbackSystem.menusMaster.primaryTextPromptParam({
                prompt = "ID:184899",
                endCallback = function()
                  feedbackSystem.menusMaster.primaryTextPrompt("ID:231403")
                end
              })
            elseif taskObject.coreData.rank == 2 then
              feedbackSystem.menusMaster.primaryTextPromptParam({
                prompt = "ID:184900",
                endCallback = function()
                  feedbackSystem.menusMaster.primaryTextPrompt("ID:231403")
                end
              })
            end
            task.instance.taskObjectsByActorID["player Actor"].coreData.actor.ranking = taskObject.coreData.rank
            local icamParams = {
              cameraTargets = {
                task.instance.taskObjectsByActorID["player Actor"].coreData.agent.gameVehicle,
                localPlayer.currentVehicle.gameVehicle
              },
              duration = 3,
              speed = 0.2,
              framing = "wide",
              angleYaw = "front quarter"
            }
            iCamActivationTableInput(icamParams)
            RouteArrowsManager.ClearArrows()
            RaceManager.EnableWrongWay(task.instance.raceId, false)
            RaceManager.EnableOffRoute(task.instance.raceId, false)
            feedbackSystem.menusMaster.setCurrentFocusString(2)
            if task.instance.taskObjectsByActorID.racer1 then
              task.instance.taskObjectsByActorID.racer1:delete()
            end
            if task.instance.taskObjectsByActorID.racer2 then
              task.instance.taskObjectsByActorID.racer2:delete()
            end
            if task.instance.taskObjectsByActorID.racer3 then
              task.instance.taskObjectsByActorID.racer3:delete()
            end
          elseif task.condition == 7 then
            racersWrecked = true
            RouteArrowsManager.ClearArrows()
            RaceManager.EnableWrongWay(task.instance.raceId, false)
            RaceManager.EnableOffRoute(task.instance.raceId, false)
            feedbackSystem.menusMaster.setCurrentFocusString(2)
          end
        elseif task.majorOrder == 2 and task.specialName == "messageDelay" then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:184901")
        elseif task.majorOrder == 2 and task.specialName == "wander" then
          feedbackSystem.stopFreeDriveMusic()
          if racersWrecked then
            params.successReason = "ID:248757"
          elseif taskObject.coreData.rank == 1 then
            params.successReason = params.successReasonPerfect
            params.dialogue = "GPMV01_SUCCESS_L_1"
          elseif taskObject.coreData.rank == 2 then
            params.dialogue = "GPMV01_SUCCESS_L_2"
          end
          params.rating = "PASS"
          params.callback = completeTask
          localPlayer.challenge.endScreen(taskObject, params)
        elseif task.specialName == "Spawn ambushers" then
          challengeSystem.spawnActors(task.instance, "Never", {cop1 = true, cop2 = true})
        elseif task.specialName == "Ambush" then
          felony_patrollingVehicleManager.enablePatrollingVehicles(true)
          if localPlayer.inZap or localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle ~= taskObject.coreData.agent.gameVehicle then
            localPlayer:zapToAgent(task.instance.taskObjectsByActorID["player Actor"].coreData.agent)
          end
          if not localPlayer.zapTransition then
            iCamFlyToCam(task.instance.taskObjectsByActorID.cop1.coreData.agent.gameVehicle)
            local evaderGameVehicle = task.instance.taskObjectsByActorID["player Actor"].coreData.agent.gameVehicle
            felony_getaway.addEvader(evaderGameVehicle)
            felony_getaway.addChaser(evaderGameVehicle, task.instance.taskObjectsByActorID.cop1.coreData.agent.gameVehicle)
            felony_getaway.addChaser(evaderGameVehicle, task.instance.taskObjectsByActorID.cop2.coreData.agent.gameVehicle)
            OneShotSound.Play("HUD_Fel_Gained")
            feedbackSystem.menusMaster.primaryTextPrompt("ID:184902")
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_1", nil, "missionCritical")
          else
            local function doiCam()
              if not localPlayer.zapTransition then
                iCamFlyToCam(task.instance.taskObjectsByActorID.cop1.coreData.agent.gameVehicle)
                local evaderGameVehicle = task.instance.taskObjectsByActorID["player Actor"].coreData.agent.gameVehicle
                felony_getaway.addEvader(evaderGameVehicle)
                felony_getaway.addChaser(evaderGameVehicle, task.instance.taskObjectsByActorID.cop1.coreData.agent.gameVehicle)
                felony_getaway.addChaser(evaderGameVehicle, task.instance.taskObjectsByActorID.cop2.coreData.agent.gameVehicle)
                OneShotSound.Play("HUD_Fel_Gained")
                feedbackSystem.menusMaster.primaryTextPrompt("ID:184902")
                feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_1", nil, "missionCritical")
                removeUserUpdateFunction("doiCam")
              end
            end
            addUserUpdateFunction("doiCam", doiCam, 1)
          end
          feedbackSystem.menusMaster.setCurrentFocusString(3)
        end
      else
        feedbackSystem.stopFreeDriveMusic()
        if task.specialName == "race" then
          if task.condition == 1 then
            params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
            params.reason = "Wrecked"
            params.dialogue = "GPMV01_FAILURE_L_1"
          elseif task.condition == 5 then
            params.failReason = "ID:186285"
            params.reason = "Busted"
            params.dialogue = "GPMV01_FAILURE_L_1"
            params.hint = "ID:235490"
          elseif task.condition == 3 then
            params.failReason = "ID:184894"
            params.reason = "Lost race"
            params.dialogue = "GPMV01_FAILURE_L_2"
          end
        elseif task.specialName == "wander" then
          if task.condition == 1 then
            params.failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"]
            params.reason = "Wrecked"
            params.dialogue = "GPMV01_FAILURE_L_1"
          elseif task.condition == 3 then
            params.failReason = "ID:186285"
            params.reason = "Busted"
            params.dialogue = "GPMV01_FAILURE_L_1"
          end
        end
        params.callback = failTask
        params.rating = "FAIL"
        localPlayer.challenge.endScreen(taskObject, params)
      end
    elseif task.specialName == "AI race" then
      if task.success then
        RaceManager.RacerCrossedFinishLine(task.agent.raceId, taskObject.coreData.agent.gameVehicle)
        if not racerFinished then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:184952")
          racerFinished = true
        end
      else
        feedbackSystem.menusMaster.primaryTextPrompt("ID:183974")
        iCamCrashCam(taskObject.coreData.agent.gameVehicle)
      end
    end
  end
end
missionEndCallback["Race away"] = function(instance)
  feedbackSystem.stopFreeDriveMusic()
end
