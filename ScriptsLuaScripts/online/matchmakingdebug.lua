local selected = 1
local matchmakingMenu = {}
local title_position = vec.vector(0.2, 0.15, 0, 0)
local menuEntry_position = vec.vector(0.2, 0.2, 0, 1)
local menuStatus_position = vec.vector(0.5, 0.2, 0, 1)
local menuSpacing = 0.04
local buttonMenuSpacing = 0.1
local list_position = vec.vector(0.5, 0.3, 0, 1)
local listSpacing = 0.1
local colours = {
  default = vec.vector(0.94, 0.667, 0.157, 1),
  selection = vec.vector(1, 1, 0, 1),
  disabled = vec.vector(0.3, 0.3, 0.3, 1),
  disabledSelection = vec.vector(0.4, 0.4, 0.6, 1),
  title = vec.vector(0.99, 0.5, 0.067, 1)
}
local function clearCurrentMenu()
  if matchmakingMenu then
    Development:clearScreen("all")
  end
end
local function drawMenu()
  if matchmakingMenu and MatchmakingDisplayEnabled then
    local title_scale = 1.6
    local item_scale = 1
    local info_scale = 0.8
    local y = 0.2
    local textColour = colours.default
    local selectionColour = colours.selection
    Development:add2DText(0, matchmakingMenu.title, title_position, colours.title, title_scale, -1)
    for i = 1, #matchmakingMenu.entries do
      menuEntry_position[1] = y
      if i == selected then
        Development:add2DText(i, matchmakingMenu.entries[i].name, menuEntry_position, selectionColour, 1.1, -1)
      else
        Development:add2DText(i, matchmakingMenu.entries[i].name, menuEntry_position, textColour, item_scale, -1)
      end
      if matchmakingMenu.entries[i].name == "CREATE MATCH" then
        y = y + buttonMenuSpacing
      else
        y = y + menuSpacing
      end
    end
    Development:add2DText(1001, Network.getLANSessionCount() .. " MATCH(ES) FOUND", menuStatus_position, textColour, info_scale, -1)
  end
end
local recreateMatchmakingMenu = false
local function refreshMenuWhenDone()
  if not Network.isLANBusy() then
    recreateMatchmakingMenu()
    drawMenu()
    removeUserUpdateFunction("refreshMenuWhenDone")
  end
end
function recreateMatchmakingMenu()
  matchmakingMenu = {
    title = "MATCHMAKING VIEWER",
    entries = {
      {
        name = "FIND MATCHES",
        action = function()
          Network.findLAN()
          name = "BUSY"
          drawMenu()
          addUserUpdateFunction("refreshMenuWhenDone", refreshMenuWhenDone, 10, true)
        end
      },
      {
        name = "CUSTOMISE FILTERS...",
        action = function()
          Network.createLAN()
          hideMatchmakingDisplay()
        end
      },
      {
        name = "CREATE MATCH",
        action = function()
          Network.createLAN()
          hideMatchmakingDisplay()
        end
      }
    }
  }
  local numSessions = Network.getLANSessionCount()
  for i = 1, numSessions do
    if Network.getLANSessionPlayerCount(i) ~= 1 or not ("> " .. Network.getLANSessionName(i)) then
    end
    sessionName = "> " .. Network.getLANSessionName(i) .. " and " .. Network.getLANSessionPlayerCount(i) - 1 .. " friend(s)"
    table.insert(matchmakingMenu.entries, {
      name = sessionName,
      action = function()
        Network.joinLAN(i)
        hideMatchmakingDisplay()
      end
    })
  end
end
recreateMatchmakingMenu()
local function EnableMatchmakingDisplay()
  OnlineModeSettings.onlineDisableAssert = true
  localPlayer:SetZapLevel(5)
  OnlineModeSettings.onlineDisableAssert = false
  MatchmakingDisplayEnabled = true
  drawMenu()
  if devElementsOn == false then
    Development:useDevText(true)
  end
  controlHandler:registerState(localPlayer.localID, "MatchmakingDisplay", MatchmakingDisplayCallbacks)
  controlHandler:setState("MatchmakingDisplay")
end
_G.EnableMatchmakingDisplay = EnableMatchmakingDisplay
local function DisableMatchmakingDisplay()
  selected = 1
  clearCurrentMenu()
  if devElementsOn == false then
    Development:useDevText(false)
  end
  MatchmakingDisplayEnabled = false
  controlHandler:resetState("MatchmakingDisplay")
  controlHandler:removeState("MatchmakingDisplay", localPlayer.localID)
end
_G.DisableMatchmakingDisplay = DisableMatchmakingDisplay
local function step(menu, change)
  selected = selected + change
  if selected < 1 then
    selected = #menu.entries
  elseif selected > #menu.entries then
    selected = 1
  end
end
local function stepMenu(moveStep)
  step(matchmakingMenu, moveStep)
  drawMenu()
end
local function stepMenuUp()
  stepMenu(-1)
end
local function stepMenuDown()
  stepMenu(1)
end
local function stepMenuSelect()
  if matchmakingMenu.entries[selected].action ~= nil then
    matchmakingMenu.entries[selected].action()
  end
end
MatchmakingDisplayCallbacks = {
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
