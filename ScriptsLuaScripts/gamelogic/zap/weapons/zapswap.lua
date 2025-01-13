module("zap.zapSwap", package.seeall)
zapSwapCost = -200
zapSwapUseable = {
  [0] = true,
  [1] = true
}
tutorialPromptsActive = false
overideSwapCancel = false
originUserControl = {
  [0] = true,
  [1] = true
}
local zapSwapActive = false
needCameraReset = {}
function reset()
  needCameraReset = {}
  zapSwapUseable[0] = true
  zapSwapUseable[1] = true
  tutorialPromptsActive = false
  overideSwapCancel = false
  originUserControl[0] = true
  originUserControl[1] = true
  zapSwapActive = false
end
function isZapSwapActive()
  return zapSwapActive
end
function shouldCancelSwap(gameVehicle)
  if gameStatus.splitscreenSession then
    return false
  end
  if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle == gameVehicle then
    if overideSwapCancel then
      return false
    end
    local bWeaponsEnabled = zapWeaponSupport.getAreWeaponsEnabled()
    if not bWeaponsEnabled then
      zapSwapActive = false
    end
    return not bWeaponsEnabled
  end
  local instance = false
  local playerTO = localPlayer.getTaskObject()
  if playerTO then
    instance = playerTO.coreData.instance
    if instance.challenge and not instance.challenge.settings.zapLock and not instance.challenge.settings.teamGame and instance.challenge.settings.raceMode then
      local id = false
      local taskObj = false
      local raceCompleted = false
      for playerID, player in next, playerManager.players, nil do
        if player.currentVehicle and player.currentVehicle.gameVehicle == gameVehicle then
          id = playerID
          break
        end
      end
      if not id then
        NetworkLog.Write(">[LUA] shouldCancelSwap - failed to find a player using the passed in gameVehicle: " .. tostring(gameVehicle) .. " returning true")
        return true
      end
      taskObj = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[id + 1]]
      if taskObj and taskObj.namedTasks.checkpoints and taskObj.namedTasks.checkpoints.networkVars.laps > taskObj.namedTasks.checkpoints.coreData.totalLaps then
        raceCompleted = true
      end
      if raceCompleted then
        zapSwapActive = false
      end
      return raceCompleted
    end
  end
  if phaseManager.networkVars.phase > 0 and (phaseManager.networkVars.phase == FreeDriveStateIndex or phaseManager.networkVars.phase == ModeResetStateIndex or phaseManager.networkVars.phase == EndModeStateIndex) then
    if phaseManager.raceModePlayed then
      zapSwapActive = false
    end
    return phaseManager.raceModePlayed
  end
  return false
end
_G.shouldCancelSwap = shouldCancelSwap
function zapSwapAvailable()
  if localPlayer.blockedAbilities.ZapSwap then
    return false
  end
  if zap.zapAttack.isZapAttackActive() then
    return false
  end
  local zapSwapUnlocked = false
  if gameStatus.splitscreenSession then
    return false
  end
  if onlineProgressionSystem.onlineWeaponData[1].unlocked then
    zapSwapUnlocked = true
  end
  if zapSwapUnlocked then
    if zapWeaponSupport.areZapWeaponsAvailable() and zapSwapUseable[0] then
      local gameVehicle
      if not localPlayer.inZap then
        gameVehicle = localPlayer.currentVehicle.gameVehicle
      else
        gameVehicle = zapcontroller.GetTargetedGameVehicle()
      end
      if gameVehicle then
        if 1 <= gameVehicle.damage then
          return false
        end
        if vehicleManager.multiplayerBusManager.multiplayerBus and vehicleManager.multiplayerBusManager.multiplayerBus.gameVehicle == gameVehicle then
          return false
        end
        local target = vehicleManager.vehiclesByGameVehicle[gameVehicle]
        if target and taskSystem.isAgentRestricted(target, 2) then
          return false
        end
        for playerID, player in next, playerManager.players, nil do
          if playerID ~= localPlayer.playerID and player.currentVehicle and player.currentVehicle.gameVehicle and player.currentVehicle.gameVehicle == gameVehicle then
            return false
          end
        end
      end
      return true
    else
      OneShotSound.Play("HUD_Online_Weapons_Unavailable")
      if tutorialPromptsActive then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:235967")
      end
    end
  end
  return false
end
function isSwapAvailable()
  value = zapSwapAvailable()
  return value
end
_G.zapSwopAvailable = isSwapAvailable
function zapSwapTriggered(localID)
  print("zapSwapTriggered")
  zapSwapActive = true
  assert(localPlayerManager.players[localID], "Player not found in the local player manager. localID = " .. tostring(localID))
  local player = localPlayerManager.players[localID]
  if player.currentVehicle then
    player.currentVehicle.blockCamChange = true
  end
  if originUserControl[localID] then
    zapWeaponSupport.setZapWeaponFireTime(false, 1)
  end
  zapSwapUseable[localID] = false
end
_G.zapSwopTriggered = zapSwapTriggered
function zapSwapComplete(localID)
  print("zapSwapComplete")
  zapSwapActive = false
  if not zapSwapUseable[localID] then
    zapSwapUseable[localID] = true
    assert(localPlayerManager.players[localID], "Player not found in the local player manager. localID = " .. tostring(localID))
    local player = localPlayerManager.players[localID]
    if needCameraReset[localID] then
      if player.currentVehicle then
        setActiveCamera(needCameraReset[localID].previousCamera, localID)
      end
      needCameraReset[localID] = {}
    end
    if player.currentVehicle then
      player.currentVehicle.blockCamChange = false
    end
    if zapWeaponSupport.getAreWeaponsEnabled() and onlineProgressionSystem.onlineWeaponData[1].unlocked and originUserControl[localID] then
      if gameStatus.onlineSessionType and gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
        ProfileSettings.SetSwapModel()
        OnlineAchievements.onValueChange("CarSwap", ProfileSettings.GetNumUniqueSwapModel())
      end
      ProfileSettings.SetNumCarSwaps(ProfileSettings.GetNumCarSwaps() + 1)
    end
  end
end
_G.zapSwapComplete = zapSwapComplete
function carSwapTriggered(player, carModelUID)
  if not player.inZap then
    if player.cameraMode == "DriverEye" then
      needCameraReset[player.localID] = {}
      needCameraReset[player.localID].previousCamera = player.cameraMode
      setActiveCamera("Normal", player.localID)
    end
    inBumperOrBonnet = player.cameraMode == "Bonnet" or player.cameraMode == "Bumper"
    if carModelUID ~= nil then
      originUserControl[player.localID] = false
    else
      originUserControl[player.localID] = true
    end
    zapcontroller.carSwap(player.currentVehicle.gameVehicle, not inBumperOrBonnet, carModelUID)
    zapSwapTriggered(player.localID)
  end
end
local swapFinishedCallback = false
function setSwapFinishedCallback(callback)
  swapFinishedCallback = callback
end
function swapFinished(gameVehicle)
  if swapFinishedCallback then
    swapFinishedCallback(gameVehicle)
  end
end
_G.swapFinished = swapFinished
