scenePreviewer = {}
scenePreviewer.ModelDataPath = "COM:LuaScripts\\scenePreviewer\\Models\\"
scenePreviewer.ModelContainerID = -1
scenePreviewer.ModelIndex = 0
scenePreviewer.ModelUID = ""
scenePreviewer.myModel = 0
scenePreviewer.ModelInstanced = false
scenePreviewer.RenderMethod = "Default"
scenePreviewer.Camera = 0
function scenePreviewer.ClearInstances()
  renderer._instances = {}
  renderer._uidinstances = {}
end
function scenePreviewer.Close()
  if scenePreviewer.ModelContainerID ~= -1 then
    renderer.unloadModelContainer(scenePreviewer.myModel)
    scenePreviewer.ModelContainerID = -1
    scenePreviewer.ModelIndex = 0
    scenePreviewer.ModelUID = ""
    scenePreviewer.ClearInstances()
  end
end
function scenePreviewer.Open(filename)
  if scenePreviewer.ModelContainerID ~= -1 then
    print("Unloading last modelcontainer")
    scenePreviewer.Close()
  end
  print("Lua Loading : ", scenePreviewer.ModelDataPath .. filename)
  scenePreviewer.myModel = renderer.loadModelContainer(scenePreviewer.ModelDataPath .. filename)
  scenePreviewer.ModelContainerID = 4096
end
function scenePreviewer.OpenLatest()
  scenePreviewer.Open("latest.model")
end
function scenePreviewer.PrintInstances()
  printTable(renderer._instances)
end
function scenePreviewer.AmIActive()
  print("<PREVIEWER><TAGTYPE=GAMEISLOADED>")
end
function scenePreviewer.CreateInstanceInFrontOfCamera(id)
  if scenePreviewer.ModelContainerID ~= -1 then
    print("Creating instance of loaded model")
    v = renderer.viewports.main
    t = scenePreviewer.Camera.matrix
    t[3] = t[3] - 5 * t[2]
    renderer.addInstance(v, scenePreviewer.ModelContainerID, id or scenePreviewer.ModelIndex, t)
  else
    print("Model not yet loaded")
  end
end
function scenePreviewer.CreateInstanceAtOrigin()
  if scenePreviewer.ModelContainerID ~= -1 then
    print("Creating instance of loaded model")
    v = renderer.viewports.main
    t = vec.matrix()
    renderer.addInstance(v, scenePreviewer.ModelContainerID, scenePreviewer.ModelIndex, t)
  else
    print("Model not yet loaded")
  end
end
function scenePreviewer.SetModelIndex(id)
  print("changing model ID")
  scenePreviewer.ModelIndex = id
end
function scenePreviewer.CreateDummyInstanceAtOrigin()
  v = renderer.viewports.main
  t = vec.matrix()
  renderer.addInstance(v, 0, scenePreviewer.ModelIndex, t)
  print("Created instance of loaded model DUMMY")
end
function scenePreviewer.CreateInstanceIDAtOrigin(id)
  if scenePreviewer.ModelContainerID ~= -1 then
    scenePreviewer.ClearInstances()
    scenePreviewer.SetModelIndex(id)
    scenePreviewer.CreateInstanceAtOrigin()
  end
end
function scenePreviewer.NewFormat_InternalCreateInstanceAtOrigin()
  if scenePreviewer.ModelContainerID ~= -1 then
    if scenePreviewer.ModelUID ~= "" then
      print("In:NewFormat_InternalCreateInstanceAtOrigin")
      v = renderer.viewports.main
      t = vec.matrix()
      renderer.addInstance_uid(v, scenePreviewer.ModelUID, t, scenePreviewer.RenderMethod)
    else
      print("Model not selected")
    end
  else
    print("Conatiner not yet loaded")
  end
end
function scenePreviewer.NewFormat_SetModelUID(UID)
  print("changing model UID")
  scenePreviewer.ModelUID = UID
end
function scenePreviewer.NewFormat_CreateInstanceAtOrigin(UID, clear)
  print("Creating instance of loaded model (new model format) : ", UID)
  if scenePreviewer.ModelContainerID ~= -1 then
    if clear ~= 0 then
      scenePreviewer.ClearInstances()
    end
    scenePreviewer.NewFormat_SetModelUID(UID)
    scenePreviewer.NewFormat_InternalCreateInstanceAtOrigin()
  end
end
function scenePreviewer.NewFormat_CreateInstance(UID, clear, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16)
  print("Creating instance of loaded model (new model format) : ", UID)
  if scenePreviewer.ModelContainerID ~= -1 then
    if clear ~= 0 then
      scenePreviewer.ClearInstances()
    end
    scenePreviewer.NewFormat_SetModelUID(UID)
    v = renderer.viewports.main
    t = vec.matrix(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16)
    renderer.addInstance_uid(v, scenePreviewer.ModelUID, t, scenePreviewer.RenderMethod)
  end
end
function scenePreviewer.NewFormat_SetRenderMethod(RenderMethod)
  print("changing Render Method to : ", RenderMethod)
  scenePreviewer.RenderMethod = RenderMethod
  scenePreviewer.NewFormat_CreateInstance(scenePreviewer.ModelUID, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
end
function scenePreviewer.SetTimeOfDay(hours, minutes)
  lifeEnvironment.setLifeTime(hours, minutes)
end
function scenePreviewer.TurnOnLuaCamera(iToggle)
end
function scenePreviewer.SetCurrentCameraMatrix(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16)
  if scenePreviewer.Camera == 0 then
    scenePreviewer.Camera = CameraSystem.CreateCamera()
    scenePreviewer.Camera.viewport = 0
  end
  scenePreviewer.Camera.matrix = vec.matrix(m1, m5, m9, m13, m2, m6, m10, m14, m3, m7, m11, m15, m4, m8, m12, m16)
end
function scenePreviewer.SetCurrentCameraMatrixFOV(fov, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16)
  if scenePreviewer.Camera == 0 then
    scenePreviewer.Camera = CameraSystem.CreateCamera()
    scenePreviewer.Camera.viewport = 0
  end
  scenePreviewer.Camera.fov = fov
  scenePreviewer.Camera.matrix = vec.matrix(m1, m5, m9, m13, m2, m6, m10, m14, m3, m7, m11, m15, m4, m8, m12, m16)
end
function scenePreviewer.SetCurrentCameraFOV(fov)
  if scenePreviewer.Camera == 0 then
    scenePreviewer.Camera = CameraSystem.CreateCamera()
    scenePreviewer.Camera.viewport = 0
  end
  scenePreviewer.Camera.fov = fov
end
function scenePreviewer.GetCurrentCameraMatrix()
  if scenePreviewer.Camera ~= 0 then
    local mat = scenePreviewer.Camera.matrix
    local strRow1 = mat[0][0] .. "," .. mat[0][1] .. "," .. mat[0][2] .. "," .. mat[0][3] .. ","
    local strRow2 = mat[1][0] .. "," .. mat[1][1] .. "," .. mat[1][2] .. "," .. mat[1][3] .. ","
    local strRow3 = mat[2][0] .. "," .. mat[2][1] .. "," .. mat[2][2] .. "," .. mat[2][3] .. ","
    local strRow4 = mat[3][0] .. "," .. mat[3][1] .. "," .. mat[3][2] .. "," .. mat[3][3]
    print("<PREVIEWER><TAGTYPE=CAMERAMATRIX><DATA=" .. strRow1 .. strRow2 .. strRow3 .. strRow4 .. ">")
  end
end
function scenePreviewer.GetCurrentCameraFOV()
  if scenePreviewer.Camera ~= 0 then
    local fov = scenePreviewer.Camera.fov
    print("<PREVIEWER><TAGTYPE=CAMERAFOV><DATA=" .. fov .. ">")
  end
end
mp = scenePreviewer
function updatescenePreviewer()
  print("SCENE PREVIEWER TICKED")
  removeUserUpdateFunction("scenePreviewer")
end
addUserUpdateFunction("scenePreviewer", updatescenePreviewer, 1)
