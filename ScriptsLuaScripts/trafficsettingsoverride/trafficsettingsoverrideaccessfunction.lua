function GetTrafficSettingsOverrideValue(progressionIndex, laneTrackCRC, parameterName)
  if LaneTrackData and LaneTrackData[progressionIndex] and LaneTrackData[progressionIndex][laneTrackCRC] then
    return LaneTrackData[progressionIndex][laneTrackCRC][parameterName]
  else
    return nil
  end
end
function GetTrafficLaneSpeedOverrideValue(progressionIndex, roadName, laneIndex)
  if RoadSpeedData and RoadSpeedData[progressionIndex] and RoadSpeedData[progressionIndex][roadName] and RoadSpeedData[progressionIndex][roadName][laneIndex] then
    return RoadSpeedData[progressionIndex][roadName][laneIndex]
  else
    return nil
  end
end
