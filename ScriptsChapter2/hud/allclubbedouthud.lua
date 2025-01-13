feedbackSystem.registerHUD("All clubbed out hud", function(task, settings)
end, function(task, settings)
  local signTimeBonus = 3
  local pointsParams = {
    pointsText = "ID:246669",
    pointsValue = signTimeBonus,
    pointsSlotPass = 1
  }
  local previousNumberSmashed = 0
  local clubPosition = vec.vector(616.486, 34.252, 556.233, 1)
  local timer
  if task.specialName == "Saboteur route" then
    timer = {
      slot = 1,
      startTime = task.instance.challenge.goalValues["Time limit"]
    }
    feedbackSystem.stepTimer(timer)
  end
  local function update()
    if task.specialName == "Saboteur route" then
      if propSystem.getAccumulativeNumberSmashed() > previousNumberSmashed then
        feedbackSystem.updatePointsFeedback(pointsParams)
        task.instance.timeLimit = task.instance.timeLimit + signTimeBonus
        timer.startTime = task.instance.timeLimit
        timer.updateStartTime = true
        feedbackSystem.stepTimer(timer)
        previousNumberSmashed = previousNumberSmashed + 1
      else
        timer.updateStartTime = false
        feedbackSystem.stepTimer(timer)
      end
    end
  end
  local function taskComplete()
    if task.specialName == "Initial pause" then
      CutsceneFiles.tutorials.playTutorial("ID:243968")
    elseif task.specialName == "First text prompt" then
      local promptParams = {prompt = "ID:245532", priority = 1}
      feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
    end
  end
  return update, nil, taskComplete, nil
end)
