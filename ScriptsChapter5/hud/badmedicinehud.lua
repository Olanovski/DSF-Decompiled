feedbackSystem.registerHUD("Bad medicine hud", function(task, settings)
end, function(task, settings)
  local playedBoxesDestroyed1 = false
  local playedBoxesDestroyed2 = false
  local playerTask = task
  local previousCurrentValue = false
  local timer = {slot = 1, startTime = 30}
  task.instance.allowBonusDisplay = false
  local pointsParams = {pointsText = "ID:246669", pointsSlotPass = 1}
  local propHUD = {
    slot = 1,
    barIcon = "smash",
    barTitle = "ID:236569",
    value = 0
  }
  local timeAddition = 1
  local currentSmashed = 0
  local previousCurrentSmashed = 0
  local startCount
  local displayTimer = false
  local function smashBoxWatch()
    currentSmashed = startCount - propSystem.getNumberRemainingProps("bad medicine")
    local propCalc = math.floor(propSystem.getNumberSmashed("bad medicine") / propSystem.getInitialPropCount("bad medicine") * 100)
    if currentSmashed ~= previousCurrentValue then
      previousCurrentValue = currentSmashed
      if propCalc > 0 and not playedBoxesDestroyed1 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_3A")
        playedBoxesDestroyed1 = true
      elseif propCalc > 35 and not playedBoxesDestroyed2 then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_3B")
        playedBoxesDestroyed2 = true
      end
      previousCurrentValue = currentSmashed
      if previousCurrentValue > 0 then
        if task.instance.allowBonusDisplay then
          pointsParams.pointsValue = currentSmashed - previousCurrentSmashed
          feedbackSystem.updatePointsFeedback(pointsParams)
        end
        task.instance.timeLimit = task.instance.timeLimit + (currentSmashed - previousCurrentSmashed) * timeAddition
        previousCurrentSmashed = currentSmashed
        timer.startTime = task.instance.timeLimit
        timer.updateStartTime = true
      end
    end
  end
  if task.specialName == "Initial pause" then
    feedbackSystem.removeSlot(1)
  end
  GameVehicleResource.playerOnlyTakedown({gameVehicle = someGameVehicle, enabled = false})
  local function update()
    if not gameStatus.simulationPaused and playerTask.specialName == "Display timer" and displayTimer then
      feedbackSystem.stepTimer(timer)
      timer.updateStartTime = false
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Use oncoming reminder" and conditionKey == 1 then
      local promptParams = {
        prompt = "ID:243639",
        delay = false,
        priority = 3
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
    elseif task.specialName == "Display timer" then
      displayTimer = true
      startCount = propSystem.getNumberRemainingProps("bad medicine")
      addUserUpdateFunction("propWatch", smashBoxWatch, 60)
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "first prompt" then
        local promptParams = {
          prompt = "ID:245545",
          delay = false,
          priority = 1
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
      elseif task.specialName == "Soft save" then
        feedbackSystem.menusMaster.setCurrentFocusString(1)
        feedbackSystem.removeSlot(1)
      elseif task.specialName == "Allow time update" then
        task.instance.allowBonusDisplay = true
      elseif task.specialName == "Trucks text prompt 1" then
        local promptParams = {
          prompt = "ID:184883",
          delay = false,
          priority = 1
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
      elseif task.specialName == "Trucks text prompt 2" then
        local promptParams2 = {
          prompt = "ID:235452",
          delay = false,
          priority = 1
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(promptParams2)
      elseif task.specialName == "Chase convoy" then
        propHUD.value = 100
        feedbackSystem.updateProgressBar(propHUD)
      elseif task.specialName == "Display trucks counter" then
        propHUD.value = 0
        feedbackSystem.updateProgressBar(propHUD)
      elseif task.specialName == "Mission part 2 - First text prompt" then
        local removeSecondaryPrompt = function()
          feedbackSystem.menusMaster.clearSecondaryTextPrompt()
        end
        local promptParams = {
          prompt = "ID:245546",
          delay = false,
          priority = 1,
          endCallback = removeSecondaryPrompt
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(promptParams)
      elseif task.specialName == "Mission part 2 - Second text prompt" then
        local promptParams = {
          prompt = "ID:245295",
          delay = false,
          priority = 1
        }
        feedbackSystem.menusMaster.secondaryTextPromptParam(promptParams)
      end
    elseif task.specialName == "Convoy race" then
      local numWrecked = 0
      local modifier = 33
      for k, v in next, task.instance.taskObjectsByActorID, nil do
        if v.coreData.actor.team == "Race team" and 1 <= v.coreData.agent.gameVehicle.damage then
          numWrecked = numWrecked + 1
        end
      end
      propHUD.value = numWrecked * modifier
      feedbackSystem.updateProgressBar(propHUD)
    end
  end
  return update, goalComplete, taskComplete, nil
end)
