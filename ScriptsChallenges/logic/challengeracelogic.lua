module("cardSystem.logic")
missionSetupData["Generic challenge race"] = {}
local countdownTime = 3
local drift = 0
local startTime = false
local splitTime = false
local tutorialStarted = false
local felonyStarted = false
local targetBeat = false
local blockChaseCam = function()
  local promptFired
  return function()
    if localPlayer.cameraMode == "Normal" then
      localPlayer.currentMode = 2
      localPlayer.cameraMode = "DriverEye"
      localPlayer:resetCameraMode()
      if not promptFired and not feedbackSystem.menusMaster.primaryPromptActive then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:248792")
        promptFired = true
      end
    end
  end
end
local startPromptParams = {delay = true, priority = 1}
local openRacePromptParams = {priority = 3}
local failHintsLookup = {
  ["RallyFaceOff"] = "ID:246660",
  ["FreewayFaceoff"] = "ID:246660",
  ["Team colours tutorial"] = "ID:246660",
  ["Uplaych1"] = "ID:246660",
  ["Uplaych2"] = "ID:246660",
  ["Uplaych4"] = "ID:246658",
  ["ChinatownDrift"] = "ID:246658",
  ["MarinEscape"] = "ID:246668",
  ["Smoketrail"] = "ID:245263"
}
local function racerTask(goalParams, HUD)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait for countdown",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = countdownTime},
              feedback = "Time"
            }
          }
        },
        HUD = {
          {
            style = "Challenge race hud"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Checkpoints",
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
              params = {coreValue = "totalLaps"}
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                [goalParams["Checkpoint type"]] = {}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Challenge race hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "FAIL - Busted",
        taskConditions = {
          {
            failCondition = true,
            {goal = "Got busted"}
          }
        }
      }
    }
  }
  if goalParams["Endless race"] then
    task[2][1].coreData.endless = true
  end
  if goalParams["Hide checkpoints"] then
    table.remove(task[2][1].targetManagers[1])
  end
  if goalParams["Score drift distance"] then
    task[2][1].taskConditions[1] = {
      {
        goal = "Completed lap",
        params = {coreValue = "totalLaps"}
      },
      {
        goal = "Is drifting",
        params = {inverse = true}
      }
    }
  end
  if goalParams["Damage amount for fail"] then
    task[2][#task[2] + 1] = {
      task = "No AI",
      specialName = "FAIL - Damage Above",
      taskConditions = {
        {
          failCondition = true,
          {
            goal = "Damage above",
            params = {
              value = goalParams["Damage amount for fail"]
            }
          }
        }
      }
    }
  end
  if goalParams["Score drift distance"] and goalParams["Time limit"] then
    task[2][#task[2] + 1] = {
      task = "No AI",
      specialName = "FAIL - Time ran out",
      taskConditions = {
        {
          failCondition = true,
          {
            goal = "Instance time above",
            params = {
              value = goalParams["Time limit"] + countdownTime
            }
          },
          {
            goal = "Is drifting",
            params = {inverse = true}
          }
        }
      }
    }
  elseif goalParams["Time limit"] then
    task[2][#task[2] + 1] = {
      task = "No AI",
      specialName = "FAIL - Time ran out",
      taskConditions = {
        {
          failCondition = true,
          {
            goal = "Instance time above",
            params = {
              value = goalParams["Time limit"] + countdownTime
            }
          }
        }
      }
    }
  end
  if goalParams["Any team member damage above"] then
    task[2][#task[2] + 1] = {
      task = "No AI",
      specialName = "FAIL - Team Mate Wrecked",
      taskConditions = {
        {
          failCondition = true,
          {
            goal = "Any team member damage above",
            params = {
              value = goalParams["Any team member damage above"]
            }
          }
        }
      }
    }
  end
  if goalParams["Destroy opposing teams"] then
    task[2][#task[2] + 1] = {
      task = "No AI",
      specialName = "PASS - All opposing vehicles wrecked",
      taskConditions = {
        {
          {
            goal = "All opposing vehicles damage above",
            params = {value = 1}
          }
        }
      }
    }
  end
  return task
end
local function scoringTask(goalParams, HUD)
  local task = {
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
            style = "Challenge race hud"
          }
        }
      }
    },
    {
      {
        task = "Non-linear Checkpoints",
        specialName = "Checkpoints",
        dynamicTargets = false,
        coreData = {
          totalLaps = goalParams["Total laps"] or 0
        },
        goalConditions = {},
        taskConditions = {},
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Challenge race hud"
          }
        }
      }
    }
  }
  if goalParams["Hide checkpoints"] then
    table.remove(task[2][1].targetManagers[1])
  end
  if goalParams["Damage amount for fail"] then
    task[2][#task[2] + 1] = {
      task = "No AI",
      specialName = "FAIL - Damage Above",
      taskConditions = {
        {
          failCondition = true,
          {
            goal = "Damage above",
            params = {
              value = goalParams["Damage amount for fail"]
            }
          }
        }
      }
    }
  end
  if goalParams["Time limit"] then
    task[2][#task[2] + 1] = {
      task = "No AI",
      specialName = "FAIL - Time ran out",
      taskConditions = {
        {
          failCondition = true,
          {
            goal = "Instance time above",
            params = {
              value = goalParams["Time limit"] + countdownTime
            }
          }
        }
      }
    }
  end
  if goalParams["Any team member damage above"] then
    task[2][#task[2] + 1] = {
      task = "No AI",
      specialName = "FAIL - Team Mate Wrecked",
      taskConditions = {
        {
          failCondition = true,
          {
            goal = "Any team member damage above",
            params = {
              value = goalParams["Any team member damage above"]
            }
          }
        }
      }
    }
  end
  task = setupGenericLevers(task, goalParams, HUD)
  return task
end
local function opposingRacerTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait for countdown",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = countdownTime},
              feedback = "Time"
            }
          }
        },
        HUD = {
          {
            style = "Challenge race hud"
          }
        }
      }
    },
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
            }
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Generic challenge race"].taskCreatorFunctionLookups = {
  ["Race team 1"] = racerTask,
  ["Race team 2"] = opposingRacerTask,
  ["Scoring race team 1"] = scoringTask
}
missionSetupData["Generic challenge race"].initiate = function(instance)
  localPlayer:blockAbility("zap", true)
  if instance.challenge.name == "ItalianJob" or instance.challenge.name == "Survival" or instance.challenge.name == "GoldenGateCircuit" or instance.challenge.name == "ChinatownDrift" or instance.challenge.name == "DowntownSprint" or instance.challenge.name == "DownhillDrift" then
    characterManager.DisablePeds()
  end
  createCheckpoints(instance)
  scoreSystem.maxAbility()
  local playerTaskObject = localPlayer:getTaskObject()
  setUpRouteManager(playerTaskObject)
  if instance.challenge.goalValues.scoringType == "Drift" then
    instance.driftScore = 0
    Sound.EnableScoring("drift", true)
  end
  if instance.challenge.name == "RallyFaceOff" then
    for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
      if not taskObject.coreData.actor.previewMovie then
        taskObject.coreData.agent.gameVehicle.performance = 1.15
      end
    end
  end
  if instance.challenge.name == "HardcoreChallenge" then
    addUserUpdateFunction("Block chase cam", blockChaseCam(), 1)
  end
  if instance.challenge.props then
    propSystem.setupRuntimeProps(instance.challenge.props, false)
  end
  felonyStarted = false
  targetBeat = false
  localPlayer:enterCutsceneMode()
end
missionSetupData["Generic challenge race"].update = nil
local function RaceTeamDynamicTargets(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if not task.instance.splitTimes and taskObject.coreData.agent.controlled then
    task.instance.splitTimes = {}
    startTime = g_NetworkTime
  end
  if dynamicListID then
    if taskObject.coreData.agent.controlled then
      splitTime = g_NetworkTime - startTime
      splitTime = feedbackSystem.RandomiseMilliseconds(splitTime)
      table.insert(task.instance.splitTimes, splitTime)
    end
    if task.networkVars.checkpoints < #allCheckpoints then
      if task.instance.challenge.goalValues["Checkpoint type"] == "Hotspot" and task.actor.team == "Race team 1" then
        OneShotSound.Play("HUD_Play_Waypoint")
        if task.networkVars.checkpoints == #allCheckpoints - 1 then
          openRacePromptParams.prompt = "ID:243130"
        else
          openRacePromptParams.prompt = "ID:243824"
          openRacePromptParams.value = #allCheckpoints - task.networkVars.checkpoints
        end
        localPlayer.simulationSupport.doWait(4, function()
          feedbackSystem.menusMaster.primaryTextPromptParam(openRacePromptParams)
        end, "promptWait")
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
local ScoringRaceTeamDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
end
missionSetupData["Generic challenge race"].targetList = {
  ["Race team 1"] = RaceTeamDynamicTargets,
  ["Race team 2"] = RaceTeamDynamicTargets,
  ["Scoring race team 1"] = ScoringRaceTeamDynamicTargets
}
missionSetupData["Generic challenge race"].goalComplete = function(taskObject, task, conditionKey)
  if task.instance.challenge.name == "MarinEscape" and task.specialName == "Checkpoints" and not felonyStarted and task.networkVars.checkpoints == 4 then
    felony_getaway.addEvader(task.instance.taskObjectsByActorID["Race team 1 member 1"].coreData.agent.gameVehicle)
    felonyStarted = true
  end
end
taskCompleteData["Generic challenge race"] = {}
taskCompleteData["Generic challenge race"].taskComplete = function(taskObject, task)
  if task.specialName == "Wait for countdown" then
    localPlayer:exitCutsceneMode()
    if task.instance.challenge.goalValues["Start prompt"] then
      startPromptParams.prompt = task.instance.challenge.goalValues["Start prompt"]
    else
      startPromptParams.prompt = "ID:229435"
    end
    feedbackSystem.menusMaster.primaryTextPromptParam(startPromptParams)
    if task.instance.challenge.name == "Smoketrail" then
      feedbackSystem.menusMaster.secondaryTextPromptParam({prompt = "ID:231170", delay = true})
    end
  else
    local params = {
      vehicle = task.agent,
      cameraShots = cameraShots[2],
      successReason = task.instance.challenge.taskCompleteData["Success reason"] or "ID:183987",
      hint = failHintsLookup[task.instance.challenge.name] or "ID:246657"
    }
    local function completeTask()
      progressionSystem.challengeComplete(task.instance, task.agent.matrix)
    end
    local function failTask()
      progressionSystem.challengeFailed(task.instance, task.agent.matrix)
    end
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
      elseif task.specialName == "Wait for tutorial" then
      elseif taskObject.playerTask then
        if task.instance.challenge.goalValues.scoringType == "Drift" then
          if task.instance.driftScore > singlePlayerStatistics.getScoreStatistic() then
            singlePlayerStatistics.updateScoreStatistic(task.instance.driftScore, "Score")
            targetBeat = true
          end
        elseif feedbackSystem.getTimer() < math.floor(singlePlayerStatistics.getScoreStatistic()) / 100 then
          singlePlayerStatistics.updateScoreStatistic(feedbackSystem.getTimer(), "Time")
          if task.instance.splitTimes then
            singlePlayerStatistics.updateSplitStatistics(task.instance.splitTimes)
          end
          targetBeat = true
        end
        if task.specialName == "PASS - All opposing vehicles wrecked" then
          params.successReason = "ID:186280"
        end
        if targetBeat then
          params.rating = "PASS"
          params.callback = completeTask
          params.driverIsTanner = true
          localPlayer.challenge.endScreen(taskObject, params)
        else
          params.failReason = "ID:231222"
          params.callback = failTask
          params.rating = "FAIL"
          params.driverIsTanner = true
          localPlayer.challenge.endScreen(taskObject, params)
        end
      else
        params.failReason = "ID:245576"
        params.callback = failTask
        params.rating = "FAIL"
        localPlayer.challenge.endScreen(taskObject, params)
      end
    elseif taskObject.playerTask then
      if task.specialName == "FAIL - Damage Above" then
        params.failReason = "ID:173965"
      elseif task.specialName == "FAIL - Time ran out" then
        params.failReason = "ID:184074"
      elseif task.specialName == "FAIL - Team Mate Wrecked" then
        params.failReason = "ID:184688"
      elseif task.specialName == "FAIL - Busted" then
        params.failReason = "ID:231166"
        params.hint = "ID:235490"
      else
        params.failReason = "INVALID FAIL, CHECK LOGIC"
      end
      params.callback = failTask
      params.rating = "FAIL"
      params.driverIsTanner = true
      localPlayer.challenge.endScreen(taskObject, params)
    else
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:183974", priority = 2})
    end
  end
end
missionEndCallback["Generic challenge race"] = function(instance)
  localPlayer:blockAbility("zap", false)
  characterManager.EnablePeds()
  if instance.challenge.props then
    propSystem.cleanupRuntimeProps(instance.challenge.props)
  end
  if userUpdateFunctions["Block chase cam"] then
    removeUserUpdateFunction("Block chase cam")
  end
  if userUpdateFunctions.promptWait then
    removeUserUpdateFunction("promptWait")
  end
  if instance.challenge.goalValues.scoringType == "Drift" then
    Sound.EnableScoring("drift", false)
  end
end
