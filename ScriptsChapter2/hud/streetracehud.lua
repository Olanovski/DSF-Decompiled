feedbackSystem.registerHUD("Streetrace HUD", function(task, settings)
end, function(task, settings)
  local instance = task.instance
  local taskObject = task.agent:getTaskObject()
  local racerTask = instance.taskObjectsByActorID.Racer1.coreData.agent:getTaskObject()
  local racerCheckpoints = checkpointSystem.getCheckpoints(instance, racerTask.coreData.actor.checkpointGroup)
  local mark, mark1, mark2, targetArrow
  local index = -1
  local ramPromptActive = false
  local racersBar
  Marker.setAnimationLength("Fade", 0.5)
  local function createCheckpoints(tempIndex)
    if mark then
      Marker:delete(mark)
      mark = false
    end
    if mark1 then
      Marker:delete(mark1)
      mark1 = false
    end
    if mark2 then
      Marker:delete(mark2)
      mark2 = false
    end
    if targetArrow then
      Marker:delete(targetArrow)
      targetArrow = false
    end
    local checkpointGateMarkers = {
      activeGateMinimap = {
        type = "Minimap",
        gadgetID = 73,
        colour = vec.vector(246, 196, 14, 255),
        radius = 30,
        visible = true,
        position = nil,
        canrotate = false
      },
      checkpointNumber = {
        type = "Checkpoint",
        position = vec.vector(0, 0, 0, 0),
        colour = vec.vector(246, 196, 14, 255),
        scale = vec.vector(3, 3, 3, 0),
        offset = vec.vector(0, 6, 0.3, 0),
        visible = true,
        angle = 0,
        spacing = 1,
        number = 0,
        numberof = 0,
        fadedistance = 120,
        minalpha = 0,
        maxalpha = 255,
        localID = nil,
        introType = "Fade",
        outroType = "Fade"
      }
    }
    local params = {
      type = "World",
      facing = false,
      colour = vec.vector(255, 255, 255, 255),
      targetScale = vec.vector(1, 1, 1, 1),
      visible = true,
      fadedistance = 120,
      minalpha = 0,
      maxalpha = 255,
      introType = "Fade",
      outroType = "Fade"
    }
    checkpointGateMarkers.activeGateMinimap.position = racerCheckpoints[tempIndex + 1].position
    params.position = racerCheckpoints[tempIndex + 1].position
    local roadIndex, distanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(params.position)
    local roadWidth = Atlas.AverageRoadWidth(roadIndex)
    local roadHeading = getVectorRoadAngleAtPosition(roadIndex, distanceAlong)
    local roadAngle = math.atan2(roadHeading.x, roadHeading.z)
    params.heading = roadAngle
    if roadWidth <= 8 then
      params.gadgetID = 56
    elseif roadWidth <= 16 then
      params.gadgetID = 57
    elseif roadWidth <= 24 then
      params.gadgetID = 58
    elseif roadWidth <= 32 then
      params.gadgetID = 59
    else
      params.gadgetID = 60
    end
    if tempIndex + 1 == #racerCheckpoints then
      params.gadgetID = params.gadgetID + 5
      checkpointGateMarkers.activeGateMinimap.colour = vec.vector(219, 25, 35, 255)
    end
    targetArrow = Marker:create(params)
    mark = Marker:create(checkpointGateMarkers.activeGateMinimap)
    if racerCheckpoints[tempIndex + 2] then
      checkpointGateMarkers.activeGateMinimap.position = racerCheckpoints[tempIndex + 2].position
      if tempIndex + 2 == #racerCheckpoints then
        params.gadgetID = params.gadgetID + 5
        checkpointGateMarkers.activeGateMinimap.colour = vec.vector(246, 196, 14, 255)
      else
        checkpointGateMarkers.activeGateMinimap.colour = vec.vector(246, 196, 14, 80)
      end
      mark1 = Marker:create(checkpointGateMarkers.activeGateMinimap)
    end
    checkpointGateMarkers.checkpointNumber.position = racerCheckpoints[tempIndex + 1].position
    checkpointGateMarkers.checkpointNumber.number = racerCheckpoints[tempIndex + 1].checkpointNum
    checkpointGateMarkers.checkpointNumber.numberof = #racerCheckpoints
    mark2 = Marker:create(checkpointGateMarkers.checkpointNumber)
  end
  if task.specialName == "ChaserTask" then
    racersBar = {
      slot = 1,
      barIcon = "smash",
      barTitle = "ID:243981",
      value = 0,
      numericValue = 0
    }
    feedbackSystem.updateProgressBar(racersBar)
    local prompt = {
      prompt = "ID:184367",
      priority = 1,
      delay = true
    }
    feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
  end
  local function update()
    if not gameStatus.simulationPaused and task.specialName == "ChaserTask" then
      local tempIndex = -1
      for k, v in next, instance.taskObjectsByActorID, nil do
        if v.coreData.actor.team == "Race team" and v.coreData.agent.damage < 1 then
          local task = v.coreData.agent:getTaskObject()
          if task.namedTasks.racerTask and tempIndex <= task.namedTasks.racerTask.networkVars.checkpoints - 1 then
            tempIndex = task.namedTasks.racerTask.networkVars.checkpoints - 1
          end
        end
      end
      if tempIndex > index then
        createCheckpoints(tempIndex)
        index = tempIndex
        if index == 22 then
          local prompt = {prompt = "ID:184379", priority = 1}
          feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
        end
        if index == 12 then
          local prompt = {prompt = "ID:184380", priority = 1}
          feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
        end
      end
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "ChaserTask" and conditionKey == 1 then
      OneShotSound.Play("HUD_Gen_Positive", false)
      racersBar.value = racersBar.value + 25
      racersBar.numericValue = racersBar.numericValue + 1
      feedbackSystem.updateProgressBar(racersBar)
    elseif task.specialName == "Prompt ram - chaser" then
      local index = -1
      for k, v in next, task.instance.taskObjectsByActorID, nil do
        if v.coreData.actor.team == "Race team" and 1 > v.coreData.agent.damage then
          local task = v.coreData.agent:getTaskObject()
          if task.namedTasks.racerTask and index <= task.namedTasks.racerTask.networkVars.checkpoints - 1 then
            index = task.namedTasks.racerTask.networkVars.checkpoints - 1
          end
        end
      end
      if conditionKey == 1 and index < 12 and index > 1 then
        ramPromptActive = true
        local prompt = {
          prompt = "ID:245322",
          priority = 3,
          icon1 = localPlayer.buttonLayout.ramAbility,
          watchFor = {
            button = "Activate_Ram",
            pressType = "Pressed"
          },
          endCallback = function()
            ramPromptActive = false
          end
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
      elseif conditionKey == 2 then
        ramPromptActive = true
        local prompt = {
          prompt = "ID:246400",
          priority = 3,
          icon1 = localPlayer.buttonLayout.ramAbility,
          watchFor = {
            button = "Activate_Ram",
            pressType = "NotPressed"
          },
          endCallback = function()
            ramPromptActive = false
          end
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
      elseif conditionKey == 3 and ramPromptActive then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        ramPromptActive = false
      end
    elseif task.specialName == "Prompt headon - chaser" then
      local index = -1
      for k, v in next, task.instance.taskObjectsByActorID, nil do
        if v.coreData.actor.team == "Race team" and 1 > v.coreData.agent.damage then
          local task = v.coreData.agent:getTaskObject()
          if task.namedTasks.racerTask and index <= task.namedTasks.racerTask.networkVars.checkpoints - 1 then
            index = task.namedTasks.racerTask.networkVars.checkpoints - 1
          end
        end
      end
      if conditionKey == 1 and index > 12 then
        local prompt = {prompt = "ID:243639", priority = 3}
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
      end
    end
  end
  local function taskComplete()
    if task.specialName == "Cop car destroyed" then
      local prompt = {prompt = "ID:243192", priority = 1}
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    end
  end
  local function cleanup()
    if mark then
      Marker:delete(mark)
      mark = false
    end
    if mark1 then
      Marker:delete(mark1)
      mark1 = false
    end
    if mark2 then
      Marker:delete(mark2)
      mark2 = false
    end
    if targetArrow then
      Marker:delete(targetArrow)
      targetArrow = false
    end
  end
  return update, goalComplete, taskComplete, cleanup
end)
