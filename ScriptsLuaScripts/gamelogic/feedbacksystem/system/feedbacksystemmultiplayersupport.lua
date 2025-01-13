module("feedbackSystem.multiplayerSupport", package.seeall)
enabled = false
function playerJoined(player)
  if enabled and gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode then
    feedbackSystem.eventMessages.addMessage(3, player.name, "ID:216800", "", player.playerID, false)
  end
  feedbackSystem.faceOffSupport.addPlayer(player)
end
function playerLeft(player)
  if enabled and gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode then
    feedbackSystem.eventMessages.addMessage(3, player.name, "ID:216801", "", player.playerID, false)
  end
  feedbackSystem.faceOffSupport.removePlayer(player)
end
local playerVehicles = {
  [1] = {SNVID = false},
  [2] = {SNVID = false},
  [3] = {SNVID = false},
  [4] = {SNVID = false},
  [5] = {SNVID = false},
  [6] = {SNVID = false},
  [7] = {SNVID = false},
  [8] = {SNVID = false}
}
function stepNeutralPlayerColours()
  for playerID, data in next, playerVehicles, nil do
    if data.SNVID and not vehicleManager.vehiclesBySNVID[data.SNVID] then
      playerVehicles[playerID].SNVID = false
    end
  end
  for playerID, player in next, playerManager.players, nil do
    if not player.colourSet then
      Menu.SetPlayerColour(player.playerID, OnlineModeSettings.blue128)
      player.colourSet = true
    end
    if player.currentVehicle and playerID ~= localPlayer.playerID and playerVehicles[playerID + 1].SNVID ~= player.currentVehicle.SNVID then
      playerVehicles[playerID + 1].SNVID = player.currentVehicle.SNVID
      player.currentVehicle:setDisplayColour(OnlineModeSettings.blue32, OnlineModeSettings.blue128)
    end
  end
end
function resetNeutralPlayerColours()
  playerVehicles = {
    [1] = {SNVID = false},
    [2] = {SNVID = false},
    [3] = {SNVID = false},
    [4] = {SNVID = false},
    [5] = {SNVID = false},
    [6] = {SNVID = false},
    [7] = {SNVID = false},
    [8] = {SNVID = false}
  }
  for playerID, player in next, playerManager.players, nil do
    player.colourSet = nil
  end
end
local playerVehicleHightlightColours = {
  [1] = {
    SNVID = false,
    colour32 = false,
    colour128 = false
  },
  [2] = {
    SNVID = false,
    colour32 = false,
    colour128 = false
  },
  [3] = {
    SNVID = false,
    colour32 = false,
    colour128 = false
  },
  [4] = {
    SNVID = false,
    colour32 = false,
    colour128 = false
  },
  [5] = {
    SNVID = false,
    colour32 = false,
    colour128 = false
  },
  [6] = {
    SNVID = false,
    colour32 = false,
    colour128 = false
  },
  [7] = {
    SNVID = false,
    colour32 = false,
    colour128 = false
  },
  [8] = {
    SNVID = false,
    colour32 = false,
    colour128 = false
  }
}
local worldMarkers = {}
function stepPostGameFeedback()
  for playerID, data in next, playerVehicleHightlightColours, nil do
    if data.SNVID and not vehicleManager.vehiclesBySNVID[data.SNVID] then
      playerVehicleHightlightColours[playerID].SNVID = false
    end
  end
  for playerID, player in next, playerManager.players, nil do
    if not player.colourSet and playerVehicleHightlightColours[playerID + 1].colour128 then
      Menu.SetPlayerColour(player.playerID, playerVehicleHightlightColours[playerID + 1].colour128)
      player.colourSet = true
    end
    if player.currentVehicle and playerVehicleHightlightColours[playerID + 1].colour32 and playerVehicleHightlightColours[playerID + 1].SNVID ~= player.currentVehicle.SNVID then
      playerVehicleHightlightColours[playerID + 1].SNVID = player.currentVehicle.SNVID
      player.currentVehicle:setDisplayColour(playerVehicleHightlightColours[playerID + 1].colour32, playerVehicleHightlightColours[playerID + 1].colour128)
    end
  end
end
function setPlayerHighlight(id, colour32, colour128)
  playerVehicleHightlightColours[id].colour32 = colour32
  playerVehicleHightlightColours[id].colour128 = colour128
end
function addWorldMarker(type, data)
  table.insert(worldMarkers, {type = type, data = data})
end
function clearPostGameFeedback()
  for i, marker in ipairs(worldMarkers) do
    if marker.type == "shieldZone" then
      ZAPSHIELDZONE.delete()
      if challengeSystem.instances[phaseManager.networkVars.modeID] then
        challengeSystem.instances[phaseManager.networkVars.modeID].dangerZone = false
      end
    elseif marker.type == "terrain" then
      TerrainMarker.Delete(marker.data)
    elseif marker.type == "world" then
      Marker:delete(marker.data)
    elseif marker.type == "lightTrail" then
      if vehicleManager.vehiclesBySNVID[marker.data.SNVID] then
        marker.data:removeLightTrail()
      end
    elseif marker.type == "mood" then
      moodSystem.removeMood(marker.data)
    else
      assert(false, "Marker type not found")
    end
  end
  worldMarkers = {}
  for i = 1, 8 do
    playerVehicleHightlightColours[i].SNVID = false
    playerVehicleHightlightColours[i].colour32 = false
    playerVehicleHightlightColours[i].colour128 = false
  end
end
local behindVehicleFeedbackOn = false
local behindVehicleIconOn = false
local bvFeedbackDisplayTime = 0
local lastBVFeedbackupUpdate = 0
local startDiffScore = 0
local prevPlayerScore = 0
function updateBehindVehicleFeedback(playerScore, feedbackDisplayTime, displayIcon, scoreFlashThreshold, eventFlashThreshold)
  bvFeedbackDisplayTime = feedbackDisplayTime or 0
  if prevPlayerScore ~= playerScore then
    if not behindVehicleFeedbackOn then
      if bvFeedbackDisplayTime > 0 then
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 2)
      else
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 1)
      end
      if displayIcon then
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 1)
        behindVehicleIconOn = true
      end
      startDiffScore = prevPlayerScore
      behindVehicleFeedbackOn = true
    elseif eventFlashThreshold and eventFlashThreshold < playerScore - prevPlayerScore then
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring", 2)
    elseif scoreFlashThreshold and scoreFlashThreshold < playerScore then
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring", 2)
    end
    OneShotSound.Play("MP_ScoreFlash_Single", false)
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_pulse", 1)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_scoring_text_number", "+" .. tostring(playerScore - startDiffScore))
    prevPlayerScore = playerScore
    lastBVFeedbackupUpdate = g_NetworkTime
  end
  if behindVehicleFeedbackOn and g_NetworkTime - lastBVFeedbackupUpdate > bvFeedbackDisplayTime then
    if bvFeedbackDisplayTime > 0 then
      feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 0)
      if behindVehicleIconOn then
        feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 0)
        behindVehicleIconOn = false
      end
    end
    behindVehicleFeedbackOn = false
    startDiffScore = playerScore
  end
end
function hideBehindVehicleFeedback()
  if behindVehicleIconOn then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Icon_Display", 0)
    behindVehicleIconOn = false
  end
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Scoring_Text_Display", 0)
  behindVehicleFeedbackOn = false
  prevPlayerScore = 0
end
function disableZapReticle()
  if gameStatus.splitscreenSession then
    zapcontroller.setRenderTarget(false, 0)
    zapcontroller.setRenderTarget(false, 1)
  else
    zapcontroller.setRenderTarget(false, 0)
  end
end
function enableZapReticle()
  if gameStatus.splitscreenSession then
    zapcontroller.setRenderTarget(true, 0)
    zapcontroller.setRenderTarget(true, 1)
  else
    zapcontroller.setRenderTarget(true, 0)
  end
end
local ssAbilityBarState = {
  [0] = {shown = false},
  [1] = {shown = false}
}
function resetAbilityBarState()
  ssAbilityBarState[0].shown = false
  ssAbilityBarState[1].shown = false
end
function enableSSAbilityBar(localID)
  if localID == 0 and not ssAbilityBarState[0].shown then
    ssAbilityBarState[0].shown = true
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_ability_display", 1)
  elseif localID == 1 and not ssAbilityBarState[1].shown then
    ssAbilityBarState[1].shown = true
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_ability_display", 1)
  end
end
function disableSSAbilityBar(localID)
  if localID == 0 and ssAbilityBarState[0].shown then
    ssAbilityBarState[0].shown = false
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_ability_display", 0)
  elseif localID == 1 and ssAbilityBarState[1].shown then
    ssAbilityBarState[1].shown = false
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_ability_display", 0)
  end
end
local ssSpeedoState = {
  [0] = {shown = false},
  [1] = {shown = false}
}
function resetSpeedoState()
  ssSpeedoState[0].shown = false
  ssSpeedoState[1].shown = false
end
function enableSSSpeedo(localID)
  if localID == 0 and not ssSpeedoState[0].shown then
    ssSpeedoState[0].shown = true
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_speedo_display", 1)
  elseif localID == 1 and not ssSpeedoState[1].shown then
    ssSpeedoState[1].shown = true
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_speedo_display", 1)
  end
end
function disableSSSpeedo(localID)
  if localID == 0 and ssSpeedoState[0].shown then
    ssSpeedoState[0].shown = false
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_speedo_display", 0)
  elseif localID == 1 and ssSpeedoState[1].shown then
    ssSpeedoState[1].shown = false
    feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_speedo_display", 0)
  end
end
local barFillers = {}
barFillers[1] = {
  lastFillTime = 0,
  currentFill = 0,
  fillAddAmount = 0,
  barFillDelay = 0.02,
  targetFill = 0,
  fillStartFunc = false,
  fillCompFunc = false,
  fillOnUpdateFunc = false,
  fillTargetTime = 0,
  mmResourceName = false,
  fillComplete = true,
  progBarStartTime = false,
  progBarStartDelay = 0,
  progressBars = {},
  progBarSet = false
}
barFillers[2] = {
  lastFillTime = 0,
  currentFill = 0,
  fillAddAmount = 0,
  barFillDelay = 0.02,
  targetFill = 0,
  fillStartFunc = false,
  fillCompFunc = false,
  fillOnUpdateFunc = false,
  fillTargetTime = 0,
  mmResourceName = false,
  fillComplete = true,
  progBarStartTime = false,
  progBarStartDelay = 0,
  progressBars = {},
  progBarSet = false
}
local function fillBar(index)
  if not barFillers[index].fillComplete then
    if g_NetworkTime - barFillers[index].lastFillTime > barFillers[index].barFillDelay then
      if barFillers[index].currentFill + barFillers[index].fillAddAmount > barFillers[index].targetFill then
        if barFillers[index].fillCompFunc then
          barFillers[index].fillCompFunc()
          barFillers[index].fillCompFunc = false
        end
        barFillers[index].currentFill = barFillers[index].targetFill
        barFillers[index].lastFillTime = 0
        barFillers[index].fillComplete = true
        barFillers[index].progBarSet = false
      else
        if barFillers[index].fillStartFunc then
          barFillers[index].fillStartFunc()
          barFillers[index].fillStartFunc = false
        end
        barFillers[index].currentFill = barFillers[index].currentFill + barFillers[index].fillAddAmount
        if barFillers[index].lastFillTime > 0 then
          local diff = g_NetworkTime - barFillers[index].lastFillTime - barFillers[index].barFillDelay
          local add = barFillers[index].targetFill / barFillers[index].fillTargetTime * diff
          barFillers[index].currentFill = barFillers[index].currentFill + add
        end
        if barFillers[index].currentFill > barFillers[index].targetFill then
          barFillers[index].currentFill = barFillers[index].targetFill
        end
        barFillers[index].lastFillTime = g_NetworkTime
      end
    end
    if barFillers[index].fillOnUpdateFunc then
      barFillers[index].fillOnUpdateFunc(barFillers[index].currentFill)
    end
    if gameStatus.splitscreenSession then
      feedbackSystem.menusMaster.splitscreenMenusSetVariable(barFillers[index].mmResourceName, barFillers[index].currentFill)
    else
      feedbackSystem.menusMaster.onlineHUDSetVariable(barFillers[index].mmResourceName, barFillers[index].currentFill)
    end
  end
end
function addBarFill(filler, startDelay, mmResource, targetQty, targetTime, startFunc, compFunc, updateFunc)
  table.insert(barFillers[filler].progressBars, {
    delay = startDelay,
    resourceName = mmResource,
    targetFillTime = targetTime,
    targetFill = targetQty,
    fillAddAmount = targetQty / targetTime * barFillers[filler].barFillDelay,
    startCallback = startFunc or false,
    endCallback = compFunc or false,
    updateCallback = updateFunc or false
  })
end
function updateBarFiller()
  for i = 1, 2 do
    if #barFillers[i].progressBars > 0 and not barFillers[i].progBarSet then
      barFillers[i].progBarStartTime = g_NetworkTime
      barFillers[i].lastFillTime = 0
      barFillers[i].currentFill = 0
      barFillers[i].fillAddAmount = barFillers[i].progressBars[1].fillAddAmount
      barFillers[i].targetFill = barFillers[i].progressBars[1].targetFill
      barFillers[i].fillStartFunc = barFillers[i].progressBars[1].startCallback
      barFillers[i].fillCompFunc = barFillers[i].progressBars[1].endCallback
      barFillers[i].fillOnUpdateFunc = barFillers[i].progressBars[1].updateCallback
      barFillers[i].fillTargetTime = barFillers[i].progressBars[1].targetFillTime
      barFillers[i].mmResourceName = barFillers[i].progressBars[1].resourceName
      barFillers[i].fillComplete = false
      barFillers[i].progBarStartDelay = barFillers[i].progressBars[1].delay
      table.remove(barFillers[i].progressBars, 1)
      barFillers[i].progBarSet = true
    elseif barFillers[i].progBarSet and g_NetworkTime - barFillers[i].progBarStartTime > barFillers[i].progBarStartDelay then
      fillBar(i)
    end
  end
end
function purgeProgBarFiller()
  barFillers[1] = {
    lastFillTime = 0,
    currentFill = 0,
    fillAddAmount = 0,
    barFillDelay = 0.02,
    targetFill = 0,
    fillStartFunc = false,
    fillCompFunc = false,
    fillOnUpdateFunc = false,
    fillTargetTime = 0,
    mmResourceName = false,
    fillComplete = true,
    progBarStartTime = false,
    progBarStartDelay = 0,
    progressBars = {},
    progBarSet = false
  }
  barFillers[2] = {
    lastFillTime = 0,
    currentFill = 0,
    fillAddAmount = 0,
    barFillDelay = 0.02,
    targetFill = 0,
    fillStartFunc = false,
    fillCompFunc = false,
    fillOnUpdateFunc = false,
    fillTargetTime = 0,
    mmResourceName = false,
    fillComplete = true,
    progBarStartTime = false,
    progBarStartDelay = 0,
    progressBars = {},
    progBarSet = false
  }
end
