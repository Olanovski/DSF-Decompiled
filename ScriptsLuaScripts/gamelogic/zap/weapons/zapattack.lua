module("zap.zapAttack", package.seeall)
lockOnThreshold = 1.25
offLockThreshold = 2
overchargeThreshold = 10
overchargeFlashTime = 3
impulseStrengthMin = 0.4
impulseStrengthMax = 1
impulseStrengthScaleStart = 0.4
impulseStrengthScale = 1
impulseDamageMin = 0
impulseDamageMax = 0.5
impulseDamageScaleStart = 0.4
impulseDamageScale = 0.833
local collisionLocked = false
local collisionTypeValue = 0
local collisionFailed = true
local startTime = -1
local prevStepTime = -1
local lockOnVehicle = -1
local lockOnTime = -1
local offLockTime = -1
local totalOffLockTime = -1
local chargeSoundOn = false
local overchargeDisplayOn = false
local lowAbilityWarningOn = false
local prevLockOnPercent = 0
tutorialPromptsActive = false
tutorialPromptsActive2 = false
local collisionTutorial = false
local isActive = false
local overCharged = false
local zapAttackCallback = false
function isZapAttackActive()
  return isActive
end
function addAttackCallback(callback)
  zapAttackCallback = callback
end
function clearAttackCallback()
  zapAttackCallback = false
end
local function resetLockOnHUD()
  feedbackSystem.menusMaster.currentHUDSetVariable("iZap_Attack_Bar", 0)
  OneShotSound.Play("HUD_Online_Weapons_Reticule_Stop")
  OneShotSound.Play("HUD_Online_Weapons_Reticule_LockOn_Stop")
  prevLockOnPercent = 0
  chargeSoundOn = false
end
local function resetLockOnTimers()
  if vehicleManager.vehiclesByGameVehicle[lockOnVehicle] then
    zapcontroller.ClearZapAttackGlow(lockOnVehicle)
  end
  lockOnVehicle = -1
  lockOnTime = -1
  offLockTime = -1
  totalOffLockTime = -1
  resetLockOnHUD()
end
_G.tzResetLockOnTimers = resetLockOnTimers
local function StepLockOnEffect()
  local disableLockOn, currentLockOnPercent = getLockOnTValue()
  if prevLockOnPercent ~= currentLockOnPercent then
    feedbackSystem.menusMaster.currentHUDSetVariable("iZap_Attack_Bar", math.floor(currentLockOnPercent * 100))
    if zapcontroller.SetZapAttackGlow(lockOnVehicle, currentLockOnPercent) then
      if currentLockOnPercent == 1 then
        OneShotSound.Play("HUD_Online_Weapons_Reticule_Stop")
        OneShotSound.Play("HUD_Online_Weapons_Reticule_LockOn_Play")
        chargeSoundOn = false
      elseif currentLockOnPercent > 0 then
        if not chargeSoundOn then
          OneShotSound.Play("HUD_Online_Weapons_Reticule_Play", false)
          chargeSoundOn = true
        end
      else
        OneShotSound.Play("HUD_Online_Weapons_Reticule_LockOn_Stop")
        OneShotSound.Play("HUD_Online_Weapons_Reticule_Stop")
        chargeSoundOn = false
      end
      prevLockOnPercent = currentLockOnPercent
    else
      resetLockOnTimers()
    end
  end
end
local function ZapAttackActive()
  if g_NetworkTime - startTime >= overchargeThreshold then
    removeUserUpdateFunction("ZapAttackActive")
    overCharged = true
    zapcontroller.ZapAttackShoot()
  else
    if not lowAbilityWarningOn and g_NetworkTime - startTime >= overchargeThreshold / 2 then
      zapcontroller.ZapAttackLowAbilityWarning()
    end
    if not overchargeDisplayOn and g_NetworkTime - startTime >= overchargeThreshold - overchargeFlashTime then
      feedbackSystem.menusMaster.currentHUDSetVariable("iZap_Attack_Overload", 1)
      OneShotSound.Play("HUD_Online_Weapons_Reticule_Overcharge")
      overchargeDisplayOn = true
    end
  end
  if lockOnVehicle ~= -1 then
    lockOnTime = g_NetworkTime - prevStepTime + lockOnTime
    StepLockOnEffect()
    if offLockTime > -1 and offLockTime < offLockThreshold then
      offLockTime = g_NetworkTime - prevStepTime + offLockTime
      totalOffLockTime = g_NetworkTime - prevStepTime + totalOffLockTime
    elseif offLockTime >= offLockThreshold then
      resetLockOnTimers()
    end
  end
  prevStepTime = g_NetworkTime
end
function isZapAttackInTolerance()
  if offLockTime > -1 then
    return true
  end
  return false
end
_G.IsZapAttackInTolerance = isZapAttackInTolerance
local function zapAttackButtonPressed()
  startTime = g_NetworkTime
  prevStepTime = g_NetworkTime
  addUserUpdateFunction("ZapAttackActive", ZapAttackActive, 2)
  isActive = true
  collisionTypeValue = 1
  collisionFailed = true
  overCharged = false
  zapWeaponSupport.setSwapSpawnUnavailableFeedback()
end
local function zapAttackButtonReleased()
  removeUserUpdateFunction("ZapAttackActive")
  feedbackSystem.menusMaster.currentHUDSetVariable("iZap_Attack_Overload", 0)
  overchargeDisplayOn = false
  lowAbilityWarningOn = false
  zapWeaponSupport.setZapWeaponFireTime(collisionFailed, 2)
  if tutorialPromptsActive then
    if not collisionTutorial then
      if overCharged then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:236027")
      else
        feedbackSystem.menusMaster.primaryTextPrompt("ID:235751")
        feedbackSystem.menusMaster.secondaryTextPrompt("ID:243705")
      end
    end
    collisionTutorial = false
  end
  isActive = false
  Mood.removeMood("Impulse_Attack", 0, -1, 0)
end
local function zapAttackReticuleOnVehicle(gameVehicle)
  if lockOnVehicle ~= gameVehicle then
    lockOnVehicle = gameVehicle
    lockOnTime = 0
    offLockTime = -1
    totalOffLockTime = 0
  else
    offLockTime = -1
  end
end
local function zapAttackReticuleOffVehicle(gameVehicle)
  if lockOnVehicle == gameVehicle then
    OneShotSound.Play("HUD_Online_Weapons_Reticule_Stop")
    chargeSoundOn = false
    offLockTime = 0
  end
end
zap.AddZapCallbacks("zapAttackButtonPressed", zapAttackButtonPressed)
zap.AddZapCallbacks("zapAttackButtonReleased", zapAttackButtonReleased)
zap.AddZapCallbacks("zapAttackReticuleOnVehicle", zapAttackReticuleOnVehicle)
zap.AddZapCallbacks("zapAttackReticuleOffVehicle", zapAttackReticuleOffVehicle)
function isAvailable()
  if (localPlayer.blockedAbilities.ZapAttack or not onlineProgressionSystem.onlineWeaponData[4].unlocked) and (localPlayer.blockedAbilities.ZapImpulse or not onlineProgressionSystem.onlineWeaponData[2].unlocked) then
    return false
  end
  if zapcontroller.IsZapSpawnInProcess() then
    print("IsZapSpawnInProcess")
    return false
  end
  if onlineProgressionSystem.onlineWeaponData[2].unlocked or onlineProgressionSystem.onlineWeaponData[4].unlocked then
    if zapWeaponSupport.areZapWeaponsAvailable() then
      if tutorialPromptsActive and not overCharged and zapcontroller.getZapLevel(0) > 1 then
        if tutorialPromptsActive2 then
          onlineInstructionSupport.displayPrompt("ID:243704", localPlayer.buttonLayout.zapDown)
        else
          onlineInstructionSupport.displayPrompt("ID:243706", localPlayer.buttonLayout.zapDown)
        end
      end
      return true
    else
      OneShotSound.Play("HUD_Online_Weapons_Unavailable")
    end
  end
  if tutorialPromptsActive and not overCharged then
    if zapcontroller.getZapLevel(0) == 1 then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:235967")
    elseif tutorialPromptsActive2 then
      onlineInstructionSupport.displayPrompt("ID:243704", localPlayer.buttonLayout.zapDown)
    else
      onlineInstructionSupport.displayPrompt("ID:243706", localPlayer.buttonLayout.zapDown)
    end
  end
  return false
end
_G.tzIsAvailable = isAvailable
function expend()
  resetLockOnHUD()
end
_G.tzExpend = expend
function cancelZapAttack()
  startTime = g_NetworkTime
  collisionLocked = false
  resetLockOnHUD()
end
_G.tzCancel = cancelZapAttack
function collision()
  assert(not collisionLocked)
  local gameVehicle = zapcontroller.GetZapAttackVehicle()
  assert(gameVehicle)
  collisionLocked = true
  if not vehicleManager.vehiclesByGameVehicle[gameVehicle] then
    vehicleManager.takeOwnership({gameVehicle = gameVehicle})
  end
  doZapAttackIntoVehicle(vehicleManager.vehiclesByGameVehicle[gameVehicle])
  return true
end
_G.tzCollision = collision
local isTargetOnYourTeam = function(target)
  for playerID, player in next, playerManager.players, nil do
    if player.currentVehicle == target then
      local localTaskObject = localPlayer.getTaskObject()
      if localTaskObject and localTaskObject.coreData.instance and localTaskObject.coreData.instance.challenge.settings.teamGame and PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == PlayerGamePlay.getPlayerTeam(player.playerID) then
        return true
      end
      break
    end
  end
  return false
end
local isTargetAPlayer = function(target)
  for playerID, player in next, playerManager.players, nil do
    if player.currentVehicle == target then
      return true
    end
  end
  return false
end
function pushed(attackerPlayerid)
  local removeMood = function()
    Mood.removeMood("Impulse_Attack", 1.5, -1, 0)
  end
  if gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode then
    feedbackSystem.eventMessages.addMessage(1, playerManager.players[attackerPlayerid].name, "ID:243746", "", attackerPlayerid, false)
  end
  Mood.addMoodUserDefinedOverrideZap(moodSystem.Impulse_Attack, "Impulse_Attack", 1, 0, removeMood, 0)
end
_G.tzPushed = pushed
function taken(attackerPlayerid)
  feedbackSystem.eventMessages.addMessage(1, playerManager.players[attackerPlayerid].name, "ID:243747", "", attackerPlayerid, false)
end
_G.tzTaken = taken
function collisionType()
  local target = vehicleManager.vehiclesByGameVehicle[zapcontroller.GetZapAttackVehicle()]
  collisionFailed = true
  if target then
    if zapAttackCallback then
      zapAttackCallback(target)
    end
    if tutorialPromptsActive then
      collisionTutorial = true
    end
    local restriction = taskSystem.isAgentRestricted(target, 1)
    if restriction == 2 or 1 <= target.damage or isTargetOnYourTeam(target) then
      return 2
    elseif restriction or not isTargetAPlayer(target) and not target:getTaskObject() then
      resetLockOnTimers()
      return 1
    end
    collisionFailed = false
    if lockOnTime - totalOffLockTime >= lockOnThreshold then
      resetLockOnTimers()
      return 0
    end
    if tutorialPromptsActive2 then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:235968")
    end
    resetLockOnTimers()
    return 1
  else
    if tutorialPromptsActive then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:235751")
    end
    resetLockOnTimers()
    return 1
  end
end
function getCollisionType()
  local tempCollisionTypeValue = collisionType()
  if tempCollisionTypeValue == 0 then
    if not onlineProgressionSystem.onlineWeaponData[4].unlocked then
      tempCollisionTypeValue = 1
    end
    if not tutorialPromptsActive and not tutorialPromptsActive2 then
      if gameStatus.onlineSessionType and gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
        local timesUsed = ProfileSettings.GetNumSuccessfulPublicZapAttacks() + 1
        OnlineAchievements.onValueChange("Zap Attacks", timesUsed)
        ProfileSettings.SetNumSuccessfulPublicZapAttacks(timesUsed)
      end
      ProfileSettings.SetNumSuccessfulZapAttacks(ProfileSettings.GetNumSuccessfulZapAttacks() + 1)
    end
  end
  if tempCollisionTypeValue == 1 then
    OneShotSound.Play("HUD_Online_ZapAttack_PlayerPush")
  end
  collisionTypeValue = tempCollisionTypeValue
  return collisionTypeValue
end
_G.tzGetCollisionType = getCollisionType
function getLockOnTValue()
  local disableLockOn = false
  local lockOnPercent = 0
  if not onlineProgressionSystem.onlineWeaponData[2].unlocked then
    disableLockOn = true
  else
    local target = vehicleManager.vehiclesByGameVehicle[lockOnVehicle]
    if target and (taskSystem.isAgentRestricted(target, 1) or not isTargetAPlayer(target) and not target:getTaskObject() or isTargetOnYourTeam(target) or 1 <= target.damage) then
      disableLockOn = true
    end
  end
  if not disableLockOn then
    lockOnPercent = (lockOnTime - totalOffLockTime) / lockOnThreshold
    if lockOnPercent > 1 then
      lockOnPercent = 1
    end
  end
  return not disableLockOn, lockOnPercent
end
_G.tzGetLockOnTValue = getLockOnTValue
function doZapAttackIntoVehicle(vehicle)
  NetworkLog.Write(">[LUA] ZAP ATTACK - Doing zap attack into vehicle, SNVID = " .. tostring(vehicle.SNVID) .. ", vehicle isLocal = " .. tostring(vehicle.isLocal) .. ", vehicle owner playerID = " .. tostring(SNV.getSNVOwner(vehicle.SNVID)))
  collisionLocked = false
  localPlayer:SetZapLevel(0, vehicle, true)
end
function getTargetAttackType()
  local target = vehicleManager.vehiclesByGameVehicle[zapcontroller.GetZapAttackVehicle()]
  if target then
    local restriction = taskSystem.isAgentRestricted(target, 1)
    if restriction == 2 or 1 <= target.damage then
      return 2
    elseif restriction then
      return 1
    end
    if not isTargetAPlayer(target) then
      if not target:getTaskObject() then
        return 1
      end
    elseif isTargetOnYourTeam(target) then
      return 2
    end
  else
    return 1
  end
  return 0
end
_G.GetTargetAttackType = getTargetAttackType
function getImpulseModifier(_lockOnPercent)
  print("getImpulseModifier _lockOnPercent: " .. tostring(_lockOnPercent))
  if _lockOnPercent < impulseStrengthScaleStart then
    return impulseStrengthMin
  end
  return math.min(impulseStrengthMin + (_lockOnPercent - impulseStrengthScaleStart) * impulseStrengthScale, impulseStrengthMax)
end
_G.getImpulseModifier = getImpulseModifier
function getImpulseDamage(_lockOnPercent)
  local targetVehicle = vehicleManager.vehiclesByGameVehicle[zapcontroller.GetZapAttackVehicle()]
  if targetVehicle and targetVehicle.networkVars.multiplayerBus then
    return 0
  elseif not tutorialPromptsActive then
    print("getImpulseDamage _lockOnPercent: " .. tostring(_lockOnPercent))
    if _lockOnPercent < impulseDamageScaleStart then
      return impulseDamageMin
    end
    return math.min(impulseDamageMin + (_lockOnPercent - impulseDamageScaleStart) * impulseDamageScale, impulseDamageMax)
  else
    print(">>>>>>>>>>>>>>>>> Tutorial impulse damage fun")
    local playerTO = localPlayer.getTaskObject()
    assert(playerTO, "getImpulseDamage - tutorial damage, no task object found")
    local instance = playerTO.coreData.instance
    assert(instance, "getImpulseDamage - tutorial damage, no instance found")
    assert(instance.challenge.settings.tutorial, "getImpulseDamage - tutorial damage, instance is not a tutorial")
    local objVehicleTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    assert(objVehicleTO, "getImpulseDamage - tutorial damage, objective task object not found")
    assert(objVehicleTO.coreData.agent, "getImpulseDamage - tutorial damage, objective agent not found")
    local damage = 0
    if objVehicleTO.coreData.agent.gameVehicle.damage < 0.2 then
      if _lockOnPercent < impulseDamageScaleStart then
        damage = impulseDamageMin
      else
        damage = math.min(impulseDamageMin + (_lockOnPercent - impulseDamageScaleStart) * impulseDamageScale, impulseDamageMax)
      end
      if objVehicleTO.coreData.agent.gameVehicle.damage + damage > 0.2 then
        damage = 0.2 - objVehicleTO.coreData.agent.gameVehicle.damage
      end
    end
    print(">>>>>>>>>>>>>>>>> Tutorial impulse damage fun - damage = " .. tostring(damage) .. "  vehicle current damage = " .. tostring(objVehicleTO.coreData.agent.gameVehicle.damage))
    return damage
  end
  assert(false, "getImpulseDamage - MEGA ERROR")
end
_G.getImpulseDamage = getImpulseDamage
function PlayZapAttackerMood(fZoomPercentage)
  Mood.addMoodUserDefinedOverrideZap(moodSystem.Impulse_Attack, "Impulse_Attack", fZoomPercentage, 0, -1, 0)
end
_G.PlayZapAttackerMood = PlayZapAttackerMood
function PlayBeingAttackedMood(fPercentage)
  Mood.addMoodUserDefinedOverrideZap(moodSystem.Impulse_Target, "Impulse_Target", fPercentage, 0, -1, 0)
end
_G.PlayBeingAttackedMood = PlayBeingAttackedMood
function StopBeingAttackedMood()
  Mood.removeMood("Impulse_Target", 0, -1, 0)
end
_G.StopBeingAttackedMood = StopBeingAttackedMood
