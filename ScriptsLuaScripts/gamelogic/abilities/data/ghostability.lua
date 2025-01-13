module("abilities", package.seeall)
ghost = {}
function ghost.applySettings()
  local settings = {}
  settings.highlightColour = vec.vector(0.6, 0.6, 1, 0)
  settings.fadeColour = vec.vector(20, 20, 20, 1)
  settings.vanishingPoint = 0.5
  settings.reappearingDistance = 10
  settings.fadeTimes = vec.vector(30, 5, 1, 0)
  GhostCar.Settings(settings)
end
function ghost.abilityFunction()
  ghost.applySettings()
  GhostCar.Start()
end
function ghost.stopAbilityFunction()
  GhostCar.Stop()
end
