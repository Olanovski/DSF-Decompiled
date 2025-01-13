module("cardSystem.logic")
missionSetupData["Generic chase"] = {}
local evadeTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Follow Route"
      }
    }
  }
  return task
end
local chaseTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Non-linear Chase",
        dynamicTargets = true,
        taskConditions = {},
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Generic chase hud"
          }
        },
        audioPIP = audio
      }
    }
  }
  if goalParams["Duration of chaser proximity to evader (+ score)"] then
    task[1][1].goalConditions[#task[1][1].goalConditions + 1] = {
      {
        goal = "Within radius",
        params = {value = 10}
      },
      {
        goal = "Time trigger",
        params = {
          value = goalParams["Duration of chaser proximity to evader (+ score)"]
        }
      }
    }
  end
  if goalParams["Within radius (+ score)"] then
    task[1][1].taskConditions[#task[1][1].taskConditions + 1] = {
      {
        goal = "Within radius",
        params = {value = 10}
      },
      {
        goal = "Time trigger",
        params = {
          value = goalParams["Within radius time"] or 1
        }
      }
    }
  end
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
  if goalParams["Score for chaser win"] then
    task[1][1].taskConditions[#task[1][1].taskConditions + 1] = {
      {
        goal = "Total team payload over",
        params = {
          value = goalParams["Score for chaser win"]
        }
      }
    }
  end
  if goalParams["Evader damage for chaser win"] then
    task[1][1].taskConditions[#task[1][1].taskConditions + 1] = {
      {
        goal = "All targets damage above",
        params = {
          value = goalParams["Evader damage for chaser win"]
        }
      }
    }
  end
  task = setupGenericLevers(task, goalParams, HUD)
  return task
end
missionSetupData["Generic chase"].taskCreatorFunctionLookups = {
  ["Evade team"] = evadeTask,
  ["Chase team"] = chaseTask
}
local notPrintedOnce = false
missionSetupData["Generic chase"].initiate = function(instance)
  if instance.challenge.name == "Exposition 06 Law Breaker (cop)" then
    local getawayVehicle = instance.taskObjectsByActorID["Evade team member 1"].coreData.agent.gameVehicle
    zapcontroller.AddLockedVehicle({gameVehicle = getawayVehicle})
    local copToWreckVehicle = instance.taskObjectsByActorID["Chase team member 1"].coreData.agent.gameVehicle
    GameVehicleResource.applyDamage({gameVehicle = copToWreckVehicle, damage = 1})
    feedbackSystem.menusMaster.currentHUDSetTextVariable("prompt_primary", "THE CARS WRECKED")
    feedbackSystem.menusMaster.masterSetVariable("iPrompt_Primary_Display", 2)
    feedbackSystem.menusMaster.currentHUDSetTextVariable("prompt_secondary", "USE ANY OTHER VEHICLE TO TAKEDOWN THE GETAWAY")
    feedbackSystem.menusMaster.masterSetVariable("iPrompt_Secondary_Display", 2)
  elseif instance.challenge.name == "Exposition 08 Law Breaker (Getaway)" then
    local copVehicle = instance.taskObjectsByActorID["Chase team member 1"].coreData.agent.gameVehicle
    zapcontroller.AddLockedVehicle({gameVehicle = copVehicle})
  end
end
missionSetupData["Generic chase"].update = nil
local getEvadeTeamDynamicTargets = function(taskObject, task, dynamicListID)
  local teams = {}
  for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
    teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
    table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
  end
  return teams["Chase team"], false
end
local getChaseTeamDynamicTargets = function(taskObject, task, dynamicListID)
  local teams = {}
  for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
    teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
    table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
  end
  return teams["Evade team"], false
end
missionSetupData["Generic chase"].targetList = {
  ["Evade team"] = getEvadeTeamDynamicTargets,
  ["Chase team"] = getChaseTeamDynamicTargets
}
