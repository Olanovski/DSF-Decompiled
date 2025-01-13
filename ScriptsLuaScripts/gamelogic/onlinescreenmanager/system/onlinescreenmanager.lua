module("onlineScreenManager", package.seeall)
introScreenOn = false
completeScreenOn = false
rewardScreenOn = false
minNumPlaysForAutoInstructions = 5
local addNewScreen = false
local screens = {}
local displayStack = {}
local instructionButtonActivated = false
local teamSwapButtonActivated = false
local gamerCardHighlight = 1
local instructionScreenOn = false
local instructionsClosable = false
local instructionScreenOnStartTime = 0
local gamerCardHighlightOn = false
local connectionScreenShown = false
local cancelButtonCallback = false
function setCancelButtonCallback(callback)
  cancelButtonCallback = callback
end
function screenManagerOnCancelButton()
  if cancelButtonCallback then
    cancelButtonCallback()
  end
end
function setPlatformSpecificLocalisation()
  if gameStatus.platform == gameStatus.platformID.XBOX360 then
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_gamercard_dpad", "ID:246064")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_table_header_player", "ID:220599")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_complete_banner_player", "ID:220599")
  else
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_gamercard_dpad", "ID:236795")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_table_header_player", "ID:100208")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_complete_banner_player", "ID:100208")
  end
  local isPadPresent = Menu.getControllerPreset(localID) + 1 ~= 4
  Menu.SetTextVariableIcon("Online_HUD", "multi_seaching_button_Y", "%S", isPadPresent and 57369)
  Menu.SetTextVariableIcon("Online_HUD", "multi_team_swap_prompt_button", "%S", isPadPresent and 57367)
  Menu.SetTextVariableIcon("Online_HUD", "mission_complete_continue_button", "%S", buttonsTable[localPlayer.buttonLayout.accept.button])
  Menu.SetTextVariableIcon("Online_HUD", "multi_instructions_button_cross", "%S", buttonsTable[localPlayer.buttonLayout.accept.button])
  Menu.SetTextVariableIcon("Online_HUD", "multi_seaching_button_A", "%S", buttonsTable[localPlayer.buttonLayout.accept.button])
  Menu.SetTextVariableIcon("Online_HUD", "ButtonACross", "%S", buttonsTable[localPlayer.buttonLayout.accept.button])
  if isPadPresent then
    Menu.SetTextVariableIcon("Online_HUD", "multi_gamercard_dpad_button", "%S", 604)
  else
    Menu.SetTextVariableIcon("Online_HUD", "multi_gamercard_dpad_button", "%S%S", 57440, 57441)
  end
  Menu.SetTextVariableIcon("Online_HUD", "expand_contract_button", "%S", isPadPresent and 57356)
  Menu.SetTextVariableIcon("Online_HUD", "multi_menu_options_button", "%S", isPadPresent and 57455)
  Menu.SetTextVariableIcon("Online_HUD", "ButtonBCircle", "%S", buttonsTable[localPlayer.buttonLayout.cancel.button])
  Menu.SetTextVariableIcon("Online_HUD", "multi_seaching_button_L", "%S", buttonsTable[localPlayer.buttonLayout.cancel.button])
  Menu.SetTextVariableIcon("Online_HUD", "multi_dpad_up", "%S", buttonsTable[localPlayer.buttonLayout.vehicleSlot1.button])
  Menu.SetTextVariableIcon("Online_HUD", "multi_dpad_down", "%S", buttonsTable[localPlayer.buttonLayout.vehicleSlot2.button])
end
local function initiateGamerCardHighlight()
  gamerCardHighlight = 1
  if screens[displayStack[1].screen].getEntryFromPlayerID and displayStack[1].intialised then
    gamerCardHighlight = screens[displayStack[1].screen].getEntryFromPlayerID(localPlayer.playerID)
  end
  if not instructionScreenOn then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Searching_Set_Player_Bar", gamerCardHighlight)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Complete_Set_Player_Bar", gamerCardHighlight)
  end
  gamerCardHighlightOn = true
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_button_A", "%S", nil, localPlayer.buttonLayout.accept)
  if gameStatus.platform == gameStatus.platformID.XBOX360 then
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_gamercard", "ID:236137")
  else
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_gamercard", "ID:236138")
  end
end
local hideGamerCardHighlight = function()
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Searching_Set_Player_Bar", 0)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Complete_Set_Player_Bar", 0)
end
local function showGamerCardHighlight()
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Searching_Set_Player_Bar", gamerCardHighlight)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Complete_Set_Player_Bar", gamerCardHighlight)
end
function disableGamerCardHightlight()
  hideGamerCardHighlight()
  gamerCardHighlightOn = false
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_button_A", "")
  feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_gamercard", "")
end
local setPlayerListMovePromptVisiblity = function(show)
  if show then
    setPlatformSpecificLocalisation()
    if localPlayer.buttonLayout.scrollPlayerList2 then
      feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_gamercard_dpad_button", "%S%S", nil, localPlayer.buttonLayout.scrollPlayerList, localPlayer.buttonLayout.scrollPlayerList2)
    else
      feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_gamercard_dpad_button", "%S", nil, localPlayer.buttonLayout.scrollPlayerList)
    end
  else
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_gamercard_dpad", "")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_gamercard_dpad_button", "")
  end
end
local function soloPlayerlistMoveGamerCardHighlight(direction)
  if direction == "up" then
    if gamerCardHighlight > 1 then
      gamerCardHighlight = gamerCardHighlight - 1
    else
      gamerCardHighlight = playerManager.numberOfPlayers
    end
  elseif direction == "down" then
    if gamerCardHighlight < playerManager.numberOfPlayers then
      gamerCardHighlight = gamerCardHighlight + 1
    else
      gamerCardHighlight = 1
    end
  end
end
local function teamPlayerlistMoveGamerCardHighlight(direction)
  local localPlayerTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
  local numPlayerTeam = 1
  local numOppsTeam = 0
  for playerID, player in next, playerManager.players, nil do
    if playerID ~= localPlayer.playerID then
      if PlayerGamePlay.getPlayerTeam(playerID) == localPlayerTeam then
        numPlayerTeam = numPlayerTeam + 1
      else
        numOppsTeam = numOppsTeam + 1
      end
    end
  end
  if direction == "up" then
    gamerCardHighlight = gamerCardHighlight - 1
    if gamerCardHighlight < 5 then
      if numPlayerTeam < gamerCardHighlight then
        gamerCardHighlight = numPlayerTeam
      elseif gamerCardHighlight < 1 then
        gamerCardHighlight = numOppsTeam + 4
      end
    elseif gamerCardHighlight > numOppsTeam + 4 then
      gamerCardHighlight = numOppsTeam + 4
    end
  elseif direction == "down" then
    gamerCardHighlight = gamerCardHighlight + 1
    if gamerCardHighlight < 5 then
      if numPlayerTeam < gamerCardHighlight then
        gamerCardHighlight = 5
      end
    elseif gamerCardHighlight > numOppsTeam + 4 then
      gamerCardHighlight = 1
    end
  end
end
function moveGamerCardHighlight(direction)
  if not instructionScreenOn and displayStack[1] and not rewardScreenOn and displayStack[1].intialised and screens[displayStack[1].screen].getPlayerIDFromEntry then
    if not gamerCardHighlightOn then
      initiateGamerCardHighlight()
    else
      if screens[displayStack[1].screen].teams then
        teamPlayerlistMoveGamerCardHighlight(direction)
      else
        soloPlayerlistMoveGamerCardHighlight(direction)
      end
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Searching_Set_Player_Bar", gamerCardHighlight)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Complete_Set_Player_Bar", gamerCardHighlight)
    end
  end
end
function showPlayerGamerCard()
  if displayStack[1] and gamerCardHighlightOn and not gameStatus.splitscreenSession and displayStack[1].intialised and (displayStack[1].startTime > 0 and g_NetworkTime - displayStack[1].startTime > 1.5 or displayStack[1].startTime == -1) and not instructionScreenOn and not gameStatus.simulationPaused and not gameStatus.onlinePaused and screens[displayStack[1].screen].getPlayerIDFromEntry then
    local playerID = screens[displayStack[1].screen].getPlayerIDFromEntry(gamerCardHighlight)
    if playerID > -1 then
      PlayerGamePlay.showGamerCard(playerID)
    else
      initiateGamerCardHighlight()
    end
  end
end
function resetGamerCardHighlight()
  if displayStack[1] and gamerCardHighlightOn and not gameStatus.splitscreenSession and displayStack[1].intialised and gamerCardHighlightOn then
    initiateGamerCardHighlight()
  end
end
function isIntroScreenShowing()
  return introScreenOn
end
function isCompleteScreenShowing()
  return completeScreenOn
end
function clearVoiceChatIcons()
  for i = 1, 8 do
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Voicechat_Board_p" .. i, 0)
  end
end
local voiceChatMMStrings = {
  [1] = "iMulti_Voicechat_Board_p1",
  [2] = "iMulti_Voicechat_Board_p2",
  [3] = "iMulti_Voicechat_Board_p3",
  [4] = "iMulti_Voicechat_Board_p4",
  [5] = "iMulti_Voicechat_Board_p5",
  [6] = "iMulti_Voicechat_Board_p6",
  [7] = "iMulti_Voicechat_Board_p7",
  [8] = "iMulti_Voicechat_Board_p8"
}
local function updatePlayerTalkingStatus(playerID, isMuted, isTalking, hasMic)
  assert(displayStack[1].screen, "ONLINE SCREEN MANAGER - CANNOT SET THE VOICE CHAT STATUS OF A PLAYER WHEN A SCREEN IS NOT SHOWING")
  if ONLINE_SCREEN_DEBUG then
    print("onlineScreenManager - updatePlayerTalkingStatus - playerID: " .. tostring(playerID) .. ", isMuted: " .. tostring(isMuted) .. ", isTalking: " .. tostring(isTalking))
  end
  local playerPosition = screens[displayStack[1].screen].getEntryFromPlayerID(playerID)
  if isMuted == 1 and hasMic == 1 then
    feedbackSystem.menusMaster.onlineHUDSetVariable(voiceChatMMStrings[playerPosition], 2)
  elseif isTalking == 1 and hasMic == 1 then
    feedbackSystem.menusMaster.onlineHUDSetVariable(voiceChatMMStrings[playerPosition], 1)
  elseif isTalking == 0 and hasMic == 1 then
    feedbackSystem.menusMaster.onlineHUDSetVariable(voiceChatMMStrings[playerPosition], 3)
  elseif hasMic == 0 then
    feedbackSystem.menusMaster.onlineHUDSetVariable(voiceChatMMStrings[playerPosition], 0)
  end
end
_G.updatePlayerTalkingStatus = updatePlayerTalkingStatus
function toggleRewardScreen()
  if displayStack[1] and screens[displayStack[1].screen].toggleRewards then
    screens[displayStack[1].screen].toggleRewards()
  end
end
function progressRewardScreen()
  if displayStack[1] and screens[displayStack[1].screen].progressRewards then
    screens[displayStack[1].screen].progressRewards()
  end
end
local lastSwapRequest = false
function isTeamSwapButtonActivated()
  return teamSwapButtonActivated
end
function setTeamSwapPromptText(textID)
  if textID == 1 then
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_swap_prompt", "ID:245970")
  elseif textID == 2 then
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_swap_prompt", "ID:245971")
  end
end
local setTeamSwapButtonVisiblity = function(show)
  if show then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_TeamSwap_Prompt", 1)
  else
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_TeamSwap_Prompt", 0)
  end
end
function activateTeamSwapButton()
  teamSwapButtonActivated = true
  PlayerGamePlay.initiateTeamSwitching()
  setTeamSwapButtonVisiblity(true)
  setTeamSwapPromptText(1)
  lastSwapRequest = 0
end
function desactivateTeamSwapButton()
  teamSwapButtonActivated = false
  PlayerGamePlay.endTeamSwitching()
  setTeamSwapButtonVisiblity(false)
end
function onTeamSwapToggle()
  if teamSwapButtonActivated and g_NetworkTime - lastSwapRequest > 0.5 and not instructionScreenOn then
    PlayerGamePlay.toggleLocalRequestTeamSwitch()
    lastSwapRequest = g_NetworkTime
  end
end
function activateInstructionButton()
  instructionButtonActivated = true
  feedbackSystem.menusMaster.currentHUDSetVariable("iMulti_Instruction_Button_Visible", 1)
end
function desactivateInstructionButton()
  instructionButtonActivated = false
  feedbackSystem.menusMaster.currentHUDSetVariable("iMulti_Instruction_Button_Visible", 0)
end
function isInstructionButtonActivated()
  return instructionButtonActivated
end
local function enableCloseInstructions()
  if Menu.GetSceneFrame("Online_HUD", "multi_instructions_show") > 145 then
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_instructions_button_cross", localPlayer.buttonLayout.accept)
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_instructions_close", "ID:100237")
    instructionScreenOnStartTime = 0
    instructionsClosable = true
    removeUserUpdateFunction("enableCloseInstructions")
  end
end
function displayInstructionScreen()
  assert(instructionButtonActivated, "Cannot show the instruction screen - instuction button is inactive")
  if not gameStatus.simulationPaused and not gameStatus.onlinePaused then
    feedbackSystem.menusMaster.currentHUDSetVariable("iMulti_Instructions_Show", 1)
    local instrucLineOneValue = false
    local instrucLineTwoValue = false
    local instrucLineThreeValue = false
    if onlineScreenData[displayStack[1].name].instructions_line_1_Func then
      instrucLineOneValue = onlineScreenData[displayStack[1].name].instructions_line_1_Func()
    end
    if onlineScreenData[displayStack[1].name].instructions_line_2_Func then
      instrucLineTwoValue = onlineScreenData[displayStack[1].name].instructions_line_2_Func()
    end
    if onlineScreenData[displayStack[1].name].instructions_line_3_Func then
      instrucLineThreeValue = onlineScreenData[displayStack[1].name].instructions_line_3_Func()
    end
    if instrucLineOneValue then
      feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_instructions_line_1", onlineScreenData[displayStack[1].name].instructions_line_1, instrucLineOneValue)
    else
      feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_instructions_line_1", onlineScreenData[displayStack[1].name].instructions_line_1)
    end
    if instrucLineTwoValue then
      feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_instructions_line_2", onlineScreenData[displayStack[1].name].instructions_line_2, instrucLineTwoValue)
    else
      feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_instructions_line_2", onlineScreenData[displayStack[1].name].instructions_line_2)
    end
    if instrucLineThreeValue then
      feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_instructions_line_3", onlineScreenData[displayStack[1].name].instructions_line_3, instrucLineThreeValue)
    else
      feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_instructions_line_3", onlineScreenData[displayStack[1].name].instructions_line_3)
    end
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_instructions_instructions", onlineScreenData[displayStack[1].name].abbrTitle)
    feedbackSystem.menusMaster.currentHUDSetVariable("iMultiplayer_IconType", onlineScreenData[displayStack[1].name].screenIconID)
    feedbackSystem.menusMaster.currentHUDSetVariable("iMulti_Instruction_Button_Visible", 0)
    instructionScreenOn = true
    if not gameStatus.splitscreenSession then
      disableGamerCardHightlight()
    end
    if teamSwapButtonActivated then
      setTeamSwapButtonVisiblity(false)
    end
    setPlayerListMovePromptVisiblity(false)
    instructionScreenOnStartTime = g_NetworkTime
    instructionsClosable = false
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_instructions_button_cross", "")
    feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_instructions_close", "")
    addUserUpdateFunction("enableCloseInstructions", enableCloseInstructions, 30, true)
  end
end
function isInstructionScreenOn()
  return instructionScreenOn
end
function turnOffInstructionScreen(forced)
  if (not gameStatus.simulationPaused and not gameStatus.onlinePaused or forced) and (forced or instructionsClosable) and instructionScreenOn then
    feedbackSystem.menusMaster.currentHUDSetVariable("iMulti_Instructions_Show", 0)
    instructionScreenOn = false
    if teamSwapButtonActivated then
      setTeamSwapButtonVisiblity(true)
    end
    setPlayerListMovePromptVisiblity(true)
    if forced then
      instructionScreenOnStartTime = 0
      removeUserUpdateFunction("enableCloseInstructions")
    elseif instructionButtonActivated then
      feedbackSystem.menusMaster.currentHUDSetVariable("iMulti_Instruction_Button_Visible", 1)
    end
  end
end
function addScreen(index, screenName, screenData)
  assert(not screens[index], "ONLINE SCREEN MANAGER - SCREEN SLOT ALREADY TAKEN " .. tostring(index))
  if not screens[index] then
    screens[index] = screenData
  end
end
function showScreen(screenIndex, startTime, sortType, displayName, startCallback, endCallback, displayOffTime)
  if connectionScreenShown then
    if gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode and not phaseManager.SNOID or not phaseManager.playlistSupport.SNOID or not onlineRaceManager.SNOID then
      assert(false, "Failed to sync required SNO's PM: " .. tostring(phaseManager.SNOID) .. "  PMPS: " .. tostring(phaseManager.playlistSupport.SNOID) .. "   ORM: " .. tostring(onlineRaceManager.SNOID))
    end
    hideConnectionScreen()
  end
  if screenIndex ~= JoiningScreenIndex and #displayStack > 0 then
    onlineScreenManager.endScreen("JOINING SCREEN")
  end
  PartyBusManager.DeactivateLoadingScreen()
  if phaseManager.skipIntroHUD then
    return
  end
  assert(screens[screenIndex], "ONLINE SCREEN MANAGER - SCREEN REQUEST FAILED. SCREEN " .. tostring(screenIndex) .. " DOES NOT EXIST")
  if #displayStack > 0 then
    if displayStack[1].screen == screenIndex and displayStack[1].name == displayName then
      if screens[screenIndex].updateCoreData then
        displayStack[1].startTime = startTime
        displayStack[1].endTime = phaseManager.networkVars.screenBlockEndTime
        if displayOffTime then
          displayStack[1].earlyEndTime = startTime + displayOffTime
        else
          displayStack[1].earlyEndTime = phaseManager.networkVars.screenBlockEndTime
        end
        local length = phaseManager.networkVars.screenBlockEndTime - startTime
        screens[screenIndex].updateCoreData(startTime, length, displayStack[1].earlyEndTime - startTime)
      end
    else
      for i, screen in ipairs(displayStack) do
        if screen.screen == screenIndex and screen.name == displayName then
          table.remove(displayStack, i)
          break
        end
      end
      addNewScreen = true
    end
  else
    addNewScreen = true
  end
  if addNewScreen then
    table.insert(displayStack, {
      screen = screenIndex,
      startTime = startTime,
      name = displayName,
      sortType = sortType,
      startCallback = startCallback,
      endCallback = endCallback,
      displayOff = displayOffTime or false,
      intialised = false
    })
    if screens[screenIndex].preEnter then
      screens[screenIndex].preEnter()
    end
    addNewScreen = false
    if ONLINE_SCREEN_DEBUG then
      print(">>>>>>>>>>>> Online Screen Manager: Add Screen: " .. tostring(displayName) .. " Index: " .. tostring(screenIndex) .. " Start Time: " .. tostring(startTime) .. " Display Off Time: " .. tostring(displayOffTime) .. "  END TIME " .. tostring(phaseManager.networkVars.screenBlockEndTime))
    end
  end
end
local delayTime = 0.5
local delayStartTime = 0
function areScreensComplete()
  for i, screen in ipairs(screens) do
    if screen and screen.getStatus and not screen.getStatus() then
      return false
    end
  end
  return true
end
function endScreen(displayName, fromPurge)
  for i, screen in ipairs(displayStack) do
    if screen.name == displayName then
      if introScreenOn then
        turnOffInstructionScreen(true)
        desactivateInstructionButton()
      end
      screens[screen.screen].exitScreen(fromPurge)
      if not gameStatus.splitscreenSession then
        disableGamerCardHightlight()
      end
      delayStartTime = g_NetworkTime
      table.remove(displayStack, i)
      if not gameStatus.splitscreenSession then
        disableGamerCardHightlight()
      end
      if ONLINE_SCREEN_DEBUG then
        print(">>>>>>>>>>>> Online Screen Manager: REMOVE SCREEN: " .. tostring(displayName) .. " INDEX: " .. tostring(i))
      end
      break
    end
  end
end
function clearCurrentScreenEarlyEndTime()
  assert(displayStack[1], "Cannot clear the current screens early end time. Screen does not exist!")
  displayStack[1].earlyEndTime = displayStack[1].endTime
end
function update()
  if displayStack[1] then
    if displayStack[1].intialised then
      if isInstructionScreenOn() and (g_NetworkTime > displayStack[1].endTime - 2 or g_NetworkTime > displayStack[1].earlyEndTime - 2) then
        turnOffInstructionScreen(true)
      end
      if isInstructionButtonActivated() and (g_NetworkTime > displayStack[1].endTime - 3 or g_NetworkTime > displayStack[1].earlyEndTime - 3) then
        desactivateInstructionButton()
      end
      if displayStack[1].startTime > 0 and (g_NetworkTime > displayStack[1].endTime or g_NetworkTime > displayStack[1].earlyEndTime) then
        local callExitScreen = true
        if displayStack[1].endCallback then
          callExitScreen = displayStack[1].endCallback()
        end
        if callExitScreen then
          if introScreenOn then
            turnOffInstructionScreen(true)
            desactivateInstructionButton()
          end
          if ONLINE_SCREEN_DEBUG then
            print(">>>>>>>>>>>> Online Screen Manager: Exit Screen: " .. tostring(displayStack[1].name) .. ". Screen Timed out")
          end
          screens[displayStack[1].screen].exitScreen()
          if not gameStatus.splitscreenSession then
            disableGamerCardHightlight()
          end
          table.remove(displayStack, 1)
          delayStartTime = g_NetworkTime
          if not gameStatus.splitscreenSession then
            disableGamerCardHightlight()
          end
        else
          if ONLINE_SCREEN_DEBUG then
            print(">>>>>>>>>>>> Online Screen Manager: Exit Screen: " .. tostring(displayStack[1].name) .. ". Exit callback failed. Screen will be manually turned off in current state exit.")
          end
          displayStack[1].startTime = -1
          if screens[displayStack[1].screen].finishScreen then
            if ONLINE_SCREEN_DEBUG then
              print(">>>>>>>>>>>> Online Screen Manager: Mark screen as finished: " .. tostring(displayStack[1].name))
            end
            screens[displayStack[1].screen].finishScreen()
          end
        end
      else
        screens[displayStack[1].screen].updateScreen()
      end
    elseif screens[displayStack[1].screen] and phaseManager.networkVars.screenBlockEndTime ~= 0 then
      if g_NetworkTime >= displayStack[1].startTime then
        local endTime = false
        if phaseManager.networkVars.screenBlockEndTime >= g_NetworkTime then
          endTime = phaseManager.networkVars.screenBlockEndTime
          if ONLINE_SCREEN_DEBUG then
            print(">>>>>>>>>>>> Online Screen Manager: NOT CATCH UP END TIME")
          end
        elseif phaseManager.networkVars.screenBlockEndTime < g_NetworkTime then
          endTime = g_NetworkTime + 5
          displayStack[1].startTime = g_NetworkTime
          if ONLINE_SCREEN_DEBUG then
            print(">>>>>>>>>>>> Online Screen Manager: CATCH UP END TIME")
          end
        end
        if endTime > g_NetworkTime then
          displayStack[1].intialised = true
          displayStack[1].endTime = endTime
          if displayStack[1].displayOff then
            displayStack[1].earlyEndTime = displayStack[1].startTime + displayStack[1].displayOff
          else
            displayStack[1].earlyEndTime = endTime
          end
          if displayStack[1].startCallback then
            displayStack[1].startCallback()
          end
          screens[displayStack[1].screen].enterScreen(displayStack[1].startTime, endTime - displayStack[1].startTime, displayStack[1].sortType, displayStack[1].name, displayStack[1].earlyEndTime - g_NetworkTime, g_NetworkTime)
          if ONLINE_SCREEN_DEBUG then
            print(">>>>>>>>>>>> Online Screen Manager: Start Screen: " .. tostring(displayStack[1].name) .. " Duration Time: " .. tostring(endTime - displayStack[1].startTime) .. " Early End Duration: " .. tostring(displayStack[1].earlyEndTime - displayStack[1].startTime))
            print(">>>>>>>>>>>>> Start Time: " .. tostring(displayStack[1].startTime) .. "   End Time: " .. tostring(displayStack[1].endTime) .. "  Current Time: " .. tostring(g_NetworkTime))
          end
        elseif ONLINE_SCREEN_DEBUG then
          print("SCREEN START FAILED: " .. tostring(displayStack[1].name) .. " " .. tostring(endTime) .. "  " .. tostring(phaseManager.networkVars.screenBlockEndTime) .. " " .. tostring(g_NetworkTime))
        end
      end
    else
      table.remove(displayStack, 1)
    end
  end
end
function getScreenOutroSceneName()
  if displayStack[1] and screens[displayStack[1].screen].getOutroSceneName then
    return screens[displayStack[1].screen].getOutroSceneName()
  end
  return false
end
function purge()
  for i, screen in ipairs(displayStack) do
    screens[screen.screen].exitScreen(true)
  end
  if instructionScreenOn then
    turnOffInstructionScreen(true)
    disableGamerCardHightlight()
  end
  if ONLINE_SCREEN_DEBUG then
    print(">>>>>>>>>>>> Online Screen Manager: PURGE")
  end
  displayStack = {}
  delayStartTime = 0
  if not gameStatus.splitscreenSession then
    disableGamerCardHightlight()
  end
  resetSSCoopModeResults()
end
function getScreenTable(screen)
  return screens[screen]
end
function getScreenStack()
  return displayStack
end
function showConnectionScreen()
  Menu.ChangePage("Online", "Connecting_game")
  PauseMenu.allow(false)
  WwiseMotion.Disable()
  connectionScreenShown = true
end
_G.showConnectionScreen = showConnectionScreen
function hideConnectionScreen()
  Menu.ChangePage("Online", "Free_drive")
  PauseMenu.allow(true)
  WwiseMotion.Enable()
  connectionScreenShown = false
end
_G.hideConnectionScreen = hideConnectionScreen
