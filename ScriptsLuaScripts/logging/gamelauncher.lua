GameLauncher = {}
GameLauncher.ScriptDebugger = {MemoryTrack = false, SourceFileTrack = false}
local GameState = "Game Started"
function GameLauncher.GetGameState()
  print("$GAMELAUNCHER$<GAMESTATE>" .. GameState)
end
function GameLauncher.SetGameState(strState)
  GameState = strState
  print("$GAMELAUNCHER$<GAMESTATE>" .. GameState)
end
function GameLauncher.StartScriptDebugger(mode)
  if mode == "Start" then
    ScriptDebugger.Start()
  elseif mode == "PauseAll" then
    ScriptDebugger.PauseAll()
  elseif mode == "Stop" then
    ScriptDebugger.Stop()
  end
end
function GameLauncher.SetLuaMemoryTrack(value)
  GameLauncher.ScriptDebugger.MemoryTrack = value
end
function GameLauncher.SetLuaSourceTrack(value)
  GameLauncher.ScriptDebugger.SourceFileTrack = value
end
function GameLauncher.Set_Breakpoint(file, line)
  ScriptDebugger.Set_Breakpoint(file, line)
end
