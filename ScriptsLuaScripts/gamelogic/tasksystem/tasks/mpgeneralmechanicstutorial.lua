local stopPlayer = function()
  localPlayer.controllerInterface:removePlayerControl()
  controller.disableGameControls()
  local slowPlayerDown = function()
    if localPlayer.currentVehicle.gameVehicle.speed == 0 then
      removeUserUpdateFunction("Online Stop Player")
      localPlayer.currentVehicle:unlockEmergencyBrakes()
      return
    elseif localPlayer.currentVehicle.gameVehicle.speed < 0.15 then
      localPlayer.currentVehicle.gameVehicle.speed = 0
      removeUserUpdateFunction("Online Stop Player")
      localPlayer.currentVehicle:unlockEmergencyBrakes()
      return
    end
  end
  localPlayer.currentVehicle:lockEmergencyBrakes(10)
  addUserUpdateFunction("Online Stop Player", slowPlayerDown, 1)
end
local setTextbox = function(title, text, button)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_title", title)
  if button then
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_textbox", text, nil, button)
  else
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_textbox", text)
  end
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", 4)
end
local setContinueButton = function(on)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_continue_button", localPlayer.buttonLayout.accept)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_Continue_Prompt", on)
end
local tickOneOn = false
local tickTwoOn = false
local tickThreeOn = false
local function setTickOnOff(tickNum, on)
  if tickNum == 1 then
    if on then
      if not tickOneOn then
        feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Tick_1", 1)
        tickOneOn = true
      end
    elseif tickOneOn then
      feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Tick_1", 0)
      tickOneOn = false
    end
  elseif tickNum == 2 then
    if on then
      if not tickTwoOn then
        feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Tick_2", 1)
        tickTwoOn = true
      end
    elseif tickTwoOn then
      feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Tick_2", 0)
      tickTwoOn = false
    end
  elseif tickNum == 3 then
    if on then
      if not tickThreeOn then
        feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Tick_3", 1)
        tickThreeOn = true
      end
    elseif tickThreeOn then
      feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Tick_3", 0)
      tickThreeOn = false
    end
  end
end
local highLightOneOn = false
local highLightTwoOn = false
local highLightThreeOn = false
local function setPanelHighlightOnOff(panelNum, on)
  if panelNum == 1 then
    if on then
      if not highLightOneOn then
        feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_StringHighlight_1", 1)
        highLightOneOn = true
      end
    elseif highLightOneOn then
      feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_StringHighlight_1", 0)
      highLightOneOn = false
    end
  elseif panelNum == 2 then
    if on then
      if not highLightTwoOn then
        feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_StringHighlight_2", 1)
        highLightTwoOn = true
      end
    elseif highLightTwoOn then
      feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_StringHighlight_2", 0)
      highLightTwoOn = false
    end
  elseif panelNum == 3 then
    if on then
      if not highLightThreeOn then
        feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_StringHighlight_3", 1)
        highLightThreeOn = true
      end
    elseif highLightThreeOn then
      feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_StringHighlight_3", 0)
      highLightThreeOn = false
    end
  end
end
local setTutorialPanel = function(title, stringOne, subOne, buttonOne, stringTwo, subTwo, buttonTwo, stringThree, subThree, buttonThree, panelType, panelPosition)
  if panelPosition ~= 0 then
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_title", title)
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_1", stringOne, subOne, buttonOne)
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_1_button", "")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_2", stringTwo, subTwo, buttonTwo)
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_2_button", "")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3", stringThree, subThree, buttonThree)
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3_button", "")
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_Type", panelType)
  end
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", panelPosition)
end
local createVehicle = function(vehicleID, instance, position, team, glow)
  local routeIndex = instance.networkVars.routeIndex
  local vehicleActor = false
  local startPosition = false
  if position == 1 then
    startPosition = instance.challenge.spawnPositions[routeIndex].positionB
  else
    startPosition = instance.challenge.spawnPositions[routeIndex].positionC
  end
  assert(startPosition, "No start position given")
  local vehicle = vehicleManager.spawnVehicle({
    position = startPosition,
    modelID = vehicleID,
    heading = instance.challenge.spawnPositions[routeIndex].headingB,
    shader = {
      [0] = 0
    }
  })
  if team == 1 then
    instance:newActorFromAgent(instance.challenge.actorPool[OBJ_TEAM_ONE_STRING_TABLE[1]].ID, vehicle)
  else
    instance:newActorFromAgent(instance.challenge.actorPool[OBJ_TEAM_TWO_STRING_TABLE[1]].ID, vehicle)
  end
  if glow then
    vehicle:disableDisplay(false)
    vehicle:setDisplayColour(OnlineModeSettings.yellow32, OnlineModeSettings.yellow128)
  end
  vehicle:set_damageMultiplier(0)
end
local createTargetMarkers = function(instance, team)
  local target = {
    type = "Target",
    targetType = "MultiplayerObjective",
    gadgetID = 180,
    colour = OnlineModeSettings.yellow32a + OnlineModeSettings.targetAlphaMask32,
    radius = 45,
    markerOffset = 1,
    visible = true
  }
  local minimapArrow = {
    type = "Minimap",
    radius = 40,
    gadgetID = 257,
    colour = OnlineModeSettings.yellow32,
    visible = true,
    canrotate = true,
    nofade = true
  }
  local minimap = {
    type = "Minimap",
    radius = 40,
    gadgetID = 253,
    colour = OnlineModeSettings.yellow32,
    visible = true,
    canrotate = false,
    nofade = true
  }
  if team == 1 then
    target.gameVehicle = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent.gameVehicle
    minimap.gameVehicle = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent.gameVehicle
    minimapArrow.gameVehicle = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent.gameVehicle
  else
    target.gameVehicle = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]].coreData.agent.gameVehicle
    minimap.gameVehicle = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]].coreData.agent.gameVehicle
    minimapArrow.gameVehicle = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]].coreData.agent.gameVehicle
  end
  instance.markedVehicleTargetMarker = Marker:create(target)
  instance.markedVehicleMinimapMarkerArrow = Marker:create(minimapArrow)
  instance.markedVehicleMinimapMarker = Marker:create(minimap)
end
local removeMarkers = function(instance, vehicle)
  if instance.markedVehicleWorldMarker then
    Marker:delete(instance.markedVehicleWorldMarker)
    instance.markedVehicleWorldMarker = nil
  end
  if instance.markedVehicleTargetMarker then
    Marker:delete(instance.markedVehicleTargetMarker)
    instance.markedVehicleTargetMarker = nil
  end
  if instance.markedVehicleMinimapMarker then
    Marker:delete(instance.markedVehicleMinimapMarker)
    instance.markedVehicleMinimapMarker = nil
  end
  if instance.markedVehicleMinimapMarkerArrow then
    Marker:delete(instance.markedVehicleMinimapMarkerArrow)
    instance.markedVehicleMinimapMarkerArrow = nil
  end
  if vehicle then
    vehicle:deleteDisplay()
  end
end
local checkpointGateMarkers = {
  gateMinimap = {
    type = "Minimap",
    gadgetID = 73,
    colour = vec.vector(246, 196, 14, 255),
    radius = 30,
    visible = true,
    position = vec.vector(0, 0, 0, 0),
    nofade = true,
    canrotate = false,
    introType = "BigScaleDown",
    animationType = "WaveScale"
  },
  checkpointColumn = {
    type = "World",
    gadgetID = 79,
    colour = vec.vector(255, 255, 255, 255),
    visible = true,
    position = vec.vector(0, 0, 0, 0),
    offset = vec.vector(0, 1.5, 0, 0),
    minalpha = 100,
    maxalpha = 255,
    fadedistance = 150,
    facing = true
  },
  checkpointTargetMarker = {
    type = "Target",
    gadgetID = 73,
    radius = 50,
    visible = true,
    colour = vec.vector(246, 196, 14, 255),
    showDistance = true
  },
  gate = {
    type = "World",
    facing = false,
    colour = vec.vector(255, 255, 255, 255),
    targetScale = vec.vector(1, 1, 1, 1),
    visible = true,
    heading = 0
  }
}
local function createCheckpoint(position, instance)
  local roadIndex, distanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(position)
  local roadWidth = Atlas.AverageRoadWidth(roadIndex)
  local roadHeading = getVectorRoadAngleAtPosition(roadIndex, distanceAlong)
  local roadAngle = math.atan2(roadHeading.x, roadHeading.z)
  if roadWidth <= 8 then
    checkpointGateMarkers.gate.gadgetID = 56
  elseif roadWidth <= 16 then
    checkpointGateMarkers.gate.gadgetID = 57
  elseif roadWidth <= 24 then
    checkpointGateMarkers.gate.gadgetID = 58
  elseif roadWidth <= 32 then
    checkpointGateMarkers.gate.gadgetID = 59
  else
    checkpointGateMarkers.gate.gadgetID = 60
  end
  checkpointGateMarkers.gateMinimap.position = position
  checkpointGateMarkers.checkpointColumn.position = position
  checkpointGateMarkers.checkpointTargetMarker.position = position + vec.vector(0, 10, 0, 0)
  checkpointGateMarkers.gate.position = position
  checkpointGateMarkers.gateMinimap.localID = localPlayer.localID
  checkpointGateMarkers.checkpointColumn.localID = localPlayer.localID
  checkpointGateMarkers.checkpointTargetMarker.localID = localPlayer.localID
  checkpointGateMarkers.gate.localID = localPlayer.localID
  checkpointGateMarkers.gate.heading = roadAngle
  checkpointGateMarkers.gate.scale = vec.vector(1, 1, 1, 1)
  instance.mpCheckpointGateMinimap = Marker:create(checkpointGateMarkers.gateMinimap)
  instance.mpCheckpointColumn = Marker:create(checkpointGateMarkers.checkpointColumn)
  instance.mpCheckpointTargetMarker = Marker:create(checkpointGateMarkers.checkpointTargetMarker)
  instance.mpCheckpointGate = Marker:create(checkpointGateMarkers.gate)
end
local removeChecpoint = function(instance)
  checkpointSystem.deleteInstanceCheckpoints(instance)
  if instance.mpCheckpointGateMinimap then
    Marker:delete(instance.mpCheckpointGateMinimap)
    instance.mpCheckpointGateMinimap = nil
  end
  if instance.mpCheckpointColumn then
    Marker:delete(instance.mpCheckpointColumn)
    instance.mpCheckpointColumn = nil
  end
  if instance.mpCheckpointTargetMarker then
    Marker:delete(instance.mpCheckpointTargetMarker)
    instance.mpCheckpointTargetMarker = nil
  end
  if instance.mpCheckpointGate then
    Marker:delete(instance.mpCheckpointGate)
    instance.mpCheckpointGate = nil
  end
end
local playerZappedOut = false
local function zapOutDetection()
  if localPlayer.inZap and not playerZappedOut then
    playerZappedOut = true
    removeUserUpdateFunction("tutZapOutDetection")
  end
end
local function setInstructionPrompts(majorOrder)
  onlineInstructionSupport.setPrompts(false, false, false, false, false, false, false, false, false, false, false, false, false, false)
  if majorOrder == 2 then
    onlineInstructionSupport.addPrompt("shift out", {
      enabled = false,
      shown = false,
      resetOnScore = true,
      startTime = 8,
      resetTime = 10,
      displayFunction = function()
        local task = localPlayer.getTaskObject().taskList[#localPlayer.getTaskObject().taskList][1]
        if task.networkVars.taskOneComp and not task.networkVars.taskTwoComp then
          onlineInstructionSupport.displayPrompt("ID:235739", localPlayer.buttonLayout.zapSelect)
          return true
        end
        return false
      end
    })
  elseif majorOrder == 4 then
    onlineInstructionSupport.addPrompt("level one", {
      enabled = true,
      shown = false,
      resetOnScore = true,
      startTime = 8,
      resetTime = 10,
      displayFunction = function()
        local task = localPlayer.getTaskObject().taskList[#localPlayer.getTaskObject().taskList][1]
        if not task.networkVars.taskOneComp then
          onlineInstructionSupport.displayPrompt("ID:235741", localPlayer.buttonLayout.zapUp)
          return true
        end
        return false
      end
    })
    onlineInstructionSupport.addPrompt("level two", {
      enabled = false,
      shown = false,
      resetOnScore = true,
      startTime = 8,
      resetTime = 10,
      displayFunction = function()
        local task = localPlayer.getTaskObject().taskList[#localPlayer.getTaskObject().taskList][1]
        if task.networkVars.taskOneComp and not task.networkVars.taskTwoComp then
          onlineInstructionSupport.displayPrompt("ID:235741", localPlayer.buttonLayout.zapUp)
          return true
        end
        return false
      end
    })
    onlineInstructionSupport.addPrompt("level three", {
      enabled = false,
      shown = false,
      resetOnScore = true,
      startTime = 8,
      resetTime = 10,
      displayFunction = function()
        local task = localPlayer.getTaskObject().taskList[#localPlayer.getTaskObject().taskList][1]
        if task.networkVars.taskOneComp and task.networkVars.taskTwoComp and not task.networkVars.taskThreeComp then
          onlineInstructionSupport.displayPrompt("ID:235742", localPlayer.buttonLayout.zapDown)
          return true
        end
        return false
      end
    })
  elseif majorOrder == 6 then
    onlineInstructionSupport.addPrompt("select target", {
      enabled = false,
      shown = false,
      resetOnScore = true,
      startTime = 8,
      resetTime = 10,
      displayFunction = function()
        local task = localPlayer.getTaskObject().taskList[#localPlayer.getTaskObject().taskList][1]
        if not task.networkVars.taskOneComp then
          onlineInstructionSupport.displayPrompt("ID:235743", iconsTable.multiTakedown)
          return true
        end
        return false
      end
    })
    onlineInstructionSupport.addPrompt("shift in", {
      enabled = false,
      shown = false,
      resetOnScore = true,
      startTime = 8,
      resetTime = 10,
      displayFunction = function()
        local task = localPlayer.getTaskObject().taskList[#localPlayer.getTaskObject().taskList][1]
        if task.networkVars.taskOneComp and not task.networkVars.taskTwoComp then
          onlineInstructionSupport.displayPrompt("ID:235739", localPlayer.buttonLayout.zapSelect)
          return true
        end
        return false
      end
    })
  elseif majorOrder == 8 then
    onlineInstructionSupport.addPrompt("car one", {
      enabled = true,
      shown = false,
      resetOnScore = true,
      startTime = 8,
      resetTime = 10,
      displayFunction = function()
        local task = localPlayer.getTaskObject().taskList[#localPlayer.getTaskObject().taskList][1]
        if not task.networkVars.taskOneComp then
          onlineInstructionSupport.displayPrompt("ID:235739", localPlayer.buttonLayout.zapSelect)
          return true
        end
        return false
      end
    })
    onlineInstructionSupport.addPrompt("car two", {
      enabled = false,
      shown = false,
      resetOnScore = true,
      startTime = 8,
      resetTime = 10,
      displayFunction = function()
        local task = localPlayer.getTaskObject().taskList[#localPlayer.getTaskObject().taskList][1]
        if task.networkVars.taskOneComp and not task.networkVars.taskTwoComp then
          onlineInstructionSupport.displayPrompt("ID:235739", localPlayer.buttonLayout.zapSelect)
          return true
        end
        return false
      end
    })
    onlineInstructionSupport.addPrompt("car three", {
      enabled = false,
      shown = false,
      resetOnScore = true,
      startTime = 8,
      resetTime = 10,
      displayFunction = function()
        local task = localPlayer.getTaskObject().taskList[#localPlayer.getTaskObject().taskList][1]
        if task.networkVars.taskOneComp and task.networkVars.taskTwoComp and not task.networkVars.taskThreeComp then
          onlineInstructionSupport.displayPrompt("ID:235739", localPlayer.buttonLayout.zapSelect)
          return true
        end
        return false
      end
    })
  elseif majorOrder == 17 or majorOrder == 20 then
    onlineInstructionSupport.addPrompt("checkpoints zap out", {
      enabled = false,
      shown = false,
      resetOnScore = true,
      startTime = 4,
      resetTime = 3,
      displayFunction = function()
        if not playerZappedOut then
          onlineInstructionSupport.displayPrompt("ID:243703", localPlayer.buttonLayout.zapSelect)
          return true
        end
        return false
      end
    })
  elseif majorOrder == 14 then
    onlineInstructionSupport.addPrompt("tutorialBoost", {
      enabled = true,
      shown = false,
      resetOnScore = true,
      startTime = 2,
      resetTime = 10,
      displayFunction = function()
        if localPlayer.currentVehicle and localPlayer.currentVehicle.speed > 0 and localPlayer.currentVehicle.activeAbilityName == "none" and scoreSystem.getAbility(0) >= abilities.getPointsToUseAbility("nitro") then
          onlineInstructionSupport.displayPrompt("ID:234258", localPlayer.buttonLayout.boostAbility)
          return true
        end
        return false
      end
    })
  elseif majorOrder == 22 then
    onlineInstructionSupport.addPrompt("shift return", {
      enabled = true,
      shown = false,
      resetOnScore = true,
      startTime = 5,
      resetTime = 10,
      displayFunction = function()
        if scoreSystem.enoughAbilityToUseShift(0) and not localPlayer.inZap then
          onlineInstructionSupport.displayPrompt("ID:234447", localPlayer.buttonLayout.zapReturn)
          return true
        end
        return false
      end
    })
  end
end
taskSystem.registerTask("MP General Mechanics Tutorial", {
  {
    name = "done",
    startingValue = false,
    parseType = "boolean"
  },
  {
    name = "taskOneComp",
    startingValue = false,
    parseType = "boolean"
  },
  {
    name = "taskTwoComp",
    startingValue = false,
    parseType = "boolean"
  },
  {
    name = "taskThreeComp",
    startingValue = false,
    parseType = "boolean"
  },
  {
    name = "wellDone",
    startingValue = false,
    parseType = "boolean"
  },
  {
    name = "vehicleSNVIDOne",
    startingValue = 0,
    parseType = "integer16"
  },
  {
    name = "vehicleSNVIDTwo",
    startingValue = 0,
    parseType = "integer16"
  },
  {
    name = "raceStartTime",
    startingValue = 0,
    parseType = "float"
  },
  {
    name = "reseting",
    startingValue = false,
    parseType = "boolean"
  },
  {
    name = "checkpoints",
    startingValue = 1,
    parseType = "integer16",
    dynamicTargetTrigger = true
  },
  {
    name = "laps",
    startingValue = 0,
    parseType = "integer16"
  },
  {
    name = "fadeComplete",
    startingValue = true,
    parseType = "boolean"
  }
}, function(task)
  tickOneOn = false
  tickTwoOn = false
  tickThreeOn = false
  local overtakeCount = 0
  if task.majorOrder == 2 or task.majorOrder == 4 or task.majorOrder == 6 or task.majorOrder == 8 or task.majorOrder == 11 or task.majorOrder == 14 or task.majorOrder == 17 or task.majorOrder == 20 or task.majorOrder == 22 then
    setInstructionPrompts(task.majorOrder)
  end
  if task.majorOrder == 17 or task.majorOrder == 20 then
    onlineInstructionSupport.setPrompt("checkpoints zap out", true)
    playerZappedOut = false
    addUserUpdateFunction("tutZapOutDetection", zapOutDetection, 1)
  end
  local function goalCallback(success, condition, missionData, promptID)
    if promptID.turnOffBlockFeedback then
      scoreSystem.setZapBlocked(0, false)
    end
    if success then
      if promptID.stopVehicle then
        stopPlayer()
      end
      if promptID.blockZap then
        localPlayer:blockAbility("zap", true)
        localPlayer.currentVehicle.gameVehicle.damage = 0
        localPlayer.currentVehicle:set_damageMultiplier(0)
      end
      if promptID.disableZapIn then
        zap.disableZapSelection()
      end
      if promptID.removeMarkers then
        removeMarkers(task.instance)
      end
      if promptID.removeCheckpoint then
        removeChecpoint(task.instance)
      end
      if promptID.speedComplete then
        setPanelHighlightOnOff(1, false)
        setTickOnOff(1, true)
        setPanelHighlightOnOff(2, true)
        task.networkVars.taskOneComp = true
      end
      if promptID.boostComplete then
        setTickOnOff(2, true)
        setPanelHighlightOnOff(2, false)
        setPanelHighlightOnOff(3, true)
        task.networkVars.taskTwoComp = true
      end
      if promptID.clear then
        setTickOnOff(1, false)
        setTickOnOff(2, false)
        setTickOnOff(3, false)
        setPanelHighlightOnOff(1, false)
        setPanelHighlightOnOff(2, false)
        setPanelHighlightOnOff(3, false)
        feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", 3)
        feedbackSystem.menusMaster.currentHUDSetVariable("iDisplay_Tutorial_Counter_3", 0)
        task.networkVars.done = true
        removeUserUpdateFunction("tutZapOutDetection")
      end
      if promptID.welldone then
        if promptID.tick == 1 then
          setTickOnOff(1, true)
          setPanelHighlightOnOff(1, false)
        elseif promptID.tick == 2 then
          setTickOnOff(2, true)
          setPanelHighlightOnOff(2, false)
        elseif promptID.tick == 3 then
          setTickOnOff(3, true)
          setPanelHighlightOnOff(3, false)
        end
        feedbackSystem.menusMaster.primaryTextPrompt("ID:235749")
        feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3_button", "")
        task.networkVars.wellDone = true
      end
      if promptID.done then
        if promptID.tick == 1 then
          setTickOnOff(1, true)
          setPanelHighlightOnOff(1, false)
        elseif promptID.tick == 2 then
          setTickOnOff(2, true)
          setPanelHighlightOnOff(2, false)
        elseif promptID.tick == 3 then
          setTickOnOff(3, true)
          setPanelHighlightOnOff(3, false)
        end
        feedbackSystem.menusMaster.primaryTextPrompt("ID:236315")
        feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3_button", "")
        task.networkVars.wellDone = true
      end
      if promptID.group == 1 then
        if promptID.subgroup == 1 then
          setTextbox("ID:235693", "ID:235694")
        elseif promptID.subgroup == 2 then
          setContinueButton(1)
        elseif promptID.subgroup == 3 then
          setTutorialPanel("title", "stringOne", nil, nil, "stringTwo", nil, nil, "stringThree", nil, nil, 0, 0)
          setContinueButton(2)
          if promptID.group ~= 1 then
            task.networkVars.done = true
          else
            task.networkVars.taskOneComp = true
          end
        elseif promptID.subgroup == 4 then
          setTutorialPanel("ID:235919", "ID:235734", nil, nil, "", nil, nil, "", nil, nil, 1, 1)
        elseif promptID.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235919", "ID:235734", nil, nil, "", nil, nil, "", nil, nil, 1, 2)
          setPanelHighlightOnOff(1, true)
          scoreSystem.stopAbilityGain(0, false)
          task.networkVars.done = true
        elseif promptID.subgroup == 7 then
          localPlayer.controllerInterface:removePlayerControl()
          controller.disableGameControls()
          setTextbox("ID:235945", "ID:235946")
        elseif promptID.subgroup == 8 then
          setTutorialPanel("title", "stringOne", nil, nil, "stringTwo", nil, nil, "stringThree", nil, nil, 0, 0)
          setContinueButton(2)
          task.networkVars.taskTwoComp = true
        end
      elseif promptID.group == 2 then
        if promptID.subgroup == 1 then
          setTextbox("ID:235696", "ID:235697")
          scoreSystem.emptyAbility()
          scoreSystem.setTimeAbilityGain(0, false)
          scoreSystem.stopAbilityGain(localPlayer.localID, true)
          scoreSystem.stopAbilityGain(0, true)
          civilianTraffic.setTrafficOnOff(true)
          createVehicle(298, task.instance, 1, 1, true)
        elseif promptID.subgroup == 4 then
          setTutorialPanel("ID:235920", "ID:235735", nil, iconsTable.multiTakedown, "ID:235736", nil, localPlayer.buttonLayout.cancel, "ID:243709", "3", nil, 3, 1)
        elseif promptID.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235735", nil, iconsTable.multiTakedown, "ID:235736", nil, localPlayer.buttonLayout.cancel, "ID:243709", "3", nil, 3, 2)
          scoreSystem.emptyAbility()
          if not gameStatus.onlinePaused then
            localPlayer.controllerInterface:registerPlayerControl()
            controller.enableGameControls()
          end
          setPanelHighlightOnOff(1, true)
          task.networkVars.done = true
          overtakeCount = 0
          localPlayer.scoring.onlineTutorialFeedback = 2
          scoreSystem.limitedFeedback = 1
          createTargetMarkers(task.instance, 1)
        end
      elseif promptID.group == 3 then
        if promptID.subgroup == 1 then
          setTextbox("ID:235698", "ID:235699")
          removeMarkers(task.instance)
          localPlayer:blockAbility("zap", false)
          scoreSystem.emptyAbility()
          scoreSystem.stopAbilityGain(localPlayer.localID, true)
          scoreSystem.setTimeAbilityGain(localPlayer.localID, false)
          zapcontroller.setZapCameraLocks(0, {
            missile = false,
            low = true,
            mid = true,
            high = true,
            top = true
          })
        elseif promptID.subgroup == 3 then
          setTutorialPanel("title", "stringOne", nil, nil, "stringTwo", nil, nil, "stringThree", nil, nil, 0, 0)
          setContinueButton(2)
          task.networkVars.taskThreeComp = true
        elseif promptID.subgroup == 4 then
          setTutorialPanel("ID:235920", "ID:235738", nil, nil, "ID:235739", nil, localPlayer.buttonLayout.zapSelect, "", nil, nil, 2, 1)
        elseif promptID.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235738", nil, nil, "ID:235739", nil, localPlayer.buttonLayout.zapSelect, "", nil, nil, 2, 2)
          scoreSystem.emptyAbility()
          scoreSystem.setTimeAbilityGain(0, true)
          if not gameStatus.onlinePaused then
            localPlayer.controllerInterface:registerPlayerControl()
            controller.enableGameControls()
          end
          scoreSystem.stopAbilityGain(localPlayer.localID, false)
          setPanelHighlightOnOff(1, true)
          task.networkVars.done = true
        end
      elseif promptID.group == 4 then
        if promptID.subgroup == 1 then
          setTextbox("ID:235701", "ID:235702")
          zapcontroller.setRenderTarget(false, 0)
          localPlayer:blockAbility("zap", true)
          zapcontroller.EnableZapInput(false, localPlayer.localID)
          zap.disableZapSelection()
          scoreSystem.setAbility(localPlayer.localID, 0)
          scoreSystem.stopAbilityDrain(localPlayer.localID, true)
          civilianTraffic.setTrafficOnOff(false)
        elseif promptID.subgroup == 4 then
          setTutorialPanel("ID:235919", "ID:235740", nil, nil, "", nil, nil, "", nil, nil, 1, 1)
        elseif promptID.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235919", "ID:235740", nil, nil, "", nil, nil, "", nil, nil, 1, 2)
          zapcontroller.setRenderTarget(true, 0)
          localPlayer:SetZapLevel(1)
          zapcontroller.EnableZapInput(true, localPlayer.localID)
          setPanelHighlightOnOff(1, true)
          task.networkVars.done = true
        end
      elseif promptID.group == 5 then
        if promptID.subgroup == 1 then
          setTextbox("ID:235703", "ID:235704")
          zapcontroller.setRenderTarget(false, 0)
          localPlayer:SetZapLevel(1)
          zapcontroller.EnableZapInput(false, localPlayer.localID)
          CityLockManager.CityLockActive = false
          scoreSystem.emptyAbility()
          scoreSystem.setTimeAbilityGain(0, false)
          scoreSystem.stopAbilityGain(localPlayer.localID, true)
        elseif promptID.subgroup == 4 then
          setTutorialPanel("ID:235920", "ID:235741", nil, localPlayer.buttonLayout.zapUp, "ID:235741", nil, localPlayer.buttonLayout.zapUp, "ID:235742", nil, localPlayer.buttonLayout.zapDown, 3, 1)
        elseif promptID.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235741", nil, localPlayer.buttonLayout.zapUp, "ID:235741", nil, localPlayer.buttonLayout.zapUp, "ID:235742", nil, localPlayer.buttonLayout.zapDown, 3, 2)
          localPlayer:SetZapLevel(1)
          zapcontroller.EnableZapInput(true, localPlayer.localID)
          zapcontroller.setRenderTarget(true, 0)
          zapcontroller.setZapCameraLocks(0, {
            missile = true,
            low = true,
            mid = false,
            high = true,
            top = true
          })
          setPanelHighlightOnOff(1, true)
          task.networkVars.done = true
          onlineInstructionSupport.setPrompt("level one", true)
          scoreSystem.setTimeAbilityGain(0, true)
          scoreSystem.stopAbilityGain(localPlayer.localID, false)
        end
      elseif promptID.group == 6 then
        if promptID.subgroup == 1 then
          zapcontroller.setRenderTarget(false, 0)
          zapcontroller.setZapCameraLocks(0, {
            missile = false,
            low = true,
            mid = false,
            high = false,
            top = true
          })
          zap.disableZapSelection()
          zapcontroller.EnableZapInput(false, localPlayer.localID)
          createVehicle(62, task.instance, 1, 2, false)
          scoreSystem.emptyAbility()
          scoreSystem.setTimeAbilityGain(0, false)
          scoreSystem.stopAbilityGain(localPlayer.localID, true)
        elseif promptID.subgroup == 4 then
          setTutorialPanel("ID:235920", "ID:235743", nil, iconsTable.multiTakedown, "ID:235739", nil, localPlayer.buttonLayout.zapSelect, "", nil, nil, 2, 1)
        elseif promptID.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235743", nil, iconsTable.multiTakedown, "ID:235739", nil, localPlayer.buttonLayout.zapSelect, "", nil, nil, 2, 2)
          localPlayer:blockAbility("zap", false)
          zapcontroller.EnableZapInput(true, localPlayer.localID)
          zap.enableZapSelection()
          zapcontroller.setRenderTarget(true, 0)
          setPanelHighlightOnOff(1, true)
          task.networkVars.done = true
          onlineInstructionSupport.setPrompt("select target", true)
          createTargetMarkers(task.instance, 2)
          scoreSystem.setTimeAbilityGain(0, true)
          scoreSystem.stopAbilityGain(localPlayer.localID, false)
        elseif promptID.subgroup == 6 then
          setTextbox("ID:246688", "ID:235707")
        end
      elseif promptID.group == 7 then
        if promptID.subgroup == 1 then
          setTextbox("ID:235706", "ID:235709")
          zapcontroller.setRenderTarget(false, 0)
          scoreSystem.stopAbilityDrain(0, true)
          localPlayer:blockAbility("zap", true)
          scoreSystem.emptyAbility()
          scoreSystem.setTimeAbilityGain(0, false)
          scoreSystem.stopAbilityGain(localPlayer.localID, true)
          civilianTraffic.setTrafficOnOff(true)
          zap.disableZapSelection()
          CityLockManager.CityLockActive = true
          zapcontroller.EnableZapInput(false, localPlayer.localID)
          localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
          removeMarkers(task.instance)
          task.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]:delete()
        elseif promptID.subgroup == 4 then
          setTutorialPanel("ID:235920", "ID:235744", nil, nil, "ID:235745", nil, nil, "ID:235746", nil, nil, 3, 1)
        elseif promptID.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235744", nil, nil, "ID:235745", nil, nil, "ID:235746", nil, nil, 3, 2)
          scoreSystem.stopAbilityDrain(localPlayer.localID, false)
          scoreSystem.setTimeAbilityGain(0, true)
          scoreSystem.stopAbilityGain(localPlayer.localID, false)
          localPlayer:blockAbility("zap", false)
          zapcontroller.EnableZapInput(true, localPlayer.localID)
          zap.enableZapSelection()
          zapcontroller.setRenderTarget(true, 0)
          setPanelHighlightOnOff(1, true)
          task.networkVars.done = true
          onlineInstructionSupport.setPrompt("car one", true)
        end
      elseif promptID.group == 8 then
        if promptID.subgroup == 1 then
          setTextbox("ID:235711", "ID:235714")
          scoreSystem.stopAbilityDrain(localPlayer.localID, true)
          scoreSystem.stopAbilityGain(localPlayer.localID, true)
          localPlayer:blockAbility("zap", true)
          scoreSystem.emptyAbility()
          localPlayer.controllerInterface:removePlayerControl()
          controller.disableGameControls()
          local routeIndex = task.instance.networkVars.routeIndex
          local route = task.instance.challenge.spawnPositions[routeIndex].route
          for i, checkpointData in ipairs(route) do
            if not checkpointSystem.findNextCheckpoint(task.instance.instanceID, 1, i - 1) then
              checkpointSystem.createCheckpoint(task.instance, checkpointData.position, 0)
              createCheckpoint(checkpointData.position, task.instance)
              break
            end
          end
        elseif promptID.subgroup == 6 then
          setTextbox("ID:235715", "ID:235716")
        elseif promptID.subgroup == 7 then
          setTutorialPanel("title", "stringOne", nil, nil, "stringTwo", nil, nil, "stringThree", nil, nil, 0, 0)
          setContinueButton(2)
          task.networkVars.taskTwoComp = true
        elseif promptID.subgroup == 4 then
          setTutorialPanel("ID:235919", "ID:235748", nil, nil, "", nil, nil, "", nil, nil, 1, 1)
        elseif promptID.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235919", "ID:235748", nil, nil, "", nil, nil, "", nil, nil, 1, 2)
          setPanelHighlightOnOff(1, true)
          scoreSystem.setZapBlocked(0, true)
          task.networkVars.done = true
        end
      elseif promptID.group == 9 then
        if promptID.subgroup == 1 then
          setTextbox("ID:235717", "ID:235719")
          scoreSystem.stopAbilityDrain(localPlayer.localID, false)
          scoreSystem.stopAbilityGain(localPlayer.localID, false)
          localPlayer:blockAbility("zap", true)
          scoreSystem.maxAbility()
          localPlayer.controllerInterface:removePlayerControl()
          controller.disableGameControls()
          local routeIndex = task.instance.networkVars.routeIndex
          local route = task.instance.challenge.spawnPositions[routeIndex].route2
          for i, checkpointData in ipairs(route) do
            if not checkpointSystem.findNextCheckpoint(task.instance.instanceID, 1, i - 1) then
              checkpointSystem.createCheckpoint(task.instance, checkpointData.position, 0)
              createCheckpoint(checkpointData.position, task.instance)
              break
            end
          end
        elseif promptID.subgroup == 4 then
          setTutorialPanel("ID:235919", "ID:235748", nil, nil, "", nil, nil, "", nil, nil, 1, 1)
        elseif promptID.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235919", "ID:235748", nil, nil, "", nil, nil, "", nil, nil, 1, 2)
          setPanelHighlightOnOff(1, true)
          task.networkVars.done = true
          localPlayer:blockAbility("zap", false)
          localPlayer.resetingToStart = false
        end
      elseif promptID.group == 10 then
        if promptID.subgroup == 1 then
          setTextbox("ID:235720", "ID:235721")
          scoreSystem.stopAbilityDrain(localPlayer.localID, false)
          scoreSystem.stopAbilityGain(localPlayer.localID, false)
          scoreSystem.maxAbility()
          civilianTraffic.setTrafficOnOff(true)
          localPlayer:blockAbility("zap", true)
          localPlayer.controllerInterface:removePlayerControl()
          controller.disableGameControls()
          local routeIndex = task.instance.networkVars.routeIndex
          local route = task.instance.challenge.spawnPositions[routeIndex].route3
          for i, checkpointData in ipairs(route) do
            if not checkpointSystem.findNextCheckpoint(task.instance.instanceID, 1, i - 1) then
              checkpointSystem.createCheckpoint(task.instance, checkpointData.position, 0)
              createCheckpoint(checkpointData.position, task.instance)
              break
            end
          end
        elseif promptID.subgroup == 4 then
          setTutorialPanel("ID:235919", "ID:235748", nil, nil, "", nil, nil, "", nil, nil, 1, 1)
        elseif promptID.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235919", "ID:235748", nil, nil, "", nil, nil, "", nil, nil, 1, 2)
          setPanelHighlightOnOff(1, true)
          task.networkVars.done = true
          localPlayer.resetingToStart = false
          localPlayer:blockAbility("zap", false)
        end
      elseif promptID.group == 11 then
        if promptID.subgroup == 1 then
          setTextbox("ID:214344", "ID:246488")
          scoreSystem.stopAbilityDrain(localPlayer.localID, true)
          scoreSystem.stopAbilityGain(localPlayer.localID, true)
          localPlayer:blockAbility("zap", true)
          scoreSystem.emptyAbility()
          localPlayer.controllerInterface:removePlayerControl()
          controller.disableGameControls()
          local routeIndex = task.instance.networkVars.routeIndex
          local route = task.instance.challenge.spawnPositions[routeIndex].route4
          for i, checkpointData in ipairs(route) do
            if not checkpointSystem.findNextCheckpoint(task.instance.instanceID, 1, i - 1) then
              checkpointSystem.createCheckpoint(task.instance, checkpointData.position, 0)
              createCheckpoint(checkpointData.position, task.instance)
              break
            end
          end
        elseif promptID.subgroup == 6 then
          setTextbox("ID:214344", "ID:246489", localPlayer.buttonLayout.boostAbility)
        elseif promptID.subgroup == 7 then
          setTutorialPanel("title", "stringOne", nil, nil, "stringTwo", nil, nil, "stringThree", nil, nil, 0, 0)
          setContinueButton(2)
          task.networkVars.taskTwoComp = true
        elseif promptID.subgroup == 4 then
          setTutorialPanel("ID:235919", "ID:246490", nil, nil, "ID:246492", nil, localPlayer.buttonLayout.boostAbility, "ID:235748", nil, nil, 3, 1)
        elseif promptID.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235919", "ID:246490", nil, nil, "ID:246492", nil, localPlayer.buttonLayout.boostAbility, "ID:235748", nil, nil, 3, 2)
          setPanelHighlightOnOff(1, true)
          scoreSystem.setZapBlocked(0, true)
          localPlayer.resetingToStart = false
          task.networkVars.done = true
          scoreSystem.stopAbilityDrain(localPlayer.localID, false)
          scoreSystem.stopAbilityGain(localPlayer.localID, false)
          onlineInstructionSupport.setPrompt("tutorialBoost", true)
        end
      elseif promptID.group == 12 then
        if promptID.subgroup == 1 then
          setTextbox("ID:234286", "ID:246493", localPlayer.buttonLayout.zapReturn)
          localPlayer.controllerInterface:removePlayerControl()
          controller.disableGameControls()
          scoreSystem.emptyAbility()
          scoreSystem.setTimeAbilityGain(0, false)
          scoreSystem.stopAbilityGain(localPlayer.localID, true)
          createVehicle(62, task.instance, 1, 1, false)
          scoreSystem.stopAbilityGain(0, true)
          localPlayer:blockAbility("zap", true)
        elseif promptID.subgroup == 4 then
          setTutorialPanel("ID:235920", "ID:235738", nil, nil, "ID:234447", nil, localPlayer.buttonLayout.zapReturn, "", nil, nil, 2, 1)
        elseif promptID.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235738", nil, nil, "ID:234447", nil, localPlayer.buttonLayout.zapReturn, "", nil, nil, 2, 2)
          scoreSystem.emptyAbility()
          scoreSystem.setTimeAbilityGain(0, true)
          scoreSystem.stopAbilityGain(localPlayer.localID, false)
          scoreSystem.stopAbilityGain(0, false)
          if not gameStatus.onlinePaused then
            localPlayer.controllerInterface:registerPlayerControl()
            controller.enableGameControls()
          end
          setPanelHighlightOnOff(1, true)
          createTargetMarkers(task.instance, 1)
          task.networkVars.done = true
          MPZapToAction.setZapToAction(1, task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent)
          zap.SetZapInOverride(function()
          end)
          onlineInstructionSupport.setPrompt("shift return", true)
        end
      end
      if promptID.spawnPlayerVehicle then
        local routeIndex = task.instance.networkVars.routeIndex
        local vehicleActor = task.instance.challenge.actorPool[OBJ_TEAM_ONE_STRING_TABLE[1]]
        local vehicle = vehicleManager.spawnVehicle({
          position = task.instance.challenge.spawnPositions[routeIndex].routeStartP,
          modelID = 62,
          heading = task.instance.challenge.spawnPositions[routeIndex].routeStartH,
          shader = {
            [0] = 0
          }
        })
        task.instance:newActorFromAgent(vehicleActor.ID, vehicle)
      end
      if promptID.forceZapPlayer then
        local position = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent.position
        local vehicle = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent
        spooling.waitForSpooling(position, function()
          if not localPlayer.inZap then
            local tempVehicle = localPlayer.currentVehicle
            localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
            tempVehicle:delete()
            Orphanage.deleteAll()
          end
        end, function()
          localPlayer:SetZapLevel(0, vehicle)
        end, nil, 1, 2, false)
      end
      if promptID.createAndForceZapPlayer and not task.networkVars.wellDone then
        localPlayer.resetingToStart = true
        feedbackSystem.menusMaster.primaryTextPrompt("ID:235757")
        feedbackSystem.menusMaster.currentHUDSetVariable("iPrompt_M_Secondary_Display", 0)
        local delayStart = g_NetworkTime
        task.networkVars.fadeComplete = false
        addUserUpdateFunction("restartDelay", function()
          if g_NetworkTime - delayStart > 2 then
            spooling.waitForSpooling(position, function()
              if task.instance and task.instance.challenge then
                localPlayer.controllerInterface:removePlayerControl()
                controller.disableGameControls()
                if not localPlayer.inZap then
                  local tempVehicle = localPlayer.currentVehicle
                  localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
                  tempVehicle:delete()
                end
                task.networkVars.reseting = true
                local routeIndex = task.instance.networkVars.routeIndex
                local vehicleActor = task.instance.challenge.actorPool[OBJ_TEAM_ONE_STRING_TABLE[1]]
                local vehicle = vehicleManager.spawnVehicle({
                  position = task.instance.challenge.spawnPositions[routeIndex].routeStartP,
                  modelID = 62,
                  heading = task.instance.challenge.spawnPositions[routeIndex].routeStartH,
                  shader = {
                    [0] = 0
                  }
                })
                task.instance:newActorFromAgent(vehicleActor.ID, vehicle)
                Orphanage.deleteAll()
              end
            end, function()
              if task.instance and task.instance.taskObjectsByActorID then
                local objTO = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
                local vehicle = objTO and task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent or false
                if vehicle then
                  localPlayer:SetZapLevel(0, vehicle)
                end
                if task.majorOrder == 14 then
                  setPanelHighlightOnOff(3, false)
                  setPanelHighlightOnOff(2, false)
                  setTickOnOff(1, false)
                  setTickOnOff(2, false)
                  setPanelHighlightOnOff(1, true)
                  onlineInstructionSupport.setPrompt("tutorialBoost", true)
                  setPanelHighlightOnOff(1, false)
                  task.networkVars.taskOneComp = false
                  task.networkVars.taskTwoComp = false
                end
              end
            end, function()
              if task.networkVars then
                task.networkVars.fadeComplete = true
                task.networkVars.raceStartTime = g_NetworkTime
                task.networkVars.reseting = false
                playerZappedOut = false
                if task.majorOrder == 17 or task.majorOrder == 20 then
                  onlineInstructionSupport.setPrompt("checkpoints zap out", true)
                  playerZappedOut = false
                  addUserUpdateFunction("tutZapOutDetection", zapOutDetection, 1)
                end
              end
            end, 2, 2, false)
            removeUserUpdateFunction("restartDelay")
          end
        end, 1)
      end
      if promptID.forceTaskDone then
        task.networkVars.done = true
      end
      if promptID.deletePlayerTO then
        localPlayer.resetingToStart = false
        task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]:delete()
        scoreSystem.maxAbility()
        local timeAdded = g_NetworkTime
        addUserUpdateFunction("returnControl", function()
          if g_NetworkTime - timeAdded > 0.7 then
            if not gameStatus.onlinePaused then
              localPlayer.controllerInterface:registerPlayerControl()
              controller.enableGameControls()
            end
            task.networkVars.raceStartTime = g_NetworkTime
            if task.majorOrder == 14 then
              onlineProgressionSystem.onlineAbilityData[1].unlockFunc()
            end
            removeUserUpdateFunction("returnControl")
          end
        end, 1)
      end
    else
      if promptID.group == 1 then
        setPanelHighlightOnOff(1, false)
        setTickOnOff(1, true)
        setPanelHighlightOnOff(2, true)
        task.networkVars.taskOneComp = true
        if task.majorOrder == 2 then
          onlineInstructionSupport.setPrompt("shift out", true)
        elseif task.majorOrder == 6 then
          onlineInstructionSupport.setPrompt("shift in", true)
          onlineInstructionSupport.setPrompt("select target", false)
        end
      elseif promptID.group == 2 then
        setTickOnOff(2, true)
        setPanelHighlightOnOff(2, false)
        setPanelHighlightOnOff(3, true)
        task.networkVars.taskTwoComp = true
      elseif promptID.group == 3 then
        setTickOnOff(3, true)
        task.networkVars.taskThreeComp = true
      end
      if promptID.group == 4 then
        setTickOnOff(1, false)
        setPanelHighlightOnOff(2, false)
        setPanelHighlightOnOff(1, true)
        task.networkVars.taskOneComp = false
        if task.majorOrder == 6 then
          onlineInstructionSupport.setPrompt("shift in", false)
          onlineInstructionSupport.setPrompt("select target", true)
        end
      elseif promptID.group == 5 then
        setTickOnOff(2, false)
        setPanelHighlightOnOff(1, true)
        setPanelHighlightOnOff(2, false)
        task.networkVars.taskTwoComp = false
      elseif promptID.group == 6 then
        setTickOnOff(3, false)
        setPanelHighlightOnOff(2, true)
        setPanelHighlightOnOff(3, false)
        task.networkVars.taskThreeComp = false
      end
      if promptID.group == 7 then
        setPanelHighlightOnOff(1, false)
        setTickOnOff(1, true)
        setPanelHighlightOnOff(2, true)
        task.networkVars.taskOneComp = true
        task.networkVars.vehicleSNVIDOne = localPlayer.currentVehicle.SNVID
        onlineInstructionSupport.setPrompt("car one", false)
        onlineInstructionSupport.setPrompt("car two", true)
      elseif promptID.group == 8 then
        if localPlayer.currentVehicle.SNVID ~= task.networkVars.vehicleSNVIDOne then
          setTickOnOff(2, true)
          setPanelHighlightOnOff(2, false)
          setPanelHighlightOnOff(3, true)
          task.networkVars.taskTwoComp = true
          task.networkVars.vehicleSNVIDTwo = localPlayer.currentVehicle.SNVID
          onlineInstructionSupport.setPrompt("car two", false)
          onlineInstructionSupport.setPrompt("car three", true)
        end
      elseif promptID.group == 9 and localPlayer.currentVehicle.SNVID ~= task.networkVars.vehicleSNVIDOne and localPlayer.currentVehicle.SNVID ~= task.networkVars.vehicleSNVIDTwo then
        setTickOnOff(3, true)
        setPanelHighlightOnOff(3, false)
        task.networkVars.taskThreeComp = true
      end
      if promptID.group == 10 then
        setPanelHighlightOnOff(1, false)
        setTickOnOff(1, true)
        setPanelHighlightOnOff(2, true)
        task.networkVars.taskOneComp = true
        zapcontroller.setZapCameraLocks(0, {
          missile = true,
          low = true,
          mid = true,
          high = false,
          top = true
        })
        onlineInstructionSupport.setPrompt("level one", false)
        onlineInstructionSupport.setPrompt("level two", true)
      elseif promptID.group == 11 then
        setTickOnOff(2, true)
        setPanelHighlightOnOff(1, false)
        setPanelHighlightOnOff(2, false)
        setPanelHighlightOnOff(3, true)
        task.networkVars.taskTwoComp = true
        zapcontroller.setZapCameraLocks(0, {
          missile = true,
          low = true,
          mid = false,
          high = true,
          top = true
        })
        onlineInstructionSupport.setPrompt("level two", false)
        onlineInstructionSupport.setPrompt("level three", true)
      elseif promptID.group == 12 then
        setTickOnOff(3, true)
        setPanelHighlightOnOff(1, false)
        setPanelHighlightOnOff(2, false)
        setPanelHighlightOnOff(3, false)
        task.networkVars.taskThreeComp = true
      elseif promptID.group == 13 then
        setPanelHighlightOnOff(1, false)
        setTickOnOff(1, true)
        setPanelHighlightOnOff(2, true)
        task.networkVars.taskOneComp = true
        local maxAbility = scoreSystem.getMaxAbility(localPlayer.localID)
        if task.networkVars.taskTwoComp and task.networkVars.taskThreeComp then
          scoreSystem.setAbility(0, maxAbility)
        elseif task.networkVars.taskTwoComp or task.networkVars.taskThreeComp then
          scoreSystem.setAbility(0, 0.67 * maxAbility)
        else
          scoreSystem.setAbility(0, 0.335 * maxAbility)
        end
        onlineInstructionSupport.setPrompt("jump ramp truck", false)
        onlineInstructionSupport.setPrompt("drift to shift", true)
        removeMarkers(task.instance, task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent)
        localPlayer.scoring.onlineTutorialFeedback = 1
        scoreSystem.limitedFeedback = 2
      elseif promptID.group == 14 then
        setTickOnOff(2, true)
        setPanelHighlightOnOff(2, false)
        setPanelHighlightOnOff(3, true)
        task.networkVars.taskTwoComp = true
        local maxAbility = scoreSystem.getMaxAbility(localPlayer.localID)
        if task.networkVars.taskOneComp and task.networkVars.taskThreeComp then
          scoreSystem.setAbility(0, maxAbility)
        elseif task.networkVars.taskOneComp or task.networkVars.taskThreeComp then
          scoreSystem.setAbility(0, 0.67 * maxAbility)
        else
          scoreSystem.setAbility(0, 0.335 * maxAbility)
        end
        onlineInstructionSupport.setPrompt("drift to shift", false)
        onlineInstructionSupport.setPrompt("overtake vehicles", true)
        localPlayer.scoring.onlineTutorialFeedback = false
        scoreSystem.limitedFeedback = 3
      elseif promptID.group == 15 then
        setTickOnOff(3, true)
        setPanelHighlightOnOff(3, false)
        task.networkVars.taskThreeComp = true
        scoreSystem.limitedFeedback = false
      elseif promptID.group == 16 then
        overtakeCount = overtakeCount + 1
        if overtakeCount > 3 then
          overtakeCount = 3
        end
        if overtakeCount == 3 then
          feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3", "ID:243784")
        elseif overtakeCount == 1 then
          feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3", "ID:243709", "2")
        else
          feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3", "ID:235737")
        end
        local maxAbility = scoreSystem.getMaxAbility(localPlayer.localID)
        local currentAbility = scoreSystem.getAbility(localPlayer.localID)
        scoreSystem.setAbility(0, currentAbility + 0.335 * (0.335 * maxAbility))
      elseif promptID.group == 17 then
        setTickOnOff(3, true)
        setPanelHighlightOnOff(3, false)
        localPlayer.resetingToStart = true
      elseif promptID.group == 18 then
        task.networkVars.taskThreeComp = true
        localPlayer.resetingToStart = nil
      end
    end
  end
  local cleanup = function()
    onlineInstructionSupport.resetPrompts()
    removeUserUpdateFunction("restartDelay")
  end
  return goalCallback, nil, cleanup
end)
