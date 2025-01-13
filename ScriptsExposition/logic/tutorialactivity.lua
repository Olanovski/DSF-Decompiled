module("cardSystem.logic")
missionSetupData["Tutorial activity"] = {}
local tannerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Activity unlocked",
        taskConditions = {
          {
            {
              goal = "Prompt active",
              params = {promptType = "Primary"}
            }
          }
        },
        HUD = {
          {style = HUD}
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Activity prompt over",
        taskConditions = {
          {
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            }
          },
          {
            {
              goal = "In activity hotspot"
            }
          }
        },
        HUD = {
          {style = HUD}
        }
      },
      {
        task = "No AI",
        specialName = "Activity prompt audio",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2, takeZapIntoAccount = true}
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
        specialName = "Activity accepted",
        goalConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "In garage hotspot",
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
              goal = "In garage hotspot"
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
        }
      }
    }
  }
  return task
end
missionSetupData["Tutorial activity"].taskCreatorFunctionLookups = {
  ["Player team"] = tannerTask
}
local expoActivity = "Checkpoint activity 1"
missionSetupData["Tutorial activity"].initiate = function(instance)
  local ID = cards.ReverseMissionNetworkLookup[expoActivity]
  ProfileSettings.SetChallengeUnlocked(ID, true)
  shop.purchaseChallenge(ID)
  activeChallenges.enableActivities()
  enableWillpower(true)
  scoreSystem.setWillpowerPromptState(true)
  Commentary.LoadMission(cards.Missions[instance.challenge.name].MissionID)
end
missionSetupData["Tutorial activity"].update = nil
taskCompleteData["Tutorial activity"] = {}
taskCompleteData["Tutorial activity"].taskComplete = function(taskObject, task)
  print(task.specialName)
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  if task.success and task.specialName == "Activity accepted" then
    localPlayer.challenge.endScreen(taskObject, {callback = completeTask, rating = "PASS"})
  end
end
missionEndCallback["Tutorial activity"] = function(instance)
  local activity = progressionSystem.findActivityInProgression(expoActivity)
  activity.iconIndex = feedbackSystem.newTarget(activity, "In world icon", {
    type = activity.iconType
  })
end
