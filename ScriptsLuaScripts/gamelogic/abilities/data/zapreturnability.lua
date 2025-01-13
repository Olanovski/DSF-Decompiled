module("abilities", package.seeall)
zapReturn = {}
local active = false
function zapReturn.setLevel(level)
  active = level and 1
end
function zapReturn.getLevel()
  return abilities.abilitiesEnabled and active
end
