module("cardSystem.logic")
missionSetupData["Tutorial garage"] = {}
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
        specialName = "Willpower tutorial finished",
        taskConditions = {
          {
            {
              goal = "Tutorial panel active",
              params = {inverse = true}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Purchased vehicle from garage",
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
              goal = "Purchased vehicle from shop"
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
        specialName = "Exited garage",
        taskConditions = {
          {
            {
              goal = "In garage",
              params = {inverse = true}
            },
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Garage income tutorial started",
        taskConditions = {
          {
            {
              goal = "Tutorial panel active"
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Garage income tutorial finished",
        taskConditions = {
          {
            {
              goal = "Tutorial panel active",
              params = {inverse = true}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Faked income finished",
        taskConditions = {
          {
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
missionSetupData["Tutorial garage"].taskCreatorFunctionLookups = {
  ["Player team"] = tannerTask
}
missionSetupData["Tutorial garage"].initiate = function(instance)
  enableWillpower(true)
  scoreSystem.setWillpowerPromptState(true)
  Commentary.LoadMission(cards.Missions[instance.challenge.name].MissionID)
end
missionSetupData["Tutorial garage"].update = nil
taskCompleteData["Tutorial garage"] = {}
taskCompleteData["Tutorial garage"].taskComplete = function(taskObject, task)
  print(task.specialName)
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  if task.specialName == "Player is not in a transition" then
    if not ProfileSettings.GetToolTipShown(toolTipLookupTable["Willpower tutorial"]) then
      CutsceneFiles.tutorials.playTutorial("ID:243880", nil, function()
        ProfileSettings.SetToolTipShown(toolTipLookupTable["Willpower tutorial"])
      end)
    end
  elseif task.specialName == "Willpower tutorial finished" then
    garage.enable(true, true)
    garage.updateGarageUnlocks(0)
    vehicleManager.updateVehicleUnlocks(0)
  elseif task.specialName == "Exited garage" then
    garage.enable(false)
    feedbackSystem.menusMaster.blockHintButton(true)
    CutsceneFiles.tutorials.playTutorial("ID:243894")
  elseif task.specialName == "Garage income tutorial finished" then
    local fakedGarageIncome = 3500
    ProfileSettings.SetGarageWillpowerTutorialPlayed(true)
    garage.enable(true)
    scoreSystem.willpowerReward(fakedGarageIncome, "Garage")
    garage.awardedWillpower(fakedGarageIncome)
  elseif task.specialName == "Faked income finished" then
    localPlayer.challenge.endScreen(taskObject, {callback = completeTask, rating = "PASS"})
  end
end
missionEndCallback["Tutorial garage"] = function(instance)
  ProfileSettings.SetGarageTutorialPlayed(true)
  ProfileSettings.SetGarageWillpowerTutorialPlayed(true)
  garage.updateGarageUnlocks(0)
  vehicleManager.updateVehicleUnlocks(0)
end
