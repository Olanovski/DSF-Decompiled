local setTextbox = function(title, text, button)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_title", title)
  if button then
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_textbox", text, nil, button)
  else
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_textbox", text)
  end
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", 4)
end
local setTutorialPanel = function(title, stringOne, buttonOne, stringTwo, buttonTwo, stringThree, buttonThree, panelType, panelPosition)
  if panelPosition ~= 0 then
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_title", title)
    if not buttonOne then
      feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_1", stringOne)
    else
      feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_1", stringOne, nil, buttonOne)
    end
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_1_button", "")
    if not buttonTwo then
      feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_2", stringTwo)
    else
      feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_2", stringTwo, nil, buttonTwo)
    end
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_2_button", "")
    if not buttonThree then
      feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3", stringThree)
    else
      feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3", stringThree, nil, buttonThree)
    end
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3_button", "")
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_Type", panelType)
  end
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", panelPosition)
end
local setContinueButton = function(on)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_continue_button", localPlayer.buttonLayout.accept)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_Continue_Prompt", on)
end
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
        onlineInstructionSupport.displayPrompt("ID:235730", localPlayer.buttonLayout.zapSelect)
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
        onlineInstructionSupport.displayPrompt("ID:243704", localPlayer.buttonLayout.zapDown)
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
        onlineInstructionSupport.displayPrompt("ID:235731", localPlayer.buttonLayout.zapSelect)
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
taskSystem.registerTask("MP shift take tutorial", {
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
  local function zapAttackCallback(vehicle)
    local objTO = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
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
    if promptID.stopVehicle then
      stopPlayer()
    end
    if success then
      if promptID.setSpeed then
        task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]].coreData.actor.desiredSpeed = 88
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
        zap.zapAttack.tutorialPromptsActive2 = false
        task.networkVars.done = true
      end
      if promptID.group == 1 then
        if promptID.subgroup == 1 then
          setTextbox("ID:235656", "ID:235673")
        elseif promptID.subgroup == 2 then
          setContinueButton(1)
        elseif promptID.subgroup == 3 then
          setTutorialPanel("title", "stringOne", false, "stringTwo", false, "stringThree", false, 0, 0)
          setContinueButton(2)
          task.networkVars.done = true
        elseif promptID.subgroup == 4 then
          setTextbox("ID:235950", "ID:235952")
          controller.disableGameControls()
          zap.disableZapSelection()
        elseif promptID.subgroup == 5 then
          setTutorialPanel("title", "stringOne", false, "stringTwo", false, "stringThree", false, 0, 0)
          setContinueButton(2)
          task.networkVars.taskOneComp = true
        end
      elseif promptID.group == 2 then
        if promptID.subgroup == 1 then
          setTextbox("ID:235674", "ID:235676")
        elseif promptID.subgroup == 2 then
          setContinueButton(1)
        elseif promptID.subgroup == 3 then
          setTutorialPanel("title", "stringOne", false, "stringTwo", false, "stringThree", false, 0, 0)
          setContinueButton(2)
          task.networkVars.taskOneComp = true
        elseif promptID.subgroup == 4 then
          setTextbox("ID:235677", "ID:235679", localPlayer.buttonLayout.zapSelect)
        elseif promptID.subgroup == 5 then
          setTutorialPanel("title", "stringOne", false, "stringTwo", false, "stringThree", false, 0, 0)
          setContinueButton(2)
          task.networkVars.taskTwoComp = true
        elseif promptID.subgroup == 6 then
          setTutorialPanel("ID:235920", "ID:235724", false, "ID:235730", localPlayer.buttonLayout.zapSelect, "ID:235731", localPlayer.buttonLayout.zapSelect, 3, 1)
        elseif promptID.subgroup == 7 then
          zapWeaponSupport.paused()
          zapWeaponSupport.pauseZapWeaponFuel(false)
          onlineProgressionSystem.onlineWeaponData[2].unlocked = true
          localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
          zap.zapAttack.tutorialPromptsActive = true
          zap.zapAttack.tutorialPromptsActive2 = true
          controller.enableGameControls()
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235724", false, "ID:235730", localPlayer.buttonLayout.zapSelect, "ID:235731", localPlayer.buttonLayout.zapSelect, 3, 2)
          setPanelHighlightOnOff(1, true)
          task.networkVars.done = true
        end
      elseif promptID.group == 3 then
        if promptID.subgroup == 1 then
          setTextbox("ID:235677", "ID:235680")
          controller.disableGameControls()
        end
      elseif promptID.group == 4 and promptID.subgroup == 1 then
        civilianTraffic.setTrafficOnOff(true)
        setTextbox("ID:235677", "ID:235681")
        controller.disableGameControls()
      end
    elseif promptID.group == 1 then
      setTickOnOff(1, true)
      setPanelHighlightOnOff(1, false)
      setPanelHighlightOnOff(2, true)
      task.networkVars.taskOneComp = true
      onlineInstructionSupport.setPrompt("release X to attack", false)
      onlineInstructionSupport.setPrompt("hold down [] to aim", true)
      onlineInstructionSupport.setPrompt("too far up", true)
    elseif promptID.group == 2 then
      setTickOnOff(2, true)
      setPanelHighlightOnOff(2, false)
      setPanelHighlightOnOff(3, true)
      task.networkVars.taskTwoComp = true
      onlineInstructionSupport.setPrompt("release X to attack", true)
      onlineInstructionSupport.setPrompt("hold down [] to aim", false)
      onlineInstructionSupport.setPrompt("too far up", false)
    elseif promptID.group == 3 then
      setTickOnOff(1, false)
      setPanelHighlightOnOff(1, true)
      setPanelHighlightOnOff(2, false)
      task.networkVars.taskOneComp = false
      onlineInstructionSupport.setPrompt("release X to attack", false)
      onlineInstructionSupport.setPrompt("hold down [] to aim", false)
      onlineInstructionSupport.setPrompt("too far up", false)
    elseif promptID.group == 4 then
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
  end
  local cleanup = function()
    zap.zapAttack.clearAttackCallback()
    onlineInstructionSupport.resetPrompts()
  end
  return goalCallback, nil, cleanup
end)
