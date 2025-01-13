local CommentaryLIABDebug = false
local function ToggleCommentaryLIABDebug(mode, character)
  if CommentaryLIABDebug == false then
    CommentaryLIABDebug = true
    Commentary.StartLIABDebug(mode, character)
  else
    CommentaryLIABDebug = false
    Commentary.StopLIABDebug()
  end
end
local LIABDebugCallback = function()
  StopLIABDebugCharacter()
end
local function SetLIABDebugCharacter(mode, character)
  if CommentaryLIABDebug == false then
    CommentaryLIABDebug = true
    Commentary.StartLIABDebug(mode, character, LIABDebugCallback)
  else
    Commentary.StopLIABDebug()
    Commentary.StartLIABDebug(mode, character, LIABDebugCallback)
  end
end
local function StopLIABDebugCharacter()
  if CommentaryLIABDebug == true then
    Commentary.StopLIABDebug()
    CommentaryLIABDebug = false
  end
end
local CommentaryDebugMenu = {}
table.insert(CommentaryDebugMenu, {
  name = "LIAB Debug",
  action = changePauseMenu("LIABDebugMenu"),
  info = "LIAB Debug Menu"
})
table.insert(CommentaryDebugMenu, {
  name = "Mission Commentary Debug",
  action = changePauseMenu("MissionCommentaryDebug"),
  info = "Mission Commentary Debug Menu"
})
table.insert(CommentaryDebugMenu, {
  name = "Back",
  action = changePauseMenu("Pause"),
  info = "Return to previous menu"
})
addPauseMenu("CommentaryDebugMenu", CommentaryDebugMenu)
local LIABDebugMenu = {}
table.insert(LIABDebugMenu, {
  name = "Toggle Rolling Mode",
  action = function()
    ToggleCommentaryLIABDebug(0, nil)
  end,
  info = "Toggle Rolling LIAB Debug"
})
table.insert(LIABDebugMenu, {
  name = "Toggle Interactive Mode",
  action = function()
    ToggleCommentaryLIABDebug(1, nil)
  end,
  info = "Toggle Interactive LIAB Debug"
})
table.insert(LIABDebugMenu, {
  name = "OnDemand Character Mode",
  action = changePauseMenu("LIABChapters"),
  info = "LIAB Characters Menu"
})
table.insert(LIABDebugMenu, {
  name = "Back",
  action = changePauseMenu("CommentaryDebugMenu"),
  info = "Return to previous menu"
})
addPauseMenu("LIABDebugMenu", LIABDebugMenu)
local LIABChaptersMenu = {}
table.insert(LIABChaptersMenu, {
  name = "Back",
  action = changePauseMenu("LIABDebugMenu"),
  info = "Return to previous menu"
})
for i = 1, 7 do
  table.insert(LIABChaptersMenu, {
    name = "LIAB Chapter " .. i,
    action = changePauseMenu("LIABChapter" .. i),
    info = "Debug characters for chapter"
  })
end
addPauseMenu("LIABChapters", LIABChaptersMenu)
local LIABCharsMenu = {
  {},
  {},
  {},
  {},
  {},
  {},
  {}
}
local LIABCharacterTables = {
  LIABCharacters.LIABCharacters_01,
  LIABCharacters.LIABCharacters_02,
  LIABCharacters.LIABCharacters_03,
  LIABCharacters.LIABCharacters_04,
  LIABCharacters.LIABCharacters_05,
  LIABCharacters.LIABCharacters_06,
  LIABCharacters.LIABCharacters_07
}
for i, v in pairs(LIABCharsMenu) do
  table.insert(v, {
    name = "Back",
    action = changePauseMenu("LIABChapters"),
    info = "Return to previous menu"
  })
  for k in pairs(LIABCharacterTables[i]) do
    table.insert(v, {
      name = k,
      action = function()
        SetLIABDebugCharacter(2, k)
      end,
      info = k
    })
  end
  addPauseMenu("LIABChapter" .. i, v)
end
local MissionComMenu = {}
table.insert(MissionComMenu, {
  name = "Mission Events",
  action = function()
    ToggleCommentaryLIABDebug(3, nil)
  end,
  info = "Debug Mission Events"
})
table.insert(MissionComMenu, {
  name = "Back",
  action = changePauseMenu("CommentaryDebugMenu"),
  info = "Return to previous menu"
})
addPauseMenu("MissionCommentaryDebug", MissionComMenu)
