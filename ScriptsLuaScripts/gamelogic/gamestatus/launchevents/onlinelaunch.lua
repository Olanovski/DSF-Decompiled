local preLoadGlobalDataSet = false
local preLoadModeDataSet = false
local setPhaseManagerTimers, setAbilitySettings, setMissionSettings, setOnlineVehicleSets, setOnlineProgressionData
function hostMigrationTest()
  if gameStatus.onlineSession and Network.isOnlineHost() and (not phaseManager.SNOID or not phaseManager.playlistSupport.SNOID or not onlineRaceManager.SNOID) then
    print("Error in OnlineLaunch.hostMigrationTest() : required SNOs are missing .. match sync failure!")
    Network.matchSyncFailure()
  end
end
function hostMigrationBusTest()
  if gameStatus.onlineSession and Network.isOnlineHost() then
    for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
      if vehicle.networkVars.multiplayerBus then
        removeUserUpdateFunction("hostMigrationBusTest")
        return
      end
    end
    Network.lobbySyncFailure()
    removeUserUpdateFunction("hostMigrationBusTest")
  end
end
gameStatus.registerEvent("launch", "Online", function(newSession)
  scoreSystem.blockWillpowerPrompt(true)
  simulation.start()
  Menu.ShowMain = 0
  initialise.allLoadingComplete()
  loadAbilitiesFromProfile()
  onlineProgressionSystem.enableOnlineProgression()
  vehicleManager.activeVehicles.resetSystem()
  LocalisationSpooler.RequestText(10)
  feedbackSystem.menusMaster.masterSetVariable("iFocus_Highlight_Active", 0)
  Menu.ResetPage("Master", "Online")
  zapcontroller.EnableOnlineControllers(true)
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.partyMode then
    scoringSystem.trafficOvertakingFlashGraphicsOn = false
    feedbackSystem.multiplayerSupport.enabled = false
    zapcontroller.SetZapAttackAllow(false, 0)
    localPlayer:showHUDElements(false)
    if phaseManager.allowTooFewPlayers then
      Network.enableTooFewPlayers()
    end
  else
    scoringSystem.trafficOvertakingFlashGraphicsOn = true
    zapcontroller.SetZapAttackAllow(true, 0)
  end
  if not preLoadGlobalDataSet then
    setAbilitySettings()
    setPhaseManagerTimers()
    setOnlineVehicleSets()
    setOnlineProgressionData()
    preLoadGlobalDataSet = true
  end
  if gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode and not preLoadModeDataSet then
    setMissionSettings()
    preLoadModeDataSet = true
  end
  abilities.setAbilityMode("multiplayer")
  zapcontroller.ShowPrompts(false)
  zapcontroller.HideFlare(true)
  activeChallenges.disable()
  if disableAutoDisconnectOnIdle then
    player.DisallowDisconnectOnInactivity()
  end
  civilianTraffic.notifyOfZapLevelChange(4)
  PatrollingVehicleManager.Enable(false)
  InterestingVehicleManager.Enable(false)
  TrafficSpooler.SetIdleCallback(spooling.setSpoolingStatusIdle)
  TrafficSpooler.SetBusyCallback(spooling.setSpoolingStatusBusy)
  player.setAttachment(localPlayer.localID, game_camera)
  controlHandler:setState("zap")
  zapcontroller.setZapCameraLocks({
    missile = false,
    low = true,
    mid = false,
    high = false,
    top = false
  })
  setPlayerCameras("multiPlayer", localPlayer.localID)
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.partyMode or gameStatus.onlineSessionType == gameStatus.onlineSessionID.lanPartyMode then
    vehicleManager.multiplayerBusManager.transitionOutOfMultiplayerBus()
    gamerTag.enabled = true
  else
    OnlineModeSettings.onlineDisableAssert = true
    if not localPlayer.inZap or zapcontroller.getTargetZapLevel(0) ~= 5 then
      localPlayer:SetZapLevel(5, nil, true, {forcedOut = true})
    end
    OnlineModeSettings.onlineDisableAssert = false
    gamerTag.enabled = false
  end
  vehicleManager.setSelfRightParameters("multiPlayer")
  moodSystem.clearMoods()
  moodSystem.applyMood("OnlineLobby")
  if Network.isOnlineHost() then
    if gameStatus.onlineSessionType == gameStatus.onlineSessionID.partyMode or gameStatus.onlineSessionType == gameStatus.onlineSessionID.lanPartyMode then
      vehicleManager.multiplayerBusManager.createMultiplayerBus()
      vehicleManager.multiplayerBusManager.autoTransitionIntoBus = true
    else
      Network.addCustomPlaylists()
      phaseManager.playlistSupport.buildPlaylistFromSyncedModes()
    end
  elseif gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode then
    addUserUpdateFunction("hostMigrationTest", hostMigrationTest, 1)
  elseif gameStatus.onlineSessionType == gameStatus.onlineSessionID.partyMode then
    addUserUpdateFunction("hostMigrationBusTest", hostMigrationBusTest, 1)
  end
  Marker.TargetHideDistance = 20
  Marker.TargetOpponentShowBehindDistance = 50
  Marker.TargetPriorityFadeAlpha = 61
  CityLockManager.UsePhysics(true)
  Menu.ShowLowercaseWarning(false)
  feedbackSystem.menusMaster.setOnlinePrimaryPrompt()
  player.ResetInactivityTimer()
  gamerTag:setTagProperties({
    maxAlpha = 0.7,
    maxSize = 0.6,
    minSize = 0.3,
    scaleDist = 75,
    maxDist = 150,
    maxOffCamDist = 50,
    markerFadeBeginDist = 150,
    markerFadeEndDist = 375,
    maxMarkerAlpha = 0.7,
    minMarkerAlpha = 0,
    standardIconScale = 50,
    objectiveIconScale = 70,
    minHeightOffset = 1.75,
    maxHeightOffset = 5.5,
    offsetScaleBeginDist = 10,
    offsetScaleEndDist = 200
  })
  ZapAIPresence.Settings({
    Radius = 0.8,
    Height = 100,
    TransitionInTime = 0.8,
    Color = vec.vector(40, 40, 40, 0.8)
  })
  onlineScreenManager.setPlatformSpecificLocalisation()
  zap.enableZapSelection()
end)
function setPhaseManagerTimers()
  phaseManager.modeMinJoinTime = OnlineGameConfigLua.GetIntConfig("ModeTimersPublicComp", "PMModeMinJoin")
  phaseManager.faceOffMinJoinTime = OnlineGameConfigLua.GetIntConfig("FaceoffTimersPublic", "PMFaceOffMinJoin")
  phaseManager.faceOffPhaseLengthPublic = OnlineGameConfigLua.GetIntConfig("FaceoffTimersPublic", "PMFaceOffLength")
  phaseManager.faceOffPhaseLengthPrivate = OnlineGameConfigLua.GetIntConfig("FaceoffTimersPrivate", "PMFaceOffLength")
  phaseManager.faceOffIntroLengthPublic = OnlineGameConfigLua.GetIntConfig("FaceoffTimersPublic", "PMFaceOffIntroLength")
  phaseManager.faceOffIntroLengthPrivate = OnlineGameConfigLua.GetIntConfig("FaceoffTimersPrivate", "PMFaceOffIntroLength")
  phaseManager.faceOffCompleteLengthPublic = OnlineGameConfigLua.GetIntConfig("FaceoffTimersPublic", "PMFaceOffCompleteLength")
  phaseManager.faceOffCompleteLengthPrivate = OnlineGameConfigLua.GetIntConfig("FaceoffTimersPrivate", "PMFaceOffCompleteLength")
  phaseManager.waitForPlayersLengthCompPublic = OnlineGameConfigLua.GetIntConfig("ModeTimersPublicComp", "PMWaitForPlayers")
  phaseManager.waitForPlayersLengthCompPrivate = OnlineGameConfigLua.GetIntConfig("ModeTimersPublicComp", "PMWaitForPlayers")
  phaseManager.modeIntroLengthCompPublic = OnlineGameConfigLua.GetIntConfig("ModeTimersPublicComp", "PMModeIntroLength")
  phaseManager.modeIntroLengthCompPrivate = OnlineGameConfigLua.GetIntConfig("ModeTimersPrivateComp", "PMModeIntroLength")
  phaseManager.introScreenTimeOutCompPublic = OnlineGameConfigLua.GetIntConfig("ModeTimersPublicComp", "PMModeIntroTimeout")
  phaseManager.introScreenTimeOutCompPrivate = OnlineGameConfigLua.GetIntConfig("ModeTimersPrivateComp", "PMModeIntroTimeout")
  phaseManager.modeCompleteLengthCompPublic = OnlineGameConfigLua.GetIntConfig("ModeTimersPublicComp", "PMModeCompleteLength")
  phaseManager.modeCompleteLengthCompPrivate = OnlineGameConfigLua.GetIntConfig("ModeTimersPrivateComp", "PMModeCompleteLength")
  phaseManager.roundCompleteLengthCompPublic = OnlineGameConfigLua.GetIntConfig("ModeTimersPublicComp", "PMRoundCompleteLength")
  phaseManager.roundCompleteLengthCompPrivate = OnlineGameConfigLua.GetIntConfig("ModeTimersPrivateComp", "PMRoundCompleteLength")
  phaseManager.resultScreenLengthCompPublic = OnlineGameConfigLua.GetIntConfig("ModeTimersPublicComp", "PMResultsLength")
  phaseManager.resultScreenLengthCompPrivate = OnlineGameConfigLua.GetIntConfig("ModeTimersPrivateComp", "PMResultsLength")
  onlineScreenManager.SMModeResultLength = OnlineGameConfigLua.GetIntConfig("ModeTimersPublicComp", "SMModeResultLength")
  onlineScreenManager.SMMinXPRewardShowTime = OnlineGameConfigLua.GetIntConfig("ModeTimersPublicComp", "SMMinXPRewardShowTime")
  onlineScreenManager.SMXPFillTime = OnlineGameConfigLua.GetIntConfig("ModeTimersPublicComp", "SMXPFillTime")
end
function setAbilitySettings()
  zapcontroller.SetLastVehicleUnlockingTime(0, OnlineGameConfigLua.GetFloatConfig("ZapVehicleUnlocking", "unlockTime"))
  abilities.constants.multiplayer.useDurationBoost = false
  abilities.constants.multiplayer.allowRamOnDrift = false
  abilities.constants.multiplayer.gain = {
    drift = 0,
    overtake = 0,
    oncoming = 0,
    jump = 0
  }
  abilities.constants.multiplayer.cost = {
    nitro = OnlineGameConfigLua.GetIntConfig("NitroSettings", "cost"),
    ram = 25
  }
  abilities.constants.multiplayer.hold = {
    nitro = OnlineGameConfigLua.GetIntConfig("NitroSettings", "hold"),
    ram = 0
  }
  abilities.constants.multiplayer.minimumPoints = {
    nitro = OnlineGameConfigLua.GetIntConfig("NitroSettings", "minCost"),
    ram = 51
  }
  abilities.constants.multiplayer.holdDecayRate.nitro = OnlineGameConfigLua.GetFloatConfig("NitroSettings", "holdDecayRate")
  abilities.constants.multiplayer.holdDecayMin.nitro = OnlineGameConfigLua.GetFloatConfig("NitroSettings", "holdDecayMin")
  zapWeaponSupport.setWeaponDefaultValue(OnlineGameConfigLua.GetIntConfig("ZapWeapon", "defaultCharge"))
  zapWeaponSupport.setWeaponUpgradeValue(OnlineGameConfigLua.GetIntConfig("ZapWeapon", "upgradedCharge"))
  zap.zapAttack.lockOnThreshold = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "attackLockOnTime")
  zap.zapAttack.offLockThreshold = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "attackOffLockTime")
  zap.zapAttack.overchargeThreshold = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "overchargeTime")
  zap.zapAttack.overchargeFlashTime = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "overchargeFlashTime")
  zap.zapAttack.impulseStrengthMin = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "impulseStrengthMin")
  zap.zapAttack.impulseStrengthMax = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "impulseStrengthMax")
  zap.zapAttack.impulseStrengthScaleStart = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "impulseStrengthScaleStart")
  zap.zapAttack.impulseStrengthScale = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "impulseStrengthScale")
  zap.zapAttack.impulseDamageMin = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "impulseDamageMin")
  zap.zapAttack.impulseDamageMax = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "impulseDamageMax")
  zap.zapAttack.impulseDamageScaleStart = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "impulseDamageScaleStart")
  zap.zapAttack.impulseDamageScale = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "impulseDamageScale")
  zapWeaponSupport.onlineWeaponCosts[1].success = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "swapCost")
  zapWeaponSupport.onlineWeaponCosts[2].success = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "impulseCost")
  zapWeaponSupport.onlineWeaponCosts[2].fail = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "impulseFailCost")
  zapWeaponSupport.onlineWeaponCosts[3].success = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "spawnCost")
  zapWeaponSupport.onlineWeaponCosts[4].success = OnlineGameConfigLua.GetFloatConfig("ZapWeapon", "takeCost")
  zap.multiplayerSettings.zapCosts[1].zapOutCost[1].amount = OnlineGameConfigLua.GetIntConfig("zapCosts", "level1Cost")
  zap.multiplayerSettings.zapCosts[1].zapAbilityRegen[1].primerSecs = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level1RegenPrimer")
  zap.multiplayerSettings.zapCosts[1].zapAbilityRegen[2].primerSecs = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level1RegenPrimer")
  zap.multiplayerSettings.zapCosts[1].zapAbilityDegen[1].primerSecs = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level1DegenPrimer")
  zap.multiplayerSettings.zapCosts[1].zapAbilityDegen[2].primerSecs = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level1DegenPrimer")
  zap.multiplayerSettings.zapCosts[1].zapAbilityRegen[1].abilityPrimerSecs = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level1AbilityPrimer")
  zap.multiplayerSettings.zapCosts[1].zapAbilityRegen[2].abilityPrimerSecs = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level1AbilityPrimer")
  zap.multiplayerSettings.zapCosts[1].zapAbilityRegen[1].amount = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level1Range0Regen")
  zap.multiplayerSettings.zapCosts[1].zapAbilityRegen[2].amount = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level1Range25Regen")
  zap.multiplayerSettings.zapCosts[1].zapAbilityDegen[1].amount = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level1Range0Degen")
  zap.multiplayerSettings.zapCosts[1].zapAbilityDegen[2].amount = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level1Range25Degen")
  zap.multiplayerSettings.zapCosts[2].zapOutCost[1].amount = OnlineGameConfigLua.GetIntConfig("zapCosts", "level2Cost")
  zap.multiplayerSettings.zapCosts[2].zapAbilityRegen[1].primerSecs = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level2RegenPrimer")
  zap.multiplayerSettings.zapCosts[2].zapAbilityRegen[2].primerSecs = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level2RegenPrimer")
  zap.multiplayerSettings.zapCosts[2].zapAbilityDegen[1].primerSecs = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level2DegenPrimer")
  zap.multiplayerSettings.zapCosts[2].zapAbilityDegen[2].primerSecs = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level2DegenPrimer")
  zap.multiplayerSettings.zapCosts[2].zapAbilityRegen[1].abilityPrimerSecs = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level2AbilityPrimer")
  zap.multiplayerSettings.zapCosts[2].zapAbilityRegen[2].abilityPrimerSecs = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level2AbilityPrimer")
  zap.multiplayerSettings.zapCosts[2].zapAbilityRegen[1].amount = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level2Range0Regen")
  zap.multiplayerSettings.zapCosts[2].zapAbilityRegen[2].amount = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level2Range25Regen")
  zap.multiplayerSettings.zapCosts[2].zapAbilityDegen[1].amount = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level2Range0Degen")
  zap.multiplayerSettings.zapCosts[2].zapAbilityDegen[2].amount = OnlineGameConfigLua.GetFloatConfig("zapCosts", "level2Range25Degen")
end
local setModeScoreLimit = function(mode, score)
  cardSystem.formattedMissionData[mode].challenge.settings.targetScore = score
end
local setModeRoundLimit = function(mode, rounds)
  cardSystem.formattedMissionData[mode].challenge.settings.numRounds = rounds
end
local setModeUsableRouteIndicies = function(mode, indicies)
  local indexTable = {}
  for index in string.gmatch(indicies, "%d+") do
    indexTable[#indexTable + 1] = tonumber(index)
  end
  cardSystem.formattedMissionData[mode].challenge.usableRouteIndicies = indexTable
end
local setFaceOffUsableRouteIndicies = function(faceoff, indicies)
  local indexTable = {}
  for index in string.gmatch(indicies, "%d+") do
    indexTable[#indexTable + 1] = tonumber(index)
  end
  faceOffData[faceoff].usableRouteIndicies = indexTable
end
local removeFaceOff = function(faceOffID)
  print("remove: " .. tostring(faceOffID))
  faceOffSystem.faceOffPool[faceOffID] = nil
  for i, faceOff in next, faceOffSystem.faceOffPool, nil do
    if faceOff.name == faceOffID then
      faceOffSystem.faceOffPool[i] = nil
      break
    end
  end
end
local rebuildFaceOffPool = function()
  local index = 1
  local tempPool = faceOffSystem.faceOffPool
  faceOffSystem.faceOffPool = {}
  for i, faceOff in next, tempPool, nil do
    if type(i) == "string" then
      faceOffSystem.faceOffPool[i] = faceOff
      faceOffSystem.faceOffPool[i].ID = index
      faceOffSystem.faceOffPool[index] = faceOff
      faceOffSystem.faceOffPool[index].ID = index
      index = index + 1
    end
  end
end
function setMissionSettings()
  phaseManager.timeToJoinScore.soloUnbalancedDef = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "soloUnbalMode")
  phaseManager.timeToJoinScore.teamUnbalancedDef = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "teamUnbalMode")
  phaseManager.timeToJoinScore.waitForPlayers = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "waitForPlayers")
  phaseManager.timeToJoinScore.faceOffIntro = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "faceOffIntro")
  phaseManager.timeToJoinScore.faceOffIntroUnbPlayers = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "faceOffIntroUnb")
  phaseManager.timeToJoinScore.faceOffIntroTFPlayers = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "faceOffIntroTFP")
  phaseManager.timeToJoinScore.faceOff = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "faceOff")
  phaseManager.timeToJoinScore.faceOffUnbPlayers = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "faceOffUnb")
  phaseManager.timeToJoinScore.faceOffTFPlayers = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "faceOffTFP")
  phaseManager.timeToJoinScore.faceOffResults = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "faceOffResults")
  phaseManager.timeToJoinScore.faceOffResultsUnbPlayers = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "faceOffResultsUnb")
  phaseManager.timeToJoinScore.faceOffResultsTFPlayers = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "faceOffResultsTFP")
  phaseManager.timeToJoinScore.modeIntro = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "modeIntro")
  phaseManager.timeToJoinScore.modeIntroUnbPlayers = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "modeIntroUnb")
  phaseManager.timeToJoinScore.modeIntroTFPlayers = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "modeIntroTFP")
  phaseManager.timeToJoinScore.modeResults = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "modeResults")
  phaseManager.timeToJoinScore.modeOneMinRemain = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "modeOneMinRemain")
  phaseManager.timeToJoinScore.modeException = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "modeException")
  phaseManager.timeToJoinExceptionValues.tag = OnlineGameConfigLua.GetFloatConfig("BestTimeToJoin", "tagException")
  phaseManager.timeToJoinExceptionValues.trailblazer = OnlineGameConfigLua.GetFloatConfig("BestTimeToJoin", "trailException")
  phaseManager.timeToJoinExceptionValues.tugOfWar = OnlineGameConfigLua.GetFloatConfig("BestTimeToJoin", "tugException")
  phaseManager.timeToJoinExceptionValues.rushdown = OnlineGameConfigLua.GetFloatConfig("BestTimeToJoin", "rushDownException")
  phaseManager.timeToJoinExceptionValues.burningRubber = OnlineGameConfigLua.GetFloatConfig("BestTimeToJoin", "burnException")
  phaseManager.timeToJoinExceptionValues.teamRush = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "teamRushException")
  phaseManager.timeToJoinExceptionValues.checkpointRush = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "checkRushException")
  phaseManager.timeToJoinExceptionValues.sprintRace = OnlineGameConfigLua.GetFloatConfig("BestTimeToJoin", "sprintException")
  phaseManager.missionIntroData["MP tag"].timeToJoinScore = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "tagInProgress")
  phaseManager.missionIntroData["MP takedown"].timeToJoinScore = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "takedownInProgress")
  phaseManager.missionIntroData["MP burning rubber"].timeToJoinScore = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "burningRubberInProgress")
  phaseManager.missionIntroData["MP circuit race"].timeToJoinScore = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "circuitRaceInProgress")
  phaseManager.missionIntroData["MP pure race"].timeToJoinScore = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "pureRaceInProgress")
  phaseManager.missionIntroData["MP sprint race"].timeToJoinScore = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "sprintRaceInProgress")
  phaseManager.missionIntroData["MP tug of war"].timeToJoinScore = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "tugOfWarInProgress")
  phaseManager.missionIntroData["MP rush down"].timeToJoinScore = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "rushDownInProgress")
  phaseManager.missionIntroData["MP trail blazer"].timeToJoinScore = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "trailBlazerInProgress")
  phaseManager.missionIntroData["MP team circuit race"].timeToJoinScore = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "teamCircuitRaceInProgress")
  phaseManager.missionIntroData["MP checkpoint rush"].timeToJoinScore = OnlineGameConfigLua.GetIntConfig("BestTimeToJoin", "checkpointRushInProgress")
  local rewardTable = {}
  local rewardString = ""
  for i = 1, 8 do
    rewardString = OnlineGameConfigLua.GetStringConfig("FaceoffSettings", "reward" .. i)
    rewardTable = {}
    for score in string.gmatch(rewardString, "%d+%p%d") do
      rewardTable[#rewardTable + 1] = tonumber(score)
    end
    faceOffSystem.qualifyingRewardTable[i] = rewardTable
  end
  faceOffSystem.allowSidebarToggle = OnlineGameConfigLua.GetIntConfig("FaceoffSettings", "allowSidebarToggle")
  faceOffSystem.qualifyingRewardTarget = OnlineGameConfigLua.GetFloatConfig("FaceoffSettings", "rewardTarget")
  local jumpEnabled = OnlineGameConfigLua.GetIntConfig("AvailableFaceoffs", "jump") == 1
  local overtakeEnabled = OnlineGameConfigLua.GetIntConfig("AvailableFaceoffs", "overtake") == 1
  local smashEnabled = OnlineGameConfigLua.GetIntConfig("AvailableFaceoffs", "smash") == 1
  local driftEnabled = OnlineGameConfigLua.GetIntConfig("AvailableFaceoffs", "drift") == 1
  local marathonEnabled = OnlineGameConfigLua.GetIntConfig("AvailableFaceoffs", "marathon") == 1
  local rebuildFOPool = false
  print("jumpEnabled - " .. tostring(jumpEnabled))
  print("overtakeEnabled - " .. tostring(overtakeEnabled))
  print("smashEnabled - " .. tostring(smashEnabled))
  print("driftEnabled - " .. tostring(driftEnabled))
  print("marathonEnabled - " .. tostring(marathonEnabled))
  if not jumpEnabled and not overtakeEnabled and not smashEnabled and not driftEnabled and not marathonEnabled then
    assert("No faceoffs are enabled, must have at least one face off. If wish not to play faceoffs use devTurnOffFaceOffs = true in userSettings.lua")
  end
  if driftEnabled then
    setFaceOffUsableRouteIndicies("Drift", OnlineGameConfigLua.GetStringConfig("DriftSettings", "maps"))
    phaseManager.setModeUsedIndexLevel("Drift", OnlineGameConfigLua.GetIntConfig("DriftSettings", "routeIndexProtLevel"), #faceOffData.Drift.usableRouteIndicies)
  else
    removeFaceOff("Drift")
    rebuildFOPool = true
  end
  if jumpEnabled then
    setFaceOffUsableRouteIndicies("Air", OnlineGameConfigLua.GetStringConfig("JumpSettings", "maps"))
    phaseManager.setModeUsedIndexLevel("Air", OnlineGameConfigLua.GetIntConfig("JumpSettings", "routeIndexProtLevel"), #faceOffData.Air.usableRouteIndicies)
  else
    removeFaceOff("jump")
    rebuildFOPool = true
  end
  if marathonEnabled then
    setFaceOffUsableRouteIndicies("Drive far", OnlineGameConfigLua.GetStringConfig("MarathonSettings", "maps"))
    phaseManager.setModeUsedIndexLevel("Drive far", OnlineGameConfigLua.GetIntConfig("MarathonSettings", "routeIndexProtLevel"), #faceOffData["Drive far"].usableRouteIndicies)
  else
    removeFaceOff("Marathon")
    rebuildFOPool = true
  end
  if overtakeEnabled then
    setFaceOffUsableRouteIndicies("Overtake cars", OnlineGameConfigLua.GetStringConfig("OvertakeSettings", "maps"))
    phaseManager.setModeUsedIndexLevel("Overtake cars", OnlineGameConfigLua.GetIntConfig("OvertakeSettings", "routeIndexProtLevel"), #faceOffData["Overtake cars"].usableRouteIndicies)
  else
    removeFaceOff("overtake")
    rebuildFOPool = true
  end
  if smashEnabled then
    setFaceOffUsableRouteIndicies("Smash props", OnlineGameConfigLua.GetStringConfig("SmashSettings", "maps"))
    phaseManager.setModeUsedIndexLevel("Smash props", OnlineGameConfigLua.GetIntConfig("SmashSettings", "routeIndexProtLevel"), #faceOffData["Smash props"].usableRouteIndicies)
  else
    removeFaceOff("Smash")
    rebuildFOPool = true
  end
  if rebuildFOPool then
    rebuildFaceOffPool()
  end
  cardSystem.logic.mpTagTimeLimit = OnlineGameConfigLua.GetIntConfig("TagSettings", "timeLimit")
  cardSystem.logic.mpTagScoreLimit = OnlineGameConfigLua.GetIntConfig("TagSettings", "scoreLimit")
  cardSystem.logic.mpTagTimeTrigger = OnlineGameConfigLua.GetIntConfig("TagSettings", "timeTrigger")
  setModeUsableRouteIndicies("MP tag", OnlineGameConfigLua.GetStringConfig("TagSettings", "maps"))
  cardSystem.formattedMissionData["MP tag"].challenge.settings.invunTime = OnlineGameConfigLua.GetIntConfig("TagSettings", "invunTime")
  cardSystem.formattedMissionData["MP tag"].challenge.settings.modeTimeLimit = OnlineGameConfigLua.GetIntConfig("TagSettings", "timeLimit")
  cardSystem.formattedMissionData["MP tag"].challenge.settings.targetScore = OnlineGameConfigLua.GetIntConfig("TagSettings", "scoreLimit")
  phaseManager.setModeUsedIndexLevel("MP tag", OnlineGameConfigLua.GetIntConfig("TagSettings", "routeIndexProtLevel"), #cardSystem.formattedMissionData["MP tag"].challenge.usableRouteIndicies)
  cardSystem.logic.mpTrailTimeLimit = OnlineGameConfigLua.GetIntConfig("TrailblazerSettings", "timeLimit")
  cardSystem.logic.mpTrailScoreLimit = OnlineGameConfigLua.GetIntConfig("TrailblazerSettings", "scoreLimit")
  cardSystem.logic.mpTrailTimeTrigger = OnlineGameConfigLua.GetIntConfig("TrailblazerSettings", "timeTrigger")
  setModeUsableRouteIndicies("MP trail blazer", OnlineGameConfigLua.GetStringConfig("TrailblazerSettings", "maps"))
  cardSystem.formattedMissionData["MP trail blazer"].challenge.settings.modeTimeLimit = OnlineGameConfigLua.GetIntConfig("TrailblazerSettings", "timeLimit")
  cardSystem.formattedMissionData["MP trail blazer"].challenge.settings.targetScore = OnlineGameConfigLua.GetIntConfig("TrailblazerSettings", "scoreLimit")
  phaseManager.setModeUsedIndexLevel("MP trail blazer", OnlineGameConfigLua.GetIntConfig("TrailblazerSettings", "routeIndexProtLevel"), #cardSystem.formattedMissionData["MP trail blazer"].challenge.usableRouteIndicies)
  cardSystem.logic.mpTakedownTimeLimit = OnlineGameConfigLua.GetIntConfig("TakedownSettings", "timeLimit")
  cardSystem.formattedMissionData["MP takedown"].challenge.settings.modeTimeLimit = OnlineGameConfigLua.GetIntConfig("TakedownSettings", "timeLimit")
  setModeUsableRouteIndicies("MP takedown", OnlineGameConfigLua.GetStringConfig("TakedownSettings", "maps"))
  phaseManager.setModeUsedIndexLevel("MP takedown", OnlineGameConfigLua.GetIntConfig("TakedownSettings", "routeIndexProtLevel"), #cardSystem.formattedMissionData["MP takedown"].challenge.usableRouteIndicies)
  cardSystem.formattedMissionData["MP takedown"].challenge.settings.maxRounds = OnlineGameConfigLua.GetIntConfig("TakedownSettings", "maxRounds")
  local damageTable = {}
  damageTable[1] = OnlineGameConfigLua.GetFloatConfig("TakedownSettings", "damageMul1")
  damageTable[2] = OnlineGameConfigLua.GetFloatConfig("TakedownSettings", "damageMul2")
  damageTable[3] = OnlineGameConfigLua.GetFloatConfig("TakedownSettings", "damageMul3")
  damageTable[4] = OnlineGameConfigLua.GetFloatConfig("TakedownSettings", "damageMul4")
  damageTable[5] = OnlineGameConfigLua.GetFloatConfig("TakedownSettings", "damageMul5")
  damageTable[6] = OnlineGameConfigLua.GetFloatConfig("TakedownSettings", "damageMul6")
  damageTable[7] = OnlineGameConfigLua.GetFloatConfig("TakedownSettings", "damageMul7")
  damageTable[8] = OnlineGameConfigLua.GetFloatConfig("TakedownSettings", "damageMul8")
  cardSystem.logic.mpTakeDownVehicleDamageMultipliers = damageTable
  cardSystem.logic.mpSprintRaceTimeLimit = OnlineGameConfigLua.GetIntConfig("SprintRaceSettings", "timeLimit")
  cardSystem.logic.mpSprintRaceNumRounds = OnlineGameConfigLua.GetIntConfig("SprintRaceSettings", "rounds")
  cardSystem.formattedMissionData["MP sprint race"].challenge.settings.modeTimeLimit = OnlineGameConfigLua.GetIntConfig("SprintRaceSettings", "timeLimit")
  setModeUsableRouteIndicies("MP sprint race", OnlineGameConfigLua.GetStringConfig("SprintRaceSettings", "maps"))
  setModeRoundLimit("MP sprint race", OnlineGameConfigLua.GetIntConfig("SprintRaceSettings", "rounds"))
  phaseManager.setModeUsedIndexLevel("MP sprint race", OnlineGameConfigLua.GetIntConfig("SprintRaceSettings", "routeIndexProtLevel"), #cardSystem.formattedMissionData["MP sprint race"].challenge.usableRouteIndicies)
  cardSystem.logic.mpSprintRaceEndTimeLimit = OnlineGameConfigLua.GetIntConfig("SprintRaceSettings", "overTimeLength")
  local scoreTable = {}
  local scoreString = ""
  for i = 1, 8 do
    scoreString = OnlineGameConfigLua.GetStringConfig("SprintRaceSettings", "score" .. i)
    scoreTable = {}
    for score in string.gmatch(scoreString, "%d+") do
      scoreTable[#scoreTable + 1] = tonumber(score)
    end
    cardSystem.logic.mpSprintRaceScoreTable[i] = scoreTable
  end
  cardSystem.logic.mpPureRaceTimeLimit = OnlineGameConfigLua.GetIntConfig("PureRaceSettings", "timeLimit")
  cardSystem.logic.mpPureRaceLapCount = OnlineGameConfigLua.GetIntConfig("PureRaceSettings", "laps")
  cardSystem.formattedMissionData["MP pure race"].challenge.settings.modeTimeLimit = OnlineGameConfigLua.GetIntConfig("PureRaceSettings", "timeLimit")
  cardSystem.formattedMissionData["MP pure race"].challenge.settings.totalLaps = OnlineGameConfigLua.GetIntConfig("PureRaceSettings", "laps")
  setModeUsableRouteIndicies("MP pure race", OnlineGameConfigLua.GetStringConfig("PureRaceSettings", "maps"))
  phaseManager.setModeUsedIndexLevel("MP pure race", OnlineGameConfigLua.GetIntConfig("PureRaceSettings", "routeIndexProtLevel"), #cardSystem.formattedMissionData["MP pure race"].challenge.usableRouteIndicies)
  cardSystem.logic.mpPureRaceEndTimeLimit = OnlineGameConfigLua.GetIntConfig("PureRaceSettings", "overTimeLength")
  cardSystem.logic.mpCircuitRaceLapCount = OnlineGameConfigLua.GetIntConfig("CircuitRaceSettings", "laps")
  cardSystem.logic.mpCircuitRaceTimeLimit = OnlineGameConfigLua.GetIntConfig("CircuitRaceSettings", "timeLimit")
  cardSystem.formattedMissionData["MP circuit race"].challenge.settings.modeTimeLimit = OnlineGameConfigLua.GetIntConfig("CircuitRaceSettings", "timeLimit")
  cardSystem.formattedMissionData["MP circuit race"].challenge.settings.totalLaps = OnlineGameConfigLua.GetIntConfig("CircuitRaceSettings", "laps")
  setModeUsableRouteIndicies("MP circuit race", OnlineGameConfigLua.GetStringConfig("CircuitRaceSettings", "maps"))
  phaseManager.setModeUsedIndexLevel("MP circuit race", OnlineGameConfigLua.GetIntConfig("CircuitRaceSettings", "routeIndexProtLevel"), #cardSystem.formattedMissionData["MP circuit race"].challenge.usableRouteIndicies)
  cardSystem.logic.mpCircuitRaceEndTimeLimit = OnlineGameConfigLua.GetIntConfig("CircuitRaceSettings", "overTimeLength")
  local damageMultString = ""
  local damageIndex = 1
  damageMultString = OnlineGameConfigLua.GetStringConfig("CircuitRaceSettings", "damageMultiplier")
  for mult in string.gmatch(damageMultString, "%d+%p%d") do
    cardSystem.formattedMissionData["MP circuit race"].challenge.settings.damageMultiplier[damageIndex] = tonumber(mult)
    damageIndex = damageIndex + 1
  end
  cardSystem.logic.mpTugOfWarTimeLimit = OnlineGameConfigLua.GetIntConfig("TugOfWarSettings", "timeLimit")
  cardSystem.logic.mpTugOfWarResetTime = OnlineGameConfigLua.GetIntConfig("TugOfWarSettings", "groundResetTime")
  cardSystem.formattedMissionData["MP tug of war"].challenge.settings.modeTimeLimit = OnlineGameConfigLua.GetIntConfig("TugOfWarSettings", "timeLimit")
  setModeScoreLimit("MP tug of war", OnlineGameConfigLua.GetIntConfig("TugOfWarSettings", "scoreLimit"))
  setModeRoundLimit("MP tug of war", OnlineGameConfigLua.GetIntConfig("TugOfWarSettings", "rounds"))
  setModeUsableRouteIndicies("MP tug of war", OnlineGameConfigLua.GetStringConfig("TugOfWarSettings", "maps"))
  cardSystem.formattedMissionData["MP tug of war"].challenge.settings.damageMultiplier = OnlineGameConfigLua.GetFloatConfig("TugOfWarSettings", "flagCarrierToughness")
  phaseManager.setModeUsedIndexLevel("MP tug of war", OnlineGameConfigLua.GetIntConfig("TugOfWarSettings", "routeIndexProtLevel"), #cardSystem.formattedMissionData["MP tug of war"].challenge.usableRouteIndicies)
  cardSystem.logic.flagCapsToWin = OnlineGameConfigLua.GetIntConfig("TugOfWarSettings", "scoreLimit")
  cardSystem.logic.mpRushdownTimeLimit = OnlineGameConfigLua.GetIntConfig("RushdownSettings", "timeLimit")
  setModeUsableRouteIndicies("MP rush down", OnlineGameConfigLua.GetStringConfig("RushdownSettings", "maps"))
  cardSystem.formattedMissionData["MP rush down"].challenge.settings.modeTimeLimit = OnlineGameConfigLua.GetIntConfig("RushdownSettings", "timeLimit")
  cardSystem.formattedMissionData["MP rush down"].challenge.settings.baseRadius = OnlineGameConfigLua.GetIntConfig("RushdownSettings", "baseRadius")
  cardSystem.formattedMissionData["MP rush down"].challenge.settings.attackPointGain = OnlineGameConfigLua.GetIntConfig("RushdownSettings", "attackPointGain")
  cardSystem.formattedMissionData["MP rush down"].challenge.settings.defendPointGain = OnlineGameConfigLua.GetIntConfig("RushdownSettings", "defendPointGain")
  phaseManager.setModeUsedIndexLevel("MP rush down", OnlineGameConfigLua.GetIntConfig("RushdownSettings", "routeIndexProtLevel"), #cardSystem.formattedMissionData["MP rush down"].challenge.usableRouteIndicies)
  setModeScoreLimit("MP rush down", OnlineGameConfigLua.GetIntConfig("RushdownSettings", "scoreLimit"))
  cardSystem.logic.mpRushdownScore = OnlineGameConfigLua.GetIntConfig("RushdownSettings", "scoreLimit")
  local targetRadiusString = OnlineGameConfigLua.GetStringConfig("RushdownSettings", "targetRadius")
  local index = 1
  for radius in string.gmatch(targetRadiusString, "%d+%p%d") do
    cardSystem.formattedMissionData["MP rush down"].challenge.spawnPositions[index].targetRadius = tonumber(radius)
    index = index + 1
  end
  cardSystem.logic.mpBurningRubberTimeLimit = OnlineGameConfigLua.GetIntConfig("BurningRubberSettings", "timeLimit")
  cardSystem.formattedMissionData["MP burning rubber"].challenge.settings.modeTimeLimit = OnlineGameConfigLua.GetIntConfig("BurningRubberSettings", "timeLimit")
  cardSystem.formattedMissionData["MP burning rubber"].challenge.settings.totalLaps = OnlineGameConfigLua.GetIntConfig("BurningRubberSettings", "laps")
  cardSystem.logic.mpBurningRubberLapCount = OnlineGameConfigLua.GetIntConfig("BurningRubberSettings", "laps")
  setModeUsableRouteIndicies("MP burning rubber", OnlineGameConfigLua.GetStringConfig("BurningRubberSettings", "maps"))
  cardSystem.logic.mpBurningRubberInvunTime = OnlineGameConfigLua.GetIntConfig("BurningRubberSettings", "InvunTime")
  cardSystem.formattedMissionData["MP burning rubber"].challenge.settings.invunTime = cardSystem.logic.mpBurningRubberInvunTime
  cardSystem.logic.mpBurningRubberDecayTime = OnlineGameConfigLua.GetIntConfig("BurningRubberSettings", "decayTime")
  cardSystem.formattedMissionData["MP burning rubber"].challenge.settings.powerLossTime = OnlineGameConfigLua.GetIntConfig("BurningRubberSettings", "decayTime")
  phaseManager.setModeUsedIndexLevel("MP burning rubber", OnlineGameConfigLua.GetIntConfig("BurningRubberSettings", "routeIndexProtLevel"), #cardSystem.formattedMissionData["MP burning rubber"].challenge.usableRouteIndicies)
  cardSystem.logic.mpTeamCircuitRaceTimeLimit = OnlineGameConfigLua.GetIntConfig("TeamCircuitRaceSettings", "timeLimit")
  setModeUsableRouteIndicies("MP team circuit race", OnlineGameConfigLua.GetStringConfig("TeamCircuitRaceSettings", "maps"))
  cardSystem.formattedMissionData["MP team circuit race"].challenge.settings.modeTimeLimit = OnlineGameConfigLua.GetIntConfig("TeamCircuitRaceSettings", "timeLimit")
  cardSystem.formattedMissionData["MP team circuit race"].challenge.settings.speedClamp = OnlineGameConfigLua.GetFloatConfig("TeamCircuitRaceSettings", "leadVehSpeedClamp")
  cardSystem.formattedMissionData["MP team circuit race"].challenge.settings.gateScore = OnlineGameConfigLua.GetIntConfig("TeamCircuitRaceSettings", "gateScore")
  phaseManager.setModeUsedIndexLevel("MP team circuit race", OnlineGameConfigLua.GetIntConfig("TeamCircuitRaceSettings", "routeIndexProtLevel"), #cardSystem.formattedMissionData["MP team circuit race"].challenge.usableRouteIndicies)
  local phaseOneGateTime = OnlineGameConfigLua.GetFloatConfig("TeamCircuitRaceSettings", "phaseOneGateTime")
  local phaseTwoGateTime = OnlineGameConfigLua.GetFloatConfig("TeamCircuitRaceSettings", "phaseTwoGateTime")
  local phaseThreeGateTime = OnlineGameConfigLua.GetFloatConfig("TeamCircuitRaceSettings", "phaseThreeGateTime")
  local numFlashes = OnlineGameConfigLua.GetIntConfig("TeamCircuitRaceSettings", "numFlashes")
  local gateFlashTime = OnlineGameConfigLua.GetFloatConfig("TeamCircuitRaceSettings", "gateFlashTime")
  checkpointSystem.setOnlineCPTimers(phaseOneGateTime, phaseTwoGateTime, phaseThreeGateTime, numFlashes, gateFlashTime)
  cardSystem.logic.mpCheckpointRushTimeLimit = OnlineGameConfigLua.GetIntConfig("TeamCircuitRaceSettings", "timeLimit")
  setModeUsableRouteIndicies("MP checkpoint rush", OnlineGameConfigLua.GetStringConfig("TeamCircuitRaceSettings", "maps"))
  cardSystem.formattedMissionData["MP checkpoint rush"].challenge.settings.modeTimeLimit = OnlineGameConfigLua.GetIntConfig("TeamCircuitRaceSettings", "timeLimit")
  cardSystem.formattedMissionData["MP checkpoint rush"].challenge.settings.speedClamp = OnlineGameConfigLua.GetFloatConfig("TeamCircuitRaceSettings", "leadVehSpeedClamp")
  cardSystem.formattedMissionData["MP checkpoint rush"].challenge.settings.gateScore = OnlineGameConfigLua.GetIntConfig("TeamCircuitRaceSettings", "gateScore")
  phaseManager.setModeUsedIndexLevel("MP checkpoint rush", OnlineGameConfigLua.GetIntConfig("TeamCircuitRaceSettings", "routeIndexProtLevel"), #cardSystem.formattedMissionData["MP checkpoint rush"].challenge.usableRouteIndicies)
end
function setOnlineVehicleSets()
  local vehicleTable = {}
  local vehicleList = OnlineGameConfigLua.GetStringConfig("vehicles", "rallyVehicles")
  for vehicleID in string.gmatch(vehicleList, "%d+") do
    vehicleTable[#vehicleTable + 1] = {
      vehicleID = tonumber(vehicleID),
      shader = {
        [0] = 0
      }
    }
  end
  OnlineModeSettings.vehicleTypeRally = vehicleTable
  vehicleList = OnlineGameConfigLua.GetStringConfig("vehicles", "roadVehicles")
  vehicleTable = {}
  for vehicleID in string.gmatch(vehicleList, "%d+") do
    vehicleTable[#vehicleTable + 1] = {
      vehicleID = tonumber(vehicleID),
      shader = {
        [0] = 0
      }
    }
  end
  OnlineModeSettings.vehicleTypeRoad = vehicleTable
  vehicleList = OnlineGameConfigLua.GetStringConfig("vehicles", "mixedVehicles")
  vehicleTable = {}
  for vehicleID in string.gmatch(vehicleList, "%d+") do
    vehicleTable[#vehicleTable + 1] = {
      vehicleID = tonumber(vehicleID),
      shader = {
        [0] = 0
      }
    }
  end
  OnlineModeSettings.vehicleTypeMixed = vehicleTable
  vehicleList = OnlineGameConfigLua.GetStringConfig("vehicles", "muscleVehicles")
  vehicleTable = {}
  for vehicleID in string.gmatch(vehicleList, "%d+") do
    vehicleTable[#vehicleTable + 1] = {
      vehicleID = tonumber(vehicleID),
      shader = {
        [0] = 0
      }
    }
  end
  OnlineModeSettings.vehicleTypeMuscle = vehicleTable
  vehicleList = OnlineGameConfigLua.GetStringConfig("vehicles", "trafficVehicles")
  vehicleTable = {}
  for vehicleID in string.gmatch(vehicleList, "%d+") do
    vehicleTable[#vehicleTable + 1] = {
      vehicleID = tonumber(vehicleID),
      shader = {
        [0] = 0
      }
    }
  end
  OnlineModeSettings.vehicleTypeTraffic = vehicleTable
  for vehicleID in string.gmatch(vehicleList, "%d+") do
    vehicleTable[#vehicleTable + 1] = {
      vehicleID = tonumber(vehicleID),
      shader = {
        [0] = 0
      }
    }
  end
  OnlineModeSettings.vehicleTypeMixedRally = vehicleTable
  for vehicleID in string.gmatch(vehicleList, "%d+") do
    vehicleTable[#vehicleTable + 1] = {
      vehicleID = tonumber(vehicleID),
      shader = {
        [0] = 0
      }
    }
  end
  OnlineModeSettings.vehicleTypePureRally = vehicleTable
  for vehicleID in string.gmatch(vehicleList, "%d+") do
    vehicleTable[#vehicleTable + 1] = {
      vehicleID = tonumber(vehicleID),
      shader = {
        [0] = 0
      }
    }
  end
  OnlineModeSettings.vehicleTypeDriftRally = vehicleTable
end
function setOnlineProgressionData()
  local numLevels = OnlineGameConfigLua.GetIntConfig("progression", "numLevels")
  for i = 1, numLevels do
    onlineProgressionSystem.onlineLevelData[i].xp = OnlineGameConfigLua.GetIntConfig("progression", "level" .. i)
  end
  onlineProgressionSystem.abilityBalancelevelCap = OnlineGameConfigLua.GetIntConfig("PrivateAbilityBalancing", "playerLevel")
end
