local HUDOn = true
local CommentaryDebugOn = false
local CommentaryLoggingOn = false
local pauseMenuShown = false
local drawMenu
local activeMenu = "Pause"
local selected = 1
local menus = {}
lightTrailBlocked = false
g_zapSlowDownTrigger = false
devElementsOn = true
local title_position = vec.vector(0.65, 0.1, 0, 0)
local mediaVersion_position = vec.vector(0.08, 0.1, 0, 0)
local menuEntry_position = vec.vector(0.65, 0.15, 0, 1)
local menuInfo_position = vec.vector(0.65, 0.9, 0, 0)
local menuSpacing = 0.04
local CPUPerfLogEnabled = false
local CPUPerfLogFreq = 23
local function toggleCPULog()
  CPUPerfLogEnabled = not CPUPerfLogEnabled
  performanceMeter.enableCPULog(CPUPerfLogEnabled, CPUPerfLogFreq)
  PauseMenu.resume()
end
function addPauseMenu(name, table)
  menus[name] = {
    title = "/" .. tostring(name),
    entries = table
  }
end
local function clearCurrentMenu()
  local menu = menus[activeMenu]
  if menu and pauseMenuShown then
    Development:clearScreen("all")
  end
end
function changePauseMenu(name)
  return function()
    if (name ~= "MissionsMenu" and name ~= "ActivitiesMenu" and name ~= "ChallengeMenu" or not localPlayer.inCutsceneOrIcam) and menus[name] then
      clearCurrentMenu()
      activeMenu = name
      selected = 1
      drawMenu()
    end
  end
end
open("configuration\\pauseMenu_LIABChapters.lua")
local function HideMenusForScreenshot()
  if HUDOn == true then
    HUDOn = false
    Menu.HideUI = 1
    debugOptions.showFps = false
    debugOptions.showMemory = false
    clearCurrentMenu()
    for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
      vehicle:removeLightTrail()
    end
  else
    HUDOn = true
    Menu.HideUI = 0
    debugOptions.showFps = true
    debugOptions.showMemory = true
    drawMenu()
  end
end
function GetHUDOn()
  return HUDOn
end
function toggleFPS()
  toggleFPSCounter()
  PauseMenu.resume()
end
vsyncToggle = 0
function toggle30hz()
  vsyncToggle = 1 - vsyncToggle
  Renderer.SetNumVSyncs(1 + vsyncToggle)
  PauseMenu.resume()
end
local removelightTrails = function()
  lightTrailBlocked = true
  for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
    vehicle:removeLightTrail()
  end
end
local enablelightTrails = function()
  lightTrailBlocked = false
end
local toggleRumble = function()
  if controlHandler.rumbleAllowed then
    controlHandler:allowRumble(false)
  else
    controlHandler:allowRumble(true)
  end
  PauseMenu.resume()
end
local function hideFeedback()
  removelightTrails()
  if localPlayer.currentVehicle then
    localPlayer.currentVehicle:set_damageMultiplier(0)
  end
  VEdit.ResetVehicleDamage()
  if GetHUDOn() then
    HideMenusForScreenshot()
  end
  print("HIDE FEEDBACK")
end
local function showFeedback()
  enablelightTrails()
  if localPlayer.currentVehicle then
    localPlayer.currentVehicle:set_damageMultiplier(1)
  end
  if not GetHUDOn() then
    HideMenusForScreenshot()
  end
  print("SHOW FEEDBACK")
end
local postcardLocations = {
  {
    position = vec.vector(-384.7166, 63.10689, -94.09248, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-321.6305, 70.00041, 74.16445, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-1315.533, 24.7299, 176.385, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-1335.11, 57, 830.306, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-662.5585, 30.87507, 1231.968, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-1070.351, 18.49672, 305.2231, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-378.9569, 19.1003, 826.8561, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-53.64511, 18, 1021.792, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(1099.942, 5.974995, 680.7256, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-1309.474, 64.65224, 1747.703, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(1470.053, 5.974995, 1721.732, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(1477.385, 6.158983, 2086.378, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(639.3962, 18.00904, 1946.511, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(987.0735, 13.07876, 2286.228, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-759.2172, 63.37791, 2195.876, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(1316.837, 8.25, 3448.089, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(14.53415, 67.44881, 3625.555, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-1457.177, 169.5324, 3250.364, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-1485.116, 66.78291, 2251.538, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-2123.466, 151.0063, 3445.65, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-2288.471, 167.8135, 4355.067, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-2930.355, 129.1247, 3700.209, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-3571.182, 57.59952, 3724.027, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-3382.505, 81.75497, 2922.383, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-2979.321, 85.34271, 2625.655, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-3573.054, 35.50967, 1538.829, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-3795.072, 60.63026, 920.5795, 1),
    minimapMarker = {},
    worldMarker = {}
  },
  {
    position = vec.vector(-3504.604, 11.0475, 202.864, 1),
    minimapMarker = {},
    worldMarker = {}
  }
}
local showingPostcards = false
local function TogglePostcardLocations()
  if not showingPostcards then
    for k, v in next, postcardLocations, nil do
      v.minimapMarker = Marker:create({
        type = "Minimap",
        gadgetID = 5,
        colour = vec.vector(100, 255, 100, 255),
        radius = 30,
        position = v.position,
        visible = true,
        canrotate = false
      })
      v.worldMarker = Marker:create({
        type = "World",
        gadgetID = 5,
        colour = vec.vector(100, 255, 100, 255),
        radius = 50,
        position = v.position,
        visible = true,
        facinginzap = true,
        hideinmissilezap = true
      })
    end
    showingPostcards = true
  else
    for k, v in next, postcardLocations, nil do
      Marker:delete(v.minimapMarker)
      Marker:delete(v.worldMarker)
    end
    showingPostcards = false
  end
  PauseMenu.resume()
end
local playingBIK = false
local counter = 0
local timebuffer = 0
function playOverlayBIK()
  timebuffer = g_NetworkTime
  addUserUpdateFunction("playBIK", function()
    if playingBIK == false and g_NetworkTime - timebuffer > 1 then
      playingBIK = true
      movie.Open("com:fmv/gameplay/icam_crash_overlay.bik")
      movie.Play(function()
        playingBIK = false
        timebuffer = g_NetworkTime
      end)
    end
  end, 5)
end
function TogglePIPOverlay()
  if counter % 2 == 0 then
    playOverlayBIK()
  else
    playingBIK = false
    removeUserUpdateFunction("playBIK")
  end
  counter = counter + 1
  PauseMenu.resume()
end
function ToggleTrafficCarrierCount()
  if counter % 2 == 0 then
    simulation.EnableTrafficCarriersDisplay()
  else
    simulation.DisableTrafficCarriersDisplay()
  end
  counter = counter + 1
  PauseMenu.resume()
end
local function ToggleCommentaryDebug()
  if CommentaryDebugOn == false then
    CommentaryDebugOn = true
  else
    CommentaryDebugOn = false
  end
  Commentary.ShowDebugText(CommentaryDebugOn)
end
local function ToggleCommentaryLogging()
  if CommentaryLoggingOn == false then
    CommentaryLoggingOn = true
    Commentary.StartLIABLog()
  else
    CommentaryLoggingOn = false
    Commentary.StopLIABLog()
  end
end
function quitMissionProper(taskObject)
  return function()
    local isChallenge = taskObject.coreData.instance.isChallenge
    localPlayer.challenge.setRetryingMission(false)
    feedbackSystem.menusMaster.masterSetVariable("iPrompt_Primary_Display", 0)
    progressionSystem.challengeAbandoned(taskObject.coreData.instance)
    if not isChallenge and not progressionSystem.applyingChapterSettings then
      spooling.fadeIn()
    end
    PauseMenu.resume()
  end
end
function quitMission()
  if gameStatus.onlineSession then
    if challengeSystem.instances[phaseManager.networkVars.modeID] then
      challengeSystem.instances[phaseManager.networkVars.modeID]:initiateOverTimePhase()
    elseif faceOffSystem.currentFaceOff then
      faceOffSystem.forceEndFaceOff()
    end
  else
    local taskObject = localPlayer:getTaskObject()
    if taskObject then
      if taskObject.coreData.instance.isChallenge then
        feedbackSystem.clearHUD()
      end
      feedbackSystem.previewScreen.startMissionFromHotspot = false
      spooling.fadeOut(nil, 0)
      iCamDeActivation()
      CameraSystem.ClearScene()
      localPlayer.challenge.missionEndWait(quitMissionProper(taskObject), true)
    elseif dareSystem.activeDare then
      dareSystem.abortActiveDare()
      print("Presence set to FREEDRIVE")
      presenceSystem.setPresence(9)
    end
  end
end
local restartCurrentMissionProper = function(taskObject, notTutorial)
  return function()
    local challengeName = taskObject.coreData.instance.challenge.name
    local fromInWorld = taskObject.coreData.instance.fromInWorld
    local mission, potID, subType, type = progressionSystem.findMissionInProgression(challengeName)
    GameplayTracking.OnObjectiveStop(missionInfo[cards.ReverseMissionNetworkLookup[challengeName]].challengeTitle, type, "RETRY", "RETRY")
    feedbackSystem.menusMaster.masterSetVariable("iPrompt_Primary_Display", 0)
    spooling.fadeOut(nil, 0)
    taskObject.coreData.instance:delete()
    progressionSystem.forceStartMission(challengeName, notTutorial, fromInWorld)
    PauseMenu.resume()
  end
end
function restartCurrentMission()
  local taskObject = localPlayer:getTaskObject()
  if taskObject then
    local missionID = taskObject.coreData.instance.challenge.name
    iCamDeActivation()
    spooling.fadeOut(nil, 0)
    CameraSystem.ClearScene()
    local mission, potID, subType, type = progressionSystem.findMissionInProgression(missionID)
    print("MISSION TYPE")
    print(type)
    print(type ~= "progressionTutorial")
    localPlayer.challenge.setRetryingMission(type ~= "progressionTutorial")
    localPlayer.challenge.missionEndWait(restartCurrentMissionProper(taskObject, type ~= "progressionTutorial"), true)
  elseif dareSystem.activeDare then
    dareSystem.createDare(dareSystem.activeDare, true)
    feedbackSystem.menusMaster.updateFreedriveHintText()
  end
end
local skipCurrentGame = function()
  if phaseManager then
    if phaseManager.networkVars.phase == HighLevelZapStateIndex then
      faceOffSystem.deleteAllFaceOffs()
      phaseManager.faceOffPhaseLength = 0
      phaseManager.update()
      phaseManager.faceOffPhaseLength = 60
    end
    if phaseManager.networkVars.phase == CreateFaceOffStateIndex then
      local instance = challengeSystem.instances[phaseManager.networkVars.watchInstance]
      if instance.isLocal then
        instance:delete()
      end
    end
  end
end
local returnToPartyBus = function()
  if Network.isPartyLeader() then
    print("Party leader is returning to bus")
    Network.returnPartyToBus()
  end
end
local failMission = function()
  local currentTask = localPlayer:getTaskObject()
  if currentTask then
    local function failMissionsCallBack()
      progressionSystem.challengeFailed(currentTask.coreData.instance, currentTask.coreData.agent.matrix)
    end
    BackSeatDriver.Clear()
    localPlayer:resetCameraMode()
    if localPlayer.primaryFelony.getawayGameVehicle then
      felony_chase.endScreenVehicle = felony_chase.takeOwnershipOfGetaway()
    end
    local params = {
      vehicle = currentTask.coreData.agent or felony_chase.endScreenVehicle or localPlayer.currentVehicle,
      rating = "FAIL",
      callback = failMissionsCallBack
    }
    Chase.StopAll()
    if currentTask.coreData.instance.challenge.taskCompleteData then
      params.cameraShots = cardSystem.cameraShots[2]
      params.successReason = currentTask.coreData.instance.challenge.taskCompleteData["Success reason"]
      params.failReason = currentTask.coreData.instance.challenge.taskCompleteData["Failure reason"]
      params.inCarCompletion = currentTask.coreData.instance.challenge.taskCompleteData["In-car completion"]
      params.inCarReward = currentTask.coreData.instance.challenge.taskCompleteData["In-car reward"]
      params.passCondition = currentTask.coreData.instance.challenge.taskCompleteData["Pass condition"]
      params.passReward = currentTask.coreData.instance.challenge.taskCompleteData["Pass reward"]
    end
    if currentTask then
      localPlayer.challenge.endScreen(currentTask, params)
      PauseMenu.resume()
    end
  else
    PauseMenu.resume()
  end
end
local completeMission = function()
  local currentTask = localPlayer:getTaskObject()
  if currentTask then
    local function completeMissionsCallBack()
      progressionSystem.challengeComplete(currentTask.coreData.instance, currentTask.coreData.agent.matrix)
    end
    if localPlayer.primaryFelony.getawayGameVehicle then
      felony_chase.endScreenVehicle = felony_chase.takeOwnershipOfGetaway()
    end
    local params = {
      vehicle = currentTask.coreData.agent or felony_chase.endScreenVehicle or localPlayer.currentVehicle,
      rating = "PASS",
      callback = completeMissionsCallBack
    }
    Chase.StopAll()
    if currentTask.coreData.instance.challenge.taskCompleteData then
      params.successReason = currentTask.coreData.instance.challenge.taskCompleteData["Success reason"]
    end
    if currentTask then
      localPlayer.challenge.endScreen(currentTask, params)
      PauseMenu.resume()
    end
  else
    PauseMenu.resume()
  end
end
function toggleDevElements()
  if devElementsOn then
    Development:useDevText(false)
    Development:useDevGraph(false)
    devElementsOn = false
  else
    Development:useDevText(true)
    Development:useDevGraph(true)
    devElementsOn = true
  end
  PauseMenu.resume()
end
local pipsOn = true
local function togglePips()
  if pipsOn then
    Commentary.DisablePips(true)
    pipsOn = false
  else
    Commentary.DisablePips(false)
    pipsOn = true
  end
  PauseMenu.resume()
end
local HUDOn = true
local function toggleHUD()
  if HUDOn then
    Menu.ShowHUD = 0
    HUDOn = false
  else
    Menu.ShowHUD = 1
    HUDOn = true
  end
  PauseMenu.resume()
end
local PostProcessDisabled = false
local function togglePostProcess()
  if PostProcessDisabled then
    postprocess.DevDisable = false
    PostProcessDisabled = false
  else
    postprocess.DevDisable = true
    PostProcessDisabled = true
  end
  PauseMenu.resume()
end
local toggleGamma = function()
  graphics.ToggleGammaCorrection()
  PauseMenu.resume()
end
local togglePVS = function()
  pvsdiagnostics.TogglePVS()
  PauseMenu.resume()
end
local FelonyOn = false
local function toggleFelony()
  if FelonyOn then
    FelonyOn = false
  else
    FelonyOn = true
  end
  PatrollingVehicleManager.Enable(FelonyOn)
  PauseMenu.resume()
end
local PedestriansOn = true
local function togglePedestrians()
  if PedestriansOn then
    PedestriansOn = false
    characterManager.DisablePeds()
  else
    PedestriansOn = true
    characterManager.EnablePeds()
  end
  PauseMenu.resume()
end
local zapRadius1 = function()
  shop.purchaseAbility(abilities.abilitySlots.zap, 0)
  PauseMenu.resume()
end
local zapRadius2 = function()
  shop.purchaseAbility(abilities.abilitySlots.zap, 0)
  shop.purchaseAbility(abilities.abilitySlots.aerialZap, 0)
  PauseMenu.resume()
end
local zapRadius4 = function()
  shop.purchaseAbility(abilities.abilitySlots.zap, 0)
  shop.purchaseAbility(abilities.abilitySlots.aerialZap, 0)
  shop.purchaseAbility(abilities.abilitySlots.aerialZap, 1)
  PauseMenu.resume()
end
local zapRadius5 = function()
  shop.purchaseAbility(abilities.abilitySlots.zap, 0)
  shop.purchaseAbility(abilities.abilitySlots.aerialZap, 0)
  shop.purchaseAbility(abilities.abilitySlots.aerialZap, 1)
  shop.purchaseAbility(abilities.abilitySlots.aerialZap, 2)
  PauseMenu.resume()
end
local resetPlayerOnlineProgression = function()
  onlineProgressionSystem.resetPlayerProgression(true)
end
local setPlayerMaxOnlineProgression = function()
  onlineProgressionSystem.setPlayerProgressionMax()
  zapWeaponSupport.enableZapWeapons(true)
  ActiveVehicles.enableSystem(true)
  Menu.UnloadMPImages()
end
local unlockNextOnlineProgression = function()
  onlineProgressionSystem.progressToNextLevel()
end
local toggleOnlineProgDebugText = function()
  onlineProgressionSystem.toggleOnlineProgressionDebugInfo()
  PauseMenu.resume()
end
local addThousandXPToOnlineProg = function()
  onlineProgressionSystem.addXPtoPlayerTotal(1000)
end
local addFiveThousandXPToOnlineProg = function()
  onlineProgressionSystem.addXPtoPlayerTotal(5000)
end
local addTenThousandXPToOnlineProg = function()
  onlineProgressionSystem.addXPtoPlayerTotal(10000)
end
local addHundredThousandXPToOnlineProg = function()
  onlineProgressionSystem.addXPtoPlayerTotal(100000)
end
local onlineTurnOnAllowTooFewPlayers = function()
  phaseManager.turnOnAllowTooFewPlayers()
  Network.enableTooFewPlayers()
  PauseMenu.resume()
end
local onlineToggleDebugModeInfo = function()
  phaseManager.toggleOnlineDebugInfo()
  PauseMenu.resume()
end
local tutorialVehicleSwap = function()
  phaseManager.turnOnAllowTooFewPlayers()
  phaseManager.playlistSupport.playerTutorialVehicleSwap = not phaseManager.playlistSupport.playerTutorialVehicleSwap
  phaseManager.playlistSupport.playerTutorialShiftImpulse = false
  phaseManager.playlistSupport.playerTutorialVehicleSpawn = false
  phaseManager.playlistSupport.playerTutorialGeneralMechanics = false
  phaseManager.playlistSupport.playerTutorialShiftTake = false
  PauseMenu.resume()
end
local tutorialVehicleSpawn = function()
  phaseManager.turnOnAllowTooFewPlayers()
  phaseManager.playlistSupport.playerTutorialVehicleSpawn = not phaseManager.playlistSupport.playerTutorialVehicleSpawn
  phaseManager.playlistSupport.playerTutorialShiftImpulse = false
  phaseManager.playlistSupport.playerTutorialVehicleSwap = false
  phaseManager.playlistSupport.playerTutorialGeneralMechanics = false
  phaseManager.playlistSupport.playerTutorialShiftTake = false
  PauseMenu.resume()
end
local tutorialShiftImpulse = function()
  phaseManager.turnOnAllowTooFewPlayers()
  phaseManager.playlistSupport.playerTutorialShiftImpulse = not phaseManager.playlistSupport.playerTutorialShiftImpulse
  phaseManager.playlistSupport.playerTutorialVehicleSwap = false
  phaseManager.playlistSupport.playerTutorialVehicleSpawn = false
  phaseManager.playlistSupport.playerTutorialGeneralMechanics = false
  phaseManager.playlistSupport.playerTutorialShiftTake = false
  PauseMenu.resume()
end
local tutorialShiftTake = function()
  phaseManager.turnOnAllowTooFewPlayers()
  phaseManager.playlistSupport.playerTutorialShiftTake = not phaseManager.playlistSupport.playerTutorialShiftTake
  phaseManager.playlistSupport.playerTutorialVehicleSwap = false
  phaseManager.playlistSupport.playerTutorialVehicleSpawn = false
  phaseManager.playlistSupport.playerTutorialShiftImpulse = false
  phaseManager.playlistSupport.playerTutorialGeneralMechanics = false
  PauseMenu.resume()
end
local tutorialGeneralMechanics = function()
  phaseManager.turnOnAllowTooFewPlayers()
  phaseManager.playlistSupport.playerTutorialGeneralMechanics = not phaseManager.playlistSupport.playerTutorialGeneralMechanics
  phaseManager.playlistSupport.playerTutorialVehicleSwap = false
  phaseManager.playlistSupport.playerTutorialVehicleSpawn = false
  phaseManager.playlistSupport.playerTutorialShiftImpulse = false
  phaseManager.playlistSupport.playerTutorialShiftTake = false
  PauseMenu.resume()
end
local lockRouteSelection = function()
  phaseManager.playlistSupport.debug_none_random_route_cycle = not phaseManager.playlistSupport.debug_none_random_route_cycle
end
local nextRouteSelection = function()
  phaseManager.playlistSupport.debug_none_random_route_cycle = true
  phaseManager.playlistSupport.debug_none_random_cycle_lastRoute = phaseManager.playlistSupport.debug_none_random_cycle_lastRoute + 1
end
local lastRouteSelection = function()
  phaseManager.playlistSupport.debug_none_random_route_cycle = true
  phaseManager.playlistSupport.debug_none_random_cycle_lastRoute = phaseManager.playlistSupport.debug_none_random_cycle_lastRoute - 1
end
local nextRouteSelectionFaceOff = function()
  phaseManager.playlistSupport.debug_none_random_route_cycle = true
  phaseManager.playlistSupport.debug_none_random_cycle_lastRoute_faceOff = phaseManager.playlistSupport.debug_none_random_cycle_lastRoute_faceOff + 1
end
local lastRouteSelectionFaceOff = function()
  phaseManager.playlistSupport.debug_none_random_route_cycle = true
  phaseManager.playlistSupport.debug_none_random_cycle_lastRoute_faceOff = phaseManager.playlistSupport.debug_none_random_cycle_lastRoute_faceOff - 1
end
local resetPlayerXP = function()
  onlineStatistics.clearPlayerXP()
  PauseMenu.resume()
end
local clearPlayerMissionStats = function()
  onlineStatistics.clearServerStatistics()
  PauseMenu.resume()
end
local setPlayerXPtoServerXP = function()
  onlineStatistics.useServerXP()
  PauseMenu.resume()
end
local setInfiniteZapWeaponCooldown = function()
  zapWeaponSupport.setZapWeaponCooldownTime(1)
  PauseMenu.resume()
end
local setZapWeaponCooldownSixty = function()
  zapWeaponSupport.setZapWeaponCooldownTime(60)
  PauseMenu.resume()
end
local setZapWeaponCooldownFortyFive = function()
  zapWeaponSupport.setZapWeaponCooldownTime(45)
  PauseMenu.resume()
end
local setZapWeaponCooldownThirty = function()
  zapWeaponSupport.setZapWeaponCooldownTime(30)
  PauseMenu.resume()
end
local setZapWeaponCooldownTwenty = function()
  zapWeaponSupport.setZapWeaponCooldownTime(20)
  PauseMenu.resume()
end
local setZapWeaponCooldownTen = function()
  zapWeaponSupport.setZapWeaponCooldownTime(10)
  PauseMenu.resume()
end
menus.Pause = {
  title = "/Pause",
  mediaVersion = "Media version: " .. Network.getVersionString(),
  entries = {
    {
      name = "Resume",
      action = PauseMenu.resume,
      info = "Back To The Game"
    },
    {
      name = "Missions",
      action = changePauseMenu("MissionsMenu"),
      info = "View Avalible Missions"
    },
    {
      name = "Activities",
      action = changePauseMenu("ActivitiesMenu"),
      info = "View Avalible Activities"
    },
    {
      name = "Challenges",
      action = changePauseMenu("ChallengesMenu"),
      info = "View Avalible Challenges"
    },
    {
      name = "Tutorials",
      action = changePauseMenu("Tutorial missions"),
      info = "Open the tutorial menu"
    },
    {
      name = "Cheats",
      action = changePauseMenu("CheatMenu"),
      info = "View cheat menu"
    },
    {
      name = "Cut Scenes...",
      action = changePauseMenu("CutScenes"),
      info = "View packaged In-Game CutScenes"
    },
    {
      name = "Preloaded Cut Scenes...",
      action = changePauseMenu("Preloaded"),
      info = "View preloaded In-Game CutScenes"
    },
    {
      name = "Evidence Board...",
      action = changePauseMenu("EvidenceBoard"),
      info = "View the evidence board"
    },
    {
      name = "Options",
      action = changePauseMenu("OptionsMenu"),
      info = "Game Options"
    },
    {
      name = "Marketing",
      action = changePauseMenu("marketingMenu"),
      info = "Marketing menu options"
    },
    {
      name = "Advert Preview",
      action = function()
        cycleAdverts()
        PauseMenu.resume()
      end,
      info = "Cycle through the city's adverts in Free Cam"
    },
    {
      name = "Quit to Frontend",
      action = PauseMenu.quit,
      info = "Quit to Frontend"
    },
    {
      name = "Quit to Dash",
      action = framework.quit,
      info = "Quit to Frontend"
    },
    {
      name = "Skip Current Game",
      action = function()
        skipCurrentGame()
        PauseMenu.resume()
      end,
      info = "Skips the current game mode, HOST Only"
    },
    {
      name = "Restart Current Mission",
      action = function()
        restartCurrentMission()
        PauseMenu.resume()
      end,
      info = "Restart"
    },
    {
      name = "quit Current Mission",
      action = function()
        quitMission()
        PauseMenu.resume()
      end,
      info = "Quit your current mission"
    },
    {
      name = "Return to Party Bus",
      action = function()
        returnToPartyBus()
        PauseMenu.resume()
      end,
      info = "Returns to the party bus, HOST Only"
    }
  }
}
local colours = {
  default = vec.vector(1, 1, 1, 1),
  selection = vec.vector(1, 0, 0, 1),
  disabled = vec.vector(0.25, 0.25, 0.25, 1)
}
function drawMenu()
  if HUDOn == true then
    local menu = menus[activeMenu]
    if menu then
      local title_scale = 1.2
      local item_scale = 0.9
      local y = 0.15
      local chapter = challengeProgressionTable[progressionSystem.currentProgression].settings.chapter
      Development:add2DText(0, menu.title, title_position, colours.default, title_scale, -1)
      for i = 1, #menu.entries do
        if menu.entries[i].name ~= "Skip Current Game" and menu.entries[i].name ~= "Level 1" and menu.entries[i].name ~= "Level 1,2" and menu.entries[i].name ~= "Level 1,2,3" and menu.entries[i].name ~= "Level 1,2,3,4" and menu.entries[i].name ~= "Level 1,2,3,4,5" and menu.entries[i].name ~= "chapter select" and menu.entries[i].name ~= "quit Current Mission" and menu.entries[i].name ~= "complete Current Mission" and menu.entries[i].name ~= "fail Current Mission" and menu.entries[i].name ~= "Restart Current Mission" and menu.entries[i].name ~= "missions" and menu.entries[i].name ~= "Disable Zap Radius" and menu.entries[i].name ~= "Toggle Zap Fuel" and menu.entries[i].name ~= "LIAB Chapter 1" and menu.entries[i].name ~= "LIAB Chapter 2" and menu.entries[i].name ~= "LIAB Chapter 3" and menu.entries[i].name ~= "LIAB Chapter 4" and menu.entries[i].name ~= "LIAB Chapter 5" and menu.entries[i].name ~= "LIAB Chapter 6" and menu.entries[i].name ~= "LIAB Chapter 7" then
          menuEntry_position[1] = y
          Development:add2DText(i, menu.entries[i].name, menuEntry_position, colours.default, item_scale, -1)
        elseif menu.entries[i].name == "quit Current Mission" or menu.entries[i].name == "complete Current Mission" or menu.entries[i].name == "fail Current Mission" or menu.entries[i].name == "Restart Current Mission" then
          menuEntry_position[1] = y
          if localPlayer:getTaskObject() or faceOffSystem.currentFaceOff then
            Development:add2DText(i, menu.entries[i].name, menuEntry_position, colours.default, item_scale, -1)
          else
            Development:add2DText(i, menu.entries[i].name, menuEntry_position, colours.disabled, item_scale, -1)
          end
        elseif menu.entries[i].name == "missions" then
          menuEntry_position[1] = y
          if localPlayer then
            if localPlayer.inCutscene then
              Development:add2DText(i, menu.entries[i].name, menuEntry_position, colours.disabled, item_scale, -1)
            else
              Development:add2DText(i, menu.entries[i].name, menuEntry_position, colours.default, item_scale, -1)
            end
          else
            Development:add2DText(i, menu.entries[i].name, menuEntry_position, colours.disabled, item_scale, -1)
          end
        elseif menu.entries[i].name == "Skip Current Game" then
          menuEntry_position[1] = y
          if gameStatus and not gameStatus.onlineSession then
            Development:add2DText(i, menu.entries[i].name, menuEntry_position, colours.disabled, item_scale, -1)
          else
            Development:add2DText(i, menu.entries[i].name, menuEntry_position, colours.default, item_scale, -1)
          end
        elseif menu.entries[i].name == "LIAB Chapter 1" and chapter == 1 or menu.entries[i].name == "LIAB Chapter 2" and chapter == 2 or menu.entries[i].name == "LIAB Chapter 3" and chapter == 3 or menu.entries[i].name == "LIAB Chapter 4" and chapter == 4 or menu.entries[i].name == "LIAB Chapter 5" and chapter == 5 or menu.entries[i].name == "LIAB Chapter 6" and chapter == 6 or menu.entries[i].name == "LIAB Chapter 7" and chapter == 7 then
          menuEntry_position[1] = y
          Development:add2DText(i, menu.entries[i].name, menuEntry_position, colours.default, item_scale, -1)
        elseif menu.entries[i].name == "LIAB Chapter 1" and chapter ~= 1 or menu.entries[i].name == "LIAB Chapter 2" and chapter ~= 2 or menu.entries[i].name == "LIAB Chapter 3" and chapter ~= 3 or menu.entries[i].name == "LIAB Chapter 4" and chapter ~= 4 or menu.entries[i].name == "LIAB Chapter 5" and chapter ~= 5 or menu.entries[i].name == "LIAB Chapter 6" and chapter ~= 6 or menu.entries[i].name == "LIAB Chapter 7" and chapter ~= 7 then
          menuEntry_position[1] = y
          Development:add2DText(i, menu.entries[i].name, menuEntry_position, colours.disabled, item_scale, -1)
        else
          menuEntry_position[1] = y
          if localPlayer then
            if localPlayer.inZap or localPlayer.inCutscene then
              Development:add2DText(i, menu.entries[i].name, menuEntry_position, colours.disabled, item_scale, -1)
            else
              Development:add2DText(i, menu.entries[i].name, menuEntry_position, colours.default, item_scale, -1)
            end
          else
            Development:add2DText(i, menu.entries[i].name, menuEntry_position, colours.disabled, item_scale, -1)
          end
        end
        if menu.entries[i].valueText ~= nil then
          menuEntry_position[0] = menuEntry_position[0] + 0.1
          Development:add2DText(#menu.entries + i + 1001, menu.entries[i].valueText(), menuEntry_position, colours.default, item_scale, -1)
          menuEntry_position[0] = menuEntry_position[0] - 0.1
        end
        y = y + menuSpacing
      end
      if menu.entries[selected].info ~= nil then
        Development:add2DText(#menu.entries + 1, "Info: " .. menu.entries[selected].info, menuInfo_position, colours.default, item_scale, -1)
      end
      local mediaVersion_scale = 1
      Development:add2DText(#menu.entries + 2, menu.mediaVersion, mediaVersion_position, colours.default, mediaVersion_scale, -1)
    end
  end
end
function clearPauseMenu()
  selected = 1
  clearCurrentMenu()
  activeMenu = "Pause"
  if devElementsOn == false then
    Development:useDevText(false)
  end
  pauseMenuShown = false
  controlHandler:resetState("Pause")
  Menu.ShowHUD = 1
end
local function step(menu, change)
  if menu.entries[selected].info ~= nil then
    Development:eraseText(#menu.entries + 1)
  end
  selected = selected + change
  if selected < 1 then
    selected = #menu.entries
  elseif selected > #menu.entries then
    selected = 1
  end
end
local function stepMenu(moveStep)
  local menu = menus[activeMenu]
  local chapter = challengeProgressionTable[progressionSystem.currentProgression].settings.chapter
  step(menu, moveStep)
  if menu.entries[selected].name == "chapter select" then
    if localPlayer then
      if localPlayer.inZap then
        step(menu, moveStep)
      end
    else
      step(menu, moveStep)
    end
  elseif menu.entries[selected].name == "toggle moods" then
    if not moodSystem then
      step(menu, moveStep)
    end
  elseif menu.entries[selected].name == "Skip Current Game" then
    if gameStatus and not gameStatus.onlineSession then
      step(menu, moveStep)
    end
  elseif menu.entries[selected].name == "LIAB Chapter 1" and chapter ~= 1 or menu.entries[selected].name == "LIAB Chapter 2" and chapter ~= 2 or menu.entries[selected].name == "LIAB Chapter 3" and chapter ~= 3 or menu.entries[selected].name == "LIAB Chapter 4" and chapter ~= 4 or menu.entries[selected].name == "LIAB Chapter 5" and chapter ~= 5 or menu.entries[selected].name == "LIAB Chapter 6" and chapter ~= 6 or menu.entries[selected].name == "LIAB Chapter 7" and chapter ~= 7 then
    step(menu, moveStep)
  end
  drawMenu()
end
local function stepMenuUp()
  OneShotSound.PlayMenuSound("Menu_Move")
  stepMenu(-1)
end
local function stepMenuDown()
  OneShotSound.PlayMenuSound("Menu_Move")
  stepMenu(1)
end
local function stepMenuLeft()
  local menu = menus[activeMenu]
  if menu.entries[selected].leftAction then
    menu.entries[selected].leftAction()
    drawMenu()
  end
end
local function stepMenuRight()
  local menu = menus[activeMenu]
  if menu.entries[selected].rightAction then
    menu.entries[selected].rightAction()
    drawMenu()
  end
end
local function stepMenuSelect()
  local menu = menus[activeMenu]
  if menu.entries[selected].action ~= nil then
    OneShotSound.PlayMenuSound("Menu_Select")
    menu.entries[selected].action()
  end
end
local stepMenuCancel = function()
  OneShotSound.PlayMenuSound("Menu_Back")
  PauseMenu.resume()
end
local stepCameraPress = function(state, value, localID)
  cycleActiveCamera(state, value, localID)
end
local minimapOut = function(state, value, localID)
  plr = localPlayerManager.players[localID]
  plr.minimapSupport:zoomOut()
end
local minimapIn = function(state, value, localID)
  plr = localPlayerManager.players[localID]
  plr.minimapSupport:zoomIn()
end
PauseMenuCallbacks = {
  Menu_Down = {
    JustPressed = {
      [1] = stepMenuDown
    }
  },
  Menu_Up = {
    JustPressed = {
      [1] = stepMenuUp
    }
  },
  Menu_Left = {
    JustPressed = {
      [1] = stepMenuLeft
    }
  },
  Menu_Right = {
    JustPressed = {
      [1] = stepMenuRight
    }
  },
  Menu_Select = {
    JustPressed = {
      [1] = stepMenuSelect
    }
  },
  Menu_Cancel = {
    JustPressed = {
      [1] = stepMenuCancel
    }
  },
  Camera_Change = {
    JustPressed = {
      [1] = stepCameraPress
    }
  },
  Zoom_Minimap = {
    JustPressed = {
      [1] = minimapOut
    },
    JustReleased = {
      [1] = minimapIn
    }
  }
}
controlHandler:registerState(0, "Pause", PauseMenuCallbacks)
controlHandler:registerState(1, "Pause", PauseMenuCallbacks)
function TriggerPauseMenu()
  drawMenu()
  if devElementsOn == false then
    Development:useDevText(true)
  end
  pauseMenuShown = true
  controlHandler:setState("Pause")
  Menu.ShowHUD = 0
end
local OptionsMenu = {}
table.insert(OptionsMenu, {
  name = "ForceFeedback reset",
  action = function()
    Menu.InputFFBReset()
    PauseMenu.resume()
  end,
  info = "Reset ForceFeedback for current input device"
})
table.insert(OptionsMenu, {
  name = "Controls reset",
  action = function()
    Menu.InputCtrReset()
    PauseMenu.resume()
  end,
  info = "Reset Input mappings for current input device"
})
table.insert(OptionsMenu, {
  name = "Zap options",
  action = changePauseMenu("ZapRadius"),
  info = "Zap options"
})
table.insert(OptionsMenu, {
  name = "Cheats",
  action = changePauseMenu("CheatMenu"),
  info = "Cheats to complete missions and dares"
})
table.insert(OptionsMenu, {
  name = "Chapter select FOR DEV ONLY",
  action = changePauseMenu("chapterSelect"),
  info = "change between chapters"
})
table.insert(OptionsMenu, {
  name = "Online Progression...",
  action = changePauseMenu("OnlineProgression"),
  info = "Online Progression..."
})
table.insert(OptionsMenu, {
  name = "Online Statistics...",
  action = changePauseMenu("OnlineStatistics"),
  info = "Online Statistics Options ..."
})
table.insert(OptionsMenu, {
  name = "Online Zap Weapons...",
  action = changePauseMenu("OnlineZapWeapons"),
  info = "Online Zap Weapon Options..."
})
table.insert(OptionsMenu, {
  name = "Online Modes...",
  action = changePauseMenu("OnlineModes"),
  info = "Online Modes Options..."
})
table.insert(OptionsMenu, {
  name = "Debug Commands",
  action = changePauseMenu("DebugCommands"),
  info = "Debug commands"
})
table.insert(OptionsMenu, {
  name = "Network Debug...",
  action = changePauseMenu("NetworkDebug"),
  info = "Network Debug..."
})
table.insert(OptionsMenu, {
  name = "Visual Options / OSD",
  action = changePauseMenu("Visuals"),
  info = "Change Visual Options, Toggle HUD, Light Trails, Skid Marks, FPS Counter, P Process, Overtake Flash"
})
table.insert(OptionsMenu, {
  name = "Toggle Rumble",
  action = toggleRumble,
  info = "toggle rumble"
})
table.insert(OptionsMenu, {
  name = "Toggle Music",
  action = Music.ToggleMute,
  info = "toggle music"
})
table.insert(OptionsMenu, {
  name = "Toggle Felony",
  action = toggleFelony,
  info = "toggle felony"
})
table.insert(OptionsMenu, {
  name = "Screenshot",
  action = HideMenusForScreenshot,
  info = "Hide HUD for Screenshot"
})
table.insert(OptionsMenu, {
  name = "Car Type Abilities",
  action = changePauseMenu("carAbilities"),
  info = "Car type abilities"
})
table.insert(OptionsMenu, {
  name = "Toggle Postcard Locations",
  action = TogglePostcardLocations,
  info = "Toggle postcard locations"
})
table.insert(OptionsMenu, {
  name = "Toggle Commentary Debug",
  action = ToggleCommentaryDebug,
  info = "Toggle Commentary Debug"
})
table.insert(OptionsMenu, {
  name = "Toggle Commentary Logging",
  action = ToggleCommentaryLogging,
  info = "Toggle Commentary Logging"
})
table.insert(OptionsMenu, {
  name = "Commentary and LIAB Debug",
  action = changePauseMenu("CommentaryDebugMenu"),
  info = "Commentary and LIAB Debug Menu"
})
table.insert(OptionsMenu, {
  name = "Toggle Pedestrians",
  action = togglePedestrians,
  info = "Toggle Pedestrians"
})
table.insert(OptionsMenu, {
  name = "Quit to Frontend",
  action = PauseMenu.quit,
  info = "quit to frontend"
})
table.insert(OptionsMenu, {
  name = "Quit to Dash",
  action = framework.quit,
  info = "quit to dash"
})
table.insert(OptionsMenu, {
  name = "Back",
  action = changePauseMenu("Pause")
})
addPauseMenu("OptionsMenu", OptionsMenu)
local VisualsDebugMenu = {}
table.insert(VisualsDebugMenu, {
  name = "Toggle Dev HUD",
  action = toggleDevElements,
  info = "Disables/enables dev text and graphics"
})
table.insert(VisualsDebugMenu, {
  name = "Toggle PIPs",
  action = togglePips,
  info = "Toggle Picture in Picture"
})
table.insert(VisualsDebugMenu, {
  name = "Toggle HUD",
  action = toggleHUD,
  info = "Toggle the HUD"
})
table.insert(VisualsDebugMenu, {
  name = "Toggle Gamma Correction",
  action = toggleGamma
})
table.insert(VisualsDebugMenu, {
  name = "Toggle Post Process",
  action = togglePostProcess
})
table.insert(VisualsDebugMenu, {name = "Toggle PVS", action = togglePVS})
table.insert(VisualsDebugMenu, {
  name = "toggle FPS",
  action = toggleFPS,
  info = "toggle FPS counter"
})
table.insert(VisualsDebugMenu, {
  name = "toggle 30hz",
  action = toggle30hz,
  info = "toggle 30hz mode"
})
table.insert(VisualsDebugMenu, {
  name = "Remove Light Trails",
  action = function()
    removelightTrails()
    PauseMenu.resume()
  end,
  info = "Remove Light Trails"
})
table.insert(VisualsDebugMenu, {
  name = "Enable Light Trails",
  action = function()
    enablelightTrails()
    PauseMenu.resume()
  end,
  info = "Enable Light Trails"
})
table.insert(VisualsDebugMenu, {
  name = "Disable Overtake Flash",
  action = function()
    scoringSystem.trafficOvertakingFlashGraphicsOn = false
    PauseMenu.resume()
  end,
  info = "Disable Vehicle Flash On Overtake"
})
table.insert(VisualsDebugMenu, {
  name = "Enable Overtake Flash",
  action = function()
    scoringSystem.trafficOvertakingFlashGraphicsOn = true
    PauseMenu.resume()
  end,
  info = "Enable Vehicle Flash On Overtake"
})
table.insert(VisualsDebugMenu, {
  name = "Remove skid marks",
  action = function()
    CVehicleSFX.clearSkidmarks()
    PauseMenu.resume()
  end,
  info = "Removes your skid marks!"
})
table.insert(VisualsDebugMenu, {
  name = "Toggle ICam Overlay",
  action = TogglePIPOverlay,
  info = "Play the ICam overlay on top of the game"
})
table.insert(VisualsDebugMenu, {
  name = "Toggle Traffic Carrier Count",
  action = ToggleTrafficCarrierCount,
  info = "Show how many traffic carriers are being simulated around the player"
})
table.insert(VisualsDebugMenu, {
  name = "Back to Pause",
  action = changePauseMenu("Pause")
})
addPauseMenu("Visuals", VisualsDebugMenu)
local DebugCommandsMenu = {}
table.insert(DebugCommandsMenu, {
  name = "AI...",
  action = changePauseMenu("AI"),
  info = "Debug options for working with AI"
})
table.insert(DebugCommandsMenu, {
  name = "Spawn Chasers...",
  action = changePauseMenu("SpawnChasers"),
  info = "Spawn a selected number of chasers"
})
table.insert(DebugCommandsMenu, {
  name = "Toggle CPU Log...",
  action = toggleCPULog,
  info = "Toggle CPU Performance logging"
})
table.insert(DebugCommandsMenu, {
  name = "Toggle Player Indicator Graphics",
  action = function()
    PlayerAnalysis.ToggleDebugGraphics()
    PauseMenu.resume()
  end,
  info = "Toggle CPU Performance logging"
})
table.insert(DebugCommandsMenu, {
  name = "Toggle soft save warnings",
  action = function()
    debugSoftSaveWarning = not debugSoftSaveWarning
    PauseMenu.resume()
  end,
  info = "Debug options for working with AI"
})
table.insert(DebugCommandsMenu, {
  name = "Toggle race checkpoint display",
  action = function()
    RaceManager.ToggleDebugGraphics()
    OnlineRaceManager.ToggleDebugGraphics()
    PauseMenu.resume()
  end,
  info = "Display checkpoint detection volumes"
})
table.insert(DebugCommandsMenu, {
  name = "Back",
  action = changePauseMenu("OptionsMenu")
})
addPauseMenu("DebugCommands", DebugCommandsMenu)
local AIMenu = {}
table.insert(AIMenu, {
  name = "Turn ON cheap AI debugging info",
  action = function()
    ActiveLifeAI.enableCheapDebugger(true)
    PauseMenu.resume()
  end,
  info = "Draws basic AI settings above AI controled vehicles"
})
table.insert(AIMenu, {
  name = "Turn OFF cheap AI debugging info",
  action = function()
    ActiveLifeAI.enableCheapDebugger(false)
    PauseMenu.resume()
  end,
  info = "Disables the AI debugging info"
})
table.insert(AIMenu, {
  name = "Turn ON Search Area Graphics",
  action = function()
    ActiveLifeAI.enableSearchAreaDebugging(true)
    allowFreeCam(true)
    PauseMenu.resume()
  end,
  info = "Draws the AI search area boarders"
})
table.insert(AIMenu, {
  name = "Turn OFF Search Area Graphics",
  action = function()
    ActiveLifeAI.enableSearchAreaDebugging(false)
    PauseMenu.resume()
  end,
  info = "Disables the AI search area debug graphics"
})
table.insert(AIMenu, {
  name = "TOGGLE AI Counter",
  action = function()
    ActiveLifeAI.toggleAICounter()
    PauseMenu.resume()
  end,
  info = "Displays how many Active Life AI are currently enabled"
})
table.insert(AIMenu, {
  name = "TOGGLE AI Systems Counter",
  action = function()
    ActiveLifeAI.ToggleAISystemsCounter()
  end,
  info = "Displays how many AIs are owned by each system"
})
table.insert(AIMenu, {
  name = "Start CIV AI",
  action = function()
    startAIControl("civ")
    PauseMenu.resume()
  end,
  info = "Changes the player vehicle to the CIV personality"
})
table.insert(AIMenu, {
  name = "Start FAST CIV AI",
  action = function()
    startAIControl("fastCiv")
    PauseMenu.resume()
  end,
  info = "Changes the player vehicle to the FAST CIV personality"
})
table.insert(AIMenu, {
  name = "Start RACER AI",
  action = function()
    startAIControl("racer")
    PauseMenu.resume()
  end,
  info = "Changes the player vehicle to the RACER personality"
})
table.insert(AIMenu, {
  name = "Start COP AI",
  action = function()
    startAIControl("cop")
    PauseMenu.resume()
  end,
  info = "Changes the player vehicle to the COP personality"
})
table.insert(AIMenu, {
  name = "Start AGGRESSIVE COP AI",
  action = function()
    startAIControl("aggressiveCop")
    PauseMenu.resume()
  end,
  info = "Changes the player vehicle to the AGGRESSIVE COP personality"
})
table.insert(AIMenu, {
  name = "Start BUS AI",
  action = function()
    startAIControl("bus")
    PauseMenu.resume()
  end,
  info = "Changes the player vehicle to the BUS personality"
})
table.insert(AIMenu, {
  name = "Resume Player Control",
  action = function()
    startAIControl(nil)
    PauseMenu.resume()
  end,
  info = "Restored the player vehicle to player control"
})
table.insert(AIMenu, {
  name = "Back",
  action = changePauseMenu("DebugCommands")
})
function startAIControl(personality)
  if localPlayer then
    if personality then
      ActiveLifeAI.stopActiveLife(localPlayer.currentVehicle.gameVehicle)
      localPlayer.controllerInterface:removePlayerControl()
      player.setAttachment(localPlayer.localID, game_camera)
      ActiveLifeAI.createActiveLife(localPlayer.currentVehicle.gameVehicle, personality)
    else
      ActiveLifeAI.stopActiveLife(localPlayer.currentVehicle.gameVehicle)
      player.setAttachment(localPlayer.localID, localPlayer.currentVehicle.gameVehicle)
      localPlayer.controllerInterface:registerPlayerControl()
    end
  end
end
addPauseMenu("AI", AIMenu)
local SpawnChasersMenu = {}
table.insert(SpawnChasersMenu, {
  name = "Spawn 1 Chaser",
  action = function()
    spawnChaser(1)
    PauseMenu.resume()
  end,
  info = "Spawn a selected number of chasers"
})
table.insert(SpawnChasersMenu, {
  name = "Spawn 2 Chasers",
  action = function()
    spawnChaser(2)
    PauseMenu.resume()
  end,
  info = "Spawn a selected number of chasers"
})
table.insert(SpawnChasersMenu, {
  name = "Spawn 3 Chasers",
  action = function()
    spawnChaser(3)
    PauseMenu.resume()
  end,
  info = "Spawn a selected number of chasers"
})
table.insert(SpawnChasersMenu, {
  name = "Spawn 4 Chasers",
  action = function()
    spawnChaser(4)
    PauseMenu.resume()
  end,
  info = "Spawn a selected number of chasers"
})
table.insert(SpawnChasersMenu, {
  name = "Spawn 5 Chasers",
  action = function()
    spawnChaser(5)
    PauseMenu.resume()
  end,
  info = "Spawn a selected number of chasers"
})
table.insert(SpawnChasersMenu, {
  name = "Spawn 6 Chasers",
  action = function()
    spawnChaser(6)
    PauseMenu.resume()
  end,
  info = "Spawn a selected number of chasers"
})
table.insert(SpawnChasersMenu, {
  name = "Spawn 7 Chasers",
  action = function()
    spawnChaser(7)
    PauseMenu.resume()
  end,
  info = "Spawn a selected number of chasers"
})
table.insert(SpawnChasersMenu, {
  name = "Spawn 8 Chasers",
  action = function()
    spawnChaser(8)
    PauseMenu.resume()
  end,
  info = "Spawn a selected number of chasers"
})
table.insert(SpawnChasersMenu, {
  name = "Spawn 9 Chasers",
  action = function()
    spawnChaser(9)
    PauseMenu.resume()
  end,
  info = "Spawn a selected number of chasers"
})
table.insert(SpawnChasersMenu, {
  name = "Spawn 10 Chasers",
  action = function()
    spawnChaser(10)
    PauseMenu.resume()
  end,
  info = "Spawn a selected number of chasers"
})
table.insert(SpawnChasersMenu, {
  name = "Spawn 11 Chasers",
  action = function()
    spawnChaser(11)
    PauseMenu.resume()
  end,
  info = "Spawn a selected number of chasers"
})
table.insert(SpawnChasersMenu, {
  name = "Spawn 12 Chasers",
  action = function()
    spawnChaser(12)
    PauseMenu.resume()
  end,
  info = "Spawn a selected number of chasers"
})
table.insert(SpawnChasersMenu, {
  name = "Spawn 13 Chasers",
  action = function()
    spawnChaser(13)
    PauseMenu.resume()
  end,
  info = "Spawn a selected number of chasers"
})
table.insert(SpawnChasersMenu, {
  name = "Spawn 14 Chasers",
  action = function()
    spawnChaser(14)
    PauseMenu.resume()
  end,
  info = "Spawn a selected number of chasers"
})
table.insert(SpawnChasersMenu, {
  name = "Spawn 15 Chasers",
  action = function()
    spawnChaser(15)
    PauseMenu.resume()
  end,
  info = "Spawn a selected number of chasers"
})
table.insert(SpawnChasersMenu, {
  name = "Spawn 25 Chasers",
  action = function()
    spawnChaser(25)
    PauseMenu.resume()
  end,
  info = "WARNING: MAY CRASH GAME"
})
table.insert(SpawnChasersMenu, {
  name = "Back",
  action = changePauseMenu("DebugCommands")
})
addPauseMenu("SpawnChasers", SpawnChasersMenu)
local OnlineProgressionMenu = {}
table.insert(OnlineProgressionMenu, {
  name = "Set Player Level 0",
  action = resetPlayerOnlineProgression,
  info = "Set the players level to level 0"
})
table.insert(OnlineProgressionMenu, {
  name = "Set Player Level Max",
  action = setPlayerMaxOnlineProgression,
  info = "Set the players level to the max level"
})
table.insert(OnlineProgressionMenu, {
  name = "Progress to next level",
  action = unlockNextOnlineProgression,
  info = "Progress the players level to the next level"
})
table.insert(OnlineProgressionMenu, {
  name = "Toggle online progression debug info",
  action = toggleOnlineProgDebugText,
  info = "Show Online Progression Debug Info"
})
table.insert(OnlineProgressionMenu, {
  name = "Add 1000 xp",
  action = addThousandXPToOnlineProg,
  info = "Add 1000 xp to player mode gained xp (not total xp)"
})
table.insert(OnlineProgressionMenu, {
  name = "Add 5000 xp",
  action = addFiveThousandXPToOnlineProg,
  info = "Add 5000 xp to player mode gained xp (not total xp)"
})
table.insert(OnlineProgressionMenu, {
  name = "Add 10000 xp",
  action = addTenThousandXPToOnlineProg,
  info = "Add 10000 xp to player mode gained xp (not total xp)"
})
table.insert(OnlineProgressionMenu, {
  name = "Add 100000 xp",
  action = addHundredThousandXPToOnlineProg,
  info = "Add 100000 xp to player mode gained xp (not total xp)"
})
table.insert(OnlineProgressionMenu, {
  name = "Back",
  action = changePauseMenu("OptionsMenu")
})
addPauseMenu("OnlineProgression", OnlineProgressionMenu)
local onlineModesMenu = {}
table.insert(onlineModesMenu, {
  name = "Allow Too Few Players",
  action = onlineTurnOnAllowTooFewPlayers,
  info = "Allow multiplayer modes to be played with 1 player. Only works with Trophy tag, trailblazer, classic race, sprint race"
})
table.insert(onlineModesMenu, {
  name = "Toggle Mode Debug Info",
  action = onlineToggleDebugModeInfo,
  info = "Show Debug Info For the current Mode"
})
table.insert(onlineModesMenu, {
  name = "Tutorial Vehicle Swap",
  action = tutorialVehicleSwap,
  info = "Player Vehicle Swap Tutorial"
})
table.insert(onlineModesMenu, {
  name = "Tutorial Vehicle Spawn",
  action = tutorialVehicleSpawn,
  info = "Tutorial Vehicle Spawn"
})
table.insert(onlineModesMenu, {
  name = "Tutorial Shift Attack: Impulse",
  action = tutorialShiftImpulse,
  info = "Tutorial Shift Attack: Impulse"
})
table.insert(onlineModesMenu, {
  name = "Tutorial Shift Attack: Take",
  action = tutorialShiftTake,
  info = "Tutorial Shift Attack: Take"
})
table.insert(onlineModesMenu, {
  name = "Tutorial General Mechanics",
  action = tutorialGeneralMechanics,
  info = "Tutorial General Mechanics"
})
table.insert(onlineModesMenu, {
  name = "Stop random route selection",
  action = lockRouteSelection,
  info = "Stops the current route selection from cycling"
})
table.insert(onlineModesMenu, {
  name = "Cycle to the next route",
  action = nextRouteSelection,
  info = "Cycle to the next route"
})
table.insert(onlineModesMenu, {
  name = "Cycle to the previous route",
  action = lastRouteSelection,
  info = "Cycle to the previous route"
})
table.insert(onlineModesMenu, {
  name = "Cycle to the next route faceoff",
  action = nextRouteSelectionFaceOff,
  info = "Cycle to the next route faceoff"
})
table.insert(onlineModesMenu, {
  name = "Cycle to the previous route faceoff",
  action = lastRouteSelectionFaceOff,
  info = "Cycle to the previous route faceoff"
})
addPauseMenu("OnlineModes", onlineModesMenu)
local OnlineStatisticsMenu = {}
table.insert(OnlineStatisticsMenu, {
  name = "Clear server XP",
  action = resetPlayerXP,
  info = "Set the players server xp to 0"
})
table.insert(OnlineStatisticsMenu, {
  name = "Clear server mission statistics",
  action = clearPlayerMissionStats,
  info = "Set the players server mission statistics to 0"
})
table.insert(OnlineStatisticsMenu, {
  name = "Use server xp",
  action = setPlayerXPtoServerXP,
  info = "Set the players xp to the servers xp"
})
table.insert(OnlineStatisticsMenu, {
  name = "Back",
  action = changePauseMenu("OptionsMenu")
})
addPauseMenu("OnlineStatistics", OnlineStatisticsMenu)
local ZapWeaponSupportMenu = {}
table.insert(ZapWeaponSupportMenu, {
  name = "Set Zap Weapon Cooldown infinite (1)",
  action = setInfiniteZapWeaponCooldown,
  info = "Set the players zap weapon cooldown to 1"
})
table.insert(ZapWeaponSupportMenu, {
  name = "Set Zap Weapon Cooldown to 60",
  action = setZapWeaponCooldownSixty,
  info = "Set the players zap weapon cooldown to 60"
})
table.insert(ZapWeaponSupportMenu, {
  name = "Set Zap Weapon Cooldown to 45",
  action = setZapWeaponCooldownFortyFive,
  info = "Set the players zap weapon cooldown to 45"
})
table.insert(ZapWeaponSupportMenu, {
  name = "Set Zap Weapon Cooldown to 30",
  action = setZapWeaponCooldownThirty,
  info = "Set the players zap weapon cooldown to 30"
})
table.insert(ZapWeaponSupportMenu, {
  name = "Set Zap Weapon Cooldown to 20",
  action = setZapWeaponCooldownTwenty,
  info = "Set the players zap weapon cooldown to 20"
})
table.insert(ZapWeaponSupportMenu, {
  name = "Set Zap Weapon Cooldown to 10",
  action = setZapWeaponCooldownTen,
  info = "Set the players zap weapon cooldown to 10"
})
table.insert(ZapWeaponSupportMenu, {
  name = "Back",
  action = changePauseMenu("OptionsMenu")
})
addPauseMenu("OnlineZapWeapons", ZapWeaponSupportMenu)
local NetworkDebugMenu = {}
table.insert(NetworkDebugMenu, {
  name = "Network Display",
  action = Network.toggleNetworkDisplay,
  info = "Toggle the network info display"
})
table.insert(NetworkDebugMenu, {
  name = "Network Datasets",
  action = Network.toggleNetworkDatasetDisplay,
  info = "Toggle the network object dataset display"
})
table.insert(NetworkDebugMenu, {
  name = "Object Ownership Gfx",
  action = Network.toggleObjectOwnershipGfx,
  info = "Toggle the network object ownership graphics"
})
table.insert(NetworkDebugMenu, {
  name = "Network Handles",
  action = Network.toggleNetworkHandleDisplay,
  info = "Toggle the network object handles"
})
table.insert(NetworkDebugMenu, {
  name = "Object Registration gfx",
  action = Network.toggleRegistrationGfx,
  info = "Toggle the network object registration debug graphics"
})
table.insert(NetworkDebugMenu, {
  name = "Output Network TTY",
  action = Network.toggleRegistrationTTY,
  info = "Toggle network controller TTY output"
})
table.insert(NetworkDebugMenu, {
  name = "Network Vehicle Trails",
  action = Network.toggleRemoteVehiclePositionGfx,
  info = "Toggle the remote vehicle position graphics"
})
table.insert(NetworkDebugMenu, {
  name = "Objects To Screen",
  action = Network.toggleObjectListToScreen,
  info = "Toggle the PrintNetObjects display to screen"
})
table.insert(NetworkDebugMenu, {
  name = "Objects To TTY",
  action = Network.toggleObjectListToTTY,
  info = "Toggle the PrintNetObjects output to TTY"
})
table.insert(NetworkDebugMenu, {
  name = "Object List Cont Update",
  action = Network.toggleObjectListContinuousDisplay,
  info = "Call object list display every registration step"
})
table.insert(NetworkDebugMenu, {
  name = "Display NTEs",
  action = Network.toggleDisplayNTE,
  info = "Display NTEs"
})
table.insert(NetworkDebugMenu, {
  name = "Display Carriers",
  action = Network.toggleDisplayCarriers,
  info = "Display Carriers"
})
table.insert(NetworkDebugMenu, {
  name = "Migration Time",
  action = Network.incrementDisplayMigrationTime,
  info = "Display Migration Time"
})
table.insert(NetworkDebugMenu, {
  name = "Traffic Sync Test",
  action = Network.toggleTrafficDeterminismTest,
  info = "Traffic Sync Test"
})
table.insert(NetworkDebugMenu, {
  name = "Print GV",
  action = Network.printGV,
  info = "Print GV"
})
table.insert(NetworkDebugMenu, {
  name = "Print GamerTags",
  action = Network.printGamerTags,
  info = "Print GamerTags"
})
table.insert(NetworkDebugMenu, {
  name = "Enable Quazal Log",
  action = Network.enableQuazalLog,
  info = "Enable Quazal Log"
})
table.insert(NetworkDebugMenu, {
  name = "Disable Quazal Log",
  action = Network.disableQuazalLog,
  info = "Disable Quazal Log"
})
table.insert(NetworkDebugMenu, {
  name = "Back",
  action = changePauseMenu("OptionsMenu")
})
addPauseMenu("NetworkDebug", NetworkDebugMenu)
local ZapRadiusMenu = {}
table.insert(ZapRadiusMenu, {
  name = "Missile zap",
  action = zapRadius1,
  info = "Sets Zap Radius to 150m"
})
table.insert(ZapRadiusMenu, {
  name = "Aerial zap level 1",
  action = zapRadius2,
  info = "Sets Zap Radius to 300m"
})
table.insert(ZapRadiusMenu, {
  name = "Aerial zap level 2",
  action = zapRadius4,
  info = "Sets Zap Radius to 1800m"
})
table.insert(ZapRadiusMenu, {
  name = "Top level zap",
  action = zapRadius5,
  info = "Sets Zap Radius to 2000m"
})
table.insert(ZapRadiusMenu, {
  name = "Back",
  action = changePauseMenu("OptionsMenu")
})
addPauseMenu("ZapRadius", ZapRadiusMenu)
local CheatMenu = {}
table.insert(CheatMenu, {
  name = "Complete Current Mission",
  action = function()
    completeMission()
  end,
  info = "Completes the current mission if you are in one"
})
table.insert(CheatMenu, {
  name = "Fail Current Mission",
  action = function()
    failMission()
  end,
  info = "Fails the current mission if you are in one"
})
table.insert(CheatMenu, {
  name = "Complete Current Dare",
  action = function()
    dareSystem.cheatCompleteDare()
    PauseMenu.resume()
  end,
  info = "Completes the current top dare if you are in one"
})
table.insert(CheatMenu, {
  name = "Unlock Boost Ability",
  action = function()
    local blah = function()
      enableAbilities(localPlayer.localID, true)
      removeUserUpdateFunction("blah")
    end
    shop.purchaseAbility(abilities.abilitySlots.nitro, 0, true)
    scoreSystem.showAbilityFeedback(localPlayer.localID, true)
    if not localPlayer.inZap then
      localPlayer.controllerInterface:createCallbacks()
    end
    addUserUpdateFunction("blah", blah, 120, true)
    PauseMenu.resume()
  end,
  info = "Unlock Boost Ability Including Tutorial"
})
table.insert(CheatMenu, {
  name = "Unlock Ram Ability",
  action = function()
    local blah = function()
      enableAbilities(localPlayer.localID, true)
      removeUserUpdateFunction("blah")
    end
    shop.purchaseAbility(abilities.abilitySlots.ram, 0, true)
    scoreSystem.showAbilityFeedback(localPlayer.localID, true)
    if not localPlayer.inZap then
      localPlayer.controllerInterface:createCallbacks()
    end
    addUserUpdateFunction("blah", blah, 120, true)
    PauseMenu.resume()
  end,
  info = "Unlock Ram Ability Including Tutorial"
})
table.insert(CheatMenu, {
  name = "Back to Pause",
  action = changePauseMenu("Pause")
})
addPauseMenu("CheatMenu", CheatMenu)
local abilityLevelMenu = {}
table.insert(abilityLevelMenu, {
  name = "Ability Values",
  action = changePauseMenu("AbilityValues"),
  info = "Cheat to enable unlimited ability points"
})
table.insert(abilityLevelMenu, {
  name = "Unlimited Ability",
  action = function()
    zapWeaponSupport.unlimitedAbilityPoints(true)
    scoreSystem.setUnlimitedAbility()
    PauseMenu.resume()
  end,
  info = "Cheat to enable unlimited ability points"
})
table.insert(abilityLevelMenu, {
  name = "Back to Pause",
  action = changePauseMenu("Pause")
})
addPauseMenu("AbilityOptions", abilityLevelMenu)
local nitroCivilian = {
  [1] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 0.5,
    topSpeedIncrement = 1,
    heatUpTime = -1,
    attackTime = 1.5,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 6,
    pressureMax = 0.4,
    cameraDistanceMax = 3,
    cameraDistanceSustain = 2,
    cameraFovMax = 20,
    cameraShakeScale = 0.18
  },
  [2] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 1.5,
    topSpeedIncrement = 2.5,
    heatUpTime = -1,
    attackTime = 1.3,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 0.5,
    pressureMax = 0.8,
    cameraDistanceMax = 3,
    cameraDistanceSustain = 2,
    cameraFovMax = 20,
    cameraShakeScale = 0.16
  },
  [3] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 3.5,
    topSpeedIncrement = 10,
    heatUpTime = -1,
    attackTime = 0.8,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 0.5,
    pressureMax = 1.2,
    cameraDistanceMax = 2,
    cameraDistanceSustain = -1,
    cameraFovMax = 25,
    cameraShakeScale = 0.12
  }
}
local nitroDrift = {
  [1] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 0.5,
    topSpeedIncrement = 1,
    heatUpTime = -1,
    attackTime = 0.8,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 6,
    pressureMax = 1,
    cameraDistanceMax = 2.6,
    cameraDistanceSustain = 1.8,
    cameraFovMax = 20,
    cameraShakeScale = 0.14
  },
  [2] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 1.5,
    topSpeedIncrement = 2.5,
    heatUpTime = -1,
    attackTime = 0.4,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 0.5,
    pressureMax = 1.8,
    cameraDistanceMax = 2.2,
    cameraDistanceSustain = 1.4,
    cameraFovMax = 20,
    cameraShakeScale = 0.12
  },
  [3] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 1.5,
    topSpeedIncrement = 1.5,
    heatUpTime = -1,
    attackTime = 0.1,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 5,
    pressureMax = 3,
    cameraDistanceMax = 1.8,
    cameraDistanceSustain = 1,
    cameraFovMax = 20,
    cameraShakeScale = 0.08
  }
}
local nitroHeavy = {
  [1] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 0.5,
    topSpeedIncrement = 1,
    heatUpTime = -1,
    attackTime = 1.5,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 6,
    pressureMax = 0.4,
    cameraDistanceMax = 3,
    cameraDistanceSustain = 2,
    cameraFovMax = 20,
    cameraShakeScale = 0.18
  },
  [2] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 1.5,
    topSpeedIncrement = 2.5,
    heatUpTime = -1,
    attackTime = 1.3,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 0.5,
    pressureMax = 0.8,
    cameraDistanceMax = 3,
    cameraDistanceSustain = 2,
    cameraFovMax = 20,
    cameraShakeScale = 0.16
  },
  [3] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 3.5,
    topSpeedIncrement = 10,
    heatUpTime = -1,
    attackTime = 0.8,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 0.5,
    pressureMax = 1.2,
    cameraDistanceMax = 2,
    cameraDistanceSustain = -1,
    cameraFovMax = 25,
    cameraShakeScale = 0.12
  }
}
local nitroMuscle = {
  [1] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 0.5,
    topSpeedIncrement = 1,
    heatUpTime = -1,
    attackTime = 0.9,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 6,
    pressureMax = 1.2,
    cameraDistanceMax = 3,
    cameraDistanceSustain = 2,
    cameraFovMax = 20,
    cameraShakeScale = 0.18
  },
  [2] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 1.5,
    topSpeedIncrement = 2.5,
    heatUpTime = -1,
    attackTime = 0.2,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 0.5,
    pressureMax = 1.8,
    cameraDistanceMax = 3,
    cameraDistanceSustain = 2,
    cameraFovMax = 20,
    cameraShakeScale = 0.14
  },
  [3] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 3.5,
    topSpeedIncrement = 10,
    heatUpTime = -1,
    attackTime = 0.1,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 0.5,
    pressureMax = 3,
    cameraDistanceMax = 2,
    cameraDistanceSustain = 1,
    cameraFovMax = 25,
    cameraShakeScale = 0.08
  }
}
local nitroOffRoad = {
  [1] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 0.5,
    topSpeedIncrement = 1,
    heatUpTime = -1,
    attackTime = 1.5,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 6,
    pressureMax = 0.6,
    cameraDistanceMax = 3,
    cameraDistanceSustain = 2,
    cameraFovMax = 20,
    cameraShakeScale = 0.19
  },
  [2] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 1.5,
    topSpeedIncrement = 2.5,
    heatUpTime = -1,
    attackTime = 1.3,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 0.5,
    pressureMax = 1,
    cameraDistanceMax = 3,
    cameraDistanceSustain = 2,
    cameraFovMax = 20,
    cameraShakeScale = 0.16
  },
  [3] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 3.5,
    topSpeedIncrement = 10,
    heatUpTime = -1,
    attackTime = 0.8,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 0.5,
    pressureMax = 1.8,
    cameraDistanceMax = 2,
    cameraDistanceSustain = -1,
    cameraFovMax = 25,
    cameraShakeScale = 0.09
  }
}
local nitroSport = {
  [1] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 0.5,
    topSpeedIncrement = 2.5,
    heatUpTime = -1,
    attackTime = 0.8,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 0.5,
    pressureMax = 1.5,
    cameraDistanceMax = 3,
    cameraDistanceSustain = 2,
    cameraFovMax = 20,
    cameraShakeScale = 0.18
  },
  [2] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 1.5,
    topSpeedIncrement = 1,
    heatUpTime = -1,
    attackTime = 0.5,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 6,
    pressureMax = 1.5,
    cameraDistanceMax = 3,
    cameraDistanceSustain = 2,
    cameraFovMax = 20,
    cameraShakeScale = 0.14
  },
  [3] = {
    requiredPoints = 0,
    pointDegradeRate = 100,
    nitroThrust = 1.5,
    topSpeedIncrement = 1.5,
    heatUpTime = -1,
    attackTime = 0.1,
    decayTime = 0.5,
    releaseTime = 0.5,
    coolDownTime = 5,
    pressureMax = 4,
    cameraDistanceMax = 1.5,
    cameraDistanceSustain = 0.5,
    cameraFovMax = 20,
    cameraShakeScale = 0.08
  }
}
local carTypeAbilitiesMenu = {}
table.insert(carTypeAbilitiesMenu, {
  name = "Civilian Nitro",
  action = changePauseMenu("nitroCivMenu"),
  info = ""
})
table.insert(carTypeAbilitiesMenu, {
  name = "Drift Nitro",
  action = changePauseMenu("nitroDriftMenu"),
  info = ""
})
table.insert(carTypeAbilitiesMenu, {
  name = "Heavy Nitro",
  action = changePauseMenu("nitroHeavyMenu"),
  info = ""
})
table.insert(carTypeAbilitiesMenu, {
  name = "Muscle Nitro",
  action = changePauseMenu("nitroMuscleMenu"),
  info = ""
})
table.insert(carTypeAbilitiesMenu, {
  name = "Off Road Nitro",
  action = changePauseMenu("nitroOffRoadMenu"),
  info = ""
})
table.insert(carTypeAbilitiesMenu, {
  name = "Sports Nitro",
  action = changePauseMenu("nitroSportsMenu"),
  info = ""
})
table.insert(carTypeAbilitiesMenu, {
  name = "Back",
  action = changePauseMenu("OptionsMenu")
})
addPauseMenu("carAbilities", carTypeAbilitiesMenu)
function setNitroAbility(nitroSettings, level)
  local settings = AbilityController.getAbilitySettings("nitro")
  print(settings)
  print(settings.cameraShakeScale)
  for k, v in next, nitroSettings, nil do
    settings[k] = v
  end
  print(settings.cameraShakeScale)
  PauseMenu.resume()
end
local nitroCivilianMenu = {}
table.insert(nitroCivilianMenu, {
  name = "Civilian Nitro Level 1",
  action = function()
    setNitroAbility(nitroCivilian[1], 1)
  end,
  info = ""
})
table.insert(nitroCivilianMenu, {
  name = "Civilian Nitro Level 2",
  action = function()
    setNitroAbility(nitroCivilian[2], 2)
  end,
  info = ""
})
table.insert(nitroCivilianMenu, {
  name = "Civilian Nitro Level 3",
  action = function()
    setNitroAbility(nitroCivilian[3], 3)
  end,
  info = ""
})
table.insert(nitroCivilianMenu, {
  name = "Back",
  action = changePauseMenu("carAbilities")
})
addPauseMenu("nitroCivMenu", nitroCivilianMenu)
local nitroDriftMenu = {}
table.insert(nitroDriftMenu, {
  name = "Drift Nitro Level 1",
  action = function()
    setNitroAbility(nitroDrift[1], 1)
  end,
  info = ""
})
table.insert(nitroDriftMenu, {
  name = "Drift Nitro Level 2",
  action = function()
    setNitroAbility(nitroDrift[2], 2)
  end,
  info = ""
})
table.insert(nitroDriftMenu, {
  name = "Drift Nitro Level 3",
  action = function()
    setNitroAbility(nitroDrift[3], 3)
  end,
  info = ""
})
table.insert(nitroDriftMenu, {
  name = "Back",
  action = changePauseMenu("carAbilities")
})
addPauseMenu("nitroDriftMenu", nitroDriftMenu)
local nitroHeavyMenu = {}
table.insert(nitroHeavyMenu, {
  name = "Heavy Nitro Level 1",
  action = function()
    setNitroAbility(nitroHeavy[1], 1)
  end,
  info = ""
})
table.insert(nitroHeavyMenu, {
  name = "Heavy Nitro Level 2",
  action = function()
    setNitroAbility(nitroHeavy[2], 2)
  end,
  info = ""
})
table.insert(nitroHeavyMenu, {
  name = "Heavy Nitro Level 3",
  action = function()
    setNitroAbility(nitroHeavy[3], 3)
  end,
  info = ""
})
table.insert(nitroHeavyMenu, {
  name = "Back",
  action = changePauseMenu("carAbilities")
})
addPauseMenu("nitroHeavyMenu", nitroHeavyMenu)
local nitroMuscleMenu = {}
table.insert(nitroMuscleMenu, {
  name = "Muscle Nitro Level 1",
  action = function()
    setNitroAbility(nitroMuscle[1], 1)
  end,
  info = ""
})
table.insert(nitroMuscleMenu, {
  name = "Muscle Nitro Level 2",
  action = function()
    setNitroAbility(nitroMuscle[2], 2)
  end,
  info = ""
})
table.insert(nitroMuscleMenu, {
  name = "Muscle Nitro Level 3",
  action = function()
    setNitroAbility(nitroMuscle[3], 3)
  end,
  info = ""
})
table.insert(nitroMuscleMenu, {
  name = "Back",
  action = changePauseMenu("carAbilities")
})
addPauseMenu("nitroMuscleMenu", nitroMuscleMenu)
local nitroOffRoadMenu = {}
table.insert(nitroOffRoadMenu, {
  name = "OffRoad Nitro Level 1",
  action = function()
    setNitroAbility(nitroOffRoad[1], 1)
  end,
  info = ""
})
table.insert(nitroOffRoadMenu, {
  name = "OffRoad Nitro Level 2",
  action = function()
    setNitroAbility(nitroOffRoad[2], 2)
  end,
  info = ""
})
table.insert(nitroOffRoadMenu, {
  name = "OffRoad Nitro Level 3",
  action = function()
    setNitroAbility(nitroOffRoad[3], 3)
  end,
  info = ""
})
table.insert(nitroOffRoadMenu, {
  name = "Back",
  action = changePauseMenu("carAbilities")
})
addPauseMenu("nitroOffRoadMenu", nitroOffRoadMenu)
local nitroSportMenu = {}
table.insert(nitroSportMenu, {
  name = "Sport Nitro Level 1",
  action = function()
    setNitroAbility(nitroSport[1], 1)
  end,
  info = ""
})
table.insert(nitroSportMenu, {
  name = "Sport Nitro Level 2",
  action = function()
    setNitroAbility(nitroSport[2], 2)
  end,
  info = ""
})
table.insert(nitroSportMenu, {
  name = "Sport Nitro Level 3",
  action = function()
    setNitroAbility(nitroSport[3], 3)
  end,
  info = ""
})
table.insert(nitroSportMenu, {
  name = "Back",
  action = changePauseMenu("carAbilities")
})
addPauseMenu("nitroSportsMenu", nitroSportMenu)
local marketingMenu = {}
table.insert(marketingMenu, {
  name = "Perfect Combination for Video Footage",
  action = function()
    hideFeedback()
    Music.TogglePause(true)
    Commentary.DisableSpeech(true)
    allowFreeCam(true)
    if localPlayer.currentVehicle then
      localPlayer.currentVehicle:set_damageMultiplier(0)
    end
    VEdit.ResetVehicleDamage()
    PauseMenu.resume()
  end,
  info = "Hide visuals / Disable Music / Disable Voices / Enable Freecam / Make Car Invulnerable"
})
table.insert(marketingMenu, {
  name = "Hide All Feedback/Damage",
  action = function()
    hideFeedback()
    PauseMenu.resume()
  end,
  info = "Hides All Feedback/Damage In The Game"
})
table.insert(marketingMenu, {
  name = "Show All Feedback/Damage",
  action = function()
    showFeedback()
    PauseMenu.resume()
  end,
  info = "Shows All Feedback/Damage In The Game"
})
table.insert(marketingMenu, {
  name = "Visual Options / OSD",
  action = changePauseMenu("Visuals"),
  info = "Change Visual Options, Toggle HUD, Light Trails, Skid Marks, FPS Counter, P Process, Overtake Flash"
})
table.insert(marketingMenu, {
  name = "Willpower Options",
  action = changePauseMenu("willPowerOptionMenu"),
  info = "Change Willpower Options"
})
table.insert(marketingMenu, {
  name = "Mission Options",
  action = changePauseMenu("CheatMenu"),
  info = "Complete/Fail Missions etc"
})
table.insert(marketingMenu, {
  name = "Ability Options",
  action = changePauseMenu("AbilityLevel"),
  info = "Set ability levels"
})
table.insert(marketingMenu, {
  name = "Toggle postcard locations",
  action = TogglePostcardLocations,
  info = "Turn postcard location markers on and off"
})
table.insert(marketingMenu, {
  name = "Toggle Pedestrians",
  action = togglePedestrians,
  info = "Toggle pedestrians on and off"
})
table.insert(marketingMenu, {
  name = "Dare Selection",
  action = changePauseMenu("Dares"),
  info = "View and select Dares"
})
table.insert(marketingMenu, {
  name = "Enable Free Cam",
  action = function()
    allowFreeCam(true)
    PauseMenu.resume()
  end,
  info = "Enable Free Cam"
})
table.insert(marketingMenu, {
  name = "Disable Free Cam",
  action = function()
    while localPlayer.cameraMode ~= "Normal" do
      cycleActiveCamera("JustPressed", 1, 0)
    end
    allowFreeCam(false)
    PauseMenu.resume()
  end,
  info = "Disable Free Cam (DO NOT disable while still in freecam"
})
table.insert(marketingMenu, {
  name = "Toggle Music",
  action = function()
    Music.TogglePause(true)
    PauseMenu.resume()
  end,
  info = "Toggles the Music pause/play"
})
table.insert(marketingMenu, {
  name = "Disable Traffic",
  action = function()
    spooling.enableTraffic(false)
    PauseMenu.resume()
  end,
  info = "Disables traffic"
})
table.insert(marketingMenu, {
  name = "Enable Traffic",
  action = function()
    spooling.enableTraffic(true)
    PauseMenu.resume()
  end,
  info = "Enables traffic"
})
table.insert(marketingMenu, {
  name = "Make car invulnerable",
  action = function()
    localPlayer.currentVehicle:set_damageMultiplier(0)
    VEdit.ResetVehicleDamage()
    PauseMenu.resume()
  end,
  info = "Makes player car invulnerable"
})
table.insert(marketingMenu, {
  name = "Make car vulnerable",
  action = function()
    localPlayer.currentVehicle:set_damageMultiplier(1)
    PauseMenu.resume()
  end,
  info = "Makes player car vulnerable"
})
table.insert(marketingMenu, {
  name = "Reset Vehicle Damage",
  action = function()
    VEdit.ResetVehicleDamage()
    PauseMenu.resume()
  end,
  info = "Resets the damage of your current vehicle"
})
table.insert(marketingMenu, {
  name = "Back",
  action = changePauseMenu("Pause")
})
addPauseMenu("marketingMenu", marketingMenu)
local willPowerOptionMenu = {}
local displayWillpowerBreakdown = function()
  simulation.EnableWillpowerBreakdown()
  PauseMenu.resume()
end
table.insert(willPowerOptionMenu, {
  name = "Display Willpower Breakdown",
  action = displayWillpowerBreakdown,
  info = "Shows where willpower earned came from."
})
table.insert(willPowerOptionMenu, {
  name = "Back to pause",
  action = changePauseMenu("Pause")
})
addPauseMenu("willPowerOptionMenu", willPowerOptionMenu)
local CutScenesNames = {}
local CutScenesMenu = {}
for k in pairs(CutsceneDirectory) do
  table.insert(CutScenesNames, k)
end
table.sort(CutScenesNames)
local PageSize = 10
local PageCount = math.ceil(#CutScenesNames / PageSize)
local SceneIndex = 1
for Page = 1, PageCount do
  local PageMenu = {}
  local PageMenuName = "CutScenePage " .. tostring(Page)
  for Count = 1, PageSize do
    if SceneIndex > #CutScenesNames then
      break
    end
    local SceneName = CutScenesNames[SceneIndex]
    table.insert(PageMenu, {
      name = SceneName,
      action = function()
        playCutscenePackage(SceneName)
        PauseMenu.resume()
      end
    })
    SceneIndex = SceneIndex + 1
  end
  table.insert(PageMenu, {
    name = "Back",
    action = changePauseMenu("CutScenes")
  })
  addPauseMenu(PageMenuName, PageMenu)
  table.insert(CutScenesMenu, {
    name = "Page" .. tostring(Page),
    action = changePauseMenu(PageMenuName)
  })
end
table.insert(CutScenesMenu, {
  name = "Load cutscene traffic",
  action = function()
    PauseMenu.resume()
    spoolCutsceneTraffic()
  end
})
table.insert(CutScenesMenu, {
  name = "Back",
  action = changePauseMenu("Pause")
})
addPauseMenu("CutScenes", CutScenesMenu)
function disposeCutScene(sceneId)
  Cutscene.Dispose(sceneId)
  removeUserUpdateFunction("cutsceneDispose")
end
function cutSceneCleanup(sceneId)
  addUserUpdateFunction("cutsceneDispose", function()
    disposeCutScene(sceneId)
  end, updates.stepRate, 60)
  Menu.ShowHUD = 1
end
function callCutScene(sceneId)
  Cutscene.Play(sceneId, function()
    cutSceneCleanup(sceneId)
  end)
  removeUserUpdateFunction("cutscene")
  Menu.ShowHUD = 0
end
function cutsceneLoaded(sceneId)
  PauseMenu.resume()
  addUserUpdateFunction("cutscene", function()
    callCutScene(sceneId)
  end, updates.stepRate, 2)
end
function playCutscenePackage(sceneName)
  engineCutscene.playCutscene(sceneName)
end
local PreloadedMenu = {}
for k in pairs(PreloadedDirectory) do
  table.insert(PreloadedMenu, {
    name = k,
    action = function()
      playPreloadedCutscene(k)
    end
  })
end
addPauseMenu("Preloaded", PreloadedMenu)
function preloadedCleanup(sceneId)
  Cutscene.Dispose(sceneId)
end
function callPreloaded(sceneId)
  Cutscene.Play(sceneId, function()
    preloadedCleanup(sceneId)
  end)
  removeUserUpdateFunction("preloaded")
  Menu.ShowHUD = 0
end
function playPreloadedCutscene(sceneName)
  sceneId = engineCutscene.GetPreloadedId(sceneName)
  Cutscene.RegisterPreloaded(sceneId)
  PauseMenu.resume()
  addUserUpdateFunction("preloaded", function()
    callPreloaded(sceneId)
  end, updates.stepRate, 2)
end
local EvidenceBoardMenu = {}
table.insert(EvidenceBoardMenu, {
  name = "Show Evidence Board",
  action = function()
    EBoard.DisplayCurrentBoard()
  end
})
local EBoardStateNames = EBoard.GetStateNames()
local PageSize = 10
local PageCount = math.ceil(#EBoardStateNames / PageSize)
local StateIndex = 1
for Page = 1, PageCount do
  local PageMenu = {}
  local PageMenuName = "EvidenceBoardPage " .. tostring(Page)
  for Count = 1, PageSize do
    if StateIndex > #EBoardStateNames then
      break
    end
    local StateName = EBoardStateNames[StateIndex]
    table.insert(PageMenu, {
      name = StateName,
      action = function()
        EBoard.DisplayBoard(StateName)
      end
    })
    StateIndex = StateIndex + 1
  end
  table.insert(PageMenu, {
    name = "Back",
    action = changePauseMenu("EvidenceBoard")
  })
  addPauseMenu(PageMenuName, PageMenu)
  table.insert(EvidenceBoardMenu, {
    name = "Page" .. tostring(Page),
    action = changePauseMenu(PageMenuName)
  })
end
table.insert(EvidenceBoardMenu, {
  name = "Back",
  action = changePauseMenu("Pause")
})
addPauseMenu("EvidenceBoard", EvidenceBoardMenu)
local tutorialMissions = {}
table.insert(tutorialMissions, {
  name = "Aerial shift level 1 tutorial",
  action = function()
    shop.purchaseAbility("aerialZap", 0)
    progressionSystem.startTutorial("aerialZap", 0)
    clearCurrentMenu()
    PauseMenu.resume()
  end
})
table.insert(tutorialMissions, {
  name = "Boost tutorial",
  action = function()
    shop.purchaseAbility("nitro")
    progressionSystem.startTutorial("nitro", 0)
    clearCurrentMenu()
    PauseMenu.resume()
  end
})
table.insert(tutorialMissions, {
  name = "Rapid shift tutorial",
  action = function()
    shop.purchaseAbility("zapReturn")
    progressionSystem.startTutorial("zapReturn", 0)
    clearCurrentMenu()
    PauseMenu.resume()
  end
})
table.insert(tutorialMissions, {
  name = "Ram tutorial",
  action = function()
    shop.purchaseAbility("ram")
    progressionSystem.startTutorial("ram", 0)
    clearCurrentMenu()
    PauseMenu.resume()
  end
})
table.insert(tutorialMissions, {
  name = "Aerial shift level 2 tutorial",
  action = function()
    shop.purchaseAbility("aerialZap", 1)
    progressionSystem.startTutorial("aerialZap", 1)
    clearCurrentMenu()
    PauseMenu.resume()
  end
})
table.insert(tutorialMissions, {
  name = "Aerial shift top level tutorial",
  action = function()
    shop.purchaseAbility("aerialZap", 2)
    progressionSystem.startTutorial("aerialZap", 2)
    clearCurrentMenu()
    PauseMenu.resume()
  end
})
table.insert(tutorialMissions, {
  name = "Tutorial Mission Willpower",
  action = function()
    progressionSystem.startTutorial("willpower")
    clearCurrentMenu()
    PauseMenu.resume()
  end
})
addPauseMenu("Tutorial missions", tutorialMissions)
