ModelPreviewer = {}
ModelPreviewer.ModelDataPath = "COM:LuaScripts\\ModelPreviewer\\Models\\"
ModelPreviewer.ModelContainerID = -1
ModelPreviewer.ModelIndex = 0
ModelPreviewer.ModelUID = ""
ModelPreviewer.myModel = 0
ModelPreviewer.ModelInstanced = false
ModelPreviewer.RenderMethod = "Default"
ModelPreviewer.Camera = 0
function ModelPreviewer.ClearInstances()
  renderer._instances = {}
  renderer._uidinstances = {}
end
function ModelPreviewer.Close()
  if ModelPreviewer.ModelContainerID ~= -1 then
    renderer.unloadModelContainer(ModelPreviewer.myModel)
    ModelPreviewer.ModelContainerID = -1
    ModelPreviewer.ModelIndex = 0
    ModelPreviewer.ModelUID = ""
    ModelPreviewer.ClearInstances()
  end
end
function ModelPreviewer.Open(filename)
  if ModelPreviewer.ModelContainerID ~= -1 then
    print("Unloading last modelcontainer")
    ModelPreviewer.Close()
  end
  print("Lua Loading : ", ModelPreviewer.ModelDataPath .. filename)
  ModelPreviewer.myModel = renderer.loadModelContainer(ModelPreviewer.ModelDataPath .. filename)
  ModelPreviewer.ModelContainerID = 4096
end
function ModelPreviewer.OpenLatest()
  ModelPreviewer.Open("latest.model")
end
function ModelPreviewer.PrintInstances()
  printTable(renderer._instances)
end
function ModelPreviewer.AmIActive()
  print("<PREVIEWER><TAGTYPE=GAMEISLOADED>")
end
function ModelPreviewer.CreateInstanceInFrontOfCamera(id)
  if ModelPreviewer.ModelContainerID ~= -1 then
    print("Creating instance of loaded model")
    v = renderer.viewports.main
    t = ModelPreviewer.Camera.matrix
    t[3] = t[3] - 5 * t[2]
    renderer.addInstance(v, ModelPreviewer.ModelContainerID, id or ModelPreviewer.ModelIndex, t)
  else
    print("Model not yet loaded")
  end
end
function ModelPreviewer.CreateInstanceAtOrigin()
  if ModelPreviewer.ModelContainerID ~= -1 then
    print("Creating instance of loaded model")
    v = renderer.viewports.main
    t = vec.matrix()
    renderer.addInstance(v, ModelPreviewer.ModelContainerID, ModelPreviewer.ModelIndex, t)
  else
    print("Model not yet loaded")
  end
end
function ModelPreviewer.SetModelIndex(id)
  print("changing model ID")
  ModelPreviewer.ModelIndex = id
end
function ModelPreviewer.CreateDummyInstanceAtOrigin()
  v = renderer.viewports.main
  t = vec.matrix()
  renderer.addInstance(v, 0, ModelPreviewer.ModelIndex, t)
  print("Created instance of loaded model DUMMY")
end
function ModelPreviewer.CreateInstanceIDAtOrigin(id)
  if ModelPreviewer.ModelContainerID ~= -1 then
    ModelPreviewer.ClearInstances()
    ModelPreviewer.SetModelIndex(id)
    ModelPreviewer.CreateInstanceAtOrigin()
  end
end
function ModelPreviewer.NewFormat_InternalCreateInstanceAtOrigin()
  if ModelPreviewer.ModelContainerID ~= -1 then
    if ModelPreviewer.ModelUID ~= "" then
      print("In:NewFormat_InternalCreateInstanceAtOrigin")
      v = renderer.viewports.main
      t = vec.matrix()
      renderer.addInstance_uid(v, ModelPreviewer.ModelUID, t, ModelPreviewer.RenderMethod)
    else
      print("Model not selected")
    end
  else
    print("Conatiner not yet loaded")
  end
end
function ModelPreviewer.NewFormat_SetModelUID(UID)
  print("changing model UID")
  ModelPreviewer.ModelUID = UID
end
function ModelPreviewer.NewFormat_CreateInstanceAtOrigin(UID, clear)
  print("Creating instance of loaded model (new model format) : ", UID)
  if ModelPreviewer.ModelContainerID ~= -1 then
    if clear ~= 0 then
      ModelPreviewer.ClearInstances()
    end
    ModelPreviewer.NewFormat_SetModelUID(UID)
    ModelPreviewer.NewFormat_InternalCreateInstanceAtOrigin()
  end
end
function ModelPreviewer.NewFormat_CreateInstance(UID, clear, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16)
  print("Creating instance of loaded model (new model format) : ", UID)
  if ModelPreviewer.ModelContainerID ~= -1 then
    if clear ~= 0 then
      ModelPreviewer.ClearInstances()
    end
    ModelPreviewer.NewFormat_SetModelUID(UID)
    v = renderer.viewports.main
    t = vec.matrix(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16)
    renderer.addInstance_uid(v, ModelPreviewer.ModelUID, t, ModelPreviewer.RenderMethod)
  end
end
function ModelPreviewer.NewFormat_SetRenderMethod(RenderMethod)
  print("changing Render Method to : ", RenderMethod)
  ModelPreviewer.RenderMethod = RenderMethod
  ModelPreviewer.NewFormat_CreateInstance(ModelPreviewer.ModelUID, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
end
function ModelPreviewer.SetTimeOfDay(hours, minutes)
  lifeEnvironment.setLifeTime(hours, minutes)
end
function ModelPreviewer.TurnOnLuaCamera(iToggle)
end
function ModelPreviewer.SetCurrentCameraMatrix(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16)
  if ModelPreviewer.Camera == 0 then
    ModelPreviewer.Camera = CameraSystem.CreateCamera()
    ModelPreviewer.Camera.viewport = 0
  end
  ModelPreviewer.Camera.matrix = vec.matrix(m1, m5, m9, m13, m2, m6, m10, m14, m3, m7, m11, m15, m4, m8, m12, m16)
end
function ModelPreviewer.SetCurrentCameraMatrixFOV(fov, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16)
  if ModelPreviewer.Camera == 0 then
    ModelPreviewer.Camera = CameraSystem.CreateCamera()
    ModelPreviewer.Camera.viewport = 0
  end
  ModelPreviewer.Camera.fov = fov
  ModelPreviewer.Camera.matrix = vec.matrix(m1, m5, m9, m13, m2, m6, m10, m14, m3, m7, m11, m15, m4, m8, m12, m16)
end
function ModelPreviewer.SetCurrentCameraFOV(fov)
  if ModelPreviewer.Camera == 0 then
    ModelPreviewer.Camera = CameraSystem.CreateCamera()
    ModelPreviewer.Camera.viewport = 0
  end
  ModelPreviewer.Camera.fov = fov
end
function ModelPreviewer.GetCurrentCameraMatrix()
  if ModelPreviewer.Camera ~= 0 then
    local mat = ModelPreviewer.Camera.matrix
    local strRow1 = mat[0][0] .. "," .. mat[0][1] .. "," .. mat[0][2] .. "," .. mat[0][3] .. ","
    local strRow2 = mat[1][0] .. "," .. mat[1][1] .. "," .. mat[1][2] .. "," .. mat[1][3] .. ","
    local strRow3 = mat[2][0] .. "," .. mat[2][1] .. "," .. mat[2][2] .. "," .. mat[2][3] .. ","
    local strRow4 = mat[3][0] .. "," .. mat[3][1] .. "," .. mat[3][2] .. "," .. mat[3][3]
    print("<PREVIEWER><TAGTYPE=CAMERAMATRIX><DATA=" .. strRow1 .. strRow2 .. strRow3 .. strRow4 .. ">")
  end
end
function ModelPreviewer.GetCurrentCameraFOV()
  if ModelPreviewer.Camera ~= 0 then
    local fov = ModelPreviewer.Camera.fov
    print("<PREVIEWER><TAGTYPE=CAMERAFOV><DATA=" .. fov .. ">")
  end
end
mp = ModelPreviewer
function updateModelPreviewer()
  print("TICKED")
  removeUserUpdateFunction("ModelPreviewer")
end
addUserUpdateFunction("ModelPreviewer", updateModelPreviewer, 1)
