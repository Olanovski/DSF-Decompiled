module("cardSystem.logic")
missionSetupData["Felony chase activity"] = {}
local startPromptParams = {delay = true, priority = 1}
local ramPromptActive = false
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
              params = {value = 0.5}
            }
          }
        },
        HUD = {
          {
            style = "Felony chase activity hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Chase",
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
            style = "Felony chase activity hud"
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
      },
      {
        task = "No AI",
        groupProgression = {importantMinorOrder = false},
        specialName = "Ram reminder",
        goalConditions = {
          {
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
              params = {value = 20}
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
              params = {value = 20}
            },
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          },
          {
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
              params = {value = 10}
            }
          }
        }
      }
    }
  }
  if goalParams["Start countdown"] then
    task[1][1].taskConditions[1] = {
      {
        goal = "Time trigger",
        params = {value = 3},
        feedback = "Time"
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
            goal = "Time trigger",
            params = {
              value = goalParams["Time limit"]
            }
          }
        }
      }
    }
  end
  return task
end
missionSetupData["Felony chase activity"].taskCreatorFunctionLookups = {
  ["Evade team"] = doomedTask,
  ["Chase team"] = doomedTask,
  ["Player"] = playerTask
}
missionSetupData["Felony chase activity"].initiate = function(instance)
  ramPromptActive = false
  if instance.challenge.props then
    propSystem.setupRuntimeProps(instance.challenge.props, false)
  end
  localPlayer:enterCutsceneMode()
end
missionSetupData["Felony chase activity"].update = nil
missionSetupData["Felony chase activity"].goalComplete = function(taskObject, task, conditionKey)
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
  end
end
taskCompleteData["Felony chase activity"] = {}
taskCompleteData["Felony chase activity"].taskComplete = function(taskObject, task)
  local params = {
    cameraShots = cameraShots[2],
    successReason = "ID:245207",
    hint = "ID:245265"
  }
  if task.specialName == "Wait for countdown" then
    if task.instance.challenge.goalValues["Start prompt"] then
      startPromptParams.prompt = task.instance.challenge.goalValues["Start prompt"]
    else
      startPromptParams.prompt = "ID:178462"
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
  elseif task.specialName ~= "Ram reminder" then
    if task.success then
      local function completeTask()
        progressionSystem.challengeComplete(task.instance, task.agent.matrix)
      end
      params.rating = "PASS"
      params.vehicle = felony_chase.endScreenVehicle
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    else
      local function failTask()
        progressionSystem.challengeFailed(task.instance, task.agent.matrix)
      end
      if task.specialName == "Chase" then
        if task.condition == 2 then
          params.vehicle = felony_chase.endScreenVehicle
          params.failReason = "ID:243499"
        elseif task.condition == 3 then
          params.vehicle = felony_chase.endScreenVehicle
          params.failReason = "ID:173965"
        end
      elseif task.specialName == "FAIL - Time ran out" then
        params.vehicle = felony_chase.endScreenVehicle
        params.failReason = "ID:184828"
      end
      params.callback = failTask
      params.rating = "FAIL"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  end
end
missionEndCallback["Felony chase activity"] = function(instance)
  if instance.challenge.props then
    propSystem.cleanupRuntimeProps(instance.challenge.props)
  end
end
