function overExposure(inTime, outTime)
  local startTime = g_NetworkTime
  local startBloomThreshold = postprocess.bloomThreshold
  local endBloomThrshold = 0.5
  local startVignetteAmount = postprocess.vignetteAmount
  local endVignetteAmount = 0
  local currentTime = 0
  local blendingIn = true
  local time = inTime
  addUserUpdateFunction("overExposure", function()
    if blendingIn then
      currentTime = (g_NetworkTime - startTime) / time
      if currentTime >= 1 then
        blendingIn = false
        startTime = g_NetworkTime
        time = outTime
        currentTime = 1 - (g_NetworkTime - startTime) / time
      end
    else
      currentTime = -(math.cos(math.pi * (1 - (g_NetworkTime - startTime) / time)) - 1) / 2
    end
    if not blendingIn and g_NetworkTime - startTime >= outTime then
      postprocess.bloomThreshold = startBloomThreshold
      postprocess.vignetteAmount = startVignetteAmount
      removeUserUpdateFunction("overExposure")
    else
      postprocess.bloomThreshold = lerp_value(startBloomThreshold, endBloomThrshold, currentTime)
      postprocess.vignetteAmount = lerp_value(startVignetteAmount, endVignetteAmount, currentTime)
    end
  end, 2)
end
function showFakeZapRing()
  local cameraSystemCamera = CameraSystem.GetCamera()
  workingVector = vec.vector()
  addUserUpdateFunction("ZapFlare", function()
    if not localPlayer.inZap then
      if cameraSystemCamera.viewport ~= nil then
        cameraSystemCamera.matrix:getColumn(2, workingVector)
      else
        game_camera.matrix:getColumn(2, workingVector)
      end
      zapcontroller.FPPShowZapFlare(true, math.atan2(workingVector.z, workingVector.x))
    end
  end, 2)
end
function hideFakeZapRing()
  removeUserUpdateFunction("ZapFlare")
  if not localPlayer.inZap then
    zapcontroller.FPPShowZapFlare(false)
  end
end
