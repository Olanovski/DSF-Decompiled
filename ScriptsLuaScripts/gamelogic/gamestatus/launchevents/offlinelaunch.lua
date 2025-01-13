gameStatus.registerEvent("launch", "Offline", function()
  simulation.start()
  Menu.ShowMain = 0
  scoringSystem.trafficOvertakingFlashGraphicsOn = true
  zapcontroller.ShowPrompts(false)
  zapcontroller.EnableZapInput(true)
  zapcontroller.HideFlare(false)
  civilianTraffic.notifyOfZapLevelChange(configSelector.launchConfig.startInZap and 0)
  dareSystem.initialiseSavedDare()
  if configSelector.launchConfig.Name == "No traffic, no challenges" then
    local roadIndex = Atlas.ClosestRoadIndexAndDistanceAlong(spoolsystem.position)
    local position = Atlas.RoadPositionAtDistanceAlong(roadIndex, Atlas.RoadLength(roadIndex) * 0.5)
    vehicleManager.spawnVehicle({
      position = configSelector.launchConfig.firstPoint,
      heading = configSelector.launchConfig.firstHeading
    })
    vehicleManager.spawnVehicle({
      position = configSelector.launchConfig.secondPoint,
      heading = configSelector.launchConfig.secondHeading
    })
    player.setAttachment(localPlayer.localID, localPlayer.camera)
    controlHandler:setState("zap")
    localPlayer:SetZapLevel(2, nil, false, {forcedOut = true})
  elseif configSelector.launchConfig.Name == "Full City Profiling" or configSelector.launchConfig.Name == "Manual Profiling" then
    local roadIndex = Atlas.ClosestRoadIndexAndDistanceAlong(configSelector.launchConfig.StartPosition)
    local position = Atlas.RoadPositionAtDistanceAlong(roadIndex, Atlas.RoadLength(roadIndex) * 0.5)
    local actor = {
      characters = {
        [0] = 0,
        [1] = 1
      }
    }
    local vehicleParams = {
      modelID = configSelector.launchConfig.StartVehicle,
      position = position,
      heading = configSelector.launchConfig.StartVehicleHeading,
      actor = actor
    }
    player.setAttachment(localPlayer.localID, localPlayer.camera)
    localPlayer:SetZapLevel(0, {
      gameVehicle = vehicleManager.spawnVehicle(vehicleParams).gameVehicle
    }, true)
    moodSystem.applyMood("Chapter0", 0.3, nil)
  else
    progressionSystem.setSavedMissions()
    if configSelector.launchConfig.forceMission then
      local missionID = cards.MissionNetworkLookup[configSelector.launchConfig.forceMission]
      local mission, potID, subType, type = progressionSystem.findMissionInProgression(missionID)
      if type == "challenge" or type == "activity" then
        progressionSystem.applyChallengeSettings(mission, true)
      else
        progressionSystem.applyChapterSettings(potID, missionID, true)
      end
    else
      local pot = ProfileSettings.GetProgression()
      local chapter = challengeProgressionTable[pot].settings.chapter
      local skipInitialCutscene = chapter > 0 and ProfileSettings.GetFMVWatched(chapter)
      progressionSystem.skipToProgressionPot(pot, true, skipInitialCutscene)
    end
    activeChallenges.initialiseActivities()
  end
  abilities.setAbilityMode("single")
  setPlayerCameras("singlePlayer", localPlayer.localID)
  GameVehicleResource.registerAttachCallback(vehicleManager.hookupCallback)
  GameVehicleResource.registerDetachCallback(vehicleManager.unhookCallback)
  Menu.ShowLowercaseWarning(true)
  felony_patrollingVehicleManager.enablePatrollingVehicles(true)
  InterestingVehicleManager.Enable(true)
  TrafficSpooler.SetIdleCallback(spooling.setSpoolingStatusIdle)
  TrafficSpooler.SetBusyCallback(spooling.setSpoolingStatusBusy)
  CityLockManager.UsePhysics(false)
  if configSelector.launchConfig.Name == "Free Drive No Progression Reference Mood" then
    Mood.addMoodUserDefined(moodSystem.Reference, "Reference", 1, 0, -1)
  end
  vehicleManager.setSelfRightParameters("singlePlayer")
  feedbackSystem.menusMaster.setSinglePlayerPrimaryPrompt()
  if configSelector.launchConfig.Name == "Full City Profiling" then
    PerformanceAnalysis.RunAnalysis(0, true, 6, 1.1)
  end
  scoreSystem.blockWillpowerPrompt(false)
end)
