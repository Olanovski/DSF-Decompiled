module("cardSystem.logic")
missionSetupData["Tutorial mission 06 aerial jump"] = {}
local tutorialTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Tutorial Start",
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {levelOfZap = 4}
            },
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
        specialName = "Intro finished",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {levelOfZap = 4}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "At level 4",
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Player in zap transition to level",
              params = {level = 5}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {levelOfZap = 5}
            }
          }
        },
        HUD = {
          {style = HUD}
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Zap prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1, takeZapIntoAccount = true}
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
        specialName = "Well Done",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1, takeZapIntoAccount = true}
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
        specialName = "At level 3",
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Player in zap transition to level",
              params = {level = 4}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {levelOfZap = 4}
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
        specialName = "Complete prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1, takeZapIntoAccount = true}
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
        specialName = "Tutorial complete",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3, takeZapIntoAccount = true}
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
missionSetupData["Tutorial mission 06 aerial jump"].taskCreatorFunctionLookups = {
  ["Tanner team"] = tutorialTask
}
local blockZapFunction = function()
  if zapcontroller.GetTargetedGameVehicle() then
    zapcontroller.ShowZapInLockedIcon(localPlayer.localID, true)
    OneShotSound.Play("ZAP_ZapIn_Unavailable")
  end
end
missionSetupData["Tutorial mission 06 aerial jump"].initiate = function(instance)
  localPlayer:blockAbility("zap", true)
  localPlayer:SetZapLevel(4)
  scoreSystem.tutorialMode(localPlayer.localID, true)
  feedbackSystem.menusMaster.blockHintButton(true)
  zap.SetZapInOverride(blockZapFunction)
  zapcontroller.setZapCameraLocks(0, {
    missile = true,
    low = true,
    mid = true,
    high = true,
    top = true
  })
  Commentary.SetTannerInMission(true)
  Commentary.LoadMission(cards.Missions[instance.challenge.name].MissionID)
end
missionSetupData["Tutorial mission 06 aerial jump"].update = nil
missionEndCallback["Tutorial mission 06 aerial jump"] = function(instance)
  feedbackSystem.menusMaster.blockHintButton(false)
  scoreSystem.tutorialMode(localPlayer.localID, false)
  zap.SetZapInOverride(nil)
  zapcontroller.setZapCameraLocks(0, {
    missile = false,
    low = true,
    mid = false,
    high = false,
    top = false
  })
  localPlayer:blockAbility("zap", false)
  Commentary.SetTannerInMission(false)
  zapcontroller.ShowZapInLockedIcon(localPlayer.localID, false)
end
taskCompleteData["Tutorial mission 06 aerial jump"] = {}
taskCompleteData["Tutorial mission 06 aerial jump"].taskComplete = function(taskObject, task)
  local function completeTask()
    progressionSystem.endTutorial()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  if task.specialName == "Tutorial Start" then
    CutsceneFiles.tutorials.playTutorial("ID:236224", nil, nil, true)
    localPlayer:blockAbility("zap", false)
  elseif task.specialName == "Tutorial complete" then
    localPlayer.challenge.endScreen(taskObject, {callback = completeTask, rating = "PASS"})
  end
end
