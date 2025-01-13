module("felony_chase", package.seeall)
local promptTable = {
  counter = true,
  priority = 1,
  felony = true
}
local iCamParams = {
  duration = 3,
  speed = 0.5,
  framing = "wide",
  angleyaw = "rear",
  hudParams = {prompts = true, willpowerRewards = true}
}
goalCallbacks = {}
function registerGoalCallback(callback, type)
  goalCallbacks[type] = goalCallbacks[type] or {}
  goalCallbacks[type][#goalCallbacks[type] + 1] = callback
end
function unregisterGoalCallback(callback, type)
  if goalCallbacks[type] then
    local remove = false
    for i, storedCallback in ipairs(goalCallbacks[type]) do
      if storedCallback == callback then
        remove = i
        break
      end
    end
    if remove then
      table.remove(goalCallbacks[type], remove)
    end
  end
end
local unregisterAllGoalCallbacks = function()
  goalCallbacks = {}
end
local CopTimeTriggerCount = 0
function chaseOngoingAudioFeedback()
  return function()
    CopTimeTriggerCount = CopTimeTriggerCount + 1
    if CopTimeTriggerCount == 20 then
      if localPlayer.currentVehicle and Chase.IsAChaser(localPlayer.currentVehicle.gameVehicle) then
        Commentary.TriggerEvent("CopTime", nil, nil, 0, true)
      end
      CopTimeTriggerCount = 0
    end
  end
end
local lastCopRamTime = 0
function getawayCollsionCallback(collisionData)
  if g_NetworkTime - lastCopRamTime < 5 then
    return
  end
  if collisionData and collisionData.GameVehicle and collisionData.CollidedGameVehicle and collisionData.GameVehicle.damage < 1 and collisionData.GameVehicleResponsibleForCollision ~= collisionData.GameVehicle and localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle == collisionData.CollidedGameVehicle and Chase.IsAChaser(localPlayer.currentVehicle.gameVehicle) then
    Commentary.TriggerEvent("CopRam", nil, nil, 0, true)
    CopTimeTriggerCount = 0
    lastCopRamTime = g_NetworkTime
  end
end
local workingVector = vec.vector()
local promptDistance = 150
local losingRadius = 350
local function doRapidShiftPrompt(getawayGameVehicle)
  local numZapReturns = ProfileSettings.GetNumZapReturns()
  local playerDistance, teamMate, teamMateDistance
  local showingReturnPrompt = false
  return function()
    numZapReturns = ProfileSettings.GetNumZapReturns()
    if localPlayer.zapReturning then
      feedbackSystem.menusMaster.clearSecondaryTextPrompt()
    end
    if numZapReturns > 30 then
      removeUserUpdateFunction("doRapidShiftPrompt")
      return
    elseif localPlayer.currentVehicle then
      playerDistance = workingVector:sub(localPlayer.currentVehicle.position, getawayGameVehicle.position):length()
      if playerDistance > promptDistance and playerDistance < losingRadius then
        teamMate = Chase.GetZapReturnChaser()
        if teamMate then
          teamMateDistance = GameVehicleResource.withinRadius(teamMate.position, getawayGameVehicle.position, playerDistance)
          if teamMateDistance and not feedbackSystem.menusMaster.primaryPromptActive and not feedbackSystem.menusMaster.secondaryPromptActive and not showingReturnPrompt then
            feedbackSystem.menusMaster.secondaryTextPrompt("ID:234447", nil, false, false, true, localPlayer.buttonLayout.zapReturn, function()
              showingReturnPrompt = false
            end, {
              button = "Zap_Return",
              pressType = "JustPressed"
            })
            showingReturnPrompt = true
          end
        end
      elseif showingReturnPrompt then
        feedbackSystem.menusMaster.clearSecondaryTextPrompt()
        showingReturnPrompt = false
      end
    end
  end
end
local showStartPrompt = function()
  feedbackSystem.menusMaster.primaryTextPrompt("ID:178462")
end
function started(getawayGameVehicle)
  if not localPlayer:getTaskObject() then
    if not ProfileSettings.GetFreeDriveFelonyTutorialPlayed() then
      CutsceneFiles.tutorials.playTutorial("ID:243884", nil, function()
        showStartPrompt()
        ProfileSettings.SetFreeDriveFelonyTutorialPlayed(true)
        felony_feedback.setupFelonyHUD()
        GameVehicleResource.setDisableAllDamage(getawayGameVehicle, false)
        if localPlayer.primaryFelony.chasers[1] then
          GameVehicleResource.setDisableAllDamage(localPlayer.primaryFelony.chasers[1], false)
        end
      end)
    else
      showStartPrompt()
      local function callback()
        felony_feedback.setupFelonyHUD()
        GameVehicleResource.setDisableAllDamage(getawayGameVehicle, false)
        if localPlayer.primaryFelony.chasers[1] then
          GameVehicleResource.setDisableAllDamage(localPlayer.primaryFelony.chasers[1], false)
        end
        iCamParams.callbackFunction = nil
      end
      iCamParams.callbackFunction = callback
      iCamParams.cameraTargets = {getawayGameVehicle}
      iCamActivationTableInput(iCamParams)
    end
    print("Presence set to Trying To Takedown A Getaway")
    presenceSystem.setPresence(7)
    localPlayer:clearPreviousVehicle()
    feedbackSystem.menusMaster.updateFreedriveHintText()
  end
  Commentary.TriggerEvent("CopJoin", nil, nil, 0, false)
  if localPlayer.primaryFelony.settings.chaseMode == "Cop" then
    OneShotSound.Play("HUD_Fel_Gained")
  end
  CopTimeTriggerCount = 0
  lastCopRamTime = g_NetworkTime
  addUserUpdateFunction("chaseOngoing", chaseOngoingAudioFeedback(), 120)
  if isAbilityUnlocked("zapReturn") then
    addUserUpdateFunction("doRapidShiftPrompt", doRapidShiftPrompt(getawayGameVehicle), 120)
  end
  collision_system.RegisterCollisionCallback(getawayGameVehicle, getawayCollsionCallback)
end
function ended(getawayGameVehicle)
  removeUserUpdateFunction("chaseOngoing")
  removeUserUpdateFunction("doRapidShiftPrompt")
  removeUserUpdateFunction("escapeCountdown")
  removeUserUpdateFunction("warningCountdown")
  felony_patrollingVehicleManager.setSpawningModels()
  local agent = vehicleManager.getAgentFromGameVehicle(getawayGameVehicle)
  if agent then
    localPlayer.clearFreedriveMarkers(agent)
  end
  local waitUntilNotBusy = function(callback)
    return function()
      if not localPlayer.inCutsceneOrIcam then
        if callback then
          callback()
        end
        removeUserUpdateFunction("busyWait")
      end
    end
  end
  if not localPlayer:getTaskObject() then
    local function callback()
      activeChallenges.enableActivities()
      felony_suspiciousVehicleManager.enableSuspiciousVehicles(true)
      local agent = vehicleManager.vehiclesByGameVehicle[getawayGameVehicle]
      if agent then
        agent:setDebugRequiredVehicles(false)
      end
    end
    addUserUpdateFunction("busyWait", waitUntilNotBusy(callback), 1)
    getawayGameVehicle.softness = 1
    localPlayer:clearFelony(getawayGameVehicle)
    felony_feedback.endFelony(false)
    localPlayer.missionSupport.setFreedriveMode()
    presenceSystem.setPresence(9)
    feedbackSystem.menusMaster.updateFreedriveHintText()
    localPlayer:buildZapReturn()
    felony_suspiciousVehicleManager.enableSuspiciousVehicles(false)
  end
  collision_system.UnRegisterCollisionCallback(getawayGameVehicle, getawayCollsionCallback)
  takeOwnershipOfActivityGameVehicle()
end
function leftChaseArea(getawayGameVehicle)
  removeUserUpdateFunction("escapeCountdown")
  removeUserUpdateFunction("warningCountdown")
  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  feedbackSystem.menusMaster.primaryTextPromptParam({
    prompt = "ID:245234",
    priority = 1,
    delayTime = 3
  })
  if not localPlayer:getTaskObject() then
    felony_feedback.endFelony(false)
  end
  unregisterAllGoalCallbacks()
end
function wrecked(getawayGameVehicle)
  removeUserUpdateFunction("escapeCountdown")
  removeUserUpdateFunction("warningCountdown")
  if not localPlayer.primaryFelony.settings.disableGenericFelonyPrompts then
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    feedbackSystem.menusMaster.primaryTextPromptParam({
      prompt = "ID:243501",
      priority = 1,
      delayTime = 3
    })
  end
  OneShotSound.Play("HUD_Gen_Positive", false)
  if goalCallbacks.bustedGetaway then
    for i, callback in ipairs(goalCallbacks.bustedGetaway) do
      callback(getawayGameVehicle)
    end
  end
  unregisterAllGoalCallbacks()
  if localPlayer.currentVehicle and Chase.IsAChaser(localPlayer.currentVehicle.gameVehicle) then
    CopTimeTriggerCount = 0
    Commentary.TriggerEvent("CopBust", nil, nil, 0, false)
  end
  if localPlayer.primaryFelony.settings.chaseMode == "Cop" then
    OneShotSound.Play("HUD_Fel_Gained")
  end
  function endICamHUDRemoval()
    if not localPlayer:getTaskObject() then
      felony_feedback.endFelony()
    end
  end
  iCamCrashCam(getawayGameVehicle, endICamHUDRemoval, {prompts = true, willpowerRewards = true})
  if localPlayer:getTaskObject() then
    endScreenVehicle = takeOwnershipOfGetaway()
  else
    scoreSystem.willpowerReward(felony_feedback.felonyHUDTable.value, "copChase")
    progressionSystem.saveGame("took down the getaway in a freedrive felony")
    local reward = feedbackSystem.menusMaster.setWillpowerComma(felony_feedback.felonyHUDTable.value)
    feedbackSystem.menusMaster.secondaryTextPromptParam({
      prompt = "+" .. tostring(reward) .. tostring("%S"),
      icon1 = iconsTable.willpower,
      priority = 1,
      delayTime = 3
    })
  end
end
local workingVector = vec.vector()
function escaped(getawayGameVehicle)
  removeUserUpdateFunction("escapeCountdown")
  removeUserUpdateFunction("warningCountdown")
  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  feedbackSystem.menusMaster.primaryTextPromptParam({
    prompt = "ID:243499",
    priority = 1,
    delayTime = 3
  })
  if goalCallbacks.getawayEscaped then
    for i, callback in ipairs(goalCallbacks.getawayEscaped) do
      callback(getawayGameVehicle)
    end
  end
  unregisterAllGoalCallbacks()
  if localPlayer:getTaskObject() then
    endScreenVehicle = takeOwnershipOfGetaway()
  else
    felony_feedback.endFelony(false)
  end
  if localPlayer.currentVehicle and Chase.IsAChaser(localPlayer.currentVehicle.gameVehicle) then
    CopTimeTriggerCount = 0
    Commentary.TriggerEvent("CopFree", nil, nil, 0, false)
  end
  if localPlayer.primaryFelony.settings.chaseMode == "Cop" then
    OneShotSound.Play("HUD_Fel_Gained")
  end
end
function allChasersWrecked(getawayGameVehicle, lastWreckedGameVehicle)
  removeUserUpdateFunction("escapeCountdown")
  removeUserUpdateFunction("warningCountdown")
  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  feedbackSystem.menusMaster.primaryTextPromptParam({
    prompt = "ID:243499",
    priority = 1,
    delayTime = 3
  })
  if goalCallbacks.allChasersWrecked then
    for i, callback in ipairs(goalCallbacks.allChasersWrecked) do
      callback(getawayGameVehicle)
    end
  end
  unregisterAllGoalCallbacks()
  if localPlayer.primaryFelony.settings.chaseMode == "Cop" then
    OneShotSound.Play("HUD_Fel_Gained")
  end
  if localPlayer:getTaskObject() then
    endScreenVehicle = takeOwnershipOfLastChaserRemoved(lastWreckedGameVehicle)
  else
    felony_feedback.endFelony(false)
    iCamParams.cameraTargets = {lastWreckedGameVehicle}
    iCamActivationTableInput(iCamParams)
  end
end
function chaserAdded(getawayGameVehicle, chaseGameVehicle)
end
function chaserRemoved(getawayGameVehicle, chaseGameVehicle)
  if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle == chaseGameVehicle then
    localPlayer.currentVehicle:setDebugRequiredVehicles(false)
  end
  vehicleManager.removeHighLODOccupants(chaseGameVehicle)
  if chaseGameVehicle.damage >= 1 then
    if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle == chaseGameVehicle then
      CopTimeTriggerCount = 0
      Commentary.TriggerEvent("CopDstry", nil, nil, 0, true)
    end
    if goalCallbacks.chaserWrecked then
      for i, callback in ipairs(goalCallbacks.chaserWrecked) do
        callback(localPlayer:getChaserID(getawayGameVehicle, chaseGameVehicle))
      end
    end
  end
  if localPlayer.primaryFelony.settings.chaseMode == "Cop" then
    OneShotSound.Play("HUD_Fel_Gained")
  end
  localPlayer:removeChaser(getawayGameVehicle, chaseGameVehicle)
end
function escapingStarted(getawayGameVehicle, timer)
  local losingString = localPlayer.primaryFelony.settings.losingString or "ID:235433"
  local losingLastChaserTimer = timer
  local startTime = g_NetworkTime
  promptTable.prompt = losingString
  promptTable.value = losingLastChaserTimer
  promptTable.overrideTime = losingLastChaserTimer
  feedbackSystem.menusMaster.primaryTextPromptParam(promptTable)
  addUserUpdateFunction("escapeCountdown", function()
    local counter = math.ceil(losingLastChaserTimer - (g_NetworkTime - startTime))
    if not feedbackSystem.menusMaster.primaryPromptActive and not feedbackSystem.previewScreen.activityBeingPrompted and counter > 1 then
      feedbackSystem.menusMaster.primaryTextPromptParam(promptTable)
    end
    feedbackSystem.menusMaster.setPrimaryPromptCounterValues(losingString, counter)
    OneShotSound.PlayCountdown("HUD_Fel_54321")
    if counter == 5 and localPlayer.currentVehicle and Chase.IsAChaser(localPlayer.currentVehicle.gameVehicle) then
      Commentary.TriggerEvent("CopLrng", nil, nil, 0, true)
    end
    CopTimeTriggerCount = 0
  end, 1 * updates.stepRate)
  localPlayer.primaryFelony.status.losingGetaway = true
  if localPlayer.primaryFelony.settings.chaseMode == "Cop" then
    OneShotSound.Play("HUD_Fel_Gained")
  end
end
function escapingStopped(getawayGameVehicle)
  removeUserUpdateFunction("escapeCountdown")
  if localPlayer:getTaskObject() then
    OneShotSound.Play("HUD_Gen_Positive")
  end
  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  if goalCallbacks.notLosingEvader then
    for i, callback in ipairs(goalCallbacks.notLosingEvader) do
      callback(getawayGameVehicle)
    end
  end
  localPlayer.primaryFelony.status.losingGetaway = false
  if localPlayer.primaryFelony.settings.chaseMode == "Cop" then
    OneShotSound.Play("HUD_Fel_Gained")
  end
end
function leavingChaseAreaWarning(getawayGameVehicle)
  if not feedbackSystem.previewScreen.activityBeingPrompted then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:245232")
  end
end
function leavingChaseAreaStarted(getawayGameVehicle, warningTime)
  removeUserUpdateFunction("escapeCountdown")
  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  if not localPlayer:getTaskObject() then
    felony_feedback.pauseFelonyHUD()
  end
  local CurrentSteps = warningTime * (updates.stepRate / 15)
  local TimePerStep = warningTime / CurrentSteps
  local lastTime = warningTime + 1
  promptTable.prompt = "ID:245235"
  promptTable.value = warningTime
  promptTable.overrideTime = warningTime
  feedbackSystem.menusMaster.primaryTextPromptParam(promptTable)
  addUserUpdateFunction("warningCountdown", function()
    local counter = math.ceil(TimePerStep * CurrentSteps)
    CurrentSteps = CurrentSteps - 1
    if lastTime ~= counter then
      lastTime = counter
      if not feedbackSystem.menusMaster.primaryPromptActive and not feedbackSystem.previewScreen.activityBeingPrompted and counter > 1 then
        feedbackSystem.menusMaster.primaryTextPromptParam(promptTable)
      end
      feedbackSystem.menusMaster.setPrimaryPromptCounterValues("ID:245235", counter)
      OneShotSound.PlayCountdown("HUD_Fel_54321")
    end
  end, updates.stepRate / 8)
end
function leavingChaseAreaStopped(getawayGameVehicle)
  removeUserUpdateFunction("warningCountdown")
  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  if not localPlayer:getTaskObject() then
    felony_feedback.resumeFelonyHUD()
  end
end
function PAWindowStarted(getawayGameVehicle)
  if localPlayer.currentVehicle and Chase.IsAChaser(localPlayer.currentVehicle.gameVehicle) then
    CopTimeTriggerCount = 0
    Commentary.TriggerEvent("CopErng", nil, nil, 0, true)
  end
end
function triggerCopLostAudio(getawayGameVehicle)
  if localPlayer.currentVehicle and Chase.IsAChaser(localPlayer.currentVehicle.gameVehicle) then
    CopTimeTriggerCount = 0
    Commentary.TriggerEvent("CopLost", nil, nil, 0, true)
  end
  if localPlayer.primaryFelony.settings.chaseMode == "Cop" then
    OneShotSound.Play("HUD_Fel_Gained")
  end
end
local getChaseChapterSettings = function()
  local highestChapterWithSettings = 0
  local requiredChapter = progressionSystem.getCurrentChapterInlcudingArtificial()
  for chapter, settings in next, chaseSettingsPerChapter, nil do
    if chapter <= requiredChapter and chapter > highestChapterWithSettings then
      highestChapterWithSettings = chapter
    end
  end
  return chaseSettingsPerChapter[highestChapterWithSettings]
end
function getSpecifiedMissionChaseSettings(missionName)
  local chaseSettings = {}
  duplicateTable(defaultChaseSettings, chaseSettings)
  local playerTaskObject = localPlayer:getTaskObject()
  local tempTable = getChaseChapterSettings(playerTaskObject)
  for key, value in next, tempTable, nil do
    if type(value) == "table" then
      if chaseSettings[key] then
        for k, v in next, value, nil do
          chaseSettings[key][k] = v
        end
      else
        chaseSettings[key] = value
      end
    else
      chaseSettings[key] = value
    end
  end
  if missionName then
    local missionFelonySettings = chaseSettingsPerMission[missionName]
    if missionFelonySettings then
      for k, v in next, missionFelonySettings, nil do
        chaseSettings[k] = v
      end
    end
  end
  return chaseSettings
end
function getChaseSettings()
  local chaseSettings = {}
  duplicateTable(defaultChaseSettings, chaseSettings)
  local playerTaskObject = localPlayer:getTaskObject()
  local tempTable = getChaseChapterSettings(playerTaskObject)
  for key, value in next, tempTable, nil do
    if type(value) == "table" then
      if chaseSettings[key] then
        for k, v in next, value, nil do
          chaseSettings[key][k] = v
        end
      else
        chaseSettings[key] = value
      end
    else
      chaseSettings[key] = value
    end
  end
  if playerTaskObject then
    local missionFelonySettings = chaseSettingsPerMission[playerTaskObject.coreData.instance.challenge.name]
    if missionFelonySettings then
      for k, v in next, missionFelonySettings, nil do
        chaseSettings[k] = v
      end
    end
    local routeName = playerTaskObject.coreData.instance.challenge.goalValues["Initial route"]
    if routeName then
      chaseSettings.getawayRoute = routes[routeName].roads
    end
  end
  if chaseSettings.playerAnalysis then
    PlayerAnalysis.AddWeight("Chase", chaseSettings.playerAnalysis)
    chaseSettings.playerAnalysis = nil
  end
  if chaseSettings.playerAnalysisDecay then
    PlayerAnalysis.SetDecay("Chase", chaseSettings.playerAnalysisDecay)
    chaseSettings.playerAnalysisDecay = nil
  end
  if localPlayer:getAbilityAvailable("zapReturn") then
    chaseSettings.rapidShiftAvaliable = true
  end
  return chaseSettings
end
function disownAgent(gameVehicle)
  local agent = vehicleManager.vehiclesByGameVehicle[gameVehicle]
  if agent then
    agent:setDebugRequiredVehicles(true)
    local taskObject = agent:getTaskObject()
    if taskObject then
      taskObject:delete()
    end
    if not agent.controlled then
      vehicleManager.unregisterVehicle(agent, false)
    end
  end
end
function startChase(evaderGameVehicle, chaseGameVehicle)
  local chaseSettings = getChaseSettings()
  localPlayer:createFelony(evaderGameVehicle, chaseSettings)
  disownAgent(evaderGameVehicle)
  local chaserAgent = vehicleManager.vehiclesByGameVehicle[chaseGameVehicle]
  local chaserControlled = chaserAgent and chaserAgent.controlled
  if chaseGameVehicle then
    disownAgent(chaseGameVehicle)
    localPlayer:addChaser(evaderGameVehicle, chaseGameVehicle)
  end
  Chase.Start(evaderGameVehicle, chaseGameVehicle, "Mission", chaseSettings)
  if not chaserControlled then
    Chase.OKToOwnVehicle(chaseGameVehicle)
  end
end
function addChaser(evaderGameVehicle, chaseGameVehicle)
  local chaserAgent = vehicleManager.vehiclesByGameVehicle[chaseGameVehicle]
  local chaserControlled = chaserAgent and chaserAgent.controlled
  disownAgent(chaseGameVehicle)
  localPlayer:addChaser(evaderGameVehicle, chaseGameVehicle)
  Chase.AddChaser(evaderGameVehicle, chaseGameVehicle)
  if not chaserControlled then
    Chase.OKToOwnVehicle(chaseGameVehicle)
  end
end
function StartChaseFromTrafficEvent(evaderGameVehicle, chaseGameVehicle)
  disownAgent(evaderGameVehicle)
  local function callback()
    if not localPlayer.zapTransition then
      felony_suspiciousVehicleManager.startFelony(evaderGameVehicle, chaseGameVehicle)
      removeUserUpdateFunction("copwait")
    end
  end
  addUserUpdateFunction("copwait", callback, 1)
end
function changeSettings(settings)
  Chase.SetSettings(localPlayer.primaryFelony.getawayGameVehicle, settings)
end
function takeOwnershipOfLastChaserRemoved(lastWreckedGameVehicle)
  if lastWreckedGameVehicle then
    local vehicle = vehicleManager.vehiclesByGameVehicle[lastWreckedGameVehicle] or vehicleManager.registerVehicle({gameVehicle = lastWreckedGameVehicle})
    vehicle:setDebugRequiredVehicles(true)
    return vehicle
  end
end
function takeOwnershipOfGetaway()
  if localPlayer.primaryFelony.getawayGameVehicle then
    local vehicle = vehicleManager.vehiclesByGameVehicle[localPlayer.primaryFelony.getawayGameVehicle] or vehicleManager.registerVehicle({
      gameVehicle = localPlayer.primaryFelony.getawayGameVehicle
    })
    vehicle:setDebugRequiredVehicles(true)
    return vehicle
  end
end
function takeOwnershipOfActivityGameVehicle()
  local activityGameVehicle = progressionSystem.getActivityGameVehicle()
  if activityGameVehicle then
    local vehicle = vehicleManager.vehiclesByGameVehicle[activityGameVehicle] or vehicleManager.registerVehicle({gameVehicle = activityGameVehicle})
    return vehicle
  end
end
