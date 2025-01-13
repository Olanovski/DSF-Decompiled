module("abilities", package.seeall)
ZapSpawn = {}
local active = false
function ZapSpawn.setLevel(level)
  active = level and 1
end
function ZapSpawn.getLevel()
  return active
end
