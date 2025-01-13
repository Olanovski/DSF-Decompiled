module("massiveDebug", package.seeall)
function setCamera(matrix)
  freeCamOnly(true)
  spooling.waitForSpooling(matrix[3], nil, function()
    while localPlayer.cameraMode ~= "FreeCam" do
      cycleActiveCamera("JustPressed", 1, 0)
    end
    free_camera.matrix = matrix
    player.setAttachment(localPlayer.localID, free_camera)
    spoolsystem.EnableCameraTracking()
  end, nil, 0.5, 0.5, false)
end
_G.massiveDebugSetCamera = setCamera
