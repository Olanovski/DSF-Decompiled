module("missionEditor", package.seeall)
header = "$ME$"
missionEditor.Vehicles = {}
function Init()
  physics.MissionEditorInit()
  luaConsole.luaConsoleSetUpdateCounter(1)
end
function Deinit()
  physics.MissionEditorDeinit()
end
function GetPropTypes()
  print(header .. "startproptypes")
  local params = {}
  params.matrix = vec.matrix(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
  for name, t in next, propType, nil do
    params.name = name
    local propHandles = PropSystem.CreateRuntimeProps({params})
    if PropSystem.IsValidRuntimeProp(propHandles[1]) then
      print(header .. "addproptype " .. name .. " " .. t.modelUID)
      PropSystem.DeleteRuntimeProp(propHandles[1])
    else
      print("<unspawnable proptype: " .. name .. ">")
    end
  end
  print(header .. "endproptypes")
end
function Pick(x, y, context, params)
  if params ~= nil and params.IgnoreMissionEditorVehicle ~= nil then
    params.IgnoreMissionEditorVehicle = GetReferenceFromID(params.IgnoreMissionEditorVehicle)
  end
  local results = physics.LinePick(x, y, params)
  if results.Position then
    print(header .. "Pick " .. context .. " " .. results.Position.x .. "," .. results.Position.y .. "," .. results.Position.z .. " " .. results.Normal.x .. "," .. results.Normal.y .. "," .. results.Normal.z .. " " .. results.CollisionType .. " " .. PrintPickSubtype(results))
  end
end
function PrintPickSubtype(results)
  if results.CollisionType == "dynamic" then
    if results.RuntimeProp then
      return PropSystem.GetRuntimePropID(results.RuntimeProp)
    end
  elseif results.CollisionType == "vehicle" then
    local ID = missionEditor.GetIDFromReference(results.VehicleType)
    if ID ~= nil then
      return "VehicleID" .. ID
    end
  elseif results.CollisionType == "static" then
  elseif results.CollisionType == "terrain" then
  end
  return ""
end
function CreateProp(params, context)
  local propHandles = PropSystem.CreateRuntimeProps({params})
  print(header .. "CreateRuntimeProp " .. PropSystem.GetRuntimePropID(propHandles[1]) .. " " .. context)
end
function IsValidProp(ID, context)
  local propHandle = PropSystem.GetRuntimeProp(ID)
  if PropSystem.IsValidRuntimeProp(propHandle) then
    print(header .. "ValidRuntimeProp " .. ID .. " " .. context)
  else
    print(header .. "InvalidRuntimeProp " .. ID .. " " .. context)
  end
end
function DeleteProp(ID)
  local propHandle = PropSystem.GetRuntimeProp(ID)
  if PropSystem.IsValidRuntimeProp(propHandle) then
    PropSystem.DeleteRuntimeProp(propHandle)
    print(header .. "DeleteRuntimeProp " .. ID)
  else
    print(header .. "InvalidRuntimeProp " .. ID)
  end
end
function UpdateProp(ID, params)
  local propHandle = PropSystem.GetRuntimeProp(ID)
  if PropSystem.IsValidRuntimeProp(propHandle) then
    PropSystem.UpdateRuntimeProp(propHandle, params)
    print(header .. "UpdateRuntimeProp " .. ID)
  else
    print(header .. "InvalidRuntimeProp " .. ID)
  end
end
function GetPropTransform(ID)
  local propHandle = PropSystem.GetRuntimeProp(ID)
  if PropSystem.IsValidRuntimeProp(propHandle) then
    matrix = PropSystem.GetRuntimePropTransform(propHandle)
    matrix2 = matrix
    print(header .. "PropTransform " .. ID .. " " .. matrix2[0][0] .. "," .. matrix2[0][1] .. "," .. matrix2[0][2] .. "," .. matrix2[0][3] .. "," .. matrix2[1][0] .. "," .. matrix2[1][1] .. "," .. matrix2[1][2] .. "," .. matrix2[1][3] .. "," .. matrix2[2][0] .. "," .. matrix2[2][1] .. "," .. matrix2[2][2] .. "," .. matrix2[2][3] .. "," .. matrix2[3][0] .. "," .. matrix2[3][1] .. "," .. matrix2[3][2] .. "," .. matrix2[3][3])
  else
    print(header .. "InvalidRuntimeProp " .. ID)
  end
end
function GetCameraTransform()
  local camera = free_camera or game_camera
  local matrix = camera.matrix
  local output = header .. "CameraTransform " .. matrix[0][0] .. "," .. matrix[0][1] .. "," .. matrix[0][2] .. "," .. matrix[0][3] .. "," .. matrix[1][0] .. "," .. matrix[1][1] .. "," .. matrix[1][2] .. "," .. matrix[1][3] .. "," .. matrix[2][0] .. "," .. matrix[2][1] .. "," .. matrix[2][2] .. "," .. matrix[2][3] .. "," .. matrix[3][0] .. "," .. matrix[3][1] .. "," .. matrix[3][2] .. "," .. matrix[3][3]
  print(output)
end
function SetCameraTransform(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p)
  configureFreeCamMatrix(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p)
end
function MoveCamera(x, y, z)
  local camera = free_camera or game_camera
  local matrix = camera.matrix
  matrix[3][0] = matrix[3][0] + matrix[0][0] * x * 5
  matrix[3][1] = matrix[3][1] + matrix[0][1] * x * 5
  matrix[3][2] = matrix[3][2] + matrix[0][2] * x * 5
  matrix[3][0] = matrix[3][0] + matrix[1][0] * y * 5
  matrix[3][1] = matrix[3][1] + matrix[1][1] * y * 5
  matrix[3][2] = matrix[3][2] + matrix[1][2] * y * 5
  matrix[3][0] = matrix[3][0] + matrix[2][0] * z * 2
  matrix[3][1] = matrix[3][1] + matrix[2][1] * z * 2
  matrix[3][2] = matrix[3][2] + matrix[2][2] * z * 2
  configureFreeCamMatrix(matrix[0][0], matrix[1][0], matrix[2][0], matrix[3][0], matrix[0][1], matrix[1][1], matrix[2][1], matrix[3][1], matrix[0][2], matrix[1][2], matrix[2][2], matrix[3][2], matrix[0][3], matrix[1][3], matrix[2][3], matrix[3][3])
end
function TurnCamera(x, y, z)
  local camera = free_camera or game_camera
  local xRotation = createRotationAroundAxis(camera.matrix[0], x * 1)
  local yRotation = createRotationAroundAxis(camera.matrix[1], y * 1)
  matrix = xRotation * yRotation * camera.matrix
  matrix[3] = camera.matrix[3]
  matrix = CreateLookAtMatrix(matrix[3], matrix[3] - matrix[2])
  configureFreeCamMatrix(matrix[0][0], matrix[1][0], matrix[2][0], matrix[3][0], matrix[0][1], matrix[1][1], matrix[2][1], matrix[3][1], matrix[0][2], matrix[1][2], matrix[2][2], matrix[3][2], matrix[0][3], matrix[1][3], matrix[2][3], matrix[3][3])
end
function GetReferenceFromID(runtimeID)
  return missionEditor.Vehicles[runtimeID]
end
function GetIDFromReference(vehicleReference)
  for key, value in pairs(missionEditor.Vehicles) do
    if value == vehicleReference then
      return key
    end
  end
  return nil
end
function AddReference(vehicleReference, runtimeID)
  missionEditor.Vehicles[runtimeID] = vehicleReference
end
function RemoveReference(runtimeID)
  missionEditor.Vehicles[runtimeID] = nil
end
function spawnVehicleInternal(parameters)
  parameters.gameVehicle = GameVehicleResource.create({
    SnapToTerrain = parameters.snapToTerrain or true,
    Model_Id = parameters.modelID,
    ShaderParams = parameters.shader,
    Matrix = parameters.matrix,
    Position = parameters.position,
    Heading = parameters.heading,
    InitialVelocity = parameters.initialVelocity,
    DisableHandbrake = parameters.disableHandbrake or false,
    MinKillDamageChange = parameters.minKillDamageChange or 0.05
  })
  return parameters.gameVehicle
end
function SpawnVehicle(params, runtimeID)
  local actor = {
    characters = {
      0,
      -1,
      -1,
      -1
    }
  }
  local vehicleSpawn = missionEditor.spawnVehicleInternal({
    modelID = params.model,
    matrix = params.matrix,
    initialVelocity = 0
  })
  missionEditor.AddReference(vehicleSpawn, runtimeID)
end
function DeleteVehicle(runtimeID)
  local vehicleSpawn = missionEditor.GetReferenceFromID(runtimeID)
  GameVehicleResource.destroy(vehicleSpawn)
  missionEditor.RemoveReference(runtimeID)
end
function UpdateVehicle(runtimeID, params)
  local vehicleSpawn = missionEditor.GetReferenceFromID(runtimeID)
  if vehicleSpawn ~= nil then
    vehicleSpawn.matrix = params.matrix
  end
end
function GetVehicleTransform(ID)
  local vehicleSpawn = missionEditor.GetReferenceFromID(ID)
  local matrix2 = vehicleSpawn.matrix
  print(header .. "PropTransform " .. ID .. " " .. matrix2[0][0] .. "," .. matrix2[0][1] .. "," .. matrix2[0][2] .. "," .. matrix2[0][3] .. "," .. matrix2[1][0] .. "," .. matrix2[1][1] .. "," .. matrix2[1][2] .. "," .. matrix2[1][3] .. "," .. matrix2[2][0] .. "," .. matrix2[2][1] .. "," .. matrix2[2][2] .. "," .. matrix2[2][3] .. "," .. matrix2[3][0] .. "," .. matrix2[3][1] .. "," .. matrix2[3][2] .. "," .. matrix2[3][3])
end
function ReplaceVehicle(params, runtimeID)
  missionEditor.DeleteVehicle(runtimeID)
  missionEditor.SpawnVehicle(params, runtimeID)
end
function GetTrafficChapter()
  local chapter = string.gsub(spooling.previousTrafficSet, " ", "_")
  print(header .. "TrafficChapter " .. chapter)
end
function SwitchToFreecam()
  allowFreeCam(true)
  while localPlayer.cameraMode ~= "FreeCam" do
    cycleActiveCamera("JustPressed", 1, 0)
  end
end
function ShowCursor()
  print("missionEditor - ShowCursor( )")
  physics.ShowCursor()
end
function DisableTraffic()
  print("missionEditor - DisableTraffic( )")
  spooling.enableTraffic(false)
end
function EnableTraffic()
  print("missionEditor - EnableTraffic()")
  spooling.enableTraffic(true)
end
function ZoomTo(x, y, z, rotation)
  SwitchToFreecam()
  spoolsystem.EnableCameraTracking()
  local matrix = vec.matrix()
  local trans = vec.matrix()
  trans[3][0] = x
  trans[3][1] = y
  trans[3][2] = z
  local currentRotation = setXRotation(rotation)
  matrix = matrix * trans
  matrix = matrix * currentRotation
  free_camera.matrix = matrix
end
