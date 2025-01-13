local settingsLookup = {
  framingExtremeWide = {
    camFunction = IntelligentCamera.SetFramingPreference,
    value = 0
  },
  framingVeryWide = {
    camFunction = IntelligentCamera.SetFramingPreference,
    value = 1
  },
  framingWide = {
    camFunction = IntelligentCamera.SetFramingPreference,
    value = 2
  },
  framingMid = {
    camFunction = IntelligentCamera.SetFramingPreference,
    value = 3
  },
  framingMediumClose = {
    camFunction = IntelligentCamera.SetFramingPreference,
    value = 4
  },
  framingCloseUp = {
    camFunction = IntelligentCamera.SetFramingPreference,
    value = 5
  },
  framingExtremeCloseUp = {
    camFunction = IntelligentCamera.SetFramingPreference,
    value = 6
  },
  angleYawFront = {
    camFunction = IntelligentCamera.SetAngleYawPreference,
    value = 0
  },
  angleYawFrontQuarter = {
    camFunction = IntelligentCamera.SetAngleYawPreference,
    value = 1
  },
  angleYawProfile = {
    camFunction = IntelligentCamera.SetAngleYawPreference,
    value = 2
  },
  angleYawRearQuarter = {
    camFunction = IntelligentCamera.SetAngleYawPreference,
    value = 3
  },
  angleYawRear = {
    camFunction = IntelligentCamera.SetAngleYawPreference,
    value = 4
  },
  anglepitchLow = {
    camFunction = IntelligentCamera.SetAnglePitchPreference,
    value = 0
  },
  anglepitchEye = {
    camFunction = IntelligentCamera.SetAnglePitchPreference,
    value = 1
  },
  anglepitchHigh = {
    camFunction = IntelligentCamera.SetAnglePitchPreference,
    value = 2
  },
  anglepitchBirds = {
    camFunction = IntelligentCamera.SetAnglePitchPreference,
    value = 3
  },
  anglepitchWorms = {
    camFunction = IntelligentCamera.SetAnglePitchPreference,
    value = 4
  }
}
local icamHighLODOccupantsGameVehicle = false
local function turnOccupantsHighLOD(gameVehicle)
  local highLODGameVehicle = vehicleManager.getHighLODGameVehicle()
  if not highLODGameVehicle or highLODGameVehicle ~= gameVehicle then
    local agent = vehicleManager.getAgentFromGameVehicle(gameVehicle)
    if not agent or not agent.controlled then
      vehicleManager.removeAllHighLODOccupants()
      GameVehicleResource.spoolOccupants(gameVehicle)
      GameVehicleResource.upgradeOccupants(gameVehicle)
      icamHighLODOccupantsGameVehicle = gameVehicle
    end
  end
end
local function resetOccupantsLOD()
  if icamHighLODOccupantsGameVehicle then
    GameVehicleResource.downgradeOccupants(icamHighLODOccupantsGameVehicle)
    vehicleManager.reapplyAllHighLODOccupants()
    icamHighLODOccupantsGameVehicle = false
  end
end
local function iCamApplyShotSettings(framing, angleyaw, anglepitch)
  for settingType, settingValue in next, iCamFramingSettings[framing], nil do
    settingsLookup[settingType].camFunction(settingsLookup[settingType].value, settingValue)
  end
  for settingType, settingValue in next, iCamAngleYawSettings[angleyaw], nil do
    settingsLookup[settingType].camFunction(settingsLookup[settingType].value, settingValue)
  end
  for settingType, settingValue in next, iCamAnglePitchSettings[anglepitch], nil do
    settingsLookup[settingType].camFunction(settingsLookup[settingType].value, settingValue)
  end
end
local vehiclesWithIcamSimulationAreaSet = {}
local StoredHudOn = false
local DoFlyCamAudio = false
function iCamDeActivation()
  resetOccupantsLOD()
  if localPlayer.inCutsceneOrIcam then
    IntelligentCamera.SetCallback(-1)
    localPlayer.inCutsceneOrIcam = nil
    if localPlayer.currentVehicle then
      localPlayer.currentVehicle:clearTrafficAheadOfVehicle()
    else
    end
    activeChallenges.enableCollectables()
    garage.hide(false)
    localPlayer:exitCutsceneMode()
    if DoFlyCamAudio then
      Sound.ExitAudioState("AuxAmbience")
      DoFlyCamAudio = false
    end
    if StoredHudOn then
      Menu.ShowHUD = 1
      StoredHudOn = false
    end
    if localPlayer.cameraMode == "Bumper" then
      VehicleSystem.setPlayerVehicleVisible(0, localPlayer.localID)
    end
    IntelligentCamera.SetName("Unknown")
    IntelligentCamera.ClearTargets()
    ReplaySystem.StopScriptedCamera()
    simulation.setSpeed(1)
    ReplaySystem.SetCameraSlowMo(1)
    for gameVehicle, boolean in next, vehiclesWithIcamSimulationAreaSet, nil do
      GameVehicleResource.removeVehicleSimulationArea(gameVehicle)
    end
    vehiclesWithIcamSimulationAreaSet = {}
  end
end
local function addSimulationArea(gameVehicle)
  local ignore = true
  local agent = vehicleManager.getAgentFromGameVehicle(gameVehicle)
  if not agent or agent.controlled then
  end
  if agent and not agent.controlled then
    local taskObject = agent:getTaskObject()
    if not taskObject then
    elseif taskObject.coreData.actor.enableSimulationArea then
    end
    if taskObject and not taskObject.coreData.actor.enableSimulationArea then
      ignore = false
    end
  end
  if not ignore then
    GameVehicleResource.addVehicleSimulationArea(gameVehicle)
    vehiclesWithIcamSimulationAreaSet[gameVehicle] = true
  end
end
local temporaryInvulnerabilityAfterIcam = 2
function iCamActivationTableInput(params)
  local iCamValid = true
  local cameraTargets = params.cameraTargets or false
  if not cameraTargets then
    iCamValid = false
  elseif localPlayer.inZap then
    iCamValid = false
  else
    for index, gameVehicle in next, cameraTargets, nil do
      if not spoolsystem.IsLocationResident(gameVehicle.position) then
        iCamValid = false
      end
    end
  end
  if iCamValid then
    local duration = params.duration or 2
    local speed = params.speed or 1
    local framing = params.framing or "mid"
    local angleyaw = params.angleYaw or "front quarter"
    local anglepitch = params.anglePitch or "normal"
    local mission = localPlayer.missionSupport:getMainTaskObject()
    local cutsceneModeParams = params.hudParams or {}
    local RadiusCamLow = params.radiusCamLow or -0.5
    local RadiusCamHigh = params.radiusCamHigh or 1.5
    local callBackFunction = params.callbackFunction or false
    local stopFunction = params.stopFunction or false
    local Preset = params.preset or false
    local FixedCameras = params.fixedCameras or false
    local Movie = params.movie or false
    local RadiusCam = params.radiusCam or false
    local Zoom = params.zoom or false
    local disableAI = params.disableAI
    local disableCallbackOnFail = params.disableCallbackOnFail
    IntelligentCamera.ClearTargets()
    localPlayer.inCutsceneOrIcam = true
    if mission then
      IntelligentCamera.SetName(mission.coreData.instance.challenge.name)
    else
      IntelligentCamera.SetName("Unknown")
    end
    if Movie then
      movie.Open(Movie)
      movie.Play()
      duration = 3
    end
    if not disableAI then
      cutsceneModeParams.addAI = true
    end
    localPlayer:enterCutsceneMode(cutsceneModeParams)
    activeChallenges.disableCollectables()
    garage.hide(true)
    if localPlayer.cameraMode == "Bumper" then
      VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
    end
    for index, gameVehicle in next, cameraTargets, nil do
      if index == 1 then
        turnOccupantsHighLOD(gameVehicle)
      end
      addSimulationArea(gameVehicle)
      IntelligentCamera.AddVehicleTarget(gameVehicle)
    end
    IntelligentCamera.SetMode(1)
    if Preset then
      IntelligentCamera.SetPresetPreferences(Preset)
    else
      IntelligentCamera.SetPresetPreferences("Mission")
      iCamApplyShotSettings(framing, angleyaw, anglepitch)
    end
    if FixedCameras then
      IntelligentCamera.SetShotTypePreference(0, 1)
      IntelligentCamera.SetShotTypePreference(1, 0)
      IntelligentCamera.SetShotTypePreference(2, 0)
      IntelligentCamera.SetShotTypePreference(3, 0)
      IntelligentCamera.SetFinderRulesPreference(0, 0)
      IntelligentCamera.SetFinderRulesPreference(1, 0)
      IntelligentCamera.SetFinderRulesPreference(2, 0)
      for index, vec in next, FixedCameras, nil do
        IntelligentCamera.AddFixedCameraPosition(vec)
      end
    end
    if RadiusCam then
      IntelligentCamera.SetFinderRulesPreference(0, 0)
      IntelligentCamera.SetFinderRulesPreference(1, 0)
      IntelligentCamera.SetFinderRulesPreference(2, 1)
      IntelligentCamera.SetFinderPreference(5, RadiusCam)
      IntelligentCamera.SetFinderPreference(6, RadiusCamLow)
      IntelligentCamera.SetFinderPreference(7, RadiusCamHigh)
    end
    if Zoom then
      IntelligentCamera.SetEffectPreference(2, 1)
    end
    IntelligentCamera.SetDuration(duration)
    localPlayer.currentVehicle:addTemporaryInvulnerability(duration + temporaryInvulnerabilityAfterIcam)
    if callBackFunction then
      IntelligentCamera.SetCallback(function()
        iCamDeActivation()
        callBackFunction()
      end)
    else
      IntelligentCamera.SetCallback(function()
        iCamDeActivation()
      end)
    end
    IntelligentCamera.SetVisibility(1)
    ReplaySystem.StartScriptedCamera()
    simulation.setSpeed(speed)
    ReplaySystem.SetCameraSlowMo(speed)
    local function update()
      if stopFunction() then
        iCamDeActivation()
        if callBackFunction then
          callBackFunction()
        end
        removeUserUpdateFunction("iCam update")
      end
    end
    if stopFunction then
      addUserUpdateFunction("iCam update", update, 5)
    end
    return true
  else
    if callBackFunction and not disableCallbackOnFail then
      callBackFunction()
    end
    return false
  end
end
local playerInvolvementTimeout = 3
local playerInvolvementTimeoutAfterHittingTarget = 4
function iCamCrashCam(gameVehicle, callbackFunction, hudParams)
  local iCamValid = true
  if not gameVehicle or not spoolsystem.IsLocationResident(gameVehicle.position) then
    iCamValid = false
  end
  if localPlayer.lastCollidedGameVehicle and localPlayer.lastCollidedGameVehicle == gameVehicle then
    if g_NetworkTime - localPlayer.lastCollisionTime > playerInvolvementTimeoutAfterHittingTarget then
      iCamValid = false
    end
  elseif g_NetworkTime - localPlayer.lastCollisionTime > playerInvolvementTimeout then
    iCamValid = false
  end
  if iCamValid then
    IntelligentCamera.ClearTargets()
    localPlayer.inCutsceneOrIcam = true
    localPlayer:enterCutsceneMode(hudParams)
    if localPlayer.cameraMode == "Bumper" then
      VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
    end
    turnOccupantsHighLOD(gameVehicle)
    addSimulationArea(gameVehicle)
    IntelligentCamera.AddVehicleTarget(gameVehicle)
    IntelligentCamera.SetDuration(4)
    IntelligentCamera.SetVisibility(1)
    if callbackFunction then
      IntelligentCamera.SetCallback(function()
        iCamDeActivation()
        callbackFunction()
      end)
    else
      IntelligentCamera.SetCallback(iCamDeActivation)
    end
    moodSystem.addMoodFlash("Awesome", "Awesome", 0.008, 4)
    IntelligentCamera.ForceCrashEvent()
  elseif callbackFunction then
    callbackFunction()
  end
end
function iCamFlyToCam(gameVehicle, callbackFunction, hudParams, WaitAtEnd, WaitCallback)
  local iCamValid = true
  if not gameVehicle or not spoolsystem.IsLocationResident(gameVehicle.position) then
    iCamValid = false
  end
  if iCamValid then
    IntelligentCamera.ClearTargets()
    localPlayer:enterCutsceneMode(hudParams)
    if localPlayer.cameraMode == "Bumper" then
      VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
    end
    localPlayer.inCutsceneOrIcam = true
    turnOccupantsHighLOD(gameVehicle)
    addSimulationArea(gameVehicle)
    IntelligentCamera.AddVehicleTarget(gameVehicle)
    IntelligentCamera.ForceFlyToEvent()
    simulation.setSpeed(0)
    ReplaySystem.SetCameraSlowMo(0)
    if WaitAtEnd == 1 then
      IntelligentCamera.SetFlyToWait(WaitAtEnd, WaitCallback)
    end
    Sound.EnterAudioState("AuxAmbience", "HUD_CamFlyTo_Play", "HUD_CamFlyTo_Stop")
    DoFlyCamAudio = true
    if callbackFunction then
      IntelligentCamera.SetCallback(function()
        iCamDeActivation()
        callbackFunction()
      end)
    else
      IntelligentCamera.SetCallback(iCamDeActivation)
    end
  elseif callbackFunction then
    callbackFunction()
  end
end
function iCamFlyToCamPosition(position, callbackFunction, hudParams, WaitAtEnd, WaitCallback)
  local iCamValid = true
  if not position then
    iCamValid = false
  end
  if iCamValid then
    IntelligentCamera.ClearTargets()
    localPlayer:enterCutsceneMode(hudParams)
    if localPlayer.cameraMode == "Bumper" then
      VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
    end
    localPlayer.inCutsceneOrIcam = true
    IntelligentCamera.AddPositionTarget(position)
    IntelligentCamera.ForceFlyToEvent()
    ReplaySystem.StartScriptedCamera()
    simulation.setSpeed(0)
    ReplaySystem.SetCameraSlowMo(0)
    IntelligentCamera.ForceFlyToEvent()
    if WaitAtEnd == 1 then
      IntelligentCamera.SetFlyToWait(WaitAtEnd, WaitCallback)
    end
    Sound.EnterAudioState("AuxAmbience", "HUD_CamFlyTo_Play", "HUD_CamFlyTo_Stop")
    DoFlyCamAudio = true
    if callbackFunction then
      IntelligentCamera.SetCallback(function()
        iCamDeActivation()
        callbackFunction()
      end)
    else
      IntelligentCamera.SetCallback(iCamDeActivation)
    end
  elseif callbackFunction then
    callbackFunction()
  end
end
