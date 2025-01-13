taskSystem.registerTask("Restrict Local Player Zap", nil, function(task)
  local goalCallback = function(success, condition, missionData, goalData)
    if success then
      localPlayer:blockAbility("zap", true)
      localPlayer:setWreckAutoZapEnabled(false)
      scoreSystem.setZapBlocked(localPlayer.localID, true)
      localPlayer:blockAbility("ZapSwap", true)
    else
      localPlayer:blockAbility("zap", false)
      localPlayer:setWreckAutoZapEnabled(true)
      scoreSystem.setZapBlocked(localPlayer.localID, false)
      localPlayer:blockAbility("ZapSwap", false)
    end
  end
  local cleanup = function()
    localPlayer:blockAbility("zap", false)
    localPlayer:setWreckAutoZapEnabled(true)
    scoreSystem.setZapBlocked(localPlayer.localID, false)
    localPlayer:blockAbility("ZapSwap", false)
  end
  return goalCallback, AIUpdate, cleanup
end)
