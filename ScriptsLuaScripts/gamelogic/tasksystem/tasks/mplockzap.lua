taskSystem.registerTask("MP Lock Zap", {
  {
    name = "playerZapLocked",
    startingValue = false,
    parseType = "boolean"
  }
}, function(task)
  local function goalCallback(success, condition, missionData, goalData)
    if success then
      localPlayer:blockAbility("zap", false)
      task.networkVars.playerZapLocked = false
      scoreSystem.setZapBlocked(localPlayer.localID, false)
    else
      localPlayer:blockAbility("zap", true)
      task.networkVars.playerZapLocked = true
      scoreSystem.setZapBlocked(localPlayer.localID, true)
    end
  end
  local cleanup = function()
    localPlayer:blockAbility("zap", false)
    scoreSystem.setZapBlocked(localPlayer.localID, false)
  end
  return goalCallback, nil, cleanup
end)
