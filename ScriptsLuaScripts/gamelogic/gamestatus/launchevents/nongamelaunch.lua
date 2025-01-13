gameStatus.registerEvent("launch", "Non-game", function()
  Menu.ShowMain = 0
  allowFreeCam(true)
  civilianTraffic.notifyOfZapLevelChange(configSelector.launchConfig.startInZap and 0)
  moodSystem.applyMood("Chapter0", 0.3, nil)
  if configSelector.launchConfig.Name == "Full City Profiling" then
    initialise.allLoadingComplete()
    PerformanceAnalysis.RunAnalysis(0, true, 6, 1.1)
  end
  simulation.start()
end)
