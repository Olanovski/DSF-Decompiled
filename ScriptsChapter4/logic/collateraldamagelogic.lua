module("cardSystem.logic")
missionSetupData["Collateral Damage"] = {}
local chaseSettings = felony_chase.getSpecifiedMissionChaseSettings("Collateral Damage")
local currentJerichoGameVehicle
local waitingForZapTransition = false
local zapTransitionFinished = false
local startSimulationSpeed = simulation.getSpeed()
local skidSequence = true
local firstPipPlayed = false
local colour = vec.vector(1, 0, 0, 1)
local firstPip = "firstPip"
local skidHalt = "skidAttack"
local ramWait = "ramWait"
local afterSoftSave = "afterSoftSave"
local glowEffect1 = "glowEffect1"
local glowEffect2 = "glowEffect2"
local glowEffect3 = "glowEffect3"
local groundRavenID
local ravenPosition = vec.vector(-4033.794, 25.51517, 2641.711, 1)
local function civAttack(gameVehicle, instance)
  local actorID
  if not instance.taskObjectsByActorID.Civ then
    actorID = "Civ"
  elseif not instance.taskObjectsByActorID.Civ2 then
    actorID = "Civ2"
  elseif not instance.taskObjectsByActorID.Civ3 then
    actorID = "Civ3"
  end
  if gameVehicle and actorID then
    if not SNV.getSNVFromGameVehicle(gameVehicle) then
      SNV.CreateSNVFromGV(gameVehicle)
    end
    if gameVehicle.owner == "Orphan" then
      local actor = instance.challenge.actorPool[actorID]
      local civAgent = convertOrphanToAgent(gameVehicle)
      challengeSystem.createActor(instance, civAgent, actor)
    else
      local civAgent = vehicleManager.registerVehicle({gameVehicle = gameVehicle})
      local actor = instance.challenge.actorPool[actorID]
      challengeSystem.createActor(instance, civAgent, actor)
    end
  elseif actorID then
    challengeSystem.spawnActors(instance, "Never", {
      [actorID] = true
    })
  end
  if actorID and instance.taskObjectsByActorID[actorID] then
    instance.taskObjectsByActorID[actorID].coreData.agent.gameVehicle.performance = 1.25
    OneShotSound.Play("Jericho_Shift_OneShot")
    ZapAIPresence.Settings({FlashVehicle = true})
    ZapAIPresence.StartTransition(nil, instance.taskObjectsByActorID[actorID].coreData.agent.gameVehicle)
    GameVehicleResource.upgradeOccupants(instance.taskObjectsByActorID[actorID].coreData.agent.gameVehicle)
    if actorID == "Civ" then
      addUserUpdateFunction(glowEffect1, function()
        removeUserUpdateFunction(glowEffect1)
        if instance.taskObjectsByActorID.Civ then
          SNV.setFlashColour(instance.taskObjectsByActorID.Civ.coreData.agent.SNVID, colour)
        end
      end, 156, true)
    elseif actorID == "Civ2" then
      addUserUpdateFunction(glowEffect2, function()
        removeUserUpdateFunction(glowEffect2)
        if instance.taskObjectsByActorID.Civ2 then
          SNV.setFlashColour(instance.taskObjectsByActorID.Civ2.coreData.agent.SNVID, colour)
        end
      end, 156, true)
    elseif actor == "Civ3" then
      addUserUpdateFunction(glowEffect3, function()
        removeUserUpdateFunction(glowEffect3)
        if instance.taskObjectsByActorID.Civ3 then
          SNV.setFlashColour(instance.taskObjectsByActorID.Civ3.coreData.agent.SNVID, colour)
        end
      end, 156, true)
    end
    currentJerichoGameVehicle = instance.taskObjectsByActorID[actorID].coreData.agent.gameVehicle
  end
end
local function jerichoZapTransitionEnd()
  zapTransitionFinished = true
end
local timeBetweenAttacks = 2
local civAllowedAttack = false
local jerichoDamageAmount = 0.69
local function playerTask(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    {
      {
        task = "No AI",
        specialName = "music start",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Felony chase",
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 3,
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            },
            {
              goal = "Player within then outside radius of getaway",
              params = {value = 150}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            },
            {
              goal = "Recent audio played",
              params = {value = 3}
            },
            {
              goal = "Getaway damage above",
              params = {value = 0.2}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            },
            {
              goal = "Recent audio played",
              params = {value = 3}
            },
            {
              goal = "Getaway damage above",
              params = {value = 0.35}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            },
            {
              goal = "Recent audio played",
              params = {value = 3}
            },
            {
              goal = "Getaway damage above",
              params = {value = 0.55}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        },
        taskConditions = {
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "All chaser teammates wrecked"
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Getaway escaped"
            }
          },
          {
            {
              goal = "Getaway damage above",
              params = {value = jerichoDamageAmount}
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
            style = "Collateral damage hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "destroy tanner 1 after cutscene",
        taskConditions = {
          {
            forceTaskComplete = true,
            {
              goal = "Player in agent",
              params = {agentName = "Tanner 2"}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        }
      }
    }
  }
  return task
end
local jerichoTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "Wander",
        specialName = "jericho run"
      }
    }
  }
  return task
end
local tanner2Task = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Waiting for end of cutscene",
        taskConditions = {
          {
            {
              goal = "Player in agent",
              params = {agentName = "Tanner 2"}
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
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Soft save",
        taskConditions = {
          {
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Jericho", "Tanner"},
                inverse = true
              }
            }
          },
          {
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Waiting for end of cutscene - end delay",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2.5}
            }
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "evade civs",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Agent stopped inside radius",
              params = {value = 12, unlockBrakes = false}
            }
          },
          {
            {
              goal = "Being towed",
              params = {towedBy = "Player"}
            },
            {
              goal = "Agent stopped inside radius",
              params = {
                value = 12,
                stopDuration = 0.2,
                agent = "Player"
              }
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
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          },
          {
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {discScale = 6.5}
              }
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "stop the cavalry",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 200}
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
      },
      {
        task = "No AI",
        specialName = "switch attacks",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Within radius",
              params = {value = 2500}
            },
            {
              goal = "Within radius",
              params = {value = 1500, inverse = true}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Within radius",
              params = {value = 1500}
            },
            {
              goal = "Within radius",
              params = {value = 1000, inverse = true}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Within radius",
              params = {value = 1000}
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
      },
      {
        task = "No AI",
        specialName = "Tanner near destination and nearly wrecked",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Damage above",
              params = {value = 0.85}
            },
            {
              goal = "Within radius",
              params = {value = 400}
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
      },
      {
        task = "No AI",
        specialName = "Player too far from Tanner",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            skipTargetUpdate = true,
            {
              goal = "Within radius of player",
              params = {value = 200, inverse = true}
            },
            {
              goal = "Is player controlled",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 7}
            }
          },
          {
            autoRefresh = true,
            skipTargetUpdate = true,
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Player within radius in zap",
              params = {value = 200, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 7}
            }
          }
        },
        HUD = {
          {
            style = "Collateral damage hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "In zap again",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player just zapped out of specified actors",
              params = {
                actors = {"Tanner 2"}
              }
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Wander",
        specialName = "mission end zap",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.3}
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
        specialName = "mission end",
        taskConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 3}
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
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        }
      }
    }
  }
  return task
end
local civTask = function(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Linear Chase",
        specialName = "civ attack tanner",
        dynamicTargets = true,
        goalConditions = {
          {
            {
              goal = "Agent within then outside radius of target",
              params = {value = 40}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 5}
            },
            {
              goal = "Outside radius",
              params = {value = 100}
            }
          },
          {
            {
              goal = "Simple collision check",
              params = {hitActor = "Tanner 2"}
            }
          },
          {
            {
              goal = "Specified actors have finished race",
              params = {
                actors = {"Tanner 2"},
                value = 1
              }
            }
          },
          {
            {
              goal = "Player in target vehicle",
              params = {inverse = true}
            },
            {
              goal = "Agent within then outside radius of target",
              params = {value = 15}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 15}
            },
            {
              goal = "Outside radius",
              params = {value = 15}
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
  return task
end
position = vec.vector(-4027.328, 24.3052, 2617.778, 1)
radius = 45
local firstCivTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "Non-linear Chase",
        dynamicTargets = true,
        specialName = "Chase tanner",
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = radius}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          }
        }
      }
    },
    {
      {
        task = "Non-linear Chase",
        dynamicTargets = true,
        specialName = "Chase tanner 3",
        goalConditions = {
          {
            {
              goal = "Simple collision check",
              params = {hitActor = "Tanner 2"}
            }
          },
          {
            {
              goal = "Agent within then outside radius of target",
              params = {value = 40}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 5}
            },
            {
              goal = "Outside radius",
              params = {value = 100}
            }
          },
          {
            {
              goal = "Player in target vehicle",
              params = {inverse = true}
            },
            {
              goal = "Agent within then outside radius of target",
              params = {value = 15}
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 15}
            },
            {
              goal = "Outside radius",
              params = {value = 15}
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
    }
  }
  return task
end
local dummyTask = function(goalParams, HUD, audio)
  local task = {
    {
      {task = "No AI"}
    }
  }
  return task
end
missionSetupData["Collateral Damage"].taskCreatorFunctionLookups = {
  ["Truck team"] = playerTask,
  ["Tanner team 1"] = dummyTask,
  ["Tanner team 2"] = tanner2Task,
  ["Jericho team"] = jerichoTask,
  ["Civ team"] = civTask,
  ["First civ team"] = firstCivTask
}
local endPosition = vec.vector(-286.6966, 18.21417, 976.7795, 1)
local tannerSpeedExploitBlock, tannerLowSpeedStart, tannerLowSpeedOverride
missionSetupData["Collateral Damage"].initiate = function(instance)
  tannerLowSpeedStart = nil
  tannerLowSpeedOverride = false
  tannerSpeedExploitBlock = 10
  createFixedPosition(instance, {endPosition}, 101)
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData and softSaveData.progression == 1 then
    SNV.setFlashColour(instance.taskObjectsByActorID["First civ"].coreData.agent.SNVID, colour)
    moodSystem.applyMood("Avoid The Cars", 0.3)
    feedbackSystem.menusMaster.setCurrentFocusString(2)
  end
  createFixedPosition(instance, {position}, 99)
  ZapAIPresence.SetCallback({TransitionCallback = jerichoZapTransitionEnd})
  ZapAIPresence.Settings({
    Height = 20,
    Radius = 1,
    TransitionInTime = 1,
    Color = vec.vector(40, 40, 40, 1)
  })
end
local vehicleSearchParameters = {
  ignoreSciptOwnedVehicles = true,
  ignoreCops = true,
  scoring = {
    sameRoad = {condition = true, discard = true},
    discardIfConditionsNotMet = {
      condition = false,
      speed = 40,
      discardModelIDs = {
        298,
        287,
        201,
        185,
        284,
        152,
        291,
        286,
        167,
        170,
        197
      }
    },
    ahead = {condition = true, discard = true},
    sameDirection = {condition = false, discard = true},
    heightDifference = {difference = 3, discard = true},
    proximity = true,
    print = false,
    drawDebug = false,
    towedincluded = false
  }
}
local vehicleSearchParametersCloseSkid = {
  idealDistance = 27,
  ignoreSciptOwnedVehicles = true,
  ignoreCops = true,
  scoring = {
    sameRoad = {condition = true, discard = true},
    discardIfConditionsNotMet = {
      condition = false,
      speed = 70,
      discardModelIDs = {
        298,
        287,
        201,
        185,
        284,
        152,
        291,
        286,
        167,
        170,
        197
      }
    },
    ahead = {condition = true, discard = true},
    sameDirection = {condition = true, discard = true},
    heightCheck = true,
    proximity = true,
    print = false,
    drawDebug = false,
    towedincluded = false
  }
}
local delay = false
local attackType = 1
local skidStart = 0
local tannerSpeed = 0
missionSetupData["Collateral Damage"].update = function(instance)
  if instance.taskObjectsByActorID["Tanner 2"] then
    tannerSpeed = instance.taskObjectsByActorID["Tanner 2"].coreData.agent.gameVehicle.speed * 2.236
  end
  if tannerSpeed < 20 then
    if not tannerLowSpeedStart then
      tannerLowSpeedStart = g_NetworkTime
    elseif tannerLowSpeedStart and not tannerLowSpeedOverride and g_NetworkTime - tannerLowSpeedStart > tannerSpeedExploitBlock then
      tannerLowSpeedOverride = true
    end
  elseif tannerLowSpeedStart then
    tannerLowSpeedStart = nil
    tannerLowSpeedOverride = false
  end
  local attackDelay = true
  attackDelay = delay and g_NetworkTime - delay > 5
  if attackDelay and instance.taskObjectsByActorID["Tanner 2"] and civAllowedAttack and not instance.taskObjectsByActorID["First civ"] and (tannerSpeed > 20 or tannerLowSpeedOverride) then
    if not firstPipPlayed then
      local waitEnd = g_NetworkTime
      local played = {}
      local function doAudio()
        if g_NetworkTime >= waitEnd + 35 and not played.GPMV01_SEQUENCE_R_6a then
          eventFeedback(tanner, "GPMV01_SEQUENCE_R_6")
          played.GPMV01_SEQUENCE_R_6a = true
        elseif g_NetworkTime >= waitEnd + 75 and not played.GPMV01_SEQUENCE_R_6b then
          eventFeedback(tanner, "GPMV01_SEQUENCE_R_6")
          played.GPMV01_SEQUENCE_R_6b = true
        elseif g_NetworkTime >= waitEnd + 105 and not played.GPMV01_SEQUENCE_R_6c then
          eventFeedback(tanner, "GPMV01_SEQUENCE_R_6")
          played.GPMV01_SEQUENCE_R_6c = true
        elseif g_NetworkTime >= waitEnd + 135 and not played.GPMV01_SEQUENCE_R_6d then
          eventFeedback(tanner, "GPMV01_SEQUENCE_R_6")
          removeUserUpdateFunction("AddAudio")
        end
      end
      addUserUpdateFunction("AddAudio", doAudio, 30)
      firstPipPlayed = true
    end
    if not waitingForZapTransition then
      local gameVehicle = instance.taskObjectsByActorID["Tanner 2"].coreData.agent.gameVehicle
      local attack = math.random(2)
      local searchParams
      local behaviour = "ramToKill"
      local distance
      local position = vec.vector()
      if skidSequence and skidStart and g_NetworkTime - skidStart > 1 then
        skidSequence = false
        attack = 2
      end
      if skidSequence or attack == 1 and not tannerLowSpeedOverride then
        searchParams = vehicleSearchParametersCloseSkid
        vehicleSearchParametersCloseSkid.scoring.sameDirection.condition = localPlayer.currentVehicle:get_withTrafficFlow() or isVehicleOnJunction(localPlayer.currentVehicle)
        position = position:add(gameVehicle.matrix[3], gameVehicle.matrix[2] * (gameVehicle.speed / 3))
        behaviour = "skid"
        distance = 30
        if not skidSequence then
          skidSequence = true
          skidStart = g_NetworkTime
        end
      elseif attack == 2 or tannerLowSpeedOverride then
        searchParams = vehicleSearchParameters
        position = position:add(gameVehicle.matrix[3], gameVehicle.matrix[2] * (gameVehicle.speed * 4))
        distance = 150
        if not isEventActive() then
          eventFeedback(tanner, "GPMV01_SEQUENCE_R_5")
        end
      end
      local jerichoVehicle = vehicleManager.findVehiclesInTraffic(position, gameVehicle.matrix[2], distance, searchParams, 1)
      if jerichoVehicle and jerichoVehicle[1] then
        skidSequence = false
        waitingForZapTransition = true
        civAttack(jerichoVehicle[1], instance)
        if behaviour and (behaviour ~= "skid" or tannerSpeed < 75) then
          ActiveLifeAI.setDynamicPathOverrideMode(currentJerichoGameVehicle, behaviour)
        end
        if behaviour == "skid" and (attack == 1 or skidSequence) then
          addUserUpdateFunction(skidHalt, function()
            removeUserUpdateFunction(skidHalt)
            ActiveLifeAI.setDynamicPathOverrideMode(currentJerichoGameVehicle, "forceHalt")
          end, 120, true)
        end
      elseif not skidSequence then
        civAttack(nil, instance)
      end
      if attackType == 1 and instance.taskObjectsByActorID.Civ then
        civAllowedAttack = false
      elseif attackType == 2 and instance.taskObjectsByActorID.Civ2 then
        civAllowedAttack = false
      end
    elseif zapTransitionFinished or civAllowedAttack then
      waitingForZapTransition = false
      zapTransitionFinished = false
    end
  end
end
local getTannerTeamDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID.Jericho.coreData.agent
    }, false
  end
end
local function getTanner2TeamDynamicTargets(taskObject, task, dynamicListID, goalConditionKey)
  if task.specialName == "switch attacks" then
    if goalConditionKey == 1 then
      attackType = 2
    elseif goalConditionKey == 3 then
      timeBetweenAttacks = timeBetweenAttacks / 2
    end
    return checkpointSystem.getCheckpoints(task.instance, 101), false
  elseif dynamicListID then
    return false, true
  elseif task.specialName == "evade civs" or task.specialName == "Tanner near destination and nearly wrecked" or task.specialName == "stop the cavalry" then
    return checkpointSystem.getCheckpoints(task.instance, 101), false
  elseif task.specialName == "Player too far from Tanner" then
    return {
      task.instance.taskObjectsByActorID["Tanner 2"].coreData.agent
    }, false
  end
end
local getAttackerTeamDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID["Tanner 2"].coreData.agent
    }, false
  end
end
local getFirstCivTeamDynamicTargets = function(taskObject, task, dynamicListID, goalConditionKey)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID["Tanner 2"].coreData.agent
    }, false
  end
end
missionSetupData["Collateral Damage"].targetList = {
  ["Tanner team 1"] = getTannerTeamDynamicTargets,
  ["Tanner team 2"] = getTanner2TeamDynamicTargets,
  ["Civ team"] = getAttackerTeamDynamicTargets,
  ["First civ team"] = getAttackerTeamDynamicTargets
}
local params
local function setupEndScreen(task)
  params = {
    vehicle = localPlayer.currentVehicle,
    musicID = nil,
    successReason = "ID:245619",
    failReason = task.instance.challenge.taskCompleteData["Failure reason (wrecked)"],
    hint = ""
  }
end
missionSetupData["Collateral Damage"].goalComplete = function(taskObject, task, conditionKey)
  if task.specialName == "Chase tanner" and not task.instance.loadedFromSoftSave then
    spooling.enableTraffic(true)
    GameVehicleResource.ClearAreaOfVehicles(vec.vector(-4015.7, 24.78617, 2575.378, 1), 100)
    GameVehicleResource.lockEmergencyBrakes(task.agent.gameVehicle, 0.1)
    task.instance.taskObjectsByActorID["First civ"].coreData.actor.desiredSpeed = 0
    ActiveLifeAI.setDynamicPathOverrideMode(task.instance.taskObjectsByActorID["First civ"].coreData.agent.gameVehicle, "forceHalt")
  end
end
taskCompleteData["Collateral Damage"] = {}
taskCompleteData["Collateral Damage"].taskComplete = function(taskObject, task)
  if task.success then
    if task.specialName == "music start" then
      feedbackSystem.startMusic("Uid02306_CH04_Story_CollateralDamage_Play")
      local evaderGameVehicle = task.instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle
      local chaserGameVehicle = task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle
      felony_chase.startChase(evaderGameVehicle, chaserGameVehicle)
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184312", false, true, false, false)
    elseif task.specialName == "Felony chase" then
      removeUserUpdateFunction("escapeCountdown")
      propSystem.disablePropType("DO_NOT_USE_Wall_B")
      engineCutscene.playCutscene("ch4_sm4_01", nil, function()
        localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
        challengeSystem.spawnActors(task.instance, "Never", {
          ["Tanner 2"] = true
        })
        spooling.enableTraffic(false)
        localPlayer:SetZapLevel(0, task.instance.taskObjectsByActorID["Tanner 2"].coreData.agent, true)
        localPlayer.missionSupport:setMainTaskObject(task.instance.taskObjectsByActorID["Tanner 2"])
        felony_patrollingVehicleManager.enablePatrollingVehicles(false)
        groundRavenID = characterManager.addPerchedRavens(ravenPosition, 1, 14, 2)
        feedbackSystem.playRavensSound("Ravens_Perched", ravenPosition)
      end, function()
        localPlayer:enterCutsceneMode()
        propSystem.reenableAllPropTypes()
        eventFeedback(localPlayer.currentVehicle, "PIP01")
      end)
    elseif task.specialName == "Chase tanner 3" then
      ZapAIPresence.StartTransition(nil, task.instance.taskObjectsByActorID["First civ"].coreData.agent.gameVehicle)
      SNV.resetFlashColour(task.instance.taskObjectsByActorID["First civ"].coreData.agent.SNVID)
      GameVehicleResource.setCharacterSpoolingEntityIndex(task.agent.gameVehicle, 0, "-1269137079")
      vehicleManager.removeHighLODOccupants(task.agent.gameVehicle)
      local waitEnd = g_NetworkTime + 3
    elseif task.specialName == "jericho run" then
      OneShotSound.Play("HUD_Gen_Positive", false)
      localPlayer:showHUDElements(false)
    elseif task.specialName == "Soft save" then
      localPlayer.cameraSupport.miniSceneCamera()
      moodSystem.applyMood("Avoid The Cars", 0.3)
      feedbackSystem.menusMaster.setCurrentFocusString(2)
      GameVehicleResource.ClearAreaOfVehicles(vec.vector(-4015.7, 24.78617, 2575.378, 1), 100)
      challengeSystem.spawnActors(task.instance, "Never", {
        ["First civ"] = true
      })
      ZapAIPresence.StartTransition(nil, task.instance.taskObjectsByActorID["First civ"].coreData.agent.gameVehicle)
      SNV.setFlashColour(task.instance.taskObjectsByActorID["First civ"].coreData.agent.SNVID, colour)
      progressionSystem.triggerSoftSave({progression = 1})
      local waitEnd = g_NetworkTime + 14
      addUserUpdateFunction(afterSoftSave, function()
        if g_NetworkTime >= waitEnd then
          removeUserUpdateFunction(afterSoftSave)
          civAllowedAttack = true
        end
      end, 1)
      feedbackSystem.startMusic("Uid02306_CH04_Story_CollateralDamage_Cue02_Play")
    elseif task.specialName == "Chase tanner" then
      ActiveLifeAI.setDynamicPathOverrideMode(task.instance.taskObjectsByActorID["First civ"].coreData.agent.gameVehicle, "ramToKill")
      spooling.enableTraffic(true)
      GameVehicleResource.unlockEmergencyBrakes(task.agent.gameVehicle, 0.1)
      task.instance.taskObjectsByActorID["First civ"].coreData.actor.desiredSpeed = 75
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184302")
      feedbackSystem.menusMaster.secondaryTextPrompt("ID:245544")
      localPlayer:exitCutsceneMode()
      localPlayer:resetCameraMode()
      localPlayer.inCountdownMode = false
      characterManager.OutdoorCharacter_TriggerEvent("TRIGGER_TAKEOFF", "eCharacter_Bird", groundRavenID, -1)
      feedbackSystem.playRavensSound("Ravens_Flee", ravenPosition)
    elseif task.specialName == "civ attack tanner" then
      if task.condition == 3 then
        delay = g_NetworkTime
      end
      localPlayer.simulationSupport.doWait(timeBetweenAttacks, function()
        civAllowedAttack = true
      end, "timeBetweenAttacks")
      if task.instance.taskObjectsByActorID["Tanner 2"].coreData.agent.damage > 0.8 then
        delay = g_NetworkTime
      end
      SNV.resetFlashColour(task.agent.SNVID)
      ZapAIPresence.Settings({FlashVehicle = false})
      ZapAIPresence.StartTransition(nil, task.agent.gameVehicle)
    elseif task.specialName == "stop the cavalry" then
      if task.instance.taskObjectsByActorID.Civ then
        SNV.resetFlashColour(task.instance.taskObjectsByActorID.Civ.coreData.agent.SNVID)
        ZapAIPresence.Settings({FlashVehicle = false})
        ZapAIPresence.StartTransition(nil, task.instance.taskObjectsByActorID.Civ.coreData.agent.gameVehicle)
        task.instance.taskObjectsByActorID.Civ:delete(false)
      end
      if task.instance.taskObjectsByActorID.Civ2 then
        SNV.resetFlashColour(task.instance.taskObjectsByActorID.Civ2.coreData.agent.SNVID)
        ZapAIPresence.Settings({FlashVehicle = false})
        ZapAIPresence.StartTransition(nil, task.instance.taskObjectsByActorID.Civ2.coreData.agent.gameVehicle)
        task.instance.taskObjectsByActorID.Civ2:delete(false)
      end
      if task.instance.taskObjectsByActorID.Civ3 then
        SNV.resetFlashColour(task.instance.taskObjectsByActorID.Civ3.coreData.agent.SNVID)
        ZapAIPresence.Settings({FlashVehicle = false})
        ZapAIPresence.StartTransition(nil, task.instance.taskObjectsByActorID.Civ3.coreData.agent.gameVehicle)
        task.instance.taskObjectsByActorID.Civ3:delete(false)
      end
      moodSystem.removeMood("Avoid The Cars", 2)
      civAllowedAttack = false
    elseif task.specialName == "evade civs" then
      task.instance.taskObjectsByActorID["Tanner 2"].coreData.agent:set_damageMultiplier(0)
      if not task.instance.taskObjectsByActorID["Tanner 2"].coreData.agent.controlled then
        if not localPlayer.inZap then
          localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
        end
        localPlayer:SetZapLevel(0, task.instance.taskObjectsByActorID["Tanner 2"].coreData.agent, true)
        localPlayer:blockAbility("zap", true)
      end
    elseif task.specialName == "mission end zap" then
      OneShotSound.Play("HUD_Play_Waypoint")
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP02", nil, "missionCritical")
    elseif task.specialName == "mission end" then
      local function completeTask()
        progressionSystem.challengeComplete(task.instance, task.agent.matrix)
      end
      setupEndScreen(task)
      params.dialogue = "GPMV01_SUCCESS_L_1"
      params.rating = "PASS"
      params.hint = "ID:245619"
      feedbackSystem.stopMusic("Uid02306_CH04_Story_CollateralDamage_Cue02_Stop")
      localPlayer:exitCutsceneMode()
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    end
  else
    setupEndScreen(task)
    if task.specialName == "Felony chase" then
      params.vehicle = felony_chase.endScreenVehicle
      params.dialogue = "GPMV01_FAILURE_L_1"
      params.hint = "ID:235487"
      params.reason = "Wrecked"
      if task.condition == 2 then
        params.reason = "Lost getaway"
        params.failReason = task.instance.challenge.taskCompleteData["Failure reason"]
      end
    else
      params.reason = "Wrecked"
      params.dialogue = "GPMV01_FAILURE_L_2"
      params.hint = "ID:235491"
    end
    local function failTask()
      progressionSystem.challengeFailed(task.instance, task.agent.matrix)
    end
    if task.specialName == "evade civs" or task.specialName == "mission end" then
      params.vehicle = task.instance.taskObjectsByActorID["Tanner 2"].coreData.agent
      feedbackSystem.stopMusic("Uid02306_CH04_Story_CollateralDamage_Cue02_Stop")
    end
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Collateral Damage"] = function(instance)
  if groundRavenID then
    characterManager.removeRavenGroup(groundRavenID)
    groundRavenID = nil
  end
  feedbackSystem.stopRavensSound()
  localPlayer:exitCutsceneMode()
  localPlayer.inCountdownMode = false
  localPlayer:blockAbility("zap", false)
  removeUserUpdateFunction(skidHalt)
  removeUserUpdateFunction(afterSoftSave)
  removeUserUpdateFunction(firstPip)
  removeUserUpdateFunction(glowEffect)
  removeUserUpdateFunction("timeBetweenAttacks")
  removeUserUpdateFunction("AddAudio")
  checkpointSystem.deleteInstanceCheckpoints(instance)
  attackType = 1
  propSystem.reenableAllPropTypes()
  Atlas.JerichoAlleyWayActive(false)
  civAllowedAttack = false
  timeBetweenAttacks = 2
  firstPipPlayed = false
  skidSequence = true
  delay = false
  waitingForZapTransition = false
  zapTransitionFinished = false
  currentJerichoGameVehicle = nil
  tannerLowSpeedStart = nil
  tannerLowSpeedOverride = false
  tannerSpeedExploitBlock = 10
end
