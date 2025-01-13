module("scoreSystem", package.seeall)
feedbackVisible = false
limitedFeedback = false
function initialise()
  driftingEndSpeed = 13.41142
  driftingSpinOutAngle = 70
end
local playerVehicle = {}
local showingFeedback = false
local currentScore, currentType
function purge()
end
function setPlayerVehicle(localID, gameVehicle)
  if gameVehicle then
    playerVehicle[localID] = gameVehicle
    scoringSystem.SetGameVehicle(localID, gameVehicle)
  else
    playerVehicle[localID] = false
    scoringSystem.SetGameVehicle(localID, false)
  end
end
function isPlayerOffRoad(wheels, localID)
  local isOff = false
  if playerVehicle[localID] then
    local numOff = playerVehicle[localID].isOffRoad
    local numWheels = wheels or 2
    if numOff >= numWheels then
      isOff = true
    end
  end
  return isOff
end
