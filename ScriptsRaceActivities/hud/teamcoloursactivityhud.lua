feedbackSystem.registerHUD("Team colours activity hud", function(task, settings)
end, function(task, settings)
  local playerPositionBar1 = {
    slot = 1,
    title = task.instance.challenge.goalValues["Racer 1 name"] or "ID:235436"
  }
  local playerPositionBar2 = {
    slot = 2,
    title = task.instance.challenge.goalValues["Racer 2 name"] or "ID:235437"
  }
  local countdownStarted = false
  local raceRanking
  local highlightSlot = false
  local function update()
    if not gameStatus.simulationPaused then
      if task.specialName == "Wait for countdown" then
        if task.instance.challenge.goalValues["Start countdown"] and not countdownStarted then
          feedbackSystem.menusMaster.singlePlayer321Countdown()
          countdownStarted = true
        end
      else
        for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
          if taskObject.coreData.actor.routeName and task.instance.raceId then
            raceRanking = RaceManager.GetRacerPosition(task.instance.raceId, taskObject.coreData.agent.gameVehicle)
            taskObject.coreData.rank = raceRanking
            if actorID == "Player" then
              playerPositionBar1.racePosition = raceRanking
              feedbackSystem.updateRacePosition(playerPositionBar1)
            elseif actorID == "Teammate" then
              playerPositionBar2.racePosition = raceRanking
              feedbackSystem.updateRacePosition(playerPositionBar2)
            end
          end
        end
        if task.instance.taskObjectsByActorID.Player and task.instance.taskObjectsByActorID.Teammate then
          if not highlightSlot and not localPlayer.inZap then
            if task.instance.taskObjectsByActorID.Player.coreData.agent.controlled then
              feedbackSystem.highlightSlot(1)
              highlightSlot = true
            elseif task.instance.taskObjectsByActorID.Teammate.coreData.agent.controlled then
              feedbackSystem.highlightSlot(2)
              highlightSlot = true
            end
          elseif highlightSlot and (not task.instance.taskObjectsByActorID.Player.coreData.agent.controlled and not task.instance.taskObjectsByActorID.Teammate.coreData.agent.controlled or localPlayer.inZap) then
            highlightSlot = false
            feedbackSystem.highlightSlot(0)
          end
        end
        if task.instance.challenge.goalValues["Time limit"] then
          feedbackSystem.stepTimer(missionTimer)
        end
      end
    end
  end
  return update, nil, nil, nil
end)
