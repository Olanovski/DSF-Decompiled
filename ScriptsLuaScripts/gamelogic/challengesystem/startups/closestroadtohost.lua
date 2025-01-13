challengeSystem.registerStartup("Closest road to host", {
  staticPosition = true,
  sameRoad = true,
  radius = 200
}, function(instance)
  local roadIndex, distanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(instance.host.position)
  local roadLength = Atlas.RoadLength(roadIndex)
  if distanceAlong < 50 then
    distanceAlong = 50
  elseif distanceAlong > roadLength - 50 then
    distanceAlong = roadLength - 50
  end
  instance.position = Atlas.RoadPositionAtDistanceAlong(roadIndex, distanceAlong)
end)
