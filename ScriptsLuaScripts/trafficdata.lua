trafficData = {}
if configSelector.launchConfig.RoadSettingsData then
  open(configSelector.launchConfig.RoadSettingsData)
end
if configSelector.launchConfig.TrafficLightSettings then
  open(configSelector.launchConfig.TrafficLightSettings)
end
function trafficData:setIndexedRoad(roadIndex, inputParameters)
  local trafficParameters
  if type(inputParameters) == "userdata" then
    trafficParameters = inputParameters
  end
  if trafficParameters then
    atlas.road[roadIndex].trafficParameters = trafficParameters
  end
end
function trafficData:setAllRoads(inputParameters)
  for i, road in next, atlas.road, nil do
    self:setIndexedRoad(road.thisRoadIndex, inputParameters)
  end
end
function trafficData:setRoadByName(inputParameters, roadName)
  for i, road in next, atlas.road, nil do
    if road.name == roadName then
      self:setIndexedRoad(road.thisRoadIndex, inputParameters)
      print("Set road data for " .. tostring(roadName))
    end
  end
end
function trafficData:setAllRoadsViaNumberOfLanes(dataTable)
  local densityData, lanes, laneDensity
  for atlasIndex, atlasRoad in next, atlas.road, nil do
    lanes = 0
    for k, v in next, atlasRoad.drivingLane.with, nil do
      lanes = lanes + 1
    end
    laneDensity = dataTable[lanes] or "clear"
  end
end
function trafficData:setRoadsViaAtlasNumber(dataTable)
  local densityData, lanes
  for atlasIndex, density in next, dataTable, nil do
    lanes = 0
    for k, v in next, atlas.road[atlasIndex].drivingLane.with, nil do
      lanes = lanes + 1
    end
    if lanes == 0 then
      lanes = 1
    end
    self:setIndexedRoad(atlasIndex, densityData)
  end
end
function trafficData:setRoadViaClosestPosition(position, inputParameters)
  local closestRoad = atlas.closestRoad({position = position})
  self:setIndexedRoad(closestRoad.thisRoadIndex, inputParameters)
end
function trafficData.dumpTrafficData(userData)
  local fields = {
    "isOn",
    "numLanes",
    "closestTailgateDistance",
    "pingInProbabilityWith",
    "pingInProbabilityAgainst",
    "blockPingInProbabilityWith",
    "blockPingInProbabilityAgainst",
    "halfLaneWidth",
    "useableLaneDistanceWith",
    "useableLaneDistanceAgainst",
    "laneChangeBreatherSpaceWith",
    "laneChangeBreatherSpaceAgainst",
    "trafficSpeedWith",
    "trafficSpeedAgainst",
    "minLongOscillationPeriod",
    "longOscillationPeriodRange",
    "minLatOscillationPeriod",
    "latOscillationPeriodRange",
    "minLongOscillationAmplitude",
    "longOscillationAmplitudeRange",
    "minLatOscillationAmplitude",
    "latOscillationAmplitudeRange",
    "zeroLatOscillationDampingDist",
    "zeroLongOscillationDampingDist",
    "pingInRadius",
    "pingOutRadius",
    "civMoveDistanceToTriggerPingUpdate",
    "laneChangingProbability",
    "laneChangeStartTriggerDistanceWith",
    "laneChangeCompleteTriggerDistanceWith",
    "laneChangeStartTriggerDistanceAgainst",
    "laneChangeCompleteTriggerDistanceAgainst",
    "doubleLaneChangeStartTriggerDistanceWith",
    "doubleLaneChangeCompleteTriggerDistanceWith",
    "doubleLaneChangeStartTriggerDistanceAgainst",
    "doubleLaneChangeCompleteTriggerDistanceAgainst",
    "doubleLaneChangeProbability",
    "bigVehicleHeightThreshold",
    "bigVehicleLengthThreshold",
    "bigVehicleProbability",
    "playerRepulsionStrengthWith",
    "playerRepulsionStrengthAgainst",
    "fakeJunctionTriggerETAWith",
    "fakeJunctionTriggerETAAgainst",
    "fakeJunctionsOn",
    "triggerSpeed"
  }
  print("****** Beginning dump ******")
  for k, v in next, fields, nil do
    print(v .. " = " .. userData[v])
  end
  print("****** End dump ******")
end
