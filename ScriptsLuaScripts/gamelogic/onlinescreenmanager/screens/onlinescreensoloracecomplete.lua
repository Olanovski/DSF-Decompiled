module("onlineScreenManager", package.seeall)
local compScreenComplete = true
local modeName = false
local enterCompScreen, updateCompScreen, exitCompScreen
local function preEnterScreen()
  compScreenComplete = false
end
local function getScreenStatus()
  return compScreenComplete
end
local function setCompleteScreenComplete()
  compScreenComplete = true
end
function enterCompScreen(startTime, displayTime, sortType, missionName, endTime, screenStartTime)
  OneShotSound.Play("MP_Result_Draw", false)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_you_finished", "ID:184917")
  feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Finished", 1)
  feedbackSystem.eventMessages.pushXPGroup()
  onlineSideBar.setHidden(true)
  localPlayer:showHUDElements(false)
  zapWeaponSupport.enableZapWeapons(false)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 0)
  for localID, player in next, localPlayerManager.players, nil do
    if player.currentVehicle and player.currentVehicle.abilityActive then
      player.currentVehicle:cancelAbility(localID)
    end
    player:blockAbility("zap", true)
  end
  localPlayer.controllerInterface:removePlayerControl()
  zap.disableZapSelection()
  if localPlayer.currentVehicle and 1 > localPlayer.currentVehicle.damage then
    localPlayer.currentVehicle:set_damageMultiplier(0)
    local behaviour = {
      personality = "fastCiv",
      traits = {
        desiredSpeed = 65,
        avoidAlleyways = 0,
        spawnSpeed = 0,
        ignorePlayers = true,
        avoidedByCivilianTraffic = true,
        avoidUTurns = false,
        drivingSkill = "Professional",
        wanderType = "obeyTrafficRules",
        stayInLockedArea = true
      }
    }
    localPlayer.currentVehicle:highSpeedDrive(behaviour)
    if challengeSystem.instances[phaseManager.networkVars.modeID] then
      if challengeSystem.instances[phaseManager.networkVars.modeID].challenge.spawnPositions[phaseManager.lastModeAreaIndex].endTargetRoads then
        ActiveLifeAI.setBehaviour(localPlayer.currentVehicle.gameVehicle, "FollowRoute", "TEMP ROUTE", challengeSystem.instances[phaseManager.networkVars.modeID].challenge.spawnPositions[phaseManager.lastModeAreaIndex].endTargetRoads)
      else
        ActiveLifeAI.setBehaviour(localPlayer.currentVehicle.gameVehicle, "FollowRoute", "TEMP ROUTE", challengeSystem.instances[phaseManager.networkVars.modeID].challenge.spawnPositions[phaseManager.networkVars.modeAreaIndex].roads)
        ActiveLifeAI.setRouteLoop(localPlayer.currentVehicle.gameVehicle, true)
      end
    elseif cards.MissionNetworkLookup[phaseManager.networkVars.modeIndex] then
      local missionData = cardSystem.createMission(cards.MissionNetworkLookup[phaseManager.networkVars.modeIndex])
      if missionData.spawnPositions[phaseManager.networkVars.modeAreaIndex].endTargetRoads then
        ActiveLifeAI.setBehaviour(localPlayer.currentVehicle.gameVehicle, "FollowRoute", "TEMP ROUTE", missionData.spawnPositions[phaseManager.networkVars.modeAreaIndex].endTargetRoads)
      else
        ActiveLifeAI.setBehaviour(localPlayer.currentVehicle.gameVehicle, "FollowRoute", "TEMP ROUTE", missionData.spawnPositions[phaseManager.networkVars.modeAreaIndex].roads)
        ActiveLifeAI.setRouteLoop(localPlayer.currentVehicle.gameVehicle, true)
      end
    end
  end
end
local setCoreTimers = function(startTime, displayTime, endTime)
end
function updateCompScreen()
  local screenStack = onlineScreenManager.getScreenStack()
  if #screenStack > 1 and compScreenComplete and onlineRaceManager.hasFinishedPositionBeenSynced(localPlayer.playerID) then
    onlineScreenManager.endScreen("FINISHED")
  end
end
function exitCompScreen(fromPurge)
  if fromPurge then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Finished", 0)
  end
  compScreenComplete = true
  modeName = false
end
local soloRaceCompleteScreen = {
  enterScreen = enterCompScreen,
  updateScreen = updateCompScreen,
  exitScreen = exitCompScreen,
  preEnter = preEnterScreen,
  getStatus = getScreenStatus,
  finishScreen = setCompleteScreenComplete,
  updateCoreData = setCoreTimers
}
addScreen(SoloRaceCompleteScreenIndex, "SOLO RACE COMPLETE SCREEN", soloRaceCompleteScreen)
