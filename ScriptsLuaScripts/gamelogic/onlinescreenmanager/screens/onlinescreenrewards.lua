module("onlineScreenManager", package.seeall)
local screenStartTime = 0
local displayLength = 0
local screenSet = false
local rewards = false
local auto = true
local timePerReward = 0
local rewardNumber = 0
local progressToNextScreen = false
local xpScreenShowing = false
local timerStartTime = 0
local timerDisplayTime = 0
local xpProgressTarget = 0
local currentXPProgress = 0
local endScreenCallback = false
local vehicleImageShown = false
local unlockImageShown = false
local levelUpEvent = false
local rewardScreenFirstShow = false
local buttonDelayTime = false
local sortRewards = function(rewardA, rewardB)
  if not rewardA then
    return false
  elseif not rewardB then
    return true
  end
  if rewardA.type == rewardB.type then
    return rewardA.info1 > rewardB.info1
  end
  return rewardA.type < rewardB.type
end
local checkForMultiIconPacks = function(rewards)
  local deletionTable = {}
  local image = false
  for i, reward in ripairs(rewards) do
    if reward.type == onlineProgressionSystem.onlineRewardID.icon then
      table.insert(deletionTable, i)
      image = image or reward.info2
    end
  end
  return deletionTable, image
end
local function enterRewardScreens(startTime, displayTime, endCallback, rewardFirstShow)
  timerStartTime = phaseManager.networkVars.screenBlockStartTime
  timerDisplayTime = phaseManager.networkVars.screenBlockEndTime - timerStartTime
  rewards = getRewardTable()
  local image = false
  local delTable = false
  delTable, image = checkForMultiIconPacks(rewards)
  local numIcons = #delTable
  if numIcons > 1 then
    for i, location in ipairs(delTable) do
      table.remove(rewards, location)
    end
    table.insert(rewards, {
      type = onlineProgressionSystem.onlineRewardID.icon,
      info1 = "ID:245937",
      info2 = image,
      info3 = numIcons
    })
  end
  table.sort(rewards, sortRewards)
  auto = true
  rewardNumber = 0
  screenStartTime = 0
  if #rewards - 1 > 0 then
    timePerReward = (displayTime - SMMinXPRewardShowTime) / (#rewards - 1)
  else
    timePerReward = displayTime
  end
  progressToNextScreen = false
  xpScreenShowing = false
  xpFillFuncAdded = false
  unlockImageShown = false
  vehicleImageShown = false
  disableGamerCardHightlight()
  rewardScreenOn = true
  buttonDelayTime = g_NetworkTime
  addUserUpdateFunction("setContinueButton", function()
    if g_NetworkTime - buttonDelayTime > 0.5 then
      feedbackSystem.menusMaster.currentHUDSetTextVariable("multi_seaching_button_A", "%S", nil, localPlayer.buttonLayout.zapSelect)
      removeUserUpdateFunction("setContinueButton")
    end
  end, 1)
  endScreenCallback = endCallback or false
  rewardScreenFirstShow = rewardFirstShow
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_screen_number_total", #rewards)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_screen_number_current", 1)
end
local function progressRewardScreen()
  if auto then
    auto = false
  end
  progressToNextScreen = true
end
local function setRewardScreenManual()
  auto = false
  if rewardNumber == 0 then
    progressRewardScreen()
  end
end
local currentLevel = false
local currentXP = false
local currentXPReq = false
local nextLevel = false
local nextXPReq = false
local prevLevel = false
local prevXP = false
local preXPReq = false
local gainedXP = false
local barFillDelay = 0.02
local barFillTime = 2
local barFillRate = false
local barFillTarget = false
local barFillProg = false
local barFillLvl = false
local lastBarFill = 0
local initialFillDelay = false
local initialFillDelayTime = 2
local function showCurrentLevelStats()
  local currentProgress = 100
  if nextXPReq then
    currentProgress = (currentXP - currentXPReq) / (nextXPReq - currentXPReq) * 100
    local reqXP = nextXPReq - currentXP
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_next_LVL", "ID:248747", nextLevel)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_needed_xp", "ID:221388", reqXP)
  else
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_next_LVL", "")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_needed_xp", "")
  end
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_xp_reward", "ID:220238", gainedXP)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_tot_XP", "ID:220887")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_gained_xp", tostring(currentXP))
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_rewards_XP_gained", currentProgress)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_LVL_text", tostring(currentLevel))
end
function clearRewardFillFunction()
  removeUserUpdateFunction("processXPBarFill")
  OneShotSound.PlayGUI("HUD_Gen_Currency_Increase_Stop", false)
  audioFillOn = false
  xpFillFuncAdded = false
end
local function processXPBarFill()
  if g_NetworkTime - initialFillDelay > initialFillDelayTime and g_NetworkTime - lastBarFill > barFillDelay then
    lastBarFill = g_NetworkTime
    if barFillTarget - barFillRate >= 0 then
      if not audioFillOn and xpFillFuncAdded then
        OneShotSound.PlayGUI("HUD_Gen_Currency_Increase_Play", false)
        audioFillOn = true
      end
      barFillProg = barFillProg + barFillRate
      barFillTarget = barFillTarget - barFillRate
      if barFillProg >= 100 then
        barFillLvl = barFillLvl + 1
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Rewards_lvl_up", 1)
        levelUpEvent = true
        if barFillLvl < #onlineProgressionSystem.onlineLevelData then
          barFillProg = barFillProg - 100
          feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_LVL_text", tostring(barFillLvl))
          feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_next_LVL", "ID:248747", barFillLvl + 1)
        else
          showCurrentLevelStats()
          clearRewardFillFunction()
          return
        end
      end
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_rewards_XP_gained", barFillProg)
      local reqXP = onlineProgressionSystem.onlineLevelData[barFillLvl].xp
      local nxtReqXP = onlineProgressionSystem.onlineLevelData[barFillLvl + 1].xp
      local diff = nxtReqXP - reqXP
      local currentRemainVisXP = diff - diff / 100 * barFillProg
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_needed_xp", "ID:221388", currentRemainVisXP)
    else
      showCurrentLevelStats()
      clearRewardFillFunction()
    end
  end
end
local function showAnimatedlevelStats()
  local nextLvl = prevLevel + 1
  assert(nextLvl <= #onlineProgressionSystem.onlineLevelData, "Cannot show animated xp screen, player was already max level")
  local prevNxtXPReq = onlineProgressionSystem.onlineLevelData[nextLvl].xp
  local reqXP = prevNxtXPReq - prevXP
  local reqDiff = prevNxtXPReq - preXPReq
  barFillProg = (prevXP - preXPReq) / reqDiff * 100
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_next_LVL", "ID:248747", nextLvl)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_needed_xp", "ID:221388", reqXP)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_xp_reward", "ID:220238", gainedXP)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_gained_xp", "")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_tot_XP", "")
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_rewards_XP_gained", barFillProg)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_LVL_text", tostring(prevLevel))
  local tempGained = gainedXP
  local tempXPReq = prevNxtXPReq
  local tempPrevXPReq = false
  local tempNxtLvl = nextLvl
  barFillReq = reqXP
  barFillLvl = prevLevel
  barFillTarget = 0
  while tempGained > 0 do
    if reqXP - tempGained < 0 then
      barFillTarget = barFillTarget + reqXP / reqDiff * 100
      tempNxtLvl = tempNxtLvl + 1
      tempGained = tempGained - reqXP
      if tempNxtLvl <= #onlineProgressionSystem.onlineLevelData then
        tempPrevXPReq = tempXPReq
        tempXPReq = onlineProgressionSystem.onlineLevelData[tempNxtLvl].xp
        reqXP = tempXPReq - tempPrevXPReq
        reqDiff = reqXP
      else
        break
      end
    else
      barFillTarget = barFillTarget + tempGained / reqDiff * 100
      tempGained = 0
    end
  end
  assert(barFillTarget > 0, "Cannot show animated xp screen, no fill required")
  barFillRate = barFillTarget / barFillTime * barFillDelay
  initialFillDelay = g_NetworkTime
  audioFillOn = false
  xpFillFuncAdded = true
  lastBarFill = 0
  addUserUpdateFunction("processXPBarFill", processXPBarFill, 1)
end
local function displayXPReward()
  local maxLevel = #onlineProgressionSystem.onlineLevelData
  currentLevel = onlineProgressionSystem.getLocalPlayerLevel()
  currentXP = onlineProgressionSystem.getLocalPlayerXP()
  currentXPReq = onlineProgressionSystem.onlineLevelData[currentLevel].xp
  nextLevel = currentLevel + 1
  nextXPReq = onlineProgressionSystem.onlineLevelData[nextLevel].xp or maxLevel >= nextLevel and false
  gainedXP = rewards[rewardNumber].info1
  prevXP = currentXP - gainedXP
  prevLevel = onlineProgressionSystem.getLevelFromXP(prevXP)
  preXPReq = onlineProgressionSystem.onlineLevelData[prevLevel].xp
  if rewardScreenFirstShow and maxLevel > prevLevel then
    showAnimatedlevelStats()
  else
    showCurrentLevelStats()
  end
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_screen_name", "ID:169957")
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 6)
  OneShotSound.Play("MP_Reward_XP_Intro", false)
end
local function displayAbilityReward()
  OneShotSound.Play("MP_Reward_AbiIconPlay_Intro", false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 7)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_button_L", "")
  if rewards[rewardNumber].type == onlineProgressionSystem.onlineRewardID.weapon then
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_HOLD DOWN", "ID:242159")
  else
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_HOLD DOWN", "")
  end
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_screen_name", "ID:169958")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_upgrade_you_learned", "ID:169959")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_upgrade_you_learned_text", rewards[rewardNumber].info1)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_upgrade_next_upgrade_level_text", "")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_upgrade_next_upgrade_level", "")
  if ONLINE_PROG_DEBUG then
    print(">>>>>>>>>>>>>>>>>> Display reward Image: " .. tostring(rewards[rewardNumber].info2))
  end
  Menu.DisplayMPUnlock(rewards[rewardNumber].info2)
  unlockImageShown = true
end
local function displayVehicleReward()
  OneShotSound.Play("MP_Reward_Vehicle_Intro", false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 8)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_screen_name", "ID:169962")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_car_name", rewards[rewardNumber].info2)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_car_year", rewards[rewardNumber].info1)
  Menu.DisplayMPVehicleUnlock(rewards[rewardNumber].info3)
  vehicleImageShown = true
end
local function displayIconReward()
  OneShotSound.Play("MP_Reward_AbiIconPlay_Intro", false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 7)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_button_L", "")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_HOLD DOWN", "")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_screen_name", "ID:169963")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_upgrade_you_learned", "ID:169964")
  if not rewards[rewardNumber].info3 then
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_upgrade_you_learned_text", rewards[rewardNumber].info1)
  else
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_upgrade_you_learned_text", rewards[rewardNumber].info1, rewards[rewardNumber].info3)
  end
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_upgrade_next_upgrade_level_text", "")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_upgrade_next_upgrade_level", "")
  if ONLINE_PROG_DEBUG then
    print(">>>>>>>>>>>>>>>>>> Display reward Image: " .. tostring(rewards[rewardNumber].info2))
  end
  Menu.DisplayMPUnlock(rewards[rewardNumber].info2)
  unlockImageShown = true
end
local function displayPlayListReward()
  OneShotSound.Play("MP_Reward_AbiIconPlay_Intro", false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 7)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_button_L", "")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_HOLD DOWN", "")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_screen_name", "ID:236571")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_upgrade_you_learned", "ID:169964")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_upgrade_you_learned_text", rewards[rewardNumber].info1)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_upgrade_next_upgrade_level_text", "")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_upgrade_next_upgrade_level", "")
  if ONLINE_PROG_DEBUG then
    print(">>>>>>>>>>>>>>>>>> Display reward Image: " .. tostring(rewards[rewardNumber].info2))
  end
  Menu.DisplayMPUnlock(rewards[rewardNumber].info2)
  unlockImageShown = true
end
local function showReward()
  if vehicleImageShown then
    Menu.StopDisplayingMPUnlock()
    vehicleImageShown = false
  end
  if unlockImageShown then
    Menu.StopDisplayingMPUnlock()
    unlockImageShown = false
  end
  if levelUpEvent then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Rewards_lvl_up", 0)
    levelUpEvent = false
  end
  if rewards[rewardNumber].type == onlineProgressionSystem.onlineRewardID.xp then
    displayXPReward()
    xpScreenShowing = true
  elseif rewards[rewardNumber].type == onlineProgressionSystem.onlineRewardID.ability or rewards[rewardNumber].type == onlineProgressionSystem.onlineRewardID.weapon then
    displayAbilityReward()
    xpScreenShowing = false
    if xpFillFuncAdded then
      clearRewardFillFunction()
    end
  elseif rewards[rewardNumber].type == onlineProgressionSystem.onlineRewardID.vehicle then
    displayVehicleReward()
    xpScreenShowing = false
    if xpFillFuncAdded then
      clearRewardFillFunction()
    end
  elseif rewards[rewardNumber].type == onlineProgressionSystem.onlineRewardID.icon then
    displayIconReward()
    xpScreenShowing = false
    if xpFillFuncAdded then
      clearRewardFillFunction()
    end
  elseif rewards[rewardNumber].type == onlineProgressionSystem.onlineRewardID.playlist then
    displayPlayListReward()
    xpScreenShowing = false
    if xpFillFuncAdded then
      clearRewardFillFunction()
    end
  end
end
local function autoUpdate()
  if rewardNumber < #rewards then
    local timeOut = xpScreenShowing and SMMinXPRewardShowTime or timePerReward
    if timeOut < g_NetworkTime - screenStartTime then
      rewardNumber = rewardNumber + 1
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_screen_number_current", rewardNumber)
      showReward()
      screenStartTime = g_NetworkTime
    end
  end
end
local function manualUpdate()
  if progressToNextScreen then
    rewardNumber = rewardNumber + 1
    if rewardNumber <= #rewards then
      feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_screen_number_current", rewardNumber)
      showReward()
    else
      assert(endScreenCallback, "NO END OF REWARD CALLBACK PROVIDED, CANNOT RETURN TO THE PREVIOUS SCREEN")
      if xpFillFuncAdded then
        clearRewardFillFunction()
      end
      endScreenCallback()
    end
    progressToNextScreen = false
  end
end
local function updateRewardScreens()
  assert(rewards, "CAN'T UPDATE REWARD SCREENS - REWARDS TABLE IS EMPTY")
  if auto then
    autoUpdate()
  else
    manualUpdate()
  end
  local timeRemaining = math.ceil(timerDisplayTime - (g_NetworkTime - timerStartTime))
  if timeRemaining < 0.1 then
    timeRemaining = 0
  end
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_rewards_qualyfing_txt", timeRemaining)
end
local function exitRewardScreens(blockScreenClose)
  removeUserUpdateFunction("setContinueButton")
  OneShotSound.Play("MP_Reward_Outro", false)
  if not blockScreenClose then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Online_Screen_Show", 0)
    clearRewardTable()
  end
  rewards = false
  displayLength = 0
  screenStartTime = 0
  endScreenCallback = false
  rewardScreenOn = false
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_seaching_button_A", "")
  if xpFillFuncAdded then
    clearRewardFillFunction()
  end
  if vehicleImageShown then
    Menu.StopDisplayingMPUnlock()
    vehicleImageShown = false
  end
  if unlockImageShown then
    Menu.StopDisplayingMPUnlock()
    unlockImageShown = false
  end
  if levelUpEvent then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Rewards_lvl_up", 0)
    levelUpEvent = false
  end
end
rewardScreens = {
  enterScreen = enterRewardScreens,
  updateScreen = updateRewardScreens,
  exitScreen = exitRewardScreens,
  setRewardScreenManual = setRewardScreenManual,
  progressRewardScreen = progressRewardScreen
}
