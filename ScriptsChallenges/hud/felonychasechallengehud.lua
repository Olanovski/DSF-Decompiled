feedbackSystem.registerHUD("Felony chase challenge hud", function(task, settings)
end, function(task, settings)
  local instance = task.instance
  if task.specialName == "Wait for countdown" then
    feedbackSystem.menusMaster.singlePlayer321Countdown()
  end
  local timer = {slot = 1}
  local getawayHealthBar = {slot = 3, title = "ID:184067"}
  if localPlayer.primaryFelony.getawayGameVehicle then
    getawayHealthBar.value = localPlayer.primaryFelony.getawayGameVehicle.damage
  end
  local splitTimes = instance.splitTimes
  local bestSplitTimes = singlePlayerStatistics.returnMissionSplitTimes(instance.challenge.name)
  local previousAmountOfSplitTimes = 0
  local splitParams = {}
  local function update()
    if not gameStatus.simulationPaused then
      timer.startTime = instance.challenge.goalValues["Time limit"]
      feedbackSystem.stepTimer(timer)
      if localPlayer.primaryFelony.getawayGameVehicle then
        getawayHealthBar.value = localPlayer.primaryFelony.getawayGameVehicle.damage
        feedbackSystem.updateHealthBar(getawayHealthBar)
      end
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
  local goalComplete = function()
  end
  local function taskComplete()
    splitParams = {splitTimeRemove = true}
    feedbackSystem.updateSplitTime(splitParams)
  end
  local cleanup = function()
  end
  return update, nil, taskComplete, nil
end)
