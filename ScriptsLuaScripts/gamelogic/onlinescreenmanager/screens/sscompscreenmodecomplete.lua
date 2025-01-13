module("onlineScreenManager", package.seeall)
local compScreenComplete = true
local stringTableIndex = false
local audioOn = false
local enterCompScreen, updateCompScreen, exitCompScreen
local bronze1Set = false
local silver1Set = false
local gold1Set = false
local barFillComplete = false
local bronze2Set = false
local silver2Set = false
local gold2Set = false
local barFill2Complete = false
local function preEnterScreen()
  compScreenComplete = false
end
local function getScreenStatus()
  return compScreenComplete
end
local function setCompleteScreenComplete()
  compScreenComplete = true
end
local stringTable = {
  [1] = {
    page = "SS_06_end_stat_tanner_win",
    win = "iSS_06_tanner_anim",
    lose = "iSS_06_jericho_anim",
    bronze = "iSS_06_bronze_position",
    silver = "iSS_06_silver_position",
    gold = "iSS_06_gold_position",
    bronzeFlashT = "iSS_06_tanner_bronze_flare",
    silverFlashT = "iSS_06_tanner_silver_flare",
    goldFlashT = "iSS_06_tanner_gold_flare",
    bronzeFlashJ = "iSS_06_jericho_bronze_flare",
    silverFlashJ = "iSS_06_jericho_silver_flare",
    goldFlashJ = "iSS_06_jericho_gold_flare"
  },
  [2] = {
    page = "SS_07_end_stat_jericho_win",
    win = "iSS_07_jericho_win_anim",
    lose = "iSS_07_tanner_lose_anim",
    bronze = "iSS_07_bronze_position",
    silver = "iSS_07_silver_position",
    gold = "iSS_07_gold_position",
    bronzeFlashT = "iSS_07_tanner_bronze_flare",
    silverFlashT = "iSS_07_tanner_silver_flare",
    goldFlashT = "iSS_07_tanner_gold_flare",
    bronzeFlashJ = "iSS_07_jericho_bronze_flare",
    silverFlashJ = "iSS_07_jericho_silver_flare",
    goldFlashJ = "iSS_07_jericho_gold_flare"
  }
}
function enterCompScreen(startTime, displayTime, sortType, missionName, endTime)
  PauseMenu.allow(false)
  print("-------------------- pause menu false")
  assert(onlineScreenData[missionName], "SCREEN NOT STARTED: " .. tostring(missionName) .. " ENTRY NOT IN THE SCREEN DATA TABLE")
  local playerTable = getPlayerScreenDataTable()
  local modeCompData = getSSModeCompDataTable()
  assert(modeCompData.silverMedal and modeCompData.bronzeMedal and modeCompData.scoreLimit and modeCompData.goldMedal, "FAILED TO SET SPLITSCREEN COMP SCREEN - INVALID COMPLETE DATA")
  assert(playerTable[0] and playerTable[1], "FAILED TO SET SPLITSCREEN COMP SCREEN - INVALID PLAYER DATA")
  local tannerWin = false
  if not modeCompData.race then
    tannerWin = playerTable[0].score > playerTable[1].score
  else
    tannerWin = playerTable[0].secondaryScore < playerTable[1].secondaryScore
  end
  local tannerScore = false
  local jerichoScore = false
  if not modeCompData.use2ndScore then
    tannerScore = playerTable[0].score / modeCompData.scoreLimit * 100
    jerichoScore = playerTable[1].score / modeCompData.scoreLimit * 100
  else
    tannerScore = playerTable[0].secondaryScore / modeCompData.scoreLimit * 100
    jerichoScore = playerTable[1].secondaryScore / modeCompData.scoreLimit * 100
  end
  local jMedal = 0
  local tMedal = 0
  if tannerScore >= modeCompData.goldMedal then
    tMedal = 1
  elseif tannerScore >= modeCompData.silverMedal then
    tMedal = 2
  elseif tannerScore >= modeCompData.bronzeMedal then
    tMedal = 3
  end
  if jerichoScore >= modeCompData.goldMedal then
    jMedal = 1
  elseif jerichoScore >= modeCompData.silverMedal then
    jMedal = 2
  elseif jerichoScore >= modeCompData.bronzeMedal then
    jMedal = 3
  end
  setSSMissionResults(phaseManager.playlistSupport.ssPlayedModeCount, tMedal, jMedal)
  if tannerWin then
    phaseManager.playlistSupport.ssPlayedModeResults.tanner = phaseManager.playlistSupport.ssPlayedModeResults.tanner + 1
    phaseManager.playlistSupport.ssPlayedModeResults.wins[phaseManager.playlistSupport.ssPlayedModeCount] = 1
  else
    phaseManager.playlistSupport.ssPlayedModeResults.jericho = phaseManager.playlistSupport.ssPlayedModeResults.jericho + 1
    phaseManager.playlistSupport.ssPlayedModeResults.wins[phaseManager.playlistSupport.ssPlayedModeCount] = 2
  end
  stringTableIndex = tannerWin and 2
  assert(stringTableIndex == 1 or stringTableIndex == 2, "FAILED TO SET SPLITSCREEN COMP SCREEN - PAGE INDEX")
  Menu.ResetPage("SplitscreenMenus", stringTable[stringTableIndex].page)
  feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].bronze, modeCompData.bronzeMedal)
  feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].silver, modeCompData.silverMedal)
  feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].gold, modeCompData.goldMedal)
  feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].win, 0)
  feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].lose, 0)
  if stringTableIndex == 2 then
    feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].bronzeFlashT, 0)
    feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].bronzeFlashJ, 0)
    feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].silverFlashT, 0)
    feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].silverFlashJ, 0)
    feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].goldFlashT, 0)
    feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].goldFlashJ, 0)
  end
  feedbackSystem.multiplayerSupport.purgeProgBarFiller()
  local score1 = tannerWin and tannerScore or jerichoScore
  local score2 = tannerWin and jerichoScore or tannerScore
  if score1 > 0 then
    barFillComplete = false
    feedbackSystem.multiplayerSupport.addBarFill(1, 1, stringTable[stringTableIndex].win, score1, 2, function()
      OneShotSound.PlayGUI("HUD_Gen_Currency_Increase_Play", false)
      audioOn = true
    end, function()
      if audioOn then
        OneShotSound.PlayGUI("HUD_Gen_Currency_Increase_Stop", false)
        audioOn = false
      end
      barFillComplete = true
    end, function(value)
      if not bronze1Set and value >= modeCompData.bronzeMedal then
        if tannerWin then
          feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].bronzeFlashT, 1)
        else
          feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].bronzeFlashJ, 1)
        end
        bronze1Set = true
        OneShotSound.Play("HUD_Gen_Positive_Lite", false)
      elseif not silver1Set and value >= modeCompData.silverMedal then
        if tannerWin then
          feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].silverFlashT, 1)
        else
          feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].silverFlashJ, 1)
        end
        silver1Set = true
        OneShotSound.Play("HUD_Gen_Positive_Lite", false)
      elseif not gold1Set and value >= modeCompData.goldMedal then
        if tannerWin then
          feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].goldFlashT, 1)
        else
          feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].goldFlashJ, 1)
        end
        gold1Set = true
        OneShotSound.Play("HUD_Gen_Positive_Lite", false)
      end
    end)
  else
    barFillComplete = true
  end
  if score2 > 0 then
    barFill2Complete = false
    feedbackSystem.multiplayerSupport.addBarFill(2, 1, stringTable[stringTableIndex].lose, score2, 2, nil, function()
      barFill2Complete = true
    end, function(value)
      if not bronze2Set and value >= modeCompData.bronzeMedal then
        if tannerWin then
          feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].bronzeFlashJ, 1)
        else
          feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].bronzeFlashT, 1)
        end
        bronze2Set = true
        OneShotSound.Play("HUD_Gen_Positive_Lite", false)
      elseif not silver2Set and value >= modeCompData.silverMedal then
        if tannerWin then
          feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].silverFlashJ, 1)
        else
          feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].silverFlashT, 1)
        end
        silver2Set = true
        OneShotSound.Play("HUD_Gen_Positive_Lite", false)
      elseif not gold2Set and value >= modeCompData.goldMedal then
        if tannerWin then
          feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].goldFlashJ, 1)
        else
          feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].goldFlashT, 1)
        end
        gold2Set = true
        OneShotSound.Play("HUD_Gen_Positive_Lite", false)
      end
    end)
  else
    barFill2Complete = true
  end
  setCancelButtonCallback(function()
    if SplitScreen.getControllerConnected(0) and SplitScreen.getControllerConnected(1) and not SplitScreen.getIsDisconnectPopupShowing() and barFill2Complete and barFillComplete then
      onlineScreenManager.endScreen(missionName)
      OneShotSound.Play("Menu_Select")
    end
  end)
end
local setCoreTimers = function(startTime, displayTime, endTime)
end
function updateCompScreen()
  feedbackSystem.multiplayerSupport.updateBarFiller()
end
function exitCompScreen(fromPurge)
  PauseMenu.allow(true)
  feedbackSystem.multiplayerSupport.purgeProgBarFiller()
  setCancelButtonCallback(false)
  clearSSModeCompDataTable()
  compScreenComplete = true
  if stringTableIndex then
    feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].bronzeFlashT, 0)
    feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].bronzeFlashJ, 0)
    feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].silverFlashT, 0)
    feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].silverFlashJ, 0)
    feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].goldFlashT, 0)
    feedbackSystem.menusMaster.splitscreenMenusSetVariable(stringTable[stringTableIndex].goldFlashJ, 0)
  end
  stringTableIndex = false
  bronze1Set = false
  silver1Set = false
  gold1Set = false
  bronze2Set = false
  silver2Set = false
  gold2Set = false
  if audioOn then
    OneShotSound.PlayGUI("HUD_Gen_Currency_Increase_Stop", false)
    audioOn = false
  end
  if phaseManager.playlistSupport.durationSelected > 1 then
    if phaseManager.playlistSupport.ssPlayedModeCount < phaseManager.playlistSupport.durationSelected then
      Menu.ResetPage("SplitscreenMenus", "SS_05_hub_gametype")
    else
      phaseManager.networkVars.screenBlockStartTime = g_NetworkTime
      phaseManager.networkVars.screenBlockEndTime = g_NetworkTime + 5
      onlineScreenManager.showScreen(SSCompFinalScreenIndex, phaseManager.networkVars.screenBlockStartTime, false, cards.MissionNetworkLookup[phaseManager.networkVars.modeIndex], false, function()
        return false
      end, 5)
    end
  elseif not fromPurge then
    Menu.ResetPage("SplitscreenMenus", "SS_01_main_menu")
  end
end
local ssCompComplete = {
  enterScreen = enterCompScreen,
  updateScreen = updateCompScreen,
  exitScreen = exitCompScreen,
  preEnter = preEnterScreen,
  getStatus = getScreenStatus,
  finishScreen = setCompleteScreenComplete,
  updateCoreData = setCoreTimers
}
addScreen(SSCompCompleteScreenIndex, "SS COMP COMPLETE SCREEN", ssCompComplete)
