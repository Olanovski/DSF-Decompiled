challengeSystem.registerStartup("Closest actor positions", {staticPosition = true, fixedSpawning = true}, function(instance, settings)
  local hostActor = instance.actorsByVehicleID[instance.host.uid]
  local positionLists = settings.positionLists
  local closestDistance = math.huge
  local closestPositionList
  for i, actorPositions in ipairs(positionLists) do
    local distance = instance.host.position - actorPositions[hostActor.ID].position:length()
    if closestDistance > distance then
      closestDistance = distance
      closestPositionList = i
    end
  end
  instance.networkVars.startupKey = closestPositionList
end)
