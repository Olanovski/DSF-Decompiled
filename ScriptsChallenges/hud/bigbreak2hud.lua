feedbackSystem.registerHUD("Big break 2 hud", function(task, settings)
end, function(task, settings)
  local bar = {
    slot = 3,
    title = "ID:184308",
    barTitle = "ID:184306",
    value = 0,
    numericValue = 0
  }
  local timer = {
    slot = 1,
    startTime = task.instance.timeLimit
  }
  local countdownStarted = false
  local previousNumberSmashed = 0
  local signTimeBonus = 3
  local pointsParams = {pointsText = "ID:220701", pointsSlotPass = 1}
  if task.specialName == "Destruction" then
    bar.value = propSystem.getAccumulativeNumberSmashed()
    bar.numericValue = propSystem.getAccumulativeNumberSmashed()
    feedbackSystem.updateProgressBar(bar)
    feedbackSystem.stepTimer(timer)
  end
  local function update()
    if not gameStatus.simulationPaused then
      if task.specialName == "Wait for countdown" then
        if not countdownStarted then
          feedbackSystem.menusMaster.singlePlayer321Countdown()
          countdownStarted = true
        end
      elseif not localPlayer.inCutscene then
        timer.updateStartTime = false
        if propSystem.getAccumulativeNumberSmashed() > previousNumberSmashed then
          pointsParams.pointsText = "+" .. tostring(signTimeBonus)
          feedbackSystem.updatePointsFeedback(pointsParams)
          task.instance.timeLimit = task.instance.timeLimit + signTimeBonus
          timer.startTime = task.instance.timeLimit
          timer.updateStartTime = true
          feedbackSystem.stepTimer(timer)
          OneShotSound.Play("HUD_Gen_Positive", false)
          previousNumberSmashed = previousNumberSmashed + 1
        end
        if bar.numericValue ~= propSystem.getAccumulativeTotalOfInitialProps() then
          bar.value = propSystem.getAccumulativeNumberSmashed() * 2
          bar.numericValue = propSystem.getAccumulativeNumberSmashed()
          feedbackSystem.updateProgressBar(bar)
        end
      end
    end
  end
  return update
end)
