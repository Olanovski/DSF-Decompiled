local lastAudioFinished = 0
local function audioCallback(callback)
  local callback = callback
  return function()
    lastAudioFinished = g_NetworkTime
    if not localPlayer.blockHUD then
      scoreSystem.blockWillpowerPrompt(false)
    end
    if callback then
      callback()
    end
  end
end
function isEventActive()
  return not Commentary.Available()
end
local pipName = {
  PIP01 = true,
  PIP02 = true,
  PIP03 = true,
  PIP04 = true,
  PIP05 = true,
  PIP06 = true,
  PIP07 = true,
  PIP08 = true,
  PIP09 = true,
  PIP10 = true,
  PIP11 = true,
  PIP12 = true,
  PIP13 = true,
  PIP14 = true,
  PIP15 = true
}
function eventFeedback(agent, event, callback, playType)
  local playbackState = 0
  if pipName[event] then
    scoreSystem.blockWillpowerPrompt(true)
  end
  if playType then
    if playType == "missionCritical" then
      playbackState = 1
    elseif playType == "timeSensitive" then
      playbackState = 2
    elseif playType == "queued" then
      playbackType = 3
    end
  end
  local success = Commentary.TriggerEvent(event, nil, audioCallback(callback), nil, false, playbackState)
  return success
end
function didRecentAudio(secs)
  local secs = secs or 5
  if not Commentary.Available() then
    return true
  elseif secs > g_NetworkTime - lastAudioFinished then
    return true
  else
    return false
  end
end
local printCounter = 1
local function doPrint(text)
  if Commentary.InDebugMode() then
    Development:add2DText(printCounter, text, vec.vector(0.4, 0.75 + printCounter / 33, 0, 0), vec.vector(1, 1, 1, 1), 1, 3)
    printCounter = printCounter + 1
    if printCounter == 5 then
      printCounter = 1
    end
    print(text)
  end
end
