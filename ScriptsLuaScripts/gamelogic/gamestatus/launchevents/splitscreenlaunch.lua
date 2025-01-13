local preLoadModeDataSet = false
local setMissionSettings
gameStatus.registerEvent("launch", "SplitScreen", function()
  scoreSystem.blockWillpowerPrompt(true)
  feedbackSystem.menusMaster.resetDamageBarState()
  localPlayer.minimapSupport.resetMinimapState()
  feedbackSystem.multiplayerSupport.resetAbilityBarState()
  feedbackSystem.multiplayerSupport.resetSpeedoState()
  initialise.allLoadingComplete()
  simulation.start()
  Menu.ShowMain = 0
  loadAbilitiesFromProfile()
  onlineProgressionSystem.enableOnlineProgression()
  vehicleManager.activeVehicles.resetSystem()
  LocalisationSpooler.RequestText(10)
  Menu.ResetPage("Splitscreen", "Online")
  feedbackSystem.splitScreenSupport.disableSSHud = false
  scoringSystem.trafficOvertakingFlashGraphicsOn = false
  feedbackSystem.multiplayerSupport.enabled = false
  zapcontroller.ShowPrompts(false)
  zapcontroller.HideFlare(false)
  activeChallenges.disable()
  civilianTraffic.notifyOfZapLevelChange(4)
  PatrollingVehicleManager.Enable(false)
  InterestingVehicleManager.Enable(false)
  TrafficSpooler.SetIdleCallback(spooling.setSpoolingStatusIdle)
  TrafficSpooler.SetBusyCallback(spooling.setSpoolingStatusBusy)
  player.setAttachment(localPlayer.localID, game_camera)
  controlHandler:setState("zap")
  for localID, plr in next, localPlayerManager.players, nil do
    zapcontroller.SetZapAttackAllow(false, localID)
    zapcontroller.setZapCameraLocks(localID, {
      missile = false,
      low = true,
      mid = false,
      high = false,
      top = true
    })
    setPlayerCameras("splitScreen", localID)
    zapcontroller.EnableOnlineControllers(true, localID)
  end
  OnlineModeSettings.onlineDisableAssert = true
  if not localPlayer.inZap or zapcontroller.getTargetZapLevel(0) ~= 4 then
    localPlayer:SetZapLevel(4, nil, true, {forcedOut = true})
  end
  OnlineModeSettings.onlineDisableAssert = false
  moodSystem.clearMoods()
  moodSystem.applyMood("Chapter0")
  vehicleManager.setSelfRightParameters("multiPlayer")
  print("SPLITSCREEN LAUNCH EVENT")
  if not preLoadModeDataSet then
    setMissionSettings()
    preLoadModeDataSet = true
  end
  local playlistID = Network.getSelectedPlaylistIndex()
  if GameModeManager.GetSplitScreenMissionMode() == 1 then
    if playlistID == 0 then
      Network.addCustomPlaylists()
    end
    print(" *** SPLITSCREEN LAUNCH Launching playlist " .. playlistID)
    phaseManager.playlistSupport.buildPlaylistFromSyncedModes()
    Menu.ChangePage("SplitscreenMenus", "SS_InASession")
    for localID, plr in next, localPlayerManager.players, nil do
      zapcontroller.setZapCameraLocks(localID, {
        missile = false,
        low = true,
        mid = false,
        high = false,
        top = false
      })
    end
    onlineScreenManager.showSplitscreenIntro(phaseManager.playlistSupport.getCurrentMission())
    phaseManager.ssFadedOut = true
  end
  Marker.TargetHideDistance = 20
  Marker.TargetOpponentShowBehindDistance = 50
  Marker.TargetPriorityFadeAlpha = 61
  CityLockManager.CityLockState = "CityLockingLevel4"
  CityLockManager.CityLockActive = false
  CityLockManager.UsePhysics(true)
  Menu.ShowLowercaseWarning(false)
  Menu.HideZapPreview(false)
  abilities.setAbilityMode("splitscreen")
  vehicleManager.activeVehicles.disableVehicleSelectFeedback = true
  feedbackSystem.menusMaster.setOnlinePrimaryPrompt()
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
end)
function setMissionSettings()
  phaseManager.setModeUsedIndexLevel("MP tag", 1, #cardSystem.formattedMissionData["MP tag"].challenge.usableRouteIndicies[1])
  phaseManager.setModeUsedIndexLevel("MP trail blazer", 1, #cardSystem.formattedMissionData["MP trail blazer"].challenge.usableRouteIndicies[1])
  phaseManager.setModeUsedIndexLevel("MP pure race", 1, #cardSystem.formattedMissionData["MP pure race"].challenge.usableRouteIndicies[1])
  phaseManager.setModeUsedIndexLevel("MP sprint race", 4, #cardSystem.formattedMissionData["MP sprint race"].challenge.usableRouteIndicies[1])
  phaseManager.setModeUsedIndexLevel("MP checkpoint rush", 1, #cardSystem.formattedMissionData["MP checkpoint rush"].challenge.usableRouteIndicies[1])
  phaseManager.setModeUsedIndexLevel("SS Survival", 1, #cardSystem.formattedMissionData["SS Survival"].challenge.usableRouteIndicies[1])
end
