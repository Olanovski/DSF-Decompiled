local menus = {}
local currentMenu = {}
function nextMenu(name)
  return function(prev)
    print(name)
    local t = menus[name]
    if t then
      t.prev = currentMenu
      print(name, t)
    end
    currentMenu = t
    return t
  end
end
function prevMenu()
  if currentMenu.prev then
    currentMenu.selection = 1
    local p = currentMenu.prev
    currentMenu.prev = nil
    currentMenu = p
  end
end
function menu(a)
  menus[a.title] = {}
  menus[a.title] = a
  menus[a.title].selection = 3
end
function entry(e)
  return e
end
menu({title = "/Driver"})
currentMenu = menus["/Driver"]
local menuSetting = {
  xpos = 0.1,
  ypos = 0.15,
  scale = 0.9
}
local colours = {
  default = vec.vector(1, 1, 1, 1),
  selection = vec.vector(1, 0, 0, 1)
}
local function _stepGameMenu()
  local pad = controller.getPad(1)
  local Menu_Down = "Menu_Down"
  local Menu_Up = "Menu_Up"
  local Menu_Select = "Menu_Select"
  local Menu_Cancel = "Menu_Cancel"
  local Menu_Down_Status, Menu_Up_Status, Menu_Select_Status, Menu_Cancel_Status
  local watch_for = "JustPressed"
  local clear = "ALL"
  local blankString = "NoName"
  local title_position = vec.vector(0.08, 0.05, 0, 0)
  local font_scale = 1.2
  local version = debugOptions.versionString or "Build version unknown"
  local version_position = vec.vector(0.7, 0.85, 0, 0)
  local version_scale = 0.6
  local network_version = "v " .. Network.getVersionString()
  local network_version_position = vec.vector(0.7, 0.875, 0, 0)
  local network_version_scale = 0.6
  local total_network_sessions_found = "0 sessions"
  local total_network_sessions_found_position = vec.vector(0.7, 0.9, 0, 0)
  local total_network_sessions_found_scale = 0.6
  local position = vec.vector(0, 0, 0, 0)
  local param = {
    input = 1,
    textIndex = -1,
    xpos = 0,
    ypos = 0,
    isSelected = false
  }
  configSelector.configIndex = 2
  return function()
    local p = 0.05
    local t = 1
    Development:removeDevTextBatch(666)
    Development:startDevTextBatch(666)
    Development:add2DText(t, currentMenu.title, title_position, colours.default, font_scale, -1)
    t = t + 1
    Development:add2DText(t, version, version_position, colours.default, version_scale, -1)
    t = t + 1
    param.input = pad
    configSelector.stepConfigList(param)
    Development:endDevTextBatch()
  end
end
stepGameMenu = _stepGameMenu()
addUserUpdateFunction("configurationSelect", stepGameMenu, 1)
