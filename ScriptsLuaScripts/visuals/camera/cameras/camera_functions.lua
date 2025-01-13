local up_down_value = 0
local padToUse
local _padokay = controller.checkControllerStatus(2)
if _padokay == 1 then
  padToUse = controller.getPad("GAMEPAD2")
else
  padToUse = controller.getPad("GAMEPAD1")
end
local Camera_Function_Free_Cam_Step = function(cam)
  local deadZone = 0.2
  local rotateLeftRightStep = 0
  local rotateUpDownStep = 0
  local moveLeftRightStep = 0
  local moveForwardBackStep = 0
  local moveUpStep = 0
  local moveDownStep = 0
  local speedUpStep = 0
  local speedDownStep = 0
  local zoomInStep = 0
  local zoomOutStep = 0
  local rotationYMatrixHolder = setYRotation(math.pi)
  local rotationXMatrixHolder = setXRotation(0)
  local mode = "freeCam"
  local function rotateLeftRight(state, value)
    rotateLeftRightStep = math.abs(value) > deadZone and value or 0
  end
  local function rotateUpDown(state, value)
    rotateUpDownStep = math.abs(value) > deadZone and value or 0
  end
  local function moveLeftRight(state, value)
    moveLeftRightStep = math.abs(value) > deadZone and value or 0
  end
  local function moveForwardBack(state, value)
    moveForwardBackStep = math.abs(value) > deadZone and value or 0
  end
  local function moveUp(state, value)
    moveUpStep = math.abs(value) > deadZone and value or 0
  end
  local function moveDown(state, value)
    moveDownStep = math.abs(value) > deadZone and value or 0
  end
  local function speedUpControl(state, value)
    speedUpStep = math.abs(value) > deadZone and value or 0
  end
  local function slowDownControl(state, value)
    speedDownStep = math.abs(value) > deadZone and value or 0
  end
  local function zoomIn(state, value)
    zoomInStep = math.abs(value) > deadZone and value or 0
  end
  local function zoomOut(state, value)
    zoomOutStep = math.abs(value) > deadZone and value or 0
  end
  local function switchMode(state)
    if cam.camera_parameters.agent and not getFreeCamOnlyAllowed() then
      if mode == "freeCam" then
        offset = cam.camera.matrix:transpose() * (cam.camera.matrix[3] - cam.camera_parameters.agent.gameVehicle.position)
        offset.w = 1
        controlHandler:setState("StickCam", cam.camera_parameters.pad)
        player.setAttachment(localPlayer.localID, localPlayer.currentVehicle.gameVehicle)
        localPlayer.controllerInterface:registerPlayerControl()
        mode = "stickCam"
      else
        controlHandler:resetState("StickCam", cam.camera_parameters.pad)
        if cam.camera_parameters.pad == 1 then
          player.setAttachment(localPlayer.localID, cam.camera)
        end
        localPlayer.controllerInterface:removePlayerControl()
        mode = "freeCam"
      end
    end
  end
  local freeCamControls = {
    LuaCamera_Rotate_LeftRight = {
      Pressed = {rotateLeftRight}
    },
    LuaCamera_Rotate_UpDown = {
      Pressed = {rotateUpDown}
    },
    LuaCamera_Move_LeftRight = {
      Pressed = {moveLeftRight}
    },
    LuaCamera_Move_BackForward = {
      Pressed = {moveForwardBack}
    },
    LuaCamera_Move_Up = {
      Pressed = {moveUp},
      JustReleased = {moveUp}
    },
    LuaCamera_Move_Down = {
      Pressed = {moveDown},
      JustReleased = {moveDown}
    },
    Vehicle_Accelerate = {
      Pressed = {speedUpControl}
    },
    Vehicle_Reverse = {
      Pressed = {slowDownControl}
    },
    DPad_Up = {
      Pressed = {zoomIn},
      JustReleased = {zoomIn}
    },
    DPad_Down = {
      Pressed = {zoomOut},
      JustReleased = {zoomOut}
    },
    Camera_Action = {
      JustPressed = {switchMode}
    },
    Camera_Change = {
      JustPressed = {cycleActiveCamera}
    }
  }
  local stickCamControls = {
    Camera_Action = {
      JustPressed = {switchMode}
    },
    Camera_Change = {
      JustPressed = {cycleActiveCamera}
    }
  }
  if controlHandler then
    controlHandler:registerState(cam.camera_parameters.agent.localID, "FreeCam", freeCamControls)
    controlHandler:registerState(cam.camera_parameters.agent.localID, "StickCam", stickCamControls)
    if cam.camera_parameters then
      controlHandler:setState("FreeCam", cam.camera_parameters.pad)
    else
      controlHandler:setState("FreeCam", 1)
    end
  end
  localPlayer.controllerInterface:removePlayerControl()
  local maxMoveCameraSpeed = 15 / updates.stepRate
  local maxUpDownMoveSpeed = 5 / updates.stepRate
  local upDownSpeed = maxUpDownMoveSpeed
  local maxRotateCameraSpeed = 2 / updates.stepRate
  local rotationSpeed = maxRotateCameraSpeed
  local maxZoomSpeed = 2 / updates.stepRate
  local zoomMultiplier = 1
  local maxFoV = math.rad(175)
  local minFoV = math.rad(1)
  local deadZone = 0.2
  local normalVec = vec.vector()
  local binormalVec = vec.vector()
  local tangetVec = vec.vector()
  local positionVec = vec.vector()
  return function(cam)
    if mode == "stickCam" then
      local VehicleMatrix = cam.camera_parameters.agent.gameVehicle.matrix
      VehicleMatrix = VehicleMatrix * rotationYMatrixHolder * rotationXMatrixHolder
      VehicleMatrix[3] = VehicleMatrix * offset
      cam.camera.matrix = VehicleMatrix
    elseif rotateLeftRightStep ~= 0 or rotateUpDownStep ~= 0 or moveLeftRightStep ~= 0 or moveForwardBackStep ~= 0 or moveUpStep ~= 0 or moveDownStep ~= 0 or zoomInStep ~= 0 or zoomOutStep ~= 0 then
      local speedmultiplier = 1
      if speedUpStep > speedDownStep then
        speedmultiplier = speedmultiplier + speedUpStep * 5
        rotationSpeed = maxRotateCameraSpeed * (speedUpStep * 5)
        upDownSpeed = maxUpDownMoveSpeed * (speedUpStep * 5)
        zoomMultiplier = 1 + speedUpStep * 2
      else
        speedDownStep = math.min(0.98, speedDownStep)
        speedmultiplier = speedmultiplier - speedDownStep
        rotationSpeed = maxRotateCameraSpeed * ((1 - speedDownStep) * 3)
        upDownSpeed = maxUpDownMoveSpeed * ((1 - speedDownStep) * 3)
        zoomMultiplier = 1 - math.min(0.98, speedDownStep)
      end
      local speed = maxMoveCameraSpeed * speedmultiplier
      if zoomInStep > 0 then
        cam.camera.fov = math.max(math.min(cam.camera.fov - maxZoomSpeed * zoomMultiplier, maxFoV), minFoV)
      elseif zoomOutStep > 0 then
        cam.camera.fov = math.max(math.min(cam.camera.fov + maxZoomSpeed * zoomMultiplier, maxFoV), minFoV)
      end
      rotateLeftRightStep = rotateLeftRightStep * rotationSpeed
      rotateUpDownStep = rotateUpDownStep * rotationSpeed
      moveLeftRightStep = moveLeftRightStep * speed
      moveForwardBackStep = moveForwardBackStep * speed
      local upDownStep = 0
      if moveUpStep > moveDownStep then
        upDownStep = moveUpStep * upDownSpeed
      elseif moveDownStep > moveUpStep then
        upDownStep = -moveDownStep * upDownSpeed
      end
      local matrix = cam.camera.matrix
      matrix:getColumn(0, normalVec)
      matrix:getColumn(1, binormalVec)
      matrix:getColumn(2, tangetVec)
      matrix:getColumn(3, positionVec)
      positionVec = positionVec:add(positionVec, normalVec * moveLeftRightStep)
      positionVec = positionVec:add(positionVec, binormalVec * upDownStep)
      positionVec = positionVec:sub(positionVec, tangetVec * moveForwardBackStep)
      local yRotation = setYRotation(-rotateLeftRightStep)
      rotationYMatrixHolder = rotationYMatrixHolder * yRotation
      local matrix_out = yRotation * matrix
      matrix_out[3] = positionVec
      local xRotation = setXRotation(-rotateUpDownStep)
      rotationXMatrixHolder = rotationXMatrixHolder * xRotation
      matrix_out = matrix_out * xRotation
      cam.camera.matrix = matrix_out
    end
  end
end
function Camera_Function_Free_Cam(cam)
  cam.camera_function = Camera_Function_Free_Cam_Step(cam)
  CameraSystem.SetLuaUpdateRate(1)
end
function Camera_Function_Static_Cam(cam)
  cam.camera_function = nil
  CameraSystem.SetLuaUpdateRate(120)
end
function createScene(scene, t)
  local visited = {}
  local function parseTable(subScene)
    for k, v in next, subScene, nil do
      if type(v) == "table" then
        if not visited[v] then
          visited[v] = true
          parseTable(v)
        end
      elseif t[k] then
        subScene[k] = t[k]
      end
    end
  end
  parseTable(scene)
end
function Camera_Function_Vehicle_Chase_Cam(cam)
  cam.camera:newBehaviour("Vehicle_Chase", cam.camera_parameters.agent.uid)
  cam.camera_function = nil
  CameraSystem.SetLuaUpdateRate(120)
end
function Camera_Function_Vehicle_Position_Cam(cam)
  cam.camera:newBehaviour("Vehicle_Position", cam.camera_parameters.agent.uid, cam.camera_parameters.position)
  cam.camera_function = nil
  CameraSystem.SetLuaUpdateRate(120)
end
Dynamic_Chase_Cam_Settings = {
  FovPosCatchUpRate = 0.1,
  FovNegCatchUpRate = 0.1,
  TurnCatchUpRate = 0.0328,
  RollCatchUpRate = 1,
  PeriscopeHeightMultiplier = 0.2,
  PeriscopeFocusMultiplier = 0.2,
  PeriscopeFocalHeightChangeRatePos = 0.01,
  PeriscopeFocalHeightChangeRateNeg = 0.01,
  PeriscopeEyeHeightChangeRatePos = 0.01,
  PeriscopeEyeHeightChangeRateNeg = 0.01,
  PeriscopeTerrainCheckDistance = 32.5,
  PeriscopeTerrainCheckVehicleOffset = 65
}
function Camera_Function_Vehicle_Dynamic_Chase_Cam(cam)
  local plr = localPlayerManager.getPlayerByGameVehicle(cam.camera_parameters.agent.gameVehicle)
  VehicleSystem.setPlayerVehicleVisible(1, plr.localID)
  cam.camera:newBehaviour("Dynamic_Vehicle_Chase", cam.camera_parameters.agent.gameVehicle, Dynamic_Chase_Cam_Settings, cam.camera_parameters.pad)
  cam.camera_function = nil
  CameraSystem.SetLuaUpdateRate(120)
end
function Camera_Function_Vehicle_In_Car_Cam(cam)
  cam.camera:newBehaviour("In_Car", cam.camera_parameters.agent.gameVehicle, cam.camera_parameters.position, cam.camera_parameters.pad)
  cam.camera_function = nil
  CameraSystem.SetLuaUpdateRate(120)
end
function Camera_Function_Sperical(cam)
  cam.camera:newBehaviour("Spherical", cam.camera_parameters.center, cam.camera_parameters.radius, 1 - cam.camera_parameters.damping, cam.camera_parameters.rotation, cam.camera_parameters.userControl)
  cam.camera_function = nil
  CameraSystem.SetLuaUpdateRate(120)
end
function Camera_Function_Vehicle_Driver_Eye_Cam(cam)
  cam.camera:newBehaviour("Driver_Eye", cam.camera_parameters.agent.gameVehicle, cam.camera_parameters.position, cam.camera_parameters.pad)
  cam.camera_function = nil
  CameraSystem.SetLuaUpdateRate(120)
end
function Camera_Function_Vehicle_Dynamic_Bumper_Cam(cam)
  local plr = localPlayerManager.getPlayerByGameVehicle(cam.camera_parameters.agent.gameVehicle)
  VehicleSystem.setPlayerVehicleVisible(0, plr.localID)
  cam.camera:newBehaviour("Dynamic_Vehicle_Bumper", cam.camera_parameters.agent.gameVehicle, cam.camera_parameters.position, cam.camera_parameters.pad)
  cam.camera_function = nil
  CameraSystem.SetLuaUpdateRate(120)
end
function Camera_Function_Preview_Cam(cam)
  cam.camera:newBehaviour("Preview", cam.camera_parameters.agent.gameVehicle, nil)
  cam.camera_function = nil
  CameraSystem.SetLuaUpdateRate(120)
end
function Camera_Function_Vehicle_Bonnet_Cam(cam)
  cam.camera:newBehaviour("Bonnet", cam.camera_parameters.agent.gameVehicle, cam.camera_parameters.position, cam.camera_parameters.pad)
  cam.camera_function = nil
  CameraSystem.SetLuaUpdateRate(120)
end
function Camera_Function_Random_Vehicle_Position_Cam(cam)
  cam.camera_parameters.position = math.abs(math.random(1, 8))
  if cam.camera_parameters.position == 1 then
    cam.camera_parameters.position = "CAMERA_R_BUMPER"
  elseif cam.camera_parameters.position == 2 then
    cam.camera_parameters.position = "CAMERA_CHASE"
  elseif cam.camera_parameters.position == 3 then
    cam.camera_parameters.position = "CAMERA_BUMPER"
  elseif cam.camera_parameters.position == 4 then
    cam.camera_parameters.position = "CAMERA_DRIVER"
  elseif cam.camera_parameters.position == 5 then
    cam.camera_parameters.position = "CAMERA_LWHEEL"
  elseif cam.camera_parameters.position == 6 then
    cam.camera_parameters.position = "CAMERA_RWHEEL"
  elseif cam.camera_parameters.position == 7 then
    cam.camera_parameters.position = "CAMERA_BOOT"
  elseif cam.camera_parameters.position == 8 then
    cam.camera_parameters.position = "CAMERA_BONNET"
  end
  cam.camera:newBehaviour("Vehicle_Position", cam.camera_parameters.agent.gameVehicle, cam.camera_parameters.position)
  cam.ticks_to_change = math.random(500, 1000)
  cam.camera_function = Camera_Function_Random_Vehicle_Position_Cam_Step
  CameraSystem.SetLuaUpdateRate(1)
end
function Camera_Function_Random_Vehicle_Position_Cam_Step(cam)
  if cam.ticks_to_change == 0 then
    cam.camera_parameters.position = math.abs(math.random(1, 8))
    if cam.camera_parameters.position == 1 then
      cam.camera_parameters.position = "CAMERA_R_BUMPER"
    elseif cam.camera_parameters.position == 2 then
      cam.camera_parameters.position = "CAMERA_CHASE"
    elseif cam.camera_parameters.position == 3 then
      cam.camera_parameters.position = "CAMERA_BUMPER"
    elseif cam.camera_parameters.position == 4 then
      cam.camera_parameters.position = "CAMERA_DRIVER"
    elseif cam.camera_parameters.position == 5 then
      cam.camera_parameters.position = "CAMERA_LWHEEL"
    elseif cam.camera_parameters.position == 6 then
      cam.camera_parameters.position = "CAMERA_RWHEEL"
    elseif cam.camera_parameters.position == 7 then
      cam.camera_parameters.position = "CAMERA_BOOT"
    elseif cam.camera_parameters.position == 8 then
      cam.camera_parameters.position = "CAMERA_BONNET"
    end
    cam.camera:newBehaviour("Vehicle_Position", cam.camera_parameters.agent.gameVehicle, cam.camera_parameters.position)
    cam.ticks_to_change = math.random(500, 1000)
  else
    cam.ticks_to_change = cam.ticks_to_change - 1
  end
end
local heli_cam_offset_x = 0
local heli_cam_offset_y = 10
local heli_cam_offset_z = 1
local heli_cam_rot = math.pi
local heli_cam_rot_step = 0
local heli_cam_look_at_offset = vec.vector(0, 0, 0, 1)
local heli_cam_look_at_offset_step = vec.vector(0, 0, 0, 0)
function Camera_Function_Heli_Cam(cam)
  vehicle_matrix = setYRotation(heli_cam_rot)
  vehicle_matrix[3] = cam.camera_parameters.agent.position
  camera_matrix = setXRotation(-0.2)
  camera_matrix[3] = vec.vector(heli_cam_offset_x, heli_cam_offset_y, heli_cam_offset_z, 1)
  middle_matrix = vehicle_matrix * camera_matrix
  cam.camera.matrix = CreateLookAtMatrix(middle_matrix[3], vehicle_matrix[3])
  math.randomseed(1001)
  cam.ticks_to_change_rotation = math.random(500, 1000)
  heli_cam_rot_step = math.random() / 1000
  cam.ticks_to_change_offset = math.random(500, 1000)
  heli_cam_look_at_offset_step.x = math.random() / 500
  heli_cam_look_at_offset_step.y = math.random() / 500
  heli_cam_look_at_offset_step.z = math.random() / 500
  cam.camera_function = Camera_Function_Heli_Cam_Step
  CameraSystem.SetLuaUpdateRate(1)
end
function Camera_Function_Heli_Cam_Step(cam)
  if cam.ticks_to_change_offset == 0 then
    heli_cam_look_at_offset_step.x = math.random(-1, 1) / 500
    heli_cam_look_at_offset_step.y = math.random(-1, 1) / 500
    heli_cam_look_at_offset_step.z = math.random(-1, 1) / 500
    cam.ticks_to_change_offset = math.random(500, 1000)
  else
    cam.ticks_to_change_offset = cam.ticks_to_change_offset - 1
  end
  heli_cam_look_at_offset.x = heli_cam_look_at_offset.x + heli_cam_look_at_offset_step.x
  heli_cam_look_at_offset.y = heli_cam_look_at_offset.y + heli_cam_look_at_offset_step.y
  heli_cam_offset_z = heli_cam_offset_z + heli_cam_look_at_offset_step.z
  if heli_cam_look_at_offset.x >= 3 then
    heli_cam_look_at_offset.x = 3
  end
  if heli_cam_look_at_offset.x <= -3 then
    heli_cam_look_at_offset.x = -3
  end
  if heli_cam_look_at_offset.y >= 3 then
    heli_cam_look_at_offset.y = 3
  end
  if heli_cam_look_at_offset.y <= -3 then
    heli_cam_look_at_offset.y = -3
  end
  if heli_cam_offset_z >= 3 then
    heli_cam_offset_z = 3
  end
  if heli_cam_offset_z <= -3 then
    heli_cam_offset_z = -3
  end
  if cam.ticks_to_change_rotation == 0 then
    heli_cam_rot_step = math.random(-1, 1) / 1000
    cam.ticks_to_change_rotation = math.random(500, 1000)
  else
    cam.ticks_to_change_rotation = cam.ticks_to_change_rotation - 1
  end
  heli_cam_rot = heli_cam_rot + heli_cam_rot_step
  if heli_cam_rot <= 0 then
    heli_cam_rot = math.rad(360)
  end
  if heli_cam_rot >= math.rad(360) then
    heli_cam_rot = 0
  end
  vehicle_matrix = setYRotation(heli_cam_rot)
  vehicle_matrix[3] = cam.camera_parameters.agent.gameVehicle.position
  camera_matrix = setXRotation(-0.2)
  camera_matrix[3] = vec.vector(heli_cam_offset_x, heli_cam_offset_y, heli_cam_offset_z, 1)
  middle_matrix = vehicle_matrix * camera_matrix
  cam.camera.matrix = CreateLookAtMatrix(middle_matrix[3], vehicle_matrix[3] + heli_cam_look_at_offset)
end
function Camera_Function_Aerial_Cam(cam)
  local offset = vec.vector(0, 80, 1, 1)
  local maxTimer = 5 * updates.stepRate
  local sensitivity = 8
  local minOffset = 5
  local maxOffset = 400
  local pi = math.pi
  local pad = controller.getPad("GAMEPAD1")
  local left_vert = "LuaCamera_Move_BackForward"
  local watchFor = "Pressed"
  local left_vert_status, left_vert_value
  local timer = 0
  local rotation
  vehicle_matrix = setYRotation(pi)
  vehicle_matrix[3] = cam.camera_parameters.agent.gameVehicle.position
  camera_matrix = setXRotation(-0.2)
  camera_matrix[3] = offset
  middle_matrix = vehicle_matrix * camera_matrix
  cam.camera.matrix = CreateLookAtMatrix(middle_matrix[3], vehicle_matrix[3])
  local function cameraStep()
    left_vert_status, left_vert_value = pad:status(left_vert)
    if left_vert_value ~= 0 then
      left_vert_value = left_vert_value * -1
      timer = timer + 1
      offset.y = offset.y + left_vert_value * (timer / maxTimer) * sensitivity
      if offset.y < minOffset then
        offset.y = minOffset
      elseif offset.y > maxOffset then
        offset.y = maxOffset
      end
    else
      timer = 0
    end
    rotation = cam.camera_parameters.agent.gameVehicle.heading + pi
    vehicle_matrix = setYRotation(rotation)
    vehicle_matrix[3] = cam.camera_parameters.agent.gameVehicle.position
    camera_matrix = setXRotation(-0.2)
    camera_matrix[3] = offset
    middle_matrix = vehicle_matrix * camera_matrix
    cam.camera.matrix = CreateLookAtMatrix(middle_matrix[3], vehicle_matrix[3])
  end
  cam.camera_function = cameraStep
  CameraSystem.SetLuaUpdateRate(1)
end
function Camera_Function_Vehicle_Preview_Cam(cam)
  cam.camera:newBehaviour("Vehicle_Preview", cam.camera_parameters.agent.uid)
  cam.camera_function = nil
  CameraSystem.SetLuaUpdateRate(120)
end
function Camera_Function_Rear_View_Mirror(cam)
  cam.camera_function = Camera_Function_Rear_View_Mirror_Step
  cam.camera:newBehaviour("Vehicle_Position", cam.camera_parameters.agent.uid, "CAMERA_R_BUMPER")
  cam.camera_function = nil
  CameraSystem.SetLuaUpdateRate(120)
end
local _Camera_Function_LookAT_Cam = function()
  local position = vec.vector()
  local workingVector = vec.vector()
  local subVector = vec.vector()
  local moveHorzStatus, moveHorzValue = "NotPressed", 0
  local moveVertUpStatus, moveVertUpValue = "NotPressed", 0
  local moveVertDownStatus, moveVertDownValue = "NotPressed", 0
  local moveVertValue = 0
  local moveZStatus, moveZValue = "NotPressed", 0
  local zoomInStatus, zoomInValue = "NotPressed", 0
  local zoomOutStatus, zoomOutValue = "NotPressed", 0
  local zoomValue = 0
  local horzMultiplier = 5 / updates.stepRate
  local vertMultiplier = 10 / updates.stepRate
  local zMultiplier = 10 / updates.stepRate
  local zoomMultiplier = 1 / updates.stepRate
  local maxFoV = math.rad(175)
  local minFoV = math.rad(1)
  local function horizontalUpdate(status, value)
    moveHorzValue = value
  end
  local function verticalUpUpdate(status, value)
    moveVertUpValue = value
  end
  local function verticalDownUpdate(status, value)
    moveVertDownValue = value
  end
  local function zUpdate(status, value)
    moveZValue = value
  end
  local function zoomInUpdate(status, value)
    zoomInValue = value
  end
  local function zoomOutUpdate(status, value)
    zoomOutValue = value
  end
  local freeCamPressed = function(state, value, localID)
    cycleActiveCamera(state, value, localID)
  end
  local controls = {
    LuaCamera_Rotate_LeftRight = {
      NotPressed = {horizontalUpdate}
    },
    LuaCamera_Rotate_UpDown = {
      NotPressed = {zUpdate}
    },
    Zap_Down = {
      Pressed = {},
      JustReleased = {}
    },
    Zap_Up = {
      Pressed = {},
      JustReleased = {}
    },
    Camera_Change = {
      JustPressed = {cycleActiveCamera}
    },
    DPad_Up = {
      Pressed = {zoomInUpdate},
      JustReleased = {zoomInUpdate}
    },
    DPad_Down = {
      Pressed = {zoomOutUpdate},
      JustReleased = {zoomOutUpdate}
    }
  }
  if controlHandler then
    controlHandler:registerState(localPlayer.localID, "DropCam", controls)
  end
  return function(cam)
    matrix = cam.camera.matrix
    matrix:getColumn(3, position)
    if moveHorzValue ~= 0 then
      matrix:getColumn(0, workingVector)
      position = subVector:add(position, workingVector * (moveHorzValue * horzMultiplier))
    end
    if moveVertUpValue > 0 or moveVertDownValue > 0 then
      if moveVertUpValue > moveVertDownValue then
        moveVertValue = moveVertUpValue * vertMultiplier
      else
        moveVertValue = -moveVertDownValue * vertMultiplier
      end
    else
      moveVertValue = 0
    end
    if zoomInValue > 0 or zoomOutValue > 0 then
      if zoomInValue > zoomOutValue then
        zoomValue = -zoomInValue * zoomMultiplier
      else
        zoomValue = zoomOutValue * zoomMultiplier
      end
      cam.camera.fov = math.max(math.min(cam.camera.fov + zoomValue, maxFoV), minFoV)
    end
    if moveVertValue ~= 0 then
      matrix:getColumn(1, workingVector)
      position = subVector:add(position, workingVector * moveVertValue)
    end
    if moveZValue ~= 0 then
      matrix:getColumn(2, workingVector)
      position = subVector:sub(position, workingVector * (moveZValue * zMultiplier))
    end
    cam.camera.matrix = CreateLookAtMatrix(position, cam.camera_parameters.agent.gameVehicle.position, matrix)
  end
end
Camera_Function_LookAT_Cam = _Camera_Function_LookAT_Cam()
function Camera_Function_Debug_Vehicle_Offsets_Cam(cam)
end
function Camera_Function_Debug_Vehicle_Offsets_Cam(cam)
  local pad1 = controller.getPad("GAMEPAD1")
  local right_horz = "LuaCamera_Rotate_LeftRight"
  local right_vert = "LuaCamera_Rotate_UpDown"
  local left_horz = "LuaCamera_Move_LeftRight"
  local left_vert = "LuaCamera_Move_BackForward"
  local right_trigger = "Zap_Up"
  local left_trigger = "Zap_Down"
  local right_bottom = "Vehicle_Accelerate"
  local left_bottom = "Vehicle_Reverse"
  local right_horz_status, right_horz_value, right_vert_status, right_vert_value, left_vert_status, left_vert_value, left_horz_status, left_horz_value, right_trigger_status, right_trigger_value, left_trigger_status, left_trigger_value, right_bottom_status, right_bottom_value, left_bottom_status, left_bottom_value
  local lookFrom = vec.vector(0, 0, 0, 1)
  local lookAt = vec.vector(0, 0, 0, 1)
  local maxMoveCameraSpeed = 15 / updates.stepRate
  local maxUpDownMoveSpeed = 0.5 / updates.stepRate
  local maxRotateCameraSpeed = 2 / updates.stepRate
  local speedmultiplier = 1
  local rot_speed = maxRotateCameraSpeed
  local watchFor = "Pressed"
  local function cameraStep()
    right_horz_status, right_horz_value = pad1:status(right_horz)
    right_vert_status, right_vert_value = pad1:status(right_vert)
    left_horz_status, left_horz_value = pad1:status(left_horz)
    left_vert_status, left_vert_value = pad1:status(left_vert)
    right_trigger_status, right_trigger_value = pad1:status(right_trigger)
    left_trigger_status, left_trigger_value = pad1:status(left_trigger)
    right_bottom_status, right_bottom_value = pad1:status(right_bottom)
    left_bottom_status, left_bottom_value = pad1:status(left_bottom)
    local speedmultiplier = 1
    if right_bottom_value > left_bottom_value then
      speedmultiplier = speedmultiplier + right_bottom_value * 5
    else
      left_bottom_value = math.min(0.95, left_bottom_value)
      speedmultiplier = speedmultiplier - left_bottom_value
    end
    local speed = maxMoveCameraSpeed * speedmultiplier
    right_horz_value = right_horz_value * rot_speed
    right_vert_value = right_vert_value * rot_speed
    left_vert_value = left_vert_value * speed
    left_horz_value = left_horz_value * speed
    player.setAttachment(localPlayer.localID, cam.camera)
    local up_down_value = 0
    if right_trigger_status == watchFor then
      if left_trigger_status == watchFor then
        up_down_value = (right_trigger_value - left_trigger_value) * maxUpDownMoveSpeed
      else
        up_down_value = right_trigger_value * maxUpDownMoveSpeed
      end
    else
      up_down_value = -left_trigger_value * maxUpDownMoveSpeed
    end
    local matrix = cam.camera.matrix
    local positionVec = matrix[3]
    positionVec = positionVec + matrix[0] * left_horz_value
    positionVec = positionVec + matrix[1] * up_down_value
    positionVec = positionVec - matrix[2] * left_vert_value
    local matRotation = setYRotation(-right_horz_value)
    local matrix_out = matRotation * matrix
    matrix_out[3] = positionVec
    matRotation = setXRotation(-right_vert_value)
    matrix_out = matrix_out * matRotation
    cam.camera.matrix = matrix_out
    local vehicleMatrix = cam.camera_parameters.agent.gameVehicle.transform
    local transposeVehicleMatrix = vehicleMatrix:transpose()
    lookFrom = cam.camera.matrix[3] - vehicleMatrix[3]
    lookFrom = transposeVehicleMatrix * lookFrom
    lookAt = cam.camera.matrix * vec.vector(0, 0, -10, 1)
    lookAt = lookAt - vehicleMatrix[3]
    lookAt = transposeVehicleMatrix * lookAt
    Development:add2DText(15191, "LookFrom: " .. string.format("%.2f %.2f %.2f", lookFrom[0], lookFrom[1], lookFrom[2]), vec.vector(0.1, 0.1, 0, 1), vec.vector(1, 1, 1, 1), 1, 5)
    Development:add2DText(15192, "LookAt  : " .. string.format("%.2f %.2f %.2f", lookAt[0], lookAt[1], lookAt[2]), vec.vector(0.1, 0.125, 0, 1), vec.vector(1, 1, 1, 1), 1, 5)
  end
  cam.camera_function = cameraStep
  CameraSystem.SetLuaUpdateRate(1)
end
