GameLauncher.SetGameState("Game Loaded Configs")
configSelector.defaultConfig = {
  Name = "DEFAULT CONFIG",
  Type = "Single Player",
  City = "Install\\san_francisco.dngc",
  CityAIData = "Media\\san_franciscoAI.fchunk",
  SpooledVehicles = "Install\\dngvehicles.sp",
  Characters = "Install\\character_global.fchunk",
  Challenges = "Install\\challenges.sp",
  CommentaryPackage = "Install\\Commentary.sp",
  CutscenePackage = "Install\\Cutscenes.sp",
  AmbientAudioPackage = "Install\\WwiseAmbient.sp",
  CityLockingPackage = "Install\\citylocking.sp",
  SkyPackage = "Install\\skies.sp",
  InitialSky = "Default",
  SplineGadgetsPackage = "Media\\Sfxsplinegadgets.fchunk",
  LocalePackage = "text:loc.sp",
  GUIPackage = "Install\\GUI.sp",
  BillboardPackage = "TEXT:billboards.sp",
  EBoardPackage = "Install\\EBoard.sp",
  MegaMeshPackage = "Install\\MegaMesh.sp",
  MenusMasterPackage = "Install\\MenusMaster.sp",
  initialiseEvent = "Default",
  preLaunchEvent = "Default",
  launchEvent = false,
  skipNetworkEnterSession = false,
  enableLightMaps = true,
  enableWrappedLightMaps = true,
  enableTraffic = true,
  enablePeds = true,
  enableProgression = false,
  enableActiveChallenges = true,
  StartPoint = vec.vector(-160, 18, 1002, 1),
  StartVehicle = 62,
  StartVehicleHeading = -0.439,
  StartVehiclePosition = vec.vector(-160, 18, 1002, 1),
  startInZap = false
}
configSelector.configEntry({
  hidden = true,
  Name = "Single Player",
  enableProgression = true
})
configSelector.configEntry({
  Name = "Free Drive No Progression"
})
configSelector.configEntry({
  Name = "City Art Dev (only works for city artists)",
  City = "Install\\CityArtDev.dngc",
  CityAIData = "Media\\CityArtDev_AI.fchunk",
  CityLockingPackage = "Install\\CityArtDev_CityLocking.sp"
})
configSelector.configEntry({
  Name = "Post Debrief",
  enableProgression = true
})
configSelector.configEntry({Name = "Chapter 1", enableProgression = true})
configSelector.configEntry({Name = "Chapter 2", enableProgression = true})
configSelector.configEntry({Name = "Chapter 3", enableProgression = true})
configSelector.configEntry({Name = "Chapter 4", enableProgression = true})
configSelector.configEntry({Name = "Chapter 5", enableProgression = true})
configSelector.configEntry({Name = "Chapter 6", enableProgression = true})
configSelector.configEntry({Name = "Chapter 7", enableProgression = true})
configSelector.configEntry({Name = "Chapter 8", enableProgression = true})
configSelector.configEntry({Name = "Epilogue", enableProgression = true})
configSelector.configEntry({
  Name = "Split Screen",
  launchEvent = "SplitScreen",
  Type = "Split Screen",
  Characters = "Install\\character_globalsplit.fchunk",
  enableProgression = false,
  enableTraffic = true
})
configSelector.configEntry({
  hidden = true,
  Name = "Replay",
  Type = "Replay",
  initialiseEvent = "Default",
  preLaunchEvent = "OldDefault",
  launchEvent = "Replay",
  skipNetworkEnterSession = false,
  enableLightMaps = true,
  enableWrappedLightMaps = true,
  enableTraffic = false,
  enablePeds = true,
  enableProgression = false,
  enableActiveChallenges = false,
  StartPoint = vec.vector(-160, 18, 1002, 1),
  StartVehicle = 62,
  StartVehicleHeading = -0.439,
  StartVehiclePosition = vec.vector(-160, 18, 1002, 1),
  startInZap = false
})
configSelector.configEntry({
  hidden = true,
  Name = [[
Multiplayer
Party Bus]],
  Type = "Multiplayer",
  enableTraffic = true,
  preLaunchEvent = "OldDefault"
})
configSelector.configEntry({
  hidden = true,
  Name = "Multiplayer - No Challenge",
  Type = "Multiplayer",
  enableTraffic = true
})
configSelector.configEntry({
  hidden = true,
  Name = "Play Test",
  enableLightMaps = false,
  enableWrappedLightMaps = false,
  enableActiveChallenges = false
})
configSelector.configEntry({
  hidden = true,
  Name = [[
Multiplayer
Play Test]],
  Type = "Multiplayer",
  enableTraffic = true,
  enableLightMaps = false,
  enableWrappedLightMaps = false,
  enableActiveChallenges = false
})
configSelector.configEntry({
  hidden = true,
  Name = "DistributedBuilder",
  preLaunchEvent = "Distributed builder",
  launchEvent = "Distributed builder"
})
configSelector.configEntry({
  Name = "Auto Test",
  preLaunchEvent = "OldDefault",
  launchEvent = "AutoTestLaunch"
})
configSelector.configEntry({
  Name = "Full City Profiling",
  preLaunchEvent = "OldDefault",
  skipNetworkEnterSession = false,
  StartPosition = vec.vector(-2784.144, 155.2148, 4365.466, 1)
})
configSelector.configEntry({
  Name = "Manual Profiling",
  preLaunchEvent = "OldDefault",
  skipNetworkEnterSession = false,
  StartPosition = vec.vector(-2784.144, 155.2148, 4365.466, 1)
})
