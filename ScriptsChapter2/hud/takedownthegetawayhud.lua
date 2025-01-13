feedbackSystem.registerHUD("Takedown the getwaway hud", function(task, settings)
end, function(task, settings)
  local health = {
    slot = 1,
    value = 100,
    title = "ID:184445"
  }
  local previousHealth
  local function update()
    if localPlayer.primaryFelony and localPlayer.primaryFelony.getawayGameVehicle and previousHealth ~= localPlayer.primaryFelony.getawayGameVehicle.damage then
      health.value = localPlayer.primaryFelony.getawayGameVehicle.damage
      previousHealth = health.value
      feedbackSystem.updateHealthBar(health)
    end
  end
  local cleanup = function()
    feedbackSystem.menusMaster.clearMinimapTextPrompt()
  end
  return update, nil, nil, cleanup
end)
