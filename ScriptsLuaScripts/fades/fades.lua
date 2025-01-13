module("fades", package.seeall)
local debugOutput = function(output)
  print(" == | Fades | " .. tostring(output))
end
function down(functionToCallOnCompletion, duration)
  local function fadeDone()
    replays.pause()
    abilities.thrillCam.disable()
    if functionToCallOnCompletion then
      functionToCallOnCompletion()
    end
  end
  if not gameStatus.onlineSession then
    for localID, plr in next, localPlayerManager.players, nil do
      plr:enterCutsceneMode()
    end
  end
  debugOutput("Down")
  transitions.fadeto(colour or vec.vector(0, 0, 0, 1), 0, duration or 1, fadeDone, true, true, "all")
end
function up(functionToCallOnCompletion, duration)
  local function fadeDone()
    if functionToCallOnCompletion then
      functionToCallOnCompletion()
    end
    if not gameStatus.onlineSession then
      for localID, plr in next, localPlayerManager.players, nil do
        if not vehicleManager.previewVehicleManager.previewVehicle and not localPlayer.challenge.showingEndScreen then
          plr:exitCutsceneMode()
        end
      end
    end
    abilities.thrillCam.enable()
  end
  debugOutput("Up")
  replays.unPause()
  transitions.fadeto(colour or vec.vector(0, 0, 0, 0), 1, duration or 1, fadeDone, true, true, "all")
end
