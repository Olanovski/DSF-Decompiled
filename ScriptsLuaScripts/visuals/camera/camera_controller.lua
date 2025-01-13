function CameraSystemRegisterUpdate(name, camera, camera_type, camera_function, parameters)
  cameraController.createCamera({
    name = name,
    camera = camera,
    camera_type = camera_type,
    camera_function = camera_function,
    camera_parameters = parameters
  })
end
Camera = {
  camera = nil,
  camera_function = nil,
  camera_name = nil,
  camera_parameters = nil,
  camera_type = nil
}
function Camera:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function Camera:delete()
end
function Camera:update()
  if self.camera_function then
    self.camera_function(self)
  end
end
function cameraControllerUpdateSimulationTime()
  for cameraKey, camera in next, cameraController.camerasSimulationTime, nil do
    camera:update()
  end
end
function cameraControllerUpdateRealTime()
  for cameraKey, camera in next, cameraController.camerasRealTime, nil do
    camera.camera.prev_matrix = camera.camera.matrix
    camera:update()
  end
end
module("cameraController", package.seeall)
camerasSimulationTime = {}
camerasRealTime = {}
function createCamera(parameters)
  if parameters.name == nil then
    return
  end
  local cam
  if camerasSimulationTime[parameters.name] ~= nil then
    cam = camerasSimulationTime[parameters.name]
  elseif camerasRealTime[parameters.name] ~= nil then
    cam = camerasRealTime[parameters.name]
  else
    cam = Camera:new()
  end
  if parameters.camera_type == "simulation" then
    if camerasSimulationTime[parameters.name] ~= nil then
      camerasSimulationTime[parameters.name].camera:newBehaviour(nil)
      deleteCam(camerasSimulationTime[parameters.name])
    end
  elseif camerasRealTime[parameters.name] ~= nil then
    camerasRealTime[parameters.name].camera:newBehaviour(nil)
    deleteCam(camerasRealTime[parameters.name])
  end
  if parameters.camera_function == nil and cam.camera ~= nil then
    deleteCam(cam)
    return
  end
  cam.name = parameters.name
  cam.camera = parameters.camera or nil
  cam.camera_function = parameters.camera_function or nil
  cam.camera_parameters = parameters.camera_parameters or nil
  cam.camera_type = parameters.camera_type or "simulation"
  if cam.name == nil then
    return
  end
  if cam.camera == nil then
    return
  end
  if cam.camera_function == nil then
    return
  end
  if cam.camera_type == "real" then
    camerasRealTime[cam.name] = cam
    cam.camera.stepType = "RealTime"
  else
    camerasSimulationTime[cam.name] = cam
    cam.camera.stepType = "Simulation"
  end
  cam.camera_function(cam)
end
function deleteCam(cam)
  if cam.name ~= nil then
    if cam.camera_type == "real" then
      if camerasRealTime[cam.name] ~= nil then
        camerasRealTime[cam.name].camera:deleteBehaviour()
        camerasRealTime[cam.name]:delete()
        camerasRealTime[cam.name] = nil
      end
    elseif camerasSimulationTime[cam.name] ~= nil then
      camerasSimulationTime[cam.name].camera:deleteBehaviour()
      camerasSimulationTime[cam.name]:delete()
      camerasSimulationTime[cam.name] = nil
    end
  end
end
function getCamera(camera_name)
  if camerasRealTime[camera_name] ~= nil then
    return camerasRealTime[camera_name]
  end
  if camerasSimulationTime[camera_name] ~= nil then
    return camerasSimulationTime[camera_name]
  end
  return nil
end
addUserUpdateFunction("CameraSystemRealTime", cameraControllerUpdateRealTime, 1)
function stop()
  for camera_name, cam in next, camerasRealTime, nil do
    deleteCam(cam)
  end
  for camera_name, cam in next, camerasSimulationTime, nil do
    deleteCam(cam)
  end
end
