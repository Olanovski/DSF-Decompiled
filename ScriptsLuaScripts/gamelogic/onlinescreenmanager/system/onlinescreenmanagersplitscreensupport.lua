module("onlineScreenManager", package.seeall)
local ssTannerModeMedalStringTable = false
local ssJerichoModeMedalStringTable = false
local ssMedalTopTable = false
local ssMedalBottomTable = false
local showMenuElement = Menu.ShowMenuElement
local splitscreenIntroOn = false
splitscreenContinuPressed = false
function setCompSplitscreenMedal(isTanner, top, win, modeNum, played, medalID)
  if not played then
    if isTanner then
      showMenuElement("SplitscreenMenus", ssTannerModeMedalStringTable[modeNum].box, false)
    else
      showMenuElement("SplitscreenMenus", ssJerichoModeMedalStringTable[modeNum].box, false)
    end
    if top then
      showMenuElement("SplitscreenMenus", ssMedalTopTable[modeNum].emptyBox, false)
    else
      showMenuElement("SplitscreenMenus", ssMedalBottomTable[modeNum].emptyBox, false)
    end
  elseif top then
    if isTanner then
      showMenuElement("SplitscreenMenus", ssTannerModeMedalStringTable[modeNum].box, win == true)
    else
      showMenuElement("SplitscreenMenus", ssJerichoModeMedalStringTable[modeNum].box, win == true)
    end
    if not win then
      showMenuElement("SplitscreenMenus", ssMedalTopTable[modeNum].emptyBox, true)
    end
    if medalID == 3 then
      showMenuElement("SplitscreenMenus", ssMedalTopTable[modeNum].bronze, true)
      showMenuElement("SplitscreenMenus", ssMedalTopTable[modeNum].silver, false)
      showMenuElement("SplitscreenMenus", ssMedalTopTable[modeNum].gold, false)
    elseif medalID == 2 then
      showMenuElement("SplitscreenMenus", ssMedalTopTable[modeNum].bronze, false)
      showMenuElement("SplitscreenMenus", ssMedalTopTable[modeNum].silver, true)
      showMenuElement("SplitscreenMenus", ssMedalTopTable[modeNum].gold, false)
    elseif medalID == 1 then
      showMenuElement("SplitscreenMenus", ssMedalTopTable[modeNum].bronze, false)
      showMenuElement("SplitscreenMenus", ssMedalTopTable[modeNum].silver, false)
      showMenuElement("SplitscreenMenus", ssMedalTopTable[modeNum].gold, true)
    else
      showMenuElement("SplitscreenMenus", ssMedalTopTable[modeNum].bronze, false)
      showMenuElement("SplitscreenMenus", ssMedalTopTable[modeNum].silver, false)
      showMenuElement("SplitscreenMenus", ssMedalTopTable[modeNum].gold, false)
    end
  else
    if isTanner then
      showMenuElement("SplitscreenMenus", ssTannerModeMedalStringTable[modeNum].box, win == true)
    else
      showMenuElement("SplitscreenMenus", ssJerichoModeMedalStringTable[modeNum].box, win == true)
    end
    if not win then
      showMenuElement("SplitscreenMenus", ssMedalBottomTable[modeNum].emptyBox, true)
    end
    if medalID == 3 then
      showMenuElement("SplitscreenMenus", ssMedalBottomTable[modeNum].bronze, true)
      showMenuElement("SplitscreenMenus", ssMedalBottomTable[modeNum].silver, false)
      showMenuElement("SplitscreenMenus", ssMedalBottomTable[modeNum].gold, false)
    elseif medalID == 2 then
      showMenuElement("SplitscreenMenus", ssMedalBottomTable[modeNum].bronze, false)
      showMenuElement("SplitscreenMenus", ssMedalBottomTable[modeNum].silver, true)
      showMenuElement("SplitscreenMenus", ssMedalBottomTable[modeNum].gold, false)
    elseif medalID == 1 then
      showMenuElement("SplitscreenMenus", ssMedalBottomTable[modeNum].bronze, false)
      showMenuElement("SplitscreenMenus", ssMedalBottomTable[modeNum].silver, false)
      showMenuElement("SplitscreenMenus", ssMedalBottomTable[modeNum].gold, true)
    else
      showMenuElement("SplitscreenMenus", ssMedalBottomTable[modeNum].bronze, false)
      showMenuElement("SplitscreenMenus", ssMedalBottomTable[modeNum].silver, false)
      showMenuElement("SplitscreenMenus", ssMedalBottomTable[modeNum].gold, false)
    end
  end
end
_G.setCompSplitScreenMedalInTable = setCompSplitscreenMedal
ssTannerModeMedalStringTable = {
  [1] = {
    box = "Msh.splitscreen_bestof_blue_box.gck"
  },
  [2] = {
    box = "Msh.splitscreen_bestof_blue_box.gck (2)"
  },
  [3] = {
    box = "Msh.splitscreen_bestof_blue_box.gck (3)"
  },
  [4] = {
    box = "Msh.splitscreen_bestof_blue_box.gck (4)"
  },
  [5] = {
    box = "Msh.splitscreen_bestof_blue_box.gck (5)"
  },
  [6] = {
    box = "Msh.splitscreen_bestof_blue_box.gck (6)"
  },
  [7] = {
    box = "Msh.splitscreen_bestof_blue_box.gck (7)"
  }
}
ssJerichoModeMedalStringTable = {
  [1] = {
    box = "Msh.splitscreen_bestof_orange_box.gck"
  },
  [2] = {
    box = "Msh.splitscreen_bestof_orange_box.gck (2)"
  },
  [3] = {
    box = "Msh.splitscreen_bestof_orange_box.gck (3)"
  },
  [4] = {
    box = "Msh.splitscreen_bestof_orange_box.gck (4)"
  },
  [5] = {
    box = "Msh.splitscreen_bestof_orange_box.gck (5)"
  },
  [6] = {
    box = "Msh.splitscreen_bestof_orange_box.gck (6)"
  },
  [7] = {
    box = "Msh.splitscreen_bestof_orange_box.gck (7)"
  }
}
ssMedalTopTable = {
  [1] = {
    emptyBox = "Msh.splitscreen_bestof_empty_box.gck",
    bronze = "Spr.medal_bronze",
    silver = "Spr.medal_silver",
    gold = "Spr.medals_gold",
    rank = "SS_00_RANK_1"
  },
  [2] = {
    emptyBox = "Msh.splitscreen_bestof_empty_box.gck (2)",
    bronze = "Spr.medal_bronze (2)",
    silver = "Spr.medal_silver (2)",
    gold = "Spr.medals_gold (2)",
    rank = "SS_00_RANK_2"
  },
  [3] = {
    emptyBox = "Msh.splitscreen_bestof_empty_box.gck (3)",
    bronze = "Spr.medal_bronze (3)",
    silver = "Spr.medal_silver (3)",
    gold = "Spr.medals_gold (3)",
    rank = "SS_00_RANK_3"
  },
  [4] = {
    emptyBox = "Msh.splitscreen_bestof_empty_box.gck (4)",
    bronze = "Spr.medal_bronze (4)",
    silver = "Spr.medal_silver (4)",
    gold = "Spr.medals_gold (4)",
    rank = "SS_00_RANK_4"
  },
  [5] = {
    emptyBox = "Msh.splitscreen_bestof_empty_box.gck (5)",
    bronze = "Spr.medal_bronze (5)",
    silver = "Spr.medal_silver (5)",
    gold = "Spr.medals_gold (5)",
    rank = "SS_00_RANK_5"
  },
  [6] = {
    emptyBox = "Msh.splitscreen_bestof_empty_box.gck (6)",
    bronze = "Spr.medal_bronze (6)",
    silver = "Spr.medal_silver (6)",
    gold = "Spr.medals_gold (6)",
    rank = "SS_00_RANK_6"
  },
  [7] = {
    emptyBox = "Msh.splitscreen_bestof_empty_box.gck (7)",
    bronze = "Spr.medal_bronze (7)",
    silver = "Spr.medal_silver (7)",
    gold = "Spr.medals_gold (7)",
    rank = "SS_00_RANK_7"
  }
}
ssMedalBottomTable = {
  [1] = {
    emptyBox = "Msh.splitscreen_bestof_empty_box.gck (8)",
    bronze = "Spr.medal_bronze (8)",
    silver = "Spr.medal_silver (8)",
    gold = "Spr.medals_gold (8)",
    rank = "SS_00_RANK_1 (2)"
  },
  [2] = {
    emptyBox = "Msh.splitscreen_bestof_empty_box.gck (9)",
    bronze = "Spr.medal_bronze (9)",
    silver = "Spr.medal_silver (9)",
    gold = "Spr.medals_gold (9)",
    rank = "SS_00_RANK_2 (2)"
  },
  [3] = {
    emptyBox = "Msh.splitscreen_bestof_empty_box.gck (10)",
    bronze = "Spr.medal_bronze (10)",
    silver = "Spr.medal_silver (10)",
    gold = "Spr.medals_gold (10)",
    rank = "SS_00_RANK_3 (2)"
  },
  [4] = {
    emptyBox = "Msh.splitscreen_bestof_empty_box.gck (11)",
    bronze = "Spr.medal_bronze (11)",
    silver = "Spr.medal_silver (11)",
    gold = "Spr.medals_gold (11)",
    rank = "SS_00_RANK_4 (2)"
  },
  [5] = {
    emptyBox = "Msh.splitscreen_bestof_empty_box.gck (12)",
    bronze = "Spr.medal_bronze (12)",
    silver = "Spr.medal_silver (12)",
    gold = "Spr.medals_gold (12)",
    rank = "SS_00_RANK_5 (2)"
  },
  [6] = {
    emptyBox = "Msh.splitscreen_bestof_empty_box.gck (13)",
    bronze = "Spr.medal_bronze (13)",
    silver = "Spr.medal_silver (13)",
    gold = "Spr.medals_gold (13)",
    rank = "SS_00_RANK_6 (2)"
  },
  [7] = {
    emptyBox = "Msh.splitscreen_bestof_empty_box.gck (14)",
    bronze = "Spr.medal_bronze (14)",
    silver = "Spr.medal_silver (14)",
    gold = "Spr.medals_gold (14)",
    rank = "SS_00_RANK_7 (2)"
  }
}
function showSplitscreenIntro(modeID)
  if not splitscreenIntroOn then
    phaseManager.splitscreenModeLoaded = false
    splitscreenContinuPressed = false
    Menu.ChangePage("Loading", "SS_popup_loading")
    Menu.SetVariable("Loading", "iSS_loading_continue_prompt", 3)
    Menu.SetVariable("Loading", "iSS_loading_arrow_display", 1)
    Menu.SetTextVariable("Loading", "ss_loading_title", onlineScreenData[modeID].displayTitle)
    Menu.SetTextVariable("Loading", "ss_loading_line_1", onlineScreenData[modeID].SSinstructions_line_1)
    Menu.SetTextVariable("Loading", "ss_loading_line_2", onlineScreenData[modeID].SSinstructions_line_2)
    Menu.SetTextVariable("Loading", "ss_loading_line_3", onlineScreenData[modeID].SSinstructions_line_3)
    splitscreenIntroOn = true
    PauseMenu.allow(false)
    OneShotSound.Play("HUD_SplitScreen_Instructions_OneShot")
  end
end
function onSplitscreenModeLoaded()
  phaseManager.splitscreenModeLoaded = true
  Menu.SetVariable("Loading", "iSS_loading_arrow_display", 3)
  Menu.SetVariable("Loading", "iSS_loading_continue_prompt", 1)
end
function closeSplitscreenIntro()
  if splitscreenIntroOn then
    Menu.SetVariable("Loading", "iSS_loading_continue_prompt", 3)
    Menu.GoBackPage("Loading", 1)
    splitscreenIntroOn = false
    PauseMenu.allow(true)
  end
end
_G.closeSplitscreenIntro = closeSplitscreenIntro
function isSplitscreenIntroOn()
  return splitscreenIntroOn
end
function getSSModeMedalRequirements()
  local modeID = phaseManager.playlistSupport.getCurrentMission()
  assert(onlineScreenData[modeID], "Mode not found in screen manager data table")
  assert(onlineScreenData[modeID].bronzeMedalReq, "Bronze medal requirement not found in screen manager data table")
  assert(onlineScreenData[modeID].silverMedalReq, "Silver medal requirement not found in screen manager data table")
  assert(onlineScreenData[modeID].goldMedalReq, "Gold medal requirement not found in screen manager data table")
  return onlineScreenData[modeID].bronzeMedalReq, onlineScreenData[modeID].silverMedalReq, onlineScreenData[modeID].goldMedalReq
end
_G.getSSModeMedalRequirements = getSSModeMedalRequirements
local ssCoopModeResults = {levelReached = -1, medalAchieved = 0}
function resetSSCoopModeResults()
  ssCoopModeResults.levelReached = -1
  ssCoopModeResults.medalAchieved = 0
  feedbackSystem.splitScreenSupport.clearRoundWinMarkers()
end
function setSSCoopModeResults(level, medal)
  ssCoopModeResults.levelReached = level
  ssCoopModeResults.medalAchieved = medal
end
function getSSCoopModeResults()
  local instance = challengeSystem.instances[phaseManager.networkVars.modeID]
  if instance then
    assert(instance.getPlayerProgress, "Failed to get players progress. Failed to find progress function")
    ssCoopModeResults.levelReached, ssCoopModeResults.medalAchieved = instance:getPlayerProgress()
  end
  return ssCoopModeResults.levelReached, ssCoopModeResults.medalAchieved
end
_G.getSSCoopModeResults = getSSCoopModeResults
function getSSFreeDriveStats(localID)
  local player = localPlayerManager.players[localID]
  assert(player, "Player not found")
  assert(phaseManager.playlistSupport.getCurrentMission() == "SS Freedrive", "Trying to get free drive stats when not in freedrive")
  local taskObject = player.getTaskObject()
  if taskObject then
    local di = taskObject.namedTasks.distance and taskObject.namedTasks.distance.stat or 0
    local vc = taskObject.namedTasks.vehicle and taskObject.namedTasks.vehicle.vehicles or 0
    local sp = taskObject.namedTasks.speed and taskObject.namedTasks.speed.stat or 0
    local ov = taskObject.namedTasks.jump and taskObject.namedTasks.jump.stat or 0
    local dr = taskObject.namedTasks.drift and taskObject.namedTasks.drift.stat or 0
    return di, sp, vc, ov, dr
  end
  return 0, 0, 0, 0, 0
end
_G.getSSFreeDriveStats = getSSFreeDriveStats
function resetSSFreeDriveStats(localID)
  local player = localPlayerManager.players[localID]
  if player then
    local taskObject = player.getTaskObject()
    if taskObject then
      if taskObject.namedTasks.distance then
        taskObject.namedTasks.distance.stat = 0
      end
      if taskObject.namedTasks.vehicle then
        taskObject.namedTasks.vehicle.vehicles = 0
      end
      if taskObject.namedTasks.speed then
        taskObject.namedTasks.speed.stat = 0
      end
      if taskObject.namedTasks.jump then
        taskObject.namedTasks.jump.stat = 0
      end
      if taskObject.namedTasks.drift then
        taskObject.namedTasks.drift.stat = 0
      end
    end
  end
end
_G.resetSSFreeDriveStats = resetSSFreeDriveStats
