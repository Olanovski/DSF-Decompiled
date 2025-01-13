module("cardSystem", package.seeall)
missionSetupData = {}
missionEndCallback = {}
taskCompleteData = {}
formattedMissionData = {}
local proxy = function(t, k)
  return cardSystem[k] or rawget(t, k) or _G[k]
end
function createSubModule()
  module("cardSystem.logic", package.seeall)
  local metatable = getmetatable(cardSystem.logic)
  metatable.__index = proxy
end
createSubModule()
