feedbackSystem.registerHUD("Felony getaway activity hud", function(task, settings)
end, function(task, settings)
  local timer = {}
  if task.instance.challenge.goalValues["Time limit"] then
    timer = {
      slot = 1,
      startTime = task.instance.challenge.goalValues["Time limit"]
    }
  end
  local countdownStarted = false
  local showingWarning = false
  local warningParams = {
    prompt = "ID:231403",
    permanent = true,
    priority = 2
  }
  local function update()
    if not gameStatus.simulationPaused then
      if task.specialName == "Wait for countdown" then
        if task.instance.challenge.goalValues["Start countdown"] and not countdownStarted then
          feedbackSystem.menusMaster.singlePlayer321Countdown()
          countdownStarted = true
        end
      elseif not localPlayer.inCutscene and task.instance.challenge.goalValues["Time limit"] then
        timer.startTime = task.instance.challenge.goalValues["Time limit"]
        feedbackSystem.stepTimer(timer)
      end
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Lose cops warning" then
      if conditionKey == 1 and not showingWarning then
        feedbackSystem.menusMaster.primaryTextPromptParam(warningParams)
        showingWarning = true
      elseif showingWarning then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        showingWarning = false
      end
    elseif task.specialName == "Change objective if chase status changes" then
      if conditionKey == 1 then
        feedbackSystem.menusMaster.primaryTextPromptParam({
          prompt = "ID:245575",
          delay = true,
          priority = 1
        })
        feedbackSystem.menusMaster.setCurrentFocusString(1)
      else
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:236468", priority = 1})
        feedbackSystem.menusMaster.setCurrentFocusString(2)
      end
    end
  end
  local taskComplete = function()
  end
  local cleanup = function()
  end
  return update, goalComplete, nil, nil
end)
