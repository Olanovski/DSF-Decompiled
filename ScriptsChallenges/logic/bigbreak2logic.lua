module("cardSystem.logic")
missionSetupData["Big break 2"] = {}
local tutorialStarted = false
local playerTask = function(goalParams, HUD, audio)
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
            style = "Big break 2 hud"
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Destruction",
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
              params = {value = 0}
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
              goal = "Instance dynamic time above",
              params = {
                value = goalParams["Time limit"]
              }
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Checkpoint Gate"] = {dontShowTrackingMarker = true}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Big break 2 hud"
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Big break 2"].taskCreatorFunctionLookups = {
  ["Player team"] = playerTask
}
missionSetupData["Big break 2"].initiate = function(instance)
  instance.timeLimit = instance.challenge.goalValues["Time limit"]
  localPlayer:blockAbility("zap", true)
  characterManager.DisablePeds()
  propSystem.setupRuntimeProps(instance.challenge.props, true, true, true)
  createCheckpoints(instance)
  localPlayer:enterCutsceneMode()
end
missionSetupData["Big break 2"].update = nil
local RaceTeamDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, task.actor.checkpointGroup)
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
end
missionSetupData["Big break 2"].targetList = {
  ["Player team"] = RaceTeamDynamicTargets
}
taskCompleteData["Big break 2"] = {}
taskCompleteData["Big break 2"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.agent,
    cameraShots = cameraShots[2],
    successReason = "ID:245521",
    failReason = "ID:184074",
    hint = "ID:246659",
    driverIsTanner = true
  }
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
    elseif task.specialName == "Wait for countdown" then
      localPlayer:exitCutsceneMode()
      feedbackSystem.menusMaster.primaryTextPromptParam({
        prompt = "ID:245940",
        delay = true,
        priority = 1
      })
    else
      local function completeTask()
        progressionSystem.challengeComplete(task.instance, task.agent.matrix)
      end
      if feedbackSystem.getTimer() > math.floor(singlePlayerStatistics.getScoreStatistic()) / 100 then
        params.rating = "PASS"
        params.callback = completeTask
        singlePlayerStatistics.updateScoreStatistic(feedbackSystem.getTimer(), "Time")
      else
        params.failReason = "ID:231222"
        params.rating = "FAIL"
        params.callback = failTask
      end
      localPlayer.challenge.endScreen(taskObject, params)
    end
  else
    if 1 <= task.agent.damage then
      params.failReason = "ID:173965"
    end
    params.rating = "FAIL"
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Big break 2"] = function(instance)
  propSystem.cleanupRuntimeProps("BigBreak2Props2")
  localPlayer:blockAbility("zap", false)
end
