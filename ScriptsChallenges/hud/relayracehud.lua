local scoreHolder = 0
feedbackSystem.registerHUD("Relay race hud", function(task, settings)
end, function(task, settings)
  local positionPanel = {slot = 3, title = "ID:184130"}
  local missionTimer = {slot = 1}
  local countdownStarted = false
  local splitTimes = task.instance.splitTimes
  local bestSplitTimes = singlePlayerStatistics.returnMissionSplitTimes(task.instance.challenge.name)
  local previousAmountOfSplitTimes = 0
  local splitParams = {}
  local function update()
    if task.specialName == "Wait for countdown" then
      if not countdownStarted then
        feedbackSystem.menusMaster.singlePlayer321Countdown()
        countdownStarted = true
      end
    elseif not gameStatus.simulationPaused then
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
      feedbackSystem.stepTimer(missionTimer)
      if splitTimes and bestSplitTimes then
        if #splitTimes ~= previousAmountOfSplitTimes and #splitTimes <= #bestSplitTimes then
          local previousSplit = splitTimes[#splitTimes]
          local bestSplit = bestSplitTimes[#splitTimes].value
          local splitDifference = previousSplit - bestSplit
          if splitDifference >= 0 then
            splitParams = {splitTime = splitDifference, splitTimeNegative = true}
          else
            splitDifference = splitDifference * -1
            splitParams = {splitTime = splitDifference, splitTimePositive = true}
          end
          feedbackSystem.updateSplitTime(splitParams)
        end
        previousAmountOfSplitTimes = #splitTimes
      end
    end
  end
  local function taskComplete()
    splitParams = {splitTimeRemove = true}
    feedbackSystem.updateSplitTime(splitParams)
  end
  return update, nil, taskComplete, nil
end)
