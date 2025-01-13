userUpdateFunctions = {}
luaUpdateFunctionTable = {}
luaUpdateFunctionBuckets = {}
luaUpdateFunctionTable[1] = {}
luaUpdateFunctionTable[2] = {}
luaUpdateFunctionTable[3] = {}
luaUpdateFunctionTable[1].funcs = {}
luaUpdateFunctionTable[2].funcs = {}
luaUpdateFunctionTable[3].funcs = {}
luaUpdateFunctionTable[1].updateInterval = 1
luaUpdateFunctionTable[2].updateInterval = 2
luaUpdateFunctionTable[3].updateInterval = 4
luaUpdateFunctionTable[1].lastUpdate = 1
luaUpdateFunctionTable[2].lastUpdate = 1
luaUpdateFunctionTable[3].lastUpdate = 1
luaRemoveUpdateFunction = {}
function updateLuaFunctions(steprate)
  luaRemoveUpdateFunctions()
  for c = 1, #luaUpdateFunctionTable do
    for k, v in next, luaUpdateFunctionTable[c].funcs, nil do
      v()
    end
    luaUpdateFunctionTable[c].lastUpdate = luaUpdateFunctionTable[c].lastUpdate + 1
    if luaUpdateFunctionTable[c].lastUpdate > luaUpdateFunctionTable[c].updateInterval then
      luaUpdateFunctionTable[c].lastUpdate = 1
    end
  end
end
function addLuaUpdateFunction(name, func, bucket)
  if luaUpdateFunctionBuckets[name] == nil then
    if luaRemoveUpdateFunction[name] then
      luaRemoveUpdateFunction[name] = nil
    end
    luaUpdateFunctionTable[bucket].funcs[name] = func
    luaUpdateFunctionBuckets[name] = bucket
  end
end
function markUpdateFunctionForRemoval(name)
  local entries
  luaRemoveUpdateFunction[name] = luaUpdateFunctionBuckets[name]
  luaUpdateFunctionBuckets[name] = nil
end
function luaRemoveUpdateFunctions()
  for k, v in next, luaRemoveUpdateFunction, nil do
    luaUpdateFunctionTable[v].funcs[k] = nil
  end
  luaRemoveUpdateFunction = {}
end
local subSystemNames = {
  "localPlayerManager",
  "remotePlayers",
  "vehicleManager",
  "phaseManager",
  "challengeSystem",
  "feedbackSystem",
  "onlineSideBar",
  "taskSystem",
  "goalSystem",
  "faceOffSystem",
  "packageManager"
}
function setUpdateRate(subSystem, frequency)
  local subName = subSystem
  if type(subSystem) == "number" then
    subName = subSystemNames[subSystem]
  end
  if userUpdateFunctions[subSystem] then
    userUpdateFunctions[subSystem].stepRate = frequency
    print(subSystem .. ": Step Rate " .. frequency)
  end
end
function setAllUpdateRates(frequency)
  for k, v in next, subSystemNames, nil do
    print(v)
    setUpdateRate(v, frequency)
  end
end
_G.tzSetAllUpdateRates = setAllUpdateRates
function doubleAllUpdateRates()
  for k, v in next, userUpdateFunctions, nil do
    v.stepRate = v.stepRate * 2
  end
end
_G.tzDoubleAllUpdateRates = doubleAllUpdateRates
function halveAllUpdateRates()
  for k, v in next, userUpdateFunctions, nil do
    v.stepRate = v.stepRate / 2
  end
end
_G.tzHalveAllUpdateRates = halveAllUpdateRates
local removeQueue = {}
updates = {stepRate = 120}
function addUserUpdateFunction(name, func, stepRate, delayUpdate)
  assert(type(name) == "string", "Name is " .. tostring(type(name)) .. " not a string")
  assert(type(func) == "function", "func is " .. tostring(type(func)) .. " not a function")
  assert(type(stepRate) == "number", "stepRate is " .. tostring(type(stepRate)) .. " not a number")
  local found = false
  for i = 1, #removeQueue do
    if removeQueue[i] == name then
      found = i
      table.remove(removeQueue, found)
      break
    end
  end
  if found and userUpdateFunctions[name] then
    userUpdateFunctions[name].func = func
    userUpdateFunctions[name].stepRate = stepRate
  else
    userUpdateFunctions[name] = {func = func, stepRate = stepRate}
  end
  if delayUpdate then
    userUpdateFunctions[name].steps = 0
  else
    userUpdateFunctions[name].steps = stepRate
  end
  updates[name] = updates.stepRate / stepRate
end
function removeUserUpdateFunction(name)
  removeQueue[#removeQueue + 1] = name
end
local function _updateLuaUserFunctions()
  local userUpdateFunctions = userUpdateFunctions
  local cgStep = "step"
  collectgarbage("setstepmul", 300)
  collectgarbage("setpause", 50)
  return function()
    if #removeQueue > 0 then
      for i = 1, #removeQueue do
        userUpdateFunctions[removeQueue[i]] = nil
        updates[removeQueue[i]] = nil
      end
      for i = #removeQueue, 1, -1 do
        table.remove(removeQueue, i)
      end
    end
    for k, v in next, userUpdateFunctions, nil do
      v.steps = v.steps + 1
      if v.steps >= v.stepRate then
        v.func()
        v.steps = 0
      end
    end
    collectgarbage(cgStep)
  end
end
updateLuaUserFunctions = _updateLuaUserFunctions()
function stopUserUpdates()
  for k, v in next, userUpdateFunctions, nil do
    removeUserUpdateFunction(k)
  end
end
