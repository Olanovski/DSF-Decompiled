module("spooling", package.seeall)
previousTrafficSet = false
previousTrafficFrequency = 0
local vehiclesRequestedForSpool = {}
local numberOfVehicleAllowed = 18
function releaseSpooledVehicle(modelID)
  TrafficSpooler.ReleaseMissionVehicle(modelID)
  for i, model in ipairs(vehiclesRequestedForSpool) do
    if model == modelID then
      table.remove(vehiclesRequestedForSpool, i)
    end
  end
end
function releaseAllSpooledVehicles()
  for i, modelID in ipairs(vehiclesRequestedForSpool) do
    releaseSpooledVehicle(modelID)
  end
end
function requestToSpoolVehicle(modelID, callback)
  local spoolAllowed = false
  if TrafficSpooler.IsMissionVehicleLoaded(modelID) then
    if callback then
      callback()
    end
    spoolAllowed = true
  elseif #vehiclesRequestedForSpool < numberOfVehicleAllowed then
    vehiclesRequestedForSpool[#vehiclesRequestedForSpool + 1] = modelID
    TrafficSpooler.RequestMissionVehicle(modelID)
    if callback then
      addUserUpdateFunction("VehicleSpool" .. tostring(modelID), function()
        if TrafficSpooler.IsMissionVehicleLoaded(modelID) then
          callback()
          removeUserUpdateFunction("VehicleSpool" .. tostring(modelID))
        end
      end, 1, true)
    end
    spoolAllowed = true
  end
  return spoolAllowed
end
function spoolSafety()
  localPlayer:clearPreviousVehicle()
  local previewVehicle = vehicleManager.previewVehicleManager.previewVehicle
  local previewVehicleTaskObject
  if previewVehicle then
    previewVehicleTaskObject = previewVehicle:getTaskObject()
  end
  local activityGameVehicle = progressionSystem.getActivityGameVehicle()
  if not localPlayer.inZap and not previewVehicle and not activityGameVehicle then
    localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
  end
  Getaway.StopAll()
  Chase.StopAll()
  for instanceID, instance in next, challengeSystem.instances, nil do
    if previewVehicleTaskObject and instance ~= previewVehicleTaskObject.coreData.instance then
      instance:delete()
    end
  end
  for gameVehicle, agent in next, vehicleManager.vehiclesByGameVehicle, nil do
    local taskObject = agent:getTaskObject()
    if taskObject then
      if not previewVehicleTaskObject or previewVehicleTaskObject and taskObject.coreData.instance ~= previewVehicleTaskObject.coreData.instance then
        taskObject:delete(true)
      end
    elseif not activityGameVehicle or activityGameVehicle and agent.gameVehicle ~= activityGameVehicle then
      agent:delete()
    end
  end
  progressionSystem.setTrafficEvents(false)
  vehicleManager.clearOrphanage()
end
local spoolingBusy = false
function setSpoolingStatusBusy()
  spoolingBusy = true
end
function setSpoolingStatusIdle()
  spoolingBusy = false
end
function isMissionVehiclesSpooled(missionVehiclesSet)
  spoolSafety()
  local vehiclesRequiredForChapter = {}
  if not gameStatus.onlineSession then
    local vehiclesToRemove = {}
    for i, modelID in ipairs(vehiclesRequestedForSpool) do
      if not TrafficSpooler.IsMissionVehicleLoaded(modelID) then
        print(tostring(modelID) .. " script thought this was loaded, but it was taken off us by traffic")
        vehiclesToRemove[modelID] = i
      end
    end
    for modelID, i in next, vehiclesToRemove, nil do
      table.remove(vehiclesRequestedForSpool, i)
    end
  end
  if type(missionVehiclesSet) == "table" then
    vehiclesRequestedForSpool = missionVehiclesSet
    for i, modelID in ipairs(vehiclesRequestedForSpool) do
      if not requestToSpoolVehicle(modelID) then
        print("WARNING: ran out of spool slots for " .. tostring(modelID))
        break
      end
    end
  else
    for i, modelID in ipairs(missionSpecificVehiclePots["All chapters"]) do
      table.insert(vehiclesRequiredForChapter, modelID)
    end
    if missionSpecificVehiclePots[missionVehiclesSet] then
      for i, modelID in ipairs(missionSpecificVehiclePots[missionVehiclesSet]) do
        table.insert(vehiclesRequiredForChapter, modelID)
      end
    end
    local vehiclesToRemove = {}
    for i, spooledModelID in ipairs(vehiclesRequestedForSpool) do
      local retainSpooledModelID = false
      for i, modelID in ipairs(vehiclesRequiredForChapter) do
        if modelID == spooledModelID then
          retainSpooledModelID = true
        end
      end
      if not retainSpooledModelID then
        table.insert(vehiclesToRemove, spooledModelID)
      end
    end
    for i, spooledModelID in ipairs(vehiclesToRemove) do
      releaseSpooledVehicle(spooledModelID)
    end
    for i, modelID in ipairs(vehiclesRequiredForChapter) do
      if not requestToSpoolVehicle(modelID) then
        print("WARNING: ran out of spool slots for " .. tostring(modelID))
        break
      end
    end
  end
  return function()
    local loaded = false
    local vehicleCount = 0
    for i, modelID in ipairs(vehiclesRequestedForSpool) do
      if TrafficSpooler.IsMissionVehicleLoaded(modelID) then
        vehicleCount = vehicleCount + 1
      end
    end
    if vehicleCount == #vehiclesRequestedForSpool then
      spooling.enableTraffic(true)
      loaded = true
    end
    return loaded
  end
end
local trafficSpooledState = "none"
function isChapterTrafficSpooled(trafficSet, missionVehiclesSet, trafficFrequency)
  print("trafficSet = " .. tostring(trafficSet))
  print("previousTrafficSet = " .. tostring(previousTrafficSet))
  trafficFrequency = trafficFrequency or 0
  local stepFunction
  trafficSpooledState = "none"
  return function()
    local loaded = false
    local ts = false
    if not spoolingBusy then
      if trafficSpooledState == "none" then
        InterestingVehicleManager.Enable(false)
        civilianTraffic.setTrafficOnOff(false)
        spoolSafety()
        trafficSpooledState = "trafficCheck"
      elseif trafficSpooledState == "trafficCheck" then
        ts = TrafficSpooler.Busy()
        if ts == false then
          trafficSpooledState = "waitingForIVS"
        end
      elseif trafficSpooledState == "waitingForIVS" then
        if previousTrafficSet ~= trafficSet then
          previousTrafficSet = trafficSet
          previousTrafficFrequency = trafficFrequency
          civilianTraffic.setTrafficSettingsName(trafficSet, trafficFrequency)
        elseif previousTrafficSet == trafficSet and trafficFrequency ~= previousTrafficFrequency then
          previousTrafficFrequency = trafficFrequency
          civilianTraffic.setTrafficSettingsName(trafficSet, trafficFrequency)
        end
        trafficSpooledState = "waitingForTrafficSet"
      elseif trafficSpooledState == "waitingForTrafficSet" and TrafficSpooler.AllTrafficVehiclesLoaded() then
        if missionVehiclesSet then
          if stepFunction then
            loaded = stepFunction()
          else
            stepFunction = isMissionVehiclesSpooled(missionVehiclesSet)
          end
        else
          loaded = true
        end
      end
    end
    if loaded then
      InterestingVehicleManager.Enable(true)
    end
    return loaded
  end
end
function spoolTraffic(trafficSet, fullyFadedOutFunction, fadeInFunction, fullyFadedInFunction, fadeOutTime, fadeInTime, alreadyFaded)
  local fading = false
  local trafficSpoolingFunction
  if trafficSet then
    activeChallenges.preventActiveChallenges = true
    trafficSpoolingFunction = isChapterTrafficSpooled(trafficSet)
  end
  local function wait()
    if (trafficSet and trafficSpoolingFunction() or not trafficSet) and not civilianTraffic.RoadUpdateInProgress() then
      if trafficSet then
        enableTraffic(true)
      end
      if fadeInFunction then
        fadeInFunction()
      end
      if fading then
        fadeIn(nil, fadeInTime, fullyFadedInFunction)
      elseif fullyFadedInFunction then
        fullyFadedInFunction()
      end
      activeChallenges.preventActiveChallenges = false
      removeUserUpdateFunction("Wait for traffic spooling")
    end
  end
  local function fadeOutDone()
    if fullyFadedOutFunction then
      fullyFadedOutFunction()
    end
    addUserUpdateFunction("Wait for traffic spooling", wait, 10, true)
  end
  if not alreadyFaded then
    fading = true
    fadeOut(nil, fadeOutTime, fadeOutDone)
  else
    fadeOutDone()
  end
end
function isMissionVehicleSpooled(modelID)
  TrafficSpooler.RequestMissionVehicle(modelID)
  return function()
    if TrafficSpooler.IsMissionVehicleLoaded(modelID) then
      return true
    else
      return false
    end
  end
end
function unrequestAllObjects()
end
function waitForSpooling(position, fullyFadedOutFunction, fadeInFunction, fullyFadedInFunction, fadeOutTime, fadeInTime, alreadyFaded, forceFade, colour, hudParams)
  local fading = false
  local function wait()
    if not localPlayer.inZap and spoolsystem.IsLocationResident(position) or localPlayer.inZap and not spoolsystem.IsStalled() and not civilianTraffic.RoadUpdateInProgress() then
      if fadeInFunction then
        fadeInFunction()
      end
      if fading then
        fadeIn(nil, fadeInTime, fullyFadedInFunction)
      elseif fullyFadedInFunction then
        fullyFadedInFunction()
      end
      removeUserUpdateFunction("Wait for spooling")
    end
  end
  local function fadeOutDone()
    if fullyFadedOutFunction then
      fullyFadedOutFunction()
    end
    addUserUpdateFunction("Wait for spooling", wait, 10, true)
  end
  if not alreadyFaded then
    fading = true
    fadeOut(colour, fadeOutTime, fadeOutDone, nil, nil, nil, nil, hudParams)
  else
    fadeOutDone()
  end
end
function cutsceneAndSpool(position, cutscene, fullyFadedOutFunction, fadeInFunction, fullyFadedInFunction, fadeOutTime, fadeInTime)
  local function wait()
    if not localPlayer.inZap and spoolsystem.IsLocationResident(position) or localPlayer.inZap and not spoolsystem.IsStalled() and not civilianTraffic.RoadUpdateInProgress() then
      if fadeInFunction then
        fadeInFunction()
      end
      fadeIn(nil, fadeInTime or 1, fullyFadedInFunction)
      removeUserUpdateFunction("Wait for spooling")
    end
  end
  local function cutsceneOver()
    fadeOut(nil, 0)
    if fullyFadedOutFunction then
      fullyFadedOutFunction()
    end
    addUserUpdateFunction("Wait for spooling", wait, 10, true)
  end
  local function fadeOutDone()
    engineCutscene.triggerCutscene(cutscene, nil, cutsceneOver)
  end
  fadeOut(nil, fadeOutTime or 1, fadeOutDone)
end
function unspoolUnneceassaryMissionVehicles(progressionPot)
  local unnecessaryVehicles = {}
  for challengeType, challenges in next, progressionPot, nil do
    if challengeType ~= "settings" then
      for i, challenge in next, challenges, nil do
        if challenge.complete and cardSystem.formattedMissionData[challenge.ID] then
          for i, actor in ipairs(cardSystem.formattedMissionData[challenge.ID].challenge.actorPool) do
            table.insert(unnecessaryVehicles, actor.modelID, true)
            if actor.trailerModelID then
              table.insert(unnecessaryVehicles, actor.trailerModelID, true)
            end
          end
        end
      end
    end
  end
  local unnecessarySpooledVehicles = {}
  for i, modelID in next, vehiclesRequestedForSpool, nil do
    if unnecessaryVehicles[modelID] then
      table.insert(unnecessarySpooledVehicles, modelID, true)
    end
  end
  for i, modelID in ipairs(spooling.missionSpecificVehiclePots["All chapters"]) do
    if unnecessarySpooledVehicles[modelID] then
      unnecessarySpooledVehicles[modelID] = nil
    end
  end
  local tableEmpty = false
  for challengeType, challenges in next, progressionPot, nil do
    if tableEmpty then
      break
    end
    if challengeType ~= "settings" then
      for index, challenge in next, challenges, nil do
        if tableEmpty then
          break
        end
        if not challenge.complete and cardSystem.formattedMissionData[challenge.ID] then
          for i, actor in ipairs(cardSystem.formattedMissionData[challenge.ID].challenge.actorPool) do
            if unnecessarySpooledVehicles[actor.modelID] or unnecessarySpooledVehicles[actor.trailerModelID] then
              unnecessarySpooledVehicles[actor.modelID] = nil
              tableEmpty = true
              for modelID, bool in next, unnecessarySpooledVehicles, nil do
                tableEmpty = false
              end
              if tableEmpty then
                break
              end
            end
          end
        end
      end
    end
  end
  if unnecessarySpooledVehicles[265] then
    print("Was trying to unspool the super cop")
    unnecessarySpooledVehicles[265] = nil
  end
  for modelID, bool in next, unnecessarySpooledVehicles, nil do
    releaseSpooledVehicle(modelID)
  end
end
function enableTraffic(enable, preserveOrphanage)
  if preserveOrphanage ~= true and not enable then
    vehicleManager.clearOrphanage()
  end
  civilianTraffic.setTrafficOnOff(enable)
end
local stepClearAreaOfVehicles = function(position, radius)
  return function()
    if not civilianTraffic.RoadUpdateInProgress() then
      GameVehicleResource.ClearAreaOfVehicles(position, radius)
      removeUserUpdateFunction("clearAreaOfVehicles")
    end
  end
end
function clearAreaOfVehicles(position, radius)
  local radius = radius or 5
  local stepFunction = stepClearAreaOfVehicles(position, radius)
  addUserUpdateFunction("clearAreaOfVehicles", stepFunction, 2)
end
function fadeOut(colour, duration, callback, preventAudioFade, localID, onTopOfMenu, priority, hudParams, useSimulationTime)
  local useRealTime = true
  if useSimulationTime then
    useRealTime = false
  end
  if not gameStatus.onlineSession then
    local localID = localID or 0
    local playerTable = localPlayerManager.players
    if playerTable then
      local player = localPlayerManager.players[localID]
      if player then
        player:enterCutsceneMode(hudParams)
      end
    end
  end
  local audioVolume = 0
  if preventAudioFade then
    audioVolume = -1
  end
  if onTopOfMenu == nil then
    onTopOfMenu = true
  end
  local function fadeDone()
    replays.pause()
    if callback then
      callback()
    end
  end
  transitions.fadeto(colour or vec.vector(0, 0, 0, 1), audioVolume, duration or 1, fadeDone, onTopOfMenu, useRealTime, "all", localID, priority)
end
function fadeIn(colour, duration, callback, preventAudioFade, localID, onTopOfMenu, priority, useSimulationTime)
  local audioVolume = 1
  if preventAudioFade then
    audioVolume = -1
  end
  if onTopOfMenu == nil then
    onTopOfMenu = true
  end
  local useRealTime = true
  if useSimulationTime then
    useRealTime = false
  end
  replays.unPause()
  transitions.fadeto(colour or vec.vector(0, 0, 0, 0), audioVolume, duration or 1, function()
    if not gameStatus.onlineSession then
      local localID = localID or 0
      local playerTable = localPlayerManager.players
      if playerTable then
        local player = localPlayerManager.players[localID]
        if player and not player.inCountdownMode and not player.inCutsceneOrIcam and not vehicleManager.previewVehicleManager.previewVehicle and not player.challenge.showingEndScreen and not feedbackSystem.unlockPanelSupport.rewardPanelActive and not CutsceneFiles.tutorials.tutorialActive then
          player:exitCutsceneMode()
        end
      end
    end
    if callback then
      callback()
    end
  end, onTopOfMenu, useRealTime, "all", localID, priority)
end
