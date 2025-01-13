module("cardSystem.logic")
missionSetupData["Generic smash activity"] = {}
local playerTask = function(goalParams, HUD)
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
            style = "Generic smash activity HUD"
          }
        }
      }
    },
    {
      {
        task = "Follow Route",
        specialName = "Smash props",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 13}
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
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            }
          },
          {
            failCondition = true,
            {
              goal = "Instance dynamic time above"
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
            style = "Generic smash activity HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Reduce willpower",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Generic smash activity HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Setup route arrows",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Generic smash activity"].taskCreatorFunctionLookups = {
  ["Player team"] = playerTask
}
local marker
missionSetupData["Generic smash activity"].initiate = function(instance)
  local playerTaskObject = localPlayer:getTaskObject()
  local endPosition = routes[playerTaskObject.coreData.actor.routeName].checkpoints[1].position
  instance.timeLimit = instance.challenge.goalValues["Maximum willpower"] / instance.challenge.goalValues["Substracted willpower per second"]
  createFixedPosition(instance, {endPosition}, 101)
  createCheckpoints(instance)
  propSystem.setupRuntimeProps(instance.challenge.props, true, true, true)
  marker = feedbackSystem.newTarget({position = endPosition}, "Hotspot")
  setUpRouteManager(playerTaskObject)
  feedbackSystem.menusMaster.setCurrentFocusString(1)
  localPlayer:enterCutsceneMode()
end
missionSetupData["Generic smash activity"].update = nil
local getPlayersDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    return false, true
  else
    return checkpointSystem.getCheckpoints(task.instance, 101), false
  end
end
missionSetupData["Generic smash activity"].targetList = {
  ["Player team"] = getPlayersDynamicTargets
}
missionEndCallback["Generic smash activity"] = function(instance)
  propSystem.cleanupRuntimeProps(instance.challenge.props)
  feedbackSystem.clearTarget(marker)
  RouteArrowsManager.ClearArrows(localPlayer.localID)
  marker = nil
end
taskCompleteData["Generic smash activity"] = {}
taskCompleteData["Generic smash activity"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.Player.coreData.agent,
    successReason = "ID:245521",
    failReason = "ID:243979",
    hint = "ID:235496"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.specialName == "Wait for countdown" then
    localPlayer:exitCutsceneMode()
  elseif task.success then
    if task.specialName == "Smash props" then
      params.rating = "PASS"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "Setup route arrows" then
      RouteArrowsManager.HideArrows(localPlayer.localID, false)
    end
  else
    if task.condition == 2 then
      params.failReason = "ID:182731"
    end
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
