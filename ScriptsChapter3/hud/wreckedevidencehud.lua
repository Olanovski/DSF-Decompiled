local attackPromptDisplayed = false
feedbackSystem.registerHUD("Wrecked evidence hud", function(task, settings)
end, function(task, settings)
  local evidenceHealthBar, timer, previousDamage, showGoonCounter, previousCount, initialiseCounter
  if settings.updateHealth then
    evidenceHealthBar = {
      slot = 1,
      title = "ID:184602",
      value = 0
    }
  end
  local function getGoonCount()
    local count = 0
    for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team == "Siege team" then
        count = count + 1
      end
    end
    return count
  end
  if settings.updateTimer and settings.timerLength then
    timer = {slot = 2}
    timer.startTime = settings.timerLength
    feedbackSystem.stepTimer(timer)
  end
  local function update()
    if not gameStatus.simulationPaused then
      if settings.updateHealth and task.agent.damage ~= previousDamage then
        evidenceHealthBar.value = task.agent.damage
        feedbackSystem.updateHealthBar(evidenceHealthBar)
        previousDamage = task.agent.damage
      end
      if showGoonCounter then
        local currentCount = getGoonCount()
        if not initialiseCounter then
          feedbackSystem._G.showFelonyCounter(true)
          initialiseCounter = true
        end
        if currentCount ~= previousCount then
          feedbackSystem._G.updateFelonyCounter(currentCount)
          previousCount = currentCount
        end
      end
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Is being driven" or task.specialName == "Initial being driven" then
      if conditionKey == 1 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:184588", false, false, false, false, false)
      elseif conditionKey == 2 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:246487", false, false, false, false, false)
      else
        feedbackSystem.menusMaster.primaryTextPrompt("ID:184589", false, false, false, false)
      end
    elseif task.specialName == "Proximity warning" then
      if not feedbackSystem.menusMaster.primaryPromptActive then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:243692", false, false, false, false, false)
      else
        removeUserUpdateFunction("promptWait")
        localPlayer.simulationSupport.doWait(1, function()
          feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        end, "promptWait")
      end
    elseif task.specialName == "Wait for Police" then
      if settings.updateTimer and not showGoonCounter then
        feedbackSystem.removeSlot(2)
        showGoonCounter = true
      end
    elseif task.specialName == "Attacker Hits Prison Van" and conditionKey == 1 and not attackPromptDisplayed then
      attackPromptDisplayed = true
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243690", false, false, false, false, false, function()
        attackPromptDisplayed = false
      end)
    end
  end
  local function cleanup()
    if settings.updateHealth then
      feedbackSystem.removeSlot(1)
    end
    if settings.updateTimer then
      feedbackSystem.removeSlot(2)
      if showGoonCounter then
        showGoonCounter = false
        feedbackSystem._G.hideFelonyCounter()
      end
    end
  end
  return update, goalComplete, nil, cleanup
end)
