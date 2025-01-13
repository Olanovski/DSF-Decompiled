feedbackSystem.registerHUD("Challenge chase hud", function(task, settings)
end, function(task, settings)
  local instance = task.instance
  local timer = {slot = 1}
  local countdownStarted = false
  local splitTimes = instance.splitTimes
  local bestSplitTimes = singlePlayerStatistics.returnMissionSplitTimes(task.instance.challenge.name)
  local previousAmountOfSplitTimes = 0
  local splitParams = {}
  local function update()
    if not gameStatus.simulationPaused then
      if task.specialName == "Wait for countdown" then
        if not countdownStarted then
          feedbackSystem.menusMaster.singlePlayer321Countdown()
          countdownStarted = true
        end
      elseif not localPlayer.inCutscene then
        if instance.challenge.goalValues["Time limit"] then
          timer.startTime = instance.challenge.goalValues["Time limit"]
          feedbackSystem.stepTimer(timer)
        else
          feedbackSystem.stepTimer(timer)
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
