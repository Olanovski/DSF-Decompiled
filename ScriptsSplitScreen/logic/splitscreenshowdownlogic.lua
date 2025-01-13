module("cardSystem.logic")
missionSetupData["Split Screen Show Down"] = {}
missionSetupData["Split Screen Show Down"].spawnPositions = {
  [1] = {
    target = vec.vector(369.021, 4.773615, -235.152, 1),
    positionA = vec.vector(369.021, 4.773615, -235.152, 1),
    headingA = 2.79,
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    trafficSet = 3
  }
}
missionSetupData["Split Screen Show Down"].usableRouteIndicies = {
  [1] = 1
}
local playerTasks = function(goalParams, HUDFile)
  return {
    [1] = {task = "No target"}
  }
end
local getawayTasks = function(goalParams, HUDFile)
  return {
    [1] = {task = "No target"}
  }
end
missionSetupData["Split Screen Show Down"].taskCreatorFunctionLookups = {
  ["Objective Team 1"] = getawayTasks,
  ["Player Pool"] = playerTasks
}
missionSetupData["Split Screen Show Down"].stepHighlightColours = function(instance)
  if not instance.playersColours then
    instance.playersColours = {
      [1] = {SNVID = -1},
      [2] = {SNVID = -1}
    }
    Menu.SetPlayerColour(0, OnlineModeSettings.blue128)
    Menu.SetPlayerColour(1, OnlineModeSettings.orange128)
  end
  for playerID, data in next, instance.playersColours, nil do
    if data.SNVID ~= -1 and not vehicleManager.vehiclesBySNVID[data.SNVID] then
      data.SNVID = -1
    end
  end
  for localPlayerID, player in next, localPlayerManager.players, nil do
    if player.currentVehicle and (instance.playersColours[localPlayerID + 1].SNVID == -1 or instance.playersColours[localPlayerID + 1].SNVID ~= player.currentVehicle.SNVID) then
      instance.playersColours[localPlayerID + 1].SNVID = player.currentVehicle.SNVID
      if localPlayerID == 0 then
        player.currentVehicle:setDisplayColour(OnlineModeSettings.blue32, OnlineModeSettings.blue128)
      else
        player.currentVehicle:setDisplayColour(OnlineModeSettings.orange32, OnlineModeSettings.orange128)
      end
    end
  end
end
missionSetupData["Split Screen Show Down"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 2,
      spoolStartArea = true,
      gridStyle = 1,
      missionVehicleStyle = 1,
      moodStyle = 1,
      introHUD = "MP Checkpoint Rush Start HUD",
      teamGame = false,
      modeTimeLimit = 120,
      gridStagger = 0,
      disableZapOnCompletion = true
    }
  }
end
missionSetupData["Split Screen Show Down"].initiate = function(instance)
end
missionSetupData["Split Screen Show Down"].missionStart = function(instance)
end
missionSetupData["Split Screen Show Down"].modeReadyCheck = function(instance)
  return true
end
missionSetupData["Split Screen Show Down"].update = function(instance)
end
taskCompleteData["Split Screen Show Down"] = {}
taskCompleteData["Split Screen Show Down"].taskComplete = function(taskObject, task)
end
