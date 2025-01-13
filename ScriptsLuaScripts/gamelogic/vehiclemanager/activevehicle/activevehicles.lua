module("vehicleManager.activeVehicles", package.seeall)
local activeVehicleSlot = 0
local ActiveVehiclesSpooled = true
disableVehicleSelectFeedback = false
local modelIDs = {
  1,
  101,
  95,
  125,
  227,
  243,
  232,
  119,
  181,
  126,
  226,
  150,
  156,
  258,
  171,
  178,
  284
}
local activeVehicles = {
  [0] = {modelID = 232, colour = 0},
  [1] = {modelID = 181, colour = 0}
}
function tempActiveVehicle(playerID)
end
function loadActiveVehicles()
  for i = 0, #activeVehicles do
    ActiveVehicles.changeActive(i, activeVehicles[i].modelID, activeVehicles[i].colour)
  end
end
function lockActiveVehicles()
end
_G.requestActiveVehicles = tempActiveVehicle
function resetSystem()
  ActiveVehicles.resetSystem()
  ActiveVehiclesSpooled = true
end
function startWaitForSpool()
end
function getAreVehiclesSpooled()
  return activeVehiclesSpooled
end
function vehiclesAreSpooled()
  activeVehiclesSpooled = true
end
_G.avVehiclesSpooled = vehiclesAreSpooled
function setActiveVehicleSlot(slotID)
  ActiveVehicles.setActiveVehicleSlot(slotID)
end
function setActiveCarSwapDisplayOne()
  if not disableVehicleSelectFeedback then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMultiplayer_CarSwap", 1)
    OneShotSound.Play("HUD_Online_DPad_CarSwap")
  end
end
_G.setActiveCarSwapDisplayOne = setActiveCarSwapDisplayOne
function setActiveCarSwapDisplayTwo()
  if not disableVehicleSelectFeedback then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMultiplayer_CarSwap", 2)
    OneShotSound.Play("HUD_Online_DPad_CarSwap")
  end
end
_G.setActiveCarSwapDisplayTwo = setActiveCarSwapDisplayTwo
