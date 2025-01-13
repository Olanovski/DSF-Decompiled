feedbackSystem.registerHUD("Collateral damage hud", function(task, settings)
end, function(task, settings)
  local jerichoCurrentHealth, previousHealth
  local instance = task.instance
  if task.specialName == "Felony chase" then
    jerichoCurrentHealth = {
      slot = 1,
      value = nil,
      title = "ID:214487"
    }
  end
  local function update()
    if task.specialName == "Felony chase" and localPlayer.primaryFelony and localPlayer.primaryFelony.getawayGameVehicle and previousHealth ~= localPlayer.primaryFelony.getawayGameVehicle.damage then
      jerichoCurrentHealth.value = localPlayer.primaryFelony.getawayGameVehicle.damage
      previousHealth = jerichoCurrentHealth.value
      feedbackSystem.updateHealthBar(jerichoCurrentHealth)
    end
  end
  local function goalComplete()
    if task.specialName == "Player too far from Tanner" then
      GameVehicleResource.applyDamage({
        gameVehicle = task.instance.taskObjectsByActorID["Tanner 2"].coreData.agent.gameVehicle,
        damage = 0.2
      })
    end
  end
  local cleanup = function()
    feedbackSystem.removeSlot(1)
  end
  return update, goalComplete, nil, cleanup
end)
