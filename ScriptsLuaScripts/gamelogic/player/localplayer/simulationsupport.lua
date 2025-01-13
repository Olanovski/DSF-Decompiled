module("localPlayer.simulationSupport", package.seeall)
slowingDown = false
speedingUp = false
function purge()
  if slowingDown then
    removeUserUpdateFunction("slowDownUpdate")
  end
  if speedingUp then
    removeUserUpdateFunction("speedUpUpdate")
  end
  removeUserUpdateFunction("waitUpdate")
end
local defaultSlowDownDuration = 0.5
local defaultSlowDownTarget = 0.05
local defaultSpeedUpDuration = 0.5
local defaultSpeedUpTarget = 1
local defaultBlockEnterCutsceneMode = false
function doSlowDown(callback, duration, target, blockEnteringCutsceneMode)
  duration = duration or defaultSlowDownDuration
  target = target or defaultSlowDownTarget
  local blockEnteringCutsceneMode = blockEnteringCutsceneMode or defaultBlockEnterCutsceneMode
  local startSimulationSpeed
  if localPlayer.inZap then
    startSimulationSpeed = zapcontroller.getZapSlowMotionMultiplier()
  else
    startSimulationSpeed = simulation.getSpeed()
  end
  local simulationSpeed = startSimulationSpeed
  local stepsToTake = duration * updates.stepRate
  local stepsTaken = 0
  if not blockEnteringCutsceneMode then
    localPlayer:enterCutsceneMode()
  end
  slowingDown = true
  removeUserUpdateFunction("speedUpUpdate")
  addUserUpdateFunction("slowDownUpdate", function()
    stepsTaken = stepsTaken + 1
    if stepsTaken < stepsToTake then
      simulationSpeed = lerp_value(startSimulationSpeed, target, stepsTaken / stepsToTake)
      simulation.setSpeed(simulationSpeed)
    else
      simulation.setSpeed(target)
      if callback then
        callback()
      end
      slowingDown = false
      removeUserUpdateFunction("slowDownUpdate")
    end
  end, 1)
end
function doSpeedUp(callback, duration, target)
  duration = duration or defaultSpeedUpDuration
  target = target or defaultSpeedUpTarget
  local startSimulationSpeed = simulation.getSpeed()
  local stepsToTake = duration * updates.stepRate
  local stepsTaken = 0
  removeUserUpdateFunction("slowDownUpdate")
  addUserUpdateFunction("speedUpUpdate", function()
    stepsTaken = stepsTaken + 1
    if stepsTaken < stepsToTake then
      simulationSpeed = lerp_value(startSimulationSpeed, target, stepsTaken / stepsToTake)
      simulation.setSpeed(simulationSpeed)
    else
      simulation.setSpeed(target)
      if callback then
        callback()
      end
      speedingUp = false
      removeUserUpdateFunction("speedUpUpdate")
    end
  end, 1)
end
local _getUID = function()
  local startUID = 17000
  local range = 1000
  local uid = startUID - 1
  return function()
    uid = uid + 1
    if uid >= startUID + range then
      uid = startUID
    end
    return uid
  end
end
local getUID = _getUID()
local name = "waitUpdate"
function doWait(waitTime, callback, nameOverride)
  local waitEnd = g_NetworkTime + waitTime
  local uid = getUID()
  local updateName = nameOverride or name .. tostring(uid)
  addUserUpdateFunction(updateName, function()
    if g_NetworkTime >= waitEnd then
      removeUserUpdateFunction(updateName)
      if callback then
        callback()
      end
    end
  end, 1)
end
