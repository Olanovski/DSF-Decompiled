feedbackSystem.registerHUD("Generic race hud", function(task, settings)
end, function(task, settings)
  local playerPositionBar1 = {slot = 1, title = "ID:231122"}
  local playerPositionBar2 = {slot = 2, title = "ID:231123"}
  local missionTimer = {slot = 3}
  if task.instance.challenge.name == "Easy Street" or task.instance.challenge.name == "1 Downtown race" or task.instance.challenge.name == "Speed Race" or task.instance.challenge.name == "High plains drifter" or task.instance.challenge.name == "Marin County race" then
    playerPositionBar1.title = "ID:235434"
  end
  local checkpoints = 0
  local raceRanking, totalCheckpoints
  local currentLap = 0
  local totalLaps = 0
  local taskObject = localPlayer.missionSupport:getMainTaskObject()
  if taskObject and task.instance.raceId then
    raceRanking = RaceManager.GetRacerPosition(task.instance.raceId, taskObject.coreData.agent.gameVehicle)
    totalCheckpoints = #routes[taskObject.coreData.actor.routeName].checkpoints
  end
  local teamMateRanking
  local highlightSlot = false
  local halfRacePromptDisplayed = false
  local halfRaceRange = 0
  local opponentPassedCheckpoints = 0
  local opponentRanking = 0
  local opponentCheckpointNumber = 0
  local opponentRaceIndex = 0
  local playerTaskObject
  if task.specialName == "Checkpoints" then
    if task.instance.challenge.name == "Easy Street" or task.instance.challenge.name == "High plains drifter" or task.instance.challenge.name == "1 Downtown race" or task.instance.challenge.name == "Speed Race" or task.instance.challenge.name == "Marin County race" then
      local prompt = {
        prompt = "ID:184013",
        delay = true,
        priority = 1
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    end
    local teamMembers = 0
    local playerTeam
    for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
      if taskObject.playerTask then
        playerTeam = taskObject.coreData.actor.team
      end
    end
    for ID, vehicle in next, task.instance.taskObjectsByActorID, nil do
      if vehicle.coreData.actor.team == playerTeam then
        teamMembers = teamMembers + 1
      else
      end
    end
  end
  if task.actor.ID == "Player team member 02" then
    playerPositionBar1.slot = 2
    playerPositionBar1.title = "ID:231123"
    playerPositionBar2.slot = 1
    playerPositionBar2.title = "ID:231122"
  end
  if task.instance.challenge.name == "Team colours tutorial" then
    playerPositionBar1.title = "ID:231122"
    playerPositionBar2.title = "ID:231123"
    if task.actor.ID == "Blue2" then
      playerPositionBar1.slot = 2
      playerPositionBar1.title = "ID:231123"
      playerPositionBar2.slot = 1
      playerPositionBar2.title = "ID:231122"
    end
  end
  local function update()
    if not gameStatus.simulationPaused and task.specialName ~= "Team colours rapid shift prompt reminder" and task.specialName ~= "team colours prompt rules" then
      checkpoints = task.networkVars.checkpoints - 1
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if taskObject.coreData.actor.routeName and task.instance.raceId then
          raceRanking = RaceManager.GetRacerPosition(task.instance.raceId, taskObject.coreData.agent.gameVehicle)
          taskObject.coreData.rank = raceRanking
          if task.instance.challenge.name == "1 Downtown race" and task.specialName == "Checkpoints" and taskObject.namedTasks.Checkpoints and 1 > taskObject.coreData.agent.damage and taskObject ~= localPlayer.missionSupport:getMainTaskObject() and not halfRacePromptDisplayed then
            playerTaskObject = localPlayer.missionSupport:getMainTaskObject()
            opponentCheckpointNumber = #checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
            opponentPassedCheckpoints = taskObject.namedTasks.Checkpoints.networkVars.checkpoints - 1
            halfRaceRange = (task.coreData.totalLaps + 1) * opponentCheckpointNumber / 2
            playerRanking = RaceManager.GetRacerPosition(task.instance.raceId, playerTaskObject.coreData.agent.gameVehicle)
            opponentRaceIndex = math.floor(opponentPassedCheckpoints / halfRaceRange)
            if opponentRaceIndex == 1 then
              if taskObject.coreData.rank == 1 and 2 < playerRanking then
                local prompt = {
                  prompt = "ID:245312",
                  delay = false,
                  priority = 2
                }
                feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
              end
              halfRacePromptDisplayed = true
            end
          end
          if taskObject.coreData.agent.networkVars.taskObjectID == localPlayer.missionSupport:getMainTaskObject().coreData.taskObjectID then
            playerPositionFlash = true
            if currentRanking == nil then
              currentRanking = raceRanking
            end
            playerPositionBar1.racePosition = raceRanking
            feedbackSystem.updateRacePosition(playerPositionBar1)
            currentRanking = raceRanking
            taskObject.coreData.rank = raceRanking
            currentLap = task.networkVars.laps + 1 or 1
            totalLaps = task.coreData.totalLaps + 1 or 1
          elseif taskObject and taskObject.coreData.actor.team == localPlayer.missionSupport:getMainTaskObject().coreData.actor.team and task.instance.raceId then
            teamMateRanking = RaceManager.GetRacerPosition(task.instance.raceId, taskObject.coreData.agent.gameVehicle)
            teamMatePositionFlash = true
            if teamMateCurrentRanking == nil then
              teamMateCurrentRanking = teamMateRanking
            end
            playerPositionBar2.racePosition = teamMateRanking
            feedbackSystem.updateRacePosition(playerPositionBar2)
            teamMateCurrentRanking = teamMateRanking
            taskObject.coreData.rank = teamMateRanking
          end
        end
      end
      if task.instance.challenge.name == "Team colours tutorial" then
        feedbackSystem.stepTimer(missionTimer)
      end
      if not localPlayer.inZap and not highlightSlot then
        if task.actor.ID == "Player team member 01" and not highlightSlot or task.actor.ID == "Blue1" then
          if localPlayer.currentVehicle == taskObject.coreData.agent or localPlayer.currentVehicle == taskObject.coreData.agent then
            feedbackSystem.highlightSlot(1)
            highlightSlot = true
          end
        elseif (task.actor.ID == "Player team member 02" and not highlightSlot or task.actor.ID == "Blue2") and (localPlayer.currentVehicle == taskObject.coreData.agent or localPlayer.currentVehicle == taskObject.coreData.agent) then
          feedbackSystem.highlightSlot(2)
          highlightSlot = true
        end
      elseif highlightSlot and (task.actor.ID ~= "Player team member 01" and task.actor.ID ~= "Player team member 02" and task.actor.ID ~= "Blue1" and task.actor.ID ~= "Blue2" or localPlayer.inZap) then
        highlightSlot = false
        feedbackSystem.highlightSlot(0)
      end
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Team colours rapid shift prompt reminder" then
      local prompt = {
        prompt = "ID:234447",
        delay = false,
        icon1 = localPlayer.buttonLayout.zapReturn,
        priority = 3
      }
    elseif task.specialName == "team colours prompt rules" then
      local prompt = {
        prompt = "ID:234447",
        delay = false,
        icon1 = localPlayer.buttonLayout.zapReturn,
        priority = 3
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    end
  end
  local taskComplete = function()
  end
  local cleanup = function()
  end
  return update, goalComplete, nil, nil
end)
