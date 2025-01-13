UnderTrailerCamParams = {TrailerVehicle = nil, ExitBonnetRadius = 5}
local SwitchToBonnet, ResetCamera
local UnderCallback = {}
local ExitCallback = {}
local trailerDeleted = function()
  UnderTrailerCamParams.TrailerVehicle = nil
end
local function Under_Trailer_Camera_Step(parameters)
  if UnderTrailerCamParams.ExitBonnetRadius ~= 0 then
    if not UnderTrailerCamParams.TrailerVehicle then
      print("\163ERROR\163 no trailer vehicle passed to trailer cam")
      ResetCamera()
    elseif not localPlayer.inZap and not GameVehicleResource.withinRadius(localPlayer.currentVehicle.position, UnderTrailerCamParams.TrailerVehicle.attachedPosition, UnderTrailerCamParams.ExitBonnetRadius) then
      for i, callback in ipairs(ExitCallback) do
        callback(parameters)
      end
      ResetCamera()
    end
  end
end
function SwitchToBonnet(parameters)
  if localPlayer.cameraMode == "Normal" then
    CameraSystemRegisterUpdate("Game_Cam", game_camera, "simulation", Camera_Function_Vehicle_Bonnet_Cam, {
      agent = localPlayer.currentVehicle
    })
  end
  UnderTrailerCamParams.TrailerVehicle = parameters.GameVehicle
  GameVehicleResource.RegisterDeletionCallback(UnderTrailerCamParams.TrailerVehicle, trailerDeleted)
  localPlayer.scoring.unregisterUnderTrailerCallback(SwitchToBonnet)
  for i, callback in ipairs(UnderCallback) do
    callback(parameters)
  end
  if UnderTrailerCamParams.ExitBonnetRadius == 0 then
    localPlayer.scoring.registerUnderTrailerExitCallback(ResetCamera)
  else
    addUserUpdateFunction("UnderTrailerCamStep", Under_Trailer_Camera_Step, 20)
  end
end
function ResetCamera()
  removeUserUpdateFunction("UnderTrailerCamStep")
  if UnderTrailerCamParams.TrailerVehicle then
    GameVehicleResource.UnRegisterDeletionCallback(UnderTrailerCamParams.TrailerVehicle, trailerDeleted)
    UnderTrailerCamParams.TrailerVehicle = nil
  end
  if not localPlayer.inZap then
    localPlayer:resetCameraMode()
  end
  localPlayer.scoring.unregisterUnderTrailerExitCallback(ResetCamera)
  localPlayer.scoring.registerUnderTrailerCallback(SwitchToBonnet)
end
function Start_Under_Trailer_Camera(parameters)
  localPlayer.scoring.registerUnderTrailerCallback(SwitchToBonnet)
end
function Stop_Under_Trailer_Camera()
  removeUserUpdateFunction("UnderTrailerCamStep")
  localPlayer.scoring.unregisterUnderTrailerCallback(SwitchToBonnet)
  localPlayer.scoring.unregisterUnderTrailerExitCallback(ResetCamera)
end
function registerUnderTrailerCameraCallback(callback)
  if callback then
    table.insert(UnderCallback, #UnderCallback + 1, callback)
  end
end
function unregisterUnderTrailerCameraCallback(callback)
  if callback then
    local remove = false
    for i, storedCallback in ipairs(UnderCallback) do
      if storedCallback == callback then
        remove = i
        break
      end
    end
    if remove then
      table.remove(UnderCallback, remove)
    end
  end
end
function registerExitTrailerCameraCallback(callback)
  if callback then
    table.insert(ExitCallback, #ExitCallback + 1, callback)
  end
end
function unregisterExitTrailerCameraCallback(callback)
  if callback then
    local remove = false
    for i, storedCallback in ipairs(ExitCallback) do
      if storedCallback == callback then
        remove = i
        break
      end
    end
    if remove then
      table.remove(ExitCallback, remove)
    end
  end
end
