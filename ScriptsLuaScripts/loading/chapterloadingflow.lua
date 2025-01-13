module("chapterLoading", package.seeall)
local debugOutput = function(output)
  print("[ChapterLoading] == |  " .. tostring(output))
end
local getTutorialFromPot = function(pot, unlocksAbility)
  for _, tutorial in next, challengeProgressionTable[pot].tutorials, nil do
    if tutorial.ability == unlocksAbility then
      return tutorial
    end
  end
end
local function getIncompleteTutorial(potID)
  if challengeProgressionTable[potID].missions and not ProfileSettings.GetStoryModeComplete() then
    for _, mission in next, challengeProgressionTable[potID].missions, nil do
      if mission.unlocksAbility and mission.complete then
        local tutorial = getTutorialFromPot(potID, mission.unlocksAbility)
        if not tutorial.complete then
          return tutorial
        end
      end
    end
  end
end
local getIncompleteForceStartedMissions = function(potID)
  for challengeType, challenges in next, challengeProgressionTable[potID], nil do
    if challengeType ~= "settings" then
      for i, mission in ipairs(challenges) do
        if mission.complete and mission.forceStartNextMission and not ProfileSettings.GetMissionCompleted(cards.ReverseMissionNetworkLookup[mission.forceStartNextMission]) then
          return mission.forceStartNextMission
        end
      end
    end
  end
end
local startReplay = function(initialLoad)
  if initialLoad then
    replays.start()
  end
end
local chapterChange = false
state = "inactive"
function purge()
  if state ~= "inactive" then
    removeUserUpdateFunction("chapterLoading")
    removeUserUpdateFunction("chapterTitle")
    removeUserUpdateFunction("Remove shift prompt")
  end
end
function handleChapterLoading(pot, missionID, forced, skipCutScene, noSpoolingOrInitialCutscene, initialLoad, triggerLoadingScreen, fromInWorld, fromChallenge)
  debugOutput("Start load")
  loadingSystem.loadingStart()
  local chapterToLoad = challengeProgressionTable[pot].settings.chapter
  Sound.DoChapterTransition(true)
  chapterChange = challengeProgressionTable[pot].settings.chunkFile ~= loadingSystem.getLastLoadedMode()
  progressionSystem.inArtificialChapter = pot ~= progressionSystem.currentProgression
  if chapterChange and chapterToLoad > 0 then
    dareSystem.dareUnlockCheck(chapterToLoad)
  end
  if noSpoolingOrInitialCutscene then
    state = "startGame"
  else
    debugOutput(" Chapter to load and current chapter: " .. tostring(chapterToLoad) .. " | " .. tostring(progressionSystem.currentChapter))
    state = "initialFadeDown"
  end
  local f = handleChapterLoading_update(pot, missionID, forced, skipCutScene, noSpoolingOrInitialCutscene, initialLoad, fromInWorld, fromChallenge)
  addUserUpdateFunction("chapterLoading", f, 1)
end
function handleChapterLoading_update(pot, missionID, forced, skipCutScene, noSpoolingOrInitialCutscene, initialLoad, fromInWorld, fromChallenge)
  debugOutput("handleChapterLoading_update[ pot = " .. tostring(pot))
  debugOutput(", missionID = " .. tostring(missionID))
  debugOutput(", forced = " .. tostring(forced))
  debugOutput(", skipCutScene = " .. tostring(skipCutScene))
  debugOutput(", noSpoolingOrInitialCutscene = " .. tostring(noSpoolingOrInitialCutscene))
  debugOutput(", initialLoad = " .. tostring(initialLoad))
  debugOutput(", chapterChange = " .. tostring(chapterChange))
  debugOutput(", fromInWorld = " .. tostring(fromInWorld))
  debugOutput(", fromChallenge = " .. tostring(fromChallenge))
  debugOutput(" ] ")
  local settings = challengeProgressionTable[pot].settings
  local chapter = settings.chapter
  local positionToSpool, commentaryID, audioID, headingToSpool, allMissionsComplete
  local forceStartMissionFound = false
  local timeTrafficRequested = 0
  local activityGameVehicle = progressionSystem.getActivityGameVehicle()
  local activityVehicle
  if activityGameVehicle then
    activityVehicle = vehicleManager.vehiclesByGameVehicle[activityGameVehicle]
  end
  local abilityTutorialIncomplete, incompleteForcedMission
  if initialLoad then
    abilityTutorialIncomplete = getIncompleteTutorial(pot)
    incompleteForcedMission = getIncompleteForceStartedMissions(pot)
  end
  local recap = false
  if initialLoad and chapter > 0 and chapter < 8 then
    local recapNumber = 0
    if progressionSystem.showNextRecap(challengeProgressionTable[pot]) and not abilityTutorialIncomplete then
      recapNumber = chapter
    else
      recapNumber = chapter - 1
    end
    if recapNumber > 0 then
      recap = "Recap" .. tostring(recapNumber)
    end
  end
  return function()
    if state == "initialFadeDown" then
      state = "initialFadeDown - active"
      if transitions.isScreenFaded() then
        state = "loadingCoreFiles"
      else
        fades.down(function()
          state = "loadingCoreFiles"
        end)
      end
      if settings.hospitalCutscene and not forced and not skipCutScene then
        Cutscene.HintNext(engineCutscene.GetCutsceneId(settings.hospitalCutscene))
      end
      if settings.evidenceBoardUpdate then
        EBoard.SetCurrentBoard(settings.evidenceBoardUpdate)
      end
    elseif state == "loadingCoreFiles" then
      if chapterChange then
        debugOutput("Loading Chapter " .. tostring(chapter))
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
      else
        state = "loadTraffic"
      end
    elseif state == "loadingMissionFiles" then
      debugOutput("Loading Mission Files")
      state = "active - loading missions files"
      loadingSystem.requestModeFiles(settings.chunkFile)
      loadingSystem.triggerLoadRequest("Loading Mission Files", function()
        cardSystem.initialiseAllLoadedMissions()
        state = "loadTraffic"
      end)
    elseif state == "loadTraffic" then
      local loadCallback = function()
        state = "playHospitalCutscene"
      end
      state = "active - loadTraffic"
      loadingSystem.requestVehicleSettings(settings.trafficSettings, settings.missionVehiclePot, settings.trafficFrequencyOverride)
      loadingSystem.triggerLoadRequest("Loading Chapter", loadCallback)
    elseif state == "playHospitalCutscene" then
      debugOutput("Play hospital cutscene")
      state = "active - playing hospital Cutscene"
      if settings.hospitalCutscene and not initialLoad and not forced and not skipCutScene and not ProfileSettings.GetStoryModeComplete() then
        engineCutscene.triggerCutscene(settings.hospitalCutscene, nil, function()
          state = "fadeDownAfterHospitalCutscene"
        end)
      else
        state = "playUnlockCutscene"
        debugOutput("No cutsene to play")
      end
    elseif state == "fadeDownAfterHospitalCutscene" then
      if settings.cityUnlockCutscene and not forced and not skipCutScene then
        Cutscene.HintNext(engineCutscene.GetCutsceneId(settings.cityUnlockCutscene))
      end
      debugOutput("Fade down")
      state = "active - fading"
      fades.down(function()
        state = "playUnlockCutscene"
      end)
    elseif state == "playUnlockCutscene" then
      debugOutput("Play city unlock scene")
      state = "active - playUnlockCutscene"
      initialise.allLoadingComplete()
      if settings.cityUnlockCutscene and not initialLoad and not forced and not skipCutScene and not ProfileSettings.GetStoryModeComplete() then
        engineCutscene.triggerCutscene(settings.cityUnlockCutscene, nil, function()
          state = "chapterTitle"
        end)
      else
        debugOutput("No city unlock scene to play")
        state = "chapterTitle"
      end
    elseif state == "chapterTitle" then
      if settings.initialCutscene and not initialLoad and not forced and not skipCutScene then
        Cutscene.HintNext(engineCutscene.GetCutsceneId(settings.initialCutscene))
      end
      if settings.chapterTitle and not initialLoad and not forced and not skipCutScene then
        initialise.allLoadingComplete()
        state = "chapterTitle - active"
        Menu.SetVariable("Loading", "iChapter_Title", 1)
        Menu.SetVariable("Loading", "iChapter_Title_Text", 1)
        Menu.SetTextVariable("Loading", "Chapter 00", settings.chapterTitle.title)
        Menu.SetTextVariable("Loading", "Subtitle", settings.chapterTitle.subtitle)
        addUserUpdateFunction("chapterTitle", chapterTitleScreen(), 1)
      else
        state = "playCutscene"
      end
    elseif state == "fadeOutChapterTitle" then
      state = "fadeOutChapterTitle - active"
      fades.down(function()
        Menu.SetVariable("Loading", "iChapter_Title", 0)
        Menu.SetVariable("Loading", "iChapter_Title_Text", 0)
        state = "playCutscene"
      end)
    elseif state == "playCutscene" then
      debugOutput("Play Cutscene ")
      initialise.allLoadingComplete()
      local expoOrEpilogue = chapter == 0 or chapter > 7
      if settings.initialCutscene and not forced and not skipCutScene and (not initialLoad or expoOrEpilogue or not ProfileSettings.GetFMVWatched(chapter)) then
        state = "active - playing Cutscene"
        local function callback()
          ProfileSettings.SetFMVWatched(chapter)
          if not expoOrEpilogue then
            progressionSystem.saveGame("After watching or skipping a chapter start cutscene in chpaters 1-7")
          end
          state = "fadeDownAfterCutscene"
        end
        engineCutscene.triggerCutscene(settings.initialCutscene, nil, callback, false, false, settings.blendCutsceneBillBoard, settings.blendCutsceneBillBoardID)
      else
        state = "playRecap"
        debugOutput("No cutsene to play")
      end
    elseif state == "fadeDownAfterCutscene" then
      debugOutput("Fade down")
      state = "active - fading"
      fades.down(function()
        state = "playRecap"
      end, 0)
      localPlayer:exitCutsceneMode()
    elseif state == "playRecap" then
      local callback = function()
        state = "fadeDownAfterRecap"
      end
      if recap then
        debugOutput("Play Recap " .. recap)
        state = "active - playing recap"
        engineCutscene.triggerCutscene(recap, nil, callback)
      else
        state = "postCutsceneLoad"
        debugOutput("No recap to play")
      end
    elseif state == "fadeDownAfterRecap" then
      debugOutput("Fade down")
      state = "active - fading"
      fades.down(function()
        state = "postCutsceneLoad"
      end, 0)
      localPlayer:exitCutsceneMode()
    elseif state == "postCutsceneLoad" then
      initialise.allLoadingComplete()
      debugOutput("Post cutscene load")
      state = "active - postCutsceneLoad"
      positionToSpool, commentaryID, audioID, forceStartMissionFound = getMissionSettings(pot, missionID)
      if fromChallenge then
        local mission, potID, subType, missionType = progressionSystem.findMissionInProgression(fromChallenge)
        if missionType == "challenge" then
          positionToSpool = settings.zapStartPosition.position
          headingToSpool = settings.zapStartPosition.heading
        else
          positionToSpool = mission.position
          headingToSpool = mission.heading
        end
      elseif not positionToSpool and settings.zapStartPosition then
        positionToSpool = settings.zapStartPosition.position
        headingToSpool = settings.zapStartPosition.heading
      end
      if activityVehicle then
        local activity = progressionSystem.findActivityInProgression(progressionSystem.getLastActivityID())
        positionToSpool = activity.position
        headingToSpool = activity.heading
      end
      local function callback()
        state = "waitingForTraffic"
        timeTrafficRequested = g_NetworkTime
      end
      local missionToStart = missionID
      if not missionToStart and forceStartMissionFound then
        missionToStart = forceStartMissionFound.ID
      end
      requestChapterDataToBeLoaded(pot, missionToStart, forced, skipCutScene, noSpoolingOrInitialCutscene, positionToSpool, headingToSpool or 0, commentaryID, audioID, callback)
    elseif state == "waitingForTraffic" then
      if g_NetworkTime - timeTrafficRequested > 0.1 and not civilianTraffic.RoadUpdateInProgress() then
        state = "startGame"
      end
    elseif state == "startGame" then
      debugOutput("Starting Game")
      if missionID ~= nil then
        progressionSystem.forceStartMission(missionID)
      else
        if activityVehicle then
          if localPlayer.inZap then
            localPlayer:SetZapLevel(0, activityVehicle, true)
          elseif localPlayer.currentVehicle ~= activityVehicle then
            localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
            localPlayer:SetZapLevel(0, activityVehicle, true)
          end
          localPlayer:buildZapReturn()
          local activity = progressionSystem.findActivityInProgression(progressionSystem.getLastActivityID())
          local position = activity.position
          local heading = activity.heading
          activityVehicle:teleportToPositionAndHeading(position, heading, nil, nil, nil, false)
          GameVehicleResource.resetDamage({gameVehicle = activityGameVehicle})
        end
        allMissionsComplete = nextChapter(pot, chapter, false, initialLoad, forceStartMissionFound)
      end
      initialise.allLoadingComplete()
      if allMissionsComplete and not incompleteForcedMission and not abilityTutorialIncomplete then
        state = "done"
        chapterBookendLoading.handleChapterBookendLoading()
      else
        state = "waitForZapTransition"
      end
    elseif state == "waitForZapTransition" then
      debugOutput("waitForZapTransition")
      if not localPlayer.zapTransition then
        state = "fadeUpAfterSpool"
      end
    elseif state == "fadeUpAfterSpool" then
      state = "fadeUpAfterSpool - active"
      local unlockedAbility, abilityLevel = progressionSystem.tutorialCheck("potStart")
      debugOutput("Fade Up")
      state = "done"
      Sound.DoChapterTransition(false)
      progressionSystem.applyingChapterSettings = false
      if fromInWorld == false then
        Menu.GoToShopMenu()
      end
      local function fadeCallback()
        if chapter == 10 and configSelector.launchConfig.Name ~= "Free Drive No Progression" then
          local unlocks = false
          local eveythingComplete = progressionSystem.isEverythingUnlocked()
          if not ProfileSettings.GetStoryModeComplete() then
            ProfileSettings.SetStoryModeComplete()
            unlocks = true
          end
          local survival = cards.ReverseMissionNetworkLookup.Survival
          if not ProfileSettings.GetChallengeOwned(survival) then
            feedbackSystem.menusMaster.allowUnlockPanel(false)
            CutsceneFiles.tutorials.playTutorial("ID:246333", 1)
            ProfileSettings.SetChallengeUnlocked(survival)
            shop.purchaseChallenge(survival)
            unlocks = true
          end
          local challenger = 62
          if not ProfileSettings.GetVehicleOwned(challenger) then
            ProfileSettings.SetVehicleUnlocked(challenger)
            feedbackSystem.menusMaster.queueUnlockPanel("gadget", "vehicle", "vehicle", {challenger}, nil, nil, "ID:242805", "ID:245770")
            unlocks = true
          end
          if unlocks then
            progressionSystem.saveGame("When you complete the game")
          end
        elseif not forced and not skipCutScene then
          if pot == 7 then
            feedbackSystem.menusMaster.blockHintButton(true)
            local removeShiftPrompt = function()
              if not localPlayer.inZap then
                feedbackSystem.menusMaster.clearPrimaryTextPrompt()
                removeUserUpdateFunction("Remove shift prompt")
              end
            end
            if initialLoad then
              feedbackSystem.menusMaster.primaryTextPromptParam({
                prompt = "ID:183938",
                icon1 = localPlayer.buttonLayout.enterZap,
                permanent = true
              })
              addUserUpdateFunction("Remove shift prompt", removeShiftPrompt, 60)
            end
          elseif pot == 8 then
            if not ProfileSettings.IsTakedownUnlocked() then
              localPlayer.simulationSupport.doWait(4, function()
                feedbackSystem.menusMaster.currentHUDSetVariable("iMinimap_flash", 0)
              end)
              feedbackSystem.menusMaster.primaryTextPromptParam({
                prompt = "ID:245520",
                priority = 1,
                delay = true,
                permanent = true
              })
              feedbackSystem.menusMaster.currentHUDSetVariable("iMinimap_flash", 4)
              if not initialLoad then
                tannerNarration.playTannerNarration("PostCarDlr1")
              end
            elseif ProfileSettings.IsTakedownUnlocked() and not ProfileSettings.GetMissionCompleted(cards.ReverseMissionNetworkLookup["Exposition 06 Law Breaker (cop)"]) then
              feedbackSystem.menusMaster.primaryTextPromptParam({
                prompt = "ID:245806",
                priority = 1,
                delay = true,
                permanent = true
              })
            elseif ProfileSettings.GetMissionCompleted(cards.ReverseMissionNetworkLookup["Exposition 06 Law Breaker (cop)"]) then
              feedbackSystem.menusMaster.primaryTextPromptParam({
                prompt = "ID:245852",
                priority = 1,
                delay = true,
                permanent = true
              })
            end
          elseif not initialLoad and chapter == 1 then
            if ProfileSettings.GetStoryModeComplete() then
              CutsceneFiles.tutorials.playTutorial("ID:246057")
            else
              feedbackSystem.menusMaster.primaryTextPrompt("ID:246216")
              feedbackSystem.eventFeedback(nil, "POSTACTIVITY")
            end
          end
        end
        startReplay(initialLoad)
      end
      loadingSystem.loadingComplete()
      if unlockedAbility then
        tutorialLoading.handleTutorialLoading(unlockedAbility, abilityLevel)
        startReplay(initialLoad)
      elseif incompleteForcedMission then
        print("incomplete force start mission = " .. incompleteForcedMission)
        progressionSystem.forceStartMission(incompleteForcedMission)
        startReplay(initialLoad)
      elseif abilityTutorialIncomplete then
        tutorialLoading.handleTutorialLoading(abilityTutorialIncomplete.ability, abilityTutorialIncomplete.level)
        startReplay(initialLoad)
      else
        fades.up(fadeCallback)
      end
    elseif state == "done" then
      debugOutput("============ | DONE")
      state = "inactive"
      localPlayer.missionSupport.setFreedriveMode()
      if not forceStartMissionFound then
        print("Presence set to FREEDRIVE")
        presenceSystem.setPresence(9)
      end
      removeUserUpdateFunction("chapterLoading")
    end
  end
end
function getMissionSettings(pot, missionID)
  local positionToSpool, commentaryID, audioID, forceStartMissionFound
  print("[getMissionSettings] : Enter")
  print("[getMissionSettings] : missionID = " .. tostring(missionID))
  for challengeType, challenges in next, challengeProgressionTable[pot], nil do
    if challengeType ~= "settings" then
      for i, challenge in ipairs(challenges) do
        print("[getMissionSettings] : challenge.ID = " .. tostring(challenge.ID))
        print("[getMissionSettings] : challenge.forceStart = " .. tostring(challenge.forceStart))
        if challenge.forceStart and (not missionID or missionID and challenge.ID == missionID) then
          for i, actor in ipairs(cardSystem.formattedMissionData[challenge.ID].challenge.actorPool) do
            if actor.previewMovie then
              positionToSpool = actor.spawn and actor.spawn.position or cardSystem.formattedMissionData[challenge.ID].challenge.settings.position
              break
            end
          end
          feedbackSystem.stopFreeDriveMusic(cards.Missions[challenge.ID].MissionID)
          commentaryID = cards.Missions[challenge.ID].MissionID
          audioID = cards.Missions[challenge.ID].MissionID
          forceStartMissionFound = challenge
          print("forceStartMissionFound = " .. tostring(challenge.ID))
          break
        end
      end
    end
  end
  return positionToSpool, commentaryID, audioID, forceStartMissionFound
end
function requestChapterDataToBeLoaded(pot, missionID, forced, skipCutScene, noSpoolingOrInitialCutscene, positionToSpool, headingForSpool, commentaryID, audioID, loadCallback)
  local settings = challengeProgressionTable[pot].settings
  local chapter = settings.chapter
  print("===================== requestChapterDataToBeLoaded")
  if positionToSpool then
    loadingSystem.requestSpoolPosition(positionToSpool, headingForSpool, 0)
  end
  if chapter < 1 then
    civilianPot = "Free Drive Pot 01"
  elseif chapter > 7 then
    civilianPot = "Free Drive Pot 07"
  else
    civilianPot = "Free Drive Pot 0" .. chapter
  end
  felony_patrollingVehicleManager.enablePatrollingVehicles(true)
  felony_suspiciousVehicleManager.enableSuspiciousVehicles(true)
  progressionSystem.setTrafficEvents(true)
  loadingSystem.requestCivilianPot(civilianPot)
  loadingSystem.requestInterestingVehicleSettings(spooling.interestingVehicles)
  if settings.cityLocking then
    local cityLocking = settings.cityLocking
    if ProfileSettings.GetStoryModeComplete() and not settings.cityLockingRequired and missionID ~= "Tanner & Jones Mission 2" then
      cityLocking = "CityLockingLevel4"
    end
    loadingSystem.requestCityLocking(cityLocking)
  end
  loadingSystem.requestAudio(audioID, chapter)
  if commentaryID then
    loadingSystem.requestCommentary(commentaryID)
  end
  loadingSystem.requestLocalistationText(chapter)
  local moodToRequest
  if missionID and moodSystem.missionStartMoods[missionID] then
    moodToRequest = missionID
  elseif chapter ~= 10 then
    moodToRequest = "Chapter" .. chapter
  else
    moodToRequest = "FreeDrive"
  end
  if chapterMood ~= moodToRequest then
    moodSystem.removeMood(chapterMood)
    chapterMood = moodToRequest
  end
  loadingSystem.requestMood(chapterMood)
  if dareSystem.narrativeBillboardTexture[pot] then
    print("==================================================== REQUEST THE TEXTURE")
    BillboardManager.LoadNarrativeBillboard(dareSystem.narrativeBillboardTexture[pot])
  end
  loadingSystem.triggerLoadRequest("Loading Chapter", loadCallback)
end
function chapterTitleScreen()
  local timer = 0
  return function()
    timer = timer + 1
    if timer > 480 then
      removeUserUpdateFunction("chapterTitle")
      state = "fadeOutChapterTitle"
    end
  end
end
function nextChapter(pot, chapter, alreadyFaded, initialLoad, forceStartMissionFound)
  print("nextChapter = " .. tostring(chapter))
  print("progressionSystem.currentProgression = " .. tostring(progressionSystem.currentProgression))
  if forceStartMissionFound then
    print("forceStartMissionFound = " .. tostring(forceStartMissionFound.ID))
  end
  callStack()
  if progressionSystem.currentChapter ~= chapter then
    GameplayTracking.OnChapterStart(chapter)
  end
  progressionSystem.currentChapter = chapter
  activeChallenges.deleteAllInstances()
  local allComplete = true
  local missionCount = 0
  for instanceID, instance in next, challengeSystem.instances, nil do
    local inCurrentPot = false
    if challengeProgressionTable[pot].missions then
      for index, challenge in next, challengeProgressionTable[pot].missions, nil do
        if instance.challenge.name == challenge.ID then
          inCurrentPot = true
        end
      end
    end
    if not inCurrentPot then
      instance:delete()
    end
  end
  for challengeType, challenges in next, challengeProgressionTable[pot], nil do
    if challengeType ~= "settings" then
      for i, challenge in ipairs(challenges) do
        if cards.Missions[challenge.ID].MissionID and not challenge.doNotSpawn then
          Sound.LoadPreview(cards.Missions[challenge.ID].MissionID)
        end
        allComplete = allComplete and challenge.complete
        missionCount = missionCount + 1
      end
    end
  end
  if not localPlayer.currentVehicle and not progressionSystem.getActivityGameVehicle() and 0 < zap.currentUnlockedZapLevel then
    local zapLevel = challengeProgressionTable[progressionSystem.currentProgression].settings and challengeProgressionTable[progressionSystem.currentProgression].settings.maxZapLevel or zap.currentUnlockedZapLevel
    localPlayer:SetZapLevel(zapLevel, nil, false, {forcedOut = true})
  end
  if forceStartMissionFound then
    for i, actor in ipairs(cardSystem.formattedMissionData[forceStartMissionFound.ID].challenge.actorPool) do
      if actor.previewMovie then
        local vehicleToDelete
        if localPlayer.currentVehicle then
          vehicleToDelete = localPlayer.currentVehicle
        end
        progressionSystem.forceStartMission(forceStartMissionFound.ID)
        if vehicleToDelete then
          vehicleToDelete:delete()
        end
      end
    end
  end
  allComplete = allComplete and missionCount > 0
  if not forceStartMissionFound and not allComplete then
    progressionSystem.clearActivityGameVehicle()
    if challengeProgressionTable[pot].tannerMission or challengeProgressionTable[pot].storyMission then
      progressionSystem.storyMissionUnlockCheck(initialLoad)
    end
    activeChallenges.updateActiveChallengePot(challengeProgressionTable[pot], true)
  end
  if (challengeProgressionTable[pot].tannerMission or challengeProgressionTable[pot].storyMission) and not challengeProgressionTable[pot].missions and challengeProgressionTable[pot].storyMission then
    challengeProgressionTable[pot].storyMission[1].unlocked = true
  end
  garage.updateGarageUnlocks(chapter)
  collectables.updateCollectableUnlocks(chapter)
  vehicleManager.updateVehicleUnlocks(chapter)
  abilityUnlockCheck(chapter, false)
  progressionSystem.updateUnlockProgression()
  return allComplete
end
