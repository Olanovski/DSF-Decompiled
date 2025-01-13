feedbackSystem.registerHUD("Relay race activity hud", function(task, settings)
end, function(task, settings)
  local positionPanel = {slot = 1, title = "ID:184130"}
  local function update()
    if not gameStatus.simulationPaused then
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if task.instance.raceId then
          local raceRanking = RaceManager.GetRacerPosition(task.instance.raceId, taskObject.coreData.agent.gameVehicle)
          taskObject.coreData.rank = raceRanking
          if taskObject.coreData.agent.networkVars.taskObjectID == localPlayer.missionSupport:getMainTaskObject().coreData.taskObjectID then
            positionPanel.racePosition = raceRanking
            feedbackSystem.updateRacePosition(positionPanel)
          end
        end
      end
    end
  end
  return update, nil, nil, nil
end)
