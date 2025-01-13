module("feedbackSystem", package.seeall)
local blockHUD = false
local stringFormat = "%02d"
local fullTimeFormat = "%02d:%02d.%02d"
local heartometerFormat = "%03d"
local sub = string.sub
local floor = math.floor
local ceil = math.ceil
local format = string.format
local startTime
local countUpTimer = 0
local timeRemaining = 0
local currentScore = 0
local timerFlash = false
local setStartTime = false
local audioTimeCheck = false
local timerFlashTime = 30
local currentTime = 0
local countDownTime = 0
local pauseTimer = false
local showTimerPrompt = false
local timerPromptSetup = {}
local timerIcon
local promptTime = 0
local countdownPanelSet = false
local speedConversion = mph
local speedConversions = {mph = 2.236936, kph = 3.6}
local prevMins = false
local prevSecs = false
local prevMilli = false
local function initialise()
  timerPromptSetup = {
    icon1 = iconsTable.zoomIn,
    counter = true,
    priority = 3
  }
  timerIcon = iconsTable.clock
  feedbackSystem.updateSpeedLocalisation()
end
addInitObject(initialise)
local felonyCounterActive = false
local updateCopCounter = false
local newSlotAvailable = false
local felonyPanelSlot = 0
local felonyCount = 0
local barFlashActive = false
local settingUpPanels = false
function round_num(x)
  return floor(x + 0.5)
end
local activePanels = {
  [1] = {
    panelType = "Empty",
    currentPosition = 0,
    currentBarValue = 0,
    currentCount = 0,
    currentHeartRate = 0,
    panelHighlighted = false,
    panelFlash = false
  },
  [2] = {
    panelType = "Empty",
    currentPosition = 0,
    currentBarValue = 0,
    currentCount = 0,
    currentHeartRate = 0,
    panelHighlighted = false,
    panelFlash = false
  },
  [3] = {
    panelType = "Empty",
    currentPosition = 0,
    currentBarValue = 0,
    currentCount = 0,
    currentHeartRate = 0,
    panelHighlighted = false,
    panelFlash = false
  }
}
local panelIcons = {
  target = 1,
  smash = 2,
  drift = 3
}
local missionSlots = {
  display = {
    [1] = "iMissionPanel_1_Display",
    [2] = "iMissionPanel_2_Display",
    [3] = "iMissionPanel_3_Display"
  },
  type = {
    [1] = "iMissionPanel_1_Type",
    [2] = "iMissionPanel_2_Type",
    [3] = "iMissionPanel_3_Type"
  },
  title = {
    [1] = "mission_panel_1_bar_title",
    [2] = "mission_panel_2_bar_title",
    [3] = "mission_panel_3_bar_title"
  },
  text = {
    [1] = "mission_panel_1_bar_text",
    [2] = "mission_panel_2_bar_text",
    [3] = "mission_panel_3_bar_text"
  },
  highlight = {
    [1] = "iMissionPanel_1_Selected",
    [2] = "iMissionPanel_2_Selected",
    [3] = "iMissionPanel_3_Selected"
  },
  dangerBar = {
    [1] = "iMissionPanel_1_DangerBar",
    [2] = "iMissionPanel_2_DangerBar",
    [3] = "iMissionPanel_3_DangerBar"
  },
  bar = {
    [1] = "iMissionPanel_1_Bar",
    [2] = "iMissionPanel_2_Bar",
    [3] = "iMissionPanel_3_Bar"
  },
  percentage = {
    [1] = "iMissionPanel_1_Percentage",
    [2] = "iMissionPanel_2_Percentage",
    [3] = "iMissionPanel_3_Percentage"
  },
  barNumber = {
    [1] = "mission_panel_1_bar_number",
    [2] = "mission_panel_2_bar_number",
    [3] = "mission_panel_3_bar_number"
  },
  pointsTotal = {
    [1] = "mission_panel_1_points_total",
    [2] = "mission_panel_2_points_total",
    [3] = "mission_panel_3_points_total"
  },
  pointsIcon = {
    [1] = "mission_panel_1_points_icon",
    [2] = "mission_panel_2_points_icon",
    [3] = "mission_panel_3_points_icon"
  },
  flash = {
    [1] = "iMissionPanel_1_Bar_Flash",
    [2] = "iMissionPanel_2_Bar_Flash",
    [3] = "iMissionPanel_3_Bar_Flash"
  },
  barIcon = {
    [1] = "iMissionPanel_1_PanelIcon",
    [2] = "iMissionPanel_2_PanelIcon",
    [3] = "iMissionPanel_3_PanelIcon"
  }
}
local felonySlots = {
  counter = {
    [1] = "iMissionPanel_1_Cop_Counter",
    [2] = "iMissionPanel_2_Cop_Counter",
    [3] = "iMissionPanel_3_Cop_Counter"
  },
  iconType = {
    [1] = "iMissionPanel_1_CopCounter",
    [2] = "iMissionPanel_2_CopCounter",
    [3] = "iMissionPanel_3_CopCounter"
  }
}
local timerSlots = {
  mins = {
    [1] = "mission_panel_1_timer_mins",
    [2] = "mission_panel_2_timer_mins",
    [3] = "mission_panel_3_timer_mins"
  },
  secs = {
    [1] = "mission_panel_1_timer_secs",
    [2] = "mission_panel_2_timer_secs",
    [3] = "mission_panel_3_timer_secs"
  },
  milli = {
    [1] = "mission_panel_1_timer_milli",
    [2] = "mission_panel_2_timer_milli",
    [3] = "mission_panel_3_timer_milli"
  },
  colon = {
    [1] = "mission_panel_1_timer_colon",
    [2] = "mission_panel_2_timer_colon",
    [3] = "mission_panel_3_timer_colon"
  },
  dot = {
    [1] = "mission_panel_1_timer_dot",
    [2] = "mission_panel_2_timer_dot",
    [3] = "mission_panel_3_timer_dot"
  },
  flash = {
    [1] = "iMissionPanel_1_Timer_Flash",
    [2] = "iMissionPanel_2_Timer_Flash",
    [3] = "iMissionPanel_3_Timer_Flash"
  }
}
local heartometerSlots = {
  heartometer = {
    [1] = "iMissionPanel_1_Heartometer",
    [2] = "iMissionPanel_2_Heartometer",
    [3] = "iMissionPanel_3_Heartometer"
  },
  shake = {
    [1] = "iMissionPanel_1_Heartometer_Shake",
    [2] = "iMissionPanel_2_Heartometer_Shake",
    [3] = "iMissionPanel_3_Heartometer_Shake"
  },
  colour = {
    [1] = "iMissionPanel_1_Heartometer_Colour",
    [2] = "iMissionPanel_2_Heartometer_Colour",
    [3] = "iMissionPanel_3_Heartometer_Colour"
  },
  bpm = {
    [1] = "mission_panel_1_heartometer_bpm_number",
    [2] = "mission_panel_2_heartometer_bpm_number",
    [3] = "mission_panel_3_heartometer_bpm_number"
  },
  flash = {
    [1] = "iMissionPanel_1_Heartometer_BPM_Flash",
    [2] = "iMissionPanel_2_Heartometer_BPM_Flash",
    [3] = "iMissionPanel_3_Heartometer_BPM_Flash"
  }
}
local missionTimes = {
  ["Tutorial dare"] = {10},
  ["Escape the law"] = {
    150,
    90,
    30
  },
  ["Trunked"] = {15},
  ["All clubbed out"] = {30, 15},
  ["In the nick of time"] = {
    90,
    60,
    30
  },
  ["Heat from above"] = {15},
  ["Wrecked evidence"] = {60, 30},
  ["TheSneakout"] = {90, 30},
  ["Felony lure"] = {
    150,
    90,
    30
  },
  ["Collateral Damage"] = {30},
  ["Bad medicine"] = {15},
  ["Deactivating bombs under trucks"] = {150, 90},
  ["TestDrive"] = {30, 15},
  ["Protect the base"] = {
    150,
    90,
    30
  },
  ["Gone in 59 seconds"] = {
    150,
    90,
    30
  },
  ["Kill Tanner"] = {
    150,
    90,
    30
  },
  ["Mass Chase"] = {30},
  ["Bad medicine 2"] = {15},
  ["Breaking news 2"] = {15},
  ["Tanner and Jones 7"] = {15},
  ["ChinatownDrift"] = {
    90,
    60,
    30
  },
  ["Uplaych4"] = {
    150,
    90,
    30
  },
  ["Big break 2"] = {10},
  ["DriveToSurvive2"] = {90},
  ["Survival"] = {60},
  ["Protect1Activity"] = {
    150,
    90,
    30
  },
  ["Protect2Activity"] = {
    150,
    90,
    30
  },
  ["Protect3Activity"] = {
    150,
    90,
    30
  },
  ["Dare10"] = {3},
  ["Dare30"] = {5},
  ["Dare40"] = {10}
}
function clearHUD()
  blockHUD = true
  removeTimer()
  OneShotSound.Play("HUD_Heartometer_STOP")
  OneShotSound.Play("HUD_Bar_LowWarning_Stop")
  for i = 1, 3 do
    activePanels[i].panelType = "Empty"
    activePanels[i].currentPosition = 0
    activePanels[i].currentBarValue = 0
    activePanels[i].currentCount = 0
    activePanels[i].currentHeartRate = 0
    activePanels[i].panelHighlighted = false
    activePanels[i].panelFlash = false
    feedbackSystem.menusMaster.masterSetVariable(missionSlots.barIcon[i], 0)
    feedbackSystem.menusMaster.masterSetVariable(missionSlots.flash[i], 0)
  end
  if localPlayer.inCountdownMode then
    OneShotSound.Play("HUD_Gen_321GO_Stop")
  end
  feedbackSystem.menusMaster.currentHUDSetVariable("iClear_HUD_Panels", 1)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", 9)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_Continue_Prompt", 0)
  localPlayer:setBlockDamageBarUpdate(false)
  localPlayer.minimapSupport.setHighlightedVehicleModelType("exclamationMark")
  feedbackSystem.highlightSlot(0)
  countUpTimer = 0
  blockHUD = false
  settingUpPanels = false
  barFlashActive = false
  currentScore = 0
end
function showHUDPanels(status)
  if not settingUpPanels then
    local showHUDPanels = 0
    if status then
      showHUDPanels = 1
    end
    if status and blockHUD then
      blockHUD = false
    elseif not status and not blockHUD then
      blockHUD = true
    end
    if felonyCounterActive then
      feedbackSystem.menusMaster.masterSetVariable("iMissionPanel_" .. felonyPanelSlot .. "_Display", showHUDPanels)
    end
    for k, v in next, activePanels, nil do
      if v.panelType ~= "Empty" then
        feedbackSystem.menusMaster.masterSetVariable("iMissionPanel_" .. k .. "_Timer_Flash", 0)
        timerFlash = false
        if v.panelType ~= "startTimerCountDown" then
          feedbackSystem.menusMaster.masterSetVariable("iMissionPanel_" .. k .. "_Display", showHUDPanels)
        elseif v.panelType == "startTimerCountDown" and countdownPanelSet then
          feedbackSystem.menusMaster.masterSetVariable("iMissionPanel_" .. k .. "_Display", showHUDPanels)
        end
        if v.panelHighlighted then
          feedbackSystem.menusMaster.masterSetVariable("iMissionPanel_" .. k .. "_Selected", showHUDPanels)
        end
        if v.panelType == "updateDangerBar" then
          if not status and v.panelFlash then
            feedbackSystem.menusMaster.masterSetVariable(missionSlots.flash[k], 0)
            OneShotSound.Play("HUD_Bar_LowWarning_Stop", false)
          elseif status and v.panelFlash then
            feedbackSystem.menusMaster.masterSetVariable(missionSlots.flash[k], 1)
            OneShotSound.Play("HUD_Bar_LowWarning_Play", false)
          end
        end
        if status and v.panelType == "updateHeartMonitor" then
          feedbackSystem.menusMaster.masterSetVariable("iMissionPanel_" .. k .. "_Heartometer", v.currentHeartRate)
          if v.currentHeartRate < 10 then
            OneShotSound.Play("HUD_Heartometer_0" .. v.currentHeartRate .. "_Play")
          else
            OneShotSound.Play("HUD_Heartometer_10_Play")
          end
        end
        if not status and v.panelType == "updateHeartMonitor" then
          OneShotSound.Play("HUD_Heartometer_STOP")
        end
      end
    end
  end
end
function setupSlotType(slot, mode, panelType, blockRemoveTime)
  settingUpPanels = true
  if activePanels[slot].panelType == "startTimerCountDown" and not blockRemoveTime or activePanels[slot].panelType == "startTimerCountUp" then
    removeTimer()
  end
  if activePanels[slot].panelType == "updateHeartMonitor" then
    OneShotSound.Play("HUD_Heartometer_STOP")
  end
  if activePanels[slot].panelFlash then
    OneShotSound.Play("HUD_Bar_LowWarning_Stop")
    activePanels[slot].panelFlash = false
  end
  feedbackSystem.menusMaster.masterSetVariable(missionSlots.flash[slot], 0)
  feedbackSystem.menusMaster.masterSetVariable(missionSlots.display[slot], 0)
  feedbackSystem.menusMaster.masterSetVariable(missionSlots.dangerBar[slot], 0)
  feedbackSystem.menusMaster.masterSetVariable(missionSlots.bar[slot], 0)
  feedbackSystem.menusMaster.masterSetVariable(missionSlots.percentage[slot], 0)
  feedbackSystem.menusMaster.masterSetVariable(missionSlots.display[slot], 0)
  feedbackSystem.menusMaster.masterSetVariable(missionSlots.type[slot], 0)
  activePanels[slot].panelType = panelType
  localPlayer.simulationSupport.doWait(0.1, updateSlotVisibility(slot, mode))
end
function updateSlotVisibility(slot, mode)
  return function()
    updateSlot(slot, mode)
  end
end
function updateSlot(slot, mode, blockUpdateFelony)
  feedbackSystem.menusMaster.masterSetVariable(missionSlots.type[slot], mode)
  if not localPlayer.inCutscene and localPlayer.isHUDActive() and activePanels[slot].panelType ~= "Empty" and (activePanels[slot].panelType ~= "startTimerCountDown" or activePanels[slot].panelType == "startTimerCountDown" and countdownPanelSet) then
    feedbackSystem.menusMaster.masterSetVariable(missionSlots.display[slot], 1)
  end
  if felonyCounterActive and not blockUpdateFelony then
    updateFelonyPanelPosition()
  end
  settingUpPanels = false
  if localPlayer.inCutscene then
    showHUDPanels(false)
  end
  if not localPlayer.inCutscene then
    blockHUD = false
  end
end
function _G.showFelonyCounter(goonFelony)
  newSlotAvailable = false
  for i = 1, 3 do
    if goonFelony then
      feedbackSystem.menusMaster.masterSetVariable(felonySlots.iconType[i], 1)
    else
      feedbackSystem.menusMaster.masterSetVariable(felonySlots.iconType[i], 0)
    end
  end
  if not felonyCounterActive then
    for i, panelInfo in ipairs(activePanels) do
      if panelInfo.panelType == "Empty" then
        feedbackSystem.menusMaster.masterSetVariable(missionSlots.type[i], 13)
        if not localPlayer.inCutscene then
          feedbackSystem.menusMaster.masterSetVariable(missionSlots.display[i], 1)
          feedbackSystem.menusMaster.masterSetTextVariable("no_of_cops", felonyCount)
        end
        felonyPanelSlot = i
        felonyCounterActive = true
        newSlotAvailable = true
        break
      end
    end
    if not updateCopCounter then
      addUserUpdateFunction("copPanelCounterDelay", function()
        updateCopCounter = true
        removeUserUpdateFunction("copPanelCounterDelay")
      end, 1 * updates.stepRate, true)
    end
  end
end
function _G.hideFelonyCounter()
  if felonyCounterActive then
    felonyCounterActive = false
    if userUpdateFunctions.copPanelIntroDelay then
      removeUserUpdateFunction("copPanelIntroDelay")
    end
    if newSlotAvailable then
      feedbackSystem.menusMaster.masterSetVariable(missionSlots.type[felonyPanelSlot], 0)
      feedbackSystem.menusMaster.masterSetVariable(missionSlots.display[felonyPanelSlot], 0)
    end
    feedbackSystem.menusMaster.masterSetTextVariable("no_of_cops", "")
    felonyPanelSlot = 0
    updateCopCounter = false
  end
end
function _G.updateFelonyCounter(copAmount)
  if felonyCounterActive then
    if updateCopCounter and newSlotAvailable and not localPlayer.inCutscene then
      if copAmount < felonyCount then
        feedbackSystem.menusMaster.masterSetVariable(felonySlots.counter[felonyPanelSlot], 1)
      else
        feedbackSystem.menusMaster.masterSetVariable(felonySlots.counter[felonyPanelSlot], 2)
      end
    end
    felonyCount = copAmount
    feedbackSystem.menusMaster.masterSetTextVariable("no_of_cops", felonyCount)
  end
end
function updateFelonyPanelPosition()
  newSlotAvailable = false
  updateCopCounter = false
  feedbackSystem.menusMaster.masterSetTextVariable("no_of_cops", "")
  if felonyCounterActive then
    for i, panelInfo in ipairs(activePanels) do
      if panelInfo.panelType == "Empty" then
        if i < felonyPanelSlot then
          feedbackSystem.menusMaster.masterSetVariable(missionSlots.display[felonyPanelSlot], 0)
        end
        newSlotAvailable = true
        felonyPanelSlot = i
        break
      elseif i == 3 and panelInfo.panelType ~= "Empty" then
        print("NO SPACE TO SHOW COP COUNTER")
        newSlotAvailable = false
        removeUserUpdateFunction("copPanelCounterDelay")
      end
    end
    if newSlotAvailable then
      addUserUpdateFunction("copPanelIntroDelay", function()
        feedbackSystem.menusMaster.masterSetVariable(missionSlots.type[felonyPanelSlot], 13)
        if not localPlayer.inCutscene then
          feedbackSystem.menusMaster.masterSetVariable(missionSlots.display[felonyPanelSlot], 1)
          feedbackSystem.menusMaster.masterSetTextVariable("no_of_cops", felonyCount)
        end
        updateCopCounter = true
        removeUserUpdateFunction("copPanelIntroDelay")
      end, 0.1 * updates.stepRate, true)
    end
  end
end
local function barUpdate(params)
  if params.successAudio then
    taskSuccessAudio()
  end
  if activePanels[params.slot].panelType ~= "updateWillpowerBar" then
    feedbackSystem.menusMaster.masterSetTextVariable(missionSlots.title[params.slot], params.title or "")
  else
    feedbackSystem.menusMaster.masterSetTextVariable(missionSlots.title[params.slot], "")
  end
  if activePanels[params.slot].panelType == "updateHealthBar" then
    feedbackSystem.menusMaster.masterSetTextVariable(missionSlots.text[params.slot], "ID:182930")
  else
    feedbackSystem.menusMaster.masterSetTextVariable(missionSlots.text[params.slot], params.barTitle or "")
  end
  if activePanels[params.slot].panelType == "updateProgressBar" or activePanels[params.slot].panelType == "updateWillpowerBar" then
    if params.percentValue then
      feedbackSystem.menusMaster.masterSetVariable(missionSlots.percentage[params.slot], 1)
    elseif params.numericValue then
      feedbackSystem.menusMaster.masterSetVariable(missionSlots.percentage[params.slot], 2)
      feedbackSystem.menusMaster.masterSetTextVariable(missionSlots.barNumber[params.slot], params.numericValue)
    end
  end
  if params.barIcon and panelIcons[params.barIcon] then
    feedbackSystem.menusMaster.masterSetVariable(missionSlots.barIcon[params.slot], panelIcons[params.barIcon])
  else
    feedbackSystem.menusMaster.masterSetVariable(missionSlots.dangerBar[params.slot], 0)
  end
  if (activePanels[params.slot].panelType == "updateScoreBar" or activePanels[params.slot].panelType == "updateDangerBar") and params.value then
    barValue = params.value
    feedbackSystem.menusMaster.masterSetVariable(missionSlots.dangerBar[params.slot], barValue)
  else
    if (activePanels[params.slot].panelType == "updateWillpowerBar" or activePanels[params.slot].panelType == "updateProgressBar") and params.value then
      barValue = params.value
    elseif params.value then
      barValue = math.ceil(100 - params.value * 100)
    elseif score then
      barValue = params.score
    end
    feedbackSystem.menusMaster.masterSetVariable(missionSlots.bar[params.slot], barValue)
  end
  if barValue then
    if activePanels[params.slot].panelType ~= "updateDangerBar" then
      local audioBarValue = math.ceil(barValue)
      if audioBarValue < activePanels[params.slot].currentBarValue and activePanels[params.slot].currentBarValue ~= 0 then
        OneShotSound.Play("HUD_Bar_Progress_Decrease", false)
      elseif audioBarValue > activePanels[params.slot].currentBarValue then
        OneShotSound.Play("HUD_Bar_Progress_Increase", false)
      end
      activePanels[params.slot].currentBarValue = audioBarValue
    end
    if not activePanels[params.slot].panelFlash and barValue >= 80 and activePanels[params.slot].panelType == "updateDangerBar" then
      feedbackSystem.menusMaster.masterSetVariable(missionSlots.flash[params.slot], 1)
      OneShotSound.Play("HUD_Bar_LowWarning_Play", false)
      activePanels[params.slot].panelFlash = true
    elseif activePanels[params.slot].panelFlash and barValue < 80 and activePanels[params.slot].panelType == "updateDangerBar" then
      feedbackSystem.menusMaster.masterSetVariable(missionSlots.flash[params.slot], 0)
      OneShotSound.Play("HUD_Bar_LowWarning_Stop", false)
      activePanels[params.slot].panelFlash = false
    end
  end
end
function updateHealthBar(params)
  if not blockHUD or not localPlayer.challenge.showingEndScreen then
    if activePanels[params.slot].panelType ~= "updateHealthBar" then
      setupSlotType(params.slot, 6, "updateHealthBar")
    end
    barUpdate(params)
  end
end
function updateWillpowerBar(params)
  if not blockHUD or not localPlayer.challenge.showingEndScreen then
    if activePanels[params.slot].panelType ~= "updateWillpowerBar" then
      setupSlotType(params.slot, 16, "updateWillpowerBar")
    end
    barUpdate(params)
  end
end
function updateDangerBar(params)
  if not blockHUD or not localPlayer.challenge.showingEndScreen then
    if activePanels[params.slot].panelType ~= "updateDangerBar" then
      setupSlotType(params.slot, 8, "updateDangerBar")
    end
    barUpdate(params)
  end
end
function updateProgressBar(params)
  if not blockHUD or not localPlayer.challenge.showingEndScreen then
    if activePanels[params.slot].panelType ~= "updateProgressBar" then
      setupSlotType(params.slot, 12, "updateProgressBar")
    end
    barUpdate(params)
  end
end
local raceSlots = {
  position = {
    [1] = "mission_panel_1_race_position",
    [2] = "mission_panel_2_race_position",
    [3] = "mission_panel_3_race_position"
  },
  tag = {
    [1] = "mission_panel_1_race_position_tag",
    [2] = "mission_panel_2_race_position_tag",
    [3] = "mission_panel_3_race_position_tag"
  },
  flash = {
    [1] = "iMissionPanel_1_Race_Flash",
    [2] = "iMissionPanel_2_Race_Flash",
    [3] = "iMissionPanel_3_Race_Flash"
  }
}
local tags = {
  [1] = "ID:183074",
  [2] = "ID:183076",
  [3] = "ID:183077",
  ["default"] = "ID:183078"
}
function positionUpdate(slot, racePosition)
  if racePosition and not localPlayer.inCutscene then
    if racePosition then
      feedbackSystem.menusMaster.masterSetTextVariable(raceSlots.position[slot], racePosition)
    end
    feedbackSystem.menusMaster.masterSetTextVariable(raceSlots.tag[slot], tags[racePosition] or tags.default)
    if racePosition < activePanels[slot].currentPosition then
      feedbackSystem.menusMaster.masterSetVariable(raceSlots.flash[slot], 1)
      OneShotSound.Play("HUD_Mis_PositionChange_Positive_OneShot")
      activePanels[slot].currentPosition = racePosition
    elseif racePosition > activePanels[slot].currentPosition then
      feedbackSystem.menusMaster.masterSetVariable(raceSlots.flash[slot], 0)
      OneShotSound.Play("HUD_Mis_PositionChange_Negative_OneShot")
      activePanels[slot].currentPosition = racePosition
    end
  else
    feedbackSystem.menusMaster.masterSetTextVariable(raceSlots.position[slot], "")
    feedbackSystem.menusMaster.masterSetTextVariable(raceSlots.tag[slot], "")
  end
end
function updateRacePosition(params)
  if not blockHUD or not localPlayer.challenge.showingEndScreen then
    if activePanels[params.slot].panelType ~= "updateRacePosition" then
      setupSlotType(params.slot, 7, "updateRacePosition")
    end
    feedbackSystem.menusMaster.masterSetTextVariable(missionSlots.title[params.slot], params.title or "ID:235718")
    if params.successAudio then
      taskSuccessAudio()
    end
    if params.racePosition then
      positionUpdate(params.slot, params.racePosition)
    end
  end
end
function updateChallengeBestScore(params)
  if not blockHUD or not localPlayer.challenge.showingEndScreen then
    if activePanels[params.slot].panelType ~= "updateChallengeBestScore" then
      if params.defaultBest then
        setupSlotType(params.slot, 20, "updateChallengeBestScore")
      else
        setupSlotType(params.slot, 19, "updateChallengeBestScore")
      end
    end
    if params.value then
      feedbackSystem.menusMaster.masterSetTextVariable(missionSlots.pointsTotal[params.slot], params.value)
    end
  end
end
function updateChallengeBestTime(params)
  if not blockHUD or not localPlayer.challenge.showingEndScreen then
    if activePanels[params.slot].panelType ~= "updateChallengeBestTime" then
      if params.defaultBest then
        setupSlotType(params.slot, 18, "updateChallengeBestTime")
      else
        setupSlotType(params.slot, 17, "updateChallengeBestTime")
      end
    end
    if params.time then
      local mins, secs, milli = formatTime(params.time)
      feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.mins[params.slot], mins)
      feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.secs[params.slot], secs)
      feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.milli[params.slot], milli)
      feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.colon[params.slot], ":")
      feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.dot[params.slot], ".")
    end
  end
end
local function timerAudio(ceilTime)
  if not audioTimeCheck then
    currentTime = ceilTime
    audioTimeCheck = true
  end
  if audioTimeCheck and (ceilTime == currentTime - 1 or ceilTime == currentTime + 1) then
    audioTimeCheck = false
    if not timerFlash then
      Sound.SetRTPC("HUD_Timer", 20)
      OneShotSound.PlayCountdown("HUD_Gen_Timer_01_OneShot")
    elseif ceilTime > 10 then
      Sound.SetRTPC("HUD_Timer", 20)
      OneShotSound.PlayCountdown("HUD_Gen_Timer_02_OneShot")
    elseif ceilTime >= 1 then
      Sound.SetRTPC("HUD_Timer", ceilTime)
      OneShotSound.PlayCountdown("HUD_Gen_Timer_03_OneShot")
    end
  end
end
promptTimes = {}
local function setPromptTimes(params)
  local taskObject = localPlayer:getTaskObject()
  promptTimes = {}
  if taskObject and missionTimes[taskObject.coreData.instance.challenge.name] then
    for i, times in ipairs(missionTimes[taskObject.coreData.instance.challenge.name]) do
      table.insert(promptTimes, times)
    end
  elseif dareSystem.activeDare then
    if dareSystem.activeDare.timer <= 10 then
      table.insert(promptTimes, missionTimes.Dare10)
    elseif dareSystem.activeDare.timer <= 30 then
      table.insert(promptTimes, missionTimes.Dare30)
    else
      table.insert(promptTimes, missionTimes.Dare40)
    end
  end
  if promptTimes and missionTimes then
    if taskObject and missionTimes[taskObject.coreData.instance.challenge.name] then
      timerFlashTime = missionTimes[taskObject.coreData.instance.challenge.name][#missionTimes[taskObject.coreData.instance.challenge.name]]
    elseif dareSystem.activeDare then
      local dareFlash = missionTimes.Dare40[#missionTimes.Dare40]
      if dareSystem.activeDare.timer <= 10 then
        dareFlash = missionTimes.Dare10[#missionTimes.Dare10]
      elseif dareSystem.activeDare.timer <= 30 then
        dareFlash = missionTimes.Dare30[#missionTimes.Dare30]
      end
      timerFlashTime = dareFlash
    end
  end
end
local function timerUpdate(params)
  if not localPlayer.challenge.showingEndScreen and not localPlayer.inCutscene and not pauseTimer and not blockHUD then
    if not setStartTime then
      startTime = g_NetworkTime
      setStartTime = true
      if params.startTime then
        OneShotSound.PlayCountdown("HUD_Gen_Timer_01_OneShot")
      end
    end
    if params.startTime then
      timeRemaining = countDownTime - (g_NetworkTime - startTime)
    else
      timeRemaining = g_NetworkTime - startTime
    end
    if timeRemaining then
      local mins, secs, milli = formatTime(timeRemaining)
      if not showTimerPrompt and not feedbackSystem.menusMaster.isPrimaryCounterActive() and not feedbackSystem.menusMaster.isSecondaryCounterActive() and params.startTime and not countdownPanelSet then
        countdownPanelSet = true
        setupSlotType(params.slot, 1, "startTimerCountDown", true)
      end
      if showTimerPrompt then
        local promptTime = format(fullTimeFormat, mins, secs, milli)
        timerPromptSetup.prompt = "%S " .. tostring(promptTime)
        if not feedbackSystem.menusMaster.primaryPromptActive and not feedbackSystem.menusMaster.isPrimaryFelonyActive() then
          feedbackSystem.menusMaster.primaryTextPromptParam(timerPromptSetup)
        elseif not feedbackSystem.menusMaster.secondaryPromptActive then
          feedbackSystem.menusMaster.secondaryTextPromptParam(timerPromptSetup)
        end
        showTimerPrompt = false
      elseif feedbackSystem.menusMaster.isPrimaryCounterActive() and not feedbackSystem.menusMaster.isPrimaryFelonyActive() or feedbackSystem.menusMaster.isSecondaryCounterActive() then
        local promptTime = format(fullTimeFormat, mins, secs, milli)
        local prompt = "%S " .. tostring(promptTime)
        if feedbackSystem.menusMaster.isPrimaryCounterActive() and not feedbackSystem.menusMaster.isPrimaryFelonyActive() then
          feedbackSystem.menusMaster.setPrimaryPromptCounterValues(prompt, nil, timerIcon)
        elseif feedbackSystem.menusMaster.isSecondaryCounterActive() then
          feedbackSystem.menusMaster.setSecondaryPromptCounterValues(prompt, nil, timerIcon)
        end
      end
      if params.slot then
        if timeRemaining < 0 then
          feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.mins[params.slot], "00")
          feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.secs[params.slot], "00")
          feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.milli[params.slot], "00")
          feedbackSystem.menusMaster.masterSetVariable(timerSlots.flash[params.slot], 0)
          if activePanels[params.slot].panelType == "startTimerCountDown" then
            OneShotSound.Play("HUD_Online_Timer_0Seconds")
          end
        elseif string.len(mins) <= 2 then
          if prevMins ~= mins then
            feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.mins[params.slot], mins)
            prevMins = mins
          end
          if prevSecs ~= secs then
            feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.secs[params.slot], secs)
            prevSecs = secs
          end
          if prevMilli ~= milli then
            feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.milli[params.slot], milli)
            prevMilli = milli
          end
        end
      end
      if params.startTime or not params.startTime and promptTimes and promptTimes[1] then
        if timerFlashTime >= timeRemaining and not timerFlash then
          feedbackSystem.menusMaster.masterSetVariable(timerSlots.flash[params.slot], 1)
          OneShotSound.PlayCountdown("HUD_Online_Timer_10Seconds")
          timerFlash = true
        elseif timerFlashTime < timeRemaining and timerFlash then
          feedbackSystem.menusMaster.masterSetVariable(timerSlots.flash[params.slot], 0)
          timerFlash = false
        end
      end
      local timeRemainingCeil = ceil(timeRemaining)
      if params.startTime then
        if promptTimes and promptTimes[1] == timeRemainingCeil and not dareSystem.activeDare then
          table.remove(promptTimes, 1)
          if not feedbackSystem.menusMaster.isPrimaryCounterActive() and not feedbackSystem.menusMaster.isPrimaryFelonyActive() and not feedbackSystem.menusMaster.isSecondaryCounterActive() then
            showTimerPrompt = true
          end
        end
        timerAudio(timeRemainingCeil)
      end
    end
  end
  return timeRemaining
end
function stepTimer(params)
  if (not blockHUD or not localPlayer.challenge.showingEndScreen) and (activePanels[params.slot].panelType ~= "startTimerCountUp" and params.startTime == nil and params.timeToBeat == nil or activePanels[params.slot].panelType ~= "startTimerCountDown" and (params.startTime or params.timeToBeat) or activePanels[params.slot].panelType == "startTimerCountDown" and countDownTime ~= params.startTime and not params.updateStartTime and not dareSystem.activeDare and not params.reset) then
    if params.startTime or params.timeToBeat then
      countDownTime = params.startTime
      local mins, secs, milli = formatTime(params.startTime)
      feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.mins[params.slot], mins)
      feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.secs[params.slot], secs)
      activePanels[params.slot].panelType = "startTimerCountDown"
    else
      feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.mins[params.slot], "00")
      feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.secs[params.slot], "00")
      setupSlotType(params.slot, 1, "startTimerCountUp")
    end
    feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.milli[params.slot], "00")
    feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.colon[params.slot], ":")
    feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.dot[params.slot], ".")
    setPromptTimes()
    prevMins = false
    prevSecs = false
    prevMilli = false
    setStartTime = false
    countdownPanelSet = false
    audioTimeCheck = false
    if not dareSystem.activeDare and params.startTime then
      showTimerPrompt = true
    end
  end
  if params.timeToBeat then
    if params.timeToBeat ~= 0 then
      local mins, secs, milli = formatTime(params.timeToBeat)
      feedbackSystem.menusMaster.secondaryTextPrompt("%S " .. tostring(format(fullTimeFormat, mins, secs, milli)), nil, nil, nil, nil, timerIcon)
      feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.mins[params.slot], mins)
      feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.secs[params.slot], secs)
      feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.milli[params.slot], milli)
    else
      feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.mins[params.slot], "--")
      feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.secs[params.slot], "--")
      feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.milli[params.slot], "--")
    end
  end
  if params.updateStartTime then
    countDownTime = params.startTime
  end
  if not userUpdateFunctions.timerUpdate and not params.timeToBeat then
    addUserUpdateFunction("timerUpdate", function()
      timerUpdate(params)
    end, 1)
  end
  if params.pause then
    pauseTimer = true
  elseif not params.pause and pauseTimer then
    countDownTime = getTimer()
    startTime = g_NetworkTime
    pauseTimer = false
  end
  if params.reset then
    prevMins = false
    prevSecs = false
    prevMilli = false
    setStartTime = false
    timerFlash = false
    timerPause = false
    audioTimeCheck = false
    countDownTime = params.startTime
    setPromptTimes()
    feedbackSystem.menusMaster.masterSetVariable(timerSlots.flash[params.slot], 0)
    if not dareSystem.activeDare and params.startTime then
      showTimerPrompt = true
    end
  end
end
function removeTimer()
  if userUpdateFunctions.timerUpdate then
    removeUserUpdateFunction("timerUpdate")
  end
  for i = 1, 3 do
    feedbackSystem.menusMaster.masterSetVariable(timerSlots.flash[i], 0)
    feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.mins[i], "")
    feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.secs[i], "")
    feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.milli[i], "")
    feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.colon[i], "")
    feedbackSystem.menusMaster.masterSetTextVariable(timerSlots.dot[i], "")
  end
  if feedbackSystem.menusMaster.primaryCounterActive then
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
  end
  if feedbackSystem.menusMaster.secondaryCounterActive then
    feedbackSystem.menusMaster.clearSecondaryTextPrompt()
  end
  prevMins = false
  prevSecs = false
  prevMilli = false
  timerFlashTime = 30
  setStartTime = false
  startTime = 0
  timeRemaining = 0
  timerFlash = false
  audioTimeCheck = false
  timerPause = false
  showTimerPrompt = false
  promptTime = 0
end
function initializeTimerSS(params)
  if not params then
    print("no params, ending initializeTimerSS early")
    return
  end
  if not vehicleManager.previewVehicleManager.previewVehicle and not userUpdateFunctions.stepTimerSS and not params.timeToBeat then
    addUserUpdateFunction("stepTimerSS", function()
      stepTimerSS(params)
    end, 2)
  else
    if not vehicleManager.previewVehicleManager.previewVehicle and userUpdateFunctions.stepTimerSS and not params.timeToBeat and params.reset then
      removeTimerSS()
      addUserUpdateFunction("stepTimerSS", function()
        stepTimerSS(params)
      end, 2)
    else
    end
  end
end
function stepTimerSS(params)
  if (not blockHUD or not localPlayer.challenge.showingEndScreen) and not vehicleManager.previewVehicleManager.previewVehicle then
    if params.reset then
      setStartTime = false
      timerFlash = false
      params.reset = false
    end
    if not setStartTime then
      startTime = g_NetworkTime
      setStartTime = true
    end
    local mins = ""
    local secs = ""
    local milli = ""
    if params.startTime then
      if not params.pause then
        timeRemaining = params.startTime - (g_NetworkTime - startTime)
      end
      if timeRemaining < 0.1 then
        feedbackSystem.menusMaster.masterSetTextVariable("ss_timer", "00:00.00")
        feedbackSystem.menusMaster.masterSetTextVariable("ss_timer_minutes", "00")
        feedbackSystem.menusMaster.masterSetTextVariable("ss_timer_seconds", "00")
        feedbackSystem.menusMaster.masterSetTextVariable("ss_timer_splitseconds", "00")
        OneShotSound.Play("HUD_Online_Timer_0Seconds")
      else
        mins, secs, milli = formatTime(timeRemaining)
        feedbackSystem.menusMaster.masterSetTextVariable("ss_timer", format(fullTimeFormat, mins, secs, milli))
        feedbackSystem.menusMaster.masterSetTextVariable("ss_timer_minutes", mins)
        feedbackSystem.menusMaster.masterSetTextVariable("ss_timer_seconds", secs)
        feedbackSystem.menusMaster.masterSetTextVariable("ss_timer_splitseconds", milli)
      end
      return timeRemaining
    else
      countUpTimer = math.ceil(g_NetworkTime - startTime)
      mins, secs, milli = formatTime(countUpTimer)
      feedbackSystem.menusMaster.masterSetTextVariable("ss_timer", format(fullTimeFormat, mins, secs, milli))
      feedbackSystem.menusMaster.masterSetTextVariable("ss_timer_minutes", mins)
      feedbackSystem.menusMaster.masterSetTextVariable("ss_timer_seconds", secs)
      feedbackSystem.menusMaster.masterSetTextVariable("ss_timer_splitseconds", milli)
      return countUpTimer
    end
  end
end
function removeTimerSS()
  if userUpdateFunctions.stepTimerSS then
    removeUserUpdateFunction("stepTimerSS")
  end
end
function getTimer()
  local result = timeRemaining
  if countUpTimer > timeRemaining then
    result = countUpTimer
  end
  result = RandomiseMilliseconds(result)
  return result
end
local function heartmonitorUpdate(slot, value, bpm, flipFeedback)
  if value then
    heartRateValue = math.ceil(value / 10)
  end
  if heartRateValue then
    if activePanels[slot].currentHeartRate ~= heartRateValue then
      feedbackSystem.menusMaster.masterSetVariable(heartometerSlots.heartometer[slot], heartRateValue)
      feedbackSystem.menusMaster.masterSetVariable(heartometerSlots.shake[slot], 1)
      activePanels[slot].currentHeartRate = heartRateValue
      OneShotSound.Play("HUD_Heartometer_STOP")
      if 10 > activePanels[slot].currentHeartRate then
        OneShotSound.Play("HUD_Heartometer_0" .. activePanels[slot].currentHeartRate .. "_Play")
      else
        OneShotSound.Play("HUD_Heartometer_10_Play")
      end
    end
    if activePanels[slot].currentHeartRate <= 3 then
      if flipFeedback then
        heartRateColour = 0
      else
        heartRateColour = 2
      end
    elseif activePanels[slot].currentHeartRate <= 6 then
      heartRateColour = 1
    elseif flipFeedback then
      heartRateColour = 2
    else
      heartRateColour = 0
    end
    feedbackSystem.menusMaster.masterSetVariable(heartometerSlots.colour[slot], heartRateColour)
  end
  if bpm then
    feedbackSystem.menusMaster.masterSetTextVariable(heartometerSlots.bpm[slot], format(heartometerFormat, bpm))
  end
end
function updateHeartMonitor(params)
  if not blockHUD or not localPlayer.challenge.showingEndScreen then
    if activePanels[params.slot].panelType ~= "updateHeartMonitor" then
      setupSlotType(params.slot, 5, "updateHeartMonitor")
    end
    heartmonitorUpdate(params.slot, params.value, params.bpm, params.flipFeedback)
    if params.bpmPositive then
      feedbackSystem.menusMaster.masterSetVariable(heartometerSlots.flash[params.slot], 1)
    elseif params.bpmNegative then
      feedbackSystem.menusMaster.masterSetVariable(heartometerSlots.flash[params.slot], 0)
    end
  end
end
local checklistSlots = {
  panelTitle = {
    [1] = "mission_panel_1_checklist_title",
    [2] = "mission_panel_2_checklist_title",
    [3] = "mission_panel_3_checklist_title"
  },
  iconType = {
    [1] = {
      [1] = "iMissionPanel_1_ChecklistIcon_1_IconType",
      [2] = "iMissionPanel_1_ChecklistIcon_2_IconType",
      [3] = "iMissionPanel_1_ChecklistIcon_3_IconType"
    },
    [2] = {
      [1] = "iMissionPanel_2_ChecklistIcon_1_IconType",
      [2] = "iMissionPanel_2_ChecklistIcon_2_IconType",
      [3] = "iMissionPanel_2_ChecklistIcon_3_IconType"
    },
    [3] = {
      [1] = "iMissionPanel_3_ChecklistIcon_1_IconType",
      [2] = "iMissionPanel_3_ChecklistIcon_2_IconType",
      [3] = "iMissionPanel_3_ChecklistIcon_3_IconType"
    }
  },
  iconMode = {
    [1] = {
      [1] = "iMissionPanel_1_ChecklistIcon_1_Mode",
      [2] = "iMissionPanel_1_ChecklistIcon_2_Mode",
      [3] = "iMissionPanel_1_ChecklistIcon_3_Mode"
    },
    [2] = {
      [1] = "iMissionPanel_2_ChecklistIcon_1_Mode",
      [2] = "iMissionPanel_2_ChecklistIcon_2_Mode",
      [3] = "iMissionPanel_2_ChecklistIcon_3_Mode"
    },
    [3] = {
      [1] = "iMissionPanel_3_ChecklistIcon_1_Mode",
      [2] = "iMissionPanel_3_ChecklistIcon_2_Mode",
      [3] = "iMissionPanel_3_ChecklistIcon_3_Mode"
    }
  }
}
local checklistIcons = {
  jump = 1,
  drift = 2,
  overtake = 3,
  oncoming = 3,
  smash = 4,
  cops = 5,
  speed = 6
}
function updateChecklist(params)
  if not blockHUD or not localPlayer.challenge.showingEndScreen then
    if activePanels[params.slot].panelType ~= "updateChecklist" then
      setupSlotType(params.slot, 4, "updateChecklist")
      feedbackSystem.menusMaster.masterSetTextVariable(checklistSlots.panelTitle[params.slot], "ID:221495")
    end
    if params.reset then
      feedbackSystem.menusMaster.masterSetVariable(checklistSlots.iconMode[params.slot][1], 0)
      feedbackSystem.menusMaster.masterSetVariable(checklistSlots.iconMode[params.slot][2], 0)
      feedbackSystem.menusMaster.masterSetVariable(checklistSlots.iconMode[params.slot][3], 0)
    end
    if params.icon1 then
      feedbackSystem.menusMaster.masterSetVariable(checklistSlots.iconType[params.slot][1], checklistIcons[params.icon1])
    end
    if params.icon2 then
      feedbackSystem.menusMaster.masterSetVariable(checklistSlots.iconType[params.slot][2], checklistIcons[params.icon2])
    end
    if params.icon3 then
      feedbackSystem.menusMaster.masterSetVariable(checklistSlots.iconType[params.slot][3], checklistIcons[params.icon3])
    end
    if params.icon1State then
      feedbackSystem.menusMaster.masterSetVariable(checklistSlots.iconMode[params.slot][1], params.icon1State)
    end
    if params.icon2State then
      feedbackSystem.menusMaster.masterSetVariable(checklistSlots.iconMode[params.slot][2], params.icon2State)
    end
    if params.icon3State then
      feedbackSystem.menusMaster.masterSetVariable(checklistSlots.iconMode[params.slot][3], params.icon3State)
    end
    if params.audio then
      if params.audio == 1 then
        OneShotSound.Play("HUD_Mis_StuntFail_OneShot")
      elseif params.audio == 2 then
        OneShotSound.Play("HUD_Gen_Positive", false)
      end
    end
  end
end
function updateAudioRecorder(params)
  if not blockHUD or not localPlayer.challenge.showingEndScreen then
    if activePanels[params.slot].panelType ~= "updateAudioRecorder" then
      feedbackSystem.menusMaster.masterSetVariable("iMissionPanel_" .. params.slot .. "_recorder", 0)
      feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_" .. params.slot .. "_recorder_rec", "ID:243081")
      setupSlotType(params.slot, 9, "updateAudioRecorder")
    end
    if params.recordingState then
      feedbackSystem.menusMaster.masterSetVariable("iMissionPanel_" .. params.slot .. "_recorder", params.recordingState)
    end
  end
end
function updateFelonyReward(params)
  if not blockHUD or not localPlayer.challenge.showingEndScreen then
    if activePanels[params.slot].panelType ~= "updateFelonyReward" then
      setupSlotType(params.slot, 14, "updateFelonyReward")
    end
    if params.value then
      feedbackSystem.menusMaster.masterSetTextVariable("mission_panel_" .. params.slot .. "_escape_counter", params.value)
    end
  end
end
local parameters = {
  variable = "dare_1_description"
}
function updateScrollingText(params)
  if not blockHUD or not localPlayer.challenge.showingEndScreen then
    if params.slot == 1 then
      if activePanels[params.slot].panelType ~= "updateScrollingText" then
        setupSlotType(params.slot, 15, "updateScrollingText")
      end
      if params.iconType then
        if params.iconType == "control" then
          feedbackSystem.menusMaster.masterSetVariable("iDareDescription_IconType", 1)
        elseif params.iconType == "speed" then
          feedbackSystem.menusMaster.masterSetVariable("iDareDescription_IconType", 2)
        elseif params.iconType == "stunt" then
          feedbackSystem.menusMaster.masterSetVariable("iDareDescription_IconType", 3)
        end
      end
      parameters.text = params.text
      if params.delimits then
        parameters.value1 = params.delimits[1]
        parameters.value2 = params.delimits[2]
        parameters.value3 = params.delimits[3]
      end
      feedbackSystem.menusMaster.masterSetTextVariableParams(parameters)
      parameters.text = nil
      parameters.value1 = nil
      parameters.value2 = nil
      parameters.value3 = nil
    else
      print("SCROLLING TEXT ONLY WORKS IN PANEL SLOT 1")
    end
  end
end
function updateScore(params)
  if not blockHUD or not localPlayer.challenge.showingEndScreen then
    if activePanels[params.slot].panelType ~= "updateScore" then
      activePanels[params.slot].panelType = "updateScore"
      feedbackSystem.menusMaster.masterSetTextVariable(missionSlots.pointsTotal[params.slot], "0")
      setupSlotType(params.slot, 10, "updateScore")
    end
    if params.value then
      currentScore = params.value
      feedbackSystem.menusMaster.masterSetTextVariable(missionSlots.pointsTotal[params.slot], currentScore)
    end
    if params.title and params.icon then
      feedbackSystem.menusMaster.masterSetTextVariable(missionSlots.pointsIcon[params.slot], params.title, nil, params.icon)
    end
    if params.barIcon and panelIcons[params.barIcon] then
      feedbackSystem.menusMaster.masterSetVariable(missionSlots.barIcon[params.slot], panelIcons[params.barIcon])
    else
      feedbackSystem.menusMaster.masterSetVariable(missionSlots.dangerBar[params.slot], 0)
    end
    if params.scoreToBeat then
      if params.scoreToBeat ~= 0 then
        feedbackSystem.menusMaster.masterSetTextVariable(missionSlots.pointsTotal[params.slot], params.scoreToBeat)
      else
        feedbackSystem.menusMaster.masterSetTextVariable(missionSlots.pointsTotal[params.slot], "--")
      end
    end
  end
end
function getScore()
  return currentScore
end
function highlightSlot(slot)
  for currentSlot, panel in ipairs(activePanels) do
    panel.panelHighlighted = slot == currentSlot
    if panel.panelHighlighted and not blockHUD then
      feedbackSystem.menusMaster.masterSetVariable(missionSlots.highlight[currentSlot], 1)
    else
      feedbackSystem.menusMaster.masterSetVariable(missionSlots.highlight[currentSlot], 0)
    end
  end
end
function removeSlot(slot)
  if activePanels[slot].panelType == "startTimerCountDown" or activePanels[slot].panelType == "startTimerCountDown" then
    removeTimer()
  end
  if activePanels[slot].panelType == "updateHeartMonitor" then
    OneShotSound.Play("HUD_Heartometer_STOP")
  end
  if activePanels[slot].currentBarValue ~= 0 and activePanels[slot].panelFlash then
    OneShotSound.Play("HUD_Bar_LowWarning_Stop")
    activePanels[slot].panelFlash = false
  end
  feedbackSystem.menusMaster.masterSetVariable(missionSlots.barIcon[slot], 0)
  feedbackSystem.menusMaster.masterSetVariable(missionSlots.flash[slot], 0)
  feedbackSystem.menusMaster.masterSetVariable(missionSlots.display[slot], 0)
  activePanels[slot].panelType = "Empty"
  activePanels[slot].currentPosition = 0
  activePanels[slot].currentBarValue = 0
  activePanels[slot].currentCount = 0
  activePanels[slot].currentHeartRate = 0
  activePanels[slot].panelHighlighted = false
  activePanels[slot].panelFlash = false
  if felonyCounterActive and slot ~= felonyPanelSlot then
    updateFelonyPanelPosition()
  end
end
local promptColours = {
  positive = vec.vector(0, 0, 180, 255),
  negative = vec.vector(0, 255, 0, 0)
}
local promptScales = {
  [1] = vec.vector(1, 1, 1, 1),
  [2] = vec.vector(1.5, 1.5, 1.5, 1.5),
  [3] = vec.vector(2, 2, 2, 2),
  ["default"] = vec.vector(1.5, 1.5, 1.5, 1.5)
}
local promptOffset = vec.vector(0.5, 1.5, 0, 0)
local workingVector = vec.vector()
local promptSetup = {showDuration = 0, animationLength = 2}
function scorePrompt(prompt, promptScale, negativeFeedback)
  if not localPlayer.inZap then
    if negativeFeedback then
      promptSetup.colour = promptColours.negative
    else
      promptSetup.colour = promptColours.positive
    end
    promptSetup.position = workingVector:add(localPlayer.position, promptOffset)
    promptSetup.scale = promptScales[promptScale] or promptScales.default
    promptSetup.prompt = prompt or "NO TEXT SET"
    OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
    scoreprompt.set(promptSetup)
  end
end
function updateTutorialPanel(params)
  feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_1_button", "")
  feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_2_button", "")
  feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3_button", "")
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Icon", 0)
  if params.title then
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_title", params.title, nil, params.titleIcon)
  end
  if params.string1 then
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_1", params.string1, params.stringValue1, params.textIcon1)
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_Type", 1)
  end
  if params.string2 then
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_2", params.string2, params.stringValue2, params.textIcon2)
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_Type", 2)
  end
  if params.string3 then
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_string_3", params.string3, params.stringValue3, params.textIcon3)
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_Type", 3)
  end
  if params.highlight1 then
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_StringHighlight_1", 1)
  elseif params.clearHighlight1 then
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_StringHighlight_1", 0)
  end
  if params.highlight2 then
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_StringHighlight_2", 1)
  elseif params.clearHighlight2 then
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_StringHighlight_2", 0)
  end
  if params.highlight3 then
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_StringHighlight_3", 1)
  elseif params.clearHighlight3 then
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_StringHighlight_3", 0)
  end
  if params.tick1 then
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_StringHighlight_1", 0)
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Tick_1", 1)
    taskSuccessAudio()
  elseif params.clearTick1 then
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Tick_1", 0)
  end
  if params.tick2 then
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_StringHighlight_2", 0)
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Tick_2", 1)
    taskSuccessAudio()
  elseif params.clearTick2 then
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Tick_2", 0)
  end
  if params.tick3 then
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_StringHighlight_3", 0)
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Tick_3", 1)
    taskSuccessAudio()
  elseif params.clearTick3 then
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Tick_3", 0)
  end
  if params.panelState then
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", params.panelState)
    if params.panelState == 1 and simulation.getSpeed() == 0 then
      PauseMenu.allow(false)
    else
      PauseMenu.allow(true)
    end
  end
  if params.continueState then
    feedbackSystem.menusMaster.currentHUDSetTextVariable("tutorial_continue_button", localPlayer.buttonLayout.accept)
    feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_Continue_Prompt", params.continueState)
  end
end
function hideBlueBall(bHide)
  if bHide then
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_willpower_level", "")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_willpower_level_number", "")
    feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 0)
  else
    feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 3)
  end
end
local stringLookup = {}
for i = 0, 99 do
  stringLookup[i] = format(stringFormat, i)
end
function formatTime(time)
  if time then
    local mins = stringLookup[floor(time / 60)]
    local secs = stringLookup[floor(time % 60)]
    local milli = stringLookup[math.min(99, round_num(100 * (time - floor(time))))]
    if mins and string.len(mins) <= 2 then
      return mins, secs, milli
    else
      return 99, 59, 99
    end
  end
end
stuntFeedbackActive = false
function updateStuntFeedback(params)
  if gameStatus.onlineSession then
    return
  end
  if not raceManager.wrongWayPromptActive and not raceManager.offRoutePromptActive and not localPlayer.minimapSupport.zoomed and params then
    if not params.stuntHide then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.clearSecondaryTextPrompt()
    end
    if not stuntFeedbackActive then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Stunt_Global", 1)
      stuntFeedbackActive = true
    end
    if params.stuntText then
      feedbackSystem.menusMaster.masterSetTextVariable("score_feedback_stunt", params.stuntText, params.stuntTextValue or nil)
    end
    if params.stuntIcon then
      feedbackSystem.menusMaster.masterSetTextVariable("score_feedback_stunt_icon", params.stuntIcon)
    end
    if params.willpowerIcon then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_WP", 1)
    else
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_WP", 0)
    end
    if params.stuntFail then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Stunt_Global", 3)
      stuntFeedbackActive = false
    end
    if params.stuntSlotPass == 1 then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Stunt_Global", 4)
    elseif params.stuntSlotPass == 2 then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Stunt_Global", 5)
    elseif params.stuntSlotPass == 3 then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Stunt_Global", 6)
    end
    if params.stuntSlotPass then
      stuntFeedbackActive = false
    end
    if params.stuntHide then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Stunt_Global", 0)
      stuntFeedbackActive = false
    end
  else
    feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Stunt_Global", 0)
    stuntFeedbackActive = false
  end
end
pointsFeedbackActive = false
function updatePointsFeedback(params)
  if gameStatus.onlineSession then
    return
  end
  if not localPlayer.minimapSupport.zoomed and params then
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    feedbackSystem.menusMaster.clearSecondaryTextPrompt()
    if not pointsFeedbackActive then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Points", 1)
      if not params.noAudio then
        OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
      end
      pointsFeedbackActive = true
    end
    if params.pointsText then
      feedbackSystem.menusMaster.masterSetTextVariable("score_feedback_points", params.pointsText, params.pointsValue)
    end
    if params.willpowerIcon then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_WP", 1)
    else
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_WP", 0)
    end
    if params.pointsSlotPass == 1 then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Points", 2)
    elseif params.pointsSlotPass == 2 then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Points", 3)
    elseif params.pointsSlotPass == 3 then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Points", 4)
    end
    if params.pointsSlotFail == 1 then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Points", 5)
    elseif params.pointsSlotFail == 2 then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Points", 6)
    elseif params.pointsSlotFail == 3 then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Points", 7)
    end
    if params.pointsSlotPass or params.pointsSlotFail then
      pointsFeedbackActive = false
    end
    if params.pointsHide then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Points", 0)
      pointsFeedbackActive = false
    end
  else
    feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Points", 0)
    pointsFeedbackActive = false
  end
end
barFeedbackActive = false
function updateBarFeedback(params)
  if not barFeedbackActive then
    feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Gauge_State", 1)
    barFeedbackActive = true
  end
  if params.barText then
    feedbackSystem.menusMaster.masterSetTextVariable("score_feedback_gauge", params.barText)
  end
  if params.barIcon then
    feedbackSystem.menusMaster.masterSetTextVariable("score_feedback_gauge_icon", params.barIcon)
  end
  if params.barPass then
    feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Gauge_State", 3)
    barFeedbackActive = false
  end
  if params.barFail then
    feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Gauge_State", 2)
    barFeedbackActive = false
  end
  if params.barValue then
    feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Gauge", params.barValue)
  end
  if params.barHide then
    feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Gauge_State", 0)
    barFeedbackActive = false
  end
  if barFeedbackActive then
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    feedbackSystem.menusMaster.clearSecondaryTextPrompt()
  end
end
local positiveTime = false
function updateSplitTime(params)
  if gameStatus.onlineSession then
    return
  end
  if not raceManager.wrongWayPromptActive and not raceManager.offRoutePromptActive and not localPlayer.minimapSupport.zoomed and params then
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    feedbackSystem.menusMaster.clearSecondaryTextPrompt()
    if params.splitTimeText then
      feedbackSystem.menusMaster.masterSetTextVariable("score_feedback_split_title", params.splitTimeText)
    end
    if params.splitTime then
      local mins, secs, milli = feedbackSystem.formatTime(params.splitTime)
      local formattedTime = string.format(fullTimeFormat, mins, secs, milli)
      if formattedTime == "00:00.00" then
        params.splitTimePositive = nil
        params.splitTimeNegative = true
      end
      feedbackSystem.menusMaster.masterSetTextVariable("score_feedback_split", formattedTime)
    end
    if params.splitTimePositive then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Split", 1)
      positiveTime = true
    end
    if params.splitTimeNegative then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Split", 2)
    end
    if params.splitTimeRemove then
      feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Split", 0)
      positiveTime = false
    end
  else
    feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Split", 0)
    positiveTime = false
  end
end
function updateSpeedLocalisation()
  if ProfileSettings.DisplayInMPH() then
    speedConversion = "mph"
  else
    speedConversion = "kph"
  end
end
local speedPattern = "%03d"
function localiseSpeedFromMetersASecond(speed)
  return floor(speed * speedConversions[speedConversion])
end
local mphToKmh = 1.609344
local kmhToMph = 0.6213712
local roundTo = 5
function mphToLocalisedSpeed(speed)
  if speedConversion == "kph" then
    local roundedSpeedInKmh = floor(speed * mphToKmh / roundTo) * roundTo
    local adjustedSpeedInMph = roundedSpeedInKmh * kmhToMph
    return roundedSpeedInKmh, adjustedSpeedInMph
  else
    return speed, speed
  end
end
function RandomiseMilliseconds(time)
  framework.seed()
  time = time * 10
  time = floor(time)
  time = time * 10
  time = time + framework.random(0, 9)
  time = time / 100
  return time
end
