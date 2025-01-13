module("cutsceneManager", package.seeall)
local scenes = {}
local inScene, currentSceneCallback, currentSceneCallbackReturn
local function sceneEnd()
  localPlayer:exitCutsceneMode()
  if currentSceneCallback then
    currentSceneCallback(currentSceneCallbackReturn)
  end
  currentSceneCallback = nil
  inScene = false
end
function registerScene(name, defaultParamsTable, generatorFunction)
  scenes[name] = {params = defaultParamsTable, generator = generatorFunction}
end
function startScene(name, paramsTable, callbackFunction)
  if inScene then
    cancelCurrentScene()
  else
    inScene = true
  end
  if not scenes[name] then
    print("Cannot find scene '" .. name .. "'. Ensure it got registered correctly by cutsceneManager.registerScene()")
    callStack()
    return
  end
  local params = scenes[name].params or {}
  for k, v in next, paramsTable, nil do
    params[k] = v
  end
  local cutscene, cutsceneReturn = scenes[name].generator(params)
  currentSceneCallback = callbackFunction
  currentSceneCallbackReturn = cutsceneReturn
  table.insert(cutscene, {action = "callback", callback = sceneEnd})
  CameraSystem.AddScene(cutscene)
  localPlayer:enterCutsceneMode()
end
function cancelCurrentScene()
  if inScene then
    sceneEnd()
  end
end
