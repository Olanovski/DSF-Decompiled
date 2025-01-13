module("networkParsing", package.seeall)
DEBUG_NETWORKVAR = true
local terminationDataType = 23
local dataTypeLookup = {
  [1] = "popFloat",
  [3] = "popBoolean",
  [5] = "popString",
  [7] = "popUInteger8",
  [9] = "popUInteger16",
  [11] = "popUInteger32",
  [15] = "popInteger8",
  [17] = "popInteger16",
  [19] = "popInteger32",
  ["float"] = {dataType = 1, nilType = 2},
  ["boolean"] = {dataType = 3, nilType = 4},
  ["string"] = {dataType = 5, nilType = 6},
  ["uinteger8"] = {dataType = 7, nilType = 8},
  ["uinteger16"] = {dataType = 9, nilType = 10},
  ["uinteger32"] = {dataType = 11, nilType = 12},
  ["integer8"] = {dataType = 15, nilType = 16},
  ["integer16"] = {dataType = 17, nilType = 18},
  ["integer32"] = {dataType = 19, nilType = 20}
}
local vectorLookup = {
  {name = "x", parseType = "float"},
  {name = "y", parseType = "float"},
  {name = "z", parseType = "float"},
  {name = "w", parseType = "integer32"}
}
function metaSetNetworkVar(t, k, v)
  if t.debugCheckIsLocal() then
    if t.__index[k] ~= v then
      t.__index[k] = v
      t.updateRequired = true
      if t.vehicleTemplateOwner ~= nil then
        vehicleManagerCoreReflection.synchNetworkVars(t.vehicleTemplateOwner.gameVehicle, t)
      end
    end
  else
    print("ATTEMPTED TO PUSH NETWORKVAR '" .. tostring(k) .. "' ONTO A REMOTE OBJECT")
    print("CURRENT VALUE " .. tostring(t.__index[k]) .. ", REQUESTED VALUE " .. tostring(v))
    callStack()
  end
end
function makeLookupTable(inputTable)
  for i, data in ipairs(inputTable) do
    data.ID = i
    inputTable[data.name] = data
  end
  return inputTable
end
function getDataType(parseType, parseData)
  assert(dataTypeLookup[parseType], "NETWORK PARSING: getDataType - COULDN'T FIND DATA TYPE LOOKUP " .. tostring(parseType))
  if parseData ~= nil then
    return {
      DataType = dataTypeLookup[parseType].dataType,
      Data = parseData
    }
  else
    return {
      DataType = dataTypeLookup[parseType].nilType
    }
  end
end
function getBufferData(buffer, target, parseInfo)
  local data
  if parseInfo.getFunction then
    data = parseInfo.getFunction(target)
  else
    data = target[parseInfo.name]
  end
  table.insert(buffer, getDataType(parseInfo.parseType, data))
end
function getComplexBuffer(buffer, target, lookupTable)
  if lookupTable then
    for i, parseInfo in ipairs(lookupTable) do
      if parseInfo.subTable then
        getComplexBuffer(buffer, target[parseInfo.name], parseInfo.getLookup(target))
      elseif parseInfo.vector then
        getComplexBuffer(buffer, target[parseInfo.name], vectorLookup)
      else
        getBufferData(buffer, target, parseInfo)
      end
    end
  end
end
function getSimpleBuffer(buffer, target, parseType)
  for i, data in ipairs(target) do
    buffer[i] = getDataType(parseType, data)
  end
end
function getIndexedBuffer(buffer, target, indexParseType, valueParseType)
  local i = 1
  for index, value in next, target.__index, nil do
    buffer[i] = getDataType(indexParseType, index)
    buffer[i + 1] = getDataType(valueParseType, value)
    i = i + 2
  end
end
function writeBuffer(library, objectID, bufferID, bufferInfo, target)
  local maxBuffers = 24
  if bufferID < maxBuffers then
    NetworkLog.WriteDetail(">[LUA] NETWORK PARSING - Writing to buffer, networkID = " .. tostring(objectID) .. ", bufferID = " .. tostring(bufferID))
    assert(objectID, "NETWORKPARSING - writeBuffer: Attempt to write to object with invalid network object ID (ID was " .. tostring(objectID) .. ")")
    local buffer = {}
    if bufferInfo.simple then
      getSimpleBuffer(buffer, target, bufferInfo.parseType)
    elseif bufferInfo.indexed then
      getIndexedBuffer(buffer, target, bufferInfo.indexParseType, bufferInfo.valueParseType)
    else
      getComplexBuffer(buffer, target, bufferInfo.lookupTable)
    end
    library.pushBuffer(objectID, bufferID, buffer)
  end
end
function blindReadBuffer(library, objectID, bufferID)
  NetworkLog.WriteDetail(">[LUA] NETWORK PARSING - Reading from buffer, networkID = " .. tostring(objectID) .. ", bufferID = " .. tostring(bufferID))
  library.startReading(objectID, bufferID)
  local buffer = {}
  local data = library.popDataType(objectID, bufferID)
  local i = 1
  while data ~= terminationDataType do
    if dataTypeLookup[data] then
      buffer[i] = library[dataTypeLookup[data]](objectID, bufferID)
    end
    data = library.popDataType(objectID, bufferID)
    i = i + 1
  end
  library.stopReading(objectID, bufferID)
  return buffer
end
function buildBufferLoop(blindBuffer, target, lookupTable, keyOffset)
  local buffer = {}
  local i = 1
  local keyShift = 1
  local parseInfo = lookupTable[i]
  while parseInfo do
    keyShift = 1
    if blindBuffer[i + keyOffset] ~= nil then
      if parseInfo.subTable then
        buffer[parseInfo.name], keyShift = buildBufferLoop(blindBuffer, target, parseInfo.getLookup(target), i)
      elseif parseInfo.vector then
        buffer[parseInfo.name] = vec.vector(blindBuffer[i + keyOffset], blindBuffer[i + keyOffset + 1], blindBuffer[i + keyOffset + 2], blindBuffer[i + keyOffset + 3])
        keyShift = 3
      else
        buffer[parseInfo.name] = blindBuffer[i + keyOffset]
      end
    end
    i = i + keyShift
    parseInfo = lookupTable[i]
  end
  return buffer, i
end
function buildIndexedBuffer(blindBuffer)
  local buffer = {}
  for i = 1, #blindBuffer, 2 do
    buffer[blindBuffer[i]] = blindBuffer[i + 1]
  end
  return buffer
end
function readBuffer(library, objectID, bufferID, bufferInfo, target)
  local buffer = blindReadBuffer(library, objectID, bufferID)
  if bufferInfo.indexed then
    buffer = buildIndexedBuffer(buffer)
  elseif not bufferInfo.simple then
    buffer = buildBufferLoop(buffer, target, bufferInfo.lookupTable, 0)
  end
  if target then
    if bufferInfo.bufferUpdate then
      bufferInfo.bufferUpdate(target, buffer)
    else
      for varName, varValue in next, buffer, nil do
        target[varName] = varValue
      end
    end
  end
  return buffer
end
