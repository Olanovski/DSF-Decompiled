module("zap.zapSpawn", package.seeall)
zapSpawnCost = -200
tutorialPromptsActive = false
spawnButtonDown = false
function reset()
  tutorialPromptsActive = false
  spawnButtonDown = false
end
function zapSpawnAvailable()
  if localPlayer.blockedAbilities.ZapSpawn then
    return false
  end
  if zap.zapAttack.isZapAttackActive() then
    return false
  end
  if onlineProgressionSystem.onlineWeaponData[3].unlocked then
    if zapWeaponSupport.areZapWeaponsAvailable() then
      spawnButtonDown = true
      return true
    end
    if tutorialPromptsActive then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:235967")
    end
  end
  return false
end
_G.zapSpawnAvailable = zapSpawnAvailable
function zapSpawnTriggered()
  zapWeaponSupport.setZapWeaponFireTime(false, 3)
  spawnButtonDown = false
end
_G.zapSpawnTriggered = zapSpawnTriggered
function zapSpawnStartZap(parameters)
  local plr = localPlayerManager.players[parameters.localID]
  plr:ZapIntoVehicle(parameters.GameVehicle, false, false, false)
end
_G.zapSpawnStartZap = zapSpawnStartZap
local zapSpawnFailedCallback = {}
function zapSpawnFailed(player)
  spawnButtonDown = false
  for index, callBack in next, zapSpawnFailedCallback, nil do
    callBack()
  end
end
_G.zapSpawnFailed = zapSpawnFailed
function registerZapSpawnFailedCallback(callBack)
  zapSpawnFailedCallback[callBack] = callBack
end
function clearZapSpawnFailedCallback(callBack)
  zapSpawnFailedCallback[callBack] = nil
end
function clearZapSpawnFailedCallbacks()
  zapSpawnFailedCallback = {}
end
function zapSpawnCanceled()
  spawnButtonDown = false
end
_G.zapSpawnCanceled = zapSpawnCanceled
