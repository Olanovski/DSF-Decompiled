feedbackSystem.registerHUD("Challenge race hud", function(task, settings)
end, function(task, settings)
  local instance = task.instance
  local taskObject = task.agent:getTaskObject()
  local sub = string.sub
  local timer = {}
  local score = {
    slot = 1,
    barIcon = "drift",
    value = 0
  }
  local position = {slot = 3}
  local stuntParams = {stuntSlotPass = 1, stuntFail = false}
  local countdownStarted = false
  local showPosition = false
  local raceScoringType = instance.challenge.goalValues.scoringType or "Time"
  local activeDrift = 0
  local oldDrift = 0
  local thisDrift = false
  local currentCheckpoint = 2
  local displayLastDestination = false
  local splitTimes = instance.splitTimes
  local bestSplitTimes = singlePlayerStatistics.returnMissionSplitTimes(task.instance.challenge.name)
  local previousAmountOfSplitTimes = 0
  local splitParams = {}
  if raceScoringType == "Drift" then
    feedbackSystem.updateScore(score)
    scoringSystem.UpdateDriftStuntText = true
  end
  if instance.challenge.name == "Team colours tutorial" then
    addUserUpdateFunction("teamColoursClearScr", function()
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      removeUserUpdateFunction("teamColoursClearScr")
    end, 1040, true)
  end
  local function update()
    if not gameStatus.simulationPaused then
      if task.specialName == "Wait for countdown" or task.specialName == "Wait for countdown2" then
        if not countdownStarted then
          feedbackSystem.menusMaster.singlePlayer321Countdown()
          countdownStarted = true
        end
      elseif not localPlayer.inCutscene then
        if raceScoringType == "Drift" then
          timer.slot = 3
        else
          timer.slot = 1
        end
        if instance.challenge.goalValues["Time limit"] then
          timer.startTime = instance.challenge.goalValues["Time limit"]
          feedbackSystem.stepTimer(timer)
        else
          feedbackSystem.stepTimer(timer)
        end
        if raceScoringType == "Drift" then
          activeDrift = localPlayer.scoring:getCurrentDriftDistance()
          if localPlayer.scoring.isDrifting and (feedbackSystem.menusMaster.primaryPromptActive or feedbackSystem.menusMaster.secondaryPromptActive) then
            feedbackSystem.menusMaster.clearAllTextPrompts()
          end
          if activeDrift == oldDrift then
            activeDrift = 0
          end
          if activeDrift > 0 then
            oldDrift = activeDrift
          end
          if not thisDrift and localPlayer.scoring.isDrifting then
            thisDrift = localPlayer.scoring:getTotalDriftDistance()
          elseif thisDrift and not localPlayer.scoring.isDrifting and activeDrift == 0 then
            local amount = localPlayer.scoring:getTotalDriftDistance() - thisDrift
            if amount > 0 then
              stuntParams.stuntTextValue = amount
              feedbackSystem.updateStuntFeedback(stuntParams)
              score.value = math.floor(score.value + amount)
              addUserUpdateFunction("driftScoreDelay", function()
                feedbackSystem.updateScore(score)
                removeUserUpdateFunction("driftScoreDelay")
              end, 180, true)
              localPlayer.scoring:resetDrift()
            else
              stuntParams.stuntTextValue = oldDrift
              feedbackSystem.updateStuntFeedback(stuntParams)
              score.value = math.floor(score.value + oldDrift)
              addUserUpdateFunction("driftScoreDelay", function()
                feedbackSystem.updateScore(score)
                removeUserUpdateFunction("driftScoreDelay")
              end, 180, true)
              localPlayer.scoring:resetDrift()
            end
            thisDrift = false
          end
        end
        for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
          if taskObject.coreData.agent.networkVars.taskObjectID ~= localPlayer.missionSupport:getMainTaskObject().coreData.taskObjectID then
            showPosition = true
          end
          if task.instance.raceId then
            raceRanking = RaceManager.GetRacerPosition(task.instance.raceId, taskObject.coreData.agent.gameVehicle)
            taskObject.coreData.rank = raceRanking
            if taskObject.coreData.agent.networkVars.taskObjectID == localPlayer.missionSupport:getMainTaskObject().coreData.taskObjectID and showPosition then
              currentRanking = raceRanking
              position.racePosition = currentRanking
              feedbackSystem.updateRacePosition(position)
            end
          end
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
    if task.specialName == "Checkpoints" and task.instance.challenge.goalValues["Score drift distance"] then
      score.value = math.floor(score.value + localPlayer.scoring:getCurrentDriftDistance())
      task.instance.driftScore = score.value
      feedbackSystem.updateScore(score)
    end
    splitParams = {splitTimeRemove = true}
    stuntParams.stuntHide = true
    feedbackSystem.updateSplitTime(splitParams)
    feedbackSystem.updateStuntFeedback(stuntParams)
  end
  local cleanup = function()
    scoringSystem.UpdateDriftStuntText = false
    removeUserUpdateFunction("teamColoursClearScr")
    removeUserUpdateFunction("driftScoreDelay")
  end
  return update, nil, taskComplete, cleanup
end)
