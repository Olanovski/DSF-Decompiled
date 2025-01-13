module("cardSystem.logic")
missionSetupData["Generic chase challenge"] = {}
local startTime = false
local splitTime = false
local startPromptParams = {delay = true, priority = 1}
local tutorialStarted = false
local failHintsLookup = {
  MarinCopRun = "ID:246666",
  LuckyEscape = "ID:247271",
  SutroDrift = "ID:247271",
  CopOut = "ID:247270"
}
local evadeTask = function(goalParams, HUD, audio)
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
            style = "Challenge chase hud"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        dynamicTargets = true,
        specialName = "Evader",
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
          },
          {
            failCondition = true,
            {goal = "Got busted"}
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                [goalParams["Checkpoint type"] or "Checkpoint Gate"] = {}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Challenge chase hud"
          }
        }
      }
    }
  }
  if goalParams["Jump iCam Checkpoint Start"] then
    task[2][#task[2] + 1] = {
      task = "Linear Checkpoints",
      specialName = "Jump iCam Checkpoint",
      dynamicTargets = true,
      groupProgression = {importantMinorOrder = false},
      goalConditions = {
        {
          {
            goal = "Within strip of road",
            params = {value = 10}
          }
        }
      },
      taskConditions = {
        {
          {
            goal = "Actor has passed checkpoint number",
            params = {
              value = goalParams["Jump iCam Checkpoint Start"]
            }
          },
          {
            goal = "Actor has passed checkpoint number",
            params = {
              value = goalParams["Jump iCam Checkpoint Start"] + 1,
              inverse = true
            }
          },
          {goal = "Is jumping"}
        },
        {
          failCondition = true,
          {
            goal = "Actor has passed checkpoint number",
            params = {
              value = goalParams["Jump iCam Checkpoint Start"] + 1
            }
          }
        }
      }
    }
  end
  return task
end
local chaseTask = function(goalParams, HUD, audio)
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
            style = "Challenge chase hud"
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Generic chase challenge"].taskCreatorFunctionLookups = {
  ["Evade team"] = evadeTask,
  ["Chase team"] = chaseTask
}
missionSetupData["Generic chase challenge"].initiate = function(instance)
  localPlayer:blockAbility("zap", true)
  createCheckpoints(instance)
  local playerTaskObject = localPlayer:getTaskObject()
  setUpRouteManager(playerTaskObject)
  localPlayer:enterCutsceneMode()
  if instance.challenge.props then
    propSystem.setupRuntimeProps(instance.challenge.props, false)
  end
end
missionSetupData["Generic chase challenge"].update = nil
local function EvaderDynamicTargets(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if task.specialName ~= "Jump iCam Checkpoint" and not task.instance.splitTimes and taskObject.coreData.agent.controlled then
    task.instance.splitTimes = {}
    startTime = g_NetworkTime
  end
  if dynamicListID then
    if task.specialName ~= "Jump iCam Checkpoint" and taskObject.coreData.agent.controlled then
      splitTime = g_NetworkTime - startTime
      splitTime = feedbackSystem.RandomiseMilliseconds(splitTime)
      table.insert(task.instance.splitTimes, splitTime)
    end
    if task.networkVars.checkpoints < #allCheckpoints then
      return {
        allCheckpoints[task.networkVars.checkpoints + 1]
      }, false
    elseif task.instance.challenge.goalValues["Evader endless route checkpoint"] then
      task.networkVars.checkpoints = task.instance.challenge.goalValues["Evader endless route checkpoint"]
      RaceManager.SetStartCheckpointIndex(task.instance.raceId, task.instance.challenge.goalValues["Evader endless route checkpoint"])
      return {
        allCheckpoints[task.instance.challenge.goalValues["Evader endless route checkpoint"]]
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
missionSetupData["Generic chase challenge"].targetList = {
  ["Evade team"] = EvaderDynamicTargets
}
taskCompleteData["Generic chase challenge"] = {}
taskCompleteData["Generic chase challenge"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.agent,
    cameraShots = cameraShots[2],
    successReason = task.instance.challenge.taskCompleteData["Success reason"] or "ID:245584",
    driverIsTanner = true,
    hint = failHintsLookup[task.instance.challenge.name] or "ID:246665"
  }
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.specialName == "Wait for countdown" then
    localPlayer:exitCutsceneMode()
    if task.instance.challenge.goalValues["Start prompt"] then
      startPromptParams.prompt = task.instance.challenge.goalValues["Start prompt"]
    else
      startPromptParams.prompt = "ID:245297"
    end
    feedbackSystem.menusMaster.primaryTextPromptParam(startPromptParams)
    if task.instance.challenge.goalValues["Secondary start prompt"] then
      feedbackSystem.menusMaster.secondaryTextPrompt(task.instance.challenge.goalValues["Secondary start prompt"], nil, nil, true)
    end
    local evaderGameVehicle = task.instance.taskObjectsByActorID.Evader.coreData.agent.gameVehicle
    felony_getaway.addEvader(evaderGameVehicle)
    for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team == "Chase team" then
        felony_getaway.addChaser(evaderGameVehicle, taskObject.coreData.agent.gameVehicle)
      end
    end
  elseif task.success then
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
    elseif task.specialName == "Evader" then
      local function completeTask()
        progressionSystem.challengeComplete(task.instance, task.agent.matrix)
      end
      if feedbackSystem.getTimer() < math.floor(singlePlayerStatistics.getScoreStatistic()) / 100 then
        params.rating = "PASS"
        params.callback = completeTask
        singlePlayerStatistics.updateScoreStatistic(feedbackSystem.getTimer(), "Time")
        if task.instance.splitTimes then
          singlePlayerStatistics.updateSplitStatistics(task.instance.splitTimes)
        end
      else
        params.failReason = "ID:231222"
        params.rating = "FAIL"
        params.callback = failTask
      end
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "Jump iCam Checkpoint" then
      local icamParams = {
        cameraTargets = {
          localPlayer.currentVehicle.gameVehicle
        },
        duration = 3,
        speed = 0.2,
        framing = "verywide",
        angleYaw = "front",
        anglePitch = "low",
        fixedCameras = {
          [5] = vec.vector(-1221.61, 179.8029, 4375.527, 1)
        },
        disableAI = true
      }
      iCamActivationTableInput(icamParams)
    end
  elseif task.specialName ~= "Jump iCam Checkpoint" then
    if task.condition == 2 then
      params.failReason = "ID:173965"
    elseif task.condition == 3 then
      params.failReason = "ID:231166"
    end
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Generic chase challenge"] = function(instance)
  localPlayer:blockAbility("zap", false)
  if instance.challenge.props then
    propSystem.cleanupRuntimeProps(instance.challenge.props)
  end
end
