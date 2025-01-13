module("cardSystem.logic")
missionSetupData["Epilogue pt 2"] = {}
local jumpIcamTrigger = vec.vector(-31.48866, 56.76025, 3482.968, 1)
local function tannerTask(goalParams, HUD, audio)
  local taskList = {
    {
      {
        task = "No AI",
        specialName = "PIP 01 trigger & jones radio 1",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        },
        taskConditions = {
          {
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
        audioPIP = audio
      }
    },
    {
      {
        task = "Non-linear Chase",
        specialName = "Chase jericho",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {
                value = felony_chase.defaultChaseSettings.radius,
                inverse = true
              }
            },
            {
              goal = "Losing getaway time trigger",
              params = {value = 10, prompt = "ID:236625"}
            }
          },
          {
            skipTargetUpdate = true,
            triggerCount = 3,
            {
              goal = "Within radius",
              params = {
                value = felony_chase.defaultChaseSettings.radius,
                inverse = true
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
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
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
        },
        audioPIP = audio,
        HUD = {
          {
            style = "Epilogue pt 2 hud"
          }
        }
      },
      {
        task = "No AI Linear Checkpoints",
        specialName = "Tanner route",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        coreData = {totalLaps = 0},
        goalConditions = {
          {
            {
              goal = "Within strip of road",
              params = {value = 10}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Jump icam",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {goal = "Is jumping"},
            {
              goal = "Player within radius of point",
              params = {value = 20, position = jumpIcamTrigger}
            }
          }
        }
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
              goal = "Button Press",
              params = {watchFor = "Pressed", button = "Zap_In"}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Approaching warehouse",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 100}
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
        specialName = "Remove blast cloud and trigger the audio",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 100}
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
        specialName = "collision check for speech",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            autoRefresh = true,
            triggerCount = 1,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Simple collision check",
              params = {force = 5000, type = "Vehicle"}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "tanner hit jericho",
        groupProgression = {importantMinorOrder = false},
        dynamicTargets = false,
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 3,
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Jericho"}
              }
            },
            {
              goal = "Specified actors struck by player",
              params = {
                actorIDs = {"Jericho"}
              }
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "jones on radio2",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 75}
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
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return taskList
end
local jerichoTask = function(goalParams, HUD)
  local taskList = {
    {
      {
        task = "Linear Checkpoints",
        specialName = "Jericho evade",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within strip of road",
              params = {value = 10}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Jericho evade route 2 loop",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within strip of road",
              params = {value = 10}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {
                value = math.huge
              }
            }
          },
          {
            {
              goal = "Damage above",
              params = {value = 0.7}
            }
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "Jericho evade route 3 end",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within strip of road",
              params = {value = 10}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          }
        }
      }
    }
  }
  return taskList
end
local staticTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "Static shit"
      }
    }
  }
  return task
end
local copTask = function(goalParams, HUD, audio)
  local taskList = {
    enableNonPlayerFeedback = true,
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Non-linear Chase",
        specialName = "Chase tanker",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 10}
            }
          },
          {
            {
              goal = "Destroy specified actor after collision",
              params = {
                actorIDs = {
                  "RoadblockTanker"
                }
              }
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
      }
    }
  }
  return taskList
end
local headonTask = function(goalParams, HUD, audio)
  local taskList = {
    enableNonPlayerFeedback = true,
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Linear Checkpoints",
        specialName = "Hit tanner",
        dynamicTargets = true,
        coreData = {totalLaps = 0},
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
              goal = "Completed lap",
              params = {value = 0}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 20}
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return taskList
end
local driveByTask = function(goalParams, HUD)
  local taskList = {
    {
      {
        task = "Linear Checkpoints",
        specialName = "Drive by",
        dynamicTargets = true,
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
          }
        }
      }
    }
  }
  return taskList
end
missionSetupData["Epilogue pt 2"].taskCreatorFunctionLookups = {
  ["Tanner team"] = tannerTask,
  ["Jericho team"] = jerichoTask,
  ["Cop team"] = copTask,
  ["Headon team"] = headonTask,
  ["Drive by team"] = driveByTask,
  ["Static"] = staticTask
}
local prompts = {
  ["Takedown jericho"] = "ID:186300"
}
local showText = function(text)
  feedbackSystem.menusMaster.primaryTextPrompt(text, false, false, false, false)
end
local headOnCivDestination = vec.vector(1464.695, 6.170436, 1544.149, 1)
local removeTheBlastCloudAndTriggerTheAudio = vec.vector(1307.272, 8.52806, 2640.432, 1)
local jonesRadioSpeechTrigger = vec.vector(528.7167, 8.439592, 3607.303, 1)
local loadSoundCallback = function()
  feedbackSystem.startMusic("Uid06931_CH09_Standard_Dead_End_Play")
end
local audioAlarmPos = {
  vec.vector(906.455, 19.61, 1789.52, 1),
  vec.vector(604.363, 7.275, 1548.83, 1),
  vec.vector(1501.54, 8.927, 2194.14, 1),
  vec.vector(853.869, 7.325, 1322, 1),
  vec.vector(1170.96, 7.724, 1600.14, 1),
  [9] = vec.vector(1341.74, 8.927, 1848.81, 1)
}
local audioAlarmVel = vec.vector(0, 0, 0, 0)
local audioAlarmDir = vec.vector(1, 0, 0, 0)
local audioAlarmPlayIds = {}
missionSetupData["Epilogue pt 2"].initiate = function(instance)
  propSystem.disablePropType("DO_NOT_USE_shutter_A")
  if moodSystem.missionStartMoods[instance.challenge.name] then
    moodSystem.applyMood(instance.challenge.name)
  end
  local jerichoActor = instance.taskObjectsByActorID.Jericho.coreData.actor
  jerichoActor.routeName = "Epilogue jericho"
  instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle.performance = 1.25
  createCheckpoints(instance)
  createFixedPosition(instance, {headOnCivDestination}, 101)
  createFixedPosition(instance, {removeTheBlastCloudAndTriggerTheAudio}, 102)
  createFixedPosition(instance, {jonesRadioSpeechTrigger}, 103)
  characterManager.EnableEscapedConvicts()
  characterManager.EnablePeds()
  characterManager.SetPedestrianDensityMultiplier(0.25)
  Sound.OverrideAmbience("WakingNightmare")
  for i, pos in ipairs(audioAlarmPos) do
    local playId = OneShotSound.PlayAtPosition("Burglar_Alarm_Play", pos, audioAlarmVel, audioAlarmDir)
    table.insert(audioAlarmPlayIds, playId)
  end
  civilianTraffic.setTrafficAbandonedOnOff(true)
  scoringSystem.EnableOvertaking = false
  localPlayer.currentVehicle.gameVehicle.speed = 26.82
  Music.StopFreeDriveMusic()
  Sound.LoadMission(cards.Missions[instance.challenge.name].MissionID, loadSoundCallback)
  Sfx.SetBlastCloud(true)
  Commentary.SetTannerInMission(true)
  Commentary.ForceEventChange()
  GameVehicleResource.setAlarmActivation(true)
  AbandonedVehicles.Spawn(EpiloguePt2StaticVehicles)
  feedbackSystem.menusMaster.focusHintButtonState(true)
  feedbackSystem.menusMaster.setFocusButtonText()
end
missionSetupData["Epilogue pt 2"].update = nil
local getTannerTeamDynamicTargets = function(taskObject, task, dynamicListID)
  if task.specialName == "Chase jericho" then
    if dynamicListID then
      if task.specialName == "Chase jericho" then
        return false, true
      else
        return {
          taskObject.coreData.instance.taskObjectsByActorID.Jericho.coreData.agent
        }, false
      end
    else
      return {
        taskObject.coreData.instance.taskObjectsByActorID.Jericho.coreData.agent
      }, false
    end
  elseif task.specialName == "Approaching warehouse" then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
      return false, true
    else
      return {
        allCheckpoints[#allCheckpoints]
      }, false
    end
  elseif task.specialName == "Tanner route" then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
      if task.networkVars.checkpoints < #allCheckpoints then
        if task.networkVars.checkpoints == 1 then
          challengeSystem.spawnActors(task.instance, "Any", {Headon1 = true})
          GameVehicleResource.explode({
            gameVehicle = taskObject.coreData.instance.taskObjectsByActorID["Tanker explode"].coreData.agent.gameVehicle,
            offset = vec.vector(0, 3.5, 3.5, 1),
            range = 1,
            strength = 100
          })
        elseif task.networkVars.checkpoints == 4 then
          challengeSystem.spawnActors(task.instance, "Any", {RoadblockTanker = true})
          GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID.RoadblockTanker.coreData.agent.position, 30)
          challengeSystem.spawnActors(task.instance, "Any", {
            ["Cop Explode"] = true
          })
          ActiveLifeAI.setDynamicPathOverrideMode(task.instance.taskObjectsByActorID["Cop Explode"].coreData.agent.gameVehicle, "ramToKill")
          GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID["Cop Explode"].coreData.agent.position, 30)
          GameVehicleResource.ClearAreaOfVehicles(vec.vector(1233.666, 8.391761, 2551.585, 1), 20)
        elseif task.networkVars.checkpoints == 7 then
          challengeSystem.spawnActors(task.instance, "Never", {
            ["Emergency convoy cop"] = true,
            ["Emergency convoy cop 2"] = true,
            ["Emergency convoy ambulance"] = true
          })
          challengeSystem.spawnActors(task.instance, "Any", {RoadblockJackknife = true})
          challengeSystem.spawnActors(task.instance, "Any", {
            ["Ramp truck"] = true
          })
        end
        return {
          allCheckpoints[task.networkVars.checkpoints + 1]
        }, false
      else
        return {
          allCheckpoints[1]
        }, true
      end
    else
      return {
        allCheckpoints[task.networkVars.checkpoints]
      }, false
    end
  elseif task.specialName == "Remove blast cloud and trigger the audio" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 102), false
    end
  elseif task.specialName == "jones on radio2" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 103), false
    end
  end
end
local getJerichoTeamDynamicTargets = function(taskObject, task, dynamicListID)
  local jerichoActor = task.instance.taskObjectsByActorID.Jericho.coreData.actor
  if task.specialName == "Jericho evade" then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
      if task.networkVars.checkpoints < #allCheckpoints then
        if task.networkVars.checkpoints == 5 then
          jerichoActor.desiredSpeed = 90
          jerichoActor.rubberbandingToPlayerStrength = "Medium"
          jerichoActor.distanceBehindPlayer = -5
        elseif task.networkVars.checkpoints == 6 then
          jerichoActor.desiredSpeed = 100
          jerichoActor.rubberbandingToPlayerStrength = "Strong"
          jerichoActor.distanceBehindPlayer = -20
          GameVehicleResource.ClearAreaOfVehicles(vec.vector(1369.779, 8.393927, 2817.995, 1), 20)
        elseif task.networkVars.checkpoints == 7 then
          jerichoActor.desiredSpeed = 90
          jerichoActor.rubberbandingToPlayerStrength = "Medium"
          jerichoActor.distanceBehindPlayer = -5
          GameVehicleResource.ClearAreaOfVehicles(vec.vector(1303.547, 8.442091, 3161.265, 1), 20)
        elseif task.networkVars.checkpoints == 8 then
          jerichoActor.desiredSpeed = 100
          jerichoActor.rubberbandingToPlayerStrength = "Strong"
          jerichoActor.distanceBehindPlayer = -20
        elseif task.networkVars.checkpoints == 9 then
          GameVehicleResource.ClearAreaOfVehicles(vec.vector(1138.629, 8.488533, 3355.503, 1), 30)
          GameVehicleResource.ClearAreaOfVehicles(vec.vector(817.8521, 9.79485, 3348.528, 1), 20)
        elseif task.networkVars.checkpoints == 10 then
          jerichoActor.desiredSpeed = 100
          jerichoActor.rubberbandingToPlayerStrength = "Strong"
          jerichoActor.distanceBehindPlayer = -30
          jerichoActor.ignoreCivilianTraffic = true
          GameVehicleResource.setInfiniteMass(task.instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle, true)
        elseif task.networkVars.checkpoints == 11 then
          jerichoActor.desiredSpeed = 90
          jerichoActor.rubberbandingToPlayerStrength = "Medium"
          jerichoActor.distanceBehindPlayer = -5
          jerichoActor.ignoreCivilianTraffic = false
          GameVehicleResource.setInfiniteMass(task.instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle, false)
        elseif task.networkVars.checkpoints == 12 then
          jerichoActor.desiredSpeed = 100
          jerichoActor.rubberbandingToPlayerStrength = "Strong"
          jerichoActor.distanceBehindPlayer = -30
          jerichoActor.ignoreCivilianTraffic = true
          GameVehicleResource.setInfiniteMass(task.instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle, true)
        elseif task.networkVars.checkpoints == 13 then
          jerichoActor.desiredSpeed = 90
          jerichoActor.rubberbandingToPlayerStrength = "Medium"
          jerichoActor.distanceBehindPlayer = -5
          jerichoActor.ignoreCivilianTraffic = false
          GameVehicleResource.setInfiniteMass(task.instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle, false)
        elseif task.networkVars.checkpoints == 14 then
          jerichoActor.desiredSpeed = 100
          jerichoActor.rubberbandingToPlayerStrength = "Medium"
          jerichoActor.distanceBehindPlayer = -20
          GameVehicleResource.ClearAreaOfVehicles(vec.vector(-230.2697, 88.71481, 3412.72, 1), 20)
        elseif task.networkVars.checkpoints == 15 then
          jerichoActor.desiredSpeed = 90
          jerichoActor.rubberbandingToPlayerStrength = "Strong"
          jerichoActor.distanceBehindPlayer = -5
        elseif task.networkVars.checkpoints == 16 then
          jerichoActor.desiredSpeed = 100
          jerichoActor.rubberbandingToPlayerStrength = "Medium"
          jerichoActor.distanceBehindPlayer = -20
        elseif task.networkVars.checkpoints == 17 then
          jerichoActor.desiredSpeed = 90
          jerichoActor.rubberbandingToPlayerStrength = "Strong"
          jerichoActor.distanceBehindPlayer = -10
          GameVehicleResource.ClearAreaOfVehicles(vec.vector(950.0696, 8.408367, 3626.161, 1), 20)
          GameVehicleResource.ClearAreaOfVehicles(vec.vector(774.9447, 8.221434, 4147.752, 1), 20)
        elseif task.networkVars.checkpoints == 18 then
          jerichoActor.desiredSpeed = 100
          jerichoActor.rubberbandingToPlayerStrength = "Medium"
          jerichoActor.distanceBehindPlayer = -20
        end
        return {
          allCheckpoints[task.networkVars.checkpoints + 1]
        }, false
      else
        return {
          allCheckpoints[1]
        }, true
      end
    else
      return {
        allCheckpoints[task.networkVars.checkpoints]
      }, false
    end
  elseif task.specialName == "Jericho evade route 2 loop" then
    if jerichoActor.routeName == "Epilogue jericho" then
      jerichoActor.routeName = "Epilogue jericho loop"
      createCheckpoints(task.instance, "Epilogue jericho loop")
    end
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
      if task.networkVars.checkpoints < #allCheckpoints then
        if task.networkVars.checkpoints == 2 then
          jerichoActor.desiredSpeed = 90
          jerichoActor.rubberbandingToPlayerStrength = "Medium"
          jerichoActor.distanceBehindPlayer = -5
        elseif task.networkVars.checkpoints == 3 then
          jerichoActor.desiredSpeed = 100
          jerichoActor.rubberbandingToPlayerStrength = "Strong"
          jerichoActor.distanceBehindPlayer = -15
        elseif task.networkVars.checkpoints == 4 then
          jerichoActor.desiredSpeed = 100
          jerichoActor.rubberbandingToPlayerStrength = "Medium"
          jerichoActor.distanceBehindPlayer = -5
        elseif task.networkVars.checkpoints == 5 then
          jerichoActor.desiredSpeed = 100
          jerichoActor.rubberbandingToPlayerStrength = "Strong"
          jerichoActor.distanceBehindPlayer = -15
        end
        return {
          allCheckpoints[task.networkVars.checkpoints + 1]
        }, false
      else
        return {
          allCheckpoints[1]
        }, true
      end
    else
      return {
        allCheckpoints[task.networkVars.checkpoints]
      }, false
    end
  elseif task.specialName == "Jericho evade route 3 end" then
    if jerichoActor.routeName == "Epilogue jericho loop" then
      jerichoActor.routeName = "Epilogue jericho end"
      jerichoActor.avoidUTurns = true
      jerichoActor.desiredSpeed = 125
      jerichoActor.rubberbandingToPlayerStrength = "Strong"
      jerichoActor.distanceBehindPlayer = -70
      createCheckpoints(task.instance, "Epilogue jericho end")
    end
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if dynamicListID then
      if task.networkVars.checkpoints < #allCheckpoints then
        return {
          allCheckpoints[task.networkVars.checkpoints + 1]
        }, false
      else
        return {
          allCheckpoints[1]
        }, true
      end
    else
      return {
        allCheckpoints[task.networkVars.checkpoints]
      }, false
    end
  end
end
local getCopTeamDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID.RoadblockTanker.coreData.agent
    }, false
  end
end
local getDriveByTeamDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
  if dynamicListID then
    if task.networkVars.checkpoints < #allCheckpoints then
      return {
        allCheckpoints[task.networkVars.checkpoints + 1]
      }, false
    else
      return {
        allCheckpoints[1]
      }, true
    end
  else
    return {
      allCheckpoints[task.networkVars.checkpoints]
    }, false
  end
end
local getHeadonTeamDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  else
    return checkpointSystem.getCheckpoints(task.instance, 101), false
  end
end
missionSetupData["Epilogue pt 2"].targetList = {
  ["Tanner team"] = getTannerTeamDynamicTargets,
  ["Jericho team"] = getJerichoTeamDynamicTargets,
  ["Cop team"] = getCopTeamDynamicTargets,
  ["Headon team"] = getHeadonTeamDynamicTargets,
  ["Drive by team"] = getDriveByTeamDynamicTargets
}
local function stopAlarms()
  for i, playId in ipairs(audioAlarmPlayIds) do
    if playId ~= nil then
      OneShotSound.Stop(playId)
      audioAlarmPlayIds[i] = nil
    end
  end
  GameVehicleResource.setAlarmActivation(false)
end
taskCompleteData["Epilogue pt 2"] = {}
taskCompleteData["Epilogue pt 2"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = cameraShotVehicle or localPlayer.currentVehicle,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    passCondition = task.instance.challenge.taskCompleteData["Pass condition"]
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.specialName == "Chase jericho" then
    if not task.success then
      params.callback = failTask
      params.rating = "FAIL"
      params.driverIsTanner = true
      if task.condition == 2 then
        params.hint = "ID:236267"
        params.dialogue = "GPMV01_FAILURE_L_1"
        params.failReason = "ID:182731"
      else
        params.hint = "ID:236267"
        params.failReason = "ID:231141"
        params.dialogue = "GPMV01_FAILURE_L_2"
      end
      feedbackSystem.stopMusic("Uid06931_CH09_Standard_Dead_End_No_Fade_Stop")
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "PIP 01 trigger & jones radio 1" then
    showText(prompts["Takedown jericho"])
  elseif task.specialName == "Jericho evade route 3 end" then
    for k, v in next, task.instance.taskObjectsByActorID, nil do
      if k ~= "Tanner" and k ~= "Jericho" then
        v:delete(true)
      end
    end
    GameVehicleResource.unspoolOccupants(taskObject.coreData.instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle)
    params.callback = completeTask
    params.rating = "PASS"
    params.keepMusicTrackRunning = true
    characterManager.DisableEscapedConvicts()
    characterManager.DisablePeds()
    characterManager.SetPedestrianDensityMultiplier(1)
    characterManager.EnablePeds()
    civilianTraffic.setTrafficAbandonedOnOff(false)
    AbandonedVehicles.Clear()
    stopAlarms()
    localPlayer.challenge.endScreen(taskObject, params)
    GameplayTracking.OnGameComplete()
  elseif task.specialName == "Jump icam" then
    local icamParams = {
      cameraTargets = {
        taskObject.coreData.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle,
        taskObject.coreData.instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle
      },
      duration = 5,
      speed = 0.2,
      framing = "wide",
      angleYaw = "front",
      anglePitch = "low",
      fixedCameras = {
        [4] = vec.vector(32.49003, 33.6666, 3484.779, 1)
      },
      disableAI = true
    }
    iCamActivationTableInput(icamParams)
  elseif task.specialName == "Chase tanker" then
    GameVehicleResource.explode({
      gameVehicle = taskObject.coreData.instance.taskObjectsByActorID.RoadblockTanker.coreData.agent.gameVehicle,
      offset = vec.vector(0, 3.5, 3.5, 1),
      range = 1,
      strength = 100
    })
    GameVehicleResource.explode({
      gameVehicle = taskObject.coreData.instance.taskObjectsByActorID["Cop Explode"].coreData.agent.gameVehicle,
      offset = vec.vector(0, 3.5, 3.5, 1),
      range = 1,
      strength = 100
    })
  end
end
missionEndCallback["Epilogue pt 2"] = function(instance)
  characterManager.DisableEscapedConvicts()
  characterManager.DisablePeds()
  propSystem.reenableAllPropTypes()
  characterManager.SetPedestrianDensityMultiplier(1)
  characterManager.EnablePeds()
  civilianTraffic.setTrafficAbandonedOnOff(false)
  scoringSystem.EnableOvertaking = true
  Sound.RestoreAmbience()
  feedbackSystem.stopMusic("Uid06931_CH09_Standard_Dead_End_No_Fade_Stop")
  Commentary.SetTannerInMission(false)
  stopAlarms()
  AbandonedVehicles.Clear()
  feedbackSystem.removeSlot(1)
  local jerichoActor = instance.taskObjectsByActorID.Jericho.coreData.actor
  jerichoActor.routeName = "Epilogue jericho"
end
