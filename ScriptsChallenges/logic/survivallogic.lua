module("cardSystem.logic")
missionSetupData.Survival = {}
local timer, launchedVehicle, chuckTime, startTime, damageWitness, lastWitnessUpdate, damageTimer, damageRelief, difficultyLevel
local function collisionCheck(collisionData)
  if collisionData.CollidedGameVehicle and collisionData.CollidedGameVehicle.owner == "VehicleLauncher" then
    launchedVehicle = true
  end
end
local callbackSettings = {callbackFunction = collisionCheck, typeOfHit = "Vehicle"}
local vehicleSearchParametersStopped = {
  idealDistance = 25,
  ignoreSciptOwnedVehicles = true,
  ignoreOrphans = true,
  ignoreThrown = true,
  ignoreCops = true
}
local vehicleSearchParametersMoving = {
  idealDistance = 45,
  ignoreSciptOwnedVehicles = true,
  ignoreOrphans = true,
  ignoreThrown = true,
  ignoreCops = true,
  scoring = {
    ahead = {condition = true, discard = true},
    sameRoad = {condition = true, discard = true},
    sameDirection = {condition = true, discard = false}
  }
}
local tutorialStarted = false
local tannerTask = function(goalParams, HUD)
  local task = {
    {
      {
        task = "No AI",
        specialName = "Wait for countdown",
        HUD = {
          {
            style = "Survival hud"
          }
        },
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 3},
              feedback = "Time"
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "End conditions",
        taskConditions = {
          {
            forceTaskComplete = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          },
          {
            forceTaskComplete = true,
            {
              goal = "Specified actors in mission",
              params = {
                actorIDs = {"Jericho"}
              }
            },
            {
              goal = "Within radius of specified actor",
              params = {
                actorID = "Jericho",
                value = 300,
                inverse = true
              }
            },
            {
              goal = "Losing getaway time trigger",
              params = {value = 10, prompt = "ID:236625"}
            }
          }
        },
        HUD = {
          {
            style = "Survival hud"
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
        specialName = "Wait for attacks",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 5}
            }
          }
        }
      }
    }
  }
  return task
end
local jerichoTask = function(goalParams, HUD, audio)
  local task = {
    enableNonPlayerFeedback = true,
    deleteVehicleOnCompletion = true,
    {
      {
        task = "Follow Route",
        specialName = "Jericho task",
        groupProgression = {importantMinorOrder = false}
      }
    }
  }
  return task
end
missionSetupData.Survival.taskCreatorFunctionLookups = {
  ["Player team"] = tannerTask,
  ["Jericho team"] = jerichoTask
}
function missionSetupData.Survival.initiate(instance)
  timer = g_NetworkTime
  launchedVehicle = false
  chuckTime = 3
  startTime = nil
  damageWitness = 0
  lastWitnessUpdate = 0
  damageTimer = 0
  damageRelief = 5
  difficultyLevel = 0
  GameVehicleResource.setInfiniteMass(instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle, true)
  instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle.performance = 1.25
  instance.taskObjectsByActorID.Tanner.coreData.agent:addCollisionCallback(callbackSettings)
  localPlayer:blockAbility("zap", true)
  scoreSystem.blockWillpowerPrompt(true)
  Sfx.SetJerichoCityLightning(true)
  VehicleLauncher.Settings({
    LaunchAngle = 75,
    LaunchVelocity = 23,
    SecondImpulseTime = 0.1,
    TravelTime = 1.2
  })
  if userUpdateFunctions.throw then
    removeUserUpdateFunction("throw")
  end
  localPlayer:enterCutsceneMode()
end
missionSetupData.Survival.update = nil
local getPlayerDynamicTargets = function(taskObject, task, dynamicListID)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID.Jericho.coreData.agent
    }, false
  end
end
missionSetupData.Survival.targetList = {
  ["Player team"] = getPlayerDynamicTargets
}
taskCompleteData.Survival = {}
function taskCompleteData.Survival.taskComplete(taskObject, task)
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
  elseif task.specialName == "Wait for tutorial" then
  elseif task.specialName == "Wait for countdown" then
    localPlayer:exitCutsceneMode()
    feedbackSystem.menusMaster.primaryTextPromptParam({
      prompt = "ID:248694",
      delay = true,
      priority = 1
    })
  elseif task.specialName == "Wait for attacks" then
    local function throwCars()
      local workingVector = vec.vector()
      local vehicleList = {}
      if not startTime then
        startTime = g_NetworkTime
      end
      if damageRelief > 0 then
        if localPlayer.currentVehicle.damage - damageWitness >= 0.1 and launchedVehicle == true then
          launchedVehicle = false
          damageTimer = g_NetworkTime
          damageWitness = localPlayer.currentVehicle.damage
        elseif g_NetworkTime - lastWitnessUpdate >= 1 then
          damageWitness = localPlayer.currentVehicle.damage
          lastWitnessUpdate = g_NetworkTime
        end
        if damageTimer ~= 0 and g_NetworkTime - damageTimer > damageRelief then
          damageTimer = 0
        end
        if g_NetworkTime - startTime > 22 and damageRelief > 3 then
          damageRelief = 3
        end
        if g_NetworkTime - startTime > 52 and damageRelief > 0 then
          damageRelief = 0
          damageTimer = 0
        end
      end
      if task.instance.taskObjectsByActorID.Tanner and g_NetworkTime - timer > chuckTime and damageTimer == 0 and task.instance.taskObjectsByActorID.Tanner.coreData.agent.speed > 10 then
        vehicleSearchParametersMoving.scoring.sameDirection.condition = localPlayer.currentVehicle:get_withTrafficFlow()
        vehicleList = {}
        vehicleList = vehicleManager.findVehiclesInTraffic(task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.position, task.instance.taskObjectsByActorID.Tanner.coreData.agent.matrix[2], 90, vehicleSearchParametersMoving, 1)
        if vehicleList[1] then
          ZapAIPresence.Settings({
            Radius = 0.5,
            TransitionInTime = 0.2,
            Color = vec.vector(40, 40, 40, 1)
          })
          ZapAIPresence.StartTransition(nil, vehicleList[1])
          GameVehicleResource.setFlashColour(vehicleList[1], vec.vector(1, 0, 0, 1))
          VehicleLauncher.VehicleToVehicle(vehicleList[1], task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle, vec.vector(1, 0, 1, 1))
          if difficultyLevel == 0 and g_NetworkTime - task.instance.networkVars.startTime > 33 then
            chuckTime = 2
            VehicleLauncher.Settings({
              LaunchAngle = 80,
              LaunchVelocity = 23,
              SecondImpulseTime = 0.1,
              TravelTime = 1.2
            })
            vehicleSearchParametersMoving.idealDistance = 40
            difficultyLevel = 1
          elseif difficultyLevel == 1 and g_NetworkTime - task.instance.networkVars.startTime > 63 then
            chuckTime = 1
            VehicleLauncher.Settings({
              LaunchAngle = 80,
              LaunchVelocity = 24,
              SecondImpulseTime = 0.1,
              TravelTime = 1.1
            })
            vehicleSearchParametersMoving.idealDistance = 40
            difficultyLevel = 2
          elseif difficultyLevel == 2 and g_NetworkTime - task.instance.networkVars.startTime > 123 then
            chuckTime = 0.7
            VehicleLauncher.Settings({
              LaunchAngle = 80,
              LaunchVelocity = 24,
              SecondImpulseTime = 0.1,
              TravelTime = 1.1
            })
            vehicleSearchParametersMoving.idealDistance = 30
            difficultyLevel = 3
          elseif difficultyLevel == 3 and g_NetworkTime - task.instance.networkVars.startTime > 183 then
            chuckTime = 0.4
            VehicleLauncher.Settings({
              LaunchAngle = 85,
              LaunchVelocity = 24,
              SecondImpulseTime = 0.1,
              TravelTime = 1.2
            })
            vehicleSearchParametersMoving.idealDistance = 30
            difficultyLevel = 4
          end
          timer = g_NetworkTime
        end
      end
    end
    addUserUpdateFunction("throw", throwCars, 60, true)
  elseif task.specialName == "End conditions" then
    local params = {
      vehicle = task.agent,
      cameraShots = cameraShots[2],
      successReason = "ID:245583",
      failReason = "ID:231222",
      hint = "ID:246662",
      driverIsTanner = true
    }
    if feedbackSystem.getTimer() > math.floor(singlePlayerStatistics.getScoreStatistic()) / 100 then
      scoreSystem.blockWillpowerPrompt(false)
      local function completeTask()
        progressionSystem.challengeComplete(task.instance, task.agent.matrix)
      end
      params.rating = "PASS"
      params.callback = completeTask
      singlePlayerStatistics.updateScoreStatistic(feedbackSystem.getTimer(), "Time")
    else
      local function failTask()
        progressionSystem.challengeFailed(task.instance, task.agent.matrix)
      end
      params.rating = "FAIL"
      params.callback = failTask
    end
    localPlayer.challenge.endScreen(taskObject, params)
  end
end
function missionEndCallback.Survival(instance)
  removeUserUpdateFunction("throw")
  instance.taskObjectsByActorID.Tanner.coreData.agent:removeCollisionCallback(callbackSettings)
  VehicleLauncher.DeleteAll()
  Sfx.SetJerichoCityLightning(false)
  localPlayer:blockAbility("zap", false)
  scoreSystem.blockWillpowerPrompt(false)
end
