module("localPlayer.cameraSupport", package.seeall)
function zoomLookToPosition(params)
  assert(params.position ~= nil, "zoomLookToPosition() requires at least a position value to be passed into the params table")
  params.zoomWait = params.zoomWait or 0
  params.zoomInDuration = params.zoomInDuration or 1.5
  params.zoomHoldDuration = params.zoomHoldDuration or 2
  params.zoomOutDuration = params.zoomOutDuration or 1.5
  params.zoomFOV = params.zoomFOV or 0.3
  params.offset = params.offset or vec.vector()
  local function doCameraZoomScene()
    local oldFov = game_camera.fov
    local oldLookAt = game_camera.matrix[3] + game_camera.matrix[2] * -5
    if localPlayer.cameraMode ~= "Normal" then
    end
    offset = vec.vector() + params.offset
    do return end
    offset = vec.vector(0, 3, 0, 0) + params.offset
    OneShotSound.Play("HUD_Mis_CameraZoom_Play")
    local zoomScene = {
      {
        {
          action = "callback",
          callback = function()
            if localPlayer.cameraMode == "Bumper" then
              VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
            end
          end
        },
        {
          action = "behaviour",
          type = "Dynamic_Vehicle_Chase",
          gameVehicle = localPlayer.currentVehicle.gameVehicle,
          duration = 0.01
        },
        {
          action = "pauseSimulation",
          audioPauseEvent = "Simulation_Pause",
          audioResumeEvent = "Simulation_Resume"
        }
      },
      {
        action = "blend",
        blendFunction = "slerp",
        lookAt = params.position,
        fov = params.zoomFOV,
        duration = params.zoomInDuration
      },
      {
        action = "callback",
        callback = function()
          if params.holdCallback then
            params.holdCallback()
          end
        end
      },
      {
        duration = params.zoomHoldDuration
      },
      {
        action = "blend",
        blendFunction = "slerp",
        lookAt = oldLookAt,
        fov = oldFov,
        duration = params.zoomOutDuration
      },
      {
        action = "resumeSimulation"
      },
      {
        action = "callback",
        callback = function()
          OneShotSound.Play("HUD_Mis_CameraZoom_Stop")
          if localPlayer.cameraMode == "Bumper" then
            VehicleSystem.setPlayerVehicleVisible(0, localPlayer.localID)
          end
          localPlayer.simulationSupport.doSpeedUp(function()
            localPlayer:exitCutsceneMode()
          end)
          if params.endCallback then
            params.endCallback()
          end
        end
      }
    }
    if not params.zoomOutEnable then
      table.remove(zoomScene, 6)
    end
    if params.agent then
      zoomScene[2] = {
        action = "blend",
        blendFunction = "slerp",
        lookAt = params.agent.gameVehicle,
        lookAtOffset = offset,
        lookAtAttached = true,
        fov = params.zoomFOV,
        duration = params.zoomInDuration
      }
    end
    if localPlayer.cameraMode == "Normal" then
      zoomScene[1][2] = {
        action = "behaviour",
        type = "Existing",
        camera = game_camera,
        duration = 0.01
      }
    end
    CameraSystem.AddScene(zoomScene)
    localPlayer:enterCutsceneMode({hideVehicle = true})
  end
  localPlayer:enterCutsceneMode()
  localPlayer.simulationSupport.doSlowDown(function()
    if params.startCallback then
      params.startCallback()
    end
    localPlayer.simulationSupport.doWait(params.zoomWait, doCameraZoomScene)
  end)
end
function zoomLookToAgent(params)
  params.position = params.agent.position
  if params.agent.gameVehicle then
    params.position.y = params.position.y + params.agent.gameVehicle.height / 2
  end
  zoomLookToPosition(params)
end
function zoomLookToAgentDestroyed(params)
  params.position = params.agent.position
  if params.agent.gameVehicle then
    params.position.y = params.position.y + params.agent.gameVehicle.height / 2
    params.zoomFOV = 1.3
  end
  zoomLookToPosition(params)
end
function zoomLookToGameVehicleWithinRadius(params)
  local canSeeVehicle = false
  local vehicleList = TrafficSystem.vehicleList(params.agent.position, params.radius)
  for k, vehicle in next, vehicleList, nil do
    if vehicle.model_id == params.vehicleID then
      params.agent = {
        gameVehicle = vehicle,
        position = vehicle.position
      }
      zoomLookToAgent(params)
      canSeeVehicle = true
    end
  end
  return canSeeVehicle
end
local workingVector = vec.vector()
local offset = vec.vector(0, 1.5, 0, 0)
local offsetPosition = vec.vector()
function addCanSeeCheck(callback, target, distanceAllowed, lookFrom)
  local lineCheckParams = {}
  local collisionResults
  local collisionResult = false
  offsetPosition = offsetPosition:add(target.position, offset)
  addUserUpdateFunction("CanSeeCheck" .. tostring(callback), function()
    collisionResult = false
    if lookFrom and lookFrom.position then
      lineCheckParams.Position = lookFrom.position
      lineCheckParams.Position.y = lineCheckParams.Position.y + 1.5
      lineCheckParams.IgnoreGameVehicles = {
        lookFrom.gameVehicle,
        target.gameVehicle
      }
    else
      lineCheckParams.Position = game_camera.matrix[3]
      lineCheckParams.IgnoreGameVehicles = {
        target.gameVehicle
      }
    end
    workingVector = workingVector:sub(offsetPosition, lineCheckParams.Position)
    lineCheckParams.Length = workingVector:length()
    if not distanceAllowed or lineCheckParams.Length <= distanceAllowed then
      lineCheckParams.Heading = workingVector:normalise()
      collisionResults = physics.LineCheck(lineCheckParams)
      local intercept = round(collisionResults.Intercept, 1)
      local actualDistance = round(lineCheckParams.Length, 2)
      if intercept >= actualDistance then
        collisionResult = true
      end
    end
    callback(collisionResult)
  end, 5)
end
function removeCanSeeCheck(callback)
  removeUserUpdateFunction("CanSeeCheck" .. tostring(callback))
end
function slowActionCamera(vehicle, speed, exitCar, scene, targetOffset, lookFromVehicle, duration, zoom, overlay, callback)
  local actionTime = duration or 1.1 * speed * 2
  local endFov = zoom or 1.308
  local atOffset = targetOffset or vec.vector(0, 0, 0, 0)
  local fromOffset = scene or vec.vector(5, 1, 3, 0)
  local challengeCompleteScene = {
    {
      {
        action = "callback",
        callback = function()
          localPlayer.simulationSupport.doSlowDown(nil, speed)
        end
      }
    },
    {
      {
        action = "attach",
        lookAt = vehicle,
        lookFrom = lookFromVehicle or vehicle,
        duration = actionTime / 5,
        lookFromOffset = fromOffset,
        lookFromAttached = true,
        lookAtOffset = atOffset,
        fov = 1.308
      }
    },
    {
      {
        action = "blend",
        fov = endFov,
        lookAt = vehicle,
        lookAtOffset = atOffset,
        lookFrom = lookFromVehicle or vehicle,
        lookFromOffset = fromOffset,
        lookFromAttached = true,
        lookAtAttached = true,
        blendFunction = "lerp",
        duration = actionTime / 4
      }
    },
    {
      {
        action = "callback",
        callback = function()
          localPlayer.simulationSupport.doSpeedUp(function()
            if exitCar and not localPlayer.inZap then
              localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
            end
          end, 0.1)
          localPlayer:exitCutsceneMode()
          if localPlayer.cameraMode == "Bumper" then
            VehicleSystem.setPlayerVehicleVisible(0, localPlayer.localID)
          end
          if overlay then
            feedbackSystem.menusMaster.masterSetVariable("iTV_Cam", 0)
            feedbackSystem.showHUDPanels(true)
          end
          if callback then
            callback()
          end
        end
      }
    }
  }
  localPlayer:enterCutsceneMode()
  if localPlayer.cameraMode == "Bumper" then
    VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
  end
  if overlay then
    feedbackSystem.showHUDPanels(false)
    feedbackSystem.menusMaster.masterSetVariable("iTV_Cam", 1)
  end
  CameraSystem.AddScene(challengeCompleteScene)
end
function trafficEnableCamera()
  local timerStart = g_NetworkTime
  local function fadeIn()
    if g_NetworkTime - timerStart > 0.1 then
      spooling.fadeIn(nil, 0.2)
      removeUserUpdateFunction("Showing")
    end
  end
  local function trafficShow()
    spooling.enableTraffic(true)
    addUserUpdateFunction("Showing", fadeIn, 10, true)
  end
  if not localPlayer.inCutscene then
    spooling.fadeOut(nil, 0, trafficShow)
  end
end
function miniSceneCamera()
  if localPlayer.cameraMode == "Bumper" or localPlayer.cameraMode == "Bonnet" then
    if localPlayer.cameraMode == "Bumper" then
      VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
    end
    CameraSystemRegisterUpdate(localPlayer.camName, localPlayer.camera, "simulation", Camera_Function_Vehicle_Driver_Eye_Cam, {
      agent = localPlayer.currentVehicle,
      pad = localPlayer.gamepad
    })
  end
end
function tutorialSceneCamera()
  CameraSystemRegisterUpdate(localPlayer.camName, localPlayer.camera, "simulation", Camera_Function_Vehicle_Dynamic_Chase_Cam, {
    agent = localPlayer.currentVehicle,
    pad = localPlayer.gamepad
  })
end
