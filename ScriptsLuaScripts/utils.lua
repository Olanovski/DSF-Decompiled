local ripairsIterator = function(t, i)
  i = i - 1
  local v = t[i]
  if v ~= nil then
    return i, v
  end
  return nil
end
local ripairsMax
function ripairs(t)
  ripairsMax = 1
  while t[ripairsMax] ~= nil do
    ripairsMax = ripairsMax + 1
  end
  return ripairsIterator, t, ripairsMax
end
function tableToString(table, depth)
  local alreadyDone = {}
  local outputstring = ""
  local function printTable(table, indent)
    local result = ""
    local iChar = ">\t"
    for k, v in next, table, nil do
      if type(v) == "table" then
        if alreadyDone[v] then
          result = result .. string.rep(iChar, indent) .. k .. " [Visited]\n"
        elseif indent + 1 > depth then
          result = result .. string.rep(iChar, indent) .. k .. ": [Out of scope]\n"
        else
          result = result .. (string.rep(iChar, indent) or "") .. tostring(k) .. " :\n"
          alreadyDone[v] = true
          result = result .. printTable(v, indent + 1)
        end
      else
        result = result .. (string.rep(iChar, indent) or "") .. tostring(k) .. ":\n" .. (string.rep(iChar, indent + 1) or "") .. tostring(v) .. "\n"
      end
    end
    return result
  end
  outputstring = printTable(table, 0)
  return outputstring
end
function printTable(table, depth)
  depth = depth or math.huge
  if type(table) == "table" then
    local ostring = tableToString(table, depth)
    print("************************** Begin print of " .. tostring(table) .. " **************************")
    if ostring ~= "" then
      for line in string.gmatch(ostring, [[
([^
]*)]]) do
        if line ~= "" then
          print(line)
        end
      end
    else
      print("The table is empty or not a table")
    end
    print("************************** End print **************************")
  else
    print("Error - no table passed in!")
  end
end
function networkLogPrintTable(table, depth)
  depth = depth or math.huge
  if type(table) == "table" then
    local ostring = tableToString(table, depth)
    NetworkLog.Write(">[LUA] ************************** Begin print of " .. tostring(table) .. " **************************")
    if ostring ~= "" then
      for line in string.gmatch(ostring, [[
([^
]*)]]) do
        if line ~= "" then
          NetworkLog.Write(line)
        end
      end
    else
      NetworkLog.Write(">[LUA] The table is empty or not a table")
    end
    NetworkLog.Write(">[LUA] ************************** End print **************************")
  else
    NetworkLog.Write(">[LUA] Error - no table passed in!")
  end
end
function duplicateTable(source, target)
  if type(source) ~= "table" then
    print("No table passed into duplicateTable. Not necessarily a bad thing if used correctly.")
    return false
  end
  local visited = {}
  local function duplication(source, target)
    for k, v in next, source, nil do
      if type(v) == "table" then
        if not visited[v] then
          target[k] = {}
          visited[v] = target[k]
          duplicateTable(v, target[k])
        else
          target[k] = visited[v]
        end
      else
        target[k] = v
      end
    end
    return target
  end
  return duplication(source, target)
end
function deepCopy(object)
  local lookup_table = {}
  local function _copy(object)
    if type(object) ~= "table" then
      return object
    elseif lookup_table[object] then
      return lookup_table[object]
    end
    local new_table = {}
    lookup_table[object] = new_table
    for index, value in pairs(object) do
      new_table[_copy(index)] = _copy(value)
    end
    return setmetatable(new_table, getmetatable(object))
  end
  return _copy(object)
end
function findKeyInTable(root, key, branch)
  local visited = {}
  branch = branch or tostring(root)
  local function searchTableForKey(t, branch)
    visited[t] = true
    for k, v in next, t, nil do
      if k == key then
        branch = branch .. "." .. tostring(k) .. " = " .. tostring(v)
        print(branch)
      elseif type(v) == "table" and not visited[v] then
        searchTableForKey(v, branch .. "." .. tostring(k))
      end
    end
  end
  searchTableForKey(root, branch)
end
function findValueInTable(root, value, branch)
  local visited = {}
  branch = branch or tostring(root)
  local function searchTableForValue(t, branch)
    visited[t] = true
    for k, v in next, t, nil do
      if v == value then
        branch = branch .. "." .. tostring(k) .. " = " .. tostring(v)
        print(branch)
      elseif type(v) == "table" and not visited[v] then
        searchTableForValue(v, branch .. "." .. tostring(k))
      end
    end
  end
  searchTableForValue(root, branch)
end
function addMetaFunction(object, funcname, func)
  local m = getmetatable(object)
  m.__index = m
  m[funcname] = func
end
function table.getTheSize(t)
  if type(t) ~= "table" then
    print("table expected")
  else
    local c = 0
    for _, _ in next, t, nil do
      c = c + 1
    end
    return c
  end
  return 0
end
function table.isEmpty(t)
  for k, v in next, t, nil do
    return false
  end
  return true
end
endianSwapping = {}
function EndianSwapCheck(type, swapped)
  local entry = endianSwapping[type]
  if endianSwapping[type] == nil then
    endianSwapping[type] = {}
    if swapped == 1 then
      print(type .. " : Endian Swapped in code")
    end
  end
end
function callStack(level)
  local callStackTable = {}
  local level = level or 1
  local stack = debug.getinfo(level)
  while stack do
    local stackString = level .. ": " .. tostring(stack.short_src or stack.source) .. " ...  in function '" .. tostring(stack.name) .. "', line [" .. tostring(stack.currentline) .. "]"
    print("\t" .. stackString)
    local currentStack = {
      stack = stackString,
      locals = {},
      upvalues = {}
    }
    local locals = 1
    local currentName, currentValue = debug.getlocal(level, locals)
    while currentName do
      currentStack.locals[currentName] = currentValue
      locals = locals + 1
      currentName, currentValue = debug.getlocal(level, locals)
    end
    if stack.func then
      for i = 1, stack.nups do
        local currentUpName, currentUpvalue = debug.getupvalue(stack.func, i)
        if currentUpName then
          currentStack.upvalues[currentUpName] = currentUpvalue
        end
      end
    end
    table.insert(callStackTable, currentStack)
    level = level + 1
    stack = debug.getinfo(level)
  end
  return callStackTable
end
function hookCallStack(f)
  local function trap()
    local level = 1
    local stack = debug.getinfo(2)
    if stack and stack.func == f then
      print("Callstack hooked to function " .. tostring(f))
      callStack(3)
    end
  end
  debug.sethook(trap, "c")
end
function callStackAsTable(startLevel)
  local callStackTable = {}
  local level = startLevel or 2
  repeat
    local stack = debug.getinfo(level)
    if stack then
      table.insert(callStackTable, "\t" .. level .. ": " .. tostring(stack.short_src or stack.source) .. " ...  in function '" .. tostring(stack.name) .. "', line [" .. tostring(stack.currentline) .. "]")
      level = level + 1
    end
  until not stack
  return callStackTable
end
function watchTableForChanges(t)
  local _t = t
  local t = {}
  setmetatable(t, {
    __index = function(t, k)
      return _t[k]
    end,
    __newindex = function(t, k, v)
      if k ~= "suggestion" then
        print("watchTableForChanges - table being accessed - key: " .. tostring(k) .. " = " .. tostring(v))
        callStack()
      end
      _t[k] = v
    end
  })
  return t
end
function saveTable(t, name)
  local file = io.open(LuaMediaPath .. tostring(name) .. ".lua", "w+")
  local returnString = "\n"
  name = tostring(name)
  local visited = {}
  local function writeLine(string)
    file:write(string .. returnString)
  end
  local valueToString = function(v)
    if type(v) == "string" then
      return "\"" .. v .. "\""
    else
      return tostring(v)
    end
  end
  local function parseTable(name, t)
    visited[t] = name
    writeLine(name .. " = {}")
    for k, v in next, t, nil do
      if type(v) == "table" then
        if not visited[v] then
          parseTable(name .. "[" .. valueToString(k) .. "]", v)
        else
          writeLine(name .. "[" .. valueToString(k) .. "] = " .. visited[t])
        end
      else
        writeLine(name .. "[" .. valueToString(k) .. "] = " .. valueToString(v))
      end
    end
  end
  parseTable(name, t)
  io.close(file)
end
function debugOpen(filename)
  print("Lua Debug Loading : " .. filename)
  local f, error = loadfile(LuaMediaPath .. filename)
  local success = true
  if f == nil then
    print("\t" .. error)
    success = false
  else
    f()
  end
  return success
end
