module("MPZapToAction", package.seeall)
local zapToActionTarget, zapTargetHeading
local invalidType = -1
local zapToActionType = invalidType
local zapToActionActiveTimerLimit = 2
local zapToActionActiveTimer = 0
local zapToVehicle, zapToPackage, zapToPosition
function setZapToAction(actionType, actionTarget, actionHeading)
  assert(actionType < 5 and actionType > 0, "MP ZAP TO ACTION, invalid action type")
  zapToActionType = actionType
  zapToActionTarget = actionTarget
  zapToActionHeading = actionHeading
end
function updateZapToActionTarget(actionTarget, actionHeading)
  zapToActionTarget = actionTarget
  zapToActionHeading = actionHeading
  for localID, player in next, localPlayerManager.players, nil do
    if player.zapToActionActive then
      player.zapToActionActive = false
      trigger(localID, true)
    end
  end
end
function zapToActionTimerClosure(player)
  return function()
    if player.zapToActionStartTimer == 0 and not player.zapTransition then
      player.zapToActionStartTimer = g_NetworkTime
      player.zapToActionActive = false
      if not gameStatus.onlineSessionType or gameStatus.onlineSessionType ~= gameStatus.onlineSessionID.partyMode then
        player.minimapSupport:show()
      end
    end
    if player.zapToActionStartTimer ~= 0 then
      player.zapToActionActiveTimer = g_NetworkTime - player.zapToActionStartTimer
      if player.zapToActionActiveTimer > zapToActionActiveTimerLimit then
        player.zapToActionActiveTimer = 0
        player.zapToActionStartTimer = 0
        zapcontroller.setZapTargetingBackToInput(player.localID)
        removeUserUpdateFunction("MPZapToActionTimer" .. tostring(player.localID))
      end
    end
  end
end
function trigger(localID, fromUpdate)
  NetworkLog.Write(">[LUA] ZAP TO ACTION - trigger - localID = " .. tostring(localID) .. ", fromUpdate = " .. tostring(fromUpdate))
  networkLogPrintTable(callStackAsTable())
  local player = localPlayerManager.players[localID]
  if canZapToAction(player, fromUpdate) then
    if not player.inZap then
      player:SetZapLevel(1)
      scoreSystem.enteringZap(localID)
    end
    if zapToActionType == 1 then
      zapToVehicle(player, zapToActionTarget)
    elseif zapToActionType == 2 then
      zapToPackage(player, zapToActionTarget)
    elseif zapToActionType == 3 then
      zapToPosition(player, zapToActionTarget, zapToActionHeading)
    elseif zapToActionType == 4 then
      zapToVehicle(player, zapToActionTarget.coreData.agent)
    end
    player.zapToActionActiveTimer = 0
    player.zapToActionStartTimer = 0
    player.zapToActionActive = true
    addUserUpdateFunction("MPZapToActionTimer" .. tostring(player.localID), zapToActionTimerClosure(player), 4)
  end
end
function reset()
  zapToActionType = invalidType
  zapToActionTarget = nil
  removeUserUpdateFunction("MPZapToActionTimer0")
  removeUserUpdateFunction("MPZapToActionTimer1")
  for localID, player in next, localPlayerManager.players, nil do
    player.zapToActionActiveTimer = 0
    player.zapToActionStartTimer = 0
    player.zapToActionActive = false
  end
end
function zapToPackage(player, package)
  if package.owner and package.owner.gameVehicle then
    zapToVehicle(player, package.owner)
  else
    zapToPosition(player, package.position)
  end
end
function zapToVehicle(player, vehicle)
  player:zapToAction(vehicle)
end
function zapToPosition(player, vector, heading)
  local roadIndex, distanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(vector)
  local roadWidth = Atlas.AverageRoadWidth(roadIndex)
  if heading ~= nil then
    vector = vector + vec.vector(-math.cos(heading), 0, math.sin(heading), 0) * roadWidth / 5
    heading = heading * -1
    heading = heading - math.pi / 2
  else
    heading = 0
  end
  player:ZapTransitionToPoint(vector, heading)
end
function purge()
  reset()
end
function canZapToAction(player, fromUpdate)
  player = player or localPlayer
  if zap.zapAttack.isZapAttackActive() or zap.zapSwap.isZapSwapActive() or zapcontroller.IsZapSpawnInProcess() then
    return false
  end
  if player.zapReturning then
    return false
  end
  if (not fromUpdate or fromUpdate and zapToActionType ~= 3) and player.zapTransition then
    return false
  end
  if player.zapToActionActive then
    return false
  end
  if not player.inZap and not scoreSystem.enoughAbilityToUseShift(player.localID) then
    return false
  end
  if zapToActionType == 1 and zapToActionTarget == player.currentVehicle then
    return false
  end
  if zapToActionType == 4 and zapToActionTarget.coreData.agent == player.currentVehicle then
    return false
  end
  if zapToActionType == 2 and zapToActionTarget.owner == player.currentVehicle then
    return false
  end
  if zapToActionType ~= invalidType then
    return true
  end
  return false
end
