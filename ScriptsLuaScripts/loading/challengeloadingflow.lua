module("challengeLoading", package.seeall)
state = "inactive"
previousLoadedScrpts = "none"
local debugOutput = function(output)
  print("[challengeLoading] : " .. tostring(output))
end
function purge()
  if state ~= "inactive" then
    removeUserUpdateFunction("ChallengeLoading")
    removeUserUpdateFunction("spawnVehicle")
  end
end
function handleChallengeLoad(challenge, instantFade, startedFromHotspot)
  debugOutput("Challenge to Load" .. tostring(challenge))
  loadingSystem.loadingStart()
  state = "fadeDown"
  local f = handleChallengeLoad_update(challenge, instantFade, startedFromHotspot)
  addUserUpdateFunction("ChallengeLoading", f, 1)
end
function handleChallengeLoad_update(challenge, instantFade, startedFromHotspot)
  local activityPotID, positionToSpool
  local settings = challenge.settings
  local startedInZap = localPlayer.inZap
  return function()
    if state == "fadeDown" then
      debugOutput("Fade Down")
      local nextState
      if settings.chunkFile then
        nextState = "loadingCoreFiles"
      else
        nextState = "settings"
      end
      state = "fadeDown - active"
      local fadeTime = 1
      if instantFade then
        fadeTime = 0
      end
      if startedFromHotspot then
        state = nextState
      else
        fades.down(function()
          state = nextState
        end, fadeTime)
      end
    elseif state == "loadingCoreFiles" then
      debugOutput("Loading Core Script Files")
      for instanceID, instance in next, challengeSystem.instances, nil do
        instance:delete()
      end
      cardSystem.clearModeData()
      state = "active - loading core files"
      loadingSystem.requestModeFiles("Core")
      loadingSystem.triggerLoadRequest("Loading Core Files", function()
        state = "loadingMissionFiles"
      end)
    elseif state == "loadingMissionFiles" then
      debugOutput("Loading Mission Files")
      state = "active - loading missions files"
      loadingSystem.requestModeFiles(settings.chunkFile)
      loadingSystem.triggerLoadRequest("Loading Mission Files", function()
        cardSystem.initialiseAllLoadedMissions()
        state = "settings"
      end)
    elseif state == "settings" then
      debugOutput("Get and Apply Settings")
      positionToSpool = getSettings(challenge)
      applySettings(challenge)
      local challenge, potID, subType, type = progressionSystem.findActivityInProgression(challenge.ID)
      if type == "activity" and potID ~= "Protect" then
        state = "loadActivityVehicle"
        activityPotID = potID
      else
        state = "loadData"
      end
    elseif state == "loadActivityVehicle" then
      state = "active - loadActivityVehicle"
      debugOutput("Load Activity Vehicle")
      local gameVehicle = not startedInZap and localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle
      print("gameVehicle = " .. tostring(gameVehicle))
      local function callback()
        progressionSystem.setActivityGameVehicle(gameVehicle, challenge.ID)
        state = "loadData"
      end
      local vehicleModelSwappedTo = false
      local vehicleModelToSpawn
      if not gameVehicle then
        print("no activity game vehicle")
        vehicleModelToSpawn = vehicleManager.getBestOwnedModelID()
        print("vehicleModelToSpawn = " .. tostring(vehicleModelToSpawn))
      end
      if activityPotID == "Getaway" or activityPotID == "RaceAway" then
        local copToCivLookupTable = {
          [271] = 187,
          [269] = 176,
          [280] = 150,
          [265] = 163,
          [302] = 178,
          [267] = 266
        }
        for copModelId, civModelID in next, copToCivLookupTable, nil do
          if gameVehicle and gameVehicle.model_id == copModelId or vehicleModelToSpawn == copModelId then
            print("Cop ModelID " .. tostring(copModelId) .. " needs changing to " .. tostring(civModelID))
            vehicleModelSwappedTo = civModelID
          end
        end
      end
      InterestingVehicleManager.Enable(false)
      civilianTraffic.setTrafficOnOff(false)
      vehicleManager.clearOrphanage()
      if vehicleModelSwappedTo or vehicleModelToSpawn then
        local function spawn()
          local params = {
            position = positionToSpool,
            modelID = vehicleModelSwappedTo or vehicleModelToSpawn
          }
          local vehicle = vehicleManager.spawnVehicle(params)
          for i = 1, 3 do
            GameVehicleResource.setCharacterSpoolingEntityIndex(vehicle.gameVehicle, i, -1)
          end
          localPlayer:SetZapLevel(0, vehicle, true, {disableZapFlash = true})
          gameVehicle = vehicle.gameVehicle
        end
        local function waitForSpooling()
          if TrafficSpooler.IsPlayerVehicleLoaded() then
            spawn()
            callback()
            removeUserUpdateFunction("spawnVehicle")
          end
        end
        vehicleManager.clearOrphanage()
        if not localPlayer.inZap then
          localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
        end
        if localPlayer.currentVehicle then
          localPlayer.currentVehicle:delete()
        end
        TrafficSpooler.SetAsPlayerVehicle(vehicleModelSwappedTo or vehicleModelToSpawn)
        addUserUpdateFunction("spawnVehicle", waitForSpooling, 1)
      else
        TrafficSpooler.SetAsPlayerVehicle(gameVehicle.model_id)
        callback()
      end
    elseif state == "loadData" then
      debugOutput("Load Data")
      state = "loadData - active"
      if missionLaunchedFromFrontEnd then
        local chapter = challenge.settings.chapter
        if chapter then
          local chapterMood
          if chapter ~= 10 then
            chapterMood = "Chapter" .. chapter
          else
            chapterMood = "FreeDrive"
          end
          loadingSystem.requestMood(chapterMood)
        end
      end
      if positionToSpool then
        loadingSystem.requestSpoolPosition(positionToSpool, headingForSpool, 0, true)
      end
      local mission, potID, subType, type = progressionSystem.findActivityInProgression(challenge.ID)
      loadingSystem.requestVehicleSettings(settings.trafficSettings, settings.missionVehiclePot, mission.trafficFrequencyOverride)
      loadingSystem.triggerLoadRequest("Loading Challenge Data", function()
        state = "fadeUp"
      end)
    elseif state == "fadeUp" then
      debugOutput("Fade Up")
      initialise.allLoadingComplete()
      state = "inactive"
      removeUserUpdateFunction("ChallengeLoading")
      if challenge.ID then
        local mission, potID, subType, type = progressionSystem.findActivityInProgression(challenge.ID)
        if type == "challenge" then
          singlePlayerStatistics.setupMissionStatistics(challenge.ID)
        end
        progressionSystem.forceStartMission(challenge.ID, nil, startedFromHotspot)
      end
      progressionSystem.applyingChapterSettings = false
      local callback = function()
        loadingSystem.loadingComplete()
        if missionLaunchedFromFrontEnd then
          replays.start()
          replays.pause()
        end
      end
      if not startedFromHotspot then
        fades.up(callback)
      elseif missionLaunchedFromFrontEnd then
        replays.start()
      end
    end
  end
end
function getSettings(challenge)
  local settings = challenge.settings
  local missionID = challenge.ID
  local positionToSpool
  for i, actor in ipairs(cardSystem.formattedMissionData[missionID].challenge.actorPool) do
    if actor.previewMovie then
      positionToSpool = actor.spawn and actor.spawn.position or cardSystem.formattedMissionData[missionID].challenge.settings.position
      break
    end
  end
  return positionToSpool
end
function applySettings(challenge)
  local settings = challenge.settings
  local missionID = challenge.ID
  local chapter = settings.chapter
  GameVehicleResource.SetCivilianPot("Free Drive Pot 01")
  if settings.cityLocking then
    loadingSystem.requestCityLocking(settings.cityLocking)
  end
  if settings.blockAbilityBar then
    cardSystem.formattedMissionData[missionID].challenge.settings.blockAbilityBar = true
    enableAbilities(localPlayer.localID, not settings.blockAbilityBar)
    localPlayer:blockAbility("zap", true)
    localPlayer:blockAbility("ram", true)
    localPlayer:blockAbility("nitro", true)
    localPlayer:blockAbility("zapReturn", true)
  end
  if settings.blockWillpower then
    enableWillpower(not settings.blockWillpower)
  end
  if settings.forceCamOnStart then
    cardSystem.formattedMissionData[missionID].challenge.settings.forceCamOnStart = settings.forceCamOnStart
  end
end
