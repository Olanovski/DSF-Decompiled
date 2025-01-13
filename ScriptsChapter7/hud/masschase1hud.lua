feedbackSystem.registerHUD("Mass chase hud", function(task, settings)
end, function(task, settings)
  local timer, showingWarning, lastChaseStarted, displayTimer
  if task.specialName == "Chase" then
    timer = {slot = 1, startTime = 90}
    displayTimer = false
  elseif task.specialName == "Lose cops warning" then
    showingWarning = false
  elseif task.specialName == "Board the tuck prompt reminder" then
    lastChaseStarted = false
  end
  local function update()
    if not gameStatus.simulationPaused and task.specialName == "Chase" and displayTimer then
      feedbackSystem.stepTimer(timer)
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Lose cops warning" then
      if conditionKey == 1 and not showingWarning then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:231403", nil, false, false, true)
        showingWarning = true
      elseif showingWarning then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        showingWarning = false
      end
    elseif task.specialName == "Board the tuck prompt reminder" then
      if conditionKey == 1 then
        lastChaseStarted = true
      elseif conditionKey == 2 and lastChaseStarted == true then
        local prompt = {prompt = "ID:184790", priority = 1}
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
      end
    elseif task.specialName == "Chase" and conditionKey == 3 then
      displayTimer = true
    end
  end
  local function taskComplete()
    if task.specialName == "First prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245541")
    elseif task.specialName == "Get to safety prompt" then
      feedbackSystem.menusMaster.setCurrentFocusString(2)
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245544", false, false, false, false)
    elseif task.specialName == "Reminder prompt about Aegis" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245542")
    elseif task.specialName == "Board the truck prompt" then
      local prompt = {prompt = "ID:184790", priority = 1}
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    elseif task.specialName == "Chase" and task.success then
      displayTimer = false
      feedbackSystem.removeSlot(1)
      if localPlayer.inZap then
        localPlayer:SetZapLevel(0, task.instance.taskObjectsByActorID.Truck.coreData.agent, false)
      else
        localPlayer:zapToAgent(task.instance.taskObjectsByActorID.Truck.coreData.agent)
      end
      Commentary.StopCommentary()
    end
  end
  return update, goalComplete, taskComplete, nil
end)
