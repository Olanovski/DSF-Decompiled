feedbackSystem.registerHUD("Smash tv hud", function(task, settings)
end, function(task, settings)
  local prevEnemyHealth = -1
  local enemyHealthTable = {
    slot = 1,
    value = 0,
    title = "ID:242000"
  }
  local function update()
    if task.agent:getTaskObject().coreData.instance.taskObjectsByActorID.Truck and task.specialName == "Chase" then
      local currentEnemyHealth = task.agent:getTaskObject().coreData.instance.taskObjectsByActorID.Truck.coreData.agent.damage
      if prevEnemyHealth ~= currentEnemyHealth then
        enemyHealthTable.value = currentEnemyHealth
        feedbackSystem.updateHealthBar(enemyHealthTable)
        prevEnemyHealth = currentEnemyHealth
      end
    end
  end
  local goalComplete = function()
  end
  local function taskComplete()
    if task.specialName == "Instructions" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245549", false, true, false, false)
    elseif task.specialName == "Instructions Chase" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184478", false, false, false, false)
    elseif task.specialName == "Player has lost cops" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184477", false, false, false, false)
    elseif task.specialName == "Player has lost cops second part" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184478", false, false, false, false)
    elseif task.specialName == "Out of truck prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:248739", false, false, false, false)
    end
  end
  local cleanup = function()
  end
  return update, goalComplete, taskComplete, cleanup
end)
