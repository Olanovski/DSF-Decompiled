feedbackSystem.registerHUD("Peroxide convoy HUD", function(task, settings)
end, function(task, settings)
  local tanker1, tanker2, tanker3
  if settings.hud1 then
    feedbackSystem.removeSlot(2)
    feedbackSystem.removeSlot(3)
  elseif settings.hud2 then
    tanker1 = {
      slot = 1,
      value = 0,
      title = "ID:184645"
    }
    feedbackSystem.updateHealthBar(tanker1)
  elseif settings.hud3 then
    tanker2 = {
      slot = 1,
      value = 0,
      title = "ID:184646"
    }
    tanker3 = {
      slot = 2,
      value = 0,
      title = "ID:184647"
    }
    if task.instance.taskObjectsByActorID.Convoy2 then
      feedbackSystem.updateHealthBar(tanker2)
    else
      feedbackSystem.removeSlot(1)
    end
    if task.instance.taskObjectsByActorID.Convoy3 then
      feedbackSystem.updateHealthBar(tanker3)
    else
      feedbackSystem.removeSlot(2)
    end
  end
  local function update()
    if tanker1 then
      if task.instance.taskObjectsByActorID.Convoy1 then
        if tanker1.value ~= task.instance.taskObjectsByActorID.Convoy1.coreData.agent.damage then
          tanker1.value = task.instance.taskObjectsByActorID.Convoy1.coreData.agent.damage
          feedbackSystem.updateHealthBar(tanker1)
        end
      else
        feedbackSystem.removeSlot(1)
        tanker1 = nil
      end
    elseif tanker2 or tanker3 then
      if task.instance.taskObjectsByActorID.Convoy2 then
        tanker3.slot = 2
        if tanker2.value ~= task.instance.taskObjectsByActorID.Convoy2.coreData.agent.damage then
          tanker2.value = task.instance.taskObjectsByActorID.Convoy2.coreData.agent.damage
          feedbackSystem.updateHealthBar(tanker2)
        end
      else
        tanker3.slot = 1
        feedbackSystem.removeSlot(2)
        feedbackSystem.updateHealthBar(tanker3)
        tanker2 = nil
        tanker3 = nil
      end
      if task.instance.taskObjectsByActorID.Convoy3 and tanker3.value ~= task.instance.taskObjectsByActorID.Convoy3.coreData.agent.damage then
        tanker3.value = task.instance.taskObjectsByActorID.Convoy3.coreData.agent.damage
        feedbackSystem.updateHealthBar(tanker3)
      end
    end
  end
  local secondaryPrompt = function()
    feedbackSystem.menusMaster.secondaryTextPromptParam({prompt = "ID:243491", priority = 2})
    removeUserUpdateFunction("secondaryPrompt")
  end
  local function goalComplete(conditionKey)
    if task.specialName == "highlight target 2" or task.specialName == "highlight target 1" or task.specialName == "highlight target 3" then
      if conditionKey == 1 then
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:245315", value = 2500})
      elseif conditionKey == 2 then
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:245315", value = 1500})
      elseif conditionKey == 3 then
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:245315", value = 1000})
        addUserUpdateFunction("secondaryPrompt", secondaryPrompt, 240, true)
      else
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:245323", priority = 3})
      end
    elseif (task.specialName == "oncoming prompt" or task.specialName == "oncoming prompt 2" or task.specialName == "first stage - oncoming prompt") and conditionKey == 1 then
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:245323", priority = 3})
    elseif task.specialName == "Wait for prompt" then
      if conditionKey == 1 then
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:184640", priority = 1})
        feedbackSystem.menusMaster.blockHintButton(false)
        feedbackSystem.menusMaster.setCurrentFocusString(3)
      elseif conditionKey == 2 then
        feedbackSystem.menusMaster.secondaryTextPromptParam({prompt = "ID:246473", priority = 2})
      elseif conditionKey == 3 then
        feedbackSystem.menusMaster.clearSecondaryTextPrompt()
      end
    end
  end
  local function taskComplete()
    if task.specialName ~= "oncoming prompt" and task.specialName ~= "oncoming prompt 2" and task.specialName ~= "first stage - oncoming prompt" then
      feedbackSystem.removeSlot(1)
      feedbackSystem.removeSlot(2)
    end
  end
  return update, goalComplete, taskComplete
end)
