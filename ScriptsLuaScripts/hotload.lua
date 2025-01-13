hotload = {}
local watchList = {}
function hotload.addWatch(name)
  watchList[name] = watchList[name] or {time = ""}
end
function hotload.removeWatch(name)
  watchList[name] = nil
end
local replaceRendererFile = function(name, info)
  print(string.format("reloading renderer file %s", name))
  if prevPackage then
    renderer.unloadModelContainer(info.package)
  end
  info.package = renderer.loadModelContainer(name)
end
local replaceLuaFile = function(name, info)
  print(string.format("re-opening Lua file", name))
  open(name)
end
function checkHotloadWatches()
  for name, info in pairs(watchList) do
    local time = file.getmodifytime(name)
    if (time or "") > info.time then
      if string.find(name, ".lua") then
        replaceLuaFile(name, info)
      else
        replaceRendererFile(name, info)
      end
      info.time = time
    end
  end
end
addUserUpdateFunction("hotload", function()
  checkHotloadWatches()
end, 120)
