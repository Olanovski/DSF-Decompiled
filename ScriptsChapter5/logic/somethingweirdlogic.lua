module("cardSystem.logic")
local TIMER1 = 1
local TIMER2 = 1
local TIMER3 = 0.5
local TIMER4 = 0.25
local MULTIPLIER = 1
missionSetupData["Something weird"] = {}
local function tannerTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Free drive",
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 20}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Initial audio",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
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
        specialName = "Prompt start chase",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        HUD = {
          {
            style = "Something weird hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Prompt bpm level",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 10}
            }
          }
        },
        HUD = {
          {
            style = "Something weird hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Begin scoring",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        HUD = {
          {
            style = "Something weird hud"
          }
        }
      },
      {
        task = "Payload Tracking With Multiplyer",
        specialName = "Chase ambulance",
        coreData = {upper = 200, lower = 155},
        startingValues = {
          payload = 180,
          upMultiplyer = 1,
          downMultiplyer = 1
        },
        goalConditions = {
          {
            autoRefresh = true,
            failCondition = true,
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 1"
                }
              }
            },
            {
              goal = "Within blaze SP",
              params = {multiplier = MULTIPLIER}
            },
            {
              goal = "Time trigger",
              params = {value = TIMER1}
            }
          },
          {
            autoRefresh = true,
            failCondition = true,
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 1"
                }
              }
            },
            {
              goal = "Within blaze SP",
              params = {multiplier = 0, inverse = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 1"
                }
              }
            },
            {
              goal = "Payload under",
              params = {value = 170}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 1"
                }
              }
            },
            {
              goal = "Payload under",
              params = {value = 162}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Payload under",
              params = {value = 179}
            },
            {
              goal = "Within blaze SP",
              params = {multiplier = 0, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 20}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Payload under",
              params = {value = 179}
            },
            {
              goal = "Within blaze SP",
              params = {multiplier = 0, inverse = true}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            {
              goal = "Payload over",
              params = {value = 200}
            }
          },
          {
            {
              goal = "Payload under",
              params = {value = 155}
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
            style = "Something weird hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Target switch",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 1"
                }
              }
            },
            {
              goal = "Within radius of specified actor",
              params = {
                actorID = "Ambulance 1",
                value = 200,
                inverse = true
              }
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 1"
                }
              }
            },
            {
              goal = "Within radius of specified actor",
              params = {
                actorID = "Ambulance 1",
                value = 200,
                inverse = true
              }
            },
            {
              goal = "Losing getaway time trigger",
              params = {value = 10, prompt = "ID:246468"}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Respawn2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 1"
                }
              }
            },
            {
              goal = "Specified actors struck by player",
              params = {
                actorIDs = {
                  "Ambulance 1"
                }
              }
            }
          }
        },
        HUD = {
          {
            style = "Something weird hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Chase 1 zap prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Button Press",
              params = {watchFor = "Pressed", button = "Zap_In"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "No Functionality",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Something weird hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Transition",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 4}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
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
            style = "Something weird hud"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Ghost",
        taskConditions = {
          {
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
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
            style = "Something weird hud"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "SoftSave",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
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
            style = "Something weird hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Prompt start chase 2",
        groupProgression = {importantMinorOrder = false},
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
            style = "Something weird hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Prompt bpm level 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 10}
            }
          }
        },
        HUD = {
          {
            style = "Something weird hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Begin scoring 2",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            },
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Something weird hud"
          }
        }
      },
      {
        task = "Payload Tracking With Multiplyer",
        specialName = "Chase ambulance 2",
        coreData = {upper = 155, lower = 85},
        startingValues = {
          payload = 155,
          upMultiplyer = 1,
          downMultiplyer = 1
        },
        goalConditions = {
          {
            autoRefresh = true,
            failCondition = true,
            {
              goal = "Payload over",
              params = {value = 148}
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 2"
                }
              }
            },
            {
              goal = "Within blaze SP",
              params = {multiplier = MULTIPLIER}
            },
            {
              goal = "Time trigger",
              params = {value = TIMER2}
            }
          },
          {
            autoRefresh = true,
            failCondition = true,
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 2"
                }
              }
            },
            {
              goal = "Within blaze SP",
              params = {multiplier = 0, inverse = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 2"
                }
              }
            },
            {
              goal = "Payload under",
              params = {value = 135}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 2"
                }
              }
            },
            {
              goal = "Payload under",
              params = {value = 115}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 2"
                }
              }
            },
            {
              goal = "Payload under",
              params = {value = 100}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            autoRefresh = true,
            failCondition = true,
            {
              goal = "Payload under",
              params = {value = 147}
            },
            {
              goal = "Payload over",
              params = {value = 117}
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 2"
                }
              }
            },
            {
              goal = "Within blaze SP",
              params = {multiplier = MULTIPLIER}
            },
            {
              goal = "Time trigger",
              params = {value = TIMER3}
            }
          },
          {
            autoRefresh = true,
            failCondition = true,
            {
              goal = "Payload under",
              params = {value = 116}
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 2"
                }
              }
            },
            {
              goal = "Within blaze SP",
              params = {multiplier = MULTIPLIER}
            },
            {
              goal = "Time trigger",
              params = {value = TIMER4}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Payload under",
              params = {value = 154}
            },
            {
              goal = "Within blaze SP",
              params = {multiplier = 0, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 20}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Payload under",
              params = {value = 154}
            },
            {
              goal = "Within blaze SP",
              params = {multiplier = 0, inverse = true}
            },
            {
              goal = "Set payload to specified value",
              params = {same = true}
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            failCondition = true,
            {
              goal = "Payload over",
              params = {value = 200}
            }
          },
          {
            {
              goal = "Payload under",
              params = {value = 85}
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
            style = "Something weird hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Target switch2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 10}
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 2"
                }
              }
            },
            {
              goal = "Within radius of specified actor",
              params = {
                actorID = "Ambulance 2",
                value = 200,
                inverse = true
              }
            }
          }
        },
        taskConditions = {
          {
            failCondition = true,
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 2"
                }
              }
            },
            {
              goal = "Within radius of specified actor",
              params = {
                actorID = "Ambulance 2",
                value = 200,
                inverse = true
              }
            },
            {
              goal = "Losing getaway time trigger",
              params = {value = 10, prompt = "ID:246468"}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Respawn",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {
                  "Ambulance 2"
                }
              }
            },
            {
              goal = "Within radius of specified actor",
              params = {
                value = 5,
                actorID = "Ambulance 2"
              }
            }
          }
        },
        HUD = {
          {
            style = "Something weird hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - Chase 2 zap prompt",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Button Press",
              params = {watchFor = "Pressed", button = "Zap_In"}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Trigger text 2",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 2}
            },
            {
              goal = "Ghost vehicle collision"
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Final timer for iCam",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
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
            style = "Something weird hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Final timer for disappear",
        taskConditions = {
          {
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
            style = "Something weird hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Final timer",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
            },
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2}
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
            style = "Something weird hud"
          }
        }
      }
    }
  }
  return task
end
local ambulanceTask = function(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    {
      {
        task = "Follow Route",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 50}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      }
    },
    {
      {
        task = "Follow Route"
      }
    }
  }
  return task
end
missionSetupData["Something weird"].taskCreatorFunctionLookups = {
  ["Tanner team"] = tannerTask,
  ["Ambulance team"] = ambulanceTask
}
missionSetupData["Something weird"].initiate = function(instance)
  createCheckpoints(instance)
  Sound.OverrideAmbience("Amb_Mis_Frozen_Play")
  localPlayer:blockAbility("zap", true)
  characterManager.FreezePeds()
  instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.speed = 0
  if GhostCar.IsActive() then
    abilities.ghost.stopAbilityFunction()
  end
  civilianTraffic.setTrafficStoppedOnOff(true)
  scoringSystem.EnableOvertaking = false
  Sound.Replace("AmbulanceSiren", "Mis_Frozen_Ambulance_Siren_Play", "Mis_Frozen_Ambulance_Siren_Stop")
  Sound.Replace("Whooshes", "Mis_Frozen_Whooshes_Play", "Mis_Frozen_Whooshes_Stop")
  Sound.TurnOff("CivHorns", true)
  Sound.OverrideEnvironment("AMB_REVERB_FROZEN", 1)
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.speed = 20
    feedbackSystem.menusMaster.setCurrentFocusString(4)
  else
    feedbackSystem.menusMaster.setCurrentFocusString(1)
    feedbackSystem.menusMaster.blockHintButton(true)
  end
  GameVehicleResource.setVehicleOccupantFrozen(instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle, 1, true)
end
missionSetupData["Something weird"].update = nil
local count = 0
local function getTannerDynamicTargets(taskObject, task, dynamicListID)
  if dynamicListID then
    if task.specialName == "Chase ambulance" then
      return {
        task.instance.taskObjectsByActorID["Ambulance 1"].coreData.agent
      }, false
    elseif task.specialName == "Chase ambulance 2" then
      return {
        task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent
      }, false
    elseif task.specialName == "Trigger text 2" then
      if count == 1 then
        return {
          task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent
        }, true
      else
        count = count + 1
        return {
          task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent
        }, false
      end
    end
  elseif task.specialName == "Chase ambulance" then
    return {
      task.instance.taskObjectsByActorID["Ambulance 1"].coreData.agent
    }, false
  elseif task.specialName == "Chase ambulance 2" then
    return {
      task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent
    }, false
  elseif task.specialName == "Trigger text 2" then
    count = 0
    return {
      task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent
    }, false
  end
end
local getAmbulanceDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    if task.actor.ID == "Ambulance 1" then
      task.actor.routeName = "Something weird ambulance"
      task.actor.spawn.route = "Something weird ambulance"
      task.instance.rubberbandRoute = "Something weird ambulance"
    else
      task.actor.routeName = "Something weird ambulance 2"
      task.actor.spawn.route = "Something weird ambulance 2"
      task.instance.rubberbandRoute = "Something weird ambulance 2"
    end
    createCheckpoints(task.instance)
    return false, true
  else
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    return {
      allCheckpoints[#allCheckpoints]
    }, false
  end
end
missionSetupData["Something weird"].targetList = {
  ["Tanner team"] = getTannerDynamicTargets,
  ["Ambulance team"] = getAmbulanceDynamicTargets
}
taskCompleteData["Something weird"] = {}
taskCompleteData["Something weird"].taskComplete = function(taskObject, task)
  if task.success then
    if task.specialName == "Free drive" then
      feedbackSystem.menusMaster.blockHintButton(false)
      engineCutscene.playCutscene("mis_ch5_frozen_01", function()
        task.instance.taskObjectsByActorID.Tanner.coreData.agent:teleportToPositionAndHeading(spawnPositions["Something weird tanner teleport"].position, spawnPositions["Something weird tanner teleport"].heading)
      end, function()
        GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID.Tanner.coreData.agent.position, 30)
        task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.speed = 17.8816
        challengeSystem.spawnActors(task.instance, "Never", {
          ["Ambulance 1"] = true
        })
        GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID["Ambulance 1"].coreData.agent.position, 30)
        task.instance.taskObjectsByActorID["Ambulance 1"].coreData.actor.desiredSpeed = 75
        task.instance.taskObjectsByActorID["Ambulance 1"].coreData.agent.gameVehicle.performance = 1.35
        GameVehicleResource.setVehicleOccupantDraw(task.instance.taskObjectsByActorID["Ambulance 1"].coreData.agent.gameVehicle, 0, false)
        task.instance.taskObjectsByActorID["Ambulance 1"].coreData.agent:set_damageMultiplier(0)
        player.setAttachment(localPlayer.localID, task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle)
      end, nil, 0.2, 0.2)
    elseif task.specialName == "Chase ambulance" then
      local agent = task.instance.taskObjectsByActorID["Ambulance 1"].coreData.agent
      local function removeVehicle()
        task.instance.taskObjectsByActorID["Ambulance 1"]:delete(true)
        localPlayer.currentVehicle:removeFlashColourOverRide()
        OneShotSound.Play("Mis_Frozen_Ambulance_Trail_Stop")
      end
      ZapAIPresence.Settings({
        Height = 5,
        Radius = 0.085,
        TransitionInTime = 0.5,
        Color = vec.vector(40, 40, 40, 1)
      })
      ZapAIPresence.SetCallback({TransitionCallback = removeVehicle})
      ZapAIPresence.StartTransition(nil, task.instance.taskObjectsByActorID["Ambulance 1"].coreData.agent.gameVehicle)
      abilities.ghost.applySettings()
      localPlayer.currentVehicle:removeFlashColourOverRide()
    elseif task.specialName == "Ghost" then
      abilities.ghost.abilityFunction()
      localPlayer.currentVehicle:removeFlashColourOverRide()
    elseif task.specialName == "Transition" then
      task.instance.taskObjectsByActorID.Tanner.coreData.agent:teleportToPositionAndHeading(spawnPositions["Something weird tanner teleport 2"].position, spawnPositions["Something weird tanner teleport 2"].heading)
      task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.speed = 50
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Ambulance 2"] = true
      })
      task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent.gameVehicle.performance = 1.25
      task.instance.taskObjectsByActorID["Ambulance 2"].coreData.actor.desiredSpeed = 75
      GameVehicleResource.setVehicleIsGhost(task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent.gameVehicle, true)
      GameVehicleResource.setVehicleOccupantDraw(task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent.gameVehicle, 0, false)
      task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent:addLightTrail(2, vec.vector(1, 1, 0, 1), 2, true)
      local iCamTable = {
        cameraTargets = {
          task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent.gameVehicle
        },
        duration = 3,
        speed = 0.8,
        framing = "wide",
        angleYaw = "rear quarter"
      }
      iCamActivationTableInput(iCamTable)
    elseif task.specialName == "SoftSave" then
      progressionSystem.triggerSoftSave({progression = 1})
      task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent.gameVehicle.performance = 1.35
      task.instance.taskObjectsByActorID["Ambulance 2"].coreData.actor.desiredSpeed = 75
      GameVehicleResource.setVehicleIsGhost(task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent.gameVehicle, true)
      if not GhostCar.IsActive() then
        abilities.ghost.abilityFunction()
        localPlayer.currentVehicle:removeFlashColourOverRide()
      end
    elseif task.specialName == "Final timer for iCam" then
      local iCamTable = {
        cameraTargets = {
          task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent.gameVehicle
        },
        duration = 3,
        speed = 0.3,
        framing = "wide",
        angleYaw = "rear quarter"
      }
      iCamActivationTableInput(iCamTable)
    elseif task.specialName == "Final timer for disappear" then
      local function removeVehicle()
        task.instance.taskObjectsByActorID["Ambulance 2"]:delete(true)
        moodSystem.removeMood("Something weird", 2)
      end
      ZapAIPresence.Settings({
        Height = 5,
        Radius = 0.085,
        TransitionInTime = 0.5,
        Color = vec.vector(40, 40, 40, 1)
      })
      ZapAIPresence.SetCallback({TransitionCallback = removeVehicle})
      ZapAIPresence.StartTransition(nil, task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent.gameVehicle)
    elseif task.specialName == "Final timer" then
      local function completeTask()
        progressionSystem.challengeComplete(task.instance, task.agent.matrix)
      end
      local params = {
        vehicle = taskObject.coreData.agent,
        cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
        successReason = task.instance.challenge.taskCompleteData["Success reason"],
        failReason = task.instance.challenge.taskCompleteData["Failure reason"],
        inCarCompletion = task.instance.challenge.taskCompleteData["In-car completion"],
        inCarReward = task.instance.challenge.taskCompleteData["In-car reward"],
        passCondition = task.instance.challenge.taskCompleteData["Pass condition"],
        passReward = task.instance.challenge.taskCompleteData["Pass reward"],
        perfectCondition = task.instance.challenge.taskCompleteData["Perfect condition"],
        perfectReward = task.instance.challenge.taskCompleteData["Perfect reward"],
        hint = "ID:236305",
        driverIsTanner = true,
        rating = "PASS",
        callback = completeTask,
        dialogue = "GPMV01_SUCCESS_L_1"
      }
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      localPlayer.challenge.endScreen(taskObject, params)
    end
  else
    local function failTask()
      progressionSystem.challengeFailed(task.instance, task.agent.matrix)
    end
    local params = {
      vehicle = taskObject.coreData.agent,
      musicID = nil,
      failReason = task.instance.challenge.taskCompleteData["Failure reason"],
      rating = "FAIL",
      hint = "ID:236260",
      callback = failTask,
      dialogue = "GPMV01_FAILURE_L_1"
    }
    if GhostCar.IsActive() then
      params.hint = "ID:236305"
    end
    if 1 <= taskObject.coreData.agent.gameVehicle.damage then
      params.failReason = "ID:184950"
      params.reason = "Wrecked"
    elseif task.specialName == "Target switch" or task.specialName == "Target switch2" then
      params.dialogue = "GPMV01_FAILURE_L_2"
      params.failReason = "ID:245613"
      params.reason = "Lost getaway"
    end
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Something weird"] = function(instance)
  localPlayer:blockAbility("zap", false)
  characterManager.UnfreezePeds()
  civilianTraffic.setTrafficStoppedOnOff(false)
  scoringSystem.EnableOvertaking = true
  removeUserUpdateFunction("Respawn")
  removeUserUpdateFunction("allowBPMUpdate")
  ZapAIPresence.SetCallback({TransitionCallback = nil})
  if GhostCar.IsActive() then
    abilities.ghost.stopAbilityFunction()
  end
  instance.challenge.actorPool["Ambulance 1"].routeName = "Drive to loop 1"
  instance.challenge.actorPool["Ambulance 1"].spawn.route = "Drive to loop 1"
  instance.challenge.actorPool["Ambulance 2"].routeName = "Drive to second loop"
  instance.challenge.actorPool["Ambulance 2"].spawn.route = "Drive to second loop"
  OneShotSound.Play("Mis_Frozen_Ambulance_Trail_Stop", false, true)
  Sound.ResetReplace("Whooshes")
  Sound.ResetReplace("AmbulanceSiren")
  Sound.TurnOff("CivHorns", false)
  Sound.RestoreEnvironment()
  Sound.RestoreAmbience()
  GameVehicleResource.setVehicleOccupantFrozen(instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle, 1, false)
end
