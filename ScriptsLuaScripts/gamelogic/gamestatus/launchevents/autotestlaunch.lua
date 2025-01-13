gameStatus.registerEvent("launch", "AutoTestLaunch", function()
  AutoTest.initaliseAutoTestSystem()
  simulation.start()
  Menu.ShowMain = 0
  scoringSystem.trafficOvertakingFlashGraphicsOn = true
  zapcontroller.ShowPrompts(false)
  zapcontroller.EnableZapInput(true)
  Presence.setPresence(12)
  civilianTraffic.notifyOfZapLevelChange(configSelector.launchConfig.startInZap and 0)
  dareSystem.initialiseSavedDare()
  controller.disableRumble()
  local actor = {
    characters = {
      [0] = 0,
      [1] = 1
    }
  }
  local vehicleParams = {
    modelID = configSelector.launchConfig.StartVehicle,
    position = configSelector.launchConfig.StartVehiclePosition,
    heading = configSelector.launchConfig.StartVehicleHeading,
    actor = actor
  }
  localPlayer:SetZapLevel(0, {
    gameVehicle = vehicleManager.spawnVehicle(vehicleParams).gameVehicle
  }, true)
  moodSystem.applyMood("Chapter0", 0.3, nil)
  setPlayerCameras("singlePlayer", localPlayer.localID)
  GameVehicleResource.registerAttachCallback(vehicleManager.hookupCallback)
  GameVehicleResource.registerDetachCallback(vehicleManager.unhookCallback)
  Menu.ShowLowercaseWarning(true)
  PatrollingVehicleManager.Enable(true)
  felony_patrollingVehicleManager.setSpawningModels()
  InterestingVehicleManager.Enable(true)
  TrafficSpooler.SetIdleCallback(spooling.setSpoolingStatusIdle)
  TrafficSpooler.SetBusyCallback(spooling.setSpoolingStatusBusy)
  CityLockManager.UsePhysics(false)
  vehicleManager.setSelfRightParameters("singlePlayer")
  replays.start()
  feedbackSystem.menusMaster.setSinglePlayerPrimaryPrompt()
  if configSelector.launchConfig.Name == "Full City Profiling" then
    PerformanceAnalysis.RunAnalysis(0, true, 6, 1.1)
  end
  Menu.CreditsListEnabled = true
end)
