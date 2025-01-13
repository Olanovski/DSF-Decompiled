local timeRemainingHavingLostCops
feedbackSystem.registerHUD("Escape the law 3 HUD", function(task, settings)
end, function(task, settings)
  local timer, timeToGetToTheMeet
  if settings.updateTimer then
    timer = {}
    if task.majorOrder == 9 then
      timer.startTime = 180
      timer.slot = 1
      feedbackSystem.stepTimer(timer)
    end
  end
  if task.majorOrder == 10 then
    feedbackSystem.removeSlot(1)
  end
  function spawnCop(task, number)
    local settings = {
      type = "InFrontOfVehicle",
      distanceInFront = 150,
      vehicle = task.agent.gameVehicle,
      direction = "against",
      position = "randomLane",
      vehicles = {}
    }
    local vehicleType = {modelID = 271}
    for i = 1, number do
      settings.vehicles[i] = vehicleType
    end
    local vehicles = Spawn.Spawn(settings)
    felony_getaway.addEvader(task.agent.gameVehicle)
    for i, gameVehicle in ipairs(vehicles) do
      local vehicle = vehicleManager.registerVehicle({gameVehicle = gameVehicle})
      felony_getaway.addChaser(task.agent.gameVehicle, gameVehicle)
    end
  end
  local function goalComplete(conditionKey)
    if settings.outOfCops then
      spawnCop(task, 2)
    elseif task.specialName == "Prompt and pip" and conditionKey == 1 then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:248735", nil, false, false, false)
    elseif task.specialName == "Prompt get to the meet" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245528")
      feedbackSystem.menusMaster.setCurrentFocusString(3)
    end
  end
  local taskComplete = function()
  end
  return nil, goalComplete, taskComplete, nil
end)
