module("missionEndLoading", package.seeall)
local debugOutput = function(output)
  print("[missionEndLoading] == |  " .. tostring(output))
end
local chapterChange = false
local skipIconVisible = false
state = "inactive"
function purge()
  if state ~= "inactive" then
    removeUserUpdateFunction("missionEndLoading")
  end
end
function handleMissionEndLoading(challengeName, successful, disableZapOnCompletion, afterEndScreenCutscene, afterEndScreenLocation, fromInWorld)
  if challengeName == "Tutorial activity" then
    return
  end
  debugOutput("Start load")
  loadingSystem.loadingStart()
  if not disableZapOnCompletion and missionType ~= "challenge" and missionType ~= "activity" then
    state = "initialFadeDown"
  else
    state = "specialFadeDown"
  end
  print(state)
  callStack()
  local f = handleMissionEndLoading_update(challengeName, successful, disableZapOnCompletion, afterEndScreenCutscene, afterEndScreenLocation, fromInWorld)
  addUserUpdateFunction("missionEndLoading", f, 1)
end
function handleMissionEndLoading_update(challengeName, successful, disableZapOnCompletion, afterEndScreenCutscene, afterEndScreenLocation, fromInWorld)
  localPlayer.missionSupport.setFreedriveMode()
  local currentPot = challengeProgressionTable[progressionSystem.currentProgression]
  local settings = currentPot.settings
  local chapter = settings.chapter
  local completedMissionInCurrentPot = false
  local loadNextChapter = progressionSystem.getLoadNextPot()
  local mission, potID, subType, missionType = progressionSystem.findMissionInProgression(challengeName)
  local disableLoad = false
  local unlockingAbility = ProfileSettings.GetMissionCompleted(cards.ReverseMissionNetworkLookup[challengeName]) and mission.unlocksAbility and not isAbilityUnlocked(mission.unlocksAbility)
  local forceStartNextMission = successful and not ProfileSettings.GetStoryModeComplete() and mission.forceStartNextMission
  if missionType == "mission" or missionType == "progressionTutorial" then
    completedMissionInCurrentPot = progressionSystem.isMissionInCurrentChapter(challengeName)
    if completedMissionInCurrentPot then
      debugOutput("In progression")
    else
      debugOutput("In freedrive")
      Sound.RemovePreview(cards.Missions[challengeName].MissionID)
      state = "finished"
    end
  end
  if not unlockingAbility and not loadNextChapter and completedMissionInCurrentPot then
    progressionSystem.storyMissionUnlockCheck()
    activeChallenges.updateActiveChallengePot(currentPot)
    progressionSystem.updateUnlockProgression()
  end
  local afterEndScreenCutscene = successful and afterEndScreenCutscene
  local recap = false
  if successful and (missionType == "mission" or missionType == "progressionTutorial") and progressionSystem.showNextRecap(currentPot, mission, subType) then
    recap = "Recap" .. tostring(chapter)
  end
  local evidenceBoard = successful and mission.evidenceBoard
  return function()
    if state == "initialFadeDown" then
      state = "initialFadeDown - active"
      debugOutput("initialFadeDown")
      local function fadeCallback()
        if successful then
          state = "playMissionEndCutscene"
        else
          state = "loadData"
        end
      end
      fades.down(fadeCallback, 0)
      if afterEndScreenCutscene then
        Cutscene.HintNext(engineCutscene.GetCutsceneId(afterEndScreenCutscene))
      end
    elseif state == "playMissionEndCutscene" then
      debugOutput("playMissionEndCutscene")
      local callback = function()
        state = "fadeDownAfterCutscene"
      end
      if afterEndScreenCutscene then
        state = "active - playMissionEndCutscene"
        debugOutput("Show cutscene " .. tostring(afterEndScreenCutscene))
        engineCutscene.triggerCutscene(afterEndScreenCutscene, nil, callback)
      elseif Credits.areRequested() then
        state = "credits"
      else
        state = "showEvidenceBoard"
      end
    elseif state == "credits" then
      debugOutput("credits")
      skipIconVisible = false
      controlHandler:registerState(localPlayer.localID, "skipCredits", {
        Menu_Select = {
          JustPressed = {
            [1] = function()
              if skipIconVisible then
                Credits.stop()
                Menu.SetVariable("Loading", "iCutscene_Skip", 2)
                skipIconVisible = false
              else
                Menu.SetTextVariableIcon("Loading", "Cutscene_Skip", "ID:236758", buttonsTable[localPlayer.buttonLayout.accept.button])
                Menu.SetVariable("Loading", "iCutscene_Skip", 1)
                skipIconVisible = true
              end
            end
          }
        }
      })
      controlHandler:setState("skipCredits")
      local function callback()
        state = "fadeDownAfterCutscene"
        if skipIconVisible then
          Menu.SetVariable("Loading", "iCutscene_Skip", 2)
        end
        controlHandler:resetState("skipCredits")
        controlHandler:removeState("skipCredits", localPlayer.localID)
      end
      Credits.show(callback)
      state = "active - credits"
    elseif state == "fadeDownAfterCutscene" then
      debugOutput("fadeDownAfterCutscene")
      state = "active - fading"
      local callback = function()
        state = "showEvidenceBoard"
      end
      fades.down(callback, 0)
      localPlayer:exitCutsceneMode()
    elseif state == "specialFadeDown" then
      debugOutput("specialFadeDown")
      state = "specialFadeDown - active"
      disableLoad = true
      if evidenceBoard then
        fades.down(function()
          state = "showEvidenceBoard"
        end)
      else
        state = "finished"
      end
    elseif state == "showEvidenceBoard" then
      debugOutput("Show evidence board")
      state = "active - showEvidenceBoard"
      if evidenceBoard then
        debugOutput("Show evidence board " .. evidenceBoard)
        local exitEvidenceBoardCallback = function()
          state = "playRecap"
          Presence.setPresence(9)
        end
        EBoard.DisplayCurrentBoard(exitEvidenceBoardCallback)
      else
        debugOutput("No evidence board to show")
        state = "playRecap"
      end
    elseif state == "playRecap" then
      local callback = function()
        state = "fadeDownAfterRecap"
      end
      if recap then
        debugOutput("Play Recap " .. recap)
        state = "active - playing recap"
        engineCutscene.triggerCutscene(recap, nil, callback)
      else
        state = "loadData"
        debugOutput("No recap to play")
      end
    elseif state == "fadeDownAfterRecap" then
      debugOutput("Fade down")
      state = "active - fading"
      fades.down(function()
        state = "loadData"
      end, 0)
      localPlayer:exitCutsceneMode()
    elseif state == "loadData" then
      if disableLoad then
        state = "finished"
      else
        debugOutput("loadData")
        state = "active - loadData"
        local loadCallback = function()
          state = "finished"
        end
        if loadNextChapter and not afterEndScreenLocation then
          loadCallback()
        else
          if ProfileSettings.GetStoryModeComplete() then
            local mission, potID, subType, type = progressionSystem.findMissionInProgression(challengeName)
            if mission.cityLockingRequired then
              loadingSystem.requestCityLocking("CityLockingLevel4")
            end
          end
          loadingSystem.requestVehicleSettings(settings.trafficSettings, settings.missionVehiclePot, settings.trafficFrequencyOverride)
          if afterEndScreenLocation then
            loadingSystem.requestSpoolPosition(afterEndScreenLocation.position, afterEndScreenLocation.heading)
          else
            loadingSystem.requestSpoolPosition(zapcontroller.ZapCameraGetTargetPos(), nil, 0)
          end
          loadingSystem.triggerLoadRequest("Loading Chapter", loadCallback)
        end
      end
    elseif state == "finished" then
      debugOutput("finished")
      if not disableZapOnCompletion and 0 < zap.currentUnlockedZapLevel then
        localPlayer:SetZapLevel(zap.currentUnlockedZapLevel, nil)
      end
      progressionSystem.applyingChapterSettings = false
      local function isPotEndTutorial()
        if missionType == "progressionTutorial" then
          return mission.type == "potEnd" and potID == progressionSystem.currentProgression
        end
      end
      loadingSystem.loadingComplete()
      if isPotEndTutorial() then
        progressionSystem.initialiseProgressionPot()
      elseif missionType == "mission" or missionType == "progressionTutorial" then
        if unlockingAbility then
          tutorialLoading.handleTutorialLoading(mission.unlocksAbility, 0)
        elseif forceStartNextMission then
          progressionSystem.forceStartMission(forceStartNextMission)
        elseif loadNextChapter then
          chapterBookendLoading.handleChapterBookendLoading(disableZapOnCompletion)
        elseif completedMissionInCurrentPot then
          print("Presence set to FREEDRIVE")
          presenceSystem.setPresence(9)
          fades.up()
        else
          print("Presence set to FREEDRIVE")
          presenceSystem.setPresence(9)
          progressionSystem.applyChapterSettings(progressionSystem.currentProgression, nil, true, true)
        end
      elseif missionType == "challenge" or missionType == "activity" then
        if mission.settings.blockAbilityBar then
          localPlayer:blockAbility("zap", false)
          localPlayer:blockAbility("ram", false)
          localPlayer:blockAbility("nitro", false)
          localPlayer:blockAbility("zapReturn", false)
        end
        if progressionSystem.getLoadNextPot() then
          local activityGameVehicle = progressionSystem.getActivityGameVehicle()
          local activityVehicle
          if activityGameVehicle then
            activityVehicle = vehicleManager.vehiclesByGameVehicle[activityGameVehicle]
            if activityVehicle then
              activityVehicle:delete()
              progressionSystem.clearActivityGameVehicle()
            end
          end
        end
        if (configSelector.launchConfig.Name == "Single Player" or configSelector.launchConfig.Name == "Post Debrief") and not ProfileSettings.GetFMVWatched(1) then
          print("Presence set to Just Completed Chapter 0")
          presenceSystem.setPresence(11, 0)
          progressionSystem.applyChapterSettings(progressionSystem.currentProgression)
        else
          local fromChallenge = false
          if missionType == "challenge" then
            fromChallenge = mission.ID
          end
          progressionSystem.applyChapterSettings(progressionSystem.currentProgression, nil, true, true, nil, nil, fromInWorld, fromChallenge)
        end
      end
      state = "cleanup"
    elseif state == "cleanup" then
      state = "inactive"
      removeUserUpdateFunction("missionEndLoading")
      progressionSystem.setLoadNextPot(false)
      debugOutput("============ | DONE")
    end
  end
end
