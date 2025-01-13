module("dareSystem", package.seeall)
activeDare = false
promptingDareRetry = false
resettingDare = false
local currentBillboard = false
local preventDupes = false
local dareHintPrompt = false
isInBillboardScene = false
dareHintActive = false
dareCompleteScreenActive = false
local billboardMarkers = {}
local billboardMarkersVisible = false
local activeDareMarkers = false
local initialiseDelayed = false
local numberOfDaresCompleted = 0
local dareProgressBar = {
  slot = 2,
  value = 0,
  title = "",
  barTitle = "ID:245954"
}
local timerTable = {slot = 3}
local dareStartTime
narrativeBillboardTexture = {
  [4] = "CLOSE_CALL",
  [5] = "DO_IT_AGAIN",
  [9] = "EXPLORE",
  [10] = "GET_YOUR_BEARINGS",
  [11] = "CONNECT_THE_DOTS",
  [12] = "INVESTIGATE",
  [13] = "HURRY_UP",
  [14] = "WATCH_YOUR_BACK",
  [15] = "ENDGAME",
  [16] = "ON_YOUR_OWN",
  [62] = "DO_IT_TANNER"
}
function isDareActive()
  return activeDare and activeDare.active
end
function isDareSuspended()
  return activeDare and not activeDare.active
end
function initialiseDareLocalisation()
  for uid, dare in next, daresByUID, nil do
    if dare.params then
      for __, goals in ipairs(dare.goals) do
        for __, goal in ipairs(goals) do
          if goal.params then
            for k, v in next, goal.params, nil do
              if dare.params[v] then
                print(tostring(v) .. " = " .. tostring(dare.params[v]))
                if v == "speed" then
                  goal.params.targetDisplaySpeed, goal.params[k] = feedbackSystem.mphToLocalisedSpeed(dare.params[v])
                  dare.params.targetDisplaySpeed = goal.params.targetDisplaySpeed
                else
                  goal.params[k] = dare.params[v]
                end
              end
            end
            if dare.timer then
              if dare.params.time then
                dare.timer = dare.params.time
              else
                print("WARNING: NO VARIABLE TIME SET FOR TIMED DARE " .. tostring(uid))
              end
            end
          end
        end
      end
    end
  end
end
addInitObject(initialiseDareLocalisation)
function getNumberCompletedDares()
  return numberOfDaresCompleted
end
local dareAllowed = function()
  local allowed = false
  if not gameStatus.onlineSession and not localPlayer.inZap and not localPlayer.challenge.showingEndScreen and not localPlayer.inCutscene and not vehicleManager.previewVehicleManager.previewVehicle then
    local currentChapter = progressionSystem.getCurrentChapter()
    local localPlayerTaskObject = localPlayer:getTaskObject()
    if (currentChapter > 0 and currentChapter < 8 or currentChapter == 10) and not localPlayerTaskObject or currentChapter == 0 then
      allowed = true
    end
  end
  return allowed
end
function dareUnlockCheck(chapter)
  if daresByChapter[chapter] then
    for uid, dare in next, daresByChapter[chapter], nil do
      if not ProfileSettings.GetDareUnlocked(uid) then
        ProfileSettings.SetDareUnlocked(uid)
        activeChallenges.registerActivity(dare, "Dare")
      end
    end
  end
end
local order = {
  [1] = "distance",
  [2] = "quantity",
  [3] = "targetDisplaySpeed",
  [4] = "time"
}
function unpackParams(params)
  local returnValues = {}
  if params then
    for __, param in ipairs(order) do
      if params[param] then
        table.insert(returnValues, params[param])
      end
    end
  end
  return unpack(returnValues)
end
function createDare(dare, restartDare, reactivation)
  if activeDare and not reactivation then
    abortActiveDare(restartDare)
  end
  GameplayTracking.OnObjectiveStart()
  print("Presence set to Taking On A Dare")
  presenceSystem.setPresence(10, 142)
  resettingDare = false
  for index, dareGoal in next, dare.goals[1], nil do
    if (dareGoal.goal == "Prompted if in invalid camera mode" or dareGoal.goal == "Is player camera") and not isInCorrectCameraMode(dareGoal.params.value) or dareGoal.goal == "Dare number of props smashed" and dareGoal.params.inCameraMode and not isInCorrectCameraMode(dareGoal.params.inCameraMode) then
      if not localPlayer.inZap then
        if dareGoal.params.value ~= "ThrillCam" then
          setActiveCamera("DriverEye", localPlayer.localID)
          break
        end
        if abilities.thrillCam.getActiveLevel() then
          setActiveCamera("ThrillCam", localPlayer.localID)
        end
        break
      end
      if dareGoal.params.value ~= "ThrillCam" then
        localPlayer.cameraMode = "DriverEye"
        break
      end
      if abilities.thrillCam.getActiveLevel() then
        localPlayer.cameraMode = "ThrillCam"
      end
      break
    end
  end
  dare.agent = localPlayer.currentVehicle
  localPlayer.currentVehicle.gameVehicle.softness = 1
  dare.active = true
  activeDare = dare
  felony_patrollingVehicleManager.enablePatrollingVehicles(false)
  felony_suspiciousVehicleManager.enableSuspiciousVehicles(false)
  progressionSystem.setTrafficEvents(false)
  tannerNarration.startNarrationManager()
  feedbackSystem.menusMaster.updateFreedriveHintText()
  feedbackSystem.updateScrollingText({
    slot = 1,
    text = dare.objective,
    iconType = dare.type,
    delimits = {
      [6] = unpackParams(dare.params)
    }
  })
  dareProgressBar.value = 0
  feedbackSystem.removeSlot(2)
  feedbackSystem.updateProgressBar(dareProgressBar)
  timerTable.startTime = nil
  if dare.allowJumpSound then
    Sound.EnableScoring("jump", true)
  else
    Sound.EnableScoring("jump", false)
  end
  if dare.allowDriftSound then
    Sound.EnableScoring("drift", true)
  else
    Sound.EnableScoring("drift", false)
  end
  if dare.timer then
    timerTable.startTime = dare.timer
  end
  for i, goals in ipairs(dare.goals) do
    for j, goal in ipairs(goals) do
      if goal.feedback then
        dare.increment = 100 / (goal.params.value or 1)
        break
      end
    end
  end
  goalSystem.dareSupport.createDareGoals(dare)
end
local dareCompleteText = {
  speed = "ID:245807",
  stunt = "ID:245808",
  control = "ID:245809"
}
local function saveOnDareComplete(dare)
  if not ProfileSettings.GetDareCompleted(dare.uid) then
    scoreSystem.willpowerReward(willpowerRewards.dares[dare.chapter], dare.iconType, true)
    numberOfDaresCompleted = numberOfDaresCompleted + 1
    abilityUnlockCheck(false, numberOfDaresCompleted)
    ProfileSettings.SetDareCompleted(dare.uid, dare.type)
  end
  GameplayTracking.OnObjectiveStop(dare.uid, "dare", "COMPLETE", "COMPLETE")
  if not ProfileSettings.GetToolTipShown(toolTipLookupTable["Completed a dare"]) then
    ProfileSettings.SetToolTipShown(toolTipLookupTable["Completed a dare"])
  end
  progressionSystem.saveGame("When you complete a dare")
end
local showWillpowerReward = function()
  removeUserUpdateFunction("rewardDelay")
  scoreSystem.showStoredWillpowerReward()
end
function hideDareCompleteScreen(previewActive)
  removeUserUpdateFunction("clearDareEndScreen")
  if userUpdateFunctions.rewardDelay then
    showWillpowerReward()
  end
  if not previewActive then
    feedbackSystem.menusMaster.masterSetVariable("iActivity_Complete", 0)
  end
  OneShotSound.Play("HUD_Mission_Complete_Outro", false)
  if not localPlayer.inCutscene then
    localPlayer:showHUDElements(true)
  end
  feedbackSystem.removeSlot(1)
  feedbackSystem.removeSlot(dareProgressBar.slot)
  feedbackSystem.removeSlot(timerTable.slot)
  Sound.ExitAudioState("DareComplete")
  dareCompleteScreenActive = false
  feedbackSystem.menusMaster.allowUnlockPanel(true)
end
local function showDareCompleteScreen(dare)
  Sound.EnterAudioState("DareComplete", "Dare_Complete_Fade_Intro", "Dare_Complete_Fade_Outro")
  dareCompleteScreenActive = true
  localPlayer:showHUDElements(false)
  feedbackSystem.menusMaster.masterSetTextVariable("mission_complete_description", dareCompleteText[dare.type])
  feedbackSystem.menusMaster.masterSetTextVariable("reward", "ID:245865")
  feedbackSystem.menusMaster.masterSetTextVariable("reward_plus", "+")
  feedbackSystem.menusMaster.masterSetTextVariable("Activity_willpower", feedbackSystem.menusMaster.setWillpowerComma(willpowerRewards.dares[dare.chapter]))
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Preview_Reward", 1)
  feedbackSystem.menusMaster.allowUnlockPanel(false)
  if feedbackSystem.previewScreen.mmPreviewSetup[dare.iconType] then
    feedbackSystem.menusMaster.masterSetVariable("iActivity_Type", feedbackSystem.previewScreen.mmPreviewSetup[dare.iconType].previewColour)
    feedbackSystem.menusMaster.masterSetVariable("iActivity_Icon", feedbackSystem.previewScreen.mmPreviewSetup[dare.iconType].iconType)
  end
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Complete", 1)
  OneShotSound.Play("HUD_Mission_Complete_Intro", false)
  OneShotSound.Play("HUD_Mission_Complete_Intro_WP", false)
  addUserUpdateFunction("rewardDelay", showWillpowerReward, 2 * updates.stepRate, true)
  addUserUpdateFunction("clearDareEndScreen", hideDareCompleteScreen, 5 * updates.stepRate, true)
end
function dareComplete(dare)
  Sound.EnableScoring("jump", false)
  Sound.EnableScoring("drift", false)
  scoringSystem.SetDareDriftBarProgression(localPlayer.localID, false, goalDistance)
  scoringSystem.SetDareJumpBarProgression(localPlayer.localID, false, goalDistance, true)
  scoringSystem.UpdateDriftStuntText = false
  scoringSystem.UpdateJumpStuntText = false
  goalSystem.dareSupport.removeDareGoals(dare)
  showDareCompleteScreen(dare)
  saveOnDareComplete(dare)
  activeDare = false
  dare.active = false
  felony_patrollingVehicleManager.enablePatrollingVehicles(true)
  felony_suspiciousVehicleManager.enableSuspiciousVehicles(true)
  progressionSystem.setTrafficEvents(true)
  print("Presence set to FREEDRIVE")
  presenceSystem.setPresence(9)
end
function cheatCompleteDare()
  if activeDare then
    dareComplete(activeDare)
  end
end
function suspendActiveDare(delete, restartDare)
  if activeDare then
    activeDare.active = false
    goalSystem.dareSupport.removeDareGoals(activeDare)
    feedbackSystem.removeSlot(1)
    feedbackSystem.removeSlot(dareProgressBar.slot)
    feedbackSystem.removeSlot(timerTable.slot)
    removeUserUpdateFunction("timerEndDare")
    if delete then
      if not restartDare then
        activeChallenges.registerActivity(activeDare, "Dare")
        felony_patrollingVehicleManager.enablePatrollingVehicles(true)
        felony_suspiciousVehicleManager.enableSuspiciousVehicles(true)
        progressionSystem.setTrafficEvents(true)
      end
      activeDare = false
      feedbackSystem.menusMaster.updateFreedriveHintText()
    end
  end
  Sound.EnableScoring("jump", false)
  Sound.EnableScoring("drift", false)
  scoringSystem.SetDareDriftBarProgression(localPlayer.localID, false, goalDistance)
  scoringSystem.SetDareJumpBarProgression(localPlayer.localID, false, goalDistance, true)
  scoringSystem.UpdateDriftStuntText = false
  scoringSystem.UpdateJumpStuntText = false
  if initialiseDelayed then
    initialiseDelayed = false
  end
end
function abortActiveDare(restartDare)
  if activeDare then
    GameplayTracking.OnObjectiveStop(activeDare.uid, activeDare.type, "ABANDONED", "ABANDONED")
  end
  suspendActiveDare(true, restartDare)
  feedbackSystem.menusMaster.focusHintButtonState(true)
end
function reactivateSuspendedDare()
  if activeDare and not activeDare.active then
    createDare(activeDare, true)
  end
end
function initialiseSavedDare()
  numberOfDaresCompleted = 0
  for uid, dare in next, daresByUID, nil do
    if ProfileSettings.GetDareCompleted(uid) then
      daresByUID[uid].completed = true
      if uid ~= 2 then
        numberOfDaresCompleted = numberOfDaresCompleted + 1
      end
    end
  end
  Menu.SetDareData(daresByUID)
end
function hideDarePrompts(status)
  if status then
    feedbackSystem.menusMaster.masterSetVariable("iDare_Prompt", 0)
  elseif dareAllowed() and initialiseDelayed then
    initialiseSavedDare()
  end
end
function checkIfInHotspot()
  local data = feedbackSystem.previewScreen.activityBeingPrompted
  if data then
    if data.hotspotType == "garage" then
      if localPlayer.inZap then
        feedbackSystem.previewScreen.showPreview("shiftHotspotPreview", data.ID)
      else
        feedbackSystem.previewScreen.showGaragePrompt()
      end
    elseif localPlayer.inZap then
      if data.hotspotType == "dare" then
        feedbackSystem.previewScreen.showPreview("shiftHotspotPreview", activeChallenges.activitiesHotspots[data.activityIndex])
      else
        feedbackSystem.previewScreen.showPreview("shiftHotspotPreview", activeChallenges.activitiesHotspots[data.activityIndex].ID)
      end
    else
      feedbackSystem.previewScreen.displayActivityPrompt(activeChallenges.activitiesHotspots[data.activityIndex])
    end
  end
end
function endDare()
  promptingDareRetry = false
  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  abortActiveDare(false)
  feedbackSystem.menusMaster.blockHintButton(false)
  removeUserUpdateFunction("endDare")
  checkIfInHotspot()
end
function feedbackCallbackHACK(dare, feedback)
  if feedback and dare.increment then
    dareProgressBar.value = feedback * dare.increment
    feedbackSystem.updateProgressBar(dareProgressBar)
    if dare.timer then
      if feedback > 0 then
        if not userUpdateFunctions.timerEndDare and not feedbackSystem.previewScreen.previewScreenActive and not vehicleManager.previewVehicleManager.previewVehicle then
          local function timerEndDare()
            if g_NetworkTime - dareStartTime >= dare.timer then
              if not dare.timerComplete then
                promptingDareRetry = true
                local data = feedbackSystem.previewScreen.activityBeingPrompted
                if data then
                  if data.hotspotType == "garage" then
                    if localPlayer.inZap then
                      feedbackSystem.previewScreen.hideZapPreview()
                    else
                      feedbackSystem.previewScreen.hideGaragePrompt()
                    end
                  elseif localPlayer.inZap then
                    feedbackSystem.previewScreen.hideZapPreview()
                  else
                    feedbackSystem.previewScreen.hideActivityPrompt(true)
                  end
                end
                suspendActiveDare(false, true)
                if not ProfileSettings.GetToolTipShown(toolTipLookupTable["Completed a dare"]) and (configSelector.launchConfig.Name == "Single Player" or configSelector.launchConfig.Name == "Post Debrief") then
                  resettingDare = true
                  reactivateSuspendedDare()
                else
                  feedbackSystem.menusMaster.primaryTextPrompt("ID:245955", false, false, true, false, localPlayer.buttonLayout.focusButton)
                  feedbackSystem.menusMaster.blockHintButton(true)
                  addUserUpdateFunction("endDare", endDare, 600, true)
                end
                GameplayTracking.OnObjectiveStop(dare.uid, "dare", "FAILURE", "FAILURE")
                OneShotSound.Play("HUD_Bar_Progress_Reset", false)
              end
              removeUserUpdateFunction("timerEndDare")
            end
          end
          addUserUpdateFunction("timerEndDare", timerEndDare, 5, true)
          dareStartTime = g_NetworkTime
        end
        feedbackSystem.stepTimer(timerTable)
      else
        feedbackSystem.removeSlot(timerTable.slot)
      end
    end
  else
    dareProgressBar.value = 0
    feedbackSystem.updateProgressBar(dareProgressBar)
    feedbackSystem.removeSlot(timerTable.slot)
    removeUserUpdateFunction("timerEndDare")
  end
end
function setDareHint(showHighlight)
  if dareSystem.activeDare then
    params = {}
    dareHint = {}
    params = {
      [4] = dareSystem.unpackParams(dareSystem.activeDare.params)
    }
    if next(params) == nil then
      dareHint = {
        dareSystem.activeDare.hint,
        0
      }
    else
      dareHint = {
        dareSystem.activeDare.hint,
        #params,
        params[1],
        params[2],
        params[3]
      }
    end
    feedbackSystem.menusMaster.setHintText(dareHint, showHighlight)
  end
end
function dareGoalComplete(dare)
  removeUserUpdateFunction("timerEndDare")
  dareComplete(dare)
end
function _G.billboardAvailable(uid)
  return false
end
function clearTimer()
  timerTable.slot = 3
  timerTable.pause = nil
  timerTable.startTime = nil
end
function resetTimer()
  timerTable.slot = 3
  timerTable.pause = false
  timerTable.startTime = dareSystem.activeDare.timer
  timerTable.reset = true
  feedbackSystem.stepTimer(timerTable)
  timerTable.reset = false
end
function setTimePassed(timePassed)
  timerTable.startTime = dareSystem.activeDare.timer - timePassed
end
function pauseTimer()
  timerTable.pause = true
end
function unpauseTimer()
  timerTable.pause = false
end
function dareGoalComplete(dare)
  removeUserUpdateFunction("timerEndDare")
  dareComplete(dare)
end
