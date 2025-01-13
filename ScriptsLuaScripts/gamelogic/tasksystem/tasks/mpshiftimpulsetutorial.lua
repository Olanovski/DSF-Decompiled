local setTextbox = function(title, text, button)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_title", title)
  if button then
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_textbox", text, nil, button)
  else
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_textbox", text)
  end
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
local setInstructionPrompts = function()
  onlineInstructionSupport.setPrompts(false, false, false, false, false, false, false, false, false, false, false, false, false, false)
  onlineInstructionSupport.addPrompt("hold down [] to aim", {
    enabled = false,
    shown = false,
    resetOnScore = true,
    startTime = 8,
    resetTime = 5,
    displayFunction = function()
      local task = localPlayer.getTaskObject().taskList[#localPlayer.getTaskObject().taskList][1]
      if task.networkVars.taskOneComp and not task.networkVars.taskTwoComp and zapcontroller.getZapLevel(0) == 1 then
        onlineInstructionSupport.displayPrompt("ID:235732", localPlayer.buttonLayout.zapAttack)
        return true
      end
      return false
    end
  })
  onlineInstructionSupport.addPrompt("too far up", {
    enabled = false,
    shown = false,
    resetOnScore = true,
    startTime = 5,
    resetTime = 10,
    displayFunction = function()
      local task = localPlayer.getTaskObject().taskList[#localPlayer.getTaskObject().taskList][1]
      if task.networkVars.taskOneComp and not task.networkVars.taskTwoComp and 1 < zapcontroller.getZapLevel(0) then
        onlineInstructionSupport.displayPrompt("ID:243706", localPlayer.buttonLayout.zapDown)
        return true
      end
      return false
    end
  })
  onlineInstructionSupport.addPrompt("release X to attack", {
    enabled = false,
    shown = false,
    resetOnScore = true,
    startTime = 2,
    resetTime = 5,
    displayFunction = function()
      local task = localPlayer.getTaskObject().taskList[#localPlayer.getTaskObject().taskList][1]
      if task.networkVars.taskOneComp and task.networkVars.taskTwoComp and not task.networkVars.taskThreeComp then
        onlineInstructionSupport.displayPrompt("ID:235733", localPlayer.buttonLayout.zapAttack)
        return true
      end
      return false
    end
  })
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
taskSystem.registerTask("MP shift impulse tutorial", {
  {
    name = "done",
    startingValue = false,
    parseType = "boolean"
  },
  {
    name = "impulsedVehicle",
    startingValue = false,
    parseType = "boolean"
  },
  {
    name = "impulseCount",
    startingValue = 0,
    parseType = "uinteger8"
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
  local target = {
    type = "Target",
    gadgetID = 180,
    targetType = "MultiplayerObjective",
    colour = OnlineModeSettings.red32 + OnlineModeSettings.targetAlphaMask32,
    markerOffset = 1,
    radius = 45,
    visible = true
  }
  local instance = task.instance
  local function zapAttackCallback(vehicle)
    local objTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    if objTO and objTO.coreData.agent and objTO.coreData.agent == vehicle then
      task.networkVars.impulsedVehicle = true
      if not objTO.coreData.agent.zapImpulsed then
        objTO.coreData.agent.zapImpulsed = true
      end
    end
  end
  zap.zapAttack.addAttackCallback(zapAttackCallback)
  if task.majorOrder == 3 or task.majorOrder == 6 or task.majorOrder == 9 then
    setInstructionPrompts()
  end
  local function goalCallback(success, condition, missionData, promptID)
    if success then
      if promptID.setSpeed then
        instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.actor.desiredSpeed = 88
        task.networkVars.done = true
      end
      if promptID.clear then
        setTickOnOff(1, false)
        setTickOnOff(2, false)
        setTickOnOff(3, false)
        setPanelHighlightOnOff(1, false)
        setPanelHighlightOnOff(2, false)
        setPanelHighlightOnOff(3, false)
        feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", 3)
        task.networkVars.done = true
      end
      if promptID.welldone then
        setTickOnOff(1, false)
        setTickOnOff(2, false)
        setTickOnOff(3, true)
        setPanelHighlightOnOff(3, false)
        zapWeaponSupport.paused()
        zapWeaponSupport.pauseZapWeaponFuel(true)
        task.networkVars.taskThreeComp = true
        feedbackSystem.menusMaster.primaryTextPrompt("ID:235749")
        feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3_button", "")
        zap.zapAttack.tutorialPromptsActive = false
        task.networkVars.done = true
        MPZapToAction.reset()
      end
      if promptID.group == 1 then
        if promptID.subgroup == 1 then
          setTextbox("ID:235656", "ID:235682")
        elseif promptID.subgroup == 2 then
          setContinueButton(1)
        elseif promptID.subgroup == 3 then
          setTutorialPanel("title", "stringOne", nil, nil, "stringTwo", nil, nil, "stringThree", nil, nil, 0, 0)
          setContinueButton(2)
          task.networkVars.done = true
          zap.disableZapSelection()
        elseif promptID.subgroup == 4 then
          setTextbox("ID:235947", "ID:235949")
          controller.disableGameControls()
        elseif promptID.subgroup == 5 then
          setTutorialPanel("title", "stringOne", nil, nil, "stringTwo", nil, nil, "stringThree", nil, nil, 0, 0)
          setContinueButton(2)
          task.networkVars.taskOneComp = true
        end
      elseif promptID.group == 2 then
        if promptID.subgroup == 1 then
          setTextbox("ID:235683", "ID:235684", localPlayer.buttonLayout.zapAttack)
          zapcontroller.setRenderTarget(false, 0)
        elseif promptID.subgroup == 2 then
          setContinueButton(1)
        elseif promptID.subgroup == 3 then
          setTutorialPanel("title", "stringOne", nil, nil, "stringTwo", nil, nil, "stringThree", nil, nil, 0, 0)
          setContinueButton(2)
          task.networkVars.taskOneComp = true
        elseif promptID.subgroup == 4 then
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:235732", nil, localPlayer.buttonLayout.zapAttack, "ID:235733", nil, localPlayer.buttonLayout.zapAttack, 3, 1)
        elseif promptID.subgroup == 5 then
          zapWeaponSupport.paused()
          zapWeaponSupport.pauseZapWeaponFuel(false)
          onlineProgressionSystem.onlineWeaponData[2].unlocked = true
          localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
          zap.zapAttack.tutorialPromptsActive = true
          zapcontroller.setRenderTarget(true, 0)
          controller.enableGameControls()
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:235732", nil, localPlayer.buttonLayout.zapAttack, "ID:235733", nil, localPlayer.buttonLayout.zapAttack, 3, 2)
          setPanelHighlightOnOff(1, true)
          task.networkVars.done = true
          target.gameVehicle = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent.gameVehicle
          instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent:addLightTrail(32, OnlineModeSettings.red128)
          instance.impulseVehicleTargetMarker = Marker:create(target)
          instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent:disableDisplay(false)
          instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent:setDisplayColour(OnlineModeSettings.teamRed, OnlineModeSettings.red128)
        end
      elseif promptID.group == 3 then
        if promptID.subgroup == 1 then
          zapcontroller.EnableZapInput(false, localPlayer.localID)
          setTextbox("ID:235683", "ID:235687")
          zapcontroller.setRenderTarget(false, 0)
          instance.impulseVehicleTargetMarker.visible = false
        elseif promptID.subgroup == 5 then
          zapWeaponSupport.paused()
          zapWeaponSupport.pauseZapWeaponFuel(false)
          zapcontroller.EnableZapInput(true, localPlayer.localID)
          zap.zapAttack.tutorialPromptsActive = true
          zapcontroller.setRenderTarget(true, 0)
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:235732", nil, localPlayer.buttonLayout.zapAttack, "ID:235733", nil, localPlayer.buttonLayout.zapAttack, 3, 2)
          setPanelHighlightOnOff(1, true)
          instance.impulseVehicleTargetMarker.visible = true
          instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent.gameVehicle.damage = 0
          MPZapToAction.setZapToAction(1, instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent)
          task.networkVars.done = true
        end
      elseif promptID.group == 4 then
        if promptID.subgroup == 1 then
          zapcontroller.EnableZapInput(false, localPlayer.localID)
          civilianTraffic.setTrafficOnOff(true)
          setTextbox("ID:235683", "ID:235690")
          zapcontroller.setRenderTarget(false, 0)
          instance.impulseVehicleTargetMarker.visible = false
        elseif promptID.subgroup == 4 then
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:235732", nil, localPlayer.buttonLayout.zapAttack, "ID:243739", "3", nil, 3, 1)
        elseif promptID.subgroup == 5 then
          zapWeaponSupport.paused()
          zapWeaponSupport.pauseZapWeaponFuel(false)
          zapcontroller.EnableZapInput(true, localPlayer.localID)
          zap.zapAttack.tutorialPromptsActive = true
          zapcontroller.setRenderTarget(true, 0)
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:235732", nil, localPlayer.buttonLayout.zapAttack, "ID:243739", "3", nil, 3, 2)
          instance.impulseVehicleTargetMarker.visible = true
          instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent.gameVehicle.damage = 0
          MPZapToAction.setZapToAction(1, instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.agent)
          setPanelHighlightOnOff(1, true)
          task.networkVars.done = true
        end
      elseif promptID.group == 5 then
        if promptID.subgroup == 1 then
          setTextbox("ID:246494", "ID:246495")
          controller.disableGameControls()
        elseif promptID.subgroup == 2 then
          setContinueButton(1)
        elseif promptID.subgroup == 5 then
          setTutorialPanel("title", "stringOne", nil, nil, "stringTwo", nil, nil, "stringThree", nil, nil, 0, 0)
          setContinueButton(2)
          task.networkVars.done = true
          zapWeaponSupport.paused()
          zapWeaponSupport.pauseZapWeaponFuel(false)
          zapcontroller.EnableZapInput(true, localPlayer.localID)
          zapcontroller.setRenderTarget(true, 0)
          controller.enableGameControls()
        end
      end
    else
      if promptID.group == 1 then
        setTickOnOff(1, true)
        setPanelHighlightOnOff(1, false)
        setPanelHighlightOnOff(2, true)
        task.networkVars.taskOneComp = true
        onlineInstructionSupport.setPrompt("hold down [] to aim", true)
        onlineInstructionSupport.setPrompt("too far up", true)
      end
      if promptID.group == 2 then
        task.networkVars.impulseCount = task.networkVars.impulseCount + 1
        task.networkVars.impulsedVehicle = false
        if task.networkVars.impulseCount == 1 then
          feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3", "ID:243739", "2")
        else
          feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3", "ID:243738")
        end
        if task.networkVars.impulseCount == 3 then
          task.networkVars.taskThreeComp = true
          feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3", "ID:243739", "3")
        else
          feedbackSystem.menusMaster.primaryTextPrompt("ID:235755")
        end
      end
      if promptID.group == 3 then
        setTickOnOff(1, false)
        setPanelHighlightOnOff(1, true)
        setPanelHighlightOnOff(2, false)
        task.networkVars.taskOneComp = false
        onlineInstructionSupport.setPrompt("release X to attack", false)
        onlineInstructionSupport.setPrompt("hold down [] to aim", false)
        onlineInstructionSupport.setPrompt("too far up", false)
      end
      if promptID.group == 4 then
        setTickOnOff(2, false)
        if task.networkVars.taskOneComp then
          setPanelHighlightOnOff(2, true)
          onlineInstructionSupport.setPrompt("hold down [] to aim", true)
          onlineInstructionSupport.setPrompt("too far up", true)
        else
          setPanelHighlightOnOff(2, false)
          setPanelHighlightOnOff(1, true)
          onlineInstructionSupport.setPrompt("hold down [] to aim", false)
          onlineInstructionSupport.setPrompt("too far up", false)
        end
        setPanelHighlightOnOff(3, false)
        task.networkVars.taskTwoComp = false
        onlineInstructionSupport.setPrompt("release X to attack", false)
      end
      if promptID.group == 5 then
        task.networkVars.taskTwoComp = true
        setTickOnOff(2, true)
        setPanelHighlightOnOff(2, false)
        setPanelHighlightOnOff(3, true)
        onlineInstructionSupport.setPrompt("release X to attack", true)
        onlineInstructionSupport.setPrompt("hold down [] to aim", false)
        onlineInstructionSupport.setPrompt("too far up", false)
      end
    end
  end
  local cleanup = function()
    zap.zapAttack.clearAttackCallback()
    onlineInstructionSupport.resetPrompts()
  end
  return goalCallback, nil, cleanup
end)
