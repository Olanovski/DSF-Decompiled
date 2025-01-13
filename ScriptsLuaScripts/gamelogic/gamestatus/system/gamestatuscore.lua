module("gameStatus", package.seeall)
platformID = {
  PS3 = 4,
  XBOX360 = 6,
  PC = 2
}
onlineSessionID = {
  public = 1,
  private = 2,
  lan = 3,
  partyMode = 4,
  lanPartyMode = 5
}
updates.ScriptSystem = 30
onlineSession = false
onlineSessionType = false
onlineIsLan = false
splitscreenSession = false
simulationPaused = false
onlinePaused = false
platform = false
function setSimulationPaused(isPaused)
  simulationPaused = isPaused
  gameStatusReflection.setSimulationPaused(isPaused)
end
function registerEvent(eventType, eventName, eventFunction)
  local eventTable = gameStatus[eventType .. "Events"]
  assert(eventTable, "GAMESTATUS EVENTS - registerEvent: Invalid eventType '" .. tostring(eventType) .. "'")
  assert(type(eventName) == "string", "GAMESTATUS EVENTS - registerEvent: Attempt to register event with invalid name")
  assert(not eventTable[eventName], "GAMESTATUS EVENTS - registerEvent: Attempt to re-register existing event: " .. tostring(eventName))
  eventTable[eventName] = eventFunction
end
function toggleSimulationPaused(state)
  if state == "true" then
    if not GetHUDOn() then
      Menu.HideUI = 0
    end
    TriggerPauseMenu()
    setSimulationPaused(true)
  elseif state == "cutscene" then
    if scriptController then
      scriptController.simulationPaused = true
    end
  else
    clearPauseMenu()
    removeUserUpdateFunction("PauseMenu")
    setSimulationPaused(false)
    if not GetHUDOn() then
      Menu.HideUI = 1
    end
  end
end
_G.simulationPaused = toggleSimulationPaused
function toggleOnlinePaused(state)
  if state == "true" then
    onlinePaused = true
  else
    onlinePaused = false
  end
end
_G.onlinePaused = toggleOnlinePaused
