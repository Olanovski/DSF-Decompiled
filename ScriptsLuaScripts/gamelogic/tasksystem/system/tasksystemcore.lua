module("taskSystem", package.seeall)
goals = {}
taskBuilders = {}
taskObjects = {}
coolDownVehicles = {}
local onlineGameSession
function initialise()
  onlineGameSession = Network.isOnlineGame() or Network.isSplitScreenMode()
end
addInitObject(initialise)
function registerGoal(goalName, goalSettings, goalFunction)
  if LIVERELOAD_ACTIVE then
    print("registerGoal " .. goalName)
  end
  assert(not goals[goalName] or LIVERELOAD_ACTIVE, "TASKSYSTEM - registerGoal: Attempt to re-register existing goal: " .. tostring(goalName))
  goals[goalName] = {
    isParent = goalSettings.parentFunction,
    canTrigger = goalSettings.trigger,
    canFeedback = goalSettings.feedbackOutput,
    goalFunction = goalFunction
  }
end
function registerTask(taskName, networkVars, createFunction)
  if LIVERELOAD_ACTIVE then
    print("registerTask " .. taskName)
  end
  assert(not taskBuilders[taskName] or LIVERELOAD_ACTIVE, "TASKSYSTEM - registerTask: Attempt to re-register existing task: " .. tostring(taskName))
  assert(not networkVars or type(networkVars) == "table" and #networkVars > 0, "TASKSYSTEM - registerTask: Attempt to register task '" .. tostring(taskName) .. "' with empty networkVars data table")
  if networkVars then
    for i, varInfo in ipairs(networkVars) do
      varInfo.name = tostring(varInfo.name)
      varInfo.numID = i
      networkVars[varInfo.name] = varInfo
    end
  end
  taskBuilders[taskName] = {create = createFunction, networkVars = networkVars}
end
function removeMissionSpecifics(agent)
  if agent.markers then
    if gameStatus.splitscreenSession then
      if agent.markers[0] then
        for k, v in next, agent.markers[0], nil do
          Marker:delete(v)
          agent.markers[0][k] = nil
        end
      end
      agent.markers[0] = nil
      if agent.markers[1] then
        for k, v in next, agent.markers[1], nil do
          Marker:delete(v)
          agent.markers[1][k] = nil
        end
      end
      agent.markers[1] = nil
    end
    for k, v in next, agent.markers, nil do
      Marker:delete(v)
      agent.markers[k] = nil
    end
    agent.markers = nil
  end
  zapcontroller.RemoveLockedVehicle({
    gameVehicle = agent.gameVehicle
  })
  if agent.lightTrail then
    if not agent.disableTrailAutoDelete then
      agent:removeLightTrail()
    end
    agent.lightTrail = false
  end
  if agent.siren then
    agent:deactivateSiren()
  end
end
function update()
  if debugInfo.showActiveMissionLogic and debugInfo.showActiveMissionLogic == true then
    debug_DisplayActiveTasks()
  end
  if onlineGameSession then
    for taskObjectID, taskObject in next, taskObjects, nil do
      if taskObject.coreData.isLocal then
        updateSNOFromObject(taskObject)
      elseif taskObject.coreData.agent.isLocal then
        taskObject:migrateToLocal()
      end
    end
  end
  for SNVID, coolDown in next, coolDownVehicles, nil do
    if coolDown < g_NetworkTime then
      coolDownVehicles[SNVID] = nil
    end
  end
  updateRestrictedObjects()
  if onlineGameSession then
    updateNetworkQueue()
  end
end
function forceTaskObjectMinorTaskRefresh()
  if gameStatus.onlineSession or not gameStatus.onlineSession and (activeChallenges.playerPositionBasedMissionsOnWarmup() or not vehicleManager.previewVehicleManager.previewVehicle and localPlayer.getTaskObject()) then
    for taskObjectID, taskObject in next, taskObjects, nil do
      if taskObject.coreData.isLocal then
        taskObject:refreshMinorTaskAI()
      end
    end
  end
end
function purge()
  for taskObjectID, taskObject in next, taskObjects, nil do
    for i, taskGroup in ipairs(taskObject.taskList) do
      for j, task in ipairs(taskGroup) do
        if not task.stopped then
          stopTask(task)
        end
      end
    end
  end
  for SNVID, coolDown in next, coolDownVehicles, nil do
    coolDownVehicles[SNVID] = nil
  end
  taskObjects = {}
  networkQueue.protoObjects = {}
  networkQueue.setAgent = {}
end
local ts_DebugTextID = 88989
local ts_debugText_textPosition = vec.vector(0.25, 0.1, 0, 0)
local ts_debugTextColour = vec.vector(1, 1, 1, 1)
local ts_debugTextColour_stopped = vec.vector(1, 0, 0, 1)
function debug_DisplayActiveTasks()
  local y = 0.1
  debug_removeDisplayActiveTasks()
  for t, taskObject in next, taskSystem.taskObjects, nil do
    for i, taskGroup in ipairs(taskObject.taskList) do
      for j, task in ipairs(taskGroup) do
        if not task.stopped then
          Development:add2DText(ts_DebugTextID, task.taskName, ts_debugText_textPosition, ts_debugTextColour, 0.5, -1)
        else
          Development:add2DText(ts_DebugTextID, task.taskName, ts_debugText_textPosition, ts_debugTextColour_stopped, 0.5, -1)
        end
        ts_DebugTextID = ts_DebugTextID + 1
        y = y + 0.02
        ts_debugText_textPosition[1] = y
      end
    end
  end
end
function debug_removeDisplayActiveTasks()
  local ts_counter
  for ts_counter = 88989, ts_DebugTextID - 1 do
    Development:eraseText(ts_counter)
  end
  ts_DebugTextID = 88989
end
function buildDriveTraits(task)
  local actor = task.actor
  local traits = {}
  traits.matchTrafficSpeed = actor.matchTrafficSpeed
  traits.matchTrafficSpeedMultiplier = actor.matchTrafficSpeedMultiplier
  traits.desiredSpeed = actor.desiredSpeed
  traits.wanderType = actor.wanderType
  traits.avoidAlleyways = actor.avoidAlleys
  traits.driveOnPavements = actor.driveOnPavements
  traits.driveInOncoming = actor.driveInOncoming
  traits.avoidUTurns = actor.avoidUTurns
  traits.collisionResilience = actor.collisionResilience
  traits.avoidAttacks = actor.avoidAttacks
  traits.forceHighLodAi = actor.forceHighLodAi
  traits.drivingSkill = actor.drivingSkill
  traits.ignoreCivilianTraffic = actor.ignoreCivilianTraffic
  traits.ignoreOtherAis = actor.ignoreOtherAis
  traits.maintainLane = actor.maintainLane
  traits.distanceFromFrontOfGroup = actor.distanceFromFrontOfGroup
  traits.unaffectedByRaceSpeedTweaks = actor.unaffectedByRaceSpeedTweaks
  traits.rubberbandingStrength = actor.rubberbandingStrength
  traits.speedMultiplierOverride = actor.speedMultiplierOverride
  traits.distanceBehindPlayer = actor.distanceBehindPlayer
  traits.rubberbandingToPlayerStrength = actor.rubberbandingToPlayerStrength
  traits.rubberBandMinVelocityTopSpeedFraction = actor.rubberBandMinVelocityTopSpeedFraction
  traits.rubberBandIgnoreRaceCheckpoints = actor.rubberBandIgnoreRaceCheckpoints
  traits.avoidedByCivilianTraffic = actor.avoidedByCivilianTraffic
  traits.accidentProbability = actor.accidentProbability
  traits.obeyRaceTowingRules = actor.obeyRaceTowingRules
  if actor.rubberbandingActor and task.instance.taskObjectsByActorID[actor.rubberbandingActor] then
    traits.rubberbandingActor = task.instance.taskObjectsByActorID[actor.rubberbandingActor].coreData.agent.gameVehicle
  end
  traits.spawnSpeed = actor.spawnSpeed
  traits.ignorePlayers = actor.aiIgnorePlayers
  traits.ignoreHiddenVehicles = actor.aiIgnorePlayerInCivsUntilHit
  traits.stayInLockedArea = actor.stayInLockedArea
  return traits
end
function buildChaseTraits(task)
  local actor = task.actor
  local traits = buildDriveTraits(task)
  traits.reactionTime = actor.reactionTime
  traits.tailingDistance = actor.tailingDistance
  traits.groupAggression = actor.groupAggression
  traits.customAggression = actor.customAggression
  traits.ramInFrontDistance = actor.ramInFrontDistance
  traits.ramStationaryDistance = actor.ramStationaryDistance or 20
  traits.attackStationaryVehicle = actor.attackStationaryVehicle
  return traits
end
function validTaskObject(taskObject)
  if taskObject and taskObject.namedTasks and taskObject.coreData and taskObject.coreData.agent then
    return true
  end
  return false
end
local returnValue
function markAllForDeletion()
  returnValue = true
  for taskObjectID, taskObject in next, taskObjects, nil do
    if not taskObject.coreData.flagForDeletion then
      if taskObject.coreData.isLocal then
        taskObject.coreData.flagForDeletion = true
        updateSNOFromObject(taskObject, true)
      end
      returnValue = false
    end
  end
  return returnValue
end
function allObjectsDeleted()
  for taskObjectID, taskObject in next, taskObjects, nil do
    return false
  end
  return true
end
function removeFlaggedForDeletionObjects()
  for taskObjectID, taskObject in next, taskObjects, nil do
    if taskObject.coreData.isLocal and taskObject.coreData.flagForDeletion and taskObject:canBeDeleted() then
      taskObject:delete(false)
    end
  end
end
