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
local setInstructionPrompts = function()
  onlineInstructionSupport.setPrompts(false, false, false, false, false, false, false, false, false, false, false, false, false, false)
  onlineInstructionSupport.addPrompt("press [] to swap", {
    enabled = false,
    shown = false,
    resetOnScore = true,
    startTime = 8,
    resetTime = 5,
    displayFunction = function()
      local task = localPlayer.getTaskObject().taskList[#localPlayer.getTaskObject().taskList][1]
      if task.networkVars.taskOneComp and not task.networkVars.taskTwoComp then
        onlineInstructionSupport.displayPrompt("ID:235725", localPlayer.buttonLayout.vehicleSwap)
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
taskSystem.registerTask("MP vehicle swap tutorial", {
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
  if task.majorOrder == 3 or task.majorOrder == 6 or task.majorOrder == 9 then
    setInstructionPrompts()
  end
  local numSwaps = 0
  local function goalCallback(success, condition, missionData, goalData)
    if goalData.clear then
      setTickOnOff(1, false)
      setTickOnOff(2, false)
      setTickOnOff(3, false)
      feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", 3)
      task.networkVars.done = true
      setPanelHighlightOnOff(1, false)
      setPanelHighlightOnOff(2, false)
      setPanelHighlightOnOff(3, false)
      zap.zapSwap.tutorialPromptsActive = false
    end
    if goalData.welldone then
      zapWeaponSupport.paused()
      zapWeaponSupport.pauseZapWeaponFuel(true)
      feedbackSystem.menusMaster.primaryTextPrompt("ID:235749")
      zap.zapSwap.tutorialPromptsActive = false
      task.networkVars.done = true
    end
    if goalData.promptID then
      if goalData.promptID == 1 then
        if goalData.subgroup == 1 then
          setTextbox("ID:235656", "ID:235658")
          localPlayer.controllerInterface:removePlayerControl()
          controller.disableGameControls()
          stopPlayer()
        elseif goalData.subgroup == 2 then
          setContinueButton(1)
        elseif goalData.subgroup == 3 then
          setTutorialPanel("title", "stringOne", nil, nil, "stringTwo", nil, nil, "stringThree", nil, nil, 0, 0)
          setContinueButton(2)
          task.networkVars.done = true
        elseif goalData.subgroup == 4 then
          setTextbox("ID:235958", "ID:235961")
          localPlayer.controllerInterface:removePlayerControl()
          controller.disableGameControls()
          stopPlayer()
        elseif goalData.subgroup == 5 then
          setContinueButton(1)
        elseif goalData.subgroup == 6 then
          setTutorialPanel("title", "stringOne", nil, nil, "stringTwo", nil, nil, "stringThree", nil, nil, 0, 0)
          setContinueButton(2)
          task.networkVars.taskOneComp = true
        end
      elseif goalData.promptID == 2 then
        if goalData.subgroup == 1 then
          setTextbox("ID:235659", "ID:235660")
        elseif goalData.subgroup == 2 then
          setContinueButton(1)
        elseif goalData.subgroup == 3 then
          setTutorialPanel("title", "stringOne", nil, nil, "stringTwo", nil, nil, "stringThree", nil, nil, 0, 0)
          setContinueButton(2)
          task.networkVars.taskOneComp = true
        elseif goalData.subgroup == 4 then
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:235725", nil, localPlayer.buttonLayout.vehicleSwap, "", nil, nil, 2, 1)
        elseif goalData.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:235725", nil, localPlayer.buttonLayout.vehicleSwap, "", nil, nil, 2, 2)
          setPanelHighlightOnOff(1, true)
          localPlayer.controllerInterface:registerPlayerControl()
          controller.enableGameControls()
          zapWeaponSupport.pauseZapWeaponFuel(false)
          onlineProgressionSystem.onlineWeaponData[1].unlocked = true
          zap.zapSwap.tutorialPromptsActive = true
          task.networkVars.done = true
        end
      elseif goalData.promptID == 3 then
        if goalData.subgroup == 1 then
          setTextbox("ID:235662", "ID:235663")
          stopPlayer()
          feedbackSystem.menusMaster.enableDamageBar(localPlayer)
          GameVehicleResource.applyDamage({
            gameVehicle = localPlayer.currentVehicle.gameVehicle,
            damage = 0.9
          })
          localPlayer.controllerInterface:removePlayerControl()
          controller.disableGameControls()
        elseif goalData.subgroup == 4 then
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:235725", nil, localPlayer.buttonLayout.vehicleSwap, "", nil, nil, 2, 1)
        elseif goalData.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:235725", nil, localPlayer.buttonLayout.vehicleSwap, "", nil, nil, 2, 2)
          setPanelHighlightOnOff(1, true)
          localPlayer.controllerInterface:registerPlayerControl()
          controller.enableGameControls()
          zapWeaponSupport.pauseZapWeaponFuel(false)
          onlineProgressionSystem.onlineWeaponData[1].unlocked = true
          zap.zapSwap.tutorialPromptsActive = true
          task.networkVars.done = true
        end
      elseif goalData.promptID == 4 then
        if goalData.subgroup == 1 then
          setTextbox("ID:235664", "ID:235665")
          stopPlayer()
          onlineProgressionSystem.onlineWeaponData[1].unlocked = false
          localPlayer.controllerInterface:removePlayerControl()
          controller.disableGameControls()
        elseif goalData.subgroup == 4 then
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:243711", "3", nil, "", nil, nil, 2, 1)
        elseif goalData.subgroup == 5 then
          setContinueButton(2)
          setTutorialPanel("ID:235920", "ID:235724", nil, nil, "ID:243711", "3", nil, "", nil, nil, 2, 2)
          setPanelHighlightOnOff(1, true)
          localPlayer.controllerInterface:registerPlayerControl()
          controller.enableGameControls()
          zapWeaponSupport.pauseZapWeaponFuel(false)
          onlineProgressionSystem.onlineWeaponData[1].unlocked = true
          zap.zapSwap.tutorialPromptsActive = true
          localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
          task.networkVars.done = true
        end
      end
    end
    if goalData.extraData then
      if goalData.extraData == 2 then
        setTickOnOff(1, true)
        setPanelHighlightOnOff(1, false)
        setPanelHighlightOnOff(2, true)
        task.networkVars.taskOneComp = true
        onlineInstructionSupport.setPrompt("press [] to swap", true)
      elseif goalData.extraData == 3 then
        setTickOnOff(2, true)
        setPanelHighlightOnOff(2, false)
        setPanelHighlightOnOff(3, true)
        task.networkVars.done = true
      elseif goalData.extraData == 6 then
        numSwaps = numSwaps + 1
        if numSwaps < 3 then
          localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
        end
        if numSwaps == 1 then
          feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_2", "ID:243711", "2")
        elseif numSwaps == 2 then
          feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_2", "ID:243710")
        end
        if numSwaps == 3 then
          feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_2", "ID:243711", "3")
          task.networkVars.done = true
        else
          feedbackSystem.menusMaster.primaryTextPrompt("ID:235750")
          setTickOnOff(1, false)
          setPanelHighlightOnOff(1, true)
          setPanelHighlightOnOff(2, false)
          setPanelHighlightOnOff(3, false)
        end
      end
    end
  end
  local cleanup = function()
    onlineInstructionSupport.resetPrompts()
  end
  return goalCallback, nil, cleanup
end)
