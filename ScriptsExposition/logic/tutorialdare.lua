module("cardSystem.logic")
missionSetupData["Tutorial dare"] = {}
local tannerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Player is not in a transition",
        taskConditions = {
          {
            {
              goal = "Player in zap transition",
              params = {value = false}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Dare accepted",
        goalConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "In activity hotspot",
              params = {inverse = true}
            }
          },
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "In activity hotspot"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "In hotspot preview"
            }
          }
        },
        HUD = {
          {style = HUD}
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Dare completed",
        taskConditions = {
          {
            {
              goal = "Dare complete screen active"
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Dare end screen finished",
        taskConditions = {
          {
            {
              goal = "Dare complete screen active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 3, takeZapIntoAccount = true}
            }
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Tutorial dare"].taskCreatorFunctionLookups = {
  ["Player team"] = tannerTask
}
missionSetupData["Tutorial dare"].initiate = function(instance)
  print("Tutorial dare init")
  Commentary.LoadMission(cards.Missions[instance.challenge.name].MissionID)
end
missionSetupData["Tutorial dare"].update = nil
taskCompleteData["Tutorial dare"] = {}
taskCompleteData["Tutorial dare"].taskComplete = function(taskObject, task)
  print(task.specialName)
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  if task.specialName == "Player is not in a transition" and ProfileSettings.GetToolTipShown(toolTipLookupTable["Completed a dare"]) then
    localPlayer.challenge.endScreen(taskObject, {callback = completeTask, rating = "PASS"})
  elseif task.specialName == "Player is not in a transition" then
    dareSystem.dareUnlockCheck(0)
    activeChallenges.enableActivities()
  elseif task.specialName == "Dare completed" then
    feedbackSystem.menusMaster.blockHintButton(true)
  elseif task.specialName == "Dare end screen finished" then
    enableWillpower(true)
    scoreSystem.setWillpowerPromptState(true)
    localPlayer.challenge.endScreen(taskObject, {callback = completeTask, rating = "PASS"})
  end
end
missionEndCallback["Tutorial dare"] = function(instance)
end
