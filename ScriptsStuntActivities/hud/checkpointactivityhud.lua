local willpowerValue
feedbackSystem.registerHUD("Checkpoint activity hud", function(task, settings)
end, function(task, settings)
  local playerWillpowerBar = {
    slot = 1,
    value = 100,
    numericValue = willpowerValue,
    title = "ID:243978"
  }
  local willpowerBonus = task.instance.challenge.goalValues["Willpower per checkpoint"] or 1000
  local decreaseValue = task.instance.challenge.goalValues["Substracted willpower per second"] or 2
  local startTime
  local pointsParams = {
    pointsText = "",
    pointsSlotPass = 1,
    willpowerIcon = true
  }
  local countdownStarted = false
  local lowWarning = false
  local criticalWarning = false
  if task.specialName == "Checkpoints" then
    willpowerValue = task.instance.challenge.goalValues["Maximum willpower"] or 12500
    playerWillpowerBar.numericValue = willpowerValue
    startTime = g_NetworkTime
    feedbackSystem.updateWillpowerBar(playerWillpowerBar)
    feedbackSystem.menusMaster.primaryTextPromptParam({
      prompt = "ID:245597",
      delay = true,
      priority = 1
    })
  end
  local function update()
    if not gameStatus.simulationPaused and task.specialName == "Wait for countdown" and not countdownStarted then
      feedbackSystem.menusMaster.singlePlayer321Countdown()
      countdownStarted = true
    end
  end
  local function goalComplete()
    if task.specialName == "Reduce willpower" then
      willpowerValue = willpowerValue - decreaseValue
      if willpowerValue < 0 then
        willpowerValue = 0
      end
      playerWillpowerBar.value = willpowerValue / task.instance.challenge.goalValues["Maximum willpower"] * 100
      playerWillpowerBar.numericValue = willpowerValue
      feedbackSystem.updateWillpowerBar(playerWillpowerBar)
      if not lowWarning and playerWillpowerBar.value <= 50 then
        feedbackSystem.menusMaster.primaryTextPromptParam({
          prompt = "ID:247264",
          icon1 = iconsTable.willpower,
          priority = 2
        })
        OneShotSound.Play("HUD_Gen_WP_Low_Prompt_OneShot", false)
        lowWarning = true
      elseif not criticalWarning and playerWillpowerBar.value <= 20 then
        feedbackSystem.menusMaster.primaryTextPromptParam({
          prompt = "ID:247265",
          icon1 = iconsTable.willpower,
          priority = 2
        })
        OneShotSound.Play("HUD_Gen_WP_Low_Prompt_OneShot", false)
        criticalWarning = true
      end
    elseif task.specialName == "Checkpoints" then
      task.instance.timeLimit = task.instance.timeLimit + willpowerBonus / task.instance.challenge.goalValues["Substracted willpower per second"]
      if task.instance.timeLimit - (g_NetworkTime - startTime) > task.instance.challenge.goalValues["Maximum willpower"] / task.instance.challenge.goalValues["Substracted willpower per second"] then
        task.instance.timeLimit = task.instance.challenge.goalValues["Maximum willpower"] / task.instance.challenge.goalValues["Substracted willpower per second"] + (g_NetworkTime - startTime)
      end
      willpowerValue = willpowerValue + willpowerBonus
      if willpowerValue > task.instance.challenge.goalValues["Maximum willpower"] then
        willpowerValue = task.instance.challenge.goalValues["Maximum willpower"]
      end
      playerWillpowerBar.value = willpowerValue / task.instance.challenge.goalValues["Maximum willpower"] * 100
      playerWillpowerBar.numericValue = willpowerValue
      feedbackSystem.updateWillpowerBar(playerWillpowerBar)
      pointsParams.pointsText = "+" .. tostring(willpowerBonus)
      feedbackSystem.updatePointsFeedback(pointsParams)
    end
  end
  local function taskComplete()
    if task.specialName == "Checkpoints" and task.success then
      task.instance.accumulatedWillpower = playerWillpowerBar.numericValue
    end
  end
  local cleanup = function()
  end
  return update, goalComplete, taskComplete, nil
end)
