module("onlineSideBar", package.seeall)
standardSortFuncs = {}
addEntry = false
local hidden = true
local initialised = false
local setByJoinState = false
local sideBarData = {}
local sideBarEntries = 0
local sideBarInitFunc = false
local sideBarDataFunc = false
local sideBarSortFunc = false
local sideBarCleanupFunc = false
local sideBarTeamDataFunc = false
local sideBarTeam = false
local fullSideBarDisplay = false
local lockSideBar = false
local teamOneData = {}
local numTeamOneEntries = 0
local teamTwoData = {}
local numTeamTwoEntries = 0
local localTeam = 0
local remoteTeam = 0
local sidebarMinamised = false
local expandPromptOn = false
local expandPromptStartTime = false
closeSidebar = false
local smallTitleDisplayOn = false
local timerTitleDisplayOn = false
local progTitleDisplayOn = false
local timerFlashOn = false
local updateRequired = false
local playerData = {}
local previousPlayerData = {
  [0] = false,
  [1] = false,
  [2] = false,
  [3] = false,
  [4] = false,
  [5] = false,
  [6] = false,
  [7] = false
}
local queuedTaskObjects = {
  [0] = false,
  [1] = false,
  [2] = false,
  [3] = false,
  [4] = false,
  [5] = false,
  [6] = false,
  [7] = false
}
local soloPlayerShow = false
local soloPlayerName = false
local soloPlayerScore = false
local soloPlayerPosition = false
local soloPlayerHighlight = false
local soloPlayerIsLocal = false
local soloPlayerHand = false
local soloPlayerFlashBlue = false
local soloPlayerFlashRed = false
local soloPlayerZap = false
local soloPlayerExclamation = false
local teamPlayerShowBlue = false
local teamPlayerShowRed = false
local teamPlayerScore = false
local teamPlayerIconBlue = false
local teamPlayerIconRed = false
local teamPlayerName = false
local teamPlayerZapB = false
local teamPlayerZapR = false
local teamPlayerBarB = false
local teamPlayerBarR = false
local teamData = {
  [1] = {
    name = "TEAM",
    endScore = 5,
    currentScore = 0,
    previousScore = 0,
    teamHighlight = 0,
    prevHighlight = 0,
    isDirty = false
  },
  [2] = {
    name = "TEAM",
    endScore = 5,
    currentScore = 0,
    previousScore = 0,
    teamHighlight = 0,
    prevHighlight = 0,
    isDirty = false
  }
}
local sideBarBuilders = {}
local screenDataTable = false
local screenDataSortType = false
local allowLocalSort = true
local expandPromptDelay = false
local function turnOnExpandPrompt(type)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Expand_Prompt_State", type)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Expand_Prompt", 1)
  expandPromptOn = true
  expandPromptStartTime = g_NetworkTime
  removeUserUpdateFunction("turnOnExpandPrompt")
end
function showSidebarExpandPrompt()
  expandPromptDelay = g_NetworkTime
  addUserUpdateFunction("turnOnExpandPrompt", function()
    if g_NetworkTime - expandPromptDelay > 1 then
      turnOnExpandPrompt(fullSidebar and 0)
    end
  end, 1)
end
function hideSidebarExpandPrompt()
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Expand_Prompt", 0)
  expandPromptOn = false
  expandPromptStartTime = false
end
function toggleSmallSidebarTitle(toggle)
  if toggle == 1 ~= smallTitleDisplayOn then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Small_Display", toggle)
    smallTitleDisplayOn = toggle == 1
    if smallTitleDisplayOn then
      OneShotSound.Play("MP_Generic_Whoosh_Single")
    end
  end
end
function toggleTimerSidebarTitle(toggle)
  if toggle == 1 ~= timerTitleDisplayOn then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Large_With_Timer_Show", toggle)
    timerTitleDisplayOn = toggle == 1
    if timerTitleDisplayOn then
      OneShotSound.Play("MP_Generic_Whoosh_Single")
    end
  end
end
function toggleProgressSidebarTitle(toggle, type)
  if type and not progTitleDisplayOn then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Bar_Type", type)
  end
  if toggle == 1 ~= progTitleDisplayOn then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Bar", toggle)
    progTitleDisplayOn = toggle == 1
    if progTitleDisplayOn then
      OneShotSound.Play("MP_Generic_Whoosh_Single")
    end
  end
  if toggle == 0 then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Bar_Progress", 0)
  end
end
function toggleSidebarTimerFlash(toggle)
  timerFlashOn = toggle == 1
  if timerFlashOn and timerTitleDisplayOn then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Flash_Timer", toggle)
  else
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Flash_Timer", 0)
    timerFlashOn = false
  end
end
local function clearMM()
  if sideBarTeam then
    for i = 1, 4 do
      feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerShowBlue[i], 0)
      feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerShowRed[i], 0)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(teamPlayerScore[i + 4], "")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(teamPlayerScore[i], "")
      feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerIconBlue[i], 0)
      feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerIconRed[i], 0)
    end
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Icon_Red", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Icon_Blue", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Blue", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Red", 0)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_total_red", "")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_current_red", "")
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Red", 0)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_total_blue", "")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_current_blue", "")
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Blue", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Display", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Bar_Red_Display", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Bar_Blue_Display", 0)
  else
    for i = 1, 8 do
      feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerShow[i], 0)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(soloPlayerName[i], "")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(soloPlayerScore[i], "")
      feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerHighlight[i], 0)
      feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerIsLocal[i], 0)
      feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerHand[i], 0)
    end
  end
  toggleSmallSidebarTitle(0)
  toggleTimerSidebarTitle(0)
  toggleProgressSidebarTitle(0)
  toggleSidebarTimerFlash(0)
end
function clearPlayerData()
  for i = 0, 7 do
    previousPlayerData[i] = false
  end
  playerData = {}
  teamData[1].endScore = 5
  teamData[1].currentScore = 0
  teamData[1].previousScore = 0
  teamData[1].targetMarker = false
  teamData[1].previousMarker = false
  teamData[1].teamHighlight = 0
  teamData[2].endScore = 5
  teamData[2].currentScore = 0
  teamData[2].previousScore = 0
  teamData[2].targetMarker = false
  teamData[2].previousMarker = false
  teamData[2].teamHighlight = 0
end
function standardSortFuncs.playerScoreSort(playerA, playerB)
  assert(playerA, "playerScoreSort - PLAYER A is invalid")
  assert(playerB, "playerScoreSort - PLAYER B is invalid")
  if playerA.id == playerB.id then
    return false
  end
  if playerA.score == playerB.score then
    if playerA.score > 0 then
      if (playerA.isLocal or playerB.isLocal) and allowLocalSort then
        return playerA.isLocal
      else
        return playerA.id < playerB.id
      end
    else
      local playerAPosition = -1
      local playerBPosition = -1
      assert(screenDataTable, "screenDataTable is not valid")
      for i, player in ipairs(screenDataTable) do
        if player then
          if player.id == playerA.id then
            playerAPosition = i
          elseif player.id == playerB.id then
            playerBPosition = i
          end
        else
          break
        end
      end
      assert(playerAPosition > 0 and playerBPosition > 0, "PLAYER POSITION < 0: " .. tostring(playerAPosition) .. "  " .. tostring(playerBPosition))
      return playerAPosition < playerBPosition
    end
  else
    return playerA.score > playerB.score
  end
  return false
end
function standardSortFuncs.playerInvScoreSort(playerA, playerB)
  assert(playerA, "playerInvScoreSort - PLAYER A is invalid")
  assert(playerB, "playerInvScoreSort - PLAYER B is invalid")
  if playerA.id == playerB.id then
    return false
  end
  if playerA.score == playerB.score then
    if playerA.score > 0 then
      if (playerA.isLocal or playerB.isLocal) and allowLocalSort then
        return playerA.isLocal
      else
        return playerA.id < playerB.id
      end
    else
      local playerAPosition = -1
      local playerBPosition = -1
      assert(screenDataTable, "screenDataTable is not valid")
      for i, player in ipairs(screenDataTable) do
        if player then
          if player.id == playerA.id then
            playerAPosition = i
          elseif player.id == playerB.id then
            playerBPosition = i
          end
        else
          break
        end
      end
      assert(playerAPosition > 0 and playerBPosition > 0, "PLAYER POSITION < 0: " .. tostring(playerAPosition) .. "  " .. tostring(playerBPosition))
      return playerAPosition < playerBPosition
    end
  else
    return playerA.score < playerB.score
  end
  return false
end
local function preModeSort(playerA, playerB)
  assert(playerA, "preModeSort - PLAYER A is invalid")
  assert(playerB, "preModeSort - PLAYER B is invalid")
  if playerA.id == playerB.id then
    return false
  end
  local playerAPosition = -1
  local playerBPosition = -1
  assert(screenDataTable, "screenDataTable is not valid")
  for i, player in ipairs(screenDataTable) do
    if player then
      if player.id == playerA.id then
        playerAPosition = i
      elseif player.id == playerB.id then
        playerBPosition = i
      end
    else
      break
    end
  end
  assert(playerAPosition > 0 and playerBPosition > 0, "PLAYER POSITION < 0: " .. tostring(playerAPosition) .. "  " .. tostring(playerBPosition))
  return playerAPosition < playerBPosition
end
function registerSideBar(builderID, buildFunc)
  assert(not sideBarBuilders[builderID], "Sidebar already registered with system: " .. tostring(builderID))
  sideBarBuilders[builderID] = buildFunc
end
function setSidebar(sidebarID, setInJoinState)
  if not setByJoinState then
    assert(sideBarBuilders[sidebarID], "Sidebar not registered with system: " .. tostring(sidebarID))
    assert(not sideBarDataFunc and not sideBarSortFunc, "Previous sidebar has not been cleared or cleared correctly")
    closeSidebar(true)
    local instance = false
    local disableLocalSort = false
    if phaseManager.faceOffNext() then
      instance = phaseManager.networkVars.modeIndex ~= 0 and faceOffSystem.currentFaceOff or false
    else
      instance = phaseManager.networkVars.modeIndex ~= 0 and challengeSystem.instances[phaseManager.networkVars.modeID] or false
    end
    assert(instance, "Failed to set the sidebar. Instance is invalid - " .. tostring(phaseManager.faceOffNext()))
    sideBarInitFunc, sideBarDataFunc, sideBarCleanupFunc, sideBarSortFunc, sideBarTeam, lockSideBar, fullSideBarDisplay, sideBarTeamDataFunc, disableLocalSort = sideBarBuilders[sidebarID](instance)
    fullSidebar = fullSideBarDisplay
    if disableLocalSort == nil then
      disableLocalSort = false
    end
    hidden = true
    initialised = true
    allowLocalSort = not disableLocalSort
    for i = 0, 7 do
      if queuedTaskObjects[i] then
        addEntry(queuedTaskObjects[i], i, true)
        queuedTaskObjects[i] = false
      end
    end
    setByJoinState = setInJoinState or false
  end
end
local function start()
  assert(sideBarInitFunc and initialised, "Failed to start sidebar - initialised: " .. tostring(initialised) .. "  sideBarInitFunc: " .. tostring(sideBarInitFunc))
  sideBarInitFunc()
  hidden = false
  updateRequired = true
  if sideBarTeam then
    if fullSideBarDisplay then
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Size", 1)
    else
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Size", 0)
    end
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Red", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Blue", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Display", 1)
    localTeam = PlayerGamePlay.getPlayerTeam(localPlayer.playerID)
    remoteTeam = math.abs(localTeam - 3)
    assert(localTeam == 1 or localTeam == 2, "Received an invalid team number from code - " .. tostring(localTeam))
    assert(remoteTeam == 1 or remoteTeam == 2, "Generated an invalid team number for the remote team - " .. tostring(remoteTeam))
    teamData[1].name = "ID:168515"
    teamData[2].name = "ID:168516"
    numTeamOneEntries = 0
    numTeamTwoEntries = 0
  end
  local instance = challengeSystem.instances[phaseManager.networkVars.modeID]
  screenDataSortType = onlineScreenManager.screenSortTypes.scoreNoID
  if instance and instance.challenge.settings.gridSortStyle and 1 < instance.networkVars.roundOn then
    screenDataSortType = instance.challenge.settings.gridSortStyle
  end
  screenDataTable = onlineScreenManager.getScreenCurrentPlayerTable(screenDataSortType)
end
function setHidden(hide)
  NetworkLog.Write(">[LUA] Sidebar: setHidden hide = " .. tostring(hide))
  if hidden ~= hide then
    hidden = hide
    if hide then
      sideBarEntries = 0
      numTeamOneEntries = 0
      numTeamTwoEntries = 0
      if sideBarCleanupFunc then
        sideBarCleanupFunc()
      end
      clearMM()
      if expandPromptOn then
        hideSidebarExpandPrompt()
      end
      removeUserUpdateFunction("turnOnExpandPrompt")
    else
      start()
    end
  end
end
function isHidden()
  return hidden
end
function closeSidebar(setPurge)
  NetworkLog.Write(">[LUA] Sidebar: closeSidebar setPurge = " .. tostring(setPurge))
  if not setPurge and sideBarCleanupFunc then
    sideBarCleanupFunc()
  end
  if not hidden then
    clearMM()
  end
  if not setPurge then
    for i = 0, 7 do
      queuedTaskObjects[i] = false
    end
  end
  clearPlayerData()
  sideBarInitFunc = false
  sideBarDataFunc = false
  sideBarCleanupFunc = false
  sideBarSortFunc = false
  sideBarTeamDataFunc = false
  sideBarTeam = false
  lockSideBar = false
  fullSideBarDisplay = false
  sideBarData = {}
  sideBarEntries = 0
  numTeamOneEntries = 0
  numTeamTwoEntries = 0
  hidden = true
  initialised = false
  setByJoinState = false
  screenDataTable = false
  screenDataSortType = false
  if expandPromptOn then
    hideSidebarExpandPrompt()
  end
  removeUserUpdateFunction("turnOnExpandPrompt")
end
function getSideBarDataSorted()
  return sideBarData
end
function setfullSideBarDisplay(fullSideBar)
  fullSideBarDisplay = fullSideBar
end
function setLockSideBar(lock)
  lockSideBar = lock
end
local function minimiseSideBar()
  if not lockSideBar and fullSideBarDisplay then
    fullSideBarDisplay = false
    if not sideBarTeam then
      for i = 1, 8 do
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerShow[i], 0)
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerIsLocal[i], 0)
      end
      sideBarEntries = 0
      updateRequired = true
      OneShotSound.Play("MP_Generic_Whoosh_Single")
    else
      for i = 1, 4 do
        feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerShowBlue[i], 0)
        feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerShowRed[i], 0)
        feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerIconBlue[i], 0)
        feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerIconRed[i], 0)
      end
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Size", 0)
      OneShotSound.Play("MP_Generic_Whoosh_Double")
      updateRequired = true
    end
  end
end
local function maximiseSideBar()
  if not lockSideBar and not fullSideBarDisplay then
    fullSideBarDisplay = true
    if not sideBarTeam then
      for i = 1, 8 do
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerShow[i], 0)
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerIsLocal[i], 0)
      end
      sideBarEntries = 0
      updateRequired = true
      OneShotSound.Play("MP_Generic_Whoosh_Single")
    else
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Icon_Red", 0)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Icon_Blue", 0)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Blue", 0)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Red", 0)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Size", 1)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Bar_Blue_Display", 0)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Bar_Red_Display", 0)
      OneShotSound.Play("MP_Generic_Whoosh_Double")
      numTeamOneEntries = 0
      numTeamTwoEntries = 0
      updateRequired = true
    end
  end
end
function toggleSideBar()
  if not hidden then
    if fullSidebar then
      fullSidebar = false
      minimiseSideBar()
    else
      fullSidebar = true
      maximiseSideBar()
    end
    if not lockSideBar then
      if expandPromptOn then
        hideSidebarExpandPrompt()
      end
      showSidebarExpandPrompt()
    end
  end
end
function forceMinimiseSidbar()
  local locked = lockSideBar
  lockSideBar = false
  fullSidebar = false
  minimiseSideBar()
  lockSideBar = locked
end
function getSidebarCollapsedPreference()
  return ProfileSettings.GetIsSidebarCollapsed()
end
function setSidebarCollapsedPreference(preference)
  ProfileSettings.SetIsSidebarCollapsed(preference)
end
function autoSetSidebarCollapsedPreference()
  ProfileSettings.SetIsSidebarCollapsed(not fullSidebar)
end
local function drawFullSideBar(full)
  if sideBarEntries ~= #sideBarData then
    if #sideBarData > sideBarEntries then
      for i = 1, #sideBarData do
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerShow[i], 1)
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerHand[i], 0)
      end
    else
      for i = #sideBarData + 1, sideBarEntries do
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerShow[i], 0)
      end
    end
    sideBarEntries = #sideBarData
  end
  for i = 1, #playerData do
    if full or not full and playerData[i].isDirty then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(soloPlayerName[playerData[i].rank], playerData[i].name)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(soloPlayerScore[playerData[i].rank], playerData[i].hideScore or "")
      feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerHighlight[playerData[i].rank], playerData[i].highlight)
      if playerData[i].isLocal then
        local rankString = "ERR"
        if playerData[i].rank == 1 then
          rankString = "ID:221364"
        elseif playerData[i].rank == 2 then
          rankString = "ID:221371"
        elseif playerData[i].rank == 3 then
          rankString = "ID:221372"
        elseif playerData[i].rank == 4 then
          rankString = "ID:221373"
        elseif playerData[i].rank == 5 then
          rankString = "ID:231386"
        elseif playerData[i].rank == 6 then
          rankString = "ID:221381"
        elseif playerData[i].rank == 7 then
          rankString = "ID:221382"
        elseif playerData[i].rank == 8 then
          rankString = "ID:221383"
        end
        feedbackSystem.menusMaster.onlineHUDSetTextVariable(soloPlayerPosition[playerData[i].rank], rankString)
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerIsLocal[playerData[i].rank], 1)
        if previousPlayerData[playerData[i].id] and playerData[i].rank and previousPlayerData[playerData[i].id].rank ~= playerData[i].rank then
          if previousPlayerData[playerData[i].id].rank < playerData[i].rank then
            feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerFlashRed[playerData[i].rank], 1)
          else
            feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerFlashBlue[playerData[i].rank], 1)
          end
        end
      else
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerIsLocal[playerData[i].rank], 0)
      end
      if playerData[i].inZap then
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerZap[playerData[i].rank], 0)
      else
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerZap[playerData[i].rank], 1)
      end
      if playerData[i].target then
        if playerData[i].target == 1 then
          feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerHand[playerData[i].rank], 1)
        else
          feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerExclamation[playerData[i].rank], 1)
        end
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerZap[playerData[i].rank], 2)
      else
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerHand[playerData[i].rank], 0)
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerExclamation[playerData[i].rank], 0)
      end
    end
  end
  updateRequired = false
end
local function drawMinimisedSideBar()
  feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerShow[1], 1)
  feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerShow[2], 0)
  local player = -1
  local target = -1
  local playerShow = -1
  for i = 1, 8 do
    if playerData[i] then
      if playerData[i].isLocal then
        player = i
      end
      if playerData[i].target then
        target = i
      end
    end
  end
  if target ~= -1 and target ~= player then
    playerShow = target
  end
  feedbackSystem.menusMaster.onlineHUDSetTextVariable(soloPlayerName[1], playerData[player].name)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable(soloPlayerScore[1], playerData[player].hideScore or "")
  local rankString = "ERR"
  if playerData[player].rank == 1 then
    rankString = "ID:221364"
  elseif playerData[player].rank == 2 then
    rankString = "ID:221371"
  elseif playerData[player].rank == 3 then
    rankString = "ID:221372"
  elseif playerData[player].rank == 4 then
    rankString = "ID:221373"
  elseif playerData[player].rank == 5 then
    rankString = "ID:231386"
  elseif playerData[player].rank == 6 then
    rankString = "ID:221381"
  elseif playerData[player].rank == 7 then
    rankString = "ID:221382"
  elseif playerData[player].rank == 8 then
    rankString = "ID:221383"
  end
  feedbackSystem.menusMaster.onlineHUDSetTextVariable(soloPlayerPosition[1], rankString)
  feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerHighlight[1], playerData[player].highlight)
  if playerData[player].isLocal then
    feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerIsLocal[1], 1)
    if previousPlayerData[playerData[player].id] and previousPlayerData[playerData[player].id].rank ~= playerData[player].rank then
      if previousPlayerData[playerData[player].id].rank < playerData[player].rank then
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerFlashRed[1], 1)
      else
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerFlashBlue[1], 1)
      end
    end
  else
    feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerIsLocal[1], 0)
  end
  if playerData[player].inZap then
    feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerZap[1], 0)
  else
    feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerZap[1], 1)
  end
  if playerData[player].target then
    if playerData[player].target == 1 then
      feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerHand[1], 1)
    else
      feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerExclamation[1], 1)
    end
    feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerZap[2], 2)
  else
    feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerHand[1], 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerExclamation[1], 0)
  end
  if playerShow ~= -1 then
    feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerShow[2], 1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable(soloPlayerName[2], playerData[playerShow].name)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable(soloPlayerScore[2], playerData[playerShow].hideScore or "")
    feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerHighlight[2], playerData[playerShow].highlight)
    feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerIsLocal[2], 0)
    if playerData[playerShow].inZap then
      feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerZap[2], 0)
    else
      feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerZap[2], 1)
    end
    if playerData[playerShow].target then
      if playerData[playerShow].target == 1 then
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerHand[2], 1)
      else
        feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerExclamation[2], 1)
      end
      feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerZap[2], 2)
    else
      feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerHand[2], 0)
      feedbackSystem.menusMaster.onlineHUDSetVariable(soloPlayerExclamation[2], 0)
    end
  end
  updateRequired = false
end
local tempNumLocalTeam = 0
local tempNumRemoteTeam = 0
local tempPlayerTeamNum = 0
local function drawFullSideBarTeam(full)
  assert(localTeam == 1 or localTeam == 2, "Received an invalid team number from code - " .. tostring(localTeam))
  assert(remoteTeam == 1 or remoteTeam == 2, "Generated an invalid team number for the remote team - " .. tostring(remoteTeam))
  tempNumRemoteTeam = 0
  tempPlayerTeamNum = 0
  tempNumLocalTeam = 0
  for i, player in ipairs(playerData) do
    if PlayerGamePlay.getPlayerTeam(player.id) == localTeam then
      tempNumLocalTeam = tempNumLocalTeam + 1
    elseif PlayerGamePlay.getPlayerTeam(player.id) == remoteTeam then
      tempNumRemoteTeam = tempNumRemoteTeam + 1
    else
      assert(false, "Player is not on a valid team - id " .. tostring(player.id) .. "   team num " .. tostring(PlayerGamePlay.getPlayerTeam(player.id)) .. "  localTeam " .. tostring(localTeam) .. "   remoteTeam " .. tostring(remoteTeam))
    end
  end
  if numTeamOneEntries ~= tempNumLocalTeam then
    if tempNumLocalTeam > numTeamOneEntries then
      for i = 1, tempNumLocalTeam do
        feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerShowBlue[i], 1)
      end
    else
      local diff = numTeamOneEntries - tempNumLocalTeam
      for i = 1, diff do
        feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerShowBlue[numTeamOneEntries - (i - 1)], 0)
      end
    end
    numTeamOneEntries = tempNumLocalTeam
  end
  if numTeamTwoEntries ~= tempNumRemoteTeam then
    if tempNumRemoteTeam > numTeamTwoEntries then
      for i = 1, tempNumRemoteTeam do
        feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerShowRed[i], 1)
      end
    else
      local diff = numTeamTwoEntries - tempNumRemoteTeam
      for i = 1, diff do
        feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerShowRed[numTeamTwoEntries - (i - 1)], 0)
      end
    end
    numTeamTwoEntries = tempNumRemoteTeam
  end
  if teamData[1].isDirty or full then
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_name_blue", teamData[1].name)
    if teamData[localTeam].currentScore then
      if not teamData[1].endScore then
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_current_blue", teamData[1].currentScore)
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_slash_1", "")
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_total_blue", "")
      else
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_current_blue", teamData[1].currentScore)
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_slash_1", "/")
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_total_blue", teamData[1].endScore)
      end
      if full or teamData[1].teamHighlight ~= teamData[1].prevHighlight then
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Blue", teamData[1].teamHighlight)
      end
    else
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_slash_1", "")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_total_blue", "")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_current_blue", "")
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Blue", 0)
    end
    teamData[1].isDirty = false
  end
  if teamData[2].isDirty or full then
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_name_red", teamData[2].name)
    if teamData[localTeam].currentScore then
      if not teamData[2].endScore then
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_current_red", teamData[2].currentScore)
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_slash_2", "")
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_total_red", "")
      else
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_current_red", teamData[2].currentScore)
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_slash_2", "/")
        feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_total_red", teamData[2].endScore)
      end
      if full or teamData[2].teamHighlight ~= teamData[2].prevHighlight then
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Red", teamData[2].teamHighlight)
      end
    else
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_slash_2", "")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_total_red", "")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_current_red", "")
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Red", 0)
    end
    teamData[2].isDirty = false
  end
  local redi = 5
  local bluei = 1
  local listI = 0
  local BPosI = 1
  local RPosI = 1
  local PosI = 0
  for i, player in ipairs(playerData) do
    tempPlayerTeamNum = PlayerGamePlay.getPlayerTeam(player.id)
    if tempPlayerTeamNum == localTeam then
      listI = bluei
      PosI = BPosI
      bluei = bluei + 1
      BPosI = BPosI + 1
    else
      listI = redi
      PosI = RPosI
      redi = redi + 1
      RPosI = RPosI + 1
    end
    if full or not full and player.isDirty then
      playerData[i].isDirty = false
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(teamPlayerName[listI], player.name)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable(teamPlayerScore[listI], player.hideScore or "")
      if tempPlayerTeamNum == localTeam then
        if player.isLocal then
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Player_Is_You", PosI)
        else
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Player_Is_You", 0)
        end
        feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerBarB[PosI], player.highlight)
        if player.inZap then
          feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerZapB[listI], 0)
        else
          feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerZapB[listI], 1)
        end
        if not player.target then
          feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerIconBlue[PosI], 0)
        else
          feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerIconBlue[PosI], player.target)
        end
      else
        feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerBarR[PosI], player.highlight)
        if player.inZap then
          feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerZapR[listI], 0)
        else
          feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerZapR[listI], 1)
        end
        if not player.target then
          feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerIconRed[PosI], 0)
        else
          feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerIconRed[PosI], player.target)
        end
      end
    end
  end
  updateRequired = false
end
local function drawMinimisedSideBarTeam()
  assert(localTeam == 1 or localTeam == 2, "Received an invalid team number from code - " .. tostring(localTeam))
  assert(remoteTeam == 1 or remoteTeam == 2, "Generated an invalid team number for the remote team - " .. tostring(remoteTeam))
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Bar_Blue_Display", 0)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Bar_Red_Display", 0)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_name_blue", teamData[1].name)
  if teamData[localTeam].currentScore then
    if not teamData[1].endScore then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_current_blue", teamData[1].currentScore)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_slash_1", "")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_total_blue", "")
    else
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_current_blue", teamData[1].currentScore)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_slash_1", "/")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_total_blue", teamData[1].endScore)
    end
    if teamData[1].teamHighlight ~= teamData[1].prevHighlight then
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Blue", teamData[1].teamHighlight)
    end
  else
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_slash_1", "")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_total_blue", "")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_current_blue", "")
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Blue", 0)
  end
  teamData[1].isDirty = false
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_name_red", teamData[2].name)
  if teamData[localTeam].currentScore then
    if not teamData[2].endScore then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_current_red", teamData[2].currentScore)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_slash_2", "")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_total_red", "")
    else
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_current_red", teamData[2].currentScore)
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_slash_2", "/")
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_total_red", teamData[2].endScore)
    end
    if teamData[2].teamHighlight ~= teamData[2].prevHighlight then
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Red", teamData[2].teamHighlight)
    end
  else
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_slash_2", "")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_total_red", "")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_team_score_current_red", "")
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Header_Bar_Red", 0)
  end
  teamData[2].isDirty = false
  for i, player in ipairs(playerData) do
    tempPlayerTeamNum = PlayerGamePlay.getPlayerTeam(player.id)
    playerData[i].isDirty = false
    if player.target then
      if tempPlayerTeamNum == localTeam then
        if player.target == 1 then
          feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerIconBlue[1], player.target)
        elseif player.target == 2 then
          feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerIconBlue[1], player.target)
        else
          feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerIconBlue[1], 0)
        end
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Bar_Blue_Display", 1)
        feedbackSystem.menusMaster.onlineHUDSetTextVariable(teamPlayerName[1], player.name)
        feedbackSystem.menusMaster.onlineHUDSetTextVariable(teamPlayerScore[1], player.hideScore or "")
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Bar_Blue_1", player.highlight)
        if player.isLocal then
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Player_Is_You", 1)
        else
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Player_Is_You", 0)
        end
        if player.inZap then
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Player_Zap_Display_Blue_1", 0)
        else
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Player_Zap_Display_Blue_1", 1)
        end
      else
        if player.target == 1 then
          feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerIconRed[1], player.target)
        elseif player.target == 2 then
          feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerIconRed[1], player.target)
        else
          feedbackSystem.menusMaster.onlineHUDSetVariable(teamPlayerIconRed[1], 0)
        end
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Bar_Red_Display", 1)
        feedbackSystem.menusMaster.onlineHUDSetTextVariable(teamPlayerName[5], player.name)
        feedbackSystem.menusMaster.onlineHUDSetTextVariable(teamPlayerScore[5], player.hideScore or "")
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Bar_Red_1", player.highlight)
        if player.inZap then
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Player_Zap_Display_Red_1", 0)
        else
          feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Team_Player_Zap_Display_Red_1", 1)
        end
      end
    end
  end
  updateRequired = false
end
local updateType = 0
local function updateFullSideBar()
  assert(sideBarDataFunc, "Invalid sidebar get data function!")
  updateType = 0
  for i, player in ipairs(playerData) do
    if player then
      previousPlayerData[player.id].name = player.name
      previousPlayerData[player.id].rank = player.rank
      previousPlayerData[player.id].highlight = player.highlight
      previousPlayerData[player.id].score = player.score
      previousPlayerData[player.id].target = player.target
      previousPlayerData[player.id].isLocal = player.isLocal
      previousPlayerData[player.id].inZap = player.inZap
      previousPlayerData[player.id].id = player.id
      playerData[i].isDirty = false
    end
  end
  for i, entry in ipairs(sideBarData) do
    playerData[i].name, playerData[i].highlight, playerData[i].score, playerData[i].isLocal, playerData[i].target, playerData[i].id, playerData[i].hideScore = sideBarDataFunc(entry)
    playerData[i].inZap = playerData[i].isLocal and playerManager.players[playerData[i].id].inZap
  end
  if phaseManager.networkVars.phase == RunModeStateIndex or phaseManager.networkVars.phase == RunFaceOffStateIndex then
    table.sort(playerData, sideBarSortFunc)
  else
    table.sort(playerData, preModeSort)
  end
  for i, player in ipairs(playerData) do
    playerData[i].rank = i
    if not updateRequired then
      if previousPlayerData[player.id].rank ~= playerData[i].rank then
        updateType = 1
      elseif updateType ~= 1 and (previousPlayerData[player.id].highlight ~= player.highlight or previousPlayerData[player.id].score ~= player.score or previousPlayerData[player.id].target ~= player.target or previousPlayerData[player.id].inZap ~= player.inZap) then
        playerData[i].isDirty = true
        updateType = 2
      end
    end
  end
  if not fullSideBarDisplay then
    drawMinimisedSideBar()
  elseif updateRequired or updateType == 1 then
    drawFullSideBar(true)
  elseif updateType == 2 then
    drawFullSideBar(false)
  end
end
local function updateFullSideBarTeam()
  assert(localTeam == 1 or localTeam == 2, "Received an invalid team number from code - " .. tostring(localTeam))
  assert(remoteTeam == 1 or remoteTeam == 2, "Generated an invalid team number for the remote team - " .. tostring(remoteTeam))
  assert(sideBarDataFunc, "Invalid sidebar get data function!")
  assert(sideBarTeamDataFunc, "Invalid sidebar team get data function!")
  updateType = 0
  for i, player in ipairs(playerData) do
    if player then
      previousPlayerData[player.id].name = player.name
      previousPlayerData[player.id].rank = player.rank
      previousPlayerData[player.id].highlight = player.highlight
      previousPlayerData[player.id].score = player.score
      previousPlayerData[player.id].target = player.target
      previousPlayerData[player.id].isLocal = player.isLocal
      previousPlayerData[player.id].inZap = player.inZap
      previousPlayerData[player.id].id = player.id
      playerData[i].isDirty = false
    end
  end
  teamData[1].previousScore = teamData[1].currentScore
  teamData[1].teamHighlight = teamData[1].teamHighlight
  teamData[2].previousScore = teamData[2].currentScore
  teamData[2].prevHighlight = teamData[2].teamHighlight
  for i, entry in ipairs(sideBarData) do
    playerData[i].name, playerData[i].highlight, playerData[i].score, playerData[i].isLocal, playerData[i].target, playerData[i].id, playerData[i].hideScore = sideBarDataFunc(entry)
    playerData[i].inZap = playerData[i].isLocal and playerManager.players[playerData[i].id].inZap
  end
  teamData[1].currentScore, teamData[1].endScore, teamData[1].teamHighlight, teamData[2].currentScore, teamData[2].endScore, teamData[2].teamHighlight = sideBarTeamDataFunc()
  if phaseManager.networkVars.phase == RunModeStateIndex or phaseManager.networkVars.phase == RunFaceOffStateIndex then
    table.sort(playerData, sideBarSortFunc)
  else
    table.sort(playerData, preModeSort)
  end
  for i, player in ipairs(playerData) do
    playerData[i].rank = i
    if not updateRequired then
      if previousPlayerData[player.id].rank ~= playerData[i].rank then
        updateType = 1
      elseif updateType ~= 1 and (previousPlayerData[player.id].highlight ~= player.highlight or previousPlayerData[player.id].score ~= player.score or previousPlayerData[player.id].target ~= player.target or previousPlayerData[player.id].inZap ~= player.inZap) then
        playerData[i].isDirty = true
        updateType = 2
      end
    end
  end
  if teamData[1].currentScore ~= teamData[1].previousScore or teamData[1].prevHighlight ~= teamData[1].teamHighlight then
    teamData[1].isDirty = true
    if updateType ~= 1 then
      updateType = 2
    end
  end
  if teamData[2].currentScore ~= teamData[2].previousScore or teamData[2].prevHighlight ~= teamData[2].teamHighlight then
    teamData[2].isDirty = true
    if updateType ~= 1 then
      updateType = 2
    end
  end
  if not fullSideBarDisplay then
    drawMinimisedSideBarTeam()
  elseif updateRequired or updateType == 1 then
    drawFullSideBarTeam(true)
  elseif updateType == 2 then
    drawFullSideBarTeam(false)
  end
end
function update()
  if not hidden and #sideBarData > 0 then
    if sideBarTeam then
      updateFullSideBarTeam()
    else
      updateFullSideBar()
    end
    if expandPromptOn and g_NetworkTime - expandPromptStartTime > 5 then
      hideSidebarExpandPrompt()
    end
  end
end
function addEntry(entry, playerID, isTaskObject)
  if challengeSystem.instances[phaseManager.networkVars.modeID] and challengeSystem.instances[phaseManager.networkVars.modeID].challenge.settings.tutorial then
    return
  end
  if isTaskObject and not initialised then
    assert(not queuedTaskObjects[playerID], [[
FEEDBACKSYSTEM SIDEBAR - addEntry:
 Attempt to queue an entry in a slot which is already filled ]] .. tostring(playerID))
    NetworkLog.Write(">[LUA] Sidebar: Queuing task object entry PlayerID = " .. tostring(playerID))
    queuedTaskObjects[playerID] = entry
    return
  end
  assert(stateMachine.catchUp or initialised, [[
FEEDBACKSYSTEM SIDEBAR - addEntry:
 Attempt to add entry while the sidebar has not been initialised ]] .. tostring(stateMachine.catchUp) .. " " .. tostring(initialised))
  for i, player in ipairs(playerData) do
    if player.id == playerID then
      return
    end
  end
  NetworkLog.Write(">[LUA] Sidebar: Adding entry PlayerID = " .. tostring(playerID) .. " isTaskObject = " .. tostring(isTaskObject) .. " entry = " .. tostring(entry))
  table.insert(sideBarData, entry)
  table.insert(playerData, {
    name = playerManager.players[playerID].name,
    id = playerID,
    isLocal = localPlayer.playerID == playerID,
    rank = 0,
    highlight = 0,
    score = 0,
    target = 0,
    inZap = false,
    isDirty = true,
    hideScore = false
  })
  assert(#sideBarData < 9, "Error - too many entries in the sidebar data table: " .. tostring(#sideBarData))
  assert(#playerData < 9, "Error - too many entries in the sidebar player data table: " .. tostring(#playerData))
  previousPlayerData[playerID] = {
    name = playerManager.players[playerID].name,
    rank = 0,
    highlight = 0,
    score = 0,
    target = 0,
    isLocal = localPlayer.playerID == playerID,
    inZap = 0,
    id = playerID
  }
  updateRequired = true
end
function addEntries(entries)
  for i, entry in ipairs(entries) do
    addEntry(entry.data, entry.playerID)
  end
end
function removeEntry(entry, playerID)
  if queuedTaskObjects[playerID] then
    queuedTaskObjects[playerID] = false
  end
  NetworkLog.Write(">[LUA] Sidebar: Attempt to remove entry PlayerID = " .. tostring(playerID) .. " entry = " .. tostring(entry) .. " #sideBarData = " .. tostring(#sideBarData))
  if #sideBarData == 0 then
    return
  end
  for i, testEntry in ipairs(sideBarData) do
    if testEntry == entry then
      NetworkLog.Write(">[LUA] Sidebar: Removing entry PlayerID = " .. tostring(playerID) .. " entry = " .. tostring(entry))
      table.remove(sideBarData, i)
      break
    end
  end
  for i, player in ipairs(playerData) do
    if player and player.id == playerID then
      table.remove(playerData, i)
      break
    end
  end
  previousPlayerData[playerID] = false
  updateRequired = true
end
function updateSideBarScreenDataTable(dataTable)
  if not hidden and screenDataTable then
    if challengeSystem.instances[phaseManager.networkVars.modeID] and challengeSystem.instances[phaseManager.networkVars.modeID].challenge.settings.tutorial then
      return
    end
    screenDataTable = onlineScreenManager.getScreenCurrentPlayerTable(screenDataSortType)
  end
end
function removeEntries(entries)
  for i, entry in ipairs(entries) do
    removeEntry(entry.data, entry.playerID)
  end
end
function purge()
  closeSidebar()
  if progTitleDisplayOn then
    toggleProgressSidebarTitle(0)
  end
  if timerTitleDisplayOn then
    toggleTimerSidebarTitle(0)
  end
  if smallTitleDisplayOn then
    toggleSmallSidebarTitle(0)
  end
  if timerFlashOn then
    toggleSidebarTimerFlash(0)
  end
end
soloPlayerShow = {
  [1] = "iMulti_Leaderboard_Display_1",
  [2] = "iMulti_Leaderboard_Display_2",
  [3] = "iMulti_Leaderboard_Display_3",
  [4] = "iMulti_Leaderboard_Display_4",
  [5] = "iMulti_Leaderboard_Display_5",
  [6] = "iMulti_Leaderboard_Display_6",
  [7] = "iMulti_Leaderboard_Display_7",
  [8] = "iMulti_Leaderboard_Display_8"
}
soloPlayerName = {
  [1] = "multi_leaderboard_player_name_1",
  [2] = "multi_leaderboard_player_name_2",
  [3] = "multi_leaderboard_player_name_3",
  [4] = "multi_leaderboard_player_name_4",
  [5] = "multi_leaderboard_player_name_5",
  [6] = "multi_leaderboard_player_name_6",
  [7] = "multi_leaderboard_player_name_7",
  [8] = "multi_leaderboard_player_name_8"
}
soloPlayerScore = {
  [1] = "multi_leaderboard_score_1",
  [2] = "multi_leaderboard_score_2",
  [3] = "multi_leaderboard_score_3",
  [4] = "multi_leaderboard_score_4",
  [5] = "multi_leaderboard_score_5",
  [6] = "multi_leaderboard_score_6",
  [7] = "multi_leaderboard_score_7",
  [8] = "multi_leaderboard_score_8"
}
soloPlayerPosition = {
  [1] = "multi_leaderboard_position_1",
  [2] = "multi_leaderboard_position_2",
  [3] = "multi_leaderboard_position_3",
  [4] = "multi_leaderboard_position_4",
  [5] = "multi_leaderboard_position_5",
  [6] = "multi_leaderboard_position_6",
  [7] = "multi_leaderboard_position_7",
  [8] = "multi_leaderboard_position_8"
}
soloPlayerHighlight = {
  [1] = "iMulti_Leaderboard_Bar_1",
  [2] = "iMulti_Leaderboard_Bar_2",
  [3] = "iMulti_Leaderboard_Bar_3",
  [4] = "iMulti_Leaderboard_Bar_4",
  [5] = "iMulti_Leaderboard_Bar_5",
  [6] = "iMulti_Leaderboard_Bar_6",
  [7] = "iMulti_Leaderboard_Bar_7",
  [8] = "iMulti_Leaderboard_Bar_8"
}
soloPlayerIsLocal = {
  [1] = "iMulti_Leaderboard_IsPlayer_1",
  [2] = "iMulti_Leaderboard_IsPlayer_2",
  [3] = "iMulti_Leaderboard_IsPlayer_3",
  [4] = "iMulti_Leaderboard_IsPlayer_4",
  [5] = "iMulti_Leaderboard_IsPlayer_5",
  [6] = "iMulti_Leaderboard_IsPlayer_6",
  [7] = "iMulti_Leaderboard_IsPlayer_7",
  [8] = "iMulti_Leaderboard_IsPlayer_8"
}
soloPlayerHand = {
  [1] = "iMulti_LeaderBoard_Hand_Display_1",
  [2] = "iMulti_LeaderBoard_Hand_Display_2",
  [3] = "iMulti_LeaderBoard_Hand_Display_3",
  [4] = "iMulti_LeaderBoard_Hand_Display_4",
  [5] = "iMulti_LeaderBoard_Hand_Display_5",
  [6] = "iMulti_LeaderBoard_Hand_Display_6",
  [7] = "iMulti_LeaderBoard_Hand_Display_7",
  [8] = "iMulti_LeaderBoard_Hand_Display_8"
}
soloPlayerFlashBlue = {
  [1] = "iMulti_Leaderboard_Flash_Position_Blue_1",
  [2] = "iMulti_Leaderboard_Flash_Position_Blue_2",
  [3] = "iMulti_Leaderboard_Flash_Position_Blue_3",
  [4] = "iMulti_Leaderboard_Flash_Position_Blue_4",
  [5] = "iMulti_Leaderboard_Flash_Position_Blue_5",
  [6] = "iMulti_Leaderboard_Flash_Position_Blue_6",
  [7] = "iMulti_Leaderboard_Flash_Position_Blue_7",
  [8] = "iMulti_Leaderboard_Flash_Position_Blue_8"
}
soloPlayerFlashRed = {
  [1] = "iMulti_Leaderboard_Flash_Position_Red_1",
  [2] = "iMulti_Leaderboard_Flash_Position_Red_2",
  [3] = "iMulti_Leaderboard_Flash_Position_Red_3",
  [4] = "iMulti_Leaderboard_Flash_Position_Red_4",
  [5] = "iMulti_Leaderboard_Flash_Position_Red_5",
  [6] = "iMulti_Leaderboard_Flash_Position_Red_6",
  [7] = "iMulti_Leaderboard_Flash_Position_Red_7",
  [8] = "iMulti_Leaderboard_Flash_Position_Red_8"
}
soloPlayerZap = {
  [1] = "iMulti_LeaderBoard_Zap_Display_1",
  [2] = "iMulti_LeaderBoard_Zap_Display_2",
  [3] = "iMulti_LeaderBoard_Zap_Display_3",
  [4] = "iMulti_LeaderBoard_Zap_Display_4",
  [5] = "iMulti_LeaderBoard_Zap_Display_5",
  [6] = "iMulti_LeaderBoard_Zap_Display_6",
  [7] = "iMulti_LeaderBoard_Zap_Display_7",
  [8] = "iMulti_LeaderBoard_Zap_Display_8"
}
soloPlayerExclamation = {
  [1] = "iMulti_Leaderboard_Exclamation_Display_1",
  [2] = "iMulti_Leaderboard_Exclamation_Display_2",
  [3] = "iMulti_Leaderboard_Exclamation_Display_3",
  [4] = "iMulti_Leaderboard_Exclamation_Display_4",
  [5] = "iMulti_Leaderboard_Exclamation_Display_5",
  [6] = "iMulti_Leaderboard_Exclamation_Display_6",
  [7] = "iMulti_Leaderboard_Exclamation_Display_7",
  [8] = "iMulti_Leaderboard_Exclamation_Display_8"
}
teamPlayerShowBlue = {
  [1] = "iMulti_Team_Blue_1_Show",
  [2] = "iMulti_Team_Blue_2_Show",
  [3] = "iMulti_Team_Blue_3_Show",
  [4] = "iMulti_Team_Blue_4_Show"
}
teamPlayerShowRed = {
  [1] = "iMulti_Team_Red_1_Show",
  [2] = "iMulti_Team_Red_2_Show",
  [3] = "iMulti_Team_Red_3_Show",
  [4] = "iMulti_Team_Red_4_Show"
}
teamPlayerScore = {
  [1] = "multi_team_player_score_1",
  [2] = "multi_team_player_score_2",
  [3] = "multi_team_player_score_3",
  [4] = "multi_team_player_score_4",
  [5] = "multi_team_player_score_5",
  [6] = "multi_team_player_score_6",
  [7] = "multi_team_player_score_7",
  [8] = "multi_team_player_score_8"
}
teamPlayerIconBlue = {
  [1] = "iMulti_Team_Player_Icon_Blue_1",
  [2] = "iMulti_Team_Player_Icon_Blue_2",
  [3] = "iMulti_Team_Player_Icon_Blue_3",
  [4] = "iMulti_Team_Player_Icon_Blue_4"
}
teamPlayerIconRed = {
  [1] = "iMulti_Team_Player_Icon_Red_1",
  [2] = "iMulti_Team_Player_Icon_Red_2",
  [3] = "iMulti_Team_Player_Icon_Red_3",
  [4] = "iMulti_Team_Player_Icon_Red_4"
}
teamPlayerName = {
  [1] = "multi_team_player_name_1",
  [2] = "multi_team_player_name_2",
  [3] = "multi_team_player_name_3",
  [4] = "multi_team_player_name_4",
  [5] = "multi_team_player_name_5",
  [6] = "multi_team_player_name_6",
  [7] = "multi_team_player_name_7",
  [8] = "multi_team_player_name_8"
}
teamPlayerZapB = {
  [1] = "iMulti_Team_Leaderboard_Zap_Display_B1",
  [2] = "iMulti_Team_Leaderboard_Zap_Display_B2",
  [3] = "iMulti_Team_Leaderboard_Zap_Display_B3",
  [4] = "iMulti_Team_Leaderboard_Zap_Display_B4",
  [5] = "iMulti_Team_Leaderboard_Zap_Display_B5",
  [6] = "iMulti_Team_Leaderboard_Zap_Display_B6",
  [7] = "iMulti_Team_Leaderboard_Zap_Display_B7",
  [8] = "iMulti_Team_Leaderboard_Zap_Display_B8"
}
teamPlayerZapR = {
  [1] = "iMulti_Team_Leaderboard_Zap_Display_R1",
  [2] = "iMulti_Team_Leaderboard_Zap_Display_R2",
  [3] = "iMulti_Team_Leaderboard_Zap_Display_R3",
  [4] = "iMulti_Team_Leaderboard_Zap_Display_R4",
  [5] = "iMulti_Team_Leaderboard_Zap_Display_R5",
  [6] = "iMulti_Team_Leaderboard_Zap_Display_R6",
  [7] = "iMulti_Team_Leaderboard_Zap_Display_R7",
  [8] = "iMulti_Team_Leaderboard_Zap_Display_R8"
}
teamPlayerBarB = {
  [1] = "iMulti_Team_Bar_Blue_1",
  [2] = "iMulti_Team_Bar_Blue_2",
  [3] = "iMulti_Team_Bar_Blue_3",
  [4] = "iMulti_Team_Bar_Blue_4",
  [5] = "iMulti_Team_Bar_Blue_5",
  [6] = "iMulti_Team_Bar_Blue_6",
  [7] = "iMulti_Team_Bar_Blue_7",
  [8] = "iMulti_Team_Bar_Blue_8"
}
teamPlayerBarR = {
  [1] = "iMulti_Team_Bar_Red_1",
  [2] = "iMulti_Team_Bar_Red_2",
  [3] = "iMulti_Team_Bar_Red_3",
  [4] = "iMulti_Team_Bar_Red_4",
  [5] = "iMulti_Team_Bar_Red_5",
  [6] = "iMulti_Team_Bar_Red_6",
  [7] = "iMulti_Team_Bar_Red_7",
  [8] = "iMulti_Team_Bar_Red_8"
}
