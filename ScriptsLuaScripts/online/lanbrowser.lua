local selected = 1
local lanBrowserMenu = {}
local title_position = vec.vector(0.2, 0.15, 0, 0)
local menuEntry_position = vec.vector(0.2, 0.25, 0, 1)
local menuStatus_position = vec.vector(0.2, 0.3, 0, 0)
local menuSpacing = 0.04
local buttonMenuSpacing = 0.1
local devElementsWereOnAtStart = false
local LANBusy = false
local colours = {
  default = vec.vector(1, 1, 1, 1),
  selection = vec.vector(0.5, 0.5, 1, 1),
  disabled = vec.vector(0.3, 0.3, 0.3, 1),
  disabledSelection = vec.vector(0.4, 0.4, 0.6, 1),
  title = vec.vector(0.8, 0.8, 1, 1)
}
local function clearCurrentMenu()
  if lanBrowserMenu then
    Development:clearScreen("all")
  end
end
local function drawMenu()
  if lanBrowserMenu and LANBrowserShown then
    local title_scale = 1.6
    local item_scale = 1
    local info_scale = 0.8
    local y = 0.2
    local textColour = LANBusy and colours.disabled or colours.default
    local selectionColour = LANBusy and colours.disabledSelection or colours.selection
    Development:add2DText(0, lanBrowserMenu.title, title_position, colours.title, title_scale, -1)
    for i = 1, #lanBrowserMenu.entries do
      menuEntry_position[1] = y
      Development:add2DText(i, lanBrowserMenu.entries[i].name, menuEntry_position, i == selected and selectionColour or textColour, item_scale, -1)
      if lanBrowserMenu.entries[i].name == "CREATE SESSION" then
        y = y + buttonMenuSpacing
      else
        y = y + menuSpacing
      end
    end
    if LANBusy then
      Development:add2DText(1001, "PLEASE WAIT...", menuStatus_position, colours.default, info_scale, -1)
    else
      Development:add2DText(1001, Network.getLANSessionCount() .. " SESSION(S) FOUND", menuStatus_position, textColour, info_scale, -1)
    end
  end
end
local recreateLANMenu = false
local function refreshMenuWhenDone()
  if not Network.isLANBusy() then
    recreateLANMenu()
    LANBusy = false
    drawMenu()
    removeUserUpdateFunction("refreshMenuWhenDone")
  end
end
function recreateLANMenu()
  lanBrowserMenu = {
    title = "LAN BROWSER",
    entries = {
      {
        name = "FIND SESSIONS",
        action = function()
          Network.findLAN()
          name = "BUSY"
          LANBusy = true
          drawMenu()
          addUserUpdateFunction("refreshMenuWhenDone", refreshMenuWhenDone, 10, true)
        end
      },
      {
        name = "CREATE SESSION",
        action = function()
          Network.createLAN()
          hideLANBrowser()
        end
      }
    }
  }
  local numSessions = Network.getLANSessionCount()
  for i = 1, numSessions do
    if Network.getLANSessionPlayerCount(i) ~= 1 or not ("> " .. Network.getLANSessionName(i)) then
    end
    sessionName = "> " .. Network.getLANSessionName(i) .. " and " .. Network.getLANSessionPlayerCount(i) - 1 .. " friend(s)"
    table.insert(lanBrowserMenu.entries, {
      name = sessionName,
      action = function()
        Network.joinLAN(i)
        hideLANBrowser()
      end
    })
  end
end
recreateLANMenu()
local function ShowLANBrowser()
  OnlineModeSettings.onlineDisableAssert = true
  localPlayer:SetZapLevel(5)
  OnlineModeSettings.onlineDisableAssert = false
  LANBrowserShown = true
  drawMenu()
  if devElementsOn == false then
    Development:useDevText(true)
  end
  controlHandler:registerState(localPlayer.localID, "LANBrowser", LANBrowserCallbacks)
  controlHandler:setState("LANBrowser")
  controller.disableGameControls()
  devElementsWereOnAtStart = devElementsOn
  if not devElementsWereOnAtStart then
    toggleDevElements()
  end
end
_G.ShowLANBrowser = ShowLANBrowser
local function hideLANBrowser()
  selected = 1
  clearCurrentMenu()
  if devElementsOn == false then
    Development:useDevText(false)
  end
  LANBrowserShown = false
  controlHandler:resetState("LANBrowser")
  controlHandler:removeState("LANBrowser", localPlayer.localID)
  if not devElementsWereOnAtStart then
    toggleDevElements()
  end
end
_G.hideLANBrowser = hideLANBrowser
local function step(menu, change)
  selected = selected + change
  if selected < 1 then
    selected = #menu.entries
  elseif selected > #menu.entries then
    selected = 1
  end
end
local function stepMenu(moveStep)
  if not LANBusy then
    step(lanBrowserMenu, moveStep)
    drawMenu()
  end
end
local function stepMenuUp()
  stepMenu(-1)
end
local function stepMenuDown()
  stepMenu(1)
end
local function stepMenuSelect()
  if lanBrowserMenu.entries[selected].action ~= nil then
    lanBrowserMenu.entries[selected].action()
  end
end
LANBrowserCallbacks = {
  Menu_Down = {
    JustPressed = {
      [1] = stepMenuDown
    }
  },
  Menu_Up = {
    JustPressed = {
      [1] = stepMenuUp
    }
  },
  Menu_Select = {
    JustPressed = {
      [1] = stepMenuSelect
    }
  }
}
