module("felony_getaway", package.seeall)
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
local disablePromptClear = false
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
local TriggerChaserAddedAudio = false
local TriggerChaserRemovedAudio = true
local TriggerFelErngAudioAvaliable = true
local lastFelRamTime = 0
local FelTimeTriggerCount = 0
function getawayOngoingAudioFeedback(getawayGameVehicle)
  local getawayGameVehicle = getawayGameVehicle
  return function()
    FelTimeTriggerCount = FelTimeTriggerCount + 1
    if FelTimeTriggerCount == 20 then
      if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle == getawayGameVehicle then
        Commentary.TriggerEvent("FelTime", nil, nil, 0, true)
      end
      FelTimeTriggerCount = 0
    end
  end
end
function getawayCollsionCallback(collisionData)
  if g_NetworkTime - lastFelRamTime < 5 then
    return
  end
  if collisionData and collisionData.GameVehicle and collisionData.CollidedGameVehicle and collisionData.GameVehicle.damage < 1 and collisionData.GameVehicleResponsibleForCollision ~= collisionData.GameVehicle and localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle == collisionData.GameVehicle and Getaway.IsAChaser(collisionData.CollidedGameVehicle) then
    Commentary.TriggerEvent("FelRam", nil, nil, 0, true)
    FelTimeTriggerCount = 0
    lastFelRamTime = g_NetworkTime
  end
end
local showStartPrompt = function()
  local hint
  if localPlayer.primaryFelony and not localPlayer.primaryFelony.settings.disableHint then
    if localPlayer.primaryFelony.settings.getawayMode == "Goon" then
      hint = "ID:245381"
    else
      hint = "ID:242126"
    end
    feedbackSystem.menusMaster.primaryTextPrompt(hint)
  end
end
function started(getawayGameVehicle)
  local vehicleAgent = vehicleManager.vehiclesByGameVehicle[getawayGameVehicle]
  if vehicleAgent == nil then
    vehicleAgent = vehicleManager.registerVehicle({gameVehicle = getawayGameVehicle})
  end
  vehicleAgent:setDebugRequiredVehicles(true)
  if not localPlayer:getTaskObject() then
    if not ProfileSettings.GetFreeDriveFelonyTutorialPlayed() then
      CutsceneFiles.tutorials.playTutorial("ID:243884", nil, function()
        showStartPrompt()
        ProfileSettings.SetFreeDriveFelonyTutorialPlayed(true)
        felony_feedback.setupFelonyHUD()
        GameVehicleResource.setDisableAllDamage(getawayGameVehicle, false)
      end)
    else
      showStartPrompt()
      local function callback()
        felony_feedback.setupFelonyHUD()
        GameVehicleResource.setDisableAllDamage(getawayGameVehicle, false)
        iCamParams.callbackFunction = nil
      end
      iCamParams.callbackFunction = callback
      iCamParams.cameraTargets = {getawayGameVehicle}
      iCamActivationTableInput(iCamParams)
    end
    print("Presence set to Trying To Lose The Cops")
    presenceSystem.setPresence(6)
    localPlayer:buildZapReturn()
    feedbackSystem.menusMaster.updateFreedriveHintText()
  end
  Commentary.TriggerEvent("FelChase", nil, nil, 0, false)
  if localPlayer.primaryFelony.settings.getawayMode == "Cop" then
    OneShotSound.Play("HUD_Fel_Gained")
  end
  FelTimeTriggerCount = 0
  TriggerChaserAddedAudio = false
  TriggerChaserRemovedAudio = true
  TriggerFelErngAudioAvaliable = true
  lastFelRamTime = g_NetworkTime
  addUserUpdateFunction("getawayOngoing", getawayOngoingAudioFeedback(getawayGameVehicle), 120)
  felony_patrollingVehicleManager.enablePatrollingVehiclesSpawning(false)
  collision_system.RegisterCollisionCallback(getawayGameVehicle, getawayCollsionCallback)
end
function ended(getawayGameVehicle)
  removeUserUpdateFunction("getawayOngoing")
  if not disablePromptClear then
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  end
  disablePromptClear = false
  removeUserUpdateFunction("escapeCountdown")
  removeUserUpdateFunction("bustedCountdown")
  removeUserUpdateFunction("warningCountdown")
  local agent = vehicleManager.getAgentFromGameVehicle(localPlayer.primaryFelony.getawayGameVehicle)
  if agent then
    localPlayer.clearFreedriveMarkers(agent)
    agent:setDebugRequiredVehicles(false)
  end
  local enableSpawning = true
  local playerTaskObject = localPlayer:getTaskObject()
  if playerTaskObject then
    local felonySettings = playerTaskObject.coreData.instance.challenge.felonySettings
    if felonySettings and felonySettings.disablePoliceInTrafficDuringMission and not felonySettings.reenablePatrollingVehiclesAfterFelonyEnd then
      enableSpawning = false
    end
  else
    function waitUntilNotBusy(callback)
      return function()
        if not localPlayer.inCutsceneOrIcam then
          if callback then
            callback()
          end
          removeUserUpdateFunction("busyWait")
        end
      end
    end
    local callback = function()
      activeChallenges.enableActivities()
    end
    addUserUpdateFunction("busyWait", waitUntilNotBusy(callback), 1)
    getawayGameVehicle.softness = 1
    localPlayer:clearFelony(getawayGameVehicle)
    felony_feedback.endFelony(false)
    felony_suspiciousVehicleManager.enableSuspiciousVehicles(true)
    localPlayer.missionSupport.setFreedriveMode()
    presenceSystem.setPresence(9)
    feedbackSystem.menusMaster.updateFreedriveHintText()
    localPlayer:buildZapReturn()
  end
  felony_patrollingVehicleManager.enablePatrollingVehiclesSpawning(enableSpawning)
  collision_system.UnRegisterCollisionCallback(getawayGameVehicle, getawayCollsionCallback)
end
function leftGetawayArea(getawayGameVehicle)
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
  TriggerChaserRemovedAudio = false
  unregisterAllGoalCallbacks()
end
function escaped(getawayGameVehicle)
  removeUserUpdateFunction("bustedCountdown")
  removeUserUpdateFunction("escapeCountdown")
  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  print("SHOW ESCAPED PROMPT")
  feedbackSystem.menusMaster.primaryTextPromptParam({
    prompt = "ID:231165",
    priority = 1,
    delayTime = 3
  })
  OneShotSound.Play("HUD_Gen_Positive", false)
  disablePromptClear = true
  if not localPlayer:getTaskObject() then
    local function callback()
      felony_feedback.endFelony()
      iCamParams.callbackFunction = nil
    end
    iCamParams.cameraTargets = {getawayGameVehicle}
    iCamParams.callbackFunction = callback
    iCamActivationTableInput(iCamParams)
    scoreSystem.willpowerReward(felony_feedback.felonyHUDTable.value, "copChase")
    progressionSystem.saveGame("escaped the cops in a freedrive felony")
    local reward = feedbackSystem.menusMaster.setWillpowerComma(felony_feedback.felonyHUDTable.value)
    feedbackSystem.menusMaster.secondaryTextPromptParam({
      prompt = "+" .. tostring(reward) .. tostring("%S"),
      icon1 = iconsTable.willpower,
      priority = 1,
      delayTime = 3
    })
  end
  if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle == getawayGameVehicle then
    FelTimeTriggerCount = 0
    Commentary.TriggerEvent("FelFree", nil, nil, 0, false)
  end
  if localPlayer.primaryFelony.settings.getawayMode == "Cop" then
    OneShotSound.Play("HUD_Fel_Gained")
  end
  TriggerChaserRemovedAudio = false
  unregisterAllGoalCallbacks()
end
function busted(getawayGameVehicle)
  removeUserUpdateFunction("bustedCountdown")
  removeUserUpdateFunction("escapeCountdown")
  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  feedbackSystem.menusMaster.primaryTextPromptParam({
    prompt = "ID:231166",
    priority = 1,
    delayTime = 3
  })
  disablePromptClear = true
  PatrollingVehicleManager.SetVehicleToWatch(nil)
  SuspiciousVehicleManager.SetVehicleToWatch(nil)
  if goalCallbacks.gotBusted then
    for i, callback in ipairs(goalCallbacks.gotBusted) do
      callback(getawayGameVehicle)
    end
  end
  unregisterAllGoalCallbacks()
  if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle == getawayGameVehicle then
    FelTimeTriggerCount = 0
    Commentary.TriggerEvent("FelBust", nil, nil, 0, false)
  end
  if localPlayer.primaryFelony.settings.getawayMode == "Cop" then
    OneShotSound.Play("HUD_Fel_Gained")
  end
  TriggerChaserRemovedAudio = false
  local function doZapOut()
    if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle == getawayGameVehicle and not localPlayer.currentVehicle:getTaskObject() then
      localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
    end
    iCamParams.callbackFunction = nil
    iCamParams.disableAI = false
  end
  if not localPlayer:getTaskObject() then
    felony_feedback.endFelony(false)
    iCamParams.cameraTargets = {getawayGameVehicle}
    iCamParams.callbackFunction = doZapOut
    iCamParams.disableAI = true
    iCamActivationTableInput(iCamParams)
  else
    doZapOut()
  end
  zapcontroller.AddLockedVehicle({gameVehicle = getawayGameVehicle})
end
function wrecked(getawayGameVehicle)
  removeUserUpdateFunction("bustedCountdown")
  removeUserUpdateFunction("escapeCountdown")
  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  feedbackSystem.menusMaster.primaryTextPromptParam({
    prompt = "ID:173965",
    priority = 1,
    delayTime = 3
  })
  disablePromptClear = true
  if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle == getawayGameVehicle then
    FelTimeTriggerCount = 0
    Commentary.TriggerEvent("FelBust", nil, nil, 0, false)
  end
  if localPlayer.primaryFelony.settings.getawayMode == "Cop" then
    OneShotSound.Play("HUD_Fel_Gained")
  end
  TriggerChaserRemovedAudio = false
  if not localPlayer:getTaskObject() then
    felony_feedback.endFelony(false)
    iCamParams.cameraTargets = {getawayGameVehicle}
    iCamActivationTableInput(iCamParams)
  end
  unregisterAllGoalCallbacks()
end
function chaserAdded(getawayGameVehicle, chaserGameVehicle)
  if TriggerChaserAddedAudio == true then
    if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle == getawayGameVehicle then
      FelTimeTriggerCount = 0
      Commentary.TriggerEvent("FelJoin", nil, nil, 0, true)
    end
  else
    TriggerChaserAddedAudio = true
  end
end
local lastCamTime = 0
function chaserRemoved(getawayGameVehicle, chaserGameVehicle)
  if chaserGameVehicle.damage >= 1 then
    if localPlayer:getTaskObject() and not localPlayer.primaryFelony.status.beingBusted and g_NetworkTime - lastCamTime > 12 then
      lastCamTime = g_NetworkTime
      iCamCrashCam(chaserGameVehicle)
    end
    if goalCallbacks.chaserDestroyed then
      for i, callback in ipairs(goalCallbacks.chaserDestroyed) do
        callback(getawayGameVehicle)
      end
    end
  end
  if TriggerChaserRemovedAudio == true and localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle == getawayGameVehicle then
    FelTimeTriggerCount = 0
    if chaserGameVehicle.damage >= 1 then
      Commentary.TriggerEvent("FelDstry", nil, nil, 0, true)
    else
      Commentary.TriggerEvent("FelLost", nil, nil, 0, true)
    end
  end
end
function escapingStarted(getawayGameVehicle, timer)
  local losingLastChaserTimer = timer
  local startTime = g_NetworkTime
  local warningPrompt = "ID:231167"
  if localPlayer.primaryFelony.settings.getawayMode == "Goon" then
    warningPrompt = "ID:242110"
  end
  promptTable.prompt = warningPrompt
  promptTable.value = losingLastChaserTimer
  promptTable.overrideTime = losingLastChaserTimer
  feedbackSystem.menusMaster.primaryTextPromptParam(promptTable)
  addUserUpdateFunction("escapeCountdown", function()
    local counter = math.ceil(losingLastChaserTimer - (g_NetworkTime - startTime))
    if counter == 5 then
      TriggerFelErngAudioAvaliable = true
      if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle == getawayGameVehicle then
        Commentary.TriggerEvent("FelLrng", nil, nil, 0, true)
      end
    end
    if not feedbackSystem.menusMaster.primaryPromptActive and not feedbackSystem.previewScreen.activityBeingPrompted and counter > 1 then
      feedbackSystem.menusMaster.primaryTextPromptParam(promptTable)
    end
    feedbackSystem.menusMaster.setPrimaryPromptCounterValues(warningPrompt, counter)
    OneShotSound.PlayCountdown("HUD_Fel_54321")
    FelTimeTriggerCount = 0
  end, 1 * updates.stepRate)
  if goalCallbacks.losingLastChaser then
    for i, callback in ipairs(goalCallbacks.losingLastChaser) do
      callback(getawayGameVehicle)
    end
  end
  localPlayer.primaryFelony.status.escapingChasers = true
end
function escapingStopped(getawayGameVehicle)
  removeUserUpdateFunction("escapeCountdown")
  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  if goalCallbacks.chaseReinstated then
    for i, callback in ipairs(goalCallbacks.chaseReinstated) do
      callback(getawayGameVehicle)
    end
  end
  localPlayer.primaryFelony.status.escapingChasers = false
end
function bustedStarted(getawayGameVehicle, timer)
  local bustedTimer = timer
  local startTime = g_NetworkTime
  promptTable.prompt = "ID:231169"
  promptTable.value = bustedTimer
  promptTable.overrideTime = bustedTimer
  feedbackSystem.menusMaster.primaryTextPromptParam(promptTable)
  addUserUpdateFunction("bustedCountdown", function()
    local counter = math.ceil(bustedTimer - (g_NetworkTime - startTime))
    if not feedbackSystem.menusMaster.primaryPromptActive and not feedbackSystem.previewScreen.activityBeingPrompted and counter > 1 then
      feedbackSystem.menusMaster.primaryTextPromptParam(promptTable)
    end
    feedbackSystem.menusMaster.setPrimaryPromptCounterValues("ID:231169", counter)
    OneShotSound.PlayCountdown("HUD_Fel_54321")
    FelTimeTriggerCount = 0
  end, 1 * updates.stepRate)
  if goalCallbacks.beingBusted then
    for i, callback in ipairs(goalCallbacks.beingBusted) do
      callback(getawayGameVehicle)
    end
  end
  localPlayer.primaryFelony.status.beingBusted = true
end
function bustedStopped(getawayGameVehicle)
  removeUserUpdateFunction("bustedCountdown")
  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  if goalCallbacks.notBeingBusted then
    for i, callback in ipairs(goalCallbacks.notBeingBusted) do
      callback(getawayGameVehicle)
    end
  end
  localPlayer.primaryFelony.status.beingBusted = false
end
function leavingGetawayAreaWarning(getawayGameVehicle)
  if not feedbackSystem.previewScreen.activityBeingPrompted then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:245232")
  end
end
function leavingGetawayAreaStarted(getawayGameVehicle, warningTime)
  removeUserUpdateFunction("escapeCountdown")
  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  if not localPlayer:getTaskObject() then
    felony_feedback.pauseFelonyHUD()
  end
  local currentSteps = warningTime * (updates.stepRate / 15)
  local tmePerStep = warningTime / currentSteps
  local lastTime = warningTime + 1
  promptTable.prompt = "ID:245235"
  promptTable.value = warningTime
  promptTable.overrideTime = warningTime
  feedbackSystem.menusMaster.primaryTextPromptParam(promptTable)
  addUserUpdateFunction("warningCountdown", function()
    local counter = math.ceil(tmePerStep * currentSteps)
    currentSteps = currentSteps - 1
    if lastTime ~= counter then
      if not feedbackSystem.menusMaster.primaryPromptActive and not feedbackSystem.previewScreen.activityBeingPrompted and counter > 1 then
        feedbackSystem.menusMaster.primaryTextPromptParam(promptTable)
      end
      lastTime = counter
      feedbackSystem.menusMaster.setPrimaryPromptCounterValues("ID:245235", counter)
      OneShotSound.PlayCountdown("HUD_Fel_54321")
    end
  end, updates.stepRate / 8)
end
function leavingGetawayAreaStopped(getawayGameVehicle)
  removeUserUpdateFunction("warningCountdown")
  feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  if not localPlayer:getTaskObject() then
    felony_feedback.resumeFelonyHUD()
  end
end
function triggerFelErngAudio(getawayGameVehicle)
  if TriggerFelErngAudioAvaliable == true and localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle == getawayGameVehicle then
    FelTimeTriggerCount = 0
    Commentary.TriggerEvent("FelErng", nil, nil, 0, true)
    TriggerFelErngAudioAvaliable = false
  end
end
function getGetawayBehaviourPerChapter()
  local highestChapterWithSettings = 0
  local requiredChapter = progressionSystem.getCurrentChapterInlcudingArtificial()
  for chapter, settings in next, getawayBehaviour, nil do
    if chapter <= requiredChapter and chapter > highestChapterWithSettings then
      highestChapterWithSettings = chapter
    end
  end
  return getawayBehaviour[highestChapterWithSettings]
end
local getGetawayChapterSettings = function()
  local highestChapterWithSettings = 0
  local requiredChapter = progressionSystem.getCurrentChapterInlcudingArtificial()
  for chapter, settings in next, getawaySettingsPerChapter, nil do
    if chapter <= requiredChapter and chapter > highestChapterWithSettings then
      highestChapterWithSettings = chapter
    end
  end
  return getawaySettingsPerChapter[highestChapterWithSettings]
end
function getGetawaySettings()
  local getawaySettings = {}
  duplicateTable(defaultGetawaySettings, getawaySettings)
  local playerTaskObject = localPlayer:getTaskObject()
  local tempTable = getGetawayChapterSettings(playerTaskObject)
  for key, value in next, tempTable, nil do
    if type(value) == "table" then
      if getawaySettings[key] then
        for k, v in next, value, nil do
          getawaySettings[key][k] = v
        end
      else
        getawaySettings[key] = value
      end
    else
      getawaySettings[key] = value
    end
  end
  if playerTaskObject then
    local missionFelonySettings = getawaySettingsPerMission[playerTaskObject.coreData.instance.challenge.name]
    if missionFelonySettings then
      for k, v in next, missionFelonySettings, nil do
        getawaySettings[k] = v
      end
    end
  end
  local evaderDamageMultiplier
  if getawaySettings.evaderDamageMultiplier then
    evaderDamageMultiplier = getawaySettings.evaderDamageMultiplier
    getawaySettings.evaderDamageMultiplier = nil
  end
  if getawaySettings.playerAnalysis then
    PlayerAnalysis.AddWeight("Getaway", getawaySettings.playerAnalysis)
    getawaySettings.playerAnalysis = nil
  end
  if getawaySettings.playerAnalysisDecay then
    PlayerAnalysis.SetDecay("Getaway", getawaySettings.playerAnalysisDecay)
    getawaySettings.playerAnalysisDecay = nil
  end
  return getawaySettings, evaderDamageMultiplier
end
function addEvader(evaderGameVehicle)
  local getawaySettings = getGetawaySettings()
  localPlayer:createFelony(evaderGameVehicle, getawaySettings)
  Getaway.Start(evaderGameVehicle, nil, "Mission", getawaySettings)
end
function StartGetawayFromTrafficEvent(evaderGameVehicle)
  local function callback()
    if not localPlayer.zapTransition then
      felony_patrollingVehicleManager.startFelony(evaderGameVehicle)
      removeUserUpdateFunction("copwait")
    end
  end
  addUserUpdateFunction("copwait", callback, 1)
end
function addChaser(evaderGameVehicle, chaserGameVehicle)
  if Getaway.IsRoomToAddAChaser(evaderGameVehicle) then
    local agent = vehicleManager.vehiclesByGameVehicle[chaserGameVehicle]
    if agent then
      agent:setDebugRequiredVehicles(true)
      local taskObject = agent:getTaskObject()
      if taskObject then
        taskObject:delete()
      end
      vehicleManager.unregisterVehicle(agent, false)
    end
    Getaway.AddChaser(evaderGameVehicle, chaserGameVehicle)
  end
end
function changeSettings(settings)
  Getaway.SetSettings(localPlayer.primaryFelony.getawayGameVehicle, settings)
end
