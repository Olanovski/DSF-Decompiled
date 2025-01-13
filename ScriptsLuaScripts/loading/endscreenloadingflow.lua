module("endScreenLoading", package.seeall)
local debugOutput = function(output)
  print("[endScreenLoading] == |  " .. tostring(output))
end
local chapterChange = false
local endScreenOptionSelected = false
local endMission = false
local bonusRewards = {
  challengeRace = "challengeRaceBonus",
  challengeTimeTrial = "challengeTimeTrialBonus",
  challengeEscape = "challengeEscapeBonus",
  challengeTakedown = "challengeTakedownBonus",
  challengeDrift = "challengeDriftBonus",
  challengeStunt = "challengeStuntBonus",
  movieRace = "challengeRaceBonus",
  movieStunt = "challengeStuntBonus",
  movieAction = "challengeEscapeBonus"
}
state = "inactive"
function purge()
  if state ~= "inactive" then
    removeUserUpdateFunction("endScreenLoading")
    removeUserUpdateFunction("Put off end screen until zap finished")
  end
end
local missionHasEndScreen = function(params)
  if params.type ~= "progressionTutorial" then
    if params.subType == "storyMission" then
      local chapter = challengeProgressionTable[params.potID].settings.chapter
      return chapter > 0 and chapter < 7
    else
      return true
    end
  end
  return false
end
local function missionNeedsToStopFreeDriveMusic(params)
  if params.type == nil then
    return false
  else
    return missionHasEndScreen(params)
  end
end
local function checkChallengeTime(params)
  local statsTable = singlePlayerStatistics.getMissionStatisticsScoreTable()
  local showDefaultBest = false
  local bonusWillpower = false
  local function bonusWPAmount(beatTarget)
    local willpowerReward = progressionSystem.getChallengeWillpowerReward(params.mission.ID)
    if not beatTarget then
      willpowerReward = willpowerReward / 2
    end
    return willpowerReward
  end
  if statsTable and statsTable.value ~= 0 then
    if params.mission.ID == "DriveToSurvive2" or params.mission.ID == "Survival" or params.mission.ID == "Big break 2" or params.mission.ID == "ChinatownDrift" or params.mission.ID == "Uplaych4" then
      if statsTable.startValue <= params.mission.defaultBest or statsTable.startValue == 0 then
        showDefaultBest = true
      end
      if statsTable.value > statsTable.startValue then
        singlePlayerStatistics.updateServerStatistics()
        bonusWillpower = bonusWPAmount(showDefaultBest)
      end
    else
      if statsTable.startValue >= params.mission.defaultBest or statsTable.startValue == 0 then
        showDefaultBest = true
      end
      if statsTable.value < statsTable.startValue then
        singlePlayerStatistics.updateServerStatistics()
        bonusWillpower = bonusWPAmount(showDefaultBest)
      end
    end
    if params.mission.scoreType == "Time" then
      feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_1_title", "ID:221134")
      local mins, secs, milli = feedbackSystem.formatTime(math.floor(statsTable.value) / 100)
      feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_1_minutes", mins)
      feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_1_seconds", secs)
      feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_1_milli", milli)
    elseif params.mission.scoreType == "Score" then
      feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_1_title", "ID:221133")
      feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_1_string", statsTable.value)
    end
    if bonusWillpower then
      feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Popup_Reward", 1)
      feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_2_title", "ID:243781")
      if showDefaultBest then
        feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_2_title", "ID:245523")
      end
      feedbackSystem.menusMaster.masterSetTextVariable("lboard_pb_reward", bonusWillpower)
      scoreSystem.willpowerReward(bonusWillpower, bonusRewards[params.mission.iconType], true)
      Achievements.UnlockAchievement(AchievementTable.AchievementID.THECHALLENGER.achievementID)
    end
  end
end
function handleEndScreenLoading(instance, params)
  debugOutput("Start load")
  loadingSystem.loadingStart()
  if missionNeedsToStopFreeDriveMusic(params) then
    feedbackSystem.stopFreeDriveMusic()
  end
  local f = handleEndScreenLoading_update(instance, params)
  addUserUpdateFunction("endScreenLoading", f, 1)
end
function handleEndScreenLoading_update(instance, params)
  local cutscene = params.rating == "PASS" and instance.challenge.missionEndCutscene
  local freezeFrame = params.rating == "PASS" and instance.challenge.freezeFrameOnMissionEndCutscene
  local disableZapOnCompletion = params.rating == "PASS" and instance.challenge.settings.disableZapOnCompletion
  local doesMissionHaveEndScreen
  local zapToEndScreenVehicle = false
  state = "started"
  return function()
    if state == "started" then
      debugOutput("started")
      endScreen(instance, params)
      doesMissionHaveEndScreen = missionHasEndScreen(params) or params.rating == "FAIL"
      if params.vehicle and doesMissionHaveEndScreen and not freezeFrame then
        zapToEndScreenVehicle = true
      end
      if params.type == "progressionTutorial" then
        if params.callback then
          params.callback()
        end
        state = "finished"
      else
        state = "postponeCriteria"
      end
    elseif state == "postponeCriteria" then
      debugOutput("postponeCriteria")
      state = "postponeCriteria - active"
      local callback = function()
        state = "whereNext"
      end
      localPlayer.challenge.missionEndWait(callback)
    elseif state == "whereNext" then
      debugOutput("whereNext")
      if disableZapOnCompletion then
        state = "displayEndScreenCheck"
      elseif cutscene or not doesMissionHaveEndScreen or params.forceRetry then
        state = "fadeDown"
      else
        state = "doSlowDown"
      end
      debugOutput("Chose to skip to " .. state)
    elseif state == "fadeDown" then
      state = "fadeDown - active"
      debugOutput("fadeDown")
      local function fadeCallback()
        if params.forceRetry then
          retry(instance, params)
          state = "finished"
        elseif cutscene then
          state = "playMissionEndCutscene"
        else
          state = "displayEndScreenCheck"
        end
      end
      fades.down(fadeCallback)
      if afterEndScreenCutscene then
        Cutscene.HintNext(engineCutscene.GetCutsceneId(cutscene))
      end
    elseif state == "playMissionEndCutscene" then
      local callback = function()
        state = "fadeDownAfterCutscene"
      end
      debugOutput("playMissionEndCutscene " .. tostring(cutscene))
      state = "active - playMissionEndCutscene"
      if freezeFrame then
        engineCutscene.triggerCutsceneWithEndScreen(cutscene, nil, function()
          params.cutsceneEndScreen = true
          callback()
        end)
      else
        engineCutscene.triggerCutscene(cutscene, nil, function()
          callback()
        end)
      end
    elseif state == "fadeDownAfterCutscene" then
      debugOutput("fadeDownAfterCutscene")
      state = "active - fading"
      local function callback()
        if freezeFrame then
          state = "displayEndScreenCheck"
        else
          state = "zapToEndScreenVehicle"
        end
      end
      fades.down(callback, 0)
    elseif state == "doSlowDown" then
      debugOutput("doSlowDown")
      state = "active - doSlowDown"
      local callback = function()
        state = "zapToEndScreenVehicle"
      end
      if doesMissionHaveEndScreen then
        if params.rating == "PASS" then
          OneShotSound.Play("HUD_Mission_Complete_Music")
        else
          OneShotSound.Play("HUD_Mission_Fail_Music")
        end
      end
      if not cutscene or params.rating == "FAIL" then
        localPlayer.simulationSupport.doSlowDown(callback)
      else
        callback()
      end
    elseif state == "zapToEndScreenVehicle" then
      debugOutput("zapToEndScreenVehicle")
      debugOutput("zapToEndScreenVehicle = " .. tostring(zapToEndScreenVehicle))
      debugOutput("params.driverIsTanner = " .. tostring(params.driverIsTanner))
      debugOutput("params.vehicle ~= localPlayer.currentVehicle = " .. tostring(params.vehicle ~= localPlayer.currentVehicle))
      debugOutput("localPlayer.inZap = " .. tostring(localPlayer.inZap))
      debugOutput("spoolsystem.IsLocationResident = " .. tostring(spoolsystem.IsLocationResident(params.vehicle.position)))
      if zapToEndScreenVehicle then
        if params.driverIsTanner then
          if params.vehicle ~= localPlayer.currentVehicle or localPlayer.inZap then
            if not localPlayer.inZap then
              localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
            end
            localPlayer:zapToAgent(params.vehicle, {disableZapFlash = true})
            state = "waitForReturnZap"
          else
            state = "displayEndScreenCheck"
          end
        elseif params.vehicle ~= localPlayer.currentVehicle or localPlayer.inZap then
          if spoolsystem.IsLocationResident(params.vehicle.position) then
            if not localPlayer.inZap then
              localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
            end
            localPlayer:SetZapLevel(0, params.vehicle, true, {disableZapFlash = true})
            state = "displayEndScreenCheck"
          else
            state = "fadeForSpooling"
          end
        else
          state = "displayEndScreenCheck"
        end
      else
        state = "displayEndScreenCheck"
      end
    elseif state == "fadeForSpooling" then
      debugOutput("fadeForSpooling")
      state = "fadeForSpooling - active"
      local callback = function()
        state = "waitForEndScreenVehicleSpooling"
      end
      fades.down(callback)
    elseif state == "waitForEndScreenVehicleSpooling" then
      debugOutput("waitForEndScreenVehicleSpooling")
      state = "spoolEndLocation - active"
      local function callback()
        local settings = {
          matricesOnly = true,
          type = "Generic",
          position = params.vehicle.position,
          heading = params.vehicle.heading,
          vehicles = {}
        }
        settings.vehicles[1] = {
          modelID = params.vehicle.gameVehicle.model_id,
          trailerID = params.vehicle.gameVehicle.childVehicle and params.vehicle.gameVehicle.childVehicle.model_id
        }
        local tableOfMatrices = challengeSystem.createActors(settings)
        params.vehicle:teleport(tableOfMatrices[1])
        localPlayer:SetZapLevel(0, params.vehicle, true, {disableZapFlash = true})
        state = "displayEndScreenCheck"
      end
      if params.vehicle then
        loadingSystem.requestSpoolPosition(params.vehicle.position, params.vehicle.heading)
      end
      loadingSystem.triggerLoadRequest("Loading Challenge Data", callback)
    elseif state == "waitForReturnZap" then
      debugOutput("waitForReturnZap")
      state = "waitForReturnZap - active"
      addUserUpdateFunction("Put off end screen until zap finished", function()
        if not localPlayer.zapReturning then
          state = "displayEndScreenCheck"
          removeUserUpdateFunction("Put off end screen until zap finished")
        end
      end, 1)
      Commentary.StopCommentary()
    elseif state == "displayEndScreenCheck" then
      debugOutput("displayEndScreenCheck")
      state = "setDriver"
      if params.rating ~= "FAIL" then
        if not doesMissionHaveEndScreen then
          forceContinue(instance, params)
          state = "finished"
        end
      else
        GameplayTracking.OnMissionFail(params.failReason)
      end
    elseif state == "setDriver" then
      debugOutput("setDriver")
      player.setAttachment(localPlayer.localID, params.vehicle.gameVehicle, not params.driverIsTanner)
      PropSystem.RemoveOverlappingFragments({
        gameVehicle = params.vehicle.gameVehicle
      })
      GameVehicleResource.upgradeOccupants(params.vehicle.gameVehicle)
      state = "fadeUp"
    elseif state == "fadeUp" then
      debugOutput("fadeUp")
      if doesMissionHaveEndScreen then
        fades.up(nil, 0)
        if params.rating == "PASS" then
          OneShotSound.Play("HUD_Mission_Complete_Music")
        end
      end
      state = "displayEndScreen"
    elseif state == "displayEndScreen" then
      debugOutput("displayEndScreen")
      state = "finished"
      runEndScreen(instance, params)
    elseif state == "finished" then
      state = "inactive"
      removeUserUpdateFunction("endScreenLoading")
      debugOutput("============ | DONE")
    end
  end
end
function cleanup(params)
  PauseMenu.allow(true)
  if params.mission.ID ~= "Epilogue pt 2" or params.rating == "FAIL" then
    localPlayer:exitCutsceneMode()
  end
  CameraSystem.ClearScene()
  if params.rating == "FAIL" then
    feedbackSystem.menusMaster.masterSetVariable("iActivity_Failed", 0)
    OneShotSound.Play("HUD_Mission_Fail_Outro")
  else
    feedbackSystem.menusMaster.masterSetVariable("iActivity_Complete", 0)
    OneShotSound.Play("HUD_Mission_Complete_Outro")
    Sound.EnableScoring("WillpowerBank", false)
  end
  feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Popup", 0)
  feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Popup_Reward", 0)
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle", 0)
  OneShotSound.Play("GUI_EndScreenExit_OneShot", false)
  Commentary.StopCommentary()
  Commentary.BlockAI(false)
  if params.callback then
    params.callback()
  end
  if params.vehicle and params.vehicle.debugRequiredVehicles then
    params.vehicle:setDebugRequiredVehicles(false)
  end
  localPlayer.challenge:setShowingEndScreen(false)
  feedbackSystem.menusMaster.allowUnlockPanel(true)
end
function forceContinue(instance, params)
  localPlayer.challenge.setRetryingMission(false)
  progressionSystem.clearSoftSave()
  cleanup(params)
end
function continue(instance, params)
  feedbackSystem.previewScreen.startMissionFromHotspot = false
  forceContinue(instance, params)
end
function retry(instance, params)
  localPlayer.challenge.setRetryingMission(true)
  if params.rating == "PASS" then
    progressionSystem.clearSoftSave()
  end
  cleanup(params)
  progressionSystem.forceStartMission(params.mission.ID, true, instance.fromInWorld)
end
function missionEndScreenButtons(params)
  endMission = false
  endScreenOptionSelected = false
  local selectionMade = false
  controlHandler:resetState("missionComplete")
  controlHandler:removeState("missionComplete", localPlayer.localID)
  feedbackSystem.menusMaster.masterSetTextVariable("Activity_toggle_top", "ID:243634")
  if missionLaunchedFromFrontEnd then
    feedbackSystem.menusMaster.masterSetTextVariable("Activity_toggle_bottom", "ID:221041")
  else
    feedbackSystem.menusMaster.masterSetTextVariable("Activity_toggle_bottom", "ID:221108")
  end
  if params.blockRetry then
    endMission = true
    feedbackSystem.menusMaster.masterSetTextVariable("Activity_toggle_top", "ID:221108")
  elseif params.blockContinue then
    endMission = false
    feedbackSystem.menusMaster.masterSetTextVariable("Activity_toggle_top", "ID:242705")
  elseif params.rating ~= "FAIL" then
    endMission = true
    if missionLaunchedFromFrontEnd then
      feedbackSystem.menusMaster.masterSetTextVariable("Activity_toggle_top", "ID:221041")
    else
      feedbackSystem.menusMaster.masterSetTextVariable("Activity_toggle_top", "ID:221108")
    end
    feedbackSystem.menusMaster.masterSetTextVariable("Activity_toggle_bottom", "ID:243634")
  end
  local function menuSelectionUp()
    if not selectionMade then
      if params.rating ~= "FAIL" then
        if not endMission then
          endMission = true
          OneShotSound.Play("Menu_Move", false)
          feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 1)
        end
      elseif endMission then
        endMission = false
        OneShotSound.Play("Menu_Move", false)
        feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 1)
      end
    end
  end
  local function menuSelectionDown()
    if not selectionMade then
      if params.rating ~= "FAIL" then
        if endMission then
          endMission = false
          OneShotSound.Play("Menu_Move", false)
          feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 2)
        end
      elseif not endMission then
        endMission = true
        OneShotSound.Play("Menu_Move", false)
        feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 2)
      end
    end
  end
  if not params.blockRetry and not params.blockContinue then
    feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Type", 2)
    controlHandler:registerState(localPlayer.localID, "missionComplete", {
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
              if endMission then
                if params.rating ~= "FAIL" then
                  feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 3)
                else
                  feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 4)
                end
              elseif params.rating ~= "FAIL" then
                feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 4)
              else
                feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 3)
              end
              OneShotSound.Play("Menu_Select", false)
              CameraSystem.ContinueScene()
            end
          end
        }
      },
      Menu_ExtraFirst = {
        JustPressed = {
          [1] = function()
            local bOfflineMode = Menu.GetVariable("Master", "PC_OfflineMode")
            if params.mission.scoreType and not selectionMade and bOfflineMode == 0 and not feedbackSystem.leaderboard.leaderboardActive then
              selectionMade = true
              feedbackSystem.leaderboard.showLeaderboardPanel()
              feedbackSystem.leaderboard.setLeaderboardButtons(params.mission, function()
                missionEndScreenButtons(params)
              end)
              OneShotSound.Play("Menu_Select", false)
            end
          end
        }
      }
    })
  else
    feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Type", 1)
    controlHandler:registerState(localPlayer.localID, "missionComplete", {
      Menu_Select = {
        JustPressed = {
          [1] = function()
            if not selectionMade and not feedbackSystem.leaderboard.leaderboardActive then
              selectionMade = true
              CameraSystem.ContinueScene()
              feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle_Select", 3)
              OneShotSound.Play("Menu_Select", false)
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
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle", 1)
  controlHandler:setState("missionComplete")
end
function runEndScreen(instance, params)
  Menu.ClearCreditsList()
  local challengeName = instance.challenge.name
  if params.rating ~= "FAIL" then
    GameplayTracking.OnObjectiveStop(missionInfo[cards.ReverseMissionNetworkLookup[challengeName]].challengeTitle, params.type, "COMPLETE")
    if not missionHasEndScreen(params) then
      forceContinue(instance, params)
      return
    end
  else
    GameplayTracking.OnObjectiveStop(missionInfo[cards.ReverseMissionNetworkLookup[challengeName]].challengeTitle, params.type, params.failReason, "FAILURE")
    GameplayTracking.OnMissionFail(params.failReason)
  end
  player.setAttachment(localPlayer.localID, params.vehicle.gameVehicle, not params.driverIsTanner)
  PropSystem.RemoveOverlappingFragments({
    gameVehicle = params.vehicle.gameVehicle
  })
  GameVehicleResource.upgradeOccupants(params.vehicle.gameVehicle)
  if params.dialogue then
    feedbackSystem.eventFeedback(localPlayer.currentVehicle, params.dialogue, nil, "missionCritical")
  end
  local function doCameraCutscene()
    local vehicle = params.vehicle.gameVehicle
    local input, scene
    local buttonDelay = 4
    local willPowerDelay = 2.7
    local function endScreenLogic()
      OneShotSound.PlayMenuSound("HUD_Gen_ScreenFlash", false)
      if params.mission.scoreType then
        local statsTable = singlePlayerStatistics.getMissionStatisticsScoreTable()
        local previousBest = 0
        local showDefaultBest = false
        feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_2_title", "ID:245384")
        if params.mission.ID == "DriveToSurvive2" or params.mission.ID == "Survival" or params.mission.ID == "Big break 2" or params.mission.ID == "ChinatownDrift" or params.mission.ID == "Uplaych4" then
          if statsTable.startValue <= params.mission.defaultBest or statsTable.startValue == 0 then
            feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_2_title", "ID:245383")
            showDefaultBest = true
          end
        elseif statsTable.startValue >= params.mission.defaultBest or statsTable.startValue == 0 then
          feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_2_title", "ID:245383")
          showDefaultBest = true
        end
        feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_bar_3_title", "ID:245860")
        if showDefaultBest and params.mission.scoreType == "Score" then
          previousBest = params.mission.defaultBest
        elseif params.mission.scoreType == "Score" then
          previousBest = statsTable.startValue
        end
        if showDefaultBest and params.mission.scoreType == "Time" then
          previousBest = math.floor(params.mission.defaultBest) / 100
        elseif params.mission.scoreType == "Time" then
          previousBest = math.floor(statsTable.startValue) / 100
        end
        if previousBest ~= 0 then
          local mins, secs, milli = feedbackSystem.formatTime(previousBest)
          feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_minutes", mins)
          feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_seconds", secs)
          feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_milli", milli)
          feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_string", previousBest)
        else
          feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_minutes", "--")
          feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_seconds", "--")
          feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_milli", "--")
          feedbackSystem.menusMaster.masterSetTextVariable("Leaderboard_bar_2_string", "--")
        end
        feedbackSystem.menusMaster.masterSetTextVariable("Mission_panel_1_timer_colon", ":")
        feedbackSystem.menusMaster.masterSetTextVariable("Mission_panel_1_timer_dot", ".")
        feedbackSystem.menusMaster.masterSetTextVariable("Mission_panel_2_timer_colon", ":")
        feedbackSystem.menusMaster.masterSetTextVariable("Mission_panel_2_timer_dot", ".")
      end
      feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle", 0)
      if params.mission and feedbackSystem.previewScreen.mmPreviewSetup[params.mission.iconType] then
        feedbackSystem.menusMaster.masterSetVariable("iActivity_Type", feedbackSystem.previewScreen.mmPreviewSetup[params.mission.iconType].previewColour)
        feedbackSystem.menusMaster.masterSetVariable("iActivity_Icon", feedbackSystem.previewScreen.mmPreviewSetup[params.mission.iconType].iconType)
      end
      if params.rating == "FAIL" then
        local upgradeHints = {
          ["Lost race"] = {hint = "ID:246525", ID = 2},
          ["Busted"] = {hint = "ID:246526", ID = 2},
          ["Lost getaway"] = {hint = "ID:246527", ID = 2},
          ["Recharge"] = {hint = "ID:246528", ID = 3}
        }
        local alternateHint = upgradeHints[params.reason]
        if alternateHint then
          local function checkUpgrades(ability)
            local i = 0
            repeat
              if ProfileSettings.GetAbilityOwned(ability.ID, i) == 1 then
                i = i + 1
              elseif ProfileSettings.GetAbilityUnlocked(ability.ID, i) then
                params.hint = ability.hint
                return
              elseif ability.ID == 2 then
                checkUpgrades(upgradeHints.Recharge)
                return
              else
                return
              end
            until i == 3
          end
          if alternateHint.ID ~= 2 or abilities.isAbilityUnlocked("nitro", 1) then
            checkUpgrades(alternateHint)
          end
        end
        feedbackSystem.menusMaster.masterSetTextVariable("mission_failed_description", params.failReason or "NO FAIL CONDITION SET")
        feedbackSystem.menusMaster.masterSetTextVariable("focus_button_text_01", params.hint or "NO FAIL HINT SET OR YOU CHEAT COMPLETED")
        feedbackSystem.menusMaster.masterSetVariable("iActivity_Failed", 1)
        feedbackSystem.menusMaster.masterSetVariable("iActivity_Preview_Reward", 0)
        OneShotSound.Play("HUD_Mission_Fail_Intro")
      else
        feedbackSystem.menusMaster.masterSetTextVariable("mission_complete_description", params.successReason or "NO SUCCESS CONDITION SET")
        OneShotSound.Play("HUD_Mission_Complete_Intro")
        if not params.willpowerReward then
          feedbackSystem.menusMaster.masterSetVariable("iActivity_Preview_Reward", 0)
          willPowerDelay = 0.01
          buttonDelay = 0.01
        else
          feedbackSystem.menusMaster.masterSetVariable("iActivity_Preview_Reward", 1)
          feedbackSystem.menusMaster.masterSetTextVariable("reward", "ID:245865")
          feedbackSystem.menusMaster.masterSetTextVariable("reward_plus", "+")
          local activityWillPowerReward = progressionSystem.getChallengeWillpowerReward(params.mission.ID)
          feedbackSystem.menusMaster.masterSetTextVariable("Activity_willpower", feedbackSystem.menusMaster.setWillpowerComma(activityWillPowerReward))
          OneShotSound.Play("HUD_Mission_Complete_Intro_WP")
        end
        feedbackSystem.menusMaster.masterSetVariable("iActivity_Complete", 1)
        Sound.EnableScoring("WillpowerBank", true)
        if instance.accumulatedWillpower then
          feedbackSystem.menusMaster.masterSetTextVariable("Activity_willpower", instance.accumulatedWillpower)
        end
      end
      feedbackSystem.menusMaster.masterSetTextVariable("leaderboard_toggle", "")
      if params.mission.scoreType and params.mission.scoreType == "Score" then
        feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Popup", 2)
      elseif params.mission.scoreType then
        feedbackSystem.menusMaster.masterSetVariable("iLeaderboard_Popup", 1)
      end
    end
    scene = {
      {action = "behaviour", type = "ICam"},
      {
        action = "pauseSimulation",
        audioPauseEvent = "Simulation_Pause_MissionStatus",
        audioResumeEvent = "Simulation_Resume_MissionStatus"
      },
      {
        {action = "callback", callback = endScreenLogic},
        {
          action = "callback",
          callback = function()
            OneShotSound.PlayMenuSound("HUD_Gen_ScreenFlash", false)
          end
        },
        {
          action = "callback",
          callback = function()
            if params.rating ~= "FAIL" then
              scoreSystem.showStoredWillpowerReward()
            end
          end,
          afterDuration = willPowerDelay
        },
        {
          action = "callback",
          callback = function()
            missionEndScreenButtons(params)
          end,
          afterDuration = buttonDelay
        }
      },
      {infiniteLength = true},
      {duration = 0.3},
      {
        action = "callback",
        callback = function()
          if endMission then
            fades.down(function()
              continue(instance, params)
            end)
          else
            fades.down(function()
              retry(instance, params)
            end)
          end
          controlHandler:resetState("missionComplete")
          controlHandler:removeState("missionComplete", localPlayer.localID)
        end
      },
      {duration = 1},
      {
        action = "resumeSimulation"
      }
    }
    CutsceneScene = {
      {
        action = "pauseSimulation",
        audioPauseEvent = "Simulation_Pause_MissionStatus",
        audioResumeEvent = "Simulation_Resume_MissionStatus"
      },
      {
        {action = "callback", callback = endScreenLogic},
        {
          action = "callback",
          callback = function()
            OneShotSound.PlayMenuSound("HUD_Gen_ScreenFlash", false)
          end
        },
        {
          action = "callback",
          callback = function()
            if params.rating ~= "FAIL" then
              scoreSystem.showStoredWillpowerReward()
            end
          end,
          afterDuration = willPowerDelay
        },
        {
          action = "callback",
          callback = function()
            missionEndScreenButtons(params)
          end,
          afterDuration = buttonDelay
        }
      },
      {infiniteLength = true},
      {duration = 0.3},
      {
        action = "resumeSimulation"
      },
      {
        action = "callback",
        callback = function()
          if endMission then
            fades.down(function()
              engineCutscene.DisposeCutsceneManually(instance.challenge.missionEndCutscene, function()
                continue(instance, params)
              end)
            end)
          else
            fades.down(function()
              engineCutscene.DisposeCutsceneManually(instance.challenge.missionEndCutscene, function()
                retry(instance, params)
              end)
            end)
          end
          controlHandler:resetState("missionComplete")
          controlHandler:removeState("missionComplete", localPlayer.localID)
        end
      }
    }
    if localPlayer.cameraMode == "Bumper" then
      VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
    end
    if params.cutsceneEndScreen then
      CameraSystem.AddScene(CutsceneScene)
    else
      CameraSystem.AddScene(scene)
    end
  end
  doCameraCutscene()
end
function endScreen(instance, params)
  local params = params or {}
  Getaway.StopAll()
  if not localPlayer.challenge.showingEndScreen then
    params.mission, params.potID, params.subType, params.type = progressionSystem.findMissionInProgression(instance.challenge.name)
    local evidenceBoard = params.mission.evidenceBoard
    if evidenceBoard then
      EBoard.SetCurrentBoard(evidenceBoard)
    end
    if type(params.rating) == "number" or params.rating == "PERFECT" then
      print("Warning: Challenge " .. tostring(params.mission.ID) .. " attempted to award rating " .. tostring(params.rating) .. " - this is deprecated")
      if params.rating == 0 then
        params.rating = "FAIL"
      else
        params.rating = "PASS"
      end
    end
    if params.type ~= "progressionTutorial" then
      params.willpowerReward = false
      if progressionSystem.getChallengeWillpowerReward(params.mission.ID) then
        params.willpowerReward = true
      end
    end
    if params.rating == "PASS" then
      if instance.challenge.name == "Epilogue pt 2" then
        print("Presence set to Just Completed Chapter " .. tostring(8))
        presenceSystem.setPresence(11, 8)
      end
      if params.type == "challenge" then
        checkChallengeTime(params)
      end
      progressionSystem.saveOnMissionComplete(instance)
    else
      progressionSystem.saveGame("When failing a mission " .. instance.challenge.name)
    end
    if params.type == "challenge" or params.type == "activity" then
      params.isChallenge = true
    end
    if localPlayer.currentVehicle and localPlayer.currentVehicle.abilityActive then
      localPlayer.currentVehicle:cancelAbility(localPlayer.localID)
    end
    Sound.OnAbilityButtonReleased(nil, "Ram", 0)
    Sound.OnAbilityButtonReleased(nil, "Nitro", 0)
    Sound.OnAbilityButtonReleased(nil, "Ram", 1)
    Sound.OnAbilityButtonReleased(nil, "Nitro", 1)
    Commentary.BlockAI(true)
    if params.isChallenge then
      feedbackSystem.stopFreeDriveMusic()
    end
    if params.type ~= "progressionTutorial" then
      localPlayer:enterCutsceneMode()
      PauseMenu.allow(false)
      PIP.Deactivate()
      Commentary.StopCommentary()
      if not params.keepMusicTrackRunning then
        feedbackSystem.stopMusic()
      end
      feedbackSystem.menusMaster.clearAllTextPrompts()
      if params.vehicle then
        params.vehicle:setDebugRequiredVehicles(true)
      end
      params.flow = params.flow or {}
      params.awarded = {}
      if not params.isChallenge then
        if params.subType == "storyMission" and not missionLaunchedFromFrontEnd then
          if params.rating == "FAIL" then
            params.blockContinue = true
          else
            params.blockRetry = true
          end
        else
          local chapter = challengeProgressionTable[params.potID].settings.chapter
          if chapter and chapter == 0 then
            if params.rating == "FAIL" then
              params.blockContinue = true
            else
              params.blockRetry = true
            end
          end
        end
      end
      localPlayer.challenge:setShowingEndScreen(true)
      feedbackSystem.menusMaster.allowUnlockPanel(false)
    end
  end
end
