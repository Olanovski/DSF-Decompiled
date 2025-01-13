challengeSystem.registerShutDown("Fixed time", {duration = 20}, function(instance, settings)
  return function()
    if g_NetworkTime - instance.networkVars.overTime > settings.duration then
      return true
    end
    return false
  end
end)
