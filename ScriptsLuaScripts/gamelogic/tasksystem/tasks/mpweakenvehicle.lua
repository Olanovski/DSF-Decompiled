taskSystem.registerTask("MP Weaken Vehicle", nil, function(task)
  local function goalCallback(success, condition, missionData, goalData)
    if task.agent.currentVehicle then
      task.agent.currentVehicle:set_damageMultiplier(task.instance.challenge.settings.damageMultiplier[onlineRaceManager.getPlayerRank(localPlayer.playerID)])
    end
  end
  return goalCallback, nil, nil
end)
