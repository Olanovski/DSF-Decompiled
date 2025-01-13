challengeSystem.registerStartup("Closest route", {staticPosition = false, radius = 200}, function(instance, settings)
  local routes = settings.routes
  local closestDistance = math.huge
  local closestRoute
  for i, route in ipairs(routes) do
    local distance = instance.host.position - route[1].position:length()
    if closestDistance > distance then
      closestDistance = distance
      closestRoute = i
    end
  end
  instance.networkVars.startupKey = closestRoute
end)
