module("abilities", package.seeall)
collectableDetection = {}
local active = false
collectableDetection.settings = {
  [0] = 250,
  [1] = 500,
  [2] = math.huge
}
function collectableDetection.setLevel(level)
  if collectableDetection.settings[level] then
    active = collectableDetection.settings[level]
    collectables.setAbilityRadius(collectableDetection.settings[level])
  end
end
function collectableDetection.getLevel()
  return active
end
