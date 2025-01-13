feedbackSystem.registerTargetManager("Grouped vehicles", "Update", function(task, settings)
  local vehicleStyleIDs = {}
  local settings = settings or {all = true}
  local distance, workingDistance, group
  local workingVector = vec.vector()
  local playerPosition
  local function drawTaskObjectVehicle(taskObject, newSettings)
    local vehicle = taskObject.coreData.agent
    local selectedStyles = false
    if newSettings then
      if team and newSettings.styles[team] then
        selectedStyles = newSettings.styles[team]
      elseif newSettings.styles[1] then
        if #newSettings.styles > 1 then
          selectedStyles = newSettings.styles
        else
          selectedStyles = newSettings.styles[1]
        end
      elseif newSettings.styles.generic then
        selectedStyles = newSettings.styles.generic
      end
    end
    if selectedStyles and type(selectedStyles) == "table" then
      vehicleStyleIDs[vehicle.gameVehicle] = {}
      for style, styleParams in next, selectedStyles, nil do
        table.insert(vehicleStyleIDs[vehicle.gameVehicle], feedbackSystem.newTarget(vehicle, selectedStyles[style]))
      end
    elseif selectedStyles then
      vehicleStyleIDs[vehicle.gameVehicle] = {}
      table.insert(vehicleStyleIDs[vehicle.gameVehicle], feedbackSystem.newTarget(vehicle, selectedStyles))
    end
  end
  local function clearTarget(gameVehicle)
    if vehicleStyleIDs[gameVehicle] then
      for i, drawListID in ipairs(vehicleStyleIDs[gameVehicle]) do
        feedbackSystem.clearTarget(drawListID)
      end
      vehicleStyleIDs[gameVehicle] = nil
    end
  end
  local function taskObjectAgentIsValid(taskObject)
    local vehicle = taskObject.coreData.agent
    if vehicleStyleIDs[vehicle.gameVehicle] then
      return false
    end
    if task.targetList then
      for i, target in next, task.targetList, nil do
        if target == vehicle then
          return false
        end
      end
    end
    return true
  end
  local function drawMarkerCheck(taskObject)
    if taskObject.coreData.actor.markerType and taskObject.coreData.actor.markerType ~= "None" and not taskObject.coreData.defused then
      local newSettings = feedbackSystem.vehicleMarkerTypes[taskObject.coreData.actor.markerType]
      if taskObjectAgentIsValid(taskObject) then
        drawTaskObjectVehicle(taskObject, newSettings)
      end
    end
  end
  local function draw()
    local playerTaskObject = localPlayer:getTaskObject()
    group = nil
    distance = nil
    if localPlayer.inZap then
      playerPosition = game_camera.matrix[3]
    else
      playerPosition = localPlayer.currentVehicle.position
    end
    if settings.group then
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if settings.group[actorID] and settings.zapLevel and zapcontroller.getClosestCameraZapLevel() >= settings.zapLevel then
          drawMarkerCheck(taskObject)
        elseif settings.group[actorID] then
          if playerTaskObject == taskObject and not localPlayer.inZap then
            group = settings.group[actorID]
            break
          else
            workingDistance = workingVector:sub(taskObject.coreData.agent.position, playerPosition):length()
            if not distance or workingDistance < distance then
              distance = workingDistance
              group = settings.group[actorID]
            end
          end
        end
      end
      if group then
        for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
          if settings.group[actorID] and group == settings.group[actorID] then
            drawMarkerCheck(taskObject)
          elseif settings.group[actorID] then
            clearTarget(taskObject.coreData.agent.gameVehicle)
          end
        end
      end
    end
  end
  local function update()
    for gameVehicle, value in next, vehicleStyleIDs, nil do
      local remove = true
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if gameVehicle == taskObject.coreData.agent.gameVehicle and taskObject.coreData.actor.markerType ~= "None" then
          remove = false
          break
        end
      end
      if remove then
        clearTarget(gameVehicle)
      end
    end
    draw()
  end
  local function cleanup()
    for gameVehicle, drawListIDs in next, vehicleStyleIDs, nil do
      clearTarget(gameVehicle)
    end
  end
  return update, cleanup
end)
