challengeSystem.registerStartup("Closest fixed position", {
  staticPosition = true,
  sameRoad = true,
  radius = 200
}, function(instance, settings)
  local positionList = settings.positionList
  local closestDistance = math.huge
  local closestPosition
  for i, position in ipairs(positionList) do
    local distance = instance.host.position - position:length()
    if closestDistance > distance then
      closestDistance = distance
      closestPosition = position
    end
  end
  instance.position = closestPosition
end)
