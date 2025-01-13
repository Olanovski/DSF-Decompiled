module("phaseManager")
local stateIndex = SpawnVehiclesStateIndex
local stateComplete = false
spawnDone = false
local modeReady = false
local foundMyVehicle = false
local instance
local targetTime = 0
local oriented = false
local function debugCheck()
  NetworkLog.Write(">[LUA] SpawnVehiclesState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " modeReady = " .. tostring(modeReady) .. " spawnDone = " .. tostring(spawnDone) .. " oriented = " .. tostring(oriented) .. " foundMyVehicle = " .. tostring(foundMyVehicle))
  print("SpawnVehiclesState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " modeReady = " .. tostring(modeReady) .. " spawnDone = " .. tostring(spawnDone) .. " oriented = " .. tostring(oriented) .. " foundMyVehicle = " .. tostring(foundMyVehicle))
end
local function enter()
  stateComplete = false
  spawnDone = false
  modeReady = false
  foundMyVehicle = false
  targetTime = 0
  oriented = false
  SNV.disableDistanceMigration()
  if not faceOffNext() then
    instance = challengeSystem.instances[networkVars.modeID]
    instance.missionStartCalled = false
    instance:initiateInstance()
  else
    faceOffSystem.initiate()
    modeReady = true
  end
end
local function orientatePlayer()
  for localID, player in next, localPlayerManager.players, nil do
    for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
      if vehicle.networkVars.onlineOwnerID == player.playerID and not player.currentVehicle then
        oriented = true
        targetTime = g_NetworkTime + 2
      end
    end
  end
end
local function step()
  if not stateComplete and isLocal and not spawnDone then
    local missionData
    local positions = {}
    local headings = {}
    local vehicleTypes = {}
    local style, missionVehiclestyle
    local gridSortStyle = onlineScreenManager.screenSortTypes.scoreNoID
    local gridStagger = 6
    local gridWidth = 10
    if faceOffNext() then
      positions.positionA = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].positionA
      headings.headingA = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].headingA
      vehicleTypes.vehicleTypeA = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].vehicleSet[networkVars.missionVehicleIndex]
      if faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].gridWidth then
        gridWidth = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].gridWidth
      end
      if faceOffSystem.faceOffPool[networkVars.modeIndex].settings.gridStyle then
        style = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.gridStyle
      elseif faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].gridStyle then
        style = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].gridStyle
      else
        assert(false, "CANT FIND GRID STYLE!")
      end
      if faceOffSystem.faceOffPool[networkVars.modeIndex].settings.gridStagger then
        gridStagger = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.gridStagger
      end
      if style == 3 then
        positions.positionB = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].positionB
        headings.headingB = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].headingB
        vehicleTypes.vehicleTypeB = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].vehicleSet[networkVars.missionVehicleIndex]
      elseif style == 6 then
        positions.positionB = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].positionB
        headings.headingB = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].headingB
        vehicleTypes.vehicleTypeB = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].vehicleSet[networkVars.missionVehicleIndex]
        positions.positionC = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].positionC
        headings.headingC = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].headingC
        vehicleTypes.vehicleTypeC = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].vehicleSet[networkVars.missionVehicleIndex]
        positions.positionD = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].positionD
        headings.headingD = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].headingD
        vehicleTypes.vehicleTypeD = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].vehicleSet[networkVars.missionVehicleIndex]
      end
    else
      missionData = cardSystem.createMission(cards.MissionNetworkLookup[networkVars.modeIndex])
      style = missionData.settings.gridStyle
      missionVehiclestyle = missionData.settings.missionVehicleStyle
      if missionData.spawnPositions[networkVars.modeAreaIndex].gridWidth then
        gridWidth = missionData.spawnPositions[networkVars.modeAreaIndex].gridWidth
      end
      if missionData.settings.gridStagger then
        gridStagger = missionData.settings.gridStagger
      end
      if missionData.settings.gridSortStyle and instance.networkVars.roundOn > 1 then
        gridSortStyle = missionData.settings.gridSortStyle
      end
      if style == 1 or style == 2 then
        positions.positionA = missionData.spawnPositions[networkVars.modeAreaIndex].positionA
        headings.headingA = missionData.spawnPositions[networkVars.modeAreaIndex].headingA
        if missionData.spawnPositions[networkVars.modeAreaIndex].frequenceAndVehicles then
          vehicleTypes.vehicleTypeA = missionData.spawnPositions[networkVars.modeAreaIndex].frequenceAndVehicles[networkVars.vehicleFreqIndex].vehicleSet[networkVars.missionVehicleIndex]
        else
          vehicleTypes.vehicleTypeA = missionData.spawnPositions[networkVars.modeAreaIndex].vehicleSet[networkVars.missionVehicleIndex]
        end
      elseif style == 5 then
        vehicleTypes.vehicleTypeA = missionData.spawnPositions[networkVars.modeAreaIndex].playerOneVehicle
        vehicleTypes.vehicleTypeB = missionData.spawnPositions[networkVars.modeAreaIndex].playerTwoVehicle
        positions.positionA = missionData.spawnPositions[networkVars.modeAreaIndex].positionA
        headings.headingA = missionData.spawnPositions[networkVars.modeAreaIndex].headingA
      else
        positions.positionA = missionData.spawnPositions[networkVars.modeAreaIndex].positionA
        headings.headingA = missionData.spawnPositions[networkVars.modeAreaIndex].headingA
        positions.positionB = missionData.spawnPositions[networkVars.modeAreaIndex].positionB
        headings.headingB = missionData.spawnPositions[networkVars.modeAreaIndex].headingB
        if missionVehiclestyle == 1 or missionVehiclestyle == 2 then
          vehicleTypes.vehicleTypeA = missionData.spawnPositions[networkVars.modeAreaIndex].vehicleSet[networkVars.missionVehicleIndex]
          vehicleTypes.vehicleTypeB = missionData.spawnPositions[networkVars.modeAreaIndex].vehicleSet[networkVars.missionVehicleIndex]
        else
          vehicleTypes.vehicleTypeA = missionData.spawnPositions[networkVars.modeAreaIndex].missionVehicle
          vehicleTypes.vehicleTypeB = missionData.spawnPositions[networkVars.modeAreaIndex].vehicleSet[networkVars.missionVehicleIndex]
        end
      end
    end
    spawnGrid(style, gridStagger, gridWidth, vehicleTypes, positions, headings, gridSortStyle)
    spawnDone = true
  elseif not stateComplete and not spawnDone then
    spawnDone = true
    sendMessage(3)
  end
  if not modeReady then
    if instance.modeReadyCheck then
      if instance:modeReadyCheck() then
        modeReady = true
      end
    else
      modeReady = true
    end
  end
  if not foundMyVehicle and spawnDone and modeReady then
    for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
      if vehicle.networkVars.onlineOwnerID and localPlayer.playerID == vehicle.networkVars.onlineOwnerID then
        foundMyVehicle = true
      end
    end
  end
  if not oriented and foundMyVehicle and spawnDone and modeReady then
    orientatePlayer()
  end
  if not stateComplete and oriented and foundMyVehicle and spawnDone and modeReady and targetTime < g_NetworkTime then
    stateComplete = true
    sendMessage(2, stateIndex)
  end
  if not faceOffNext() and instance.stepHighlightColours then
    instance.stepHighlightColours(instance)
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    if not gameStatus.splitscreenSession then
      stateMachine.changeState(states[ZoomToModeStateIndex])
    else
      stateMachine.changeState(states[ZapPlayerStateIndex])
    end
  end
end
local function exit(forced)
  if not faceOffNext() then
    PlayerGamePlay.allowTeamShuffling(false)
    if not forced then
      if not gameStatus.splitscreenSession then
        PauseMenu.allow(false)
        onlineScreenManager.endScreen(cards.MissionNetworkLookup[networkVars.modeIndex])
        onlineScreenManager.endScreen("JOINING SCREEN")
      end
      local missionData = cardSystem.createMission(cards.MissionNetworkLookup[networkVars.modeIndex])
      if not gameStatus.splitscreenSession then
        local introHUDName = missionData.settings.introHUD
        introHUD = {}
        if introHUDName then
          assert(feedbackSystem.HUDBuilders[introHUDName], "FEEDBACKSYSTEM - setTaskFeedback: Couldn't find specified HUD: " .. tostring(introHUDName))
          introHUD.update, introHUD.goalComplete, introHUD.taskComplete, introHUD.cleanup = feedbackSystem.HUDBuilders[introHUDName].mission(instance, {})
        end
      end
      if stateMachine.catchUp then
        if instance.missionStart then
          instance:missionStart()
        end
        instance:startInstanceTaskObjects()
      end
    end
  elseif not forced then
    PauseMenu.allow(false)
    onlineScreenManager.endScreen("JOINING SCREEN")
    onlineScreenManager.endScreen(faceOffSystem.faceOffPool[networkVars.modeIndex].settings.title)
    introHUD = false
    feedbackSystem.faceOffSupport.setupFeedback()
  end
  if not forced and not gameStatus.splitscreenSession and (faceOffNext() or not faceOffNext() and not instance.challenge.settings.tutorial) then
    local siderBarDelayStart = g_NetworkTime
    if not skipIntroHUD then
      addUserUpdateFunction("showOnlineSidebar", function()
        if g_NetworkTime - siderBarDelayStart > 0.75 then
          onlineSideBar.setHidden(false)
          removeUserUpdateFunction("showOnlineSidebar")
        end
      end, 30)
    else
      PauseMenu.allow(false)
      onlineSideBar.setHidden(false)
    end
  end
end
local spawnVehiclesState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(spawnVehiclesState, stateIndex, "SpawnVehiclesState")
