local attackPromptDisplayed = false
local copsPromptDisplayed = false
feedbackSystem.registerHUD("Protect the base HUD", function(task, settings)
end, function(task, settings)
  local instance = task.instance
  local taskObject = instance.taskObjectsByActorID.MoneyTruck
  local previousDamage, playerHealthBar, timer, previousCount, showGoonCounter, initialiseCounter
  if settings.updateHealth then
    playerHealthBar = {
      slot = 1,
      title = "ID:184602",
      value = nil
    }
  end
  local function getGoonCount()
    local count = 0
    for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team == "Attack team" then
        count = count + 1
      end
    end
    return count
  end
  if settings.updateTimer then
    timer = {barTitle = "ID:243582", slot = 2}
    if settings.timerLength then
      timer.startTime = settings.timerLength
      feedbackSystem.stepTimer(timer)
    end
  end
  local function update()
    if not gameStatus.simulationPaused then
      if settings.updateHealth then
        local damage = taskObject.coreData.agent.damage
        if damage ~= previousDamage then
          playerHealthBar.value = damage
          feedbackSystem.updateHealthBar(playerHealthBar)
          previousDamage = damage
        end
      end
      if showGoonCounter then
        local count = getGoonCount()
        if not initialiseCounter then
          feedbackSystem._G.showFelonyCounter(true)
          initialiseCounter = true
        end
        if count ~= previousCount then
          feedbackSystem._G.updateFelonyCounter(count)
          previousCount = count
        end
      end
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Proximity warning" then
      if not attackPromptDisplayed and not copsPromptDisplayed then
        if not feedbackSystem.menusMaster.primaryPromptActive then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:243754", false, false, true, false, false)
        else
          removeUserUpdateFunction("promptWait")
          localPlayer.simulationSupport.doWait(1, function()
            feedbackSystem.menusMaster.clearPrimaryTextPrompt()
          end, "promptWait")
        end
      end
    elseif task.specialName == "Wait for Police" then
      if settings.updateTimer and not showGoonCounter then
        feedbackSystem.removeSlot(2)
        showGoonCounter = true
      end
    elseif task.specialName == "Attacker Hits Prison Van" and conditionKey == 1 then
      attackPromptDisplayed = true
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      removeUserUpdateFunction("promptWait")
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184713", false, false, false, false, false, function()
        attackPromptDisplayed = false
      end)
    end
  end
  local function taskComplete()
    if task.specialName == "Trigger Messages" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:231119")
      feedbackSystem.menusMaster.secondaryTextPrompt("ID:243581")
      attackPromptDisplayed = false
      copsPromptDisplayed = false
    elseif task.specialName == "Trigger Shift Reminder" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243691")
    end
  end
  local function cleanup()
    removeUserUpdateFunction("promptWait")
    if showGoonCounter then
      showGoonCounter = false
      feedbackSystem._G.hideFelonyCounter()
    end
  end
  return update, goalComplete, taskComplete, cleanup
end)
