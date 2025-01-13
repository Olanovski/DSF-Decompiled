local timer = {slot = 1, startTime = 0}
local racersBar = {
  slot = 2,
  barIcon = "smash",
  barTitle = "ID:243489",
  value = 0,
  numericValue = 0
}
feedbackSystem.registerHUD("Bad medicine 2 hud", function(task, settings)
end, function(task, settings)
  local pointsParams, startCount
  local boxTimeBonus = 3
  local leftAttached, attatchedToVehicle, currentSmashed
  local previousCurrentSmashed = 0
  local playerActorID = "Attacker1 (Actor)"
  local previousCurrentValue = false
  local hideTimer = false
  local propsGroups, totalPropsRemaining
  local function smashBoxWatch(propsGroupToCount)
    leftAttached = 0
    totalPropsRemaining = 0
    for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
      if actorID ~= playerActorID then
        attatchedToVehicle = PropSystem.GetEffectiveNoOfAttachedProps({
          vehicle = taskObject.coreData.agent.gameVehicle
        })
        leftAttached = leftAttached + attatchedToVehicle
      end
    end
    for v, propsGroupName in next, propsGroupToCount, nil do
      totalPropsRemaining = totalPropsRemaining + propSystem.getNumberRemainingProps(propsGroupName)
    end
    currentSmashed = startCount - (totalPropsRemaining + leftAttached)
    if currentSmashed ~= previousCurrentValue then
      previousCurrentValue = currentSmashed
      if previousCurrentValue > 0 then
        pointsParams.pointsValue = (currentSmashed - previousCurrentSmashed) * boxTimeBonus
        feedbackSystem.updatePointsFeedback(pointsParams)
        task.instance.timeLimit = task.instance.timeLimit + (currentSmashed - previousCurrentSmashed) * boxTimeBonus
        previousCurrentSmashed = currentSmashed
        timer.updateStartTime = true
        timer.startTime = task.instance.timeLimit
      end
    end
  end
  if task.specialName == "Initial pause" then
    racersBar.value = 0
    racersBar.numericValue = 0
  elseif task.specialName == "Reach the first crates hotspot" then
    pointsParams = {pointsText = "ID:246669", pointsSlotPass = 1}
    timer.startTime = task.instance.timeLimit
    propsGroups = {
      "FeverPitchProps1"
    }
    startCount = propSystem.getNumberRemainingProps("FeverPitchProps1")
    addUserUpdateFunction("propWatch", function()
      smashBoxWatch(propsGroups)
    end, 60)
  elseif task.specialName == "Chase part 1" then
    pointsParams = {pointsText = "ID:246669", pointsSlotPass = 1}
    propsGroups = {
      "FeverPitchProps1",
      "FeverPitchProps2"
    }
    startCount = 0
    for v, propsGroupRemaining in next, propsGroups, nil do
      startCount = startCount + propSystem.getNumberRemainingProps(propsGroupRemaining)
    end
    for k, v in next, task.instance.taskObjectsByActorID, nil do
      startCount = startCount + PropSystem.GetEffectiveNoOfAttachedProps({
        vehicle = v.coreData.agent.gameVehicle
      })
    end
    addUserUpdateFunction("propWatch", function()
      smashBoxWatch(propsGroups)
    end, 60)
  elseif task.specialName == "Reach the third crates hotspot" then
    feedbackSystem.removeSlot(1)
    racersBar.slot = 2
    feedbackSystem.updateProgressBar(racersBar)
    pointsParams = {pointsText = "ID:246669", pointsSlotPass = 1}
    propsGroups = {
      "FeverPitchProps1",
      "FeverPitchProps2",
      "FeverPitchProps3"
    }
    startCount = 0
    for v, propsGroupRemaining in next, propsGroups, nil do
      startCount = startCount + propSystem.getNumberRemainingProps(propsGroupRemaining)
    end
    addUserUpdateFunction("propWatch", function()
      smashBoxWatch(propsGroups)
    end, 60)
    timer.startTime = 20
    task.instance.timeLimit = 20
  elseif task.specialName == "Reach the fourth crates hotspot" then
    pointsParams = {pointsText = "ID:246669", pointsSlotPass = 1}
    propsGroups = {
      "FeverPitchProps1",
      "FeverPitchProps2",
      "FeverPitchProps3",
      "FeverPitchProps4"
    }
    startCount = 0
    for v, propsGroupRemaining in next, propsGroups, nil do
      startCount = startCount + propSystem.getNumberRemainingProps(propsGroupRemaining)
    end
    addUserUpdateFunction("propWatch", function()
      smashBoxWatch(propsGroups)
    end, 60)
  elseif task.specialName == "Chase part 2" then
    pointsParams = {pointsText = "ID:246669", pointsSlotPass = 1}
    propsGroups = {
      "FeverPitchProps1",
      "FeverPitchProps2",
      "FeverPitchProps3",
      "FeverPitchProps4",
      "FeverPitchProps5"
    }
    startCount = 0
    for v, propsGroupRemaining in next, propsGroups, nil do
      startCount = startCount + propSystem.getNumberRemainingProps(propsGroupRemaining)
    end
    for k, v in next, task.instance.taskObjectsByActorID, nil do
      startCount = startCount + PropSystem.GetEffectiveNoOfAttachedProps({
        vehicle = v.coreData.agent.gameVehicle
      })
    end
    addUserUpdateFunction("propWatch", function()
      smashBoxWatch(propsGroups)
    end, 60)
  end
  local function update()
    if (task.specialName == "Reach the first crates hotspot" or task.specialName == "Chase part 1" or task.specialName == "Reach the third crates hotspot" or task.specialName == "Reach the fourth crates hotspot" or task.specialName == "Chase part 2") and not hideTimer then
      feedbackSystem.stepTimer(timer)
      timer.updateStartTime = false
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Chase part 1" or task.specialName == "Chase part 2" then
      feedbackSystem.removeSlot(1)
      feedbackSystem.removeSlot(2)
      racersBar.slot = 1
      racersBar.value = racersBar.value + 50
      racersBar.numericValue = racersBar.numericValue + 1
      feedbackSystem.updateProgressBar(racersBar)
      hideTimer = true
    end
  end
  local function taskComplete()
    if task.specialName == "First prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245545")
    elseif task.specialName == "Mission part 2 - First text prompt" then
      local removeSecondaryPrompt = function()
        feedbackSystem.menusMaster.clearSecondaryTextPrompt()
      end
      local promptParams = {
        prompt = "ID:247305",
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
    elseif task.specialName == "Reach the first crates hotspot" or task.specialName == "Chase part 1" or task.specialName == "Reach the third crates hotspot" then
      removeUserUpdateFunction("propWatch")
    elseif task.specialName == "Softsave 2" or task.specialName == "Softsave 3" then
      racersBar.value = 50
      racersBar.numericValue = 1
      feedbackSystem.updateProgressBar(racersBar)
    elseif task.specialName == "Reach the fourth crates hotspot" then
      removeUserUpdateFunction("propWatch")
    elseif task.specialName == "Chase part 2" then
      feedbackSystem.removeSlot(2)
      removeUserUpdateFunction("propWatch")
    elseif task.specialName == "Hold position" and task.success then
      local function afterFlyCam()
        task.instance.taskObjectsByActorID[task.actor.ID].coreData.agent.iconsVisible = true
        feedbackSystem.updateProgressBar(racersBar)
        feedbackSystem.menusMaster.setCurrentFocusString(3)
        feedbackSystem.menusMaster.primaryTextPrompt("ID:247309")
      end
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      iCamFlyToCam(task.agent.gameVehicle, afterFlyCam)
    end
  end
  return update, goalComplete, taskComplete, nil
end)
