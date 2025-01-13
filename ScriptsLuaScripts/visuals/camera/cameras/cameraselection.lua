free_camera = nil
local freeCamAllowed = false
local freeCamOnlyAllowed = false
local freeCamAIDebugAllowed = false
local cameraList = {}
local blockedModes = {
  [0] = {},
  [1] = {}
}
local cameraOffset = vec.matrix(-1, 0, 0, 0, 0, 1, 0, 2.4, 0, 0, -1, -6.7, 0, 0, 0, 1)
local createFreeCam = function(matrix)
  if not free_camera then
    free_camera = CameraSystem.CreateCamera()
    free_camera.matrix = matrix
    game_camera.viewport = nil
    if GetHUDOn() then
      Menu.ShowHUD = 0
      Menu.HideUI = 0
    end
  end
  free_camera.viewport = 0
  CameraSystem.EnableLuaDebugCameras(true)
  return free_camera
end
local deleteFreeCam = function()
  if GetHUDOn() then
    Menu.ShowHUD = 1
  end
  CameraSystem.EnableLuaDebugCameras(false)
  game_camera.viewport = 0
  if free_camera then
    local matrix = free_camera.matrix
    CameraSystemRegisterUpdate("Free_Cam", free_camera, "real", nil)
    CameraSystemRegisterUpdate("Free_Cam", free_camera, "simulation", nil)
    free_camera:delete()
    free_camera = nil
    return matrix
  end
end
local cameraModes = {
  Normal = {
    create = function(camOwner, matrix)
      CameraSystemRegisterUpdate(camOwner.camName, camOwner.camera, "simulation", Camera_Function_Vehicle_Dynamic_Chase_Cam, {
        agent = camOwner.currentVehicle,
        pad = camOwner.gamepad
      })
    end,
    cleanUp = function(camOwner)
      return game_camera.matrix
    end
  },
  DriverEye = {
    create = function(camOwner, matrix)
      CameraSystemRegisterUpdate(camOwner.camName, camOwner.camera, "simulation", Camera_Function_Vehicle_Driver_Eye_Cam, {
        agent = camOwner.currentVehicle,
        pad = camOwner.gamepad
      })
    end,
    cleanUp = function(camOwner)
      return game_camera.matrix
    end
  },
  Bonnet = {
    create = function(camOwner, matrix)
      CameraSystemRegisterUpdate(camOwner.camName, camOwner.camera, "simulation", Camera_Function_Vehicle_Bonnet_Cam, {
        agent = camOwner.currentVehicle,
        pad = camOwner.gamepad
      })
    end,
    cleanUp = function(camOwner)
      return game_camera.matrix
    end
  },
  Bumper = {
    create = function(camOwner, matrix)
      VehicleSystem.setPlayerVehicleVisible(0, camOwner.localID)
      CameraSystemRegisterUpdate(camOwner.camName, camOwner.camera, "simulation", Camera_Function_Vehicle_Dynamic_Bumper_Cam, {
        agent = camOwner.currentVehicle,
        pad = camOwner.gamepad
      })
    end,
    cleanUp = function(camOwner)
      VehicleSystem.setPlayerVehicleVisible(1, camOwner.localID)
      return game_camera.matrix
    end
  },
  ThrillCam = {
    create = function(camOwner, matrix)
      IntelligentCamera.SetFakeForeground(1)
    end,
    cleanUp = function(camOwner)
      IntelligentCamera.SetFakeForeground(0)
      return game_camera.matrix
    end
  },
  FreeCam = {
    create = function(camOwner, matrix)
      local matrix = localPlayer.currentVehicle.matrix:clone()
      matrix = matrix * cameraOffset
      createFreeCam(matrix)
      CameraSystemRegisterUpdate("Free_Cam", free_camera, gameStatus.simulationPaused and "simulation", Camera_Function_Free_Cam, {
        agent = camOwner.currentVehicle,
        pad = camOwner.gamepad
      })
    end,
    cleanUp = function(camOwner)
      controlHandler:resetState("FreeCam", camOwner.gamepad)
      controlHandler:removeState("FreeCam", camOwner.gamepad)
      controlHandler:resetState("StickCam", camOwner.gamepad)
      controlHandler:removeState("StickCam", camOwner.gamepad)
      return deleteFreeCam()
    end
  },
  DropCam = {
    create = function(camOwner, matrix)
      createFreeCam(matrix)
      CameraSystemRegisterUpdate("Free_Cam", free_camera, gameStatus.simulationPaused and "simulation", Camera_Function_LookAT_Cam, {
        agent = camOwner.currentVehicle,
        pad = camOwner.gamepad
      })
      controlHandler:setState("DropCam", 2)
      player.setAttachment(camOwner.localID, camOwner.currentVehicle.gameVehicle)
      player.registerController()
      camOwner.controllerInterface:registerPlayerControl()
    end,
    cleanUp = function(camOwner)
      controlHandler:resetState("DropCam", 2)
      return deleteFreeCam()
    end
  },
  AerialCam = {
    create = function(camOwner, matrix)
      createFreeCam(matrix)
      CameraSystemRegisterUpdate("Free_Cam", free_camera, gameStatus.simulationPaused and "simulation", Camera_Function_Aerial_Cam, {
        agent = camOwner.currentVehicle,
        pad = camOwner.gamepad
      })
    end,
    cleanUp = function(camOwner)
      return deleteFreeCam()
    end
  }
}
local cameraLists = {
  singlePlayer = {
    "Normal",
    "DriverEye",
    "Bonnet",
    "Bumper"
  },
  multiPlayer = {
    "Normal",
    "DriverEye",
    "Bonnet",
    "Bumper"
  },
  splitScreen = {
    "Normal",
    "DriverEye",
    "Bonnet",
    "Bumper"
  },
  freeCamOnly = {"Normal", "FreeCam"}
}
local debugCameras = {
  "FreeCam",
  "DropCam",
  "AerialCam"
}
function setPlayerCameras(mode, localID)
  if not freeCamOnlyAllowed then
    localID = localID or 0
    if cameraLists[mode] then
      cameraList[localID] = cameraLists[mode]
    end
  end
  if freeCamAllowed then
    allowFreeCam(freeCamAllowed)
  end
end
setPlayerCameras("singlePlayer", 0)
setPlayerCameras("splitScreen", 1)
function insertCameraMode(modeName, localID)
  if not freeCamOnlyAllowed then
    localID = localID or 0
    if cameraModes[modeName] then
      local found = false
      for __, mode in next, cameraList[localID], nil do
        if mode == modeName then
          found = true
          break
        end
      end
      if not found then
        table.insert(cameraList[localID], modeName)
      end
    end
  end
end
function removeCameraMode(modeName, localID)
  if not freeCamOnlyAllowed then
    localID = localID or 0
    for id, cameraMode in next, cameraList[localID], nil do
      if cameraMode == modeName then
        table.remove(cameraList[localID], id)
        break
      end
    end
    local camOwner = localPlayerManager.players[localID]
    if camOwner.cameraMode == modeName then
      cycleActiveCamera("JustPressed", 1, localID)
    end
  end
end
function blockCameraMode(modeName, localID, blockState)
  localID = localID or 0
  if blockState then
    blockedModes[localID][modeName] = true
    local camOwner = localPlayerManager.players[localID]
    if camOwner.cameraMode == modeName then
      local allowCamChange = not camOwner.inCutscene and (not camOwner.currentVehicle or not camOwner.currentVehicle.blockCamChange)
      if allowCamChange then
        cycleActiveCamera("JustPressed", 1, localID)
      else
        local loop = 0
        local found = false
        repeat
          while loop < #cameraList[localID] and not found do
            camOwner.currentMode = camOwner.currentMode + 1
            if camOwner.currentMode > #cameraList[localID] then
              camOwner.currentMode = 1
            end
            camOwner.cameraMode = cameraList[localID][camOwner.currentMode]
            found = true
          end
        until not blockedModes[localID][camOwner.cameraMode]
      end
    end
  else
    blockedModes[localID][modeName] = nil
  end
end
function allowFreeCam(allow)
  freeCamAllowed = allow
  if allow then
    for __, cameraMode in ipairs(debugCameras) do
      insertCameraMode(cameraMode, 0)
    end
  else
    for __, cameraMode in ipairs(debugCameras) do
      removeCameraMode(cameraMode, 0)
    end
  end
end
function freeCamOnly(allow)
  if allow then
    setPlayerCameras("freeCamOnly", localPlayer.loacalID)
  else
    setPlayerCameras("singlePlayer", localPlayer.loacalID)
  end
  freeCamOnlyAllowed = allow
end
function freeCamAIDebug(allow)
  freeCamOnly(allow)
  freeCamAIDebugAllowed = allow
end
function getFreeCamOnlyAllowed()
  return freeCamOnlyAllowed
end
function getFreeCamAIDebugAllowed()
  return freeCamAIDebugAllowed
end
function cycleActiveCamera(state, value, localID, recursionLength)
  local camOwner = localPlayerManager.players[localID]
  local allowCamChange = not camOwner.inCutscene and (not camOwner.currentVehicle or not camOwner.currentVehicle.blockCamChange)
  recursionLength = recursionLength or 0
  if allowCamChange then
    local previousMatrix = cameraModes[camOwner.cameraMode].cleanUp(camOwner)
    camOwner.currentMode = camOwner.currentMode + 1
    if camOwner.currentMode > #cameraList[localID] then
      camOwner.currentMode = 1
    end
    camOwner.cameraMode = cameraList[localID][camOwner.currentMode]
    if blockedModes[localID][camOwner.cameraMode] and recursionLength < #cameraList[localID] then
      cycleActiveCamera(state, value, localID, recursionLength + 1)
    else
      cameraModes[camOwner.cameraMode].create(camOwner, previousMatrix)
    end
    return true
  end
end
function setActiveCamera(modeName, localID)
  local camOwner = localPlayerManager.players[localID]
  local modeIDtoSet = false
  for modeID, currentModeName in ipairs(cameraList[localID]) do
    if currentModeName == modeName then
      local previousMatrix = cameraModes[camOwner.cameraMode].cleanUp(camOwner)
      camOwner.currentMode = modeID
      camOwner.cameraMode = cameraList[localID][camOwner.currentMode]
      cameraModes[camOwner.cameraMode].create(camOwner, previousMatrix)
      break
    end
  end
end
function cleanupActiveCamera(localID)
  local camOwner = localPlayerManager.players[localID]
  cameraModes[camOwner.cameraMode].cleanUp(camOwner)
end
function resetActiveCamera(localID)
  local camOwner = localPlayerManager.players[localID]
  cameraModes[camOwner.cameraMode].create(camOwner, previousMatrix)
end
function SetFreeCamMatrix(mtx, fov)
  EnableCameraPathSetup()
  free_camera.matrix = mtx
  free_camera.fov = fov
end
function PrintFreeCam(id)
  EnableCameraPathSetup()
  print("$CAMERASETUP$" .. id .. ":" .. free_camera.matrix[0][0] .. "," .. free_camera.matrix[0][1] .. "," .. free_camera.matrix[0][2] .. "," .. free_camera.matrix[0][3] .. "," .. free_camera.matrix[1][0] .. "," .. free_camera.matrix[1][1] .. "," .. free_camera.matrix[1][2] .. "," .. free_camera.matrix[1][3] .. "," .. free_camera.matrix[2][0] .. "," .. free_camera.matrix[2][1] .. "," .. free_camera.matrix[2][2] .. "," .. free_camera.matrix[2][3] .. "," .. free_camera.matrix[3][0] .. "," .. free_camera.matrix[3][1] .. "," .. free_camera.matrix[3][2] .. "," .. free_camera.matrix[3][3] .. ":" .. free_camera.fov)
end
function CameraPathSetupActionButton()
  PrintFreeCam(-1)
end
function CameraPathSetupZoomInButton()
  local fov = free_camera.fov
  fov = fov + 0.05
  if fov > 2.5 then
    fov = 2.5
  end
  free_camera.fov = fov
  PrintFreeCam(-2)
end
function CameraPathSetupZoomOutButton()
  local fov = free_camera.fov
  fov = fov - 0.05
  if fov < 0.1 then
    fov = 0.1
  end
  free_camera.fov = fov
  PrintFreeCam(-2)
end
function EnableCameraPathSetup()
  if not free_camera then
    free_camera = CameraSystem.CreateCamera()
    free_camera.matrix = game_camera.matrix
    game_camera.viewport = nil
    if GetHUDOn() then
      Menu.ShowHUD = 0
    end
  end
  CameraSystemRegisterUpdate("Free_Cam", free_camera, "real", Camera_Function_Free_Cam, nil)
  free_camera.viewport = 0
  player.setAttachment(localPlayer.localID, free_camera)
  stateTable = {
    Zap_In_Alt = {
      JustPressed = {
        [1] = CameraPathSetupActionButton
      }
    },
    Zap_Preview = {
      JustPressed = {
        [1] = CameraPathSetupZoomOutButton
      }
    },
    Zap_Cancel = {
      JustPressed = {
        [1] = CameraPathSetupZoomInButton
      }
    }
  }
  controlHandler:registerState(localPlayer.localID, "CameraPathSetup", stateTable)
  controlHandler:setState("CameraPathSetup")
end
function ExitCameraPathSetup()
  game_camera.viewport = 0
  if free_camera then
    CameraSystemRegisterUpdate("Free_Cam", free_camera, "real", nil)
    free_camera:delete()
    free_camera = nil
  end
  if GetHUDOn() then
    Menu.ShowHUD = 1
  end
  player.setAttachment(localPlayer.localID, localPlayer.currentVehicle.gameVehicle)
  localPlayer.controllerInterface:registerPlayerControl()
  controlHandler:resetState("CameraPathSetup")
end
