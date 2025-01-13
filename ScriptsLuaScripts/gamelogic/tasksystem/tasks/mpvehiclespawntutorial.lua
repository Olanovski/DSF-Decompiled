local setTextbox = function(title, text)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_title", title)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_textbox", text)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", 4)
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
local setContinueButton = function(on)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_continue_button", localPlayer.buttonLayout.accept)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_Continue_Prompt", on)
end
local zapSpawnFailed = function()
  localPlayer.hasZapSpawnFailed = true
end
local function setInstructionPrompts(majorOrder)
  localPlayer.hasZapSpawnFailed = nil
  onlineInstructionSupport.setPrompts(false, false, false, false, false, false, false, false, false, false, false, false, false, false)
  onlineInstructionSupport.addPrompt("press [] to spawn", {
    enabled = false,
    shown = false,
    resetOnScore = true,
    startTime = 8,
    resetTime = 5,
    displayFunction = function()
      local task = localPlayer.getTaskObject().taskList[#localPlayer.getTaskObject().taskList][1]
      if task.networkVars.taskOneComp and not task.networkVars.taskTwoComp then
        onlineInstructionSupport.displayPrompt("ID:246496", localPlayer.buttonLayout.vehicleSwap)
        return true
      end
      return false
    end
  })
  onlineInstructionSupport.addPrompt("trying to spawn on top of a vehicle", {
    enabled = true,
    shown = false,
    resetOnScore = true,
    startTime = 1,
    resetTime = 5,
    displayFunction = function()
      if not localPlayer.registerZapSpawnFailedCallback then
        localPlayer.registerZapSpawnFailedCallback = true
        zap.zapSpawn.registerZapSpawnFailedCallback(zapSpawnFailed)
      end
      if localPlayer.hasZapSpawnFailed then
        localPlayer.hasZapSpawnFailed = nil
        localPlayer.registerZapSpawnFailedCallback = nil
        zap.zapSpawn.clearZapSpawnFailedCallback(zapSpawnFailed)
        onlineInstructionSupport.displayPrompt("ID:243707")
        return true
      end
      return false
    end
  })
  onlineInstructionSupport.addPrompt("cant use spawn", {
    enabled = true,
    shown = false,
    resetOnScore = true,
    startTime = 10,
    resetTime = 15,
    displayFunction = function()
      local zapLevel = zapcontroller.getZapLevel(0)
      if zapLevel ~= 0 and zapLevel ~= 1 then
        onlineInstructionSupport.displayPrompt("ID:235742", localPlayer.buttonLayout.zapDown)
        return true
      end
      return false
    end
  })
  if majorOrder == 12 then
    onlineInstructionSupport.addPrompt("press dpad", {
      enabled = true,
      shown = false,
      resetOnScore = true,
      startTime = 12,
      resetTime = 5,
      displayFunction = function()
        local task = localPlayer.getTaskObject().taskList[#localPlayer.getTaskObject().taskList][1]
        if not task.networkVars.taskOneComp then
          onlineInstructionSupport.displayPrompt("ID:235775", localPlayer.buttonLayout.vehicleSlot2)
          return true
        end
        return false
      end
    })
  end
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
taskSystem.registerTask("MP vehicle spawn tutorial", {
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
  }
}, function(task)
  local instance = task.instance
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
  if task.majorOrder == 3 or task.majorOrder == 6 or task.majorOrder == 9 or task.majorOrder == 12 then
    if task.majorOrder == 3 or task.majorOrder == 9 then
      task.networkVars.taskOneComp = true
    end
    setInstructionPrompts(task.majorOrder)
  end
  local numTags = 0
  local function goalCallback(success, condition, missionData, goalData)
    if goalData.failed then
      if goalData.failReason == 1 then
        if goalData.hitWrongPosition then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:243783")
        else
          feedbackSystem.menusMaster.primaryTextPrompt("ID:235751")
        end
        setTickOnOff(2, false)
        setTickOnOff(3, false)
        setPanelHighlightOnOff(3, false)
        if ActiveVehicles.getActiveVehicleSlot() ~= 1 then
          setTickOnOff(1, false)
          setPanelHighlightOnOff(2, false)
          setPanelHighlightOnOff(1, true)
        else
          setPanelHighlightOnOff(2, true)
        end
      elseif goalData.failReason == 2 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:235752")
        setPanelHighlightOnOff(1, true)
        setPanelHighlightOnOff(2, false)
        setPanelHighlightOnOff(3, false)
      elseif goalData.failReason == 3 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:235752")
        task.networkVars.taskOneComp = false
        setPanelHighlightOnOff(1, true)
        setPanelHighlightOnOff(2, false)
        setPanelHighlightOnOff(3, false)
      elseif goalData.failReason == 4 then
        if goalData.wrongVehicle then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:235753")
          setPanelHighlightOnOff(1, true)
          setPanelHighlightOnOff(2, false)
          setPanelHighlightOnOff(3, false)
        else
          feedbackSystem.menusMaster.primaryTextPrompt("ID:235752")
          setPanelHighlightOnOff(1, true)
          setPanelHighlightOnOff(2, false)
          setPanelHighlightOnOff(3, false)
        end
      elseif goalData.failReason == 5 then
        setTickOnOff(2, false)
        setTickOnOff(3, false)
        setPanelHighlightOnOff(1, true)
        setPanelHighlightOnOff(2, false)
        setPanelHighlightOnOff(3, false)
        feedbackSystem.menusMaster.primaryTextPromptParam({
          prompt = "ID:246502",
          icon1 = localPlayer.buttonLayout.vehicleSwap
        })
      end
      localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
      if goalData.failReason and goalData.failReason ~= 1 then
        setTickOnOff(1, false)
        setTickOnOff(2, false)
        setTickOnOff(3, false)
      end
      return
    elseif goalData.done then
      task.networkVars.done = true
      zap.zapSpawn.tutorialPromptsActive = false
    end
    if goalData.clear then
      setTickOnOff(1, false)
      setTickOnOff(2, false)
      setTickOnOff(3, false)
      feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", 3)
      task.networkVars.done = true
      zap.zapSpawn.tutorialPromptsActive = false
      setPanelHighlightOnOff(1, false)
      setPanelHighlightOnOff(2, false)
      setPanelHighlightOnOff(3, false)
    end
    if goalData.welldone then
      zapWeaponSupport.paused()
      zapWeaponSupport.pauseZapWeaponFuel(true)
      feedbackSystem.menusMaster.currentHUDSetVariable("iMinimap_Display", 1)
      feedbackSystem.menusMaster.primaryTextPrompt("ID:235749")
      MPZapToAction.reset()
      task.networkVars.done = true
      zap.zapSpawn.tutorialPromptsActive = false
      MPZapToAction.reset()
    end
    if goalData.spawnVehicle then
      local startPosition = vec.vector(365.8571, 30.28114, 2101.671, 1)
      local startHeading = -0.8506181
      local actor = task.instance.challenge.actorPool[OBJ_TEAM_ONE_STRING_TABLE[1]]
      local vehicle = vehicleManager.spawnVehicle({
        position = startPosition,
        heading = startHeading,
        modelID = 193
      })
      task.instance:newActorFromAgent(actor.ID, vehicle)
      vehicle:addLightTrail(32, OnlineModeSettings.red128)
      vehicle:disableDisplay(false)
      vehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
      vehicle:set_damageMultiplier(0)
      target = {
        type = "Target",
        gadgetID = 180,
        targetType = "MultiplayerObjective",
        colour = OnlineModeSettings.red32 + OnlineModeSettings.targetAlphaMask32,
        markerOffset = 1,
        radius = 45,
        visible = true,
        gameVehicle = vehicle.gameVehicle
      }
      instance.markedVehicleTargetMarker = Marker:create(target)
    end
    if goalData.removeMarkers and instance.markedVehicleTargetMarker then
      Marker:delete(instance.markedVehicleTargetMarker)
      instance.markedVehicleTargetMarker = nil
    end
    if goalData.slowdown then
      stopPlayer()
    end
    if goalData.promptID then
      if goalData.promptID == 1 then
        if goalData.subgroup == 1 then
          setTextbox("ID:235656", "ID:235666")
        elseif goalData.subgroup == 2 then
          setContinueButton(1)
        elseif goalData.subgroup == 3 then
          setTutorialPanel("title", "stringOne", nil, nil, "stringTwo", nil, nil, "stringThree", nil, nil, 0, 0)
          setContinueButton(2)
          task.networkVars.done = true
        elseif goalData.subgroup == 4 then
          setTextbox("ID:235669", "ID:235957")
          localPlayer.controllerInterface:removePlayerControl()
          controller.disableGameControls()
          zap.disableZapSelection()
        elseif goalData.subgroup == 5 then
          setContinueButton(1)
        elseif goalData.subgroup == 6 then
          setTutorialPanel("title", "stringOne", nil, nil, "stringTwo", nil, nil, "stringThree", nil, nil, 0, 0)
          setContinueButton(2)
          task.networkVars.taskOneComp = true
        end
      elseif goalData.promptID == 2 then
        if goalData.subgroup == 1 then
          setTextbox("ID:235667", "ID:235668")
          localPlayer.controllerInterface:removePlayerControl()
          controller.disableGameControls()
        elseif goalData.subgroup == 2 then
          setContinueButton(1)
        elseif goalData.subgroup == 3 then
          setTutorialPanel("title", "stringOne", nil, nil, "stringTwo", nil, nil, "stringThree", nil, nil, 0, 0)
          setContinueButton(2)
          task.networkVars.taskOneComp = true
        elseif goalData.subgroup == 4 then
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:246496", nil, localPlayer.buttonLayout.vehicleSwap, "ID:246503", nil, localPlayer.buttonLayout.vehicleSwap, 3, 1)
        elseif goalData.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:246496", nil, localPlayer.buttonLayout.vehicleSwap, "ID:246503", nil, localPlayer.buttonLayout.vehicleSwap, 3, 2)
          setPanelHighlightOnOff(1, true)
          localPlayer.controllerInterface:registerPlayerControl()
          controller.enableGameControls()
          onlineProgressionSystem.onlineWeaponData[1].unlocked = true
          zap.zapSpawn.tutorialPromptsActive = true
          zapWeaponSupport.pauseZapWeaponFuel(false)
          localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
          task.networkVars.done = true
        end
      elseif goalData.promptID == 3 then
        if goalData.subgroup == 1 then
          setTextbox("ID:235667", "ID:246505")
          localPlayer.controllerInterface:removePlayerControl()
          controller.disableGameControls()
        elseif goalData.subgroup == 4 then
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:246496", nil, localPlayer.buttonLayout.vehicleSwap, "ID:246504", nil, localPlayer.buttonLayout.vehicleSwap, 3, 1)
        elseif goalData.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:246496", nil, localPlayer.buttonLayout.vehicleSwap, "ID:246504", nil, localPlayer.buttonLayout.vehicleSwap, 3, 2)
          localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
          setPanelHighlightOnOff(1, true)
          localPlayer.controllerInterface:registerPlayerControl()
          controller.enableGameControls()
          zapWeaponSupport.pauseZapWeaponFuel(false)
          onlineProgressionSystem.onlineWeaponData[1].unlocked = true
          zap.zapSpawn.tutorialPromptsActive = true
          task.networkVars.done = true
        end
      elseif goalData.promptID == 4 then
        if goalData.subgroup == 1 then
          setTextbox("ID:235669", "ID:235670")
          localPlayer.controllerInterface:removePlayerControl()
          controller.disableGameControls()
        elseif goalData.subgroup == 4 then
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:246496", nil, localPlayer.buttonLayout.vehicleSwap, "ID:243708", "2", nil, 3, 1)
          civilianTraffic.setTrafficOnOff(true)
        elseif goalData.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:246496", nil, localPlayer.buttonLayout.vehicleSwap, "ID:243708", "2", nil, 3, 2)
          localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
          setPanelHighlightOnOff(1, true)
          localPlayer.controllerInterface:registerPlayerControl()
          controller.enableGameControls()
          zapWeaponSupport.pauseZapWeaponFuel(false)
          onlineProgressionSystem.onlineWeaponData[1].unlocked = true
          zap.zapSpawn.tutorialPromptsActive = true
          instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent.gameVehicle.damage = 0
          MPZapToAction.setZapToAction(1, instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent)
          task.networkVars.done = true
        end
      elseif goalData.promptID == 5 then
        if goalData.subgroup == 1 then
          setTextbox("ID:235671", "ID:235672")
          instance.markedVehicleTargetMarker.visible = false
          localPlayer.controllerInterface:removePlayerControl()
          controller.disableGameControls()
        elseif goalData.subgroup == 4 then
          setTutorialPanel("ID:235920", "ID:235775", nil, localPlayer.buttonLayout.vehicleSlot2, "ID:246496", nil, localPlayer.buttonLayout.vehicleSwap, "ID:235729", nil, nil, 3, 1)
        elseif goalData.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235775", nil, localPlayer.buttonLayout.vehicleSlot2, "ID:246496", nil, localPlayer.buttonLayout.vehicleSwap, "ID:235729", nil, nil, 3, 2)
          ActiveVehicles.setUnlockedSlots(2)
          localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
          setPanelHighlightOnOff(1, true)
          localPlayer.controllerInterface:registerPlayerControl()
          controller.enableGameControls()
          zapWeaponSupport.pauseZapWeaponFuel(false)
          onlineProgressionSystem.onlineWeaponData[1].unlocked = true
          zap.zapSpawn.tutorialPromptsActive = true
          instance.markedVehicleTargetMarker.visible = true
          localPlayer:blockAbility("ZapSpawn", true)
          instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent.gameVehicle.damage = 0
          MPZapToAction.setZapToAction(1, instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent)
          task.networkVars.taskOneComp = false
          task.networkVars.done = true
        end
      end
    end
    if not goalData.extraData or goalData.extraData == 1 then
    elseif goalData.extraData == 2 then
      setTickOnOff(1, true)
      setPanelHighlightOnOff(1, false)
      setPanelHighlightOnOff(2, true)
      task.networkVars.taskOneComp = true
      onlineInstructionSupport.setPrompt("press [] to swap", true)
    elseif goalData.extraData == 3 then
      setTickOnOff(2, true)
      setPanelHighlightOnOff(2, false)
      setPanelHighlightOnOff(3, true)
    elseif goalData.extraData == 4 then
      if not task.networkVars.done then
        setTickOnOff(2, false)
        setPanelHighlightOnOff(3, false)
        setPanelHighlightOnOff(2, true)
      end
    elseif goalData.extraData == 5 then
    elseif goalData.extraData == 6 then
    elseif goalData.extraData == 7 then
      task.networkVars.taskOneComp = false
      onlineInstructionSupport.setPrompt("press [] to swap", false)
      numTags = numTags + 1
      if numTags == 1 then
        feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3", "ID:235728")
      end
      if numTags == 2 then
        zapWeaponSupport.paused()
        zapWeaponSupport.pauseZapWeaponFuel(true)
        setTickOnOff(1, false)
        setTickOnOff(2, false)
        setTickOnOff(3, false)
        feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", 3)
        feedbackSystem.menusMaster.primaryTextPrompt("ID:235749")
        feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3", "ID:243708", "2")
        task.networkVars.done = true
      else
        localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
        feedbackSystem.menusMaster.primaryTextPrompt("ID:235754")
        setTickOnOff(1, false)
        setTickOnOff(2, false)
        setPanelHighlightOnOff(1, true)
        setPanelHighlightOnOff(2, false)
        setPanelHighlightOnOff(3, false)
      end
    elseif goalData.extraData == 8 then
      if goalData.welldone then
        instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent.gameVehicle.damage = 1
      end
    elseif goalData.extraData == 10 then
      if goalData.slotCorrect then
        task.networkVars.taskOneComp = true
        setTickOnOff(1, true)
        setPanelHighlightOnOff(1, false)
        setPanelHighlightOnOff(2, true)
        localPlayer:blockAbility("ZapSpawn", false)
        onlineInstructionSupport.setPrompt("press dpad", false)
        onlineInstructionSupport.setPrompt("press [] to swap", true)
      else
        task.networkVars.taskOneComp = false
        setTickOnOff(1, false)
        setPanelHighlightOnOff(2, false)
        localPlayer:blockAbility("ZapSpawn", true)
        onlineInstructionSupport.setPrompt("press [] to swap", false)
        onlineInstructionSupport.setPrompt("press dpad", true)
        setPanelHighlightOnOff(1, true)
        setPanelHighlightOnOff(2, false)
        setPanelHighlightOnOff(3, false)
      end
    elseif goalData.extraData == 11 then
      setTickOnOff(3, true)
      setPanelHighlightOnOff(3, false)
      zapWeaponSupport.paused()
      zapWeaponSupport.pauseZapWeaponFuel(true)
      feedbackSystem.menusMaster.primaryTextPrompt("ID:235749")
      feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", 0)
      task.networkVars.done = true
    end
  end
  local cleanup = function()
    onlineInstructionSupport.resetPrompts()
    zap.zapSpawn.clearZapSpawnFailedCallbacks()
    localPlayer.registerZapSpawnFailedCallback = nil
    localPlayer.hasZapSpawnFailed = nil
  end
  return goalCallback, nil, cleanup
end)
