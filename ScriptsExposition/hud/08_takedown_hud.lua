local felonyTutorialDisplayed = false
local tutorialTriggered = true
feedbackSystem.registerHUD("Takedown HUD", function(task, settings)
end, function(task, settings)
  local evaderHealth = {
    slot = 1,
    title = "ID:178478",
    value = -1
  }
  local previousTime
  local radiusFlashTime = 0.3
  local function update()
    if not gameStatus.simulationPaused and task.specialName == "Meat" and localPlayer.primaryFelony.getawayGameVehicle then
      evaderHealth.value = localPlayer.primaryFelony.getawayGameVehicle.damage
      feedbackSystem.updateHealthBar(evaderHealth)
    end
  end
  local function taskComplete()
    if task.specialName == "Is player controlled" then
      localPlayer:blockAbility("zap", false)
      feedbackSystem.menusMaster.primaryTextPrompt("ID:178462", false, false, false, false)
      feedbackSystem.menusMaster.currentHUDSetVariable("iMinimap_flash", 0)
    elseif task.specialName == "Tutorial trigger" then
      if not felonyTutorialDisplayed then
        CutsceneFiles.Exposition.felonyTutorial()
        felonyTutorialDisplayed = true
        tutorialTriggered = true
      end
    elseif task.specialName == "Evader" and task.condition == 2 then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243496", false, false, false, false)
    end
  end
  return update, nil, taskComplete, nil
end)
