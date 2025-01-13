module("cardSystem.logic")
missionSetupData["Bad medicine 2"] = {}
local firstHotspotPosition = vec.vector(996.341, 8.248, 3893.174, 1)
local part1HotspotPosition = vec.vector(85.485, 20.021, 3994.226, 1)
local firstTruckHotspotPosition = vec.vector(343.627, 14.76, 3676.196, 1)
local afterFirstTruckPosition = vec.vector(520.233, 8.234, 3492.548, 1)
local part2HotspotPosition = vec.vector(837.054, 9.011, 3310.525, 1)
local noTruckHotspotPosition = vec.vector(963.066, 8.271, 3668.897, 1)
local lastCratesHotspot = vec.vector(993.598, 8.248, 3675.322, 1)
local lastTruckHotspot = vec.vector(554.57, 8.248, 3609.585, 1)
local tannerTask = function(goalParams, HUD, audio)
  local taskList = {
    {
      {
        task = "Wander",
        specialName = "Initial pause",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine 2 hud"
          }
        }
      }
    },
    {
      {
        task = "Follow Route",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        specialName = "Initial drive",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 20}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
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
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {hideTerrainMarker = true}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        }
      },
      {
        task = "No AI",
        specialName = "First prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine 2 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "First PiP",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 4.5}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Initial drive intermittent chatter",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 4,
            {
              goal = "Is player controlled"
            },
            {
              goal = "Time trigger",
              params = {value = 5}
            },
            {
              goal = "Recent audio played",
              params = {value = 4}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Initial drive zap out",
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
        task = "Follow Route",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        specialName = "Reach the first crates hotspot",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 20}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          },
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
            forceTaskComplete = true,
            {
              goal = "Instance dynamic time above"
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
            style = "Bad medicine 2 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Mission part 2 - First text prompt",
        groupProgression = {importantMinorOrder = false},
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
            style = "Bad medicine 2 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Mission part 2 - Second text prompt",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3}
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine 2 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Smash boxes first audio",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Number of smashed",
              params = {
                propGroup = "FeverPitchProps1",
                value = 1
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Smash boxes 2nd audio",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Number of smashed",
              params = {
                propGroup = "FeverPitchProps1",
                value = 15
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Smash boxes zap out part 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
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
        task = "Follow Route or Non-linear Chase",
        specialName = "Chase part 1",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "No props attached (target)"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            },
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          },
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
            forceTaskComplete = true,
            {
              goal = "Instance dynamic time above"
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
            style = "Bad medicine 2 hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Smash boxes zap out part 2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Smash boxes 3rd audio",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Number of smashed",
              params = {
                propGroup = "FeverPitchProps2",
                value = 3
              }
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Reach hotspot leading to second truck",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 20}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
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
        }
      },
      {
        task = "Follow Route",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        specialName = "Softsave 2",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine 2 hud"
          }
        }
      }
    },
    {
      {
        task = "Follow Route",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        specialName = "Softsave 3",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.1}
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine 2 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Reach the third crates hotspot",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 20}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          },
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
            forceTaskComplete = true,
            {
              goal = "Instance dynamic time above"
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
            style = "Bad medicine 2 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Smash boxes zap out part 3",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Audio - 1 truck down then smash",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Smashed a prop",
              params = {
                propGroup = "FeverPitchProps3"
              }
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Follow Route",
        groupProgression = {importantMinorOrder = false}
      },
      {
        task = "No AI",
        specialName = "Reach the fourth crates hotspot",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 20}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          },
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
            forceTaskComplete = true,
            {
              goal = "Instance dynamic time above"
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
            style = "Bad medicine 2 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Smash boxes zap out part 4",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
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
        task = "Follow Route or Non-linear Chase",
        specialName = "Chase part 2",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "No props attached (target)"
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            },
            {
              goal = "Time trigger",
              params = {value = 3.5}
            }
          },
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
            forceTaskComplete = true,
            {
              goal = "Instance dynamic time above"
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
            style = "Bad medicine 2 hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Smash boxes zap out part 5",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Player zap status has changed",
              params = {transition = "into"}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Smash boxes 4th audio",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Number of smashed",
              params = {
                propGroup = "FeverPitchProps5",
                value = 3
              }
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return taskList
end
local truckTask = function(goalParams, HUD, audio)
  local taskList = {
    deleteTaskObjectOnCompletion = true,
    enableNonPlayerFeedback = true,
    {
      {
        task = "No AI",
        specialName = "Hold position",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Is player controlled",
              params = {target = "Target"}
            },
            {
              goal = "Within radius",
              params = {value = 80}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          },
          {
            failCondition = true,
            {
              goal = "No props attached"
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine 2 hud"
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Follow Route",
        specialName = "Convoy getaway",
        taskConditions = {
          {
            failCondition = true,
            {
              goal = "No props attached"
            }
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        HUD = {
          {
            style = "Bad medicine 2 hud"
          }
        }
      }
    }
  }
  return taskList
end
missionSetupData["Bad medicine 2"].taskCreatorFunctionLookups = {
  ["Race team"] = truckTask,
  ["Chase team"] = tannerTask
}
local secondTruckMarker, lastHotspotMarker, cratesHotspot1, cratesHotspot2, cratesHotspot3, cratesHotspot4
missionSetupData["Bad medicine 2"].initiate = function(instance)
  instance.timeLimit = 30
  instance.truckCount = 0
  secondTruckMarker = nil
  lastHotspotMarker = nil
  lastTruckHotspotMarker = nil
  cratesHotspot1 = nil
  cratesHotspot2 = nil
  cratesHotspot3 = nil
  cratesHotspot4 = nil
  createFixedPosition(instance, {firstHotspotPosition}, 91)
  createFixedPosition(instance, {part1HotspotPosition}, 95)
  createFixedPosition(instance, {firstTruckHotspotPosition}, 94)
  createFixedPosition(instance, {afterFirstTruckPosition}, 97)
  createFixedPosition(instance, {part2HotspotPosition}, 93)
  createFixedPosition(instance, {noTruckHotspotPosition}, 92)
  createFixedPosition(instance, {lastCratesHotspot}, 90)
  createFixedPosition(instance, {lastTruckHotspot}, 89)
  createCheckpoints(instance)
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    feedbackSystem.startMusic("Uid02835_CH07_Standard_FeverPitch_Play")
    if softSaveData.progression == 2 then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245296")
      secondTruckMarker = feedbackSystem.newTarget({position = afterFirstTruckPosition}, "Hotspot", {hideTerrainMarker = true})
      feedbackSystem.menusMaster.setCurrentFocusString(4)
      instance.truckCount = 1
    elseif softSaveData.progression == 3 then
      propSystem.setupRuntimeProps("FeverPitchProps3", true, true)
      cratesHotspot3 = feedbackSystem.newTarget({position = part2HotspotPosition}, "Hotspot", {hideTerrainMarker = true})
      instance.softsaveStartTime = g_NetworkTime - 3
      feedbackSystem.menusMaster.setCurrentFocusString(2)
      instance.truckCount = 1
    end
  else
    GameVehicleResource.ClearAreaOfVehicles(instance.taskObjectsByActorID["Attacker1 (Actor)"].coreData.agent.position, 60)
  end
end
missionSetupData["Bad medicine 2"].update = nil
local getTruckTeamDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    return false, true
  else
    local teams = {}
    for actorID, taskObject in next, taskObject.coreData.instance.taskObjectsByActorID, nil do
      teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
      table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
    end
    return teams["Chase team"], false
  end
end
local getTannerTeamDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "Initial drive" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 91), false
    end
  elseif task.specialName == "Reach the first crates hotspot" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 95), false
    end
  elseif task.specialName == "Chase part 1" then
    if dynamicListID then
      return false, true
    else
      local rtpropIDs = rtpropIDs or {}
      local teams = {}
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == "Race team" then
          rtpropIDs = rtpropIDs or {}
          rtpropIDs[actorID] = PropSystem.CreateRuntimeProps({
            {
              modelUID = "0x2A26F71898721240",
              position = vec.vector(0.3, 0.83, -1.625, 1),
              zaxis = vec.vector(-1, 0, 0, 0),
              movementLimits = vec.vector(0, 0.1, 0, 0),
              attachVehicle = taskObject.coreData.agent.gameVehicle
            }
          })
        end
        teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
        table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
      end
      return teams["Race team"], false
    end
  elseif task.specialName == "Reach hotspot leading to second truck" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 97), false
    end
  elseif task.specialName == "Reach the third crates hotspot" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 93), false
    end
  elseif task.specialName == "Reach the fourth crates hotspot" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 92), false
    end
  elseif task.specialName == "Chase part 2" then
    if dynamicListID then
      return false, true
    else
      local rtpropIDs = rtpropIDs or {}
      local teams = {}
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.team == "Race team" then
          rtpropIDs = rtpropIDs or {}
          rtpropIDs[actorID] = PropSystem.CreateRuntimeProps({
            {
              modelUID = "0x2A26F71898721240",
              position = vec.vector(0.3, 0.83, -1.625, 1),
              zaxis = vec.vector(-1, 0, 0, 0),
              movementLimits = vec.vector(0, 0.1, 0, 0),
              attachVehicle = taskObject.coreData.agent.gameVehicle
            }
          })
        end
        teams[taskObject.coreData.actor.team] = teams[taskObject.coreData.actor.team] or {}
        table.insert(teams[taskObject.coreData.actor.team], taskObject.coreData.agent)
      end
      return teams["Race team"], false
    end
  end
end
missionSetupData["Bad medicine 2"].targetList = {
  ["Race team"] = getTruckTeamDynamicTargets,
  ["Chase team"] = getTannerTeamDynamicTargets
}
missionEndCallback["Bad medicine 2"] = function(instance)
  propSystem.cleanupRuntimeProps("FeverPitchProps1")
  propSystem.cleanupRuntimeProps("FeverPitchProps2")
  propSystem.cleanupRuntimeProps("FeverPitchProps3")
  propSystem.cleanupRuntimeProps("FeverPitchProps4")
  propSystem.cleanupRuntimeProps("FeverPitchProps5")
  if secondTruckMarker then
    feedbackSystem.clearTarget(secondTruckMarker)
    secondTruckMarker = nil
  end
  if cratesHotspot1 then
    feedbackSystem.clearTarget(cratesHotspot1)
    cratesHotspot1 = nil
  end
  if cratesHotspot2 then
    feedbackSystem.clearTarget(cratesHotspot2)
    cratesHotspot2 = nil
  end
  if cratesHotspot3 then
    feedbackSystem.clearTarget(cratesHotspot3)
    cratesHotspot3 = nil
  end
  if cratesHotspot4 then
    feedbackSystem.clearTarget(cratesHotspot4)
    cratesHotspot4 = nil
  end
  if lastHotspotMarker then
    feedbackSystem.clearTarget(lastHotspotMarker)
    lastHotspotMarker = nil
  end
  if lastTruckHotspotMarker then
    feedbackSystem.clearTarget(lastTruckHotspotMarker)
    lastTruckHotspotMarker = nil
  end
  removeUserUpdateFunction("propWatch")
end
taskCompleteData["Bad medicine 2"] = {}
taskCompleteData["Bad medicine 2"].taskComplete = function(taskObject, task)
  local params = {
    driverIsTanner = true,
    vehicle = taskObject.coreData.agent,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235485",
    hintIcon1 = localPlayer.buttonLayout.minimapZoom
  }
  local function completeTask()
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.success then
    if task.specialName == "Initial drive" then
      progressionSystem.triggerSoftSave({progression = 1})
      task.instance.softsaveStartTime = g_NetworkTime - 3
      propSystem.setupRuntimeProps("FeverPitchProps1", true, true)
      OneShotSound.Play("HUD_Play_Waypoint")
      feedbackSystem.startMusic("Uid02835_CH07_Standard_FeverPitch_Play")
      if not taskObject.coreData.agent.controlled then
        if localPlayer.inZap then
          localPlayer:SetZapLevel(0, taskObject.coreData.agent, false)
        else
          localPlayer:zapToAgent(taskObject.coreData.agent)
        end
      end
      cratesHotspot1 = feedbackSystem.newTarget({position = part1HotspotPosition}, "Hotspot", {hideTerrainMarker = true})
      feedbackSystem.menusMaster.setCurrentFocusString(2)
    elseif task.specialName == "Reach the first crates hotspot" then
      OneShotSound.Play("HUD_Play_Waypoint")
      feedbackSystem.clearTarget(cratesHotspot1)
      cratesHotspot1 = nil
      cratesHotspot2 = feedbackSystem.newTarget({position = firstTruckHotspotPosition}, "Hotspot", {hideTerrainMarker = true})
      propSystem.setupRuntimeProps("FeverPitchProps2", true, true)
      challengeSystem.spawnActors(task.instance, "Never", {Convoy2 = true})
      task.instance.taskObjectsByActorID.Convoy2.coreData.agent.iconsVisible = false
      GameVehicleResource.setInfiniteMass(task.instance.taskObjectsByActorID.Convoy2.coreData.agent.gameVehicle, true)
      task.instance.taskObjectsByActorID.Convoy2.coreData.agent:set_damageMultiplier(0)
    elseif task.specialName == "Softsave 2" then
      progressionSystem.triggerSoftSave({progression = 2})
    elseif task.specialName == "Reach hotspot leading to second truck" then
      OneShotSound.Play("HUD_Play_Waypoint")
      feedbackSystem.clearTarget(secondTruckMarker)
      secondTruckMarker = nil
      cratesHotspot3 = feedbackSystem.newTarget({position = part2HotspotPosition}, "Hotspot", {hideTerrainMarker = true})
      task.instance.softsaveStartTime = g_NetworkTime - 3
      feedbackSystem.menusMaster.setCurrentFocusString(2)
      propSystem.setupRuntimeProps("FeverPitchProps3", true, true)
    elseif task.specialName == "Softsave 3" then
      progressionSystem.triggerSoftSave({progression = 3})
    elseif task.specialName == "Reach the third crates hotspot" then
      OneShotSound.Play("HUD_Play_Waypoint")
      feedbackSystem.clearTarget(cratesHotspot3)
      cratesHotspot3 = nil
      cratesHotspot4 = feedbackSystem.newTarget({position = noTruckHotspotPosition}, "Hotspot", {hideTerrainMarker = true})
      propSystem.setupRuntimeProps("FeverPitchProps4", true, true)
    elseif task.specialName == "Reach the fourth crates hotspot" then
      OneShotSound.Play("HUD_Play_Waypoint")
      feedbackSystem.clearTarget(cratesHotspot4)
      cratesHotspot4 = nil
      lastTruckHotspotMarker = feedbackSystem.newTarget({position = lastTruckHotspot}, "Hotspot", {hideTerrainMarker = true})
      challengeSystem.spawnActors(task.instance, "Never", {Convoy4 = true})
      task.instance.taskObjectsByActorID.Convoy4.coreData.agent.iconsVisible = false
      GameVehicleResource.setInfiniteMass(task.instance.taskObjectsByActorID.Convoy4.coreData.agent.gameVehicle, true)
      task.instance.taskObjectsByActorID.Convoy4.coreData.agent:set_damageMultiplier(0)
      propSystem.setupRuntimeProps("FeverPitchProps5", true, true)
    elseif task.specialName == "Chase part 2" then
      feedbackSystem.taskSuccessAudio()
      params.dialogue = "GPMV01_SUCCESS_L_1"
      params.callback = completeTask
      params.rating = "PASS"
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "Hold position" then
      if taskObject == task.instance.taskObjectsByActorID.Convoy2 then
        GameVehicleResource.setInfiniteMass(taskObject.coreData.agent.gameVehicle, false)
        taskObject.coreData.agent:set_damageMultiplier(1)
        feedbackSystem.clearTarget(cratesHotspot2)
        cratesHotspot2 = nil
      elseif taskObject == task.instance.taskObjectsByActorID.Convoy4 then
        GameVehicleResource.setInfiniteMass(taskObject.coreData.agent.gameVehicle, false)
        taskObject.coreData.agent:set_damageMultiplier(1)
        feedbackSystem.clearTarget(lastTruckHotspotMarker)
        lastTruckHotspotMarker = nil
      end
    end
  elseif task.specialName == "Initial drive" or task.specialName == "Reach hotspot leading to second truck" then
    params.hint = "ID:235485"
    params.rating = "FAIL"
    params.failReason = "ID:182731"
    params.reason = "Wrecked"
    params.dialogue = "GPMV01_FAILURE_L_1"
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "Reach the first crates hotspot" or task.specialName == "Chase part 1" or task.specialName == "Reach the third crates hotspot" or task.specialName == "Reach the fourth crates hotspot" or task.specialName == "Chase part 2" then
    if task.condition == 2 then
      params.failReason = "ID:182731"
      params.reason = "Wrecked"
    elseif task.condition == 3 then
      params.failReason = "ID:184828"
    end
    params.hint = "ID:235496"
    if task.specialName == "Chase part 1" and not cratesHotspot2 or task.specialName == "Chase part 2" and not lastTruckHotspotMarker then
      params.hint = "ID:247312"
    end
    params.rating = "FAIL"
    params.dialogue = "GPMV01_FAILURE_L_1"
    params.callback = failTask
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "Convoy getaway" then
    if 1 > taskObject.coreData.agent.gameVehicle.damage then
      GameVehicleResource.applyDamage({
        gameVehicle = taskObject.coreData.agent.gameVehicle,
        damage = 1
      })
    end
    local iCamCallback
    if task.instance.truckCount == 1 then
      function iCamCallback()
        feedbackSystem.menusMaster.primaryTextPrompt("ID:247305")
        secondTruckMarker = feedbackSystem.newTarget({position = afterFirstTruckPosition}, "Hotspot", {hideTerrainMarker = true})
        feedbackSystem.menusMaster.setCurrentFocusString(4)
      end
    end
    iCamCrashCam(taskObject.coreData.agent.gameVehicle, iCamCallback)
  elseif task.specialName == "Hold position" then
    if taskObject == task.instance.taskObjectsByActorID.Convoy2 then
      feedbackSystem.clearTarget(cratesHotspot2)
      cratesHotspot2 = nil
    elseif taskObject == task.instance.taskObjectsByActorID.Convoy4 then
      feedbackSystem.clearTarget(lastTruckHotspotMarker)
      lastTruckHotspotMarker = nil
    end
  end
end
