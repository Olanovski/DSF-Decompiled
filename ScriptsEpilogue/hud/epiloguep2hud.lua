feedbackSystem.registerHUD("Epilogue pt 2 hud", nil, function(task, settings)
  local jerichoHealth = {
    slot = 1,
    title = "ID:214487",
    value = -1
  }
  feedbackSystem.updateHealthBar(jerichoHealth)
  local function update()
    if task.specialName == "Chase jericho" and not task.complete then
      jerichoHealth.value = task.instance.taskObjectsByActorID.Jericho.coreData.agent.damage
      feedbackSystem.updateHealthBar(jerichoHealth)
    end
  end
  return update, nil, nil
end)
