module("faceOffSystem", package.seeall)
faceOffPool = {}
availableFaceOffs = {}
currentFaceOff = false
local chosenFaceOff = -1
local forceEnd = false
local lastFaceOffID = 0
local playersJoining = {}
function registerFaceOff(name, settings, goals, buildFunctions)
  assert(not faceOffPool[tostring(name)], "FACEOFFSYSTEM - registerFaceOff: Attempt to re-register existing face off: " .. tostring(name))
  assert(type(goals) == "table" and #goals > 0, "FACEOFFSYSTEM - registerFaceOff: Attempt to register invalid goal table, is either empty or invalid: " .. tostring(goals))
  local faceOff = {
    ID = #faceOffPool + 1,
    name = tostring(name),
    settings = settings or {},
    goals = goals,
    buildFunctions = buildFunctions
  }
  faceOffPool[faceOff.name] = faceOff
  faceOffPool[faceOff.ID] = faceOff
end
function initiate()
  currentFaceOff:initiate()
end
function update()
  if currentFaceOff then
    for player, joining in next, playersJoining, nil do
      if player.currentVehicle then
        currentFaceOff:playerJoined(player)
        playersJoining[player] = nil
      end
    end
    currentFaceOff:update()
    feedbackSystem.faceOffSupport.update()
    if currentFaceOff.isLocal and currentFaceOff.instanceID then
      updateSNOFromObject(currentFaceOff)
    end
    return currentFaceOff.networkVars.complete
  else
    return false
  end
end
function stepFaceOffDeletion()
  if currentFaceOff then
    if currentFaceOff.endFaceOffWheWeCan then
      if currentFaceOff:canBeDeleted() then
        endFaceOff()
      end
    elseif currentFaceOff.isLocal then
      currentFaceOff.endFaceOffWheWeCan = true
    end
  end
end
function populateFaceOffPool()
  if #availableFaceOffs == 0 then
    for faceOffID, faceOff in ipairs(faceOffPool) do
      table.insert(availableFaceOffs, faceOffID)
    end
  end
end
function removeFaceOffFromAvailablePool(chosenFaceOffID)
  populateFaceOffPool()
  for i, faceOffID in ripairs(availableFaceOffs) do
    if chosenFaceOffID == faceOffID then
      table.remove(availableFaceOffs, i)
      break
    end
  end
end
function informPlayerOfPlayedFaceOffs(playerID)
  local found = false
  for faceOffID, faceOff in ipairs(faceOffPool) do
    found = false
    for i, id in ipairs(availableFaceOffs) do
      if faceOffID == id then
        found = true
        break
      end
    end
    if not found then
      PlayerGamePlay.sendMessage(playerID, 9, tostring(faceOffID))
    end
  end
end
function updateFaceOffPool(chosenFaceOffID)
  removeFaceOffFromAvailablePool(chosenFaceOffID)
  lastFaceOffID = chosenFaceOffID
end
function getRandomFaceOff()
  populateFaceOffPool()
  local index = framework.random(1, #availableFaceOffs)
  local faceoffID = availableFaceOffs[index]
  if #availableFaceOffs ~= 1 then
    while lastFaceOffID == faceoffID do
      index = framework.random(1, #availableFaceOffs)
      faceoffID = availableFaceOffs[index]
    end
  end
  lastFaceOffID = faceoffID
  table.remove(availableFaceOffs, index)
  return faceoffID
end
function chooseRandomFaceOff()
  local faceOffIndex = getRandomFaceOff()
  local faceOffAreaIndexLocation, faceOffAreaIndex
  if phaseManager.playlistSupport.debug_none_random_route_cycle then
    if phaseManager.playlistSupport.debug_none_random_cycle_lastRoute_faceOff <= 0 or phaseManager.playlistSupport.debug_none_random_cycle_lastRoute_faceOff > #faceOffData[faceOffPool[faceOffIndex].settings.title].usableRouteIndicies then
      phaseManager.playlistSupport.debug_none_random_cycle_lastRoute_faceOff = 1
    end
    faceOffAreaIndex = faceOffData[faceOffPool[faceOffIndex].settings.title].usableRouteIndicies[phaseManager.playlistSupport.debug_none_random_cycle_lastRoute_faceOff]
  else
    print(">>>>>>>>>>>> Faceoff chosen: " .. tostring(faceOffPool[faceOffIndex].settings.title))
    faceOffAreaIndexLocation = phaseManager.getUsableModeAreaIndex(faceOffPool[faceOffIndex].settings.title, faceOffData[faceOffPool[faceOffIndex].settings.title].usableRouteIndicies)
    faceOffAreaIndex = faceOffData[faceOffPool[faceOffIndex].settings.title].usableRouteIndicies[faceOffAreaIndexLocation]
    print(">>>>>>>>>>>> Faceoff route index location: " .. tostring(faceOffAreaIndexLocation))
    print(">>>>>>>>>>>> Faceoff route index: " .. tostring(faceOffAreaIndex))
  end
  return faceOffIndex, faceOffAreaIndex
end
function createChosenFaceOff()
  if chosenFaceOff == -1 then
    chooseRandomFaceOff()
  end
  createInstance(availableFaceOffs[chosenFaceOff])
  table.remove(availableFaceOffs, chosenFaceOff)
end
function createFaceOff(faceOffIndex, faceOffAreaIndex)
  currentFaceOff = createInstance(faceOffPool[faceOffIndex], faceOffAreaIndex)
end
function playerHasJoined(player)
  if currentFaceOff and currentFaceOff.playerJoined then
    playersJoining[player] = true
  end
end
function startFaceOff()
  assert(currentFaceOff, "FACE OFF SYSTEM, no face off to start")
  currentFaceOff:start()
end
function endFaceOff()
  assert(currentFaceOff, "FACE OFF SYSTEM, no face off to end")
  currentFaceOff:complete()
  forceEnd = false
  playersJoining = {}
end
function endFaceOffWhenWeCan()
  assert(currentFaceOff, "FACE OFF SYSTEM, no face off to end")
  currentFaceOff.endFaceOffWheWeCan = true
  if currentFaceOff:canBeDeleted() then
    endFaceOff()
  end
end
function stopFaceOff()
  if currentFaceOff then
    currentFaceOff:stop()
  end
  feedbackSystem.faceOffSupport.removeFeedback()
end
function unregisterPlayer(player)
  if currentFaceOff and currentFaceOff.isLocal then
    currentFaceOff:unregisterPlayer(player)
  end
end
function purge()
  availableFaceOffs = {}
  lastFaceOffID = 0
  playersJoining = {}
  if currentFaceOff then
    currentFaceOff:delete()
  end
end
function forceEndFaceOff()
  if currentFaceOff.isLocal then
    currentFaceOff.networkVars.complete = true
  else
    sendMessage(1)
  end
end
