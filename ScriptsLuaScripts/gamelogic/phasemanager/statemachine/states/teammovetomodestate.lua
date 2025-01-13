module("phaseManager")
local stateIndex = TeamMoveToModeStateIndex
local stateComplete = false
local transitionTime = false
local moved = false
local transitionWait = 2
local moveToStartArea = function()
  local position = false
  if faceOffNext() then
    local playersInOrder = onlineScreenManager.getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.scoreNoID)
    if faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].gridStyle == 3 then
      for i, player in ipairs(playersInOrder) do
        if player then
          if player.id == localPlayer.playerID then
            if i == 1 or i == 3 or i == 5 or i == 7 then
              position = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].positionA
            else
              position = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].positionB
              else
                else
                  assert(false, "local player not found in the player data table or bad sort in the onlineScreenManager.getScreenCurrentPlayerTable - i = " .. tostring(i) .. " numPlayers = " .. tostring(playerManager.numberOfPlayers))
                end
                else
                  for i, player in ipairs(playersInOrder) do
                    if player then
                      if player.id == localPlayer.playerID then
                        if i == 1 or i == 5 then
                          position = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].positionA
                        elseif i == 2 or i == 6 then
                          position = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].positionB
                        elseif i == 3 or i == 7 then
                          position = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].positionC
                        else
                          position = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].positionD
                          else
                            else
                              assert(false, "local player not found in the player data table or bad sort in the onlineScreenManager.getScreenCurrentPlayerTable - i = " .. tostring(i) .. " numPlayers = " .. tostring(playerManager.numberOfPlayers))
                            end
                            elseif PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == challengeSystem.instances[networkVars.modeID].networkVars.roundOn then
                              position = challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].positionA
                            else
                              position = challengeSystem.instances[networkVars.modeID].challenge.spawnPositions[networkVars.modeAreaIndex].positionB
                            end
                          end
                        end
                  end
                end
              end
            end
      end
  if faceOffNext() then
    assert(position, "Failed to get start location - name = " .. tostring(faceOffSystem.faceOffPool[networkVars.modeIndex].settings.title) .. " networkVars.modeAreaIndex = " .. tostring(networkVars.modeAreaIndex) .. " gridStyle = " .. tostring(faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].gridStyle) .. " networkVars.modeIndex = " .. tostring(networkVars.modeIndex))
  else
    assert(position, "Failed to get start location - name = " .. tostring(challengeSystem.instances[networkVars.modeID].challenge.name) .. " networkVars.modeAreaIndex = " .. tostring(networkVars.modeAreaIndex) .. " roundNum = " .. tostring(challengeSystem.instances[networkVars.modeID].networkVars.roundOn) .. " PlayerGamePlay.getPlayerTeam( localPlayer.playerID ) = " .. tostring(PlayerGamePlay.getPlayerTeam(localPlayer.playerID)) .. " networkVars.modeIndex = " .. tostring(networkVars.modeIndex))
  end
  zapcontroller.zapTransitionToPointTracking(0, position, true)
end
local function debugCheck()
  NetworkLog.Write(">[LUA] TeamMoveToModeState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " enterTime = " .. tostring(enterTime))
  print("TeamMoveToModeState: stateComplete = " .. tostring(stateComplete) .. " readyCheck = " .. tostring(readyCheck()) .. " enterTime = " .. tostring(enterTime))
end
local function enter()
  stateComplete = false
  moved = false
end
local function step()
  if not moved and not onlineScreenManager.isTeamSwapButtonActivated() then
    moveToStartArea()
    transitionTime = g_NetworkTime
    moved = true
  end
  if not stateComplete and moved and g_NetworkTime - transitionTime > transitionWait then
    stateComplete = true
    sendMessage(2, stateIndex)
  end
  if STATE_DEBUG_FLAG then
    debugCheck()
  end
  if stateComplete and readyCheck() then
    stateMachine.changeState(states[SpawnVehiclesCleanupStateIndex])
  end
end
local exit = function(forced)
end
local teamMoveToModeState = {
  enter = enter,
  step = step,
  exit = exit,
  index = stateIndex,
  debugCheck = debugCheck
}
addState(teamMoveToModeState, stateIndex, "TeamMoveToModeState")
