local debug = require("debug")
ScriptDebugger = {}
local breakpoints = {}
local funcLog = {}
local StepLuaDebug = false
local stack_level = 0
local step_level = 0
local debugMode = "STOP"
local idebugCommand = false
local MergeValue = function(value)
  local i, j = string.find(value, "\n")
  while i ~= nil do
    local first = string.sub(value, 1, i - 1)
    local second = string.sub(value, i + 1, string.len(value))
    value = first .. ", " .. second
    i, j = string.find(value, "\n")
  end
  return value
end
local function localTable(name, t)
  local tableAddr = {}
  local function printTable(name, t)
    tableAddr[t] = true
    print("$ScriptDebugger$<LocalValue><TableSetUp>")
    print("$ScriptDebugger$<LocalValue>" .. name .. "     :   " .. tostring(t))
    name = name or ""
    for k, v in pairs(t) do
      if type(k) == "string" then
        k = "[\"" .. k .. "\"]"
      else
        k = "[" .. tostring(k) .. "]"
      end
      k = name .. k
      if type(v) == "table" then
        if tableAddr[v] then
          print("$ScriptDebugger$<LocalValue>" .. k .. "     :   " .. tostring(v))
        else
          printTable(k, v)
        end
      elseif v ~= nil then
        if type(v) == "string" then
          v = "\"" .. v .. "\""
        else
          v = MergeValue(tostring(v))
        end
        print("$ScriptDebugger$<LocalValue>" .. k .. "     :   " .. v)
      end
    end
    print("$ScriptDebugger$<LocalValue><TableEnd>")
  end
  printTable(name, t)
end
local function catchValue()
  local level = 3
  local func = debug.getinfo(level, "flnSu").func
  local i = 1
  while true do
    if func == nil then
      break
    end
    local name, value = debug.getupvalue(func, i)
    if not name then
      break
    end
    typeofvalue = type(value)
    if name == "(*temporary)" then
    elseif name == "(for state)" then
    elseif typeofvalue == "table" then
      localTable(name, value)
    elseif value ~= nil then
      if type(value) == "string" then
        value = "\"" .. value .. "\""
      else
        value = MergeValue(tostring(value))
      end
      print("$ScriptDebugger$<LocalValue>" .. name .. "     :   " .. value)
    end
    i = i + 1
  end
  i = 1
  while true do
    local name, value = debug.getlocal(level, i)
    if not name then
      break
    end
    typeofvalue = type(value)
    if name == "(*temporary)" then
    elseif name == "(for state)" then
    elseif typeofvalue == "table" then
      localTable(name, value)
    elseif value ~= nil then
      if type(value) == "string" then
        value = "\"" .. value .. "\""
      else
        value = MergeValue(tostring(value))
      end
      print("$ScriptDebugger$<LocalValue>" .. name .. "     :   " .. value)
    end
    i = i + 1
  end
end
function ScriptDebugger.Set_Breakpoint(file, line)
  file = string.upper(file)
  if not breakpoints[file] then
    breakpoints[file] = {}
  end
  if breakpoints[file][line] ~= nil and breakpoints[file][line] then
    return
  end
  breakpoints[file][line] = true
end
function ScriptDebugger.Remove_Breakpoint(file, line)
  file = string.upper(file)
  if breakpoints[file] and breakpoints[file][line] ~= nil then
    print("$ScriptDebugger$<RemoveBreakpoint>" .. file .. " : " .. line)
    breakpoints[file][line] = nil
  end
end
function ScriptDebugger.Pause_Breakpoint(file, line)
  file = string.upper(file)
  if not breakpoints[file] then
    breakpoints[file] = {}
  end
  breakpoints[file][line] = false
end
local function Sethook(why)
  local info = debug.getinfo(2, "Sl")
  if info.what ~= "Lua" then
    return
  end
  if GameLauncher.ScriptDebugger.MemoryTrack == true and why == "call" then
    print("$ScriptDebugger$<Luamemory>" .. gcinfo())
  end
  local file = info.source
  local source = file
  local line = info.currentline
  if GameLauncher.ScriptDebugger.SourceFileTrack == true then
    print("$ScriptDebugger$<RunningLua>" .. file)
  end
  local path = string.gsub(source, "\\", "/")
  for w in string.gfind(path, "[^/]+") do
    source = w
  end
  source = string.upper(source)
  if breakpoints[source] and breakpoints[source][line] then
    debugMode = "PAUSE"
    file = source
  end
  if why == "call" then
    stack_level = stack_level + 1
    local info2 = debug.getinfo(2, "n")
    local name = info2.name or "UNKNOWN"
    if #funcLog == 10 then
      table.remove(funcLog, 10)
    end
    table.insert(funcLog, 1, file .. "(" .. line .. "):" .. name)
  elseif why == "return" then
    stack_level = stack_level - 1
  elseif debugMode == "PAUSE" or debugMode == "STEPOVER" and stack_level <= step_level or debugMode == "STEPOUT" and stack_level < step_level then
    debugMode = "START"
    local crc = 0
    print("$ScriptDebugger$<SETUP>" .. file .. " : " .. line .. " : " .. crc)
    catchValue()
    print("$ScriptDebugger$<End>" .. file .. " : " .. line)
    print("$ScriptDebugger$<LuaFunctionLogSetup>" .. file .. " : " .. line)
    for k, v in pairs(funcLog) do
      print("$ScriptDebugger$<LuaFunction><" .. k .. ">" .. v)
    end
    StepLuaDebug = true
    while StepLuaDebug == true do
      luaConsole.luaConsoleUpdate()
    end
    return
  end
  if idebugCommand == false then
    luaConsole.luaConsoleUpdate()
  end
end
function ScriptDebugger.DebugCommand(value)
  idebugCommand = value
end
function ScriptDebugger.Start()
  debugMode = "START"
  StepLuaDebug = false
  print("$ScriptDebugger$<STARTDEBUG>")
  debug.sethook(Sethook, "crl", 0)
end
function ScriptDebugger.StepOver()
  StepLuaDebug = false
  debugMode = "STEPOVER"
  stack_level = 0
  step_level = stack_level
end
function ScriptDebugger.StepOut()
  debugMode = "STEPOUT"
  StepLuaDebug = false
  stack_level = 0
  step_level = stack_level
end
function ScriptDebugger.StepInto()
  debugMode = "PAUSE"
  StepLuaDebug = false
end
function ScriptDebugger.Stop()
  debugMode = "STOP"
  StepLuaDebug = false
  debug.sethook(Sethook, 0)
  print("$ScriptDebugger$<STOPDEBUG>")
end
function ScriptDebugger.PauseAll()
  debugMode = "PAUSE"
  StepLuaDebug = false
  print("$ScriptDebugger$<STARTDEBUG>")
  if debugMode == "PAUSE" then
    debug.sethook(Sethook, "crl", 0)
  end
end
