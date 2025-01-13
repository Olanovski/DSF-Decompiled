garbageCounter = {}
function collectAndCountGarbage(name)
  garbageCounter[name] = {}
  garbageCounter[name].sizeBefore = collectgarbage("count")
  collectgarbage("collect")
  garbageCounter[name].sizeAfter = collectgarbage("count")
  garbageCounter[name].gargbage = garbageCounter[name].sizeBefore - garbageCounter[name].sizeAfter
end
function dumpGarbageStats()
  printTable(garbageCounter)
end
g_currentModePackage = nil
LuaMediaPath = MediaPath .. "LuaScripts\\"
function open(filename)
  local error, f = ScriptLoader.ri_loadfile(LuaMediaPath .. filename)
  local success = true
  if type(f) == "string" then
    print("\t" .. f)
    success = false
  elseif f == nil then
    print("\t" .. error)
    success = false
  else
    f()
  end
  return success
end
open("updates.lua")
loadFile_tableOfFiles = {}
loadFile_numLoaded = 0
loadFile_allLoaded = false
loadFile_callback = nil
loadFile_loading = false
function loadTableOfFiles(t, loadCallback)
  loadFile_allLoaded = false
  loadFile_numLoaded = 0
  loadFile_callback = loadCallback
  loadFile_tableOfFiles = {}
  loadFile_loading = true
  loadAllFiles(t, loadCallback)
  addUserUpdateFunction("loadFiles", stepFileToLoad, 1)
end
function loadFile_areYouDoneYet()
  return loadFile_allLoaded
end
function stepFileToLoad()
  if loadFile_numLoaded < #loadFile_tableOfFiles then
    loadFile_numLoaded = loadFile_numLoaded + 1
    open(loadFile_tableOfFiles[loadFile_numLoaded])
  else
    removeUserUpdateFunction("loadFiles")
    loadFile_allLoaded = true
    loafFile_loading = false
    if loadFile_callback then
      loadFile_callback()
    end
  end
  return loadFile_allLoaded
end
function loadAllFiles(t, loadCallback)
  for i = 1, #t do
    if type(t[i]) == "string" then
      loadFile_tableOfFiles[#loadFile_tableOfFiles + 1] = t[i]
    elseif type(t[i]) == "table" then
      loadAllFiles(t[i])
    end
  end
end
function cancelLoadfiles()
  removeUserUpdateFunction("loadFiles")
  loadFile_allLoaded = true
  loafFile_loading = false
end
local waitForModePackageCallback
function openModePackage(package, callback)
  ScriptLoader.ri_openScriptPackage("Media\\Scripts" .. tostring(package) .. ".fchunk")
  waitForModePackageCallback = callback
  addUserUpdateFunction("waitForModePackageLoad", waitForModePackageLoad, 1)
end
function waitForModePackageLoad()
  local function done()
    ScriptLoader.ri_closeScriptPackage()
    if waitForModePackageCallback then
      waitForModePackageCallback()
      waitForModePackageCallback = nil
    end
  end
  if ScriptLoader.ri_scriptPackageLoaded() then
    removeUserUpdateFunction("waitForModePackageLoad")
    open("fileList.lua")
    loadTableOfFiles(FileTree.ModeFiles, done)
  end
end
function loadMode(package, callback)
  print("loadMode( " .. tostring(package) .. ", " .. tostring(callback) .. " )")
  if g_currentModePackage ~= package then
    local function allDone()
      cardSystem.initialiseAllLoadedMissions()
      if callback then
        callback()
      end
    end
    local function coreDone()
      addUserUpdateFunction("chunkLoadWait", function()
        openModePackage(package, allDone)
        removeUserUpdateFunction("chunkLoadWait")
      end, 2, true)
    end
    cardSystem.clearModeData()
    g_currentModePackage = package
    openModePackage("Core", coreDone)
  elseif callback then
    callback()
  end
end
local standardInitialLoad = {
  "LoadingScreenHints.lua",
  "Logging\\GameLauncher.lua",
  "Logging\\ScriptDebugger.lua",
  "Logging\\luaDocumentation.lua",
  "Network\\Network_Functions.lua",
  "Network\\Network_Emulation.lua",
  "Online\\Leaderboards.lua",
  "Online\\Statistics.lua",
  "Online\\PartyBusMenu.lua",
  "Online\\Presence.lua",
  "maths.lua",
  "utils.lua",
  "format.lua",
  "VehicleStats\\VehicleStats.lua",
  "VehicleStats\\VehicleStatFunctions.lua",
  "missionInfo.lua",
  "missionNetworkLookups.lua",
  "GameLogic\\Progression\\Data\\dareProgression.lua",
  "GameLogic\\Progression\\Data\\missionProgression.lua",
  "GameLogic\\Progression\\Data\\challengeProgression.lua",
  "GameLogic\\Progression\\Data\\activitiesProgression.lua",
  "GameLogic\\Progression\\Data\\collectableProgression.lua",
  "GameLogic\\Progression\\Data\\willpowerRewards.lua",
  "GameLogic\\Progression\\Data\\challengePrices.lua",
  "GameLogic\\Garages\\Data\\Data.lua",
  "GameLogic\\Progression\\System\\preLoadProgressionFunctions.lua",
  "GameLogic\\Progression\\System\\progessionSaveSupport.lua",
  "unlockables.lua",
  "FileList.lua",
  "MenuInitialise.lua",
  "LoadGameScriptFiles.lua",
  "GameLogic\\gameLogicConfig.lua",
  "GameLogic\\SpoolingSystem\\spoolSystemFiles.lua",
  "GameLogic\\GameStatus\\gameStatusFiles.lua",
  "GameLogic\\NetworkObject\\networkObjectFiles.lua",
  "GameLogic\\MissionPropData\\PropDataFiles.lua",
  "GameLogic\\Coop\\CoopDataFiles.lua",
  "GameLogic\\Cutscenes\\CutsceneFiles.lua",
  "GameLogic\\EngineCutscenes\\engineCutsceneFiles.lua",
  "GameLogic\\ReplaySystem\\ReplaySystemFiles.lua",
  "GameLogic\\GoalSystem\\GoalSystemFiles.lua",
  "GameLogic\\CardSystem\\cardSystemFiles.lua",
  "GameLogic\\ChallengeSystem\\challengeSystemFiles.lua",
  "GameLogic\\Felony\\FelonyFiles.lua",
  "GameLogic\\RaceManager\\RaceManagerFiles.lua",
  "GameLogic\\HelicopterCamera\\helicopterCamera.lua",
  "GameLogic\\DareSystem\\dareSystemFiles.lua",
  "GameLogic\\CollectableSystem\\collectableSystemFiles.lua",
  "GameLogic\\FaceOffSystem\\faceOffSystemFiles.lua",
  "GameLogic\\TaskSystem\\taskSystemFiles.lua",
  "GameLogic\\FeedbackSystem\\feedbackSystemFiles.lua",
  "GameLogic\\PackageManager\\packageManagerFiles.lua",
  "GameLogic\\PhaseManager\\phaseManagerFiles.lua",
  "GameLogic\\TrafficExclusionZones\\TrafficExclusionZoneFiles.lua",
  "GameLogic\\activeChallenges\\activeChallengesFiles.lua",
  "GameLogic\\Abilities\\AbilityFiles.lua",
  "GameLogic\\Progression\\ProgressionFiles.lua",
  "GameLogic\\OnlineProgression\\onlineProgressionFiles.lua",
  "GameLogic\\onlineStatistics\\onlineStatisticsFiles.lua",
  "GameLogic\\OnlineScreenManager\\onlineScreenManagerFiles.lua",
  "GameLogic\\OnlineRaceManager\\onlineRaceManagerFiles.lua",
  "GameLogic\\OnlineAchievements\\OnlineAchievementFiles.lua",
  "GameLogic\\Moods\\moodFiles.lua",
  "GameLogic\\Player\\PlayerFiles.lua",
  "GameLogic\\ScoreSystem\\scoreSystemFiles.lua",
  "GameLogic\\VehicleManager\\vehicleManagerFiles.lua",
  "GameLogic\\CheckpointTracker\\CheckpointTrackerFiles.lua",
  "GameLogic\\Zap\\ZapFiles.lua",
  "GameLogic\\Scenes\\SceneFiles.lua",
  "GameLogic\\Garages\\GarageFiles.lua",
  "GameLogic\\Shop\\ShopFiles.lua",
  "GameLogic\\PreviewCameras\\PreviewCameraFiles.lua",
  "GameLogic\\LIAB\\LIABCharacters.lua",
  "GameLogic\\RouteData\\RouteDataE3Files.lua",
  "TrafficFiles.lua",
  "Cameras.lua",
  "DebugFiles.lua",
  "propTypes.lua",
  "propGroups.lua",
  "hotload.lua",
  "AchievementTable.lua",
  "ModuleLists.lua",
  "Shadows.lua",
  "ErrorHandler.lua",
  "debug\\dailyupdatedisplay.lua",
  "configuration\\configselector.lua",
  "loading\\loadingFlow.lua",
  "loading\\chapterLoadingFlow.lua",
  "loading\\challengeLoadingFlow.lua",
  "loading\\tutorialLoadingFlow.lua",
  "loading\\missionStartLoadingFlow.lua",
  "loading\\chapterBookendLoadingFlow.lua",
  "loading\\missionEndLoadingFlow.lua",
  "loading\\endScreenLoadingFlow.lua",
  "loading\\dareAcceptLoadingFlow.lua",
  "fades\\fades.lua"
}
local logging = {
  "Logging\\ProfileLogging.lua"
}
standardInitialLoad[#standardInitialLoad + 1] = logging
function printLoadFiles()
  local function parseTable(t)
    for i = 1, #t do
      if type(t[i]) == "string" then
        print(t[i])
      elseif type(t[i]) == "table" then
        parseTable(t[i])
      end
    end
  end
  parseTable(standardInitialLoad)
end
function buildGameLoadFiles(config)
  gameLoadFiles = {}
  local fileTable = moduleLists[config.Name] or moduleLists.Game
  for i = 1, #fileTable do
    print(fileTable[i])
    gameLoadFiles[i] = FileTree[fileTable[i]][config.Name] or FileTree[fileTable[i]].Game
  end
  return gameLoadFiles
end
function loadConfigFiles()
  loadFiles = buildGameLoadFiles(configSelector.launchConfig)
  loadTableOfFiles(gameLoadFiles, loadConfigFile_callback)
end
function loadConfigFile_callback()
  if debugOpen then
    debugOpen("userSettings.lua")
    debugOpen("regionArtStatus.lua")
  end
  loadfile_allLoaded = true
  initialise.scriptsLoaded()
end
local loadDevMenu = false
local quickStartMultiplayer = false
local quickStartDevLan = false
local quickStartSplitScreen = false
local startingReplay = false
local forceConfigFromCommandLine = false
local forceMission = false
local forceLaunch = false
local function waitForStartScreen()
  if forceConfigFromCommandLine == false then
    addUserUpdateFunction("WaitForSplashScreen", function()
      if Menu.MAIN_StartMenuDone() or forceLaunch then
        removeUserUpdateFunction("WaitForSplashScreen")
        if loadDevMenu then
          print("Show dev menu")
          open("configuration\\gameSetupmenu.lua")
          Menu.ShowMain = 0
          loadDevMenu = false
        elseif quickStartDevLan then
          print("Starting devlan")
          Network.setConnection(1)
          configSelector.configLaunch([[
Multiplayer
Party Bus]])
          quickStartDevLan = false
        elseif quickStartMultiplayer then
          print("Quick load MP Party")
          Network.setConnection(2)
          configSelector.configLaunch([[
Multiplayer
Party Bus]])
          quickStartMultiplayer = false
        elseif quickStartSplitScreen then
          print("Starting split screen...")
          Network.setConnectionOffline()
          configSelector.configLaunch("Split Screen")
          quickStartSplitScreen = false
        elseif startingReplay then
          print("Replay playback")
          Network.setConnectionOffline()
          configSelector.configLaunch("Replay")
          startingReplay = false
        else
          print("Quick load SP")
          print("Presence set to FREEDRIVE")
          presenceSystem.setPresence(9)
          Network.setConnectionOffline()
          configSelector.configLaunch("Single Player")
        end
      end
    end, 1)
  else
    Menu.ShowMain = 0
  end
end
function _flagGameReadyForLaunch_callback(_autoTestSuite)
  return function()
    if debugOpen then
      debugOpen("configSettings.lua")
      if _autoTestSuite ~= nil and _autoTestSuite ~= "" then
        debugOpen("AutoTest\\AutoTest.lua")
        AutoTest.setTestSuite(_autoTestSuite)
      end
    end
    waitForStartScreen()
    GameLauncher.SetGameState("Game Started")
    Network.setEmulationConfigID(6)
  end
end
function flagGameReadyForLaunch(filename, _autoTest, _autoTestSuite)
  print("flagGameReadyForLaunch =================================")
  print(filename, _autoTest, _autoTestSuite)
  forceConfigFromCommandLine = false
  if filename and filename ~= "" then
    forceConfigFromCommandLine = true
    table.insert(standardInitialLoad, filename)
  end
  loadTableOfFiles(standardInitialLoad, _flagGameReadyForLaunch_callback(_autoTestSuite))
end
function flagGameDevMenu()
  loadDevMenu = true
end
function flagQuickStartMultiplayer()
  quickStartMultiplayer = true
  hintType = "multiplayer"
end
function flagQuickStartDevLan()
  quickStartDevLan = true
end
function flagInvitationAccepted_callback()
  configSelector.setLaunchConfig([[
Multiplayer
Party Bus]])
end
function flagInvitationAccepted()
  print("Join MP invite")
  Network.setConnection(2)
  loadTableOfFiles(standardInitialLoad, flagInvitationAccepted_callback)
  hintType = "multiplayer"
end
function flagStartSplitScreen()
  quickStartSplitScreen = true
  hintType = "splitscreen"
end
function flagStartingReplay()
  startingReplay = true
  configSelector.setLaunchConfig("Replay")
  hintType = "replay"
end
function flagGameReadyForReplay_callback()
  configSelector.setLaunchConfig("Replay")
end
function flagGameReadyForReplay()
  loadTableOfFiles(standardInitialLoad, flagGameReadyForReplay_callback)
end
function flagMissionToLaunch(networkLookupID)
  configSelector.setLaunchConfig("Single Player")
  configSelector.launchConfig.forceMission = networkLookupID
  forceLaunch = true
  missionLaunchedFromFrontEnd = true
  hintType = "story"
end
function flagCheatMode()
  unlockAllMissions()
  unlockAllChallenges()
  unlockAllVehicles()
  unlockAllAbilities()
  unlockAllGarages()
end
function getSelectedConfig()
  return configSelector.launchConfig.Type
end
function initialiseProfileData()
end
function profileLoadedCallback()
end
