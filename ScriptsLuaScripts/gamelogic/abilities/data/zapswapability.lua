module("abilities", package.seeall)
ZapSwap = {}
local active = false
function ZapSwap.setLevel(level)
  active = level and 1
end
function ZapSwap.getLevel()
  return active
end
