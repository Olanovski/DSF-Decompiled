feedbackSystem.registerHUD("Final fight hud", function(task, settings)
end, function(task, settings)
  local jerichoHealth = {
    slot = 1,
    value = -1,
    title = "ID:214343"
  }
  local previousHealth
  local prompts = {
    ["Chase jericho"] = "ID:184960"
  }
  local showText = function(text, constant)
    feedbackSystem.menusMaster.primaryTextPrompt(text, false, false, false, false)
  end
  local function update()
    if not gameStatus.simulationPaused and task.specialName == "chase jericho" and not task.complete and localPlayer.primaryFelony and localPlayer.primaryFelony.getawayGameVehicle and previousHealth ~= localPlayer.primaryFelony.getawayGameVehicle.damage then
      jerichoHealth.value = localPlayer.primaryFelony.getawayGameVehicle.damage
      previousHealth = jerichoHealth.value
      feedbackSystem.updateHealthBar(jerichoHealth)
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Objective prompt & initial speech sample" then
      showText(prompts["Chase jericho"])
    end
  end
  local function taskComplete()
    if task.specialName == "chase jericho" then
      feedbackSystem.removeSlot(1)
    end
  end
  return update, goalComplete, taskComplete, nil
end)
