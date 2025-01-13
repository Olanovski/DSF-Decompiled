module("cardSystem.logic")
missionSetupData["Generic checkpoint race"] = {}
local racerTask = function(goalParams, HUD, audio)
  local task = {
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
            {
              goal = "Damage above",
              params = {value = 1}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
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
            manager = "Target list",
            settings = {
              styles = {
                ["Checkpoint Gate"] = {blockCheckpointAudio = true}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Generic race hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "First prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "zapped into racer",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Player zap status has changed",
              params = {transition = "out"}
            },
            {
              goal = "Player in agent",
              params = {
                agentName = "Race team 1 member 1"
              }
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
        specialName = "zapped into team colors racer",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            triggerCount = 1,
            {
              goal = "Player in agent",
              params = {
                agentName = "Player team member 02"
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "zapped out of racer",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player just zapped out of specified actors",
              params = {
                actors = {
                  "Race team 1 member 1",
                  "Player team member 01",
                  "Player team member 02"
                }
              }
            },
            {
              goal = "Player using zap return",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "start of race",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 5}
            },
            {
              goal = "Player in a specified agent",
              params = {
                actorIDs = {
                  "Race team 1 member 1"
                }
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Team Colours - timer",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Is player controlled"
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
        }
      }
    },
    {
      {
        task = "Follow Route"
      }
    }
  }
  if goalParams["Time limit"] then
    task[1][1].taskConditions[#task[1][1].taskConditions + 1] = {
      failCondition = true,
      {
        goal = "Instance time above",
        params = {
          value = goalParams["Time limit"]
        }
      }
    }
  end
  if goalParams["Any team member damage above"] then
    task[1][1].taskConditions[#task[1][1].taskConditions + 1] = {
      failCondition = true,
      {
        goal = "Any team member damage above",
        params = {
          value = goalParams["Any team member damage above"]
        }
      }
    }
  end
  if goalParams["Destroy opposing teams"] then
    task[1][1].taskConditions[#task[1][1].taskConditions + 1] = {
      {
        goal = "All opposing vehicles damage above",
        params = {value = 1}
      }
    }
  end
  if goalParams["Team race prompt"] then
    task[1][#task[1] + 1] = {
      task = "No AI",
      specialName = "rapid shift",
      groupProgression = {importantMinorOrder = false},
      goalConditions = {
        {
          {
            goal = "Time trigger",
            params = {value = 2}
          },
          {
            goal = "Button Press",
            params = {watchFor = "Pressed", button = "Zap_Return"}
          }
        }
      },
      audioPIP = audio
    }
  end
  if goalParams["Team race prompt"] then
    task[1][#task[1] + 1] = {
      task = "No AI",
      specialName = "team colours prompt rules",
      groupProgression = {importantMinorOrder = false},
      goalConditions = {
        {
          autoRefresh = true,
          {
            goal = "Prompt active",
            params = {promptType = "Primary", inverse = true}
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
            goal = "Is player controlled"
          },
          {
            goal = "Team member above race position",
            params = {value = 2, controlled = true}
          },
          {
            goal = "Team member above race position",
            params = {value = 3, inverse = true}
          }
        }
      },
      taskConditions = {
        {
          {
            goal = "Total zap returns above",
            params = {value = 30}
          }
        }
      },
      HUD = {
        {
          style = "Generic race hud"
        }
      }
    }
  end
  return task
end
local AIRacerTask = function(goalParams)
  local task = {
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
      }
    }
  }
  return task
end
missionSetupData["Generic checkpoint race"].taskCreatorFunctionLookups = {
  ["Race team 1"] = racerTask,
  ["Race team 2"] = AIRacerTask,
  ["Race team 3"] = AIRacerTask,
  ["Race team 4"] = AIRacerTask,
  ["Race team 5"] = AIRacerTask,
  ["Race team 6"] = AIRacerTask,
  ["Race team 7"] = AIRacerTask,
  ["Race team 8"] = AIRacerTask
}
local racesWithMusic = {
  ["1 Downtown race"] = true,
  ["Easy Street"] = true,
  ["Team colours 01"] = true,
  ["Speed Race"] = true,
  ["High plains drifter"] = true,
  ["Marin County race"] = true
}
missionSetupData["Generic checkpoint race"].initiate = function(instance)
  createCheckpoints(instance)
  if instance.challenge.name == "Speed Race" then
    propSystem.setupRuntimeProps("Baja race props", false, false)
  end
  if instance.challenge.name == "Team colours 01" then
    instance.timedPromptShown = false
    if instance.taskObjectsByActorID["Race team 2 member 1"] then
      instance.taskObjectsByActorID["Race team 2 member 1"].coreData.actor.desiredSpeed = 160
      instance.taskObjectsByActorID["Race team 2 member 1"].coreData.actor.distanceBehindPlayer = -20
    end
    if instance.taskObjectsByActorID["Race team 2 member 2"] then
      instance.taskObjectsByActorID["Race team 2 member 2"].coreData.actor.desiredSpeed = 160
      instance.taskObjectsByActorID["Race team 2 member 2"].coreData.actor.distanceBehindPlayer = -15
    end
  end
  if racesWithMusic[instance.challenge.name] then
    feedbackSystem.startFreeDriveMusic(cards.Missions[instance.challenge.name].MissionID)
  end
  feedbackSystem.menusMaster.setCurrentFocusString(1)
  if instance.challenge.name == "Marin County race" then
    local playerOnlyTakedownData = {enabled = true, maxNonPlayerDamage = 0}
    for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
      if not taskObject.playerTask then
        playerOnlyTakedownData.gameVehicle = taskObject.coreData.agent.gameVehicle
        GameVehicleResource.playerOnlyTakedown(playerOnlyTakedownData)
      end
    end
  end
end
missionSetupData["Generic checkpoint race"].update = nil
local RaceTeamDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Checkpoints" then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
      if taskObject == localPlayer:getTaskObject() and task.agent.controlled then
        OneShotSound.Play("HUD_Play_Checkpoint")
      elseif taskObject == localPlayer:getTaskObject() and not task.agent.controlled then
        OneShotSound.Play("HUD_Play_Checkpoint_Team")
      end
      if task.networkVars.checkpoints < #allCheckpoints then
        if task.instance.challenge.name == "Team colours 01" then
          if task.networkVars.checkpoints == 15 then
            if task.instance.taskObjectsByActorID["Race team 2 member 1"] then
              task.instance.taskObjectsByActorID["Race team 2 member 1"].coreData.actor.desiredSpeed = 125
              task.instance.taskObjectsByActorID["Race team 2 member 1"].coreData.actor.distanceBehindPlayer = -5
            end
            if task.instance.taskObjectsByActorID["Race team 2 member 2"] then
              task.instance.taskObjectsByActorID["Race team 2 member 2"].coreData.actor.desiredSpeed = 125
              task.instance.taskObjectsByActorID["Race team 2 member 2"].coreData.actor.distanceBehindPlayer = -5
            end
          elseif task.networkVars.checkpoints == 17 then
            if task.instance.taskObjectsByActorID["Race team 2 member 1"] then
              task.instance.taskObjectsByActorID["Race team 2 member 1"].coreData.actor.desiredSpeed = 115
              task.instance.taskObjectsByActorID["Race team 2 member 1"].coreData.actor.distanceBehindPlayer = -5
            end
            if task.instance.taskObjectsByActorID["Race team 2 member 2"] then
              task.instance.taskObjectsByActorID["Race team 2 member 2"].coreData.actor.desiredSpeed = 115
              task.instance.taskObjectsByActorID["Race team 2 member 2"].coreData.actor.distanceBehindPlayer = -5
            end
          end
        end
        return {
          allCheckpoints[task.networkVars.checkpoints + 1]
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
    else
      return {
        allCheckpoints[task.networkVars.checkpoints]
      }, false
    end
  end
end
local AITeamDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Checkpoints" then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
      if task.networkVars.checkpoints < #allCheckpoints then
        return {
          allCheckpoints[task.networkVars.checkpoints + 1]
        }, false
      elseif task.instance.challenge.goalValues["Total laps"] then
        if task.networkVars.laps == task.instance.challenge.goalValues["Total laps"] then
          return false, true
        else
          return {
            allCheckpoints[1]
          }, true
        end
      else
        return false, true
      end
    else
      return {
        allCheckpoints[task.networkVars.checkpoints]
      }, false
    end
  end
end
missionSetupData["Generic checkpoint race"].targetList = {
  ["Race team 1"] = RaceTeamDynamicTargets,
  ["Race team 2"] = AITeamDynamicTargets,
  ["Race team 3"] = AITeamDynamicTargets,
  ["Race team 4"] = AITeamDynamicTargets,
  ["Race team 5"] = AITeamDynamicTargets,
  ["Race team 6"] = AITeamDynamicTargets,
  ["Race team 7"] = AITeamDynamicTargets,
  ["Race team 8"] = AITeamDynamicTargets
}
missionEndCallback["Generic checkpoint race"] = function(instance)
  if instance.challenge.name == "Team colours 01" then
    removeUserUpdateFunction("tryPositionAudio")
    removeUserUpdateFunction("stillInZap")
    instance.playedPIPOnce = false
  end
  if racesWithMusic[instance.challenge.name] then
    feedbackSystem.stopFreeDriveMusic()
  end
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.agent.raceId then
      RouteArrowsManager.ClearArrows()
      RaceManager.RemoveRace(taskObject.coreData.agent.raceId)
      taskObject.coreData.agent.raceId = nil
      taskObject.coreData.instance.raceId = nil
      break
    end
  end
end
missionSetupData["Generic checkpoint race"].goalComplete = function(taskObject, task, conditionKey)
  if task.specialName == "rapid shift" then
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    feedbackSystem.menusMaster.clearSecondaryTextPrompt()
  end
end
