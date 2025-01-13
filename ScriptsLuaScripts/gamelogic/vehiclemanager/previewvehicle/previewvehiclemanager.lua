module("vehicleManager.previewVehicleManager", package.seeall)
previewVehicle = false
previewVehicleManagerReflection.setPreviewVehicle(nil)
local taskObject
local optionSelected = false
local timerDone = false
local pipOver = false
local controlsSet = false
local challengeActivityPreview = false
local blockRejectButton = false
local rejectActivity = false
local acceptRejectPreview = false
local currentMission = false
function setPreviewButtons()
  local function menuSelectionUp()
    if rejectActivity then
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 1)
      OneShotSound.Play("Menu_Move")
      rejectActivity = false
    end
  end
  local function menuSelectionDown()
    if not rejectActivity then
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 2)
      OneShotSound.Play("Menu_Move")
      rejectActivity = true
    end
  end
  if not pipOver then
    if not blockRejectButton then
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Type", 2)
      controlHandler:registerState(localPlayer.localID, "Preview", {
        Menu_Select = {
          JustPressed = {
            [1] = function()
              if not optionSelected then
                acceptChallengeCallback()
                OneShotSound.Play("Menu_Select")
                optionSelected = true
              end
            end
          }
        },
        Menu_Cancel = {
          JustPressed = {
            [1] = function()
              if not optionSelected then
                if dareSystem.activeDare then
                  dareSystem.createDare(dareSystem.activeDare)
                end
                OneShotSound.Play("Menu_Select")
                rejectChallengeCallback()
                optionSelected = true
              end
            end
          }
        }
      })
    else
      controlHandler:registerState(localPlayer.localID, "Preview", {
        Menu_Select = {
          JustPressed = {
            [1] = function()
              if not optionSelected then
                OneShotSound.Play("Menu_Select")
                acceptChallengeCallback()
                optionSelected = true
              end
            end
          }
        }
      })
    end
  else
    if not blockRejectButton then
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Type", 2)
      controlHandler:registerState(localPlayer.localID, "Preview", {
        MissionComplete_Analog_Up = {
          JustPressed = {
            [1] = menuSelectionUp
          }
        },
        MissionComplete_Analog_Down = {
          JustPressed = {
            [1] = menuSelectionDown
          }
        },
        MissionComplete_DPad_Up = {
          JustPressed = {
            [1] = menuSelectionUp
          }
        },
        MissionComplete_DPad_Down = {
          JustPressed = {
            [1] = menuSelectionDown
          }
        },
        Menu_Select = {
          JustPressed = {
            [1] = function()
              if not feedbackSystem.leaderboard.leaderboardActive and not optionSelected then
                if rejectActivity then
                  feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 4)
                  if dareSystem.activeDare then
                    dareSystem.createDare(dareSystem.activeDare)
                  end
                  rejectChallengeCallback()
                else
                  feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 3)
                  acceptChallengeCallback()
                end
                OneShotSound.Play("Menu_Select")
                optionSelected = true
              end
            end
          }
        },
        Menu_ExtraFirst = {
          JustPressed = {
            [1] = function()
              local bOfflineMode = Menu.GetVariable("Master", "PC_OfflineMode")
              if feedbackSystem.leaderboard.leaderboardPreviewActive and not optionSelected and bOfflineMode == 0 and not feedbackSystem.leaderboard.leaderboardActive then
                feedbackSystem.leaderboard.showLeaderboardPanel()
                feedbackSystem.leaderboard.setLeaderboardButtons(currentMission, function()
                  vehicleManager.previewVehicleManager.setPreviewButtons()
                end)
                OneShotSound.Play("Menu_Select")
              end
            end
          }
        },
        Menu_Cancel = {
          JustPressed = {
            [1] = function()
              if not optionSelected then
                if not feedbackSystem.leaderboard.leaderboardActive then
                  if dareSystem.activeDare then
                    dareSystem.createDare(dareSystem.activeDare)
                  end
                  OneShotSound.Play("Menu_Select")
                  rejectChallengeCallback()
                end
                optionSelected = true
              end
            end
          }
        }
      })
    else
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Type", 1)
      controlHandler:registerState(localPlayer.localID, "Preview", {
        Menu_Select = {
          JustPressed = {
            [1] = function()
              if not optionSelected then
                feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 3)
                OneShotSound.Play("Menu_Select")
                acceptChallengeCallback()
                optionSelected = true
              end
            end
          }
        }
      })
    end
    local bOfflineMode = Menu.GetVariable("Master", "PC_OfflineMode")
    if bOfflineMode == 0 then
      feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_toggle", "ID:245797", nil, localPlayer.buttonLayout.openLeaderboard)
    else
      feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_toggle", "")
    end
    feedbackSystem.menusMaster.masterSetTextVariable("accept_button", localPlayer.buttonLayout.accept)
    feedbackSystem.menusMaster.masterSetTextVariable("reject_button", localPlayer.buttonLayout.accept)
    feedbackSystem.menusMaster.masterSetTextVariable("Activity_toggle_top", "ID:242358")
    feedbackSystem.menusMaster.masterSetTextVariable("Activity_toggle_bottom", "ID:216901")
    feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle", 1)
  end
  controlHandler:setState("Preview")
end
local function PIPOver()
  pipOver = true
  if taskObject and taskObject.coreData.actor.PIPCallBack then
    taskObject.coreData.actor.PIPCallBack()
  end
  if taskObject and previewVehicle and not acceptRejectPreview then
    setPreviewButtons()
    if taskObject.coreData.instance.challenge.name == "Exposition 05 Tanker on fire" then
      eventFeedback(previewVehicle, "preview1")
    elseif taskObject.coreData.instance.challenge.name == "Exposition 04 return to dealer" then
      eventFeedback(previewVehicle, "preview2")
    elseif taskObject.coreData.instance.challenge.name == "Exposition 06 Law Breaker (cop)" then
      eventFeedback(previewVehicle, "preview3")
    elseif taskObject.coreData.instance.challenge.name == "Exposition 08 Law Breaker (Getaway)" then
      eventFeedback(previewVehicle, "preview4")
    elseif taskObject.coreData.instance.challenge.name == "1 Downtown race" then
      eventFeedback(previewVehicle, "preview5")
    elseif taskObject.coreData.instance.challenge.name == "Learn to scream" then
      eventFeedback(previewVehicle, "preview7")
    elseif taskObject.coreData.instance.challenge.name == "Escape the law" then
      eventFeedback(previewVehicle, "preview8")
    end
  end
end
function challengeHUDPanel(challengeName)
  if challengeName then
    local mission, potID, subType, type = progressionSystem.findMissionInProgression(challengeName)
    if mission.scoreType then
      singlePlayerStatistics.setupMissionStatistics(mission.ID)
      local statsTable = singlePlayerStatistics.getMissionStatisticsScoreTable()
      local challengePreviewHUD = {slot = 2, defaultBest = false}
      if mission.ID == "DriveToSurvive2" or mission.ID == "Survival" or mission.ID == "Big break 2" or mission.ID == "ChinatownDrift" or mission.ID == "Uplaych4" then
        if statsTable.startValue <= mission.defaultBest or statsTable.startValue == 0 then
          challengePreviewHUD.defaultBest = true
        end
      elseif statsTable.startValue >= mission.defaultBest or statsTable.startValue == 0 then
        challengePreviewHUD.defaultBest = true
      end
      if mission.scoreType == "Score" then
        if challengePreviewHUD.defaultBest then
          challengePreviewHUD.value = mission.defaultBest
        else
          challengePreviewHUD.value = statsTable.startValue
        end
        feedbackSystem.updateChallengeBestScore(challengePreviewHUD)
      else
        if challengePreviewHUD.defaultBest then
          challengePreviewHUD.time = math.floor(mission.defaultBest) / 100
        else
          challengePreviewHUD.time = math.floor(statsTable.startValue) / 100
        end
        feedbackSystem.updateChallengeBestTime(challengePreviewHUD)
      end
    end
  end
end
local prePreviewCleanup = function()
  localPlayer.scoring:disableScoring(true)
  scoreSystem.stopAbilityGain(localPlayer.localID, true)
  scoringSystem.enableFeedback = false
  activeChallenges.enable(false)
  activeChallenges.disableActivities()
  activeChallenges.disableCollectables()
  garage.enable(false)
  feedbackSystem.menusMaster.allowUnlockPanel(false)
end
local function postPreviewReinstate()
  localPlayer.scoring:disableScoring(false)
  scoreSystem.stopAbilityGain(localPlayer.localID, false)
  scoringSystem.enableFeedback = unlockProgressionTable.willpowerEnabled
  activeChallenges.enableCollectables()
  local enableGarages
  if not challengeProgressionTable[progressionSystem.currentProgression].settings or not challengeProgressionTable[progressionSystem.currentProgression].settings.blockGarage then
    enableGarages = true
  else
    enableGarages = false
  end
  garage.enable(enableGarages)
  feedbackSystem.menusMaster.allowUnlockPanel(true)
  controlHandler:resetState("Preview")
  controlHandler:removeState("Preview", localPlayer.localID)
  optionSelected = false
end
local function waitForZapTransition(vehicle)
  return function()
    if not localPlayer.zapTransition then
      removeUserUpdateFunction("waitForZapTransition")
      localPlayer:enterCutsceneMode()
      previewVehicle = vehicle
      previewVehicleManagerReflection.setPreviewVehicle(vehicle.gameVehicle)
      prePreviewCleanup()
      taskObject = previewVehicle:getTaskObject()
      Commentary.StopCommentary()
      Commentary.DisableCommentaryTrigger(true)
      localPlayer.controllerInterface:removePlayerControl()
      spoolsystem.SetSpoolCentreAttachment(localPlayer.localID, previewVehicle.gameVehicle)
      zapcontroller.FPPShowZapFlare(false)
      timerDone = false
      controlsSet = false
      challengeActivityPreview = false
      pipOver = false
      blockRejectButton = false
      rejectActivity = false
      acceptRejectPreview = false
      currentMission = false
      local mission, potID, subType, type = progressionSystem.findMissionInProgression(taskObject.coreData.instance.challenge.name)
      local missionID = mission.ID
      currentMission = mission
      Mood.addMoodUserDefined(moodSystem.Zap, "previewMoodParent", 1, 1, -1)
      Mood.addMoodUserDefined(moodSystem.ZapCar, "previewMoodInCar", 1, 1, -1)
      if type == "challenge" or type == "activity" then
        challengeActivityPreview = true
      end
      if missionID == "Exposition 02 I wish we could help" or missionID == "Exposition 04 return to dealer" or missionID == "The debrief" then
        blockRejectButton = true
      end
      if subType == "tannerMission" or subType == "storyMission" then
        characterManager.InCarArmsDisplayTanner(true)
      end
      if taskObject and taskObject.coreData.instance.challenge.settings.disableTraffic then
        spooling.enableTraffic(false)
      end
      if taskObject and taskObject.coreData.instance.challenge.settings.disableInterestingVehicles then
        InterestingVehicleManager.Enable(false)
      end
      felony_patrollingVehicleManager.enablePatrollingVehicles(false)
      if missionID == "Car park" then
        Menu.SetVariable("Pause", "minimapVisible", 0)
      end
      Sound.EnterPreview()
      feedbackSystem.stopFreeDriveMusic(cards.Missions[missionID].MissionID)
      if challengeActivityPreview then
        local chapter = mission.settings.chapter
      end
      if taskObject then
        if not challengeActivityPreview then
          PIP.Activate("playfmv COM:fmv\\previews\\uid" .. string.format("%05d", cards.Missions[taskObject.coreData.instance.challenge.name].MissionID) .. "_mpr01.bik", PIPOver)
        else
          pipOver = true
        end
      end
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle", 0)
      if feedbackSystem.previewScreen.startMissionFromHotspot and challengeActivityPreview then
        acceptChallengeCallback()
      else
        CameraSystemRegisterUpdate("Game_Cam", game_camera, "simulation", Camera_Function_Vehicle_Driver_Eye_Cam, {agent = vehicle})
        feedbackSystem.previewScreen.showPreview("missionPreview", missionID)
        if mission and mission.scoreType then
          feedbackSystem.leaderboard.showLeaderboardPreviewPanel(mission)
        end
        if pipOver then
          addUserUpdateFunction("previewIntroDelay", function()
            timerDone = true
            removeUserUpdateFunction("previewIntroDelay")
          end, 1.5 * updates.stepRate, true)
        else
          addUserUpdateFunction("previewIntroDelay", function()
            timerDone = true
            removeUserUpdateFunction("previewIntroDelay")
          end, 1.5 * updates.stepRate, true)
        end
      end
    end
  end
end
function triggerVehiclePreview(vehicle)
  optionSelected = false
  if localPlayer.cameraMode == "Bumper" then
    VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
  end
  if dareSystem.dareCompleteScreenActive then
    dareSystem.hideDareCompleteScreen()
  end
  feedbackSystem.menusMaster.locationPrompt(false)
  progressionSystem.setTrafficEvents(false)
  Commentary.StopCommentary()
  localPlayer.controls:resetState("Player")
  localPlayer.controls.enableRumble(false)
  tannerNarration.disableNarrationManager()
  characterManager.InCarArmsDisplayTanner(false)
  replays.pause()
  addUserUpdateFunction("waitForZapTransition", waitForZapTransition(vehicle), 1)
end
local function cleanUp()
  PIP.Deactivate()
  Commentary.DisableCommentaryTrigger(false)
  characterManager.InCarArmsDisplayTanner(true)
  localPlayer.challenge.setRetryingMission(false)
  feedbackSystem.menusMaster.masterSetVariable("iActivity_New", 0)
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle", 0)
  if feedbackSystem.leaderboard.leaderboardPreviewActive then
    feedbackSystem.leaderboard.hideLeaderboardPreviewPanel()
  end
  localPlayer.controls.enableRumble(true)
  Mood.removeMood("previewMoodParent", 1)
  Mood.removeMood("previewMoodInCar", 1)
  previewVehicle = false
  previewVehicleManagerReflection.setPreviewVehicle(nil)
  replays.unPause()
  postPreviewReinstate()
end
function rejectChallengeCallback()
  acceptRejectPreview = true
  if not dareSystem.activeDare then
    progressionSystem.setTrafficEvents(true)
    felony_patrollingVehicleManager.enablePatrollingVehicles(true)
  end
  localPlayer:SetZapLevel(1)
  local challengeAlreadyComplete = false
  if challengeProgressionTable[progressionSystem.currentProgression].missions then
    for index, challenge in next, challengeProgressionTable[progressionSystem.currentProgression].missions, nil do
      if challenge.ID == taskObject.coreData.instance.challenge.name and challenge.complete then
        taskObject.coreData.instance:delete()
        challengeAlreadyComplete = true
        break
      end
    end
  end
  feedbackSystem.previewScreen.hidePreviewScreen()
  feedbackSystem.startFreeDriveMusic()
  feedbackSystem.menusMaster.locationPrompt(true)
  tannerNarration.startNarrationManager()
  cleanUp()
  activeChallenges.enableActivities()
  activeChallenges.enable(true)
  activeChallenges.createMissionWarmupMarker(taskObject.coreData.instance)
  localPlayer:exitCutsceneMode()
  if not challengeAlreadyComplete and (not progressionSystem.isMissionInCurrentChapter(taskObject.coreData.instance.challenge.name) or taskObject.coreData.instance.challenge.settings.deleteTaskOnReject) then
    progressionSystem.challengeAbandoned(taskObject.coreData.instance)
  end
end
local function startMission()
  localPlayer:enterCutsceneMode()
  localPlayer.missionSupport:setHooksFromVehicle(previewVehicle)
  if localPlayer.inZap then
    localPlayer:SetZapLevel(0, previewVehicle, true)
  end
  simulation.resetLevel()
  if not taskObject.coreData.instance.challenge.felonySettings.disablePoliceInTrafficDuringMission then
    felony_patrollingVehicleManager.enablePatrollingVehicles(true)
  end
  if not localPlayer.challenge.retryingMission and taskObject.coreData.instance.challenge.settings.forceCamOnStart then
    setActiveCamera(taskObject.coreData.instance.challenge.settings.forceCamOnStart, localPlayer.localID)
  end
  GameVehicleResource.unregisterAttachCallback(vehicleManager.noTowCallback, taskObject.coreData.agent.gameVehicle)
  if challengeActivityPreview then
    local mission = progressionSystem.findMissionInProgression(taskObject.coreData.instance.challenge.name)
    feedbackSystem.startFreeDriveMusic(cards.Missions[mission.ID].MissionID, true)
  end
  feedbackSystem.menusMaster.masterSetVariable("iDarepanel_Display", 1)
  cleanUp()
end
local function spawnActors()
  if taskObject.coreData.actor.spawn.relativeToVehicle then
    if taskObject.coreData.actor.spawn.position then
      challengeSystem.spawnActors(taskObject.coreData.instance, "On warmup", nil, true)
      startMission()
    else
      startMission()
    end
  else
    challengeSystem.spawnActors(taskObject.coreData.instance, "On warmup", nil, true)
    startMission()
  end
end
function acceptChallengeCallback()
  acceptRejectPreview = true
  PIP.Deactivate()
  localPlayer:clearPreviousVehicle()
  feedbackSystem.previewScreen.hidePreviewScreen()
  missionStartLoading.handleMissionStartLoading(taskObject.coreData.instance.challenge.name, taskObject.coreData.instance.challenge.missionStartCutscene, taskObject.coreData.instance.challenge.settings.loadTrafficOnStart, taskObject.coreData.actor.spawn.missionTeleportLocation and taskObject.coreData.actor.spawn.position, spawnActors)
end
function playerUpdate()
  if not controlsSet and timerDone then
    setPreviewButtons()
    controlsSet = true
  end
  if previewVehicle then
    minimap.SetPointOfInterest(previewVehicle.matrix)
  end
end
