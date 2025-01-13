module("feedbackSystem.previewScreen", package.seeall)
previewScreenActive = false
startMissionFromHotspot = false
local previewType, name, dare
local blockRejectButton = false
local rejectActivity = false
local selectionMade = false
missionDescription = false
missionButtonPrompt = false
missionButtonPressed = false
missionLocked = false
activityBeingPrompted = false
mmPreviewSetup = {
  challengeRace = {
    previewColour = 4,
    iconType = 5,
    titleType = "ID:245245"
  },
  challengeTimeTrial = {
    previewColour = 4,
    iconType = 6,
    titleType = "ID:245245"
  },
  challengeEscape = {
    previewColour = 3,
    iconType = 6,
    titleType = "ID:245245"
  },
  challengeGetaway = {
    previewColour = 3,
    iconType = 5,
    titleType = "ID:245245"
  },
  challengeDrift = {
    previewColour = 2,
    iconType = 5,
    titleType = "ID:245245"
  },
  challengeStunt = {
    previewColour = 2,
    iconType = 6,
    titleType = "ID:245245"
  },
  movieRace = {
    previewColour = 4,
    iconType = 7,
    titleType = "ID:245245"
  },
  movieAction = {
    previewColour = 3,
    iconType = 7,
    titleType = "ID:245245"
  },
  movieStunt = {
    previewColour = 2,
    iconType = 7,
    titleType = "ID:245245"
  },
  standardRace = {
    previewColour = 4,
    iconType = 3,
    titleType = "ID:245246"
  },
  standardTeamRace = {
    previewColour = 4,
    iconType = 4,
    titleType = "ID:245246"
  },
  standardEscape = {
    previewColour = 3,
    iconType = 4,
    titleType = "ID:245246"
  },
  standardTakedown = {
    previewColour = 3,
    iconType = 3,
    titleType = "ID:245246"
  },
  standardCheckpointTrial = {
    previewColour = 2,
    iconType = 3,
    titleType = "ID:245246"
  },
  standardStunt = {
    previewColour = 2,
    iconType = 4,
    titleType = "ID:245246"
  },
  dareSpeed = {
    previewColour = 4,
    iconType = 2,
    titleType = "ID:245244"
  },
  dareAction = {
    previewColour = 3,
    iconType = 2,
    titleType = "ID:245244"
  },
  dareStunt = {
    previewColour = 2,
    iconType = 2,
    titleType = "ID:245244"
  },
  premiumRace = {
    previewColour = 4,
    iconType = 1,
    titleType = "ID:245249"
  },
  premiumAction = {
    previewColour = 3,
    iconType = 1,
    titleType = "ID:245248"
  },
  premiumStunt = {
    previewColour = 2,
    iconType = 1,
    titleType = "ID:245250"
  },
  story = {
    previewColour = 1,
    iconType = 1,
    titleType = "ID:245247"
  }
}
activityPromptText = {
  speed = "ID:236158",
  stunt = "ID:245227",
  control = "ID:245228"
}
challengeCount = {
  bonus = 0,
  movie = #getChallengeList().bonus,
  uplay = #getChallengeList().bonus + #getChallengeList().movie,
  special = #getChallengeList().bonus + #getChallengeList().movie + #getChallengeList().uplay
}
local resetZap = function(doZap)
  if not localPlayer.currentVehicle or not localPlayer.currentVehicle.controlled then
    if doZap then
      localPlayer:SetZapLevel(2, nil, true, {forcedOut = true})
    end
    zapcontroller.HideFlare(false)
    zapcontroller.setRenderTarget(true, localPlayer.localID)
    zapcontroller.setZapSlowMotionMultiplier(zap.singlePlayerZapSlowDownMultiplier)
  end
end
function setPreviewButtons(mission)
  rejectActivity = false
  local function menuSelectionUp()
    if rejectActivity and not selectionMade then
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 1)
      OneShotSound.Play("Menu_Move")
      rejectActivity = false
    end
  end
  local function menuSelectionDown()
    if not rejectActivity and not selectionMade then
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 2)
      OneShotSound.Play("Menu_Move")
      rejectActivity = true
    end
  end
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
            if not selectionMade and not feedbackSystem.leaderboard.leaderboardActive then
              selectionMade = true
              if rejectActivity then
                feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 4)
              else
                feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 3)
              end
              hidePreviewScreen()
              OneShotSound.Play("Menu_Select")
              feedbackSystem.leaderboard.hideLeaderboardPreviewPanel()
              removeControls()
              CameraSystem.ContinueScene()
            end
          end
        }
      },
      Menu_ExtraFirst = {
        JustPressed = {
          [1] = function()
            local bOfflineMode = Menu.GetVariable("Master", "PC_OfflineMode")
            if not selectionMade and feedbackSystem.leaderboard.leaderboardPreviewActive and bOfflineMode == 0 and not feedbackSystem.leaderboard.leaderboardActive then
              feedbackSystem.leaderboard.showLeaderboardPanel()
              feedbackSystem.leaderboard.setLeaderboardButtons(mission, function()
                setPreviewButtons(mission)
              end)
              OneShotSound.Play("Menu_Select")
            end
          end
        }
      },
      Menu_Cancel = {
        JustPressed = {
          [1] = function()
            if not selectionMade and not feedbackSystem.leaderboard.leaderboardActive then
              selectionMade = true
              rejectActivity = true
              feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle", 0)
              hidePreviewScreen()
              OneShotSound.Play("Menu_Select")
              feedbackSystem.leaderboard.hideLeaderboardPreviewPanel()
              removeControls()
              CameraSystem.ContinueScene()
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
            if not selectionMade and not feedbackSystem.leaderboard.leaderboardActive then
              selectionMade = true
              hidePreviewScreen()
              feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 3)
              OneShotSound.Play("Menu_Select")
              removeControls()
              CameraSystem.ContinueScene()
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
  controlHandler:setState("Preview")
end
local showPreviewScreen = function()
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Preview", 1)
  OneShotSound.Play("HUD_Mission_Preview_Intro", false)
end
function hidePreviewScreen()
  feedbackSystem.menusMaster.masterSetVariable("istatic_willpower_total", 0)
  feedbackSystem.menusMaster.currentHUDSetVariable("iGift_Display", 0)
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Preview", 2)
  feedbackSystem.menusMaster.masterSetVariable("iDare_Warning", 0)
  OneShotSound.Play("HUD_Mission_Preview_Outro", false)
end
local function showIntroCamera(mission)
  local fadeTime = 0.5
  local enteredInThrillCam = localPlayer.cameraMode == "ThrillCam" and not localPlayer.inZap
  local function cleanup()
    if localPlayer.cameraMode == "Bumper" then
      VehicleSystem.setPlayerVehicleVisible(0, localPlayer.localID)
    end
    Sound.ExitAudioState("ActivityPreview")
    feedbackSystem.menusMaster.masterSetVariable("iActivity_New", 0)
    feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle", 0)
    PauseMenu.allow(true)
    localPlayer.inCutsceneOrIcam = false
    localPlayer:exitCutsceneMode()
    previewScreenActive = false
    feedbackSystem.menusMaster.allowUnlockPanel(true)
    blockRejectButton = false
    selectionMade = false
    resetZap()
    for instanceID, instance in next, challengeSystem.instances, nil do
      activeChallenges.createMissionWarmupMarker(instance)
    end
  end
  previewPosition = 0
  local previewCamera = (not mission or not mission.previewCamera) and dare and dare.previewCamera
  if not previewCamera then
    local previewPosition = (not mission or not mission.position) and dare and dare.position
    previewCamera = {
      lookAt = previewPosition,
      lookFrom = previewPosition + vec.vector(0, 150, 5, 0),
      fov = 1.3
    }
  end
  local function clearCameraScene()
    local function fadeIn(callback)
      spooling.fadeIn(nil, fadeTime, callback)
    end
    local function thrillCamResetCallback()
      if enteredInThrillCam then
        setActiveCamera("ThrillCam", localPlayer.localID)
      end
    end
    local function dareCallback()
      acceptPreview()
      fadeIn(thrillCamResetCallback)
    end
    CameraSystem.ContinueScene()
    local markers = (not mission or not mission.markers) and dare and dare.markers
    if markers then
      for type, marker in next, markers, nil do
        marker.visible = true
      end
    end
    cleanup()
    if rejectActivity then
      rejectPreview()
      fadeIn(thrillCamResetCallback)
    elseif dare then
      dareAcceptLoading.handleDareAcceptLoading(dare.position, dare.heading, dareCallback)
    else
      acceptPreview()
    end
    if rejectActivity then
      resetZap(true)
    end
  end
  local showPreviewCamera = {
    previewCamera,
    {duration = 0.25},
    {
      {
        action = "callback",
        callback = function()
          spooling.fadeIn(nil, fadeTime)
          activeChallenges.disableActivities()
          feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle", 0)
          if localPlayer.cameraMode == "Bumper" then
            VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
          end
        end
      },
      {
        action = "callback",
        callback = function()
          showPreviewScreen()
          if mission and mission.scoreType then
            feedbackSystem.leaderboard.showLeaderboardPreviewPanel(mission)
          end
        end
      },
      {
        action = "callback",
        callback = function()
          setPreviewButtons(mission)
        end,
        afterDuration = 1.5
      },
      {infiniteLength = true}
    },
    {
      {
        action = "callback",
        callback = function()
          spooling.fadeOut(nil, fadeTime, clearCameraScene)
        end,
        afterDuration = 0.5
      },
      {infiniteLength = true}
    }
  }
  local function triggerScene()
    local position = (not mission or not mission.position) and dare and dare.position
    local heading = (not mission or not mission.heading) and dare and dare.heading
    local matrix = alignMatrix(position, heading)
    if localPlayer.currentVehicle and localPlayer.currentVehicle.controlled then
      localPlayer.currentVehicle:teleport(matrix)
    else
      localPlayer:SetZapLevel(8, nil, true, {forcedOut = true})
      zapcontroller.HideFlare(true)
      zapcontroller.setRenderTarget(false, localPlayer.localID)
      zapcontroller.setZapSlowMotionMultiplier(1)
      local chapter = progressionSystem.currentChapter
      local chapterMood
      if chapter ~= 10 then
        chapterMood = "Chapter" .. chapter
      else
        chapterMood = "FreeDrive"
      end
      if chapterMood then
        sky.requestSkyDome = moodSystem.chapterMoods[chapterMood].sky
      end
    end
    local markers = (not mission or not mission.markers) and dare and dare.markers
    if markers then
      Marker.setAnimationLength("Fade", 0.25)
      for type, marker in next, markers, nil do
        marker.visible = false
      end
    end
    vehicleManager.clearOrphanage()
    progressionSystem.setTrafficEvents(false)
    localPlayer.inCutsceneOrIcam = true
    if enteredInThrillCam then
      setActiveCamera("Normal", localPlayer.localID)
    end
    CameraSystem.AddScene(showPreviewCamera)
  end
  spooling.fadeOut(nil, fadeTime, triggerScene)
end
function removeControls()
  controlHandler:resetState("Preview")
  controlHandler:removeState("Preview", localPlayer.localID)
  if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle.softness == 0 then
    localPlayer.currentVehicle.gameVehicle.softness = 1
  end
end
function acceptPreview()
  if previewType == "activityPreview" then
    local challenge, potID, challengeType = progressionSystem.findMissionInProgression(name)
    if challengeLookupTable[challengeType] then
      singlePlayerStatistics.setupMissionStatistics(name)
    end
    progressionSystem.applyChallengeSettings(challenge, nil, true)
  elseif previewType == "darePreview" then
    local function launchDare()
      dareSystem.createDare(dare)
    end
    if not ProfileSettings.GetToolTipShown(toolTipLookupTable.Dare) then
      ProfileSettings.SetToolTipShown(toolTipLookupTable.Dare)
      CutsceneFiles.tutorials.playTutorial("ID:245651", nil, launchDare)
    else
      launchDare()
    end
    activeChallenges.removeActivity(dare)
    activeChallenges.enableActivities()
  end
  if activityBeingPrompted then
    feedbackSystem.previewScreen.clearActivityBeingPrompted()
  end
  startMissionFromHotspot = true
end
function rejectPreview()
  activeChallenges.enableActivities()
  felony_suspiciousVehicleManager.enableSuspiciousVehicles(true)
  felony_patrollingVehicleManager.enablePatrollingVehicles(true)
  if dareSystem.activeDare then
    dareSystem.createDare(dareSystem.activeDare, true)
  end
  if activityBeingPrompted then
    feedbackSystem.previewScreen.displayActivityPrompt(activityBeingPrompted)
  end
end
local descriptionParameters = {
  variable = "mission_description"
}
function setupPreviewScreen(name)
  if garage.locations[name] then
    feedbackSystem.menusMaster.masterSetVariable("iActivity_New", 0)
    feedbackSystem.menusMaster.masterSetTextVariable("mission_type", "ID:246689")
    feedbackSystem.menusMaster.masterSetTextVariable("mission_title", garage.locations[name].name)
    feedbackSystem.menusMaster.masterSetTextVariable("reward_plus", "")
    feedbackSystem.menusMaster.masterSetVariable("iActivity_Preview_Reward", 0)
    feedbackSystem.menusMaster.masterSetVariable("istatic_willpower_total", 1)
    if ProfileSettings.GetGarageOwned(name) then
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Type", 5)
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Icon", 1)
      feedbackSystem.menusMaster.masterSetTextVariable("mission_description", "ID:246472")
      feedbackSystem.menusMaster.masterSetTextVariable("Activity_toggle_top", "ID:244010")
      feedbackSystem.menusMaster.masterSetTextVariable("accept_button", localPlayer.buttonLayout.focusButton)
    else
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Type", 6)
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Icon", 2)
      feedbackSystem.menusMaster.masterSetTextVariable("mission_description", "ID:246471")
      if not garage.canPlayerAffordGarage(name) then
        feedbackSystem.menusMaster.masterSetTextVariable("Activity_toggle_top", "ID:246466")
      else
        feedbackSystem.menusMaster.masterSetTextVariable("Activity_toggle_top", "ID:243856")
      end
      feedbackSystem.menusMaster.masterSetTextVariable("accept_button", localPlayer.buttonLayout.focusButton)
      feedbackSystem.menusMaster.masterSetTextVariable("reward", "ID:246690")
      feedbackSystem.menusMaster.masterSetTextVariable("Activity_willpower", feedbackSystem.menusMaster.setWillpowerComma(garage.locations[name].price))
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Preview_Reward", 1)
    end
  else
    local darePreview = false
    networkID = cards.ReverseMissionNetworkLookup[name]
    if not networkID then
      darePreview = true
      if localPlayer.currentVehicle and 1 > localPlayer.currentVehicle.gameVehicle.damage then
        localPlayer.currentVehicle.gameVehicle.softness = 0
      end
    end
    local mission, potID, subType, type = false, nil, nil, nil
    if not darePreview then
      mission, potID, subType, missionType = progressionSystem.findMissionInProgression(name)
    end
    if not name then
      printTable(activityBeingPrompted)
    end
    if darePreview then
      willPowerReward = willpowerRewards.dares[name.chapter]
      previewTitle = activityPromptText[name.type]
      previewSetting = name.iconType
      descriptionParameters.text = name.objective
      descriptionParameters.value1, descriptionParameters.value2, descriptionParameters.value3 = dareSystem.unpackParams(name.params)
    elseif networkID then
      willPowerReward = progressionSystem.getChallengeWillpowerReward(mission.ID) or false
      previewTitle = missionInfo[networkID].challengeTitle or ""
      previewSetting = mission.iconType
      descriptionParameters.text = missionInfo[networkID].description or ""
    end
    feedbackSystem.menusMaster.masterSetTextVariable("Activity_toggle_top", "ID:220948")
    if localPlayer.inZap and subType ~= "missions" and subType ~= "tannerMission" and subType ~= "storyMission" then
      feedbackSystem.menusMaster.masterSetTextVariable("accept_button", localPlayer.buttonLayout.focusButton)
    elseif localPlayer.inZap then
      feedbackSystem.menusMaster.masterSetTextVariable("accept_button", localPlayer.buttonLayout.zapSelect)
    else
      feedbackSystem.menusMaster.masterSetTextVariable("accept_button", localPlayer.buttonLayout.accept)
    end
    feedbackSystem.menusMaster.masterSetVariable("iActivity_New", 0)
    feedbackSystem.menusMaster.currentHUDSetVariable("iGift_Display", 0)
    if not darePreview and not missionDescription and subType ~= "missions" and subType ~= "tannerMission" and subType ~= "storyMission" then
      local complete = ProfileSettings.GetChallengeCompleted(cards.ReverseMissionNetworkLookup[mission.ID])
      if not complete then
        feedbackSystem.menusMaster.masterSetVariable("iActivity_New", 1)
      end
      if subType ~= "unlockable" and subType ~= "shop" and subType ~= "movie" and subType ~= "special" then
        local string1 = vehicleStatsLookupTable[mission.ID].manufacturerName
        local string2 = vehicleStatsLookupTable[mission.ID].modelName
        if not complete then
          feedbackSystem.menusMaster.masterSetTextVariable("gift_string", "ID:248485", string1, nil, nil, string2)
          feedbackSystem.menusMaster.currentHUDSetVariable("iGift_Display", 1)
        else
          feedbackSystem.menusMaster.masterSetTextVariable("gift_string_unlocked", "ID:248486", string1, nil, nil, string2)
          feedbackSystem.menusMaster.currentHUDSetVariable("iGift_Display", 2)
        end
      end
    end
    if dareSystem.activeDare and previewType ~= "shiftHotspotPreview" and previewType ~= "shiftMissionPreview" then
      feedbackSystem.menusMaster.masterSetTextVariable("accept_dare_warning", "ID:245866")
      feedbackSystem.menusMaster.masterSetVariable("iDare_Warning", 1)
    else
      feedbackSystem.menusMaster.masterSetVariable("iDare_Warning", 0)
    end
    feedbackSystem.menusMaster.masterSetTextVariable("mission_title", previewTitle)
    local missionsRemainingBeforeUnlock = progressionSystem.missionsRemainingBeforeUnlock(subType)
    if missionsRemainingBeforeUnlock and (subType == "missions" or subType == "tannerMission" or subType == "storyMission") then
      feedbackSystem.menusMaster.masterSetTextVariable("mission_description", "ID:245412", missionsRemainingBeforeUnlock)
    else
      missionLocked = false
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Preview_Locked", 0)
      feedbackSystem.menusMaster.masterSetTextVariableParams(descriptionParameters)
      descriptionParameters.text = nil
      if previewType == "darePreview" then
        descriptionParameters.value1 = nil
        descriptionParameters.value2 = nil
        descriptionParameters.value3 = nil
      end
    end
    feedbackSystem.menusMaster.masterSetVariable("iActivity_Preview_Reward", 0)
    if willPowerReward then
      feedbackSystem.menusMaster.masterSetTextVariable("reward", "ID:245865")
      feedbackSystem.menusMaster.masterSetTextVariable("reward_plus", "+")
      feedbackSystem.menusMaster.masterSetTextVariable("Activity_willpower", feedbackSystem.menusMaster.setWillpowerComma(willPowerReward))
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Preview_Reward", 1)
    end
    if mmPreviewSetup[previewSetting] then
      feedbackSystem.menusMaster.masterSetTextVariable("mission_type", mmPreviewSetup[previewSetting].titleType)
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Type", mmPreviewSetup[previewSetting].previewColour)
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Icon", mmPreviewSetup[previewSetting].iconType)
    end
  end
end
function buttonPressed()
  missionButtonPrompt = false
  missionButtonPressed = true
  OneShotSound.Play("Menu_Select")
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 3)
end
function hideButton()
  if userUpdateFunctions.zapPreviewButtonDelay then
    removeUserUpdateFunction("zapPreviewButtonDelay")
  end
  missionButtonPrompt = false
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle", 0)
end
local displayButton = function()
  missionButtonPrompt = true
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 0)
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Type", 1)
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle", 1)
end
function showButton(blockDelay)
  if userUpdateFunctions.zapPreviewButtonDelay then
    removeUserUpdateFunction("zapPreviewButtonDelay")
  end
  if activityBeingPrompted or missionDescription then
    if blockDelay then
      displayButton()
    else
      addUserUpdateFunction("zapPreviewButtonDelay", function()
        displayButton()
        removeUserUpdateFunction("zapPreviewButtonDelay")
      end, 1 * updates.stepRate, true)
    end
  end
end
local activityPromptText = {
  standardRace = "ID:245786",
  standardTeamRace = "ID:245786",
  standardTakedown = "ID:245787",
  standardEscape = "ID:245787",
  standardStunt = "ID:245788",
  standardCheckpointTrial = "ID:245788",
  dareStunt = "ID:245227",
  dareSpeed = "ID:236158",
  dareAction = "ID:245228",
  challenge = "ID:245245",
  movie = "ID:233920"
}
function displayActivityPrompt(data)
  if data.hotspotType ~= "garage" and not localPlayer.inZap then
    local prompt = ""
    local willpowerReward = ""
    if data.ID then
      local mission, potID, subType, type = progressionSystem.findMissionInProgression(data.ID)
      if type == "activity" then
        prompt = activityPromptText[data.iconType]
      elseif subType == "movie" then
        prompt = activityPromptText[subType]
      else
        prompt = activityPromptText[type]
      end
      willpowerReward = progressionSystem.getChallengeWillpowerReward(mission.ID) or ""
    else
      tannerNarration.playTannerNarration("DareFound", data.ID)
      prompt = activityPromptText[data.iconType]
      willpowerReward = willpowerRewards.dares[data.chapter] or ""
    end
    feedbackSystem.menusMaster.focusHintButtonState(false)
    feedbackSystem.menusMaster.masterSetVariable("iActivity_Type", feedbackSystem.previewScreen.mmPreviewSetup[data.iconType].previewColour)
    feedbackSystem.menusMaster.masterSetVariable("iActivity_Icon", feedbackSystem.previewScreen.mmPreviewSetup[data.iconType].iconType)
    feedbackSystem.menusMaster.masterSetTextVariable("dare_prompt_plus", "")
    feedbackSystem.menusMaster.masterSetTextVariable("dare_prompt_value", prompt)
    feedbackSystem.menusMaster.masterSetTextVariable("Focus_look", "ID:220948")
    feedbackSystem.menusMaster.masterSetTextVariable("prompt_secondary_button", localPlayer.buttonLayout.previewDare)
    if not localPlayer.inCutscene then
      feedbackSystem.menusMaster.masterSetVariable("iDare_Prompt", 1)
      feedbackSystem.menusMaster.masterSetVariable("iFocus_Refreshed", 2)
      OneShotSound.Play("HUD_Gen_HintPanel_Reminder", false)
    end
  end
end
function hideActivityPrompt(leaveCurrentActivity)
  feedbackSystem.menusMaster.masterSetVariable("iDare_Prompt", 0)
  feedbackSystem.menusMaster.masterSetVariable("iFocus_Refreshed", 0)
  if not leaveCurrentActivity then
    feedbackSystem.previewScreen.clearActivityBeingPrompted()
  end
  feedbackSystem.menusMaster.focusHintButtonState(true)
end
function clearActivityBeingPrompted()
  activityBeingPrompted = false
end
function showPreview(preview, missionNameOrDare, blockButton)
  previewType = preview or false
  if dareSystem.dareCompleteScreenActive then
    dareSystem.hideDareCompleteScreen(true)
  end
  if previewType ~= "shiftMissionPreview" and missionDescription then
    hideZapPreview("mission")
  end
  if previewType == "shiftMissionPreview" or previewType == "shiftHotspotPreview" then
    if dareSystem.activeDare and dareSystem.activeDare ~= missionNameOrDare or not dareSystem.activeDare then
      showZapPreview(missionNameOrDare)
      if not blockButton then
        showButton()
      end
    end
  elseif previewType == "activityPreview" or previewType == "darePreview" then
    showHotspotPreview(missionNameOrDare)
  end
  setupPreviewScreen(missionNameOrDare)
  if previewType == "missionPreview" and not missionDescription then
    showPreviewScreen()
  end
end
function showHotspotPreview(missionName)
  Sound.EnterAudioState("ActivityPreview", "Activity_Preview_Fade_Intro", "Activity_Preview_Fade_Outro")
  local chapter = progressionSystem.getCurrentChapter()
  if chapter == 0 then
    blockRejectButton = true
  end
  startMissionFromHotspot = false
  localPlayer:enterCutsceneMode()
  PauseMenu.allow(false)
  previewScreenActive = true
  feedbackSystem.menusMaster.allowUnlockPanel(false)
  local mission, potID, subType, type = false, nil, nil, nil
  if previewType ~= "darePreview" then
    name = missionName or false
    networkID = cards.ReverseMissionNetworkLookup[name]
    mission, potID, subType, missionType = progressionSystem.findMissionInProgression(name)
    if not ProfileSettings.GetChallengeUnlocked(networkID) then
      ProfileSettings.SetChallengeUnlocked(networkID, missionType == "activity")
      progressionSystem.saveGame("When you unlock a challenge (" .. name .. "), not from a mission or dare")
    end
    dare = false
  else
    dare = missionName or false
  end
  if missionType == "challenge" then
    local challengeInfo = getChallengeList()
    for challengeType, challengeList in next, challengeInfo, nil do
      for index, challenge in next, challengeList, nil do
        if challenge.networkID == networkID then
          local challengeIndex = challengeCount[challengeType] + (index - 1)
          Menu.SetChallengeLeaderboardEntry(challengeIndex)
          break
        end
      end
    end
  end
  for instanceID, instance in next, challengeSystem.instances, nil do
    activeChallenges.deleteMissionWarmupMarker(instance, true)
  end
  showIntroCamera(mission)
end
function showZapPreview(name)
  if not localPlayer.inCutscene then
    localPlayer:showHUDElements(false)
    local mission, potID, subType, type = false, nil, nil, nil
    if not darePreview then
      mission, potID, subType, missionType = progressionSystem.findMissionInProgression(name)
    end
    if subType == "missions" or subType == "tannerMission" or subType == "storyMission" then
      missionDescription = true
      missionLocked = true
      missionButtonPressed = false
    end
    showPreviewScreen()
  end
end
function hideZapPreview(previewType)
  if not vehicleManager.previewVehicleManager.previewVehicle and not previewScreenActive then
    if previewType == "mission" and missionDescription then
      missionDescription = false
    end
    if not previewType then
      missionDescription = false
    end
    if not missionDescription and not activityBeingPrompted or not localPlayer.inZap or dareSystem.promptingDareRetry then
      localPlayer:showHUDElements(true)
      hidePreviewScreen()
      hideButton()
    end
    feedbackSystem.menusMaster.focusHintButtonState(true)
  end
end
function showGaragePrompt()
  local currentGarageID = feedbackSystem.previewScreen.activityBeingPrompted.ID
  feedbackSystem.menusMaster.focusHintButtonState(false)
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Type", 1)
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Icon", 2)
  feedbackSystem.menusMaster.masterSetTextVariable("dare_prompt_plus", "")
  feedbackSystem.menusMaster.masterSetTextVariable("dare_prompt_value", garage.locations[currentGarageID].name)
  if not ProfileSettings.GetGarageOwned(currentGarageID) then
    if not garage.canPlayerAffordGarage(currentGarageID) then
      feedbackSystem.menusMaster.masterSetTextVariable("Focus_look", "ID:246466")
    else
      feedbackSystem.menusMaster.masterSetTextVariable("Focus_look", "ID:243856")
    end
  else
    feedbackSystem.menusMaster.masterSetTextVariable("Focus_look", "ID:244010")
  end
  feedbackSystem.menusMaster.masterSetTextVariable("prompt_secondary_button", localPlayer.buttonLayout.focusButton)
  feedbackSystem.menusMaster.masterSetVariable("iDare_Prompt", 1)
  feedbackSystem.menusMaster.masterSetVariable("iFocus_Refreshed", 2)
  OneShotSound.Play("HUD_Gen_HintPanel_Reminder", false)
end
function hideGaragePrompt()
  feedbackSystem.menusMaster.masterSetVariable("iDare_Prompt", 0)
  feedbackSystem.menusMaster.masterSetVariable("iFocus_Refreshed", 0)
  feedbackSystem.menusMaster.masterSetTextVariable("dare_prompt_value", "")
  feedbackSystem.menusMaster.focusHintButtonState(true)
end
