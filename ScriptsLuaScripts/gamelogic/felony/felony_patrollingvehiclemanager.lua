module("felony_patrollingVehicleManager", package.seeall)
local copsCurrentlyWarning = {}
local isSirenBlarePlaying = function(patrollingGameVehicle)
  return OneShotSound.IsPlayingOnGameVehicle(patrollingGameVehicle, "Veh_Cop_Siren_Warning_Oneshot")
end
local function warningCopDeleted(patrollingGameVehicle)
  if copsCurrentlyWarning[patrollingGameVehicle] then
    copsCurrentlyWarning[patrollingGameVehicle] = nil
  end
  removeUserUpdateFunction("sirenBlareFor " .. tostring(patrollingGameVehicle))
end
local function updateWarningCops(patrollingGameVehicle)
  return function()
    if not isSirenBlarePlaying(patrollingGameVehicle) or not copsCurrentlyWarning[patrollingGameVehicle] then
      warningCopDeleted(patrollingGameVehicle)
      GameVehicleResource.setLights({
        gameVehicle = patrollingGameVehicle,
        LightType = "Siren",
        State = false
      })
      GameVehicleResource.UnRegisterDeletionCallback(patrollingGameVehicle, warningCopDeleted)
    end
  end
end
local function playSirenBlare(patrollingGameVehicle)
  if not copsCurrentlyWarning[patrollingGameVehicle] then
    OneShotSound.PlayOnGameVehicle(patrollingGameVehicle, "Veh_Cop_Siren_Warning_Oneshot")
    GameVehicleResource.setLights({
      gameVehicle = patrollingGameVehicle,
      LightType = "Siren",
      State = true
    })
    copsCurrentlyWarning[patrollingGameVehicle] = true
    GameVehicleResource.RegisterDeletionCallback(patrollingGameVehicle, warningCopDeleted)
    addUserUpdateFunction("sirenBlareFor " .. tostring(patrollingGameVehicle), updateWarningCops(patrollingGameVehicle), 10)
  end
end
function startFelony(targetGameVehicle, patrollingGameVehicle)
  activeChallenges.disableActivities()
  felony_suspiciousVehicleManager.enableSuspiciousVehicles(false)
  local freeDriveSettings, evaderDamageMultiplier = felony_getaway.getGetawaySettings()
  localPlayer:createFelony(targetGameVehicle, freeDriveSettings)
  local playerTaskObject = localPlayer:getTaskObject()
  if playerTaskObject then
    Getaway.Start(targetGameVehicle, patrollingGameVehicle, "Mission", freeDriveSettings)
  else
    GameVehicleResource.setDisableAllDamage(targetGameVehicle, true)
    Getaway.Start(targetGameVehicle, patrollingGameVehicle, "Freedrive", freeDriveSettings)
  end
  localPlayer:buildZapReturn()
  if evaderDamageMultiplier then
    targetGameVehicle.softness = evaderDamageMultiplier
    if targetGameVehicle.towedVehicle then
      targetGameVehicle.towedVehicle.softness = evaderDamageMultiplier
    end
  end
end
local function collisionCallback(collisionInfo)
  if gameStatus.onlineSession then
    return
  end
  local patrollingGameVehicle = collisionInfo.GameVehicle
  local targetGameVehicle = PatrollingVehicleManager.GetVehicleBeingWatched()
  if not targetGameVehicle then
    return
  end
  if localPlayer.feloniesBlocked then
    playSirenBlare(patrollingGameVehicle)
    return
  end
  if not PatrollingVehicleManager.IsEnabled() or not PatrollingVehicleManager.IsSpawningEnabled() then
    if not Chase.IsAChaser(patrollingGameVehicle) and patrollingGameVehicle.damage < 1 and targetGameVehicle.damage < 1 and collisionInfo.CollidedGameVehicle == targetGameVehicle and not patrollingGameVehicle.isBeingTowed and collisionInfo.Force >= 5000 then
      playSirenBlare(patrollingGameVehicle)
    end
    return
  end
  local startGetaway = false
  if patrollingGameVehicle.damage < 1 and targetGameVehicle.damage < 1 and collisionInfo.CollidedGameVehicle == targetGameVehicle and not patrollingGameVehicle.isBeingTowed then
    local isValidEvader = false
    if GameVehicleResource.getEmergencyType(targetGameVehicle) == 0 or GameVehicleResource.getEmergencyType(targetGameVehicle) == 4 and targetGameVehicle.model_id ~= 62 or targetGameVehicle == progressionSystem.getActivityGameVehicle() then
      isValidEvader = true
      local playerTaskObject = localPlayer:getTaskObject()
      if playerTaskObject then
        local targetAgent = vehicleManager.vehiclesByGameVehicle[targetGameVehicle]
        if targetAgent then
          local targetVehicleTaskObject = targetAgent:getTaskObject()
          if targetVehicleTaskObject then
            isValidEvader = not targetVehicleTaskObject.coreData.actor.unableToStartFelonies
          end
        end
        local felonySettings = playerTaskObject.coreData.instance.challenge.felonySettings
        local vehicleTaskObject = playerTaskObject.coreData.instance.taskObjectsByActorID[felonySettings.onlyVehicleAbleToStartFelonies]
        isValidEvader = vehicleTaskObject and felonySettings and felonySettings.onlyVehicleAbleToStartFelonies and targetGameVehicle == vehicleTaskObject.coreData.agent.gameVehicle
      end
    end
    if isValidEvader then
      if (collisionInfo.WhereIHit == "Front" and collisionInfo.Force >= 2500 or (collisionInfo.WhereIHit == "Side" or collisionInfo.WhereIHit == "Other") and collisionInfo.Force >= 5000 or collisionInfo.Force >= 20000) and collisionInfo.ObjectPreColVelocity:length() < collisionInfo.CollidedObjectPreColVelocity:length() or not isSirenBlarePlaying(patrollingGameVehicle) and copsCurrentlyWarning[patrollingGameVehicle] then
        if copsCurrentlyWarning[patrollingGameVehicle] then
          copsCurrentlyWarning[patrollingGameVehicle] = nil
        end
        startGetaway = true
      else
        playSirenBlare(patrollingGameVehicle)
      end
    elseif collisionInfo.Force >= 5000 then
      playSirenBlare(patrollingGameVehicle)
    end
  end
  if startGetaway then
    PatrollingVehicleManager.RemovePatrollingVehicle(patrollingGameVehicle)
    startFelony(targetGameVehicle, patrollingGameVehicle)
  end
end
function patrollerAdded(patrollerGameVehicle)
  collision_system.RegisterCollisionCallback(patrollerGameVehicle, collisionCallback)
end
function patrollerRemoved(patrollerGameVehicle)
  collision_system.UnRegisterCollisionCallback(patrollerGameVehicle, collisionCallback)
end
local copModelIDs = {
  302,
  271,
  280,
  269,
  265
}
local copChaseIdealMapping = {
  {
    200,
    202,
    153,
    156,
    129,
    164,
    238,
    239,
    146,
    234,
    231,
    192,
    237,
    149,
    62,
    178,
    160,
    188,
    230,
    193,
    233,
    175,
    161,
    205,
    132
  },
  {
    249,
    153,
    156,
    129,
    164,
    238,
    239,
    179,
    184,
    146,
    234,
    231,
    192,
    237,
    187,
    272,
    250,
    149,
    144,
    128,
    62,
    178,
    171,
    258,
    273,
    278,
    160,
    188,
    165,
    282,
    127,
    230,
    193,
    233,
    159,
    148,
    175,
    161,
    205,
    239,
    132,
    124,
    213,
    181,
    274,
    190,
    196,
    136,
    151,
    158,
    248,
    173,
    176,
    133,
    119,
    143,
    207,
    215
  },
  {
    200,
    199,
    288,
    154,
    198,
    156,
    252,
    251,
    180,
    203,
    270,
    281,
    280,
    150,
    138,
    239,
    181
  },
  {
    239,
    124,
    213,
    181,
    196,
    151,
    158,
    248,
    173,
    176,
    133,
    119,
    143,
    207,
    215,
    242,
    147,
    194,
    210,
    182,
    134,
    206,
    255,
    279
  },
  {
    242,
    147,
    194,
    210,
    182,
    134,
    125,
    244,
    211,
    212,
    206,
    255,
    135,
    162,
    139,
    243,
    279,
    189,
    265,
    163,
    241,
    224,
    216,
    226,
    214,
    232,
    240,
    225
  }
}
function setSpawningModels(set)
  local modelIDs = set or copModelIDs
  FelonyVehicleSpawnManager.ClearModelTypes()
  for i = 1, #modelIDs do
    local modelID = modelIDs[i]
    if TrafficSpooler.IsMissionVehicleLoaded(modelID) then
      FelonyVehicleSpawnManager.AddModelType(modelID, 1, copChaseIdealMapping[i])
    end
  end
end
function enablePatrollingVehicles(enable, forceEnable)
  local blockPatrollingVehicles = challengeProgressionTable[progressionSystem.currentProgression].settings.blockPatrollingVehicles
  if enable and (not blockPatrollingVehicles or forceEnable) then
    localPlayer.feloniesBlocked = false
    PatrollingVehicleManager.Enable(true)
    enablePatrollingVehiclesSpawning(true)
  else
    PatrollingVehicleManager.Enable(false)
  end
end
function enablePatrollingVehiclesSpawning(enabled)
  PatrollingVehicleManager.EnableSpawning(enabled)
end
