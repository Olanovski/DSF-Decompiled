module("phaseManager")
local stateIndex = SplitScreenGlobalStateIndex
local debugCheck = function()
  print("SplitScreenGlobalState")
  NetworkLog.Write(">[LUA] SplitScreenGlobalState")
end
local enter = function()
end
local step = function()
  removeFlaggedForDeletionObjects()
  if challengeSystem.instances[networkVars.modeID] and challengeSystem.instances[networkVars.modeID].challenge.settings.raceMode and not challengeSystem.instances[networkVars.modeID]:instanceComplete() and networkVars.modeAreaIndex ~= 0 and challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].roads then
    if not onlineRaceManager.raceActive then
      onlineRaceManager.setupRace(challengeSystem.instances[networkVars.modeID])
      if not challengeSystem.instances[networkVars.modeID].challenge.settings.teamGame and localPlayerManager.numberOfPlayers == 1 then
        raceModePlayed = true
      end
    else
      onlineRaceManager.update()
    end
  end
end
local exit = function(forced)
end
local splitScreenGlobalState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(splitScreenGlobalState, stateIndex, "SplitScreenGlobalState")
