module("replays", package.seeall)
local pauseCount = 0
local recording = false
function isInReplayConfig()
  return configSelector.launchConfig.Name == "Replay"
end
_G.isInReplayConfig = isInReplayConfig
function start()
  print("Starting recording")
  callStack()
  ReplaySystem.StartRecording()
  recording = true
end
function pause()
  print("replays.pause()")
  callStack()
  if recording then
    pauseCount = pauseCount + 1
    ReplaySystem.PauseRecording()
  end
end
function unPause()
  print("replays.unPause()")
  callStack()
  if recording then
    for i = 1, pauseCount do
      ReplaySystem.UnPauseRecording()
    end
    pauseCount = 0
  end
end
