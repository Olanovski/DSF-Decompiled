module("feedbackSystem.menusMaster", package.seeall)
currentControllerPreset = {}
local masterVariables = {}
local onlineVariables = {}
local onlineHUDVariables = {}
local splitscreenVariables = {}
local mmPrimaryPromptVar = "iPrompt_Primary_Display"
local mmSecondaryPromptVar = "iPrompt_Secondary_Display"
local onlinePrimaryPrompt = false
local onlinePrimaryPromptRed = false
local primaryPromptPriority = 5
primaryPromptActive = false
local primaryFelonyActive = false
local primaryPromptOnScreen = false
local primaryCounterActive = false
local primaryCounterPrompt = false
local primaryCounterIcon = false
local primaryCounterCount
local promptHidden = false
local blockPrimaryUpdate = false
secondaryPromptActive = false
local secondaryPromptOnScreen = false
local secondaryCounterActive = false
local secondaryCounterValue = false
local secondaryCounterIcon = false
local secondaryCounterCount
local blockSecondaryUpdate = false
minimapPromptActive = false
local felonyActive = false
local minimapPromptOnScreen = false
local blockMinimapUpdate = false
local primaryPromptDelayTime = 3 * updates.stepRate
local primaryPromptShowTime = 7 * updates.stepRate
local secondaryPromptDelayTime = 3 * updates.stepRate
local secondaryPromptShowTime = 7 * updates.stepRate
local minimapPromptDelayTime = 3 * updates.stepRate
local minimapPromptShowTime = 5 * updates.stepRate
local currentPromptInfo = {
  prompt_primary = {
    prompt = nil,
    icon1 = nil,
    icon2 = nil
  },
  prompt_secondary = {
    prompt = nil,
    icon1 = nil,
    icon2 = nil
  },
  middle_prompt = {
    prompt = nil,
    icon1 = nil,
    icon2 = nil
  },
  tutorial_textbox = {
    prompt = nil,
    icon1 = nil,
    icon2 = nil
  },
  tutorial_string_1 = {
    prompt = nil,
    icon1 = nil,
    icon2 = nil
  },
  tutorial_string_2 = {
    prompt = nil,
    icon1 = nil,
    icon2 = nil
  },
  tutorial_string_3 = {
    prompt = nil,
    icon1 = nil,
    icon2 = nil
  }
}
local function setupButtonsForPrompts()
  feedbackSystem.menusMaster.currentHUDSetTextVariable("focus_button", localPlayer.buttonLayout.focusButton)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("zap_triangle", localPlayer.buttonLayout.zapSelect)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("minimap_button", localPlayer.buttonLayout.minimapZoom)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("prompt_secondary_button", localPlayer.buttonLayout.previewDare)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("stick_waggle_button", localPlayer.buttonLayout.waggle)
  Marker.TargetRapidShiftIcon = buttonsTable[localPlayer.buttonLayout.zapReturn.button]
  for k, v in next, currentPromptInfo, nil do
    if v.icon1 then
      v.icon1 = localPlayer.buttonLayout[v.icon1.buttonID]
    end
    if v.icon2 then
      v.icon2 = localPlayer.buttonLayout[v.icon2.buttonID]
    end
    if v.icon1 then
      currentHUDSetTextVariable(k, v.prompt, nil, v.icon1, v.icon2)
    end
  end
end
function updatePromptTable(promptCall, prompt, icon1, icon2)
  if promptCall then
    currentPromptInfo[promptCall].prompt = prompt or nil
    currentPromptInfo[promptCall].icon1 = icon1 or nil
    currentPromptInfo[promptCall].icon2 = icon2 or nil
  end
end
function clearPromptTable(promptCall)
  if promptCall then
    currentPromptInfo[promptCall].prompt = nil
    currentPromptInfo[promptCall].icon1 = nil
    currentPromptInfo[promptCall].icon2 = nil
  end
end
function masterSetVariable(variable, state)
  if variable then
    if not masterVariables then
      masterVariables = {}
    end
    if not masterVariables[variable] then
      masterVariables[variable] = Menu.AddVariable("Master", variable)
    end
    if masterVariables[variable] then
      Menu.SetVariable(masterVariables[variable], state)
    end
  end
end
function masterSetTextVariable(variable, text, value, icon1, icon2, value2, value3)
  local setIcon1, setIcon2
  if currentPromptInfo[variable] then
    updatePromptTable(variable, text, icon1, icon2)
  end
  if text then
    if not icon1 and (type(text) == "table" and buttonsTable[text.button] or iconsTableCheck[text]) then
      setIcon1 = buttonsTable[text.button] or iconsTableCheck[text]
      Menu.SetTextVariableIcon("Master", variable, "%S", setIcon1)
    elseif icon1 then
      setIcon1 = buttonsTable[icon1.button] or iconsTableCheck[icon1] or nil
      setIcon2 = not icon2 or buttonsTable[icon2.button] or iconsTableCheck[icon2] or nil
      Menu.SetTextVariableIcon("Master", variable, text, setIcon1, setIcon2)
    else
      Menu.SetTextVariable("Master", variable, text, value, value2, value3)
    end
  end
end
function masterSetTextVariableParams(params)
  masterSetTextVariable(params.variable, params.text, params.value1, params.icon1, params.icon2, params.value2, params.value3)
end
function onlineSetVariable(variable, state)
  if variable then
    if not onlineVariables then
      onlineVariables = {}
    end
    if not onlineVariables[variable] then
      onlineVariables[variable] = Menu.AddVariable("Online", variable)
    end
    if onlineVariables[variable] then
      Menu.SetVariable(onlineVariables[variable], state)
    end
  end
end
function onlineHUDSetTextVariable(variable, text, value, icon1, icon2, value2)
  local setIcon1, setIcon2
  if text then
    if not icon1 and (type(text) == "table" and buttonsTable[text.button] or iconsTableCheck[text]) then
      setIcon1 = buttonsTable[text.button] or iconsTableCheck[text]
      Menu.SetTextVariableIcon("Online_HUD", variable, "%S", setIcon1)
    elseif icon1 then
      setIcon1 = buttonsTable[icon1.button] or iconsTableCheck[icon1] or nil
      setIcon2 = not icon2 or buttonsTable[icon2.button] or iconsTableCheck[icon2] or nil
      Menu.SetTextVariableIcon("Online_HUD", variable, text, setIcon1, setIcon2)
    else
      Menu.SetTextVariable("Online_HUD", variable, text, value, value2)
    end
  end
end
function onlineHUDSetVariable(variable, state)
  if variable then
    if not onlineHUDVariables then
      onlineHUDVariables = {}
    end
    if not onlineHUDVariables[variable] then
      onlineHUDVariables[variable] = Menu.AddVariable("Online_HUD", variable)
    end
    if onlineHUDVariables[variable] then
      Menu.SetVariable(onlineHUDVariables[variable], state)
    end
  end
end
function onlineSetTextVariable(variable, text, value, icon1, icon2, value2)
  local setIcon1, setIcon2
  if text then
    if not icon1 and (type(text) == "table" and buttonsTable[text.button] or iconsTableCheck[text]) then
      setIcon1 = buttonsTable[text.button] or iconsTableCheck[text]
      Menu.SetTextVariableIcon("Online", variable, "%S", setIcon1)
    elseif icon1 then
      setIcon1 = buttonsTable[icon1.button] or iconsTableCheck[icon1] or nil
      setIcon2 = not icon2 or buttonsTable[icon2.button] or iconsTableCheck[icon2] or nil
      Menu.SetTextVariableIcon("Online", variable, text, setIcon1, setIcon2)
    else
      Menu.SetTextVariable("Online", variable, text, value, value2)
    end
  end
end
function splitscreenSetVariable(variable, state)
  if variable then
    if not splitscreenVariables then
      splitscreenVariables = {}
    end
    if not splitscreenVariables[variable] then
      splitscreenVariables[variable] = Menu.AddVariable("Splitscreen", variable)
    end
    if splitscreenVariables[variable] then
      Menu.SetVariable(splitscreenVariables[variable], state)
    end
  end
end
function splitscreenSetTextVariable(variable, text, value, icon1, icon2, value2)
  local setIcon1, setIcon2
  if text then
    if not icon1 and (type(text) == "table" and buttonsTable[text.button] or iconsTableCheck[text]) then
      setIcon1 = buttonsTable[text.button] or iconsTableCheck[text]
      Menu.SetTextVariableIcon("Splitscreen", variable, "%S", setIcon1)
    elseif icon1 then
      setIcon1 = buttonsTable[icon1.button] or iconsTableCheck[icon1] or nil
      setIcon2 = not icon2 or buttonsTable[icon2.button] or iconsTableCheck[icon2] or nil
      Menu.SetTextVariableIcon("Splitscreen", variable, text, setIcon1, setIcon2)
    else
      Menu.SetTextVariable("Splitscreen", variable, text, value, value2)
    end
  end
end
function splitscreenMenusSetVariable(variable, state)
  if variable then
    if not splitscreenVariables then
      splitscreenVariables = {}
    end
    if not splitscreenVariables[variable] then
      splitscreenVariables[variable] = Menu.AddVariable("SplitscreenMenus", variable)
    end
    if splitscreenVariables[variable] then
      Menu.SetVariable(splitscreenVariables[variable], state)
    end
  end
end
function splitscreenMenusSetTextVariable(variable, text, value, icon1, icon2, value2)
  local setIcon1, setIcon2
  if text then
    if not icon1 and (type(text) == "table" and buttonsTable[text.button] or iconsTableCheck[text]) then
      setIcon1 = buttonsTable[text.button] or iconsTableCheck[text]
      Menu.SetTextVariableIcon("SplitscreenMenus", variable, "%S", setIcon1)
    elseif icon1 then
      setIcon1 = buttonsTable[icon1.button] or iconsTableCheck[icon1] or nil
      setIcon2 = not icon2 or buttonsTable[icon2.button] or iconsTableCheck[icon2] or nil
      Menu.SetTextVariableIcon("SplitscreenMenus", variable, text, setIcon1, setIcon2)
    else
      Menu.SetTextVariable("SplitscreenMenus", variable, text, value, value2)
    end
  end
end
function currentHUDSetVariable(variable, state)
  if gameStatus.splitscreenSession then
    splitscreenSetVariable(variable, state)
  elseif gameStatus.onlineSession and not gameStatus.splitscreenSession then
    onlineHUDSetVariable(variable, state)
  else
    masterSetVariable(variable, state)
  end
end
function currentHUDSetTextVariable(variable, text, value, icon1, icon2, value2)
  if gameStatus.splitscreenSession then
    splitscreenSetTextVariable(variable, text, value, icon1, icon2, value2)
  elseif Network.isOnlineGame() and not gameStatus.splitscreenSession then
    onlineHUDSetTextVariable(variable, text, value, icon1, icon2, value2)
  else
    masterSetTextVariable(variable, text, value, icon1, icon2, value2)
  end
end
function clearMenusMasterVariables()
  masterVariables = nil
  onlineVariables = nil
  onlineHUDVariables = nil
  splitscreenVariables = nil
end
_G.clearMenusMasterVariables = clearMenusMasterVariables
local getBindedButtons = function(_actionSet)
  local preset = {}
  local actions = {
    enterZap = {actionPage = 0, actionId = 10},
    zapReturn = {actionPage = 1, actionId = 12},
    zapUp = {actionPage = 1, actionId = 4},
    zapUpShoulder = {actionPage = 1, actionId = 10},
    zapDown = {actionPage = 1, actionId = 5},
    zapDownShoulder = {actionPage = 1, actionId = 10},
    zapUpDown = {actionPage = nil, actionId = nil},
    zapSelect = {actionPage = 0, actionId = 10},
    zapAttack = {actionPage = 1, actionId = 8},
    moveHighlight = {actionPage = 0, actionId = 10},
    cancel = {actionPage = nil, actionId = nil},
    previewDare = {actionPage = nil, actionId = nil},
    accelerate = {actionPage = 0, actionId = 0},
    vehicleBrake = {actionPage = 0, actionId = 1},
    minimapZoom = {actionPage = 0, actionId = 8},
    vehicleSwap = {actionPage = 1, actionId = 9},
    waggle = {actionPage = nil, actionId = nil},
    helicopterScan = {actionPage = nil, actionId = nil},
    focusButton = {actionPage = nil, actionId = nil},
    vehicleSlot2 = {actionPage = nil, actionId = nil},
    handbrake = {actionPage = 0, actionId = 4},
    boostAbility = {actionPage = 0, actionId = 5},
    ramAbility = {actionPage = 0, actionId = 6},
    changeCamera = {actionPage = 0, actionId = 12},
    exitBus = {actionPage = nil, actionId = nil},
    trunked = {actionPage = nil, actionId = nil},
    accept = {actionPage = nil, actionId = nil},
    reject = {actionPage = nil, actionId = nil},
    openLeaderboard = {actionPage = nil, actionId = nil},
    scrollPlayerList = {actionPage = nil, actionId = nil},
    lookBack = {actionPage = 0, actionId = 15},
    vehicleSlot1 = {actionPage = 1, actionId = 10},
    vehicleSlot2 = {actionPage = 1, actionId = 11}
  }
  for i, v in pairs(actions) do
    if v.actionPage and v.actionId then
      local iconId = Menu.GetAssignedButtonIcon(_actionSet, v.actionPage, v.actionId)
      preset[i] = {
        buttonID = i,
        button = "button" .. tostring(iconId)
      }
    end
  end
  if _actionSet == 0 then
    preset.cancel = {
      buttonID = "cancel",
      button = "button57455"
    }
    local hintButtonIcon = Menu.GetAssignedButtonIcon(_actionSet, 0, 9)
    preset.previewDare = {
      buttonID = "previewDare",
      button = "button" .. tostring(hintButtonIcon)
    }
    preset.waggle = {buttonID = "waggle", button = "button1042"}
    preset.helicopterScan = {
      buttonID = "helicopterScan",
      button = preset.enterZap.button
    }
    preset.focusButton = {
      buttonID = "focusButton",
      button = "button" .. tostring(hintButtonIcon)
    }
    preset.exitBus = {
      buttonID = "exitBus",
      button = "button57455"
    }
    preset.trunked = {
      buttonID = "trunked",
      button = "button57444"
    }
    preset.accept = {
      buttonID = "accept",
      button = "button57444"
    }
    preset.reject = {
      buttonID = "reject",
      button = "button57455"
    }
    preset.openLeaderboard = {
      buttonID = "openLeaderboard",
      button = "button57367"
    }
    preset.scrollPlayerList = {
      buttonID = "scrollPlayerList",
      button = "button57440"
    }
    preset.scrollPlayerList2 = {
      buttonID = "scrollPlayerList",
      button = "button57441"
    }
    preset.zapUpDown = {
      buttonID = "zapUpDown",
      button = "button117",
      useSeparated = true
    }
    local nextIcon = Menu.GetAssignedButtonIcon(_actionSet, 0, 16)
    local playIcon = Menu.GetAssignedButtonIcon(_actionSet, 0, 18)
    local prevIcon = Menu.GetAssignedButtonIcon(_actionSet, 0, 17)
    Menu.SetTextVariableIcon("Master", "music_dpad", "%S%S%S", prevIcon, playIcon, nextIcon)
    Menu.SetTextVariableIcon("Master", "ExtraSecondIcon", "%S", 57369)
    Menu.SetTextVariableIcon("Master", "ScrollIcon", "%S%S", 57440, 57441)
    feedbackSystem.menusMaster.masterSetTextVariable("stick_waggle_button", "")
    feedbackSystem.menusMaster.masterSetTextVariable("stick_waggle_button_reference", "")
    Menu.SetTextVariableIcon("Master", "stick_waggle_description", "ID:249116", Menu.GetAssignedButtonIcon(_actionSet, 0, 2), Menu.GetAssignedButtonIcon(_actionSet, 0, 3))
    Menu.SetTextVariableIcon("Online_HUD", "multi_dpad_up", "%S", Menu.GetAssignedButtonIcon(_actionSet, actions.vehicleSlot1.actionPage, actions.vehicleSlot1.actionId))
    Menu.SetTextVariableIcon("Online_HUD", "multi_dpad_down", "%S", Menu.GetAssignedButtonIcon(_actionSet, actions.vehicleSlot2.actionPage, actions.vehicleSlot2.actionId))
  elseif _actionSet == 1 then
    preset.zapUpDown = {buttonID = "zapUpDown", button = "button709"}
    preset.cancel = {buttonID = "cancel", button = "button594"}
    preset.previewDare = {
      buttonID = "previewDare",
      button = "button592"
    }
    preset.waggle = {buttonID = "waggle", button = "button602"}
    preset.helicopterScan = {
      buttonID = "helicopterScan",
      button = "button595"
    }
    preset.focusButton = {
      buttonID = "focusButton",
      button = "button592"
    }
    preset.vehicleSlot2 = {
      buttonID = "vehicleSlot2",
      button = "button606"
    }
    preset.exitBus = {buttonID = "exitBus", button = "button600"}
    preset.trunked = {buttonID = "trunked", button = "button595"}
    preset.accept = {buttonID = "accept", button = "button595"}
    preset.reject = {buttonID = "reject", button = "button594"}
    preset.openLeaderboard = {
      buttonID = "openLeaderboard",
      button = "button592"
    }
    preset.scrollPlayerList = {
      buttonID = "scrollPlayerList",
      button = "button604"
    }
    Menu.SetTextVariableIcon("Master", "music_dpad", "%S", 604)
    Menu.SetTextVariableIcon("Master", "ExtraSecondIcon", "%S", 593)
    Menu.SetTextVariableIcon("Master", "ScrollIcon", "%S", 709)
    Menu.SetTextVariableIcon("Master", "stick_waggle_description", "ID:221137")
    Menu.SetTextVariableIcon("stick_waggle_button", 602)
    Menu.SetTextVariableIcon("stick_waggle_button_reference", 602)
    Menu.SetTextVariableIcon("Online_HUD", "multi_dpad_up", "%S", Menu.GetAssignedButtonIcon(_actionSet, actions.vehicleSlot1.actionPage, actions.vehicleSlot1.actionId))
    Menu.SetTextVariableIcon("Online_HUD", "multi_dpad_down", "%S", Menu.GetAssignedButtonIcon(_actionSet, actions.vehicleSlot2.actionPage, actions.vehicleSlot2.actionId))
  end
  return preset
end
function duplicateTable(t)
  assert(t and type(t) == "table", "Wrong table for duplicate")
  local new_t = {}
  local function _duplicate(k, v)
    if type(v) == "table" then
      new_t[k] = duplicateTable(v)
    else
      new_t[k] = v
    end
  end
  table.foreach(t, _duplicate)
  return new_t
end
function setButtonLayouts()
  for localID, player in next, localPlayerManager.players, nil do
    currentControllerPreset[localID] = Menu.getControllerPreset(localID) + 1
    localPlayerManagerReflection.setCurentControllerPreset(localID, currentControllerPreset[localID])
    local actionSet = currentControllerPreset[localID] ~= 4 and 1 or 0
    player.buttonLayout = duplicateTable(getBindedButtons(actionSet))
    if currentControllerPreset[localID] ~= 4 then
      if controller.isAcceptCancelSwapped() then
        player.buttonLayout.accept = {buttonID = "reject", button = "button594"}
        player.buttonLayout.reject = {buttonID = "accept", button = "button595"}
      else
        player.buttonLayout.accept = {buttonID = "accept", button = "button595"}
        player.buttonLayout.reject = {buttonID = "reject", button = "button594"}
      end
    end
  end
  if localPlayerManager.numberOfPlayers == 1 then
    setupButtonsForPrompts()
  end
end
_G.updateButtonIcons = feedbackSystem.menusMaster.setButtonLayouts
addInitObject(setButtonLayouts)
function getControllerPreset(localID)
  return currentControllerPreset[localID]
end
function setOnlinePrimaryPrompt()
  mmPrimaryPromptVar = "iPrompt_M_Primary_Display"
  mmSecondaryPromptVar = "iPrompt_M_Secondary_Display"
  onlinePrimaryPrompt = true
  onlinePrimaryPromptRed = false
  currentHUDSetVariable("iMulti_Prompt_Primary_Colour", 0)
end
function setSinglePlayerPrimaryPrompt()
  mmPrimaryPromptVar = "iPrompt_Primary_Display"
  mmSecondaryPromptVar = "iPrompt_Secondary_Display"
  onlinePrimaryPrompt = false
end
function clearPrimaryTextPrompt()
  if primaryPromptActive then
    blockPrimaryUpdate = true
    if userUpdateFunctions.delayPrimaryUpdate then
      removeUserUpdateFunction("delayPrimaryUpdate")
    end
    if userUpdateFunctions.activePrimaryUpdate then
      removeUserUpdateFunction("activePrimaryUpdate")
    end
    OneShotSound.Play("HUD_Gen_Timer_Warning_Stop", false)
    clearPromptTable("prompt_primary")
    primaryPromptPriority = 5
    primaryPromptActive = false
    primaryPromptOnScreen = false
    promptHidden = false
    primaryCounterActive = false
    primaryFelonyActive = false
    setPrimaryPromptCounterValues()
    feedbackSystem.menusMaster.currentHUDSetVariable(mmPrimaryPromptVar, 0)
    if not gameStatus.onlineSession then
      locationPrompt(true)
    end
  end
end
function isPrimaryCounterActive()
  return primaryCounterActive
end
function setPrimaryPromptCounterValues(prompt, counter, icon)
  primaryCounterPrompt = prompt or nil
  primaryCounterCount = counter or nil
  primaryCounterIcon = icon or nil
end
function isPrimaryFelonyActive()
  return primaryFelonyActive
end
function primaryTextPrompt(prompt, value, delay, permanent, everyTenSeconds, icon1, endCallback, watchFor, icon2, onlineRedPrompt, value2, priority, counter, delayTime, overrideTime, felony)
  if not counter and primaryCounterActive and not primaryFelonyActive then
    OneShotSound.Play("HUD_Gen_Timer_Warning_Stop", false)
    primaryCounterActive = false
    setPrimaryPromptCounterValues()
  end
  local displayTime = primaryPromptShowTime
  if overrideTime then
    displayTime = overrideTime * updates.stepRate
  end
  if prompt then
    priority = priority or 1
    local function primaryPromptUpdate()
      local step = 0
      local watchedButton_status, pad1
      blockPrimaryUpdate = false
      if watchFor then
        pad1 = controlHandler.pad
      end
      if onlinePrimaryPrompt then
        if onlineRedPrompt and not onlinePrimaryPromptRed then
          onlineHUDSetVariable("iMulti_Prompt_Primary_Colour", 1)
          onlinePrimaryPromptRed = true
        elseif not onlineRedPrompt and onlinePrimaryPromptRed then
          onlineHUDSetVariable("iMulti_Prompt_Primary_Colour", 0)
          onlinePrimaryPromptRed = false
        end
      end
      feedbackSystem.menusMaster.currentHUDSetTextVariable("prompt_primary", prompt, value, icon1, icon2, value2)
      if localPlayer.minimapSupport.zoomed then
        localPlayer.minimapSupport:zoomIn()
      end
      if felony and not primaryFelonyActive then
        primaryFelonyActive = true
      end
      if counter then
        primaryCounterActive = true
        if not primaryFelonyActive then
          OneShotSound.Play("HUD_Gen_Timer_Warning_Play", false)
        end
      end
      addUserUpdateFunction("activePrimaryUpdate", function()
        if not blockPrimaryUpdate then
          if localPlayer.minimapSupport.zoomed and not promptHidden and primaryPromptOnScreen then
            feedbackSystem.menusMaster.currentHUDSetVariable(mmPrimaryPromptVar, 0)
            primaryPromptOnScreen = false
          elseif not localPlayer.minimapSupport.zoomed and not promptHidden and not primaryPromptOnScreen and step < displayTime - 1 * updates.stepRate then
            feedbackSystem.menusMaster.currentHUDSetVariable(mmPrimaryPromptVar, 1)
            primaryPromptOnScreen = true
          end
          if primaryCounterActive then
            feedbackSystem.menusMaster.currentHUDSetTextVariable("prompt_primary", primaryCounterPrompt, primaryCounterCount, primaryCounterIcon)
          end
          if watchFor then
            watchedButton_status = pad1:status(watchFor.button)
            if watchedButton_status == watchFor.pressType then
              if endCallback then
                endCallback()
              end
              clearPrimaryTextPrompt()
            end
          end
          if not permanent then
            step = step + 1
            if step >= displayTime or not primaryPromptActive then
              if everyTenSeconds and not promptHidden then
                feedbackSystem.menusMaster.currentHUDSetVariable(mmPrimaryPromptVar, 0)
                promptHidden = true
                step = 0
              elseif everyTenSeconds and promptHidden then
                feedbackSystem.menusMaster.currentHUDSetVariable(mmPrimaryPromptVar, 1)
                promptHidden = false
                step = 0
              else
                if endCallback then
                  endCallback()
                end
                clearPrimaryTextPrompt()
              end
            end
          end
        end
      end, 1, true)
    end
    local function delayPrimaryPromptUpdate(delay)
      local promptDelayTime = delay or 1 * updates.stepRate
      local step = 0
      addUserUpdateFunction("delayPrimaryUpdate", function()
        step = step + 1
        if step >= promptDelayTime then
          primaryPromptUpdate()
          removeUserUpdateFunction("delayPrimaryUpdate")
        end
      end, 1, true)
    end
    if not gameStatus.splitscreenSession then
      locationPrompt(false)
    end
    if not primaryFelonyActive and not felonyActive then
      if minimapPromptActive then
        clearMinimapTextPrompt()
      end
      if primaryPromptActive then
        if priority <= primaryPromptPriority then
          blockPrimaryUpdate = true
          removeUserUpdateFunction("activePrimaryUpdate")
          primaryPromptActive = false
          primaryPromptOnScreen = false
          feedbackSystem.menusMaster.currentHUDSetVariable(mmPrimaryPromptVar, 0)
          if delay then
            delayPrimaryPromptUpdate(4 * updates.stepRate)
          else
            delayPrimaryPromptUpdate(1 * updates.stepRate)
          end
        else
          return false
        end
      elseif delay then
        if delayTime then
          delayPrimaryPromptUpdate(delayTime * updates.stepRate)
        else
          delayPrimaryPromptUpdate(primaryPromptDelayTime)
        end
      else
        primaryPromptUpdate()
      end
    end
    primaryPromptActive = true
    primaryPromptPriority = priority
    return true
  end
end
function primaryTextPromptParam(params)
  return primaryTextPrompt(params.prompt, params.value, params.delay, params.permanent, params.everyTenSeconds, params.icon1, params.endCallback, params.watchFor, params.icon2, params.onlineRedPrompt, params.value2, params.priority, params.counter, params.delayTime, params.overrideTime, params.felony)
end
function clearSecondaryTextPrompt()
  if secondaryPromptActive then
    blockSecondaryUpdate = true
    if userUpdateFunctions.delaySecondaryUpdate then
      removeUserUpdateFunction("delaySecondaryUpdate")
    end
    if userUpdateFunctions.activeSecondaryUpdate then
      removeUserUpdateFunction("activeSecondaryUpdate")
    end
    OneShotSound.Play("HUD_Gen_Timer_Warning_Stop", false)
    clearPromptTable("prompt_secondary")
    secondaryPromptActive = false
    secondaryPromptOnScreen = false
    secondaryCounterActive = false
    setSecondaryPromptCounterValues()
    feedbackSystem.menusMaster.currentHUDSetVariable(mmSecondaryPromptVar, 0)
    if not gameStatus.onlineSession then
      locationPrompt(true)
    end
  end
end
function isSecondaryCounterActive()
  return secondaryCounterActive
end
function setSecondaryPromptCounterValues(prompt, counter, icon)
  secondaryCounterValue = prompt or nil
  secondaryCounterCount = counter or nil
  secondaryCounterIcon = icon or nil
end
function secondaryTextPrompt(prompt, value, button, delay, permanent, icon1, endCallback, watchFor, icon2, value2, counter)
  if not counter and secondaryCounterActive then
    OneShotSound.Play("HUD_Gen_Timer_Warning_Stop", false)
    secondaryCounterActive = false
    setSecondaryPromptCounterValues()
  end
  if prompt then
    local watchedButton_status, pad1
    if watchFor then
      pad1 = controlHandler.pad
    end
    local function secondaryPromptUpdate()
      local step = 0
      blockSecondaryUpdate = false
      feedbackSystem.menusMaster.currentHUDSetTextVariable("prompt_secondary", prompt, value, icon1, icon2, value2)
      if localPlayer.minimapSupport.zoomed then
        localPlayer.minimapSupport:zoomIn()
      end
      if counter then
        secondaryCounterActive = true
        OneShotSound.Play("HUD_Gen_Timer_Warning_Play", false)
      end
      addUserUpdateFunction("activeSecondaryUpdate", function()
        if not blockSecondaryUpdate then
          if localPlayer.minimapSupport.zoomed and secondaryPromptOnScreen then
            feedbackSystem.menusMaster.currentHUDSetVariable(mmSecondaryPromptVar, 0)
            secondaryPromptOnScreen = false
          elseif not localPlayer.minimapSupport.zoomed and not secondaryPromptOnScreen and step < secondaryPromptShowTime - 1 * updates.stepRate then
            feedbackSystem.menusMaster.currentHUDSetVariable(mmSecondaryPromptVar, 1)
            secondaryPromptOnScreen = true
          end
          if secondaryCounterActive then
            feedbackSystem.menusMaster.currentHUDSetTextVariable("prompt_secondary", secondaryCounterValue, secondaryCounterCount, secondaryCounterIcon)
          end
          if watchFor then
            watchedButton_status = pad1:status(watchFor.button)
            if watchedButton_status == watchFor.pressType then
              if endCallback then
                endCallback()
              end
              clearSecondaryTextPrompt()
            end
          end
          if not permanent then
            step = step + 1
            if step >= secondaryPromptShowTime or not secondaryPromptActive then
              if endCallback then
                endCallback()
              end
              clearSecondaryTextPrompt()
            end
          end
        end
      end, 1, true)
    end
    local function delaySecondaryPromptUpdate(delay)
      local promptDelayTime = delay or 1 * updates.stepRate
      local step = 0
      addUserUpdateFunction("delaySecondaryUpdate", function()
        step = step + 1
        if step >= promptDelayTime then
          secondaryPromptUpdate()
          removeUserUpdateFunction("delaySecondaryUpdate")
        end
      end, 1, true)
    end
    locationPrompt(false)
    if secondaryPromptActive then
      blockSecondaryUpdate = true
      removeUserUpdateFunction("activeSecondaryUpdate")
      secondaryPromptActive = false
      secondaryPromptOnScreen = false
      feedbackSystem.menusMaster.currentHUDSetVariable(mmSecondaryPromptVar, 0)
      if delay then
        delaySecondaryPromptUpdate(4 * updates.stepRate)
      else
        delaySecondaryPromptUpdate(1 * updates.stepRate)
      end
    elseif delay then
      delaySecondaryPromptUpdate(secondaryPromptDelayTime)
    else
      secondaryPromptUpdate()
    end
    secondaryPromptActive = true
  end
end
function secondaryTextPromptParam(params)
  secondaryTextPrompt(params.prompt, params.value, params.button, params.delay, params.permanent, params.icon1, params.endCallback, params.watchFor, params.icon2, params.value2, params.counter)
end
function clearMinimapTextPrompt()
  if minimapPromptActive then
    blockMinimapUpdate = true
    if userUpdateFunctions.delayMinimapUpdate then
      removeUserUpdateFunction("delayMinimapUpdate")
    end
    if userUpdateFunctions.activeMinimapUpdate then
      removeUserUpdateFunction("activeMinimapUpdate")
    end
    clearPromptTable("middle_prompt")
    minimapPromptActive = false
    minimapPromptOnScreen = false
    felonyActive = false
    feedbackSystem.menusMaster.currentHUDSetVariable("iPrompt_Middle", 0)
    if not gameStatus.onlineSession then
      locationPrompt(true)
    end
  end
end
function minimapTextPrompt(prompt, value, felony, delay, icon1, endCallback, icon2)
  if prompt then
    if felony then
      felonyCount = value
    end
    local function minimapPromptUpdate()
      local step = 0
      blockMinimapUpdate = false
      feedbackSystem.menusMaster.currentHUDSetTextVariable("middle_prompt", prompt, value, icon1, icon2)
      feedbackSystem.menusMaster.currentHUDSetVariable("iPrompt_Middle", 1)
      minimapPromptOnScreen = true
      if felony and not felonyActive then
        felonyActive = true
      end
      addUserUpdateFunction("activeMinimapUpdate", function()
        if not blockMinimapUpdate then
          step = step + 1
          if felony then
            feedbackSystem.menusMaster.currentHUDSetTextVariable("middle_prompt", prompt, felonyCount)
          end
          if localPlayer.minimapSupport.zoomed then
            feedbackSystem.menusMaster.currentHUDSetVariable("iPrompt_Middle", 0)
            minimapPromptOnScreen = false
          elseif not localPlayer.minimapSupport.zoomed and not minimapPromptOnScreen then
            feedbackSystem.menusMaster.currentHUDSetVariable("iPrompt_Middle", 1)
            minimapPromptOnScreen = true
          end
          if not felony and (step >= minimapPromptShowTime or not minimapPromptActive) then
            if endCallback then
              endCallback()
            end
            clearMinimapTextPrompt()
          end
        end
      end, 1, true)
    end
    local function delayMinimapPromptUpdate(delay)
      local promptDelayTime = delay or 1
      local step = 0
      addUserUpdateFunction("delayMinimapUpdate", function()
        step = step + 1
        if step >= promptDelayTime then
          minimapPromptUpdate()
          removeUserUpdateFunction("delayMinimapUpdate")
        end
      end, 1, true)
    end
    locationPrompt(false)
    if (not primaryPromptActive or felony) and not felonyActive then
      if felony and primaryPromptActive then
        clearPrimaryTextPrompt()
      end
      if not felonyActive then
        if minimapPromptActive then
          blockMinimapUpdate = true
          removeUserUpdateFunction("activeMinimapUpdate")
          minimapPromptActive = false
          minimapPromptOnScreen = false
          feedbackSystem.menusMaster.currentHUDSetVariable("iPrompt_Middle", 0)
          delayMinimapPromptUpdate(1)
        elseif delay then
          delayMinimapPromptUpdate(1)
        else
          minimapPromptUpdate()
        end
      end
      minimapPromptActive = true
    end
  end
end
function clearAllTextPrompts()
  clearPrimaryTextPrompt()
  clearSecondaryTextPrompt()
  clearMinimapTextPrompt()
end
focusHintPromptActive = false
local enableHintPrompt = true
local hintPromptActive = false
local hideHintButton = false
local focusHintButtonActive = false
local hintButtonHighlight = false
local freedriveHints = {
  goForASpin = {"ID:246315", 0},
  theDebriefLocked = {"ID:245520", 0},
  takedown = {"ID:246324", 0},
  theDebrief = {"ID:245852", 0},
  breakingNews = {"ID:246324", 0},
  freedrive = {"ID:243027", 0},
  freedriveComplete = {"ID:246316", 0},
  chase = {"ID:245237", 0},
  getaway = {"ID:245238", 0}
}
local hintBlockedInMissions = {
  ["Exposition 01 Forty Adam Thirty"] = true,
  ["Exposition pre crash chase"] = true,
  ["Exposition pre crash chase alley"] = true,
  ["Tutorial Mission 01 Boost"] = true,
  ["Tutorial Mission 02 Ram"] = true,
  ["Tutorial Mission 04 Aerial Jump"] = true,
  ["Tutorial Mission 05 Aerial Jump"] = true,
  ["Tutorial Mission 06 Aerial Jump"] = true,
  ["Car park"] = true
}
local tutorialMissions = {
  ["Tutorial garage"] = true,
  ["Tutorial activity"] = true
}
local hintButtonHighlightAllowed = function()
  local taskObject = localPlayer:getTaskObject()
  if taskObject or dareSystem.activeDare or not taskObject and Chase.IsAChaseActive() or not taskObject and Getaway.IsAGetawayActive() or progressionSystem.currentProgression >= 7 and progressionSystem.currentProgression < 10 then
    return true
  else
    return false
  end
end
function hideHintButtonHighlight()
  feedbackSystem.menusMaster.masterSetVariable("iFocus_Refreshed", 0)
end
function showHintButtonHighlight()
  hintButtonHighlight = true
  if hintButtonHighlightAllowed() then
    if focusHintButtonActive and not focusHintPromptActive then
      feedbackSystem.menusMaster.masterSetVariable("iFocus_Refreshed", 2)
      OneShotSound.Play("HUD_Gen_HintPanel_Reminder", false)
      hintButtonHighlight = false
      hintButtonReminder()
    else
      hintButtonHighlight = true
    end
  else
    hintButtonHighlight = false
  end
end
function clearHintButtonReminder()
  if userUpdateFunctions.hintHighlightReminder then
    removeUserUpdateFunction("hintHighlightReminder")
  end
end
function hintButtonReminder()
  clearHintButtonReminder()
  local startHintReminder = function()
    if not userUpdateFunctions.hintHighlightReminder then
      addUserUpdateFunction("hintHighlightReminder", function()
        showHintButtonHighlight()
        removeUserUpdateFunction("hintHighlightReminder")
      end, 180 * updates.stepRate, true)
    end
  end
  if not gameStatus.onlineSession and hintButtonHighlightAllowed() then
    localPlayer.simulationSupport.doWait(1, function()
      startHintReminder()
    end)
  end
end
function setCurrentFocusString(index)
  Menu.SetCurrentFocusString(index - 1)
  showHintButtonHighlight()
end
function setNextFocusString()
  Menu:NextFocusString()
  showHintButtonHighlight()
end
function setHintText(hintPrompts, showHighlight)
  if hintPrompts then
    Menu:SetMissionFocusStrings(hintPrompts)
  end
  if showHighlight then
    showHintButtonHighlight()
  end
end
function setFocusButtonText(inlineValues)
  local focusPrompts = {}
  taskObject = localPlayer:getTaskObject()
  local focusText = taskObject.coreData.instance.challenge.focusButtons
  if focusText then
    if inlineValues then
      for key, params in ipairs(focusText) do
        table.insert(focusPrompts, params.text or "NO FOCUS TEXT SET")
        if inlineValues and inlineValues[params.text] then
          table.insert(focusPrompts, #inlineValues[params.text])
          for key, value in next, inlineValues[params.text], nil do
            table.insert(focusPrompts, value)
          end
        else
          table.insert(focusPrompts, 0)
        end
      end
    else
      for key, params in ipairs(focusText) do
        table.insert(focusPrompts, params.text or "NO FOCUS TEXT SET")
        table.insert(focusPrompts, 0)
      end
    end
  end
  setHintText(focusPrompts, true)
end
local params = {}
local dareHint = {}
function updateFreedriveHintText()
  local taskObject = localPlayer:getTaskObject()
  local chapter = progressionSystem.getCurrentChapter()
  if taskObject and not tutorialMissions[taskObject.coreData.instance.challenge.name] or dareSystem.activeDare or chapter == 8 or chapter == 9 then
    feedbackSystem.menusMaster.masterSetTextVariable("Focus_Title", "ID:236645")
    feedbackSystem.menusMaster.masterSetTextVariable("focus_objective_text", "ID:236645")
  else
    feedbackSystem.menusMaster.masterSetTextVariable("Focus_Title", "ID:235713")
    feedbackSystem.menusMaster.masterSetTextVariable("focus_objective_text", "ID:235713")
  end
  if not taskObject and not dareSystem.activeDare then
    chapter = progressionSystem.getCurrentChapter()
    if Chase.IsAChaseActive() and localPlayer.primaryFelony.getawayGameVehicle then
      setHintText(freedriveHints.chase, true)
    elseif Getaway.IsAGetawayActive() and localPlayer.primaryFelony.getawayGameVehicle then
      setHintText(freedriveHints.getaway, true)
    elseif progressionSystem.currentProgression == 7 then
      setHintText(freedriveHints.goForASpin, true)
    elseif progressionSystem.currentProgression == 8 and not ProfileSettings.IsTakedownUnlocked() then
      setHintText(freedriveHints.theDebriefLocked, true)
    elseif progressionSystem.currentProgression == 8 and ProfileSettings.IsTakedownUnlocked() and not ProfileSettings.GetMissionCompleted(cards.ReverseMissionNetworkLookup["Exposition 06 Law Breaker (cop)"]) then
      setHintText(freedriveHints.takedown, true)
    elseif progressionSystem.currentProgression == 8 and ProfileSettings.GetMissionCompleted(cards.ReverseMissionNetworkLookup["Exposition 06 Law Breaker (cop)"]) then
      setHintText(freedriveHints.theDebrief, true)
    elseif progressionSystem.currentProgression == 9 then
      setHintText(freedriveHints.breakingNews, true)
    elseif chapter >= 1 and ProfileSettings.GetStoryModeComplete() then
      setHintText(freedriveHints.freedriveComplete)
    elseif chapter >= 1 then
      setHintText(freedriveHints.freedrive)
    end
  elseif dareSystem.activeDare then
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
    dareSystem.activeDare.animatedHint = false
    setHintText(dareHint, true)
  end
end
local hintButtonDelay = 5
local function setActiveVariable()
  OneShotSound.Play("HUD_Gen_HintPanel_Prompt", false)
  if userUpdateFunctions.hintButtonActiveDelay then
    removeUserUpdateFunction("hintButtonActiveDelay")
  end
  focusHintButtonActive = true
  if hintButtonHighlight then
    showHintButtonHighlight()
  else
    hintButtonReminder()
  end
end
local function showButton()
  local taskObject = localPlayer:getTaskObject()
  local chapter = progressionSystem.getCurrentChapter()
  if taskObject or progressionSystem.currentProgression >= 7 and chapter == 0 or chapter >= 1 then
    hideHintButton = false
    if taskObject and hintBlockedInMissions[taskObject.coreData.instance.challenge.name] then
      hideHintButton = true
    end
    updateFreedriveHintText()
    if not localPlayer.inCutscene and not feedbackSystem.previewScreen.activityBeingPrompted and not feedbackSystem.unlockPanelSupport.rewardPanelActive and enableHintPrompt and not focusHintButtonActive and not hideHintButton then
      feedbackSystem.menusMaster.masterSetVariable("iFocus_Highlight", 1)
      addUserUpdateFunction("hintButtonActiveDelay", setActiveVariable, 0.5 * updates.stepRate, true)
    end
  end
end
local function hideButton()
  if focusHintButtonActive or userUpdateFunctions.hintButtonActiveDelay then
    feedbackSystem.menusMaster.masterSetVariable("iFocus_Highlight", 0)
    if userUpdateFunctions.hintButtonActiveDelay then
      removeUserUpdateFunction("hintButtonActiveDelay")
    end
    focusHintButtonActive = false
    focusHintPromptActive = false
  end
end
function focusHintButtonState(buttonState)
  if hintButtonHighlightAllowed() then
    clearHintButtonReminder()
  end
  if buttonState and not focusHintButtonActive and not gameStatus.onlineSession and localPlayerManager.numberOfPlayers == 1 then
    showButton()
  elseif not buttonState then
    hideButton()
  end
end
local playCancelAudio = false
local function stopAudioCall()
  playCancelAudio = false
  if userUpdateFunctions.hintPromptAudio then
    removeUserUpdateFunction("hintPromptAudio")
  end
end
function focusHintPromptState(promptState)
  if promptState then
    if not focusHintPromptActive and focusHintButtonActive and enableHintPrompt then
      Menu:DisplayCurrentFocusString()
      OneShotSound.Play("HUD_Gen_HintPanel_In_Play", false)
      addUserUpdateFunction("hintPromptAudio", stopAudioCall, 0.5 * updates.stepRate, true)
      focusHintPromptActive = true
      playCancelAudio = true
      hideHintButtonHighlight()
    end
  elseif not promptState and focusHintPromptActive and focusHintButtonActive then
    if userUpdateFunctions.hintPromptAudio then
      removeUserUpdateFunction("hintPromptAudio")
    end
    if playCancelAudio then
      OneShotSound.Play("HUD_Gen_HintPanel_In_Stop", false)
      playCancelAudio = false
    else
      OneShotSound.Play("HUD_Gen_HintPanel_Out", false)
    end
    focusHintPromptActive = false
    feedbackSystem.menusMaster.masterSetVariable("iFocus_Button", 0)
    hintButtonReminder()
  end
end
function blockHintButton(state)
  if not state then
    enableHintPrompt = true
    focusHintButtonState(true)
  elseif state then
    focusHintButtonState(false)
    enableHintPrompt = false
    focusHintPromptActive = false
    clearHintButtonReminder()
    hideHintButtonHighlight()
  end
end
local locationPromptState = false
local locationPromptInitialise = function()
  if not gameStatus.onlineSession then
    locationPrompt(true)
  end
end
addInitObject(locationPromptInitialise)
function isLocationPromptsEnabled()
  return locationPromptState
end
function locationPrompt(state)
  if state then
    if not localPlayer:getTaskObject() and not locationPromptState and not localPlayer.challenge.retryingMission and not vehicleManager.previewVehicleManager.previewVehicle and not localPlayer.zapReturning then
      minimap.EnableLocationPrompts(state)
      locationPromptState = state
    end
  elseif locationPromptState then
    minimap.EnableLocationPrompts(state)
    feedbackSystem.menusMaster.masterSetVariable("iRoad_Sign", 9)
    locationPromptState = state
  end
end
local enterCountdownMode = function(timeToRestore)
  localPlayer.inCountdownMode = true
  return function()
    if timeToRestore < g_NetworkTime then
      localPlayer:exitCutsceneMode()
      localPlayer.inCountdownMode = false
      PauseMenu.allow(true)
      OneShotSound.Play("HUD_Gen_321GO_Stop")
      removeUserUpdateFunction("Countdown timer")
    end
  end
end
function singlePlayer321Countdown()
  if not localPlayer.inCutscene then
    localPlayer:enterCutsceneMode()
  end
  PauseMenu.allow(false)
  feedbackSystem.menusMaster.masterSetVariable("iSingle_Race_Countdown", 1)
  OneShotSound.Play("HUD_Gen_321GO_Play", false)
  addUserUpdateFunction("Countdown timer", enterCountdownMode(g_NetworkTime + 4), 4)
end
function setWillpowerComma(willpower)
  if willpower then
    local left, num = string.match(willpower, "^([^%d]*%d)(%d*)")
    return left .. num:reverse():gsub("(%d%d%d)", "%1,"):reverse()
  end
end
local pauseMenuShowsInExpo = {
  ["Exposition 06 Law Breaker (cop)"] = true,
  ["The debrief"] = true
}
local menuType = "Pause"
local pauseMenuCall = "ButtonListLayout"
local pauseMenuGarageCall = "garagesVisible"
local pauseMenuWillpowerCall = "willpowerVisible"
function setPauseMenu()
  local taskObject = localPlayer:getTaskObject()
  local currentChapter = progressionSystem.getCurrentChapter()
  Menu.SetVariable(menuType, pauseMenuGarageCall, 1)
  if not garage.areGaragesEnabled() then
    Menu.SetVariable(menuType, pauseMenuGarageCall, 0)
  end
  Menu.SetVariable(menuType, pauseMenuWillpowerCall, 1)
  if currentChapter == 0 and not garage.areGaragesEnabled() or currentChapter == 9 then
    Menu.SetVariable(menuType, pauseMenuWillpowerCall, 0)
  end
  Menu.SetVariable(menuType, pauseMenuCall, 3)
  if not taskObject then
    if currentChapter == 0 and not missionLaunchedFromFrontEnd then
      if 9 <= progressionSystem.currentProgression then
        Menu.SetVariable(menuType, pauseMenuCall, 3)
      else
        Menu.SetVariable(menuType, pauseMenuCall, 1)
      end
    elseif dareSystem.activeDare then
      Menu.SetVariable(menuType, pauseMenuCall, 5)
    elseif vehicleManager.previewVehicleManager.previewVehicle then
      local previewTaskObject = vehicleManager.previewVehicleManager.previewVehicle:getTaskObject()
      if previewTaskObject then
        local previewMissionName = previewTaskObject.coreData.instance.challenge.name
        local mission, potID, subType, type = progressionSystem.findMissionInProgression(previewMissionName)
        if type == "challenge" then
          Menu.SetVariable(menuType, pauseMenuCall, 1)
        end
      end
    end
  end
  if taskObject then
    local missionName = taskObject.coreData.instance.challenge.name
    local mission, potID, subType, type = progressionSystem.findMissionInProgression(missionName)
    if currentChapter == 0 and not missionLaunchedFromFrontEnd then
      if type == "activity" then
        Menu.SetVariable(menuType, pauseMenuCall, 4)
      elseif pauseMenuShowsInExpo[missionName] then
        Menu.SetVariable(menuType, pauseMenuCall, 2)
      else
        Menu.SetVariable(menuType, pauseMenuCall, 1)
      end
      if mission.ID == "Tutorial activity" then
        Menu.SetVariable(menuType, pauseMenuWillpowerCall, 1)
      end
    elseif type == "challenge" then
      Menu.SetVariable(menuType, pauseMenuCall, 2)
    elseif currentChapter >= 8 and currentChapter <= 9 or subType == "storyMission" then
      Menu.SetVariable(menuType, pauseMenuCall, 6)
    elseif type == "progressionTutorial" then
      Menu.SetVariable(menuType, pauseMenuCall, 3)
    else
      Menu.SetVariable(menuType, pauseMenuCall, 4)
    end
  end
end
_G.setPauseMenu = setPauseMenu
local ssDamageBarState = {
  [0] = {shown = false, blocked = false},
  [1] = {shown = false, blocked = false}
}
function resetDamageBarState()
  ssDamageBarState[0].shown = false
  ssDamageBarState[1].shown = false
  ssDamageBarState[0].blocked = false
  ssDamageBarState[1].blocked = false
end
ssDamagerBarBlocker = false
function enableDamageBar(player)
  if gameStatus.splitscreenSession then
    if not ssDamagerBarBlocker and not feedbackSystem.splitScreenSupport.disableSSHud then
      if player.localID == 0 and not ssDamageBarState[0].blocked and not ssDamageBarState[0].shown then
        ssDamageBarState[0].shown = true
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_cardamage_display", 1)
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_cardamage_anim", 100 - player.currentVehicle.damage * 100)
      elseif player.localID == 1 and not ssDamageBarState[1].blocked and not ssDamageBarState[1].shown then
        ssDamageBarState[1].shown = true
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_cardamage_display", 1)
        feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_cardamage_anim", 100 - player.currentVehicle.damage * 100)
      end
    end
  else
    feedbackSystem.menusMaster.currentHUDSetVariable("iCar_Damage_Display", 1)
    if player.currentVehicle then
      feedbackSystem.menusMaster.currentHUDSetVariable("iCar_Damage", 100 - player.currentVehicle.damage * 100)
    end
  end
end
function disableDamageBar(player)
  if gameStatus.splitscreenSession then
    if player.localID == 0 and ssDamageBarState[0].shown then
      ssDamageBarState[0].shown = false
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_cardamage_display", 0)
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_cardamage_anim", 0)
    elseif player.localID == 1 and ssDamageBarState[1].shown then
      ssDamageBarState[1].shown = false
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_cardamage_display", 0)
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_cardamage_anim", 0)
    end
  else
    feedbackSystem.menusMaster.currentHUDSetVariable("iCar_Damage_Display", 0)
  end
end
function updateDamageBar(player)
  if player.localID == 0 and ssDamageBarState[0].shown then
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_cardamage_anim", 100 - player.currentVehicle.damage * 100)
  elseif player.localID == 1 and ssDamageBarState[1].shown then
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_cardamage_anim", 100 - player.currentVehicle.damage * 100)
  end
end
function blockDamageBar(player, block)
  if block and ssDamageBarState[player.localID].blocked ~= block then
    disableDamageBar(player)
  end
  ssDamageBarState[player.localID].blocked = block
end
local currentPanelStatus
function allowUnlockPanel(status)
  status = status and not localPlayer.challenge.showingEndScreen and not localPlayer.inCutsceneOrIcam and not dareSystem.dareCompleteScreenActive and not CutsceneFiles.tutorials.tutorialActive and not feedbackSystem.unlockPanelSupport.rewardPanelActive and not vehicleManager.previewVehicleManager.previewVehicle and not feedbackSystem.previewScreen.previewScreenActive and not progressionSystem.applyingChapterSettings and not garage.spoolingVehicle
  if status ~= currentPanelStatus then
    Menu.DisplayUnlockPanel(status)
    currentPanelStatus = status
  end
end
local trackingSubTypes = {mission = false, challenge = true}
function unlockPanelCallback(unlockID)
  if unlockID then
    local missionID = cards.MissionNetworkLookup[unlockID]
    local mission, pot, missionSubtype, missionType = progressionSystem.findMissionInProgression(missionID)
    if trackingSubTypes[missionType] and not localPlayer.getTaskObject() and not vehicleManager.previewVehicleManager.previewVehicle then
      unlockTrackingMarker(mission, missionID)
    end
    if missionID == "The debrief" then
      feedbackSystem.menusMaster.primaryTextPromptParam({
        prompt = "ID:245852",
        priority = 1,
        delay = true,
        permanent = true
      })
    end
  end
end
function queueUnlockPanel(type, subType, iconType, ID, level, progress, title, body)
  if type == "city" then
    Menu.AddCityUnlocks(subType, ID, unlockPanelIconLookup[iconType] or unlockPanelIconLookup.default, progress, unlockPanelCallback, title, body)
  elseif type == "gadget" then
    Menu.AddGadgetUnlocks(subType, #ID, ID, level, unlockPanelIconLookup[iconType] or unlockPanelIconLookup.default, title, body)
  elseif type == "progress" then
    Menu.AddProgressBar(subType, ID, unlockPanelIconLookup[iconType] or unlockPanelIconLookup.default, progress.current / progress.total, progress.current, progress.total, title, body)
  end
end
