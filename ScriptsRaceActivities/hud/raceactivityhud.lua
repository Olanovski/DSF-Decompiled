feedbackSystem.registerHUD("Race activity hud", function(task, settings)
end, function(task, settings)
  local willpowerReward = task.instance.challenge.goalValues["Willpower reward"] or 0
  local willpowerReductionRate = task.instance.challenge.goalValues["Willpower reduction rate"] or 0
  local willpowerReductionTime = task.instance.challenge.goalValues["Willpower reduction time"] or 0
  local willpowerBar = {}
  local positionPanel = {title = "ID:184130"}
  if willpowerReward == 0 then
    positionPanel.slot = 1
  else
    willpowerBar = {
      slot = 1,
      numericValue = willpowerReward,
      value = 100
    }
    positionPanel.slot = 2
    feedbackSystem.updateWillpowerBar(willpowerBar)
  end
  local countdownStarted = false
  local currentTime = g_NetworkTime
  local function update()
    if not gameStatus.simulationPaused then
      if task.specialName == "Wait for countdown" then
        if task.instance.challenge.goalValues["Start countdown"] and not countdownStarted then
          feedbackSystem.menusMaster.singlePlayer321Countdown()
          countdownStarted = true
        end
      elseif task.specialName == "Checkpoints" then
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
        if willpowerBar.numericValue ~= 1 and willpowerReductionRate ~= 0 and willpowerReductionTime ~= 0 then
          if g_NetworkTime - currentTime >= willpowerReductionTime then
            if willpowerBar.numericValue - willpowerReductionRate < 1 then
              willpowerBar.numericValue = 1
            else
              willpowerBar.numericValue = willpowerBar.numericValue - willpowerReductionRate
            end
            willpowerBar.value = math.ceil(willpowerBar.numericValue / willpowerReward * 100)
            currentTime = g_NetworkTime
          end
          feedbackSystem.updateWillpowerBar(willpowerBar)
        end
      end
    end
  end
  local goalComplete = function()
  end
  local taskComplete = function()
  end
  local cleanup = function()
  end
  return update, nil, nil, nil
end)
