module("cardSystem.logic")
missionSetupData["Tutorial mission 02 ram"] = {}
local tutorialTask = function(goalParams, HUD, audio)
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
            style = "Tutorial mission 02 ram HUD"
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
            style = "Tutorial mission 02 ram HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Player has rammed part 1",
        taskConditions = {
          {
            {
              goal = "Player successfully rammed a gameVehicle",
              params = {destroyVehicle = true, destroyICam = true}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 02 ram HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "button press 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player using ram"
            }
          },
          {
            {
              goal = "Player using ram",
              params = {inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 02 ram HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "in shift 4",
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
            style = "Tutorial mission 02 ram HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "control config change4",
        groupProgression = {priorityMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Controller config has changed"
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 02 ram HUD"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "cutscene finished AGAIN",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 4, takeZapIntoAccount = true}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 02 ram HUD"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "control config change3 AGAIN",
        groupProgression = {priorityMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Controller config has changed"
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 02 ram HUD"
          }
        }
      }
    },
    {
      {
        task = "Payload Tracking",
        specialName = "Player has rammed part 2",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Player successfully rammed a gameVehicle",
              params = {
                destroyVehicle = true,
                destroyICam = true,
                missedVehiclePrompt = "ID:183931"
              }
            }
          },
          {
            autoRefesh = true,
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Payload has changed",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Payload over",
              params = {value = 3}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 02 ram HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "button press 2 AGAIN",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player using ram"
            }
          },
          {
            {
              goal = "Player using ram",
              params = {inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 02 ram HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "in shift 4 AGAIN",
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
            style = "Tutorial mission 02 ram HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "control config change4 AGAIN",
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
            style = "Tutorial mission 02 ram HUD"
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
            style = "Tutorial mission 02 ram HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "cutscene finished AGAIN AGAIN",
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
              params = {value = 4, takeZapIntoAccount = true}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission 02 ram HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "in shift 3 AGAIN AGAIN",
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
            style = "Tutorial mission 02 ram HUD"
          }
        }
      },
      {
        task = "No AI",
        specialName = "control config change3 AGAIN AGAIN",
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
            style = "Tutorial mission 02 ram HUD"
          }
        }
      }
    }
  }
  return task
end
missionSetupData["Tutorial mission 02 ram"].taskCreatorFunctionLookups = {
  ["Tanner team"] = tutorialTask
}
missionSetupData["Tutorial mission 02 ram"].initiate = function(instance)
  zapcontroller.stopZapLoadFlashOnNextVehicle()
  Commentary.LoadMission(cards.Missions[instance.challenge.name].MissionID)
  CutsceneFiles.tutorials.playTutorial("ID:236714", nil, nil, true)
  scoreSystem.tutorialMode(localPlayer.localID, true)
  feedbackSystem.menusMaster.blockHintButton(true)
end
missionSetupData["Tutorial mission 02 ram"].update = nil
missionEndCallback["Tutorial mission 02 ram"] = function(instance)
  feedbackSystem.updateTutorialPanel({panelState = 3})
  localPlayer:blockAbility("zap", false)
  feedbackSystem.menusMaster.blockHintButton(false)
  scoreSystem.tutorialMode(localPlayer.localID, false)
  scoreSystem.showAbilityFeedback(localPlayer.localID, true)
end
taskCompleteData["Tutorial mission 02 ram"] = {}
taskCompleteData["Tutorial mission 02 ram"].taskComplete = function(taskObject, task)
  local function completeTask()
    progressionSystem.endTutorial()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  if task.specialName == "cutscene finished AGAIN AGAIN" then
    feedbackSystem.updateTutorialPanel({panelState = 3})
    localPlayer.challenge.endScreen(taskObject, {callback = completeTask, rating = "PASS"})
  end
end
