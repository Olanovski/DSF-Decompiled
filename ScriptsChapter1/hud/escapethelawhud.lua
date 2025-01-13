feedbackSystem.registerHUD("Escape the law HUD", nil, function(task)
  local maxTime = task.instance.challenge.goalValues["Time limit"]
  local timer = {
    slot = 1,
    startTime = maxTime,
    flashTime = 60
  }
  local showingWarning = false
  local startDisplayTimer = false
  local prompt
  local function update()
    if task.specialName == "Display timer" and startDisplayTimer then
      feedbackSystem.stepTimer(timer)
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Lose cops warning" then
      if (conditionKey == 1 or conditionKey == 4) and not showingWarning then
        prompt = {
          prompt = "ID:231403",
          delay = false,
          permanent = true,
          priority = 2
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
        showingWarning = true
      elseif conditionKey == 5 then
        prompt = {prompt = "ID:248738", priority = 2}
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
      elseif showingWarning then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        showingWarning = false
      end
    elseif task.specialName == "Use boost prompt" then
      if isAbilityUnlocked("nitro") and Getaway.IsBeingChased(localPlayer.currentVehicle.gameVehicle) and ProfileSettings.GetTotalBoostTime() < 30 then
        prompt = {
          prompt = "ID:245320",
          icon1 = localPlayer.buttonLayout.boostAbility,
          delay = false,
          priority = 3
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
      end
    elseif task.specialName == "First prompt" then
      prompt = {
        prompt = "ID:245527",
        delay = false,
        priority = 1
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    elseif task.specialName == "Display timer" then
      startDisplayTimer = true
    end
  end
  local function taskComplete()
    if task.specialName == "Escaped being busted" then
      prompt = {prompt = "ID:245960", priority = 1}
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    elseif task.specialName == "Being chased toggle" then
      feedbackSystem.menusMaster.setCurrentFocusString(2)
      prompt = {
        prompt = "ID:245528",
        delay = false,
        priority = 1
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    end
  end
  local function cleanup()
    showingWarning = false
  end
  return update, goalComplete, taskComplete, cleanup
end)
