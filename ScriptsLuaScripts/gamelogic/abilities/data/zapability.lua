module("abilities", package.seeall)
local zapModule = package.loaded.zap
zap = {}
local active = false
function zap.setLevel(level)
  active = level and 1
  zapModule.setZapRadiusLevel(active)
end
function zap.getLevel()
  return active
end
