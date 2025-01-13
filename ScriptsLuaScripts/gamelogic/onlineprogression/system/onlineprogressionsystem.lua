module("onlineProgressionSystem", package.seeall)
local onlineProgressionData = {}
local playerXP = 0
local playerLevel = 0
local playerTotalXP = 0
local previousXP = 0
local showRewardScreen = false
local playersInGame = {}
local faceOffMatchBonus = 0
local missionStartTime = 0
local missionID = false
local showProgressionDebugText = false
onlineMissionActive = false
abilityBalancelevelCap = 12
local playListDataSet = false
function getLocalPlayerLevel()
  return playerLevel
end
_G.getLocalPlayerLevel = getLocalPlayerLevel
function getXPForLevelUnlock(level)
  local xpRequired = 0
  if onlineLevelData[level] then
    local targetXP = onlineLevelData[level].xp
    xpRequired = targetXP - playerTotalXP
  end
  if xpRequired == -1 then
    print("ERROR IN GETTING XP REQUIRED TO GET TO LEVEL " .. tostring(level) .. " Current Level = " .. tostring(playerLevel))
  end
  return xpRequired
end
_G.getXPForLevelUnlock = getXPForLevelUnlock
function getPlayerLastXPEarned(playerID)
  if playerID == localPlayer.playerID then
    return playerTotalXP - previousXP
  else
    local playerData = onlineScreenManager.getPlayerScreenDataTable()[playerID]
    if playerData then
      return playerData.xp - playerData.previousXP
    else
      return 0
    end
  end
  return 0
end
_G.getPlayerLastXPEarned = getPlayerLastXPEarned
function setProgressionData(progressionData)
  onlineProgressionData = progressionData
end
function mainTaskObjectSet(mainTaskObject)
  cleanupProgressionGoals()
  for key, data in next, onlineProgressionData, nil do
    local object = false
    if key ~= "localPlayer" then
      assert(#data > 0, "DATA TABLE IS EMPTY")
      object = mainTaskObject.coreData.instance.taskObjectsByActorID[key]
    end
    goalSystem.onlineProgressionSupport.registerObject(object, key, data)
  end
  onlineMissionActive = true
  if not missionID then
    missionID = mainTaskObject.coreData.instance.challenge.name
    missionStartTime = g_NetworkTime
  end
  if ONLINE_PROG_DEBUG then
    print("<<<<<<<<<<<<<<<<<<<<<<<< Online Progression System mainTaskObjectSet")
  end
end
function progressionGoalCompleteCallback(objectKey, key, completeData)
  local xpGain = 0
  local subTable = onlineProgressionData[objectKey]
  if completeData.xpModifier then
    xpGain = math.floor(subTable[key].progressionData.exp * completeData.xpModifier)
    playerXP = playerXP + xpGain
  else
    playerXP = playerXP + subTable[key].progressionData.exp
    xpGain = subTable[key].progressionData.exp
  end
  if xpGain > subTable[key].progressionData.minShowXP then
    feedbackSystem.eventMessages.addMessage(3, "+" .. tostring(xpGain) .. " XP", subTable[key].progressionData.completeText, "", localPlayer.playerID, subTable[key].progressionData.groupXP, xpGain, subTable[key].progressionData.groupLimit)
  end
  if ONLINE_PROG_DEBUG then
    print("<<<<<<<<<<<<<<<<<<<<<<<< Online Progression System progressionGoalCompleteCallback : key - " .. tostring(key) .. "  playerXP( old ) - " .. tostring(playerXP - xpGain) .. "   playerXP - " .. tostring(playerXP) .. "  xpGain - " .. tostring(xpGain) .. "   completeData.xpModifier - " .. tostring(completeData.xpModifier))
  end
end
function cleanupProgressionGoals()
  if ONLINE_PROG_DEBUG then
    print("<<<<<<<<<<<<<<<<<<<<<<<< Online Progression System cleanupProgressionGoals")
  end
  goalSystem.onlineProgressionSupport.unregisterAllObjects()
end
function cleanupProgressionData()
  onlineProgressionData = {}
end
local timeInFaceOff = false
local faceOffPercentScore = false
function setTimeInFaceOff(time)
  NetworkLog.Write(">[LUA] Online Progression - setTimeInFaceOff - " .. tostring(time))
  timeInFaceOff = time
  if ONLINE_PROG_DEBUG then
    print("<<<<<<<<<<<<<<<<<<<<<<<< Online Progression System progressionMissionComplete: setTimeInFaceOff - " .. tostring(timeInFaceOff))
  end
end
function setFaceOffPercentScore(score)
  NetworkLog.Write(">[LUA] Online Progression - setFaceOffPercentScore - " .. tostring(score))
  faceOffMatchBonus = 0
  faceOffPercentScore = score
  if ONLINE_PROG_DEBUG then
    print("<<<<<<<<<<<<<<<<<<<<<<<< Online Progression System progressionMissionComplete: setFaceOffPercentScore - " .. tostring(score))
  end
end
function getLocalPlayerEarnedXP()
  return playerXP
end
_G.getLocalPlayerEarnedXP = getLocalPlayerEarnedXP
function addFaceoffMatchBonus()
  assert(timeInFaceOff, "Failed to generate faceoff xp - timeInFaceOff = " .. tostring(timeInFaceOff))
  assert(faceOffPercentScore, "Failed to generate faceoff xp - faceOffPercentScore = " .. tostring(faceOffPercentScore))
  local baseXP = onlineMatchBonusData.faceoff.baseXPValue()
  local timeBonusXP = math.min(0.5 + faceOffPercentScore * 2, 1)
  faceOffMatchBonus = math.floor(baseXP * timeInFaceOff * (timeBonusXP + faceOffPercentScore))
  playerXP = playerXP + faceOffMatchBonus
  feedbackSystem.eventMessages.addMessage(3, "+" .. tostring(faceOffMatchBonus) .. " XP", "ID:245964", localPlayer.playerID, false)
  if ONLINE_PROG_DEBUG then
    print("<<<<<<<<<<<<<<<<<<<<<<<< Online Progression System progressionMissionComplete: addFaceoffMatchBonus - " .. tostring(faceOffMatchBonus) .. "   baseXP: " .. tostring(baseXP))
  end
  faceOffPercentScore = false
  timeInFaceOff = false
end
function endProgressionGoals()
  onlineMissionActive = false
  goalSystem.update()
  cleanupProgressionGoals()
end
function progressionMissionComplete(success)
  if ONLINE_PROG_DEBUG then
    print("<<<<<<<<<<<<<<<<<<<<<<<< Online Progression System progressionMissionComplete: success - " .. tostring(success))
  end
  local instance = localPlayer.getTaskObject().coreData.instance
  local tutorialFirstPlay = instance.challenge.settings.tutorial and not PlayerCoreStats.getTutorialFlag(instance.challenge.settings.tutorialStatID) or false
  if instance.challenge.settings.tutorial and not missionID then
    missionID = instance.challenge.name
  end
  if not gameStatus.splitscreenSession and (gameStatus.onlineSessionType == gameStatus.onlineSessionID.public or tutorialFirstPlay) then
    if tutorialFirstPlay then
      PlayerCoreStats.updateLocalTutorialFlag(instance.challenge.settings.tutorialStatID, true)
      Statistics.dispatchWrite()
    end
    feedbackSystem.eventMessages.pushXPGroup()
    if onlineProgressionData.localPlayer and onlineProgressionData.localPlayer.getMatchBonus and (missionStartTime > 0 or tutorialFirstPlay) then
      assert(missionID, "Failed to generate match bonus: missionID not set")
      assert(not timeInFaceOff and not faceOffPercentScore, "Online progression XP error - faceOffMatchBonus = " .. tostring(faceOffMatchBonus) .. " faceoff xp may not have been added")
      assert(playerXP - faceOffMatchBonus >= 0, "Online progression XP error - playerXP = " .. tostring(playerXP) .. " faceOffMatchBonus = " .. tostring(faceOffMatchBonus))
      local threshold = onlineMatchBonusData[missionID].threshold
      local baseXP = onlineMatchBonusData[missionID].baseXPValue(success)
      local matchBonus = math.floor(onlineProgressionData.localPlayer.getMatchBonus(g_NetworkTime - missionStartTime, threshold, baseXP, playerXP - faceOffMatchBonus))
      local sortType = onlineScreenManager.screenSortTypes.score
      if onlineScreenManager.isRaceCompleteData() then
        sortType = onlineScreenManager.screenSortTypes.race
      end
      local playerTable = onlineScreenManager.getScreenCurrentPlayerTable(sortType)
      local playerPos = 8
      local teamGame = phaseManager.missionIntroData[missionID].teams
      local teamWin = teamGame and success or false
      for i, player in ipairs(playerTable) do
        if player and player.id == localPlayer.playerID then
          playerPos = i
          break
        end
      end
      if ONLINE_PROG_DEBUG then
        print("Online Progression - mode complete - \n" .. "   Mode ID: " .. tostring(missionID) .. "\n" .. "   Mode Start: " .. tostring(missionStartTime) .. "\n" .. "   Mode End: " .. tostring(g_NetworkTime) .. "\n" .. "   Mode Duration: " .. tostring(g_NetworkTime - missionStartTime) .. "\n" .. "   Qualifying Bonus: " .. tostring(faceOffMatchBonus) .. "\n" .. "   Action Total: " .. tostring(playerXP - faceOffMatchBonus) .. "\n" .. "   Match Bonus Base XP: " .. tostring(baseXP) .. "\n" .. "   Match Bonus Threshold: " .. tostring(threshold) .. "\n" .. "   Match Bonus: " .. tostring(matchBonus) .. "\n" .. "   Total Earned: " .. tostring(playerXP + matchBonus) .. "\n" .. "   Position: " .. tostring(playerPos) .. "\n" .. "   Team Game: " .. tostring(teamGame) .. "\n" .. "   Team Win: " .. tostring(teamWin) .. "\n" .. "End Online Progression ")
      end
      NetworkLog.Write(">[LUA] Online Progression - mode complete - \n" .. "     Mode ID: " .. tostring(missionID) .. "\n" .. "     Mode Start: " .. tostring(math.floor(missionStartTime)) .. "\n" .. "     Mode Duration: " .. tostring(math.floor(g_NetworkTime - missionStartTime)) .. "\n" .. "     Qualifying Bonus: " .. tostring(faceOffMatchBonus) .. "\n" .. "     Action Total: " .. tostring(playerXP - faceOffMatchBonus) .. "\n" .. "     Match Bonus: " .. tostring(matchBonus) .. "\n" .. "     Total Earned: " .. tostring(playerXP + matchBonus) .. "\n" .. "     Position: " .. tostring(playerPos) .. "\n" .. "     Team Win: " .. tostring(teamWin) .. "\n" .. ">[LUA] End Online Progression ")
      if matchBonus > 0 then
        feedbackSystem.eventMessages.addMessage(3, "+" .. tostring(matchBonus) .. " XP", "ID:221758", localPlayer.playerID, false)
      end
      playerXP = playerXP + matchBonus
    end
    missionID = false
    faceOffMatchBonus = 0
  end
end
function processLevelUp()
  if ONLINE_PROG_DEBUG then
    print("<<<<<<<<<<<<<<<<<<<<<<<< Online Progression System processLevelUp:   previousXP - " .. tostring(playerTotalXP) .. "    playerTotalXP - " .. tostring(playerTotalXP + playerXP) .. "    playerXP - " .. tostring(playerXP))
  end
  previousXP = playerTotalXP
  playerTotalXP = playerTotalXP + playerXP
  playerXP = 0
  PlayerCoreStats.updateLocalTotalXP(playerTotalXP)
  NetworkLog.Write(">[LUA] - Online Progression System - Update Server XP: " .. tostring(playerTotalXP))
  local newLevel = 0
  for i, levelData in ipairs(onlineLevelData) do
    if playerTotalXP >= levelData.xp then
      newLevel = newLevel + 1
    else
      break
    end
  end
  if newLevel > playerLevel then
    if ONLINE_PROG_DEBUG then
      print("<<<<<<<<<<<<<<<<<<<<<<<< Online Progression System processLevelUp - Level Up : Old Level - " .. tostring(playerLevel) .. "  New Level - " .. tostring(newLevel))
    end
    setPlayerLevel(newLevel)
    OnlineAchievements.onRankChange(newLevel)
    local statID = getStatIDByStatName("MP_LEVEL")
    Statistics.updateStat(statID, getStatType(statID), newLevel)
  end
  if playerTotalXP - previousXP > 0 then
    local targetXP = 0
    if playerLevel < 30 and playerLevel ~= #onlineLevelData then
      targetXP = getXPForLevelUnlock(playerLevel + 1)
    end
    onlineScreenManager.addRewardUnlock(onlineRewardID.xp, playerTotalXP - previousXP, targetXP)
  end
  onlineScreenManager.updatePlayerXP(localPlayer.playerID, playerTotalXP)
  ProfileSettings.SetMultiplayerProgressionLevel(newLevel)
end
local debugPosVec = vec.vector(0.6, 0.29, 0, 1)
local debugColVec = vec.vector(0.75, 0.21, 0.75, 1)
function progressionUpdate()
  if showProgressionDebugText or phaseManager.modeDebugInfo then
    Development:add2DText(1999, "Level: " .. tostring(playerLevel) .. " Total XP:" .. tostring(playerTotalXP) .. " XP Earned: " .. tostring(playerXP), debugPosVec, debugColVec, 0.75, 4)
  end
end
function progressionSetup(useServerXP)
  if ONLINE_PROG_DEBUG then
    print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: progressionSetup")
  end
  resetPlayerProgression()
  if useServerXP and not devSetMaxOnlineXP then
    playerTotalXP = PlayerCoreStats.getPlayerTotalXP(localPlayer.playerID)
  else
    local maxLevel = #onlineLevelData
    local maxLevelXP = onlineLevelData[maxLevel].xp
    playerTotalXP = maxLevelXP
  end
  local level = 0
  for i, levelData in ipairs(onlineLevelData) do
    if playerTotalXP >= levelData.xp then
      level = i
    else
      break
    end
  end
  if localPlayerManager.numberOfPlayers > 1 then
    level = 4
  end
  setPlayerLevel(level, true)
  missionStartTime = 0
  missionID = false
  if not playListDataSet then
    local rewardUnlockType = -1
    for i, type in ipairs(onlineRewardData) do
      if type == onlinePlaylistUnlockData then
        rewardUnlockType = i
        break
      end
    end
    assert(rewardUnlockType > 0, "Cannot set playlist unlock data. Playlist unlock data table not found")
    local numUnlocks = OnlineGameConfigLua.GetStringConfig("Config", "PlaylistsCount")
    local progUnlock = false
    local playlistName = false
    local rewardCount = 1
    local unlockImage = "NONE"
    for i = 1, numUnlocks do
      progUnlock = tonumber(OnlineGameConfigLua.GetStringConfig("Playlist" .. i, "ProgressionLevel"))
      playlistName = OnlineGameConfigLua.GetStringConfig("Playlist" .. i, "Name")
      configHidden = OnlineGameConfigLua.GetStringConfig("Playlist" .. i, "Hidden")
      unlockImage = OnlineGameConfigLua.GetStringConfig("Playlist" .. i, "UnlockImage")
      assert(progUnlock and playlistName and configHidden, "Cannot set playlist unlock data. Data retrieved from config file is not valid")
      if progUnlock and playlistName and configHidden and configHidden ~= "true" then
        table.insert(onlinePlaylistUnlockData, {
          name = playlistName,
          unlocked = false,
          new = false,
          image = unlockImage
        })
        table.insert(onlineLevelData[progUnlock].rewards, {rewardType = rewardUnlockType, rewardIndex = rewardCount})
        rewardCount = rewardCount + 1
      end
    end
    playListDataSet = true
  end
  local isLan = Network.isLANGame()
  if not isLan and Unlockables.IsUnlocked(5) then
    unlockUPlayCarPack()
  end
  if not isLan then
    unlockPreOrderCarPack()
  end
  feedbackSystem.eventMessages.clearMessages()
  onlineScreenManager.clearRewardTable()
  if localPlayer.blockedAbilities.ZapSwap then
    localPlayer:blockAbility("ZapSwap", false)
    if ONLINE_PROG_DEBUG then
      print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: unblock swap")
    end
  end
  if localPlayer.blockedAbilities.ZapSpawn then
    localPlayer:blockAbility("ZapSpawn", false)
    if ONLINE_PROG_DEBUG then
      print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: unblock spawn")
    end
  end
  if localPlayer.blockedAbilities.ZapImpulse then
    localPlayer:blockAbility("ZapImpulse", false)
    if ONLINE_PROG_DEBUG then
      print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: unblock impulse")
    end
  end
  previousXP = playerTotalXP
  playerXP = 0
  onlineScreenManager.setPlayerXP(localPlayer.playerID, playerTotalXP)
  if ONLINE_PROG_DEBUG then
    print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: Player XP - " .. tostring(playerTotalXP) .. "   Player Level - " .. tostring(playerLevel))
  end
end
function addRemotePlayerToGameList(playerID)
  PlayerCoreStats.updateLocalTotalXP(playerTotalXP)
end
function getLocalPlayerXP()
  return playerTotalXP
end
_G.getLocalPlayerXP = getLocalPlayerXP
function getLocalPlayerPreviousXP()
  return previousXP
end
_G.getLocalPlayerPreviousXP = getLocalPlayerPreviousXP
function getLocalPlayerXPGained()
  return playerXP
end
function getPlayerXP(playerID)
  if playerID == localPlayer.playerID then
    return getLocalPlayerXP()
  end
  for i, player in ipairs(playersInGame) do
    if player.playerID == playerID then
      return player.currentXP
    end
  end
  return 0
end
_G.getPlayerXP = getPlayerXP
function getPlayerXPGained(playerID)
  if playerID == localPlayer.playerID then
    return getLocalPlayerXPGained()
  end
  for i, player in ipairs(playersInGame) do
    if player.playerID == playerID then
      return player.currentXP - player.startXP
    end
  end
  return 0
end
function getPlayerLevel(playerID)
  local xp = 0
  local level = 0
  if playerID == localPlayer.playerID then
    xp = playerTotalXP
  else
    xp = getPlayerXP(playerID)
  end
  return getLevelFromXP(xp)
end
_G.onlineGetPlayerLevel = getPlayerLevel
function getLevelFromXP(xp)
  local level = 0
  for i, levelData in ipairs(onlineLevelData) do
    if xp >= levelData.xp then
      level = i
    else
      break
    end
  end
  return level
end
_G.onlineGetPlayerLevelFromXP = getLevelFromXP
function getXPFromLevel(level)
  assert(level <= #onlineLevelData, "getXPFromLevel - level is greater than the max level: level = " .. tostring(level) .. "    max level = " .. tostring(#onlineLevelData))
  return onlineLevelData[level].xp
end
_G.onlineGetPlayerXPFromLevel = getXPFromLevel
function enableOnlineProgression()
  enableCityLocking(false)
  activeChallenges.enable(false)
end
function onlineEnableUnlockedAbilities()
  for i, abilityData in ipairs(onlineAbilityData) do
    if abilityData.unlocked and abilityData.unlockFunc then
      abilityData.unlockFunc()
    end
  end
end
function areZapWeaponsUnlocked()
  if gameStatus.onlineSessionType == gameStatus.onlineSessionID.private and not phaseManager.playlistSupport.networkVars.allowSwap and not phaseManager.playlistSupport.networkVars.allowSpawn and not phaseManager.playlistSupport.networkVars.allowImpulse then
    return false
  end
  for i, weaponData in ipairs(onlineWeaponData) do
    if weaponData.unlocked then
      return true
    end
  end
  return false
end
function setPlayerLevel(level, initialSetup)
  local maxLevel = #onlineLevelData
  if level > maxLevel then
    level = maxLevel
  end
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_willpower_level_number", level)
  local imageCount = 0
  Menu.UnloadMPImages()
  for j = initialSetup and playerLevel + 1, level do
    if ONLINE_PROG_DEBUG then
      print("<<<<<<<<<<<<<<<<<<<<<<<< Online Progression System Unlock Level : " .. tostring(j))
    end
    for i, reward in ipairs(onlineLevelData[j].rewards) do
      onlineRewardData[reward.rewardType][reward.rewardIndex].unlocked = true
      if onlineRewardData[reward.rewardType][reward.rewardIndex].unlockFunc then
        onlineRewardData[reward.rewardType][reward.rewardIndex].unlockFunc()
      end
      if not initialSetup and imageCount < 10 then
        if ONLINE_PROG_DEBUG then
          print("<<<<<<<<<<<<<<<<<<<<<<<< Online Progression System setPlayerLevel Add reward unlock : rewardType - " .. tostring(reward.rewardType) .. " rewardIndex - " .. tostring(reward.rewardIndex) .. " name - " .. tostring(onlineRewardData[reward.rewardType][reward.rewardIndex].name))
        end
        if reward.rewardType == 1 then
          onlineScreenManager.addRewardUnlock(onlineRewardID.ability, onlineRewardData[reward.rewardType][reward.rewardIndex].name, onlineRewardData[reward.rewardType][reward.rewardIndex].image)
          onlineRewardData[reward.rewardType][reward.rewardIndex].new = true
        elseif reward.rewardType == 2 then
          onlineScreenManager.addRewardUnlock(onlineRewardID.weapon, onlineRewardData[reward.rewardType][reward.rewardIndex].name, onlineRewardData[reward.rewardType][reward.rewardIndex].image)
          onlineRewardData[reward.rewardType][reward.rewardIndex].new = true
          onlineRewardData[reward.rewardType][reward.rewardIndex].showTutorialMessage = true
        elseif reward.rewardType == 3 then
          local vehicleStats = false
          onlineRewardData[reward.rewardType][reward.rewardIndex].new = true
          for j, vehicleID in ipairs(onlineRewardData[reward.rewardType][reward.rewardIndex].vehicles) do
            if imageCount < 10 then
              vehicleStats = getVehicleStats(vehicleID)
              onlineScreenManager.addRewardUnlock(onlineRewardID.vehicle, vehicleStats.ModelName, vehicleStats.ManufacturerName, vehicleID)
              Menu.LoadMPVehicleImage(vehicleID)
              imageCount = imageCount + 1
            end
          end
        elseif reward.rewardType == 4 then
          onlineScreenManager.addRewardUnlock(onlineRewardID.icon, onlineRewardData[reward.rewardType][reward.rewardIndex].name, onlineRewardData[reward.rewardType][reward.rewardIndex].image)
          onlineRewardData[reward.rewardType][reward.rewardIndex].new = true
        elseif reward.rewardType == 5 then
          onlineScreenManager.addRewardUnlock(onlineRewardID.ability, onlineRewardData[reward.rewardType][reward.rewardIndex].name, onlineRewardData[reward.rewardType][reward.rewardIndex].image)
          onlineRewardData[reward.rewardType][reward.rewardIndex].new = true
        elseif reward.rewardType == 6 then
          onlineScreenManager.addRewardUnlock(onlineRewardID.playlist, onlineRewardData[reward.rewardType][reward.rewardIndex].name, onlineRewardData[reward.rewardType][reward.rewardIndex].image)
          onlineRewardData[reward.rewardType][reward.rewardIndex].new = true
        end
        if reward.rewardType ~= 3 then
          if ONLINE_PROG_DEBUG then
            print("<<<<<<<<<<<<<<<<<<<<<<<< Online Progression System setPlayerLevel load reward unlock image : image name - " .. tostring(onlineRewardData[reward.rewardType][reward.rewardIndex].image))
          end
          Menu.LoadMPUnlockImage(onlineRewardData[reward.rewardType][reward.rewardIndex].image)
          imageCount = imageCount + 1
        end
      end
    end
  end
  playerLevel = level
end
function resetPlayerProgression(resetServer)
  if ONLINE_PROG_DEBUG then
    print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: resetPlayerProgression")
  end
  playerXP = 0
  playerLevel = 0
  playerTotalXP = 0
  scoreSystem.emptyAbility()
  enableAbilities(localPlayer.localID, false)
  faceOffMatchBonus = 0
  faceOffPercentScore = false
  timeInFaceOff = false
  for i, ability in ripairs(onlineAbilityData) do
    if ability.unlocked then
      ability.resetFunc()
      onlineAbilityData[i].unlocked = false
    end
  end
  for i, upgrade in ripairs(onlineUpgradeData) do
    if upgrade.unlocked then
      upgrade.resetFunc()
      onlineUpgradeData[i].unlocked = false
    end
  end
  for i, weapon in ripairs(onlineWeaponData) do
    if weapon.unlocked then
      weapon.resetFunc()
      onlineWeaponData[i].unlocked = false
    end
  end
  for i, iconData in ipairs(onlineIconData) do
    onlineIconData[i].unlocked = false
  end
  for i, vehicleData in ipairs(onlineVehicleData) do
    onlineVehicleData[i].unlocked = false
  end
  for i, playListData in ipairs(onlinePlaylistUnlockData) do
    onlinePlaylistUnlockData[i].unlocked = false
  end
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_willpower_level_number", 0)
  onlineScreenManager.updatePlayerXP(localPlayer.playerID, playerTotalXP)
  zapWeaponSupport.setZapWeaponCooldownDefault()
  zap.multiplayerSettings.setOnlineZapFuelLevel(1)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMultiplayer_WeaponsAvailable", 0)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMultiplayer_VehiclesAvailable", 0)
  if resetServer then
    PlayerCoreStats.updateLocalTutorialFlag(1, false)
    PlayerCoreStats.updateLocalTutorialFlag(2, false)
    PlayerCoreStats.updateLocalTutorialFlag(3, false)
    PlayerCoreStats.updateLocalTutorialFlag(4, false)
    PlayerCoreStats.updateLocalTutorialFlag(5, false)
    PlayerCoreStats.updateLocalTotalXP(0)
    Statistics.dispatchWrite()
  end
end
function setPlayerProgressionMax()
  local maxLevel = #onlineLevelData
  local maxLevelXP = onlineLevelData[maxLevel].xp
  if maxLevel <= playerLevel then
    return
  end
  setPlayerLevel(maxLevel)
  playerTotalXP = maxLevelXP
  PlayerCoreStats.updateLocalTotalXP(0)
  Statistics.dispatchWrite()
end
function progressToNextLevel()
  local maxLevel = #onlineLevelData
  if maxLevel <= playerLevel then
    return
  end
  local nextLevel = playerLevel + 1
  local nextLevelXP = onlineLevelData[playerLevel + 1].xp
  setPlayerLevel(nextLevel)
  playerTotalXP = nextLevelXP
  PlayerCoreStats.updateLocalTotalXP(playerTotalXP)
  if not Statistics.isBusy() then
    Statistics.dispatchWrite()
  end
end
function toggleOnlineProgressionDebugInfo()
  showProgressionDebugText = not showProgressionDebugText
end
function addXPtoPlayerTotal(xp)
  playerXP = playerXP + xp
end
function onlineGetNumberOfPlaylistUnlocks()
  return #onlinePlaylistUnlockData
end
_G.onlineGetNumberOfPlaylistUnlocks = onlineGetNumberOfPlaylistUnlocks
function onlineGetPlaylistUnlockName(index)
  if onlinePlaylistUnlockData[index] then
    return onlinePlaylistUnlockData[index].name
  end
  return "INVALID PLAYLIST UNLOCK INDEX - GET NAME"
end
_G.onlineGetPlaylistUnlockName = onlineGetPlaylistUnlockName
function onlineIsPlaylistUnlocked(index)
  if onlinePlaylistUnlockData[index] then
    return onlinePlaylistUnlockData[index].unlocked
  end
  print("PLAYLIST UNLOCK INDEX " .. tostring(index) .. " IS NOT VALID")
  return false
end
_G.onlineIsPlaylistUnlocked = onlineIsPlaylistUnlocked
function onlineIsPlaylistNewlyUnlocked(index)
  if onlinePlaylistUnlockData[index] then
    return onlinePlaylistUnlockData[index].new
  end
  print("onlineIsPlaylistNewlyUnlocked() PLAYLIST " .. tostring(index) .. " IS NOT VALID")
  return false
end
_G.onlineIsPlaylistNewlyUnlocked = onlineIsPlaylistNewlyUnlocked
function onlineIsAnyPlaylistNewlyUnlocked()
  for i, pack in ipairs(onlinePlaylistUnlockData) do
    if onlineIsPlaylistNewlyUnlocked(i) == true then
      return true
    end
  end
  return false
end
_G.onlineIsAnyPlaylistNewlyUnlocked = onlineIsAnyPlaylistNewlyUnlocked
function onlinePlaylistClearNew(index)
  if onlinePlaylistUnlockData[index] then
    onlinePlaylistUnlockData[index].new = false
    return true
  end
  print("onlinePlaylistClearNew() PLAYLIST " .. tostring(index) .. " IS NOT VALID")
  return false
end
_G.onlinePlaylistClearNew = onlinePlaylistClearNew
function getPlayerTutorialFlag(index)
  return PlayerCoreStats.getTutorialFlag(index)
end
_G.getPlayerTutorialFlag = getPlayerTutorialFlag
function setOnlinePrivateMatchOptions(enableBalancedAbilities, allowSwap, allowSpawn, allowImpulse, allowTeamVoiceChat, faceoffsEnabled)
  if phaseManager.isLocal then
    phaseManager.playlistSupport.networkVars.enableBalancedAbilities = enableBalancedAbilities
    phaseManager.playlistSupport.networkVars.allowSwap = allowSwap
    phaseManager.playlistSupport.networkVars.allowSpawn = allowSpawn
    phaseManager.playlistSupport.networkVars.allowImpulse = allowImpulse
    phaseManager.playlistSupport.networkVars.allowTeamVoiceChat = allowTeamVoiceChat or false
    if faceoffsEnabled ~= nil then
      phaseManager.playlistSupport.networkVars.faceOffsEnabled = faceoffsEnabled
    elseif devTurnOffFaceOffs then
      phaseManager.playlistSupport.networkVars.faceOffsEnabled = false
    end
  end
  if ONLINE_PROG_DEBUG then
    print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: Balanced abilities are " .. (enableBalancedAbilities and "disabled"))
    print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: Swap is " .. (allowSwap and "disallowed"))
    print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: Spawn is " .. (allowSpawn and "disallowed"))
    print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: Impulse is " .. (allowImpulse and "disallowed"))
    print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: Team Voice Chat is " .. (allowTeamVoiceChat and "disallowed"))
    print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: Face Offs are " .. (faceoffsEnabled and "disallowed"))
  end
  if enableBalancedAbilities then
    local upgradeIndex = 0
    local abilityIndex = 0
    for i, progData in ipairs(onlineLevelData) do
      if i <= abilityBalancelevelCap then
        for j, rewardData in ipairs(progData.rewards) do
          if rewardData.rewardType == 5 and upgradeIndex < rewardData.rewardIndex then
            upgradeIndex = rewardData.rewardIndex
          elseif rewardData.rewardType == 1 and abilityIndex < rewardData.rewardIndex then
            abilityIndex = rewardData.rewardIndex
          end
        end
      else
        break
      end
    end
    if ONLINE_PROG_DEBUG then
      print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: Balancing abilities")
      print(">>>>>>>>>>>>> Online Progression System: abilityBalancelevelCap = " .. tostring(abilityBalancelevelCap))
      print(">>>>>>>>>>>>> Online Progression System: upgradeIndex = " .. tostring(upgradeIndex))
      print(">>>>>>>>>>>>> Online Progression System: abilityIndex = " .. tostring(abilityIndex))
    end
    for i = 1, upgradeIndex do
      if not onlineUpgradeData[i].unlocked and onlineUpgradeData[i].balancing then
        onlineUpgradeData[i].unlockFunc()
        onlineUpgradeData[i].unlocked = true
        if ONLINE_PROG_DEBUG then
          print(">>>>>>>>>>>>> Online Progression System: unlocking upgrade = " .. tostring(i))
        end
      end
    end
    for i = #onlineUpgradeData, upgradeIndex + 1, -1 do
      if onlineUpgradeData[i].unlocked and onlineUpgradeData[i].balancing then
        onlineUpgradeData[i].resetFunc()
        onlineUpgradeData[i].unlocked = false
        if ONLINE_PROG_DEBUG then
          print(">>>>>>>>>>>>> Online Progression System: locking upgrade = " .. tostring(i))
        end
      end
    end
    for i = 1, abilityIndex do
      if not onlineAbilityData[i].unlocked and onlineAbilityData[i].balancing then
        onlineAbilityData[i].unlockFunc()
        onlineAbilityData[i].unlocked = true
        if ONLINE_PROG_DEBUG then
          print(">>>>>>>>>>>>> Online Progression System: unlocking ability = " .. tostring(i))
        end
      end
    end
    for i = #onlineAbilityData, abilityIndex + 1, -1 do
      if onlineAbilityData[i].unlocked and onlineAbilityData[i].balancing then
        onlineAbilityData[i].resetFunc()
        onlineAbilityData[i].unlocked = false
        if ONLINE_PROG_DEBUG then
          print(">>>>>>>>>>>>> Online Progression System: locking ability = " .. tostring(i))
        end
      end
    end
    if ONLINE_PROG_DEBUG then
      print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: End Balancing abilities")
    end
  end
  if not allowSwap then
    localPlayer:blockAbility("ZapSwap", true)
    if ONLINE_PROG_DEBUG then
      print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: block swap")
    end
  end
  if not allowSpawn then
    localPlayer:blockAbility("ZapSpawn", true)
    if ONLINE_PROG_DEBUG then
      print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: block spawn")
    end
  end
  if not allowImpulse then
    localPlayer:blockAbility("ZapImpulse", true)
    if ONLINE_PROG_DEBUG then
      print(">>>>>>>>>>>>>>>>>>>>>>>> Online Progression System: block impulse")
    end
  end
end
_G.setOnlinePrivateMatchOptions = setOnlinePrivateMatchOptions
