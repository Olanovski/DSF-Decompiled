module("cardSystem.logic")
missionSetupData["Take down the getaway"] = {}
local chaseSettings = felony_chase.getSpecifiedMissionChaseSettings("Take down the getaway")
local playerTask = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "Chaser logic",
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "All chaser teammates wrecked"
            }
          },
          {
            forceTaskComplete = true,
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
        HUD = {
          {
            style = "Takedown the getwaway hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Audio - Zapped into",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Player controlling specified chaser",
              params = {ID = 2}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - getaway nearly wrecked",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            triggerCount = 1,
            {
              goal = "Getaway damage above",
              params = {value = 0.9}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - team mate destroyed",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            triggerCount = 1,
            {
              goal = "Specified chaser damage above",
              params = {ID = 1, value = 1}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Specified chaser damage above",
              params = {ID = 2, value = 1}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Player in zap",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Player using zap return",
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
        specialName = "Which vehicle is player controlling",
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
              params = {value = 3}
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
              params = {value = 0.5}
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
              params = {value = 3, thisInstance = true}
            }
          },
          {
            {
              goal = "Total successful rams above",
              params = {value = 40}
            }
          }
        }
      }
    }
  }
  return task
end
local dummyTask = function(goalParams, HUD, audio)
  local task = {
    {
      {task = "No AI"}
    }
  }
  return task
end
missionSetupData["Take down the getaway"].taskCreatorFunctionLookups = {
  ["Player team"] = playerTask,
  ["Chase team"] = dummyTask
}
local ramPromptActive = false
missionSetupData["Take down the getaway"].initiate = function(instance)
  ramPromptActive = false
  instance.playerPreviousVehicle = nil
  feedbackSystem.menusMaster.primaryTextPrompt("ID:232273", false, true, false, false, false)
  feedbackSystem.startMusic("Uid01234_CH02_MissionFromGod_Play")
  local evaderGameVehicle = instance.taskObjectsByActorID["Evade team member 1"].coreData.agent.gameVehicle
  local chaserGameVehicle = instance.taskObjectsByActorID["Chase team member 1"].coreData.agent.gameVehicle
  evaderGameVehicle.performance = 2
  felony_chase.startChase(evaderGameVehicle, chaserGameVehicle)
  felony_chase.addChaser(evaderGameVehicle, instance.taskObjectsByActorID["Chase team member 2"].coreData.agent.gameVehicle)
end
missionSetupData["Take down the getaway"].update = function(instance)
end
missionSetupData["Take down the getaway"].targetList = nil
missionSetupData["Take down the getaway"].goalComplete = function(taskObject, task, conditionKey)
  if task.specialName == "Ram reminder" and isAbilityUnlocked("ram") then
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
  elseif task.specialName == "Which vehicle is player controlling" then
    task.instance.playerPreviousVehicle = conditionKey
  end
end
taskCompleteData["Take down the getaway"] = {}
local params
local function setupEndScreen(task)
  params = {
    vehicle = felony_chase.endScreenVehicle,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    passCondition = task.instance.challenge.taskCompleteData["Pass condition"],
    hint = "ID:235488",
    hintIcon1 = localPlayer.buttonLayout.zapReturn,
    driverIsTanner = false
  }
end
taskCompleteData["Take down the getaway"].taskComplete = function(taskObject, task)
  if task.success and task.specialName == "Chaser logic" then
    setupEndScreen(task)
    local function completeTask()
      progressionSystem.challengeComplete(task.instance, task.agent.matrix)
    end
    params.dialogue = "GPMV00_SUCCESS_L_2"
    params.callback = completeTask
    params.rating = "PASS"
    feedbackSystem.stopMusic("Uid01234_CH02_MissionFromGod_Stop")
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.success and task.specialName == "Ram reminder" and ramPromptActive then
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    ramPromptActive = false
  elseif not task.success and task.specialName == "Chaser logic" then
    setupEndScreen(task)
    if task.condition == 2 then
      params.reason = "Wrecked"
      if task.instance.playerPreviousVehicle == 1 then
        params.dialogue = "GPMV00_FAILURE_L_2"
      elseif task.instance.playerPreviousVehicle == 2 then
        params.dialogue = "GPMV00_FAILURE_L_4"
      end
    end
    if task.condition == 1 then
      params.reason = "Lost getaway"
      if task.instance.playerPreviousVehicle == 1 then
        params.dialogue = "GPMV00_FAILURE_L_1"
      elseif task.instance.playerPreviousVehicle == 2 then
        params.dialogue = "GPMV00_FAILURE_L_3"
      end
      params.failReason = "ID:245236"
    end
    local function failTask()
      progressionSystem.challengeFailed(task.instance, task.agent.matrix)
    end
    params.callback = failTask
    params.rating = "FAIL"
    feedbackSystem.stopMusic("Uid01234_CH02_MissionFromGod_Stop")
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Take down the getaway"] = function(instance)
  feedbackSystem.menusMaster.clearSecondaryTextPrompt()
end
