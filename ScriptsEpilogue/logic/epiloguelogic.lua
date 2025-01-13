module("cardSystem.logic")
missionSetupData.Epilogue = {}
local roundTheBackOfTheInitialDriveToLocation = vec.vector(900.7158, 28.16781, 2045.921, 1)
local function tannerTask(goalParams, HUD, audio)
  local taskList = {
    {
      {
        task = "No AI Linear Checkpoints",
        specialName = "Initial drive",
        dynamicTargets = true,
        groupProgression = {priorityMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 25}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
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
            {
              goal = "Player within radius of point",
              params = {value = 25, position = roundTheBackOfTheInitialDriveToLocation}
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
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Trigger dialogue and events",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 2900}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 2500}
            },
            {
              goal = "Time trigger",
              params = {value = 0.75}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Within radius",
              params = {value = 1800}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Event active"
            },
            {
              goal = "Within radius",
              params = {value = 1800}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            {
              goal = "Within radius",
              params = {value = 1250}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Button press",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
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
        specialName = "In tanner",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            },
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
        task = "No AI Linear Checkpoints",
        specialName = "Hospital drive",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 25}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 150}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
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
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Convicts sample",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 150}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Within radius",
              params = {value = 350}
            },
            {
              goal = "Time trigger",
              params = {value = 0.2}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Horns and alarms",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Agent on highway",
              params = {inverse = true}
            }
          },
          {
            {
              goal = "Agent on highway"
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return taskList
end
local civTask = function(goalParams, HUD, audio)
  local taskList = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Follow Route",
        specialName = "Civ",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 20}
            }
          }
        }
      }
    }
  }
  return taskList
end
local stationaryTask = function(goalParams, HUD, audio)
  local taskList = {
    {
      {task = "No AI"}
    }
  }
  return taskList
end
local convoyTask = function(goalParams, HUD, audio)
  local taskList = {
    {
      {
        task = "Follow Route"
      }
    }
  }
  return taskList
end
missionSetupData.Epilogue.taskCreatorFunctionLookups = {
  ["Tanner team"] = tannerTask,
  ["Civ team"] = civTask,
  ["Roadblock team"] = stationaryTask,
  ["Convoy team"] = convoyTask
}
local prompts = {
  ["Get to prison"] = "ID:236468"
}
local showText = function(text)
  feedbackSystem.menusMaster.primaryTextPrompt(text, nil, true, false, false)
end
local initialDriveToLocation = vec.vector(1158.271, 28.9279, 1811.735, 1)
local secondDriveToLocation = vec.vector(984.2056, 6.126711, 1501.993, 1)
local convictsPrisonBreakSampleTrigger = vec.vector(600.5038, 6.217623, 1485.286, 1)
local audioAlarmPos = {
  vec.vector(906.455, 19.61, 1789.52, 1),
  vec.vector(604.363, 7.275, 1548.83, 1),
  vec.vector(356.355, 19.34, 1669.81, 1),
  vec.vector(853.869, 7.325, 1322, 1),
  vec.vector(164.768, 31.12, 1674.93, 1),
  [9] = vec.vector(440.597, 19.99, 1777.81, 1)
}
local audioAlarmVel = vec.vector(0, 0, 0, 0)
local audioAlarmDir = vec.vector(1, 0, 0, 0)
local audioAlarmPlayIds = {}
function missionSetupData.Epilogue.initiate(instance)
  Sound.LoadMission(cards.Missions[instance.challenge.name].MissionID)
  Orphanage.allowCarrierChasing(false)
  createFixedPosition(instance, {initialDriveToLocation}, 100)
  createFixedPosition(instance, {secondDriveToLocation}, 101)
  createFixedPosition(instance, {convictsPrisonBreakSampleTrigger}, 102)
  localPlayer.controllerInterface:createCallbacks()
  createCheckpoints(instance)
  characterManager.DisablePeds()
  showText(prompts["Get to prison"])
  feedbackSystem.menusMaster.setFocusButtonText()
  timer = g_NetworkTime
  localPlayer.currentVehicle.gameVehicle.speed = 22.35
  Commentary.SetTannerInMission(true)
  Commentary.ForceEventChange()
  GameVehicleResource.setHornActivation(true)
  removeUserUpdateFunction("Turn traffic")
  civilianTraffic.addStoppedTrafficLaneTrackExclusionsForRoad("superhighway_split_02 AI Road 0")
  civilianTraffic.setTrafficAbandonedOnOff(true)
  scoringSystem.EnableOvertaking = false
  characterManager.EnableEscapedConvicts()
  characterManager.EnablePeds()
  characterManager.SetPedestrianDensityMultiplier(0.25)
  feedbackSystem.menusMaster.focusHintButtonState(true)
  feedbackSystem.menusMaster.setFocusButtonText()
end
missionSetupData.Epilogue.update = nil
local getTannerTeamDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Initial drive" or task.specialName == "Trigger dialogue and events" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 100), false
    end
  elseif task.specialName == "Hospital drive" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 101), false
    end
  elseif task.specialName == "Convicts sample" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 102), false
    end
  end
end
missionSetupData.Epilogue.targetList = {
  ["Tanner team"] = getTannerTeamDynamicTargets,
  ["Civ team"] = getCivTeamDynamicTargets
}
local params
local function setUpParams(task)
  params = {
    vehicle = cameraShotVehicle or localPlayer.currentVehicle,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    passCondition = task.instance.challenge.taskCompleteData["Pass condition"],
    passReward = task.instance.challenge.taskCompleteData["Pass reward"]
  }
end
function missionSetupData.Epilogue.goalComplete(taskObject, task, conditionKey)
  if task.specialName == "Trigger dialogue and events" then
    if conditionKey == 2 then
      challengeSystem.spawnActors(task.instance, "Never", {
        ["Convoy 1"] = true,
        ["Convoy 2"] = true
      })
    elseif conditionKey == 3 then
      local function _trafficSearch()
        local vehicleSearchParameters = {
          ignoreSciptOwnedVehicles = true,
          ignoreOrphans = true,
          ignoreCops = true,
          scoring = {
            ahead = {condition = true, discard = true},
            inLane = {lane = "outside", discard = true},
            proximity = true
          }
        }
        local vehicleList = {}
        local gameVehicle
        local offset = vec.vector(0, 0, 200, 0)
        local playerPosition, playerHeading, position, roadIndex, distanceAlong, positionOnRoad
        return function()
          if not task.instance.taskObjectsByActorID.Impatient or not task.instance.taskObjectsByActorID.Impatient2 or not task.instance.taskObjectsByActorID.Impatient3 then
            if localPlayer.currentVehicle and localPlayer.currentVehicle:get_withTrafficFlow() then
              playerPosition = localPlayer.currentVehicle.position
              playerHeading = localPlayer.currentVehicle.heading
              position = playerPosition:clone()
              position.x = playerPosition.x + offset.x * math.cos(playerHeading) + offset.z * math.sin(playerHeading)
              position.z = playerPosition.z + offset.z * math.cos(playerHeading) - offset.x * math.sin(playerHeading)
              roadIndex, distanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(position)
              positionOnRoad = Atlas.RoadPositionAtDistanceAlong(roadIndex, distanceAlong)
              vehicleList = vehicleManager.findVehiclesInTraffic(positionOnRoad, task.instance.taskObjectsByActorID.Tanner.coreData.agent.matrix[2], 50, vehicleSearchParameters, 1)
              gameVehicle = vehicleList[1]
              if gameVehicle then
                if not SNV.getSNVFromGameVehicle(gameVehicle) then
                  SNV.CreateSNVFromGV(gameVehicle)
                end
                local civAgent = vehicleManager.registerVehicle({gameVehicle = gameVehicle})
                if not task.instance.taskObjectsByActorID.Impatient then
                  local actor = task.instance.challenge.actorPool.Impatient
                  challengeSystem.createActor(task.instance, civAgent, actor)
                elseif not task.instance.taskObjectsByActorID.Impatient2 then
                  local actor = task.instance.challenge.actorPool.Impatient2
                  challengeSystem.createActor(task.instance, civAgent, actor)
                elseif not task.instance.taskObjectsByActorID.Impatient3 then
                  local actor = task.instance.challenge.actorPool.Impatient3
                  challengeSystem.createActor(task.instance, civAgent, actor)
                end
              end
            end
          elseif task.instance.taskObjectsByActorID.Impatient and task.instance.taskObjectsByActorID.Impatient2 and task.instance.taskObjectsByActorID.Impatient3 then
            removeUserUpdateFunction("Turn traffic")
          end
        end
      end
      local trafficSearch = _trafficSearch()
      addUserUpdateFunction("Turn traffic", trafficSearch, 240, true)
    end
  end
end
taskCompleteData.Epilogue = {}
function taskCompleteData.Epilogue.taskComplete(taskObject, task)
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.specialName == "Initial drive" then
    removeUserUpdateFunction("Turn traffic")
    if not task.success then
      setUpParams(task)
      params.callback = failTask
      params.hint = "ID:235485"
      params.hintIcon1 = localPlayer.buttonLayout.minimapZoom
      params.rating = "FAIL"
      params.driverIsTanner = true
      params.dialogue = "GPMV00_FAILURE_L_1"
      params.failReason = "ID:182731"
      localPlayer.challenge.endScreen(taskObject, params)
    end
    for i, pos in ipairs(audioAlarmPos) do
      local playId = OneShotSound.PlayAtPosition("Burglar_Alarm_Play", pos, audioAlarmVel, audioAlarmDir)
      table.insert(audioAlarmPlayIds, playId)
    end
  elseif task.specialName == "Hospital drive" then
    if not task.success then
      setUpParams(task)
      params.callback = failTask
      params.hint = "ID:235485"
      params.hintIcon1 = localPlayer.buttonLayout.minimapZoom
      params.rating = "FAIL"
      params.driverIsTanner = true
      params.dialogue = "GPMV00_FAILURE_L_1"
      params.failReason = "ID:182731"
      localPlayer.challenge.endScreen(taskObject, params)
    else
      setUpParams(task)
      params.callback = completeTask
      params.rating = "PASS"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  end
end
function missionEndCallback.Epilogue(instance)
  Sfx.SetBlastCloud(false)
  moodSystem.removeMood("Epilogue pt 2", 1)
  moodSystem.removeMood("Epilogue pre pt 2", 1)
  removeUserUpdateFunction("Turn traffic")
  Explosion.Stop()
  civilianTraffic.setTrafficAbandonedOnOff(false)
  scoringSystem.EnableOvertaking = true
  Sound.RestoreAmbience()
  for i, playId in ipairs(audioAlarmPlayIds) do
    if playId ~= nil then
      OneShotSound.Stop(playId)
      audioAlarmPlayIds[i] = nil
    end
  end
  Commentary.SetTannerInMission(false)
  GameVehicleResource.setAlarmActivation(false)
  GameVehicleResource.setHornActivation(false)
  Orphanage.allowCarrierChasing(true)
end
