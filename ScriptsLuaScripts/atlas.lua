local Start = "Start"
local End = "End"
function getVectorRoadAngleAtPosition(roadIndex, distanceAlong)
  return Atlas.RoadTransformationAtDistanceAlongAndDistanceAcross(roadIndex, distanceAlong, 0)[2]
end
function getScalarRoadAngleAtPosition(roadIndex, distanceAlong)
  local angleVector = getVectorRoadAngleAtPosition(roadIndex, distanceAlong)
  return math.atan2(angleVector.x, angleVector.z)
end
local function _findEndVehicleHeadingTo()
  local vehicleHeading = vec.vector()
  local roadHeading = vec.vector()
  return function(vehicle)
    vehicle.matrix:getColumn(2, vehicleHeading)
    vehicle:get_closestTransformationOnRoad():getColumn(2, roadHeading)
    local angleDifference = vehicleHeading:dot(roadHeading)
    local headingTo = End
    if angleDifference < 0 then
      headingTo = Start
    end
    return headingTo
  end
end
findEndVehicleHeadingTo = _findEndVehicleHeadingTo()
function findVehicleRoadIndexAndEndHeadingTo(vehicle)
  return vehicle:get_closestRoadIndex(), findEndVehicleHeadingTo(vehicle), vehicle:get_closestDistanceAlongRoad()
end
local diffVec = vec.vector()
local function populateRoads(startPos, idealDistance, ignoreHighway, previous, roads)
  local connectedRoads = Atlas.TableOfExitsAtExtremityOfRoadIndex(previous.roadIndex, previous.roadEnd)
  for i, roadData in next, connectedRoads, nil do
    if not roads[roadData.roadIndex] and (not ignoreHighway or not Atlas.IsRoadAHighway(roadData.roadIndex) and not Atlas.IsRoadAnAlleyway(roadData.roadIndex)) then
      local roadPos = Atlas.RoadPositionAtDistanceAlong(roadData.roadIndex, Atlas.RoadLength(roadData.roadIndex) * 0.5)
      local length = math.abs(idealDistance - diffVec:sub(startPos, roadPos):length())
      if length < previous.length then
        local roadEnd = "Start"
        for a, b in next, Atlas.TableOfExitsAtExtremityOfRoadIndex(roadData.roadIndex, "Start") do
          if b.roadIndex == previous.roadIndex then
            roadEnd = "End"
            break
          end
        end
        local newRoad = {
          roadIndex = roadData.roadIndex,
          roadEnd = roadEnd,
          length = length
        }
        roads[roadData.roadIndex] = newRoad
        populateRoads(startPos, idealDistance, ignoreHighway, newRoad, roads)
      else
        roads[roadData.roadIndex] = true
      end
    end
  end
end
function getConnectedRoadAtDistance(vehicle, idealDistance, ignoreHighway, previousRoadIndexA, previousRoadIndexB)
  local startRoadIndex, startRoadEnd = findVehicleRoadIndexAndEndHeadingTo(vehicle)
  local startRoadData = {
    roadIndex = startRoadIndex,
    roadEnd = startRoadEnd,
    length = idealDistance
  }
  local roads = {
    [startRoadIndex] = true
  }
  if Atlas.IsRoadAHighway(startRoadIndex) then
    ignoreHighway = false
  end
  if previousRoadIndexA then
    roads[previousRoadIndexA] = true
  end
  if previousRoadIndexB then
    roads[previousRoadIndexB] = true
  end
  populateRoads(vehicle.position, idealDistance, ignoreHighway, startRoadData, roads)
  local bestRoadIndex
  local bestRoadLength = math.huge
  for roadIndex, roadData in next, roads, nil do
    if roadData ~= true and bestRoadLength > roadData.length then
      bestRoadLength = roadData.length
      bestRoadIndex = roadIndex
    end
  end
  if bestRoadIndex then
    return roads[bestRoadIndex].roadIndex
  else
    local connectedRoads = Atlas.TableOfExitsAtExtremityOfRoadIndex(startRoadIndex, startRoadEnd)
    return connectedRoads[0].roadIndex
  end
end
function createFixedPosition(instance, tableOfPositions, groupID)
  checkpointSystem.createNoneSyncronisedCheckpoint(instance.instanceID, groupID, tableOfPositions[1])
  return true
end
function createManualCheckpoints(instance, tableOfPositions, groupID)
  for index, checkpoint in ipairs(tableOfPositions) do
    checkpointSystem.createNoneSyncronisedCheckpoint(instance.instanceID, groupID, checkpoint)
  end
  return true
end
function getConnectedRoadDirectionsIntoJunction(vehicle, behind)
  local directionIntoJunction = {}
  local instanceRoadIndex, instanceEndHeadingTo = findVehicleRoadIndexAndEndHeadingTo(vehicle)
  local instanceEnd = instanceEndHeadingTo
  if behind then
    if instanceEndHeadingTo == "Start" then
      instanceEnd = "End"
      directionIntoJunction[instanceRoadIndex] = "against"
    else
      instanceEnd = "Start"
      directionIntoJunction[instanceRoadIndex] = "with"
    end
  elseif instanceEndHeadingTo == "Start" then
    directionIntoJunction[instanceRoadIndex] = "with"
  else
    directionIntoJunction[instanceRoadIndex] = "against"
  end
  for connection, road in next, Atlas.TableOfExitsAtExtremityOfRoadIndex(instanceRoadIndex, instanceEnd) do
    if road.extremity == "Start" then
      directionIntoJunction[road.roadIndex] = "against"
    else
      directionIntoJunction[road.roadIndex] = "with"
    end
  end
  return directionIntoJunction
end
function isVehicleOnJunction(vehicle)
  local distanceAlongRoad = vehicle:get_closestDistanceAlongRoad()
  return distanceAlongRoad <= 0.1 or distanceAlongRoad >= Atlas.RoadLength(vehicle:get_closestRoadIndex()) - 0.1
end
function getRoadsOnJunction(vehicle)
  if isVehicleOnJunction(vehicle) then
    local roads = {}
    local temp = {}
    temp = Atlas.TableOfExitsAtExtremityOfRoadIndex(vehicle:get_closestRoadIndex(), vehicle:get_closestJunctionClosestRoadExtremity())
    for k, v in next, temp, nil do
      table.insert(roads, 1, v.roadIndex)
    end
    table.insert(roads, 1, closestRoadIndex)
    return roads
  end
  return nil
end
