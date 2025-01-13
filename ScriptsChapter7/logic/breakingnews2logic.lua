module("cardSystem.logic")
missionSetupData["Breaking news 2"] = {}
local playerTask = function(goalParams, HUD, audio)
  local targetDisplaySpeed1, speedToHit1 = feedbackSystem.mphToLocalisedSpeed(goalParams["Speed above"])
  local targetDisplaySpeed2, speedToHit2 = feedbackSystem.mphToLocalisedSpeed(100)
  local offsetToVehicle = vec.vector(0, 0, 40, 1)
  local offsetForHotspot = vec.vector(0, -5, 40, 0)
  local hotspotHeight = 40
  local hotspotRadius = 30
  local distanceToHideHotspot = 100
  local task = {
    {
      {
        task = "Wander",
        specialName = "Zap out",
        taskConditions = {
          {
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
        audioPIP = audio,
        HUD = {
          {
            style = "Breaking news 2 hud"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Wait For Zap",
        taskConditions = {
          {
            {
              goal = "Vehicles zapped into",
              params = {value = 1}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Wait For Stunt Prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            }
          }
        },
        targetManagers = {
          {
            manager = "Self",
            settings = {
              alwaysOn = true,
              styles = {
                ["Radius with hotspot"] = {
                  offset = offsetForHotspot,
                  radius = hotspotRadius,
                  distanceToHideHotspot = distanceToHideHotspot,
                  height = hotspotHeight
                }
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Breaking news 2 hud"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Wait to display drift prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            }
          }
        },
        targetManagers = {
          {
            manager = "Self",
            settings = {
              alwaysOn = true,
              styles = {
                ["Radius with hotspot"] = {
                  offset = offsetForHotspot,
                  radius = hotspotRadius,
                  distanceToHideHotspot = distanceToHideHotspot,
                  height = hotspotHeight
                }
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Breaking news 2 hud"
          }
        }
      }
    },
    {
      {
        task = "Wander",
        specialName = "Drifted",
        dynamicTargets = true,
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 15}
            },
            {
              goal = "Is drifting",
              params = {inverse = true}
            },
            {
              goal = "Prompt active",
              params = {
                promptType = "StuntPrompt",
                inverse = true
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Agent within then outside radius of target",
              params = {value = 200, player = true}
            }
          },
          {
            {
              goal = "Is drifting"
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Time trigger",
              params = {
                value = goalParams["Time Limit"]
              }
            }
          },
          {
            forceTaskComplete = true,
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
            {goal = "Got busted"}
          },
          {
            {
              goal = "Player vehicle within radius in front of agent",
              params = {value = hotspotRadius, offset = offsetToVehicle},
              feedback = "Drift distance"
            },
            {
              goal = "Is drifting",
              params = {value = 30},
              feedback = "Drifting"
            }
          }
        },
        targetManagers = {
          {
            manager = "Self",
            settings = {
              alwaysOn = true,
              styles = {
                ["Radius with hotspot"] = {
                  offset = offsetForHotspot,
                  radius = hotspotRadius,
                  distanceToHideHotspot = distanceToHideHotspot,
                  height = hotspotHeight
                }
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Breaking news 2 hud",
            settings = {amountToDrift = 30}
          }
        }
      },
      {
        task = "No AI",
        specialName = "Drift zap out",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 2,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Wait to display smash prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2.5}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
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
            style = "Breaking news 2 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Oncoming complete audio",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Smash oncoming",
        dynamicTargets = true,
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 15}
            },
            {
              goal = "Prompt active",
              params = {
                promptType = "StuntPrompt",
                inverse = true
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Agent within then outside radius of target",
              params = {value = 200, player = true}
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Time trigger",
              params = {
                value = goalParams["Time Limit"]
              }
            }
          },
          {
            forceTaskComplete = true,
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
            {goal = "Got busted"}
          },
          {
            {
              goal = "Player vehicle within radius in front of agent",
              params = {value = hotspotRadius, offset = offsetToVehicle}
            },
            {
              goal = "Simple collision check",
              params = {
                force = 5000,
                type = "Vehicle",
                whereIHit = "Front",
                whereIWasHit = "Front",
                setOnPlayer = true
              },
              feedback = "Vehicle"
            }
          }
        },
        targetManagers = {
          {
            manager = "Self",
            settings = {
              alwaysOn = true,
              styles = {
                ["Radius with hotspot"] = {
                  offset = offsetForHotspot,
                  radius = hotspotRadius,
                  distanceToHideHotspot = distanceToHideHotspot,
                  height = hotspotHeight
                }
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Breaking news 2 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Smash zap out",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 2,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Wait to display speed prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2.5}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
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
            style = "Breaking news 2 hud",
            settings = {speedToHit = speedToHit1, targetDisplaySpeed = targetDisplaySpeed1}
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Drift complete audio",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Sped",
        dynamicTargets = true,
        goalConditions = {
          {
            skipTargetUpdate = true,
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 15}
            },
            {
              goal = "Prompt active",
              params = {
                promptType = "StuntPrompt",
                inverse = true
              }
            }
          },
          {
            skipTargetUpdate = true,
            autoRefresh = true,
            {
              goal = "Agent within then outside radius of target",
              params = {value = 200, player = true}
            }
          },
          {
            {
              goal = "Player vehicle within radius in front of agent",
              params = {value = hotspotRadius, offset = offsetToVehicle},
              feedback = "Radius"
            },
            {
              goal = "Player above speed",
              params = {value = speedToHit1, displayed = true}
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Time trigger",
              params = {
                value = goalParams["Time Limit"]
              }
            }
          },
          {
            forceTaskComplete = true,
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
            {goal = "Got busted"}
          },
          {
            {
              goal = "Player vehicle within radius in front of agent",
              params = {value = hotspotRadius, offset = offsetToVehicle}
            },
            {
              goal = "Player above speed",
              params = {value = speedToHit1, displayed = true}
            }
          }
        },
        targetManagers = {
          {
            manager = "Self",
            settings = {
              alwaysOn = true,
              styles = {
                ["Radius with hotspot"] = {
                  offset = offsetForHotspot,
                  radius = hotspotRadius,
                  distanceToHideHotspot = distanceToHideHotspot,
                  height = hotspotHeight
                }
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Breaking news 2 hud",
            settings = {speedToHit = speedToHit1, targetDisplaySpeed = targetDisplaySpeed1}
          }
        }
      },
      {
        task = "No AI",
        specialName = "Speed zap out",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 2,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Wait to display oncoming prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2.5}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
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
            style = "Breaking news 2 hud",
            settings = {speedToHit = speedToHit2, targetDisplaySpeed = targetDisplaySpeed2}
          }
        }
      },
      {
        task = "No AI",
        specialName = "Cop complete audio",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Sped oncoming",
        dynamicTargets = true,
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 15}
            },
            {
              goal = "Prompt active",
              params = {
                promptType = "StuntPrompt",
                inverse = true
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Agent within then outside radius of target",
              params = {value = 200, player = true}
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Time trigger",
              params = {
                value = goalParams["Time Limit"]
              }
            }
          },
          {
            forceTaskComplete = true,
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
            {goal = "Got busted"}
          },
          {
            {
              goal = "Player vehicle within radius in front of agent",
              params = {
                value = hotspotRadius,
                offset = offsetToVehicle,
                timedValue = 0.5
              },
              feedback = "Radius"
            },
            {
              goal = "Against traffic flow",
              feedback = "Oncoming"
            },
            {
              goal = "Player above speed",
              params = {value = speedToHit2, displayed = true}
            }
          }
        },
        targetManagers = {
          {
            manager = "Self",
            settings = {
              alwaysOn = true,
              styles = {
                ["Radius with hotspot"] = {
                  offset = offsetForHotspot,
                  radius = hotspotRadius,
                  distanceToHideHotspot = distanceToHideHotspot,
                  height = hotspotHeight
                }
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Breaking news 2 hud",
            settings = {speedToHit = speedToHit2, targetDisplaySpeed = targetDisplaySpeed2}
          }
        }
      },
      {
        task = "No AI",
        specialName = "Oncoming zap out",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 2,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Wait to display cop prompt",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2.5}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
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
            style = "Breaking news 2 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Speed complete audio",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "In felony",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player in zap",
              params = {inverse = true}
            },
            {
              goal = "Player in getaway vehicle"
            }
          }
        },
        HUD = {
          {
            style = "Breaking news 2 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Lost felony",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Getaway escaped"
            }
          },
          {
            {
              goal = "Has been chased",
              params = {usePlayer = true}
            },
            {
              goal = "Is a felony active",
              params = {inverse = true}
            }
          },
          {
            {
              goal = "Getaway damage above",
              params = {value = 1}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Is a felony active",
              params = {inverse = true}
            }
          }
        },
        HUD = {
          {
            style = "Breaking news 2 hud"
          }
        }
      },
      {
        task = "Wander",
        specialName = "Hit cop",
        dynamicTargets = true,
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 15}
            },
            {
              goal = "Prompt active",
              params = {
                promptType = "StuntPrompt",
                inverse = true
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Agent within then outside radius of target",
              params = {value = 200, player = true}
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Time trigger",
              params = {value = 60}
            }
          },
          {
            forceTaskComplete = true,
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
            {goal = "Got busted"}
          },
          {
            {
              goal = "Player vehicle within radius in front of agent",
              params = {value = hotspotRadius, offset = offsetToVehicle}
            },
            {
              goal = "Player in zap",
              params = {inverse = true}
            },
            {
              goal = "Being chased",
              params = {
                usePlayer = true,
                numberOfChasers = 2,
                NumberOfChasersShownOnTheHud = true
              }
            }
          }
        },
        targetManagers = {
          {
            manager = "Self",
            settings = {
              alwaysOn = true,
              styles = {
                ["Radius with hotspot"] = {
                  offset = offsetForHotspot,
                  radius = hotspotRadius,
                  distanceToHideHotspot = distanceToHideHotspot,
                  height = hotspotHeight
                }
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {
            style = "Breaking news 2 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Cop zap out",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 2,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            },
            {
              goal = "Is a felony active",
              params = {inverse = true}
            }
          },
          {
            autoRefresh = true,
            triggerCount = 2,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            },
            {
              goal = "Is a felony active"
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "Wait for end",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {
                value = goalParams["Damage amount for fail"] or 1
              }
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "Smash complete audio",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
missionSetupData["Breaking news 2"].taskCreatorFunctionLookups = {
  ["Van team"] = playerTask
}
local PlayerChangedVehicle = false
local playerStartVehicle
missionSetupData["Breaking news 2"].initiate = function(instance)
  localPlayer.feloniesBlocked = true
  feedbackSystem.menusMaster.blockHintButton(true)
  instance.taskObjectsByActorID["Van 1 Actor"].coreData.agent.blockTow = true
  local targetDisplaySpeed1Text, speedToHit1Text = feedbackSystem.mphToLocalisedSpeed(150)
  local targetDisplaySpeed2Text, speedToHit2Text = feedbackSystem.mphToLocalisedSpeed(100)
  local focusText = {
    ["ID:243579"] = {
      [1] = targetDisplaySpeed1Text
    },
    ["ID:221802"] = {
      [1] = targetDisplaySpeed2Text
    }
  }
  feedbackSystem.menusMaster.setFocusButtonText(focusText)
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    instance.taskObjectsByActorID["Van 1 Actor"].coreData.actor.onRestart = true
    localPlayer:SetZapLevel(1)
  end
  zapcontroller.AddLockedVehicle({
    gameVehicle = instance.taskObjectsByActorID["Van 1 Actor"].coreData.agent.gameVehicle
  })
  localPlayer:blockAbility("zapReturn", true)
  InterestingVehicleManager.Enable(false)
end
missionSetupData["Breaking news 2"].update = nil
taskCompleteData["Breaking news 2"] = {}
taskCompleteData["Breaking news 2"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID["Van 1 Actor"].coreData.agent,
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    passCondition = task.instance.challenge.taskCompleteData["Pass condition"],
    perfectCondition = task.instance.challenge.taskCompleteData["Perfect condition"],
    hint = "ID:235492",
    hintIcon1 = localPlayer.buttonLayout.handbrake
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.success then
    if task.specialName == "Drifted" then
      playerStartVehicle = localPlayer.currentVehicle
      playerStartGameVehicle = playerStartVehicle.gameVehicle
      playerStartVehicle:set_damageMultiplier(0.5)
    elseif task.specialName == "Smash oncoming" or task.specialName == "Sped" or task.specialName == "Sped oncoming" or task.specialName == "Hit cop" then
      if localPlayer.currentVehicle.gameVehicle ~= playerStartGameVehicle then
        PlayerChangedVehicle = true
      end
    elseif task.specialName == "Zap out" then
      zapcontroller.AddLockedVehicle({
        gameVehicle = task.agent.gameVehicle
      })
      localPlayer:blockAbility("zapReturn", true)
      localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
    elseif task.specialName == "Wait for end" then
      params.driverIsTanner = true
      params.dialogue = "GPMV01_SUCCESS_L_1"
      params.callback = completeTask
      if not PlayerChangedVehicle then
        params.rating = "PERFECT"
      else
        params.rating = "PASS"
      end
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "Wait to display smash prompt" then
      progressionSystem.triggerSoftSave({progression = 1})
    elseif task.specialName == "Wait to display speed prompt" then
      progressionSystem.triggerSoftSave({progression = 2})
    elseif task.specialName == "Wait to display oncoming prompt" then
      progressionSystem.triggerSoftSave({progression = 3})
    elseif task.specialName == "Wait to display cop prompt" then
      progressionSystem.triggerSoftSave({progression = 4})
    end
  else
    if task.condition == 1 then
      params.dialogue = "GPMV00_FAILURE_L_1"
      params.failReason = "ID:184828"
    elseif task.condition == 2 then
      params.dialogue = "GPMV01_FAILURE_L_1"
      params.failReason = "ID:184950"
      params.reason = "Wrecked"
    else
      params.dialogue = "GPMV00_FAILURE_L_1"
      params.failReason = "ID:186264"
    end
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
local getVehicleDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    return false, true
  else
    local teams = {}
    for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
      teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
      table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
    end
    return teams["Van team"], false
  end
end
missionSetupData["Breaking news 2"].targetList = {
  ["Van team"] = getVehicleDynamicTargets
}
missionEndCallback["Breaking news 2"] = function(instance)
  localPlayer.feloniesBlocked = nil
  Sound.EnableScoring("drift", false)
  localPlayer:blockAbility("zapReturn", false)
  InterestingVehicleManager.Enable(true)
  PlayerChangedVehicle = false
  feedbackSystem.menusMaster.masterSetVariable("iTV_Cam", 0)
  PatrollingVehicleManager.EnableHud(true)
end
