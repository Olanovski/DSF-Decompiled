module("abilities", package.seeall)
local zapModule = package.loaded.zap
aerialZap = {}
local active = false
local levels = {
  [0] = 3,
  [1] = 4,
  [2] = 5
}
function aerialZap.setLevel(level)
  if levels[level] then
    active = levels[level]
    zapModule.setZapRadiusLevel(active)
  end
end
function aerialZap.getLevel()
  return active
end
