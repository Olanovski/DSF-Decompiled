module("vehicleManager.multiplayerBusManager", package.seeall)
multiplayerBus = false
multiplayerBusActive = false
playerInMultiplayerBus = false
autoTransitionIntoBus = false
transitionInProgress = false
welcomeMessageShowing = false
welcomeMessageShowTime = false
welcomeMessagePart2 = false
natMessageShowing = false
natMessageShowTime = false
tutorialMessageShowing = false
tutorialMessageShowTime = false
becomeLeaderMessageShowing = false
becomeLeaderMessageShowTime = false
isPlayersFirstTimeInMP = false
remoteBusVehicle = false
local busRoutes
gamerTagStatus = {
  [0] = true,
  [1] = true,
  [2] = true,
  [3] = true,
  [4] = true,
  [5] = true,
  [6] = true,
  [7] = true,
  ["forceOff"] = false
}
local ModelID = 62
local shaderParams = {
  [0] = 0
}
local spawnLocation = {}
local promptEnabled = false
local menuOn = false
local initialPromptDone = false
local lastPromptTime = 0
local initialPromptTime = 30
local extendedPromptTime = 180
local multiplayerBusCreatedMarkers = {}
local multiplayerBusMarkers = {
  multiplayerBusMinimapIcon = {
    type = "Minimap",
    gadgetID = 5,
    colour = vec.vector(0, 182, 255, 255),
    radius = 30,
    visible = true,
    canrotate = false
  },
  multiplayerBusTargetIcon = {
    type = "Target",
    targetType = "MultiplayerObjective",
    gadgetID = 5,
    colour = vec.vector(0, 182, 255, 255),
    radius = 50,
    visible = true,
    markerOffset = 0,
    zapBackPrompt = true,
    zapBackPromptAboveCar = false
  }
}
function loadRoute()
  if not busRoutes then
    busRoutes = routes["Bus Start Locations"]
  end
end
function isLocalBusSpooled()
  if onlineMissionSync.isMissionSynched() and VehicleLodSpooler.IsInteriorLoaded(ModelID) and VehicleLodSpooler.IsExteriorLoaded(ModelID) and VehicleLodSpooler.IsVehicleLoaded(ModelID) and spoolsystem.IsLocationResident(spawnLocation.position) then
    local newBus = vehicleManager.spawnVehicle({
      position = spawnLocation.position,
      heading = spawnLocation.heading,
      modelID = ModelID,
      shader = shaderParams
    })
    spoolsystem.SetSpoolCentreAttachment(localPlayer.localID, newBus.gameVehicle)
    selfRightVehicleList.addTableOfVehicles({
      newBus.gameVehicle
    })
    onMultiplayerBusCreated(newBus)
    addAIToBus(newBus)
    if autoTransitionIntoBus then
      transitionIntoMultiplayerBus()
    end
    removeUserUpdateFunction("isLocalBusSpooled")
  end
end
function createMultiplayerBus()
  NetworkLog.Write(">[LUA] MULTIPLAYER BUS - createMultiplayerBus")
  PauseMenu.allow(false)
  loadRoute()
  onlineMissionSync.setCurrentMissionData(0, ModelID, 0)
  VehicleLodSpooler.RequestVehicle(ModelID)
  local spawnLocationIndex = framework.random(1, #busRoutes.checkpoints)
  spawnLocation = {
    position = busRoutes.checkpoints[spawnLocationIndex].position,
    heading = busRoutes.checkpoints[spawnLocationIndex].heading
  }
  spoolsystem.position = spawnLocation.position
  print("Waiting till bus is spooled...")
  addUserUpdateFunction("isLocalBusSpooled", isLocalBusSpooled, 2)
  removeUserUpdateFunction("hostMigrationBusTest")
end
function isRemoteBusSpooled()
  NetworkLog.Write(">[LUA] MULTIPLAYER BUS - isRemoteBusSpooled")
  if VehicleLodSpooler.IsVehicleLoaded(ModelID) and VehicleLodSpooler.IsExteriorLoaded(ModelID) and VehicleLodSpooler.IsInteriorLoaded(ModelID) and spoolsystem.IsLocationResident(remoteBusVehicle.gameVehicle.position) then
    onMultiplayerBusCreated(remoteBusVehicle)
    transitionIntoMultiplayerBus()
    removeUserUpdateFunction("isRemoteBusSpooled")
  end
end
function createRemoteMultiplayerBus(busVehicle)
  NetworkLog.Write(">[LUA] MULTIPLAYER BUS - createRemoteMultiplayerBus")
  PauseMenu.allow(false)
  remoteBusVehicle = busVehicle
  spoolsystem.SetSpoolCentreAttachment(localPlayer.localID, remoteBusVehicle.gameVehicle)
  onlineMissionSync.addVehicles({ModelID}, 0)
  VehicleLodSpooler.RequestVehicle(ModelID)
  addUserUpdateFunction("isRemoteBusSpooled", isRemoteBusSpooled, 12)
  removeUserUpdateFunction("hostMigrationBusTest")
end
function enableBusSwap(bEnable)
  if onlineProgressionSystem.areZapWeaponsUnlocked() then
    zapWeaponSupport.enableZapWeapons(bEnable)
    ActiveVehicles.enableSystem(bEnable)
  end
  if bEnable then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 3)
    zapWeaponSupport.setZapWeaponCooldownTime(10)
  else
    feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 0)
    if onlineProgressionSystem.onlineIsWeaponFuelUpgradeUnlocked() then
      zapWeaponSupport.setZapWeaponCooldownUpgraded()
    else
      zapWeaponSupport.setZapWeaponCooldownDefault()
    end
  end
end
function addAIToBus(scriptVehicle)
  local busPersonalityTraits = {}
  busPersonalityTraits.desiredSpeed = 120
  busPersonalityTraits.avoidAlleyways = 0
  busPersonalityTraits.spawnSpeed = 0
  busPersonalityTraits.ignorePlayers = true
  busPersonalityTraits.avoidUTurns = true
  ActiveLifeAI.createActiveLife(scriptVehicle.gameVehicle, "racer")
  ActiveLifeAI.setPersonalityTraits(scriptVehicle.gameVehicle, busPersonalityTraits)
  scriptVehicle.highSpeedDriving = true
end
function removeAIFromBus(scriptVehicle)
  if scriptVehicle.highSpeedDriving then
    ActiveLifeAI.stopActiveLife(scriptVehicle.gameVehicle)
    scriptVehicle.highSpeedDriving = false
  end
end
function onMultiplayerBusCreated(newBus)
  NetworkLog.Write(">[LUA] MULTIPLAYER BUS - onMultiplayerBusCreated")
  PartyBusManager.DeactivateLoadingScreen()
  assert(not multiplayerBus, "Bus already spawned")
  GameVehicleResource.setInfiniteMass(newBus.gameVehicle, true)
  Network.setTrackedHandle(newBus.SNVID)
  _G.trackVehicle = newBus
  multiplayerBus = newBus
  multiplayerBus:set_damageMultiplier(0)
  if multiplayerBus.isLocal then
    NetworkLog.Write(">[LUA] MULTIPLAYER BUS - set is multiplayerBus")
    multiplayerBus.networkVars.multiplayerBus = true
    multiplayerBus:updateLocalSNV()
  end
  if not localPlayer.inZap then
    localPlayer:SetZapLevel(5, nil, false, {forcedOut = true})
    zapcontroller.setActionPoinTracking(nil, math.pi / 2, 1, 0)
  end
  multiplayerBusActive = true
  enableAbilities(localPlayer.localID, false)
  newBus:disableDisplay(true)
  if Network.isLANParty() then
    isPlayersFirstTimeInMP = false
  else
    isPlayersFirstTimeInMP = not PlayerCoreStats.getTutorialFlag(0)
  end
  if isPlayersFirstTimeInMP then
    print("This is the player's first time in MP")
    PlayerCoreStats.updateLocalTutorialFlag(0, true)
    Statistics.dispatchWrite()
  end
end
local IsPlayersFirstTimeInMP = function()
  return isPlayersFirstTimeInMP
end
_G.IsPlayersFirstTimeInMP = IsPlayersFirstTimeInMP
local SetPlayerHasBeenInMP = function(val)
  isPlayersFirstTimeInMP = false
end
_G.SetPlayerHasBeenInMP = SetPlayerHasBeenInMP
function activateMultiplayerBus()
  NetworkLog.Write(">[LUA] MULTIPLAYER BUS - activateMultiplayerBus")
  enableAbilities(localPlayer.localID, false)
  zapWeaponSupport.resetZapWeapons()
  zapWeaponSupport.enableZapWeapons(false)
  zapcontroller.FPPShowZapFlare(false)
  localPlayer.controllerInterface:removePlayerControl()
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMPChallengeType", 2)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iNumPlayers", 0)
  showLobbyMenu()
  Mood.addMoodUserDefined(moodSystem.ClearDayCar, "previewMoodInCarHACK", 1, 1, -1)
  Mood.addMoodInCar(moodSystem.ClearDayCar, "previewMoodInCar", 1, 1, -1)
  PartyBusManager.SetPartyBusActive(true)
  PartyBusManager.SetInPartyBus(true)
  multiplayerBusActive = true
  playerInMultiplayerBus = true
  if transitionInProgress then
    transitionIntoMultiplayerBusComplete()
    transitionInProgress = false
  end
  initialPromptDone = false
  lastPromptTime = 0
end
function deactivateMultiplayerBus()
  NetworkLog.Write(">[LUA] MULTIPLAYER BUS - deactivateMultiplayerBus")
  gamerTag.setPlayerGamerTagsEnabled(true)
  for i = 0, 7 do
    gamerTagStatus[i] = true
  end
  zapcontroller.DisableZapAutoSelection(false)
  spoolsystem.SetSpoolCentreAttachment(localPlayer.localID, nil)
  deleteMarkers()
  if multiplayerBusActive or remoteBusVehicle then
    localPlayer:showHUDElements(false)
    enableAbilities(localPlayer.localID, false)
    enableBusSwap(false)
    zapWeaponSupport.enableZapWeapons(false)
    feedbackSystem.multiplayerSupport.enabled = false
    multiplayerBusActive = false
    playerInMultiplayerBus = false
    remoteBusVehicle = false
    feedbackSystem.menusMaster.masterSetVariable("iControls_Display", 0)
    Sound.SetState("LobbyMenu", "No")
    localPlayer.controls.enableRumble(true)
    if multiplayerBus then
      removeAIFromBus(multiplayerBus)
      selfRightVehicleList.removeTableOfVehicles({
        multiplayerBus.gameVehicle
      })
    end
    Mood.removeMood("previewMoodInCarHACK", 1)
    Mood.removeMood("previewMoodInCar", 1)
    multiplayerBus = false
    feedbackSystem.menusMaster.onlineHUDSetVariable("iNumPlayers", 0)
    controller.enableGameControls()
    zapcontroller.HideFlare(true)
    if welcomeMessageShowing then
      hideWelcomeMessage(false)
    end
    if natMessageShowing then
      hideNatMessage(false)
    end
    if tutorialMessageShowing then
      hideTutorialMessage(false)
    end
    if becomeLeaderMessageShowing then
      hideBecomeLeaderMessage(false)
    end
    zapcontroller.setSpoolerAttached(false)
    zapcontroller.ZapSettings(1, {CanSelectVehicles = true})
    zapcontroller.ZapSettings(2, {CanSelectVehicles = true})
    zapcontroller.ZapSettings(3, {CanSelectVehicles = true})
    zapcontroller.ZapSettings(4, {CanSelectVehicles = true})
  end
end
function deleteMultiplayerBus()
  NetworkLog.Write(">[LUA] MULTIPLAYER BUS - deleteMultiplayerBus")
  PartyBusManager.SetPartyBusActive(false)
  PartyBusManager.SetInPartyBus(false)
  deactivateMultiplayerBus()
  playerInMultiplayerBus = false
  if multiplayerBus then
    if multiplayerBus.isLocal then
      multiplayerBus:delete()
    end
    multiplayerBus = false
  end
  localPlayer:clearPreviousVehicle()
  removeUserUpdateFunction("isRemoteBusSpooled")
  removeUserUpdateFunction("isLocalBusSpooled")
end
_G.deleteMultiplayerBus = deleteMultiplayerBus
function transitionIntoMultiplayerBus()
  NetworkLog.Write(">[LUA] MULTIPLAYER BUS - transitionIntoMultiplayerBus")
  if multiplayerBus then
    zapcontroller.EnableZapInput(false)
    localPlayer:zapToAgent(multiplayerBus)
    zapcontroller.HideFlare(true)
    zapcontroller.setRenderTarget(false, localPlayer.localID)
    Menu.ChangePage("Online", "Free_drive")
    Network.onPlayerEnterLobby()
    transitionInProgress = true
    gamerTag.enabled = false
    gamerTagStatus.forceOff = true
  end
end
_G.transitionIntoMultiplayerBus = transitionIntoMultiplayerBus
function transitionIntoMultiplayerBusComplete()
  NetworkLog.Write(">[LUA] MULTIPLAYER BUS - transitionIntoMultiplayerBusComplete")
  createMarkers()
  zapcontroller.setRenderTarget(true, localPlayer.localID)
  zapcontroller.HideFlare(false)
  promptEnabled = true
  zapcontroller.setSpoolerAttached(true)
end
function transitionOutOfMultiplayerBus()
  NetworkLog.Write(">[LUA] MULTIPLAYER BUS - transitionOutOfMultiplayerBus")
  gamerTag.enabled = false
  gamerTagStatus.forceOff = true
  gamerTag.setPlayerGamerTagsEnabled(true)
  for i = 0, 7 do
    gamerTagStatus[i] = true
  end
  OnlineModeSettings.onlineDisableAssert = true
  if not localPlayer.inZap or zapcontroller.getTargetZapLevel(0) ~= 5 then
    zapcontroller.setZapCameraLocks(localID, {
      missile = false,
      low = true,
      mid = false,
      high = false,
      top = false
    })
    localPlayer:SetZapLevel(5, nil, false, {forcedOut = true})
    zapcontroller.setActionPoinTracking(nil, math.pi / 2, 1, 0)
  end
  OnlineModeSettings.onlineDisableAssert = false
  zapcontroller.EnableZapInput(false)
  zapcontroller.HideFlare(true)
  zapcontroller.setRenderTarget(false, localPlayer.localID)
  zapcontroller.DisableZapAutoSelection(false)
  deleteMarkers()
  promptEnabled = false
  zapcontroller.setSpoolerAttached(false)
  playerInMultiplayerBus = false
  zapcontroller.ZapSettings(1, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(2, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(3, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(4, {CanSelectVehicles = false})
  if multiplayerBus then
    controller.disableGameControls()
  end
end
_G.transitionOutOfMultiplayerBus = transitionOutOfMultiplayerBus
function deleteMarkers()
  for k, v in next, multiplayerBusCreatedMarkers, nil do
    Marker:delete(v)
    multiplayerBusCreatedMarkers[k] = nil
  end
end
function createMarkers()
  deleteMarkers()
  if multiplayerBus then
    for k, v in next, multiplayerBusMarkers, nil do
      v.gameVehicle = multiplayerBus.gameVehicle
      multiplayerBusCreatedMarkers[k] = Marker:create(v)
    end
  end
end
function zapReturnInZapToMultiplayerBus()
  NetworkLog.Write(">[LUA] MULTIPLAYER BUS - zapReturnInZapToMultiplayerBus")
  if zap.zapAttack.isZapAttackActive() or zap.zapSwap.isZapSwapActive() or zapcontroller.IsZapSpawnInProcess() then
    print("zapReturnInZapToMultiplayerBus cancelling")
    return
  end
  assert(multiplayerBus)
  zapcontroller.EnableZapInput(false)
  localPlayer:zapToAgent(multiplayerBus)
  zapcontroller.ZapSettings(1, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(2, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(3, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(4, {CanSelectVehicles = false})
end
function zapReturnToMultiplayerBus()
  NetworkLog.Write(">[LUA] MULTIPLAYER BUS - zapReturnToMultiplayerBus")
  if zap.zapAttack.isZapAttackActive() or zap.zapSwap.isZapSwapActive() or zapcontroller.IsZapSpawnInProcess() then
    print("zapReturnInZapToMultiplayerBus cancelling")
    return
  end
  assert(multiplayerBus)
  zapcontroller.EnableZapInput(false)
  localPlayer:zapToAgent(multiplayerBus)
  zapcontroller.ZapSettings(1, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(2, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(3, {CanSelectVehicles = false})
  zapcontroller.ZapSettings(4, {CanSelectVehicles = false})
end
_G.zapReturnToMultiplayerBus = zapReturnToMultiplayerBus
local function leaveMultiplayerBusCallback()
  NetworkLog.Write(">[LUA] MULTIPLAYER BUS - leaveMultiplayerBusCallback")
  controlHandler:resetState("MultiplayerBusState")
  controlHandler:removeState("MultiplayerBusState", localPlayer.localID)
  OnlineModeSettings.onlineDisableAssert = true
  localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
  OnlineModeSettings.onlineDisableAssert = false
  playerInMultiplayerBus = false
  PartyBusManager.SetInPartyBus(false)
  Mood.removeMood("previewMoodInCarHACK", 1)
  Mood.removeMood("previewMoodInCar", 1)
  hideLobbyMenu()
  enableAbilities(localPlayer.localID, true)
  initialPromptDone = false
  zapcontroller.ZapSettings(1, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(2, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(3, {CanSelectVehicles = true})
  zapcontroller.ZapSettings(4, {CanSelectVehicles = true})
end
_G.leaveMultiplayerBusCallback = leaveMultiplayerBusCallback
function onShowMenuOrDialog()
  if not menuOn then
    controller.disableGameControls()
    localPlayer.controls.enableRumble(false)
    Sound.SetState("LobbyMenu", "Yes")
    localPlayer:showHUDElements(false)
    zapcontroller.setRenderTarget(false, localPlayer.localID)
    enableBusSwap(false)
    zapcontroller.DisableZapAutoSelection(true)
    feedbackSystem.multiplayerSupport.enabled = false
    deleteMarkers()
    menuOn = true
  end
end
function onHideMenuOrDialog()
  if menuOn then
    controller.enableGameControls()
    localPlayer.controls.enableRumble(true)
    zapcontroller.EnableZapInput(true, localPlayer.localID)
    localPlayer:blockAbility("zap", false)
    enableAbilities(localPlayer.localID, true)
    scoreSystem.stopAbilityDrain(localPlayer.localID, false)
    scoreSystem.stopAbilityGain(localPlayer.localID, false)
    scoreSystem.setTimeAbilityGain(localPlayer.localID, true)
    Sound.SetState("LobbyMenu", "No")
    localPlayer:showHUDElements(true)
    zapcontroller.setRenderTarget(true, localPlayer.localID)
    enableBusSwap(true)
    zapcontroller.DisableZapAutoSelection(false)
    feedbackSystem.multiplayerSupport.enabled = true
    createMarkers()
    if localPlayer.inZap then
      zap.zoomInOutButtonPrompts(localPlayer, true)
    end
    menuOn = false
  end
end
function showLobbyMenu()
  NetworkLog.Write(">[LUA] MULTIPLAYER BUS - showLobbyMenu")
  onShowMenuOrDialog()
  PauseMenu.allow(true)
  PartyBusManager.EnterMenu()
end
_G.showLobbyMenu = showLobbyMenu
function hideLobbyMenu()
  NetworkLog.Write(">[LUA] MULTIPLAYER BUS - hideLobbyMenu")
  onHideMenuOrDialog()
  lastPromptTime = g_NetworkTime
  PartyBusManager.LeaveMenu()
end
_G.hideLobbyMenu = hideLobbyMenu
function playerUpdate()
  if promptEnabled and not playerInMultiplayerBus and Network.isPartyLeader() and not menuOn then
    if lastPromptTime ~= 0 then
      if not initialPromptDone and g_NetworkTime - lastPromptTime > initialPromptTime then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:243720", false, false, false, false, localPlayer.buttonLayout.exitBus)
        lastPromptTime = g_NetworkTime
        initialPromptDone = true
      elseif initialPromptDone and g_NetworkTime - lastPromptTime > extendedPromptTime then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:243720", false, false, false, false, localPlayer.buttonLayout.exitBus)
        lastPromptTime = g_NetworkTime
      end
    else
      lastPromptTime = g_NetworkTime
    end
  end
  if multiplayerBus and not transitionInProgress and promptEnabled then
    if playerInMultiplayerBus then
      if not gamerTagStatus.forceOff then
        gamerTag.enabled = false
        gamerTagStatus.forceOff = true
      end
    else
      if gamerTagStatus.forceOff then
        gamerTag.enabled = true
        gamerTagStatus.forceOff = false
      end
      for playerID, player in next, playerManager.players, nil do
        if not player.inZap and not gamerTagStatus[playerID] then
          gamerTag.setplayerTagEnabled(playerID, true)
          gamerTagStatus[playerID] = true
        elseif player.inZap and gamerTagStatus[playerID] then
          gamerTag.setplayerTagEnabled(playerID, false)
          gamerTagStatus[playerID] = false
        end
      end
    end
  end
end
function welcomeMessageCallback()
  if welcomeMessageShowing and g_NetworkTime - welcomeMessageShowTime > 2 then
    if welcomeMessagePart2 then
      hideWelcomeMessage(true)
    else
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_rewards_title", "ID:245945")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_rewards_generic_blurb", "ID:242348", nil)
      welcomeMessagePart2 = true
    end
  end
end
function showWelcomeMessageButton()
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_contine", "ID:245849")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_continue_button", localPlayer.buttonLayout.accept)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Toggle", 1)
  removeUserUpdateFunction("showWelcomeMessageButton")
end
function showWelcomeMessage()
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 1)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_rewards_title", "ID:242349")
  if Network.isPartyLeader() then
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_rewards_generic_blurb", "ID:242346", nil, localPlayer.buttonLayout.exitBus)
  else
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_rewards_generic_blurb", "ID:245944", nil, localPlayer.buttonLayout.exitBus)
  end
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_contine", "")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_continue_button", "")
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Toggle", 0)
  onShowMenuOrDialog()
  PauseMenu.allow(false)
  welcomeMessageShowing = true
  welcomeMessageShowTime = g_NetworkTime
  addUserUpdateFunction("showWelcomeMessageButton", showWelcomeMessageButton, 240, true)
  local state = {
    Menu_Select = {
      JustPressed = {
        [1] = welcomeMessageCallback
      }
    }
  }
  localPlayer.controls:registerState(localPlayer.localID, "Lobby", state)
  localPlayer.controls:setState("Lobby", 1, localPlayer.localID)
end
_G.showWelcomeMessage = showWelcomeMessage
function waitForWelcomeMessageAnimOut()
  if Menu.GetSceneStatus("Online_HUD", "multi_reminder_dialog") == 2 then
    PartyBusManager.OnWelcomeMessageClose()
    removeUserUpdateFunction("waitForWelcomeMessageAnimOut")
  end
end
function hideWelcomeMessage(waitForAnimToComplete)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 2)
  welcomeMessageShowing = false
  welcomeMessagePart2 = false
  localPlayer.controls:resetState("Lobby", 1, localPlayer.localID)
  localPlayer.controls:removeState("Lobby", localPlayer.localID)
  PauseMenu.allow(true)
  if waitForAnimToComplete then
    addUserUpdateFunction("waitForWelcomeMessageAnimOut", waitForWelcomeMessageAnimOut, 1)
  else
    PartyBusManager.OnWelcomeMessageClose()
  end
end
function natMessageCallback()
  if natMessageShowing and g_NetworkTime - natMessageShowTime > 2 then
    hideNatMessage(true)
  end
end
function showNatMessageButton()
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_contine", "ID:245849")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_continue_button", localPlayer.buttonLayout.accept)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Toggle", 1)
  removeUserUpdateFunction("showNatMessageButton")
end
function showNatMessage(strictNAT)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 1)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_rewards_title", "ID:247303")
  if strictNAT then
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_rewards_generic_blurb", "ID:248717", nil, localPlayer.buttonLayout.exitBus)
  else
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_rewards_generic_blurb", "ID:248718", nil, localPlayer.buttonLayout.exitBus)
  end
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_contine", "")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_continue_button", "")
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Toggle", 0)
  onShowMenuOrDialog()
  PauseMenu.allow(false)
  natMessageShowing = true
  natMessageShowTime = g_NetworkTime
  addUserUpdateFunction("showNatMessageButton", showNatMessageButton, 240, true)
  local state = {
    Menu_Select = {
      JustPressed = {
        [1] = natMessageCallback
      }
    }
  }
  localPlayer.controls:registerState(localPlayer.localID, "Lobby", state)
  localPlayer.controls:setState("Lobby", 1, localPlayer.localID)
end
_G.showNatMessage = showNatMessage
function waitForNatMessageAnimOut()
  if Menu.GetSceneStatus("Online_HUD", "multi_reminder_dialog") == 2 then
    PartyBusManager.OnNatMessageClose()
    removeUserUpdateFunction("waitForNatMessageAnimOut")
  end
end
function hideNatMessage(waitForAnimToComplete)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 2)
  natMessageShowing = false
  localPlayer.controls:resetState("Lobby", 1, localPlayer.localID)
  localPlayer.controls:removeState("Lobby", localPlayer.localID)
  PauseMenu.allow(true)
  if waitForAnimToComplete then
    addUserUpdateFunction("waitForNatMessageAnimOut", waitForNatMessageAnimOut, 1)
  else
    PartyBusManager.OnNatMessageClose()
  end
end
function tutorialMessageCallback()
  if tutorialMessageShowing and g_NetworkTime - tutorialMessageShowTime > 2 then
    hideTutorialMessage(true)
  end
end
function showTutorialMessageButton()
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_contine", "ID:245849")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_continue_button", localPlayer.buttonLayout.accept)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Toggle", 1)
  removeUserUpdateFunction("showTutorialMessageButton")
end
function showTutorialMessage(tutorialID)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 1)
  if onlineProgressionSystem.onlineShouldShowWeaponTutorialMsg(1) then
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_rewards_title", "ID:245947")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_rewards_generic_blurb", "ID:245951", nil, localPlayer.buttonLayout.exitBus)
    onlineProgressionSystem.onlineWeaponClearShowTutorialMsg(1)
  elseif onlineProgressionSystem.onlineShouldShowWeaponTutorialMsg(2) then
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_rewards_title", "ID:245949")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_rewards_generic_blurb", "ID:245950", nil, localPlayer.buttonLayout.exitBus)
    onlineProgressionSystem.onlineWeaponClearShowTutorialMsg(2)
  else
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_rewards_title", "ID:245948")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_rewards_generic_blurb", "ID:245952", nil, localPlayer.buttonLayout.exitBus)
    onlineProgressionSystem.onlineWeaponClearShowTutorialMsg(3)
  end
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_contine", "")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_continue_button", "")
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Toggle", 0)
  onShowMenuOrDialog()
  PauseMenu.allow(false)
  tutorialMessageShowing = true
  tutorialMessageShowTime = g_NetworkTime
  addUserUpdateFunction("showTutorialMessageButton", showTutorialMessageButton, 240, true)
  local state = {
    Menu_Select = {
      JustPressed = {
        [1] = tutorialMessageCallback
      }
    }
  }
  localPlayer.controls:registerState(localPlayer.localID, "Lobby", state)
  localPlayer.controls:setState("Lobby", 1, localPlayer.localID)
end
_G.showTutorialMessage = showTutorialMessage
function waitForTutorialMessageAnimOut()
  if Menu.GetSceneStatus("Online_HUD", "multi_reminder_dialog") == 2 then
    PartyBusManager.OnTutorialMessageClose()
    removeUserUpdateFunction("waitForTutorialMessageAnimOut")
  end
end
function hideTutorialMessage(waitForAnimToComplete)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 2)
  tutorialMessageShowing = false
  localPlayer.controls:resetState("Lobby", 1, localPlayer.localID)
  localPlayer.controls:removeState("Lobby", localPlayer.localID)
  PauseMenu.allow(true)
  if waitForAnimToComplete then
    addUserUpdateFunction("waitForTutorialMessageAnimOut", waitForTutorialMessageAnimOut, 1)
  else
    PartyBusManager.OnTutorialMessageClose()
  end
end
function becomeLeaderMessageCallback()
  if becomeLeaderMessageShowing and g_NetworkTime - becomeLeaderMessageShowTime > 2 then
    hideBecomeLeaderMessage(true)
  end
end
function showBecomeLeaderMessageButton()
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_contine", "ID:245849")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_continue_button", localPlayer.buttonLayout.accept)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Toggle", 1)
  removeUserUpdateFunction("showBecomeLeaderMessageButton")
end
function showBecomeLeaderMessage()
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 1)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_rewards_title", "ID:245812")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_rewards_generic_blurb", "ID:245813")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_contine", "")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_continue_button", "")
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Toggle", 0)
  onShowMenuOrDialog()
  PauseMenu.allow(false)
  becomeLeaderMessageShowing = true
  becomeLeaderMessageShowTime = g_NetworkTime
  addUserUpdateFunction("showBecomeLeaderMessageButton", showBecomeLeaderMessageButton, 240, true)
  local state = {
    Menu_Select = {
      JustPressed = {
        [1] = becomeLeaderMessageCallback
      }
    }
  }
  localPlayer.controls:registerState(localPlayer.localID, "Lobby", state)
  localPlayer.controls:setState("Lobby", 1, localPlayer.localID)
  if not playerInMultiplayerBus then
    localPlayer.controllerInterface:removePlayerControl()
    localPlayer:blockAbility("zap", true)
    zapcontroller.DisableZapAutoSelection(true)
  end
end
_G.showBecomeLeaderMessage = showBecomeLeaderMessage
function waitForBecomeLeaderMessageAnimOut()
  if Menu.GetSceneStatus("Online_HUD", "multi_reminder_dialog") == 2 then
    PartyBusManager.OnBecomeLeaderMessageClose()
    removeUserUpdateFunction("waitForBecomeLeaderMessageAnimOut")
  end
end
function hideBecomeLeaderMessage(waitForAnimToComplete)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 2)
  becomeLeaderMessageShowing = false
  localPlayer.controls:resetState("Lobby", 1, localPlayer.localID)
  localPlayer.controls:removeState("Lobby", localPlayer.localID)
  if not playerInMultiplayerBus then
    addUserUpdateFunction("reenablePlayerControl", function()
      localPlayer.controllerInterface:registerPlayerControl()
      localPlayer:blockAbility("zap", false)
      removeUserUpdateFunction("reenablePlayerControl")
      zapcontroller.DisableZapAutoSelection(false)
    end, 5, true)
  end
  PauseMenu.allow(true)
  if waitForAnimToComplete then
    addUserUpdateFunction("waitForBecomeLeaderMessageAnimOut", waitForBecomeLeaderMessageAnimOut, 1)
  else
    PartyBusManager.OnBecomeLeaderMessageClose()
  end
end
local function getMPBusModelID()
  return ModelID
end
_G.getMPBusModelID = getMPBusModelID
