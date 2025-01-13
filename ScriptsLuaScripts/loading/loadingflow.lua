module("loadingSystem", package.seeall)
loadingData = {}
loadingData.loadCompleteCallback = nil
loadingData.flags = {}
loadingData.timer = 0
local spoolingUpdateFunctionName = "loadingSystem_requestSpoolPosition"
local vehicleUpdateFunctionName = "loadingSystem_requestVehicles"
local modeFilesUpdateFunctionName = "loadingSystem_requestModeFiles"
lastLoadedMode = nil
function getLastLoadedMode()
  return lastLoadedMode
end
function debugOutput(out)
  print("[loadingSystem] ==| " .. tostring(out))
end
function loadingActiveCheck()
  local waitingCount = 0
  loadingData.timer = loadingData.timer + 1
  for k, v in next, loadingData.flags, nil do
    if v == true then
      waitingCount = waitingCount + 1
    end
  end
  if waitingCount == 0 then
    removeUserUpdateFunction("loadingActiveCheck")
    loadingAllDone()
  end
end
function purge()
  removeUserUpdateFunction("loadingActiveCheck")
  removeUserUpdateFunction("loadModeChunkFile")
  removeUserUpdateFunction(spoolingUpdateFunctionName)
  removeUserUpdateFunction(vehicleUpdateFunctionName)
  removeUserUpdateFunction(modeFilesUpdateFunctionName)
  removeUserUpdateFunction("MoodTimeOut")
end
function loadingAllDone()
  debugOutput("DONE")
  loadingData.flags = {}
  if loadingData.loadCompleteCallback then
    loadingData.loadCompleteCallback()
  end
  debugOutput(" Time Loading : " .. loadingData.timer / 120)
end
function triggerLoadRequest(gameMode, callWhenComplete)
  debugOutput(" [triggerLoadRequest]: Load requested. Switching to game loading state and loading:")
  loadingData.timer = 0
  for k, v in next, loadingData.flags, nil do
    print("          " .. k)
  end
  loadingData.loadCompleteCallback = callWhenComplete
  addUserUpdateFunction("loadingActiveCheck", loadingActiveCheck, 1)
end
function requestModeFiles_update()
  debugOutput("[requestModeFiles] : COMPLETE")
  removeUserUpdateFunction(modeFilesUpdateFunctionName)
  ScriptLoader.ri_closeScriptPackage()
  loadingData.flags.waitingModeFiles = false
end
function requestModeFiles(filechunk)
  debugOutput("[requestModeFiles] :" .. tostring(filechunk))
  loadingData.flags.waitingModeFiles = true
  if filechunk ~= "Core" then
    lastLoadedMode = filechunk
  end
  print(tostring(filechunk))
  ScriptLoader.ri_openScriptPackage("Media\\Scripts" .. tostring(filechunk) .. ".fchunk")
  addUserUpdateFunction("loadModeChunkFile", function()
    if ScriptLoader.ri_scriptPackageLoaded() then
      removeUserUpdateFunction("loadModeChunkFile")
      debugOutput("Loaded Script Chunk. Now loading files...")
      open("fileList.lua")
      loadTableOfFiles(FileTree.ModeFiles, requestModeFiles_update)
    end
  end, 1)
end
function requestSpoolPosition_update(position, ignoreRoadUpdate)
  local spoolPosition = position
  local citySpooled = false
  local roadsUpdating = false
  debugOutput(spoolPosition)
  return function()
    citySpooled = spoolsystem.IsLocationResident(spoolPosition)
    roadsUpdating = civilianTraffic.RoadUpdateInProgress()
    if citySpooled and (ignoreRoadUpdate or not ignoreRoadUpdate and not roadsUpdating) then
      debugOutput("requestSpoolPosition : Complete")
      loadingData.flags.waitingForCitySpool = false
      removeUserUpdateFunction(spoolingUpdateFunctionName)
    end
  end
end
function requestSpoolPosition(spoolPosition, spoolHeading, playerID, ignoreRoadUpdate)
  debugOutput("[requestSpoolPosition] :" .. tostring(spoolPosition))
  loadingData.flags.waitingForCitySpool = true
  localPlayer:SetZapLevel(7, nil, true, {forcedOut = true})
  zapcontroller.setActionPoinTracking(spoolPosition, spoolHeading, 0, playerID)
  spoolsystem.position = spoolPosition
  local f = requestSpoolPosition_update(spoolPosition, ignoreRoadUpdate)
  addUserUpdateFunction(spoolingUpdateFunctionName, f, 1)
end
function requestVehicleSettings_update(trafficSettings, missionSettings, frequencyOverride)
  local loadingSpoolCheck = spooling.isChapterTrafficSpooled(trafficSettings, missionSettings, frequencyOverride)
  return function()
    local result = loadingSpoolCheck()
    if result == true then
      print("[loadingSystem.requestVehiclESettings] : Complete")
      loadingData.flags.waitingForTrafficSettings = false
      removeUserUpdateFunction(vehicleUpdateFunctionName)
      spooling.enableTraffic(true)
    end
  end
end
function requestVehicleSettings(trafficSettings, missionSettings, frequencyOverride)
  print("[loadingSystem.requestVehicleSettings] :  " .. tostring(trafficSettings) .. " , " .. tostring(missionSettings) .. " , " .. tostring(frequencyOverride))
  local f = requestVehicleSettings_update(trafficSettings, missionSettings, frequencyOverride)
  addUserUpdateFunction(vehicleUpdateFunctionName, f, 1)
  loadingData.flags.waitingForTrafficSettings = true
end
function requestCityLocking(locking)
  print("[loadingSystem.requestCityLocking] : " .. locking)
  enableCityLocking(locking)
end
function requestCommentary_callback()
  print("[loadingSystem.requestCommentary] : DONE")
  loadingData.flags.waitingForCommentary = false
end
function requestCommentary(commentary)
  print("[loadingSystem.requestCommentary] : " .. commentary)
  loadingData.flags.waitingForCommentary = true
  Commentary.LoadMission(commentary, requestCommentary_callback)
end
function reqeustAudio_callback()
  print("audio callback")
  loadingData.flags.waitingForAudio = false
end
function requestAudio(audio, chapter)
  if chapter < 0 then
    chapter = 1
  elseif chapter > 9 then
    chapter = 7
  end
  print("[loadingSystem.requestAudio] : " .. tostring(audio) .. " , " .. tostring(chapter))
  if chapter then
    Sound.SetChapter(chapter)
  end
  if audio then
    loadingData.flags.waitingForAudio = true
    Sound.LoadMission(audio, reqeustAudio_callback)
  end
end
function requestMood_callback()
  print("[loadingSystem.requestMood] : DONE")
  loadingData.flags.waitingForMood = false
  removeUserUpdateFunction("MoodTimeOut")
end
function requestMood(moodName)
  loadingData.flags.waitingForMood = true
  moodSystem.applyMood(moodName, 1, requestMood_callback)
  addUserUpdateFunction("MoodTimeOut", requestMood_callback, updates.stepRate * 1.1, true)
end
function requestCutScene()
  print("[loadingSystem.requestCutScene]")
end
function requestInterestingVehicleSettings(data)
  print("[loadingSystem.requestInterestingVehicleSettings]")
  print(data)
  InterestingVehicleManager.SetInterestingVehicleRegions(spooling.interestingVehicles)
end
function requestLocalistationText(chapter)
  print("[loadingSystem.requestLocalistationText]")
  print(chapter)
  LocalisationSpooler.RequestText(chapter)
end
function requestCivilianPot(pot)
  print("[loadingSystem.requestCivilianPot] : " .. pot)
  GameVehicleResource.SetCivilianPot(pot)
end
function requestNarrativeBillboards(info)
  print("[loadingSystem.requestNarrativeBillboards] : " .. info)
end
function loadingStart()
  print("[loadingSystem.loadingStart]")
  simulation.setSpeed(1)
  progressionSystem.applyingChapterSettings = true
  feedbackSystem.menusMaster.allowUnlockPanel(false)
  zapcontroller.EnableZapInput(false)
  activeChallenges.enable(false, true)
end
function loadingComplete()
  print("[loadingSystem.loadingComplete]")
  progressionSystem.applyingChapterSettings = false
  feedbackSystem.menusMaster.allowUnlockPanel(true)
  zapcontroller.EnableZapInput(true)
  if localPlayer.inZap and not vehicleManager.previewVehicleManager.previewVehicle then
    simulation.setSpeed(zap.singlePlayerZapSlowDownMultiplier)
  else
    simulation.setSpeed(1)
  end
  felony_patrollingVehicleManager.setSpawningModels()
  local mode = getLastLoadedMode()
  if mode ~= "Challenges" and mode ~= "ActionActivities" and mode ~= "StuntActivities" and mode ~= "RaceActivities" then
    local settings = challengeProgressionTable[progressionSystem.currentProgression].settings
    activeChallenges.enable(settings and not settings.blockActiveChallenges, true)
  end
end
