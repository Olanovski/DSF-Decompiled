module("abilities", package.seeall)
thrillCam = {}
local active = false
function thrillCam.setLevel(level)
  active = level and 1
  insertCameraMode("ThrillCam", 0)
  thrillCam.enable()
end
function thrillCam.getActiveLevel()
  return active
end
function thrillCam.enable()
  if thrillCam.getActiveLevel() and not localPlayer:getTaskObject() then
    blockCameraMode("ThrillCam", 0, false)
  end
end
function thrillCam.disable()
  blockCameraMode("ThrillCam", 0, true)
end
