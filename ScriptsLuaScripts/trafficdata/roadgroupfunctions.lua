local blankTable = {
  {}
}
function trafficParameterChooser(roadName, direction)
  return blankTable
end
function trafficParameterChooserByGroup(roadGroup)
  return blankTable
end
function trafficPatternChooser(lanes, roadName, direction)
  return blankTable
end
function trafficPatternChooserByGroup(lanes, roadGroup)
  return blankTable
end
function trafficPatternChooserByName(lanes, patternName)
  return blankTable
end
function trafficPatternOverride(roadName, direction)
  return nil
end
function trafficPatternChooserOverride(roadName, laneDirection, laneIndex)
  return nil
end
function trafficFlowRateChooserOverride(roadName, laneDirection, laneIndex)
  return nil
end
function trafficProbabilityChooserOverride(roadName, laneDirection, laneIndex)
  return nil
end
function trafficProbabilityChooserByName(probabilityName)
  return nil
end
