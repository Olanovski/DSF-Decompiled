module("cardSystem.logic")
missionSetupData["Tutorial mission 01 boost"] = {}
local racerTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Start tutorial",
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 01 boost HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Zap prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1, takeZapIntoAccount = true}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 01 boost HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Boosted",
        taskConditions = {
          {
            {
              goal = "Player using nitro"
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 01 boost HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Boost prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 01 boost HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "wrecked 1",
        groupProgression = {priorityMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Player zap status has changed",
              params = {transition = "out"}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 01 boost HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "control config change1",
        groupProgression = {priorityMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Controller config has changed"
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 01 boost HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "cutscene 2 finished",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2, takeZapIntoAccount = true}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 01 boost HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Another WAIT",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 01 boost HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Hold boost start",
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 01 boost HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "WAIT",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5, takeZapIntoAccount = true}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 01 boost HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "boost end",
        goalConditions = {
          {
            {
              goal = "Player using nitro"
            }
          },
          {
            {
              goal = "Player using nitro",
              params = {inverse = true}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Player using nitro"
            },
            {
              goal = "Time trigger",
              params = {value = 1},
              feedback = "Time"
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 01 boost HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Mid boost",
        groupProgression = {priorityMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Player using nitro"
            },
            {
              goal = "Time trigger",
              params = {value = 0.7}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "wrecked 2",
        groupProgression = {priorityMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Player zap status has changed",
              params = {transition = "out"}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 01 boost HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "control config change2",
        groupProgression = {priorityMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Controller config has changed"
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 01 boost HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Trigger tutorial panel",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 01 boost HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Tutorial end",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2, takeZapIntoAccount = true}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 01 boost HUD"
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Tutorial mission 01 boost"].taskCreatorFunctionLookups = {
  ["Tanner team"] = racerTask
}
missionSetupData["Tutorial mission 01 boost"].initiate = function(instance)
  scoreSystem.showAbilityFeedback(localPlayer.localID, false)
  scoreSystem.maxAbility(localPlayer.localID)
  scoreSystem.tutorialMode(localPlayer.localID, true)
  Commentary.LoadMission(cards.Missions[instance.challenge.name].MissionID)
  scoreSystem.showAbilityFeedback(localPlayer.localID, true)
  feedbackSystem.menusMaster.blockHintButton(true)
  scoreSystem.stopAbilityGain(localPlayer.localID, false)
  CutsceneFiles.tutorials.playTutorial("ID:178494", nil, tutorialScreenFinished, true)
end
missionSetupData["Tutorial mission 01 boost"].update = nil
missionEndCallback["Tutorial mission 01 boost"] = function(instance)
  feedbackSystem.updateTutorialPanel({panelState = 3})
  feedbackSystem.menusMaster.blockHintButton(false)
  scoreSystem.tutorialMode(localPlayer.localID, false)
  localPlayer:blockAbility("zap", false)
end
taskCompleteData["Tutorial mission 01 boost"] = {}
taskCompleteData["Tutorial mission 01 boost"].taskComplete = function(taskObject, task)
  local function completeTask()
    progressionSystem.endTutorial()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  if task.specialName == "Tutorial end" then
    localPlayer.challenge.endScreen(taskObject, {callback = completeTask, rating = "PASS"})
  end
end
