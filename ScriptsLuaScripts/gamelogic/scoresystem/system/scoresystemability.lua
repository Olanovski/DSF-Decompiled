module("scoreSystem")
local defaultMultiplier = 1
local capacityLookup = {
  [100] = 1,
  [120] = 2,
  [140] = 3,
  [160] = 4
}
local playerData = {
  [0] = {
    stopDrain = false,
    stopGain = false,
    timeGain = true,
    multiplier = defaultMultiplier,
    capacity = abilities.abilityBarUpgrade.getMaxAbilityForLevel(1),
    abilityUseSettings = zap.settings.spZapSettings,
    showFeedback = true,
    HUDBar = "iZapFuel_Bar"
  }
}
playerData[1] = deepCopy(playerData[0])
local onlineLowAbilityThreshold = 25
local lowAbilityThreshold = 0
local unlimitedAbility = false
local availableFeedbackShown = false
blockedFeedbackOn = false
function setUnlimitedAbility(state)
  unlimitedAbility = state
  for localID, player in next, localPlayerManager.players, nil do
    if state then
      maxAbility(localID)
    end
    stopAbilityDrain(localID, state)
  end
end
local function updateAbilityBar(localID, enable)
  local sizeSet = false
  local function delayedUpdate()
    if not sizeSet then
      if gameStatus.onlineSession then
        feedbackSystem.menusMaster.currentHUDSetVariable("iResourceBar_Type", 1)
      else
        feedbackSystem.menusMaster.currentHUDSetVariable("iResourceBar_Type", 0)
      end
      feedbackSystem.menusMaster.currentHUDSetVariable("iResource_Bar_Size", capacityLookup[playerData[localID].capacity])
      sizeSet = true
    else
      if playerData[localID].showFeedback and not gameStatus.splitscreenSession and not feedbackSystem.unlockPanelSupport.rewardPanelActive then
        feedbackSystem.menusMaster.currentHUDSetVariable("iZapFuel_Display", 1)
        if localPlayer.currentVehicle and localPlayer.currentVehicle.abilityActive then
          feedbackSystem.menusMaster.currentHUDSetVariable("iZapFuel_Use", 1)
        end
      else
      end
      removeUserUpdateFunction("updatingAbilityBar")
    end
  end
  if localPlayer.currentVehicle and localPlayer.currentVehicle.abilityActive then
    feedbackSystem.menusMaster.currentHUDSetVariable("iZapFuel_Use", 0)
  end
  feedbackSystem.menusMaster.currentHUDSetVariable("iZapFuel_Display", 0)
  if enable then
    addUserUpdateFunction("updatingAbilityBar", delayedUpdate, 0.1, true)
  end
end
function setAbilityBarCapacity(localID, capacity)
  localID = localID or 0
  if capacityLookup[capacity] then
    playerData[localID].capacity = capacity
    updateAbilityBar(localID)
  end
end
function setAbilityBarRecharge(localID, multiplier)
  localID = localID or 0
  playerData[localID].multiplier = multiplier
end
local showBlockedShiftFeedback = function(toggle)
  if localPlayer.getTaskObject() and localPlayer.getTaskObject().coreData.instance.isChallenge then
    setZapBlocked(localPlayer.localID, toggle)
  else
    setZapBlocked(localPlayer.localID, false)
  end
end
function showAbilityFeedback(localID, toggle)
  localID = localID or 0
  playerData[localID].showFeedback = toggle
  if not gameStatus.splitscreenSession and not feedbackSystem.unlockPanelSupport.rewardPanelActive then
    playerData[localID].HUDBar = "iZapFuel_Bar"
    if not gameStatus.splitscreenSession then
      updateAbilityBar(localID, toggle)
      showBlockedShiftFeedback(toggle)
    end
  elseif gameStatus.splitscreenSession then
    if localID == 0 then
      playerData[localID].HUDBar = "iSS_p1_ability_anim"
    else
      playerData[localID].HUDBar = "iSS_p2_ability_anim"
    end
  end
end
function setAbilityUseSettings(localID, settings)
  playerData[localID].abilityUseSettings = settings
end
function showAbilityUse(localID, state)
  if playerData[localID].showFeedback then
    if not gameStatus.splitscreenSession then
      feedbackSystem.menusMaster.currentHUDSetVariable("iZapFuel_Use", state and 0)
    else
      assert(localID == 0 or localID == 1, "showAbilityUse - bad local ID")
      if localID == 0 then
        feedbackSystem.menusMaster.splitscreenSetVariable("iZapFuel_P1_Use", state and 0)
      else
        feedbackSystem.menusMaster.splitscreenSetVariable("iZapFuel_P2_Use", state and 0)
      end
    end
  end
end
function stopAbilityDrain(localID, toggle)
  playerData[localID].stopDrain = unlimitedAbility or toggle or false
end
function stopAbilityGain(localID, toggle)
  playerData[localID].stopGain = toggle or false
end
function setTimeAbilityGain(localID, gain)
  playerData[localID].timeGain = gain
end
function maxAbility(localID)
  localID = localID or 0
  localPlayer.pointSync.setSyncedAbilityPoints(localPlayerManager.players[localID], playerData[localID].capacity)
end
function emptyAbility(localID)
  localID = localID or 0
  localPlayer.pointSync.setSyncedAbilityPoints(localPlayerManager.players[localID], 0)
end
function getAbility(localID)
  localID = localID or 0
  return localPlayerManager.players[localID].abilityPoints
end
function setAbility(localID, points)
  localID = localID or 0
  local plr = localPlayerManager.players[localID]
  points = math.min(points, playerData[localID].capacity)
  plr.pointSync.setSyncedAbilityPoints(plr, points)
end
function getMaxAbility(localID)
  localID = localID or 0
  return playerData[localID].capacity
end
function tutorialMode(localID, state)
  if state then
    setAbilityBarRecharge(localID, 15)
  else
    setAbilityBarRecharge(localID, abilities.abilityBarRecharge.getLevel() or defaultMultiplier)
  end
end
function increaseAbility(player, increment)
  local localID = player.localID
  if not playerData[localID].stopGain then
    increment = math.min(player.abilityPoints + increment * playerData[localID].multiplier, playerData[localID].capacity)
    player.pointSync.setSyncedAbilityPoints(player, increment)
    return true
  end
  return false
end
function decreaseAbility(player, decrement)
  if not playerData[player.localID].stopDrain or zapWeaponSupport.zapAttackData.unlimitedAbilityPoints then
    decrement = math.max(player.abilityPoints - decrement, 0)
    player.pointSync.setSyncedAbilityPoints(player, decrement)
    return true
  end
  return false
end
function setZapBlocked(localID, status)
  blockedFeedbackOn = status
  if not gameStatus.splitscreenSession then
    feedbackSystem.menusMaster.currentHUDSetVariable("iShift_Blocked", status and 0)
  end
end
function enoughAbilityToUseNitro(localID)
  localID = localID or 0
  if gameStatus.onlineSession and not gameStatus.splitscreenSession then
    return math.floor(getAbility(localID)) > onlineLowAbilityThreshold
  else
    return math.floor(getAbility(localID)) > lowAbilityThreshold
  end
end
function enoughAbilityToUseShift(localID)
  localID = localID or 0
  if gameStatus.onlineSession and not gameStatus.splitscreenSession then
    return math.floor(getAbility(localID)) >= onlineLowAbilityThreshold
  else
    return math.floor(getAbility(localID)) >= lowAbilityThreshold
  end
end
function enteringZap(localID)
  localID = localID or 0
  playerData[localID].enterZapTime = g_NetworkTime
  local plr = localPlayerManager.players[localID]
  decreaseAbility(plr, playerData[localID].zapOutCost.amount)
end
function exitingZap(localID)
  localID = localID or 0
  playerData[localID].exitZapTime = g_NetworkTime
  local plr = localPlayerManager.players[localID]
  if not gameStatus.splitscreenSession then
    feedbackSystem.menusMaster.currentHUDSetVariable("iZapFuel_Use", 0)
  else
    assert(localID == 0 or localID == 1, "showAbilityUse - bad local ID")
    if localID == 0 then
      feedbackSystem.menusMaster.splitscreenSetVariable("iZapFuel_P1_Use", 0)
    else
      feedbackSystem.menusMaster.splitscreenSetVariable("iZapFuel_P2_Use", 0)
    end
  end
end
local abilityIcons = {nitro = 1, ram = 2}
function activeAbilityIcon(localID)
  if playerData[localID].showFeedback then
    local activeAbilityName = localPlayerManager.players[localID].currentVehicle.activeAbilityName
    feedbackSystem.menusMaster.currentHUDSetVariable("iAbility_Use_Icon", abilityIcons[activeAbilityName] or 1)
  end
end
local regenBlockingAbilities = {ram = true, nitro = true}
local function updatePlayerAbility(plr)
  local localID = plr.localID
  local playerData = playerData[localID]
  local timeSinceLastStep = 1 / updates.scoreSystem
  for settingType, abilitySettings in next, playerData.abilityUseSettings, nil do
    for i = 1, #abilitySettings do
      if plr.abilityPoints >= abilitySettings[i].range then
        playerData[settingType] = abilitySettings[i]
      end
    end
  end
  local runZapFuelUpdate = false
  if plr and not gameStatus.simulationPaused and not gameStatus.onlinePaused and not progressionSystem.applyingChapterSettings and not localPlayer.challenge.showingEndScreen and not scoreSystem.showingRewardScreen and not feedbackSystem.unlockPanelSupport.rewardPanelActive then
    runZapFuelUpdate = true
  end
  if plr and plr.currentVehicle and plr.currentVehicle.activeAbilityName ~= "none" then
    local holdModifier = math.max(1 - abilities.getAbilityHoldDecayRate(plr.currentVehicle.activeAbilityName) * (g_NetworkTime - plr.currentVehicle.abilityStartTime), (abilities.getAbilityHoldDecayMin(plr.currentVehicle.activeAbilityName)))
    decreaseAbility(plr, timeSinceLastStep * holdModifier * abilities.getAbilityHoldValue(plr.currentVehicle.activeAbilityName))
    runZapFuelUpdate = not regenBlockingAbilities[plr.currentVehicle.activeAbilityName]
  end
  if not gameStatus.onlineSession and not unlockProgressionTable.zapFuelEnabled then
    runZapFuelUpdate = false
  end
  if playerData.enterZapTime then
    if g_NetworkTime - playerData.enterZapTime >= playerData.zapAbilityDegen.primerSecs then
      playerData.enterZapTime = nil
    else
      runZapFuelUpdate = false
    end
  end
  if playerData.exitZapTime then
    if g_NetworkTime - playerData.exitZapTime >= playerData.zapAbilityRegen.primerSecs then
      playerData.exitZapTime = nil
    else
      runZapFuelUpdate = false
    end
  end
  if plr and plr.currentVehicle and plr.currentVehicle.abilityStopTime > 0 then
    if g_NetworkTime - plr.currentVehicle.abilityStopTime >= playerData.zapAbilityRegen.abilityPrimerSecs then
      plr.currentVehicle.abilityStopTime = 0
    else
      runZapFuelUpdate = false
    end
  end
  if gameStatus.onlineSession then
    zapWeaponSupport.displayZapWeaponCooldown()
    zapWeaponSupport.updateAvailableWeaponDisplay()
  end
  if runZapFuelUpdate then
    if 0 < zapcontroller.getZapLevel(localID) and plr.inZap and not vehicleManager.previewVehicleManager.previewVehicle then
      if 0 < playerData.zapAbilityDegen.amount then
        decreaseAbility(plr, timeSinceLastStep * playerData.zapAbilityDegen.amount)
      else
        increaseAbility(plr, timeSinceLastStep * -playerData.zapAbilityDegen.amount)
      end
    elseif not plr.zapTransition and playerData.timeGain then
      increaseAbility(plr, timeSinceLastStep * playerData.zapAbilityRegen.amount)
    end
  end
  playerData.lastStep = g_NetworkTime
  if playerData.showFeedback then
    if not gameStatus.splitscreenSession then
      feedbackSystem.menusMaster.currentHUDSetVariable(playerData.HUDBar, plr.abilityPoints)
      if gameStatus.onlineSession and not scoreSystem.blockedFeedbackOn then
        if plr.abilityPoints >= playerData.abilityUseSettings.zapOutCost[1].amount and not availableFeedbackShown then
          feedbackSystem.menusMaster.currentHUDSetVariable("iAbility_Active", 1)
          availableFeedbackShown = true
        elseif plr.abilityPoints < playerData.abilityUseSettings.zapOutCost[1].amount and availableFeedbackShown then
          availableFeedbackShown = false
        end
      end
    else
      feedbackSystem.menusMaster.splitscreenSetVariable(playerData.HUDBar, plr.abilityPoints)
    end
  end
end
function update()
  for localID, player in next, localPlayerManager.players, nil do
    updatePlayerAbility(player)
  end
end
local intiate = function()
  if not gameStatus.splitscreenSession then
    feedbackSystem.menusMaster.masterSetVariable("iAbility_Bar", 0)
    feedbackSystem.menusMaster.masterSetVariable("iAbility_Display", 0)
  end
end
addInitObject(intiate)
