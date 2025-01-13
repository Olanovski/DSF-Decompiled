module("felony_suspiciousVehicleManager", package.seeall)
function startFelony(suspiciousGameVehicle, copGameVehicle)
  activeChallenges.disableActivities()
  local freeDriveSettings = felony_chase.getChaseSettings()
  localPlayer:createFelony(suspiciousGameVehicle, freeDriveSettings)
  if copGameVehicle then
    felony_chase.disownAgent(copGameVehicle)
    localPlayer:addChaser(suspiciousGameVehicle, copGameVehicle)
  end
  GameVehicleResource.setDisableAllDamage(copGameVehicle, true)
  GameVehicleResource.setDisableAllDamage(suspiciousGameVehicle, true)
  Chase.Start(suspiciousGameVehicle, copGameVehicle, "Freedrive", freeDriveSettings)
  FelonyVehicleSpawnManager.ClearModelTypes()
  FelonyVehicleSpawnManager.AddModelType(copGameVehicle.model_id, 1, nil)
end
local collisionCallback = function(collisionInfo)
  local copGameVehicle = SuspiciousVehicleManager.GetVehicleBeingWatched()
  local suspiciousGameVehicle = collisionInfo.GameVehicle
  if not copGameVehicle then
    return
  end
  if collisionInfo.CollidedGameVehicle == copGameVehicle then
    startFelony(suspiciousGameVehicle, copGameVehicle)
  end
end
function suspiciousVehicleAdded(suspiciousGameVehicle)
  collision_system.RegisterCollisionCallback(suspiciousGameVehicle, collisionCallback)
end
function suspiciousVehicleRemoved(suspiciousGameVehicle)
  collision_system.UnRegisterCollisionCallback(suspiciousGameVehicle, collisionCallback)
end
function enableSuspiciousVehicles(enable)
  local chapter = challengeProgressionTable[progressionSystem.currentProgression].settings.chapter
  if enable and chapter > 0 and not dareSystem.isDareActive() and not localPlayer.primaryFelony.getawayGameVehicle and not localPlayer:getTaskObject() then
    SuspiciousVehicleManager.Enable(true)
  else
    SuspiciousVehicleManager.Enable(false)
  end
end
