module("feedbackSystem.faceOffSupport", package.seeall)
watchedInstance = false
playerList = {}
local sideBarStyleID = "FO"
local sidePanelActive = false
local scoreBoardActive = false
local lastPlayerCount = 0
local hasSoundPlayed = false
local behindVehicleFeedbackOn = false
local bvBetweenFeedbackDelay = 0
local lastBVFeedbackupUpdate = 0
local lastBVFeedbackDisplay = 0
local prevPlayerScore = 0
local startDiffScore = 0
local bvFeedbackDisplayTime = 2
local bvFeedbackMultiplier = 1
local bvStartSpeed = 0
local sortScores = function(playerA, playerB)
  local playerAScore = watchedInstance:getScore(playerA)
  local playerBScore = watchedInstance:getScore(playerB)
  if playerAScore == playerBScore then
    if playerA.isLocal then
      return true
    elseif playerB.isLocal then
      return false
    end
    return playerA.playerID < playerB.playerID
  else
    return playerAScore > playerBScore
  end
end
onlineSideBar.registerSideBar("FaceOff", function(instance)
  local initiate = function()
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Qualifying_Title_Show", 1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_game_title", "ID:220727")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_qualifying_short_description", onlineScreenManager.onlineScreenData[watchedInstance.faceOff.settings.title].description1)
  end
  local playerScore = 0
  local function getData(player)
    playerScore = watchedInstance and 0
    playerScore = watchedInstance and 0
    return player.name, playerScore, playerScore, player == localPlayer, false, player.playerID, true
  end
  local sideBarCleanup = function()
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Qualifying_Title_Show", 0)
    onlineSideBar.toggleSidebarTimerFlash(0)
  end
  return initiate, getData, sideBarCleanup, onlineSideBar.standardSortFuncs.playerScoreSort, false, faceOffSystem.allowSidebarToggle == 0, true, false, true
end)
local function updateBehindVehicleFeedback()
  local playerScore = watchedInstance:getScore(localPlayer)
  if g_NetworkTime - lastBVFeedbackDisplay > bvBetweenFeedbackDelay and prevPlayerScore ~= playerScore then
    if not behindVehicleFeedbackOn then
      if bvFeedbackDisplayTime > 0 then
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 2)
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring", 2)
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 1)
      else
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 1)
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring", 2)
      end
      startDiffScore = prevPlayerScore
      behindVehicleFeedbackOn = true
    end
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_scoring_text_number", "+" .. tostring((playerScore - startDiffScore) * bvFeedbackMultiplier))
    prevPlayerScore = playerScore
    lastBVFeedbackupUpdate = g_NetworkTime
  end
  if behindVehicleFeedbackOn and g_NetworkTime - lastBVFeedbackupUpdate > bvFeedbackDisplayTime then
    if bvFeedbackDisplayTime > 0 then
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 0)
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 0)
    end
    behindVehicleFeedbackOn = false
    lastBVFeedbackDisplay = g_NetworkTime
    startDiffScore = playerScore
  end
end
local prevSeconds = 0
local lowTimeMessage = true
local lowTimeFlash = true
local function updateSidePanel()
  if watchedInstance then
    local timeBar = phaseManager.faceOffPhaseLength() - watchedInstance:getTime()
    local currSeconds = math.mod(timeBar, 60)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_minutes", string.format("%02d", timeBar / 60))
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_seconds", "." .. string.format("%02d", currSeconds))
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_milliseconds", "." .. string.sub(math.mod(timeBar, 1), 3, 4))
    if timeBar > 17 and not lowTimeMessage then
      lowTimeMessage = true
    end
    if timeBar > 15 and not lowTimeFlash then
      lowTimeFlash = true
    end
    if timeBar < 15 and lowTimeFlash then
      lowTimeFlash = false
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Title_Flash_Timer", 1)
    end
    if timeBar < 17 and timeBar > 14 and lowTimeMessage then
      lowTimeMessage = false
      feedbackSystem.menusMaster.primaryTextPrompt("ID:169362", false, false, false, false, false, false, false, false, true)
    end
    if timeBar / 60 < 1 then
      local ceilCurrSeconds = math.ceil(math.mod(timeBar, 60))
      if ceilCurrSeconds ~= prevSeconds then
        if ceilCurrSeconds == 15 then
          OneShotSound.PlayCountdown("HUD_Online_Timer_10Seconds")
        elseif ceilCurrSeconds < 15 and ceilCurrSeconds > 5 then
          OneShotSound.PlayCountdown("HUD_Gen_Timer_02_OneShot")
        elseif ceilCurrSeconds <= 5 and ceilCurrSeconds > 0 then
          OneShotSound.PlayCountdown("HUD_Gen_Timer_03_OneShot")
        elseif ceilCurrSeconds == 0 then
          OneShotSound.Play("HUD_Online_Timer_0Seconds")
        end
        prevSeconds = math.ceil(currSeconds)
      end
    end
    updateBehindVehicleFeedback()
  end
end
function setupFeedback()
  enableSidePanel()
end
function update()
  updateSidePanel()
end
function removeFeedback()
  disableSidePanel()
end
function enableSidePanel()
  if watchedInstance then
    sidePanelActive = true
    onlineSideBar.addEntries(playerList)
    feedbackSystem.menusMaster.primaryTextPrompt(watchedInstance.faceOff.settings.prompt)
    behindVehicleFeedbackOn = false
    bvBetweenFeedbackDelay = watchedInstance.faceOff.settings.betweenFeedbackDelay
    lastBVFeedbackupUpdate = 0
    prevPlayerScore = 0
    startDiffScore = 0
    lastBVFeedbackDisplay = 0
    bvFeedbackDisplayTime = watchedInstance.faceOff.settings.feedbackDisplayTime
    bvFeedbackMultiplier = watchedInstance.faceOff.settings.feedbackMultiplier
    updateSidePanel()
  end
end
function disableSidePanel()
  sidePanelActive = false
  lowTimeMessage = true
  lastPlayerCount = 0
  feedbackSystem.menusMaster.onlineHUDSetVariable("iHighlightPosition", 0)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_minutes", "")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_seconds", "")
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_title_timer_milliseconds", "")
  if behindVehicleFeedbackOn then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 0)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 0)
    behindVehicleFeedbackOn = false
  end
end
function watch(instance)
  watchedInstance = instance
end
function stopWatching(instance)
  if instance == watchedInstance then
    watchedInstance = false
  end
end
function purge()
  if watchedInstance then
    stopWatching(watchedInstance)
  end
  if not gameStatus.splitscreenSession then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Qualifying_Title_Show", 0)
  end
  if behindVehicleFeedbackOn then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 0)
    behindVehicleFeedbackOn = false
  end
  playerList = {}
  sidePanelActive = false
end
function addPlayer(player)
  table.insert(playerList, {
    data = player,
    playerID = player.playerID
  })
  if sidePanelActive then
    onlineSideBar.addEntry(player, player.playerID)
  end
end
function removePlayer(player)
  for i, testPlayer in ipairs(playerList) do
    if player == testPlayer.data then
      table.remove(playerList, i)
      break
    end
  end
  if sidePanelActive then
    onlineSideBar.removeEntry(player, player.playerID)
  end
end
function modeDeleted()
  for localID, player in next, playerList, nil do
    if player.playerTaskObject then
      player.playerTaskObject = nil
    end
  end
end
