local attackPromptDisplayed = false
local copsPromptDisplayed = false
feedbackSystem.registerHUD("Protect HUD", function(task, settings)
end, function(task, settings)
  local truckHealthBar, timer, previousDamage, showGoonCounter, previousCount, initialiseCounter
  if settings.updateHealth then
    truckHealthBar = {
      slot = 1,
      title = "ID:184602",
      value = 0
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
  if settings.updateTimer and settings.timerLength then
    timer = {slot = 2}
    timer.startTime = settings.timerLength
    feedbackSystem.stepTimer(timer)
  end
  if task.specialName == "Sieged" then
    feedbackSystem.menusMaster.primaryTextPromptParam({
      prompt = "ID:231119",
      delay = true,
      priority = 1
    })
  end
  local function update()
    if not gameStatus.simulationPaused then
      if settings.updateHealth and task.agent.damage ~= previousDamage then
        truckHealthBar.value = task.agent.damage
        feedbackSystem.updateHealthBar(truckHealthBar)
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
    if task.specialName == "Proximity warning" then
      if not attackPromptDisplayed then
        if not feedbackSystem.menusMaster.primaryPromptActive then
          feedbackSystem.menusMaster.primaryTextPromptParam({
            prompt = "ID:243754",
            permanent = true,
            priority = 1
          })
        else
          removeUserUpdateFunction("promptWait")
          localPlayer.simulationSupport.doWait(1, function()
            feedbackSystem.menusMaster.clearPrimaryTextPrompt()
          end, "promptWait")
        end
      end
    elseif task.specialName == "Sieged" then
      if settings.updateTimer and not showGoonCounter then
        feedbackSystem.removeSlot(2)
        showGoonCounter = true
      end
    elseif task.specialName == "Attacker Hits Prison Van" and conditionKey == 1 then
      attackPromptDisplayed = true
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.primaryTextPromptParam({
        prompt = "ID:243800",
        priority = 1,
        endCallback = function()
          attackPromptDisplayed = false
        end
      })
    end
  end
  local function cleanup()
    if settings.updateHealth then
      feedbackSystem.removeSlot(1)
    end
    if settings.updateTimer then
      feedbackSystem.removeSlot(2)
      showGoonCounter = false
      feedbackSystem._G.hideFelonyCounter()
    end
    removeUserUpdateFunction("promptWait")
  end
  return update, goalComplete, nil, cleanup
end)
