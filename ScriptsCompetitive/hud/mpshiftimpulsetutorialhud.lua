feedbackSystem.registerHUD("MP shift impulse tutorial HUD", function(task, settings)
end, function(task)
  local instance = localPlayer.getTaskObject().coreData.instance
  local tutorialVehicle = instance.taskObjectsByActorID["Objective Team 1 member 1"]
  local markerSettings = {
    Target = {
      type = "Target",
      gadgetID = 180,
      targetType = "MultiplayerObjective",
      colour = OnlineModeSettings.red32 + OnlineModeSettings.targetAlphaMask32,
      markerOffset = 1,
      radius = 45,
      visible = true
    }
  }
  local mainMarker = false
  local function setMainMarker(vehicle)
    mainMarker = true
    vehicle.markers = vehicle.markers or {}
    for k, v in next, vehicle.markers, nil do
      Marker:delete(v)
      vehicle.markers[k] = nil
    end
    for k, v in next, markerSettings, nil do
      v.gameVehicle = vehicle.gameVehicle
      vehicle.markers[k] = Marker:create(v)
    end
  end
  local function clearMainMarker(vehicle)
    mainMarker = false
    if vehicle.markers then
      for k, v in next, vehicle.markers, nil do
        Marker:delete(v)
        vehicle.markers[k] = nil
      end
    end
    vehicle:removeLightTrail()
  end
  local function drawMarkers()
    if tutorialVehicle then
      local vehicle = tutorialVehicle.coreData.agent
      local drawVehicle = true
      if localPlayer.currentVehicle and localPlayer.currentVehicle == vehicle then
        drawVehicle = false
      end
      if not mainMarker and vehicle and drawVehicle then
        setMainMarker(vehicle)
        vehicle:addLightTrail(32, OnlineModeSettings.red128)
      end
      if not vehicle.colourSet then
        vehicle:disableDisplay(false)
        vehicle:setDisplayColour(OnlineModeSettings.teamRed, OnlineModeSettings.red128)
      end
    end
  end
  local function update()
    drawMarkers()
    if tutorialVehicle and mainMarker and localPlayer.currentVehicle and localPlayer.currentVehicle == tutorialVehicle.coreData.agent then
      clearMainMarker(tutorialVehicle.coreData.agent)
    end
  end
  local function cleanup()
    if tutorialVehicle then
      local vehicle = tutorialVehicle.coreData.agent
      if vehicle then
        vehicle:deleteDisplay()
        clearMainMarker(vehicle)
      end
    end
  end
  return update, nil, nil, cleanup
end)
feedbackSystem.registerHUD("MP general mechanics tutorial HUD", function(task, settings)
end, function(task)
  local length = task.actor.taskList[task.majorOrder][task.minorOrder].goalConditions[4][3].params.time
  local lengthAdd = length
  local displayed = false
  local function update()
    local timeRemaining = lengthAdd - (g_NetworkTime - task.networkVars.raceStartTime)
    if timeRemaining < 0.2 then
      timeRemaining = 0
    else
      timeRemaining = math.ceil(timeRemaining)
    end
    if not task.networkVars.wellDone and not task.networkVars.reseting then
      feedbackSystem.menusMaster.currentHUDSetTextVariable("prompt_secondary_button", "")
      feedbackSystem.menusMaster.currentHUDSetTextVariable("prompt_secondary", timeRemaining)
      if not displayed and timeRemaining ~= 0 then
        feedbackSystem.menusMaster.currentHUDSetVariable("iPrompt_M_Secondary_Display", 1)
        displayed = true
      end
    elseif (task.networkVars.wellDone or task.networkVars.reseting) and displayed then
      feedbackSystem.menusMaster.currentHUDSetVariable("iPrompt_M_Secondary_Display", 0)
      displayed = false
    end
  end
  local cleanup = function()
    feedbackSystem.menusMaster.currentHUDSetVariable("iPrompt_M_Secondary_Display", 0)
  end
  return update, nil, nil, cleanup
end)
function onlineTutorialErrorFeedback(feedbackNum)
  if feedbackNum == 1 then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243714")
  elseif feedbackNum == 2 then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243713")
  end
end
