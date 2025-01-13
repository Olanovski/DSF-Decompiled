module("cardSystem.logic")
missionSetupData["Car park"] = {}
local leftPillarPositions = {
  vec.vector(-3602.769, 7.530242, -5069.317, 1),
  vec.vector(-3602.672, 7.530242, -5094.84, 1),
  vec.vector(-3602.826, 7.530242, -5114.659, 1),
  vec.vector(-3602.714, 7.530242, -5134.619, 1),
  vec.vector(-3602.902, 7.530242, -5154.623, 1),
  [17] = vec.vector(-3602.866, 7.530242, -5180.423, 1)
}
local rightPillarPositions = {
  vec.vector(-3565.333, 7.530242, -5069.342, 1),
  vec.vector(-3565.169, 7.530242, -5094.788, 1),
  vec.vector(-3565.317, 7.530242, -5114.774, 1),
  vec.vector(-3565.167, 7.530242, -5134.533, 1),
  vec.vector(-3565.277, 7.530242, -5154.803, 1),
  [17] = vec.vector(-3565.069, 7.530242, -5180.41, 1)
}
local pillarData = {leftPillarPositions, rightPillarPositions}
local carParkCorners = {
  vec.vector(-3550.522, 7.529666, -5070.36, 1),
  vec.vector(-3550.42, 7.529169, -5179.228, 1),
  vec.vector(-3617.417, 7.530735, -5179.313, 1),
  [15] = vec.vector(-3617.476, 7.530581, -5070.28, 1)
}
local fixedCamPositions = {
  vec.vector(-3617.8, 9.8, -5178.2, 1),
  vec.vector(-3617.8, 9.8, -5070.5, 1),
  vec.vector(-3617.8, 9.8, -5144.3, 1),
  vec.vector(-3617.8, 9.8, -5124.7, 1),
  vec.vector(-3617.8, 9.8, -5105.2, 1),
  vec.vector(-3549, 9.8, -5178.2, 1),
  vec.vector(-3549, 9.8, -5070.5, 1),
  vec.vector(-3549, 9.8, -5144.3, 1),
  vec.vector(-3549, 9.8, -5124.7, 1),
  vec.vector(-3549, 9.8, -5105.2, 1),
  vec.vector(-3585, 9.8, -5178.2, 1),
  vec.vector(-3585, 9.8, -5070.5, 1),
  vec.vector(-3585, 9.8, -5144.3, 1),
  vec.vector(-3585, 9.8, -5124.7, 1),
  [18] = vec.vector(-3585, 9.8, -5105.2, 1)
}
local seriousCollision = false
local timeSinceLastCollision = g_NetworkTime
local damageApplied = false
local playerVehicle
local startTime = false
local challengeTime = 60
local tutorialStarted = false
local function collisionCheck(collisionData)
  seriousCollision = true
  timeSinceLastCollision = g_NetworkTime
end
local callbackSettings = {callbackFunction = collisionCheck, minimumForce = 3500}
local function tannerTask(goalParams, HUD)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait for countdown",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3},
              feedback = "Time"
            }
          }
        },
        HUD = {
          {
            style = "Car park hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Fail conditions",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            failCondition = true,
            forceTaskComplete = true,
            {
              goal = "Time trigger",
              params = {
                value = goalParams["Time limit"]
              }
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
              goal = "Agent had specified number of collisions in car park",
              params = {value = 4}
            }
          }
        },
        HUD = {
          {
            style = "Car park hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Speed",
        taskConditions = {
          {
            {
              goal = "Above speed",
              params = {value = 60}
            }
          }
        },
        HUD = {
          {
            style = "Car park hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Brake",
        taskConditions = {
          {
            {
              goal = "Car park brake test",
              params = {
                speedAbove = 60,
                percent = 65,
                timeForChange = 1.5
              }
            }
          }
        },
        HUD = {
          {
            style = "Car park hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Burnout",
        taskConditions = {
          {
            {
              goal = "Player has performed a burnout",
              params = {time = 37.5}
            }
          }
        },
        HUD = {
          {
            style = "Car park hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Handbrake turn",
        taskConditions = {
          {
            {
              goal = "Player has performed a handbrake turn",
              params = {angle = 0.5}
            }
          }
        },
        HUD = {
          {
            style = "Car park hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Reverse 180",
        taskConditions = {
          {
            {
              goal = "Player has performed a reverse 180"
            }
          }
        },
        HUD = {
          {
            style = "Car park hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "360 spin",
        taskConditions = {
          {
            {
              goal = "Player has spun X degrees",
              params = {angle = 360}
            }
          }
        },
        HUD = {
          {
            style = "Car park hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Slalom",
        taskConditions = {
          {
            {
              goal = "Performed slalom in car park",
              params = {pillars = pillarData, timeLimit = 4}
            }
          }
        },
        HUD = {
          {
            style = "Car park hud"
          }
        }
      },
      {
        task = "No AI",
        specialName = "Lap",
        taskConditions = {
          {
            {
              goal = "Performed lap in car park",
              params = {
                corners = carParkCorners,
                timeLimit = 5,
                hotspotRadius = 28.5
              }
            }
          }
        },
        HUD = {
          {
            style = "Car park hud"
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "All stunts completed",
        taskConditions = {
          {
            {
              goal = "Is player controlled"
            }
          }
        },
        HUD = {
          {
            style = "Car park hud"
          }
        }
      }
    }
  }
  return task
end
local staticTask = function(goalParams, HUD)
  local task = {
    deleteTaskObjectOnCompletion = true,
    {
      {task = "No AI"}
    }
  }
  return task
end
missionSetupData["Car park"].taskCreatorFunctionLookups = {
  ["Tanner team"] = tannerTask,
  ["Static team"] = staticTask
}
missionSetupData["Car park"].initiate = function(instance)
  localPlayer:blockAbility("zap", true)
  localPlayer:blockAbility("nitro", true)
  localPlayer:blockAbility("ram", true)
  scoreSystem.blockWillpowerPrompt(true)
  enableAbilities(localPlayer.localID, false)
  characterManager.DisablePeds()
  spooling.enableTraffic(false)
  localPlayer.minimapSupport:hide()
  playerVehicle = instance.taskObjectsByActorID.Tanner.coreData.agent
  seriousCollision = false
  timeSinceLastCollision = g_NetworkTime
  damageApplied = false
  playerVehicle.collisions = 0
  playerVehicle:addCollisionCallback(callbackSettings)
  startTime = false
  challengeTime = 60
  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  localPlayer:enterCutsceneMode()
  Sound.OverrideEnvironment("ART_REVERB_UNDERPASS", 1)
  IntelligentCamera.ClearTargets()
  IntelligentCamera.AddVehicleTarget(playerVehicle.gameVehicle)
  IntelligentCamera.SetPresetPreferences("Garage")
  for index, position in next, fixedCamPositions, nil do
    IntelligentCamera.AddFixedCameraPosition(position)
  end
end
missionSetupData["Car park"].update = function(instance)
  if not gameStatus.simulationPaused then
    if startTime then
      challengeTime = g_NetworkTime - startTime
    end
    if playerVehicle.collisions == 0 and seriousCollision then
      if not damageApplied then
        playerVehicle:removeCollisionCallback(callbackSettings)
        feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Cross01", 1)
        OneShotSound.Play("HUD_Gen_Currency_Fail")
        damageApplied = true
      end
      if g_NetworkTime > timeSinceLastCollision + 2 then
        playerVehicle.collisions = 1
        seriousCollision = false
        damageApplied = false
        playerVehicle:addCollisionCallback(callbackSettings)
      end
    elseif playerVehicle.collisions == 1 and seriousCollision then
      if not damageApplied then
        playerVehicle:removeCollisionCallback(callbackSettings)
        feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Cross02", 1)
        OneShotSound.Play("HUD_Gen_Currency_Fail")
        damageApplied = true
      end
      if g_NetworkTime > timeSinceLastCollision + 2 then
        playerVehicle.collisions = 2
        seriousCollision = false
        damageApplied = false
        playerVehicle:addCollisionCallback(callbackSettings)
      end
    elseif playerVehicle.collisions == 2 and seriousCollision then
      if not damageApplied then
        playerVehicle:removeCollisionCallback(callbackSettings)
        feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Cross03", 1)
        OneShotSound.Play("HUD_Gen_Currency_Fail")
        damageApplied = true
      end
      if g_NetworkTime > timeSinceLastCollision + 2 then
        playerVehicle.collisions = 3
        seriousCollision = false
        damageApplied = false
        playerVehicle:addCollisionCallback(callbackSettings)
      end
    elseif playerVehicle.collisions == 3 and seriousCollision and not damageApplied then
      playerVehicle:removeCollisionCallback(callbackSettings)
      damageApplied = true
      playerVehicle.collisions = 4
      seriousCollision = false
    end
  end
end
taskCompleteData["Car park"] = {}
taskCompleteData["Car park"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = task.agent,
    cameraShots = cameraShots[2],
    successReason = "ID:231231",
    failReason = "ID:231222",
    hint = "ID:246663",
    driverIsTanner = true
  }
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.specialName == "Start Challenge tutorial" then
    if not tutorialStarted then
      tutorialStarted = true
      ProfileSettings.SetToolTipShown(toolTipLookupTable.Challenge)
      CutsceneFiles.tutorials.playTutorial("ID:245644")
    end
  elseif task.specialName == "Start Movie Challenge tutorial" then
    if not tutorialStarted then
      tutorialStarted = true
      ProfileSettings.SetToolTipShown(toolTipLookupTable["Movie Challenge"])
      CutsceneFiles.tutorials.playTutorial("ID:245648")
    end
  elseif task.specialName == "Wait for countdown" then
    localPlayer:exitCutsceneMode({hudPanels = true})
    localPlayer.minimapSupport:hide()
    startTime = g_NetworkTime
    feedbackSystem.menusMaster.primaryTextPromptParam({
      prompt = "ID:247340",
      delay = true,
      priority = 1
    })
  elseif task.specialName == "All stunts completed" then
    scoreSystem.blockWillpowerPrompt(false)
    local function completeTask()
      progressionSystem.challengeComplete(task.instance, task.agent.matrix)
      Achievements.UnlockAchievement(AchievementTable.AchievementID.FANSERVICE.achievementID)
    end
    feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Display", 0)
    if challengeTime < math.floor(singlePlayerStatistics.getScoreStatistic()) / 100 then
      params.rating = "PASS"
      params.callback = completeTask
      singlePlayerStatistics.updateScoreStatistic(challengeTime, "Time")
      feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_1_timer_mins", string.format("%02d", challengeTime / 60))
      feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_1_timer_secs", string.format("%02d", math.mod(challengeTime, 60)))
      feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_1_timer_milli", string.sub(math.mod(challengeTime, 1), 3, 4))
      feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_1_timer_colon", ":")
      feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_1_timer_dot", ".")
    else
      params.callback = failTask
      params.rating = "FAIL"
    end
    localPlayer.challenge.endScreen(taskObject, params)
  elseif task.specialName == "Fail conditions" then
    feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Display", 0)
    params.callback = failTask
    params.rating = "FAIL"
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
missionEndCallback["Car park"] = function(instance)
  localPlayer:blockAbility("zap", false)
  localPlayer:blockAbility("nitro", false)
  localPlayer:blockAbility("ram", false)
  scoreSystem.blockWillpowerPrompt(false)
  characterManager.EnablePeds()
  CVehicleSFX.clearSkidmarks()
  instance.taskObjectsByActorID.Tanner.coreData.agent:removeCollisionCallback(callbackSettings)
  localPlayer.minimapSupport:show()
  IntelligentCamera.ClearTargets()
  feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Display", 0)
  Sound.RestoreEnvironment()
  for k, v in next, carParkCorners, nil do
    if userUpdateFunctions["Exited " .. tostring(v)] then
      removeUserUpdateFunction("Exited " .. tostring(v))
    end
  end
end
