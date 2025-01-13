taskSystem.registerTask("Restrict Player 1 Zap", nil, function(task)
  local goalCallback = function(success, condition, missionData, goalData)
    if success then
      localPlayerManager.players[0]:blockAbility("zap", true)
      scoreSystem.setZapBlocked(0, true)
    else
      localPlayerManager.players[0]:blockAbility("zap", false)
      scoreSystem.setZapBlocked(0, false)
    end
  end
  local cleanup = function()
    localPlayerManager.players[0]:blockAbility("zap", false)
    scoreSystem.setZapBlocked(0, false)
  end
  return goalCallback, AIUpdate, cleanup
end)
taskSystem.registerTask("Restrict Player 2 Zap", nil, function(task)
  local goalCallback = function(success, condition, missionData, goalData)
    if localPlayerManager.players[1] then
      if success then
        localPlayerManager.players[1]:blockAbility("zap", true)
        scoreSystem.setZapBlocked(1, true)
      else
        localPlayerManager.players[1]:blockAbility("zap", false)
        scoreSystem.setZapBlocked(1, false)
      end
    end
  end
  local cleanup = function()
    if localPlayerManager.players[1] then
      localPlayerManager.players[1]:blockAbility("zap", false)
      scoreSystem.setZapBlocked(1, false)
    end
  end
  return goalCallback, AIUpdate, cleanup
end)
