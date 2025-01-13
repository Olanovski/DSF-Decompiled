module("cardSystem.logic")
missionSetupData["Felony chase challenge"] = {}
local startTime = false
local splitTime = false
local startPromptParams = {delay = true, priority = 1}
local tutorialStarted = false
local doomedTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait for your inevitable demise"
      }
    }
  }
  return task
end
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
            style = "Felony chase challenge hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Meat",
        taskConditions = {
          {
            {
              goal = "Busted getaway"
            }
          },
          {
            failCondition = true,
            {
              goal = "Getaway escaped"
            }
          },
          {
            failCondition = true,
            {
              goal = "All chaser teammates wrecked"
            }
          }
        },
        HUD = {
          {
            style = "Felony chase challenge hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Put getaway on loop",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Getaway reached end of route"
            }
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Felony chase challenge"].taskCreatorFunctionLookups = {
  ["Evade team"] = doomedTask,
  ["Chase team"] = doomedTask,
  ["Player"] = playerTask
}
missionSetupData["Felony chase challenge"].initiate = function(instance)
  localPlayer:blockAbility("zap", true)
  localPlayer:enterCutsceneMode()
end
missionSetupData["Felony chase challenge"].update = nil
taskCompleteData["Felony chase challenge"] = {}
taskCompleteData["Felony chase challenge"].taskComplete = function(taskObject, task)
  local params = {
    cameraShots = cameraShots[2],
    successReason = task.instance.challenge.taskCompleteData["Success reason"] or "ID:186181",
    hint = "ID:246667"
  }
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
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
    if task.instance.challenge.goalValues["Start prompt"] then
      startPromptParams.prompt = task.instance.challenge.goalValues["Start prompt"]
    else
      startPromptParams.prompt = "ID:232274"
    end
    feedbackSystem.menusMaster.primaryTextPromptParam(startPromptParams)
    if task.instance.challenge.goalValues["Secondary start prompt"] then
      feedbackSystem.menusMaster.secondaryTextPrompt(task.instance.challenge.goalValues["Secondary start prompt"], nil, nil, true)
    end
    local evaderGameVehicle = task.instance.taskObjectsByActorID.Evader.coreData.agent.gameVehicle
    local chaserGameVehicle = task.instance.taskObjectsByActorID.Chaser.coreData.agent.gameVehicle
    felony_chase.startChase(evaderGameVehicle, chaserGameVehicle)
    localPlayer:exitCutsceneMode()
  elseif task.specialName == "Put getaway on loop" then
    local routeName = task.instance.challenge.goalValues["Final looped route"]
    ActiveLifeAI.setBehaviour(localPlayer.primaryFelony.getawayGameVehicle, "FollowRoute", routeName, routes[routeName].roads)
  elseif task.success then
    local function completeTask()
      progressionSystem.challengeComplete(task.instance, task.agent.matrix)
    end
    if feedbackSystem.getTimer() < math.floor(singlePlayerStatistics.getScoreStatistic()) / 100 then
      params.rating = "PASS"
      params.callback = completeTask
      singlePlayerStatistics.updateScoreStatistic(feedbackSystem.getTimer(), "Time")
    else
      params.failReason = "ID:231222"
      params.rating = "FAIL"
      params.callback = failTask
    end
    params.vehicle = felony_chase.endScreenVehicle
    localPlayer.challenge.endScreen(taskObject, params)
  else
    if task.condition == 2 then
      params.vehicle = felony_chase.endScreenVehicle
      params.failReason = "ID:243499"
    elseif task.condition == 3 then
      params.vehicle = felony_chase.endScreenVehicle
      params.failReason = "ID:173965"
    end
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Felony chase challenge"] = function(instance)
  localPlayer:blockAbility("zap", false)
end
