module("localPlayer.challenge", package.seeall)
function setShowingEndScreen(self, isShowingEndScreen)
  self.showingEndScreen = isShowingEndScreen
  localPlayerManagerReflection.setShowingEndScreen(localPlayer.localID, isShowingEndScreen)
end
local waitString = "missionEndWait"
function purge()
  removeUserUpdateFunction(waitString)
end
showingEndScreen = false
localPlayer.challenge:setShowingEndScreen(false)
retryingMission = false
function setRetryingMission(retrying)
  retryingMission = retrying
end
function endScreen(taskObject, params)
  local instance = taskObject.coreData.instance
  endScreenLoading.handleEndScreenLoading(instance, params)
end
function missionEndWait(callback, forced)
  local stepRate = 1
  local callback = callback
  if localPlayer.zapTransition then
    addUserUpdateFunction(waitString, function()
      if not localPlayer.zapTransition then
        removeUserUpdateFunction(waitString)
        missionEndWait(callback)
      end
    end, stepRate)
    return
  elseif localPlayer.inCutsceneOrIcam then
    addUserUpdateFunction(waitString, function()
      if not localPlayer.inCutsceneOrIcam then
        removeUserUpdateFunction(waitString)
        missionEndWait(callback)
      end
    end, stepRate)
    return
  elseif localPlayer.teleporting then
    addUserUpdateFunction(waitString, function()
      if forced then
        localPlayer.teleporting = false
      end
      if not localPlayer.teleporting then
        removeUserUpdateFunction(waitString)
        missionEndWait(callback)
      end
    end, stepRate)
    return
  elseif localPlayer.selfRighting then
    addUserUpdateFunction(waitString, function()
      localPlayer.currentVehicle:forceSelfRight()
      if not localPlayer.selfRighting then
        removeUserUpdateFunction(waitString)
        missionEndWait(callback)
      end
    end, stepRate)
    return
  else
    addUserUpdateFunction(waitString, function()
      removeUserUpdateFunction(waitString)
      callback()
    end, stepRate, true)
  end
end
