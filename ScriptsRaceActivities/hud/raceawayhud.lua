feedbackSystem.registerHUD("Race away challenges hud", function(task, settings)
end, function(task, settings)
  local playerPositionBar = {
    slot = 1,
    value = 100,
    title = "ID:184130",
    racePosition = 4
  }
  local taskObject = localPlayer.missionSupport:getMainTaskObject()
  local countdownStarted = false
  local function update()
    if not gameStatus.simulationPaused and task.specialName == "race" then
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if task.instance.raceId then
          local raceRanking = RaceManager.GetRacerPosition(task.instance.raceId, taskObject.coreData.agent.gameVehicle)
          taskObject.coreData.rank = raceRanking
          if taskObject.coreData.agent.networkVars.taskObjectID == localPlayer.missionSupport:getMainTaskObject().coreData.taskObjectID then
            playerPositionBar.racePosition = raceRanking
            feedbackSystem.updateRacePosition(playerPositionBar)
          end
        end
      end
    end
    if task.specialName == "Wait for countdown" and not countdownStarted then
      feedbackSystem.menusMaster.singlePlayer321Countdown()
      countdownStarted = true
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
