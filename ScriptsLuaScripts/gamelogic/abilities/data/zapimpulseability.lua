module("abilities", package.seeall)
ZapImpulse = {}
local active = false
function ZapImpulse.setLevel(level)
  active = level and 1
end
function ZapImpulse.getLevel()
  return active
end
