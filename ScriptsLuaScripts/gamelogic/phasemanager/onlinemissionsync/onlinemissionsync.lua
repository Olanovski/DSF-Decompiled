module("onlineMissionSync", package.seeall)
local missionVehicleModelIDs = {}
local missionVehicleColour, currentTrafficID
local trafficRequestPending = false
local pendingVehicleList
local noTrafficID = -1
local progressionSets = {
  [0] = {
    name = "Online Traffic ",
    vehicleFrequencyCount = 3
  },
  [1] = {
    name = "Online Traffic Easy",
    vehicleFrequencyCount = 3
  },
  [2] = {
    name = "Online Traffic Hard",
    vehicleFrequencyCount = 3
  },
  [3] = {
    name = "Online Traffic Pursuit",
    vehicleFrequencyCount = 2
  },
  [4] = {
    name = "Online Traffic Trailblazer",
    vehicleFrequencyCount = 3
  },
  [5] = {
    name = "Online Traffic Jump",
    vehicleFrequencyCount = 1
  },
  [6] = {
    name = "Online Traffic Sprint GP",
    vehicleFrequencyCount = 3
  },
  [7] = {
    name = "Online Traffic Takedown",
    vehicleFrequencyCount = 1
  },
  [8] = {
    name = "Online Traffic Survival",
    vehicleFrequencyCount = 1
  }
}
function generateTrafficID(trafficID, vehicleFrequency)
  if trafficID == noTrafficID then
    return noTrafficID
  elseif progressionSets[trafficID] then
    if vehicleFrequency then
      return trafficID * 10 + vehicleFrequency
    else
      return trafficID * 10 + framework.random(0, progressionSets[trafficID].vehicleFrequencyCount - 1)
    end
  else
    return 0
  end
end
function getCurrentTrafficID()
  return currentTrafficID
end
local function requestTraffic()
  if not spooling.spoolingBusy and not TrafficSpooler.Busy() and TrafficSpooler.AllTrafficVehiclesLoaded() then
    local progressionSet = math.floor(currentTrafficID / 10)
    local vehicleFrequency = currentTrafficID - progressionSet * 10
    if not progressionSets[progressionSet] then
      progressionSet = 0
    end
    if vehicleFrequency < 0 or vehicleFrequency >= progressionSets[progressionSet].vehicleFrequencyCount then
      vehicleFrequency = 0
    end
    NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - setTrafficSettingsName, progressionSets = " .. tostring(progressionSets[progressionSet].name) .. ", vehicleFrequency = " .. tostring(vehicleFrequency))
    civilianTraffic.setTrafficSettingsName(progressionSets[progressionSet].name, vehicleFrequency)
    spooling.enableTraffic(configSelector.launchConfig.enableTraffic)
    trafficRequestPending = false
    NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - Remove requestTraffic")
    removeUserUpdateFunction("requestTraffic")
  end
end
local function addTraffic(trafficID)
  if trafficID ~= noTrafficID then
    NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - addTraffic trafficID " .. tostring(trafficID) .. " currentTrafficID " .. tostring(currentTrafficID))
    if trafficID ~= currentTrafficID then
      trafficRequestPending = true
      NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - request new traffic " .. tostring(trafficID))
      addUserUpdateFunction("requestTraffic", requestTraffic, 12)
    else
      spooling.enableTraffic(configSelector.launchConfig.enableTraffic)
    end
  else
    NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - Turn traffic off")
    civilianTraffic.setTrafficOnOff(false)
  end
  currentTrafficID = trafficID
end
function isTrafficLoaded()
  if currentTrafficID then
    if currentTrafficID == noTrafficID then
      return true
    elseif not trafficRequestPending then
      return TrafficSpooler.AllTrafficVehiclesLoaded()
    end
  end
  return false
end
local function requestVehicles()
  if not spooling.spoolingBusy and not TrafficSpooler.Busy() and isTrafficLoaded() then
    NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - pendingVehicleList")
    networkLogPrintTable(pendingVehicleList)
    ActiveVehicles.reloadAll()
    for modelID, loadState in pairs(missionVehicleModelIDs) do
      missionVehicleModelIDs[modelID] = 0
    end
    for i, modelID in ipairs(pendingVehicleList) do
      if modelID >= 0 then
        if missionVehicleModelIDs[modelID] == 0 then
          missionVehicleModelIDs[modelID] = 2
        else
          missionVehicleModelIDs[modelID] = 1
        end
      else
        NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - invalid vehicle id in pendingVehicleList")
        networkLogPrintTable(pendingVehicleList)
      end
    end
    for modelID, loadState in pairs(missionVehicleModelIDs) do
      if loadState == 0 then
        if not ActiveVehicles.isActiveVehicle(modelID) then
          NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - ReleaseMissionVehicle, modelID = " .. tostring(modelID))
          TrafficSpooler.ReleaseMissionVehicle(modelID)
        end
        missionVehicleModelIDs[modelID] = nil
      elseif loadState == 1 then
        if not ActiveVehicles.isActiveVehicle(modelID) then
          NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - RequestMissionVehicle, modelID = " .. tostring(modelID))
          TrafficSpooler.RequestMissionVehicle(modelID)
        end
        missionVehicleModelIDs[modelID] = 2
      elseif loadState == 2 then
        if not ActiveVehicles.isActiveVehicle(modelID) and not TrafficSpooler.IsMissionVehicleLoaded(modelID) then
          NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - RetainingMissionVehicle and not loaded, modelID = " .. tostring(modelID))
          TrafficSpooler.RequestMissionVehicle(modelID)
        else
          NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - RetainingMissionVehicle and still loaded, modelID = " .. tostring(modelID))
        end
      else
        NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - vehicle had an odd load state remove, modelID = " .. tostring(modelID))
        networkLogPrintTable(missionVehicleModelIDs)
        missionVehicleModelIDs[modelID] = nil
      end
    end
    pendingVehicleList = nil
    NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - Remove requestVehicles")
    networkLogPrintTable(missionVehicleModelIDs)
    removeUserUpdateFunction("requestVehicles")
  end
end
function addVehicles(vehicleModelIDs, colourParam)
  pendingVehicleList = vehicleModelIDs
  missionVehicleColour = colourParam
  NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - Add requestVehicles")
  addUserUpdateFunction("requestVehicles", requestVehicles, 12)
end
function areVehiclesLoaded()
  if pendingVehicleList or not ActiveVehicles.allLoaded() then
    return false
  end
  for modelID, loadState in pairs(missionVehicleModelIDs) do
    if not ActiveVehicles.isActiveVehicle(modelID) and not TrafficSpooler.IsMissionVehicleLoaded(modelID) then
      return false
    end
  end
  return true
end
function setCurrentMissionData(trafficID, vehicleModelIDs, colourParam)
  NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - setCurrentMissionData trafficID " .. tostring(trafficID))
  callStack()
  networkLogPrintTable(callStackAsTable())
  trafficID = trafficID or 0
  colourParam = colourParam or -1
  if trafficID == 255 then
    trafficID = noTrafficID
  end
  local vehicleTable = vehicleModelIDs or {}
  if type(vehicleModelIDs) == "number" then
    vehicleTable = {vehicleModelIDs}
  end
  assert(type(vehicleTable) == "table", "func is " .. tostring(type(vehicleModelIDs)) .. " not a table")
  addTraffic(trafficID)
  addVehicles(vehicleTable, colourParam)
end
_G.SetCurrentMissionData = setCurrentMissionData
local function getMissionSyncData()
  local trafficID = currentTrafficID or 0
  local colourParam = missionVehicleColour or -1
  local vehicleTable = {}
  for modelID, loadState in pairs(missionVehicleModelIDs) do
    table.insert(vehicleTable, modelID)
  end
  return trafficID, vehicleTable, colourParam
end
_G.GetMissionSyncData = getMissionSyncData
local function onlineMissionVehicleIsEqualTo(modelID)
  if missionVehicleModelIDs[modelID] ~= nil then
    return true
  else
    return false
  end
end
_G.OnlineMissionVehicleIsEqualTo = onlineMissionVehicleIsEqualTo
function isMissionSynched()
  return isTrafficLoaded() and areVehiclesLoaded()
end
_G.IsMissionSynched = isMissionSynched
function purge()
  NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - purge")
  NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - Remove requestTraffic")
  removeUserUpdateFunction("requestTraffic")
  NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - Remove requestVehicles")
  removeUserUpdateFunction("requestVehicles")
  for modelID, loadState in pairs(missionVehicleModelIDs) do
    if not ActiveVehicles.isActiveVehicle(modelID) then
      NetworkLog.Write(">[LUA] ONLINE MISSION SYNC - ReleaseMissionVehicle, modelID = " .. tostring(modelID))
      TrafficSpooler.ReleaseMissionVehicle(modelID)
    end
  end
  missionVehicleModelIDs = {}
  missionVehicleColour = nil
  currentTrafficID = nil
  trafficRequestPending = false
  pendingVehicleList = nil
end
_G.CleanOnlineMissionSync = purge
