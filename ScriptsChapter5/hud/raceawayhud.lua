feedbackSystem.registerHUD("Race away hud", function(task, settings)
end, function(task, settings)
  local bustedTimer = false
  local time1 = g_NetworkTime
  local part = settings.Part or 0
  local instance = task.instance
  local taskObject = task.agent:getTaskObject()
  local playerPositionFlash = false
  local currentRanking
  local checks = 0
  local playerPositionBar = {
    slot = 1,
    title = "ID:185685",
    racePosition = 4
  }
  if part == 1 then
    checks = #checkpointSystem.getCheckpoints(instance, instance.taskObjectsByActorID["player Actor"].coreData.actor.checkpointGroup)
  elseif part == 2 then
    feedbackSystem.removeSlot(1)
  end
  if task.specialName == "race" then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:184014", false, true)
  end
  local function update()
    if not gameStatus.simulationPaused and part == 1 then
      local checkpoints = 0
      checkpoints = task.networkVars.checkpoints - 1
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.routeName then
          local raceRanking = RaceManager.GetRacerPosition(taskObject.coreData.agent.raceId, taskObject.coreData.agent.gameVehicle)
          if taskObject.coreData.agent.networkVars.taskObjectID == localPlayer.missionSupport:getMainTaskObject().coreData.taskObjectID then
            if not playerPositionFlash then
              playerPositionFlash = true
              if currentRanking == nil then
                currentRanking = raceRanking
              end
              playerPositionBar.racePosition = currentRanking
              feedbackSystem.updateRacePosition(playerPositionBar)
              currentRanking = raceRanking
            end
            if ranking ~= currentRanking then
              playerPositionFlash = false
            end
          end
          taskObject.coreData.rank = raceRanking
        end
      end
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Timer toggle" then
      if conditionKey == 1 and not bustedTimer then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:218902")
        bustedTimer = true
      elseif conditionKey == 2 and bustedTimer then
        bustedTimer = false
      end
    elseif task.specialName == "Lose cops focus text" then
      if conditionKey == 1 then
        feedbackSystem.menusMaster.setCurrentFocusString(3)
      elseif conditionKey == 2 then
        feedbackSystem.menusMaster.setCurrentFocusString(1)
      end
    elseif task.specialName == "Lose cops focus text 2" then
      if conditionKey == 1 then
        feedbackSystem.menusMaster.setCurrentFocusString(2)
      elseif conditionKey == 2 then
        feedbackSystem.menusMaster.setCurrentFocusString(1)
      end
    end
  end
  return update, goalComplete, nil, nil
end)
