module("cardSystem.logic")
missionSetupData["Final fight"] = {}
local colour = vec.vector(1, 0, 0, 1)
local possessedVehicleIDs = {}
local possessedVehicleNumber = 0
local numberAllowedToBePossessed = 3
local function civAttack(gameVehicle, instance)
  if gameVehicle.owner ~= "VehiclePossessor" then
    SNVID = VehiclePossessor.PossessVehicle(gameVehicle, 20, 300, 70)
    if SNVID ~= 0 then
      ZapAIPresence.Settings({
        Height = 50,
        Radius = 1,
        TransitionInTime = 1,
        Color = vec.vector(40, 40, 40, 1)
      })
      ZapAIPresence.StartTransition(nil, gameVehicle)
      SNV.setFlashColour(SNVID, colour)
      vec.vector(1, 0, 0, 0)
      local velocity, direction = vec.vector(0, 0, 0, 0), vec.vector(0, 0, 0, 0)
      local soundPos = gameVehicle.position
      OneShotSound.PlayAtPosition("Jericho_Shift_OneShot", soundPos, velocity, direction, false)
      zapcontroller.AddLockedVehicle({gameVehicle = gameVehicle})
      possessedVehicleNumber = possessedVehicleNumber + 1
      if gameVehicle then
        possessedVehicleIDs[gameVehicle] = {}
        table.insert(possessedVehicleIDs[gameVehicle], feedbackSystem.newTarget({gameVehicle = gameVehicle}, "Possessed vehicles"))
      end
    end
  end
end
local vehicleSearchParameters = {
  ignoreSciptOwnedVehicles = true,
  ignoreCops = true,
  scoring = {
    sameRoad = {condition = false, discard = false},
    discardIfConditionsNotMet = {condition = true, speed = 0},
    ahead = {condition = true, discard = true},
    sameDirection = {condition = false, discard = false},
    proximity = true,
    print = false,
    drawDebug = false
  }
}
local civAllowedAttack = false
local playerTask = function(goalParams, HUD, audio)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {
        task = "No AI",
        specialName = "Mission start",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "chase jericho",
        goalConditions = {
          {
            {
              goal = "Getaway damage above",
              params = {value = 1}
            }
          },
          {
            skipTargetUpdate = true,
            {
              goal = "Getaway damage above",
              params = {value = 0.5}
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
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "All chaser teammates wrecked"
            }
          },
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Getaway escaped"
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
            style = "Final fight hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Objective prompt & initial speech sample",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Prompt active",
              params = {promptType = "Primary", inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1.5}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Prompt active",
              params = {promptType = "Primary"}
            },
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        HUD = {
          {
            style = "Final fight hud"
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "jericho radius warning",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1, inverse = true}
            },
            {
              goal = "Losing getaway"
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            },
            {
              goal = "Losing getaway",
              params = {inverse = true}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            },
            {
              goal = "Losing getaway"
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
        specialName = "trigger attackers",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 10}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "In civilian or tanner",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Player zap status has changed",
              params = {transition = "out"}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1, inverse = true}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Player zap status has changed",
              params = {transition = "out"}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            },
            {
              goal = "Time trigger",
              params = {value = 0.5}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Player zap status has changed",
              params = {transition = "out"}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1, inverse = true}
            },
            {
              goal = "Current vehicle height is less than",
              params = {value = 2.5, inverse = true}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.25}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "In zap",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 4}
            },
            {
              goal = "Player in zap",
              params = {value = true, numberOfTimes = 4}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Tanner health",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            },
            {
              goal = "Chaser damage has changed by",
              params = {ID = 1, value = 0.01}
            },
            {
              goal = "Specified chaser damage above",
              params = {ID = 1, value = 0.25}
            },
            {
              goal = "Specified chaser damage above",
              params = {
                ID = 1,
                value = 0.5,
                inverse = true
              }
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            },
            {
              goal = "Chaser damage has changed by",
              params = {ID = 1, value = 0.01}
            },
            {
              goal = "Specified chaser damage above",
              params = {ID = 1, value = 0.5}
            },
            {
              goal = "Specified chaser damage above",
              params = {
                ID = 1,
                value = 0.75,
                inverse = true
              }
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            triggerCount = 2,
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1}
            },
            {
              goal = "Chaser damage has changed by",
              params = {ID = 1, value = 0.01}
            },
            {
              goal = "Specified chaser damage above",
              params = {ID = 1, value = 0.75}
            },
            {
              goal = "Specified chaser damage above",
              params = {ID = 1, value = 1}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            triggerCount = 5,
            {
              goal = "Time trigger",
              params = {value = 4}
            },
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1, inverse = true}
            },
            {
              goal = "Chaser damage has changed by",
              params = {ID = 1, value = 0.01}
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
        specialName = "Still in Tanner not hurting Jericho",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 150}
            },
            {
              goal = "Player controlling specified chaser",
              params = {ID = 1, inverse = true}
            },
            {
              goal = "Getaway damage above",
              params = {value = 0.25, inverse = true}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Getaway damage above",
              params = {value = 0.25}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Getaway damage above",
              params = {value = 0.5}
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "Player speed checks to stop the possessed",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Below speed",
              params = {value = 15}
            },
            {
              goal = "Losing getaway"
            },
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          },
          {
            {
              goal = "Above speed",
              params = {value = 15}
            },
            {
              goal = "Losing getaway",
              params = {inverse = true}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Not End Mission",
        taskConditions = {
          {
            {
              goal = "Player using zap return",
              params = {inverse = true}
            },
            {
              goal = "Player in zap transition",
              params = {value = false}
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
        specialName = "Top Zap",
        taskConditions = {
          {
            {
              goal = "Player in zap",
              params = {levelOfZap = 5}
            },
            {
              goal = "Time trigger",
              params = {value = 1.5, takeZapIntoAccount = true}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "End Mission",
        taskConditions = {
          {
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            },
            {
              goal = "Event active",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 0.01, takeZapIntoAccount = true}
            }
          }
        }
      }
    }
  }
  return task
end
local doomedTask = function(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait for your inevitable demise"
      }
    }
  }
  return task
end
missionSetupData["Final fight"].taskCreatorFunctionLookups = {
  ["Tanner team"] = doomedTask,
  ["Jericho team"] = doomedTask,
  ["Player team"] = playerTask
}
local timer = 0
local attackDelay = 5
local attackTime = 3
local loadAudioCallBack = function()
  feedbackSystem.startMusic("Uid08526_CH08_Standard_VoicesInMyHead_Play")
end
missionSetupData["Final fight"].initiate = function(instance)
  createCheckpoints(instance)
  ZapAIPresence.Settings({
    Height = 50,
    Radius = 1,
    TransitionInTime = 1,
    Color = vec.vector(40, 40, 40, 1)
  })
  ZapAIPresence.StartTransition(nil, instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle)
  instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.speed = 17.88
  instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle.speed = 22.35
  Commentary.OverrideZapTransition(true)
  Sound.LoadMission(cards.Missions[instance.challenge.name].MissionID, loadAudioCallBack)
  scoreSystem.showAbilityFeedback(localPlayer.localID, true)
  scoreSystem.maxAbility(localPlayer.localID)
  InterestingVehicleManager.Enable(false)
  feedbackSystem.menusMaster.masterSetVariable("iShowPIP", 1)
  local evaderGameVehicle = instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle
  local chaserGameVehicle = instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle
  felony_chase.startChase(evaderGameVehicle, chaserGameVehicle)
  VehiclePossessor.SetAttackTarget(chaserGameVehicle)
end
missionSetupData["Final fight"].update = nil
local firstCollisionAudioPlayed = false
function _G.vehicleOrphaned(gameVehicle, SNVID, IsHit)
  if possessedVehicleIDs[gameVehicle] then
    for i, k in ipairs(possessedVehicleIDs[gameVehicle]) do
      feedbackSystem.clearTarget(k)
    end
    possessedVehicleIDs[gameVehicle] = nil
  end
  possessedVehicleNumber = possessedVehicleNumber - 1
  zapcontroller.RemoveLockedVehicle({gameVehicle = gameVehicle})
  if IsHit and not isEventActive() then
    if not firstCollisionAudioPlayed then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_2", nil, "missionCritical")
      firstCollisionAudioPlayed = true
    elseif firstCollisionAudioPlayed then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_2B", nil, "missionCritical")
    end
  end
  SNV.resetFlashColour(SNVID)
end
function _G.vehicleDestroyed(gameVehicle, SNVID)
  if possessedVehicleIDs[gameVehicle] then
    for i, k in ipairs(possessedVehicleIDs[gameVehicle]) do
      feedbackSystem.clearTarget(k)
    end
    possessedVehicleIDs[gameVehicle] = nil
  end
  possessedVehicleNumber = possessedVehicleNumber - 1
  zapcontroller.RemoveLockedVehicle({gameVehicle = gameVehicle})
  SNV.resetFlashColour(SNVID)
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
missionSetupData["Final fight"].targetList = {
  ["Tanner team"] = getTannerTeamDynamicTargets
}
taskCompleteData["Final fight"] = {}
local params
local function setupEndScreen(task)
  params = {
    vehicle = felony_chase.endScreenVehicle,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"]
  }
  feedbackSystem.stopMusic("Uid08526_CH08_Standard_VoicesInMyHead_Stop")
  removeUserUpdateFunction("waves")
  removeUserUpdateFunction("attack")
end
local playerIsASittingDuck = false
missionSetupData["Final fight"].goalComplete = function(taskObject, task, conditionKey)
  if task.specialName == "Still in Tanner not hurting Jericho" then
    if conditionKey == 2 then
      attackTime = 3
      numberAllowedToBePossessed = 4
    elseif conditionKey == 3 then
      attackTime = 2
      numberAllowedToBePossessed = 5
    end
  elseif task.specialName == "Player speed checks to stop the possessed" then
    if conditionKey == 1 and not playerIsASittingDuck then
      civAllowedAttack = false
      playerIsASittingDuck = true
      VehiclePossessor.OrphanAllPossessed()
    elseif conditionKey == 2 and playerIsASittingDuck then
      civAllowedAttack = true
      playerIsASittingDuck = false
    end
  end
end
taskCompleteData["Final fight"].taskComplete = function(taskObject, task)
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.success then
    if task.specialName == "chase jericho" then
      removeUserUpdateFunction("waves")
      removeUserUpdateFunction("attack")
      VehiclePossessor.OrphanAllPossessed()
      Commentary.StopCommentary()
    elseif task.specialName == "Not End Mission" then
      ReplaySystem.StartScriptedCamera()
      localPlayer:enterCutsceneMode()
      localPlayer:SetZapLevel(5, nil, false)
    elseif task.specialName == "End Mission" then
      setupEndScreen(task)
      params.rating = "PASS"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "trigger attackers" then
      local initialDelay = g_NetworkTime
      local audioDelay
      local didFirstAttack = false
      local notifyAttack = function()
        if not localPlayer.eventActive then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_3")
          removeUserUpdateFunction("notifyAttack")
        end
      end
      local randomNumber = 0
      local function attacking()
        if civAllowedAttack and (g_NetworkTime - attackDelay > attackTime or possessedVehicleNumber <= 0) and possessedVehicleNumber <= numberAllowedToBePossessed and localPlayer.primaryFelony.getawayGameVehicle and Chase.IsAChaseActive() then
          attackDelay = g_NetworkTime
          if not didFirstAttack then
            didFirstAttack = true
            addUserUpdateFunction("notifyAttack", notifyAttack, 120, true)
          end
          local position = vec.vector()
          local gameVehicle = localPlayer.primaryFelony.chasers[1]
          local vehicle
          position = position:add(gameVehicle.matrix[3], gameVehicle.matrix[2] * (gameVehicle.speed * 4))
          vehicle = vehicleManager.findVehiclesInTraffic(position, localPlayer.primaryFelony.chasers[1].matrix[2], 150, vehicleSearchParameters, 1)
          if Chase.IsAChaseActive() or Getaway.IsAGetawayActive() then
            if vehicle and vehicle[1] and vehicle[1] ~= localPlayer.primaryFelony.getawayGameVehicle then
              civAttack(vehicle[1], task.instance)
            elseif not randomNumber == 2 then
              OneShotSound.Play("Jericho_Shift_OneShot")
              civAttack(nil, task.instance)
            end
            if randomNumber ~= 1 and vehicle[1] and vehicle[1] ~= localPlayer.primaryFelony.getawayGameVehicle and randomNumber == 2 then
              randomNumber = 0
            end
          end
        end
      end
      addUserUpdateFunction("attack", attacking, 60)
      civAllowedAttack = true
      timer = g_NetworkTime
    end
  else
    setupEndScreen(task)
    VehiclePossessor.OrphanAllPossessed()
    if task.specialName == "chase jericho" and task.condition == 2 then
      params.failReason = "ID:184961"
      params.hint = "ID:235491"
      params.dialogue = "GPMV00_FAILURE_L_1"
      params.driverIsTanner = true
    else
      params.failReason = "ID:231140"
      params.hint = "ID:235491"
      params.dialogue = "GPMV00_FAILURE_L_2"
    end
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Final fight"] = function(instance)
  removeUserUpdateFunction("waves")
  removeUserUpdateFunction("attack")
  civAllowedAttack = false
  Commentary.OverrideZapTransition(false)
  InterestingVehicleManager.Enable(true)
  feedbackSystem.stopMusic("Uid08526_CH08_Standard_VoicesInMyHead_Stop")
  firstCollisionAudioPlayed = false
  possessedVehicleNumber = 0
  VehiclePossessor.OrphanAllPossessed()
  ReplaySystem.StopScriptedCamera()
end
