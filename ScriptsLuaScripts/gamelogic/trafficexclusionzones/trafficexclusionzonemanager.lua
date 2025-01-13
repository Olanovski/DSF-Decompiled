module("trafficExclusionZone", package.seeall)
local trafficExclusionZones = {}
local look = vec.vector(0, 0, 1, 1)
local up = vec.vector(0, 1, 0, 1)
function addTrafficExclusionZoneTrigger(volume)
  if DEBUGDrawTrafficNoMansLand then
    Network.displayTrafficNoMansLand(1)
  end
  local triggerZoneID = Network.createTrafficNoMansLandTrigger(volume.position, look, up, volume.length, volume.width)
  assert(not trafficExclusionZones[triggerZoneID], "TRAFFIC EXCLUSION ZONE - Traffic trigger zone already in list!")
  trafficExclusionZones[triggerZoneID] = {}
  return triggerZoneID
end
function addTrafficExclusionZone(volume, triggerZoneID)
  print("================================= addTrafficExclusionZone")
  local exclusionZoneID = Network.createTrafficNoMansLand(volume.position, look, up, volume.length, volume.width, triggerZoneID, -1)
  trafficExclusionZones[triggerZoneID][exclusionZoneID] = exclusionZoneID
  return exclusionZoneID
end
function removeTrafficExclusionZone(exclusionZoneID, triggerZoneID)
  print("================================= removeTrafficExclusionZone")
  trafficExclusionZones[triggerZoneID][exclusionZoneID] = nil
  Network.deleteTrafficNoMansLand(exclusionZoneID)
end
function release()
  print("================================= release")
  for triggerVolumeID, exclusionZones in next, trafficExclusionZones, nil do
    for exclusionZoneID, unused in next, exclusionZones, nil do
      Network.deleteTrafficNoMansLand(exclusionZoneID)
    end
    Network.deleteTrafficNoMansLandTrigger(triggerVolumeID)
  end
  trafficExclusionZones = {}
end
function triggerZoneTriggered(triggerZoneID)
  print("================================= triggerZoneTriggered")
  assert(trafficExclusionZones[triggerZoneID], "TRIGGER ZONE TRIGGERED - Trigger zone is not known by script!")
  for exclusionZoneID, unused in next, trafficExclusionZones[triggerZoneID], nil do
    Network.deleteTrafficNoMansLand(exclusionZoneID)
  end
  Network.deleteTrafficNoMansLandTrigger(triggerZoneID)
  trafficExclusionZones[triggerZoneID] = nil
end
_G.triggerZoneTriggered = triggerZoneTriggered
