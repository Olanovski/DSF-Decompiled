module("cardSystem.logic")
missionSetupData["Tutorial Mission Rapid Shift"] = {}
local racerTask = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Wander",
        specialName = "cutscene finished - cop",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission Rapid shift HUD"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "In vehicle",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "Tutorial cop"
              }
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
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
            style = "Tutorial mission Rapid shift HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Prompt enter shift",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1, takeZapIntoAccount = true}
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
            style = "Tutorial mission Rapid shift HUD"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "In shift",
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = true}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1, takeZapIntoAccount = true}
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
            style = "Tutorial mission Rapid shift HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "First zap return",
        taskConditions = {
          {
            {
              goal = "Player using zap return"
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
            style = "Tutorial mission Rapid shift HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "In vehicle after first zap return",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "Tutorial cop"
              }
            },
            {
              goal = "Time trigger",
              params = {value = 1}
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
            style = "Tutorial mission Rapid shift HUD"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "End of part 1",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {
                agentName = "Tutorial cop"
              }
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
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
            style = "Tutorial mission Rapid shift HUD"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Cop chase - wait",
        taskConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Tutorial evader"
                }
              }
            }
          }
        }
      }
    },
    {
      {
        task = "Linear Chase",
        specialName = "rapid shift prompt",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
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
            style = "Tutorial mission Rapid shift HUD"
          }
        }
      }
    },
    {
      {
        task = "Linear Chase",
        specialName = "rapid shifting 1",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Player using zap return"
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
            style = "Tutorial mission Rapid shift HUD"
          }
        }
      }
    },
    {
      {
        task = "Linear Chase",
        specialName = "rapid shift prompt 3",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
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
            style = "Tutorial mission Rapid shift HUD"
          }
        }
      }
    },
    {
      {
        task = "Linear Chase",
        specialName = "rapid shifting 3",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Player using zap return"
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
            style = "Tutorial mission Rapid shift HUD"
          }
        }
      }
    },
    {
      {
        task = "Linear Chase",
        specialName = "Cop chase",
        dynamicTargets = true
      }
    }
  }
  return task
end
local starterTask = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Wander",
        specialName = "added racer",
        taskConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Tutorial evader"
                }
              }
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission Rapid shift HUD"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "removed racer",
        taskConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Tutorial evader"
                },
                inverse = true
              }
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission Rapid shift HUD"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "kill evader prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 4}
            }
          },
          {
            {
              goal = "Is a felony active",
              params = {inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission Rapid shift HUD"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "kill evader",
        goalConditions = {
          {
            {
              goal = "Player within radius of getaway",
              params = {value = 350}
            }
          },
          {
            {
              goal = "Player within radius of getaway",
              params = {inverse = true, value = 350}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Busted getaway"
            }
          },
          {
            {
              goal = "Is a felony active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          },
          {
            {
              goal = "Player within radius of getaway",
              params = {inverse = true, value = 500}
            },
            {
              goal = "Losing getaway time trigger",
              params = {
                value = 10,
                prompt = "ID:245235",
                useRealTime = true
              }
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission Rapid shift HUD"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "End mission",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        HUD = {
          {
            style = "Tutorial mission Rapid shift HUD"
          }
        }
      }
    }
  }
  return task
end
local spawnCop = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Linear Chase",
        specialName = "Cop follow",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Tutorial evader"
                }
              }
            }
          }
        }
      }
    },
    {
      {
        task = "Linear Chase",
        specialName = "rapid shift prompt 2",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 0.1}
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
            style = "Tutorial mission Rapid shift HUD"
          }
        }
      }
    },
    {
      {
        task = "Linear Chase",
        specialName = "rapid shifting 2",
        dynamicTargets = true,
        taskConditions = {
          {
            {
              goal = "Player using zap return"
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
            style = "Tutorial mission Rapid shift HUD"
          }
        }
      }
    },
    {
      {
        task = "Linear Chase",
        specialName = "Cop chase",
        dynamicTargets = true
      }
    }
  }
  return task
end
local spawnEvader = function(goalParams, HUD, audio)
  local task = {
    {
      {task = "Wander"}
    }
  }
  return task
end
missionSetupData["Tutorial Mission Rapid Shift"].taskCreatorFunctionLookups = {
  ["Tutorial actor"] = starterTask,
  ["Tutorial cop"] = racerTask,
  ["Tutorial cop 2"] = spawnCop,
  ["Tutorial cop backup"] = spawnEvader,
  ["Tutorial evader"] = spawnEvader,
  ["Cop 2 team"] = spawnCop
}
missionSetupData["Tutorial Mission Rapid Shift"].initiate = function(instance)
  local function endTutorial()
    challengeSystem.spawnActors(instance, "Never", {
      ["Tutorial cop"] = true,
      ["Tutorial cop 2"] = true
    })
    localPlayer.missionSupport:setMainTaskObject(instance.taskObjectsByActorID["Tutorial cop"])
    zapcontroller.stopZapLoadFlashOnNextVehicle()
    feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_1")
    feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_2")
  end
  localPlayer.blockRapidShiftPress = true
  localPlayer:blockAbility("zap", true)
  feedbackSystem.menusMaster.blockHintButton(true)
  Commentary.LoadMission(cards.Missions[instance.challenge.name].MissionID)
  CutsceneFiles.tutorials.playTutorial("ID:234446", nil, endTutorial, true)
end
local copTeamDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "Cop follow" then
    return {
      task.instance.taskObjectsByActorID["Tutorial cop"].coreData.agent
    }, false
  else
    return {
      task.instance.taskObjectsByActorID["Tutorial evader"].coreData.agent
    }, false
  end
end
missionSetupData["Tutorial Mission Rapid Shift"].targetList = {
  ["Cop 2 team"] = copTeamDynamicTargets,
  ["Cop team"] = copTeamDynamicTargets
}
missionSetupData["Tutorial Mission Rapid Shift"].update = nil
local wonChase
missionEndCallback["Tutorial Mission Rapid Shift"] = function(instance)
  feedbackSystem.updateTutorialPanel({panelState = 3})
  zap.SetZapInOverride(nil)
  localPlayer:blockAbility("zap", false)
  localPlayer.blockRapidShiftPress = false
  feedbackSystem.menusMaster.blockHintButton(false)
  wonChase = false
end
local vehicleSearchParameters = {
  ignoreSciptOwnedVehicles = true,
  ignoreCops = true,
  avoidModelID = {
    197,
    276,
    298,
    287,
    185,
    201,
    291,
    286,
    167
  },
  scoring = {
    sameRoad = {condition = true, discard = true},
    ahead = {condition = true, discard = true},
    sameDirection = {condition = true, discard = true},
    proximity = true
  }
}
local chaser1, chaser2
taskCompleteData["Tutorial Mission Rapid Shift"] = {}
taskCompleteData["Tutorial Mission Rapid Shift"].taskComplete = function(taskObject, task)
  local function completeTask()
    progressionSystem.endTutorial()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
    feedbackSystem.menusMaster.updateFreedriveHintText()
  end
  local function createChase()
    task.instance.taskObjectsByActorID["Tutorial cop"].coreData.agent.gameVehicle.maxAllowedDamage = 1
    task.instance.taskObjectsByActorID["Tutorial cop 2"].coreData.agent.gameVehicle.maxAllowedDamage = 1
    felony_chase.startChase(task.instance.taskObjectsByActorID["Tutorial evader"].coreData.agent.gameVehicle, task.instance.taskObjectsByActorID["Tutorial cop"].coreData.agent.gameVehicle)
    felony_chase.addChaser(localPlayer.primaryFelony.getawayGameVehicle, task.instance.taskObjectsByActorID["Tutorial cop 2"].coreData.agent.gameVehicle)
    localPlayer.primaryFelony.getawayGameVehicle.maxAllowedDamage = 1
  end
  local function createFelon()
    local getaway = vehicleManager.findVehiclesInTraffic(localPlayer.position, localPlayer.currentVehicle.gameVehicle.matrix[2], 150, vehicleSearchParameters, 1)
    if not getaway[1] then
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Tutorial evader"] = true
      })
    else
      if not SNV.getSNVFromGameVehicle(getaway[1]) then
        SNV.CreateSNVFromGV(getaway[1])
      end
      if getaway[1].owner == "Orphan" then
        local actor = task.instance.challenge.actorPool["Tutorial evader"]
        local civAgent = convertOrphanToAgent(getaway[1])
        challengeSystem.createActor(task.instance, civAgent, actor)
      else
        local civAgent = vehicleManager.registerVehicle({
          gameVehicle = getaway[1]
        })
        local actor = task.instance.challenge.actorPool["Tutorial evader"]
        challengeSystem.createActor(task.instance, civAgent, actor)
      end
    end
    felony_feedback.setupFelonyHUD()
    localPlayer.controllerInterface:createCallbacks()
    localPlayer.blockRapidShiftPress = true
    task.instance.taskObjectsByActorID["Tutorial cop 2"].coreData.actor.markerType = "Objective"
  end
  if task.specialName == "cutscene finished - cop" then
    localPlayer:SetZapLevel(1)
    localPlayer:SetZapLevel(0, task.instance.taskObjectsByActorID["Tutorial cop"].coreData.agent, false)
  elseif task.specialName == "End of part 1" then
    localPlayer:clearZapReturnOverride()
    CutsceneFiles.tutorials.playTutorial("ID:234446", 2, createFelon)
    localPlayer:blockAbility("zap", true)
  elseif task.specialName == "rapid shifting 3" then
    localPlayer.missionSupport:setMainTaskObject(task.instance.taskObjectsByActorID["Tutorial actor"])
    createChase()
  elseif task.specialName == "Prompt enter shift" then
    localPlayer:blockAbility("zap", false)
  elseif task.specialName == "In shift" then
    localPlayer.blockRapidShiftPress = false
  elseif task.specialName == "First zap return" then
    localPlayer:blockAbility("zap", true)
    localPlayer.blockRapidShiftPress = true
  elseif task.specialName == "kill evader prompt" then
    feedbackSystem.menusMaster.blockHintButton(false)
    feedbackSystem.removeSlot(2)
    localPlayer:blockAbility("zap", false)
    localPlayer.blockRapidShiftPress = false
    if task.condition == 2 then
      wonChase = true
    end
  elseif task.specialName == "kill evader" then
    if task.condition == 1 then
      wonChase = true
    elseif not wonChase then
      wonChase = false
    end
  elseif task.specialName == "In vehicle" then
    localPlayer:overrideZapReturn(localPlayer.currentVehicle)
  elseif task.specialName == "End mission" then
    if wonChase then
      scoreSystem.willpowerReward(felony_feedback.felonyHUDTable.value, "copChase")
    end
    felony_feedback.endFelony(true)
    localPlayer.challenge.endScreen(taskObject, {callback = completeTask, rating = "PASS"})
  end
end
