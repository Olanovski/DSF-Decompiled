feedbackSystem.registerHUD("Kill Tanner HUD", nil, function(task, settings)
  local timer, carDamage, checkpointTimer
  if task.specialName == "Drive route" then
    checkpointTimer = {
      30,
      40,
      25,
      25,
      30,
      25,
      30
    }
    timer = {
      slot = 1,
      startTime = checkpointTimer[task.networkVars.checkpoints],
      reset = false
    }
  end
  local function update()
    if task.specialName == "Audio pause at start" then
      carDamage = math.ceil(100 - task.instance.taskObjectsByActorID.Tanner2.coreData.agent.damage * 100)
      feedbackSystem.menusMaster.masterSetVariable("iCar_Damage", carDamage)
    elseif task.specialName == "Drive route" and task.networkVars.checkpoints > 1 then
      carDamage = math.ceil(100 - task.instance.taskObjectsByActorID.Tanner2.coreData.agent.damage * 100)
      feedbackSystem.menusMaster.masterSetVariable("iCar_Damage", carDamage)
      feedbackSystem.stepTimer(timer)
    end
  end
  local function goalComplete()
    if task.specialName == "Drive route" then
      timer.startTime = checkpointTimer[task.networkVars.checkpoints]
      timer.reset = true
      feedbackSystem.stepTimer(timer)
      timer.reset = false
    end
  end
  local function taskComplete()
    if task.specialName == "Init audio" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:186324", nil, false, false, false)
    elseif task.specialName == "Cutscene" then
      feedbackSystem.menusMaster.setNextFocusString()
    elseif task.specialName == "Ordell audio played" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245552", nil, false, false, false)
      feedbackSystem.menusMaster.setNextFocusString()
    elseif task.specialName == "Audio pause at start" then
      feedbackSystem.menusMaster.setNextFocusString()
      if not localPlayer.challenge.retryingMission then
        CutsceneFiles.tutorials.playTutorial("ID:186314")
      end
    elseif task.specialName == "Drive route - timer start" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:235441", nil, false, false, false)
      feedbackSystem.menusMaster.setNextFocusString()
    elseif task.specialName == "Get to tanner" then
      feedbackSystem.removeSlot(1)
      feedbackSystem.menusMaster.blockHintButton(true)
    elseif task.specialName == "Drive route - timer start 2" then
      task.instance.timeLimit = 30
      task.instance.softsaveStartTime = g_NetworkTime - 3
    end
  end
  local function cleanup()
    if task.specialName == "Drive route" then
      feedbackSystem.removeSlot(1)
    end
  end
  return update, goalComplete, taskComplete, cleanup
end)
