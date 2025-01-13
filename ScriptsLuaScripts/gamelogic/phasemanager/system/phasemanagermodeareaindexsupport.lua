module("phaseManager")
local usedRouteIndexes = {
  ["MP tag"] = false,
  ["MP takedown"] = false,
  ["MP burning rubber"] = false,
  ["MP circuit race"] = false,
  ["MP pure race"] = false,
  ["MP sprint race"] = false,
  ["MP checkpoint rush"] = false,
  ["MP tug of war"] = false,
  ["MP rush down"] = false,
  ["MP trail blazer"] = false,
  ["MP team circuit race"] = false,
  ["SS Clean the streets"] = false,
  ["SS Survival"] = false,
  ["SS Go the Distance"] = false,
  ["SS ShowDown"] = false,
  ["SS Freedrive"] = false,
  ["MP Vehicle Swap Tutorial"] = false,
  ["MP Vehicle Spawn Tutorial"] = false,
  ["MP shift impulse tutorial"] = false,
  ["MP general mechanics tutorial"] = false,
  ["MP shift take tutorial"] = false,
  ["Air"] = false,
  ["Drift"] = false,
  ["Drive far"] = false,
  ["Overtake cars"] = false,
  ["Smash props"] = false
}
local messageIDs = {
  ["MP tag"] = 12,
  ["MP takedown"] = 13,
  ["MP burning rubber"] = 14,
  ["MP circuit race"] = 15,
  ["MP pure race"] = 16,
  ["MP sprint race"] = 17,
  ["MP tug of war"] = 18,
  ["MP rush down"] = 19,
  ["MP trail blazer"] = 20,
  ["MP team circuit race"] = 21,
  ["MP checkpoint rush"] = 29,
  ["Air"] = 22,
  ["Drift"] = 23,
  ["Drive far"] = 24,
  ["Overtake cars"] = 25,
  ["Smash props"] = 26
}
function setModeUsedIndexLevel(modeID, level, numOfMaps)
  usedRouteIndexes[modeID] = false
  if numOfMaps <= level then
    level = numOfMaps - 1
  end
  if level > 0 then
    usedRouteIndexes[modeID] = {}
    for i = 1, level do
      usedRouteIndexes[modeID][i] = false
    end
  end
end
local function popUsedModeAreaIndex(modeID)
  local tempTable = usedRouteIndexes[modeID]
  for i = 2, #tempTable do
    usedRouteIndexes[modeID][i - 1] = tempTable[i]
  end
  usedRouteIndexes[modeID][#tempTable] = false
end
local function pushUsedModeAreaIndex(modeID, index)
  for i, usedIndex in ipairs(usedRouteIndexes[modeID]) do
    if not usedIndex then
      usedRouteIndexes[modeID][i] = index
      return
    end
  end
  popUsedModeAreaIndex(modeID)
  assert(usedRouteIndexes[modeID][#usedRouteIndexes[modeID]] == false, "Failed to store used mode area index " .. tostring(modeID))
  usedRouteIndexes[modeID][#usedRouteIndexes[modeID]] = index
end
function getUsableModeAreaIndex(modeID, modeAreaIndexTable, linearProgression)
  assert(usedRouteIndexes[modeID] ~= nil, "Cannot generate a mode are index for " .. tostring(modeID) .. ". Mode is not in the index table.")
  assert(#modeAreaIndexTable > 0, "Cannot generate a mode are index for " .. tostring(modeID) .. ". Given index table size == 0.")
  local modeAreaIndex = false
  if usedRouteIndexes[modeID] then
    if not linearProgression then
      local foundMAI = false
      repeat
        foundMAI = true
        modeAreaIndex = framework.random(1, #modeAreaIndexTable)
        for i, usedIndex in ipairs(usedRouteIndexes[modeID]) do
          if usedIndex and usedIndex == modeAreaIndex then
            foundMAI = false
            break
          end
        end
      until foundMAI
    else
      local oldIndex = usedRouteIndexes[modeID][1]
      if oldIndex and oldIndex + 1 <= #modeAreaIndexTable then
        modeAreaIndex = oldIndex + 1
      else
        modeAreaIndex = 1
      end
    end
    assert(modeAreaIndex, "Failed to generate a mode are index for " .. tostring(modeID) .. "  modeAreaIndex = " .. tostring(modeAreaIndex))
    pushUsedModeAreaIndex(modeID, modeAreaIndex)
  else
    modeAreaIndex = framework.random(1, #modeAreaIndexTable)
    assert(modeAreaIndex, "Failed to generate a mode are index for " .. tostring(modeID) .. "  modeAreaIndex = " .. tostring(modeAreaIndex))
  end
  return modeAreaIndex
end
local findUsableMAIIndexFromModeAreaIndex = function(modeID, modeAreaIndex)
  local missionData = cardSystem.createMission(modeID)
  for i, routeIndex in ipairs(missionData.usableRouteIndicies) do
    if routeIndex == modeAreaIndex then
      return i
    end
  end
  assert(false, "Failed to find mode area index location")
end
function updateUsableModeAreaIndex(modeID, modeAreaIndex, findIndexLocation)
  if usedRouteIndexes[modeID] then
    if findIndexLocation then
      pushUsedModeAreaIndex(modeID, findUsableMAIIndexFromModeAreaIndex(modeID, modeAreaIndex))
    else
      pushUsedModeAreaIndex(modeID, modeAreaIndex)
    end
  end
end
function informPlayerOfModesUsedIndexes(playerID, modeID)
  if usedRouteIndexes[modeID] then
    assert(messageIDs[modeID], "Cannot inform players of used Mode Area Indexes. " .. tostring(modeID) .. " is not in the messageID table.")
    for i, modeIndex in ipairs(usedRouteIndexes[modeID]) do
      if modeIndex then
        PlayerGamePlay.sendMessage(playerID, messageIDs[modeID], tostring(modeIndex))
      end
    end
  end
end
function informPlayerOfFaceOffsUsedIndexes(playerID)
  informPlayerOfModesUsedIndexes(playerID, "Air")
  informPlayerOfModesUsedIndexes(playerID, "Drift")
  informPlayerOfModesUsedIndexes(playerID, "Drive far")
  informPlayerOfModesUsedIndexes(playerID, "Overtake cars")
  informPlayerOfModesUsedIndexes(playerID, "Smash props")
end
function clearModeUsedIndexes(modeID)
  if usedRouteIndexes[modeID] then
    for i, modeIndex in ipairs(usedRouteIndexes[modeID]) do
      usedRouteIndexes[modeID][i] = false
    end
  end
end
function clearAllModeUsedIndexes()
  for modeID, indexTable in next, usedRouteIndexes, nil do
    if indexTable then
      clearModeUsedIndexes(modeID)
    end
  end
end
function printPMUT()
  printTable(usedRouteIndexes)
end
