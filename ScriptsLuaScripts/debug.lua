debugInfo = {showActiveMissionLogic = false}
function setMissionDebugging(status)
  if type(status) ~= "boolean" then
    print("debug.lua : setMissionDebugging : Parameter is not a boolean")
    return
  end
  debugInfo.showActiveMissionLogic = status
  if status == false then
    goalSystem.debug_removeDisplayActiveGoals()
    taskSystem.debug_removeDisplayActiveTasks()
  end
end
function countGlobals()
  local counts = {}
  for k, v in next, _G, nil do
    if not counts[type(v)] then
      counts[type(v)] = 1
    else
      counts[type(v)] = counts[type(v)] + 1
    end
  end
  printTable(counts)
end
function findGlobals(typeToFind)
  for k, v in next, _G, nil do
    if type(v) == typeToFind then
      print(tostring(k) .. " = " .. tostring(v))
    end
  end
end
function watchForGlobalAllocations()
  setmetatable(_G, {
    __index = rawget(_G, k),
    __newindex = function(t, k, v)
      print("Setting global " .. tostring(k) .. " to " .. tostring(v))
      callStack()
      rawset(_G, k, v)
    end
  })
end
function countVehicleTypes()
  local vehicleList = TrafficSystem.vehicleList(player.position, 500)
  local vehicleModels = {}
  for k, vehicle in next, vehicleList, nil do
    if not vehicleModels[vehicle.model_id] then
      vehicleModels[vehicle.model_id] = 1
    else
      vehicleModels[vehicle.model_id] = vehicleModels[vehicle.model_id] + 1
    end
  end
  printTable(vehicleModels)
end
function spawnVehicle(modelID, characters)
  local function spawn()
    local params = {
      Heading = 0,
      Model_Id = modelID or 0,
      snapToTerrain = true
    }
    if localPlayer.currentVehicle then
      params.Position = localPlayer.position + -localPlayer.currentVehicle.matrix[0] * 5
      params.Heading = localPlayer.heading
    else
      params.Position = player.position + vec.vector(5, 0, 0, 1)
    end
    local vehicle = GameVehicleResource.create(params)
    vehicle.owner = "Script"
    if characters then
      for i = 1, #characters do
        GameVehicleResource.setCharacterSpoolingEntityIndex(vehicle, i - 1, characters[i])
      end
    end
    return vehicle
  end
  local function waitForSpooling(modelID)
    TrafficSpooler.SetAsPlayerVehicle(modelID)
    return function()
      if TrafficSpooler.IsPlayerVehicleLoaded() then
        removeUserUpdateFunction("spawnVehicle")
        spawn()
      end
    end
  end
  if TrafficSpooler.IsMissionVehicleLoaded(modelID) then
    return spawn()
  elseif not spooling.requestToSpoolVehicle(modelID, spawn) then
    addUserUpdateFunction("spawnVehicle", waitForSpooling(modelID), 1)
  end
end
local deletionTracker = {
  __index = function(t, k)
    print("***************************************************************")
    print("Attempt to index '" .. tostring(k) .. "' on deleted " .. t._objectType)
    print(" ")
    print("----------Accessor callstack----------")
    callStack(3)
    print(" ")
    print("------Original deletion callstack------")
    for i, line in ipairs(t._deletionCallStack) do
      print(line)
    end
    print(" ")
    print("***************************************************************")
  end,
  __newindex = function(t, k, v)
    print("***************************************************************")
    print("Attempt to set index '" .. tostring(k) .. " = " .. tostring(v)("' on deleted ") .. t._objectType)
    print(" ")
    print("----------Accessor callstack----------")
    callStack(3)
    print(" ")
    print("------Original deletion callstack------")
    for i, line in ipairs(t._deletionCallStack) do
      print(line)
    end
    print(" ")
    print("***************************************************************")
  end
}
local deletionTrackEnabled = false
function debugTrackDeletion(object, objectType)
  if deletionTrackEnabled then
    setmetatable(object, nil)
    for k, v in next, object, nil do
      object[k] = nil
    end
    object._objectType = objectType or "unspecified object"
    object._deletionCallStack = callStackAsTable(3)
    setmetatable(object, deletionTracker)
  end
end
function printCamLookFrom(camera, agent)
  if camera then
    if agent then
      local vehicleMatrix = agent.matrix
      local cameraMatrix = camera.matrix
      local transposeVehicleMatrix = vehicleMatrix:transpose()
      local lookFrom = cameraMatrix[3] - vehicleMatrix[3]
      lookFrom = transposeVehicleMatrix * lookFrom
      lookFrom.w = 0
      local lookAt = cameraMatrix * vec.vector(0, 0, -10, 1)
      lookAt = transposeVehicleMatrix * (lookAt - vehicleMatrix[3])
      lookAt.w = 0
      print("lookFromOffset = vec.vector" .. tostring(lookFrom) .. ",")
      print("lookAtOffset = vec.vector" .. tostring(lookAt) .. ",")
      print("fov = " .. tostring(camera.fov) .. ",")
    else
      print("lookFrom = vec.vector" .. tostring(camera.matrix[3]) .. ",")
      print("lookAt = vec.vector" .. tostring(camera.matrix[3] + -camera.matrix[2] * 5) .. ",")
      print("fov = " .. tostring(camera.fov) .. ",")
    end
  else
    print("Error: No camera passed in")
  end
end
function printCurrentCamMatrix()
  local camera = free_camera or game_camera
  local cameraMatrix = camera.matrix
  local output = "configureFreeCamMatrix( "
  for i = 0, 3 do
    for j = 0, 3 do
      output = output .. string.format("%.4f", cameraMatrix[j][i])
      if i ~= 3 or j ~= 3 then
        output = output .. ", "
      end
    end
  end
  output = output .. ")"
  print(output)
end
function printCurrentPlotCamMatrix()
  local camera = free_camera or game_camera
  local cameraMatrix = camera.matrix
  local output = "$GAMEMAP$:PLOTPOINT:0,#ffffff00,"
  for i = 0, 3 do
    for j = 0, 3 do
      output = output .. string.format("%.4f", cameraMatrix[i][j])
      output = output .. ", "
    end
  end
  print(output)
end
function printCutscenePlotCamMatrix()
  local cameraMatrix = Cutscene.GetMatrix()
  local output = "$GAMEMAP$:PLOTPOINT:0,#ffffff00,"
  for i = 0, 3 do
    for j = 0, 3 do
      output = output .. string.format("%.4f", cameraMatrix[i][j])
      output = output .. ", "
    end
  end
  print(output)
end
function configureFreeCamMatrix(...)
  allowFreeCam(true)
  while localPlayer.cameraMode ~= "FreeCam" do
    cycleActiveCamera("JustPressed", 1, 0)
  end
  player.setAttachment(localPlayer.localID, free_camera)
  free_camera.matrix = vec.matrix(unpack(arg))
  spoolsystem.EnableCameraTracking()
end
function returnToCar()
  while localPlayer.cameraMode ~= "Normal" do
    cycleActiveCamera("JustPressed", 1, 0)
  end
end
local FPSallowed = true
local FPSShown = false
function toggleFPSCounter()
  if FPSallowed then
    if not FPSShown then
      simulation.EnableFPSCounter()
    else
      simulation.DisableFPSCounter()
    end
    FPSShown = not FPSShown
  end
end
function printPositionAndHeading()
  print("[\"position\"] = vec.vector" .. tostring(localPlayer.position))
  print("[\"heading\"] = " .. tostring(localPlayer.heading))
end
function enableFPSCounter(bool)
  FPSallowed = bool
  if not FPSallowed and FPSShown then
    simulation.DisableFPSCounter()
    FPSShown = bool
  elseif FPSallowed and not FPSShown then
    simulation.EnableFPSCounter()
    FPSShown = bool
  end
end
local trackNilReads = {
  __index = function(t, k)
    local v = rawget(t, k)
    if v == nil then
      print(k)
      callStack()
    end
    return v
  end
}
function spawnChaser(number)
  local settings = {
    type = "BehindVehicle",
    vehicle = localPlayer.currentVehicle.gameVehicle,
    direction = "with",
    position = "randomLane",
    vehicles = {}
  }
  local vehicleType = {modelID = 271}
  if localPlayer.currentVehicle then
    for i = 1, number do
      settings.vehicles[i] = vehicleType
    end
    local vehicles = Spawn.Spawn(settings)
    Getaway.Start(localPlayer.currentVehicle.gameVehicle, nil, "Freedrive", nil)
    for i, gameVehicle in ipairs(vehicles) do
      local vehicle = vehicleManager.registerVehicle({gameVehicle = gameVehicle})
      Getaway.AddChaser(localPlayer.currentVehicle.gameVehicle, gameVehicle)
    end
  end
end
function countTeamMembers(teamName)
  local mission = localPlayer.missionSupport:getMainTaskObject()
  local members = 0
  if mission then
    for actorID, taskObject in next, mission.coreData.instance.taskObjectsByActorID, nil do
      if taskObject.coreData.actor.team == teamName then
        members = members + 1
      end
    end
    print(tostring(teamName) .. " has " .. tostring(members) .. " members")
  else
    print("No task active to count team members")
  end
end
function killAVehicle(actorName)
  local taskObject = localPlayer.missionSupport:getMainTaskObject()
  if taskObject and taskObject.coreData.instance.taskObjectsByActorID[actorName] then
    GameVehicleResource.applyDamage({
      gameVehicle = taskObject.coreData.instance.taskObjectsByActorID[actorName].coreData.agent.gameVehicle,
      damage = 1
    })
  end
end
function spoolCutsceneTraffic()
  spooling.spoolTraffic("Cut scene traffic", function()
    InterestingVehicleManager.Enable(false)
    PatrollingVehicleManager.Enable(false)
  end, function()
    InterestingVehicleManager.Enable(false)
  end)
end
function orthoProjection(region, width, height)
  local x, z = spoolsystem.GetRegionCentre(region)
  localPlayer:SetZapLevel(3)
  zapcontroller.ZapCameraSetTargetPos(x, z, 0)
  zapcontroller.setActionPoinTracking(vec.vector(x, 0, z, 1), 1.570796, 0)
  zapcontroller.ZapSettings(3, {DistanceFromTarget = 1})
  CameraSystem.EnableOrthoProyection(true, width, height, 100, 10000)
end
function cycleAdverts()
  if not Adverts then
    debugOpen("advert.lua")
  end
  local placeCamera = function(data)
    local matrix = CreateLookAtMatrix(data.pos + data.normal * 20, data.pos)
    local pack = {}
    for i = 0, 3 do
      for j = 0, 3 do
        table.insert(pack, matrix[j][i])
      end
    end
    configureFreeCamMatrix(unpack(pack))
  end
  local thread
  local function resume()
    coroutine.resume(thread)
    if coroutine.status(thread) == "dead" then
      setActiveCamera("FreeCam", localPlayer.localID)
    end
  end
  local function stepInput()
    if controlHandler:getStatus("Menu_Cancel") == "JustPressed" then
      resume()
      removeUserUpdateFunction("stepInput")
    end
  end
  local function fadeDone()
    addUserUpdateFunction("stepInput", stepInput, 1)
  end
  local devTextRegionPosition = vec.vector(0.1, 0.1, 0, 1)
  local devTextIDPosition = vec.vector(0.1, 0.15, 0, 1)
  local devTextIndexPosition = vec.vector(0.1, 0.2, 0, 1)
  local devTextColour = vec.vector(1, 1, 1, 1)
  local function registerWait(data, regionID, advertID, index, total)
    local function waitToSpool()
      if spoolsystem.IsLocationResident(data.pos) then
        Development:add2DText(-2, "REGION: " .. tostring(regionID), devTextRegionPosition, devTextColour, 1.5, -1)
        Development:add2DText(-3, "ID: " .. tostring(advertID), devTextIDPosition, devTextColour, 1.5, -1)
        Development:add2DText(-4, "AD: " .. tostring(index) .. " of " .. tostring(total), devTextIndexPosition, devTextColour, 1.5, -1)
        spooling.fadeIn(nil, nil, fadeDone)
        removeUserUpdateFunction("cycleAdverts")
      end
    end
    return function()
      placeCamera(data)
      spoolsystem.EnableCameraTracking(localPlayer.localID)
      addUserUpdateFunction("cycleAdverts", waitToSpool, 4, true)
    end
  end
  local function step()
    local index = 1
    local total = 0
    for regionID, adverts in next, Adverts, nil do
      for advertID, advertData in next, adverts, nil do
        total = total + 1
      end
    end
    for regionID, adverts in next, Adverts, nil do
      for advertID, advertData in next, adverts, nil do
        spooling.fadeOut(nil, nil, registerWait(advertData, regionID, advertID, index, total))
        index = index + 1
        coroutine.yield()
      end
    end
  end
  if Adverts then
    allowFreeCam(true)
    localPlayer.inCutsceneOrIcam = true
    while localPlayer.cameraMode ~= "FreeCam" do
      cycleActiveCamera("JustPressed", 1, 0)
    end
    thread = coroutine.create(step)
    coroutine.resume(thread)
  end
end
