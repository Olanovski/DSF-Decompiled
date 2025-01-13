module("abilities", package.seeall)
zapAttack = {}
local active = false
function zapAttack.setLevel(level)
  active = level and 1
end
function zapAttack.getLevel()
  return active
end
