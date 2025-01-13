feedbackSystem.registerHUD("DeactivatingBUTs hud", function(task, settings)
end, function(task, settings)
  local timer, defuseBarParams, counterTable
  if settings.showTimer then
    timer = {
      slot = 1,
      startTime = settings.timerStartTime
    }
    feedbackSystem.stepTimer(timer)
  end
  if settings.showDefuseBar then
    defuseBarParams = {
      barText = "ID:184862",
      barIcon = iconsTable.c4Smash,
      barPass = false,
      barValue = 0,
      barHide = true,
      stopDefuseBarUpdate = false
    }
    if settings.playDiffuseFailSpeech then
      defuseBarParams.failedToDefuse = true
      defuseBarParams.playDiffuseFailSpeech = true
    end
  end
  if settings.showCounter then
    counterTable = {
      slot = 2,
      title = "ID:186204",
      barTitle = "ID:236325",
      numericValue = 0,
      value = 0
    }
    feedbackSystem.updateProgressBar(counterTable)
  end
  local function update()
    if settings.showDefuseBar and not defuseBarParams.stopDefuseBarUpdate then
      if task.goalFeedback.Time and task.goalFeedback.Time > 0 and not localPlayer.inZap then
        if defuseBarParams.playDiffuseFailSpeech and not defuseBarParams.failedToDefuse then
          defuseBarParams.failedToDefuse = true
        end
        if defuseBarParams.barHide then
          defuseBarParams.barHide = false
        end
        if feedbackSystem.menusMaster.primaryPromptActive then
          feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        end
        if settings.trailerTimer then
          defuseBarParams.barValue = 100 / settings.trailerTimer * task.goalFeedback.Time
        end
        feedbackSystem.updateBarFeedback(defuseBarParams)
      elseif not defuseBarParams.barHide then
        if defuseBarParams.playDiffuseFailSpeech and defuseBarParams.failedToDefuse then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_5")
          defuseBarParams.playDiffuseFailSpeech = false
        end
        defuseBarParams.barHide = true
        feedbackSystem.updateBarFeedback(defuseBarParams)
      end
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Play PIP01" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184863", nil, true)
    elseif task.specialName == "Show STAY UNDER prompt" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184866", nil, false, false)
      feedbackSystem.menusMaster.setCurrentFocusString(2)
    elseif task.specialName == "get first bomb" or task.specialName == "police task" and conditionKey == 1 then
      if defuseBarParams.playDiffuseFailSpeech then
        defuseBarParams.failedToDefuse = false
      end
      if settings.showDefuseBar then
        defuseBarParams.barValue = 100
        feedbackSystem.updateBarFeedback(defuseBarParams)
      end
      if settings.showCounter then
        counterTable.numericValue = task.networkVars.laps
        counterTable.value = task.networkVars.laps * settings.truckQuantity
        feedbackSystem.updateProgressBar(counterTable)
      end
      if conditionKey == 1 then
        if task.specialName == "get first bomb" and task.networkVars.laps == 1 then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:184868", nil, false, false)
        else
          feedbackSystem.menusMaster.primaryTextPrompt("ID:184869", nil, false, false)
        end
      end
    end
  end
  local function cleanUp()
    if task.specialName == "police task" then
      feedbackSystem.removeSlot(1)
      feedbackSystem.removeSlot(2)
    end
    if settings.showDefuseBar then
      defuseBarParams.stopDefuseBarUpdate = true
      defuseBarParams.barHide = true
      feedbackSystem.updateBarFeedback(defuseBarParams)
    end
  end
  return update, goalComplete, nil, cleanUp
end)
