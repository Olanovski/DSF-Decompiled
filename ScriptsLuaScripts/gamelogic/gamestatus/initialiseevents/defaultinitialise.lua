gameStatus.registerEvent("initialise", "Default", function()
  print("======== DefaultInit ======== ")
  Menu.DisplayZAPInScript = 0
  game_camera = CameraSystem.CreateCamera()
  game_camera.viewport = 0
  local matrix = vec.matrix()
  matrix[3] = configSelector.launchConfig.StartPoint
  game_camera.matrix = matrix
  if localPlayer then
    localPlayer.camera = game_camera
    localPlayerManager.addPlayer(localPlayer)
    feedbackSystem.menusMaster.setButtonLayouts()
  end
  zap.setDefaultZapSettingsForPlayer(0, false)
  vehicleManager.pushVehicleDataToTable()
end)
function EstimateSpoolingSettings(topSpeed, topHeight, bottomSpeed, bottomHeight, middleHeight)
  local Bounds = function(value, min, max)
    if value < min then
      value = min
    elseif max < value then
      value = max
    end
    return value
  end
  topSpeed = Bounds(topSpeed, 10, 800)
  topHeight = Bounds(topHeight, 10, 5000)
  bottomSpeed = Bounds(bottomSpeed, 10, 800)
  bottomHeight = Bounds(bottomHeight, 10, 5000)
  middleHeight = Bounds(middleHeight, bottomHeight, topHeight)
  local middleSpeed = bottomSpeed + (topSpeed - bottomSpeed) / (topHeight - bottomHeight) * (middleHeight - bottomHeight)
  zapcontroller.setZapCameraVelocities({
    low = bottomSpeed / 2.236936
  })
  zapcontroller.setZapCameraVelocities({
    mid = middleSpeed / 2.236936
  })
  zapcontroller.setZapCameraVelocities({
    high = topSpeed / 2.236936
  })
  zapcontroller.setZapCameraHeights({low = bottomHeight})
  zapcontroller.setZapCameraHeights({mid = middleHeight})
  zapcontroller.setZapCameraHeights({high = topHeight})
  print("Top speed    = " .. topSpeed .. "\n")
  print("Middle speed = " .. middleSpeed .. "\n")
  print("Bottom speed = " .. bottomSpeed .. "\n")
end
