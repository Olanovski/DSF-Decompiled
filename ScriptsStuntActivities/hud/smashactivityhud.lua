local willpowerValue
feedbackSystem.registerHUD("Generic smash activity HUD", function(task, settings)
end, function(task, settings)
  local willpowerBonus = task.instance.challenge.goalValues["Willpower per prop"] or 3
  local decreaseValue = task.instance.challenge.goalValues["Substracted willpower per second"] or 50
  local pointsParams = {
    pointsText = "",
    pointsSlotPass = 1,
    willpowerIcon = true
  }
  local previousNumberSmashed = 0
  local lowWarning = false
  local criticalWarning = false
  local playerWillpowerBar = {
    slot = 1,
    value = 100,
    numericValue = willpowerValue
  }
  local timer = {}
  if task.instance.challenge.goalValues["Timer value"] then
    timer = {
      slot = 2,
      startTime = task.instance.challenge.goalValues["Timer value"]
    }
  end
  if task.specialName == "Smash props" then
    willpowerValue = task.instance.challenge.goalValues["Maximum willpower"] or 4000
    startTime = g_NetworkTime
    playerWillpowerBar.numericValue = willpowerValue
    feedbackSystem.updateWillpowerBar(playerWillpowerBar)
    feedbackSystem.menusMaster.primaryTextPromptParam({
      prompt = "ID:247291",
      delay = true,
      priority = 1
    })
  end
  local countdownStarted = false
  local function update()
    if not gameStatus.simulationPaused then
      if task.specialName == "Wait for countdown" then
        if not countdownStarted then
          feedbackSystem.menusMaster.singlePlayer321Countdown()
          countdownStarted = true
        end
      elseif task.specialName == "Smash props" then
        if task.instance.challenge.goalValues["Timer value"] then
          feedbackSystem.stepTimer(timer)
        end
        if propSystem.getAccumulativeNumberSmashed() > previousNumberSmashed then
          pointsParams.pointsText = "+" .. tostring(willpowerBonus)
          feedbackSystem.updatePointsFeedback(pointsParams)
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
          OneShotSound.Play("HUD_Gen_Positive", false)
          previousNumberSmashed = previousNumberSmashed + 1
        end
      end
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
    end
  end
  local function taskComplete()
    if task.specialName == "Smash props" and task.success then
      task.instance.accumulatedWillpower = willpowerValue
    end
  end
  return update, goalComplete, taskComplete, nil
end)
