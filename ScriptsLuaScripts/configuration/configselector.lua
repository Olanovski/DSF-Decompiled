function loadScripts()
  print("-- Load Scripts -- ")
  loadConfigFiles()
end
function launchScripts()
  print("-- LaunchScripts -- ")
  initialiseObjects()
  gameStatus.initialiseScripts()
end
local _forceLevelActive = false
forceLevel = nil
function forceLevelActive()
  print(_forceLevelActive)
  print(forceLevel)
  if _forceLevelActive or forceLevel then
    _forceLevelActive = true
    return true
  end
  return false
end
module("configSelector", package.seeall)
configs = {}
configIndex = 1
configMenuSetting = {
  xpos = 0.2,
  ypos = 0.15,
  scale = 0.8,
  configYChange = 0.04
}
launchConfig = {}
configSelectionColour = vec.vector(1, 0, 0, 1)
local thePos = vec.vector(0, 0, 0, 0)
local colour = vec.vector(1, 1, 1, 1)
function configEntry(configParams)
  local newConfig = {}
  for k, v in next, configParams, nil do
    newConfig[k] = v
  end
  for k, v in next, configSelector.defaultConfig, nil do
    if newConfig[k] == nil then
      newConfig[k] = v
    end
  end
  configs[#configs + 1] = newConfig
end
function drawConfigList()
  local c = configs[configIndex]
  if c ~= nil then
    Development:add2DText(1, c.Name or "NoName", vec.vector(0, 0.1, 0, 0), vec.vector(0, 0, 1, 1), 1, -1)
  end
end
function stepConfigList(info)
  if info.input then
    local pad = info.input
    local status, value = pad:status("Menu_Down")
    if status == "JustPressed" then
      configIndex = configIndex + 1
      if configIndex > #configs then
        configIndex = 0
      end
      if configIndex ~= 0 then
        while configs[configIndex].hidden do
          configIndex = configIndex + 1
          if configIndex > #configs then
            configIndex = 0
          end
          if configIndex == 0 then
            break
          end
        end
      end
      Development:clearScreen("ALL")
    end
    status, value = pad:status("Menu_Up")
    if status == "JustPressed" then
      configIndex = configIndex - 1
      if configIndex ~= 0 then
        if configIndex < 0 then
          configIndex = #configs
        end
        while configs[configIndex].hidden do
          configIndex = configIndex - 1
          if configIndex == 0 then
            break
          end
        end
      end
      Development:clearScreen("ALL")
    end
    status, value = pad:status("Menu_Select")
    if status == "JustPressed" then
      if configIndex == 0 then
        framework.quit()
      else
        configLaunch()
        Development:clearScreen("ALL")
        return t
      end
    end
  end
  local theconfig = configs[configIndex]
  local xpos = configMenuSetting.xpos
  local ypos = configMenuSetting.ypos
  local scale = configMenuSetting.scale
  local t = 12
  thePos.x = configMenuSetting.xpos
  thePos.y = configMenuSetting.ypos
  ypos = ypos + configMenuSetting.configYChange
  if configIndex == 0 then
    Development:add2DText(t, "Quit to Dash", thePos, configSelectionColour, scale, -1)
  else
    Development:add2DText(t, "Quit to Dash", thePos, colour, scale, -1)
  end
  t = t + 1
  for k, v in next, configs, nil do
    if v.hidden == nil then
      thePos.x = xpos
      thePos.y = ypos
      ypos = ypos + configMenuSetting.configYChange
      if configIndex == k then
        Development:add2DText(t, v.Name or "No Name", thePos, configSelectionColour, scale, -1)
      else
        Development:add2DText(t, v.Name or "No Name", thePos, colour, scale, -1)
      end
      t = t + 1
    end
  end
  return t
end
function selectConfig(config)
  for i = 1, #configs do
    if string.lower(configs[i].Name) == string.lower(config) then
      configIndex = i
      break
    end
  end
end
function setLaunchConfig(config)
  local theconfig
  if config ~= nil then
    if type(config) == "string" then
      for k, v in next, configs, nil do
        if v.Name == config then
          theconfig = v
          break
        end
      end
    end
  else
    theconfig = configs[configIndex]
  end
  launchConfig = theconfig
end
function configLaunch(forceLevel)
  configLaunchAndForceDefaultUser(forceLevel, false)
end
function configLaunchAndForceDefaultUser(forceLevel, forceDefaultUser)
  if forceLevel then
    _forceLevelActive = true
  end
  setLaunchConfig(forceLevel)
  if PauseMenu.allow then
    PauseMenu.allow(true)
  end
  local failMessage = initialise.setInitData(launchConfig)
  if launchConfig.forceOffline then
    Network.setConnectionOffline()
  end
  if failMessage ~= nil then
    print("Launch Failure:" .. tostring(failMessage))
  else
    print("Launch is good to go")
    removeUserUpdateFunction("configurationSelect")
    Development:clearScreen("ALL")
    Network.disableSplitScreenMode()
    if launchConfig.Name == "Single Player" or launchConfig.Name == [[
Multiplayer
Party Bus]] or launchConfig.Name == "Split Screen" then
      if launchConfig.Name == "Split Screen" then
        Network.enableSplitScreenMode()
      end
      initialise.continueGame(forceDefaultUser)
    else
      if launchConfig.Name ~= "Replay" then
        ProfileSettings.ClearProgression()
        ProfileSettings.ClearStatistics()
      end
      initialise.launchGame(forceDefaultUser)
    end
  end
end
function getConfigs()
  for k, v in next, configs, nil do
    print("<config>" .. v.Name .. "</config>")
  end
end
GameLauncher.SetGameState("Waiting for Config")
open("configuration\\configs.lua")
