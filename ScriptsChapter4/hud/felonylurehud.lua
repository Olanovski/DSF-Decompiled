feedbackSystem.registerHUD("Felony lure HUD", function(task, settings)
end, function(task)
  local showText = function(text, secondary, delay)
    local delay = delay or false
    if not secondary then
      feedbackSystem.menusMaster.primaryTextPrompt(text, nil, delay, false, false)
    else
      feedbackSystem.menusMaster.secondaryTextPrompt(text, nil, false, delay, false)
    end
  end
  local prompt
  if task.specialName == "AI drives to kidnapper having too few cops" or task.specialName == "Use alleys warning prompt" or task.specialName == "Felony lure section instructions" then
    prompt = {
      ["Drive to kidnapper brief"] = "ID:184928",
      ["Avoid main roads"] = "ID:185686",
      ["Warn to get more cops"] = "ID:184929",
      ["Warn to get cops"] = "ID:246290"
    }
  end
  local currentSuspicion = 0
  local prevSuspicion = -1
  local vehicles
  if task.specialName == "Highlighted cop car manager" or task.specialName == "Felony lure section instructions" then
    vehicles = {
      {VehicleModelUID = 267},
      {VehicleModelUID = 271},
      {VehicleModelUID = 280},
      {VehicleModelUID = 269},
      {VehicleModelUID = 265}
    }
  end
  if task.specialName == "Player lures cops to the kidnapper" then
    feedbackSystem.removeSlot(1)
    feedbackSystem.removeSlot(2)
  end
  local suspicionBar, timer1, timer2
  if task.specialName == "Use alleys" then
    suspicionBar = {
      slot = 1,
      title = "ID: 243849",
      barTitle = "ID:185689",
      value = 0,
      percentValue = 100
    }
  elseif task.specialName == "Destination B timed drive through alleyways" then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:246231", false, false)
    timer1 = {slot = 2, startTime = 150}
  elseif task.specialName == "Player lures cops to the kidnapper" then
    timer2 = {slot = 1, startTime = 180}
  end
  local function update()
    if task.specialName == "Destination B timed drive through alleyways" and not task.complete then
      feedbackSystem.stepTimer(timer1)
    elseif task.specialName == "Use alleys" and not task.complete then
      currentSuspicion = task.agent:getTaskObject().namedTasks[task.specialName].networkVars.payload or 0
      Sound.SetRTPC("Paranoia_Meter", currentSuspicion)
      if prevSuspicion ~= currentSuspicion then
        if prevSuspicion > currentSuspicion then
          Sound.SetState("Suspicion_State", "Off")
        else
          Sound.SetState("Suspicion_State", "On")
        end
        if currentSuspicion <= 100 then
          suspicionBar.value = currentSuspicion
          feedbackSystem.updateDangerBar(suspicionBar)
        else
          suspicionBar.value = 100
        end
        prevSuspicion = currentSuspicion
      end
    elseif task.specialName == "Player lures cops to the kidnapper" then
      feedbackSystem.stepTimer(timer2)
    end
  end
  local warningOn = false
  local avoidAlleywaysPromptShowing = false
  local function goalCallback(conditionKey)
    if task.specialName == "Highlighted cop car manager" then
      if conditionKey == 1 and not localPlayer.minimapSupport.highlightedVehicles then
        minimap.AddHighlightedVehicleModelUIDs(vehicles)
        localPlayer.minimapSupport.highlightedVehicles = true
        minimap.SetHighlightedVehicles(true)
        localPlayer.minimapSupport.setHighlightedVehicleModelType("smash")
      elseif conditionKey == 2 then
        localPlayer.minimapSupport.highlightedVehicles = false
        minimap.SetHighlightedVehicles(false)
      end
    elseif task.specialName == "AI drives to kidnapper having too few cops" and conditionKey == 1 and not warningOn then
      showText(prompt["Warn to get more cops"], false)
      feedbackSystem.eventFeedback(task.agent, "GPMV01_FAILURE_L_6")
      warningOn = true
    elseif task.specialName == "AI drives to kidnapper having too few cops" and conditionKey == 2 and warningOn then
      warningOn = false
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    elseif task.specialName == "AI drives to kidnapper having too few cops" and conditionKey == 3 then
      showText(prompt["Warn to get cops"], false)
    elseif task.specialName == "Use alleys warning prompt" then
      if conditionKey == 1 then
        feedbackSystem.menusMaster.primaryTextPrompt(prompt["Avoid main roads"], nil, false)
        avoidAlleywaysPromptShowing = true
      elseif conditionKey == 2 and feedbackSystem.menusMaster.primaryPromptActive and avoidAlleywaysPromptShowing then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        avoidAlleywaysPromptShowing = false
      end
    elseif task.specialName == "Use alleys" then
      if conditionKey == 9 then
        local prompt = {
          prompt = "ID:184547",
          delay = false,
          priority = 2
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
      elseif conditionKey == 10 then
        local prompt = {
          prompt = "ID:248256",
          delay = false,
          priority = 2
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
      elseif conditionKey == 11 then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        local prompt = {
          prompt = "ID:243911",
          delay = false,
          priority = 2
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
      elseif conditionKey == 12 then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        local prompt = {
          prompt = "ID:184547",
          delay = false,
          priority = 2
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
      end
    end
  end
  local function taskComplete()
    if task.specialName == "Objective prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:246231", false, false)
    elseif task.specialName == "Dest B instructions" then
      feedbackSystem.menusMaster.setCurrentFocusString(3)
    elseif task.specialName == "Destination B timed drive through alleyways" or task.specialName == "Turn the player part 2" then
      feedbackSystem.removeSlot(1)
      feedbackSystem.removeSlot(2)
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    elseif task.specialName == "Felony lure section instructions" then
      showText(prompt["Drive to kidnapper brief"])
      feedbackSystem.menusMaster.setCurrentFocusString(4)
      minimap.AddHighlightedVehicleModelUIDs(vehicles)
      minimap.SetHighlightedVehicles(true)
      PatrollingVehicleManager.EnableHud(false)
      localPlayer.minimapSupport.setHighlightedVehicleModelType("smash")
    end
  end
  local function cleanup()
    localPlayer.minimapSupport.highlightedVehicles = false
    if task.specialName == "Fail to meet point C criteria" then
      feedbackSystem.removeSlot(1)
    elseif task.specialName == "Collision test dest B" then
      feedbackSystem.removeSlot(2)
    end
  end
  return update, goalCallback, taskComplete, cleanup
end)
